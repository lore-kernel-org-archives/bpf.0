Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13E35B63D
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147653; cv=none; b=o+0v7tyyVCBIZunPBAdctk/abXJ9RydRCBMbhflR5ONjusJQ81sR54C0M8fbxF90mTq6qX1jjAvCLitVigBNOejOZ9TCLvt1I+pngYCNrER+fN6flbIGh4kG5N+Frmz1x2guF4puFDRaZQXz/EfOxHzPs+vnb0wRSXrY1/GoVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147653; c=relaxed/simple;
	bh=gLAr7Pe0VEX9SNWbehByhJulMPcZMibvGXTHc1gWcNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1Px1X7dUF5r8ORXriWWWCwdsTPjGOEP8dFJ7DfU9uNTMfE/p5ul4lArEtX2nRG77B4UH8xyziOSPEUsi4YfIcWyExtOaKObPDbIuOF1LOMNlqIRQnqAIj9ZfGW+l8YqcEP96hZ8nYzB/31kd0DuO3NlUhptxYzUBhro6jVaGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHdCcPn+; arc=none smtp.client-ip=91.218.175.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHdCcPn+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gLAr7Pe0VEX9SNWbehByhJulMPcZMibvGXTHc1gWcNU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788147630; v=1; x=1788752430;
 b=SHdCcPn+mlO+wggvcAyFuTNfmJWP7EIgEm73W1+iuYuGmtlTv1kIgn2s43tYIIeBXr/K3SyR
 w3Je6e80Q7BlPzvyRwXjKbdbWHuPfIcDw0tKSKj7ehAkyELQSt2SRmSnisnSrlydnXWcbWRVwxV
 /6JN0NrLkGwaamZSHj8u1Nhw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 30af03aeaf876221;
	Mon, 31 Aug 2026 03:40:20 +0000
X-Mizu-Trace-ID: 30af03aeaf876221
X-Migadu-Flow: FLOW_OUT
Message-ID: <a3314523-7ab6-4f1d-b411-be980b964079@linux.dev>
Date: Sun, 30 Aug 2026 20:40:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf: Is the nmi_uaccess_okay() check needed for
 bpf_send_signal_task()?
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Aditya Sharma <adi.sharma@zohomail.in>
Cc: bpf@vger.kernel.org, song@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, puranjay@kernel.org,
 jolsa@kernel.org
References: <20260819124324.43162-1-adi.sharma@zohomail.in>
 <CAEf4BzZY6uWdobXVyS1WrdtmRw_SLJsodm7d_c+Bhsw=chpJ+A@mail.gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZY6uWdobXVyS1WrdtmRw_SLJsodm7d_c+Bhsw=chpJ+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/21/26 11:21 AM, Andrii Nakryiko wrote:
> On Wed, Aug 19, 2026 at 5:44 AM Aditya Sharma <adi.sharma@zohomail.in> wrote:
>> Hi,
>>
>> I hit this from a bpf_timer callback that signals a userspace task: the
>> signal was not delivered some of the time. It turned out that
>> bpf_send_signal_task() was returning -EPERM depending on which task the
>> softirq happened to interrupt, and the source is this check in
>> bpf_send_signal_common():
>>
>> bpf_trace.c:872:        if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>> bpf_trace.c:873:                return -EPERM;
>> bpf_trace.c:874:        if (unlikely(!nmi_uaccess_okay()))
>> bpf_trace.c:875:                return -EPERM;
>>
>> Is the nmi_uaccess_okay() check necessary in the bpf_send_signal_task()
>> case?
>>
>> When commit 6280cf7 ("bpf: Implement bpf_send_signal_task() kfunc")
>> made the function take a task, the PF_KTHREAD and is_global_init()
>> started testing task, while nmi_uaccess_okay() kept testing current.
> Yeah, this is weird, at the very least it should be checking it for
> the provided task. But I also am not sure why we have to check this...
>
> Yonghong, do you remember why this was necessary? Can we just drop this?

I went through the history.
In 5.3: we have bpf_send_signal() helper:

BPF_CALL_1(bpf_send_signal, u32, sig)
{
	...
         /* Similar to bpf_probe_write_user, task needs to be
          * in a sound condition and kernel memory access be
          * permitted in order to send signal to the current
          * task.
          */
         if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
                 return -EPERM;
         if (unlikely(uaccess_kernel()))
                 return -EPERM;
         if (unlikely(!nmi_uaccess_okay()))
                 return -EPERM;
	...
}

nmi_uaccess_okay() is needed for *current* task.

In 5.6, bpf_send_signal_thread() is added, but still for the same task,
so we still have:

static int bpf_send_signal_common(u32 sig, enum pid_type type)
{
	...
         /* Similar to bpf_probe_write_user, task needs to be
          * in a sound condition and kernel memory access be
          * permitted in order to send signal to the current
          * task.
          */
         if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
                 return -EPERM;
         if (unlikely(uaccess_kernel()))
                 return -EPERM;
         if (unlikely(!nmi_uaccess_okay()))
                 return -EPERM;
	...
}

In the current master:

__bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type,
                                      u64 value)
{
         if (type != PIDTYPE_PID && type != PIDTYPE_TGID)
                 return -EINVAL;

         return bpf_send_signal_common(sig, type, task, value);
}

static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *task, u64 value)
{
	...
         /* Similar to bpf_probe_write_user, task needs to be
          * in a sound condition and kernel memory access be
          * permitted in order to send signal to the current
          * task.
          */
         if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
                 return -EPERM;
         if (unlikely(!nmi_uaccess_okay()))
                 return -EPERM;
         /* Task should not be pid=1 to avoid kernel panic. */
         if (unlikely(is_global_init(task)))
                 return -EPERM;
	...
}

We probably cannot remove
         if (unlikely(!nmi_uaccess_okay()))
                 return -EPERM;
unconditionally. The above 'if' statement should be guarded
with *current* task if it is different from parameter "task"
since nmi_uaccess_okay() is only for the *current* task.

>
>> As far as I can tell the path here does no user memory access, so
>> there is nothing for the check to guard.
>>
>> Also, it compiles to true outside x86 (include/asm-generic/tlb.h:26),
>> so if it were necessary here the kfunc would be broken on every other
>> architecture.
>>
>> Thus, whether a signal can be sent depends on the caller's context,
>> rather than the task it is to be sent to. And at the bpf_timer callback,
>> we never know deterministically whether the signal would go through,
>> or it would get rejected here.
>>
>> A quick reproducibility test by Claude Opus 5 (the issue I was facing
>> from the timer callback context was not reproducible deterministically):
>>
>> SEC("tp_btf/workqueue_execute_start")   /* current is a kworker   */
>> SEC("tp_btf/sys_enter")                 /* current is a user task */
>>
>> static __always_inline int probe(void)
>> {
>> struct task_struct *t;
>> int ret;
>>
>> t = bpf_task_from_pid(target_pid);
>> if (!t)
>>    return -ESRCH;
>> /* sig == 0: permission check only, nothing is delivered */
>> ret = bpf_send_signal_task(t, 0, PIDTYPE_TGID, 0);
>> bpf_task_release(t);
>> return ret;
>> }
>>
>> On bpf-next commit f79066c7 (selftests/bpf: Add tests for a store
>> on a fault prone qdisc pointer), x86_64 under qemu:
>>
>> bpf_send_signal_task() from kworker context : -1  (-EPERM)
>> bpf_send_signal_task() from syscall context :  0
>>
>> Same result on v6.18.29, x86_64, bare metal.
>>
>> I may be missing the reason for it to be there as well. If this check
>> is intentional, what is it protecting in the _task case?
>>
>> Thanks,
>> Aditya Sharma

