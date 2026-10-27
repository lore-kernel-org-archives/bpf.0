Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127833;
	b=R/bpcn8KnHsa9Z0eXy3+c6CH6Uix1BlW0egUaD57Xbo1UDKYRoofSP9SLBMLkbptUnBV
	 X6KrKHPO8MyO1n3d2znQRdkKN+Qc+vBqu1n1yPWr5WFZE2oukCNeQOL93sz1GYTjevDX2
	 vyYm0lhWwR9j55Y+X9oqXIj9TlJyghK5t+GdICnbYsYfKkAQp1d/sB/PAJ9XvEfstRTq3
	 XRi8TcDc0MJj9tr0/l3DnrvZf/LDQM+N9NwfAyYjXdZhZwPmvWjPBNJGeGXNtfzpPnA1c
	 EELgC6F2JJ3rtdyTcxjvOlfCZdN7Je1xVKI5Bvf5PxdlLcJm2F+y9tAZlYDNxfef/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
	b=Dp48GM6r0Yx3v0dZbJ7mLb/urhtOrySTpbnxRJz06Pmu/NTwv7O7s6sLqeXBlaBU6/9Z
	 LLkyVYNQHvtrOM3wK3BMOxrav2KwOOo+uNzioAAMYrDNchHFGEJ15I3qrx+0OGCrMVp/p
	 5eSsNV0bTHWIp2VpzFyGp5/RCPgvc8C1YRcjWe8+m+s8LHdyU5sUWcRnk6kNnh9Z/2vv0
	 PVY3lrVtTq1V+bN39FZakCJx47ShvZ9XuiP7i5HXt02EL2sgFIwpTNwASAuKev2ls9+v9
	 okdopZ7tMu8/wTlc0TJA93YlPdJuoNilXfzbIoxZ8+05ryy421eLRpn0QqfZy4WVDLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nIWyilIU;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2974606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2974606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nIWyilIU
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9eb579c0eso732655ad.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127832; x=1793732632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
        b=nIWyilIUzG7JQzw3vv7xAYGjHSxzXbEbJ1h/1TxsuAvmPQx+XJV8AiseEjkBDQDMqN
         o4QvaxW6HTzA4bfh2IXEZahUJiNZtihn7k3MksHcrqkklPeaZPb4GLP/XwH1aaIeOGxd
         DXpRlVMIThLdHPwQ+mSbnxJTul3l+ngqMPSoS/FDCgavpTVt2xNWm3NS0kO7FXvxb4S9
         4hqbzyKJumWa3mz7Un+BqNEoL0wXa50uGv99rGgkfBMIFVVZTCDTUIDSgxzs+HR99L4/
         j485oLPmc4W9mkYAMLIC8/vLTKmKFJmGXLGcK8s3aRStY1NnauvoF0VAK3SoLqC5wygP
         Oglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127832; x=1793732632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
        b=dp/NORYTObLOH7BxTRYZUiQVFJzt1y66gAG3nYzkV7osnFN+SeeZOA5122PntBhAg0
         8uw4cEobcU5MqTaEI5xXnD3kzSAw8QHoklF6xjYvn3td4T6KQD9tfXP2HobR8bB8fMLh
         ZUbatXtvddofo+DVLAyybqCupBjcxO/1qxynVvT6YUbZ655tIFkPtAbuiJ5ngLAHfTFq
         grmBI8NCRN3ln1xe2uiT5cZNZZNNz32H1CtaE2yFEXuhlIAKQDTgExrQr1TG98KxjwZJ
         RJqV00UslGN0rWYkfzKnsH+Mca2C7Xic5pmXvxwDNKvSJv+DeSl5qGmJLwV24ZxKXQL9
         ndiA==
X-Gm-Message-State: AFq9FYLtOyQpeJJMyIyw+KYSO+qSY0YOZO/kyUCN1KGrNDQhYLEIQdmy
	JTnCfYxRDtx/F37yL99vMX9x70aqOwJek20Tjw1k+3JlJgIZWbrFPDd+EtDtBw==
X-Gm-Gg: AYBFou0bDcjMNK+cZSjtKNRFnmVoCsYKjMHzFpHnaLb5mJqNu4zjYmoPx0I1LhrJWxW
	ji0rKD5EtZWzjGLEwoZzRtzUsD8aNehjaOB7nyJGCrvVDPyQuwYcABq2w/FmXpTbnc9WReGaknt
	EEM8oEHLbxfCf1iShRKSANRBsrAAixu/SiY38OJULBPHC9NUXRWmnaQ3V8ggKhzCLFV5MH1eMRS
	VdcSdgix8uXoFxZnTSCPsOp69smM1Pumo2L+cX7e4gQYx6K/hOwa0QGw9Q5mdxT9w1iRdLfz7Rp
	bdvN3PYcFZpb5LKBihYeByE7ml2NJVPzmgJVvB+RV+za0ZJ0CNas79VouzvYQ3IxmdOO3jbDVZB
	+u0HWDWz+kuVFvNKmGqmsrZV03OA4yLLDiYga5rjD3BZlCsMwYFc74Ar11xwUONHJJgALeC1yA9
	1TSfdc7o8vtRoje+a6ysGDGaMIsWywwtpBbDlPhEomTlj0Gclfwlr7es46WBT8v8AORf2uWbpQF
	7X2iNW8KiW3AlrAK69kvMp1CWEpdn8rsph7j+jYM7b4CscYIM2fEMv1oO+12tgFO2tHlQCsDshA
	ghQ9nFsdFuRYwTnd5jlZNkASlXXmYllYsq41ctXopX4K2tSPdCrgB9QrU3beGxvE/865aUnajxc
	4l7zSW2RXnCkJoEhgJFu9p415
X-Received: by 2002:a17:903:1a0d:b0:2e8:c331:fc30 with SMTP id d9443c01a7336-2eb0057f2b3mr2221845ad.69.1793127831951;
        Tue, 27 Oct 2026 12:03:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9e51dsm13612365ad.64.2026.10.27.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 06/19] bpf, x86: Remove r0_on_stack from fetching atomics in arena
Date: Tue, 27 Oct 2026 19:03:01 +0000
Message-ID: <20261027190314.1440199-7-alexei.starovoitov@gmail.com>
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

x86 has no fetching AND/OR/XOR. Thus the JIT emits a loop with cmpxchg.
cmpxchg uses RAX, and RAX holds BPF R0. Thus the JIT saves R0 before the
loop.

  prog                        the address is in   the JIT saves R0 in
  --------------------------  ------------------  -------------------
  without the flag            a BPF register      BPF_REG_AX
  with BPF_F_ARENA_SCALAR     BPF_REG_AX          the stack

The flag is removed. Remove the second variant.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 58 +++++++++----------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7bfb7210484e..d90b6d238b3a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1745,26 +1745,20 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 /*
  * A fetching AND/OR/XOR can't be implemented with a single x86 insn, so do a
  * CMPXCHG loop. @index_reg is X86_REG_R12 for an arena access or -1 otherwise.
- * Unless @r0_on_stack, the caller has substituted BPF_REG_AX for R0 in
- * @dst_reg and @src_reg.
+ * The caller has saved R0 in BPF_REG_AX and has substituted BPF_REG_AX for R0
+ * in @dst_reg and @src_reg.
  *
  * Both the load and the CMPXCHG can fault when accessing the arena, so their
  * addresses are handed back in @fault[0] and @fault[1]. A fault has to resume
  * at @resume, which is past the loop and past the move that delivers the old
  * value, but before R0 is restored. Both are NULL for the non-arena case,
  * which needs no fixup.
- *
- * R0 is expected to be saved in BPF_REG_AX by the caller, or pushed on the
- * stack if @r0_on_stack. In that case an R0 operand stays in the stack slot,
- * RAX ends up holding the old value that R0 is to return, and the slot is
- * dropped rather than popped.
  */
 static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
-				 u32 src_reg, int index_reg, bool r0_on_stack,
+				 u32 src_reg, int index_reg,
 				 u8 **fault, u8 **resume)
 {
 	bool is64 = BPF_SIZE(insn->code) == BPF_DW;
-	bool operand_on_stack = r0_on_stack && src_reg == BPF_REG_0;
 	u8 *branch_target, *prog = *pprog;
 	int err;
 
@@ -1783,15 +1777,7 @@ static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 	 * Perform the (commutative) operation locally, put the result in
 	 * the AUX_REG.
 	 */
-	if (operand_on_stack) {
-		/* mov r11, [rsp]: the operand is the R0 saved there, RAX is the old value */
-		if (is64)
-			EMIT4(0x4C, 0x8B, 0x1C, 0x24);
-		else
-			EMIT4(0x44, 0x8B, 0x1C, 0x24);
-	} else {
-		emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
-	}
+	emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
 	maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
 	EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
 	      add_2reg(0xC0, AUX_REG, src_reg));
@@ -1810,20 +1796,14 @@ static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 
 	/* ZF tells us whether we won the race. If it's cleared we need to try again. */
 	EMIT2(X86_JNE, -(prog - branch_target) - 2);
-	/* Return the pre-modification value, which RAX already is for R0 */
-	if (!operand_on_stack)
-		emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+	/* Return the pre-modification value */
+	emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
 
 	if (resume)
 		*resume = prog;
 
 	/* Restore R0 after clobbering RAX */
-	if (!r0_on_stack)
-		emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
-	else if (operand_on_stack)
-		EMIT2(0x41, 0x5B); /* pop r11, dropping the operand */
-	else
-		EMIT1(0x58); /* pop rax */
+	emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
 
 	*pprog = prog;
 	return 0;
@@ -3354,7 +3334,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			if (is_atomic_fetch) {
 				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
-							    real_src_reg, -1, false,
+							    real_src_reg, -1,
 							    NULL, NULL);
 				if (err)
 					return err;
@@ -3383,29 +3363,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 			if (is_atomic_fetch_op(insn)) {
 				u32 real_src_reg = src_reg, real_dst_reg = dst_reg;
-				/*
-				 * An access through a number has its address in
-				 * BPF_REG_AX (see arena_scalar_access()), so R0 is
-				 * saved on the stack instead, as div and mod do.
-				 */
-				bool r0_on_stack = dst_reg == BPF_REG_AX;
 				u8 *fault[2], *resume;
 				int j;
 
 				/* Will need RAX as a CMPXCHG operand so save R0 */
-				if (r0_on_stack) {
-					EMIT1(0x50); /* push rax */
-				} else {
-					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
-					if (src_reg == BPF_REG_0)
-						real_src_reg = BPF_REG_AX;
-					if (dst_reg == BPF_REG_0)
-						real_dst_reg = BPF_REG_AX;
-				}
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				if (src_reg == BPF_REG_0)
+					real_src_reg = BPF_REG_AX;
+				if (dst_reg == BPF_REG_0)
+					real_dst_reg = BPF_REG_AX;
 
 				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
 							    real_src_reg, X86_REG_R12,
-							    r0_on_stack, fault, &resume);
+							    fault, &resume);
 				if (err)
 					return err;
 
-- 
2.55.0

