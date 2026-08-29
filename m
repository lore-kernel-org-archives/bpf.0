Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3237C93E
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984158; cv=none; b=YZ7CCyZzixe/GhBFt2NJsasAu6sWBYnF5Dt88a+rlkwFQKpRkLS7GELSU84X1AcLTPdlws3P9Z5RrSWGwVGROfXAp13O8KnG4d9bSvAGtJCPaKIzXT2mJhCRxea1vPLmOiZVIHh1vWL32OVVLW/lv5Ds/ety+S8Z8zOfci516eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984158; c=relaxed/simple;
	bh=1S4k0VBIBICBA13ml6xocN2HnmL8YtpsghUWc3r9vE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPfK5vSgYTuvyZml49BwqrEbdRZCrZTPBxPQIbN04psWoiEE7HmHYJP9iUpbmHnv00uAyB0ZQ83Zc2esrhxVOiD6NlMxRwvnzVer5R079AS5x915IxeMXUQeb5dArxjBCryy3uE5CxbRZPCeqr7Buxfn6Z14fddARulBGAsr2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3B9D7273BA2FDD; Fri, 28 Aug 2026 23:15:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 08/12] bpf: Allow arena pointers in a by-value kfunc return
Date: Fri, 28 Aug 2026 23:15:55 -0700
Message-ID: <20260829061555.1697503-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
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
 kernel/bpf/verifier.c                         | 22 +++++++++++--------
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 745daf58b052..a725e3917976 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14138,13 +14138,16 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
=20
 		/*
 		 * The returned struct comes back as raw register bits modeled
-		 * as an unknown scalar, so it must contain only scalars:
-		 * otherwise a pointer field would be laundered into a scalar
-		 * and escape provenance and reference tracking.
+		 * as an unknown scalar, so a pointer member would be laundered
+		 * into a scalar and escape provenance and reference tracking.
+		 * Only scalars and arena pointers are allowed; see
+		 * btf_validate_return_type() in btf.c for why an arena pointer
+		 * is safe here.
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
@@ -14165,16 +14168,17 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 					verbose(env, "member '%s' has type %s\n", bad_name,
 						btf_type_str(path.bad_type));
 					member_note =3D bpf_diag_fmt(
-						env, " Its member '%s' is %s, not a scalar.",
+						env,
+						" Its member '%s' is %s, not a scalar or an arena pointer.",
 						bad_name, btf_type_str(path.bad_type));
 				}
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

