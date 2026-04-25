Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CF3597B
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777094982; cv=none; b=tZauUWdANaSa6Ov8WnjDnNHJeSJkOnQMgfJckKyNu6wY8dQLt2Sbp8q9d6h1JAioR+UcDL++5tza6bZqC7kBKNcWjhYss3gZdVnbe/jCiE500G42Oh+EU+0wx6aQPnoevCUA5O4UuFt+fw0qGYCgj7CSE9+z5hDJpWg47mcL83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777094982; c=relaxed/simple;
	bh=EMSSPbRxEne86U8+c2oFGcV3MehDqTuipWDPetMzSeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeFWtIYTaAclPsu3N+YTPGKWWu9mneXZYtOurrzbtyI7iDC4EeRu6hKygMWRvWQirZumZF12B6TnrS6MCG8mCrAzEqwzkf1YLKbZbRI6T/NnQEEzRE869TTFkp6/Dg/MqDZ9TVAYJ9j2Ac5WL5jSOGZsYOM95otT8vxI34jJu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eu35H83v; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eu35H83v"
Message-ID: <b8c11b00-d057-42de-b0a1-98e0ae4f70e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777094978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTaQn8DD1Ak3nHNC/oDdDl+pkaRM3qHRASKwyLaj0Z0=;
	b=Eu35H83v+m+zCUMYdEa3XsRJ50d8mUK63KiigsVW58ZjMSaG17Iun0A904hJ8BnyptJBVQ
	TSYz5hxvflYSF5SI7yJETt2gtiQ4trnoScMOD0nW2dp9NX+I6JyGBKp+wxF/Nk8Gsn3jB3
	qGtjEYvQ4WVhBKP7A68LsZSkKn0ALv4=
Date: Fri, 24 Apr 2026 22:29:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 10/18] bpf,x86: Implement JIT support for stack
 arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 puranjay@kernel.org, eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171648.2043493-1-yonghong.song@linux.dev>
 <e1b7281b2a52b18ae2a9f7d41091994eec0bba81e96e64adbe4c072d915acfc2@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e1b7281b2a52b18ae2a9f7d41091994eec0bba81e96e64adbe4c072d915acfc2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 11:00 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index ea9e707e8abf..06f33fef1e8e 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   	int i, excnt = 0;
>>   	int ilen, proglen = 0;
>>   	u8 *ip, *prog = temp;
>> +	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth;
>> +	u16 outgoing_rsp;
>>   	u32 stack_depth;
>> +	int callee_saved_size;
>> +	s32 outgoing_arg_base;
>>   	int err;
>>
>>   	stack_depth = bpf_prog->aux->stack_depth;
>> +	stack_arg_depth = bpf_prog->aux->stack_arg_depth;
>> +	incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_depth;
>> +	outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Can this underflow? All three variables are u16, so the subtraction
> wraps around modulo 65536.
>
> Looking at btf_prepare_func_args() in kernel/bpf/btf.c, it sets
> 'sub->incoming_stack_arg_depth = (nargs - MAX_BPF_FUNC_REG_ARGS) *
> BPF_REG_SIZE' for any static subprog with more than 5 arguments. It does
> not initialize sub->stack_arg_depth.
>
> The 'stack_arg_depth' field is only written by check_func_call() in
> kernel/bpf/verifier.c and check_kfunc_call(), which update the *caller's*
> subprog entry when the caller makes a call with more than 5 arguments.
>
> Since env->subprog_info[] is zero-initialized (kvcalloc), leaf subprograms
> that receive stack arguments but never call other functions with stack
> arguments will have:
>    incoming_stack_arg_depth = (nargs - 5) * 8
>    stack_arg_depth = 0
>
> For example:
>    static int leaf(int a1, int a2, int a3, int a4, int a5, int a6, int a7)
>    {
>        return a1 + a7;  /* r11+16 load, then BPF_EXIT - no calls */
>    }
>
>    /* some other subprog does: ret = leaf(1,2,3,4,5,6,7); */
>
> For 'leaf', the verifier sets:
>    incoming_stack_arg_depth = (7 - 5) * 8 = 16
>    stack_arg_depth = 0    (never updated, no calls made)
>
> When do_jit() computes:
>    outgoing_stack_arg_depth = 0 - 16 = 0xFFF0 (u16 underflow)
>
> Then at the new code below:
>
>> +	/*
>> +	 * Allocate outgoing stack arg area for args 7+ only.
>> +	 * Arg 6 goes into r9 register, not on stack.
>> +	 */
>> +	outgoing_rsp = outgoing_stack_arg_depth > 8 ?  outgoing_stack_arg_depth - 8 : 0;
>                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +	emit_sub_rsp(&prog, outgoing_rsp);
> This emits 'sub rsp, 0xFFE8' (about 65 KB), which overflows the kernel
> stack (THREAD_SIZE is only 16 KB on x86_64). The epilogue then emits a
> matching 'add rsp, 0xFFE8', but the damage is already done at function
> entry.
>
> The commit message states "The verifier guarantees that neither
> tail_call_reachable nor priv_stack is set when stack args exist, so R9 is
> always available." It does not claim the verifier maintains
> 'stack_arg_depth >= incoming_stack_arg_depth', and that invariant is not
> maintained for leaf subprograms.
>
> The sanity check in bpf_fixup_call_args() at kernel/bpf/fixups.c does not
> catch this because the same underflow happens there:
>    u16 outgoing = subprog->stack_arg_depth - subprog->incoming_stack_arg_depth;
> but since leaf subprograms have max_out_stack_arg_depth == 0, the
> comparison 'outgoing > max_out_stack_arg_depth' is false (0xFFF0 wraps
> around in the comparison).
>
> Should the JIT compute outgoing_stack_arg_depth safely to prevent the
> underflow? For example:
>    outgoing_stack_arg_depth = stack_arg_depth > incoming_stack_arg_depth ?
>                               stack_arg_depth - incoming_stack_arg_depth : 0;
>
> Or should the verifier ensure the invariant 'stack_arg_depth >=
> incoming_stack_arg_depth' after verification completes?

You are right! I missed this case where the caller signature has more
than 5 arguments and the caller itself does not have any callee's.
This caused the problem as you mentioned above. I will fix the issue
and added a selftest for this in the next revision.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

