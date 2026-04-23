Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD8289E13
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951762; cv=none; b=Oqviw3jyZibFxGb5aAo6gam+Xqd4xluVn8v3UaaC8HcDbGgXiaSgPoiSULNPFdA5/6w30nLMBg2F8e6yaZko0rMnVoeQE5tVa/yezVBA7l9lvCGxbVecVeFpaAPxgFxmbQ7BDKRfVgW4fgDlfIX3k50tjip+l12xXgKYPLCuHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951762; c=relaxed/simple;
	bh=aKq/2VbSsfjwmIIDO70se4BJgnn2llOweE5tBxFyqHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3ZiPAj7n0SxyoitIfFp14F3K5YC6g1S39Dlww8DXmaLFrm7MzWXj/kdBj6Wv0L6/bmGKrOIbSKcLURimHDDvuXA2tH6jGSW1j5uY2D1NzxEJEAVOmoTRQ+6+82YlsWWqihou9BoBFxM1w8AgqDSQE0ShLw1zvcCERbmnYIz4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM5XrT5d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM5XrT5d"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso53368895e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951759; x=1777556559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iF7wu4tXflWExxLZKZAXUk9Ifc2l95pRmMz3RqxlJ+0=;
        b=iM5XrT5dpSOsmMNEnwZYxGpHJlF+EAuGf2Hctg4k8qrRqP95r2ULI7ycVLuVP/Fuje
         Sbo0uAjKG7tTuqU5/sCpyoHICTavglkdxzxlEXg0FsmT/se3uHYQ3eW5aU1K3KKtvtUR
         3gDkthkWvIZV7b+HGr4FGoSy+gZ5YTR1eMZ7ccDPm/cmNLyVl2KeNSdxGf28cM6jc2lW
         gk3W6w2SilZqtJLO5p7kIAiVHTp2v1LwRdqf+/P4llR4JoNDWuwqQqz+Ly+vNUyShg/e
         jXH75bGHncA94H7/EfITRNnwInTVWIuhTYL26i/wmx7245Zg/nWkRugKjHObEXxcaslV
         /5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951759; x=1777556559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF7wu4tXflWExxLZKZAXUk9Ifc2l95pRmMz3RqxlJ+0=;
        b=e/aPKU6PG2Zz9CIZVZdSqv4u11k5XTM38aTaqIWrdmk+hgyB2u2T7/pck4bOIT5Hbp
         Za/tkx/7YSGBszw0fDwOzoDtuQoxmsdMvDTlfezCoxdLLCgabO5404CYf3qUzFTc3GVz
         EgDpfSmeQbfC7kHR0WbzrvEBp+I/8yfHzSy+iL4F2a1YC6YuxgcFlOIn5uaFXaEaGKGI
         FOuEqmI3tQP7Up0+EKl9nMG9JLbgujXKDIwAj3bbnoukzKWPKEeOFH6hZBovBcskDAL9
         4FBLsJhAHvHwJDIResES9/mnQi09FOM+cLCrFa0oiXPUOuZjUhjLis2FfsVAdu69iRCA
         Yekw==
X-Forwarded-Encrypted: i=1; AFNElJ+VQpfY2Iq0WkjqEWh7sBT1TT1vg5Z6xhCe4nPO4ZLWMoKVDKROvIvUxPpSMfrn3GfvE/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaGrM7qUMKLMlZesA2Os9TLwf+8tMFt4ryKfjB86MTPVzqP2o
	9W6QzMx3V+zw4XHNH36ZFgoJ2w9ihjCN7VfefrmNhbiuAApOvKUCx0t1
X-Gm-Gg: AeBDietRnaDtOSKZQungjTkSsK9qsxFDNteUm2MN0CqL5fNqOMw6GnMTrSSbpglFrXb
	DxSilgGNcBCY3cSnuY2pl9Z0rU5OmwRrQZ2M8iJtrbzr9uWIGAs0w6ubbWUH55gMK7Fr2KmgRnV
	TCfFEKgTeHQVLAUBRAv5Pf1629fxAmrTj/vG13tkHJ5XSnLiF49V2mD2Qxx1eDoi/kyZrV6VJww
	UKSQxwB8BzxPdBDoY0Hykni5WkohsUIsdlGu+3lOlXEd8J8RB7hWP7hk7pxTnIE40++aV4nVjoz
	CNA/l58i90pxYdu4b4Fy6NlUk0v2murOqaYQ/ZAtunzrZauYcBpfATl8RLMcUsS6wDgYiEy/zGS
	91onI4GN7OYz7tmF2bnmA6vtx/YRE4eHMJZyzkcmm1lh9XaY6qPhzBMDeh0te6FO9xUnLMYLMop
	b4Oi+rodCXXy9DBM2BeKvcCaP7tpOo1EyOGeUx/84sRcGXJqlfZKuYmXzLEV5oHDoiZH3eMRU=
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488fb796fa0mr372414065e9.25.1776951759249;
        Thu, 23 Apr 2026 06:42:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:2371:97f6:67a4:5909? ([2620:10d:c092:500::7:a503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm57285878f8f.30.2026.04.23.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:42:38 -0700 (PDT)
Message-ID: <a340164a-3e83-403b-aa7d-3bd65b861ee0@gmail.com>
Date: Thu, 23 Apr 2026 14:42:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 peterz@infradead.org, rostedt@goodmis.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
 <869b8823e672ed52c7cca6ed2d188130f66cb23cb0be1d6f821247b7f6d7da99@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <869b8823e672ed52c7cca6ed2d188130f66cb23cb0be1d6f821247b7f6d7da99@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/26 9:57 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 8ad72e17d8eb..e98ee7e1e66f 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
> 
> [ ... ]
> 
>> @@ -1410,12 +1410,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>>   	int size = 0;
>>   	int uargs = 0;
>>
>> -	/*
>> -	 * Syscall probe called with preemption enabled, but the ring
>> -	 * buffer and per-cpu data require preemption to be disabled.
>> -	 */
>>   	might_fault();
>> -	guard(preempt_notrace)();
>>
>>   	syscall_nr = trace_get_syscall_nr(current, regs);
>>   	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
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
>> +	/*
>> +	 * Per-cpu ring buffer and perf event list operations require
>> +	 * preemption to be disabled.
>> +	 */
>> +	guard(preempt_notrace)();
>> +
>> +	head = this_cpu_ptr(sys_data->enter_event->perf_events);
>> +	if (hlist_empty(head))
>> +		return;
>> +
> 
> Could this lead to unnecessary buffer allocation in a race scenario?
> 
> The patch moves BPF execution before preempt_disable to enable sleepable
> programs. The new code checks valid_prog_array outside preempt_disable
> and runs BPF if true. Then it enters preempt_disable and checks if the
> hlist is empty.
> 
> Between the BPF check (outside preempt_disable) and the hlist check
> (inside preempt_disable), another CPU could unregister the last perf
> event, making the hlist empty. In this window, the code would:
> 
> 1. Run BPF and pass the filter (before preempt_disable)
> 2. Check valid_prog_array and find it true (before preempt_disable)
> 3. Enter preempt_disable via guard(preempt_notrace)()
> 4. Check hlist_empty(head) and find it false (inside preempt_disable)
> 5. Allocate buffer via perf_trace_buf_alloc()
> 6. Submit to an empty or nearly-empty hlist
> 
> The old code checked both conditions together under preempt_disable
> before buffer allocation:
> 
>      head = this_cpu_ptr(sys_data->enter_event->perf_events);
>      valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
>      if (!valid_prog_array && hlist_empty(head))
>          return;  /* Early exit before buffer allocation */
> 
> If the perf event is unregistered between the new code's BPF execution
> and the hlist check, would the buffer allocation and data copying be
> wasted work?
> 

Given that the downside is wasted work of allocation and data copy,
it's not necessarily a problem, because it's not a hot path.

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24799223877

