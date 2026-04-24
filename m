Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEA2C11E2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050891; cv=none; b=IPZ3eZYnOw3jP8+Rx8PFPDQpewFQE1Hq06PSnRgw2Vfg/FRL7wXbd842pigaw2T9B5VSO0HryNaVsYdhyNVtSSRy4QLTOiGwMx2yOaTYCUlU++KCh1iB0PkYfzWGSBI/eJuMhFoc0hQ1A7leuvfXCYvZ3FHM+B2NM+N5jC6fB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050891; c=relaxed/simple;
	bh=E6a4rEubTpZ4Sd4xnX4hfMMH1hFGhaYDu7h3vkCGsBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlEr8qVSzE2+zDVH9XbeCo8rzZ64yp4cRpeVJWZSBPh98KxXZRJvEHJowOnKlZbPeIIwdJ4YrEg1AzmwH1cYDIz9PULhc3/YnjXpLljjcimY4XZkGwBaFu8IrFjC3pJq8ziOuw8wJ0VGYaxR7hOGRM8wXNnQuIQ7fn3K0zkntkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 13DB4474A6455; Fri, 24 Apr 2026 10:14:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 03/18] bpf: Refactor record_call_access() to extract per-arg logic
Date: Fri, 24 Apr 2026 10:14:49 -0700
Message-ID: <20260424171449.2035279-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Extract the per-argument FP-derived pointer handling from
record_call_access() into a new record_arg_access() helper.

The existing loop body =E2=80=94 checking arg_is_fp, querying stack acces=
s
bytes, and calling record_stack_access/record_imprecise =E2=80=94 will be
reused for stack argument slots in the next patch. Factoring it out
now avoids duplicating the logic.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c | 69 +++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 332e6e003f27..1b45621d652c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1343,6 +1343,44 @@ static int record_load_store_access(struct bpf_ver=
ifier_env *env,
 	return 0;
 }
=20
+static int record_arg_access(struct bpf_verifier_env *env,
+			     struct func_instance *instance,
+			     struct bpf_insn *insn,
+			     struct arg_track *at, int arg_idx,
+			     int insn_idx)
+{
+	int depth =3D instance->depth;
+	int frame =3D at->frame;
+	s64 bytes;
+	int err;
+
+	if (!arg_is_fp(at))
+		return 0;
+
+	if (bpf_helper_call(insn)) {
+		bytes =3D bpf_helper_stack_access_bytes(env, insn, arg_idx, insn_idx);
+	} else if (bpf_pseudo_kfunc_call(insn)) {
+		bytes =3D bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
+	} else {
+		for (int f =3D 0; f <=3D depth; f++) {
+			err =3D mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			if (err)
+				return err;
+		}
+		return 1;
+	}
+	if (bytes =3D=3D 0)
+		return 0;
+
+	if (frame >=3D 0 && frame <=3D depth)
+		err =3D record_stack_access(instance, at, bytes, frame, insn_idx);
+	else if (frame =3D=3D ARG_IMPRECISE)
+		err =3D record_imprecise(instance, at->mask, insn_idx);
+	else
+		err =3D 0;
+	return err;
+}
+
 /* Record stack access for a given 'at' state of helper/kfunc 'insn' */
 static int record_call_access(struct bpf_verifier_env *env,
 			      struct func_instance *instance,
@@ -1350,9 +1388,8 @@ static int record_call_access(struct bpf_verifier_e=
nv *env,
 			      int insn_idx)
 {
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
-	int depth =3D instance->depth;
 	struct bpf_call_summary cs;
-	int r, err =3D 0, num_params =3D 5;
+	int r, err, num_params =3D 5;
=20
 	if (bpf_pseudo_call(insn))
 		return 0;
@@ -1361,33 +1398,9 @@ static int record_call_access(struct bpf_verifier_=
env *env,
 		num_params =3D cs.num_params;
=20
 	for (r =3D BPF_REG_1; r < BPF_REG_1 + num_params; r++) {
-		int frame =3D at[r].frame;
-		s64 bytes;
-
-		if (!arg_is_fp(&at[r]))
-			continue;
-
-		if (bpf_helper_call(insn)) {
-			bytes =3D bpf_helper_stack_access_bytes(env, insn, r - 1, insn_idx);
-		} else if (bpf_pseudo_kfunc_call(insn)) {
-			bytes =3D bpf_kfunc_stack_access_bytes(env, insn, r - 1, insn_idx);
-		} else {
-			for (int f =3D 0; f <=3D depth; f++) {
-				err =3D mark_stack_read(instance, f, insn_idx, SPIS_ALL);
-				if (err)
-					return err;
-			}
-			return 0;
-		}
-		if (bytes =3D=3D 0)
-			continue;
-
-		if (frame >=3D 0 && frame <=3D depth)
-			err =3D record_stack_access(instance, &at[r], bytes, frame, insn_idx)=
;
-		else if (frame =3D=3D ARG_IMPRECISE)
-			err =3D record_imprecise(instance, at[r].mask, insn_idx);
+		err =3D record_arg_access(env, instance, insn, &at[r], r - 1, insn_idx=
);
 		if (err)
-			return err;
+			return err > 0 ? 0 : err;
 	}
 	return 0;
 }
--=20
2.52.0

