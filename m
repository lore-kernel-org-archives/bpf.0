Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03072D5436
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647927; cv=none; b=i3FlJPLBk94vIk+0am4uzbqZDfTB24imd2kedVweFnl2vRIkuOn6Zx/CdgEi5PU+MIfpGUCnJiROYZZ6QJSFuw+78yeeSfpb5i0WtryFVEmeRDj42OhjynvAc3JzIDacHYroOtFzKHBWbCgch+5Gl2avAOCTHdxCT8q2gnDN92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647927; c=relaxed/simple;
	bh=mdoivd/diWC3TG5M8m1epw+spi4Jm4xmGktQbjlcXTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGwfKUFOW99/sGlQRha9NhOb4s90FVDl+hN6++scSH+Mq/dKhzuLkAVVpx5Q9QReOw77k1bkjDnimN81Fb070lwthe2gBiMIfjCmsuaMB29AttzBibbYMmut5G/7JonDfzyDZ2yQJ8UIeDYgQIotVe8gMd53KL6KuXnDnRLGSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 38D96B198257A; Tue, 12 May 2026 21:51:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v4 24/25] bpf, arm64: Add JIT support for stack arguments
Date: Tue, 12 May 2026 21:51:58 -0700
Message-ID: <20260513045158.2402494-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Puranjay Mohan <puranjay@kernel.org>

Implement stack argument passing for BPF-to-BPF and kfunc calls with
more than 5 parameters on arm64, following the AAPCS64 calling
convention.

BPF R1-R5 already map to x0-x4. With BPF_REG_0 moved to x8 by the
previous commit, x5-x7 are free for arguments 6-8. Arguments 9-12
spill onto the stack at [SP+0], [SP+8], ... and the callee reads
them from [FP+16], [FP+24], ... (above the saved FP/LR pair).

BPF convention uses fixed offsets from BPF_REG_PARAMS (r11): off=3D-8 is
always arg 6, off=3D-16 arg 7, etc. The verifier invalidates all outgoing
stack arg slots after each call, so the compiler must re-store before
every call. This means x5-x7 don't need to be saved on stack.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 88 ++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 085e650662e3..e3bbeaa94590 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -86,6 +86,7 @@ struct jit_ctx {
 	__le32 *image;
 	__le32 *ro_image;
 	u32 stack_size;
+	u16 stack_arg_size;
 	u64 user_vm_start;
 	u64 arena_vm_start;
 	bool fp_used;
@@ -533,13 +534,19 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
 	 *                        |     |
 	 *                        +-----+ <=3D (BPF_FP - prog->aux->stack_depth=
)
 	 *                        |RSVD | padding
-	 * current A64_SP =3D>      +-----+ <=3D (BPF_FP - ctx->stack_size)
+	 *                        +-----+ <=3D (BPF_FP - ctx->stack_size)
+	 *                        |     |
+	 *                        | ... | outgoing stack args (9+, if any)
+	 *                        |     |
+	 * current A64_SP =3D>      +-----+
 	 *                        |     |
 	 *                        | ... | Function call stack
 	 *                        |     |
 	 *                        +-----+
 	 *                          low
 	 *
+	 * Stack args 6-8 are passed in x5-x7, args 9+ at [SP].
+	 * Incoming args 9+ are at [FP + 16], [FP + 24], ...
 	 */
=20
 	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
@@ -613,6 +620,9 @@ static int build_prologue(struct jit_ctx *ctx, bool e=
bpf_from_cbpf)
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
=20
+	if (ctx->stack_arg_size)
+		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	if (ctx->arena_vm_start)
 		emit_a64_mov_i64(arena_vm_base, ctx->arena_vm_start, ctx);
=20
@@ -673,6 +683,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	/* Update tail_call_cnt if the slot is populated. */
 	emit(A64_STR64I(tcc, ptr, 0), ctx);
=20
+	if (ctx->stack_arg_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	/* restore SP */
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
@@ -1034,6 +1047,9 @@ static void build_epilogue(struct jit_ctx *ctx, boo=
l was_classic)
 	const u8 r0 =3D bpf2a64[BPF_REG_0];
 	const u8 ptr =3D bpf2a64[TCCNT_PTR];
=20
+	if (ctx->stack_arg_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	/* We're done with BPF stack */
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
@@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
 	return 0;
 }
=20
+static const u8 stack_arg_reg[] =3D { A64_R(5), A64_R(6), A64_R(7) };
+
+#define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
+
+static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx=
)
+{
+	int idx =3D bpf_off / sizeof(u64) - 1;
+
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
+	else
+		emit(A64_LDR64I(dst, A64_FP, (idx - NR_STACK_ARG_REGS) * sizeof(u64) +=
 16), ctx);
+}
+
+static void emit_stack_arg_store(u8 src_a64, s16 bpf_off, struct jit_ctx=
 *ctx)
+{
+	int idx =3D -bpf_off / sizeof(u64) - 1;
+
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, stack_arg_reg[idx], src_a64), ctx);
+	else
+		emit(A64_STR64I(src_a64, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u6=
4)), ctx);
+}
+
+static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp,=
 struct jit_ctx *ctx)
+{
+	int idx =3D -bpf_off / sizeof(u64) - 1;
+
+	emit_a64_mov_i(1, tmp, imm, ctx);
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, stack_arg_reg[idx], tmp), ctx);
+	else
+		emit(A64_STR64I(tmp, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u64)),=
 ctx);
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1646,6 +1697,11 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+		if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
+			emit_stack_arg_load(dst, off, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
@@ -1672,6 +1728,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 		if (src =3D=3D fp) {
 			src_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj =3D off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj +=3D ctx->stack_arg_size;
 		} else {
 			src_adj =3D src;
 			off_adj =3D off;
@@ -1752,6 +1810,11 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
+		if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
+			emit_stack_arg_store_imm(imm, off, tmp, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
@@ -1763,6 +1826,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 		if (dst =3D=3D fp) {
 			dst_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj =3D off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj +=3D ctx->stack_arg_size;
 		} else {
 			dst_adj =3D dst;
 			off_adj =3D off;
@@ -1814,6 +1879,11 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
+		if (insn->dst_reg =3D=3D BPF_REG_PARAMS) {
+			emit_stack_arg_store(src, off, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
@@ -1825,6 +1895,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 		if (dst =3D=3D fp) {
 			dst_adj =3D ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj =3D off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj +=3D ctx->stack_arg_size;
 		} else {
 			dst_adj =3D dst;
 			off_adj =3D off;
@@ -2018,6 +2090,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
 	u8 *ro_image_ptr;
 	int body_idx;
 	int exentry_idx;
+	int out_cnt;
=20
 	if (!prog->jit_requested)
 		return prog;
@@ -2065,6 +2138,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 	ctx.user_vm_start =3D bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx.arena_vm_start =3D bpf_arena_get_kern_vm_start(prog->aux->arena);
=20
+	out_cnt =3D bpf_out_stack_arg_cnt(env, prog);
+	if (out_cnt) {
+		int nr_on_stack =3D out_cnt - NR_STACK_ARG_REGS;
+
+		if (nr_on_stack > 0)
+			ctx.stack_arg_size =3D round_up(nr_on_stack * sizeof(u64), 16);
+	}
+
 	if (priv_stack_ptr)
 		ctx.priv_sp_used =3D true;
=20
@@ -2229,6 +2310,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (!aarch64_insn_copy(dst, src, len))
--=20
2.53.0-Meta

