Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF440DFBD
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776659019; cv=none; b=gVfM5EgBor82IqkIicuNWgwljGpuazZwhcymIXDycqHgQgyb2JXFGdhPW6RJNdBeSioyvZsggrV4yBHpgV6ScTZStyfmryNq/SIgTvrTArWrShWvMAZN/IGJ9qXIcuo088aV7NxsRHZtN1XyB0r9dEaXSMiT8y0YrL/pJS6wFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776659019; c=relaxed/simple;
	bh=8EeZQF3ZFmG/UaoKRoLD6q7Vz6AAb5FLXqLMHNO4GlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nek+R2CdtH37c0DpBlWXHw59d5RTijiplSIXM0l5y2qJVt/nWTXl28kDMunzZfgQK94m3RVufIuKfdUT7KNFib/JgvVRoWLIUZO3YDUhZjF+SGTeSpwY/0mRaujHTMjjTIGPVM4HTUsjySrK05t6Hl0Pbx2m85WtyLFiEgwPo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5LOYTfR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5LOYTfR"
Message-ID: <8582cfa9-b1ae-411e-893c-aa2d3b0e1012@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776659006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9abRJ72j4QFXz3H6EEWTK80D4I2r4KirAFIUEiOX+mE=;
	b=f5LOYTfRREnnTuTWCVL7I0ZI0Wd63zlf7NbC8N4ft6jWcTD0pM5ibUSYOBcYzmC90xXpFP
	k0cuH81xxSsTfukTme6OJDhVG9VAsKivb5xZ/xt2kMkZ6SeEJ9oOfHOoJqlcpKPJplDqw7
	R7Wp491h6FJk2I8kyclAQPo6+0nW534=
Date: Sun, 19 Apr 2026 21:23:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 08/17] bpf: Reject stack arguments in
 non-JITed programs
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163357.734345-1-yonghong.song@linux.dev>
 <20260419182148.BD42FC2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419182148.BD42FC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 11:21 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] The loop in `bpf_fixup_call_args()` incorrectly rejects main BPF programs with >5 arguments in their BTF signature when JIT is disabled, even though main programs do not actually use stack arguments.
> - [High] Standalone global functions with stack arguments can incorrectly fall back to the interpreter if JIT compilation fails, leading to a kernel panic.
> --
>
> commit f56b0fedf39a845476910805e073f6b2d3a4ad82
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments in non-JITed programs
>
> The interpreter does not understand the bpf register r11 (BPF_REG_PARAMS)
> used for stack argument addressing. So reject interpreter usage if stack
> arguments are used either in the main program or any subprogram.
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index ae10b9ca018df..ec8523e6e4eb4 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>   		goto finalize;
>>   
>>   	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -	    bpf_prog_has_kfunc_call(fp))
>> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_depth)
>>   		jit_needed = true;
> When loading a standalone global function (env->subprog_cnt <= 1) with >5
> arguments, bpf_jit_subprogs() sets fp->aux->stack_arg_depth to 0 (the
> outgoing_stack_arg_depth). If JIT is requested, bpf_fixup_call_args() will
> exit early, bypassing the newly added loop that checks
> incoming_stack_arg_depth.
>
> Because fp->aux->stack_arg_depth has been cleared to 0, jit_needed evaluates
> to false here.

I think the below change should fix the problem.

-       if (env->subprog_cnt <= 1)
+       if (env->subprog_cnt <= 1) {
+               env->prog->aux->stack_arg_depth = env->subprog_info[0].outgoing_stack_arg_depth
+                       + env->subprog_info[0].incoming_stack_arg_depth;
                 return 0;
+       }

In the above scenaio, env->prog->aux->stack_arg_depth will not be 0, so jit_needed
evaluates to true.


>
> If JIT compilation subsequently fails (e.g., due to memory limits or
> unsupported instructions), does the kernel silently fall back to the
> interpreter instead of rejecting the program?
>
> If executed, the interpreter encounters instructions utilizing BPF_REG_PARAMS
> (r11, mapped to regs[11]), which is initialized to 0 in the interpreter's
> stack frame. Could dereferencing this register to read stack arguments
> result in a NULL pointer dereference and cause a kernel panic?
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index c4e0224ad2f2e..3c9a82823913e 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1411,6 +1411,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>   		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>>   		return -EINVAL;
>>   	}
>> +	for (i = 0; i < env->subprog_cnt; i++) {
>> +		if (env->subprog_info[i].incoming_stack_arg_depth) {
> When verifying the main BPF program (i = 0), if the provided BTF signature
> has >5 arguments, the verifier sets
> env->subprog_info[0].incoming_stack_arg_depth > 0.

We can ignore i = 0. The first subprog is the main prog, we can skip it.

>
> Although the verifier subsequently realizes this signature doesn't match the
> expected single ctx argument and marks the BTF info as unreliable, it never
> clears the incoming_stack_arg_depth.
>
> Because this loop starts at i = 0 and unconditionally checks
> incoming_stack_arg_depth, will it reject the entire program if JIT is
> disabled (e.g., via sysctl net.core.bpf_jit_enable=0), even though main
> programs do not actually use stack arguments?
>
> Does this break backwards compatibility for existing valid BPF programs with
> 6+ argument BTF signatures that used to load successfully?
>
>> +			verbose(env, "stack args are not supported in non-JITed programs\n");
>> +			return -EINVAL;
>> +		}
>> +	}

