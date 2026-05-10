Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BA3B27F6
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433676; cv=none; b=NLTxfJHaHTL2+UlwaQ+yvrK2xcCgF9leHsCwE/h0oe9ozobjKEHQlIFIza12r2FT18xsO5tl5pDBFuieLCB7u2NjXQWRItOzys+AD0b2ilY1OeHaj2yl31XcEmMf6Vv2MLeIgQ4iH/IrYXkDGXAWdlGgKjYh9O8kZUeweoqxRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433676; c=relaxed/simple;
	bh=yuH6unK76TBxrxr0+M7raPR5j+G+FABW9PuoYb/Z62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaLnms6qv75KBltkNVOVb39B3ttiqlo6hN7p9qBUfvU+IXX8TEwK27U1+q/QSflecC2GKXgUvAGEnwziy/4zlDh6rohBBt71v16knSabXYYlqF/yjteAgS90OQB3dcvy19WBFGelVv1Q1ghsWiw75VBWkA+ZbFKmpUN2PQhVQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HlytHAdR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HlytHAdR"
Message-ID: <ace11898-eb29-4239-a095-94507dd60935@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWtdGKW+p+zyiZKJoqmO6ZWC84ikcl3/40lcLR82bH8=;
	b=HlytHAdRax2G0brUtlkceDnXI9FWFEbiQdm+uBDxW9gwFGprGLShEzbeVJb9b/P2iIPTh4
	GyNOnuGkvCoE50qDzIdSTgHsXdCrFLM5zHZONNxBKToTIlLJXDS6Tf9eX85mczhRDqYI82
	RkBPCbe5Z/q4ZctqVcA2ByxXqGUTVFQ=
Date: Sun, 10 May 2026 10:21:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 15/23] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 puranjay@kernel.org, eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260507213124.1132088-1-yonghong.song@linux.dev>
 <b1d493872b8f17c88b57d437bdeb6b228085a672d70892a853eef970f265b464@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b1d493872b8f17c88b57d437bdeb6b228085a672d70892a853eef970f265b464@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/7/26 12:26 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index ea9e707e8abf..67c2f4a3b9cc 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   	int i, excnt = 0;
>>   	int ilen, proglen = 0;
>>   	u8 *ip, *prog = temp;
>> +	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth; /* in bytes */
>> +	u16 outgoing_rsp;
>>   	u32 stack_depth;
>> +	int callee_saved_size;
>> +	s32 outgoing_arg_base;
>>   	int err;
>>
>>   	stack_depth = bpf_prog->aux->stack_depth;
>> +	stack_arg_depth = bpf_prog->aux->stack_arg_cnt * 8;
>> +	incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_cnt * 8;
>> +	outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;
> Can this u16 subtraction underflow for leaf subprograms? When a leaf

The maximum number of stack arguments in 7. The total depth is 56,
so underflow is not possible.

> function receives stack arguments but makes no calls with stack arguments,
> incoming_stack_arg_depth would be non-zero (e.g., 16 bytes for 2 args),
> but stack_arg_depth would be zero since the verifier never updates it
> for functions that don't make calls.
>
> The subtraction would wrap around modulo 65536:
>    outgoing_stack_arg_depth = 0 - 16 = 0xFFF0 (about 65520 bytes)

This is fixed in this patch set. sub->stack_arg_cnt is set in
bpf_prepare_func_args(), which captures the number of incoming arg's.

>
> Later in do_jit():
>
>> @@ -1700,6 +1757,42 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   		push_r12(&prog);
>>   	push_callee_regs(&prog, callee_regs_used);
>>   }
>> +
>> +	/* Compute callee-saved register area size. */
> [ ... ]
>
>> +	/*
>> +	 * Allocate outgoing stack arg area for args 7+ only.
>> +	 * Arg 6 goes into r9 register, not on stack.
>> +	 */
>> +	outgoing_rsp = outgoing_stack_arg_depth > 8 ? outgoing_stack_arg_depth - 8 : 0;
>> +	emit_sub_rsp(&prog, outgoing_rsp);
> This would compute outgoing_rsp = 0xFFF0 - 8 = 0xFFE8 (about 65512 bytes),
> and emit_sub_rsp() would generate:
>    sub rsp, 0xFFE8
>
> allocating a 65 KB stack frame that overflows the kernel stack
> (THREAD_SIZE is only 16 KB on x86_64).
>
> This issue was identified by bot+bpf-ci@kernel.org in v1 (Fri, 24 Apr
> 2026 18:00:42 +0000) at
> https://lore.kernel.org/bpf/e1b7281b2a52b18ae2a9f7d41091994eec0bba81e96e64adbe4c072d915acfc2@mail.kernel.org/
>
> The author acknowledged this bug and promised to fix it with a selftest
> in the next revision, but the current code still contains the vulnerable
> subtraction without underflow protection.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323

