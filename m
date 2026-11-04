Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755517;
	b=hO1GtoPmFrzTUgw1b0aqYR3Aezs1qXU/+MW2bVQq2N4EmIQdDTPOq/LAnvaX6hIOHN+g
	 trQ9qVd2NFek8BuEkeaBPVI1FMW0VL6MalrOEZywdTWhul3zuagK2jpZvQVNsWlIfL/5S
	 gpJ5UbDmfF5zgkLRvx6mhKIV6Ydnof15aGYoBka8aUKMnq+K1v1ZCDkKuyME7n5QhNqpp
	 w6ANt1xHAvelksb5VX0UVa6SrCIEC/Dppc6PEAAbA2CEt3MQsQYt/doM9O9Gl0lb8OVSd
	 iZ9MObS4GiODoxJupcelfClY/702/mr+PAQH/p/L+tek3flI/wzwVKORbS0tckrxOrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6MQKlHgkgwSeBh1mGnJOndb+pF4yahhBvxHb7BerzZ8=;
	b=1Ox8uMkmtdhdhOk4o2Brr8sHYnClAifruXrcEB7nUjjdim52mvPqIR4SSugLVVqvS7Ki
	 gTpdJbubXpymsgXEcGD6W3KLcI9+mimQt1GkU61VSp0+28k7UbgnAqijQ9OrNS2e7h1vE
	 hUeBTrO+RDNaZyCEyYrS4SARbylhqsXwlA9u9/EoCB3i+J1hwvRKYfWFoqsBt9Ed4t45X
	 iDn0hKDXE69qe15xpYbLzCKeVcq8rtp9xUsLA8lqWi/l6gc1afegt5wJbwFss+jls38iG
	 Xbug9tVJS0W4c8kffVK5NsO4GVYf7dKU1znaCdErg3ByxMjXbsdXYG5DnBkwkLvh7EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TV+0GAj5;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B823606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B823606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TV+0GAj5
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab41538192so205885a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755516; x=1794360316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6MQKlHgkgwSeBh1mGnJOndb+pF4yahhBvxHb7BerzZ8=;
        b=TV+0GAj5d856890KY4vTQduTxxeQ05Xg5taU5jygtvvJcKD+w7BJ8jmCcDiWgGQRmv
         RvJrDQr91QmhSmsc+e/YNdRcvMmIAoJlxCNv9n40H+ixkrtigqVsG3P/wcvpuX5YWnyl
         NYqKA5UHD3BQ/qWw+wmRzCsrO1d9FMiusbptEnydS3DdjDrBTh/teenYBsuMRyRD02IE
         BlCiOjpe2vOTPec5JNeSAEOvF1S3XP09TcWLyvHwCs3mZkrkd3kAHFiAE6qxkfNkRvTZ
         JKGbb/UaP2dAyJjJD9KXDFFvlcVi87pFHuZXpiKhXb3i/MgV/0yUl8gosoSebgs3cMU+
         a4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755516; x=1794360316;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MQKlHgkgwSeBh1mGnJOndb+pF4yahhBvxHb7BerzZ8=;
        b=HUe/RrXM0ZKYQQIsAsxRbVhddIynXMfUvReENMTyKB/s6bC2IzMIdb1BRgrpafIil1
         cTp6OGc5aiMPf1o6FdRUrzxm/zTNogGpnuDJt3ZgvjtytrapvjpUE2QyVmfeyWZIUmml
         7htgB1YThTkAU6ZIySzS+2O8y5ugDn50VwTYvwA4SMpDJhfIE7IEJh9hcGF3gX1UJh/5
         ul6622XTTPJsTCryq3El3B2Sc7nGC3xSZDrOYBVBuymavasJQZqpFbdu8OUuiShzBN7I
         OYXwHPbQ/xfA52jeVEgFOj0nft2s9rx1tjQV7Nuq8Sh02xa8pVJKnVvPrch9Q0Mn0plj
         Dq4g==
X-Gm-Message-State: APuU4Z/0OjNvOwqiJ/v7eg/6X/us/6HwhbP4C+oTtbDFvuHAis3egveZ
	JLNLiALwk0zZ4vn9n3Fmh0WDaxwL7ZCjGnQiMEyHC44LUDRiiQI+mBW6qeYzAg==
X-Gm-Gg: AYBFou0AwfUX66dRdFYP3Po8ioCl8vUuMXgerxU3gqdsFcZQy53NqYznGVVhFuErRT7
	RmKBq7iBwACWiKMhYL2TpbIi0unIFBac2nzkrq0AMfGHwdLdVhDrwk3EQfgeS+YP1ZzkG4ziALb
	IHTEQ6vp+m5OmtySO23RATsL2YgtiKxTgwlusVv2r72Tsj6ynXekvsTFQAHFpma8tBewvO7BCt+
	t+sQrzsSB3ZK5NWAOtr+BC2X2Xdd+ScmslRzcRCCvxzzg1YvsyRacaPP4ApKv47Iyp0ZSw6VFpT
	icMTUJC67RFPtPbi666UAaD/deBcGOiGvmhpvOO3+3FsbHI09YA7fh1iamo/IDT8aQBFV6X4zUA
	Sgz+dkSQysnPOpOADvffVOa/FAUMawXdrv3ZqmDnuEXmAeGLaZa00z4XIqClQMMPnUKefTU5mdI
	j6kvNVwo/DVN6s2h9h5YvnYvxVEdhBlpeCkOyG+pQP3N/fTZt+WoYtSlLNft1xUAofn3IFi1DnH
	jpIAqdKwOhdH9K83pkQx7DpkS+EcpC5BlvtTTyLTsgOWXmx4NdKquID6/85Vp4h+hIoLejLFElf
	HoHxtRIeOD0LzwtjN/jdIglYrFOFOXTzyzu3X3rBaYyc21rpp1uqSx6Os/xwP6pIe8vMG+y3p+i
	PTpUY/ntPjlxDVaEO1EzONcWuOPPxoCLWVFNYWyhtcuN8cpQLejn1P3NpIJT8e+CAXYnLBfmpgf
	BFcPpoNPZUZrDseqreoLoB
X-Received: by 2002:a17:90a:d803:b0:3b0:9a0d:b825 with SMTP id 98e67ed59e1d1-3b09a0db95fmr195161a91.45.1793755515774;
        Tue, 03 Nov 2026 17:25:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e087csm6607898a91.4.2026.11.03.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:25:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 12/14] bpf, x86: Support BPF_REG_ARENA_SP
Date: Wed,  4 Nov 2026 01:23:58 +0000
Message-ID: <20261104012401.1354861-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

BPF r12 (BPF_REG_ARENA_SP) is the stack pointer of the stack in arena. It
needs an x86 register for the full run of the prog. R9 is the only x86
register that has no fixed function. Map r12 to R9.

R9 has other uses too. In a prog that uses r12 the JIT changes them:

  R9 is also                        in a prog with r12
  --------------------------------  -------------------------------------
  clobbered by helpers and kfuncs   store R9 in the frame before the call,
                                    load it after the call
  arg 6 of a BPF-to-BPF call        arg 6 is on the stack, before arg 7
  arg 6 of a kfunc                  load arg 6 from the stack into R9,
                                    move rsp to arg 7 for the call. Only
                                    for a kfunc with more than 5 args
  frame pointer of private stack    the private stack is off

To reject 6 arguments in such progs is not possible, because Rust
functions have them. r12 in a slot of the frame costs a load for each
access.

Only JITed code sees the arguments of a BPF-to-BPF call, because no
trampoline attaches to a subprog of a prog with r12. Thus the JIT can
select the location of arg 6.

Progs without r12 get the same JITed code. The cost in a prog with r12, in
a hot loop on x86-64 (Zen 5), in nsec:

  call of a helper or a kfunc       store and load of R9      0.012
  function that has such a call     push r9, add rsp, 8       < 0.01
  BPF-to-BPF call with 6 or 7 args  arg 6 is on the stack     < 0.007
  call of a kfunc with 10 args      load of R9, moves of rsp  0.13 to 0.27

The last time depends on the address of the kfunc.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 140 +++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 711d774b40e1..320cf9b526b3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -155,8 +155,9 @@ static int bpf_size_to_x86_bytes(int bpf_size)
  * register in load/store instructions, it always needs an
  * extra byte of encoding and is callee saved.
  *
- * x86-64 register R9 is not used by BPF programs, but can be used by BPF
- * trampoline. x86-64 register R10 is used for blinding (if enabled).
+ * x86-64 register R9 is the 6th argument, the frame pointer of the private
+ * stack, or BPF_REG_ARENA_SP. It can be used by BPF trampoline.
+ * x86-64 register R10 is used for blinding (if enabled).
  */
 static const int reg2hex[] = {
 	[BPF_REG_0] = 0,  /* RAX */
@@ -170,6 +171,7 @@ static const int reg2hex[] = {
 	[BPF_REG_8] = 6,  /* R14 callee saved */
 	[BPF_REG_9] = 7,  /* R15 callee saved */
 	[BPF_REG_FP] = 5, /* RBP readonly */
+	[BPF_REG_ARENA_SP] = 1, /* R9 */
 	[BPF_REG_AX] = 2, /* R10 temp register */
 	[AUX_REG] = 3,    /* R11 temp register */
 	[X86_REG_R9] = 1, /* R9 register, 6th function argument */
@@ -187,6 +189,7 @@ static const int reg2pt_regs[] = {
 	[BPF_REG_7] = offsetof(struct pt_regs, r13),
 	[BPF_REG_8] = offsetof(struct pt_regs, r14),
 	[BPF_REG_9] = offsetof(struct pt_regs, r15),
+	[BPF_REG_ARENA_SP] = offsetof(struct pt_regs, r9),
 	[BPF_REG_AX] = offsetof(struct pt_regs, r10),
 };
 
@@ -211,6 +214,7 @@ static bool is_ereg(u32 reg)
 			     BIT(BPF_REG_9) |
 			     BIT(X86_REG_R9) |
 			     BIT(X86_REG_R12) |
+			     BIT(BPF_REG_ARENA_SP) |
 			     BIT(BPF_REG_AX));
 }
 
@@ -2326,6 +2330,37 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	return 0;
 }
 
+/*
+ * Helpers and kfuncs clobber R9, which is BPF_REG_ARENA_SP. It's set after
+ * bpf_arena_stack_get() and is not used after bpf_arena_stack_put().
+ */
+static bool call_clobbers_arena_sp(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg != BPF_PSEUDO_CALL &&
+	       insn->imm != BPF_CALL_IMM(bpf_arena_stack_get) &&
+	       insn->imm != BPF_CALL_IMM(bpf_arena_stack_put);
+}
+
+/* Does the kfunc take more arguments than R1-R5 hold? */
+static bool kfunc_has_stack_args(const struct btf_func_model *fm)
+{
+	u32 i, nslots = 0;
+
+	for (i = 0; i < fm->nr_args; i++)
+		nslots += btf_func_model_arg_slots(fm, i);
+	return nslots > MAX_BPF_FUNC_REG_ARGS;
+}
+
+static bool calls_clobber_arena_sp(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->len; i++)
+		if (call_clobbers_arena_sp(&prog->insnsi[i]))
+			return true;
+	return false;
+}
+
 static const struct bpf_jit_arg_abi x86_arg_abi = {
 	.nr_arg_regs		= 6,
 	.backfill_after_stack	= true,
@@ -2533,16 +2568,23 @@ static u64 bpf_unwind_target(u64 ret_addr)
 	return e ? ret_addr + e->fixup : ret_addr;
 }
 
-/* unwind_exit: fix the return address of this frame. r0 and r2 are returned. */
-static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
+/*
+ * unwind_exit: fix the return address of this frame. r0 and r2 are returned.
+ * So is BPF_REG_ARENA_SP, when it's used.
+ */
+static int emit_unwind_ret_addr(u8 **pprog, u8 *ip, bool arena_sp)
 {
 	u8 *prog = *pprog, *start = prog;
 
 	EMIT2(0x50, 0x56);			/* push rax; push rsi */
+	if (arena_sp)
+		push_r9(&prog);
 	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
 	if (emit_rsb_call(&prog, bpf_unwind_target, ip + (prog - start)))
 		return -EINVAL;
 	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
+	if (arena_sp)
+		pop_r9(&prog);
 	EMIT2(0x5E, 0x58);			/* pop rsi; pop rax */
 	*pprog = prog;
 	return 0;
@@ -2567,6 +2609,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u32 stack_depth;
 	int callee_saved_size;
 	s32 outgoing_arg_base;
+	/* the program uses BPF_REG_ARENA_SP, which is R9 */
+	bool arena_sp = bpf_prog->aux->arena_stack_size;
+	/* it has to be saved around calls of helpers and kfuncs */
+	bool arena_sp_save = arena_sp && calls_clobber_arena_sp(bpf_prog);
+	s32 arena_sp_off = 0;
 	int err;
 
 	stack_depth = bpf_prog->aux->stack_depth;
@@ -2591,12 +2638,21 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 * is disabled by the JIT when stack args exist, so R9 is always
 	 * available.
 	 *
+	 * Unless the program uses BPF_REG_ARENA_SP. Then for BPF-to-BPF calls
+	 * arg 6 is on the stack too: incoming args 6+ are at [rbp + 16], ...
+	 * and outgoing args 6+ are at [rsp], ... No trampoline is attached to
+	 * subprogs of such program. For a kfunc call arg 6 is moved to R9 and
+	 * rsp is moved to arg 7.
+	 * Helpers and kfuncs clobber R9. BPF_REG_ARENA_SP is stored in the frame
+	 * before the call and is loaded from there after it.
+	 *
 	 * Stack layout (high to low):
 	 *   [rbp + 16 + ...]    incoming stack args 7+ (from caller)
 	 *   [rbp + 8]           return address
 	 *   [rbp]               saved rbp
 	 *   [rbp - prog_stack]  program stack
 	 *   [below]             callee-saved regs
+	 *   [below]             BPF_REG_ARENA_SP, when it's used and there are calls
 	 *   [below]             outgoing args 7+ (= rsp)
 	 */
 	if (bpf_prog_uses_arena_insns(bpf_prog)) {
@@ -2655,19 +2711,29 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 * stack args exist, so tcc pushes need not be accounted for.
 	 */
 	outgoing_arg_base = -(round_up(stack_depth, 8) + callee_saved_size);
+	if (arena_sp_save) {
+		/* make the slot */
+		push_r9(&prog);
+		outgoing_arg_base -= 8;
+		arena_sp_off = outgoing_arg_base;
+	}
 
 	/*
 	 * Allocate outgoing stack arg area for args 7+ only.
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
+	if (arena_sp)
+		outgoing_rsp = out_stack_arg_cnt * 8;
 	/*
 	 * bpf_throw() sees rsp of this frame as it is at a call. The callee-saved
 	 * regs are above the outgoing args, or above r9, which is pushed around
-	 * every call when the stack is private.
+	 * every call when the stack is private. With BPF_REG_ARENA_SP the slot
+	 * that keeps r9 over calls is between the two.
 	 */
 	if (bpf_prog->aux->exception_boundary)
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp + (priv_frame_ptr ? 8 : 0);
+		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp +
+						     (priv_frame_ptr || arena_sp_save ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
@@ -3089,7 +3155,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ST | BPF_MEM | BPF_H:
 		case BPF_ST | BPF_MEM | BPF_W:
 		case BPF_ST | BPF_MEM | BPF_DW:
-			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
+			if (dst_reg == BPF_REG_PARAMS && insn->off == -8 && !arena_sp) {
 				/* Arg 6: store immediate in r9 register */
 				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31,
 					       imm32);
@@ -3103,7 +3169,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
 				 */
 				insn_off = outgoing_arg_base - outgoing_rsp -
-					   insn_off - 16;
+					   insn_off - (arena_sp ? 8 : 16);
 				dst_reg = BPF_REG_FP;
 			}
 			if (!accesses_stack_only) {
@@ -3123,14 +3189,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
 		case BPF_STX | BPF_MEM | BPF_DW:
-			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
+			if (dst_reg == BPF_REG_PARAMS && insn->off == -8 && !arena_sp) {
 				/* Arg 6: store register value in r9 */
 				EMIT_mov(X86_REG_R9, src_reg);
 				break;
 			}
 			insn_off = insn->off;
 			if (dst_reg == BPF_REG_PARAMS) {
-				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
+				insn_off = outgoing_arg_base - outgoing_rsp - insn_off -
+					   (arena_sp ? 8 : 16);
 				dst_reg = BPF_REG_FP;
 			}
 			if (!accesses_stack_only) {
@@ -3239,11 +3306,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off = insn->off;
 			if (src_reg == BPF_REG_PARAMS) {
-				if (insn_off == 8) {
+				if (insn_off == 8 && !arena_sp) {
 					/* Incoming arg 6: read from r9 */
 					EMIT_mov(dst_reg, X86_REG_R9);
 					break;
 				}
+				if (arena_sp)
+					insn_off += 8;
 				src_reg = BPF_REG_FP;
 				/*
 				 * Incoming args 7+: native_off == bpf_off
@@ -3471,6 +3540,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			const struct btf_func_model *fm = NULL;
+			bool arena_sp_args = false;
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -3481,6 +3551,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (arena_sp && call_clobbers_arena_sp(insn)) {
+				u8 *start = prog;
+
+				emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_ARENA_SP, arena_sp_off);
+				ip += prog - start;
+			}
 			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
 				if (!fm)
@@ -3489,8 +3565,31 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip += err;
-				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
-							   outgoing_rsp, &prog);
+				/*
+				 * Other kfuncs leave rsp alone. bpf_throw() is one of
+				 * them, see stack_arg_sp_adjust.
+				 */
+				arena_sp_args = arena_sp && kfunc_has_stack_args(fm);
+				if (arena_sp_args) {
+					u8 *start = prog;
+
+					/*
+					 * Args 6+ are at [rsp]. Put arg 6 where
+					 * emit_kfunc_arg_moves() expects it.
+					 */
+					emit_ldx(&prog, BPF_DW, X86_REG_R9, BPF_REG_FP,
+						 outgoing_arg_base - outgoing_rsp);
+					ip += prog - start;
+				}
+				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base - outgoing_rsp +
+							   (arena_sp ? 8 : 0), &prog);
+				if (arena_sp_args) {
+					u8 *start = prog;
+
+					/* arg 7 is at [rsp] */
+					emit_add_rsp(&prog, 8);
+					ip += prog - start;
+				}
 			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
@@ -3501,6 +3600,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (arena_sp_args)
+				emit_sub_rsp(&prog, 8);
+			if (arena_sp && call_clobbers_arena_sp(insn))
+				emit_ldx(&prog, BPF_DW, BPF_REG_ARENA_SP, BPF_REG_FP, arena_sp_off);
 			/*
 			 * A kfunc returning more than 8 bytes hands the second
 			 * half back in RDX (the native ABI's second return reg),
@@ -3827,7 +3930,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_JMP | BPF_EXIT:
 			if (src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
-			    emit_unwind_ret_addr(&prog, ip))
+			    emit_unwind_ret_addr(&prog, ip, arena_sp))
 				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i] + moved;
@@ -3841,8 +3944,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
 					return -EINVAL;
 			}
-			/* Deallocate outgoing args 7+ area. */
-			emit_add_rsp(&prog, outgoing_rsp);
+			/* Deallocate outgoing args 7+ area and the slot of BPF_REG_ARENA_SP. */
+			emit_add_rsp(&prog, outgoing_rsp + (arena_sp_save ? 8 : 0));
 			if (bpf_prog->aux->exception_boundary) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
@@ -5190,6 +5293,11 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_local_atomics(void)
 {
 	return true;
-- 
2.55.0

