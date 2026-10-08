Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1B2765E2
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476382; cv=none; b=SMAYSTCBhRfNwkXC46LitpDFq1lManldpEbeB+xNf8GRKqAYFYw88XTiRiOiL+YjeD4QGx1LaserbOqMJze+WHyE2oZEuuX3fFzAEoPiTJ0ybrtgmwQkIOZO9YUG/+hrHpSooUwpbQloxw2fL0gzqJQfqkOwHx3Ou+tVMnAMPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476382; c=relaxed/simple;
	bh=Vv6HjlkKaEcNeGM1J49gHvZyK7qtW1yuFOX7CcfX/ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnywgx3KK18gIsiwNbz9L6RDyMDIpauh/f6nDZTjzN5fO/imMH9jnkGg5DLBoctAVZnMNNfUZjQnXOQ9xWAN9ETyav6UnfwBewgep+dwiTFuh/RFVG8uizh7+ZbjkGy3G6nZG3Jx5EXV0qTSMZQybuNaS828EadbtpvIjSs8kLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2N3Sqx/; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2N3Sqx/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vv6HjlkKaEcNeGM1J49gHvZyK7qtW1yuFOX7CcfX/ig=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791476377; v=1; x=1792081177;
 b=c2N3Sqx/YNOCnK1nWcD58sk364gp0b7mM1nRTl6VjJQDR1yxP6M4dnz8l2eCHw8jXEWAPNU8
 198MJOHD8F8BeNSCYjsDI/X50yjOvT0gYDXUaEXI3tmp40/24mUw1h8YBZlGRrHNS3RJo7Nw5XW
 9GBQrzgfqydJ0delucka91+o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f9536f640e83e639;
	Thu, 08 Oct 2026 16:19:37 +0000
X-Mizu-Trace-ID: f9536f640e83e639
X-Migadu-Flow: FLOW_OUT
Message-ID: <673d4d17-72ed-4909-8858-d05c4e9c5e7d@linux.dev>
Date: Thu, 8 Oct 2026 18:19:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 12/23] bpf: Refuse a trampoline that calls a
 subprog that can unwind
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075101.3001371-1-yonghong.song@linux.dev>
 <sashiko-outbox-163811@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-163811@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/8/26 10:14 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] bpf: x86 exception unwinder passes wrong return address pointer causing stack corruption
> - [High] bpf: Missing trampoline restriction for bpf_throw() leads to NULL pointer deref
> --
>
> commit 554b5300d0510c78440f3ee71cad1d363c75cfaf
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Refuse a trampoline that calls a subprog that can unwind
>
> This patch refuses fexit, fmod_ret, and fsession trampoline attachments
> to subprograms marked with might_unwind, preventing bpf_unwind() from
> tripping over unexpected trampoline frames.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 668d811d4e4cb..3692d9b163d43 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -21600,6 +21600,22 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   				prog_extension ? "Extension" : "Tracing");
>>   			return -EINVAL;
>>   		}
>> +		/*
>> +		 * A trampoline that calls its target stays as a frame between a
>> +		 * subprog and its caller, and bpf_unwind() cannot walk past it:
>> +		 * the frames below would return after their calls rather than at
>> +		 * their landing pads. fentry leaves no frame, and the main
>> +		 * program's caller is below where the walk stops.
>> +		 */
>> +		if (aux->func && subprog && aux->func[subprog]->aux->might_unwind &&
>> +		    (prog->expected_attach_type == BPF_TRACE_FEXIT ||
>> +		     prog->expected_attach_type == BPF_MODIFY_RETURN ||
>> +		     prog->expected_attach_type == BPF_TRACE_FSESSION)) {
> [Severity: High]
> Does this logic also need to check for bpf_throw()?
>
> The patch correctly prevents attachments for bpf_unwind(), which is tracked
> by might_unwind. However, bpf_throw() seems to be missed. It uses an
> independent might_throw flag which does not appear to be propagated to
> bpf_prog_aux or checked here.

In the above, we have aux->func[subprog]->aux->might_unwind. If it is true,
that means bpf_throw() will be rejected. So I think we should be okay.

>
> If a subprogram calls bpf_throw() and has a tracing program attached
> (like fexit), bpf_stack_walker() encounters the trampoline frame. At that
> point, bpf_prog_ksym_find() will return NULL, and since ctx->cnt > 0, it aborts
> the walk before setting ctx->aux:
>
> kernel/bpf/helpers.c:bpf_stack_walker() {
>      ...
>      if (!prog)
>          return !ctx->cnt;
>      ...
> }
>
> Because the walk is aborted early, ctx.aux remains NULL, which leads to a
> kernel panic when dereferenced later in bpf_throw():
>
> kernel/bpf/helpers.c:bpf_throw() {
>      ...
>      ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust,
>                                ctx.bp, 0, 0);
>      ...
> }
>
>> +			bpf_log(log,
>> +				"Cannot attach fexit, fmod_ret or fsession to %s, which can unwind\n",
>> +				tname);
>> +			return -EINVAL;
>> +		}
>>   		conservative = aux->func_info_aux[subprog].unreliable;
>>   		if (prog_extension) {
> [Severity: Critical]
> I also have a question about the x86 exception unwinding implementation added
> earlier in this series. Can the x86 unwinder corrupt the stack by passing the
> wrong return address pointer?
>
> In arch_bpf_stack_walk_ra(), the unwinder passes the current frame's return
> address pointer to the callback:
>
> arch/x86/net/bpf_jit_comp.c:arch_bpf_stack_walk_ra() {
>      ...
>      ra = unwind_get_return_address_ptr(&state);
>      if (!ra)
>          break;
>      if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *)ra))
>      ...
> }
>
> However, bpf_unwind_rewrite() seems to expect the return address pointer
> of the previous frame, so it can make the previous frame return directly into
> the current frame's cleanup pad.
>
> By passing the current frame's return address instead, bpf_unwind_rewrite()
> overwrites the current frame's return address with its own pad or epilogue:
>
> kernel/bpf/helpers.c:bpf_unwind_rewrite() {
>      ...
>      rec = bpf_exc_pad_for_ip(prog, ip);
>      *ra = rec ? rec->pad : prog->aux->epilogue_ip;
>      ...
> }
>
> On x86, this causes the pad to execute after the current frame has already
> returned via leave and ret, corrupting the caller's stack frame. For the main
> program, its return address is overwritten with its own epilogue, leading to
> a double-epilogue execution.

The issue here seems more appropriate for commit
"bpf: Dispatch cleanup pads by rewriting return addresses". I didn't
find any issues. Selftest results match expectations (manually checked).


