Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E634DCE6
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860855; cv=none; b=muVBa6NaJgvdDd+cW3D/54pNT20XK/77SUFipaFuIXmyWdPgcZzad5QQ2R81lugLBN2r+zLRyvl7S6t6zCUZDTDnVJh7gipXhUcapnEq/qQBxXwVNSGJDOjvkjE0VsHkfmKUG1JwgtjNebQuae8Y4qecW67msFCqizKoaoPp12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860855; c=relaxed/simple;
	bh=Ub+HHYwjO1+lxofLSRkh8STGn5WXTdBwdkuuUqwKeo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XumCCkO5/svm0dKVNS2uz1hc5bPMJC+Zirj/QNzvMMRcl5ZzwF5KEifi+ZPHRwat8TS/jw3v1AdCP36TBjuFueiBhuGahC+hZ9iW/rbBhaqhlBexS+sWJT3j1YZzmDJ5oDuKENRLsZ8bsu862aUt2sh0LHaTKFP7X8utMPx/HeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WLEMHrTh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WLEMHrTh"
Message-ID: <84f08f28-74bf-487c-8040-e8d2e8613d2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778860841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUCCgeTdkJgjWNvOF/GLKvQNQNHdViTt6U3DlbfbncQ=;
	b=WLEMHrThMN88npRCgMV6JDqNhbw7bmjzoz6HqrPgsKrr5dA9YAad9GZbIiZv9NTqjgsF+k
	XDAgpLxqllIrp3+ScakQX6Bx8Cy9wR+YIMtF7RvJZYpFJXdqhQ3fAeZRFhEaP+z4VqIbDj
	hTzoEO6VrWXx/GfrRa5PBvqEyfgliSo=
Date: Fri, 15 May 2026 09:00:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 11/25] bpf: Reject stack arguments in
 non-JITed programs
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045049.2390444-1-yonghong.song@linux.dev>
 <20260514235918.CAA8DC2BCB3@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260514235918.CAA8DC2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 1:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] The patch fails to prevent interpreter fallback if stack arguments are used only in nested subprograms (e.g., Main -> Subprog A -> Subprog B). This can lead to a kernel crash via an uninitialized R11 dereference.
> - [Low] Standalone global functions with stack arguments are rejected with `-ENOTSUPP` without a verifier log, instead of `-EINVAL` with a descriptive message.
> --
>
> commit 851a484e2b5b68983f11bc3764118f2bcba5acb0
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments in non-JITed programs
>
> This patch attempts to reject programs that use stack arguments when running in
> the interpreter, as the interpreter does not support the BPF_REG_PARAMS (r11)
> register. It does this by checking for stack arguments in
> __bpf_prog_select_runtime() and bpf_fixup_call_args().
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index ae10b9ca018df..958d86f0beac3 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>   		goto finalize;
>>   
>>   	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -	    bpf_prog_has_kfunc_call(fp))
>> +	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_arg_cnt))
>>   		jit_needed = true;
> Does this condition correctly catch stack arguments in nested subprograms?

I think the above condition '(env && env->subprog_info[0].stack_arg_cnt)' is
unnecessary. This check is for the *main* prog. main prog should not call kfunc,
otherwise jit_needed must be true. helper does not have stack arguments.

If bpf-to-bpf calls are used in this prog, then bpf_fixup_call_args() will
do some checking for all subprogs.

>
> env->subprog_info[0].stack_arg_cnt only tracks the main program's incoming
> and direct outgoing stack arguments. If the main program calls Subprog A with
> no stack arguments, and Subprog A calls Subprog B with more than 5 arguments,
> the main program's stack_arg_cnt remains 0.
>
> If bpf_prog_jit_compile() subsequently fails for the main program,
> jit_needed evaluates to false and it falls back to the interpreter.
>
>>   
>>   	if (!bpf_prog_select_interpreter(fp))
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index ba86039789fdf..19056016eed8b 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1407,6 +1407,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>   		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>>   		return -EINVAL;
>>   	}
> Is it possible for bpf_jit_subprogs() to succeed earlier in this function
> and return 0, bypassing these new checks entirely?
>
> If jit_requested is true, bpf_jit_subprogs() is called before this
> point:
>
> kernel/bpf/fixups.c:bpf_fixup_call_args() {
>      ...
> 	if (env->prog->jit_requested &&
> 	    !bpf_prog_is_offloaded(env->prog->aux)) {
> 		err = bpf_jit_subprogs(env);
> 		if (err == 0)
> 			return 0;
>      ...
> }
>
> If it succeeds, the function returns 0 early, skipping the new loop.

But if bpf_jit_subprogs() succeed (with more than one subprog), then we will have
            prog->bpf_func = func[0]->bpf_func;

In __bpf_prog_select_runtime(), we have
	   if (fp->bpf_func)
                 goto finalize;
So interpreter will be ignored since jit has done successfully.

>
> Combined with the issue in __bpf_prog_select_runtime() above, the interpreter
> could end up executing the main program and processing BPF_PSEUDO_CALL
> instructions by jumping to the un-JITted instructions of the subprograms.
>
> When Subprog A writes to outgoing stack slots via BPF_REG_PARAMS (r11), the
> interpreter will use an uninitialized r11, potentially corrupting memory.
>
>> +	for (i = 1; i < env->subprog_cnt; i++) {
> Should this loop start at i = 0 to properly handle standalone global
> functions?

We can do this. Previously I skip 'i = 0' due to

                 if (env->prog->aux->func_info_aux) {
                         ret = btf_prepare_func_args(env, 0);
                         if (ret || sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_PTR_TO_CTX) {
                                 env->prog->aux->func_info_aux[0].unreliable = true;

                 }

since the main prog may have a btf which have more than 5 arguments although
in reality it will have just one argument. If I have i = 0, this will reject
interpreter which is not correct.

Now we have the following change

                 if (env->prog->aux->func_info_aux) {
                         ret = btf_prepare_func_args(env, 0);
                         if (ret || sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_PTR_TO_CTX) {
                                 env->prog->aux->func_info_aux[0].unreliable = true;
                                 sub->arg_cnt = 1;
                                 sub->stack_arg_cnt = 0;
                         }
                 }

So we can safely start from i = 0. Note that i = 0 will definitely
succeed since we have sub->arg_cnt = 1 above. So change to i = 0
won't change anything but can avoid confusion.

>
> For standalone global functions that are verified independently,
> env->subprog_cnt is 1. Starting the loop at i = 1 skips the global
> function entirely.
>
> The program is still safely rejected later in __bpf_prog_select_runtime()
> because env->subprog_info[0].stack_arg_cnt > 0 correctly sets
> jit_needed = true, leading to an -ENOTSUPP return. However, starting at
> i = 0 would emit the expected verifier log and return -EINVAL instead of
> failing silently with -ENOTSUPP.
>
>> +		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
>> +			verbose(env, "stack args are not supported in non-JITed programs\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>>   	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {

