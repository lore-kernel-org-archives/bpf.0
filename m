Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853F2DA759
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980476; cv=none; b=dB+GnjKr8oXSWVUbjg0QnotwHQZQ2PlYoZiXOElJ/HMPiUhBv+JWQEwj0M8/FQEpFZR9yU0sfbFrO4oqMPxIOmoTzH70O2uH4Jb7wQ+72IxaCDwWyGulgNaTYCVJIBvlrMYPS+WEmVj5msarIOlVPXwUPWdn540ubOCyQSRINIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980476; c=relaxed/simple;
	bh=NgKFsXHXsRY42cD3qXOlof94k4yq0ZYuAQVdju5hrVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH4a9DJml4ee8sRLlIfTn1Z5UTCzj3KzBNaiCWPJ3WvG6z2QozjaSCmDqCg/vEsG8kMPk8ZsN6ZWK6tANcqFKC3KSLJdjPobd1gw8jtfugZbKQYQ4r1HVzSlg7mjz4zffR80eD1iZD1ZNSjZvbkP8FSHlwe8n+pUYrWjpFY03/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sJdJ/gg4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sJdJ/gg4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NgKFsXHXsRY42cD3qXOlof94k4yq0ZYuAQVdju5hrVs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786980472; v=1; x=1787585272;
 b=sJdJ/gg4orQdgBNNCcyt6twUY16K4x6NZaa6KVy2eGbOYBHfggSxGt0hHr1sg81o6P/5K2ig
 RyB2ToEpOQy9xtdAEBUgLQu+d8jyA6JBrt8qaRNhsq7wFvgaaby+9DRlEKXne2TpG3gb6BGFQT3
 esd3OKiQjI1t2qctPL3iVqa0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id c9f4636a47064d55;
	Mon, 17 Aug 2026 15:27:52 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <063bfcd1-7ebf-4832-a401-9ab5b8db95a2@linux.dev>
Date: Mon, 17 Aug 2026 08:27:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 04/10] bpf: Handle R2 as a return register in
 precision backtracking
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260817042202.2288574-1-yonghong.song@linux.dev>
 <412885dce17d0fa3a3a9d5eff1d9bd06a100f7f17ed66700bda5e9851881262b@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <412885dce17d0fa3a3a9d5eff1d9bd06a100f7f17ed66700bda5e9851881262b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 10:17 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Handle R2 as a return register in precision backtracking
>>
>> Precision backtracking treats only R0 as a return register at a
>> call/return boundary, so once the verifier starts modeling R2 that way,
>> marking the second half of such a return precise would trip the
>> "unexpected regs" checks in backtrack_insn() and reject a valid
>> program.
>>
>> Marking the upper half precise, for example by branching on it after a
>> call to a static subprogram, walks backtracking into the callee and
>> reaches its BPF_EXIT with R2 still set in the mask. Handle R2 like R0
>> in boundaries where a call defines the return registers.
>>
>> R2 differs from R0 in that it is an argument register as well, so it is
>> part of the BPF_REGMASK_ARGS check and has to be cleared before that check
>> rather than next to R0. Clear it unconditionally, rather than only where
>> the callee or the kfunc really does return a pair. That gives up the
>> "unexpected regs" assertion for R2, and in exchange keeps backtracking
>> free of any BTF lookup. Nothing is lost: a callee that does not return
>> a pair leaves the caller's R2 uninitialized, so the main verification
>> pass has already rejected any program that reads it, and backtracking
>> is never asked for its precision.
>>
>> At BPF_EXIT the return registers are sampled before the callback path
>> clears R1-R5. That clear does not touch R0, but it does cover R2, and
>> running it first would drop a pair return whenever the instruction
>> following the call happens to be one that invokes a callback.
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for 16-byte return support. Should this
> include:
>
>    Fixes: 162762023c59 ("bpf: Add helpers to describe the R0:R2 return register pair")

This Fixes tag is not needed, esp. it is in the same series.

>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index a2b18a9f1694..653db80bcc47 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>
>> @@ -520,7 +524,25 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
>> -			bool r0_precise;
>> +			bool from_subprog_call, r0_precise, r2_precise;
>> +
>> +			/* BPF_EXIT in subprog or callback always returns
>> +			 * right after the call instruction, so by checking
>> +			 * whether the instruction at subseq_idx-1 is subprog
>> +			 * call or not we can distinguish actual exit from
>> +			 * *subprog* from exit from *callback*. In the former
>> +			 * case, we need to propagate the precision of the
>> +			 * return registers, if necessary. In the latter we
>> +			 * never do that.
>> +			 */
>> +			from_subprog_call = subseq_idx - 1 >= 0 &&
>> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
>> +
>> +			/* Sample the return registers before the callback
>> +			 * handling below clears R1-R5.
>> +			 */
>> +			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
>> +			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
> A subsystem pattern flags this as potentially concerning: the multi-line
> comment above starts its text on the opening /* line:
>
> 	/* Sample the return registers before the callback
> 	 * handling below clears R1-R5.
> 	 */
>
> The BPF subsystem guide suggests putting /* on its own line for
> multi-line comments under kernel/bpf/:
>
> 	/*
> 	 * Sample the return registers before the callback
> 	 * handling below clears R1-R5.
> 	 */
>
> Every existing multi-line comment in backtrack.c uses the older form,
> including the comment block that this same hunk moves, so matching the
> file's dominant style is a plausible reason to write it this way. Does
> the newer form matter here?

I think it is okay. The new comment format is from the old one.

>
> [ ... ]
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373

