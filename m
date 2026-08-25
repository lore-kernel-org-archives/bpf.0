Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4D3D5661
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691276; cv=none; b=n9gRSpchWueugbqGx1EZaXeT4X4EHbF+cPT58xx8X+9vTzZAB/fP203cNMu4khVFfNmw0clQtA/GRfhySvcPLIaSqPksoReSyVC+8854C0OoKpkRymtwsweeO2HyxCNNeTEE5NDHM7Tyr7S+qLstLIxt+w3d8L/o0chZJW4x+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691276; c=relaxed/simple;
	bh=qGi5UovYFvvYkCCrKRjAuM4y2XwIBWGmmVWlLsSUQ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+QhXWQFQaySygXHLNMBNqMJuAeM0qzXRp2Hog2RG0IOOhexiopUONcQ+XNmH0wDWb5/MPz5Qxd3iyIfcc1dNsySpl+XaMep4BmpfWI1de8x4fLXTWqdTU5iQh3P5SfTh4marVhCBR1X9qR8OERocqKAp30vHkSXZttUtz7yABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A7F26268293CFA; Tue, 25 Aug 2026 13:54:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 02/10] bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
Date: Tue, 25 Aug 2026 13:54:22 -0700
Message-ID: <20260825205422.1322431-1-yonghong.song@linux.dev>
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

btf_type_is_scalar_struct() recurses into nested struct members and
carries the nesting depth in a @rec argument, so every caller has to
spell out the 0 that starts the walk.

Move the recursion into a static helper that keeps @rec and leave
btf_type_is_scalar_struct() as a thin wrapper over it, so callers only
name the type they are asking about.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 24 +++++++++++++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 004b06785521..3eb61edc8c5e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1489,7 +1489,7 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_v=
erifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
 bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struc=
t btf *btf,
-			       const struct btf_type *t, int rec);
+			       const struct btf_type *t);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 91b8ce77f699..47d43eb983a5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7995,7 +7995,7 @@ static int btf_validate_return_type(struct bpf_veri=
fier_env *env, struct btf *bt
 		 */
 		bool local_func =3D subprog && !is_global;
=20
-		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
+		if (local_func || btf_type_is_scalar_struct(env, btf, t))
 			return 0;
 	}
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9aa29c367008..9799b50b97cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11624,9 +11624,8 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_call_arg_meta *meta, u32 arg_
 }
=20
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
-bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
-			       const struct btf *btf,
-			       const struct btf_type *t, int rec)
+static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
+				   const struct btf_type *t, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11644,7 +11643,7 @@ bool btf_type_is_scalar_struct(struct bpf_verifie=
r_env *env,
 				verbose(env, "max struct nesting depth exceeded\n");
 				return false;
 			}
-			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
+			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1))
 				return false;
 			continue;
 		}
@@ -11663,6 +11662,13 @@ bool btf_type_is_scalar_struct(struct bpf_verifi=
er_env *env,
 	return true;
 }
=20
+bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+			       const struct btf *btf,
+			       const struct btf_type *t)
+{
+	return btf_scalar_struct_walk(env, btf, t, 0);
+}
+
 enum kfunc_ptr_arg_type {
 	KF_ARG_CONST_MEM_SIZE,
 	KF_ARG_MEM_SIZE,
@@ -12043,7 +12049,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
 		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
-		    !btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+		    !btf_type_is_scalar_struct(env, meta->btf, ref_t)) {
 			verbose(env, "%s pointer type %s %s must point to void, scalar, or st=
ruct with scalar\n",
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -12059,7 +12065,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
 		 * scalars. The access size is derived from the pointed-to BTF type.
 		 */
 		if (!btf_type_is_scalar(ref_t) &&
-		    !btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+		    !btf_type_is_scalar_struct(env, meta->btf, ref_t)) {
 			verbose(env, "%s pointer type %s %s must point to scalar, or struct w=
ith scalar\n",
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -13115,7 +13121,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
 				break;
 			}
=20
-			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t)) {
 				enum bpf_reg_type reg2btf_type =3D lookup_reg2btf_ids(ref_id);
 				const char *expected_type;
=20
@@ -13657,7 +13663,7 @@ static int check_special_kfunc(struct bpf_verifie=
r_env *env, struct bpf_call_arg
=20
 		struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
 		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
-			if (!btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
+			if (!btf_type_is_scalar_struct(env, ret_btf, ret_t)) {
 				verbose(env, "bpf_percpu_obj_new type ID argument must be of a struc=
t of scalars\n");
 				return -EINVAL;
 			}
@@ -14036,7 +14042,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		 * otherwise a pointer field would be laundered into a scalar
 		 * and escape provenance and reference tracking.
 		 */
-		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
+		if (!btf_type_is_scalar_struct(env, desc_btf, t)) {
 			verbose(env,
 				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
 				func_name, btf_type_str(t),
--=20
2.53.0-Meta

