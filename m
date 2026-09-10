Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5ED58F09B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066275; cv=none; b=SRC199cwwpJtCfxXQL+FAR0yf+ak0q7yhjJKY0X0Aw7sS4ruXAIQZ7devdPVEe1zDGL68ua9KR9FOJbzFq4Vc5WVCkndyRfTosP8ly++U/wVvZqYPgyQNpCU6zrOFaJxpj3j6FfS0GGp4DJucoCeCSmMQjQytH8fcjxVFk2x7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066275; c=relaxed/simple;
	bh=l7aVvY+ftiwQa148loQ0+qhD4xLi8gidpPUfzn723bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCGZu01mnEz/H3AbmJI9bED3TVPcGjP2kw7SWGZsviOkhnQ6XZM8rAFJ4srMjhBDxhlUoFGG0H+nTuUul3ZVEV6it7OHm3e46IVFqeyPy4yO+NbFavaY427K4xK/1IwmDYQZesuOYPZ+ez6avjAcXmkspDbTSf9VuoEoHMMwKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=A4KoQjdO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="A4KoQjdO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9399a1c21c1so461054085a.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066263; x=1789671063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLCJ034DJzI4gEh3LNSHB0+4siN8J5WsqqEdRoq/eTA=;
        b=A4KoQjdOCFdFFb8IOo5SmFCr7LzNwEkphWpFRuFro8Pbe/m6SvS7KY0sCqikRnDzX5
         MdXtfjgN6YIQ6yQG3I+U0e/Icp1OcxHuK18mZ4VrltOBJGYmKRbVg9kzCree8MFmt8X4
         F4llz9che9+jJbDN6npzYKJnIJygAkXwmgKGTLmgPgbIhrd/UCZt6o3agBwEJdEv2pME
         jtfTl4m1izBbrToZzxXjYJXc6R+w9GSKDoDjD3SL0pz998Ol1mE0upIBtVWr70ivmsEu
         Y+p9/Tndea/sAMUXwc3whpmHBPihDlAeA61olFAx39uK2innM2692RDkSfgMEEIL5F56
         zvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066263; x=1789671063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLCJ034DJzI4gEh3LNSHB0+4siN8J5WsqqEdRoq/eTA=;
        b=C33JpkehRk8ubgoptTt0DC3h6pt67F2VI7Irv8dX3AtF/SAu8rvmEzsMi0N69y4BUZ
         f2BOaVpMMZUDTXmX1axeUoLH826YBluvUwm8lGhfbIrs+BYynh2mBaPIb7cjPG5Ne66E
         3/+kuxIMriHfZ2Hpp5uTiUPm5qv7xa2tWDn0Jp2BTVo0RYOIruQ0YHZM/9UC/+5jYdWn
         V36ResXvjzmicPs71ugYJba5QqT06Ud2nZxiAulxn22bObouqeROJzwlez4Irsllbc8Q
         2qkvaZHSAtHkbqR7KD3Iybswb1QMjM3Y2pDM0vFJ5llGR/YkK9uofVvFimJ1KncIx8iN
         kdoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDQGMth9rxDn26aBC4/AaD6cVEQ/PqlRQ1sA02w91LmIiIXVAJsNhP5N8l6UZamL+Hc7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kjX3AHJ6kLytSASjp/NECLrFffK8T9upyUbV8vSMWccb56M4gv
	38Hdknufuv3DP5K3B9IUVG888NvCRaxkAnA+xS315QKOgbNuIsdHF3dk7BUQVntxc6U=
X-Gm-Gg: AYBFou3RJsHYl52AzFCk5RbDM3S1aEd+KC8/xgMzqiIqaawgnpZWpt1W/x39s2NsdqG
	Z5bDQWvdePyuivqUNAGZ2NZpMHL4NBE8eg+6PBgJ0hKU88WSEQyiT/M/8Kg3aUl97swnRvdDZNZ
	PXlGV5832mwY7kXpSuCDvIwBLaV7UGGXZxAhIFXkhMxJT6hf4o3za9B7+G6yLXYH4Fgsx4YzsSp
	jBJ23J7BOIdyfkLQDDWYdTXR+wi2b53GLy+U7DoDgOiceAoloLVa82LZGKbQ+6fsoZMenN8rbhb
	Ri2yB4zEeHHGDz+yQOu7WUEZLfRHUKFj/Gj4J3EavNtS4BfqGg9n3PuG14ZjNa5mvzm7dEMXb2l
	mBaGQG/Wwg+4KFnU3vU6d+LH+a9r8JsJ0AmyqpKW1+JU31xKZEBEmBGoIR4/Do9rVdXVLLgHkkC
	7g9XZVo3Ar1AZS/agOenogmSarllqCFPnMJ71nP+WvQVP88hv7kAcS1wpZMQkpTQT9T59jZDfG0
	9VBaC161UqpxkSIws4N5KOdbbMuCqArFC4wftP+gzeqRyIjapCvfTDsSJtrqmu5hEM=
X-Received: by 2002:a05:620a:6191:b0:939:a6e4:2267 with SMTP id af79cd13be357-939ea2bff00mr14491685a.50.1789066258414;
        Thu, 10 Sep 2026 11:50:58 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e807eba7sm47389685a.29.2026.09.10.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:27 +0000
Subject: [PATCH RFC 04/13] kprobes: Let Tasks RCU recognise tasks preempted
 in an optprobe jump window
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-4-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
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
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

kprobe_optimizer() is the one synchronize_rcu_tasks() user that is not
about trampoline text: it waits for tasks that were preempted on an
instruction boundary inside the bytes it is about to overwrite with the
optimized jump, so that none of them resumes into the middle of the new
instruction.  Such a task sits in ordinary kernel or module text with
rcu_tramp_nesting == 0, and can only have got there via an irq-exit
preemption.

Add kprobe_in_optimized_region(), a lockless and conservative form of
get_optimized_kprobe() that reports whether any registered kprobe lies
within MAX_OPTIMIZED_LENGTH before the given address regardless of its
optimization state, and have rcu_tasks_ip_in_trampoline() consult it so
that a task interrupted there keeps holding off the Tasks RCU grace
period once preemption becomes a quiescent state.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/kprobes.h  |  8 +++++++-
 include/linux/rcupdate.h |  4 +++-
 kernel/kprobes.c         | 24 ++++++++++++++++++++++++
 kernel/rcu/tasks.h       |  6 ++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0a408e36ea15..e9afbbb1b061 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -200,7 +200,9 @@ bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip);
  * cannot be preempted synchronously, only from an interrupt, so the irq-exit
  * preemption path covers it by checking regs->ip with
  * rcu_tasks_ip_in_trampoline() and holding the count elevated across
- * preempt_schedule_irq() when it matches.
+ * preempt_schedule_irq() when it matches.  The same check covers the one
+ * non-trampoline user, kprobe jump optimization, which waits for tasks
+ * preempted inside the instruction bytes it is about to overwrite.
  *
  * Only current writes the count and only current (or an interrupt on the same
  * CPU) reads it, so plain accesses suffice.
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e..76f146edb0e5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -511,6 +511,30 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
+/**
+ * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optimized
+ *	kprobe replaces?
+ * @addr: kernel text address, typically an interrupted instruction pointer
+ *
+ * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for tasks that
+ * were preempted on an instruction boundary inside the region about to be
+ * overwritten by the optimized jump; such a task must not report a Tasks RCU
+ * quiescent state when it is preempted (see rcu_tasks_ip_in_trampoline()).
+ * This is the lockless, conservative form of get_optimized_kprobe(): it does
+ * not care whether the kprobe found is, or ever will be, optimized.  May be
+ * called from any context with preemption disabled.
+ */
+bool kprobe_in_optimized_region(unsigned long addr)
+{
+	int i;
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
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a801ec4a951b..a55dc2a20fb7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1114,6 +1114,9 @@ bool __weak arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
  *    deliberately does not consult is_ftrace_trampoline() and friends: text
  *    being torn down may already be unregistered there while a task still
  *    stands on it;
+ *  - inside the bytes following a registered kprobe that jump optimization
+ *    may overwrite, which kprobe_optimizer() protects with
+ *    synchronize_rcu_tasks();
  *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline().
  *
  * A false positive only defers the quiescent state to the task's next
@@ -1121,6 +1124,9 @@ bool __weak arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
  */
 bool rcu_tasks_ip_in_trampoline(unsigned long ip)
 {
+	if (kprobe_in_optimized_region(ip))
+		return true;
+
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_ip_in_trampoline(ip);
 	return !is_module_text_address(ip);

-- 
2.55.0

