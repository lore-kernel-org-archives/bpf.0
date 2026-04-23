Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C803081D6
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947969; cv=none; b=cm73wNSq5wq3byUpUSP9cDQFC4HGs/AasYyUIG9rQYayXM4467Lu9xIoMzv6zD7MUrrU9B2iROLhEAxASPo0axIhpluKQtsiNf3wMPj19EgO3U76wf6c67I2bJ9nA0ASuHH5PXxJVhYOBmFxXNWdjrgMDlCxTxKkAaf/OQJIr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947969; c=relaxed/simple;
	bh=KhQDeLKhqcH8e+wyYEzvvhIteXSGnaT0LW3qbZOi+3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXcga7SgfTmxhhdRrAmJ0oXfsnvcIybPF1kVEx6Wtacw42hK08RS2z/wz1jQEIxaNBPrka/Hb1Lv5Ly6bpMjzyUwdHyz1mURscz3GFsAInTH+JBwMol4fPt5jX0klbTHXUTQ+hFC5TGQ73yGZbUnFeshywpuF6pGgVQNaXIw+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5FYHyGU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5FYHyGU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso40309865e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776947966; x=1777552766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gHvRBSWu6tctkFEKfxFcr9Jxo6e220mndhLTZX9RCg=;
        b=G5FYHyGUXFeNA7vgcucRFwNh6dg8t8Z0cOKJdFVPRR/xD50waE2OMfXqa+d8TL9P5N
         /Rxqapo3Opp0a02iu4hjxEs5/+exHOQNHZBuZMg5sDAjBGA3pRoGV/7FzxfUbxGsU+2K
         tLC7gVtAuZRWbedsQeytOu2ysYKvAL3+mBf55wCT6I38627AWPHTBgxMMNgrb17QvKdp
         oG+eSFW+sjvP/xSgxRUoAmo+L1SGkZ5q/qnZkTjG7ETBHy0bdDBAEwlVnIH3SyRqz3S6
         OpSUaiv7uTyGmqycHYHYOg7HTUfaS+ImaCeLwjH5RFAIKUXBYblmLqNCwj0F15s7H/QY
         ERbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947966; x=1777552766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gHvRBSWu6tctkFEKfxFcr9Jxo6e220mndhLTZX9RCg=;
        b=VmlzexkzZKbKU3hCQK7Lbuom5HaAbj/wfuMLfcObiT9FWssOWDtNrDM2DGDnmgmssP
         X8dn0/Je2gcGWqhXFomvHsMwQkoubDw9daSh7b3byT+Tt2RRMKJoaZ2IeSe9ezjSPWll
         dIvpcMCZO2WsptNMSQ1yIj2MMT89xWnVkK+2Bmi0RglxlSXCB7BLiDobtmQ/mKFq14tt
         pxhJYAsMtTkAetqseDckDoJnZLmsewf/JEl37y1PP+0XXI0DW4RnJTQqHRxzu8nX2vNp
         R815HNDMh7X5YGXmMikSUEslDw4j8b4ZWxjtavak/Tv5E+o4U+b0wytQ1JDC4SijG0bc
         1pEg==
X-Gm-Message-State: AOJu0YzsbJmVbqmV5NikILwyoqFC8GZcAdLCF+9LEL42AKWDr//Ul7xj
	wCBXKouJ+gJsX5DVTX5jklGSVURL9+5XByzvPTmJ9U/zhEvkm1wmYE67
X-Gm-Gg: AeBDieuW5WydRe6XOBJoFPbLRNaac9IS42gmbkQmCU8ve2YdYPTCOGiysJ4DXH8ZN9L
	vLxW+AQMp2KEVTuB36sCIPQg7eG1ZBdcjDveTojRstF+/6bPpKRc5HYevwUvA8lSPl8P3zZ0vOS
	ebwLOjQN3Ozf7fddG660obdKJrcY1mYcdQUxx9n3gVrV+lERwXkh2yE0YplqaH8ZeNxVV4vq8TN
	dFoUJaVO12INbMUMtxuMcphT6nP7YHYqMvLxH3SBCGEMcYqGEghOYS0coOUDuQ9JWFqpBsYx4SI
	PcAT/gbyB4uRDjbbnPGtTa94F2W3m9d0L9hg4QfRNkdygGqXbk1WQH5Q0WpvQFbyDvoNJWSvHGo
	1jKcRfY+sdDTc0lilOGjJLfEJgamF9wvIPsEZLDgXvJKgRMZN2TkqLBrHwjVv4hqYZfZm59zUEC
	lYVQpEOlxK6GKQuOBExDRxZcO/tnLipZ11N9MW4mgS5M0tsgDrfFWsteEqx8DhnaBwOW6Bmsg=
X-Received: by 2002:a05:600c:a314:b0:48a:54a1:38bd with SMTP id 5b1f17b1804b1-48a54a13b5amr142010295e9.21.1776947965746;
        Thu, 23 Apr 2026 05:39:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:2371:97f6:67a4:5909? ([2620:10d:c092:500::7:a503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm23275698f8f.1.2026.04.23.05.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:39:25 -0700 (PDT)
Message-ID: <b06ad9d8-681e-41a4-bfd4-fc86f021add9@gmail.com>
Date: Thu, 23 Apr 2026 13:39:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>
 <20260423095650.GA3126523@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260423095650.GA3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/26 10:56 AM, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 10:14:17AM -0700, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Rework __bpf_trace_run() to support sleepable BPF programs by using
>> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
>>
>> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
>> protection with migrate_disable().
> 
> Why the migrate_disable() ? This is a new kind of BPF program; would it
> not be a good opportunity to not have this constraint?
> 

I rely on existing infrastructure: __bpf_prog_run() has
cant_migrate(), there is per-cpu variables access, bpf program
itself uses private stack (per-cpu allocated). It looks like making
sleepable tracepoints run without migrate_disable() would force us to
change quite a few things.
Then there are few problems in how per-cpu BPF maps would work; timer
helpers rely on per-cpu variables for deadlock  detection.

>> For non-sleepable programs, use the
>> regular rcu_read_lock_dont_migrate().
>>
>> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
>> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
>> migration protection and RCU locking are now handled per-program
>> inside __bpf_trace_run().
>>
>> Adapt bpf_prog_test_run_raw_tp() for sleepable programs: reject
>> BPF_F_TEST_RUN_ON_CPU since sleepable programs cannot run in hardirq
>> or preempt-disabled context, and call __bpf_prog_test_run_raw_tp()
>> directly instead of via smp_call_function_single(). Rework
>> __bpf_prog_test_run_raw_tp() to select RCU flavor per-program and
>> add per-program recursion context guard for private stack safety.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/trace/bpf_probe.h |  2 --
>>   kernel/trace/bpf_trace.c  | 20 ++++++++++++---
>>   net/bpf/test_run.c        | 65 ++++++++++++++++++++++++++++++++++++-----------
>>   3 files changed, 67 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
>> index 9391d54d3f12..d1de8f9aa07f 100644
>> --- a/include/trace/bpf_probe.h
>> +++ b/include/trace/bpf_probe.h
>> @@ -58,9 +58,7 @@ static notrace void							\
>>   __bpf_trace_##call(void *__data, proto)					\
>>   {									\
>>   	might_fault();							\
>> -	preempt_disable_notrace();					\
>>   	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
>> -	preempt_enable_notrace();					\
>>   }
>>   
>>   #undef DECLARE_EVENT_SYSCALL_CLASS
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index e916f0ccbed9..7276c72c1d31 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>>   static __always_inline
>>   void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>   {
>> +	struct srcu_ctr __percpu *scp = NULL;
>>   	struct bpf_prog *prog = link->link.prog;
>> +	bool sleepable = prog->sleepable;
>>   	struct bpf_run_ctx *old_run_ctx;
>>   	struct bpf_trace_run_ctx run_ctx;
>>   
>> -	rcu_read_lock_dont_migrate();
>> +	if (sleepable) {
>> +		scp = rcu_read_lock_tasks_trace();
>> +		migrate_disable();
>> +	} else {
>> +		rcu_read_lock_dont_migrate();
>> +	}
>> +
>>   	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>>   		bpf_prog_inc_misses_counter(prog);
>>   		goto out;
>> @@ -2085,12 +2093,18 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>   	run_ctx.bpf_cookie = link->cookie;
>>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>   
>> -	(void) bpf_prog_run(prog, args);
>> +	(void)bpf_prog_run(prog, args);
>>   
>>   	bpf_reset_run_ctx(old_run_ctx);
>>   out:
>>   	bpf_prog_put_recursion_context(prog);
>> -	rcu_read_unlock_migrate();
>> +
>> +	if (sleepable) {
>> +		migrate_enable();
>> +		rcu_read_unlock_tasks_trace(scp);
>> +	} else {
>> +		rcu_read_unlock_migrate();
>> +	}
>>   }
> 
> Since you have a clear distinction between __BPF_DECLARE_TRACE() and
> __BPF_DELARE_TRACE_SYSCALL(), would it not make more sense to have
> different versions of __bpf_trace_run() instead of having a runtime
> condition on ->sleepable ?

Syscall tracepoint can be sleepable or non-sleepable, so the runtime 
dispatch on prog->sleepable is needed anyway. I'm not sure how to
get access to bpf_prog in __BPF_DELARE_TRACE_SYSCALL(), that probably
won't look very clean.
