Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519325;
	b=1vCmujYEIUTR1jaJ4WKZLVTsdJRvhK+KvvutDKP6ANdHXBMJJhaghceuJTBxhLHpunT2
	 zxIAwtNwYmzp8Vea8S2uXfPcLgwUJZQwoX1jp3AgE7DvYlsQsB+SjEKPIyiSTaFgR2lj7
	 E3aR1RQFLjU4fxqPqA2vmxQxwYWOsYp4sTtMFE+Qk3GxWeIspECthgJ/+8JP5Rh6AwTEA
	 i460T+An6L3qI7j6eh5/0yHWQ3LO1lwOef3Zf/xHJUO2pMJ+w1Tgd/EL4NfBwNjn8c77X
	 kcTSC0vPxq204NlCHTUBXMfIq1mD0/LkqG+Np6wjNIEDvqmDtA9g4iW/QvPdJcz1Aqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=skK4m/Gh/OImegZzvtg9QThTgwulrfLmJFpyVkFA0Gc=;
	b=EPanILGdss0Vx+EUVQiMrsz+OEwHlDegXs1u50fQ/DLxQkHQWsGRyeTratsQ0OHys6GA
	 ZTv1qscpFFD/LriovYEN7KmJ+sLDmhuEqg3Cpfc4t6l4ON64nvMMBF7hTUy6aaRXLMhiA
	 AsLZ4nPp8gQYk50XXTLwBhKMHzANbtc7AXbnpfGLo3/uRuIHH0HLDLqGP6HSGgOPDKt6Q
	 kWgqitt1gNM2VQE7CDAK5Eu/+1l1YoXs+oNKL4oFi4hqBQNaAqd3X8bEzl5RVH0nI9BsL
	 KJ9d8nCYHwaFAQr9ZoNMQAvmDJx9/Cwh/kM4YhqTwWsQwHh+37X/qJXYwDmwsygPifQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rnxaVQzi;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C8606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 537C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rnxaVQzi
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so9300435e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519323; x=1793124123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skK4m/Gh/OImegZzvtg9QThTgwulrfLmJFpyVkFA0Gc=;
        b=rnxaVQzi0f6CFYfj3+cbb9JXwKgHK8FPWjFkXdqbXcQSoQQ1EMqNA57V3yyQy/VGXo
         jilfZZOiBVU+Z3g5oDaFb/Gs+yx3Jszt48fyevPhsH8yS4kQgUEZWO9SCvxUtmn+K5FX
         sTgojEBnO4XyHi6CUsUN2dqybe2HW2LV8UjhlwrVaR62UraT5g04BeHJCWdYyDZEBgwH
         9hiAZv9rWX60+FNbcA0Oe75+cRS0BML+jMSBgu7wxZHPLKSomDtcNGTvFnmnOGCnxAqb
         88Db45R8RrR1PAXv25IQ+1oSx51wCuVTK0bk+JYAJA8FXbHqjnxIi2ZOeIAkCu3CG/e6
         OLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519323; x=1793124123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=skK4m/Gh/OImegZzvtg9QThTgwulrfLmJFpyVkFA0Gc=;
        b=bQjV/jxmS+OBwe0PFJ81cNMrMg27jdWlS2wDlbFzCb7cviShnyoQryfF73VUwZg7Or
         /IOeWrwpZ+dL3laJzZPWO1Em7jZUxD7+nU4DXCU4z3377J0qzg705KBeCtXVA6gZzEyP
         LngZJ0LhM+U7gc259j3anKzVWFqptTuQx+rFkGxa6PUokXljpeSW441BQmDHfwkovXbM
         R0HgF+LAGXzYn6gsuWTzEvnzvV8/QXCY9RfjIC4FkykdHNoZi7P+Kf+oH+0/a3uBa/05
         4u5kZZp9TnCwD4N5Kif0WOBDu5gODvfxdWpgZnCqCYxv4PI3zuDREXkXuW29ER9APEEX
         lhPw==
X-Gm-Message-State: AFq9FYKRbNrwgnmHlUYjjS+4IXWRpPhxHmgn6TFtXsMaVEqllgYkk9Ow
	Y+uhUmIdKc9uUFSDKtMAWSoUlP9i7knWfE+iI64ZlLr/XmB7BeXTNhof+88PBdpe
X-Gm-Gg: AYBFou1e87BazYEHJuWONC/KB5hChpRbGHw+mmwt/qHjatM5iEqN7yVGKKnCnwx+0Qd
	ACwogCZ64HaG54bDPVqXzXV/nQSCwJ4hy5kNG6t7MTpDTLsH+AFyzFwr0Ylg9jL+Wb3ny+D9VLf
	fdMcjkSdve1uCppMQB+9oobkkS3lGVjtucD4/rfmGQpuW1Ll+9a369Qi6GNanS1bDiGmTGifypF
	D4nyCehZasgbz2vode0aCel/Ut4/x+yUmY69LfHhldPim8ES/pkDlD2JxGLKuJRMKzWq7rr/Dhp
	Bdi81mFKbMb07qO6wftsyegHC235KThR6sgBaGVdWM8jC7wImJNQ9ugxXjC0M2KtfzxW7WnbymE
	44qJDNjqNPW3ETzC7+K/MclO/UFRsuZkBI0yE1+hHbNif1QIBl6iMyEXokqqhZlYP9KOWefJpyz
	WCPaiUN39y/J+Hqb8g+WBlFeWvf1JOgAYBWzb1O1JCNfUU885WpR1ZZ+eqGJa05NfJoItpWRHPo
	R6V/7CZ1joRZtz+xMt8dMxDbx5GrD08YlDRyy0azcxmOkOEXXt1QFVs32HRqRD+FR44HDDAyD2e
	7PFSa+gk4y1sbxtU1kBMKhMM2p/Q9BUhWuxx0PMkCuSZJ06m
X-Received: by 2002:a05:600c:c090:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4a1d75af24bmr207200645e9.3.1792519322339;
        Tue, 20 Oct 2026 11:02:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d324f8sm82705555e9.6.2026.10.20.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:02:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 6/6] bpf: Restore callee-saved registers from the frames being unwound
Date: Tue, 20 Oct 2026 20:01:42 +0200
Message-ID: <20261020180147.1769873-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020180147.1769873-1-memxor@gmail.com>
References: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28044; i=memxor@gmail.com; h=from:subject; bh=pz51I1ihvXywdbyV+gj/zEo4rLjIrKl0lAYkB0kgn7s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6ikfP2nLuCy3ftyz2pUVa3uPjVwOmxv72tguS9Jm0c kezyCzFjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk5WuGv3LhYn/WJ7w7bFp2 kmvCjhi+3jl7pgqcsTrx4xnvZvHSnY8ZGf4FCv4r8/l49/0lz8xtAnO5lPfVxZ/MOTbn9Zrbzy5 yTmcAAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program that may throw is an exception boundary: its prologue pushes
every callee-saved register the JIT could clobber, five on x86-64 and
ten on arm64, whether the program uses them or not, and the exception
callback pops them all from the boundary frame before it runs. That is
what restores the registers a discarded frame clobbered, since the
epilogues of the frames between the throw site and the boundary never
run. It costs every invocation of such a program the pushes and pops,
18 bytes of code on x86-64 for a program that uses none of them, and
80 bytes of stack on arm64.

The unwinder can do that work instead, on the throw path only. Each
JITed function already records where its prologue saved the caller's
R6..R9; extend the record to every other callee-saved register, r12 on
x86-64, which holds the arena base, and x23..x28 on arm64: x25..x28 are
the BPF frame pointer, the tail call count pointer, the private stack
pointer and the arena base, and x23 and x24, which no JITed code
touches, may still be in use by the C code of the unwinder when it
enters the callback, whose epilogue never runs. The native entries
capture the extra registers along with R6..R9, before any C code runs.
Walking from the throw site outwards, the unwinder starts from the
values the site had and takes, in each frame, the values that frame
saved of its caller's; past the main frame, they are the registers the
program's caller expects back. The exception callback receives them as
its fourth argument and loads them before it reuses the main frame, in
place of popping the boundary's saves, and builds the rest of its frame
like any function.

The boundary prologue is then an ordinary prologue, and the x86-64
stack pointer adjustment the callback needed to find the boundary's
saves goes away with the pops.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c                 | 126 ++++++++----------
 arch/arm64/net/bpf_throw.S                    |  10 +-
 arch/x86/net/bpf_jit_comp.c                   | 120 +++++++----------
 arch/x86/net/bpf_throw.S                      |   6 +-
 include/linux/bpf.h                           |  16 ++-
 include/linux/bpf_throw.h                     |  24 +++-
 kernel/bpf/fixups.c                           |   1 -
 kernel/bpf/helpers.c                          |  33 ++++-
 .../bpf/progs/verifier_private_stack.c        |  12 +-
 9 files changed, 174 insertions(+), 174 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cc0ee9b3726b..1afcf10c49ba 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -433,24 +433,29 @@ static int callee_reg_slot_off(int idx)
 }
 
 /*
- * Record where push_callee_regs() saved the caller's R6..R9, relative to the frame
- * pointer that arch_bpf_stack_walk() reports for this frame, for the exception unwinder.
- * An exception boundary pushes x19..x28 in order, so R6..R9 take the first four slots.
+ * Record where the prologue saved the caller's callee-saved registers, relative to
+ * the frame pointer that arch_bpf_stack_walk() reports for this frame, for the
+ * exception unwinder. The registers are x19..x28 in the order of struct
+ * bpf_throw_regs, R6..R9 first: the tail call count pointer is saved with the frame
+ * record, the others where push_callee_regs() put them, and x23 and x24 nowhere,
+ * since JITed code leaves them alone.
  */
 static void record_callee_reg_off(struct jit_ctx *ctx)
 {
 	struct bpf_prog_aux *aux = ctx->prog->aux;
 	int i, j;
 
-	if (aux->exception_boundary) {
-		for (i = 0; i < 4; i++)
-			aux->callee_reg_off[i] = callee_reg_slot_off(i);
-		return;
-	}
-	for (i = 0; i < 4; i++) {
+	BUILD_BUG_ON(BPF_THROW_NR_CALLEE_SAVED != 10);
+	for (i = 0; i < BPF_THROW_NR_CALLEE_SAVED; i++) {
+		u8 reg = A64_R(19 + i);
+
 		aux->callee_reg_off[i] = 0;
+		if (reg == bpf2a64[TCCNT_PTR]) {
+			aux->callee_reg_off[i] = -8;
+			continue;
+		}
 		for (j = 0; j < ctx->nr_used_callee_reg; j++) {
-			if (ctx->used_callee_reg[j] != bpf2a64[BPF_REG_6 + i])
+			if (ctx->used_callee_reg[j] != reg)
 				continue;
 			aux->callee_reg_off[i] = callee_reg_slot_off(j);
 			break;
@@ -458,35 +463,25 @@ static void record_callee_reg_off(struct jit_ctx *ctx)
 	}
 }
 
-/* Save callee-saved registers */
+/*
+ * Save the callee-saved registers this function uses. An exception boundary
+ * saves nothing more: the unwinder recovers the registers of the frames it
+ * discards and hands them to the exception callback.
+ */
 static void push_callee_regs(struct jit_ctx *ctx)
 {
 	int reg1, reg2, i;
 
-	/*
-	 * Program acting as exception boundary should save all ARM64
-	 * Callee-saved registers as the exception callback needs to recover
-	 * all ARM64 Callee-saved registers in its epilogue.
-	 */
-	if (ctx->prog->aux->exception_boundary) {
-		emit(A64_PUSH(A64_R(19), A64_R(20), A64_SP), ctx);
-		emit(A64_PUSH(A64_R(21), A64_R(22), A64_SP), ctx);
-		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
-		emit(A64_PUSH(A64_R(25), A64_R(26), A64_SP), ctx);
-		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
-		ctx->fp_used = true;
-	} else {
-		find_used_callee_regs(ctx);
-		for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {
-			reg1 = ctx->used_callee_reg[i];
-			reg2 = ctx->used_callee_reg[i + 1];
-			emit(A64_PUSH(reg1, reg2, A64_SP), ctx);
-		}
-		if (i < ctx->nr_used_callee_reg) {
-			reg1 = ctx->used_callee_reg[i];
-			/* keep SP 16-byte aligned */
-			emit(A64_PUSH(reg1, A64_ZR, A64_SP), ctx);
-		}
+	find_used_callee_regs(ctx);
+	for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {
+		reg1 = ctx->used_callee_reg[i];
+		reg2 = ctx->used_callee_reg[i + 1];
+		emit(A64_PUSH(reg1, reg2, A64_SP), ctx);
+	}
+	if (i < ctx->nr_used_callee_reg) {
+		reg1 = ctx->used_callee_reg[i];
+		/* keep SP 16-byte aligned */
+		emit(A64_PUSH(reg1, A64_ZR, A64_SP), ctx);
 	}
 	record_callee_reg_off(ctx);
 }
@@ -494,34 +489,19 @@ static void push_callee_regs(struct jit_ctx *ctx)
 /* Restore callee-saved registers */
 static void pop_callee_regs(struct jit_ctx *ctx)
 {
-	struct bpf_prog_aux *aux = ctx->prog->aux;
 	int reg1, reg2, i;
 
-	/*
-	 * Program acting as exception boundary pushes R23 and R24 in addition
-	 * to BPF callee-saved registers. Exception callback uses the boundary
-	 * program's stack frame, so recover these extra registers in the above
-	 * two cases.
-	 */
-	if (aux->exception_boundary || aux->exception_cb) {
-		emit(A64_POP(A64_R(27), A64_R(28), A64_SP), ctx);
-		emit(A64_POP(A64_R(25), A64_R(26), A64_SP), ctx);
-		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
-		emit(A64_POP(A64_R(21), A64_R(22), A64_SP), ctx);
-		emit(A64_POP(A64_R(19), A64_R(20), A64_SP), ctx);
-	} else {
-		i = ctx->nr_used_callee_reg - 1;
-		if (ctx->nr_used_callee_reg % 2 != 0) {
-			reg1 = ctx->used_callee_reg[i];
-			emit(A64_POP(reg1, A64_ZR, A64_SP), ctx);
-			i--;
-		}
-		while (i > 0) {
-			reg1 = ctx->used_callee_reg[i - 1];
-			reg2 = ctx->used_callee_reg[i];
-			emit(A64_POP(reg1, reg2, A64_SP), ctx);
-			i -= 2;
-		}
+	i = ctx->nr_used_callee_reg - 1;
+	if (ctx->nr_used_callee_reg % 2 != 0) {
+		reg1 = ctx->used_callee_reg[i];
+		emit(A64_POP(reg1, A64_ZR, A64_SP), ctx);
+		i--;
+	}
+	while (i > 0) {
+		reg1 = ctx->used_callee_reg[i - 1];
+		reg2 = ctx->used_callee_reg[i];
+		emit(A64_POP(reg1, reg2, A64_SP), ctx);
+		i -= 2;
 	}
 }
 
@@ -622,24 +602,22 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 			/* BTI landing pad for the tail call, done with a BR */
 			emit_bti(A64_BTI_J, ctx);
 		}
-		push_callee_regs(ctx);
 	} else {
 		/*
-		 * Exception callback receives FP of Main Program as third
-		 * parameter
+		 * The exception callback receives the main program's frame
+		 * pointer as its third parameter and, as its fourth, the
+		 * callee-saved registers x19..x28 the unwinder recovered from
+		 * the frames it discarded: the values the main program's caller
+		 * expects back. Load them, then build the rest of the frame
+		 * below the main program's frame record like any function.
 		 */
+		for (int i = 0; i < BPF_THROW_NR_CALLEE_SAVED; i++)
+			emit(A64_LDR64I(A64_R(19 + i), A64_R(3), 8 * i), ctx);
 		emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
-		/*
-		 * Main Program already pushed the frame record and the
-		 * callee-saved registers. The exception callback will not push
-		 * anything and re-use the main program's stack.
-		 *
-		 * 12 registers are on the stack
-		 */
-		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
-		/* The callback may use its own BPF stack, set up fp for it. */
-		ctx->fp_used = true;
+		emit(A64_MOV(1, A64_SP, A64_FP), ctx);
+		prepare_bpf_tail_call_cnt(ctx);
 	}
+	push_callee_regs(ctx);
 
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
diff --git a/arch/arm64/net/bpf_throw.S b/arch/arm64/net/bpf_throw.S
index aac1c5e967e1..7010ba2388cd 100644
--- a/arch/arm64/net/bpf_throw.S
+++ b/arch/arm64/net/bpf_throw.S
@@ -8,15 +8,19 @@
  * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
  * bpf_throw() here, so the BPF register file of the throw site is still intact
  * on entry and x30 is the return address into the program. Push a frame record
- * whose link register is that address and save R6-R9, x19-x22, below it as a
- * struct bpf_throw_regs: saved[i] sits at [sp + 16 + 8 * i]. Then hand it to
- * bpf_throw_unwind(), which never returns.
+ * whose link register is that address and save R6-R9, x19-x22, and the extra
+ * callee-saved registers x23-x28 below it as a struct bpf_throw_regs: saved[i]
+ * sits at [sp + 16 + 8 * i]. Then hand it to bpf_throw_unwind(), which never
+ * returns.
  */
 SYM_FUNC_START(bpf_throw_entry)
 	stp	x29, x30, [sp, #-(16 + BPF_THROW_REGS_SIZE)]!
 	mov	x29, sp
 	stp	x19, x20, [sp, #16]
 	stp	x21, x22, [sp, #32]
+	stp	x23, x24, [sp, #48]
+	stp	x25, x26, [sp, #64]
+	stp	x27, x28, [sp, #80]
 
 	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
 	mov	x1, x0
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1a865313d09e..be9bfb9c8336 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -34,7 +34,6 @@ void __asan_load8(void *p);
 void __asan_store8(void *p);
 #endif
 
-static bool all_callee_regs_used[4] = {true, true, true, true};
 
 static void *trampoline_size_image;
 
@@ -428,13 +427,19 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 }
 
 /*
- * Record where push_callee_regs() saved the caller's R6..R9 relative to rbp, for the
- * exception unwinder. @off is the offset of rsp from rbp right before the first push.
+ * Record where the prologue saved the caller's callee-saved registers relative to rbp,
+ * for the exception unwinder: r12 when @r12 was pushed, then rbx, r13, r14 and r15
+ * as push_callee_regs() pushed them. @off is the offset of rsp from rbp right before
+ * the first push.
  */
-static void record_callee_reg_off(struct bpf_prog *prog, s32 off, bool *callee_regs_used)
+static void record_callee_reg_off(struct bpf_prog *prog, s32 off, bool *callee_regs_used,
+				  bool r12)
 {
 	int i;
 
+	prog->aux->callee_reg_off[4] = r12 ? off - 8 : 0;
+	if (r12)
+		off -= 8;
 	for (i = 0; i < 4; i++) {
 		if (!callee_regs_used[i]) {
 			prog->aux->callee_reg_off[i] = 0;
@@ -614,18 +619,21 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 			/* Keep the same instruction layout. */
 			emit_nops(&prog, 3);     /* nop3 */
 	}
-	/* Exception callback receives FP as third parameter */
+	/*
+	 * The exception callback receives the main program's frame pointer as
+	 * its third parameter and, as its fourth, the callee-saved registers
+	 * the unwinder recovered from the frames it discarded, rbx, r13, r14,
+	 * r15 and r12 in that order: the values the main program's caller
+	 * expects back. Load them, then reuse the main program's frame.
+	 */
 	if (is_exception_cb) {
-		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
-		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
-		/* The main frame must have exception_boundary as true, so we
-		 * first restore those callee-saved regs from stack, before
-		 * reusing the stack frame.
-		 */
-		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
-		/* Reset the stack frame. */
-		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
+		EMIT3(0x48, 0x8B, 0x19);       /* mov rbx, [rcx] */
+		EMIT4(0x4C, 0x8B, 0x69, 0x08); /* mov r13, [rcx + 8] */
+		EMIT4(0x4C, 0x8B, 0x71, 0x10); /* mov r14, [rcx + 16] */
+		EMIT4(0x4C, 0x8B, 0x79, 0x18); /* mov r15, [rcx + 24] */
+		EMIT4(0x4C, 0x8B, 0x61, 0x20); /* mov r12, [rcx + 32] */
+		EMIT3(0x48, 0x89, 0xD5);       /* mov rbp, rdx */
+		EMIT3(0x48, 0x89, 0xEC);       /* mov rsp, rbp */
 	} else {
 		EMIT1(0x55);             /* push rbp */
 		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
@@ -901,14 +909,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
 
-	if (bpf_prog->aux->exception_boundary) {
-		pop_callee_regs(&prog, all_callee_regs_used);
+	pop_callee_regs(&prog, callee_regs_used);
+	if (bpf_prog_uses_arena_insns(bpf_prog))
 		pop_r12(&prog);
-	} else {
-		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_prog_uses_arena_insns(bpf_prog))
-			pop_r12(&prog);
-	}
 
 	/* Pop tail_call_cnt_ptr. */
 	EMIT1(0x58);                              /* pop rax */
@@ -967,14 +970,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1 */
 
-	if (bpf_prog->aux->exception_boundary) {
-		pop_callee_regs(&prog, all_callee_regs_used);
+	pop_callee_regs(&prog, callee_regs_used);
+	if (bpf_prog_uses_arena_insns(bpf_prog))
 		pop_r12(&prog);
-	} else {
-		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_prog_uses_arena_insns(bpf_prog))
-			pop_r12(&prog);
-	}
 
 	/* Pop tail_call_cnt_ptr. */
 	EMIT1(0x58);                                  /* pop rax */
@@ -2594,49 +2592,31 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 	bpf_prog->aux->ksym.fp_start = prog - temp;
 
-	/* Exception callback will clobber callee regs for its own use, and
-	 * restore the original callee regs from main prog's stack frame.
+	/*
+	 * Save the callee-saved registers this function uses. An exception
+	 * boundary saves nothing more: the unwinder recovers the registers of
+	 * the frames it discards and hands them to the exception callback.
 	 */
-	if (bpf_prog->aux->exception_boundary) {
-		/* We also need to save r12, which is not mapped to any BPF
-		 * register, as we throw after entry into the kernel, which may
-		 * overwrite r12.
-		 */
+	if (arena_vm_start)
 		push_r12(&prog);
-		push_callee_regs(&prog, all_callee_regs_used);
-	} else {
-		if (arena_vm_start)
-			push_r12(&prog);
-		push_callee_regs(&prog, callee_regs_used);
-	}
+	push_callee_regs(&prog, callee_regs_used);
 
 	/*
-	 * Record where the pushes above saved the caller's R6..R9, relative to the
-	 * rbp that arch_bpf_stack_walk() reports for this frame. Below rbp lie, from
-	 * high to low addresses: round_up(stack_depth, 8) bytes of program stack
-	 * (none with a private stack), the tail call count and its pointer (16 bytes)
-	 * when tail_call_reachable, r12 when exception_boundary or arena_vm_start,
-	 * and then rbx, r13, r14 and r15 in push order, each only when pushed.
+	 * Record where the pushes above saved the caller's registers, relative to
+	 * the rbp that arch_bpf_stack_walk() reports for this frame. Below rbp lie,
+	 * from high to low addresses: round_up(stack_depth, 8) bytes of program
+	 * stack (none with a private stack), the tail call count and its pointer
+	 * (16 bytes) when tail_call_reachable, r12 when arena_vm_start, and then
+	 * rbx, r13, r14 and r15 in push order, each only when pushed.
 	 */
 	callee_regs_off = -(s32)round_up(stack_depth, 8) - (tail_call_reachable ? 16 : 0);
-	if (bpf_prog->aux->exception_boundary || arena_vm_start)
-		callee_regs_off -= 8;
-	record_callee_reg_off(bpf_prog, callee_regs_off,
-			      bpf_prog->aux->exception_boundary ? all_callee_regs_used : callee_regs_used);
+	record_callee_reg_off(bpf_prog, callee_regs_off, callee_regs_used, arena_vm_start);
 
 	/* Compute callee-saved register area size. */
-	callee_saved_size = 0;
-	if (bpf_prog->aux->exception_boundary || arena_vm_start)
-		callee_saved_size += 8; /* r12 */
-	if (bpf_prog->aux->exception_boundary) {
-		callee_saved_size += 4 * 8; /* rbx, r13, r14, r15 */
-	} else {
-		int j;
-
-		for (j = 0; j < 4; j++)
-			if (callee_regs_used[j])
-				callee_saved_size += 8;
-	}
+	callee_saved_size = arena_vm_start ? 8 : 0; /* r12 */
+	for (int j = 0; j < 4; j++)
+		if (callee_regs_used[j])
+			callee_saved_size += 8;
 	/*
 	 * Base offset from rbp for translating BPF outgoing args 7+
 	 * to native offsets. BPF uses negative offsets from r11
@@ -2657,9 +2637,6 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
-	if (bpf_prog->aux->exception_boundary)
-		/* With a private stack every call site also has r9 pushed. */
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp + (priv_frame_ptr ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
@@ -3822,14 +3799,9 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			/* Deallocate outgoing args 7+ area. */
 			emit_add_rsp(&prog, outgoing_rsp);
-			if (bpf_prog->aux->exception_boundary) {
-				pop_callee_regs(&prog, all_callee_regs_used);
+			pop_callee_regs(&prog, callee_regs_used);
+			if (arena_vm_start)
 				pop_r12(&prog);
-			} else {
-				pop_callee_regs(&prog, callee_regs_used);
-				if (arena_vm_start)
-					pop_r12(&prog);
-			}
 			EMIT1(0xC9);         /* leave */
 			bpf_prog->aux->ksym.fp_end = prog - temp;
 
diff --git a/arch/x86/net/bpf_throw.S b/arch/x86/net/bpf_throw.S
index c70a4002cc8a..7d249e099b67 100644
--- a/arch/x86/net/bpf_throw.S
+++ b/arch/x86/net/bpf_throw.S
@@ -11,7 +11,8 @@
  * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
  * bpf_throw() here, so the BPF register file of the throw site is still intact
  * on entry. Capture its callee-saved registers on the stack as a struct
- * bpf_throw_regs and hand it to bpf_throw_unwind(), which never returns.
+ * bpf_throw_regs, along with r12, the callee-saved register no BPF register
+ * maps to, and hand it to bpf_throw_unwind(), which never returns.
  */
 SYM_FUNC_START(bpf_throw_entry)
 	ANNOTATE_NOENDBR
@@ -20,7 +21,8 @@ SYM_FUNC_START(bpf_throw_entry)
 	pushq %rbp
 	movq %rsp, %rbp
 
-	/* Save R9..R6 so that [rsp + 8 * i] is saved[i]. */
+	/* Save r12, then R9..R6 so that [rsp + 8 * i] is saved[i]. */
+	pushq %r12	/* saved[4] */
 	pushq %r15	/* R9 */
 	pushq %r14	/* R8 */
 	pushq %r13	/* R7 */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 839c28d3743f..b4a1edfb1df4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1937,15 +1937,21 @@ struct bpf_prog_aux {
 	int cgroup_atype; /* enum cgroup_bpf_attach_type */
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
-	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
-	u16 stack_arg_sp_adjust;
+	/*
+	 * The exception callback of the main program: @cookie is the value of
+	 * the throw, @sp and @bp the native stack and frame pointers of the main
+	 * program's frame, @saved the callee-saved registers the unwinder
+	 * restored, R6..R9 then the architecture's own, see struct bpf_throw_regs.
+	 */
+	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64 saved, u64);
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
 	/*
 	 * Offsets from the native frame pointer of this JITed program at which
-	 * its prologue saved the caller's R6..R9, or 0 when that register is not
-	 * saved. Filled by the JIT; consumed by the exception unwinder.
+	 * its prologue saved the caller's callee-saved registers, R6..R9 then
+	 * the architecture's own, or 0 when that register is not saved. Filled
+	 * by the JIT; consumed by the exception unwinder.
 	 */
-	s16 callee_reg_off[4];
+	s16 callee_reg_off[BPF_THROW_NR_CALLEE_SAVED];
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_throw.h b/include/linux/bpf_throw.h
index 663776715b33..e3daa2875415 100644
--- a/include/linux/bpf_throw.h
+++ b/include/linux/bpf_throw.h
@@ -6,8 +6,24 @@
 #ifndef _LINUX_BPF_THROW_H
 #define _LINUX_BPF_THROW_H
 
-/* The callee-saved registers the unwinder tracks: R6..R9. */
-#define BPF_THROW_NR_CALLEE_SAVED	4
+/*
+ * The callee-saved registers of the architecture that no BPF register maps
+ * to, which the unwinder restores along with R6..R9 when it discards frames:
+ * r12 on x86-64, which holds the arena base, and x23..x28 on arm64, of which
+ * x25..x28 are the BPF frame pointer, the tail call count pointer, the
+ * private stack pointer and the arena base, while x23 and x24 are left alone
+ * by JITed code but may be in use by the C code of the unwinder when it
+ * enters the exception callback, whose epilogue never runs.
+ */
+#if defined(CONFIG_X86_64)
+#define BPF_THROW_NR_EXTRA	1
+#elif defined(CONFIG_ARM64)
+#define BPF_THROW_NR_EXTRA	6
+#else
+#define BPF_THROW_NR_EXTRA	0
+#endif
+/* The callee-saved registers the unwinder tracks: R6..R9, then the extra ones. */
+#define BPF_THROW_NR_CALLEE_SAVED	(4 + BPF_THROW_NR_EXTRA)
 /* The size of struct bpf_throw_regs, for the entries. */
 #define BPF_THROW_REGS_SIZE		(8 * BPF_THROW_NR_CALLEE_SAVED)
 
@@ -16,8 +32,8 @@
 #include <linux/types.h>
 
 /*
- * The callee-saved registers captured at a throw site, indexed like
- * bpf_prog_aux::callee_reg_off.
+ * The callee-saved registers captured at a throw site, R6..R9 then the extra
+ * ones of the architecture, indexed like bpf_prog_aux::callee_reg_off.
  */
 struct bpf_throw_regs {
 	u64 saved[BPF_THROW_NR_CALLEE_SAVED];
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 409b9104c723..8b9944cac47a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1584,7 +1584,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->real_func_cnt = env->subprog_cnt;
 	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
-	prog->aux->stack_arg_sp_adjust = func[0]->aux->stack_arg_sp_adjust;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7c78630e4dd3..d898aaf33b97 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3401,12 +3401,21 @@ struct bpf_throw_ctx {
 	u64 sp;
 	u64 bp;
 	int cnt;
+	const struct bpf_throw_regs *regs;	/* register file of the throw site, or NULL */
+	/*
+	 * The callee-saved registers of the frame being walked, R6-R9 then the
+	 * architecture's own: what the throw site had, then what each frame
+	 * recovered of its caller's. After the main frame they are the ones
+	 * its caller expects back.
+	 */
+	u64 saved[BPF_THROW_NR_CALLEE_SAVED];
 };
 
 static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 {
 	struct bpf_throw_ctx *ctx = cookie;
 	struct bpf_prog *prog;
+	int i;
 
 	/*
 	 * The RCU read lock is held to safely traverse the latch tree, but we
@@ -3418,6 +3427,20 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	rcu_read_unlock();
 	if (!prog)
 		return !ctx->cnt;
+	if (ctx->regs) {
+		/* The symbol of a program JITed as a set of functions covers its first function. */
+		const struct bpf_prog_aux *fn = !prog->is_func && prog->aux->func ?
+						prog->aux->func[0]->aux : prog->aux;
+
+		/*
+		 * Recover the caller's callee-saved registers: those this frame's
+		 * prologue saved sit in its frame, the rest are still the values
+		 * the frame itself has.
+		 */
+		for (i = 0; i < BPF_THROW_NR_CALLEE_SAVED; i++)
+			if (fn->callee_reg_off[i])
+				ctx->saved[i] = *(u64 *)(long)(bp + fn->callee_reg_off[i]);
+	}
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
@@ -3430,12 +3453,16 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 /*
  * Unwind the stack to the exception callback of the main program. @regs holds
  * the callee-saved registers of the throw site, or is NULL when the
- * architecture has no native entry and the kfunc was called directly.
+ * architecture has no native entry and the kfunc was called directly; with it,
+ * the callee-saved registers of the frames unwound are restored for the
+ * callback, without it the main program's prologue has saved them all.
  */
 void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 {
-	struct bpf_throw_ctx ctx = {};
+	struct bpf_throw_ctx ctx = { .regs = regs };
 
+	if (regs)
+		memcpy(ctx.saved, regs->saved, sizeof(ctx.saved));
 	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
 	WARN_ON_ONCE(!ctx.aux);
 	if (ctx.aux)
@@ -3449,7 +3476,7 @@ void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 	 * architectures cannot recover sp while unwinding, so fall back to bp.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, (u64)(long)ctx.saved, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..76a4e1823c6c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -212,11 +212,7 @@ __jited("	stp	x29, x30, [sp, #-0x10]!")
 __jited("	mov	x29, sp")
 __jited("	stp	xzr, x26, [sp, #-0x10]!")
 __jited("	mov	x26, sp")
-__jited("	stp	x19, x20, [sp, #-0x10]!")
-__jited("	stp	x21, x22, [sp, #-0x10]!")
-__jited("	stp	x23, x24, [sp, #-0x10]!")
-__jited("	stp	x25, x26, [sp, #-0x10]!")
-__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	stp	x25, x27, [sp, #-0x10]!")
 __jited("	mov	x27, {{.*}}")
 __jited("	movk	x27, {{.*}}, lsl #16")
 __jited("	movk	x27, {{.*}}")
@@ -228,7 +224,7 @@ __jited("	str	x0, [x27]")
 __jited("	mov	x0, #0x0")
 __jited("	bl	0x{{.*}}")
 __jited("	mov	x8, x0")
-__jited("	ldp	x27, x28, [sp], #0x10")
+__jited("	ldp	x25, x27, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
 	asm volatile ("			\
@@ -256,7 +252,7 @@ __jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __arch_arm64
-__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	stp	x25, x27, [sp, #-0x10]!")
 __jited("	mov	x27, {{.*}}")
 __jited("	movk	x27, {{.*}}, lsl #16")
 __jited("	movk	x27, {{.*}}")
@@ -267,7 +263,7 @@ __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	bl	0x{{.*}}")
 __jited("	mov	x8, x0")
-__jited("	ldp	x27, x28, [sp], #0x10")
+__jited("	ldp	x25, x27, [sp], #0x10")
 int private_stack_exception_sub_prog(void)
 {
 	asm volatile ("			\
-- 
2.53.0

