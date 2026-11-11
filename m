Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401861;
	b=nEAVdzq/g53dh8JfiuoiRibuyv4ZKtvsGSuEcVcDA44bdXEesyXfD3Qo9F7Rjf5DxOGw
	 mvNzdoWC5sUp6NUcrDoZMINUbLEGGogh6hlOc1NkPB7piLCZ5nLxJo15sichEV27H4t9t
	 lOs5FOC6uJtWx/Qgh6sLCABAQLvQnHdUIgaDI7Xuik4LbbwvI+tAck8kbxUQemFamXzWf
	 UiRiRDIQSQXDYKax8xq8E5Ft9sw8U10eMPlT1EhqjbhWHZGHW/X9tTmtr7nSbOIRQ5uCK
	 Xj80hM8WhKkxmkOhAPMqKfxrLTHqriME3HyEOBVjmq3WHKYbluJsp7rBEKLQjrNS1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=ftFXbJYgjHGODhmmv9oTH9iDE5Ia+fIDbmtLG2WRWfA=;
	b=fpeESgHEpldpdYCSswcJPgm0ANHCdQ3ry2mUcRgcfxWE4zbVqgwgCmOuwxmTyhnfMpXN
	 DUSGUXFBnRxZPqtxN8Ugeiqr4s9RfcT+Etd2hL8YSj1B2bNfEeW5R3TjFSrNkWEVY6hMx
	 hATeTNwd4mKsqEfL5VuT8BvsO4vsg058qCn0UyD9P2tGSmXS2aW8EWzGpGFlxQlbfGaNW
	 gRb637Mbi+7D1x2nPjnawXt5xrxzm4115X0dBkvHVi/obBwJZn/dzPoIPdKTrYH5Q8Zuj
	 h7wTIOZzjObNlBeSU/IzoqCbhvVFOAxmpoEFcr9mhzbchqkZNHwJpfoPF3J1IZ/M7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f98DewAb;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B8606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A44B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f98DewAb
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76ade741cso12338425e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401859; x=1795006659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftFXbJYgjHGODhmmv9oTH9iDE5Ia+fIDbmtLG2WRWfA=;
        b=f98DewAbQ29aG9/SAy9xIqGuftnCJLVUoi5YAPFx+zB6lgTeeqpqNr3c6C0NY3YD5N
         UnTzRRrnEMuoreTtqy7ynCaMT+XCz7dSlWbjkcO7qgJn+5kme3+0bEX4bf23jBN564HU
         I78+8Ela+NG/YPqHmahwk8OXp8m+nXjnbnGULlSJc/NjK0Z+I9UYUD/j/MegCg8GKwG2
         H610eifTdPPnBrliGrVyCsGnZVlxwVQs3wRFl+b8ugm2yzomQ8HkV0RcZUa//LxiEKES
         /Hky0p3lWBfoI+15bwWcZ5R6RJ/QNNevYKXjAHRte63+M+BiIcN+NcBwsvnWLdySQ/zx
         yj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401859; x=1795006659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftFXbJYgjHGODhmmv9oTH9iDE5Ia+fIDbmtLG2WRWfA=;
        b=SetrbBwF1+9iGOic6TXrYi5u2MhWnsJlMEYCcLgn23W0VXwcdo0R8P6ofJMpM6TXQC
         8Fpj4G6j53Bh+jll1xVh8Gc3l6gymHS2j6NBlbFyMZzTPDobyKlRpm/2i9ngd5t1bP9F
         EMrWU2kV4CYZy9SOp16S6McUsCFCU05VjshValRbQ8y1mQD3AJDmhyP8qKLdzKk88iXb
         rZ03p8pEXdFTfSOFsCAZgHh2kW9TiUOwzU8BWCj+ocUFw3e/e6Ewk9/251ZVTRpQrp+8
         JMFuvpU6QfLBg53EDR/fWzPr2R16HNpsVhoLNLWv9W4ql09tJjUXFlwn1Mdj0gD4FlxE
         8GTg==
X-Gm-Message-State: APuU4Z9LbI0TUKUW5hFMmCV+wMn6uBh7jOWzf4nkel+MOc21nVVOmKPb
	3eqIADXlDjfXBKhRbuYxWGSZJMeFRranMhnATuxVxyIE3yVm421bAcR3bxrkbhhkJF4=
X-Gm-Gg: AYBFou00E7WMj8QYtnvecTiYKoRyDCY94hh1ELXNWcwuV0rgjZRND7888UwsIecXzmd
	B69fME2FWVyp9Y0XTPnCP8W8RxKS5x4OBpC+kgR3Z1GispXKUxbnIyP3xYLYGfzZp+1mFigppzv
	JDeNuIvD4/QSCY/O4aqPVhFpmATpQ9r9twgIl9+NBcPlGqe8NC/1zScjlZ0kz3NCkCleiDAQPU+
	O1prfrKUKY/Q6WJbMrnbIg/aZQfMgyFs/tsgVHsckxowcAAPXa65FxrLypSw/s/p9hd49c8Wpsz
	eslfvvVVQqa+xdn1CF76EZ1j2D9Rumq3slpOXy7mDEuZeIUEkMhYSyk6VKX+B+O1fa3xdWRwJq/
	JQp3HfUDN7VzugstQ9tdAh0s/D0vjzNVpnbQFHCW00b7gMxLZSUleob3r+adBY3BgtS+XK85KQu
	RW+s8Jpbe9IyZHaljsc3lhtPuPTI4neVLY3NlkJmbtqaExx1Qhocon3IJOQIsbKgjk7CoWI979Q
	4ouadjyU6VlkG/Pj0U6xLX4pQmrTKj6/Qfb+vve8v1PASCQ7jSVeT2RNuzT6ETF8Txf8KT2gwPx
	UabIx5pDpTqv8axeu0o//PxRpK4Pdf6vCyYpcLZKqgeNkpoequiwVX6KXTCWyKEshhfmRUGo3cp
	oanfRRON10U7FsdC8Lka+iZupUGwcImuLjnF6WI0k3VhBeqH/CwxqWCZ5PDChNVrX/6hY
X-Received: by 2002:a05:600c:6214:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4ba09375bb4mr39929565e9.20.1794401858649;
        Wed, 11 Nov 2026 04:57:38 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0223c41csm142835045e9.14.2026.11.11.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:38 -0800 (PST)
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
Subject: [PATCH bpf-next v1 05/29] bpf: Restore callee-saved registers from unwound frames
Date: Wed, 11 Nov 2026 13:57:03 +0100
Message-ID: <34d17f4e59939c2afb427a69d9f34f61e3dc3343.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30119; i=memxor@gmail.com; h=from:subject:message-id; bh=B+dfJ7AKKQx8CgR4TPvlUXs+B0T22qcsHzqhz1aTdJk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzNylM4rm3LBoKRf8aeI453ywc5VFuNL/nIPH182zu ljFMj+4o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5tIrhv1Ne4dd1jMk/yo98 P+CkF3Rppbjx1T2JFhZsqov3V8hf5mFkOLVjU+n5rZyPOJ9N3K/XM/GJ1Ik/5q2qH8X+Lvo2vSO 4kBEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently a program that may throw is an exception boundary. Its prologue
pushes every callee-saved register that the JIT could clobber, five on
x86-64 and ten on arm64, whether or not the program uses them. The
exception callback pops them all from the boundary frame before it runs.
This restores the registers that a discarded frame clobbered, since the
epilogues of the frames between the throw site and the boundary never
run.

Every invocation of such a program pays for the pushes and pops: 18 bytes
of code on x86-64 for a program that uses none of the registers, and 80
bytes of stack on arm64.

Have the unwinder restore the registers instead, on the throw path only:

 - Each JITed function already records where its prologue saved the R6-R9
   of its caller. Extend this to every other callee-saved register: r12
   on x86-64 and x23-x28 on arm64.
 - The native entries capture the extra registers after R9, before any C
   code runs.
 - The unwinder starts with the values at the throw site. Walking
   outwards, it takes from each frame the values that the frame saved
   for its caller. After the main frame, these are the values that the
   caller of the program expects.
 - The exception callback receives them as its fourth argument and loads
   them before it reuses the main frame, instead of popping the saved
   registers of the boundary. It then sets up the rest of its frame like
   any function.

The extra registers are:

 - r12 on x86-64, which holds the arena base;
 - x23 on arm64, the stack pointer of the stack in arena;
 - x25-x28 on arm64: the BPF frame pointer, the tail call count pointer,
   the private stack pointer and the arena base;
 - x24 on arm64. No JITed code touches it, but the C code of the unwinder
   may still be using it when it enters the callback, whose epilogue
   never runs.

The boundary prologue becomes an ordinary prologue. The x86-64 stack
pointer adjustment that the callback needed to find the saved registers
of the boundary is removed along with the pops.

Architectures without a native entry, s390 and powerpc, are not affected.
There bpf_throw() calls the unwinder with NULL, the boundary prologue
still saves every register, and the callback restores them from the frame
as before.

bpf_prog_frame_aux() and bpf_throw_caller_regs() are the two steps of the
walk. A later patch reuses them to release the resources that the frames
hold.

The JITed code of the two verifier_private_stack programs that throw
changes on arm64 with the prologue, so update the expected output.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c                 | 126 +++++++----------
 arch/arm64/net/bpf_throw.S                    |   7 +-
 arch/x86/net/bpf_jit_comp.c                   | 132 +++++++-----------
 arch/x86/net/bpf_throw.S                      |   6 +-
 include/linux/bpf.h                           |  41 +++++-
 include/linux/bpf_throw.h                     |  20 ++-
 kernel/bpf/fixups.c                           |   1 -
 kernel/bpf/helpers.c                          |  30 +++-
 .../bpf/progs/verifier_private_stack.c        |  12 +-
 9 files changed, 190 insertions(+), 185 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 33cc50268f3a..c9f851bd5003 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -866,24 +866,29 @@ static int callee_reg_slot_off(int idx)
 }
 
 /*
- * Record where push_callee_regs() saved the caller's R6..R9, relative to the frame
- * pointer that arch_bpf_stack_walk() reports for this frame, for the exception unwinder.
- * An exception boundary pushes x19..x28 in order, so R6..R9 take the first four slots.
+ * Record where the prologue saved the caller's callee-saved registers, relative to
+ * the frame pointer that arch_bpf_stack_walk() reports for this frame, for the
+ * exception unwinder. The registers are x19..x28 in the order of struct
+ * bpf_throw_regs, R6..R9 first: the tail call count pointer is saved with the frame
+ * record, the others where push_callee_regs() put them, and x24 nowhere, since
+ * JITed code leaves it alone.
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
@@ -891,35 +896,25 @@ static void record_callee_reg_off(struct jit_ctx *ctx)
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
@@ -927,34 +922,19 @@ static void push_callee_regs(struct jit_ctx *ctx)
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
 
@@ -1055,24 +1035,22 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
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
index 93f2d208ccc8..776a339b3234 100644
--- a/arch/arm64/net/bpf_throw.S
+++ b/arch/arm64/net/bpf_throw.S
@@ -10,8 +10,8 @@
  * on entry and x30 is the return address into the program. Push a frame record
  * whose link register is that address and save the file below it as a struct
  * bpf_throw_regs: r[i] sits at [sp + 16 + 8 * i], with R0 in x8, R1-R5 in
- * x0-x4 and R6-R9 in x19-x22. Then hand it to bpf_throw_unwind(), which never
- * returns.
+ * x0-x4, R6-R9 in x19-x22 and the extra callee-saved registers x23-x28 after
+ * them. Then hand it to bpf_throw_unwind(), which never returns.
  */
 SYM_FUNC_START(bpf_throw_entry)
 	stp	x29, x30, [sp, #-(16 + BPF_THROW_REGS_SIZE)]!
@@ -21,6 +21,9 @@ SYM_FUNC_START(bpf_throw_entry)
 	stp	x3, x4, [sp, #48]
 	stp	x19, x20, [sp, #64]
 	stp	x21, x22, [sp, #80]
+	stp	x23, x24, [sp, #96]
+	stp	x25, x26, [sp, #112]
+	stp	x27, x28, [sp, #128]
 
 	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
 	mov	x1, x0
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bdfc5329a00c..9b7466ca1a82 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -35,8 +35,6 @@ void __asan_load8(void *p);
 void __asan_store8(void *p);
 #endif
 
-static bool all_callee_regs_used[4] = {true, true, true, true};
-
 static void *trampoline_size_image;
 
 static int __init init_trampoline_size_image(void)
@@ -383,13 +381,19 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
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
@@ -569,18 +573,21 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
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
@@ -856,14 +863,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
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
@@ -922,14 +924,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
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
@@ -2475,49 +2472,31 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
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
@@ -2546,15 +2525,6 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
 	if (arena_sp)
 		outgoing_rsp = out_stack_arg_cnt * 8;
-	/*
-	 * bpf_throw() sees rsp of this frame as it is at a call. The callee-saved
-	 * regs are above the outgoing args, or above r9, which is pushed around
-	 * every call when the stack is private. With BPF_REG_ARENA_SP the slot
-	 * that keeps r9 over calls is between the two.
-	 */
-	if (bpf_prog->aux->exception_boundary)
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp +
-						     (priv_frame_ptr || arena_sp_save ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
@@ -3381,10 +3351,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip += err;
-				/*
-				 * Other kfuncs leave rsp alone. bpf_throw() is one of
-				 * them, see stack_arg_sp_adjust.
-				 */
+				/* Other kfuncs leave rsp alone. */
 				arena_sp_args = arena_sp && kfunc_has_stack_args(fm);
 				if (arena_sp_args) {
 					u8 *start = prog;
@@ -3762,14 +3729,9 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			/* Deallocate outgoing args 7+ area and the slot of BPF_REG_ARENA_SP. */
 			emit_add_rsp(&prog, outgoing_rsp + (arena_sp_save ? 8 : 0));
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
index 67983e5077a6..856b3f216a76 100644
--- a/arch/x86/net/bpf_throw.S
+++ b/arch/x86/net/bpf_throw.S
@@ -10,7 +10,8 @@
 /*
  * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
  * bpf_throw() here, so the BPF register file of the throw site is still intact
- * on entry. Capture it on the stack as a struct bpf_throw_regs and hand it to
+ * on entry. Capture it on the stack as a struct bpf_throw_regs, along with
+ * r12, the callee-saved register no BPF register maps to, and hand it to
  * bpf_throw_unwind(), which never returns.
  */
 SYM_FUNC_START(bpf_throw_entry)
@@ -20,7 +21,8 @@ SYM_FUNC_START(bpf_throw_entry)
 	pushq %rbp
 	movq %rsp, %rbp
 
-	/* Save R9..R0 so that [rsp + 8 * i] is r[i]. */
+	/* Save r12, then R9..R0 so that [rsp + 8 * i] is r[i]. */
+	pushq %r12	/* r[10] */
 	pushq %r15	/* R9 */
 	pushq %r14	/* R8 */
 	pushq %r13	/* R7 */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b01820e67795..2b9adc4866bc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1995,15 +1995,21 @@ struct bpf_prog_aux {
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
@@ -4436,6 +4442,31 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+/*
+ * The aux of the JITed function a frame of @prog runs: the symbol of a
+ * program JITed as a set of functions covers its first function.
+ */
+static inline const struct bpf_prog_aux *bpf_prog_frame_aux(const struct bpf_prog *prog)
+{
+	return !prog->is_func && prog->aux->func ? prog->aux->func[0]->aux : prog->aux;
+}
+
+/*
+ * The exception unwinder leaves a frame of the JITed function @fn, whose
+ * native frame pointer is @bp, for its caller. @saved holds the callee-saved
+ * registers the frame has, R6..R9 then the architecture's own: the caller has
+ * the same, but for the ones the prologue of the frame saved, which are where
+ * it saved them.
+ */
+static inline void bpf_throw_caller_regs(const struct bpf_prog_aux *fn, u64 bp, u64 *saved)
+{
+	int i;
+
+	for (i = 0; i < BPF_THROW_NR_CALLEE_SAVED; i++)
+		if (fn->callee_reg_off[i])
+			saved[i] = *(u64 *)(long)(bp + fn->callee_reg_off[i]);
+}
+
 const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
 struct bpf_linfo_source {
 	const char *file;
diff --git a/include/linux/bpf_throw.h b/include/linux/bpf_throw.h
index 2bb2c18796ac..6449757c18a9 100644
--- a/include/linux/bpf_throw.h
+++ b/include/linux/bpf_throw.h
@@ -8,11 +8,23 @@
 
 /*
  * The callee-saved registers of the architecture that no BPF register maps
- * to, which an entry captures after R9. None yet.
+ * to, which the entries capture after R9 and the unwinder restores along
+ * with R6..R9 when it discards frames: r12 on x86-64, which holds the arena
+ * base, and x23..x28 on arm64, of which x23 is the stack pointer of the
+ * stack in arena and x25..x28 are the BPF frame pointer, the tail call count
+ * pointer, the private stack pointer and the arena base, while x24 is left
+ * alone by JITed code but may be in use by the C code of the unwinder when
+ * it enters the exception callback, whose epilogue never runs.
  */
-#define BPF_THROW_NR_EXTRA		0
-/* The callee-saved registers the unwinder tracks: R6..R9. */
-#define BPF_THROW_NR_CALLEE_SAVED	4
+#if defined(CONFIG_X86_64)
+#define BPF_THROW_NR_EXTRA	1
+#elif defined(CONFIG_ARM64)
+#define BPF_THROW_NR_EXTRA	6
+#else
+#define BPF_THROW_NR_EXTRA	0
+#endif
+/* The callee-saved registers the unwinder tracks: R6..R9, then the extra ones. */
+#define BPF_THROW_NR_CALLEE_SAVED	(4 + BPF_THROW_NR_EXTRA)
 /* The size of struct bpf_throw_regs, for the entries: R0..R9 and the extra ones. */
 #define BPF_THROW_REGS_SIZE		(8 * (10 + BPF_THROW_NR_EXTRA))
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1d33a78d9373..eb5a5bca5c8d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2103,7 +2103,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->real_func_cnt = env->subprog_cnt;
 	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
-	prog->aux->stack_arg_sp_adjust = func[0]->aux->stack_arg_sp_adjust;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index de31fdd18411..0164f183aade 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3434,6 +3434,13 @@ struct bpf_throw_ctx {
 	u64 sp;
 	u64 bp;
 	int cnt;
+	/*
+	 * The callee-saved registers of the frame being walked, R6-R9 then the
+	 * architecture's own: what the throw site had, then what each frame
+	 * recovered of its caller's. After the main frame they are the ones
+	 * its caller expects back.
+	 */
+	u64 saved[BPF_THROW_NR_CALLEE_SAVED];
 };
 
 static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
@@ -3451,6 +3458,12 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	rcu_read_unlock();
 	if (!prog)
 		return !ctx->cnt;
+	/*
+	 * Recover the caller's callee-saved registers: those this frame's
+	 * prologue saved sit in its frame, the rest are still the values the
+	 * frame itself has.
+	 */
+	bpf_throw_caller_regs(bpf_prog_frame_aux(prog), bp, ctx->saved);
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
@@ -3461,15 +3474,24 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 }
 
 /*
- * Unwind the stack to the exception callback of the main program. @regs holds
- * the callee-saved registers of the throw site, or is NULL when the
- * architecture has no native entry and the kfunc was called directly.
+ * Unwind the stack to the exception callback of the main program. @regs is the
+ * register file of the throw site, which the entry of the architecture
+ * captured: the callee-saved registers of the frames unwound are restored from
+ * it for the callback. It is NULL when the architecture has no native entry
+ * and the kfunc was called directly.
  */
 __bpf_unwind_entry
 notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 {
 	struct bpf_throw_ctx ctx = {};
 
+	/*
+	 * Without the file, on an architecture that has no native entry, the
+	 * prologue of the main program has saved every callee-saved register
+	 * and the callback restores them from its frame, not from @saved.
+	 */
+	if (regs)
+		memcpy(ctx.saved, &regs->r[BPF_REG_6], sizeof(ctx.saved));
 	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
 	WARN_ON_ONCE(!ctx.aux);
 	if (ctx.aux)
@@ -3483,7 +3505,7 @@ notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 	 * architectures cannot recover sp while unwinding, so fall back to bp.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, (u64)(long)ctx.saved, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index e7f410a74a21..14e5c6bdd4d8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -287,11 +287,7 @@ __jited("	mov	x29, sp")
 __jited("	stp	xzr, x26, [sp, #-0x10]!")
 __jited("	mov	x26, sp")
 __jited("...")
-__jited("	stp	x19, x20, [sp, #-0x10]!")
-__jited("	stp	x21, x22, [sp, #-0x10]!")
-__jited("	stp	x23, x24, [sp, #-0x10]!")
-__jited("	stp	x25, x26, [sp, #-0x10]!")
-__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	stp	x25, x27, [sp, #-0x10]!")
 __jited("	mov	x27, {{.*}}")
 __jited("	movk	x27, {{.*}}, lsl #16")
 __jited("	movk	x27, {{.*}}")
@@ -303,7 +299,7 @@ __jited("	str	x0, [x27]")
 __jited("	mov	x0, #0x0")
 __jited("	bl	0x{{.*}}")
 __jited("	mov	x8, x0")
-__jited("	ldp	x27, x28, [sp], #0x10")
+__jited("	ldp	x25, x27, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
 	asm volatile ("			\
@@ -331,7 +327,7 @@ __jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __arch_arm64
-__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	stp	x25, x27, [sp, #-0x10]!")
 __jited("	mov	x27, {{.*}}")
 __jited("	movk	x27, {{.*}}, lsl #16")
 __jited("	movk	x27, {{.*}}")
@@ -342,7 +338,7 @@ __jited("	mov	x0, #0x2a")
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

