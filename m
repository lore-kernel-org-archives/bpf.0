Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1D27F4F5
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951493; cv=none; b=uplztXl/TLLzz9Mcq+8gc0xq+X4Z0xrKKrFoSY3bIe+PRBSU6menV2O2zAM2kQC6lU99g+uanM6NPj2Tq0FgSGJnvy4TCzCM2WSRjj+nIfDxfFXG8hC9SGI6MNGyootkoiiGn7zwx2CTvFbRAjsEp8QkFVpdzDye411Iy7RJlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951493; c=relaxed/simple;
	bh=sbNf/G/I5AJPBRK4ugaKll32yta07GLU+QAjmmMjSik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISLiVHxsDIzNHShOH6yYft13RTBy3mZHeqXhaXnkJIXUoOQk76NnbOHBV9ARy/tU3bVGtca/lMkf1nV9OEqkDVV0QwzTk+dMnWy8oLdrTbk888wOgMJAU5CGFl25Q1NRoHnFi4nQhDUjJwN+V/A94o5xeH80F1BV38HeINRofHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSkn0oV9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSkn0oV9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe608cb92so4627159f8f.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951491; x=1777556291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/6jS/VxySWNSRvgZrFCB7o6gonIpEVYD2xvNKd2N9U=;
        b=fSkn0oV9C/h0z2qhZUxzE9yp3HAmNOWb8LJ+4TlYx4ZnOV7tjsVanHgYuG0V9+PsGI
         yl/HuE7vkTOTJLCW779sBFxVU1/Nb63VVtJM0DbPsxtTqFDtxpyheeW4XBlfEbWmlUFq
         9bPUn/c7/0MwrE41rs/JC5HEvwVrb3jCbVwK9u0Umk/7t3Nx5iLssm3aNIXzd1if1Je0
         EkGGUghvJOrkXFkzPnH5Mnm5hyjekTy6v7QFUxaJOcuO9lIVCv3VS/Dz3swOffUULPg6
         lvxNbSdjGmvNh8pxR+QHxhfCadXnqRq8o+6GyQy9nBlFLvnDnZvNPd5EA99L+6hpkMD0
         4d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951491; x=1777556291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/6jS/VxySWNSRvgZrFCB7o6gonIpEVYD2xvNKd2N9U=;
        b=aW+r96/LBEUAhDVrq9jOswDfq8CZlGrmDJOrXOQipOMQbtcAsQ+e1pPfSfLqAK2LS6
         DJepwlFp2rO0fCmhCwp90vqE8gYL2Qhf6KHNjMznlaUn7GX+k8n8c/MDs9USdbJDPTw2
         RsKMXzT6cY503sjQHF8BRMjb+ZQxTogP1TnP7ioHahSRz3r5QofIrob2ad5MwjsmGT0j
         3OQ7RnC1yn0QIfDzT3D/L8ekqeH/Vn1YpKGWKo2vhTUl4JERrilWgDkLhBSMzwffxnmq
         9M24ghE8ar55QrDdeZc4ggGuicTQYRLOBHNhnyYjm5aOqI1wc1GeGsttRDNaYwPYhruO
         j+Dg==
X-Gm-Message-State: AOJu0YyqiIPgqLGBNE4bL6E+1bLX1F9WCxCG4XFwGmJjXezpCA5z8kAK
	JGvOr8YRUAqP7dEWu6xMT57jJkgoYzdqrIK8JZ7Eb23uTdOHFPJyDac4
X-Gm-Gg: AeBDievsSvB4plNoyx3V7Uybk8ruV3vLFUKQYKUtZ5As4MJuCKphiKUJX4pr4u+0uBL
	6t8R9lVEII7JaEELGTUcL+4FgeHoFZgWlek1krjPilxSPl/UuHu3vi+yEA8F/ruRruvU6iDWO8r
	gO3S88lgAAxF3vL3hQyGOI/5tyQsigzAVVQdrb0kE1sNB8+cO1ce4heTywVEQqb4ZzvElSf23EG
	KNG+uh1WTOHH0tM71Otlr1hBPiHzP6+VSFFLnxQKczmtut6YtBMqHKGt6VfxcAEWIyvKCLNxU0E
	AoVAlkUYxmw70sbl8lC2j5BspxAOXMeoA1zMW0ItFH/slWqoQa75IjBNmel3/PvbY9uyg1dCrHP
	WcpSicUlzKNn4+Hxm5nsNX5djiyzFF+yrmrlHyIkQtBg7eh2pha5DII00KVGt0cyYnaOixw55C4
	xjuqlH8npdzupgEmQWuUO11mPpgCj7Atu61pemt217CEhp7+5jyLAgBKb4bF3kMsGSTtZs40Ayz
	KD54cO2NA==
X-Received: by 2002:a05:6000:4283:b0:43f:e211:1090 with SMTP id ffacd0b85a97d-43fe3db3c62mr40696234f8f.1.1776951490472;
        Thu, 23 Apr 2026 06:38:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:2371:97f6:67a4:5909? ([2620:10d:c092:500::7:a503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm50911375f8f.31.2026.04.23.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:38:09 -0700 (PDT)
Message-ID: <e669be1f-6d0b-42e0-b6c3-1db12f98b7a9@gmail.com>
Date: Thu, 23 Apr 2026 14:38:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
 <20260422233556.1AE5CC19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260422233556.1AE5CC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/26 12:35 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Uninitialized kernel stack memory leaked to BPF programs via `param` structure.
> - [High] Moving BPF program execution before `syscall_get_data()` breaks `bpf_probe_read_user()` for non-sleepable programs by removing implicit page faulting.
> --
> 
> commit 6d42174eb2c9a4cc877bdf6b63e5b37b8017a109
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Add sleepable support for classic tracepoint programs
> 
> This commit adds support for sleepable BPF programs on syscall tracepoints
> by moving the BPF program execution out of the non-preemptible ring buffer
> allocation path. It introduces trace_call_bpf_faultable() and restructures
> perf_syscall_enter() and perf_syscall_exit().
> 
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 8ad72e17d8eb9..e98ee7e1e66f4 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -1371,33 +1371,33 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
>>   static int sys_perf_refcount_enter;
>>   static int sys_perf_refcount_exit;
>>   
>> -static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *regs,
>> +static int perf_call_bpf_enter(struct trace_event_call *call,
>>   			       struct syscall_metadata *sys_data,
>> -			       struct syscall_trace_enter *rec)
>> +			       int syscall_nr, unsigned long *args)
>>   {
>>   	struct syscall_tp_t {
>>   		struct trace_entry ent;
>>   		int syscall_nr;
>>   		unsigned long args[SYSCALL_DEFINE_MAXARGS];
>>   	} __aligned(8) param;
>> +	struct pt_regs regs = {};
> 
> Could param be zero-initialized here?
> 
> Because param is allocated on the kernel stack without zero-initialization,
> there is a 4-byte padding between syscall_nr and args. Additionally, only
> sys_data->nb_args elements of the args array are initialized, leaving the
> remaining elements uninitialized.
> 
> Since the BPF verifier allows tracing programs to read the full context size,
> this padding and uninitialized array elements can be read by BPF programs,
> leaking kernel stack memory. Zero-initializing param (e.g., param = {})
> would prevent this.
> 

This is pre-existing, I'm not sure what is our stance on this problem in 
general. If I had to guess, leaking kernel stack memory to BPF is not an 
issue, because we can do bpf_probe_read_kernel() if we need it anyway.

> [ ... ]
> 
>> @@ -1429,6 +1424,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>>   
>>   	syscall_get_arguments(current, regs, args);
>>   
>> +	/*
>> +	 * Run BPF program in faultable context before per-cpu buffer
>> +	 * allocation, allowing sleepable BPF programs to execute.
>> +	 */
>> +	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
>> +	if (valid_prog_array &&
>> +	    !perf_call_bpf_enter(sys_data->enter_event, sys_data,
>> +				 syscall_nr, args))
>> +		return;
>> +
> 
> Does moving BPF program execution here break bpf_probe_read_user() for
> existing non-sleepable BPF programs?
> 
> Previously, BPF programs ran after syscall_get_data() was called, which
> explicitly faulted in user memory for string arguments. Because the memory
> became resident, non-sleepable BPF programs could use bpf_probe_read_user()
> to reliably read those arguments without taking page faults.
> 
> Now that the BPF program runs before syscall_get_data(), if the user memory
> is paged out, bpf_probe_read_user() in non-sleepable programs might fail
> with -EFAULT.
> 

Not sure if previous behaviour was purposful. bpf_probe_read_user() is
best-effort no guarantee that the data is paged in. This patch set
unlocks sleepable tracepoints, which should be used in these scenarios 
when user data needs to be read reliably.

> [ ... ]
> 
>> -static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
>> -			      struct syscall_trace_exit *rec)
>> +static int perf_call_bpf_exit(struct trace_event_call *call,
>> +			      int syscall_nr, long ret_val)
>>   {
>>   	struct syscall_tp_t {
>>   		struct trace_entry ent;
>>   		int syscall_nr;
>>   		unsigned long ret;
>>   	} __aligned(8) param;
>> -
>> -	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
>> -	perf_fetch_caller_regs(regs);
>> -	*(struct pt_regs **)&param = regs;
>> -	param.syscall_nr = rec->nr;
>> -	param.ret = rec->ret;
>> -	return trace_call_bpf(call, &param);
>> +	struct pt_regs regs = {};
> 
> Similarly to perf_call_bpf_enter(), could param be zero-initialized here
> to avoid leaking kernel stack memory through the padding between syscall_nr
> and ret?
> 

