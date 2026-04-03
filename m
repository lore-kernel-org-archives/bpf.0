Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B5347BB5
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189603; cv=none; b=pxUBD/dDukDEmORpLi4LT6LZhEwnB4svX0gBMF4zHVlMOQauPQcMEhckE+7kHi/V++otunSeHWkXke1+0tIUj/ynmvIjUn/NOd1pDgHJ+CCpe9fIOYIb4uyWR08dzziQYUFhZzECPXVuwxQv3qrjcDkgIPPXaLXY+4UlW3TqCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189603; c=relaxed/simple;
	bh=7pUyxj19GE5Rg+dO85T5EWVIspdG+WNwpYZB3wLC8mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1mtr0RnmyNwGYsnxkq4RKdHRsYH4+Ns9/TvV50pf3er5MSePgL91bh5fb70Z0IsvWm222MKkKjXCsInYyI1XQn3MPWSVLKPgOQS/wDR21QOWWlbS2WYPH2O50Smrpj5Y6ngDCkPtWZek0PLQqn36gqFKvcQ/Z2LGPVm0/gvLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TgGg7kdq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TgGg7kdq"
Message-ID: <72f47124-1cab-4406-a6c1-3bed0c3579e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775189599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8B1FcQyqOiPi+OXyU4bJBPR/UyrJV6vvroLInOVRLIA=;
	b=TgGg7kdqjI41YaA9KSLg9tFzGV7XglhvgnqAoWWrtmWux7gwnVDJsAb8LYFz4scS/Q2RKr
	+kr/45gxVKDVDYtVdV4iIr3DxDFLHjDd6lXwskrdifujKz/gzaXtoZvQqv/u8YVJT2Zr4s
	hNMlWLTHsAiPCUvGtinr2DSvGNLkuss=
Date: Thu, 2 Apr 2026 21:13:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/10] bpf,x86: Implement JIT support for stack
 arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012803.3920450-1-yonghong.song@linux.dev>
 <CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7CDJ-7aKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7CDJ-7aKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/2/26 4:51 PM, Alexei Starovoitov wrote:
> On Wed, Apr 1, 2026 at 6:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add x86_64 JIT support for BPF functions and kfuncs with more than
>> 5 arguments. The extra arguments are passed through a stack area
>> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
>> which the JIT translates to RBP-relative accesses in native code.
>>
>> There are two possible approaches to allocate the stack arg area:
>>
>>    Option 1: Allocate a single combined region (incoming + max_outgoing)
>>      below the program stack in the function prologue. All r12-relative
>>      accesses become [rbp - prog_stack_depth - offset] where the 'offset'
>>      is the offset value in (incoming + max_outgoing) region. This is
>>      simple because the area is always at a fixed offset from RBP.
>>      The tradeoff is slightly higher stack usage when multiple callees
>>      have different stack arg counts — the area is sized to the maximum.
>>
>>    Option 2: Allocate each outgoing area individually at the call
>>      site, sized exactly to the callee's needs. This minimizes
>>      stack usage but significantly complicates the JIT: each call
>>      site must dynamically adjust RSP, and addresses of stack args
>>      would shift depending on context, making the offset
>>      calculations harder.
>>
>> This patch uses Option 1 for simplicity.
>>
>> The native x86_64 stack layout for a function with incoming and
>> outgoing stack args:
>>
>>    high address
>>    ┌─────────────────────────┐
>>    │ incoming stack arg N    │  [rbp + 16 + (N - 1) * 8]  (pushed by caller)
>>    │ ...                     │
>>    │ incoming stack arg 1    │  [rbp + 16]
>>    ├─────────────────────────┤
>>    │ return address          │  [rbp + 8]
>>    │ saved rbp               │  [rbp]
>>    ├─────────────────────────┤
>>    │ callee-saved regs       │
>>    │ BPF program stack       │  (stack_depth bytes)
>>    ├─────────────────────────┤
>>    │ incoming stack arg 1    │  [rbp - prog_stack_depth - 8]
>>    │ ...   (copied from      │   (copied in prologue)
>>    │        caller's push)   │
>>    │ incoming stack arg N    │  [rbp - prog_stack_depth - N * 8]
>>    ├─────────────────────────┤
>>    │ outgoing stack arg 1    │  (written via r12-relative STX/ST,
>>    │ ...                     │   JIT translates to RBP-relative)
>>    │ outgoing stack arg M    │
>>    └─────────────────────────┘
>>      ...                        Other stack usage
>>    ┌─────────────────────────┐
>>    │ incoming stack arg M    │ (copy from outgoing stack arg to
>>    │ ...                     │  incoming stack arg)
>>    │ incoming stack arg 1    │
>>    ├─────────────────────────┤
>>    │ return address          │
>>    │ saved rbp               │
>>    ├─────────────────────────┤
>>    │ ...                     │
>>    └─────────────────────────┘
>>    low address
>>
>> In prologue, the caller's incoming stack arguments are copied to callee's
>> incoming stack arguments, which will be fetched by later load insns.
>> The outgoing stack arguments are written by JIT RBP-relative STX or ST.
>>
>> For each bpf-to-bpf call, push outgoing stack args onto the native
>> stack before CALL, pop them after return. So the same 'outgoing stack arg'
>> area is used by all bpf-to-bpf functions.
>>
>> For kfunc calls, push stack args (arg 7+) onto the native stack
>> and load arg 6 into R9 per the x86_64 calling convention,
>> then clean up RSP after return.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 145 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 138 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..807493f109e5 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -367,6 +367,27 @@ static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
>>          *pprog = prog;
>>   }
>>
>> +static int push_stack_args(u8 **pprog, s32 base_off, int from, int to)
>> +{
>> +       u8 *prog = *pprog;
>> +       int j, off, cnt = 0;
>> +
>> +       for (j = from; j >= to; j--) {
>> +               off = base_off - j * 8;
>> +
>> +               /* push qword [rbp + off] */
>> +               if (is_imm8(off)) {
>> +                       EMIT3(0xFF, 0x75, off);
>> +                       cnt += 3;
>> +               } else {
>> +                       EMIT2_off32(0xFF, 0xB5, off);
>> +                       cnt += 6;
>> +               }
>> +       }
>> +       *pprog = prog;
>> +       return cnt;
>> +}
>> +
>>   static void pop_r12(u8 **pprog)
>>   {
>>          u8 *prog = *pprog;
>> @@ -1664,19 +1685,35 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>          int i, excnt = 0;
>>          int ilen, proglen = 0;
>>          u8 *prog = temp;
>> -       u32 stack_depth;
>> +       u16 stack_arg_depth, incoming_stack_arg_depth;
>> +       u32 prog_stack_depth, stack_depth;
>> +       bool has_stack_args;
>>          int err;
>>
>>          stack_depth = bpf_prog->aux->stack_depth;
>> +       stack_arg_depth = bpf_prog->aux->stack_arg_depth;
>> +       incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_depth;
>>          priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
>>          if (priv_stack_ptr) {
>>                  priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
>>                  stack_depth = 0;
>>          }
>>
>> +       /*
>> +        * Save program stack depth before adding stack arg space.
>> +        * Each function allocates its own stack arg space
>> +        * (incoming + outgoing) below its BPF stack.
>> +        * Stack args are accessed via RBP-based addressing.
>> +        */
>> +       prog_stack_depth = round_up(stack_depth, 8);
>> +       if (stack_arg_depth)
>> +               stack_depth += stack_arg_depth;
>> +       has_stack_args = stack_arg_depth > 0;
>> +
>>          arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
>>          user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>>
>> +
>>          detect_reg_usage(insn, insn_cnt, callee_regs_used);
>>
>>          emit_prologue(&prog, image, stack_depth,
>> @@ -1704,6 +1741,38 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                  emit_mov_imm64(&prog, X86_REG_R12,
>>                                 arena_vm_start >> 32, (u32) arena_vm_start);
>>
>> +       if (incoming_stack_arg_depth && bpf_is_subprog(bpf_prog)) {
>> +               int n = incoming_stack_arg_depth / 8;
>> +
>> +               /*
>> +                * Caller pushed stack args before CALL, so after prologue
>> +                * (CALL saves ret addr, then PUSH saves old RBP) they sit
>> +                * above RBP:
>> +                *
>> +                *   [rbp + 16 + (n - 1) * 8]  stack_arg n
>> +                *   ...
>> +                *   [rbp + 24]                stack_arg 2
>> +                *   [rbp + 16]                stack_arg 1
>> +                *   [rbp +  8]                return address
>> +                *   [rbp +  0]                saved rbp
>> +                *
>> +                * Copy each into callee's own region below the program stack:
>> +                *   [rbp - prog_stack_depth - i * 8]
>> +                */
>> +               for (i = 0; i < n; i++) {
>> +                       s32 src = 16 + i * 8;
>> +                       s32 dst = -prog_stack_depth - (i + 1) * 8;
>> +
>> +                       /* mov rax, [rbp + src] */
>> +                       EMIT4(0x48, 0x8B, 0x45, src);
>> +                       /* mov [rbp + dst], rax */
>> +                       if (is_imm8(dst))
>> +                               EMIT4(0x48, 0x89, 0x45, dst);
>> +                       else
>> +                               EMIT3_off32(0x48, 0x89, 0x85, dst);
>> +               }
> This is really suboptimal.
> bpf calling convention for 6+ args needs to match x86.
> With an exception of 6th arg.
> All bpf insn need to remain as-is when calling another bpf prog
> or kfunc. There should be no additional moves.
> JIT should only special case 6th arg and convert bpf's STX [r12-N], src_reg
> into 'mov r9, src_reg', since r9 is used to pass 6th argument on x86.
> The rest of STX needs to be jitted pretty much as-is
> with a twist that bpf's r12 becomes %rbp on x86.
> And similar things in the callee.
> Instead of LDX [r12+N] it will be a 'mov dst_reg, r9' where r9 is x86's r9.
> Other LDX from [r12+M] will remain as-is, but r12->%rbp.
> On arm64 more of the STX/LDX insns become native 'mov'-s
> because arm64 has more registers for arguments.

Good point. I will try to simplify the JIT by following x86_64
calling convention.

>
> pw-bot: cr

