Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83A412C04
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498655; cv=none; b=mMxGH6yqnWK8v7J1OMJM9bdYOEAEbmvwY8yGQegIdLJtO6k/0tbRuzN9oefgFqvwraCeboHKjppkEIwklNjJbpuNd7rVyMwJe4kZeN57ScOax92SWFxuK8MYscxWd0gNZu+uAp5hKkv6mtP4v3QqKdkBD0d5yqm0bMoNPCN6MDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498655; c=relaxed/simple;
	bh=X4M9l8mxrF9I2fP3imiuOP0ucocUZ2nyZw048vbWXFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm3MtHtOVoyOA4S76qSqMpmAR8Dy0k9RxVFyJoODnHfIl1flpNGPOZLRstzef6vHSWAq6PMCjmt9YMCP6k7puFxdykG3bUeZ4myRIWlEQZOl2zHqpAhFZ/FrtdaMxOOz8IPrLS8umv1524Z4OFvTEO1g+zju+hcQdy0HtUu2bVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 182E128813F98B; Thu,  3 Sep 2026 22:10:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 09/12] bpf, arm64: Place kfunc arguments per AAPCS64
Date: Thu,  3 Sep 2026 22:10:43 -0700
Message-ID: <20260904051043.3981550-1-yonghong.song@linux.dev>
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

As on x86-64, the JIT hands each eightbyte the BPF calling convention
passes an argument in to the argument position of the same number, and
moves the ones AAPCS64 wants elsewhere.

AAPCS64 has eight argument registers and disagrees in two ways. It rounds
the register number up to an even one for an argument aligned to 16
bytes, so

  u64 f(u64 a, __int128 v, u64 b);

wants v in x2 and x3 where the BPF convention put it in x1 and x2. And it
gives no register to anything once an argument has gone to the stack,
which the BPF convention, with three argument registers fewer, reaches
sooner. Both only ever move an eightbyte further along than the BPF
convention put it, so moving the last one first is enough and no value
has to wait anywhere.

The alignment reaches the JIT as BTF_FMODEL_ALIGN16_ARG in the function
model.

An argument AAPCS64 places on the stack while the BPF convention kept it
in a register needs room the BPF slots do not account for, so the
outgoing argument area is sized for both. As on x86-64, an eightbyte
whose position equals its slot needs no move,
bpf_jit_supports_kfunc_arg_slot() can now answer yes to any placement,
and the arena argument walk counts eightbytes rather than parameters.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 112 +++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 3aa3ea0bc30b..f6c783d176ed 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1256,6 +1256,93 @@ static void emit_stack_arg_store_imm(s32 imm, s16 =
bpf_off, const u8 tmp, struct
 	}
 }
=20
+/* The kernel ABI hands the first eight eightbytes of arguments to regis=
ters. */
+static const u8 a64_arg_reg[8] =3D {
+	A64_R(0), A64_R(1), A64_R(2), A64_R(3),
+	A64_R(4), A64_R(5), A64_R(6), A64_R(7),
+};
+
+static int kfunc_arg_layout(const struct btf_func_model *fm, u8 *pos, in=
t max)
+{
+	int i, k, ngrn =3D 0, nsaa =3D 0, slot =3D 0;
+
+	for (i =3D 0; i < fm->nr_args; i++) {
+		bool align16 =3D fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
+		int n =3D (fm->arg_size[i] + 7) / 8;
+
+		if (slot + n > max)
+			return -EINVAL;
+		if (align16)
+			ngrn =3D round_up(ngrn, 2);
+		if (ngrn + n <=3D 8) {
+			for (k =3D 0; k < n; k++)
+				pos[slot++] =3D ngrn++;
+			continue;
+		}
+		/* Nothing that follows gets a register either. */
+		ngrn =3D 8;
+		if (align16)
+			nsaa =3D round_up(nsaa, 2);
+		for (k =3D 0; k < n; k++)
+			pos[slot++] =3D 8 + nsaa++;
+	}
+	return slot;
+}
+
+static u16 kfunc_arg_stack_bytes(const struct bpf_prog *prog)
+{
+	u16 slots =3D bpf_jit_kfunc_stack_slots(prog, 8, kfunc_arg_layout);
+
+	return round_up(slots * sizeof(u64), 16);
+}
+
+static void emit_arg_pos_load(u8 reg, u8 pos, struct jit_ctx *ctx)
+{
+	if (pos < 8)
+		emit(A64_MOV(1, reg, a64_arg_reg[pos]), ctx);
+	else
+		emit(A64_LDR64I(reg, A64_SP, (pos - 8) * sizeof(u64)), ctx);
+}
+
+static void emit_arg_pos_store(u8 pos, u8 reg, struct jit_ctx *ctx)
+{
+	if (pos < 8)
+		emit(A64_MOV(1, a64_arg_reg[pos], reg), ctx);
+	else
+		emit(A64_STR64I(reg, A64_SP, (pos - 8) * sizeof(u64)), ctx);
+}
+
+static int emit_kfunc_args(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
+{
+	const u8 tmp =3D bpf2a64[TMP_REG_1];
+	const struct btf_func_model *fm;
+	u8 pos[MAX_BPF_FUNC_ARGS];
+	int i, n;
+
+	fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
+	if (!fm)
+		return -EINVAL;
+
+	n =3D kfunc_arg_layout(fm, pos, ARRAY_SIZE(pos));
+	if (n < 0)
+		return 0;
+
+	for (i =3D n - 1; i >=3D 0; i--) {
+		if (pos[i] =3D=3D i)
+			continue;
+		if (WARN_ON_ONCE(pos[i] < i))
+			return -EFAULT;
+		if (pos[i] < 8) {
+			/* into a register, read straight from the slot */
+			emit_arg_pos_load(a64_arg_reg[pos[i]], i, ctx);
+		} else {
+			emit_arg_pos_load(tmp, i, ctx);
+			emit_arg_pos_store(pos[i], tmp, ctx);
+		}
+	}
+	return 0;
+}
+
 /*
  * Rebase the __arena args of a kfunc call to arena kernel addresses,
  * xN =3D kern_vm_start + (u32)xN, with the arena base register holding
@@ -1266,15 +1353,25 @@ static int emit_kfunc_arena_args(struct jit_ctx *=
ctx, const struct bpf_insn *ins
 {
 	const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
 	const struct btf_func_model *fm;
-	int i;
+	int i, slot;
=20
 	fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
 	if (!fm)
 		return -EINVAL;
=20
-	for (i =3D 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) =
{
-		const u8 reg =3D bpf2a64[BPF_REG_1 + i];
+	for (i =3D 0, slot =3D 0; i < fm->nr_args; i++) {
+		u32 arg_regs =3D (fm->arg_size[i] + 7) / 8;
 		u8 flags =3D fm->arg_flags[i];
+		u8 reg;
+
+		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS) {
+			/* The verifier refuses an arena pointer past the registers. */
+			if (WARN_ON_ONCE(flags & BTF_FMODEL_ARENA_ARG))
+				return -EFAULT;
+			break;
+		}
+		reg =3D bpf2a64[BPF_REG_1 + slot];
+		slot +=3D arg_regs;
=20
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
@@ -1719,6 +1816,9 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 			ret =3D emit_kfunc_arena_args(ctx, insn);
 			if (ret < 0)
 				return ret;
+			ret =3D emit_kfunc_args(insn, ctx);
+			if (ret < 0)
+				return ret;
 		}
 		emit_call(func_addr, ctx);
 		/*
@@ -2223,6 +2323,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
 		if (nr_on_stack > 0)
 			ctx.stack_arg_size =3D round_up(nr_on_stack * sizeof(u64), 16);
 	}
+	ctx.stack_arg_size =3D max(ctx.stack_arg_size, kfunc_arg_stack_bytes(pr=
og));
=20
 	if (priv_stack_ptr)
 		ctx.priv_sp_used =3D true;
@@ -2393,6 +2494,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
=20
+bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn)
+{
+	return true;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
--=20
2.53.0-Meta

