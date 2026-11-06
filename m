Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994954;
	b=OYzJ+NSgqXB/iZz4ebzU0Fa19E5a7JEMvCjUmWMFJ9Hwb4S9lVMosiA//PHIezlPWLKF
	 7kr7iH99uLJf1evKmIvLL2ZLBBROy9Wh5XZhg1UcWbUs5NfwdXQsYPpJyvq3gCZviBIFh
	 kjguaTiZiJ5WKwjHR/bl8bRYb3bMZbZdQlrZ9JuoHDjoR1G6su2hiRBM9Mc9/SBpZHP12
	 6f6J/1K3QzNNraNBQP99SxBt6twBgt0coNDRYehk56DSGwYuZSHMcLDzp5a6XkO95fspD
	 N7FrJtLRGe+MRoeEiwVuud84mVq9ye9CaS+NubKSReLrVl+E7/197HSF03dVx7ZL90w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994954;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=CVnrDRD14RkQVFOP831KmPYjio0EhE/Z8ExMuIwhgaA=;
	b=S4ms/BpsnIHpUUQbOhX1Ki64sNZv2u3fJfR08OBO3hT90lEJ2GM4ZSL4PNmM1JLqsTSC
	 ggXVST6Ws/MIBem6M1Pyi5swPTEGWEIA0FzjlYWqL4Zeh0qt0AoBf75L/MH4crGRpnEUf
	 PsH3T5yTmjRIhs9kZagX6nqVCWAsflWtAVs5BaDiaUZTUzaFHzq4MTJC4BogofSm5HyA8
	 mh3J4dfeWxEPr1lBCE+uXj5uJbGIDzv99bbOvxbqkztvJDMQz4rkoUOw63/6/WZf947JV
	 TWiMhqepLXV2JdFBuYRpo90ASo6kYAGi0SPyvv1Ottvk3VyFGBDWqK0pgCpJC+Ie2kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4itSoeh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D565606A32F;
	Fri,  6 Nov 2026 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4itSoeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D81F008A1;
	Fri,  6 Nov 2026 19:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994954;
	bh=CVnrDRD14RkQVFOP831KmPYjio0EhE/Z8ExMuIwhgaA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B4itSoehTAdlgPLd1obhUJeN+qkvCKJbDDTwW9xTtElsNnSnKFVfcGKrxfLMgC/YS
	 4kjTk93659roj5mozArUqiY2yA3E64SAY1JZw5DRLs2BpjKPA0MNX7YXA3si7wyDNe
	 7AbYPepCaU/kOljEqD5gSNl7EOE0pYqUPbHxfB/LEJ6pfhp9zAWL41OvkXr2WeKBZZ
	 usMSh9kpqYGmaPBiuRQzzKetVEDFZQ6Wuy0S+i/+IZMlJCign+yaxeX705prAbEqQk
	 lxteo/YeHr99NPJjDSCFtkSjEWTJOCQek7t2i6HMq/UFZ50lHwE2sm7wBh2sJWmgfk
	 mgpNKNw5LBqZg==
Content-Type: multipart/mixed; boundary="===============5974966905912842169=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d8c4fb5ce3e465c9c9e562c851d586ef8e5cc43d85d61998f63f2c48d431778e@mail.kernel.org>
In-Reply-To: <20261106094343.174905-3-radu.m.toader@gmail.com>
References: <20261106094343.174905-3-radu.m.toader@gmail.com>
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
From: bot+bpf-ci@kernel.org
To: radu.m.toader@gmail.com,peterz@infradead.org,mingo@redhat.com,tj@kernel.org,tglx@kernel.org
Cc: juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,frederic@kernel.org,anna-maria@linutronix.de,bigeasy@linutronix.de,joshdon@google.com,haoluo@google.com,brho@google.com,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 19:55:53 +0000 (UTC)

--===============5974966905912842169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> softirq: Treat an interrupted idle task as idle in tick_irq_exit()

TL;DR: Commit message only: claims the new is_idle_task() gate is "strictly
wider", but it also now covers idle-injection kthreads (PF_IDLE) and not some
early-boot cases; the changelog should say so.

>     softirq: Treat an interrupted idle task as idle in tick_irq_exit()
>
>     tick_irq_exit() only runs tick_nohz_irq_exit() if sched_core_idle_cpu(),
>     which is idle_cpu() unless core scheduling is built in. idle_cpu() is
>     false when the run queue has tasks while the idle task runs.
>
>     That is the normal state of a CPU under sched_ext whose BPF scheduler
>     holds back a runnable task of that CPU in one of its queues, e.g. a task
>     of a cgroup at its CPU limit: the task stays queued on the CPU's run
>     queue and counts in rq->nr_running, while the CPU sits in the idle loop.
>
>     tick_nohz_irq_exit() is what marks an idle CPU as idle again for the
>     scheduler clock after an interrupt in the idle loop
>     (TS_FLAG_IDLE_ACTIVE, sched_clock_idle_sleep_event()). Without it, the
>     next exit from the idle loop doesn't resynchronize the CPU's sched_clock
>     with sched_clock_idle_wakeup_event(). With an unstable sched_clock, e.g.
>     under kvm-clock without a stable TSC, the clock of a CPU in tick-stopped
>     idle is clamped to its last stamp plus a tick, so a task picked after a
>     reschedule IPI (which doesn't go through irq_enter()) starts with a
>     stale exec_start, and the next tick charges the whole idle stretch to
>     it. A cgroup holding one such task was charged twice the CPU time it
>     could possibly have used; numbers are in the cover letter.
>
>     Commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
>     fixed this same gate for the other case of "the idle task runs while
>     nr_running > 0", forced idle under core scheduling, where the symptom
>     was too little idle time in /proc/stat. sched_ext made that state
>     reachable without CONFIG_SCHED_CORE, and there the symptom is idle time
>     charged to a task as runtime.
>
>     Ask whether the idle task is running, which covers both cases. CPUs
>     whose run queue is really empty are unaffected; a CPU interrupted
>     between leaving the idle loop and switching to a task has need_resched()
>     set or has already left the idle accounting, see tick_nohz_irq_exit().
>     sched_core_idle_cpu() has no users left and goes.
>
>     The new gate is strictly wider than the old one, and deliberately so.
>     idle_cpu() is idle_rq(), rq->curr == rq->idle && !rq->nr_running &&
>     !rq->ttwu_pending, so besides the two cases above it also skipped a CPU
>     idling with a wakeup queued by TTWU_QUEUE whose IPI has not run yet.
>     That case is now covered too, on any kernel and not just under
>     sched_ext. It is the same latch failure for a shorter window, so
>     covering it looks right rather than merely harmless, but it was reached
>     by reading the code and not measured on its own. What keeps the wider
>     gate from giving a CPU idle accounting it should not have is that
>     tick_nohz_irq_exit() tests TS_FLAG_INIDLE itself and only does the idle
>     bookkeeping inside the idle loop.
>
>     Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
>     NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
>     SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.
>
>     Tooling: the bug was found and this patch and changelog were written by
>     Claude Opus 5 (Claude Code), in a session measuring cgroup CPU limit
>     enforcement under sched_ext. All of the patch and all of the changelog
>     are tool-generated; the cover letter says what was and was not measured.
>     By the threat model in Documentation/process/threat-model.rst this is a
>     regular bug and not a vulnerability: it misreports CPU time under a
>     legitimate configuration and crosses no privilege or isolation boundary.
>
>     Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
>     Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
>

The commit message says "The new gate is strictly wider than the old one,
and deliberately so", and lists the newly covered cases as nr_running > 0
while the idle task runs, and a queued TTWU_QUEUE wakeup. Is that accurate?

is_idle_task() tests PF_IDLE on current, which is a different predicate
from rq->curr == rq->idle.  play_idle_precise() sets PF_IDLE on a
SCHED_FIFO kthread and then loops on do_idle():

kernel/sched/idle.c:play_idle_precise() {
    ...
	current->flags |= PF_IDLE;
    ...
	while (!READ_ONCE(it.done))
		do_idle();
    ...
}

During idle injection rq->curr is that kthread, so the old gate was false
(except on nohz_full CPUs), while the new gate is true whenever
need_resched() is clear.  Interrupts during injected idle will now run
tick_nohz_irq_exit() with TS_FLAG_INIDLE set, which does
tick_nohz_clock_sleep(), updates ts->idle_entrytime, and may start kcpustat
idle accounting.  This affects users such as intel_powerclamp,
cpuidle_cooling and idle_inject, and is not limited to sched_ext.

Peter Zijlstra raised the same point on the earlier posting: "So
is_idle_task() is also true for idle-injection tasks. I *think* that is
also right in this case, but it wasn't mentioned."  No reply or changelog
update addressing it is visible.

Conversely, PF_IDLE is set by cpu_startup_entry(), not by init_idle(), so
a CPU running its idle task before that point (rq->curr == rq->idle,
nr_running == 0) satisfied idle_cpu() but does not satisfy
is_idle_task(current).  That looks harmless, since TS_FLAG_INIDLE is only
set inside do_idle() and nohz_full CPUs are still covered by
tick_nohz_full_cpu(cpu), but it means the gate is not strictly wider.

Could the commit message name the idle injection case among the newly
covered states, and replace "strictly wider" with wording that matches the
PF_IDLE semantics?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42280840441
--===============5974966905912842169==--
