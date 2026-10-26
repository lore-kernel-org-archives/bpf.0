Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983746;
	b=hB9LM6/dxNVARq+kqneeGSzP/s9XtLNVk5ecsJKDEOMSUHVEUrO1WxbfDubXlHZZ3bOJ
	 pHMVQ+sNUlxFOhqtZGj/IBM0Hvk2UqnFDEm0AwYgOYhKmQqBAjbuKfemrPe5dRlZfRGsX
	 fs3UZCgMvgY65A9CEyFGA3I0NSyuadbR3l5+v0SR86yMDDjUoYu5xBtk10L3dlkIgD1qQ
	 WGCH8Ri/MhHA+fzTwzoWSe1ixJ6nFMTsNRqJnrcRCEo2ba3adSbEoFadvaanZkl/4unpV
	 Sb7xpUgxWGPou3prHSBo3c1xPRKSeJlfxILTJOd9Tz9tNtA9AzYsa0I+YeqYpTQaU8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NZBi5d0JqK+BH7E2+ROGxJF3LK8R+TabpTgIYUBnhCo=;
	b=RER+ToS9RZoys3kJMjJakNl+6dGm7CxJRotAo9RCQGkr6AmtlcubRqHrwaE2Q/lf4t/g
	 xUIQXBZk3pXddwWITCEgQ8P84Xw6lsZ/JOtBbyWjLt3gfvy0Opo3Dapijg6hYchEIZQQ5
	 B8pRWzYaztnibiWfU+0CTFW5xGAdwUI91G/KP81rDdJTmg3IDk6+boiA/KY/GCR6o4JXn
	 uP3Ftqpb5UMme+2Ft3i2P9g+MJrsPGBcgn3L2/vUKuGLaMMzHoia6aS/Dy402lw7cDzeK
	 L+CqXidxOT9/dZEePNDb1E7HXVKU/If4Bn+WL8oiaAwUlIlKaFpWngs1lZd73OqRWzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHeBnEQv;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C6606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHeBnEQv
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so1218082a91.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983745; x=1793588545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NZBi5d0JqK+BH7E2+ROGxJF3LK8R+TabpTgIYUBnhCo=;
        b=PHeBnEQvT2eHsZI1picHO6uGBK91H49bIZIKuvIq4b7w0Gcstfljdaj87Lcmb4Dic1
         g1gsok5GSZ5T/BfLnclXoRWxddp39XdMCKB9GLdJUjQqKPdkrqYsVjXt/IoYsG9uj46M
         OlTWYHUhoedP1WvCDs5y0bKm+EFx3L8ZaJQyKgFabnvsB0sO9X5AuC7wwnMCALF8OZUZ
         LReldvQsMEs8kyY7+Mh10/nUNC7viCTXx9OLyxhP35/IRZa9bzBMSMCxfSen5fVtDkXk
         kFYtspBE9tIgZU/lVN1EMdO23mv6L0I7/asgluK3vVdtML7YxLYUR0KlbXX+JTCy89ao
         wACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983745; x=1793588545;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZBi5d0JqK+BH7E2+ROGxJF3LK8R+TabpTgIYUBnhCo=;
        b=s1JPyTH6zxmDDslf/NXuDN9YRFJSh526ho5vEVR95SXRTYsRrwnHA4rkLqTbamgvyf
         YU+7DXppB2N3xCT043ok+uDVqwKrj9oMs2Yn6n6nMyYXxU+w+LPIlzM6oJUs30B3dzyb
         09wtQUagzoFMxdS8bquiZL38tfvUf65YtbmNBvEnI2T5bEmnMGz2qXLljrCvymBev8Q2
         820pGnXJCiwxlT+KF96mPjArurHBrNg6ao0utIRZ01P/I4dKzdv6h1aydZI04UV+GGHW
         kSZtnGa8YLeQHCRSU2G+fcwNbabGGrLlq75NUmzl3gusSFAX5hQUn/5KAoKfSR6TQyIH
         BYGg==
X-Gm-Message-State: AFq9FYI/EDkt1GfZvwuxpaZnSYNXmyRvwf7Lng+MB9HAeQNvB6KY4PMh
	dBmLmAWQdMlU2NAOpVKGvErjdsmeHBkma066OMrupTwR4vB0WT9IJdA4ImWW+A==
X-Gm-Gg: AYBFou1tInqAytYXdjOjkTe2bxMQIgzYhf25uqsZIAe5vVlI19Bzj0Obda9iag9HmK8
	bI+MqGjbxMQw5rS8wI8BTOlUXt2gRRIdjuP+FawS+15fEIVm7padgulWINOd6iEM988D28N9fZU
	EWb8sCoKGKTaZjU8VSZ50c1AIxWxPiQxkjiQIKUpqaDIWjHHc5AvJvptCTb8xqWgBx6fInHQ9yR
	BBawZzLAu1TrLo19lrkH/xJMlrT6+6H2Bugbin0hUNPu7nD5YhaDXDeizPm91KTsG8opG7dCkUu
	UzmjRVgl/U/z5EaD+Hk8sWCM7DXmg9X41qlgNujKAdM05MNwUieqsui2AEu2TRzGgClgf1FSQhk
	vwSwKfy6dJKEfR60KnEFEoaRP5M0KeruD83owbhkbYwd0gVAtzBS+Ll7QJmqMESX6tYisH+MCWC
	aAS4vYjFFTCRv3vV34tn0eoA9gPXa/mHoumZdnEcVIGJDYwjXsJAoreotSoC+tIz/H0afXDHqY1
	+qlnGtUSa//Up52DQsO/GDqknU8ma9uBQJfmhjshZ4daMkKiPPXLvcbrDDj2yMkxK4TvOL9BDcO
	ZbZGZCIpgyeaQFAV+4CdG1kj0vXIpvu3QohWJ7hbUl/Ia6FJiAZiJA0qerc7okc6u5GXDQwo4cB
	O2sjyM2qA/Xdwy6HqGKeLsRgK
X-Received: by 2002:a17:90b:4e83:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ade9b2cf01mr4570347a91.6.1792983745297;
        Sun, 25 Oct 2026 20:02:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc67961sm1000902a12.17.2026.10.25.20.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 27/81] bpf, x86: Support BPF_REG_ARENA_SP
Date: Mon, 26 Oct 2026 02:58:48 +0000
Message-ID: <20261026025943.404450-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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
                                    move rsp to arg 7 for the call
  frame pointer of private stack    the private stack is off

Only JITed code sees the arguments of a BPF-to-BPF call, because no
trampoline attaches to a subprog of a prog with r12. Thus the JIT can
select the location of arg 6.

Progs without r12 get the same JITed code. The cost in a prog with r12, in
a hot loop on x86-64 (Zen 5), in nsec:

  call of a helper or a kfunc         store and load of R9       0.012
  function that has such a call       push r9, add rsp, 8      < 0.01
  BPF-to-BPF call with 6 or 7 args    arg 6 is on the stack    < 0.007
  call of a kfunc with 10 args        load of R9, moves of rsp   0.26

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 15 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a398c50b58ea..e417ac4ce749 100644
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
 
@@ -2294,6 +2298,27 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
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
@@ -2501,16 +2526,23 @@ static u64 bpf_unwind_target(u64 ret_addr)
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
@@ -2535,6 +2567,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -2559,12 +2596,21 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -2623,14 +2669,22 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
 	if (bpf_prog->aux->exception_boundary)
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp;
+		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp + (arena_sp_save ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
@@ -3036,7 +3090,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ST | BPF_MEM | BPF_H:
 		case BPF_ST | BPF_MEM | BPF_W:
 		case BPF_ST | BPF_MEM | BPF_DW:
-			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
+			if (dst_reg == BPF_REG_PARAMS && insn->off == -8 && !arena_sp) {
 				/* Arg 6: store immediate in r9 register */
 				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31,
 					       imm32);
@@ -3050,7 +3104,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
 				 */
 				insn_off = outgoing_arg_base - outgoing_rsp -
-					   insn_off - 16;
+					   insn_off - (arena_sp ? 8 : 16);
 				dst_reg = BPF_REG_FP;
 			}
 			if (!accesses_stack_only) {
@@ -3070,14 +3124,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3186,11 +3241,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3428,6 +3485,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3436,8 +3499,26 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip += err;
-				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
-							   outgoing_rsp, &prog);
+				if (arena_sp && out_stack_arg_cnt) {
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
+				if (arena_sp && out_stack_arg_cnt) {
+					u8 *start = prog;
+
+					/* arg 7 is at [rsp] */
+					emit_add_rsp(&prog, 8);
+					ip += prog - start;
+				}
 			}
 			if (func == (u8 *)arch_bpf_timed_may_goto) {
 				u32 fp = priv_frame_ptr ? X86_REG_R9 : BPF_REG_FP;
@@ -3460,6 +3541,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (fm && arena_sp && out_stack_arg_cnt)
+				emit_sub_rsp(&prog, 8);
+			if (arena_sp && call_clobbers_arena_sp(insn))
+				emit_ldx(&prog, BPF_DW, BPF_REG_ARENA_SP, BPF_REG_FP, arena_sp_off);
 			/*
 			 * A kfunc returning more than 8 bytes hands the second
 			 * half back in RDX (the native ABI's second return reg),
@@ -3786,7 +3871,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_JMP | BPF_EXIT:
 			if (src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
-			    emit_unwind_ret_addr(&prog, ip))
+			    emit_unwind_ret_addr(&prog, ip, arena_sp))
 				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i] + moved;
@@ -3800,8 +3885,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -5144,6 +5229,11 @@ bool bpf_jit_supports_private_stack(void)
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

