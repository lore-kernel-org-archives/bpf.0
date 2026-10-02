Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37F38D3EE
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977099; cv=none; b=h2cWmSfhHVT277nNZM/T81cYI0gOvtCW7xelMkNZWT7Vxwn8qGhxtJVdP3QVv8ZP/arktigTcR5lsUiymvN6iEAfEcY3JhyrHGyrD3A+GVv2L3QwhOmuLwkO/yjo6uxaEq1Gq/4csEacOwA74PslCC/9sSemlBPW7s6UWAh4Gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977099; c=relaxed/simple;
	bh=6xj9G+hO2E8Rup5Rebq4o/z0qfUuQjKKHqrGjcHWkWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftMtawz/TOP3+0OPJdG62GVgZhgunYWXXxp0lm4vWAHplLbLumC/CuLi887V6o6Jmq9ii7JZmoZlI/biKT+LFp1oiAWeISOvGr9unhSWSEewZUAxn0+FmuhWvqm4/555A/0ku4tAj7k6eGHbJtYdc8AwXAUuLc8YjQ4d1gEFrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWRrHztc; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWRrHztc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6xj9G+hO2E8Rup5Rebq4o/z0qfUuQjKKHqrGjcHWkWM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790977095; v=1; x=1791581895;
 b=gWRrHztcKEll2wUg8yT0261cDMQlkV8AGGBXuDZP8niCl7Kw4dOz1JuWMmZPhSeHKJrYtLx5
 LIz3d5iXx4yMQCvC6ZSuUpTwwarByJ2dt8jTQJQZxHr5abf3gEywCMQIhNL2nRs+JgcIDAFA3TQ
 zKYWUP5GipodaZW5IbMKswH8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5fbcbfcf31f29bd7;
	Fri, 02 Oct 2026 21:38:14 +0000
X-Mizu-Trace-ID: 5fbcbfcf31f29bd7
X-Migadu-Flow: FLOW_OUT
Message-ID: <5baeae3d-ef4c-4932-9744-aa4dc7b8e6ae@linux.dev>
Date: Fri, 2 Oct 2026 22:38:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 10/22] bpf: Do not use a private stack for a
 program that can unwind
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133058.1340406-1-yonghong.song@linux.dev>
 <20261001135340.CAE3F1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001135340.CAE3F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 6:53 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: callee-saved register corruption via bpf_throw without cleanup
> --
>
> commit 9d2c0e8faeb024a4647980c48ca2caa933b90b1c
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Do not use a private stack for a program that can unwind
>
> This commit disables private stacks for BPF programs that can unwind
> because an unwind skips the pop instruction corresponding to the push r9
> emitted around calls. This forces NO_PRIV_STACK in check_max_stack_depth()
> for programs with cleanup records or that may unwind.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f3ed68960d70d..488ceb9dae1b6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5769,6 +5769,17 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
>> +	 * by a pop after the call that an unwind skips. A frame resumed at a
>> +	 * pad then addresses its stack through a stale pointer, and a frame
>> +	 * sent to its epilogue instead pops its callee-saved registers one
>> +	 * slot off. Refuse a private stack for any program that can unwind,
>> +	 * on every arch for now.
>> +	 */
>> +	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
>> +		priv_stack_mode = NO_PRIV_STACK;
> [Severity: High]
> Does this logic miss programs that call bpf_throw() without any cleanup
> records?
>
> If a privileged program uses private stacks and calls bpf_throw() without
> acquiring any resources requiring cleanup, cleanup_info_cnt will be 0.
>
> Looking at bpf_prog_may_unwind() in kernel/bpf/exception.c, it only checks
> might_unwind:
>
> kernel/bpf/exception.c:bpf_prog_may_unwind() {
> 	u32 i;
>
> 	for (i = 0; i < env->subprog_cnt; i++)
> 		if (env->subprog_info[i].might_unwind)
> 			return true;
> 	return false;
> }
>
> Since bpf_throw() only sets might_throw, not might_unwind, it appears
> bpf_prog_may_unwind() will return false.
>
> Could this bypass the NO_PRIV_STACK enforcement and lead to the exception
> callback epilogue popping the misaligned stack (shifted by the skipped
> push r9) into the kernel's callee-saved registers?

I cannot figure out a condition to have misaligned stack (i.e. using r9)
like the above condition.

I think the current condition should be okay.

>
>> +
>>   	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
>>   		priv_stack_mode = bpf_enable_priv_stack(env->prog);
>>

