Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA47371CE4
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984140; cv=none; b=G2nUZ0L7p0pIe2WqYIRhpHQPsSjH9JwEkRdWB8Od5DwKGdJWNxitHgGQT583tlmWdiQ9EMnq3KUPWcXGaz6yLrj+TFE/GyCHa/9AmzU56aqKy7gfUqpK6Mk73VrUPSf9TxVD27+9eB2QtW84v+yJVPzRPEdWeTCCnnV+lFYVX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984140; c=relaxed/simple;
	bh=rotTpNj/93//ehvw4sGkzF17FgX0+XgAGULlKxonALI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0un9t2JyrS1Wm6X5btJlVJx1oHhtN1Uwr1B5yf2qrIem7+uINlp0fpOSZxRJFaFpsr+NraCOjmlKgaavq8ud61zN65kROILisz3seB4YVYvhYMVMhs5yiHJ+/6bKDl30qmn8r8ujexJ/YdM7GH9iAiQ81u5L93wh98hAYMG51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8AB63273B9C7FB; Fri, 28 Aug 2026 23:15:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 02/12] bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
Date: Fri, 28 Aug 2026 23:15:24 -0700
Message-ID: <20260829061524.1692957-1-yonghong.song@linux.dev>
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

btf_type_is_scalar_struct() recurses into nested struct members and
carries the nesting depth in a @rec argument, so every caller has to
spell out the 0 that starts the walk.

Move the recursion into btf_struct_member_walk() and leave
btf_type_is_scalar_struct() as a thin wrapper over it. This is
groundwork for the later patches, which give the walk further state
that callers should not have to supply: the kinds of member it accepts,
and a record of the member that made it fail.

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
index 5d8162e13c20..ed077a5422af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11647,9 +11647,8 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_call_arg_meta *meta, u32 arg_
 }
=20
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
-bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
-			       const struct btf *btf,
-			       const struct btf_type *t, int rec)
+static bool btf_struct_member_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
+				   const struct btf_type *t, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11667,7 +11666,7 @@ bool btf_type_is_scalar_struct(struct bpf_verifie=
r_env *env,
 				verbose(env, "max struct nesting depth exceeded\n");
 				return false;
 			}
-			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
+			if (!btf_struct_member_walk(env, btf, member_type, rec + 1))
 				return false;
 			continue;
 		}
@@ -11686,6 +11685,13 @@ bool btf_type_is_scalar_struct(struct bpf_verifi=
er_env *env,
 	return true;
 }
=20
+bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+			       const struct btf *btf,
+			       const struct btf_type *t)
+{
+	return btf_struct_member_walk(env, btf, t, 0);
+}
+
 enum kfunc_ptr_arg_type {
 	KF_ARG_CONST_MEM_SIZE,
 	KF_ARG_MEM_SIZE,
@@ -12066,7 +12072,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
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
@@ -12082,7 +12088,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
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
@@ -13138,7 +13144,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
 				break;
 			}
=20
-			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t)) {
 				enum bpf_reg_type reg2btf_type =3D lookup_reg2btf_ids(ref_id);
 				const char *expected_type;
=20
@@ -13680,7 +13686,7 @@ static int check_special_kfunc(struct bpf_verifie=
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
@@ -14059,7 +14065,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
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

