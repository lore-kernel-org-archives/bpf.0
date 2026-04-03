Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFB18DB01
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189162; cv=none; b=ltWLDWz4P3WzT47FnTezYGWbdImCrPChhRV1C9mFwjAgb/oWvrpThY1AS6C8q31PipEXHjt1j+6pXqB5isuMh9X4kU/A4pQnk3MQ5qT2K5otgp3bFIaVOy/hgHJiMJ3mN+Y+9BV/hJwI8/iPOquMJu2HTlnELcI280M91vSfyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189162; c=relaxed/simple;
	bh=QTRz3EMVsb2meueHResObY5Ag0BQD865MyrZPmsywEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a94sCWh/BI6SKJSLAChbQq8xMiJNp7SP/of8xGMzxN18DFvO07eZncBlzOrOtn3ND0rAj38LUsEM2HabTobNA+zI5vSG855wzSEbzWtZMi7sj40qD5BLankH2Sq/+K+kBIdJj8kJHFNojoNyd/6WD9dqnw/5LBK1CS1HQgo/EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsiA+YGH; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsiA+YGH"
Message-ID: <bd7fdec2-3a07-4dc9-be71-886e0bf176ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775189158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxCtDmcW+PYNWZYGao4CXe457GGVzkVY6yCZ0Fv51MY=;
	b=fsiA+YGHdjfgPsxUG7zjwMXJRZTTq5xZqSMv2u/Xo4TnniBce70YDzwCubIj9NOjRDpQTH
	rUcIq5zVLO0qHbqJamcJhwK5rhkHKRh4ak516xsnIHtAkl1NTvXpzLcDBO5td8XpCF7S+6
	H7idGDARbJvPvrweZd+OFVl82qjp+Dg=
Date: Thu, 2 Apr 2026 21:05:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf
 functions
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev>
 <CAMB2axM+UaJU0NpmkdwquinVjmJKBXeb+Ch-MQk_YskSyvrb+A@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axM+UaJU0NpmkdwquinVjmJKBXeb+Ch-MQk_YskSyvrb+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/2/26 4:38 PM, Amery Hung wrote:
> On Wed, Apr 1, 2026 at 6:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>> With [1], the compiler can emit code that passes additional arguments
>> via a dedicated stack area through bpf register
>> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>>
>> The following is an example to show how stack arguments are saved
>> and transferred between caller and callee:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>    }
>>
>> The following is a illustration of stack allocation:
>>
>>     Caller (foo)                           Callee (bar)
>>     ============                           ============
>>     r12-relative stack arg area:           r12-relative stack arg area:
>>
>>     r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from caller's outgoing r12-24)
>>     r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from caller's outgoing r12-32)
>>                                       ||+> r12-24: [incoming arg 8] (from caller's outgoing r12-40)
>>     ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>>     r12-24: [outgoing arg 6 to callee]+||   ...
>>     r12-32: [outgoing arg 7 to callee]-+|
>>     r12-40: [outgoing arg 8 to callee]--+
>>
>>    The caller writes outgoing args past its own incoming area.
>>    At the call site, the verifier transfers the caller's outgoing
>>    slots into the callee's incoming slots.
>>
>> The verifier tracks stack arg slots separately from the regular r10
>> stack. A new 'bpf_stack_arg_state' structure mirrors the existing stack
>> slot tracking (spilled_ptr + slot_type[]) but lives in a dedicated
>> 'stack_arg_slots' array in bpf_func_state. This separation keeps the
>> stack arg area from interfering with the normal stack and frame pointer
>> (r10) bookkeeping.
>>
>> If the bpf function has more than one calls, e.g.,
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>      bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>>      ...
>>    }
>>
>> The following is an illustration:
>>
>>     Caller (foo)                           Callee (bar1)
>>     ============                           =============
>>     r12-relative stack arg area:           r12-relative stack arg area:
>>
>>     r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from caller's outgoing r12-24)
>>     r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from caller's outgoing r12-32)
>>                                       ||+> r12-24: [incoming arg 8] (from caller's outgoing r12-40)
>>     ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>>     r12-24: [outgoing arg 6 to callee]+||  ...
>>     r12-32: [outgoing arg 7 to callee]-+|
>>     r12-40: [outgoing arg 8 to callee]--+
>>     ...
>>     Back from bar1
>>     ...                                     Callee (bar2)
>>     ===                                     =============
>>                                       +---> r12-8:  [incoming arg 6] (from caller's outgoing r12-24)
>>                                       |+--> r12-16: [incoming arg 7] (from caller's outgoing r12-32)
>>                                       ||+-> r12-24: [incoming arg 8] (from caller's outgoing r12-40)
>>                                       |||+> r12-32: [incoming arg 9] (from caller's outgoing r12-48)
>>     ---- incoming/outgoing boundary   ||||  ---- incoming/outgoing boundary
>>     r12-24: [outgoing arg 6 to callee]+|||  ...
>>     r12-32: [outgoing arg 7 to callee]-+||
>>     r12-40: [outgoing arg 8 to callee]--+|
>>     r12-48: [outgoing arg 9 to callee]---+
>>
>> Global subprogs with >5 args are not yet supported.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/189060
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h          |   2 +
>>   include/linux/bpf_verifier.h |  15 ++-
>>   kernel/bpf/btf.c             |  14 +-
>>   kernel/bpf/verifier.c        | 248 ++++++++++++++++++++++++++++++++---
>>   4 files changed, 257 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index e24c4a2e95f7..a0a1e14e4394 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1666,6 +1666,8 @@ struct bpf_prog_aux {
>>          u32 max_pkt_offset;
>>          u32 max_tp_access;
>>          u32 stack_depth;
>> +       u16 incoming_stack_arg_depth;
>> +       u16 stack_arg_depth; /* both incoming and max outgoing of stack arguments */
>>          u32 id;
>>          u32 func_cnt; /* used by non-func prog as the number of func progs */
>>          u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
[...]
>> @@ -8054,10 +8195,23 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                             bool strict_alignment_once)
>>   {
>> +       struct bpf_verifier_state *vstate = env->cur_state;
>> +       struct bpf_func_state *state = vstate->frame[vstate->curframe];
>>          struct bpf_reg_state *regs = cur_regs(env);
>>          enum bpf_reg_type dst_reg_type;
>>          int err;
>>
>> +       /* Handle stack arg write */
>> +       if (insn->dst_reg == BPF_REG_STACK_ARG_BASE) {
>> +               err = check_reg_arg(env, insn->src_reg, SRC_OP);
>> +               if (err)
>> +                       return err;
>> +               err = check_stack_arg_access(env, insn, "write");
>> +               if (err)
>> +                       return err;
>> +               return check_stack_arg_write(env, state, insn->off, insn->src_reg);
>> +       }
>> +
>>          /* check src1 operand */
>>          err = check_reg_arg(env, insn->src_reg, SRC_OP);
>>          if (err)
>> @@ -10940,8 +11094,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                             int *insn_idx)
>>   {
>>          struct bpf_verifier_state *state = env->cur_state;
>> +       struct bpf_subprog_info *caller_info;
>>          struct bpf_func_state *caller;
>>          int err, subprog, target_insn;
>> +       u16 callee_incoming;
>>
>>          target_insn = *insn_idx + insn->imm + 1;
>>          subprog = find_subprog(env, target_insn);
>> @@ -10993,6 +11149,15 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                  return 0;
>>          }
>>
>> +       /*
>> +        * Track caller's outgoing stack arg depth (max across all callees).
>> +        * This is needed so the JIT knows how much stack arg space to allocate.
>> +        */
>> +       caller_info = &env->subprog_info[caller->subprogno];
>> +       callee_incoming = env->subprog_info[subprog].incoming_stack_arg_depth;
>> +       if (callee_incoming > caller_info->outgoing_stack_arg_depth)
>> +               caller_info->outgoing_stack_arg_depth = callee_incoming;
>> +
>>          /* for regular function entry setup new frame and continue
>>           * from that frame.
>>           */
>> @@ -11048,13 +11213,41 @@ static int set_callee_state(struct bpf_verifier_env *env,
>>                              struct bpf_func_state *caller,
>>                              struct bpf_func_state *callee, int insn_idx)
>>   {
> Taking note when reading the change to set_callee_state():
>
> The function is not called when handling callback function, which uses
> push_callback_call() -> setup_func_entry() -> callback specific
> set_callee_state_cb. So caller stack argument will not be transferred.
>
> This should be fine as callee's stack_arg_depth will remain zero and
> then when callee tries to do r12 based load, check_stack_arg_read()
> should reject the program. Not sure if this needs a selftest since
> callbacks' set_callee_state_cb will also transfer register state very
> intentionally.

All callback functions are carefully designed in kernel. So far all
callback functions are within 5 register parameters. I ignore them
for now. If in the future, there is a need for callback functions
with more than 5 arguments, we can deal with them at that time.

>
>> -       int i;
>> +       struct bpf_subprog_info *callee_info;
>> +       int i, err;
>>
>>          /* copy r1 - r5 args that callee can access.  The copy includes parent
>>           * pointers, which connects us up to the liveness chain
>>           */
>>          for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>>                  callee->regs[i] = caller->regs[i];

[...]

