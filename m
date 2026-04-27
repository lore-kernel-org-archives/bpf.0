Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680B35CB7F
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333705; cv=none; b=M5AEwGX5UhQqlWb+uBKhnWEYozIsMnVCHLQdvl36gSFTzh0QFqcMkvYXWPfF/teCATvkhZXeWyvUhuBUCf+ZIku4gd2ttfT7VeiALIwEs/viLKII+cr5FKRbpgJ/xvA5xkqUwTKwWnwPFKCdM+WmHyJwFxF/j5z6/g0LHSAQ1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333705; c=relaxed/simple;
	bh=BZ057PbpY+4PUEf2mArRGl6pLVxBRVV/BVvTBrZOaAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS8EpEtYoduuYz0GjVsZepap0y0Ywty+qJpC0X7awPSprvwUMZ/fwhL5+eOQX+uC6CtSvVlJ7fl64VbjH3IPh+1tBEOrgfOSSKxx6E8uspUukbUL1M2yMw/UiIn5D26hEirY8AaNodI3umAYxXU6J1hPbfgk/GlZTIkJUUWl33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZFqx/f2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZFqx/f2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22B5C19425;
	Mon, 27 Apr 2026 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333705;
	bh=BZ057PbpY+4PUEf2mArRGl6pLVxBRVV/BVvTBrZOaAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZFqx/f2rp3eo15KaEKSvtJ+xWqwO1YY/fnw2UYt3GzmApmcVNpANZJdi20JlHcjZ
	 44th50u5kgS/zxYRukn18pyysKWmb8qQITITZbFmWPfNjPOcuyIpHAj2vF4l/5kf5y
	 cZw73O9cXsGBPqj1bnzQyCNIaX7AcNFzD+LkiNGKDdNAvbSetlcJWNHTCvpuwOkREh
	 iO0cQnoR6IypAoz6X24/Jnum12PYhtala/gOdklsJFPFzWa0U95eWVm23U+wFdNLx3
	 8pKEYw018xuLBvQleRFmszthdl+Rn/B5sC+o0Zd9SlJ8KXSjhoDiowKnar9LnDMBhE
	 lUWUHUVmcfuQQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	"Yonghong Song" <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v2 2/3] bpf, arm64: Add JIT support for stack arguments
Date: Mon, 27 Apr 2026 16:47:59 -0700
Message-ID: <20260427234801.2104511-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427234801.2104511-1-puranjay@kernel.org>
References: <20260427234801.2104511-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement stack argument passing for BPF-to-BPF and kfunc calls with
more than 5 parameters on arm64, following the AAPCS64 calling
convention.

BPF R1-R5 already map to x0-x4. With BPF_REG_0 moved to x8 by the
previous commit, x5-x7 are free for arguments 6-8. Arguments 9-12
spill onto the stack at [SP+0], [SP+8], ... and the callee reads
them from [FP+16], [FP+24], ... (above the saved FP/LR pair).

BPF convention uses fixed offsets from BPF_REG_PARAMS (r11): off=-8 is
always arg 6, off=-16 arg 7, etc. The verifier invalidates all outgoing
stack arg slots after each call, so the compiler must re-store before
every call. This means x5-x7 don't need to be saved on stack.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 085e650662e3..cd8279880795 100644
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
@@ -533,13 +534,19 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *                        |     |
 	 *                        +-----+ <= (BPF_FP - prog->aux->stack_depth)
 	 *                        |RSVD | padding
-	 * current A64_SP =>      +-----+ <= (BPF_FP - ctx->stack_size)
+	 *                        +-----+ <= (BPF_FP - ctx->stack_size)
+	 *                        |     |
+	 *                        | ... | outgoing stack args (9+, if any)
+	 *                        |     |
+	 * current A64_SP =>      +-----+
 	 *                        |     |
 	 *                        | ... | Function call stack
 	 *                        |     |
 	 *                        +-----+
 	 *                          low
 	 *
+	 * Stack args 6-8 are passed in x5-x7, args 9+ at [SP].
+	 * Incoming args 9+ are at [FP + 16], [FP + 24], ...
 	 */
 
 	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
@@ -613,6 +620,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
+	if (ctx->stack_arg_size)
+		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	if (ctx->arena_vm_start)
 		emit_a64_mov_i64(arena_vm_base, ctx->arena_vm_start, ctx);
 
@@ -673,6 +683,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	/* Update tail_call_cnt if the slot is populated. */
 	emit(A64_STR64I(tcc, ptr, 0), ctx);
 
+	if (ctx->stack_arg_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	/* restore SP */
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
@@ -1034,6 +1047,9 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
 
+	if (ctx->stack_arg_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
+
 	/* We're done with BPF stack */
 	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
@@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+static const u8 stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) };
+
+#define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
+
+static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
+{
+	int idx = bpf_off / sizeof(u64) - 1;
+
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
+	else
+		emit(A64_LDR64I(dst, A64_FP, (idx - NR_STACK_ARG_REGS) * sizeof(u64) + 16), ctx);
+}
+
+static void emit_stack_arg_store(u8 src_a64, s16 bpf_off, struct jit_ctx *ctx)
+{
+	int idx = -bpf_off / sizeof(u64) - 1;
+
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, stack_arg_reg[idx], src_a64), ctx);
+	else
+		emit(A64_STR64I(src_a64, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u64)), ctx);
+}
+
+static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct jit_ctx *ctx)
+{
+	int idx = -bpf_off / sizeof(u64) - 1;
+
+	emit_a64_mov_i(1, tmp, imm, ctx);
+	if (idx < NR_STACK_ARG_REGS)
+		emit(A64_MOV(1, stack_arg_reg[idx], tmp), ctx);
+	else
+		emit(A64_STR64I(tmp, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u64)), ctx);
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1646,6 +1697,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+		if (insn->src_reg == BPF_REG_PARAMS) {
+			emit_stack_arg_load(dst, off, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
@@ -1672,6 +1728,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		if (src == fp) {
 			src_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj += ctx->stack_arg_size;
 		} else {
 			src_adj = src;
 			off_adj = off;
@@ -1752,6 +1810,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
+		if (insn->dst_reg == BPF_REG_PARAMS) {
+			emit_stack_arg_store_imm(imm, off, tmp, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
@@ -1763,6 +1826,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		if (dst == fp) {
 			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj += ctx->stack_arg_size;
 		} else {
 			dst_adj = dst;
 			off_adj = off;
@@ -1814,6 +1879,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
+		if (insn->dst_reg == BPF_REG_PARAMS) {
+			emit_stack_arg_store(src, off, ctx);
+			break;
+		}
+		fallthrough;
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
@@ -1825,6 +1895,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		if (dst == fp) {
 			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
+			if (!ctx->priv_sp_used)
+				off_adj += ctx->stack_arg_size;
 		} else {
 			dst_adj = dst;
 			off_adj = off;
@@ -2065,6 +2137,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 
+	if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_depth) {
+		u16 outgoing = prog->aux->stack_arg_depth - prog->aux->incoming_stack_arg_depth;
+		int nr_on_stack = outgoing / sizeof(u64) - NR_STACK_ARG_REGS;
+
+		if (nr_on_stack > 0)
+			ctx.stack_arg_size = round_up(nr_on_stack * sizeof(u64), 16);
+	}
+
 	if (priv_stack_ptr)
 		ctx.priv_sp_used = true;
 
@@ -2229,6 +2309,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (!aarch64_insn_copy(dst, src, len))
-- 
2.52.0

