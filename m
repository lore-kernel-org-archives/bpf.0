Received: from mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F53630AC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560395; cv=none; b=AiVVURc87uJRpRq8FronQH8DRXCNLTGqkDsx/GgbadgM5CQSYs53RHganvcK2f30/vx6iAznXnetMHouVk35cnOf4rJdLo/u88caqamEuhdqfJel+pE7nxDh05TLYl5CGPUwMIc2qjmKGp2zqe6unPYWpQRO779PiKcSOPlEC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560395; c=relaxed/simple;
	bh=rNzYCUi6Npjhu4k9ajSJaAwpRCRGSH4iyjFMgHGkDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PU77aWhxPQoC+DdjK91hlyzF7OFz7uCYpxBZCKfaL+5ionw7fSCfI+j+z6kfKQjDuucvd5UrxQss1lNyy7Iq/+ttw71dfoXPkj11tOMpRQnvL3oveyVaiIXHkbIl0VQkjnh5DLjQpwDFWH/jIshHCYCf7C6KQhAJE3NYDPV978c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fsd2P7GM; arc=none smtp.client-ip=95.215.58.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fsd2P7GM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rNzYCUi6Npjhu4k9ajSJaAwpRCRGSH4iyjFMgHGkDkA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791560390; v=1; x=1792165190;
 b=Fsd2P7GM1TncK+CGo/25NRv3H/jPRAAtPTvB0yUneET29bmq6VCIxseN39yiYCvTZixLLqMC
 7im94/pihNzN6z/Mqr2gIMS8EXPB/sPqdDss4Z76VquIj6IkTTCnx9Tv9o7qQfNMN29FoeoJWzM
 X+Jrh2/fkYvcYeXP8+EY7/Eg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9b1b0e4ddc4cf102;
	Fri, 09 Oct 2026 15:39:00 +0000
X-Mizu-Trace-ID: 9b1b0e4ddc4cf102
X-Migadu-Flow: FLOW_OUT
Message-ID: <d4e436fa-818c-458d-b6bd-8028a2bb414f@linux.dev>
Date: Fri, 9 Oct 2026 17:38:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 10/24] bpf: Do not use a private stack for a
 program that can unwind
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041539.28288-1-yonghong.song@linux.dev>
 <sashiko-outbox-164850@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164850@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 6:45 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: bpf_prog_may_unwind misses might_throw, causing private stack corruption
> --
>
> commit 38438f251d7fce91364c50842e5e55c25b6033f4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Do not use a private stack for a program that can unwind
>
> This patch aims to prevent BPF programs that can unwind from using a private
> stack. A private stack keeps its frame pointer in %r9 on x86-64, and an
> unwind skips the restore, leading to stack addressing issues. The fix forces
> NO_PRIV_STACK for programs that might unwind.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 2b9640099269e..f45dd3157f7fb 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> @@ -183,6 +183,16 @@ static void mark_call_sites(struct bpf_verifier_env *env)
>>   	}
>>   }
>>   
>> +bool bpf_prog_may_unwind(const struct bpf_verifier_env *env)
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < env->subprog_cnt; i++)
>> +		if (env->subprog_info[i].might_unwind)
> [Severity: High]
> Does bpf_prog_may_unwind() miss the might_throw condition?
>
> Since might_unwind and might_throw are tracked separately in
> bpf_subprog_info, it appears a BPF program using bpf_throw() would bypass
> this check and still be compiled with a private stack.

If only might_throw (bpf_throw), private stack can be used.
Here, we have might_unwind() as well, in such cases, we have

         if (env->cleanup_info_cnt || bpf_prog_may_unwind(env)) {
                 ret = bpf_exc_check_prog(env);
                 if (ret)
                         goto skip_full_check;
         }

and bpf_exc_check_prog(env) will reject bpf_throw(), i.e., if
bpf_unwind() and bpf_throw() co-exist, verification will fail.

>
>> +			return true;
>> +	return false;
>> +}
>> +
>>   int bpf_exc_check_prog(struct bpf_verifier_env *env)
>>   {
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 59b275bfc949d..35013a5d84019 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -5801,6 +5801,17 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
>> +	 * by a pop after the call that an unwind skips. A frame resumed at a
>> +	 * pad then addresses its stack through a stale pointer, and a frame
>> +	 * sent to its epilogue instead pops its callee-saved registers one
>> +	 * slot off. Do not use a private stack for any program that can
>> +	 * unwind, on every arch for now.
>> +	 */
>> +	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
>> +		priv_stack_mode = NO_PRIV_STACK;
> [Severity: High]
> Will this leave programs that throw exceptions vulnerable to stack shifting
> in check_max_stack_depth()?
>
> If a program uses bpf_throw() and is compiled with a private stack
> (PRIV_STACK_ADAPTIVE), the x86 JIT pushes the private frame pointer (%r9)
> before every call.
>
> When bpf_throw() is called, the ORC unwinder calculates the boundary frame's
> stack pointer as the value of %rsp before the call, which includes the
> un-popped %r9 (shifting it by -8 bytes). Then bpf_exception_cb() uses this
> value to restore the boundary frame's callee-saved registers.
>
> Because of the unaccounted %r9 push, the stack pointer is off by 8 bytes.
> Could this cause pop_callee_regs to pop the stale %r9 into a callee-saved
> register, shift all other registers by one slot, and ultimately corrupt the
> callee-saved registers?

See above, bpf_throw() and bpf_unwind() cannot co-exist in the same bpf prog.

>
>> +
>>   	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
>>   		priv_stack_mode = bpf_enable_priv_stack(env->prog);
>>

