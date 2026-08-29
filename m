Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EB37C0F0
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984144; cv=none; b=CUy1eiG6DYZhZOabNmxvfymHSuyFEA1SNL3jr/wOplrgm4xwjLGaVaAluwNEy4+3dJzTldi0qf9qJFmBKokd4bEFs+NXuz5TfeKV5h2vOp54/kXmPzEj3gyREWJ+tDE94VjBoVdMkWUr99Mx05SxtOz0lFJfnPLpfspxNSqgS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984144; c=relaxed/simple;
	bh=xe8xDCAUtyCQtDMiklh5VM56ovjEpThGhV4FlmpSvBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAm9pQfkcwyvlbpP4g2rDOdH2eoRA/CQN3mm7DNND33FYzV3SA1rtksHHSnp2cu1jtE/2bvBwbgOPBpZdgsVxVVH7k6bKyvqQmn9oPNyVRo8L0h2+Ug1Dj/oA0qOhRqb6YDGj8GSLPg+eB2oVqkjLXB+3k4P4trhy8kL9/jvi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A5B65273B9C81C; Fri, 28 Aug 2026 23:15:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 03/12] bpf: Add btf_type_is_arena_ptr()
Date: Fri, 28 Aug 2026 23:15:29 -0700
Message-ID: <20260829061529.1693266-1-yonghong.song@linux.dev>
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

Add btf_type_is_arena_ptr() to test whether a BTF type is a pointer
carrying the "arena" type tag, and use it to simplify both
btf_scan_type_tags() and btf_validate_return_type(). The helper has
external linkage because a later patch calls it from verifier.c to
decide whether a struct member returned by value may be an arena
pointer.

btf_scan_type_tags() drove btf_type_tag_walk() with a one-entry match
table, so the "multiple type tags" error it checked for could never
fire: btf_type_tag_walk() only fails when the walk sets more than one
flag. Dropping that error path, and with it the int return, is
therefore no functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/btf.h |  1 +
 kernel/bpf/btf.c    | 62 ++++++++++++++++-----------------------------
 2 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 89d5a5c4f117..ddd0f4f32d24 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -235,6 +235,7 @@ struct btf_record *btf_parse_fields(const struct btf =
*btf, const struct btf_type
 				    u32 field_mask, u32 value_size);
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record =
*rec);
 bool btf_type_is_void(const struct btf_type *t);
+bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type =
*t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd);
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
 struct btf *btf_get_module_btf(const struct module *module);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 47d43eb983a5..280530d25886 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3523,6 +3523,22 @@ static int btf_type_tag_walk(const struct btf *btf=
,
 	return 0;
 }
=20
+bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type =
*t)
+{
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	for (t =3D btf_type_by_id(btf, t->type); btf_type_is_modifier(t);
+	     t =3D btf_type_by_id(btf, t->type)) {
+		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
+			continue;
+		if (!strcmp(__btf_name_by_offset(btf, t->name_off), "arena"))
+			return true;
+	}
+
+	return false;
+}
+
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t=
,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
@@ -7927,51 +7943,19 @@ static int btf_scan_decl_tags(struct bpf_verifier=
_env *env,
 	return 0;
 }
=20
-static int btf_scan_type_tags(struct bpf_verifier_env *env,
-			      const struct btf *btf, u32 type_id,
-			      u32 *tags)
+static void btf_scan_type_tags(const struct btf *btf, u32 type_id, u32 *=
tags)
 {
-	static const struct btf_type_tag_match func_type_tags[] =3D {
-		{ "arena", ARG_TAG_ARENA },
-	};
-	struct btf_type_tag_walk_ctx ctx;
-	const struct btf_type *t;
-	int err;
-
 	/* Find the first pointer type in the chain. */
-	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
+	const struct btf_type *t =3D btf_type_skip_modifiers(btf, type_id, NULL=
);
=20
-	/*
-	 * We currently reject type tags on non-pointer types,
-	 * which neither LLVM nor GCC support anyway.
-	 */
-	if (!t || !btf_type_is_ptr(t))
-		return 0;
-
-	ctx.t =3D t;
-	err =3D btf_type_tag_walk(btf, &ctx, func_type_tags,
-				ARRAY_SIZE(func_type_tags));
-	if (err) {
-		bpf_log(&env->log,
-			"function signature member has multiple type tags\n");
-		return err;
-	}
-	*tags |=3D ctx.res;
-
-	return 0;
+	if (btf_type_is_arena_ptr(btf, t))
+		*tags |=3D ARG_TAG_ARENA;
 }
=20
 /* Check whether the type is a valid return type. */
 static int btf_validate_return_type(struct bpf_verifier_env *env, struct=
 btf *btf,
 		const struct btf_type *t, int subprog, bool is_global)
 {
-	u32 tags =3D 0;
-	int err;
-
-	err =3D btf_scan_type_tags(env, btf, t->type, &tags);
-	if (err)
-		return err;
-
 	t =3D btf_type_skip_modifiers(btf, t->type, NULL);
=20
 	/*
@@ -7979,7 +7963,7 @@ static int btf_validate_return_type(struct bpf_veri=
fier_env *env, struct btf *bt
 	 * General arena variables are not allowed, since it makes no sense to =
return by value
 	 * a variable that's on the heap in the first place.
 	 */
-	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
+	if (subprog && btf_type_is_arena_ptr(btf, t))
 		return 0;
=20
 	/* We always accept void or scalars. */
@@ -8106,9 +8090,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		if (err)
 			return err;
=20
-		err =3D btf_scan_type_tags(env, btf, args[i].type, &tags);
-		if (err)
-			return err;
+		btf_scan_type_tags(btf, args[i].type, &tags);
=20
 		t =3D btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
--=20
2.53.0-Meta

