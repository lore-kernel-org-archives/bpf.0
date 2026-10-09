Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A74E9C35
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567526; cv=none; b=BjpXjsVOL0Qulczt8jSb3ptWTYuAVdx2MY1VYhMObZawsuTReqqNn+nyO9FB7AVy7HJb391xUGSz/aZ6MqIzxLpT/bIv/LAW/EgB0sxTSCF2pitoPSyJ0tkkaO7jBkD2km6fDk3HsrHu80kavQASISEGrWN+dDfjTRMdx1WbTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567526; c=relaxed/simple;
	bh=zHUuzKnIPNhWiXNI+dpd0f8/Q7kFufm5tGlpb3pCMPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jxr8HqVaHZtkJ2DjFawibebWtnxmLaDlL1BZTsRGb/brUT0uk0SsxzX1MySAckiyIX+7hUTUMvNQkwtdoPM0MV/AzFCvohIh/bp7DI+OZlqJGwmrmgeNz/1qqqN3BdnjJbwHLDkzXE86PQJXdJcM+OEL9AKNGAxkEdo6PXSsvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wyojo/YE; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wyojo/YE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zHUuzKnIPNhWiXNI+dpd0f8/Q7kFufm5tGlpb3pCMPc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791567520; v=1; x=1792172320;
 b=Wyojo/YEw4IxsClYNWoFkzNk5n0dcfqHt7qGqzDwMwXKExl+x3hSYusKvMZsVwfskpxgN7RW
 K2rZ9v6kncLMAhqjIRlaDsncYuXnoQqWxX4iJsvcVRdoEIpOo0/poeW3shb7Mj8VBzPrAFhcuDw
 Uj/LTtEr+PCx3bZa3cy1Iy1A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e32b73b4469d334d;
	Fri, 09 Oct 2026 17:38:40 +0000
X-Mizu-Trace-ID: e32b73b4469d334d
X-Migadu-Flow: FLOW_OUT
Message-ID: <ea470d9c-de17-4b1c-9cbe-174e30c44f88@linux.dev>
Date: Fri, 9 Oct 2026 19:38:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/5] bpf, x86: Place trampoline arguments by the
 x86-64 calling convention
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
 <20261009064221.1240081-1-yonghong.song@linux.dev>
 <sashiko-outbox-164976@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164976@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/26 9:08 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] bpf, x86: stack arguments offset mismatch and misalignment with BPF_TRAMP_F_TAIL_CALL_CTX
> - [Medium] bpf: info leak of uninitialized kernel stack memory due to missing garbage cleanup
> --
>
> commit ffb54c9ff7ace6fffcfc471ab2c2927e34131e44
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Place trampoline arguments by the x86-64 calling convention
>
> This commit updates the BPF trampoline to place on-stack arguments
> according to the x86-64 calling convention. It introduces a backfill
> mechanism using bpf_jit_place_args() to handle arguments like __int128
> that may span stack slots and create alignment holes.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 083fcd6cf15b7..0fc7715e569b5 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -3472,8 +3479,35 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
>>   		 *
>>   		 * the arg1-5,arg7 will be passed by regs, and arg6 will
>>   		 * by stack.
>> +		 *
>> +		 * An argument aligned to 16 bytes, an __int128 or a struct
>> +		 * holding one, also starts at an even stack slot, which can
>> +		 * leave a hole before it. bpf_jit_place_args() worked out
>> +		 * where each eightbyte is.
>>   		 */
>> -		if (nr_regs + arg_regs > 6) {
>> +		for (j = 0; j < arg_regs; j++, slot++, bargs_off -= 8) {
>> +			u8 pos = pos_of_slot[slot];
>> +			u32 src;
>> +
>> +			if (!x86_arg_on_stack(pos)) {
> [ ... ]
>> +			/* copy function arguments from origin stack frame
>> +			 * into current stack frame.
> [ ... ]
>> +			 *
>> +			 * The area for the origin call mirrors the incoming
>> +			 * one, hole and all; only the bpf program takes the
>> +			 * arguments packed.
>>   			 */
>> -			for (j = 0; j < arg_regs; j++) {
>> -				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
>> -					 nr_stack_slots * 8 + stack_args_off);
>> -				if (arena_arg)
>> -					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
>> -							    (u32)arena_base);
>> -				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
>> -					 -stack_size);
>> -
>> -				if (!nr_stack_slots)
>> -					first_off = stack_size;
>> -				stack_size -= 8;
>> -				nr_stack_slots++;
>> -			}
>> +			off = x86_arg_stack_off(pos);
>> +			doff = for_call_origin ? stack_size - off : bargs_off;
>> +			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
>> +				 stack_args_off + off);
>> +			if (arena_arg)
>> +				emit_arena_arg_conv(prog, BPF_REG_0, nullable,
>> +						    (u32)arena_base);
>> +			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -doff);
>> +
>> +			if (!nr_stack_slots)
>> +				first_off = doff;
>> +			nr_stack_slots++;
>>   		}
>>   	}
>>   
>>   	clean_stack_garbage(m, prog, nr_stack_slots, first_off);
>>   }
> [Severity: Medium]
> Does this code leak uninitialized kernel stack memory?
>
> The x86-64 ABI allocates 8-byte stack slots for arguments, but compilers
> frequently use 32-bit instructions to place 32-bit arguments, leaving the upper
> 4 bytes of the slot uninitialized.
>
> Since clean_stack_garbage() explicitly returns early when nr_stack_slots != 1,
> copying the full 64 bits with emit_ldx(..., BPF_DW, ...) captures this
> uninitialized kernel memory into the BPF context. Can this leak kernel stack
> memory to privileged BPF users if there are multiple stack arguments?

We probably will be okay since for bpf program, the return value will be
narrowed based on return type.

>
> [ ... ]
>> @@ -4011,8 +4014,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>   	}
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> -		restore_regs(m, &prog, regs_off);
>> -		save_args(m, &prog, arg_stack_off, true, flags, 0);
>> +		restore_regs(&prog, pos_of_slot, nr_regs, regs_off);
>> +		save_args(m, &prog, pos_of_slot, arg_stack_off, true, flags, 0);
>>   
>>   		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
>>   			/* Before calling the original function, load the
> [Severity: High]
> Are stack arguments misaligned here if BPF_TRAMP_F_TAIL_CALL_CTX is active?
>
> When __arch_prepare_bpf_trampoline() executes, it checks for
> BPF_TRAMP_F_TAIL_CALL_CTX and emits a push rax instruction (pushing 8 bytes)
> after sub rsp, stack_size, which permanently shifts RSP down by 8 bytes.
>
> However, the updated save_args() calculates the stack argument offsets based on
> the original stack_size (doff = stack_size - off) without accounting for this
> extra 8-byte shift.
>
> Because the push rax is unpopped before call orig_call, the original function
> will read its first stack argument from [RSP + 8]. Due to the 8-byte shift,
> this points to the tail call counter pointer instead of the actual first stack
> argument, corrupting all on-stack arguments.
>
> Additionally, doesn't this 8-byte shift break the required 16-byte stack
> alignment on function entry for x86-64?

This patch just allows 16-byte aligned parameters with possible holes. The
rest of change should be the same as the original code. Here you mentioned
a 'push rax' before calling orig_call. These should be okay, 16-byte aligned
parameters may have holes but it should not damage the 'push rax' or calling
orig_call. I will see whether we can add some tests for this.

