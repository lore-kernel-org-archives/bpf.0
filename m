Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384331;
	b=eMgjqIk0bjqkgQETERlHNPXgxY7ySAeg1dUkWDf5ClXT+ElTMp7CJwGqKG1V3GaohS+6
	 ARFBHu39B6MOMYLC4fMbOoHbbovpdrDhAuqWixpcfGlbzUEcybd/UFnypyGuj5M90k9/r
	 H4+KBrBm4cESGQis0j7UPLOdoBsL41z59MQQwsv6fjFySQw/NyFt3/RUWZj8DI1vgMPhQ
	 kjBrXqrZ0Vo8yM4ipkspZaHDPnjoRaWhU2OA1//nHJrxQX7urgftSslZzmuwxrxfK5t9Q
	 vOEVNj7ZBaLm8A4OU0PYFHfwwAjDOmmMrnY25SBNXWLjX3WiVOoBCs2ba4PoZqKr/sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384331;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=dMZUIMOLvYUrODTdzt6SoBp5bxkivOxSH3iVoMyLwAA=;
	b=P+ikEsV+liZkqNcUhR8Opgl1rNTKeSfrY15B31NQZiCCmPtFwdEp8IW11HLvZsn5iLJM
	 mboFfphhgiwIuildxU0ll69ccjCLKagICUTrluuOr3rlBFjHp3tE3p5tL6HvoJmWMFcRZ
	 +Zm0zfpobl5HXFedf9xc/hY7PDj2DZH7W03rv53QF4j1qr/w8/GGjYNfKqBznCSaiWhwE
	 gKX+S+Velw9rwgbyeaPXGWTONHq+DiGK8CPIWGZgSwEi+GIdfq/YvEBGw+mwOpXdeYbIy
	 rTJNMuFkeU+XT2kdvBrmviB0MmE9AMIrZgfzQPDrbJ62sbhMvYH+S3d+x89Dwz093Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxX6BnuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F7606A321;
	Wed, 11 Nov 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxX6BnuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453FE1F00A05;
	Wed, 11 Nov 2026 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384330;
	bh=dMZUIMOLvYUrODTdzt6SoBp5bxkivOxSH3iVoMyLwAA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nxX6BnuPV1ze2wMAtUBnKYgZFhVZtOy7yx8hp/H3FXk2GPXh1OyTyfjjiTn1hYpfv
	 Q11Vw9+cd/L3eD/gpbkDtoOgHM4I7KKEvutAVvO985QFToanpr2/FjZvJkGKkXWWB5
	 7j2hA0qJWtwSaGwo6d7QNdoXCLR2bC1jQLpbHo/abcDQfbsLnRJ7N0hnJHYh3eWLM3
	 9VkvBkqVEvXWHErgwpqYGV5FNrcNQzX0vCGvaqGk02PS2FvOpoKMFuBCowm2WedOBQ
	 XIJb8MQK+przP7V+hH3+nD05xSOoMkoO7NfHXUU25C/LHQMT0wOALn9IJgyvzMfMXQ
	 Gal2dFG/Tr1AA==
Content-Type: multipart/mixed; boundary="===============3405028542108698645=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d429e252a205d044f8f034ed8341c4cb1e1eeb61711b4dea4d437d40b7cb7223@mail.kernel.org>
In-Reply-To: <20261109135758.395119-1-radu.m.toader@gmail.com>
References: <20261109135758.395119-1-radu.m.toader@gmail.com>
Subject: Re: [PATCH v2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
From: bot+bpf-ci@kernel.org
To: radu.m.toader@gmail.com,peterz@infradead.org,mingo@redhat.com,tj@kernel.org,tglx@kernel.org
Cc: juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,frederic@kernel.org,anna-maria@linutronix.de,bigeasy@linutronix.de,joshdon@google.com,haoluo@google.com,brho@google.com,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:05:29 +0000 (UTC)

--===============3405028542108698645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> softirq: Treat an interrupted idle task as idle in tick_irq_exit()

TL;DR: Commit message only, no code issues: the changelog carries posting
notes (v1 history, dropped reproducer, compile-test matrix) that could move
below the '---' line.

> softirq: Treat an interrupted idle task as idle in tick_irq_exit()
>
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
> Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
> NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
> SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.
>
> The reproducer is a sched_ext scheduler that parks a tagged task on an
> otherwise idle CPU for a set time. It was patch 1 of v1 and is dropped
> from this posting at the maintainer's request; it remains in the list
> archive, see Link.
>
> [ ... ]
>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Link: https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/
> Signed-off-by: Radu Toader <radu.m.toader@gmail.com>

This isn't a bug, but the changelog carries notes about the posting itself:

> The reproducer is a sched_ext scheduler that parks a tagged task on an
> otherwise idle CPU for a set time. It was patch 1 of v1 and is dropped
> from this posting at the maintainer's request; it remains in the list
> archive, see Link.

Could the notes about v1 and this posting (and perhaps the compile-test
matrix) move below the '---' line, leaving the Link: tag to point at the
reproducer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982351680
--===============3405028542108698645==--
