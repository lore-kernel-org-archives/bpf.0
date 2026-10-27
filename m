Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127902;
	b=xxNJwQ1OmsyiShD7KueCbjzDEAiX2gfwdQfCQW06WYyt0UgY1fabgqvTKw7Q+4L5uTDE
	 G/bxonKNJHM6FaVZFRIryvpOaTHOlP1aFj2oxVD1KkCo9ZYyql0kSwmABstjV+UEK/AtM
	 mh/Bq9T6gLYi5qFJG9mL8+GJDsIeHZEP2hCPra9E/u22Lf7ijT8zx5R35D3hyu58Ov6HC
	 WPEE5Ua1sA/0kZdnP4wPY60StrlMDY7O0lybeOCFIav9IGPRtO93/+JbrFyxsDW/J+eL2
	 j7aDVDsu+3MUKWd5DD5PYDMqmXBGIPYAwoYTBKjk7sjdsbYnhL60tNNlgyt6biKaxKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HOIXMbvjJxbq5fr3ZqHAGVJMwiVhcUsRrmzmhT/uR4U=;
	b=L/52KLy4OxS3LQ0kfB2PXmJl4lLLR9q/xehOFyCA7fVu1cfFYI/FQG2u8n2pssvxXWmX
	 G9q6JgceuyCk0he4wJDzCh8DilRqWUUrecraaR7taOdyVHktX+2tazrROrLOgkFudpi26
	 yU3NVtqhKBb6ZgYP0HUIaMspOHgH7xa6f++C8m0DGZmNGhkxVsPQ6VBinO5+Axf2fYuJT
	 zrYrn0MP8HYr3u8HvvHgpcFZZJd/XJgjkbEHYvmOk7pfCafWRzdl/vvvmqggN1YL/9xLM
	 mY4Kl4xboOVH+H9ORoAv0KjEWuv/1fMGTsnJwcoImjZ5c4F/W7i2QbUf0zE0OslRYNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MP62x5JE;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86091606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86091606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MP62x5JE
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so181902a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127902; x=1793732702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOIXMbvjJxbq5fr3ZqHAGVJMwiVhcUsRrmzmhT/uR4U=;
        b=MP62x5JEt77iE3y55L9Z4rSBdYLr3dRQXdu9GciO0ddOwziQY1OabwvUqAE25gI0GK
         +2zlq9cShTgPkQf0qi1s67umPsWD4RZng7XEqyg9HiL9aWiAhDNEt32dt5i3HzHK6y4Q
         fIRWqQkvwBSxNt6uHaMj7xiZTycHPSYX6C8QqChwQ4YwanVxw4RNxfeSEJbNe3/sMPHh
         VjtCiVMIxcJLvp4PvngE1qMXit7g0vsjtYjJXE1vMX9sbMP/tJ9ZAuRpKuigPaFl6uhz
         5OoCNMYHwPeTQtnDNbk4qd2AFwJteykwvFEcbYU7+z+gmma3UDsX1CiTR+4x3Sm7x6Ha
         qndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127902; x=1793732702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOIXMbvjJxbq5fr3ZqHAGVJMwiVhcUsRrmzmhT/uR4U=;
        b=joVBFZ8waeKb1/OmTdnjzuW4OjZaotjbLUyv5ZWnrPp/oLbMix/yPR/b3w5TwP73N5
         qHvpA3dlzId2SuGyaOMVDx0Gcx1sFD+C8RlbvkRXNasgPr2gB3Q++/ucyGbgkblK81Xa
         0dpHGeBpNDVlj4X7ZCNDWioYN+qv+OI8CN+FbYi6IftRHTqzU7oBpvOF2JtnylapZoHH
         XqB3ObDP6mwHUya9OayHyz90MEVTF3UxNlMCdYRiwQRXkbikjRMhFb0lU5BLb/ckG/3u
         H7w33T9kyDOWVTmPapf5q7aAPsy+g+mqZa7wAc9a/ObaUBGHcqz3jIuFyCAwczZtPFAX
         EyUg==
X-Gm-Message-State: AFq9FYKOTPwNraqzDKuDDqu5UKiIdLd+b5yUtaget+8lxxTtlvZcyU32
	TvdARu8s8yvaKH20F6XRaekmn0n0j8OB2xYpSAIwMLvtU8KcI3gvJj2NAfrAnA==
X-Gm-Gg: AYBFou09+jxZI2/OXZXYHVNd3GwNqeJVbWHECxRk169iEazGM9pXk7j7iRAhi1VhL2y
	fMZMvbnjCNkIrsAenrF3PsoU6EK4k2QcYEM2iL4pq/Hq4hem+c5poaYMfY65Xn/BEl2BLYOTD7z
	/hKE4vil7H0r/KBEWj0TVMrGg1IvE5jnmDP8TViKkZWrx+2+OEghMGQP1+a1t203h89PYZDFXyC
	HKRdo0QHaQLJi4Qe5nz0qHEL84Ph1myWI62bP3CVT73o0GeGdPMO+SwSj2ke96aOcgUKtGyljYB
	QT0lUd+9j1EffMyg2KvAzcmjRUYn788NhoLeqpYMS92JjhaKBJMJvYB30j5iEqZv+H+wJW9Busy
	mmkT3vrCPELrLWjPHFGmFGQlg797Tjz2Vq9Qz7OrmQrcO8btTcluPEUY8YES+8HZEKK8m9TXifv
	UIAsJbTbTvzLP8K5f6pQowDDUpeHWeoU+q+gyKGOUds6uGqhV939BqRn4lMobuf95mRfl0FcOlI
	MH5dpLowmPTCC6vVlZ+jUsD960BsqhnRIZNXkg2gkT6TDfqTV5rCV1isUFoHiY39XqsCqKXtg0k
	+MvsBTNFu6VH2W+VtShI3ygF3RNBFa3ZvNzSfKVGJqo7FJb3jD2JbHAoJbaMwAM/KYwyaE2tWuG
	t9FUKfAXM1D6yiFD0u6+3NjHS
X-Received: by 2002:a17:90b:3dce:b0:3ad:4a8b:c701 with SMTP id 98e67ed59e1d1-3adeafd64e3mr9810009a91.45.1793127901610;
        Tue, 27 Oct 2026 12:05:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578ba2edsm129491a91.13.2026.10.27.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:05:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 18/19] bpf: Keep stack arguments in arch_bpf_timed_may_goto()
Date: Tue, 27 Oct 2026 19:03:13 +0000
Message-ID: <20261027190314.1440199-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The JITs pass the first stack arguments of a call in registers:

  x86-64    r9       argument 6
  arm64     x5-x7    arguments 6-8
  riscv64   a5-a7    arguments 6-8

'*(u64 *)(r11 - 8) = rX' writes such a register in the caller.
'rX = *(u64 *)(r11 + 8)' reads it in the callee. A call changes these
registers. Thus the verifier accepts no call between the write and the call
of the callee, and no call in the callee before the read.

may_goto is not a call for the verifier. But one time in 65535 iterations
it calls arch_bpf_timed_may_goto(), and this function calls C code. It
saves R0-R5 only.

       *(u64 *)(r11 - 8) = 0      ; the verifier: argument 6 is 0
       call sub
  sub:
    1: may_goto 2f                ; C code changes r9
       goto 1b
    2: r2 = *(u64 *)(r11 + 8)     ; r2 is a kernel address
       r1 = map_value
       r1 += r2
       *(u64 *)(r1 + 0) = 0

On x86-64 the C code changes r9 when the time of may_goto is up. With the
hpet clocksource a look at the clock changes r9 too. The prog above crashes
the kernel. LLVM does not emit such code: it reads stack arguments at the
entry of a function, and it writes them immediately before the call.

Save and restore these registers too. The cost is 2 insns on x86-64, 4 on
arm64 and 6 on riscv64, one time in 65535 iterations.

Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments")
Fixes: 235b2fe772f5 ("bpf, arm64: Add JIT support for stack arguments")
Fixes: ba754185f902 ("riscv, bpf: Add BPF stack arguments support for RV64 JIT")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_timed_may_goto.S | 10 ++++++++--
 arch/riscv/net/bpf_timed_may_goto.S | 27 ++++++++++++++++++---------
 arch/x86/net/bpf_timed_may_goto.S   |  3 +++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index a9a802711a7f..1b4a4f91ffc9 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -5,13 +5,16 @@
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/* Allocate stack space and emit frame record */
-	stp     x29, x30, [sp, #-64]!
+	stp     x29, x30, [sp, #-96]!
 	mov     x29, sp
 
 	/* Save BPF registers R0 - R5 (x8, x0-x4)*/
 	stp	x8, x0, [sp, #16]
 	stp	x1, x2, [sp, #32]
 	stp	x3, x4, [sp, #48]
+	/* Save stack arguments 6 - 8 (x5-x7) */
+	stp	x5, x6, [sp, #64]
+	str	x7, [sp, #80]
 
 	/*
 	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
@@ -32,9 +35,12 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	ldp	x8, x0, [sp, #16]
 	ldp	x1, x2, [sp, #32]
 	ldp	x3, x4, [sp, #48]
+	/* Restore stack arguments 6 - 8 (x5-x7) */
+	ldp	x5, x6, [sp, #64]
+	ldr	x7, [sp, #80]
 
 	/* Restore FP and LR */
-	ldp     x29, x30, [sp], #64
+	ldp     x29, x30, [sp], #96
 
 	ret
 SYM_FUNC_END(arch_bpf_timed_may_goto)
diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index fcf850f244c9..6ec37f634aff 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -10,15 +10,16 @@
  *	- output: updated count in BPF_REG_AX (t0)
  *
  * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
- * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (t6, a0-a4) are saved
- * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
+ * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (t6, a0-a4) and stack
+ * arguments 6-8 (a5-a7) are saved across the call; BPF_REG_FP (s5) is
+ * callee-saved and needs no saving.
  */
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
-	addi	sp, sp, -(8*SZREG)
-	REG_S	ra, 7*SZREG(sp)
-	REG_S	s0, 6*SZREG(sp)
-	addi	s0, sp, 8*SZREG
+	addi	sp, sp, -(12*SZREG)
+	REG_S	ra, 11*SZREG(sp)
+	REG_S	s0, 10*SZREG(sp)
+	addi	s0, sp, 12*SZREG
 
 	/* Save BPF registers R0-R5 (t6, a0-a4) */
 	REG_S	t6, 5*SZREG(sp)
@@ -27,6 +28,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_S	a2, 2*SZREG(sp)
 	REG_S	a3, 1*SZREG(sp)
 	REG_S	a4, 0*SZREG(sp)
+	/* Save stack arguments 6-8 (a5-a7) */
+	REG_S	a5, 6*SZREG(sp)
+	REG_S	a6, 7*SZREG(sp)
+	REG_S	a7, 8*SZREG(sp)
 
 	add	a0, t0, s5
 	call	bpf_check_timed_may_goto
@@ -39,9 +44,13 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_L	a1, 3*SZREG(sp)
 	REG_L	a0, 4*SZREG(sp)
 	REG_L	t6, 5*SZREG(sp)
+	/* Restore stack arguments 6-8 */
+	REG_L	a5, 6*SZREG(sp)
+	REG_L	a6, 7*SZREG(sp)
+	REG_L	a7, 8*SZREG(sp)
 
-	REG_L	s0, 6*SZREG(sp)
-	REG_L	ra, 7*SZREG(sp)
-	addi	sp, sp, 8*SZREG
+	REG_L	s0, 10*SZREG(sp)
+	REG_L	ra, 11*SZREG(sp)
+	addi	sp, sp, 12*SZREG
 	ret
 SYM_FUNC_END(arch_bpf_timed_may_goto)
diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index 6c6e03f725a3..dd2dde89836b 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -22,6 +22,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	pushq %rdx
 	pushq %rcx
 	pushq %r8
+	/* Save stack argument 6. */
+	pushq %r9
 
 	/*
 	 * r10 has the pointer to count and timestamp. JIT added the frame
@@ -36,6 +38,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/* BPF_REG_AX=r10 will be stored into count, so move return value to it. */
 	movq %rax, %r10
 
+	popq %r9
 	/* Restore r5-r0. */
 	popq %r8
 	popq %rcx
-- 
2.55.0

