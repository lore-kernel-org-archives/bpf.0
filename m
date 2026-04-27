Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE33AEF57
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280807; cv=none; b=ZULchJ4InRqWGx/XRanhDljrDREjkKKmcXozfbzWfuxfBc/lsQqI8aXQqQwf0bBOWkVJGIh/1rYByE2gblCvqvkLuj02tybRrQU4NpyKgRcP6zkFk6U+0YQOfbM4O5DjfzqnOjoDO2B2Ol9hUwG9vW8WPD7fiJ603/IT5L1X5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280807; c=relaxed/simple;
	bh=zvcPfm2U5dDzRnIHOblrdcLwNw/6VEpYtyP2jwwC0Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f58h9IKDgLIqyB4zaGvGgwupNc0QZ6098tYpH+zCs7rGKz3fTie0Z2eKz6OnD1Aan9c/RQWSiZhYvrcHcZSK0KAncanU1uRp4DHkeGJzr3eOXklQciKCib6pG2cdsAwrapIg4LAmWczZwUscAISjjEaP5/eju+mzpNNttwhTaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc/Ot3Vd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc/Ot3Vd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF2DC19425;
	Mon, 27 Apr 2026 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777280806;
	bh=zvcPfm2U5dDzRnIHOblrdcLwNw/6VEpYtyP2jwwC0Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dc/Ot3VdeCpPSVyWevFtfazB0U7MO4dpE/C/k7jizkCSc3cuGxBSWJP4J9AOBASu+
	 DosLhF7CSFm4Gjt2Jwl8NoYxhf9BxulrR7iP0hs9o7SHpsC8CJVkG/L0jAUtBNgRLl
	 2RVOPfG6eS/iTjj8ARjvD8+LzxR3oh5+l6++FZ1yoMa1NOMhQIoWugFTpkxEVE27TP
	 ohvp1Fs6mdX23kMk7ueSA0zxTzrkgQ5/4DBx7rg1O5Sa8EUO6NceoTRlWUZXXmKfpJ
	 CRU2Hg6ITxahJcFtLY1PQoJw4QT0vpTK9vcgo5Nfk9WIyinOmkSRN+ditT6zefib10
	 ouUPdLefx04oQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bot+bpf-ci@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev, Puranjay Mohan
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 17/18] bpf, arm64: Add JIT support for stack
 arguments
In-Reply-To: <8f7648b35db9645d6616e4af8c9c734c419439c1b784c04a8d649c902e77dcd5@mail.kernel.org>
References: <20260424171724.2058333-1-yonghong.song@linux.dev>
 <8f7648b35db9645d6616e4af8c9c734c419439c1b784c04a8d649c902e77dcd5@mail.kernel.org>
Date: Mon, 27 Apr 2026 10:06:32 +0100
Message-ID: <m21pg0zs9z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>
> [ ... ]
>
>> @@ -1671,7 +1727,7 @@
>>  	}
>>  	if (src == fp) {
>>  		src_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
>> -		off_adj = off + ctx->stack_size;
>> +		off_adj = off + ctx->stack_size + ctx->stack_arg_size;
>>  	} else {
>>  		src_adj = src;
>>  		off_adj = off;
>
> When priv_sp_used is true, does this offset calculation produce correct
> addresses for BPF fp-relative accesses?
>
> Looking at build_prologue:
>
> arch/arm64/net/bpf_jit_comp.c:build_prologue() {
>     ...
>     emit(A64_MOV(1, fp, priv_sp), ctx);
>     emit(A64_ADD_I(1, fp, fp, ctx->stack_size), ctx);  /* line 612 */
>
>     if (ctx->stack_size && !ctx->priv_sp_used)
>         emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);  /* line 620 */
>
>     if (ctx->stack_arg_size)
>         emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);  /* line 623 */
>     ...
> }
>
> When priv_sp_used is true:
> - fp = priv_sp + stack_size (line 612)
> - main SP is not decremented by stack_size (skipped at line 620)
> - main SP is decremented by stack_arg_size (line 623-624)
>
> So the BPF program data lives on the private stack, while outgoing stack
> args live on the real SP. These are separate memory regions.
>
> In build_insn, the computed address for fp-relative loads/stores becomes:
>     addr = priv_sp + off + stack_size + stack_arg_size
>
> But the intended BPF address is:
>     addr = fp + off = priv_sp + stack_size + off
>
> The computed address is stack_arg_size bytes too high, accessing memory
> above the intended location on the private stack.

> This would read/write into the private-stack guard region (16 bytes) or
> past it when stack_arg_size > 16. Can this occur?  The verifier only
> forbids tail_calls + stack_args (verifier.c:5657), not priv_stack +
> stack_args. A kprobe BPF program that uses BPF_REG_FP and calls a kfunc
> with 9+ arguments would trigger wrong memory accesses.

This analysis is correct, will fix in the next version.

> Note that x86's bpf_int_jit_compile prevents priv_stack allocation when
> stack_arg_depth != 0 (x86/bpf_jit_comp.c:3883). The arm64 version has no
> equivalent guard.
>
> The same issue affects the ST case:
>
>> @@ -1762,7 +1823,7 @@
>>  	}
>>  	if (dst == fp) {
>>  		dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
>> -		off_adj = off + ctx->stack_size;
>> +		off_adj = off + ctx->stack_size + ctx->stack_arg_size;
>>  	} else {
>>  		dst_adj = dst;
>>  		off_adj = off;
>
> and the STX case:
>
>> @@ -1824,7 +1890,7 @@
>>  	}
>>  	if (dst == fp) {
>>  		dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
>> -		off_adj = off + ctx->stack_size;
>> +		off_adj = off + ctx->stack_size + ctx->stack_arg_size;
>>  	} else {
>>  		dst_adj = dst;
>>  		off_adj = off;
>
> [ ... ]
>
>> @@ -2065,6 +2131,14 @@
>>  	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>>  	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
>>
>> +	if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_depth) {
>> +		u16 outgoing = prog->aux->stack_arg_depth - prog->aux->incoming_stack_arg_depth;
>> +		int nr_on_stack = outgoing / sizeof(u64) - NR_STACK_ARG_REGS;
>> +
>> +		if (nr_on_stack > 0)
>> +			ctx.stack_arg_size = round_up(nr_on_stack * sizeof(u64), 16);
>> +	}
>> +
> Alexei Starovoitov raised concerns about this logic during v1 review (Apr
> 21, 2026). He found the comparison between stack_arg_depth and
> incoming_stack_arg_depth confusing and suggested simplifying it:
>
> "I think stack_arg_depth should mean outgoing and
> incoming_stack_arg_depth should mean incoming only and it shouldn't be
> even used by JIT. That memory was allocated by caller, so to JIT this
> callee the conversion of r11+const is straightforward and no checks
> necessary. [...] I think it should really be one check based on
> stack_arg_depth."


But if you see where these feilds are defined:

+	u16 incoming_stack_arg_depth;
+	u16 stack_arg_depth; /* incoming + max outgoing */

So, if stack_arg_depth is not the outgoing stack depth, rather it is the
sum of both outgoing and incoming. We need to do stack_arg_depth - incoming_stack_arg_depth 
to find out the amount of space to reserve to passing stack arguments.

Only if stack_arg_depth meant outgoing stack arg depth only, then we
could simplify it.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
