Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29638AC8C
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044076; cv=none; b=KIwxB9NjY4lpohQR0Zep5+wwL09DobyZ0QQYI0cRt/jYWTM5n8bKC6j17P/bv6nsBVhzCk6VEbR0N/OvmXrViuQiEl0GaYXR5/YspIx756GvTzw2qYC9uRPk7fk5oAdf7aJhbxqpMzUP0ez1QrjH+xkvdtUZBnsk7Ki5EQFB6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044076; c=relaxed/simple;
	bh=WxuURWfyPfVrbwoJYzsme+dJrO0g2fOexfelnDzg3io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Afj0ShdZhEYmfnyRDVxIiDKGroCwud9rkeNSpFk93muWf2wGZ+/2lFGkf7FVUXDUTnYhAF3t8oIV3Il8tI3zpZC35wzWT4nIvcmDeyu5AlctR77ZM9a7prnpxhS8lshBD9PCPGHHD3+e+T/r5ZRd3EtmEnbiRITyCf59ptMJ8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I6lHTrEY; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I6lHTrEY"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so412727485a.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044073; x=1790648873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjEABplA81VfGcXS6Z1Q3Y7Xt5Unb50ofxErtTl6HPY=;
        b=I6lHTrEYx3XIEou9LiLDPR92sFcFypxuNY4FR11g5RVmVFmEJXnA2bKGJ3S1IoKiR6
         rmOgW7sNNl4wqFHPc0yQDeKQtMF9U7+ywjV3lOzf7T1gpR4Y4laOsQ0egVCyGyXuLV1P
         LqQoGUW05qT6lN6UTmJKjG/T24ScCPmKBqunbRX4ZWESiyp0gUaZCBmxibLwdEFZbXvq
         8DlU3zinQ9xOlM012tgY9qR1n46KQ0bsGJGiRcI3YpAF6gQoSQgR8IMJnKcBWk+qLf7O
         HYxNr7MbyyPfHCjuvTZHA+ns8o/vjiMcb2e6ZSlRyP7BADorS/YI+lD5hQ/KuFpXUB+J
         5IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044073; x=1790648873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjEABplA81VfGcXS6Z1Q3Y7Xt5Unb50ofxErtTl6HPY=;
        b=ojqH8K+Y50nWsCFJEqlKNNi8I1H19nvV2Wtl99BEnJA3Echp/STwmVjdwPmcezwWpn
         48UHcMZaVQUNH21SYtEPdORucv7C1ci0vqt2B8TSeohFALQgazg2SMbNJi9BlXi+mRff
         NVdJ6JUXAM0wLoNGmN/Y8218OG28zaMQ8RD4/kqMvg65ZeMCEPQAtIiCNxL8/KbZPYRA
         woqHop2Swk+XZSQyeWJ05wFapTuLk3ehTMU7USq1119P1rvAsEbpSeDAaekjBgfamGzX
         jcuqo6EOttqZmZWOJpIWzyR3EwZWJWx7lKrNpvwkJNketn0mfMlz7J3iFdWZsGMYxzGG
         H8oA==
X-Forwarded-Encrypted: i=1; AKwUvBx9k7UbwaQbwcxbyCW+vLT3Nx04viQXDk9IsH+4T64URAvCSd6thWD3DZNEiwtXc+B8f8o=@vger.kernel.org
X-Gm-Message-State: AFuF++n0QGRbBYfcUmQpgRKULILCe4+Nis8418hXbpVfcxzReWe/SsiW
	ZQOH/RhvL2hcSdP6P22iAeEuBtaP/mu1C1UzKjCr8G8chcHRQwLwajzIUYGddm2ohkc=
X-Gm-Gg: AYBFou3OqvH07IlGZWttCOD31VY72BBsZ9DMXDtTN1WRRwbCGvkozeALycwWSs6KSTf
	8pacIrmMmgVtfadGwqSMvUZFRZAI1CtyAflr1rxl8gJd7cT2R5PqmDj7GEEC2iDNJdfxMpZRuPA
	EVmCr5JO4BGooGcym+YfWX34gETdgGoBcOXhgvf2lax0IeMrZFkXU3NJWCB0+zfe5hTlo4btn23
	2khBFZz38D9tA1agNWMHriz4SQnQdwzI58/Coxi8zTNI0itzpx9yHJa3hWZ1KNxu28e6ZClp/GB
	cije2Hk5XzMe1LBD656v8ccZbvBMH3o8be0Efl8tjoFU6AXIOtjkJJToU6CO0X5MTnFjB0zJWnp
	7L3Ja3HH8UEhvLETuDJ0EpZSU7GzVQ85MPfnQmJsgemAheDg3lHxCmaPYCGg6YeMJHej5/NPugM
	TEdH3pszFSAzSnDwZ6RzoOFLXYznHZicu5g8TQjhLhE6j8Ou2A5SlG3UsHTBRHEoOMWCPxuv+pC
	24KK7yJsvui740=
X-Received: by 2002:a05:620a:2949:b0:93b:d7a0:d9dd with SMTP id af79cd13be357-93c19a67345mr151109685a.55.1790044073015;
        Mon, 21 Sep 2026 19:27:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d1e9c78sm21071585a.32.2026.09.21.19.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:27:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:23 +0000
Subject: [PATCH v5 04/13] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-4-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=7065;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WxuURWfyPfVrbwoJYzsme+dJrO0g2fOexfelnDzg3io=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIG8cGFVLUxRckCJD2FMFcjxlH7HHUuPFKzc+YD5qvFJCI6wuoTYH6RLHGPqY8+XII71ZLcy6t+
 Vmn6AcyiciAU=
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
index eb1388dd8a61..42ea6e0e61cb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1006,6 +1006,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
  *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the text of a module that hosts an out-of-line ftrace direct-call
+ *    trampoline (see ftrace_direct_mark_module());
  *  - the bytes after a kprobe that a pending jump optimization is about to
  *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
@@ -1014,12 +1016,22 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
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

