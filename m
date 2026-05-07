Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B9318EE6
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189436; cv=none; b=a7IIqWgcd2iQQXJ6s3s7Qi2dSsJb52uo5A8dj5PCDcsUCgim9kiyHhmzuIXjzYa9pg1eRp8tFztRbA2V6AiWFL08jPjBJQ1mtlhIHxgw4HZIC1vCKmp+stKr4kGcKg/KhAhMA9eInKxzYQx7pa3wtinASU0B5wD6Cr3c/7tmLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189436; c=relaxed/simple;
	bh=gHl8q/G4G+A4aoroFsSlXGyzVDtlPVOuU2OMjVNimmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agsFzVpbt27f1CEBsQJCPuvnX8RCEVbOBbWsTjuqGZilyJ+PfXcxXJb8DtjpChBAySx4rW8nPCngnZOZ6UFKPEz732OP7Gv2Prgkp4CA+YGluIL4rxewFIZdDOAoiuFDKWw5uQ56ee9W0gB2A/1zUf+Ywkuc1RSSmo/HI2fd4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0A93B92BAA48B; Thu,  7 May 2026 14:30:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 08/23] bpf: Refactor record_call_access() to extract per-arg logic
Date: Thu,  7 May 2026 14:30:24 -0700
Message-ID: <20260507213024.1129512-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
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
index 332e6e003f27..de0b4c6263ff 100644
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

