Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4EA33065D
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811114; cv=none; b=YMiyO+dJFMHJsrl0omlA7Q2gk9Ob5JirWuGuDFyivtoe2exKp8CV7oHj2GtuT/rWCvmCyvtFbBvQu3zuLAKRcctPfImrqGzqPPy+6PFn1euHP0vbbfFSimHdMr5OQ8S1tmOYix94Lp+v8iTxacPuZiCWdBPsu/fFV+6R2etb3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811114; c=relaxed/simple;
	bh=gtdPyUMj/MkTz1gcrjUNrZOkRCjTqsrMDNkJnBamUbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/xYPz1mSPfXRiZJPYICAHtVykiJvGVvARb6wspq1alScDbWpzEsl+vL9eaziHObK+AzgJa05wjnU+83xfJeZpjz3E6ZwH6GIkNJAYNYHEowXzYFQ0iWxtNBvoDPIR8TmmtlQ5ncBRFW7YODDky9hlCPqKWRte9Sn/bJgfIthQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BF25426CDEC673; Wed, 26 Aug 2026 23:11:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 07/11] bpf: Allow arena pointers in a by-value kfunc return
Date: Wed, 26 Aug 2026 23:11:50 -0700
Message-ID: <20260827061150.2518572-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827061114.2514603-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
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

Such a member carries the arena type tag but not the address space
qualifier, so the program has to cast it itself. Handing it back as a
scalar costs nothing: an arena address has no provenance to track, and th=
e
cast is confined to the caller's arena.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                         | 25 +++++++++++--------
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  2 +-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 967ad010b322..9a36808136c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14119,13 +14119,17 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
=20
 		/*
 		 * The returned struct comes back as raw register bits modeled
-		 * as an unknown scalar, so it must contain only scalars:
-		 * otherwise a pointer field would be laundered into a scalar
-		 * and escape provenance and reference tracking.
+		 * as an unknown scalar, so a pointer member would be laundered
+		 * into a scalar and escape provenance and reference tracking.
+		 * Only scalars and arena pointers are allowed: an arena pointer
+		 * has no provenance to lose, since a program may already derive
+		 * one from any scalar with addr_space_cast(), which confines the
+		 * result to the arena.
 		 */
-		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &p=
ath)) {
+		if (!btf_struct_member_walk(env, desc_btf, t,
+					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {
 			verbose(env,
-				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
+				"kernel function %s returns %s %s that is not composed of scalars or=
 arena pointers\n",
 				func_name, btf_type_str(t),
 				btf_name_by_offset(desc_btf, t->name_off));
 			if (path.too_deep) {
@@ -14142,15 +14146,16 @@ static int check_kfunc_call(struct bpf_verifier=
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
+				"structures composed of scalar values or arena pointers are "
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

