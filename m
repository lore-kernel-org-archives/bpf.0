Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517D2701B6;
	Tue,  9 Jun 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966800; cv=none; b=VVeXGgPEeCnvqVLxWxs+MeHGKe+qVj9bmMXaQYrhcsbkuCW8U6bxcS0oT6hKmIgX57VRJRFEjTi8yLcZJEXmSsLjiaBnh5iKl8HRoQxyBwpQYThf2hp56Jg1O54MH7OXTQt6DP326EHYF73V7ZJjbcXgeJT7EEmb5qLek5cMNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966800; c=relaxed/simple;
	bh=i7tjH2wS7DBHbp3/z3d9vfyJQQWNWqNvYaIvW3xLC9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8tcn6mhhS9hwqPUecD6COTzMdjLDIX8YVwCtDDIJjgjm7k/i35fZ+ZUaxvGVBofWorHv8g1s4GusDHmDzivGHMYRWxx7nFxTwTlIW2+fIG3sl9ZGn44cvb/P3HDyMnBzUj4B2O0yPxNJaBw2Cfawmmqneq//JcTrKoXe4w+d8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZ9Y42SgbzYQttc;
	Tue,  9 Jun 2026 08:59:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5D0234056B;
	Tue,  9 Jun 2026 08:59:52 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgBHvoOGZSdqimmDBA--.44671S2;
	Tue, 09 Jun 2026 08:59:52 +0800 (CST)
Message-ID: <18bec451-4f67-4f93-af6f-b47aef3e999c@huaweicloud.com>
Date: Tue, 9 Jun 2026 08:59:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
 <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
 <20260608093449.GH4149641@noisy.programming.kicks-ass.net>
 <20260608102326.GB3161497@noisy.programming.kicks-ass.net>
 <20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHvoOGZSdqimmDBA--.44671S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWktr1xJw1rtF1rury5XFb_yoW7uFWDpF
	W7K3WYkr4DJw17tr129r48JryYyrZ5JrW3Xrn5Gr1Ikrn0yF1xtr4ftw4j9a4UursxGa12
	vrWjq3sxCFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/8 21:08, Masami Hiramatsu wrote:
> On Mon, 8 Jun 2026 12:23:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Mon, Jun 08, 2026 at 11:34:49AM +0200, Peter Zijlstra wrote:
>>>
>>> +Live patching folks
>>>
>>> On Mon, Jun 08, 2026 at 09:52:37AM +0800, Tengda Wu wrote:
>>>
>>>> Background: We are verifying the support of live patches for functions that
>>>> have a kretprobe. The specific verification method is as follows:
>>>>
>>>> We construct a function foo() that calls bar():
>>>>
>>>> void bar(void)
>>>> {
>>>>     for (;;) {
>>>>         schedule();
>>>>     }
>>>> }
>>>>
>>>> void foo(void)
>>>> {
>>>>     bar();
>>>> }
>>>>
>>>> A kretprobe is attached to bar():
>>>>
>>>> echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
>>>> echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
>>>>
>>>> Then foo() is triggered. The expected behavior is that bar() will call
>>>> schedule() and yield the CPU.
>>>>
>>>> After that, the live patch is activated to attempt replacing the implementation
>>>> of foo(). The expectation is that this should succeed.
>>>
>>> This wholly depends on how foo() calls bar(), if it is a normal call,
>>> then no, it should not succeed, because foo() is still on the stack.
>>>
>>> If it is a tail-call, then yes, because foo() is no longer relevant.
>>>
>>>> However, in reality, because the task that called schedule() is still in the
>>>> RUNNING state,
>>>
>>> So calling schedule() without setting state is dodgy in the first place.
>>> Who is doing this? All wait primitives will set this to
>>> TASK_UNINTERRUPTIBLE or something along those lines.
>>>
>>>> the condition task_is_running(tsk) inside rethook_find_ret_addr()
>>>> is not satisfied, causing the function to return early. This, in turn,
>>>> prevents stack_trace_save_tsk_reliable() from determining the stack as
>>>> reliable, leading to a failure in activating the live patch.
>>>>
>>>> **Not sure if this is correct:**
>>>>
>>>> We believe that after a task voluntarily calls schedule(), when the stack
>>>> is expected to be reliable, it is a safe time to activate a live patch.
>>>
>>> Calling schedule() without setting state is a no-op and really shouldn't
>>> count much at all.
>>>
>>>> Additionally, a similar tsk->on_cpu check can be found elsewhere in the
>>>> kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
>>>> Therefore, we propose changing the task_is_running(tsk) condition to
>>>> tsk->on_cpu.
>>>
>>> Anyway, I'm wondering what the purpose of this check here is, there is
>>> no real comment, and commit 5120d167e21c ("rethook: Remove warning
>>> messages printed for finding return address of a frame.") is just pure
>>> voodoo as well.
>>
>> FWIW, you should have had this discussion then.
> 
> Indeed. The rethook is making a shadow stack by list, thus caller must
> guarantee the target process is blocked at least during this function.
> 
> The commit messages suggest that when BPF takes a backtrace, it also
> includes other running tasks. Is that safe?
> 
>>
>>> Also, note the comment that goes with the usage of
>>> task_on_another_cpu(); that thing is racy as all heck.
>>>
>>> So it really comes down to what the purpose of this check is.
> 
> This check has been introduced when it is copied from
> kretprobe_find_ret_addr(). It has the comment:
> 
>  * The @tsk must be 'current' or a task which is not running. @fp is a hint
> 
> IIRC, I added this check to explicitly verify this condition.
> 
>>>
>>> I suspect the issue at hand is that tsk->rethook elements, such as
>>> iterated by __rethook_find_ret_addr() are not safe to be accessed for a
>>> running task.
>>>
>>> Notably while rethook_recycle() has some RCU thing on, that objpool
>>> thing (and the recycle name itself) seems to strongly suggest iterating
>>> these things is not sound (you could start with things from this task,
>>> hit a recycled entry and continue iterating rethooks from another task).
>>>
>>> Also note that the current check is also racy, nothing really prevents a
>>> wakeup from happening right after you observe task_is_running() being
>>> false. The task can then get scheduled in on another CPU and tear down
>>> its rethooks concurrent with __rethook_find_ret_addr().
> 
> Yeah, but is there any way to ensure the task is blocked? Even if it is
> blocked, like TASK_UNINTERRUPTIBLE, unless holding the actual lock in
> the rethook, it may not be possible to ensure it?
> 
> Of course, we could give up on checking within this function and leave
> everything to the caller to guarantee - as kretprobe does.
> 
> BTW, the reason why we made it possible to pass tasks other than current
>  is that the stack unwinding code itself supported unwinding tasks other
> than current, so we had no choice but to create this interface.
> 
> However, it is a bad idea to check this in deep inside of unwinding.
> 
>>> Now, livepatch itself calls unwind from a proper context, but unwinds in
>>> general are not. This rethook stuff doesn't seem to be sound in general.
>>
>> I suspect just entirely removing the check is the sanest option at this
>> point. Callers that do it right (livepatch) are guaranteed consistent
>> data, and the rest gets whatever pieces.
> 
> Agreed.
> 
>>
>> Notably, unwind_next() holds rcu, so the iteration is protected from any
>> of those rethook_node things getting freed. Its just that the iteration
>> can go sideways and you might not get a sane answer.
>>
>> The very worst possible option is getting stuck in an infinite loop when
>> concurrent with agressive rethook re-use or something daft like that,
>> but that seems extremely unlikely.
> 
> 
> OK, thanks for your review!
> 
> Tengda, can you send a patch to just remove the check?
> 
> Thank you,
> 

Sure, the patch to remove the check has been sent.

-- Tengda

