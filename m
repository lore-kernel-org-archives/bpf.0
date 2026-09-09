Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFE38F930
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935153; cv=none; b=OhXB1Lzclngp1IpZ2gwF5mhloyCEQVSKaGYOkcejsSaRdlw7nI44BD2fZjX2rf+vGWyhnqtTJHDSPoHwOQp65o9etzjQEIJTVEZSyvCwfvT1AGsLGoixWHvGmiu74dtQ3OD/8Qs5jeHbdJWa6/PUtwKikApNovHPmF1UCGbNGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935153; c=relaxed/simple;
	bh=/B09vacuxWRGf0K2lwcOn1taf5o3oQkKaxd0QVeumFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNofIXWMQkXDf5e/DLAhpbHC16Vm/CPN2GjbzctRANudQq+eX4V3l8WHwIyzWbewN244GCUsh9eJ+4vjyIvLctpecvux7XClBD05KwU2UWVn2GQB8+Cv+Gjxv1vslWvsfXg0hW8+EmmXna0+blXt2JNjbt53jCIdoJoALi/CC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 52803299468B71; Tue,  8 Sep 2026 23:25:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 03/12] bpf: Support by-value struct arguments up to 16 bytes
Date: Tue,  8 Sep 2026 23:25:38 -0700
Message-ID: <20260909062538.4003426-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909062522.4001896-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
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

The previous patch made sub->arg_cnt a count of argument slots; this is
the first patch where that count can exceed the number of BTF parameters,
so a slot index no longer indexes the parameter array. Have
btf_check_func_arg_match() hand the parameters to
check_outgoing_stack_args(), which uses them only to name a stack
argument in its diagnostic, just when the two counts still agree.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  7 ++++++
 2 files changed, 59 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 104a91f5ffd5..4502b888b668 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8125,6 +8125,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
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
@@ -8253,6 +8256,33 @@ int btf_prepare_func_args(struct bpf_verifier_env =
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
@@ -8260,11 +8290,33 @@ int btf_prepare_func_args(struct bpf_verifier_env=
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
index 9e79750e2480..a9243066a114 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9784,6 +9784,13 @@ static int btf_check_func_arg_match(struct bpf_ver=
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

