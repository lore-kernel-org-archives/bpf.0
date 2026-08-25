Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB43D648A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691288; cv=none; b=NLpWXo9S2E4ne7wnqTQ8yahDPD9HQz+u7cQyzxQ7ccC/PeIf+oakza6YLHL4+pn5XeHYDj9454BUbIU1w9qwoh6XmtuRpFUXb/y5isIWIONPj89+Tvke40R0hfoHWirdhIxMwKqeE1iBBA3EA/LOfbhw2Qi8yPxeApXsdGT78lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691288; c=relaxed/simple;
	bh=v/PT2GfUSTApN3EgynjTzvsIo0tpKf8WZWvCfBTTkpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXfZdMNS4g1eaNxJdtCch0WcdyqlVk9XP1IoUKWIUSL11BikOxO01yJ2btXqBEHBw7cxJpgKH08ppvzy/i5+KORBQRRu0OYzfRjuB8KxU+aw8udA/KDxdGr41+4cMr2LA9VDOaKpyxs3WhP1KAc65AXEPgsMp80KN308BlN//Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 05C8C268293D6E; Tue, 25 Aug 2026 13:54:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 05/10] bpf: Report which member makes a kfunc return type unsupported
Date: Tue, 25 Aug 2026 13:54:37 -0700
Message-ID: <20260825205438.1323042-1-yonghong.song@linux.dev>
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

A kfunc that returns a struct by value may only return scalars, and the
message that rejects one names the type but not the member at fault:

  kernel function bpf_kfunc_call_test_ret_ptr returns STRUCT
  prog_test_ret_ptr that is not composed of scalars

For a large struct that leaves the reader to find the offending member
by inspection. Record the member that made the walk fail and name it, so
the verifier also dumps:

  member 'p' has type PTR

What is recorded is a path rather than a single member, because the walk
descends up to 4 levels. For

  struct outer { struct inner { void *p; } in; __u64 tag; };

naming 'p' alone would send the reader looking for a member struct outer
does not have, so the message reads "member 'in.p' has type PTR".

The detailed diagnostics for this failure:

  Verification failed: Program Structure: Unsupported kernel function
  return type

  Reason:
    bpf_kfunc_call_test_ret_ptr() returns STRUCT prog_test_ret_ptr by
    value. Its member 'p' is PTR, not a scalar. Only scalar values, or
    structs composed of scalar values, are supported as by-value kernel
    function return types.
  ...
  Suggestion:
    Call a kernel function that returns only scalars by value.

A type nested deeper than the walk descends has no single member to
blame, so that case reports the depth instead:

  Reason:
    bpf_kfunc_call_test_ret_deep() returns STRUCT prog_test_ret_deep by
    value. It nests structs more than 4 levels deep. ...

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 86 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5ea95e75e726..edbc48a1fdc8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11623,6 +11623,15 @@ static bool is_kfunc_arg_implicit(const struct b=
pf_call_arg_meta *meta, u32 arg_
 	return argn <=3D arg_idx;
 }
=20
+#define BTF_MEMBER_MAX_DEPTH	4
+#define BTF_MEMBER_PATH_LEN	64
+
+struct btf_member_path {
+	const struct btf_member *member[BTF_MEMBER_MAX_DEPTH];
+	int depth;
+	bool too_deep;
+};
+
 static bool btf_member_kind_allowed(const struct btf *btf, const struct =
btf_type *t,
 				    u32 member_kinds)
 {
@@ -11635,10 +11644,11 @@ static bool btf_member_kind_allowed(const struc=
t btf *btf, const struct btf_type
=20
 /*
  * Returns true if every member of struct @t is of a kind listed in
- * @member_kinds, 4 levels of nesting allowed.
+ * @member_kinds, BTF_MEMBER_MAX_DEPTH levels of nesting allowed.
  */
 static bool btf_struct_member_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
-				   const struct btf_type *t, u32 member_kinds, int rec)
+				   const struct btf_type *t, u32 member_kinds, int rec,
+				   struct btf_member_path *path)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11652,31 +11662,42 @@ static bool btf_struct_member_walk(struct bpf_v=
erifier_env *env, const struct bt
=20
 		member_type =3D btf_type_skip_modifiers(btf, member->type, NULL);
 		if (btf_type_is_struct(member_type)) {
-			if (rec >=3D 3) {
+			if (rec >=3D BTF_MEMBER_MAX_DEPTH - 1) {
 				verbose(env, "max struct nesting depth exceeded\n");
+				if (path)
+					path->too_deep =3D true;
 				return false;
 			}
-			if (!btf_struct_member_walk(env, btf, member_type, member_kinds, rec =
+ 1))
-				return false;
+			if (!btf_struct_member_walk(env, btf, member_type, member_kinds,
+						    rec + 1, path))
+				goto bad_path;
 			continue;
 		}
 		if (btf_type_is_array(member_type)) {
 			array =3D btf_array(member_type);
 			if (!array->nelems)
-				return false;
+				goto bad_member;
 			member_type =3D btf_type_skip_modifiers(btf, array->type, NULL);
 		}
 		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
-			return false;
+			goto bad_member;
 	}
 	return true;
+
+bad_member:
+	if (path)
+		path->depth =3D rec + 1;
+bad_path:
+	if (path && path->depth)
+		path->member[rec] =3D member;
+	return false;
 }
=20
 bool btf_struct_is_composed_of(struct bpf_verifier_env *env,
 			       const struct btf *btf,
 			       const struct btf_type *t, u32 member_kinds)
 {
-	return btf_struct_member_walk(env, btf, t, member_kinds, 0);
+	return btf_struct_member_walk(env, btf, t, member_kinds, 0, NULL);
 }
=20
 static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
@@ -11686,6 +11707,18 @@ static bool btf_type_is_scalar_struct(struct bpf=
_verifier_env *env,
 	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
 }
=20
+static void btf_member_path_str(const struct btf *btf, const struct btf_=
member_path *path,
+				char *buf, size_t buf_sz)
+{
+	size_t len =3D 0;
+	int i;
+
+	buf[0] =3D '\0';
+	for (i =3D 0; i < path->depth; i++)
+		len +=3D scnprintf(buf + len, buf_sz - len, "%s%s", i ? "." : "",
+				 btf_name_by_offset(btf, path->member[i]->name_off));
+}
+
 enum kfunc_ptr_arg_type {
 	KF_ARG_CONST_MEM_SIZE,
 	KF_ARG_MEM_SIZE,
@@ -14053,17 +14086,46 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
 	} else if (btf_type_is_struct(t)) {
+		struct btf_member_path path =3D {};
+		const char *member_note =3D "";
+
 		/*
 		 * The returned struct comes back as raw register bits modeled
 		 * as an unknown scalar, so it must contain only scalars:
 		 * otherwise a pointer field would be laundered into a scalar
 		 * and escape provenance and reference tracking.
 		 */
-		if (!btf_type_is_scalar_struct(env, desc_btf, t)) {
-			verbose(env,
-				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
+		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &p=
ath)) {
+			if (path.too_deep) {
+				member_note =3D bpf_diag_fmt(
+					env, " It nests structs more than %d levels deep.",
+					BTF_MEMBER_MAX_DEPTH);
+			} else if (path.depth) {
+				const struct btf_member *bad =3D path.member[path.depth - 1];
+				char bad_name[BTF_MEMBER_PATH_LEN];
+				const struct btf_type *bad_type;
+
+				verbose(env,
+					"kernel function %s returns %s %s that is not composed of scalars\n=
",
+					func_name, btf_type_str(t),
+					btf_name_by_offset(desc_btf, t->name_off));
+				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
+				bad_type =3D btf_type_skip_modifiers(desc_btf, bad->type, NULL);
+				verbose(env, "member '%s' has type %s\n", bad_name,
+					btf_type_str(bad_type));
+				member_note =3D bpf_diag_fmt(
+					env, " Its member '%s' is %s, not a scalar.", bad_name,
+					btf_type_str(bad_type));
+			}
+			bpf_diag_program_structure(
+				env, insn_idx, "unsupported kernel function return type",
+				"Call a kernel function that returns only scalars by value.",
+				"%s() returns %s %s by value.%s "
+				"Only kfuncs returning scalar values, or "
+				"structures composed of scalar values are "
+				"supported.",
 				func_name, btf_type_str(t),
-				btf_name_by_offset(desc_btf, t->name_off));
+				btf_name_by_offset(desc_btf, t->name_off), member_note);
 			return -EINVAL;
 		}
 		mark_kfunc_ret_regs(env, regs, t->size);
--=20
2.53.0-Meta

