Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608990;
	b=4CHo5eMyeeEt7KBkpUoq2yGuenfeGGyj/eHXd4uHvWy2y8rh9WHkmpysWrqZonl95m1N
	 5183078a+0YIPCni8LLFJ2O2NSUMo8Oc06MkPBK30PqRjgywHj9zBAarmT+mJKqpNpjpD
	 MmocGFBuy4J4W59C1Q3voe4CJpnQLzN/kVQNT52vKd8xxHp2Wkf/PLRqkgq+pDJIQXPXH
	 DA8rHhj4o6npzE1VuUDGj2aeJSJ4wKfkZjQWTKObDRW2DNAKsrHqp077L3b78e4YSIA2j
	 A0jJ0+Upx07aB2h6ZFFfVgeqUqg/7Be3xx/ZjEFnlhHFxVKMyrrAIq7JHvAkFGrpGzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608990;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8l4U3zQpJVwCIUSroFNMy3UbW7wsKixV4Iy1YuhTSWU=;
	b=aeoY2x9VYgYZkV2zM8mQmeoaeE8x4Dy+af9dYedCxc1DGk66hMIXfxL+YCb0LdsyyjQ2
	 52uk6Nz/FQxZVPZ1wo6f72z6RuYgJSWidq9DUE6cRKaLz7WpiTox7q8IqtuLWZLL+dLZS
	 9skqjacIX6m5kBJBIpYwniUHZ6iOF0SdOVC7vLyhQLnm/T0CYgK3BUZGRgSsjQLrK8alU
	 urS8erZzMcqt6xXmlvDrnF2xkJAypdg4GjkPik3fNv7yoXV++eL/P9XJtOCDdff0x/IGn
	 q14FZl1iHYhW6Ms8jPVe6VvjaWT0arN29SgdnzEI60no2aB7+ruL148jvlQQrLPuy8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o4KUS8tM;
	arc=none smtp.remote-ip=91.218.175.131
Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27D606A8AB
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D27D606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o4KUS8tM
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n8IEDs7xrnCjPmghkJPxe401M0h/LXYpjYH/vz+UzOY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794608978; v=1; x=1795213778;
 b=o4KUS8tMtk9ZwwtfYhEktsl05SPIWtBpT2be1y9/8DcWjy52uuJ5jZje86BcSGAwpqk7+zH7
 8BWDHmZ4sdjrXbEExFaK6Q6ILjU/NZkuxeVhRBqivfWSfr12M1/RGr7vBYLiHWqhpsjyerJB5lp
 sVxRZTc2tFtdcY8vfhsDrgHk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e59735e2ce6f26e;
	Fri, 13 Nov 2026 22:29:38 +0000
X-Mizu-Trace-ID: 1e59735e2ce6f26e
X-Migadu-Flow: FLOW_OUT
Message-ID: <b749b4c2-cd42-4a3d-b74d-af38648b9b1f@linux.dev>
Date: Fri, 13 Nov 2026 14:29:33 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Peter Zijlstra <peterz@infradead.org>,
 Martin Kelly <martin.kelly@crowdstrike.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mike Bazov <mikeba@sentinelone.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 Thomas Gleixner <tglx@kernel.org>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
 <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
 <DML75890DWIX.EYB690LPBM1O@gmail.com>
 <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
 <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
 <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
 <20261105122604.GB1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261105122604.GB1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/26 4:26 AM, Peter Zijlstra wrote:
> On Wed, Nov 04, 2026 at 05:12:15PM -0800, Martin Kelly wrote:
>> We have noticed this issue independently in testing of our own security
>> agent and have hit the same false recursion skips on 7.0 and 7.1
>> kernels. More details and measurements below.
>>
>> On Tue, Nov 3, 2026 at 6:24 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> Today a fentry prog never runs twice at the same time on one cpu.
>>> Existing progs rely on that for their per-cpu maps.
>>>
>>>   task A, cpu 0                     task B, cpu 0
>>>   buf = lookup(&percpu_scratch)
>>>   fill buf
>>>   <preempted>
>>>                                     buf = lookup(&percpu_scratch)
>>>                                     fill buf
>>>                                     output(buf)
>>>   output(buf)   <- data of B
>>>
>>> A plain (*cnt)++ in a per-cpu map loses updates the same way.
>>> Today B is skipped and recursion_misses counts it.
>>> With the per-task check A sends a corrupted event and nothing counts it.
>>
>> Our programs avoid writing to per-CPU arrays because of corruption on
>> PREEMPT_RT kernels, where trampolines have always been preemptible and
>> thus can corrupt these structures. So for us, an opt-in flag that allows
>> preemption (instead of skipping) would work well and not regress current
>> programs that don't opt in. A verifier scan for per-CPU arrays could
>> also work, but it would need to distinguish read-only vs write access to
>> those maps.
> 
> This seems weird; your task-B bpf prog would never run due to the
> prog_active thing.
> 
>> In a process-heavy workload on a 2-vCPU VM (~1M fork+exec of
>> short-lived processes, ~606/second) we recorded the following number of
>> recursion_misses on a 7.0.9 and a 7.1.5 kernel. Both kernels use lazy
>> preemption with PREEMPT_RCU enabled. The miss rate has increased
>> significantly, which we suspect is due to the HRTICK change.
>>
>>                                   7.0.9 (HRTICK off) 7.1.5 (HRTICK on)
>>                                   ================== =================
>> security_file_permission fentry   1 in 61,580        1 in 1,568
>> security_inode_getattr fentry     1 in 59,242        1 in 1,707
>> do_file_open fexit                1 in 813,983       1 in 2,503
>> sched_process_exec raw_tracepoint 1 in 1,000,816     1 in 500,408
>>
>> The sched_process_exec raw_tp had few misses (1-2) but is included just
>> to show that raw_tp can have misses as well since tracepoints became
>> preemptible.
> 
> So HRTICK will still only set RESCHED_LAZY, which should not tickle
> preempt_enable() into a reschedule. RESCHED_LAZY is acted upon in only 2
> distinct spots:
> 
>  - return to userspace; it will reschedule.
>  - the periodic tick; it will upgrade RESCHED_LAZY to RESCHED.
> 
> This would suggest you're seeing a lot of tick driven promotion. One
> reason could be due to HRTICK setting LAZY and the normal tick happening
> very shortly after it. 
> 
> You've not mentioned your CONFIG_HZ setting? Anyway, something daft like
> the below would make promotion less aggressive (also, clearly I couldn't
> come up with a decent name for the intermediate step :-).
> 
> 
>> Possible approaches
>> ===
>> We don't have a preferred mechanism and are generally open to any
>> approach that would help reduce these recursion_misses. Whatever the
>> mechanism, it would be ideal to cover raw_tp programs too, since
>> a46023d5616e made those preemptible.
>>
>> We'd be happy to help test or develop patches if needed.
> 
> I would strongly prefer all BPF programs that attach to known
> preemptible sites to use a per-task recursion counter or something of
> that sort.
> 
> This per-cpu active count stuff is quite mad; and I think I've told
> Alexei that plenty of times.
> 
> 
> ---
> diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
> index 528e6fc7efe9..feed08b51a62 100644
> --- a/include/asm-generic/thread_info_tif.h
> +++ b/include/asm-generic/thread_info_tif.h
> @@ -22,33 +22,35 @@
>  #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
>  
>  #ifdef HAVE_TIF_NEED_RESCHED_LAZY
> -# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
> +# define TIF_NEED_RESCHED_MEH	5
> +# define _TIF_NEED_RESCHED_MEH	BIT(TIF_NEED_RESCHED_MEH)
> +# define TIF_NEED_RESCHED_LAZY	6	// Lazy rescheduling needed
>  # define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
>  #endif
>  
>  #ifdef HAVE_TIF_POLLING_NRFLAG
> -# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
> +# define TIF_POLLING_NRFLAG	7	// idle is polling for TIF_NEED_RESCHED
>  # define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
>  #endif
>  
> -#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
> +#define TIF_USER_RETURN_NOTIFY	8	// notify kernel of userspace return
>  #define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
>  
> -#define TIF_UPROBE		8	// breakpointed or singlestepping
> +#define TIF_UPROBE		9	// breakpointed or singlestepping
>  #define _TIF_UPROBE		BIT(TIF_UPROBE)
>  
> -#define TIF_PATCH_PENDING	9	// pending live patching update
> +#define TIF_PATCH_PENDING	10	// pending live patching update
>  #define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
>  
>  #ifdef HAVE_TIF_RESTORE_SIGMASK
> -# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal()
> +# define TIF_RESTORE_SIGMASK	11	// Restore signal mask in do_signal()
>  # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
>  #endif
>  
> -#define TIF_RSEQ		11	// Run RSEQ fast path
> +#define TIF_RSEQ		12	// Run RSEQ fast path
>  #define _TIF_RSEQ		BIT(TIF_RSEQ)
>  
> -#define TIF_HRTIMER_REARM	12       // re-arm the timer
> +#define TIF_HRTIMER_REARM	13       // re-arm the timer
>  #define _TIF_HRTIMER_REARM	BIT(TIF_HRTIMER_REARM)
>  
>  #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1c93da75226e..d5f9176e1a75 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2117,7 +2117,9 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
>  
>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  {
> -	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
> +	atomic_long_andnot(_TIF_NEED_RESCHED |
> +			   _TIF_NEED_RESCHED_MEH |
> +			   _TIF_NEED_RESCHED_LAZY,
>  			   (atomic_long_t *)&task_thread_info(tsk)->flags);
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 04b62c16fa8c..f8e225dc2504 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5854,8 +5854,17 @@ void sched_tick(void)
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>  
> -	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> -		resched_curr(rq);
> +	/*
> +	 * Two-stage promotion of LAZY to RESCHED, ensuring there is at least
> +	 * one full tick of respite.
> +	 */
> +	if (dynamic_preempt_lazy()) {
> +		if (tif_test_bit(TIF_NEED_RESCHED_MEH))
> +			resched_curr(rq);
> +
> +		else if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +			 set_thread_flag(TIF_NEED_RESCHED_MEH);
> +	}
>  
>  	donor->sched_class->task_tick(rq, donor, 0);
>  	if (sched_feat(LATENCY_WARN))

Hi Peter,
We tested this patch on d48723711bae with CONFIG_HZ=1000, SCHED_HRTICK=y,
PREEMPT_{DYNAMIC,RCU}=y, and lazy preemption enabled, and saw roughly 60% fewer
recursion misses.

The test runs two tasks using the default sched policy pinned to the same CPU
for 30s. One calls getpgid() continuously. The other does the same but sleeps 1ms
between calls. Meanwhile a bpftrace fentry program on __x64_sys_getpgid does
some bounded work to widen the preemption window each invocation:

kfunc:vmlinux:__x64_sys_getpgid
{
    @entered = count();
    @entered_tid[tid] = count();

    $i = 0;
    $last = nsecs;
    while ($i < 10000) {
        $last = nsecs;
        $i++;
    }
    @last_ts[tid] = $last;
}
