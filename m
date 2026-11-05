Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881573;
	b=kHofzyQHmPSbcGXVGAsHcZbJIGXPHIfQOePk898Y+n0M8KuuZd9HbVt24ofXYIV0VrW9
	 F/SKJ4gmY8lbu9Riv+AfUp0ulP0/ao5Yy0Nr3jfwWmu11bgIGI0sFqTOp/6Qm0RBqCF9N
	 7gvCaCoJPrq9KryT7KkRRO+pV9XO+7WPwyVgX9cE1/YRKh+g89uG2L2sXyFngS8+H7nsQ
	 jD91NtFOGd42I1whBuPKSttTfwl+U56K5lB2sL9mIFuD5iOLIt1jIAUCUKyBkpLmMX/fH
	 Me9lBs1xFHY0z+Qq5o/yvc28kJsdgFA8oX3bLDLF6LCr+lpwWoJEqy1uqED0zZ2mHLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881573;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=SOhMdo0S3VoEznsmoM+S40XpUm7IcJEEZYZHmhkEm3g=;
	b=Yp4PQWzKXc531xG5tB4d5MPqBI6X0I5E213uh+XDb7ATVWq76eN6JSejiGJG19C2H+T6
	 NMrnANri3cywILqhyWtauS+sCItelBGKqIJ2W+rc1brRvIr+Vptn/u6PK/9cBaY2Q83bR
	 /Sm8JxlyjSZfUX/TIkwqIIVdlq93bajxQTA8CYgE/1JwKN1mMe1eiMaHRwNseSFTriLH0
	 NkuYY9+Qnoo8MSz0m/mbMbhgAD/PrjAmT3sPPN/28hpoDZdIhpNnnD9KTX9L/Pxr+wgQ+
	 NMbc3CrfRvaO79d1H5sD7vc31ut1Nq03lB1ddwUTIapRxav1oRT3kxxXuyv0mXjEBmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GfFR9ZA3;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FB606A32C;
	Thu,  5 Nov 2026 12:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979FB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GfFR9ZA3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SOhMdo0S3VoEznsmoM+S40XpUm7IcJEEZYZHmhkEm3g=; b=GfFR9ZA3ZvPtPrpOktrGrpr2Bt
	Nagr/IUr79PbLpTffvL0MrTMEavQra/op0vcEdvs1RByq9F77mvbQeA7wmSkHnYu7LI8IhkCwNIR6
	+Rd0oPvbNImVxLFxX+v5G+TzzJuBKZNqYKCwjj0hhDLOrlswWRZKr+bHOaMvrUilqvTMVtgL+KdUD
	0hh30vc+UcZwPq1reYlXZ9uyYH1Z8qGZLeMaim33Jx2WpodO/P3oza8r/Cwko9ass/6xpo+QLgoMP
	M2+UUunbRr0diO2fG6jL0y1S28WUJ9Zvgtal7hXk9CmtyRgBRQCXg87gtXiAe7YZBe0CAJ0Gsyq5F
	iuAhPVjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOwXd-000000086ip-3VmT;
	Thu, 05 Nov 2026 12:26:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A547D3002F0; Thu, 05 Nov 2026 13:26:04 +0100 (CET)
Date: Thu, 5 Nov 2026 13:26:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Mike Bazov <mikeba@sentinelone.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let
 preemption cause false recursion drops in trampoline progs
Message-ID: <20261105122604.GB1779021@noisy.programming.kicks-ass.net>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
 <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
 <DML75890DWIX.EYB690LPBM1O@gmail.com>
 <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
 <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
 <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>

On Wed, Nov 04, 2026 at 05:12:15PM -0800, Martin Kelly wrote:
> We have noticed this issue independently in testing of our own security
> agent and have hit the same false recursion skips on 7.0 and 7.1
> kernels. More details and measurements below.
> 
> On Tue, Nov 3, 2026 at 6:24 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > Today a fentry prog never runs twice at the same time on one cpu.
> > Existing progs rely on that for their per-cpu maps.
> >
> >   task A, cpu 0                     task B, cpu 0
> >   buf = lookup(&percpu_scratch)
> >   fill buf
> >   <preempted>
> >                                     buf = lookup(&percpu_scratch)
> >                                     fill buf
> >                                     output(buf)
> >   output(buf)   <- data of B
> >
> > A plain (*cnt)++ in a per-cpu map loses updates the same way.
> > Today B is skipped and recursion_misses counts it.
> > With the per-task check A sends a corrupted event and nothing counts it.
> 
> Our programs avoid writing to per-CPU arrays because of corruption on
> PREEMPT_RT kernels, where trampolines have always been preemptible and
> thus can corrupt these structures. So for us, an opt-in flag that allows
> preemption (instead of skipping) would work well and not regress current
> programs that don't opt in. A verifier scan for per-CPU arrays could
> also work, but it would need to distinguish read-only vs write access to
> those maps.

This seems weird; your task-B bpf prog would never run due to the
prog_active thing.

> In a process-heavy workload on a 2-vCPU VM (~1M fork+exec of
> short-lived processes, ~606/second) we recorded the following number of
> recursion_misses on a 7.0.9 and a 7.1.5 kernel. Both kernels use lazy
> preemption with PREEMPT_RCU enabled. The miss rate has increased
> significantly, which we suspect is due to the HRTICK change.
> 
>                                   7.0.9 (HRTICK off) 7.1.5 (HRTICK on)
>                                   ================== =================
> security_file_permission fentry   1 in 61,580        1 in 1,568
> security_inode_getattr fentry     1 in 59,242        1 in 1,707
> do_file_open fexit                1 in 813,983       1 in 2,503
> sched_process_exec raw_tracepoint 1 in 1,000,816     1 in 500,408
> 
> The sched_process_exec raw_tp had few misses (1-2) but is included just
> to show that raw_tp can have misses as well since tracepoints became
> preemptible.

So HRTICK will still only set RESCHED_LAZY, which should not tickle
preempt_enable() into a reschedule. RESCHED_LAZY is acted upon in only 2
distinct spots:

 - return to userspace; it will reschedule.
 - the periodic tick; it will upgrade RESCHED_LAZY to RESCHED.

This would suggest you're seeing a lot of tick driven promotion. One
reason could be due to HRTICK setting LAZY and the normal tick happening
very shortly after it. 

You've not mentioned your CONFIG_HZ setting? Anyway, something daft like
the below would make promotion less aggressive (also, clearly I couldn't
come up with a decent name for the intermediate step :-).


> Possible approaches
> ===
> We don't have a preferred mechanism and are generally open to any
> approach that would help reduce these recursion_misses. Whatever the
> mechanism, it would be ideal to cover raw_tp programs too, since
> a46023d5616e made those preemptible.
> 
> We'd be happy to help test or develop patches if needed.

I would strongly prefer all BPF programs that attach to known
preemptible sites to use a per-task recursion counter or something of
that sort.

This per-cpu active count stuff is quite mad; and I think I've told
Alexei that plenty of times.


---
diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
index 528e6fc7efe9..feed08b51a62 100644
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -22,33 +22,35 @@
 #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
 
 #ifdef HAVE_TIF_NEED_RESCHED_LAZY
-# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
+# define TIF_NEED_RESCHED_MEH	5
+# define _TIF_NEED_RESCHED_MEH	BIT(TIF_NEED_RESCHED_MEH)
+# define TIF_NEED_RESCHED_LAZY	6	// Lazy rescheduling needed
 # define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
 #endif
 
 #ifdef HAVE_TIF_POLLING_NRFLAG
-# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
+# define TIF_POLLING_NRFLAG	7	// idle is polling for TIF_NEED_RESCHED
 # define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
 #endif
 
-#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
+#define TIF_USER_RETURN_NOTIFY	8	// notify kernel of userspace return
 #define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
 
-#define TIF_UPROBE		8	// breakpointed or singlestepping
+#define TIF_UPROBE		9	// breakpointed or singlestepping
 #define _TIF_UPROBE		BIT(TIF_UPROBE)
 
-#define TIF_PATCH_PENDING	9	// pending live patching update
+#define TIF_PATCH_PENDING	10	// pending live patching update
 #define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
 
 #ifdef HAVE_TIF_RESTORE_SIGMASK
-# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal()
+# define TIF_RESTORE_SIGMASK	11	// Restore signal mask in do_signal()
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
 
-#define TIF_RSEQ		11	// Run RSEQ fast path
+#define TIF_RSEQ		12	// Run RSEQ fast path
 #define _TIF_RSEQ		BIT(TIF_RSEQ)
 
-#define TIF_HRTIMER_REARM	12       // re-arm the timer
+#define TIF_HRTIMER_REARM	13       // re-arm the timer
 #define _TIF_HRTIMER_REARM	BIT(TIF_HRTIMER_REARM)
 
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..d5f9176e1a75 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2117,7 +2117,9 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+	atomic_long_andnot(_TIF_NEED_RESCHED |
+			   _TIF_NEED_RESCHED_MEH |
+			   _TIF_NEED_RESCHED_LAZY,
 			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..f8e225dc2504 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,8 +5854,17 @@ void sched_tick(void)
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 
-	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
-		resched_curr(rq);
+	/*
+	 * Two-stage promotion of LAZY to RESCHED, ensuring there is at least
+	 * one full tick of respite.
+	 */
+	if (dynamic_preempt_lazy()) {
+		if (tif_test_bit(TIF_NEED_RESCHED_MEH))
+			resched_curr(rq);
+
+		else if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
+			 set_thread_flag(TIF_NEED_RESCHED_MEH);
+	}
 
 	donor->sched_class->task_tick(rq, donor, 0);
 	if (sched_feat(LATENCY_WARN))
