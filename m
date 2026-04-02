Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703061FFE
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162773; cv=none; b=Mqyf6Am64p63HfY0rysZW4VaycGU5SoYSZRMdXWFT7vY9sgimlv1uFoTzq9P/7sXAC04CnwjT+sVpB6U+scObKXgjmFHfsMwoLt8mj1ljBYD1J9kwNp9p0RwBdJW/+JK6unGh+11dIR9tvgS84x8yrebvuuSlkzBngBZhr8SM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162773; c=relaxed/simple;
	bh=7sL7vV5/1Zkwt3qipB+meQutiNWdLrQQz7Yk5AIFcZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGRf1yzZ2WU/4kGlJ6hchu1xhq7BoLphd6SBbhmh/w+VbNoNO2+EVWpuQiNQdVI47D1xvUA53kywZoYOlP1Itw3SukPjokpbKnWiqPn9CtYddAcKQMFXuniyNCi+rM7SKiiui2lC97vJxMP69/o1PVSYYsCdQynTHbhw93bxr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dy/GQWg2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dy/GQWg2"
Message-ID: <0474abcd-79e6-4eaf-b459-c8e3d8cdbf8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775162767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iI6e4ohrsR+tSDHyLOXyCnAPT78pLAsed0A6p/IJa8w=;
	b=dy/GQWg2jq4IhFWR2FGHCqVlq8g1zwU5UxIOpbH2lM00K+kJl/qzH9QlItGQ7vTwdwNrp4
	HtWPhaNb4FbpL69u/rfZg1swQZ2d79to2astzOXDZBCms5+wETV+MWhsAFUmvJvgHPfOCL
	iJu0a+f8SKuWlm/6eCZA/kXSLQ9M97A=
Date: Thu, 2 Apr 2026 13:45:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Amery Hung <ameryhung@meta.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev>
 <CAP17u3OdrYpJpx2z0gQ9OosuA-cj6etc0CwX4FyBCmM-PEn_-A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP17u3OdrYpJpx2z0gQ9OosuA-cj6etc0CwX4FyBCmM-PEn_-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/2/26 11:55 AM, Amery Hung wrote:
> On Wed, Apr 1, 2026 at 6:27 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 090aa26d1c98..a260610cd1c1 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -268,6 +268,11 @@ struct bpf_retval_range {
>>          bool return_32bit;
>>   };

...

>> +
>> +/*
>> + * Write a value to the stack arg area.
>> + * off is the negative offset from the stack arg frame pointer.
>> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
>> + */
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +                                int off, int value_regno)
>> +{
>> +       int spi = (-off - 1) / BPF_REG_SIZE;
>> +       struct bpf_func_state *cur;
>> +       struct bpf_reg_state *reg;
>> +       int i, err;
>> +       u8 type;
>> +
>> +       err = grow_stack_arg_slots(env, state, -off);
>> +       if (err)
>> +               return err;
>> +
>> +       cur = env->cur_state->frame[env->cur_state->curframe];
>> +       if (value_regno >= 0) {
>> +               reg = &cur->regs[value_regno];
>> +               state->stack_arg_slots[spi].spilled_ptr = *reg;
>> +               type = is_spillable_regtype(reg->type) ? STACK_SPILL : STACK_MISC;
> It seems any spillable register can be passed to the callee, so reg
> containing ref_obj_id can be spilled to stack_arg_slots. However,
> release_reference() does not invalidate ref_obj_id in stack_arg_slots.
> Can this cause UAF like below?
>
> a6 = bpf_task_acquire(t);
> if (!a6)
>          goto err;
>
> // a6 now has a valid ref_obj_id
> // foo1 calls bpf_task_release(a6);
> foo1(a1, a2, a3, a4, a5, a6);
>
> // a6 still has a valid ref_obj_id
> // foo2 dereference a6 -> UAF
> foo2(a1, a2, a3, a4, a5, a6);
>
> Since stack_arg_slots is separated from the normal stack slots, other
> types of stale registers may exist in the outgoing stack slots. For
> example:
> - stale pkt pointer after calling clear_all_pkt_pointers() in callee
> - register with inprecise nullness after calling
> mark_ptr_or_null_regs() in callee

Thanks for pointing this out. Indeed, a lot of checking are needed
for stack arguments. Looks like I need to add something like
	bpf_for_each_spilled_stack_arg
in bpf_for_each_reg_in_vstate_mask for full coverage.

Will fix in the next resivion.

>
>
>> +               for (i = 0; i < BPF_REG_SIZE; i++)
>> +                       state->stack_arg_slots[spi].slot_type[i] = type;
>> +       } else {
>> +               /* BPF_ST: store immediate, treat as scalar */

