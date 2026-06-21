Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DC36AB72
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053012; cv=none; b=cvvQ/j6BcVApLV+phe5rPr7uy3bH+pAJ6myL67YOmfUXIZCiSRxkqwfnpSygSq57PmMrhajF3fj6oCzmLc7XLfcxe/6vye63IG9xWxcwfpR81P9H+MZwHt5vNN8hYXIcYQgMku6KRK3XMpmA2Gh76KYxw5U0y9HSrqGwXvLg6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053012; c=relaxed/simple;
	bh=ZVaVBI340oxCiGaZZFiM2DqiCXQnhdBkL1nO/uBy1OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGrq5ibBqImwugIVDwknjtZacWN9o6Htq5J9HMFKjkaTVFbHJbdCkicZ6nQvAK2/Wu09YpSrhoi/8UNuP5Qf3ohu8fGgPrixC287HUpiTCw6DmqNR28NxDP6IqpJlRH7xbKIY/gw4FMeNlspm3JFFC+D26EZnIEXjyrGoRyZysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0egBpVl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0egBpVl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8456005a6c4so813199b3a.2
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053011; x=1782657811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L1IGDwSo3IngnCe3HqBNRffP7FgjigbpkTmExCV6uk=;
        b=O0egBpVleIIIlh2TRLXfHUScUjvni/D6wmk/ZGpPsrPmZBmdaA4E4qE7eLf1acPVM7
         se1LKY/c1PF612pZ6iDBCpthDAu13PZDJdI8qwzW/uMszKLpv8+n0qH1ZW+SinBIiyrh
         /o5pjXF/emWIURgYNHlA+yXwF4RAtlEZNrah/SwbwIjxjGJQ+0f6P5jKZPMw2qjN15QK
         8DcIjbOdm8ADgxlEBxOYl0nF5OG8QpeDOoYPkQzFcXIafZbH3AnoHfElKVKiC93fTcOB
         9BVaTiSXirS9CZfA0KMPrrH7GXYIE0QUMPiU8Lh6VzVMnC1JOGBKEuSSkRY4ZXWdA1df
         pvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053011; x=1782657811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L1IGDwSo3IngnCe3HqBNRffP7FgjigbpkTmExCV6uk=;
        b=JNoMNV8574qqXPxIJnehBzFRfO8Jqx7vnr7Q5WSg2Q/+Wy5zURRVhjWNlag9eM9GOS
         5E7yj0RLald3jJckcihCKgEd91mxwE0kvxO8qJsoSpIhPGY/OMGibhyDbcMYlls5y8Ye
         v0Q2eNorhV8y1QmaxfQT1iLbJdI2z75LR34APnDRDydxG8QYu0B3dJPgzVix6N9ywbUB
         nxhwiVFVJNhfVJZKHQ2lYzesQFrp2ATUVGjhWNSaRIdA4OLKKhXoITxjwZWM3shuA7rG
         6mPBK8KLXXhq1d3IpkmJF8CZYrmCyJgAU3+EUunQ0seADAuvU1pbS/KSSzPlm1BJ2mYW
         iK5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp0lWagzYZV0oXzvWuYuvQigrgOrhr1Av1EFD0u1Ps6B4oTqugCKLk7D8oxWHLJpz4QoKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXlFXSQKT+DaK06lriefoQH8WtsKovRn+pUiYW3CL/lxgTqIP
	LdupQyjvGZYBAOc+p+DmeEkov8RfjCjyxyV/jgCwG4jKVgfBqnxmaial
X-Gm-Gg: AfdE7cm1clPCWfYvnCn0Lhg0Hai4Ze6VVGkS9q/ExAyVzfFS7S7A8mtcbJN8T858Sog
	qlTMCc8KbjJNtEM5cuf2iDHUjY7sKRaWel/z9hTSqikel/gUT5Y9DJOzp2dwYCL2ssNy7jJjAOD
	2KOuAIazGuqSDbV6vjzGXSIygxH1HS8N+u67P3mRBs+MSewAmZHAHB2l2+krsKudHjB6Nyxj8oo
	S5YMsyZFxlquMnzBHPy5kSh+XZihBVeQ/VPpe3NFs3TNAw0YzipflQi8ht8zlOrxhtAKEnu/g14
	HWipoUCtkAI/gc2GTx2NCROcGxD731ruBUFjCp3DqkUhilRHm+tvQN2NcH1jcRIeY5iePrPRwsY
	PDKfWrKaqleP5UVCIs9j2Mm85fEOQ8ipy6S9ll34dfLIZj6hE6rGxgaOzDfnAOQjZWgeCpzkAFt
	211O9zFTpy/rTCVwBJbh/87neqj45y
X-Received: by 2002:a05:6a00:b42:b0:845:313c:d6c2 with SMTP id d2e1a72fcca58-8455089ecc1mr11704474b3a.31.1782053010671;
        Sun, 21 Jun 2026 07:43:30 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7687csm4963254b3a.35.2026.06.21.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:43:30 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
Date: Sun, 21 Jun 2026 20:12:58 +0530
Message-ID: <20260621144259.288135-3-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621144259.288135-1-varunrmallya@gmail.com>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the JIT support required for BPF exceptions (bpf_throw()) on riscv64.

Two kinds of program need special prologue/epilogue handling:

  - A program acting as an exception boundary must save the full set of
    riscv callee-saved GP registers (ra, s0-s11), not just the ones it
    happens to clobber, so that the exception callback can restore the
    state that was live at the boundary. ra and fp are stored first so
    the saved ra/fp pair forms a valid stackframe record for the
    unwinder.

  - The exception callback (exception_cb) does not allocate its own
    frame. It reuses the boundary program's frame, whose frame pointer
    is passed in a2, by setting SP = FP - stack_adjust. This lines the
    epilogue's loads up with the registers the boundary saved, so both
    paths restore the same order.

Wire up bpf_jit_support to be true only when CONFIG_FRAME_POINTER is
enabled.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c03c1de16b79..eafac0655dab 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -56,6 +56,30 @@ static const int pt_regmap[] = {
 	[RV_REG_T0] = offsetof(struct pt_regs, t0),
 };
 
+/*
+ * Full set of RISC-V callee-saved GP registers (ra, s0-s11) saved by a program
+ * acting as an exception boundary, in the order they are stored on the stack.
+ * RA and FP come first so the saved ra/fp pair forms a valid stackframe record
+ * at [FP-8]/[FP-16] for the unwinder. The exception callback reuses the
+ * boundary program's frame and restores this same set in its epilogue, so both
+ * paths must agree on the contents and ordering of this list.
+ */
+static const int rv_exception_csave_regs[] = {
+	RV_REG_RA,
+	RV_REG_FP,
+	RV_REG_S1,
+	RV_REG_S2,
+	RV_REG_S3,
+	RV_REG_S4,
+	RV_REG_S5,
+	RV_REG_S6,
+	RV_REG_S7,
+	RV_REG_S8,
+	RV_REG_S9,
+	RV_REG_S10,
+	RV_REG_S11,
+};
+
 enum {
 	RV_CTX_F_SEEN_TAIL_CALL =	0,
 	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
@@ -231,6 +255,22 @@ static void emit_imm(u8 rd, s64 val, struct rv_jit_context *ctx)
 static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 {
 	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
+	struct bpf_prog_aux *aux = ctx->prog->aux;
+	int i;
+
+	if (aux->exception_boundary || aux->exception_cb) {
+		/*
+		 * An exception boundary saved the full callee-saved register
+		 * set and the exception callback restores it from the boundary's
+		 * frame. Both restore the same fixed set, in the same order it
+		 * was stored by bpf_jit_build_prologue().
+		 */
+		for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
+			emit_ld(rv_exception_csave_regs[i], store_offset, RV_REG_SP, ctx);
+			store_offset -= 8;
+		}
+		goto epilogue_tail;
+	}
 
 	if (seen_reg(RV_REG_RA, ctx)) {
 		emit_ld(RV_REG_RA, store_offset, RV_REG_SP, ctx);
@@ -267,6 +307,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 		store_offset -= 8;
 	}
 
+epilogue_tail:
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
@@ -2002,11 +2043,61 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
+	struct bpf_prog_aux *aux = ctx->prog->aux;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
 	if (bpf_stack_adjust)
 		mark_fp(ctx);
 
+	if (aux->exception_boundary || aux->exception_cb) {
+		/*
+		 * A program acting as an exception boundary saves the full set
+		 * of riscv callee saved registers (ra, s0-s11).
+		 */
+		stack_adjust = round_up(ARRAY_SIZE(rv_exception_csave_regs) * 8,
+					STACK_ALIGN);
+		stack_adjust += bpf_stack_adjust;
+		store_offset = stack_adjust - 8;
+
+		/* emit kcfi type preamble immediately before the first insn */
+		emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
+
+		/* nops reserved for auipc+jalr pair */
+		for (i = 0; i < RV_FENTRY_NINSNS; i++)
+			emit(rv_nop(), ctx);
+
+		/* First instruction is always setting the tail-call-counter
+		 * (TCC) register. This instruction is skipped for tail calls.
+		 * Force using a 4-byte (non-compressed) instruction.
+		 */
+		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
+
+		if (!aux->exception_cb && aux->exception_boundary) {
+			/*
+			 * Boundary program: allocate the frame and save the
+			 * full callee-saved set, capturing the caller's values.
+			 */
+			emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
+			for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
+				emit_sd(RV_REG_SP, store_offset,
+					rv_exception_csave_regs[i], ctx);
+				store_offset -= 8;
+			}
+			emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
+		} else {
+			/*
+			 * Exception callback, reuse the boundary program's
+			 * frame, whose frame pointer is passed in a2. Setting
+			 * SP = FP - stack_adjust lines the epilogue's loads up
+			 * with the registers the boundary saved.
+			 */
+			emit_mv(RV_REG_FP, RV_REG_A2, ctx);
+			emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
+		}
+
+		goto tail_setup;
+	}
+
 	if (seen_reg(RV_REG_RA, ctx))
 		stack_adjust += 8;
 	stack_adjust += 8; /* RV_REG_FP */
@@ -2082,6 +2173,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
+tail_setup:
 	if (bpf_stack_adjust)
 		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
 
@@ -2157,3 +2249,13 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
+	/*
+	 * bpf_throw() unwinds by walking the frame-pointer chain from inside
+	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
+	 * exceptions require the frame-pointer unwinder to be enabled.
+	 */
+	return IS_ENABLED(CONFIG_FRAME_POINTER);
+}
-- 
2.54.0

