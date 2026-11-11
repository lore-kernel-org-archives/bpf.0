Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413457;
	b=SWKaw+yX1FONzoEY6/7qwuRivuDWfXHuos9lZtL1ohMlZ4DXGTnTsNQZfNoM7TkoHbTT
	 V6x3SwI25d2a7uL/ONve+H8KclbyqTclfke+T8tTP1HUUUky+u5rw6fVy37G6Mh8/7sdA
	 zaz7q7OyuxOhII3n3Rc6OqxwuRT3rmd3FXOwmB2rQA8CFWobaVDRFEEm8RbiOgFjvBv1O
	 JyKmBeObYQJBALsB9czwjlLFuCQLXZjDNWa+QIBaQdoO6HmOkLvZECfb6sft2JMgrh9EI
	 TBUoFyyCXDhwC/icOxo6oorAIrZZ95eb4OY7HXQqUtB0afsLxitqmdoV9bj79CbYH7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5EeGvoOJ93euoK3G9l0Q/S3rOXdRvA5oHTtG0d62buA=;
	b=jgh4NA4f8vlboPXyrmEMThNvl1ocfDEdo97tdwc4xeMUVvw8aUK52nwklMBlVL4UTg/9
	 1BWcXJVRPS/L5LehmRA7sNjsvhasZbklzTGlklfeiLeBF3/EvSMvuIat6mYS492OJ8mN8
	 ho9eUMyItazvgl6FZknygvTZBH+FGxt6J8gMVxUbVYLwhmNOqQYOFbKHgfrYt+iP5KVxH
	 dti7ExBqdRT1j112jcWSq8eG/D7lHXBXD2GCXZ7Ao5PlIdZNHAqQFLAI2DunwJQUf6By6
	 KJTuYogYI5wFtB1xnO/NeErkg6MpFNYmwEIAJbiZgzvyVg6HJ6ZYQiJZQ85mJ9Ibjig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpYtLbrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC7606A32E;
	Wed, 11 Nov 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpYtLbrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566E1F00A06;
	Wed, 11 Nov 2026 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413457;
	bh=5EeGvoOJ93euoK3G9l0Q/S3rOXdRvA5oHTtG0d62buA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WpYtLbrrCejPa5x1OItmaRa/NY7puMcmTtYl5P5HfZotQx89qt85vBVZsEpjKUGXY
	 ZRDBUiAfDZmglOyJsALB925e//RnU7ukAb7qyo92H75e1XXHGc4uXIwyunGtwhuLXa
	 btfBW7rel9qd4kUuYNDYOu8ztStAsG53tJivi6vYJja2hQz1ogJL8GBCq9vFQ9Sw5D
	 GQUYBu0lDqkHse/S4JsjosJs5NsadkkS0YDBM4nOVrL62E4QQgodHeo6x8fZeHEP+Z
	 OfyD/p45YnedT7f9bKoR0AcuXeXdij5VCCdB7IZMY6cSHP/DYs4x6fcRjeCyfj3BkU
	 S9jdsBiOH/2og==
Date: Wed, 11 Nov 2026 17:10:54 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Radu Toader <radu.m.toader@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, tglx@kernel.org,
	tglx@linutronix.de, tj@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, anna-maria@linutronix.de,
	bigeasy@linutronix.de, joshdon@google.com, haoluo@google.com,
	brho@google.com, boqun@kernel.org, joelagnelf@nvidia.com,
	enlin.mu@linux.dev, brads@mainlining.org, kmehltretter@gmail.com,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] softirq: Treat an interrupted idle task as idle in
 tick_irq_exit()
Message-ID: <avSTjihu0YXfFNUV@localhost.localdomain>
References: <20261111112944.3868822-1-radu.m.toader@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111112944.3868822-1-radu.m.toader@gmail.com>

Le Wed, Nov 11, 2026 at 11:29:44AM +0000, Radu Toader a écrit :
> tick_irq_exit() only runs tick_nohz_irq_exit() if sched_core_idle_cpu(),
> which is idle_cpu() unless core scheduling is built in. idle_cpu() is
> false when the run queue has tasks while the idle task runs.
> 
> That is the normal state of a CPU under sched_ext whose BPF scheduler
> holds back a runnable task of that CPU in one of its queues, e.g. a task
> of a cgroup at its CPU limit: the task stays queued on the CPU's run
> queue and counts in rq->nr_running, while the CPU sits in the idle loop.
> 
> tick_nohz_irq_exit() is what marks an idle CPU as idle again for the
> scheduler clock after an interrupt in the idle loop
> (TS_FLAG_IDLE_ACTIVE, sched_clock_idle_sleep_event()). Without it, the
> next exit from the idle loop doesn't resynchronize the CPU's sched_clock
> with sched_clock_idle_wakeup_event(). With an unstable sched_clock, e.g.
> under kvm-clock without a stable TSC, the clock of a CPU in tick-stopped
> idle is clamped to its last stamp plus a tick, so a task picked after a
> reschedule IPI (which doesn't go through irq_enter()) starts with a
> stale exec_start, and the next tick charges the whole idle stretch to
> it.
> 
> Measured with one thread spinning 10 ms in every 100 ms in a cgroup,
> kept off its CPU for a further 7 to 53 ms per period by a sched_ext
> scheduler: the cgroup's cpu.stat usage_usec over the thread's own
> CLOCK_MONOTONIC measurement of its busy time reached 2.00, twice the
> CPU time the thread could possibly have used, and is 0.96 with this
> patch. The same ratio with no BPF scheduler loaded is 1.005.
> 
> Commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
> fixed this same gate for the other case of "the idle task runs while
> nr_running > 0", forced idle under core scheduling, where the symptom
> was too little idle time in /proc/stat. sched_ext made that state
> reachable without CONFIG_SCHED_CORE, and there the symptom is idle time
> charged to a task as runtime.
> 
> Ask whether the idle task is running, which covers both cases. CPUs
> whose run queue is really empty are unaffected; a CPU interrupted
> between leaving the idle loop and switching to a task has need_resched()
> set or has already left the idle accounting, see tick_nohz_irq_exit().
> sched_core_idle_cpu() has no users left and goes.
> 
> The two gates test different predicates rather than one containing the
> other, and the difference is deliberate. idle_cpu() is idle_rq():
> rq->curr == rq->idle && !rq->nr_running && !rq->ttwu_pending.
> is_idle_task() tests PF_IDLE on current. Newly covered:
> 
>  - the two "the idle task runs while nr_running > 0" cases above;
> 
>  - a CPU idling with a wakeup queued by TTWU_QUEUE whose IPI has not
>    run yet;
> 
>  - injected idle. play_idle_precise() sets PF_IDLE on a SCHED_FIFO
>    kthread which then loops on do_idle(), so rq->curr is not rq->idle
>    there and the old gate was false off nohz_full CPUs. Interrupts
>    taken during injected idle now run tick_nohz_irq_exit() with
>    TS_FLAG_INIDLE set. That CPU is running an idle state and needs the
>    same latch for the same reason, so this is wanted rather than merely
>    harmless, but note it reaches the idle injection users in
>    drivers/powercap/idle_inject.c, intel_powerclamp and
>    cpuidle_cooling, and is not confined to sched_ext.
> 
> One state is no longer covered: PF_IDLE is set by cpu_startup_entry()
> and not by init_idle(), so a CPU on its idle task before that point
> satisfied idle_cpu() but does not satisfy is_idle_task(current). Nothing
> is lost, because TS_FLAG_INIDLE is only set inside do_idle(), so
> tick_nohz_irq_exit() had nothing to do there, and nohz_full CPUs are
> covered by tick_nohz_full_cpu(cpu) either way.
> 
> What keeps the new gate from giving a CPU idle accounting it should not
> have is that tick_nohz_irq_exit() tests TS_FLAG_INIDLE itself and only
> does the idle bookkeeping inside the idle loop.
> 
> Tooling: the bug was found and this patch and changelog were written by
> Claude Opus 5 (Claude Code)

About the changelog, I could recognize given the overzealous details and
labyrinthic reasoning :-)

Still it looks correct.

> in a session measuring cgroup CPU limit
> enforcement under sched_ext. All of the patch and all of the changelog
> are tool-generated. The measurements above were taken on hosts that no
> longer exist and were not repeated for this posting. By the threat model
> in Documentation/process/threat-model.rst this is a regular bug and not
> a vulnerability: it misreports CPU time under a legitimate configuration
> and crosses no privilege or isolation boundary.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Link: https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/
> Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
> ---
> Changes in v3:
>  - No code change; the diff is identical to v2.
>  - Moved the posting notes out of the changelog and below this line, as
>    asked in review of v2. The Link: tag still points at the reproducer.
>  - The Tooling: line stays in the changelog above the --- line, because
>    Documentation/process/generated-content.rst asks for tool use to be
>    noted there.
> 
> The reproducer is a sched_ext scheduler that parks a tagged task on an
> otherwise idle CPU for a set time. It was patch 1 of v1 and is dropped
> from this posting at the maintainer's request; it remains in the list
> archive, see the Link: tag above.
> 
> Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
> NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
> SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.
> 
> v1: https://lore.kernel.org/lkml/20261106094343.174905-1-radu.m.toader@gmail.com/
> v2 and its CI run: https://patchwork.kernel.org/series/1206104/
> 
>  include/linux/sched.h   |  2 --
>  kernel/sched/syscalls.c | 12 ------------
>  kernel/softirq.c        | 12 ++++++++++--
>  3 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1c93da75226e..0e704ea9416f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2326,11 +2326,9 @@ extern void sched_core_free(struct task_struct *tsk);
>  extern void sched_core_fork(struct task_struct *p);
>  extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>  				unsigned long uaddr);
> -extern int sched_core_idle_cpu(int cpu);
>  #else
>  static inline void sched_core_free(struct task_struct *tsk) { }
>  static inline void sched_core_fork(struct task_struct *p) { }
> -static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
>  #endif
>  
>  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 45a127deeadd..22e316680a86 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -194,18 +194,6 @@ struct task_struct *idle_task(int cpu)
>  	return cpu_rq(cpu)->idle;
>  }
>  
> -#ifdef CONFIG_SCHED_CORE
> -int sched_core_idle_cpu(int cpu)
> -{
> -	struct rq *rq = cpu_rq(cpu);
> -
> -	if (sched_core_enabled(rq) && rq->curr == rq->idle)
> -		return 1;
> -
> -	return idle_cpu(cpu);
> -}
> -#endif /* CONFIG_SCHED_CORE */
> -
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 7fc2200392cd..e7d649c29c0c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -738,8 +738,16 @@ static inline void tick_irq_exit(void)
>  #ifdef CONFIG_NO_HZ_COMMON
>  	int cpu = smp_processor_id();
>  
> -	/* Make sure that timer wheel updates are propagated */
> -	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> +	/*
> +	 * Make sure that timer wheel updates are propagated. An interrupted
> +	 * idle loop counts as idle even with runnable tasks queued on the
> +	 * CPU: forced idle under core scheduling, and the tasks sched_ext
> +	 * keeps on a CPU's run queue while its BPF scheduler holds them back.
> +	 * idle_cpu() would skip the idle bookkeeping of tick_nohz_irq_exit()
> +	 * for those, and with an unstable sched_clock the CPU's clock then
> +	 * isn't resynchronized when it leaves the idle loop.
> +	 */
> +	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>  		if (hardirq_count() == HARDIRQ_OFFSET)
>  			tick_nohz_irq_exit();

Works for me, but Peter might find something I haven't.

Acked-by: Frederic Weisbecker <frederic@kernel.org>


>  	}
> 
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
> -- 
> 2.43.0
> 

-- 
Frederic Weisbecker
SUSE Labs
