Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958234;
	b=t6VHDDcq1na+pQSdccyA+PxAF5Y48d272syJXfWUroQ3q5NNx1uihWDDJbwCexC43SJ0
	 kvJVAVyYDuR8pjAGJaLQgreqlGFHrFOKlTkOImZFXE2YsYw/bDtWfmTgQpF4JIGE/SH7i
	 ML2A6F/3pMR0Zjko7dQglNnF4vfthjFdp0nV/AHozg8lqvGZ4211H8NvNok78+9xnt/C7
	 jkpqJHMoybyuo9YRcmk/sTc09UArIl9pLRLgUmV+E8fjStuPVbjdTo8dH8Tw6jA7YrPMB
	 OWLNE0W67DQdUGeqYGIsWVLItNF6S4ToLv/JekuG250bbfXKe000RHr2By1bPEaTbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KJNqYYH4eS7zhfJ38fc5jVlk3yATsfNyOP5G1+rP9mE=;
	b=Px9Rvl0TtbyTW9If6p/5OGJ7asEF1NYOZ0xySairm+LuyRFArCYgR71sNVSEx4KE2KrL
	 peNWey6rw3bps/5YoYcgUCudcNwyZEnd9rCO1WPnMgW3Pa9hicAauIkQURCDkXDdt+nV8
	 2jhEUjQ3uHVt+/Hl5YkeEZO9TyfJPN/6YItQZ1DBuDrErc8A+q21pFsv+uuUdTq60TKFy
	 QXAN3EhjyqMFxe32zusyuzuz76t5TaA3NtlrSvEJoG4us0QfKh9kaA4FElVE/BugCp9v8
	 kOFzSCfS55cvekRDi33Ushz6ph8PavvWiauKLvYNPmk7hcY490eFwXo0pjIwr8iMuuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFacy4j5;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45B606A928
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE45B606A928
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFacy4j5
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e46e449e8so277732f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 01:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958232; x=1794563032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJNqYYH4eS7zhfJ38fc5jVlk3yATsfNyOP5G1+rP9mE=;
        b=yFacy4j5xTkpP/UPyaIKzgzFjGswJz2ePZIw+ediDBXSuXQoohRgj93xiU6ToCOlcb
         fYu6GTuckZ8j+avSLcTr+i3E4kIs5oWWxJ6Kgk35b3aM6gNpEdVTp11dtU0G7UJEZ/yj
         2H0GSac9bxZ/aZ0/2U04TRX3tE3zOLgmKXCxd+E7iVpuIKSfwaMzva+FjhX8+Rtwb/bO
         fNj0eRwk5+RRvFB8bjfC0hS6VTwMD4mxoeayLGyu8Aoj3iEf9PWaWEXXe81VhFz3JjO5
         Wm6exqBzAYnylVMsCpLbBJW+HRsku0xRs8+mENc3P5/YorPfNN29N40x/hjVVDe61+0J
         Whdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958232; x=1794563032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJNqYYH4eS7zhfJ38fc5jVlk3yATsfNyOP5G1+rP9mE=;
        b=NJQL7kneps9gp0OYTCJZOeHkwq+rkAeeSG9gWFLv1Yijs2jBY28AN1ow4kUEDRxdUd
         q1TnjsDN/1n4RlFjpPfEzFPl1jVQOSpAeyBvJO2F/hmk+NG433eqym3YEQ5X+pqHAt6S
         c9dVZ3JktSB4m5GNnP8wcXBaYadKEl6RluybUAtGe19YEI9EwXYqexZsCBdPyJ0OrU4K
         O2lVag2Wvou5dnuup0buEDvYj+lVHg+X+wkhTVdBaWetRT7rgj6wdIEQIQ1TjCU5Trc8
         4YDjO7zKxNmQ2ojotMhRhebscrSFsijZlmIO9CuvqjFCNqLSy0zgDnvUG+E3yd7ImYku
         OP8A==
X-Forwarded-Encrypted: i=1; AL+hErEfxfCwrRq27CbABracAVJxmYFNJJMgTAp22cbFEtbZb/DjrpBoZ3Y8QdmY6RVhFNdNeeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z83JIxnSmPqC11KgMEchhhg332RSkw+bsFDkIsbt6SpxiUfUKz0
	LLoErunmOjLNbZfJqmFwH8CPlnECgO/K7yn/GU5pDHwtanZFj7DBfER5
X-Gm-Gg: AYBFou0dxsX8nZ6HsK7FzlsheIQUytuP+i35J3mswsAMFd581efji2BhJwyk2yoBxtN
	iOkTn2jqcf6jr46Xn8bnfhdp7Mwn4N8WRy/wcYGu0DbXasdAFPS+/YiRZ38jDssaN4M8M6efpSY
	Y7ohqZOAjxKdmWBwsrZoUOrQS9FHXo7XxriAX4UlaKVb74R/p8QEfF7Jnhv5fZ3ex9sucBWHtLW
	IvBoO4qyX8TScb1/yvMLxjFlpIQNlqlnhc2dy1Orx6bXWjyynhPgBnPSte6o/aU2l+woRKh7YA2
	nrK4qrz9u0zoBqXwYYWw/yObNF7R6I5GX+v4NjwfzmBe+Szd1/mNiTCvdEJfAQS50bFWyzeVB/d
	nmsBhsrCwK2M27BcWC/5OhA7ouigJmGrv2t7KgRIb675sGYos5sfoMXH4E8h/7CV0uXx9aa6fan
	M1m55q1zAvP3O7ixU74YtdPSOzQN0Qg4fm9kvDKrMGKnoMXhlqRr/jaTBYa0FsGAIKO1Cp3YpIn
	cLVLjutyJ4FtuzXjpS0FrPvV3V74SaC2JeGmCQ9C1p5Eq6WEagLk6ydlrmilTzBLdTm7vtFQMhS
	LK6yCobEOep5x/qqftONRoAePgR/OIT4cUMzgiZC7RMLtgN1QlQfYzNO4T70HfnsF0uta70M8pq
	s1g==
X-Received: by 2002:a05:6000:22c1:b0:490:6e0f:a024 with SMTP id ffacd0b85a97d-492760dbbdcmr4572931f8f.13.1793958231776;
        Fri, 06 Nov 2026 01:43:51 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492fc80e017sm2228205f8f.34.2026.11.06.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:43:51 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tj@kernel.org,
	tglx@kernel.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Fri,  6 Nov 2026 09:43:43 +0000
Message-ID: <20261106094343.174905-3-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106094343.174905-1-radu.m.toader@gmail.com>
References: <20261106094343.174905-1-radu.m.toader@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_irq_exit() only runs tick_nohz_irq_exit() if sched_core_idle_cpu(),
which is idle_cpu() unless core scheduling is built in. idle_cpu() is
false when the run queue has tasks while the idle task runs.

That is the normal state of a CPU under sched_ext whose BPF scheduler
holds back a runnable task of that CPU in one of its queues, e.g. a task
of a cgroup at its CPU limit: the task stays queued on the CPU's run
queue and counts in rq->nr_running, while the CPU sits in the idle loop.

tick_nohz_irq_exit() is what marks an idle CPU as idle again for the
scheduler clock after an interrupt in the idle loop
(TS_FLAG_IDLE_ACTIVE, sched_clock_idle_sleep_event()). Without it, the
next exit from the idle loop doesn't resynchronize the CPU's sched_clock
with sched_clock_idle_wakeup_event(). With an unstable sched_clock, e.g.
under kvm-clock without a stable TSC, the clock of a CPU in tick-stopped
idle is clamped to its last stamp plus a tick, so a task picked after a
reschedule IPI (which doesn't go through irq_enter()) starts with a
stale exec_start, and the next tick charges the whole idle stretch to
it. A cgroup holding one such task was charged twice the CPU time it
could possibly have used; numbers are in the cover letter.

Commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
fixed this same gate for the other case of "the idle task runs while
nr_running > 0", forced idle under core scheduling, where the symptom
was too little idle time in /proc/stat. sched_ext made that state
reachable without CONFIG_SCHED_CORE, and there the symptom is idle time
charged to a task as runtime.

Ask whether the idle task is running, which covers both cases. CPUs
whose run queue is really empty are unaffected; a CPU interrupted
between leaving the idle loop and switching to a task has need_resched()
set or has already left the idle accounting, see tick_nohz_irq_exit().
sched_core_idle_cpu() has no users left and goes.

The new gate is strictly wider than the old one, and deliberately so.
idle_cpu() is idle_rq(), rq->curr == rq->idle && !rq->nr_running &&
!rq->ttwu_pending, so besides the two cases above it also skipped a CPU
idling with a wakeup queued by TTWU_QUEUE whose IPI has not run yet.
That case is now covered too, on any kernel and not just under
sched_ext. It is the same latch failure for a shorter window, so
covering it looks right rather than merely harmless, but it was reached
by reading the code and not measured on its own. What keeps the wider
gate from giving a CPU idle accounting it should not have is that
tick_nohz_irq_exit() tests TS_FLAG_INIDLE itself and only does the idle
bookkeeping inside the idle loop.

Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.

Tooling: the bug was found and this patch and changelog were written by
Claude Opus 5 (Claude Code), in a session measuring cgroup CPU limit
enforcement under sched_ext. All of the patch and all of the changelog
are tool-generated; the cover letter says what was and was not measured.
By the threat model in Documentation/process/threat-model.rst this is a
regular bug and not a vulnerability: it misreports CPU time under a
legitimate configuration and crosses no privilege or isolation boundary.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
---
 include/linux/sched.h   |  2 --
 kernel/sched/syscalls.c | 12 ------------
 kernel/softirq.c        | 12 ++++++++++--
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..0e704ea9416f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2326,11 +2326,9 @@ extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
-extern int sched_core_idle_cpu(int cpu);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
-static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd..22e316680a86 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -194,18 +194,6 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
-#ifdef CONFIG_SCHED_CORE
-int sched_core_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	if (sched_core_enabled(rq) && rq->curr == rq->idle)
-		return 1;
-
-	return idle_cpu(cpu);
-}
-#endif /* CONFIG_SCHED_CORE */
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7fc2200392cd..e7d649c29c0c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -738,8 +738,16 @@ static inline void tick_irq_exit(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	int cpu = smp_processor_id();
 
-	/* Make sure that timer wheel updates are propagated */
-	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	/*
+	 * Make sure that timer wheel updates are propagated. An interrupted
+	 * idle loop counts as idle even with runnable tasks queued on the
+	 * CPU: forced idle under core scheduling, and the tasks sched_ext
+	 * keeps on a CPU's run queue while its BPF scheduler holds them back.
+	 * idle_cpu() would skip the idle bookkeeping of tick_nohz_irq_exit()
+	 * for those, and with an unstable sched_clock the CPU's clock then
+	 * isn't resynchronized when it leaves the idle loop.
+	 */
+	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (hardirq_count() == HARDIRQ_OFFSET)
 			tick_nohz_irq_exit();
 	}
-- 
2.43.0

