Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483783;
	b=Fx8J+FMadxLodE6tfYSstwYSu6ZRTsiQ+4EjvxDcdWDTpSesGXBXiUFX3sqihVui8y2G
	 aKq1ay7zx/mYGD5qfgAkxY/RmJk/nXa0XXtCY6AjqyVZR9gfZZJ9auCl6RJgzZvfOpN0C
	 3t2ljLfl7nwFtHmKvvyioYq+nvXuq8ADxyyL53GkKyb0estw8cw+WOadw/mplbWUwmaHw
	 Iaw/APDei6p/Yjrq4aiE+k445BsVDIzNnbKS1wswE9A7vmNDo7uO5yqnHZylpc10UBgp8
	 v1Qg8OV7BBPsW5hBcsu3LsTQ5MQxcf2wWhyzRHXnrJwZ73q407Vh6yfti+uD0Rm4JHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Z14F9AXR/U4HGMlWPMBeVu92FeLmhNWlmEPG2H0/UM=;
	b=zdNk14jIx+8WDsLdm+JGUb4EII3la+uo98HMJ9fLhs2q5+UlpFYRSr8ennWS2Wy2/wwo
	 grvFOceQXpxSxtw6XZqoNRe/SwvaqEPeKFjAygVeZCD03lfGQBgRUqnIsFNx6bJetz09N
	 ja/7iKRhoouoFKHKmI5l1HnaR3vZ3lqSbZaNYhRn6+rXFdh6/jiYm5FGtYy0FmM/zER5+
	 poatg7Qc+NGtlWN3GpMEhbFBBXnAEDEOTBqtVB+55V9cAbSXH1G6BOESRlrUBi6BFMRZc
	 CE6RJ1cNObnXl4yKzzMQl2ddigqbVl6b9Dh5NZOWqc1oOI1gDYxM/MtkZhVfwiAx3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enaBFyb3;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915C606A320
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E915C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enaBFyb3
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso722764b3a.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483782; x=1794088582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Z14F9AXR/U4HGMlWPMBeVu92FeLmhNWlmEPG2H0/UM=;
        b=enaBFyb3OCBoc3nPgCw2qCuepVzSbkzF2ZeqNpXy77D0TTmrY+OqKA7hdqQjbI0eGy
         BEAoLudVWwPyqD71wz5ZXBIQX8F4TfISubg4lERW1rhoSDttumrcBiYrNzvCfRk8V88O
         za2jl+6CSDAJG9nO4O3EOvlX6n6UTPmOoMS395I4UIPFS9UwZctdKcpnMRzFp/JyZjhY
         M7Ld5tPHaVB4mby1FVOh89TdabjxZXKVy6zJG8rz70lKFdpt22ox1R/3yAsfIn2pyGBs
         uGVzJ3Bpa4P4vDrjFrIPJ7azGuM+lR9jgQ8U0tIJv95zhJpaYvnWxPfkeCm62UmTuBax
         8vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483782; x=1794088582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Z14F9AXR/U4HGMlWPMBeVu92FeLmhNWlmEPG2H0/UM=;
        b=KnC5bhGSa+P8/pHNEsrcYUkengUZe7lNXKnF3gsB7W65WIkNceFR5psv3hAoR46l7d
         R3E3r7FEqteBMEBUkcC81Y8Fs42qhzn+hn83dDdmb1ur7ER/e4RXO/EPpJtdUaiX+OuG
         Ji/YaT9wssFsMohvN+XI+vrjfVzCxNygdzzQuyXJZZZyc0pYvuOiMqw803K6LpNifT2Q
         d01mBDa3gzbvXBfFrQhEwN7I6jDFxPtYW+YgAInfVnAed731k6RUoKY4QTHgrnGW8BKC
         JlyrCKiCVIFAIyVzA0TEzDKPghr80oFrjykcNtzQnfmknQwgX9DJDXy04tr+7AonDqfT
         d/pw==
X-Gm-Message-State: AFq9FYLE9n/SEWLGa0q6sthD2AVkyDHxLX2coUTqqlB5tCvbsqTS0y8o
	tgBPojOue921M7xS3qVHbcxbn5Iehrp0KoIMG7A2V3c0mSlkR0m3+EhgIxfPQg==
X-Gm-Gg: AYBFou2ZsM1vhqwhosL2JrkfanheEC1q6xug+V7wGb5WWQaoR65bDHS6aafv4BT6lzP
	hfrhO3ss9oLiSgZK+39UC/6EzVFa7cVrjTzljpnwuqU8VdPOjMw3pRdZ4QuQiQMaAFSSlmo+jSm
	bbr7X+sDMo1r94vFIU7maFo0AVSZ7l4KneR4T1+Zq2uuNxL9tAN6XVdcHJiqEWLZ58Vgs6hHVmx
	lxhdz89HiGxEiO/ov9JRTEz9/OLM0C2sjU37bZMKEOKg6NfSknmVQ4HqAebL/fZfVdW8mV2g7/z
	KMk/7/WrcZ1vvdic7YKSZeKgi1X2RqsKSgQ73AA0M75MkHTfgapLzzs+JBrZMnv9bkNwvFV6n8L
	3ClqPrWeAD57Au/BZ6ny2YzfCkruwwq2Kr7TW8QQvUTF2MYGBeGV0I51vvjTzrX4eN0KEhedDYH
	grTo3mDzj6gKjp5TkbBW7fyU1t/tjaZt4dv0uU9f4FNVWgQPQuX3ZUDepQNkqJ37MZ0MII+H7q9
	tZFCjiprqkW+W/jzj9t1JhJ03c7yzxxSjnQBZlvZGBaP+ishDuC5IzV0Gb6CPAEPehhimiBCYsW
	+m4O8/M1j5QMAErKAHWMIPL6kEYdwGCfgqMgr9isjD3bmCFl0sZTJa+MONmvBWFGPyk7poQyGlm
	1TBvTYuP8jjijXPfEEaHMmC4w6oFkV+u9WFA4o2INAaKFD2G0QSACtOD+43JedCK/T0syOqpfxA
	==
X-Received: by 2002:a05:6a00:3a1b:b0:882:94ab:20ec with SMTP id d2e1a72fcca58-8a9be587fd4mr5030491b3a.25.1793483781927;
        Sat, 31 Oct 2026 14:56:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9637b75sm873511b3a.17.2026.10.31.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 6/9] bpf: Pass a pointer to arch_bpf_timed_may_goto()
Date: Sat, 31 Oct 2026 21:55:40 +0000
Message-ID: <20261031215543.682284-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

arch_bpf_timed_may_goto() gets the offset of count and timestamp in the
stack frame in BPF_REG_AX. Arch code adds the frame pointer to it, and
calls bpf_check_timed_may_goto() with the result. On arm64, riscv,
loongarch, powerpc and s390 the asm function does it. On x86-64 the JIT
does it, because the frame pointer is in another register when the prog has
a private stack.

The next patch moves count and timestamp out of the stack frame. So pass
the pointer in BPF_REG_AX, and let the verifier emit the addition:

  before                           after

  r12 = -16                        r12 = r10
  call arch_bpf_timed_may_goto     r12 += -16
                                   call arch_bpf_timed_may_goto

The JITs know which register r10 is. The asm functions have a move in place
of the addition, and the special case in the x86-64 JIT goes away.

These insns run when the count is used up: in each 65535th iteration. The
cost of an iteration does not change.

Three tests have the insns of may_goto in them. Update them.

Tested on x86-64, and on arm64 and s390 in QEMU. riscv, loongarch and
powerpc are compile tested only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
 arch/loongarch/net/bpf_timed_may_goto.S       | 10 ++-----
 arch/powerpc/net/bpf_timed_may_goto.S         |  9 ++----
 arch/riscv/net/bpf_timed_may_goto.S           | 10 +++----
 arch/s390/net/bpf_jit_comp.c                  |  6 ++--
 arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
 arch/x86/net/bpf_jit_comp.c                   | 12 --------
 arch/x86/net/bpf_timed_may_goto.S             |  5 +---
 kernel/bpf/fixups.c                           |  9 +++---
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 11 files changed, 51 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index 1b4a4f91ffc9..f8732b13bb1e 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -17,16 +17,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	str	x7, [sp, #80]
 
 	/*
-	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
-	 * (x25) to get the pointer to count and timestamp and pass it as the
-	 * first argument in x0.
-	 *
-	 * Before generating the call to arch_bpf_timed_may_goto, the verifier
-	 * generates a load instruction using FP, i.e. REG_AX = *(u64 *)(FP -
-	 * stack_off_cnt), so BPF_REG_FP (x25) is always set up by the arm64
-	 * jit in this case.
+	 * The pointer to count and timestamp was passed in BPF_REG_AX (x9),
+	 * pass it as the first argument in x0.
 	 */
-	add	x0, x9, x25
+	mov	x0, x9
 	bl	bpf_check_timed_may_goto
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
 	mov	x9, x0
diff --git a/arch/loongarch/net/bpf_timed_may_goto.S b/arch/loongarch/net/bpf_timed_may_goto.S
index fa128acdb108..4aaca029404b 100644
--- a/arch/loongarch/net/bpf_timed_may_goto.S
+++ b/arch/loongarch/net/bpf_timed_may_goto.S
@@ -22,14 +22,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	st.d		a4, sp, 48
 
 	/*
-	 * BPF_REG_AX (t0) holds the offset passed in by the verifier;
-	 * add it to BPF_REG_FP (s4) to get the pointer to the count and
-	 * timestamp, then pass it as the first argument in a0.
-	 *
-	 * The verifier emits a load using FP right before this call,
-	 * so BPF_REG_FP (s4) is always set up by the JIT in this case.
+	 * BPF_REG_AX (t0) holds the pointer to the count and timestamp;
+	 * pass it as the first argument in a0.
 	 */
-	add.d		a0, t0, s4
+	move		a0, t0
 	bl		bpf_check_timed_may_goto
 	/* BPF_REG_AX (t0) will be stored into count, so move the return value to it. */
 	move		t0, a0
diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
index 84ecf6fa7f5d..b8ae9885eb31 100644
--- a/arch/powerpc/net/bpf_timed_may_goto.S
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -8,7 +8,7 @@
  * arch_bpf_timed_may_goto() trampoline for powerpc64
  *
  * Custom BPF convention (verifier/JIT):
- *	- input:  stack offset in BPF_REG_AX (r12)
+ *	- input:  pointer to count and timestamp in BPF_REG_AX (r12)
  *	- output: updated count in BPF_REG_AX (r12)
  *
  * Call bpf_check_timed_may_goto(ptr) with normal powerpc64 ABI:
@@ -31,11 +31,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	std     r7, 64(r1)
 	std     r8, 72(r1)
 
-	/*
-	 * r3 = BPF_REG_FP + BPF_REG_AX
-	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
-	 */
-	add     r3, r31, r12
+	/* r3 = BPF_REG_AX (r12) */
+	mr      r3, r12
 	bl      CFUNC(bpf_check_timed_may_goto)
 
 	/* Put return value back into AX */
diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index 6ec37f634aff..2ce1c89c913e 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -6,13 +6,11 @@
 
 /*
  * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
- *	- input:  stack offset in BPF_REG_AX (t0)
+ *	- input:  pointer to count and timestamp in BPF_REG_AX (t0)
  *	- output: updated count in BPF_REG_AX (t0)
  *
- * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
- * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (t6, a0-a4) and stack
- * arguments 6-8 (a5-a7) are saved across the call; BPF_REG_FP (s5) is
- * callee-saved and needs no saving.
+ * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI. BPF R0-R5
+ * (t6, a0-a4) and stack arguments 6-8 (a5-a7) are saved across the call.
  */
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
@@ -33,7 +31,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_S	a6, 7*SZREG(sp)
 	REG_S	a7, 8*SZREG(sp)
 
-	add	a0, t0, s5
+	mv	a0, t0
 	call	bpf_check_timed_may_goto
 	mv	t0, a0
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ec32e10be24b..15029cedc50b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1877,9 +1877,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if ((void *)func == arch_bpf_timed_may_goto) {
 			/*
 			 * arch_bpf_timed_may_goto() has a special ABI: the
-			 * parameters are in BPF_REG_AX and BPF_REG_10; the
-			 * return value is in BPF_REG_AX; and all GPRs except
-			 * REG_W0, REG_W1, and BPF_REG_AX are callee-saved.
+			 * parameter is in BPF_REG_AX; the return value is in
+			 * BPF_REG_AX; and all GPRs except REG_W0, REG_W1, and
+			 * BPF_REG_AX are callee-saved.
 			 */
 
 			/* brasl %r0,func */
diff --git a/arch/s390/net/bpf_timed_may_goto.S b/arch/s390/net/bpf_timed_may_goto.S
index 06f567a460d7..05f532f8c639 100644
--- a/arch/s390/net/bpf_timed_may_goto.S
+++ b/arch/s390/net/bpf_timed_may_goto.S
@@ -21,9 +21,9 @@
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/*
-	 * This function has a special ABI: the parameters are in %r12 and
-	 * %r13; the return value is in %r12; all GPRs except %r0, %r1, and
-	 * %r12 are callee-saved; and the return address is in %r0.
+	 * This function has a special ABI: the parameter is in %r12; the
+	 * return value is in %r12; all GPRs except %r0, %r1, and %r12 are
+	 * callee-saved; and the return address is in %r0.
 	 */
 	stmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
 	stg %r14,FRAME_OFF+R14_OFF(%r15)
@@ -33,7 +33,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	lay %r15,-FRAME_SIZE(%r15)
 	stg %r1,__SF_BACKCHAIN(%r15)
 
-	lay %r2,0(%r12,%r13)
+	lgr %r2,%r12
 	brasl %r14,bpf_check_timed_may_goto
 	lgr %r12,%r2
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d90b6d238b3a..38871963e676 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3436,18 +3436,6 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
 							   outgoing_rsp, &prog);
 			}
-			if (func == (u8 *)arch_bpf_timed_may_goto) {
-				u32 fp = priv_frame_ptr ? X86_REG_R9 : BPF_REG_FP;
-
-				/*
-				 * AX has the offset of count and timestamp
-				 * in the stack. Turn it into a pointer.
-				 * add r10, rbp or add r10, r9
-				 */
-				maybe_emit_mod(&prog, BPF_REG_AX, fp, true);
-				EMIT2(0x01, add_2reg(0xC0, BPF_REG_AX, fp));
-				ip += 3;
-			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip += 2;
diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index dd2dde89836b..da42de7cca98 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -25,10 +25,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/* Save stack argument 6. */
 	pushq %r9
 
-	/*
-	 * r10 has the pointer to count and timestamp. JIT added the frame
-	 * pointer to the offset. Pass it as first argument.
-	 */
+	/* r10 has the pointer to count and timestamp. Pass it as first argument. */
 	movq %r10, %rdi
 
 	/* Emit call depth accounting for call below. */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index bb6b57f5e144..5cbab55d84be 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2083,14 +2083,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
 			int stack_off_cnt = -stack_depth - 16;
 			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
+			 * AX is used as an argument to pass in the pointer to
+			 * count and timestamp, and also as the return value of
 			 * the call to arch_bpf_timed_may_goto.
 			 */
 			struct bpf_insn tail[] = {
 				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
-				BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2),
-				BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt),
+				BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 3),
+				BPF_MOV64_REG(BPF_REG_AX, BPF_REG_10),
+				BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt),
 				BPF_EMIT_CALL(arch_bpf_timed_may_goto),
 				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt),
 			};
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index e0c389102db9..faedf36eef2a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -914,15 +914,16 @@ __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
 __xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+6")
+__xlated("7: if r12 == 0x0 goto pc+7")
 __xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+2")
-__xlated("10: r12 = -24")
-__xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) = r12")
+__xlated("9: if r12 != 0x0 goto pc+3")
+__xlated("10: r12 = r10")
+__xlated("11: r12 += -24")
+__xlated("12: call unknown")
+__xlated("13: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("13: *(u64 *)(r10 -8) = r1")
-__xlated("14: exit")
+__xlated("14: *(u64 *)(r10 -8) = r1")
+__xlated("15: exit")
 __success
 __naked void may_goto_interaction_x86_64(void)
 {
@@ -955,15 +956,16 @@ __xlated("2: r1 = 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
 __xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+6")
+__xlated("5: if r12 == 0x0 goto pc+7")
 __xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+2")
-__xlated("8: r12 = -24")
-__xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) = r12")
+__xlated("7: if r12 != 0x0 goto pc+3")
+__xlated("8: r12 = r10")
+__xlated("9: r12 += -24")
+__xlated("10: call unknown")
+__xlated("11: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("11: *(u64 *)(r10 -8) = r1")
-__xlated("12: exit")
+__xlated("12: *(u64 *)(r10 -8) = r1")
+__xlated("13: exit")
 __success
 __naked void may_goto_interaction(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index c19b0522df61..2de1ae144ac9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -91,15 +91,16 @@ __arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+6")
+__xlated("3: if r12 == 0x0 goto pc+7")
 __xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+2")
-__xlated("6: r12 = -16")
-__xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) = r12")
-__xlated("9: r0 = 1")
-__xlated("10: r0 = 2")
-__xlated("11: exit")
+__xlated("5: if r12 != 0x0 goto pc+3")
+__xlated("6: r12 = r10")
+__xlated("7: r12 += -16")
+__xlated("8: call unknown")
+__xlated("9: *(u64 *)(r10 -16) = r12")
+__xlated("10: r0 = 1")
+__xlated("11: r0 = 2")
+__xlated("12: exit")
 __success
 __naked void may_goto_batch_2(void)
 {
-- 
2.55.0

