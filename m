Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08B38F649
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242791; cv=none; b=bJn3v7nl3fuAeI4UHyW/0EPLYuokKcXQ7R+usNLsX2KWny54WxHWIyt3qKc7dFzDs0zTnEv4/NVxcKNk3I0ftSFqL/OJQ5vzJOJLkTONX1PQwMbQDVNNOrrej8maP5HUlEVK0PadAhBiGLgMp+1cSwf3TRD32TP6cZolJC7lUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242791; c=relaxed/simple;
	bh=HgLfB+iujDYXJ0SstM5grRUSNbsHH03ejmPQE6Q9ol4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7e+BQBG99F9HyVIJ++S7Qk23t/Iti+f2I+m8z2bnMMQ0Hry95htRsTHj4bXK2Dcse+JyFZaethFT8YGAhxEAdQOxhTkfj/PEjcnXu6096zgi839Qj90WOcbrzcdHaUrrQUgBJ/0lTr9q1u+LqIM9CfXT0V/e2bWuLSXRSUAd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C14732A58A0DE3; Sat, 12 Sep 2026 12:52:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 12/15] bpf, arm64: Move kfunc arguments into the arm64 calling convention
Date: Sat, 12 Sep 2026 12:52:57 -0700
Message-ID: <20260912195257.990814-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do the proper move from the BPF calling convention to the arm64 calling
convention to satisfy the native requirement. AAPCS64 only ever moves an
argument to a higher slot, so the moves need one scratch register to carr=
y
an eightbyte from one stack slot to another, and never the one a
convention moving an argument down would need.

In addition, the arena argument walk counts eightbytes rather than
parameters, as an argument may take two registers. The walk takes the
func model from the caller now, as the moves need it too, and runs first
so that they carry the rebased value.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 25a7657a6710..6c04fee46876 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1268,19 +1268,20 @@ static void emit_stack_arg_store_imm(s32 imm, s16=
 bpf_off, const u8 tmp, struct
  * kern_vm_start. A nullable arg preserves NULL by skipping the add, tes=
ted
  * on the truncated value as arena NULL is offset 0.
  */
-static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_i=
nsn *insn)
+static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct btf_f=
unc_model *fm)
 {
 	const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
-	const struct btf_func_model *fm;
-	int i;
-
-	fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
-	if (!fm)
-		return -EINVAL;
+	int i, slot;
=20
-	for (i =3D 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) =
{
-		const u8 reg =3D bpf2a64[BPF_REG_1 + i];
+	for (i =3D 0, slot =3D 0; i < fm->nr_args; i++) {
+		u32 arg_regs =3D (fm->arg_size[i] + 7) / 8;
 		u8 flags =3D fm->arg_flags[i];
+		u8 reg;
+
+		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS)
+			break;
+		reg =3D bpf2a64[BPF_REG_1 + slot];
+		slot +=3D arg_regs;
=20
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
@@ -1309,6 +1310,42 @@ static s32 a64_arg_stack_off(u8 slot)
 	return (slot - arm64_arg_abi.nr_arg_regs) * sizeof(u64);
 }
=20
+/*
+ * Move the arguments AAPCS64 places somewhere other than the argument s=
lot the
+ * BPF calling convention gave them. Slot N is X(N) up to the eighth, an=
d the
+ * outgoing stack argument area from SP beyond it, both for the slot an
+ * argument comes from and for the one it goes to.
+ *
+ * AAPCS64 only ever moves an argument to a higher slot, so no move here=
 ever
+ * takes BPF_JIT_ARG_TMP: bpf_jit_plan_arg_moves() hands out the scratch=
 only
+ * for a convention that moves one down, which needs a register to carry=
 the
+ * value past its own destination.
+ */
+static void emit_kfunc_arg_moves(struct jit_ctx *ctx, const struct btf_f=
unc_model *fm)
+{
+	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
+	const u8 tmp =3D bpf2a64[TMP_REG_1];
+	u32 i, n;
+
+	n =3D bpf_jit_plan_arg_moves(&arm64_arg_abi, fm, moves);
+
+	for (i =3D 0; i < n; i++) {
+		u8 dst =3D moves[i].dst, src =3D moves[i].src, reg;
+
+		if (a64_arg_on_stack(src)) {
+			reg =3D tmp;
+			emit(A64_LDR64I(reg, A64_SP, a64_arg_stack_off(src)), ctx);
+		} else {
+			reg =3D src;
+		}
+
+		if (a64_arg_on_stack(dst))
+			emit(A64_STR64I(reg, A64_SP, a64_arg_stack_off(dst)), ctx);
+		else if (reg !=3D dst)
+			emit(A64_MOV(1, dst, reg), ctx);
+	}
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1732,9 +1769,15 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 		if (ret < 0)
 			return ret;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
-			ret =3D emit_kfunc_arena_args(ctx, insn);
+			const struct btf_func_model *fm;
+
+			fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
+			if (!fm)
+				return -EINVAL;
+			ret =3D emit_kfunc_arena_args(ctx, fm);
 			if (ret < 0)
 				return ret;
+			emit_kfunc_arg_moves(ctx, fm);
 		}
 		emit_call(func_addr, ctx);
 		/*
@@ -2409,6 +2452,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
=20
+const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
+{
+	return &arm64_arg_abi;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
--=20
2.53.0-Meta

