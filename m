Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865414A3D42
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141791; cv=none; b=O9kcgbo1xDEzzXHOX+GqkRikbExF5Z7ii/dvHWgEdWD5zF8mbt3RVaXxPtSl/UNdSWxXM1v5UyLuRBTHU0PyHKVY5pejUbIws4LwLzRuMnq3gpGbuTjQ/jc/hN4/yQNY/SOdJVg61pmFkPLO1WOZHGYb0Ohg6bqn/i0N2txkcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141791; c=relaxed/simple;
	bh=Win9fpzD9nOZfRkd0qbvss68Ce2rKTO62kXE+b4Y2vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qiv2l9oD4yKFPAoyiE0Mg7XaKvTM409QsVAy99ya64hG81c2A7OmT32ouRsbLvKFowxwrF5IuDyVMJ1R+SpGpzMmpK9xqrqb/YeXUuGuysSnMbUApf/pquLq37rx3M5GyckQjdO+qCupJ3xH36bIfHllsbcThHHR9k7b9xHuqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AD0642A1842FF3; Fri, 11 Sep 2026 08:49:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 05/15] bpf: Support by-value struct arguments up to 16 bytes
Date: Fri, 11 Sep 2026 08:49:39 -0700
Message-ID: <20260911154939.2006395-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A global function taking a struct or union by value is rejected today:

  Arg#1 type STRUCT in tar() is not supported yet.

Accept one of at most 16 bytes, which arrives in one or two consecutive
argument registers. Only structs composed entirely of scalars are taken
for now; btf_struct_is_composed_of() enforces that.

The slots of a value are independent of each other, so the compiler may
split one across the last argument register and the stack, as in

  static void f(int a, int b, int c, int d, struct pair p);

or place it wholly past the registers, and the verifier describes either
the same way. What has to follow the slots is stack_arg_cnt, recomputed
from the slots consumed, together with the "no stack args in global
functions" and JIT support checks, and the MAX_BPF_FUNC_ARGS bound, which
now has to account for a parameter that takes two slots at once.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c      | 80 +++++++++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c |  2 ++
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 35eaa28c85b5..5bbc1ba00ae2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8018,6 +8018,29 @@ static int btf_validate_return_type(struct bpf_ver=
ifier_env *env, struct btf *bt
 	return -EOPNOTSUPP;
 }
=20
+static int btf_check_arg_slots(struct bpf_verifier_log *log, const char =
*tname,
+			       bool is_global, u32 slot_cnt,
+			       struct bpf_subprog_info *sub)
+{
+	if (slot_cnt <=3D MAX_BPF_FUNC_REG_ARGS)
+		return 0;
+
+	if (is_global) {
+		bpf_log(log,
+			"global function %s() needs %d > %d argument slots, "
+			"stack args not supported\n",
+			tname, slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+		return -EINVAL;
+	}
+	if (!bpf_jit_supports_stack_args()) {
+		bpf_log(log, "JIT does not support function %s() with %d argument slot=
s\n",
+			tname, slot_cnt);
+		return -EFAULT;
+	}
+	sub->stack_arg_cnt =3D slot_cnt - MAX_BPF_FUNC_REG_ARGS;
+	return 0;
+}
+
 /* Process BTF of a function to produce high-level expectation of functi=
on
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This informa=
tion
  * is cached in subprog info for reuse.
@@ -8087,20 +8110,9 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			MAX_BPF_FUNC_ARGS, tname, nargs);
 		return -EFAULT;
 	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
-		if (!bpf_jit_supports_stack_args()) {
-			bpf_log(log, "JIT does not support function %s() with %d args\n",
-				tname, nargs);
-			return -EFAULT;
-		}
-		sub->stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
-	}
-
-	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
-		bpf_log(log, "global function %s has %d > %d args, stack args not supp=
orted\n",
-			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
-		return -EINVAL;
-	}
+	err =3D btf_check_arg_slots(log, tname, is_global, nargs, sub);
+	if (err)
+		return err;
=20
 	err =3D btf_validate_return_type(env, btf, t, subprog, is_global);
 	if (err) {
@@ -8125,6 +8137,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
 		u32 tags =3D 0;
=20
+		if (slots_used >=3D MAX_BPF_FUNC_ARGS)
+			goto too_many_slots;
+
 		err =3D btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
 		if (err)
 			return err;
@@ -8253,6 +8268,33 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
 			continue;
 		}
+		if (btf_type_is_struct(t)) {
+			u32 nslots;
+
+			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
+				if (!is_global)
+					return -EINVAL;
+				bpf_log(log,
+					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
+					"can be passed by value\n",
+					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
+				return -EINVAL;
+			}
+			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
+				if (!is_global)
+					return -EINVAL;
+				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
+					i, btf_type_str(t), tname);
+				return -EINVAL;
+			}
+
+			nslots =3D (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
+			if (slots_used + nslots > MAX_BPF_FUNC_ARGS)
+				goto too_many_slots;
+			while (nslots--)
+				sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
+			continue;
+		}
 		if (!is_global)
 			return -EINVAL;
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
@@ -8260,11 +8302,21 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 		return -EINVAL;
 	}
=20
+	err =3D btf_check_arg_slots(log, tname, is_global, slots_used, sub);
+	if (err)
+		return err;
 	sub->arg_slot_cnt =3D slots_used;
=20
 	sub->args_cached =3D true;
=20
 	return 0;
+
+too_many_slots:
+	if (!is_global)
+		return -EINVAL;
+	bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
+		tname, MAX_BPF_FUNC_ARGS);
+	return -EINVAL;
 }
=20
 static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8f4c17fb27d..500092a2c924 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9784,6 +9784,8 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 	func =3D btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id=
);
 	func_proto =3D btf_type_by_id(btf, func->type);
 	args =3D btf_params(func_proto);
+	if (sub->arg_slot_cnt !=3D btf_type_vlen(func_proto))
+		args =3D NULL;
 	ret =3D check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
 					bpf_subprog_name(env, subprog), btf, args);
 	if (ret)
--=20
2.52.0

