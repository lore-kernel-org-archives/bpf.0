Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610692727FD
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432747; cv=none; b=lhl2Z9LvHDD29baa3uJBSAav2Ie2yMPTrO21ieLMzO1RVWW2fWw8IjSQxyFPkBLY/S7Pvnl6hJYq5tK2chqgLlvXV0VLBPFEgadH+Ojk3UVtBmZCa7rKH4pM3TBmaarUbD0rmrE1BiQ/fZWX9tOgPXi9CNn9opkIRuaDzww9zn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432747; c=relaxed/simple;
	bh=UCkOgVeofJL7dUPQt9pwF0wexdxVfpgQYmBFpq4Nwi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhvUI7Zmy1YgSlxaynP8xLsoXgmNw27tJH38GMVIyISU3xapksH7v7jx6Ub1Ku0g9dEQUGyyT9DlwmQf6oQ1En6dbq8+i8G17nEG+7SwvcPa69tw9QmIkNHfAZdQMNqUvtXaT2KKLH1qbwHBcSAreq22AlB1gcBCotOCeybAq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vwY0xrzX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vwY0xrzX"
Message-ID: <a4851c0b-d735-4bde-a09c-74de9aec11a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778432734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRzaui2r5Ptxo+c6EDyBkYWlSq4gBkxPB1YKEibpd9w=;
	b=vwY0xrzXkXQ7y9gLSzhtzePT4VRKEdk2rPWud7671W+6Y4XwShIWXghwxCLIJRSoinvxHX
	qmBuZvWjGjzrWvzIbExmJO3cL0EUq+5TwR6dXq3l2sRZac2ISXf95gSNjeJnQKsyFyyt5V
	Yh3h5cwoo2htItXLqLsvkPoH/hjEjn0=
Date: Sun, 10 May 2026 10:05:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/23] bpf: Prepare architecture JIT support
 for stack arguments
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213039.1130658-1-yonghong.song@linux.dev>
 <20260509021940.680C0C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509021940.680C0C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 4:19 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Static functions with more than 5 parameters are not actually rejected when the JIT does not support stack arguments. This bypasses verifier stack initialization checks and allows the program to run, leading to arbitrary kernel memory access at runtime.
> - [Low] The patch returns the kernel-internal error code -ENOTSUPP instead of the standard -EOPNOTSUPP, causing generic 'Unknown error 524' messages in user-space.
> --
>
> commit e571d76e56fcb6ad5c6cc343d3221d66e6aec024
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare architecture JIT support for stack arguments
>
> This commit introduces a weak function bpf_jit_supports_stack_args() to allow
> architectures to indicate support for BPF stack arguments. It also updates
> the BTF preparation code to reject functions with more than 5 arguments if
> the JIT does not support stack arguments.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index ec3fb8c8f4eef..bf83b737d55cb 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -7886,8 +7886,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   			MAX_BPF_FUNC_ARGS, tname, nargs);
>>   		return -EFAULT;
>>   	}
>> -	if (nargs > MAX_BPF_FUNC_REG_ARGS)
>> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +		if (!bpf_jit_supports_stack_args()) {
>> +			bpf_log(log, "JIT does not support function %s() with %d args\n",
>> +				tname, nargs);
>> +			return -ENOTSUPP;
> Should this return -EOPNOTSUPP instead of -ENOTSUPP?
>
> -ENOTSUPP is a kernel-internal error code (524). If this error bubbles up
> to user-space (for example, when loading a global BPF program), it might
> result in a confusing "Unknown error 524" message rather than a standard
> error.
>
> Also, does returning an error here actually reject static functions with
> more than 5 arguments?
>
> Looking at the code just above this diff, sub->arg_cnt is set to nargs
> before the check:
>
> kernel/bpf/btf.c:btf_prepare_func_args() {
> 	...
> 	sub->arg_cnt = nargs;
> 	...
> 	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> 		if (!bpf_jit_supports_stack_args()) {
> 			...
> 			return -ENOTSUPP;
> 		}
> 	...
> }
>
> If this returns -ENOTSUPP, it propagates to btf_check_subprog_call(),
> which returns the error. However, check_func_call() ignores non-EFAULT
> errors for static functions:
>
> kernel/bpf/verifier.c:check_func_call() {
> 	...
> 	err = btf_check_subprog_call(env, subprog, caller, ...);
> 	if (err == -EFAULT)
> 		return err;
> 	...
> }
>
> Since the error is ignored, verification continues without rejecting the
> program. Because the error was returned early, btf_check_func_arg_match()
> skips check_outgoing_stack_args(), meaning the caller is never forced to
> properly initialize the stack slots according to BTF types.

I will use -EFAULT error code, so the prog with potential stack arguments
will be rejected due to -EFAULT. This applies to below analysis where
they will not really work as -EFAULT will prevent that.

>
> Since sub->arg_cnt was already set to nargs, bpf_in_stack_arg_cnt() will
> calculate that the function takes stack arguments. If the caller manually
> initializes the stack argument slots by writing to r11, the verifier tracks
> the register types and might accept the program.
>
> At runtime, since the JIT does not support stack arguments, BPF_REG_PARAMS
> (r11) is likely missing from the JIT's register translation maps.
> Uninitialized entries default to 0, which often maps to the return value
> register (like rax on x86 or x0 on arm64).
>
> Could this cause reads or writes against r11 + offset to be translated
> into memory operations against rax/x0 + offset? Since the return register
> is easily controllable by the BPF program, might this allow arbitrary
> kernel memory reads and writes?
>
>> +		}
>>   		sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS;
>> +	}
>>   
>>   	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>>   		bpf_log(log, "global function %s has %d > %d args, stack args not supported\n",

