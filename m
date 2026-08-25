Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B48202F70
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691297; cv=none; b=BR0D1vZakwzEp/r0oVDfQN4ThoeFAbRkJLmtyAy4ucJJ+2Ij3dMiLRpkC9lzSi0ETRdapQFjtskUfWG0MGbcdXEgZbWyuiui6tnH9a+kVmvktHNnr7PgVRCXVrzfcSN+ekAVvp3ThMLJ6g3BHgPYkkii+AV8W11fIIjUKzFo1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691297; c=relaxed/simple;
	bh=tGukfrBfQXH4GqcMi2jPdmNAYsvU41G02mmLmPc0HI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9eIRka1fdLQFoou3CLtK15qHFi3e25vRitn7IgXxoY/jBsPtEDQDE4RpcwdKPStzGVnfi+9lUoRdkg0y5smcRMmiwLU713+HfxZVxe9QFyssGLDRmGwtwLdENsoBB2jLF/r7UOJRZTK/bnTBAgNZ3s9APIj2HwdIcAE0whngn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3C716268293DBC; Tue, 25 Aug 2026 13:54:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 07/10] bpf: Allow arena pointers in a by-value kfunc return
Date: Tue, 25 Aug 2026 13:54:48 -0700
Message-ID: <20260825205448.1324569-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825205412.1320099-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A kfunc may already return an arena pointer on its own, which the program
casts back into the arena address space to use. Let the members of a
by-value struct it returns be arena pointers as well, rather than scalars
only.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                         | 23 ++++++++++---------
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edbc48a1fdc8..0c2181d58748 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14090,12 +14090,12 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		const char *member_note =3D "";
=20
 		/*
-		 * The returned struct comes back as raw register bits modeled
-		 * as an unknown scalar, so it must contain only scalars:
-		 * otherwise a pointer field would be laundered into a scalar
-		 * and escape provenance and reference tracking.
+		 * The returned struct may only contain scalars and arena pointers
+		 * as its members. Otherwise, any other pointer would be laundered
+		 * into a scalar and escape provenance and reference tracking.
 		 */
-		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &p=
ath)) {
+		if (!btf_struct_member_walk(env, desc_btf, t,
+					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {
 			if (path.too_deep) {
 				member_note =3D bpf_diag_fmt(
 					env, " It nests structs more than %d levels deep.",
@@ -14106,7 +14106,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				const struct btf_type *bad_type;
=20
 				verbose(env,
-					"kernel function %s returns %s %s that is not composed of scalars\n=
",
+					"kernel function %s returns %s %s that is not composed of scalars o=
r arena pointers\n",
 					func_name, btf_type_str(t),
 					btf_name_by_offset(desc_btf, t->name_off));
 				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
@@ -14114,15 +14114,16 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 				verbose(env, "member '%s' has type %s\n", bad_name,
 					btf_type_str(bad_type));
 				member_note =3D bpf_diag_fmt(
-					env, " Its member '%s' is %s, not a scalar.", bad_name,
-					btf_type_str(bad_type));
+					env,
+					" Its member '%s' is %s, not a scalar or an arena pointer.",
+					bad_name, btf_type_str(bad_type));
 			}
 			bpf_diag_program_structure(
 				env, insn_idx, "unsupported kernel function return type",
-				"Call a kernel function that returns only scalars by value.",
+				"Call a kernel function that returns only scalars or arena pointers =
by value.",
 				"%s() returns %s %s by value.%s "
-				"Only kfuncs returning scalar values, or "
-				"structures composed of scalar values are "
+				"Only kfuncs returning scalar values or arena pointers, or "
+				"structures composed of scalar values and arena pointers are "
 				"supported.",
 				func_name, btf_type_str(t),
 				btf_name_by_offset(desc_btf, t->name_off), member_note);
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
index d6b422ae9784..f10e5cf6fd89 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -71,7 +71,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
=20
 SEC("tc")
 __arch_x86_64 __arch_arm64
-__failure __msg("is not composed of scalars")
+__failure __msg("is not composed of scalars or arena pointers")
 __naked int aggregate_ret_kfunc_ptr_fail(void)
 {
 	asm volatile (
--=20
2.53.0-Meta

