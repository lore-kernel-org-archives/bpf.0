Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D73C3C0C;
	Sat, 12 Sep 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248618; cv=none; b=tCFWaEdCtV8jZaH1N4YiZ4Bd2dsypqpoWFzBlXVbF7yeNcB+x5FshC6AGz6CF8qZKhbShv8zPGaeMGK0a43elv+BwLx9Q6z3MHVNago/aA7dcLb3YtL0DepwdmA7ToKn0y6UsjhSjbffnJBUgE46DyfeqrnuIMU2JS1pp1M77SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248618; c=relaxed/simple;
	bh=Qnpy72KVgwG0R3XGEoqvK+FPvQohNeo5FejtAC1zp4c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Exj/pFe1HUzBMU6/otz39ZXC5YnBKAGbtGy8D0rNdfB2yqUfGrlA73BA0jS0E0C6lnSmJClz6iPg0fRs34AfomQda3z3hjzxLF9zCKacwKuM21+Ieap+amUzeW9MglwfhhoqKhnmO2CVtZsaMkBOV2j59SdgW6geLFpgECPsGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQQuAofG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQQuAofG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963051F000FF;
	Sat, 12 Sep 2026 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789248616;
	bh=R2TpiCmLhnVYOi4/KKeCzseOcBdpoomJehEiKb7Q1Tk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BQQuAofG+Q9xqSPbH04pypz7tjw84ppQPagkx11Y/DKrjgtYr6SySn5XEbqAN+xyE
	 jSuWr19RX6rsfiG8sNIWNDcH6kBN6SCUx1Jh90hMLmt3Jm8VXbE1iIYrUknQaY34Oh
	 JXjaYuVe4nj25AQLZ7/uK4hfoLpuY0Z5KWO1xax9E5HADV219Uk+DxCXJvkIJPj5ri
	 qBTl2LoEENITgMvQxQHwi2omj6bqx+YUrUt8IG193HPm4d8Zru17zSRQR9c+klKpKH
	 azwyEBu8p2OY96CphtdLX+zNYiJIEVn89czGhRUrxgSzrc3OzwkUiYZxilT93BsXwT
	 UDixTM2TnAC/w==
Content-Type: multipart/mixed; boundary="===============4214904970316862522=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9577bd41c257d6510512104a7043602ecacacf60bf50399013240d5abe65539a@mail.kernel.org>
In-Reply-To: <20260911213300.1305763-1-arighi@nvidia.com>
References: <20260911213300.1305763-1-arighi@nvidia.com>
Subject: Re: [PATCH] sched: Set need-resched flags before tracing
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,mingo@redhat.com,peterz@infradead.org,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com
Cc: rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,gmonaco@redhat.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 12 Sep 2026 21:30:15 +0000 (UTC)

--===============4214904970316862522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8b3d47a325cc..ff3ce1ccf92a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2105,8 +2105,11 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
>  static inline void set_tsk_need_resched(struct task_struct *tsk)
>  {
>  	if (tracepoint_enabled(sched_set_need_resched_tp) &&
> -	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
> +	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED)) {
> +		set_tsk_thread_flag(tsk, TIF_NEED_RESCHED);
>  		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
> +		return;
> +	}
>  	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>  }
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b998ef6b87af..e896d5d2c72f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1196,6 +1196,7 @@ static void __resched_curr(struct rq *rq, int tif)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct thread_info *cti = task_thread_info(curr);
> +	bool send_ipi;
>  	int cpu;
>
>  	lockdep_assert_rq_held(rq);

[ ... ]

> @@ -1212,15 +1213,17 @@ static void __resched_curr(struct rq *rq, int tif)
>
>  	cpu = cpu_of(rq);
>
> -	trace_sched_set_need_resched_tp(curr, cpu, tif);
>  	if (cpu == smp_processor_id()) {
>  		set_ti_thread_flag(cti, tif);
>  		if (tif == TIF_NEED_RESCHED)
>  			set_preempt_need_resched();
> +		trace_sched_set_need_resched_tp(curr, cpu, tif);
>  		return;
>  	}
>
> -	if (set_nr_and_not_polling(cti, tif)) {
> +	send_ipi = set_nr_and_not_polling(cti, tif);
> +	trace_sched_set_need_resched_tp(curr, cpu, tif);
> +	if (send_ipi) {

In the remote-CPU branch, does this ordering break the runtime
verification nrp monitor?

On TIF_POLLING_NRFLAG builds, set_nr_and_not_polling() is implemented
as:

  return !(fetch_or(&ti->flags, 1 << tif) & _TIF_POLLING_NRFLAG);

so the fetch_or commits the TIF_NEED_RESCHED store before the
tracepoint's probe-list walk begins. The remote CPU can react to the
flag without waiting for any IPI:

  CPU0 (holds rq1 lock)                        CPU1 (running target task)
  -----------------------------------          --------------------------
  send_ipi = set_nr_and_not_polling(cti, tif)
    -> target's TIF_NEED_RESCHED now set
                                               returns from any IRQ to a
                                               preemptible context:
                                               raw_irqentry_exit_cond_resched()
                                                 if (need_resched() && ...)
                                                     preempt_schedule_irq();
                                                       __schedule(SM_PREEMPT)
                                                         trace_sched_entry_tp(true)
  trace_sched_set_need_resched_tp(curr,...)    <- arrives too late

The nrp automaton rejects schedule_entry_preempt from state
any_thread_running (the steady state after every schedule_entry).
Row any_thread_running in kernel/trace/rv/monitors/nrp/nrp.h is

  { any_thread_running, rescheduling, any_thread_running, INVALID_STATE }

so schedule_entry_preempt transitions to INVALID_STATE, printing "rv:
monitor nrp does not allow event schedule_entry_preempt on state
any_thread_running" and resetting the monitor. With the panic reactor
selected it panics the box.

The changelog says "For a remote reschedule, retain the result of
set_nr_and_not_polling() so that tracing remains ahead of IPI delivery
while still observing the updated flag." Staying ahead of the IPI is
not sufficient for correctness, because the target CPU preempts on
need_resched() alone without any IPI. raw_irqentry_exit_cond_resched()
tests need_resched() on any interrupt return, exit_to_user_mode_loop()
tests TIF_NEED_RESCHED directly, and in the polling-idle case
set_nr_and_not_polling() returns false so no IPI is ever sent while the
idle loop polls tif_need_resched().

The local-CPU branch does not have this problem: __resched_curr() runs
under the rq raw_spinlock, so preemption is disabled and rq->curr
cannot schedule before the probe returns. Likewise set_tsk_need_resched()
is safe: all three callers act on a task that cannot run concurrently
(current with IRQs disabled, or rq->idle under the rq lock).

Could the remote path emit the tracepoint before the flag store for the
remote case only (the recursion this patch fixes goes through
set_tsk_need_resched() on the local CPU, not through the remote branch
of __resched_curr()), or document why an out-of-order sched_need_resched
event is acceptable to the RV monitors?

>  		if (tif == TIF_NEED_RESCHED)
>  			smp_send_reschedule(cpu);
>  	} else {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34717210328
--===============4214904970316862522==--
