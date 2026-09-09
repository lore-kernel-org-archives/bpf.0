Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E03A7F45
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935176; cv=none; b=dROD2fs8J++bPsMTO9r4Oddtq8u1TeYJPvKh2uOv6JAkbvw+6Yshh5Xcq4fZK0j5wKvqoTLmKncPDyplJs5MOf1l3eQgC8vUAS3kI7R9dR0BfM4gGivNICvDGvYhASXfrqui+A0kDeXH0vDT29SaBhaf33q7V1eE+LIhOffAMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935176; c=relaxed/simple;
	bh=d5UY+lL/wlH7GTn2xXG2ZIhkY/JFXvyYUYxEkyvkSKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgvDbj79KjAR7YtyR2rFyz5f5/Z32E7M9VygArWDRYPQhb2fFAgvN4GCMNSUdqfRSm4+8YtWwtc4YnCF+zPbW9dvD+EqsSpxWk0kERBb6ydMcXymQpek51EPp/UMVonlJ0NHbGq4Y/oWHe9Hj9gS5TSsRhxn7TbjoKjKJzFF7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E4A8A2994896DF; Tue,  8 Sep 2026 23:26:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 09/12] bpf, arm64: Move kfunc arguments into the arm64 calling convention
Date: Tue,  8 Sep 2026 23:26:10 -0700
Message-ID: <20260909062610.4008921-1-yonghong.song@linux.dev>
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

Do proper move from bpf calling convention to arm64 calling convention
to satisfy native requirement. AAPCS64 only ever moves an argument to a
higher slot, so the moves need one scratch register to carry an eightbyte
from one stack slot to another, and never the one a convention moving an
argument down would need.

In addition, the arena argument walk counts eightbytes rather than
parameters, as an argument may take two registers. The walk takes the
func model from the caller now, as the moves need it too, and runs first
so that they carry the rebased value.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 77 ++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 3aa3ea0bc30b..bdac930dbdec 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1220,6 +1220,12 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
 	return 0;
 }
=20
+static const struct bpf_jit_arg_abi arm64_arg_abi =3D {
+	.nr_arg_regs		=3D 8,
+	.even_reg_align		=3D true,
+	.even_stack_align	=3D true,
+};
+
 static const u8 stack_arg_reg[] =3D { A64_R(5), A64_R(6), A64_R(7) };
=20
 #define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
@@ -1262,19 +1268,20 @@ static void emit_stack_arg_store_imm(s32 imm, s16=
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
@@ -1293,6 +1300,45 @@ static int emit_kfunc_arena_args(struct jit_ctx *c=
tx, const struct bpf_insn *ins
 	return 0;
 }
=20
+static bool a64_arg_on_stack(u8 slot)
+{
+	return slot >=3D arm64_arg_abi.nr_arg_regs;
+}
+
+static s32 a64_arg_stack_off(u8 slot)
+{
+	return (slot - arm64_arg_abi.nr_arg_regs) * sizeof(u64);
+}
+
+/*
+ * AAPCS64 only ever moves an argument to a higher slot, so the planner =
asks
+ * for the scratch only to carry an eightbyte from one stack slot to ano=
ther.
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
+			reg =3D a64_arg_on_stack(dst) ? tmp : dst;
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
@@ -1716,9 +1762,15 @@ static int build_insn(const struct bpf_verifier_en=
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
@@ -2393,6 +2445,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

