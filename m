Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013E30216D
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940547; cv=none; b=SD1091FTv3+6o1Zlv2+0s6MqiHX3RfkKoWN33sUUiKPHjLm4+89BiZECgAI2LOK9nI7gR1hluXb0n4i0K6M9ScVOWyhp4r1CX2mAebyk+MWkbtQ6rbk+5+XdSvKG5XKl43vQRoLmg6s/Iodr5Kx0120g35e3Qnvw38zkFzwb8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940547; c=relaxed/simple;
	bh=Jtw2sl6qYLr7uDY4/mx++8YBCx7/eyUxXJUuyLX5dyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCb2GneLBNKj2ZGO/xX9/F4q6yijduAlZ8kYX67VJmkweu0lGf51aoOGCftTUfGyDHcGHmIJJsyd3ELShc6OdnIV8g+yierQrgMUWI9ovw0/RvL+rWE2eh8nnZVag/y1iWVflLrsxWfKi7m+Kr55grheSeawFwDDzIXdQveqfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6182324982E8C2; Sun, 16 Aug 2026 21:22:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 07/10] bpf: Enable aggregate return types up to 16 bytes
Date: Sun, 16 Aug 2026 21:22:17 -0700
Message-ID: <20260817042217.2294438-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817042141.2286086-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Relax btf_distill_func_proto() to accept a by-value struct or union that
the R0:R2 convention added in earlier patches can carry:

 - a struct or union larger than 8 and up to 16 bytes, returned in the
   R0:R2 register pair, matching what LLVM emits for the BPF target;
 - a struct or union up to 8 bytes, returned in R0 alone.

A >8 byte scalar (__int128) was already accepted and is unchanged.
Everything else stays rejected: a return type larger than 16 bytes, and a=
ny
type that __get_type_size() cannot return in registers at all (e.g. an
array), which it already reports as ret < 0.

btf_validate_return_type() is relaxed as well, so that it accepts a
by-value struct or union up to 16 bytes in addition to void and scalars.

With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
verifier, JIT, precision-backtracking and live-register support from the
earlier patches becomes reachable: <=3D16 byte aggregate return values no=
w
work end to end.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                  |  2 ++
 kernel/bpf/btf.c                              | 23 +++++++++++++++----
 kernel/bpf/verifier.c                         | 18 +++++++--------
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70d5878fbff..938c9a9eb9d2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1467,6 +1467,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
+bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struc=
t btf *btf,
+			       const struct btf_type *t, int rec);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ae7cb9b30f2..ba83fa1d52a3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7591,7 +7591,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 		return -EINVAL;
 	}
 	ret =3D __get_type_size(btf, func->type, &t);
-	if (ret < 0 || btf_type_is_struct(t)) {
+	if (ret < 0 || ret > 16) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_type_str(t));
@@ -7970,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_e=
nv *env,
=20
 /* Check whether the type is a valid return type. */
 static int btf_validate_return_type(struct bpf_verifier_env *env, struct=
 btf *btf,
-		const struct btf_type *t, int subprog)
+		const struct btf_type *t, int subprog, bool is_global)
 {
 	u32 tags =3D 0;
 	int err;
@@ -7993,6 +7993,19 @@ static int btf_validate_return_type(struct bpf_ver=
ifier_env *env, struct btf *bt
 	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
 		return 0;
=20
+	if (btf_type_is_struct(t) && t->size <=3D 16) {
+		/*
+		 * A global function's caller models the return as an opaque
+		 * scalar pair, so it may only return scalars by value. A local
+		 * function is verified inline, so a pointer field stays tracked
+		 * and needs no such restriction.
+		 */
+		bool local_func =3D subprog && !is_global;
+
+		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
+			return 0;
+	}
+
 	return -EOPNOTSUPP;
 }
=20
@@ -8080,12 +8093,12 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 		return -EINVAL;
 	}
=20
-	err =3D btf_validate_return_type(env, btf, t, subprog);
+	err =3D btf_validate_return_type(env, btf, t, subprog, is_global);
 	if (err) {
 		if (is_global) {
 			bpf_log(log,
-				"Global function %s() return value not void or scalar. "
-				"Only those are supported.\n",
+				"Global function %s() has unsupported return type. "
+				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is =
supported.\n",
 				tname);
 		}
 		return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e371b7e27ec9..e5c8d8f7d474 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11600,9 +11600,9 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_call_arg_meta *meta, u32 arg_
 }
=20
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
-static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
-					const struct btf *btf,
-					const struct btf_type *t, int rec)
+bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+			       const struct btf *btf,
+			       const struct btf_type *t, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11620,7 +11620,7 @@ static bool __btf_type_is_scalar_struct(struct bp=
f_verifier_env *env,
 				verbose(env, "max struct nesting depth exceeded\n");
 				return false;
 			}
-			if (!__btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
+			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
 				return false;
 			continue;
 		}
@@ -12019,7 +12019,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
 		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
-		    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+		    !btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
 			verbose(env, "%s pointer type %s %s must point to void, scalar, or st=
ruct with scalar\n",
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -12035,7 +12035,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
 		 * scalars. The access size is derived from the pointed-to BTF type.
 		 */
 		if (!btf_type_is_scalar(ref_t) &&
-		    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+		    !btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
 			verbose(env, "%s pointer type %s %s must point to scalar, or struct w=
ith scalar\n",
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -13091,7 +13091,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
 				break;
 			}
=20
-			if (!__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
 				enum bpf_reg_type reg2btf_type =3D lookup_reg2btf_ids(ref_id);
 				const char *expected_type;
=20
@@ -13629,7 +13629,7 @@ static int check_special_kfunc(struct bpf_verifie=
r_env *env, struct bpf_call_arg
=20
 		struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
 		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
-			if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
+			if (!btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
 				verbose(env, "bpf_percpu_obj_new type ID argument must be of a struc=
t of scalars\n");
 				return -EINVAL;
 			}
@@ -14008,7 +14008,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		 * otherwise a pointer field would be laundered into a scalar
 		 * and escape provenance and reference tracking.
 		 */
-		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
+		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
 			verbose(env,
 				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
 				func_name, btf_type_str(t),
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index ac44d60e5066..9708efb93683 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
=20
 SEC("?tc")
 __exception_cb(exception_cb_bad_ret_type1)
-__failure __msg("Global function exception_cb_bad_ret_type1() return val=
ue not void or scalar.")
+__failure __msg("Only void, scalar, or a scalar-only struct/union up to =
16 bytes is supported.")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
--=20
2.53.0-Meta

