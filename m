Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FC3242B2
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464534; cv=none; b=j6KzfABClLeyNT/1qWEFGaHsn4DN+L4ayVSP6lb5wmGpVL0i1zQhvrmu18ks5G9rwT0xoUh4qndiIZngs2T5qRTgT+gjkxbTKGGpT+2jdrBpyX9RJLMoFUOoC3vQ8EECSI3GbxHq/mS36oBX4k2hTqXT/jbXA5pynf1mcgO4DYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464534; c=relaxed/simple;
	bh=3ds8w1yZdDY6SnmL5w25+/boYExqVHlnd/fcLD3jbuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSthjQi8SFS6oVajC26DnxU3XIA/a7kczhubpE0zXA2t2YZUvW2yKCEb32iCYIOHTktQNSAbpAhJXQv2YKE4niOxvVNMsaDeM5C4a3rz9q4mSwk+8V//BQN9b/ilyPcXvkva/p2DlMDZtvmPty3zBs98IkMrJpSc96+5gpaNWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l1ZbtrjK; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l1ZbtrjK"
Message-ID: <93b6496e-8f52-4983-95e1-01db68609bc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785464519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dMstA3s1q3jz7gMCf0YyeW1NWmEDHVWbTYZcaJQdY=;
	b=l1ZbtrjKAzRkvs24cBTwpKonWTyd14o0F7EvbfY9RMtZNkyM6mNCdhteXhYFZn5SoA5r+N
	FHyWJR7YEFRe3GkWTgUCgWID775ogz3/PPAm7Uv9qslKbxqVY2lO/PBxHajRosk6aQVe+m
	lSgONwJ/8oDN3jEppAMDdVl1XfKJ3Lc=
Date: Fri, 31 Jul 2026 10:21:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <77edc25d-a521-4f65-84ed-dbb016593902@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <77edc25d-a521-4f65-84ed-dbb016593902@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/7/26 07:03, Ihor Solodrai wrote:
> On 7/27/26 7:28 AM, Leon Hwang wrote:
>> The BPF tracing multi link updates several direct-call sites through one
>> ftrace_ops. Its implementation is therefore gated by
>> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
>>
>> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
>> direct calls. This enables BPF tracing multi links on arm64. Also
>> generalize the unreachable-trampoline comment because the single-ops path
>> does not use ops->direct_call.
> 
> Hi Leon,
> 
> I don't think this change can land as is yet. The series doesn't even
> apply cleanly to bpf-next, but that's minor.
> 
> More importantly, it depends on Jose's series [1], which is not in the
> mainline yet. And there Mark has raised performance concerns [2] and
> the discussion still seems to be open.
> 
> [1] https://lore.kernel.org/all/20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev/
> [2] https://lore.kernel.org/all/amjnf5gz0xP5PTSB@J2N7QTR9R3/
> 
>>
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  arch/arm64/Kconfig         | 2 ++
>>  arch/arm64/kernel/ftrace.c | 3 +--
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0de419ed780f..c98dca76859b 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -188,6 +188,8 @@ config ARM64
>>  		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
>>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
>>  		if DYNAMIC_FTRACE_WITH_ARGS
>> +	select HAVE_SINGLE_FTRACE_DIRECT_OPS \
>> +		if DYNAMIC_FTRACE_WITH_DIRECT_CALLS\
> 
> The select is only conditional on DYNAMIC_FTRACE_WITH_DIRECT_CALLS, so
> it can be set along with HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS. And AFAIU
> this would make the fast path effectively dead: every BPF direct call
> routed through ftrace_caller now goes through the slow path.
> 
> As Mark noted in the other thread, on arm64 trampolines come from
> EXECMEM_BPF, so they always land out of BL range (chance of landing in
> range is 256M/terabytes).
> 
> I vibe-slop-coded a benchmark and ran it on a Neoverse V2 machine, and
> toggling your config change seems to be causing a 1.3x regression in
> the tracing overhead:
> 
>   do-nothing fentry (r0=0; exit) on __arm64_sys_getpid, 20 M calls, min-of-N, several boots. Results:
> 
>               untraced (base)   traced        overhead
>   Kernel A    ~128 ns/call      ~145.5 ns     ~17.6 ns   (fast path: br x17)
>   Kernel B    ~127 ns/call      ~150.4 ns     ~23.4 ns   (slow path: save regs + call_direct_funcs + hash)


Thanks for your testing.

> 
> This confirms Jiri's suspicion.

True.

> 
> However my understanding is the regression should mostly disappear in
> case some version of in-range trampoline allocation on arm64 lands.
> 
> So, I think the landing sequence should be something like follows:
>   * in-range BPF-trampoline allocation that Jose proposed [3]
>   * then HAVE_SINGLE_FTRACE_DIRECT_OPS selection
> 
> After all of that reaches mainline, then a selftest patch can go
> through the bpf-next.

Sounds reasonable.

This series is based on Jose's series and is intended for the arm64
tree, rather than bpf-next. Like Jose's series, this series aims to
enable BPF tracing_multi link on arm64. And yes, with in-range
BPF-trampoline allocation, the regression should mostly disappear.

I'll follow the sequence and repost the patches afterward.

Thanks,
Leon

> 
> [3] https://lore.kernel.org/all/amn7cBQ-cqs2XlKV@linux.dev/
> 
>>  	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
>>  		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
>>  		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index e1a3c0b3a051..56ba72a87dfa 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -301,8 +301,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
>>  
>>  	/*
>>  	 * If a custom trampoline is unreachable, rely on the ftrace_caller
>> -	 * trampoline which knows how to indirectly reach that trampoline
>> -	 * through ops->direct_call.
>> +	 * trampoline which knows how to indirectly reach that trampoline.
>>  	 */
>>  	if (*addr != FTRACE_ADDR && !reachable_by_bl(*addr, pc))
>>  		*addr = FTRACE_ADDR;
> 

