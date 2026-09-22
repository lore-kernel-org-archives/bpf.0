Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD49397E91
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044485; cv=none; b=Wdnl+k6awfNUYUS6Fj/cnDXAZb+0pyw4HMzfo/WHCyrhIOQT8jP9Cgn0sx8f0Mzcle5amO6v5yXO4gsvyYAqRsXh1JBq3WB0J0bP7pUWB6qmaJKRGIpDCodSfDoek3t9f7HZ+T/qiZtSdEAag6YC6jpCes7i5XiGOsp2+oHdL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044485; c=relaxed/simple;
	bh=VsJyzZYJ6ksShlnC7Yiz29R4LafGY+0/mhkU2yBL4O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACEMecH7ErpGMadX/bMJ1DYtwCNpljyg2nK3Tr+sS8Q9Az/kglALj0JTGNMDeBqHd/qWTSctBGf7ZM7PDp2U9PfEVWDrhHu1RFJA/5hNxI+qEyM4hYPEw66LupbnujeIIk0AH5ewXPE8OMO0r1J4LHbov8vSjScisGkv0UbwLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=kIQNNrcu; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="kIQNNrcu"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef19aso38218191cf.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044482; x=1790649282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8c5rUXaTXu9B0UqDL2lNbjmJqabE8+fQOLsAHyr+Co=;
        b=kIQNNrcubijMLU9kXufwCnfuMATpJB/6pd2klffOZfFFiOw2Hu3fE5NyJXnf5RpQet
         M0pRQLpDQBo1YMaOAf8dHLgkk5rryrp30J/zo4i59zq/nUnsrr9OuUpEhkoZXThOE8Dv
         TzSWpKgTtSaXlxosklQ9aiBMkp96te8d9wdI8x9JkUACON8sEyuwynTMT9NHupATxuXM
         va7O0CdKCHNbKTmWER+Mmwb+JyrMg5AQUP6TXoPG9ow3k7xRophnT1i2bzk2BfHUZ4sD
         R9B7FrQk6w5cjPkZJSE7UObwQB4ManZn/TRRwhj8m1PuJhyGAX77xLqC6n7OOz2XOC5R
         pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044482; x=1790649282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8c5rUXaTXu9B0UqDL2lNbjmJqabE8+fQOLsAHyr+Co=;
        b=XXpOWdhG6Be6zogwr03O6r7HPP4w2/GWapM+/seBNvISLJE/rkMXFfFAoRDhe0DZnz
         2F1/qZ5BxLZzVqtzX3K/goGVz6PjMLgpD+O02lzoVrGKXxgvNmIbWAX9iYOdy5Tf3elI
         ewwOWYkz33OTV3e9iv3XQZbE6gupaAiZu7tcXD4eUrAWg1Fb7Tk+5nVECMK+iAIyoStG
         n4RRpC/eni50CFSL+gF5ZS6rZzF8Mv978w34IQE8WysVW1fbWwWVPX3PMaxe/6iNJfFw
         W99EdZBkS1ACY3LCNSQzQKWjvuIim8HTpkpILvulSUCYunF1d+Vk8IgwqVd25KWrcsPN
         PASA==
X-Forwarded-Encrypted: i=1; AKwUvBza+cSsZLCHwh98Z1pMOKpswTdPS05WI0ooDQupzeYkvjZ8ekBRyHJyJgP0AKQ5c7QEnIk=@vger.kernel.org
X-Gm-Message-State: AFuF++lOHxt2fMzggonaIzdRaqEMOEfvJdr6Xg391lNECSZYq5hgfkpH
	0CYN3HTHmg45RhCWTsbE/xnD0uBW1srWj9u0/BAeSHL5vkxsSucWqbdH5cNtxVDOelA=
X-Gm-Gg: AYBFou0e5uh2OeH/S/eT/tXLzFuuypGoWmLkDhYVyGVPoGnqmxr9Qf4qRtPvaPf1Dth
	bBFU3dsxHFQPIz0N1LxT0hz3FUgf6Vj4kvh8CizC+l7gO+0XwdlhupY9g3pDWp3ebxJrNqy6DKN
	tcNGEsOAUmrIeBWdBc/YCHMiQJzJbn3IEXi/BKifRrmwOCFNOzsEDU7jnwOiqFB7WRLiG16Csd/
	mqNK3Z0irVRTjn1t/HXh2U1LpObCKDNUs6z6Y5ZHpTAcqMiX8YdJo3E1akOC3cC8U2YgHkuW7Qg
	bJbFiXMWnfa56EDnXtNFO3MsbvaibPn4cdrWUulS5mVeDaZLLQbwbFWvDaVjLe3pOeDdYAA8kbU
	1pPtwubWhBTM5hVV6lGZRZfFKIac8WwzZZlciyPx0ZIbsPda6P6tPSjkda/K+jlCBg6grydnkqd
	os0y6dsaj39vlCV2hLjQCICt8PjEgfE7i4ODhHBwE4zfNmGTxtRQDCGp3S6pUjWbT/c0Kg2/0+D
	tU4QCXIoWAxPZFc
X-Received: by 2002:ac8:5981:0:b0:531:341:685b with SMTP id d75a77b69052e-532d8e6db17mr35559661cf.57.1790044481601;
        Mon, 21 Sep 2026 19:34:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e19042f2sm1747801cf.17.2026.09.21.19.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:34:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:32 +0000
Subject: [PATCH v5 13/13] x86, arm64: Build Tasks RCU on Tasks Trace
 readers in trampolines
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-13-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043821; l=6284;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VsJyzZYJ6ksShlnC7Yiz29R4LafGY+0/mhkU2yBL4O8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAul8WLe0tDTHb9SU5nk2yovv9PSDoMlv/2xo0UkHrqLg8PKI6TfwzvMu0u8RzKLGszaLneeE+P
 K/bP4/WyaqA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With the preceding patches every trampoline whose lifetime Tasks RCU
guards on x86-64 and arm64 -- ftrace_caller and its copies, the optprobe
template, BPF trampolines, and the sample direct-call
trampolines -- is a Tasks Trace RCU reader around its call-out, and the
text outside that reader is known to rcu_tasks_trampoline_text().
Select HAVE_RCU_TRAMPOLINE_READERS on both (x86-64 with SMP for Tree
SRCU and DYNAMIC_FTRACE, which is where its ftrace_caller changes and
arch_rcu_tasks_trampoline_text() live; arm64 with
DYNAMIC_FTRACE_WITH_ARGS likewise), which switches CONFIG_TASKS_RCU to the
implementation added earlier in the series: a Tasks RCU grace period
becomes a per-CPU pass over context switches and irq-exit reschedules
outside trampoline text plus a Tasks Trace grace period, bounded by a
few jiffies and preempt-off latency instead of by the longest stretch
any task runs without sleeping.

Other architectures keep the classic implementation.  Update
Documentation/RCU and the FORCE_TASKS_RCU help text to describe the
variant and the obligation it places on trampolines.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../RCU/Design/Requirements/Requirements.rst       | 24 ++++++++++++++++++++++
 Documentation/RCU/checklist.rst                    |  7 ++++++-
 arch/arm64/Kconfig                                 |  1 +
 arch/x86/Kconfig                                   |  1 +
 kernel/rcu/Kconfig                                 |  6 ++++--
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..c059c463e083 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2756,6 +2756,30 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
 
+Architectures that select ``CONFIG_HAVE_RCU_TRAMPOLINE_READERS`` keep the
+same three APIs but implement the grace period differently
+(``CONFIG_TASKS_RCU_TRAMPOLINE_READERS``).  There, every trampoline whose
+lifetime Tasks RCU guards enters a Tasks Trace RCU read-side critical
+section (rcu_read_lock_trace() or its assembly equivalent) before calling
+out and leaves it before returning, so a task anywhere inside such a
+call-out is an ordinary Tasks Trace reader whether or not it is
+preempted.  The few trampoline instructions outside that reader can only
+be occupied by a task that was interrupted there, so the grace period
+additionally waits for each CPU to pass through a context switch, and the
+irq-exit preemption path, the only switch that can catch a task inside
+such text (rcu_tasks_trampoline_text()), briefly makes such a task a
+holdout until it is next seen elsewhere.  On such kernels an involuntary
+context switch outside trampoline text *is* a Tasks-RCU quiescent state,
+a Tasks RCU grace period no longer depends on how long any task runs
+without sleeping, cond_resched_tasks_rcu_qs() is unnecessary, and the
+obligation moves to the trampolines: anything that relies on
+synchronize_rcu_tasks() to protect code a task may be preempted in must
+take the Tasks Trace reader (see register_ftrace_direct()), or, where
+that is impossible because the code is ordinary text with no trampoline
+of its own, make it known to rcu_tasks_trampoline_text() and wait out
+tasks already parked there with rcu_tasks_wait_irq_preempted(), as the
+kprobe jump optimizer does.
+
 Tasks Rude RCU
 ~~~~~~~~~~~~~~
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 4b30f701225f..87dd506bffef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -252,7 +252,12 @@ over a rather long period of time, but improvements are always welcome!
 	a.	If the updater uses synchronize_rcu_tasks() or
 		call_rcu_tasks(), then the readers must refrain from
 		executing voluntary context switches, that is, from
-		blocking.
+		blocking.  On architectures that select
+		CONFIG_HAVE_RCU_TRAMPOLINE_READERS a reader must in
+		addition be a Tasks Trace RCU reader (that is what the
+		trampolines there do around their call-outs) or be text
+		that rcu_tasks_trampoline_text() recognises; an arbitrary
+		stretch of preemptible kernel code is not protected.
 
 	b.	If the updater uses call_rcu_tasks_trace()
 		or synchronize_rcu_tasks_trace(), then the
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..bf0e56006863 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -218,6 +218,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_RCU_TRAMPOLINE_READERS if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..64c3814eb745 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -288,6 +288,7 @@ config X86
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_RCU_TRAMPOLINE_READERS	if X86_64 && SMP && DYNAMIC_FTRACE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bbab14bc14c3..341b68b972ef 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,8 +95,10 @@ config FORCE_TASKS_RCU
 	help
 	  This option force-enables a task-based RCU implementation
 	  that uses only voluntary context switch (not preemption!),
-	  idle, and user-mode execution as quiescent states.  Not for
-	  manual selection in most cases.
+	  idle, and user-mode execution as quiescent states, or, on
+	  HAVE_RCU_TRAMPOLINE_READERS architectures, the variant built on
+	  Tasks Trace RCU readers in trampolines.  Not for manual
+	  selection in most cases.
 
 config NEED_TASKS_RCU
 	bool

-- 
2.55.0

