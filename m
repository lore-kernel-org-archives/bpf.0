Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA71FFC48
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777094243; cv=none; b=knfemy8z/rRBO+jo08My6xzG7TU2zIx2AaceXP800rlznPxzupscIKskN1GACtUCoTWKAkrQdmBlnMyntBIWuDoNpfFPflygmTUinhfAqMgHexrpDhQVvrPq42pGAVMFkIGdeeYS/kSTmN9ywr+f1U3HQz6bJtwsFtvUpiEJ8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777094243; c=relaxed/simple;
	bh=uEcH2FQpiUvX9VY7uC2CNS64cbKchBb8adgnc+2BxZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxit5SpJsoC0N7py3nPjcwoZpK6904gInULs1ye+lkE50umrWyUs3W/loWJXI6SYY91wricV5gSp/ZFuB/cZhLuXi97eaEV51X5+e3PVHJ7gaVsQjXmJjLpq4IOuCFZ0OfPDj6CnQ+fXEzPJ4ktp43FSJ0AyZbffO5o3PrmYVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WlCNUViS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WlCNUViS"
Message-ID: <e60f2dc0-7965-4798-8163-b2796da99b30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777094240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLX13By7Dm82G9HHmibyy2jAE0S0t8TeBgCK3XA7/TE=;
	b=WlCNUViSKEwk8WHNm1mhVPbpX6Xv9iGMg0BX/7d1oDpEP/YlzAuxN9ImziqeftRsonwLSM
	EDdhXZJ9z+DbN4B7YFZiGzs1uKK+wxBboomg9+G2XcLJkvm/KBcVpcm9Il7JLgEXsLlsbI
	Ex7GR3KhvAWajitVXhY0EdWm0GZYxhY=
Date: Fri, 24 Apr 2026 22:17:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 06/18] bpf: Prepare architecture JIT support for
 stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 puranjay@kernel.org, eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171504.2039094-1-yonghong.song@linux.dev>
 <040596e7a15775a0a56f0acefecd21dc43ff423e157324315f7a4b36c8b51e82@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <040596e7a15775a0a56f0acefecd21dc43ff423e157324315f7a4b36c8b51e82@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 10:48 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index b77d0b06db6e..911205dd670e 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
> [ ... ]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index cfb35a2decf6..fa4b971c5289 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index ec8523e6e4eb..7522b3d7b267 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e041c182c614..0ba140dabe93 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12254,6 +12254,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   			MAX_BPF_FUNC_REG_ARGS);
>>   		return -EINVAL;
>>   	}
>> +	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
>> +		verbose(env, "JIT does not support kfunc %s() with %d args\n",
>> +			func_name, nargs);
>> +		return -ENOTSUPP;
>> +	}
> Can this new check ever execute? The existing check immediately above already
> rejects all kfuncs with nargs > MAX_BPF_FUNC_REG_ARGS by returning -EINVAL.
>
> Since control only reaches the new if statement when the previous check
> passes, nargs must be <= MAX_BPF_FUNC_REG_ARGS. The condition
> 'nargs > MAX_BPF_FUNC_REG_ARGS' in the new check is therefore always false
> at this point.
>
> Looking at the commit message's statement "Reject BPF functions and kfuncs
> with more than 5 parameters at verification time if the architecture does not
> support stack arguments," it appears the intention was to conditionally reject
> based on JIT support. However, for kfuncs, the unconditional rejection
> happens first.
>
> The btf_prepare_func_args() change does work as intended because its earlier
> guards allow nargs up to MAX_BPF_FUNC_ARGS for certain subprogs before
> reaching the stack-args check.
>
> A later commit in this series (73a990fcc429) raises the first check in
> check_kfunc_args() from MAX_BPF_FUNC_REG_ARGS to MAX_BPF_FUNC_ARGS, which
> would make the new branch reachable. Should this hunk be combined with that
> change to avoid introducing unreachable code?

You are right. The above check does not really work as it is a noop.
And it really works until "bpf: Support stack arguments for kfunc calls".
Therefore, as you mentioned, it should be combined with
"bpf: Support stack arguments for kfunc calls".

Will do with next revision.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

