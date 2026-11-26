Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664463;
	b=3US0F+o+mH7nItVXeESERiQv9giohIOFvPoHJlSSvjRAisnH3+jkwR6v5ajq6oSwgvzt
	 GC4ACV4Xwf9MneMUdZ1k05EJ+AJxzB8prIF1FaokeIL6wWoeli8a0i0kavYaYNPsClVW3
	 RdlJeWIllmT/QdrG2IGbHMQRSVxRO8MEgtOkc7ldBPeV8M38WF9Vx2+RuP/3b3XV7Clo+
	 zHDrpFtKRa8X3LiO7c+WjzK0hLVp4TvGX3kB8qBSK2/OaeYFO52BYrmUUMgC6+opiv2sJ
	 7cm4dsfH4zN1JB2x+IIo9zab0CHqb4LZ3HUK6601YqVSadRscXo5bq9Vq+ZWb5NWAJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664463;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UvABF4Vmpbt0VgP3jmnGLg/wsjwcbKnkPtDigc04e44=;
	b=G1rq0tgTgUeRqEiXGLNhTHx3ZGfyF6S54oNRZ87Z8gpdiFYBYm++BFUPirCPhV4hfndi
	 Rot7rfIy23tooqE3Ru+Jlp38+jrMqM28isiIdtv4JIIV6k2wGZ36wEd1Ud+3dMMsmyE2w
	 eTg7mQx9lHQV4YHLF7GUqFSs6uiSt8C37WXh2BkNiai/IIGegUyaB4u6QNS2qbec6sxRF
	 E0v2AydiCVMtl3fDysn3amCdZ47Ex4hYxjQveMN0If48SM2fLT1MNV+80884IseWmMfCr
	 mMSbJqbCFPxonXTNauRn0xFQPNUcSyVAlqOqUX4Egwz2Qx9e+Fpsq7CM/anzN+cTzng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HP1Hn27U;
	arc=none smtp.remote-ip=95.215.58.222
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C364606A332
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C364606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HP1Hn27U
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B5Xq7hAtzi7nCHHx/u6hYsscW66m+IcqB/D+SXuKXQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664461; v=1; x=1796269261;
 b=HP1Hn27Ue2UknlORWZjxqDvjVoTJzaEILIeWIF+QmWaFN2pB8C4hcPxAYEeZE9xMVuhGGHrY
 Kea21FruMWlm+BD3nbVXf3WSh/vYE8sVZ1Esd15bMwVe9K+OcpF1njzMbUMeAjyrzVX8Lns9lQt
 FtKXG9QDqyufNHUDdXVS2BlA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 923d574f246e9554;
	Thu, 26 Nov 2026 03:41:00 +0000
X-Mizu-Trace-ID: 923d574f246e9554
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] LoongArch: BPF: Add support for exceptions
Date: Thu, 26 Nov 2026 12:40:44 +0900
Message-ID: <20261126034048.7370-3-dongtai.guo@linux.dev>
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

In order to implement JIT support for BPF exceptions, bpf_throw() needs
to find the frame of the exception boundary program by walking the
stack, and then call the exception callback with the stack pointer and
frame pointer of that frame.

The stack walking is done by arch_bpf_stack_walk(), which was added by
commit e7103e5e3bde ("LoongArch: BPF: Add arch_bpf_stack_walk()
implementation") and only works with the ORC unwinder, so make
bpf_jit_supports_exceptions() return true only if CONFIG_UNWINDER_ORC
is enabled.

The exception callback does not set up a frame of its own: it takes the
frame pointer of the boundary program from its third argument (a2) and
reuses that frame, so its epilogue restores the callee-saved registers
of the boundary program and returns to the caller of the boundary
program. In order to keep the same stack layout for the boundary program
and the callback, always reserve the $s6 slot for them, just like for
arena programs.

This is similar to commit 22fc0e80aeb5 ("bpf, arm64: support
exceptions").

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 45 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3ff15b64925f..19907612a51c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -120,8 +120,8 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
  *                            +-------------------------+
  *                            |           tcc_ptr       |
  *                            +-------------------------+
- *                            |           arena         |
- *                            |         (optional)      |
+ *                            |   $s6 (arena/exception) |
+ *                            |        (optional)       |
  *                            +-------------------------+ <--BPF_REG_FP
  *                            |  prog->aux->stack_depth |
  *                            |        (optional)       |
@@ -133,6 +133,13 @@ static void build_prologue(struct jit_ctx *ctx)
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
+	/*
+	 * Exception boundary and callback programs must agree on the frame
+	 * layout: the callback reuses the boundary's frame to restore its
+	 * callee-saved registers, so the s6 slot is always reserved for them.
+	 */
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 
@@ -142,7 +149,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	/* To store tcc and tcc_ptr */
 	stack_adjust += sizeof(long) * 2;
 
-	if (ctx->arena_vm_start)
+	if (ctx->arena_vm_start || is_exception_prog)
 		stack_adjust += sizeof(long);
 
 	stack_adjust = round_up(stack_adjust, 16);
@@ -173,6 +180,19 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (is_main_prog)
 		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
 
+	if (prog->aux->exception_cb) {
+		/*
+		 * The exception callback receives the boundary program's frame
+		 * pointer as its third argument (a2). Reuse that frame so the
+		 * (FP-anchored) epilogue restores the boundary's callee-saved
+		 * registers and returns to the boundary's caller. The boundary
+		 * already saved them, so nothing is pushed here.
+		 */
+		move_reg(ctx, LOONGARCH_GPR_FP, LOONGARCH_GPR_A2);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_FP, -stack_adjust);
+		goto setup_bpf_fp;
+	}
+
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
 
 	store_offset = stack_adjust - sizeof(long);
@@ -201,13 +221,14 @@ static void build_prologue(struct jit_ctx *ctx)
 
 	prepare_bpf_tail_call_cnt(ctx, &store_offset);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		store_offset -= sizeof(long);
 		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
 	}
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
+setup_bpf_fp:
 	if (ctx->priv_sp_used) {
 		/* Point the BPF frame pointer at the top of this CPU's private stack */
 		void __percpu *priv_stack_ptr;
@@ -229,6 +250,9 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 {
 	int stack_adjust = ctx->stack_size;
 	int load_offset;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_exception_prog = prog->aux->exception_boundary ||
+				       prog->aux->exception_cb;
 
 	load_offset = stack_adjust - sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
@@ -261,7 +285,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	/* Skip the unused local 'tcc_ptr' slot to align with arena */
 	load_offset -= sizeof(long);
 
-	if (ctx->arena_vm_start) {
+	if (ctx->arena_vm_start || is_exception_prog) {
 		load_offset -= sizeof(long);
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
@@ -2649,6 +2673,17 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_exceptions(void)
+{
+	/*
+	 * Walking kernel and BPF frames from within bpf_throw() relies on
+	 * arch_bpf_stack_walk(), which is only implemented for the ORC
+	 * unwinder. ORC reports each frame's stack and frame pointer and
+	 * walks JITed BPF frames via its frame-pointer fallback.
+	 */
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.53.0

