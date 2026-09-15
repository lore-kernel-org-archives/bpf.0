Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4547D462
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478278; cv=none; b=WIolnBDZmhIvQNZw8t2EQW4FRv/5T1uMlOa6F1y9XGp4qbHVYmbLnmIdkuGZhUc2Cp9/H81puCoSdL2hCdaUKoyEjJy9doNJqvxv6FhYnjc1qpES5PTefAEnAoAityl9wyVAOgrbyes6Im6fN7tUWqk57lKwRF6ay1gcjCgAM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478278; c=relaxed/simple;
	bh=2gqgm31o9vakOy6+NG5dFQrZfNnO16Cyr1QKmdk48dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRKwAu+bXCpkNQxXpIkN7SKnOUzJhQPH+Fp0Z1DtpYxzP0NiLDROHZuwVa42KjQJBBiyTDcFiVLiLfrVKcnTyN1NGGPD00IbXKqHzIh/wpDUQlNirOq6Z0uV93Us0Hcgf0Wjz4sFVulmbIliIUki19vRPWYhqC0t/y0KoI9SlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=iN6GDaYq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="iN6GDaYq"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb7692a57so36021191cf.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478274; x=1790083074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOBWKoOt8czuTeNdTxDxvLfMht4h54WO3jEdwibwnr4=;
        b=iN6GDaYqjkwhMEqcRyjRXtWw/w7oZJwfQuaJA2LCjB4j04J+YjGFdEsEKVYXBzst/P
         KYi+YoujdruZMKfeAxSULT+AzZW4dmdajByEJsJBK7gmg+nG60lU5Je0yNHK/OxOgP/y
         Iuo1PFaBp8dlMpzk5GXkwcqb5eX8PXuq8MX9Zgi/tt3q7H8zIvBPiWU+g/XVA7fmnNGu
         gniRCX0N7mDOi4DBeMJo/bDJAw2r7TMB1piYb7zOC+IaCeqCIPssYBRjjW9rFL7HnIhQ
         qgcdbEzchV1txav7ojPhVixjkwFE/u/7pbxgAq+O8Flz3vsCcgkAn/Hg/pBUwwy8PgG1
         c0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478274; x=1790083074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOBWKoOt8czuTeNdTxDxvLfMht4h54WO3jEdwibwnr4=;
        b=dyFoKSmQKsLVJK98V2yhT7YxpXMC+wnIKoN26yRPCvd/2UYAU0eJzSTWPG1mv18Q4C
         fxD6gjbesrXYf5WOCrQ2U+t6e8rf8tr9AF8Jj0JcrI27bWwddiCiuyM63TXASrDaNREV
         newqy8TPOi8qLjZF88ZFZKxzG+JKm+P6Kim6uQBm1uknZ5d9gYliX544vRPvztg208cu
         mvojMvxRAkzd7U0DajwfVCqS1PWl44Nsf23SeauRDNPXyWtgqk6vG5F4Xhe/sKmAkRMU
         NkxiuggJSgAQJ61kaMAg3JAWe7dNLJw2PvP+GvRJ1EagqCILQGYTOQ7Y8Eoff3fHdYD2
         JRhA==
X-Forwarded-Encrypted: i=1; AKwUvBxrcNQhRnPNE8KjYZAASBcOs6hF6+s2ZZfQcJk5yL9qnbdnMTrkE9fo3DNur6+Sf5R8GEc=@vger.kernel.org
X-Gm-Message-State: AFuF++mPUK2JDZ0XqKRiyk0zdTX5KFJjrFei4BLPKT0nU1dlr7x5Tdg2
	UBpdTq42CRyTFmROu164chBRjCI2O4AxZIkTsdYPqh45Wbp4Um3p1lnDjJ7tUcwG80M=
X-Gm-Gg: AYBFou1iuvE5YmJDWWbYR8Xjb1N8+uwXgDnJ8ssiha+sUnhXS49gCEKGAvQLAXT13ei
	g6BXrT3SmUE+SLP4vWDxhKkZZ6jNO7Mxuj1LGyiHLRF1odJoNulYFffCkA/bgNLpUUh9iNwDwyL
	W8+aAmM+LdMCoOFCWHKI/qB87DjYcAV1zwmYcFHdOSDxpvuyqKeGnz1CS347o5nO9a6eRSQjkwd
	jL4KvI7iY6VnWCPqeKRGswGhpmjt+DkJdyKfgT2XAvUaZz8fltLcNvCXyslEDNYLfjLCrztCpmH
	2qCMLvq8azWXUQ+mdaF6MK/GK3ZztX2vBc4BEZyrolwIF9PtGETvzOA7iFJxXmPuBSnGTSk078s
	DmaFCqUCifdOc7BIV6uW019v006N1TGAGLKhtAi1NB+YamOZaZOICWzdQ48NM3P/3UgMYqRqvUM
	gRLNlqqC5aNdE4DI/jH98JTYgJDYBtDfH9754YitzxIIXbqcCsDUETqWrg4ozLZpINoc18nYYH7
	ym0qhW5Ubx8EQ7Cpu0Aswou9F+8eCTChkI1dLQTRZb4mnIEnRDmxTID
X-Received: by 2002:a05:622a:1646:b0:530:9bb:54ae with SMTP id d75a77b69052e-5310cf32770mr102643101cf.15.1789478273513;
        Tue, 15 Sep 2026 06:17:53 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4ba156sm126369461cf.19.2026.09.15.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:31 +0000
Subject: [PATCH RFC v3 04/13] kprobes: Expose the optprobe jump window to
 Tasks RCU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-4-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=7478;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2gqgm31o9vakOy6+NG5dFQrZfNnO16Cyr1QKmdk48dg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFs4wUTmA5uBGNzmizfs5h8i2jZ+BJEC+ZKMMB4U6RQcjTiVVDPqXAZ9evZNBFK/JcfouDSMfSj
 BhbWSxMKT7As=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kprobe_optimizer() is the one synchronize_rcu_tasks() user that is not
about trampoline text: it waits for tasks that were interrupted on an
instruction boundary inside the bytes it is about to overwrite with the
optimized jump, so that none of them resumes into the middle of the new
instruction.  Those bytes are ordinary kernel or module text with no
Tasks Trace reader around them, so on CONFIG_TASKS_RCU_TRAMPOLINE_READERS
kernels the irq-exit quiescent-state check has to be told about them.

Add kprobe_in_optimized_region(), a lockless and conservative form of
get_optimized_kprobe() that reports whether any registered kprobe lies
within MAX_OPTIMIZED_LENGTH before the given address regardless of its
optimization state, and have rcu_tasks_trampoline_text() consult it for
core and module text so that a task interrupted there becomes a holdout
rather than a quiescent event. The hash walk only runs while
kprobe_optimizer() is actually inside its synchronize_rcu_tasks(),
tracked by a flag it sets around the call; otherwise the check is a
single load. That check cannot see a task that was already preempted in
the region before the flag went up (possibly before the kprobe even
existed), and the new grace period does not otherwise wait for a
preempted task to run again, so before synchronize_rcu_tasks() the
optimizer calls rcu_tasks_wait_irq_preempted() to wait until no parked
task's recorded irq-exit preemption IP is inside such a region; its
leading synchronize_rcu() also publishes the flag to every (interrupts-
disabled) check in flight. The kprobe hash is RCU-protected and every
free path waits for a grace period after unhashing, so the lockless walk
from the irq-exit path is safe.

On other configurations the flag is set and cleared but nothing reads
it and rcu_tasks_wait_irq_preempted() is a stub; the classic
implementation already waits for such tasks.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/kprobes.h |  8 +++++++-
 kernel/kprobes.c        | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h      | 11 ++++++++---
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e6de7ae55bda..74cc48c04417 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -530,11 +530,17 @@ static inline bool is_kprobe_insn_slot(unsigned long addr)
 }
 #endif /* !CONFIG_KPROBES */
 
-#ifndef CONFIG_OPTPROBES
+#ifdef CONFIG_OPTPROBES
+bool kprobe_in_optimized_region(unsigned long addr);
+#else /* !CONFIG_OPTPROBES */
 static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 {
 	return false;
 }
+static inline bool kprobe_in_optimized_region(unsigned long addr)
+{
+	return false;
+}
 #endif /* !CONFIG_OPTPROBES */
 
 #ifdef CONFIG_KRETPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e..e460fba83e4a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -511,6 +511,48 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
+/*
+ * True while kprobe_optimizer() is waiting for its Tasks RCU grace period.
+ * Only in that window can an interruption inside an optprobe's jump region
+ * matter to it, so kprobe_in_optimized_region() does no work otherwise.
+ */
+static bool kprobe_optimizer_waiting;
+
+/**
+ * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optimized
+ *	kprobe replaces?
+ * @addr: kernel text address, typically an interrupted instruction pointer
+ *
+ * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for tasks that
+ * were interrupted on an instruction boundary inside the region about to be
+ * overwritten by the optimized jump.  Where Tasks RCU is built on
+ * reader-marked trampolines that region has no reader, so the irq-exit
+ * quiescent-state check asks this instead (see rcu_tasks_trampoline_text()).
+ * This is the lockless, conservative form of get_optimized_kprobe(): it does
+ * not care whether the kprobe found is, or ever will be, optimized.  May be
+ * called from any context with preemption disabled; the kprobe hash is
+ * RCU-protected and every free path waits for a grace period after unhashing.
+ *
+ * The hash walk only runs while the optimizer is actually waiting.  A task
+ * that was preempted in such a region before the flag went up is invisible
+ * to that check, so the optimizer first waits those out by their recorded
+ * preemption IP (rcu_tasks_wait_irq_preempted(), whose leading
+ * synchronize_rcu() also publishes the flag to every check in flight).
+ */
+bool kprobe_in_optimized_region(unsigned long addr)
+{
+	int i;
+
+	if (!READ_ONCE(kprobe_optimizer_waiting))
+		return false;
+
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+		if (get_kprobe((kprobe_opcode_t *)addr - i))
+			return true;
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_in_optimized_region);
+
 /* Optimization staging list, protected by 'kprobe_mutex' */
 static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
@@ -644,8 +686,16 @@ static void kprobe_optimizer(void)
 		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
 		 * Note that on non-preemptive kernel, this is transparently converted
 		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 * kprobe_optimizer_waiting lets a reader-marked-trampoline Tasks RCU
+		 * recognise tasks interrupted in such a region while we wait, and
+		 * rcu_tasks_wait_irq_preempted() (a no-op elsewhere) first waits
+		 * out any that were preempted there before we said so; see
+		 * kprobe_in_optimized_region().
 		 */
+		WRITE_ONCE(kprobe_optimizer_waiting, true);
+		rcu_tasks_wait_irq_preempted(kprobe_in_optimized_region);
 		synchronize_rcu_tasks();
+		WRITE_ONCE(kprobe_optimizer_waiting, false);
 
 		/* Step 3: Optimize kprobes after quiesence period */
 		do_optimize_kprobes();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3a7c092361a6..866768462850 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1006,7 +1006,9 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    text being torn down may already be unregistered there);
  *  - the .text..rcu_tramp section, C glue called directly from such
  *    trampolines before it has entered the reader;
- *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text().
+ *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the bytes after a kprobe that a pending jump optimization is about to
+ *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
  * A false positive only makes the task a holdout until its next quiescent
  * event.  Called with interrupts disabled from the irq-exit path.
@@ -1017,9 +1019,12 @@ bool rcu_tasks_trampoline_text(unsigned long ip)
 		if (ip >= (unsigned long)__rcu_tramp_text_start &&
 		    ip <  (unsigned long)__rcu_tramp_text_end)
 			return true;
-		return arch_rcu_tasks_trampoline_text(ip);
+		return arch_rcu_tasks_trampoline_text(ip) ||
+		       kprobe_in_optimized_region(ip);
 	}
-	return !is_module_text_address(ip);
+	if (is_module_text_address(ip))
+		return kprobe_in_optimized_region(ip);
+	return true;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 

-- 
2.55.0

