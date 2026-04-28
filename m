Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28893624CB
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409671; cv=none; b=qViTziZ4SPuIUbZMkViOPa/d1Sg+L5P7sKVkxTl7g9wRvLPfY7jI8AXs1yoZvVeTV/6kSYC+ePqYGqL0J6AVFJbDeOxTlAvw2c1FSCnpxR6ySgv42eez2Y6/yBIO2QTv81kmjAXBGvAw5o+KdATmbSeUJAAiRWTySJJXh8TU+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409671; c=relaxed/simple;
	bh=F3MkMNEDXiJ9N4b+H9WtSz3Chu9Wi6FA4WsPi1oRhcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCK03f8YquBQvRRYBdtXOGh9JpQo5I6Pu5kPxjVoYBHD4qhCyqJY32v6/hEu66gPT8zSvB8rPvRLSVV2mwDPhShsU3AzBETexIQXNkjiJmNnIQYQRzZYldO2aPWCLwaGnWvZDDqOeE4lxEZ8lXSutdfwuzFBYvPNoOLqnk2cbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNxGPUxH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNxGPUxH"
Message-ID: <8c6455e1-94f5-42e5-8d27-66787dec878f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777409667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CuKGev6BLhfF7EnMPMhetPzsqE/BpqDNIPe4P7qFl8=;
	b=fNxGPUxHLCkBLTX0lWJHc92rsqP3zwEp7LV5blEPvoYDbWcTk2GOBqxPxwZ5mXYzYXHQjY
	TMvIMR7L+9O8b1b1+Ut/3IV75wjr4DwL9dzbERNp58FLbo7MgiqsZqY9YjJWIsWLsYSzHV
	7pO0HnNDeauZVXaCmj1v0YPnjmMq6Oo=
Date: Tue, 28 Apr 2026 21:54:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 02/18] bpf: Add precision marking and
 backtracking for stack argument slots
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171443.2034958-1-yonghong.song@linux.dev>
 <d85346c710e62c1ccf1babe1c5e5ebce6c757fb6.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d85346c710e62c1ccf1babe1c5e5ebce6c757fb6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/28/26 9:46 AM, Eduard Zingerman wrote:
> On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
>> Extend the precision marking and backtracking infrastructure to
>> support stack argument slots (r11-based accesses). Without this,
>> precision demands for scalar values passed through stack arguments
>> are silently dropped, which could allow the verifier to incorrectly
>> prune states with different constant values in stack arg slots.
>>
>> INSN_F_STACK_ARG_ACCESS is encoded as INSN_F_STACK_ACCESS |
>> INSN_F_DST_REG_STACK (BIT(9) | BIT(10)). This is safe because
>> INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns while
>> INSN_F_DST_REG_STACK is only used for JMP insns — they never appear
>> on the same instruction. This keeps the total within the 12-bit
>> jmp_history flags budget.
>>
>> Three components are added:
>>
>> 1. Jump history recording for stack arg accesses:
>>     - check_stack_arg_write() records INSN_F_STACK_ARG_ACCESS for
>>       outgoing stores.
>>     - check_stack_arg_read() records INSN_F_STACK_ARG_ACCESS for
>>       incoming loads.
>>
>> 2. backtrack_insn() handling:
>>     - BPF_LDX: when backtracking through an incoming stack arg load,
>>       transfer precision demand from the destination register to the
>>       stack arg slot mask.
>>     - BPF_STX/BPF_ST: when backtracking through an outgoing stack arg
>>       store, transfer precision demand from the stack arg slot to the
>>       source register.
>>     - Call boundary: when exiting a callee back to the caller,
>>       propagate the callee's incoming stack arg precision bits to the
>>       caller's outgoing stack arg slots. The slot index maps directly
>>       (slot i in callee corresponds to slot i in caller) since the
>>       caller's stack_arg_regs only contains outgoing slots.
>>
>> 3. bpf_mark_chain_precision() state walking:
>>     - When iterating parent states, mark stack_arg_regs[spi].precise
>>       for slots that have pending precision demand.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>   include/linux/bpf_verifier.h | 13 ++++++++
>>   kernel/bpf/backtrack.c       | 61 ++++++++++++++++++++++++++++++++++--
>>   kernel/bpf/verifier.c        | 30 +++++++++++++++---
>>   3 files changed, 98 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 2cc349d7fc17..735f33ad3db7 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -393,6 +393,13 @@ enum {
>>   	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>>   
>>   	INSN_F_STACK_ACCESS = BIT(9),
>> +	/*
>> +	 * INSN_F_STACK_ARG_ACCESS uses INSN_F_STACK_ACCESS | INSN_F_DST_REG_STACK.
>> +	 * This is safe because INSN_F_DST_REG_STACK is only used for JMP insns
>> +	 * while INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns — they
>> +	 * never appear on the same instruction.
>> +	 */
>> +	INSN_F_STACK_ARG_ACCESS = BIT(9) | BIT(10),
> Tbh, I'd split bpf_jmp_history_entry like this:
>
>    struct bpf_jmp_history_entry {
>           u32 idx:20;
> 	 u32 frame:3;
> 	 u32 spi:6;
>           /* insn idx can't be bigger than 1 million */
>           u32 prev_idx : 20;
>           /* special INSN_F_xxx flags */
>           u32 flags : 12;
>           /* additional registers that need precision tracking when this
>            * jump is backtracked, vector of six 10-bit records
>            */
>           u64 linked_regs;
>    };

Good point, let me try.

>
> [...]
>
>> @@ -453,9 +498,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					     bt_stack_mask(bt));
>>   				return -EFAULT;
>>   			}
>> -			/* clear r1-r5 in callback subprog's mask */
>> +			/* clear r1-r5 and stack arg slots in callback subprog's mask */
>>   			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>>   				bt_clear_reg(bt, i);
>> +			bt->stack_arg_masks[bt->frame] = 0;
> Nit: I think having these set at this point is a bug condition.

This one is a leftover from early patch and I didn't remove it. I just tested again.
this is indeed not needed. Will remove.

>
>>   			if (bt_subprog_exit(bt))
>>   				return -EFAULT;
>>   			return 0;
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> [...]
>
>>   static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
>> @@ -7269,8 +7285,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>>   	}
>>   	err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>> -	if (!err)
>> -		err = mark_chain_precision(env, reg_from_argno(size_argno));
>> +	if (!err) {
>> +		int regno = reg_from_argno(size_argno);
>> +
>> +		if (regno >= 0)
>> +			err = mark_chain_precision(env, regno);
>> +		else
>> +			err = mark_stack_arg_precision(env, arg_from_argno(size_argno) - 1);
>> +	}
> Nit: maybe make this a utility function, e.g. mark_arg_precision(env, argno) ?

Sure, will do.

>
>>   	return err;
>>   }
>>   

