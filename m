Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D33C2BA2
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691276; cv=none; b=O1YrdaZ0KLJXd0HRuYAWpHkChbgg4BMKPYkRhCAX5ifFuYdwZlbRHkyfCKioV2gdKoxojkrTfu0tasw55u0aQ9eVY/BqdKa1DrvqaVHUI58SffJqzXF51KGf2epNaXNraokCt+GDn3R50BKrLQhBSH9qZa9AE3i8fAq6u02SgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691276; c=relaxed/simple;
	bh=KGIqoO9YDMVWk809jp64osYNU11VgWSR5lIdgyacwCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKQSSBf7J1gCPgTWVwLVpq+/1gKdrfOkYOnNS68wFIWZ+YzASVbrAtlgfNRFrU4Qehmf4Qa/ownibrlwcYXQFO3qMp0lTkaDv2xb8RYXMNM+Bo+5+GxzlFso4+hPszy5rmHERniEUXnzEXoFybsBdl5iKphfWV6pQ5riBEJrKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DEFA6268293D44; Tue, 25 Aug 2026 13:54:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 04/10] bpf: Let the by-value struct walk take the kinds of member it accepts
Date: Tue, 25 Aug 2026 13:54:32 -0700
Message-ID: <20260825205432.1322845-1-yonghong.song@linux.dev>
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

Use btf_struct_is_composed_of() instead of btf_type_is_scalar_struct() in
btf.c so in the future, non scalar member (e.g. arena pointer) can be
supported as well. There is no functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 11 ++++++++--
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 39 ++++++++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3eb61edc8c5e..be3ec883c08f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1488,8 +1488,15 @@ int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
-bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struc=
t btf *btf,
-			       const struct btf_type *t);
+
+/* Kinds of member a by-value struct or union may be composed of. */
+enum btf_member_kind {
+	BTF_MEMBER_SCALAR	=3D BIT(0), /* an int or an enum, or an array of them=
 */
+	BTF_MEMBER_ARENA_PTR	=3D BIT(1), /* a pointer carrying the "arena" type=
 tag */
+};
+
+bool btf_struct_is_composed_of(struct bpf_verifier_env *env, const struc=
t btf *btf,
+			       const struct btf_type *t, u32 member_kinds);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 280530d25886..b1f4ef614d4c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7979,7 +7979,7 @@ static int btf_validate_return_type(struct bpf_veri=
fier_env *env, struct btf *bt
 		 */
 		bool local_func =3D subprog && !is_global;
=20
-		if (local_func || btf_type_is_scalar_struct(env, btf, t))
+		if (local_func || btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SC=
ALAR))
 			return 0;
 	}
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9799b50b97cd..5ea95e75e726 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11623,9 +11623,22 @@ static bool is_kfunc_arg_implicit(const struct b=
pf_call_arg_meta *meta, u32 arg_
 	return argn <=3D arg_idx;
 }
=20
-/* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
-static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
-				   const struct btf_type *t, int rec)
+static bool btf_member_kind_allowed(const struct btf *btf, const struct =
btf_type *t,
+				    u32 member_kinds)
+{
+	if ((member_kinds & BTF_MEMBER_SCALAR) && btf_type_is_scalar(t))
+		return true;
+	if ((member_kinds & BTF_MEMBER_ARENA_PTR) && btf_type_is_arena_ptr(btf,=
 t))
+		return true;
+	return false;
+}
+
+/*
+ * Returns true if every member of struct @t is of a kind listed in
+ * @member_kinds, 4 levels of nesting allowed.
+ */
+static bool btf_struct_member_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
+				   const struct btf_type *t, u32 member_kinds, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11643,7 +11656,7 @@ static bool btf_scalar_struct_walk(struct bpf_ver=
ifier_env *env, const struct bt
 				verbose(env, "max struct nesting depth exceeded\n");
 				return false;
 			}
-			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1))
+			if (!btf_struct_member_walk(env, btf, member_type, member_kinds, rec =
+ 1))
 				return false;
 			continue;
 		}
@@ -11652,21 +11665,25 @@ static bool btf_scalar_struct_walk(struct bpf_v=
erifier_env *env, const struct bt
 			if (!array->nelems)
 				return false;
 			member_type =3D btf_type_skip_modifiers(btf, array->type, NULL);
-			if (!btf_type_is_scalar(member_type))
-				return false;
-			continue;
 		}
-		if (!btf_type_is_scalar(member_type))
+		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
 			return false;
 	}
 	return true;
 }
=20
-bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+bool btf_struct_is_composed_of(struct bpf_verifier_env *env,
 			       const struct btf *btf,
-			       const struct btf_type *t)
+			       const struct btf_type *t, u32 member_kinds)
+{
+	return btf_struct_member_walk(env, btf, t, member_kinds, 0);
+}
+
+static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+				      const struct btf *btf,
+				      const struct btf_type *t)
 {
-	return btf_scalar_struct_walk(env, btf, t, 0);
+	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
 }
=20
 enum kfunc_ptr_arg_type {
--=20
2.53.0-Meta

