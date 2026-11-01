Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502385;
	b=g03eVCmDvr+nWVH2CyOwYzbUW1gOCqcLH9UjVARli2zvUyrAQqeXK5tWbVbljsaPtjCW
	 hXkOVZn5GJdLM7IN1SfuMeBgTj5iuoiwCgC4Q5s61Br332Sk88L5x3zscdaGCkymdwbc3
	 FkmHhkGDac4C86W8YXjTZJZEqhfGw8Wn8lQFEjllkjA1BEETIlW4D5yw44Yt9U3wGoJbb
	 IgC0mVdzFcsy5Vqmc2KfhNOw69J3BjmmiXbTiEzuJ4wlXKq4OdAR1yVKq5qBXgS/0/nVr
	 uYZTvhMYAuT9VURbZCw4kTStTeZTAkKshGuD8nvVva2CXfJE3TKbC6hYFuJARbxufnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0t7EAn8icwjb38ymnkra53doWy29UDMHFHMkDt3DWjw=;
	b=QYdgzpZ5mdBr3Ce+ZBex9uo1Heke0nQ2k5E1aJetZj0cgPf2jvMs5ad9xeYIXnpJCBhD
	 hSwGD+0/hQs9qECQkoiqIG/4UZeMymCPMXYdRkH+YWkj1eLw1JUTUzqNoE2TwgYzol0f4
	 Yg4zfWxh/orlXvmUpqSt7yk6bGUePfIa0c8m/yc9aAtp5v3Z+bp57nZ9UQxc66TYdJAEv
	 PkBGcgCbDRMLBC87Wv6p9Wr05jEjCw+f540tljeASr9z80JQmFY5mDTi5tDt6TaHMwrKx
	 Dc1UixVI2bAdJc6PhlHtXI4ba/k+htRzgifONrwjcq3wk7+tDBaV5H6vBDoIOOPAd8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OuVxw/OP";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162A606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D162A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OuVxw/OP
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2eac4877accso6391045ad.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502384; x=1794107184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0t7EAn8icwjb38ymnkra53doWy29UDMHFHMkDt3DWjw=;
        b=OuVxw/OP/btL1Wh3GFKnhsGzjx1hV2j/RF3EJeZx4XJTk3eU32m+XrJFEzBz/W2/6A
         cPR3jNZewxQOaEC955cXcFupk5dWMJSV5KXgWUinhJCGwV5a2dnWbx7i6Fh7jJnyLGNv
         5FIMjr6fTm0XgoYzDZ0WwM2bh5PM7XdIjDa4LojzPJ2kD2rYnrF6o9pEMczhpPPDE+r+
         hUpmOX8KAdXOGvuIbW4xc7gvl43wHGB4a6CXlTIGSfgxE72C3X1/uIWBN9KaLbE+N+Tw
         R+dfkwlljjyT44qL9vY0qCAy9vnBGHI9usOcT3m6MEugViIEUIt96+J+Ma0dKkE/zlUJ
         /R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502384; x=1794107184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0t7EAn8icwjb38ymnkra53doWy29UDMHFHMkDt3DWjw=;
        b=XaVqkFWZB/3y+QBfSFGsYEbeJw/bC5O5++j3L3aFqjA5i9wBqGq3mf6E10En2kXT8D
         LTxiA8YoIz9OL1c68b0mNLmBV+Mi4l+FBYAtIqc4N1Uxm7f19hGG60MY0FxT/s13bAnB
         J6ppwDv6AKGPO/geJ+wPpUd2ootAhB43DUxXaWG++nzo3gIyHP7T0pgfDyHiAqfvkcge
         3wSAcrjOXU54Gg4GkTdcMz/QhcY4HcMT+FOrRZD/xHyzm1mXpsGFjNOBnfAHDtmD74WK
         0Kqe60s7pPXuw4yq2eB4WfGPu1pSLdSVjR38M6t6dKF5UmEwbw2+rSLwoBuPtWiA3YpL
         i6Hg==
X-Gm-Message-State: APuU4Z+DIEtf6L1GrL7x8xzT9/2jvwsvcajSaGA+50EAd7Al/9geS9OS
	9rlUJ3GGlN0lRoj8S2BmEpj9IJAshFzDSg2hdG83YmEjUuRwkQr/aOekvU/qmw==
X-Gm-Gg: AYBFou1ziFP29SYOAqO0FXXSvy5yXn+k5fSAAUwtPT6l4U7sGKPzgYu/TA4Krgk8/1l
	PD38f599wvEbP3wmy2WrWU2GJ4AKGdnQdKz7tEIFJEqrjhT7kdak5esjyUn7Wpo8EdLAL7Ezetm
	3pLl5CMf53Su/XWKE1/PLPe6nmHpevBrnP2F955YiKhT2nxpPQ0xDOyIiuY1NeF3H/4NtKaQhth
	Tnb9KH6+Mq88cUOF6Fsms4Xs2TU+WJ4psiRmRVPduC/8/YlL9T8G5FI/v060ECB1rDDtmz3EItL
	RKDoDYSsfxH6quiF4isWiQLHsYpql1/h11d/0979Cf9+UI3k8sbJ5tCNrU3u9gSGMdxl32Nb5kz
	Soy8IBJUNHsPf2e8MUz32Ul25EmX071Nd7LUEYiGbueqMaBKLZAIh99HgoJTH//3zngLvSR3GFc
	Y4wWESm1qwouHALG7ErW8jTQjh08YPksopFeLme6rR+7WVrFc/cF1V459HtO34R8wGQ1/pt2F7k
	zp8+MjT238lVr8OPRV4ajeBk35+A8zIAIrsOewiH2Xd2Fb3ekMPE6T4/Mb1v0TwS5JfBjTksZha
	YlJ6kBMmQ6YAhGnyaZ8O4T4C/5iEoPYJ8cqYVKCBCMQkZuL4dUJMcZaWVjVF16KLuez7sVQbIDJ
	mtN7bYPfmooXUQ8aZAoyp5FJEShRkR3lcgnWIh0MYqrz0ipnodFAwHuN6ZPKzTzfOulosGfBvKw
	==
X-Received: by 2002:a17:902:ce0e:b0:2e8:f4f:ad04 with SMTP id d9443c01a7336-2eb36495567mr61709005ad.12.1793502383920;
        Sat, 31 Oct 2026 20:06:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc4bsm18056525ad.12.2026.10.31.20.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/14] bpf, x86: Support BPF_REG_ARENA_SP
Date: Sun,  1 Nov 2026 03:05:08 +0000
Message-ID: <20261101030511.1578690-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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
index 3659f288b32e..314193c034a0 100644
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
 			if (func == (u8 *)arch_bpf_timed_may_goto) {
 				u32 fp = priv_frame_ptr ? X86_REG_R9 : BPF_REG_FP;
@@ -3513,6 +3612,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3839,7 +3942,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_JMP | BPF_EXIT:
 			if (src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
-			    emit_unwind_ret_addr(&prog, ip))
+			    emit_unwind_ret_addr(&prog, ip, arena_sp))
 				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i] + moved;
@@ -3853,8 +3956,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -5202,6 +5305,11 @@ bool bpf_jit_supports_private_stack(void)
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

