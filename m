Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76493D4139
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164318; cv=none; b=NuCFptuMiBv/bTdkkMG5RnUeTj4zndmuP54BUJJjJNBQpXgaNGCVIAtiMegLeimEjL/P5hB9J8pASILPjAH0oQwrLAJe74b501h/CXKqyvfdcc9FY8XP1pTuBdoICEy/xSVxsVlyFb0f09cJNT+7icZV8shMgClE9jcb2m8crwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164318; c=relaxed/simple;
	bh=n1COtsSjO+SM9/RLhtWAkMzTGhig7Wi/CElhNhHJSnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw5aM7IWZm570WJ7JuUszrhIN5tVTm9HOjjdyrXbuJTBSgbfBIxTF9gnNirmnT3SQr8Kk68ajMjb3NsGLzDkOy3aVKe9mvWK7kg399Rr39ijX3YBw28gJio2DxYncVpqQcsemFGXmujZ2cpylYVP5Oh63XrCreYO+fdWMgvxvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3l6sevw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3l6sevw"
Message-ID: <b1c85fc5-e60a-46c4-bea9-4909dcf78579@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773164315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHSDBZIeB8Z87ZaNWxDTw989R5u76Q1IXGuUeg/7QPk=;
	b=G3l6sevw8fHlWAG59N0cqToF8gEllOQgDAUkhEiSP1Q0SjE/0KYf+POUF6bskjnnPkl6iS
	eZlPbaMbMqjjLDe2i3cMc00hUNnVgWyzE5gZum+Bkff7CHLlnKpOuGqH6VVFP78u9GfJRy
	aIiECFjOznkVG+GH3hOirB6iHRMKkJM=
Date: Tue, 10 Mar 2026 10:38:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add sleepable execution path for raw
 tracepoint programs
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com>
 <9a841572b63b4a741b20e14452a230a34203a2fb325275ad57fc5c0568a30c58@mail.kernel.org>
 <CAP01T77_J8tua8HziBWZRunY9=LQ-Ut1mxJnKAk3cMCc00+7Kw@mail.gmail.com>
 <CAP01T74FbF5FH70B2-6iB0BJEh8cLcM7Ok=vhUPJZe-SXeOYJg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T74FbF5FH70B2-6iB0BJEh8cLcM7Ok=vhUPJZe-SXeOYJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/5/26 8:52 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri, 6 Mar 2026 at 05:23, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> On Wed, 25 Feb 2026 at 18:14, <bot+bpf-ci@kernel.org> wrote:
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 9bc0dfd235af..2dd345e0fdb0 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>> [ ... ]
>>>
>>>> @@ -2085,12 +2085,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>>>        run_ctx.bpf_cookie = link->cookie;
>>>>        old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>>>
>>>> -     (void) bpf_prog_run(prog, args);
>>>> +     if (prog->sleepable) {
>>>> +             might_fault();
>>>> +             (void)bpf_prog_run(prog, args);
>>> At this commit, __BPF_DECLARE_TRACE_SYSCALL in include/trace/bpf_probe.h
>>> still wraps the BPF callback in preempt_disable_notrace() /
>>> preempt_enable_notrace():
>>>
>>> include/trace/bpf_probe.h:__BPF_DECLARE_TRACE_SYSCALL() {
>>>      might_fault();
>>>      preempt_disable_notrace();
>>>      bpf_trace_run##x(__data, ...);
>>>      preempt_enable_notrace();
>>> }
>>>
>>> Since __bpf_trace_run() is inlined into bpf_trace_run##x(), which is
>>> called between the preempt_disable_notrace() and
>>> preempt_enable_notrace(), the might_fault() here will execute with
>>> preempt_count > 0, producing a warning on CONFIG_DEBUG_ATOMIC_SLEEP
>>> kernels.
>>>
>>> More importantly, if the sleepable program calls a helper like
>>> bpf_copy_from_user(), the page fault handler will see in_atomic()
>>> and return -EFAULT for any non-resident page instead of faulting it
>>> in, defeating the purpose of sleepable programs.
>>>
>>> The v1 RFC series included a separate patch to remove
>>> preempt_disable_notrace() from __BPF_DECLARE_TRACE_SYSCALL.  Should
>>> that change be folded into this commit so the sleepable path works
>>> at each bisect point?
>> But sleepable programs are not yet permitted, so I think this is not
>> needed for bisection-friendliness.
>>
>>>> +     } else {
>>>> +             /*
>>>> +              * Non-sleepable programs may run in the faultable context,
>>>> +              * do cant_sleep() only if program is non-sleepable and context
>>>> +              * is non-faultable.
>>>> +              */
>>>> +             if (!link->link.sleepable)
>>>> +                     cant_sleep();
>>>> +             rcu_read_lock();
>>>> +             (void)bpf_prog_run(prog, args);
>>>> +             rcu_read_unlock();
>>>> +     }
>>> [ ... ]
>>>
>>> The commit message states:
>>>
>>>> For non-sleepable programs, behavior is unchanged: cant_sleep() check,
>>>> rcu_read_lock() protection.
>>> The parent commit does not have a cant_sleep() call in
>>> __bpf_trace_run() -- it uses rcu_read_lock_dont_migrate().  The
>>> conditional cant_sleep() is new in this commit.  Could this sentence
>>> be updated to reflect the actual change?
>> This seems worth adjusting.
> Actually, with the extra cant_sleep() check, we get this splat when
> running normal raw_tp tests.
> E.g.
>
> ...
> [  295.211949] BUG: assuming atomic context at kernel/trace/bpf_trace.c:2098
> [  295.212166] in_atomic(): 0, irqs_disabled(): 0, pid: 587, name: test_progs
> [  295.212316] 3 locks held by test_progs/587:
> ...
> [  295.213044] Call Trace:
> [  295.213046]  <TASK>
> [  295.213048]  dump_stack_lvl+0x54/0x70
> [  295.213055]  __cant_sleep+0xb7/0xd0
> [  295.213060]  bpf_trace_run1+0xce/0x340
> [  295.213072]  bpf_testmod_test_read+0x433/0x5e0 [bpf_testmod]
> [  295.213080]  ? srso_return_thunk+0x5/0x5f
> [  295.213093]  kernfs_fop_read_iter+0x166/0x220
> ...
>
> It means if the tracepoint is not marked faultable but is invoked in a
> non-atomic context, we will get a warning.
> It might be better to just drop this, since I don't think this adds much value.

Agree. This is due to the tracepoints defined in test_kmods where
tracepoints have default non-sleepable. So we have
   prog: non-sleepable
   test_kmods assumed context: non-sleepable
   actual context: sleepable

This caused the warning.

BTW, can we merge patches 2 and 3 together? I know the sleepable tp_btf
is not enabled yet in verifier. But just looking at patch 2 is a little
bit confusing as its caller still has preempt_{disable,enable}_notrace().

>
>
>>>
>> Other than that LGTM.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>
>>> [...]

