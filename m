Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAF3F660D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978065; cv=none; b=Mz9+eRDmSE0T4m9i8cEW8SvGn5qRqcTN/4y2hmQwVTwhdLI+o5OD7iUgUBfsdYK95LTMMP8ZqsJtSx+MvAuEdjGcZzOkXEehBPxu64UtYffVz7WjzXTjF42vc5Aal5u27lpE799ojm/ltWkOM8MIBVULtLcZtzoO/2PnU8opE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978065; c=relaxed/simple;
	bh=wuc1HgE7O0stw6AwqmpKjnP0BflbZbozojiaIucOMBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0mw0bWMjNU1X/ekS4pDDeO6qQzjknTIddh5d8/DVvfIXqkJLO3nnqwnZ8X4NHlpAoHhPWIl1Hh+K9yxL40PepQ/2a5b2k6QHfqcBsBJSfbyQCZL7J522yXHOpqkxdG4G/pGnYtfsu4yYa8Y3Qg5UHA+39NrjHvoTnmY2znK0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpG0nUtF; arc=none smtp.client-ip=91.218.175.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpG0nUtF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wuc1HgE7O0stw6AwqmpKjnP0BflbZbozojiaIucOMBA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790978061; v=1; x=1791582861;
 b=cpG0nUtFvM609b+TmG/oDU/cbJQBrrtUq6/BKDcvUBKYieIBkRM/7loY1X3FjlEnX5gR7fGl
 KulG3/4iwZcBjw9rVzOwgzxEHobSKLQrAZFUSi3ixs0mz1uGwD971b1jLzxNTit2L7Xbs6tNbqE
 21Z08SR8fbV8vsWtQV0bULrY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c45516098bc13ea4;
	Fri, 02 Oct 2026 21:54:21 +0000
X-Mizu-Trace-ID: c45516098bc13ea4
X-Migadu-Flow: FLOW_OUT
Message-ID: <d02558bd-ffbb-4a8d-a6d0-0ff2e53be82b@linux.dev>
Date: Fri, 2 Oct 2026 22:54:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 12/22] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133108.1341965-1-yonghong.song@linux.dev>
 <20261001134906.B6F4B1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001134906.B6F4B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/1/26 6:49 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: verifier bypass via BPF exception unwind abort on traced frames
> --
>
> commit 8f24ec5b2338fd8477df1e09b72647e4de2ae3d4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Dispatch exception cleanup pads at run time
>
> This commit introduces runtime dispatch of exception cleanup pads using the
> ORC unwinder. It implements arch_bpf_stack_walk_ra() to traverse the stack
> and rewrite return addresses to point to their corresponding cleanup pads.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 6c7a0578760e7..544e8fd759ad4 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -4614,6 +4628,32 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>>   #endif
>>   }
>>   
>> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp, u64 *ra),
>> +			    void *cookie)
>> +{
>> +#if defined(CONFIG_UNWINDER_ORC)
>> +	struct unwind_state state;
>> +	unsigned long addr, *ra;
>> +
>> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
>> +	     unwind_next_frame(&state)) {
>> +		addr = unwind_get_return_address(&state);
>> +		ra = unwind_get_return_address_ptr(&state);
>> +		if (!addr || !ra)
>> +			break;
>> +		/*
>> +		 * A traced return: the slot holds a function graph or kretprobe
>> +		 * trampoline, not @addr, so it cannot be rewritten. Stopping
>> +		 * leaves BPF frames returning to unverified paths, so warn.
>> +		 */
>> +		if (WARN_ON_ONCE(READ_ONCE_NOCHECK(*ra) != addr))
>> +			break;
> [Severity: High]
> The comment above notes that this leaves BPF frames returning to unverified
> paths. Since the verifier assumes bpf_throw() does not return and prunes
> instructions following it, won't aborting the stack walk here allow the
> execution of those unverified instructions?
>
> Could a user with tracing permissions intentionally attach a tracer (like
> kretprobe or fgraph) to trigger this break, bypassing the verifier and
> forcing the execution of unverified BPF code?

Okay, this has been mentioned a few times. I think I should follow previous
suggestions e.g. mark bpf_unwind() as notrace etc. Will fix.

>
>> +		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *)ra))
>> +			break;
>> +	}
>> +#endif
>> +}

