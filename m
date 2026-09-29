Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C339524D
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701904; cv=none; b=mE+YRVo/eTdXnWHLOioLg7MvfEd6OveNHNk+AJj2wOK2dWaS/JIydsP2VS1/H1xnfqghCb6qmEMdAFGcQoEVr+Ae1+Mcwkf0sxQabNmCccc/pLJ5r+oDKBKNnvQUeyTbwrdDo89I+Vardglkf95pTS9V0B/is0h3aKH9V4d1NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701904; c=relaxed/simple;
	bh=4m3DMCCQmxfOOA6Fvpy5MI/pSHBQI92PlwZVm0x7Dhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMMpOMtgBPWK6lQ1z+6W00vfror+eDJPlt8A7ZO8t1zNxy8/HXQhBvbk4ZxUJKRBj2RwKZ02Cs0JXdZryByfUNhlxrPsvXzHcvueTGcKp/+J1iO/9g8h/4bcl/FHCdyaB5ztWU38oikPoNppP5swVk3x0ps+A13smt9aBywioOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FboG0nXN; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FboG0nXN"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c9ff1cso400896185a.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701902; x=1791306702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWhOl0BO9x9ME0YpBU8lqtkNCs3GopTTt9A3OXiCl+k=;
        b=FboG0nXNu0xjDZY4iU2Hw3Xpw+174ArzPflK4cn8XNl+uSrhl8ll6NnAZ+V2RrjIbV
         utZeADFC8ccI7oIthxAXZO3uOrpnzhXITGMsCS1QfYTZK5vDXl/u5tTQN4Jxq6rFEJ//
         k4JqReMy58bXKqQ15PaV4CUcDmiObBfGFJxvNut0gj8fVxwrmdb3F7IO8y7tlITpcjZY
         RjXBsfHy3kHPLlV6SVkAuEzEn8YbKrlX104xXY7m1reFnFdoqPkPw7d9f8SuVhZDd+Z+
         4zO+9uasVVMlKQWrG5EscLZHLvV3CwzF/GKJNVDgYPC22y/mT87eW4aPbRxV7xYHOIO6
         JTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701902; x=1791306702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWhOl0BO9x9ME0YpBU8lqtkNCs3GopTTt9A3OXiCl+k=;
        b=zzRHMXl12c2TIfmEJwOTIKxBfw/ldiRfkAHtLSGcVmxz7PnXtakjG1HhSwhrtg6mNk
         tQWDelN999yz07Qh9K0vS+WyvVmTDCNOEd9k4zkCVv8DvgCRU6zgwPfYOQ5LLZLx8Czy
         +4ONPt+DvsjSQzTWRrPQqsVMKJLlESxc+9XWIdU3KvPfO41NXkM7lu4WaHv3NDomA50B
         E+0YEVmigRyMr7xm/PJbe72yMK/su5nvYxMg0pylThtW7UrBiZQ+e511ahwrXKb3X7AV
         uW0vqgV6NmbUBSF/b2M8ai1KtEoNC3Kr6P7EstPdhHthipqGj1ws6wZEdc0XtHFv/lrV
         xOlQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+JTauiQPbWsOHoqedL1EF+es3HrvagXGuBxI493nPfrfmVf8fulp8MjU2KfrnlnZ/BaI=@vger.kernel.org
X-Gm-Message-State: AFuF++lysDXm3yRGi9c5R0ckE3eKXzh+mkF4+eHBq0gPD/iAjLyThc51
	oyhAvUrvlh03e1FI73mef5FX0GCjfNdBT9+RT7wT7HoeeXBdH2/Q/Ciy6U2qXSBLlL8=
X-Gm-Gg: AYBFou28m88zqzhlfAAItMIxFu9C7Wnc0Ql/tOJcU4zbLtR5Ddv34nh5ScuLJgvNAD8
	yMy1wWwUB/H/6v3CUHxuZujNa5piHkFqsDlBDD43RfPDxSAz8dYea/g65MlrAfDVUTKntLj3l2Y
	1iB5yJAo0e/C4wVwsbaJr+U6WHo0FDx83xk6SX1vwR/I0bKstG/iNCW1jPr/oK4GdRTy+nfxWU5
	PqvhIOEIdTVVqjdnijGqAckmN7XeSxVZUFdOFD09MKsh1UzyL3U1hOvCExkLKf2SQHvao8B+Nm6
	BN+dpe/0raXE1KIng2Zn6G8cqsThsCGIzVVlBjj0K1QT8Kc4KeizQ5wCs+L4X6+Vf78vUFD6mYx
	VCzR4Sx+HNqlrABgRVyQuslCbKK6RDoy+D3T6/ZQ9utD0ZRATowJzf+3q3MvfyYsQDADRtTA0S1
	yIG05Hzz60ObOkL2gxQJKd+qYsf2ucWd9AI/Cm9LJ8sbPuPShlXynTqgUt86ye4EAOJA+iDMeAx
	NQz5cvD0y/lCFI=
X-Received: by 2002:a05:620a:808c:b0:939:6dea:4f1a with SMTP id af79cd13be357-93c9fa9f5dcmr32032585a.48.1790701901901;
        Tue, 29 Sep 2026 10:11:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4bfdd4sm16724185a.23.2026.09.29.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:11:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:22 +0000
Subject: [PATCH v6 05/14] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-5-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=7063;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4m3DMCCQmxfOOA6Fvpy5MI/pSHBQI92PlwZVm0x7Dhg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMMoMYZRQwW06l0AxuXntx6A/gYFpIu/nn0GASboMvYOYbCakPG+Ly6xLjVXIW3ZujZlLuhAq2K
 Nwq7u1wj4GQw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An out-of-line direct trampoline registered with register_ftrace_direct()
is kept alive only by Tasks RCU while a task executes it or is preempted
in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
what stops rmmod freeing it under such a task.  Where Tasks RCU is built
on reader-marked trampolines, such a trampoline must be a Tasks Trace
reader across its call-out like the ftrace and BPF trampolines are, so
document that in register_ftrace_direct().

That still leaves the few instructions before the reader is entered and
after it is left.  For BPF images those are in dynamically allocated
text that rcu_tasks_trampoline_text() already treats as unmarked
trampoline text, but the in-tree samples (and any similar user) place
their trampolines in module .text.  Add a sticky
module::ftrace_direct_tramp flag (under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
its only consumer), set by every register/modify path when the direct
address is module text, and have rcu_tasks_trampoline_text() treat a task
interrupted anywhere in such a module as a potential holdout.  Other
modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 18 +++++++++++++++---
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..82ca4f774725 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	/*
+	 * An ftrace direct-call trampoline lives in this module's text; see
+	 * rcu_tasks_trampoline_text().  Sticky once set.
+	 */
+	bool ftrace_direct_tramp;
+#endif
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3f127e47ffc2..d3bd06ad362b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -997,6 +997,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
  *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the text of a module that hosts an out-of-line ftrace direct-call
+ *    trampoline (see ftrace_direct_mark_module());
  *  - the bytes after a kprobe that a pending jump optimization is about to
  *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
@@ -1005,12 +1007,22 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  */
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
+	bool ret = true;
+
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_trampoline_text(ip) ||
 		       kprobe_in_optimized_region(ip);
-	if (is_module_text_address(ip))
-		return kprobe_in_optimized_region(ip);
-	return true;
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+		if (mod)
+			ret = READ_ONCE(mod->ftrace_direct_tramp) ||
+			      kprobe_in_optimized_region(ip);
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..f69f71591358 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6076,6 +6076,29 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 }
 
+/*
+ * A direct trampoline may live in module text rather than in dynamically
+ * allocated text that rcu_tasks_trampoline_text() recognises on its own (see
+ * samples/ftrace/ftrace-direct*.c).  The trampoline itself must be a Tasks
+ * Trace reader across its call-out (see register_ftrace_direct()); marking the
+ * owning module here covers the instructions before it enters that reader and
+ * after it leaves it, where a task interrupted in the module's text must not be
+ * counted as Tasks-RCU quiescent, so that ftrace_shutdown()'s
+ * synchronize_rcu_tasks() still keeps the module text from being freed under
+ * it.
+ */
+static void ftrace_direct_mark_module(unsigned long addr)
+{
+#if defined(CONFIG_MODULES) && defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
+	struct module *mod;
+
+	guard(rcu)();
+	mod = __module_text_address(addr);
+	if (mod)
+		WRITE_ONCE(mod->ftrace_direct_tramp, true);
+#endif
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -6090,6 +6113,17 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
  * and save the parameters of the function being traced, and restore them
  * (or inject new ones if needed), before returning.
  *
+ * Nothing but Tasks RCU keeps the trampoline at @addr alive while a task is
+ * executing it or is preempted in something it called.  On architectures that
+ * select HAVE_RCU_TRAMPOLINE_READERS, Tasks RCU only waits for such a task if
+ * it is a Tasks Trace RCU reader, so the trampoline must enter one
+ * (rcu_read_lock_trace() or an assembly equivalent) before calling out and
+ * leave it before returning, just as that option requires of the in-kernel
+ * ftrace and BPF trampolines.  The few instructions before and after are
+ * covered by the irq-exit check: automatically for trampolines outside kernel
+ * and module text (e.g. BPF images), and via ftrace_direct_mark_module() for
+ * trampolines in module text.
+ *
  * Returns:
  *  0 on success
  *  -EINVAL  - The @ops object was already registered with this call or
@@ -6169,6 +6203,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
+	ftrace_direct_mark_module(addr);
 
 	err = register_ftrace_function_nolock(ops);
 	if (err)
@@ -6237,6 +6272,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	ftrace_direct_mark_module(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
@@ -6419,6 +6456,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			if (__ftrace_lookup_ip(direct_functions, entry->ip))
 				goto out_unlock;
+			ftrace_direct_mark_module(entry->direct);
 		}
 	}
 
@@ -6702,6 +6740,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 			tmp = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!tmp)
 				continue;
+			ftrace_direct_mark_module(entry->direct);
 			tmp->direct = entry->direct;
 		}
 	}

-- 
2.55.0

