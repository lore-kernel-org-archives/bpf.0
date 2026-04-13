Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9B3168EE
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099012; cv=none; b=JBsefCZWAXya6gwuE9kXNtG3QjhxE3goHkg6iprFAizQcnFMP0Lnb+7F8eCrtlw/GpJMaKCeuLN5ejMaimL3Xe/uU4wSLkd1J/Tvlukw8VBeph03cxaz4w5DXR2FssWyafIy7Dus6k2tHQMS6JRwfN8MPZcXCyeeV5zfIrG3nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099012; c=relaxed/simple;
	bh=snZ0Z0covNbsFVyVyKinND730Rk2RH5UsWIZBjVQUE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYORT6UWkzpyL8jMdORPWZsqz34ylBaq7mUyepnZAg208ijFNjPMhIf+XInfxfd24TJR6WxxqBEIFBZVcEkvLdgLE9mwf+zQrqBz1oFgWoImb/zMACI/qUAEM5dGs8d9BhSh9Faf3J69fZJkhKeOnCQToteD9F34FhGWgFPzB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtC7aaAw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtC7aaAw"
Message-ID: <baeaaf70-f5d8-4af8-9673-16bdcbec1a00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776099008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9MCkPSEMK2vZncf5g+esXVaRYQ5lGX8SyBiDWinShk=;
	b=ZtC7aaAw8xrgswuUcZwBCpLcogI/3164/yWU8RmW66sRjdIW9pSl9Zel/L51SiXKAjiFAC
	v9Mzo8ynFphZX9Giw2mdFgq0A1/cSn0otmae1dSMEl/uNPEtyltdFGh7+eZXJ4SG5lJz5l
	fy5si5/c080jkmK5NJ0smQ2lpQ96qNQ=
Date: Mon, 13 Apr 2026 09:49:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412050033.267815-1-yonghong.song@linux.dev>
 <257c9ac68d5ab6ec929cd3d53c54793a848a6cfa07a65e9473ee66a4d44f2cc3@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <257c9ac68d5ab6ec929cd3d53c54793a848a6cfa07a65e9473ee66a4d44f2cc3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..ec57b9a6b417 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1664,16 +1699,48 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> [ ... ]
>
>> +	/*
>> +	 * The verifier guarantees that neither tail_call_reachable nor
>> +	 * priv_stack is set when outgoing stack args exist, so R9 is
>> +	 * always available.
> [ ... ]
>
>> @@ -2243,6 +2377,18 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>   			insn_off = insn->off;
>> +			if (adjust_stack_arg_off) {
>> +				if (insn_off == 8) {
>> +					/* Incoming arg 6: read from r9 */
>> +					EMIT_mov(dst_reg, X86_REG_R9);
>> +					break;
>> +				}
> [ ... ]
>
>> @@ -3757,7 +3907,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		prog->aux->jit_data = jit_data;
>>   	}
>>   	priv_stack_ptr = prog->aux->priv_stack_ptr;
>> -	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
>> +	/*
>> +	 * x86-64 uses R9 for both private stack frame pointer and
>> +	 * outgoing arg 6, so disable private stack when outgoing
>> +	 * stack args are present.
>> +	 */
>> +	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack &&
>> +	    prog->aux->stack_arg_depth == prog->aux->incoming_stack_arg_depth) {
> This condition disables priv_stack when outgoing stack args are present,
> but R9 is also used for incoming arg 6. Could a subprog with incoming
> stack args (incoming_stack_arg_depth > 0) and no outgoing stack args
> still get priv_stack allocated here?
>
> The condition stack_arg_depth == incoming_stack_arg_depth is true when
> outgoing is zero, regardless of the incoming depth. When priv_stack is
> allocated, emit_priv_frame_ptr() in the prologue overwrites R9:
>
>    emit_mov_imm64(&prog, X86_REG_R9, ...priv_frame_ptr...);
>
> Later, the LDX handler for incoming arg 6 reads R9 expecting the
> caller's 6th argument:
>
>    if (insn_off == 8) {
>        EMIT_mov(dst_reg, X86_REG_R9);
>        break;
>    }
>
> For a subprog with 6+ args and >= 64 bytes of stack (triggering
> PRIV_STACK_ADAPTIVE in check_max_stack_depth_subprog()), R9 would
> contain the private stack frame pointer instead of the incoming arg 6
> value.
>
> The comment also says "outgoing arg 6" but should this also mention
> incoming arg 6, since both use R9?
>
> Would changing the condition to check that stack_arg_depth is zero
> (no stack args at all) be the right fix here?

You are right. Previous approach is to copy *all* 6+ arguments to the
stack for bpf-to-bpf, in which case, R9 will not be used.

But the new approach is to following x86_64 calling convention for
bpf-to-bpf call as well. In this case, indeed, we should disable
private stack if stack_arg_depth is not zero.

>
>>   		/* Allocate actual private stack size with verifier-calculated
>>   		 * stack size plus two memory guards to protect overflow and
>>   		 * underflow.
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

