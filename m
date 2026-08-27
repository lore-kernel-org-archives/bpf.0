Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8176342538
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811108; cv=none; b=qICfmurTyOhFzf7JjAXeypQy95LWbz41xKYrbPtGsALrauQuzUqjMGILfw+DJKSnfw9D1CV/QM0tdM7fukIt6xLE2WEdw3Dki2CHMU830KJWlDFFrVm18zskuFCy6AkpDhhJi/RF7wpoPvvH4mHF+RRCNlaf7Nmvt53z9TpjL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811108; c=relaxed/simple;
	bh=wnNHWUMbe8Sgg/Rv2Y3fEp7L5IehVUXgANDCY9Cr4wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Gw/Uy+xoHg7a5tKiCKN3S1auBDtIdD++twVn+x0W/+wp7Nj64x8ClnbcQopWYDKyKsnjayVA8hhmOoTZhleyypsmU5wMggTmbdvi2LEDXbqa0qv3oKLu/WOLotjH7iHe7Y99lB2rhQwF4I0loCz6smCxtmhaNTa/IYT4Ifp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4591A26CDE2D1D; Wed, 26 Aug 2026 23:11:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 04/11] bpf: Let the by-value struct walk take the kinds of member it accepts
Date: Wed, 26 Aug 2026 23:11:35 -0700
Message-ID: <20260827061135.2516614-1-yonghong.song@linux.dev>
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

btf_scalar_struct_walk() hardcodes that every member of a struct returned
by value must be a scalar. A later patch needs the same walk to also
accept arena pointers, so give it a mask of the member kinds it allows.

There is no functional change: btf_member_kind_allowed() is exactly
btf_type_is_scalar() when the mask is BTF_MEMBER_SCALAR alone, and the
shared check is the last statement of the loop body, so dropping the arra=
y
branch's continue neither skips a member nor checks one twice.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 11 ++++++++--
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3eb61edc8c5e..ae9f606539f4 100644
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
+	BTF_MEMBER_SCALAR	=3D BIT(0), /* an int or an enum */
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
index bc3053e81500..90139f1b78d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11646,9 +11646,23 @@ static bool is_kfunc_arg_implicit(const struct b=
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
+ * @member_kinds, 4 levels of nesting allowed. An array member counts as=
 its
+ * element type.
+ */
+static bool btf_struct_member_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
+				   const struct btf_type *t, u32 member_kinds, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
@@ -11666,7 +11680,7 @@ static bool btf_scalar_struct_walk(struct bpf_ver=
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
@@ -11675,21 +11689,25 @@ static bool btf_scalar_struct_walk(struct bpf_v=
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

