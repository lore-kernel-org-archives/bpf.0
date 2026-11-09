Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232685;
	b=juc4nFiGYa5RQ1y1OoejCR1uQEntzNRsCOmA6mm7FggQad+tQg5KZeem9FKScUPoiE07
	 AUFbLNEyPeplLzTapAjt+Yyiu/1NNzhQ6CkmW4XgtrCv59rBV+f3mQSl9tvlKGrq7CJ7l
	 EW1iIg/GWFkVd4FLDVW1a3fKXBDo7EestKQrSRJpOZ9gwndqUBA7NJiZ6fQs333XTxHcN
	 a9JL6P9H9QnkV8Zee6jO0dy00z38j0uL+nhMvSwLo9EMYHK8s74aBvU9qre4ocq1JBxT/
	 RsK7ruR4P45sFR8PverGRJ2FrZbeBBh/QIZAYdRmWWHXqaS6BajUOT+boW526r7CFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OXy3+dOjvb/DyuvDqwYDNvmtpOyjnPw41dlk99TtK1g=;
	b=FG47+U+OF53OeqxN7QhtZKwjg1AvQNiy/C5gGxJmloZnFMlNRGRbII0+OgIKLGQUJSFv
	 8TpIKSobGM3OtGxtz0s8U++1HrK/sduT++lY58zgV8BSsF8i9YRnWvAlfT1sMH12y0Sm5
	 UinSyue6Fr+i9BIEe0zOP4Y4oL8Gj8K8B/Izjcw83KNvyGC4RTWd3K8Th6bmme0Q/2JEW
	 Jc3FGifn3qFRSNUicP9f6y/mt0nnxZpXgS+IA54teeJXSk6OjIvx1r7xwf33f5whZm17e
	 EYGfdePRN2IpnOfthcA9GTeghCFznZaCFqhFnhdrvm42steepeLMlAWrwMpLlMCGkzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYVLfAma;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547AE606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 547AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYVLfAma
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b467581b98so8494435e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232684; x=1794837484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXy3+dOjvb/DyuvDqwYDNvmtpOyjnPw41dlk99TtK1g=;
        b=QYVLfAmakteH6TBk8iAj+RR+VKYJBwdC6qJUOcrynQWMO0wnhixaX6cx+2aF6j0oth
         qbYWgSJxX86+9C7HTigjNqiG6K+6SqEkVnznWRjmWyAR7CkI14ZvXgJHOibzrbdQTgRz
         s8kqHwVlDVjAdi/cnLvzUPgHm46eacZsOGld8+dyjBkTcCSfLeONp0nqJPX3t5B26AeR
         U6PcdlWjGP+IVuzEpJK7V6x81xQW2CP7LjxbEVzzwcnib0MDC2BbQq1rb3e7pqZ0TGte
         qKEoUZPrzQMpf3OC23E8juVFH8JkifzEMXkCMiDtFyve5utws2n0O2WaxYi+30anWATP
         00fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232684; x=1794837484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXy3+dOjvb/DyuvDqwYDNvmtpOyjnPw41dlk99TtK1g=;
        b=Qi8tYKvtaJFt5AB3xg1pPfgsv/gtMPz8kf7Bolg7eshf5E6LAjAmztHdtPlq2OiLRh
         b7zBu/XuxU4hHMGHeAQeymmQHXUqy7UD+Geqo/zGx5uT/7nts9H0YLenaK/ftBMSqK7h
         3Hw6dC4r1D3rS9OPQhQw41AYFMbXl0F3Xp0nWt98ohpKvLhFkGbSuNHu+LfqrdLkrLTa
         VoeZV4mqE61CvI5VL2ifcQnWXC88sx3fTVuzeDDnlqAlfwJGBD2c2EgSWjVaNwGp+Cd5
         WwyUhak7rRkPOwyRjEMJYeJWc2TakpRt1AHdg3ceRrJsaNe11yrMFIXxFdh70wSdipJK
         aMrw==
X-Forwarded-Encrypted: i=1; AL+hErHOXy5O3paYZ9f85yVBuEYok8dZCh9xgjNiBk/YSfL8it0HJqMY1DX8yhM4HYa+lTBsMcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G5MWhYlk9JW9DNctD/OfyUXfaVdkBf7haLDJCOUZoEobUMRTq
	w88dAbqEW7Gj8PHmpXqSf+l00O/ZT1dm5oY+RVWEyHqXiDAiB74WAwhC
X-Gm-Gg: AYBFou3gdhAx91LDuDEOkXuRfRr8L4lTBfoIt/8x+GdJuVTirHz8I656nVfhqbO9k+4
	a41RtS4FKzZsFKMJqlvaR51fK7lCG1gaB7pY/l7EhPbw/YCJMR4wyPq9YQnIgUe/wPRxyUmGIeB
	odiEL7yaLISZ3+AMN/rhogbDikwCg7R1jNH4JIUy0zJ8k40DuqveMIlVZ3+GKoilwwGWWuTJk+v
	s6o3ytGUakw2A6Ybx9S9o2+8EuUQiPLh86GIsrud2JCG1sF49g1w1bGvrmTQO3kA4+QHJZBtPUU
	TUCGE+AS2IhhuMAVCBxCO2lxhPnUi9Kepx95ubetKSqTEEHOEsjGGBTO/RAyxcqbEwe+yf3lL1D
	5PpgGQ+BM0ZU6VlXhcxfH1mCgEPj2S7omDLRBW7BPOvI83R5PxOpxSxPOrn80T2bFc0ZAbQgqAT
	Gxu2WPF4390IDQnDj4JdH8Pynzm9miPPuiL8A1bxX2CWoTrKGD2HBYioZMjwauKHVrj7UXOvWKW
	awwGBvLdFDXTIhIM9G3iQlzdOrwbuE6diTGucYowrZFcUAsP15xy+BIF99CRG5nGWHnwmitXFEf
	oqZa6JaN8s8aeGTehC4sabDchTU8RyAQdZzTibTokVPo4yuQ5hjaeRBwS0K129RXIAekB+mFq1u
	KQM/EsD56pwN61nmMP1h39Bk=
X-Received: by 2002:a05:600c:4f43:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4b960d9bb82mr98922965e9.6.1794232683411;
        Mon, 09 Nov 2026 05:58:03 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f119b96sm151286955e9.15.2026.11.09.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:58:02 -0800 (PST)
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
Subject: [PATCH v2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Mon,  9 Nov 2026 13:57:58 +0000
Message-ID: <20261109135758.395119-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
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
it.

Measured with one thread spinning 10 ms in every 100 ms in a cgroup,
kept off its CPU for a further 7 to 53 ms per period by a sched_ext
scheduler: the cgroup's cpu.stat usage_usec over the thread's own
CLOCK_MONOTONIC measurement of its busy time reached 2.00, twice the
CPU time the thread could possibly have used, and is 0.96 with this
patch. The same ratio with no BPF scheduler loaded is 1.005.

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

The two gates test different predicates rather than one containing the
other, and the difference is deliberate. idle_cpu() is idle_rq():
rq->curr == rq->idle && !rq->nr_running && !rq->ttwu_pending.
is_idle_task() tests PF_IDLE on current. Newly covered:

 - the two "the idle task runs while nr_running > 0" cases above;

 - a CPU idling with a wakeup queued by TTWU_QUEUE whose IPI has not
   run yet;

 - injected idle. play_idle_precise() sets PF_IDLE on a SCHED_FIFO
   kthread which then loops on do_idle(), so rq->curr is not rq->idle
   there and the old gate was false off nohz_full CPUs. Interrupts
   taken during injected idle now run tick_nohz_irq_exit() with
   TS_FLAG_INIDLE set. That CPU is running an idle state and needs the
   same latch for the same reason, so this is wanted rather than merely
   harmless, but note it reaches the idle injection users in
   drivers/powercap/idle_inject.c, intel_powerclamp and
   cpuidle_cooling, and is not confined to sched_ext.

One state is no longer covered: PF_IDLE is set by cpu_startup_entry()
and not by init_idle(), so a CPU on its idle task before that point
satisfied idle_cpu() but does not satisfy is_idle_task(current). Nothing
is lost, because TS_FLAG_INIDLE is only set inside do_idle(), so
tick_nohz_irq_exit() had nothing to do there, and nohz_full CPUs are
covered by tick_nohz_full_cpu(cpu) either way.

What keeps the new gate from giving a CPU idle accounting it should not
have is that tick_nohz_irq_exit() tests TS_FLAG_INIDLE itself and only
does the idle bookkeeping inside the idle loop.

Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.

The reproducer is a sched_ext scheduler that parks a tagged task on an
otherwise idle CPU for a set time. It was patch 1 of v1 and is dropped
from this posting at the maintainer's request; it remains in the list
archive, see Link.

Tooling: the bug was found and this patch and changelog were written by
Claude Opus 5 (Claude Code), in a session measuring cgroup CPU limit
enforcement under sched_ext. All of the patch and all of the changelog
are tool-generated. The measurements above were taken on hosts that no
longer exist and were not repeated for this posting. By the threat model
in Documentation/process/threat-model.rst this is a regular bug and not
a vulnerability: it misreports CPU time under a legitimate configuration
and crosses no privilege or isolation boundary.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Link: https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/
Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
---
v1 -> v2:
 - Dropped patch 1, the scx_tickbug reproducer, at Tejun's request. It
   is one-off debug code and does not belong in tools/sched_ext. It
   stays available in the v1 posting, see Link. I would still like to
   offer it as a selftest in tools/testing/selftests/sched_ext, next to
   nohz_tick, if a regression guard for this is wanted; say the word
   and I will post that separately.
 - Changelog: named injected idle among the states the new gate newly
   covers, and said that it reaches intel_powerclamp and
   cpuidle_cooling rather than only sched_ext. Raised by Peter
   Zijlstra and by the CI review.
 - Changelog: dropped the claim that the new gate is "strictly wider".
   It is not: PF_IDLE is set by cpu_startup_entry() and not by
   init_idle(), so an idle task before that point satisfied idle_cpu()
   but does not satisfy is_idle_task(). The patch now says which state
   that is and why nothing is lost. Raised by the CI review.
 - Changelog: put the measured ratios in the patch itself, since there
   is no longer a cover letter to point at.
 - No code change. The diff is byte-identical to v1 patch 2.

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

base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

