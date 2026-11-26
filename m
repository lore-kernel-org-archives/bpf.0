Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664469;
	b=w6CilTGbcqZ68WYRIVkjfBju7DZ4U02cf2TINkgJ0JtOGbz1iTKgKBmpMCVZF7hWCxBi
	 Z+4fKZjy4SQjV8G9AgPE8IWk//Lk0whaG6aOBd12diJSnxgd/oVyunnAmzTiogtyeRtT5
	 rl5z6xIeMmif28dt5f8J7DPHCfMNoPCHSgWejsPgQWH0M6D2dCCRh+YWDBx+CseWFEdSb
	 8AXLUXvVOyNi5C0OGMdTQrCNTGpWkzKBFubAFDpQxWSl0/j1dRc3WvthXG0facc8f48nH
	 uZXmwlom79uk9eE37cqWQKPrn1y+cNGFICle0uMIhdwhdJLQzmkh3kUpSoksFEpJ7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cu4/QMNgUDttlkSirFHlpJU0ZVFgHAqcFhz9QrC0Vy0=;
	b=awao5R8NYAqLcAm0Aq5TQNbrczSgZiHHAxPvwGeks1v9FqRTJbbjm0iSiIlBzPxXtnau
	 cTIT0hTyhJ8I1QyVtKntX6jOk/F7o6xa2MD7NJzWf5VQGMe3lqtmDNmuDgdWuQQHqFfk0
	 StKSU130c6V4U9pZmNF5tg4QE9mu9MYAGyV3Qya+ZYzG7WDlzn9V99NZgCYL9J5CLDD5h
	 fhmD92ehrPwOBkzBI3h/k3x/ivJa7mkW7FzhNz1XqLwBtgLEri9rqlTd6ImoHUvwP4Ori
	 bjGQiHHU1GSzn6A3D0JmyeICkCyCXgNNJjd+TJp4+Tmuz0rMxhVKfDSQ4vZIncjibjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VAOTSOJx;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7602606A334
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7602606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VAOTSOJx
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RtOybAiEodjNlqWR1fpxn/WkDzI29SyP9n7ldos+97I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664466; v=1; x=1796269266;
 b=VAOTSOJxWeNsUA4PJwgx03ykDKNzNwc3MKL815YBifpUsy/2ztzU5PI03k2IupcdS95r1tlK
 dJ0JL3eVrLRCnYt39MV8wjg9P0gxIhTGK9qKslvLdjEFXVGL2bXzy84LALrcdTwNuuHx/IJ53W4
 GN5rz41bMVJYxxHtLz5lcBNM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 43dfb654f877169c;
	Thu, 26 Nov 2026 03:41:06 +0000
X-Mizu-Trace-ID: 43dfb654f877169c
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] LoongArch: BPF: Allow programs 2 KiB of stack
Date: Thu, 26 Nov 2026 12:40:45 +0900
Message-ID: <20261126034048.7370-4-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126034048.7370-1-dongtai.guo@linux.dev>
References: <20261126034048.7370-1-dongtai.guo@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

Currently, the LoongArch JIT allocates the whole frame of a program with
a single addi.d, and saves and restores the callee-saved registers at
$sp-relative offsets computed from the whole frame size. All of these
instructions take a signed 12-bit immediate, so the frame must stay
below 2 KiB, otherwise emit_insn() silently truncates the offsets. The
same applies to loading tcc_ptr from $sp and to adding the private stack
depth to the BPF frame pointer with addi.d.

To fix this, allocate the save area and the BPF stack separately. The
save area is still addressed with small offsets from $sp, and the BPF
stack below it is allocated with addi.d if its size fits the immediate,
otherwise with move_imm() and sub.d. The epilogue releases the BPF stack
by deriving $sp from $fp before restoring the registers. tcc_ptr is at a
fixed offset from $fp, so load it from $fp for tail calls, direct and
indirect bpf2bpf calls. Fold the depth of a private stack into the
per-CPU address of its top.

The frame layout does not change, and a program whose BPF stack is on
the kernel stack gets one more instruction in both the prologue and the
epilogue. Then make bpf_jit_supports_large_stack() return true to give
the JITed programs the same 2 KiB budget as on x86-64 and arm64. Since
LoongArch has 16 KiB kernel stacks, the worst case of a tail call chain
is the same as on x86-64, a little over 10 KiB.

This is similar to commit 1d5306c11da2 ("bpf, arm64: Allow programs
2 KiB of stack").

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 Documentation/bpf/bpf_design_QA.rst |  13 ++--
 arch/loongarch/net/bpf_jit.c        | 110 +++++++++++++++++-----------
 2 files changed, 76 insertions(+), 47 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 98d70b8a2533..cbedc56379c3 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -223,12 +223,13 @@ Q: How much stack space a BPF program uses?
 -------------------------------------------
 A: A program may use up to 2 KiB of stack, combined over its call
 chain, when the JIT of the architecture reports support for large
-stacks (currently x86-64 and arm64); a single function may use all of
-it, and every frame of a program running on a private stack gets the
-whole amount. Elsewhere, and for programs verified for the interpreter,
-the limit is 512 bytes; the interpreter itself never runs a frame
-larger than that. The verifier computes the actual amount of stack
-used and both interpreter and most JITed code consume necessary amount.
+stacks (currently x86-64, arm64 and LoongArch); a single function may
+use all of it, and every frame of a program running on a private stack
+gets the whole amount. Elsewhere, and for programs verified for the
+interpreter, the limit is 512 bytes; the interpreter itself never runs
+a frame larger than that. The verifier computes the actual amount of
+stack used and both interpreter and most JITed code consume necessary
+amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 19907612a51c..20f29ea01bda 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -28,7 +28,8 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
-#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
+/* tcc_ptr sits below $ra, $fp, $s0-$s5 and tcc, see the stack layout below */
+#define BPF_TAIL_CALL_CNT_PTR_FP_OFF	(-80)
 
 /* Memory size/value to protect private stack overflow/underflow */
 #define PRIV_STACK_GUARD_SZ	16
@@ -127,12 +128,15 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
  *                            |        (optional)       |
  * current $sp -------------> +-------------------------+
  *                                        low
+ *
+ * The area from $ra down to the optional $s6 slot is allocated on its own
+ * and addressed with small offsets from $sp or $fp. The BPF stack below
+ * it can be up to MAX_BPF_STACK_JIT bytes plus the may_goto slots, which
+ * do not fit the 12-bit immediate of addi.d, ld.d and st.d.
  */
-static void build_prologue(struct jit_ctx *ctx)
+static int jit_save_area_size(const struct jit_ctx *ctx)
 {
-	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 	const struct bpf_prog *prog = ctx->prog;
-	const bool is_main_prog = !bpf_is_subprog(prog);
 	/*
 	 * Exception boundary and callback programs must agree on the frame
 	 * layout: the callback reuses the boundary's frame to restore its
@@ -140,27 +144,25 @@ static void build_prologue(struct jit_ctx *ctx)
 	 */
 	const bool is_exception_prog = prog->aux->exception_boundary ||
 				       prog->aux->exception_cb;
-
-	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
-
-	/* To store ra, fp, s0, s1, s2, s3, s4, s5 */
-	stack_adjust += sizeof(long) * 8;
-
-	/* To store tcc and tcc_ptr */
-	stack_adjust += sizeof(long) * 2;
+	/* To store ra, fp, s0, s1, s2, s3, s4, s5, tcc and tcc_ptr */
+	int size = sizeof(long) * 10;
 
 	if (ctx->arena_vm_start || is_exception_prog)
-		stack_adjust += sizeof(long);
+		size += sizeof(long);
 
-	stack_adjust = round_up(stack_adjust, 16);
+	return round_up(size, 16);
+}
 
-	/*
-	 * When a private stack is used the BPF stack lives in a per-CPU
-	 * allocation rather than on the kernel stack, so only the non-BPF
-	 * part is reserved here.
-	 */
-	if (!ctx->priv_sp_used)
-		stack_adjust += bpf_stack_adjust;
+static void build_prologue(struct jit_ctx *ctx)
+{
+	int i, save_size, store_offset, bpf_stack_adjust;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
+
+	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
+	save_size = jit_save_area_size(ctx);
 
 	/*
 	 * Save the original return address to a temporary register to prevent
@@ -189,13 +191,13 @@ static void build_prologue(struct jit_ctx *ctx)
 		 * already saved them, so nothing is pushed here.
 		 */
 		move_reg(ctx, LOONGARCH_GPR_FP, LOONGARCH_GPR_A2);
-		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -stack_adjust);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -save_size);
 		goto setup_bpf_fp;
 	}
 
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
+	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -save_size);
 
-	store_offset = stack_adjust - sizeof(long);
+	store_offset = save_size - sizeof(long);
 	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, store_offset);
 
 	store_offset -= sizeof(long);
@@ -226,35 +228,57 @@ static void build_prologue(struct jit_ctx *ctx)
 		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
 	}
 
-	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
+	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, save_size);
 
 setup_bpf_fp:
+	ctx->stack_size = save_size;
+
 	if (ctx->priv_sp_used) {
-		/* Point the BPF frame pointer at the top of this CPU's private stack */
+		/*
+		 * Point the BPF frame pointer at the top of this CPU's private
+		 * stack. The BPF stack lives in that per-CPU allocation rather
+		 * than on the kernel stack, so nothing more is reserved here.
+		 */
 		void __percpu *priv_stack_ptr;
 
-		priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+		priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ +
+				 bpf_stack_adjust;
 		emit_percpu_ptr(ctx, regmap[BPF_REG_FP], priv_stack_ptr);
-		emit_insn(ctx, addid, regmap[BPF_REG_FP], regmap[BPF_REG_FP], bpf_stack_adjust);
 	} else if (bpf_stack_adjust) {
-		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
+		/* The BPF stack starts right below the save area */
+		move_reg(ctx, regmap[BPF_REG_FP], LOONGARCH_GPR_SP);
+		if (is_signed_imm12(-bpf_stack_adjust)) {
+			emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,
+				  -bpf_stack_adjust);
+		} else {
+			move_imm(ctx, LOONGARCH_GPR_T1, bpf_stack_adjust);
+			emit_insn(ctx, subd, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,
+				  LOONGARCH_GPR_T1);
+		}
+		ctx->stack_size += bpf_stack_adjust;
 	}
 
-	ctx->stack_size = stack_adjust;
-
 	if (ctx->arena_vm_start)
 		move_imm(ctx, REG_ARENA, ctx->arena_vm_start);
 }
 
 static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 {
-	int stack_adjust = ctx->stack_size;
+	int save_size = jit_save_area_size(ctx);
 	int load_offset;
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_exception_prog = prog->aux->exception_boundary ||
 				       prog->aux->exception_cb;
 
-	load_offset = stack_adjust - sizeof(long);
+	/*
+	 * Release the BPF stack, if it is on the kernel stack, by deriving
+	 * $sp from $fp: unlike its size, the offset of the save area from
+	 * $fp always fits an immediate.
+	 */
+	if (ctx->stack_size != save_size)
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -save_size);
+
+	load_offset = save_size - sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
 
 	load_offset -= sizeof(long);
@@ -290,7 +314,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
 
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
+	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, save_size);
 
 	if (!is_tail_call) {
 		/* Set return value */
@@ -325,7 +349,6 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off, jmp_offset;
-	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -353,7 +376,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *      goto out;
 	 */
-	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, BPF_TAIL_CALL_CNT_PTR_FP_OFF);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
 	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
@@ -741,7 +764,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	u64 func_addr;
 	bool func_addr_fixed, sign_extend;
 	int i = insn - ctx->prog->insnsi;
-	int ret, jmp_offset, tcc_ptr_off;
+	int ret, jmp_offset;
 	const u8 code = insn->code;
 	const u8 cond = BPF_OP(code);
 	const u8 t1 = LOONGARCH_GPR_T1;
@@ -1274,8 +1297,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
-			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
-			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP,
+				  BPF_TAIL_CALL_CNT_PTR_FP_OFF);
 			move_addr(ctx, t1, func_addr);
 			emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 			break;
@@ -1312,8 +1335,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* indirect call to a bpf subprog via the address in dst */
 	case BPF_JMP | BPF_CALL | BPF_X:
-		tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
-		emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+		emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP,
+			  BPF_TAIL_CALL_CNT_PTR_FP_OFF);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, dst, 0);
 		break;
 
@@ -2690,6 +2713,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_large_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
-- 
2.53.0

