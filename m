Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C1405C3F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498627; cv=none; b=FLdwNpTlHnOjJ8jXGOns6Sujbu5ODJxND0K92vOIYURTL1b2vYjShEGgHeyPUeLVdzds6ovMQhTF2L8uHjOGPqgCzzyUFc8opQFij6OzAnSc1cKJ3uT4hNRveibSDRS/vQOCiJPZK62zee33ak3E3IvKD0CKzC8q6DtzgSfoYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498627; c=relaxed/simple;
	bh=ICJzCMro425ni4AI9h+aPtX3zZjvxH/ErLYXSwK7tdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6OpSaawOInV4gzBBQG8ysatGnJjEkEpmrZPNVrpu8Y6Tfyr58X7w2NBitV41FBXUcPipJvYu7ZrMAwYD4Hesp90RKq0itT+MPmcWJI9+WXzHMPfWdCK+q08VOt9v/oaD1kI3EjEhV+EziSLxGZhAgmRRFspaNTm7UHZCy9NHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 114212881316EB; Thu,  3 Sep 2026 22:10:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 03/12] bpf: Support by-value struct arguments up to 16 bytes
Date: Thu,  3 Sep 2026 22:10:13 -0700
Message-ID: <20260904051013.3978240-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A global function taking a struct or union by value is rejected today:

  Arg#1 type STRUCT in tar() is not supported yet.

A struct of at most 16 bytes arrives in one or two consecutive
registers. Currently, the struct is composed of scalars.

The slots of a value are independent of each other, so the compiler may
split one across the last argument register and the stack, as in

  static void f(int a, int b, int c, int d, struct pair p);

or place it wholly past the registers, and the verifier describes either
the same way. What has to follow the slots is stack_arg_cnt, recomputed
from the slots consumed, together with the "no stack args in global
functions" and JIT support checks.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c      | 48 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 55 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 22828b489b77..dbd64cee1b27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8103,6 +8103,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
 		u32 tags =3D 0;
=20
+		if (slots_used >=3D MAX_BPF_FUNC_ARGS) {
+			if (!is_global)
+				return -EINVAL;
+			bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
+				tname, MAX_BPF_FUNC_ARGS);
+			return -EINVAL;
+		}
+
 		err =3D btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
 		if (err)
 			return err;
@@ -8231,6 +8239,31 @@ int btf_prepare_func_args(struct bpf_verifier_env =
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
+			while (nslots--)
+				sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
+			continue;
+		}
 		if (!is_global)
 			return -EINVAL;
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
@@ -8238,6 +8271,21 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 		return -EINVAL;
 	}
=20
+	if (slots_used > MAX_BPF_FUNC_REG_ARGS) {
+		if (is_global) {
+			bpf_log(log,
+				"global function %s() needs %d > %d argument slots, "
+				"stack args not supported\n",
+				tname, slots_used, MAX_BPF_FUNC_REG_ARGS);
+			return -EINVAL;
+		}
+		if (!bpf_jit_supports_stack_args()) {
+			bpf_log(log, "JIT does not support function %s() with %d argument slo=
ts\n",
+				tname, slots_used);
+			return -EFAULT;
+		}
+		sub->stack_arg_cnt =3D slots_used - MAX_BPF_FUNC_REG_ARGS;
+	}
 	sub->arg_cnt =3D slots_used;
=20
 	sub->args_cached =3D true;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..17e576c7b757 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9724,6 +9724,13 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
 	func =3D btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id=
);
 	func_proto =3D btf_type_by_id(btf, func->type);
 	args =3D btf_params(func_proto);
+	/*
+	 * An argument slot index can run past the end of the parameter array,
+	 * so only pass the parameters, for the names of the stack arguments,
+	 * if the two match.
+	 */
+	if (sub->arg_cnt !=3D btf_type_vlen(func_proto))
+		args =3D NULL;
 	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt,
 					bpf_subprog_name(env, subprog), btf, args);
 	if (ret)
--=20
2.53.0-Meta

