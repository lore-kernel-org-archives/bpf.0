Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED415E5BB
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101209; cv=none; b=DLx7sr0ynmpsM6eaQ/sPhV2BdcqPNDpse/zP1929rVgb49t/CH51bR0EKehK9bNg85RO0MoU3EkzX9Wg9hfF0+UjNHUeyiZiTTW7jersAIAoOsUY9Rlm9tdw+anmcKIqVwyxnwnFXahYNKPos3Realey5009dbl79n8QWlrEWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101209; c=relaxed/simple;
	bh=FDopqZmVuWDeOmUhO3oHdEN7eDzpbtel6SkSTngDtqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBDk67MaO5NIWpcpwwknlGIOmZh+6YLiIOPhtEK2s3yCsnwhxvgaUEZj5rgxevYYgrojzSqYntg6k329o7De0FAI24CRL7Zf8x0/VuEdjq45h8NWUcFrVyjuAgYQ5DqnNYVhJF2IwoJoZzbiGotbFhQfgHiR9Iii2sDNfMSNA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNsGqUDV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNsGqUDV"
Message-ID: <281485db-073e-45b6-8929-dad36fea5f87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776101202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs03TJCdcOFMfrUKzLGoBq8VD85eC4jkuI7o5cF8Zd4=;
	b=LNsGqUDV6vsLORzY5f65fjoUAFd1hYd0z1pHqE96gH3vapA7imTBNAIS8tAPcqGINAxTYC
	/832XJlHgXWJrT7bOJrSql9LPb+IaXoq1wXkgSdPL+swyykVq3HGBdffH4WHnjNuVl1VkQ
	WGCANEYKG9dTJZhd0Xa6zS/gh/nZvg8=
Date: Mon, 13 Apr 2026 10:26:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev>
 <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/12/26 3:36 PM, Alexei Starovoitov wrote:
> On Sat, Apr 11, 2026 at 10:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add x86_64 JIT support for BPF functions and kfuncs with more than
>> 5 arguments. The extra arguments are passed through a stack area
>> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
>> which the JIT translates to native code.
>>
>> The JIT follows the x86-64 calling convention for both BPF-to-BPF
>> and kfunc calls:
>>    - Arg 6 is passed in the R9 register
>>    - Args 7+ are passed on the stack
>>
>> Incoming arg 6 (BPF r12+8) is translated to a MOV from R9 rather
>> than a memory load. Incoming args 7+ (BPF r12+16, r12+24, ...) map
>> directly to [rbp + 16], [rbp + 24], ..., matching the x86-64 stack
>> layout after CALL + PUSH RBP, so no offset adjustment is needed.
>>
>> The verifier guarantees that neither tail_call_reachable nor
>> priv_stack is set when outgoing stack args exist, so R9 is always
>> available. When BPF bytecode writes to the arg-6 stack slot
>> (the most negative outgoing offset), the JIT emits a MOV into R9
>> instead of a memory store. Outgoing args 7+ are placed at [rsp]
>> in a pre-allocated area below callee-saved registers, using:
>>    native_off = outgoing_arg_base + bpf_off
>>
>> The native x86_64 stack layout:
>>
>>    high address
>>    +-------------------------+
>>    | incoming stack arg N    |  [rbp + 16 + (N-2)*8]  (from caller)
>>    | ...                     |
>>    | incoming stack arg 7    |  [rbp + 16]
>>    +-------------------------+
>>    | return address          |  [rbp + 8]
>>    | saved rbp               |  [rbp]
>>    +-------------------------+
>>    | BPF program stack       |  (round_up(stack_depth, 8) bytes)
>>    +-------------------------+
>>    | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
>>    +-------------------------+
>>    | outgoing arg M          |  [rsp + (M-7)*8]
>>    | ...                     |
>>    | outgoing arg 7          |  [rsp]
>>    +-------------------------+  rsp
>>    low address
>>
>>    (Arg 6 is in R9, not on the stack)
>>
>>    [1] https://github.com/llvm/llvm-project/pull/189060
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 172 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 164 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..ec57b9a6b417 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -390,6 +390,34 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>>          *pprog = prog;
>>   }
>>
>> +/* add rsp, depth */
>> +static void emit_add_rsp(u8 **pprog, u16 depth)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       if (!depth)
>> +               return;
>> +       if (is_imm8(depth))
>> +               EMIT4(0x48, 0x83, 0xC4, depth); /* add rsp, imm8 */
>> +       else
>> +               EMIT3_off32(0x48, 0x81, 0xC4, depth); /* add rsp, imm32 */
>> +       *pprog = prog;
>> +}
>> +
>> +/* sub rsp, depth */
>> +static void emit_sub_rsp(u8 **pprog, u16 depth)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       if (!depth)
>> +               return;
>> +       if (is_imm8(depth))
>> +               EMIT4(0x48, 0x83, 0xEC, depth); /* sub rsp, imm8 */
>> +       else
>> +               EMIT3_off32(0x48, 0x81, 0xEC, depth); /* sub rsp, imm32 */
>> +       *pprog = prog;
>> +}
>> +
>>   static void emit_nops(u8 **pprog, int len)
>>   {
>>          u8 *prog = *pprog;
>> @@ -725,8 +753,8 @@ static void emit_return(u8 **pprog, u8 *ip)
>>    */
>>   static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>                                          u8 **pprog, bool *callee_regs_used,
>> -                                       u32 stack_depth, u8 *ip,
>> -                                       struct jit_context *ctx)
>> +                                       u32 stack_depth, u16 outgoing_depth,
>> +                                       u8 *ip, struct jit_context *ctx)
>>   {
>>          int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
>>          u8 *prog = *pprog, *start = *pprog;
>> @@ -775,6 +803,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>          /* Inc tail_call_cnt if the slot is populated. */
>>          EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
>>
>> +       /* Deallocate outgoing stack arg area. */
>> +       emit_add_rsp(&prog, outgoing_depth);
> leftover?
> tailcalls are 6+ args don't mix.

Ack. This is due to my negligence.

>
>> +
>>          if (bpf_prog->aux->exception_boundary) {
>>                  pop_callee_regs(&prog, all_callee_regs_used);
>>                  pop_r12(&prog);
>> @@ -815,6 +846,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>                                        struct bpf_jit_poke_descriptor *poke,
>>                                        u8 **pprog, u8 *ip,
>>                                        bool *callee_regs_used, u32 stack_depth,
>> +                                     u16 outgoing_depth,
>>                                        struct jit_context *ctx)
>>   {
>>          int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
>> @@ -842,6 +874,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>          /* Inc tail_call_cnt if the slot is populated. */
>>          EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1 */
>>
>> +       /* Deallocate outgoing stack arg area. */
>> +       emit_add_rsp(&prog, outgoing_depth);
>> +
> another leftover?

Ya. Will remove in the next revision.

>
>
>>          if (bpf_prog->aux->exception_boundary) {
>>                  pop_callee_regs(&prog, all_callee_regs_used);
>>                  pop_r12(&prog);
>> @@ -1664,16 +1699,48 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>          int i, excnt = 0;
>>          int ilen, proglen = 0;
>>          u8 *prog = temp;
>> +       u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth;
>> +       u16 outgoing_rsp;
>>          u32 stack_depth;
>> +       int callee_saved_size;
>> +       s32 outgoing_arg_base;
>> +       bool has_stack_args;
>>          int err;
>>
>>          stack_depth = bpf_prog->aux->stack_depth;
>> +       stack_arg_depth = bpf_prog->aux->stack_arg_depth;
>> +       incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_depth;
>> +       outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;
>>          priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
>>          if (priv_stack_ptr) {
>>                  priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
>>                  stack_depth = 0;
>>          }
>>
>> +       /*
>> +        * Follow x86-64 calling convention for both BPF-to-BPF and
>> +        * kfunc calls:
>> +        *   - Arg 6 is passed in R9 register
>> +        *   - Args 7+ are passed on the stack at [rsp]
>> +        *
>> +        * Incoming arg 6 is read from R9 (BPF r12+8 → MOV from R9).
>> +        * Incoming args 7+ are read from [rbp + 16], [rbp + 24], ...
>> +        * (BPF r12+16, r12+24, ... map directly with no offset change).
>> +        *
>> +        * The verifier guarantees that neither tail_call_reachable nor
>> +        * priv_stack is set when outgoing stack args exist, so R9 is
>> +        * always available.
>> +        *
>> +        * Stack layout (high to low):
>> +        *   [rbp + 16 + ...]    incoming stack args 7+ (from caller)
>> +        *   [rbp + 8]           return address
>> +        *   [rbp]               saved rbp
>> +        *   [rbp - prog_stack]  program stack
>> +        *   [below]             callee-saved regs
>> +        *   [below]             outgoing args 7+ (= rsp)
>> +        */
>> +       has_stack_args = stack_arg_depth > 0;
>> +
>>          arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
>>          user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>>
>> @@ -1700,6 +1767,41 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                          push_r12(&prog);
>>                  push_callee_regs(&prog, callee_regs_used);
>>          }
>> +
>> +       /* Compute callee-saved register area size. */
>> +       callee_saved_size = 0;
>> +       if (bpf_prog->aux->exception_boundary || arena_vm_start)
>> +               callee_saved_size += 8; /* r12 */
>> +       if (bpf_prog->aux->exception_boundary) {
>> +               callee_saved_size += 4 * 8; /* rbx, r13, r14, r15 */
>> +       } else {
>> +               int j;
>> +
>> +               for (j = 0; j < 4; j++)
>> +                       if (callee_regs_used[j])
>> +                               callee_saved_size += 8;
>> +       }
>> +       /*
>> +        * Base offset from rbp for translating BPF outgoing args 7+
>> +        * to native offsets:
>> +        *   native_off = outgoing_arg_base + bpf_off
>> +        *
>> +        * BPF outgoing offsets are negative (r12 - N*8 for arg6,
>> +        * ..., r12 - 8 for last arg). Arg 6 goes to R9 directly,
>> +        * so only args 7+ occupy the outgoing stack area.
>> +        *
>> +        * Note that tail_call_reachable is guaranteed to be false when
>> +        * stack args exist, so tcc pushes need not be accounted for.
>> +        */
>> +       outgoing_arg_base = -(round_up(stack_depth, 8) + callee_saved_size);
>> +
>> +       /*
>> +        * Allocate outgoing stack arg area for args 7+ only.
>> +        * Arg 6 goes into r9 register, not on stack.
>> +        */
>> +       outgoing_rsp = outgoing_stack_arg_depth > 8 ?  outgoing_stack_arg_depth - 8 : 0;
>> +       emit_sub_rsp(&prog, outgoing_rsp);
>> +
>>          if (arena_vm_start)
>>                  emit_mov_imm64(&prog, X86_REG_R12,
>>                                 arena_vm_start >> 32, (u32) arena_vm_start);
>> @@ -1715,13 +1817,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>          prog = temp;
>>
>>          for (i = 1; i <= insn_cnt; i++, insn++) {
>> +               bool adjust_stack_arg_off = false;
> This bool signal within a single insn is hard to read.

This can be removed as we can directly compare src_reg/dst_reg to BPF_REG_STACK_ARG_BASE
in the below.

>
>>                  const s32 imm32 = insn->imm;
>>                  u32 dst_reg = insn->dst_reg;
>>                  u32 src_reg = insn->src_reg;
>>                  u8 b2 = 0, b3 = 0;
>>                  u8 *start_of_ldx;
>>                  s64 jmp_offset;
>> -               s16 insn_off;
>> +               s32 insn_off;
>>                  u8 jmp_cond;
>>                  u8 *func;
>>                  int nops;
>> @@ -1734,6 +1837,21 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                                  dst_reg = X86_REG_R9;
>>                  }
>>
>> +               if (has_stack_args) {
>> +                       u8 class = BPF_CLASS(insn->code);
>> +
>> +                       if (class == BPF_LDX &&
>> +                           src_reg == BPF_REG_STACK_ARG_BASE) {
>> +                               src_reg = BPF_REG_FP;
>> +                               adjust_stack_arg_off = true;
>> +                       }
>> +                       if ((class == BPF_STX || class == BPF_ST) &&
>> +                           dst_reg == BPF_REG_STACK_ARG_BASE) {
>> +                               dst_reg = BPF_REG_FP;
>> +                               adjust_stack_arg_off = true;
>> +                       }
>> +               }
> All that stuff looks unnecessary.

Ack.

>
>> +
>>                  switch (insn->code) {
>>                          /* ALU */
>>                  case BPF_ALU | BPF_ADD | BPF_X:
>> @@ -2129,12 +2247,20 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                                  EMIT1(0xC7);
>>                          goto st;
>>                  case BPF_ST | BPF_MEM | BPF_DW:
>> +                       if (adjust_stack_arg_off && insn->off == -outgoing_stack_arg_depth) {
>> +                               /* Arg 6: store immediate in r9 register */
>> +                               emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
>> +                               break;
>> +                       }
>>                          EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>>
>> -st:                    if (is_imm8(insn->off))
>> -                               EMIT2(add_1reg(0x40, dst_reg), insn->off);
>> +st:                    insn_off = insn->off;
>> +                       if (adjust_stack_arg_off)
>> +                               insn_off = outgoing_arg_base + insn_off;
> Since this part needs to be done anyway, match dst_reg==r11 here
> and do the right thing without bool adjust_stack_arg_off ?

Yes, we can do something like below:

                 case BPF_ST | BPF_MEM | BPF_DW:
-                       if (adjust_stack_arg_off && insn->off == -outgoing_stack_arg_depth) {
+                       if (dst_reg == BPF_REG_STACK_ARG_BASE && insn->off == -outgoing_stack_arg_depth) {
                                 /* Arg 6: store immediate in r9 register */
                                 emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
                                 break;
@@ -2255,8 +2230,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
                         EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  
  st:                    insn_off = insn->off;
-                       if (adjust_stack_arg_off)
+                       if (dst_reg == BPF_REG_STACK_ARG_BASE) {
                                 insn_off = outgoing_arg_base + insn_off;
+                               dst_reg = BPF_REG_FP;
+                       }
                         if (is_imm8(insn_off))
                                 EMIT2(add_1reg(0x40, dst_reg), insn_off);
                         else
...

Similar changes like below other two cases...

>
>> +                       if (is_imm8(insn_off))
>> +                               EMIT2(add_1reg(0x40, dst_reg), insn_off);
>>                          else
>> -                               EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
>> +                               EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
>>
>>                          EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
>>                          break;
>> @@ -2144,7 +2270,15 @@ st:                      if (is_imm8(insn->off))
>>                  case BPF_STX | BPF_MEM | BPF_H:
>>                  case BPF_STX | BPF_MEM | BPF_W:
>>                  case BPF_STX | BPF_MEM | BPF_DW:
>> -                       emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +                       if (adjust_stack_arg_off && insn->off == -outgoing_stack_arg_depth) {
>> +                               /* Arg 6: store register value in r9 */
>> +                               EMIT_mov(X86_REG_R9, src_reg);
>> +                               break;
>> +                       }
>> +                       insn_off = insn->off;
>> +                       if (adjust_stack_arg_off)
>> +                               insn_off = outgoing_arg_base + insn_off;
>> +                       emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>>                          break;
>>
>>                  case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
>> @@ -2243,6 +2377,18 @@ st:                      if (is_imm8(insn->off))
>>                  case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>                  case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>                          insn_off = insn->off;
>> +                       if (adjust_stack_arg_off) {
>> +                               if (insn_off == 8) {
>> +                                       /* Incoming arg 6: read from r9 */
>> +                                       EMIT_mov(dst_reg, X86_REG_R9);
>> +                                       break;
>> +                               }
>> +                               /*
>> +                                * Incoming args 7+: native_off == bpf_off
>> +                                * (r12+16 → [rbp+16], r12+24 → [rbp+24], ...)
>> +                                * No offset adjustment needed.
>> +                                */
> Overall, looks ok. See how much cleaner and more performant JIT became ?

Indeed much cleaner than v3 and earlier.

