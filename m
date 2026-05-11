Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A936654F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477629; cv=none; b=AVuv8gDWRwoQyx5HJ76gDjw/zrUa5Y/bWJpbDFv2X5Kw/yVPj/pLmSKdM+JU5bHfmziXBgnpdv2C1y8U7IKb9vh7Tcq/yDHsmKYnSv0iNvVaQDp+sevgQn2ZEInKBBJWddeRe0pZRjEQgkVllJ5Fpf35pOV3VlLK9nNgDrsiAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477629; c=relaxed/simple;
	bh=FlALPuZcPd1QRGItj9I49uzX7ISuU7F/NBpb7igBfaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF2j3iEc5+tT9I6gRxeh0uvCqVaFkCALxnnzBHc4iJUEymYPc/MWrscq+6XOeupM66fnrGG9DmQzv0UkcvmZtFKkVzExfYH0v1KZqrgUDCN2kxfaE8FzswBnbeJzvP6Y+dmqtL9kCDo034rMhFUkige9tkm8pqz6ULeGePZXbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F3F25A59DBD72; Sun, 10 May 2026 22:33:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 08/24] bpf: Refactor record_call_access() to extract per-arg logic
Date: Sun, 10 May 2026 22:33:42 -0700
Message-ID: <20260511053342.1885131-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
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
 kernel/bpf/liveness.c | 65 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 58197d73b120..c81337dfbfc7 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1343,6 +1343,42 @@ static int record_load_store_access(struct bpf_ver=
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
+	int err =3D 0;
+	s64 bytes;
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
+		return 0;
+	}
+	if (bytes =3D=3D 0)
+		return 0;
+
+	if (frame >=3D 0 && frame <=3D depth)
+		err =3D record_stack_access(instance, at, bytes, frame, insn_idx);
+	else if (frame =3D=3D ARG_IMPRECISE)
+		err =3D record_imprecise(instance, at->mask, insn_idx);
+	return err;
+}
+
 /* Record stack access for a given 'at' state of helper/kfunc 'insn' */
 static int record_call_access(struct bpf_verifier_env *env,
 			      struct func_instance *instance,
@@ -1350,9 +1386,8 @@ static int record_call_access(struct bpf_verifier_e=
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
@@ -1361,31 +1396,7 @@ static int record_call_access(struct bpf_verifier_=
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
 			return err;
 	}
--=20
2.53.0-Meta

