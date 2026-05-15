Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CC3F99EB
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867751; cv=none; b=qXXlIdIQIWWpKXrNKtpcYl/d+Z2+qh5Hqetk/MFhkhy/7a9Mz/Nlmyvan3VmfYEJDbl3AAGU+HzyW1nfCPNJFC9kpTZUpKAF9qrTPWG6TfHz5c3tAnoH6aKwTZCJWt0LljdykesbNnS66f74NYXO9UnuU10K2VDNQ77B8JyWm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867751; c=relaxed/simple;
	bh=mEMKTbmT/lZPhB9ajUudtyUiBzSXwFr0mvTg1d/QJTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfmCs+IO14SHkMfVlbeLI3s1RNowcRNVualCq0CJyje/8bFTiFUwkXZswcf7mmlIUc992D10yhDeWYLbGJlDV7j3npbmZDz66bwr+HX2z3AwFQmUhi79nTGIpa/5ACliF0f/vbr5VU/t9OWiD8j9IK62HsVBQpL2wpmQ5pOs4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYXJzc8l; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYXJzc8l"
Message-ID: <aea80ccf-0f4f-44eb-bd7a-cb55e9f3f71b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778867737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy5pN3VENTzp0c+7QBcjZQ0FxPNZaCm0xVf+QxiavQQ=;
	b=HYXJzc8lT7NPlDx0xztaTnMAF9fYitvs2JwLRNAPiOjnZxDsYJD+C5x1DKYuZUpO8QH9Jl
	eCXrFeoyfbNouN7bJs9J3TK+pzoLCGIpjsKZc/7Tfa6AjcdfIL/4WhQQnkIZ28L0HDcl7E
	AC/+iiZUn57D5QiXFGAx/mgV/GjBNT8=
Date: Fri, 15 May 2026 10:55:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 17/25] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045122.2393118-1-yonghong.song@linux.dev>
 <20260515060214.CD991C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515060214.CD991C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 8:02 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] When a BPF program with an exception boundary calls a function with more than 5 arguments, unwinding an exception via bpf_throw() restores callee-saved registers from the wrong stack offset, corrupting kernel registers.
> --
>
> commit 86dff956386bae1d3e030c84363f5b56f2e023a7
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf,x86: Implement JIT support for stack arguments
>
> This commit implements x86_64 JIT support for BPF functions and kfuncs with
> more than 5 arguments. The extra arguments are passed on the stack, maintaining
> compatibility with the x86-64 calling convention. It introduces logic to handle
> pushing outgoing arguments to the stack area below the callee-saved registers.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index ea9e707e8abff..ceefefb4da217 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1700,6 +1755,42 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   			push_r12(&prog);
>>   		push_callee_regs(&prog, callee_regs_used);
>>   	}
>> +
>> +	/* Compute callee-saved register area size. */
>> +	callee_saved_size = 0;
> [ ... ]
>
>> +	/*
>> +	 * Allocate outgoing stack arg area for args 7+ only.
>> +	 * Arg 6 goes into r9 register, not on stack.
>> +	 */
>> +	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
>> +	emit_sub_rsp(&prog, outgoing_rsp);
> Does allocating the outgoing stack arguments area (outgoing_rsp) after pushing
> the callee-saved registers cause an issue when unwinding an exception via
> bpf_throw()?

Yes, this is indeed an issue, we need to restore 'rsp' between

         if (is_exception_cb) {
                 EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
                 EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */

and

                 /* The main frame must have exception_boundary as true, so we
                  * first restore those callee-saved regs from stack, before
                  * reusing the stack frame.
                  */
                 pop_callee_regs(&prog, all_callee_regs_used);
                 pop_r12(&prog);
                 /* Reset the stack frame. */
                 EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
	}

due to stack argument.

But I would like to know whether we want to support this
exception + stack_args combination or not.

>
> When bpf_throw() is called, the stack unwinder (arch_bpf_stack_walk()) captures
> the current stack pointer (sp) of the BPF frame, which points to the bottom of
> this outgoing_rsp area.
>
> bpf_throw() passes this shifted sp to the exception callback in the rsi
> register.
>
> The JIT-generated exception callback executes mov rsp, rsi followed by
> pop_callee_regs(). Because rsp is offset by outgoing_rsp bytes below the actual
> saved registers, the pop instructions will read from the outgoing arguments area
> instead of the saved registers.
>
> Could returning to the kernel with corrupted callee-saved registers cause
> unpredictable behavior or panics?
>

