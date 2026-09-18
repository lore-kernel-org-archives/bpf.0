Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EC4A5EB9
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743000; cv=none; b=FWbqNmSwdTY7r9ddsREbjdhEDqd033HyZ/UzoJTaKZ2u+CuXtqYUOndjUqRuc/iuWAC7CZH8aTxynWM9s0Llk+Yh6elwGNtCgQgU3u8DVOTB60FH9E1Vj4tpXkyTRBH5rZNkNW9mQ/12PLiPMdICNnSBIT0G6jWT5Rx9hOg3TCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743000; c=relaxed/simple;
	bh=EBgIXBiL5Z/I6XbFK2Nq9sAUVoT2dZ9k9OxjIjZChGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1QweWE7P2bvSlJV7bdXKmGZE+YC5QDL8KBs2yKb5jFWQLDEYHgU+zP6PkmteKhvsNA39B/tqis9gGZUm8Q6ofPsfn1kCXS0jc3fWjwDUOMqe3DWA1g63se23GVHtIigH272aV45Z2IIdKkPXSpD0xuIMNre9OVcdG8y/fNcZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=VuAxgCJO; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="VuAxgCJO"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso7371266d6.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742994; x=1790347794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPH1+eiN4EhHtK6rDK3I01/qZvQ6oNbinGntBhruq3Q=;
        b=VuAxgCJO4AOi57O9EmEjCag8LTCwQIrr2dTm3ncj0C9Z8YzZTSsgu1jBMOD2zI56Nr
         qDL34SrS9545y0e2gvRoG1ygD0XjuuJdSprtTey2Zkw1ECYmztK3WGx30xhYc0lYlFcb
         9xkg1fYZFaQsdKuop/wcdIGNA0JvRo2/gH2DwyIkZqHMx7WTCjTV1N/csNnVm+9U5Lae
         gGWXUoxnaczSiSrs2ec+NE6JV2ZpkCNdtPZ+IZoAaRH6yJq9rajYguhFb70mcGZzh1qy
         5ym7pgey4c1jNmybuhsNE8mNhk9p3E5/ozCVFuIU9NWbCzuzajWO823Iu6ykQywJEj0z
         sxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742994; x=1790347794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPH1+eiN4EhHtK6rDK3I01/qZvQ6oNbinGntBhruq3Q=;
        b=IaiHp0T2Jao4thnrRp+GN7UCtUAPRgRf87qx6AdNYwxt5vB0KywuH4XIdFnxq77TfP
         5fuMMZQDAHYCybxXuBgud/ky/9XqqRJMNmX0cQg1/qJykX6Z2QjAbiY2zfLFofZeb8RT
         Hgg8hcz0S0voeiS5T4kwJDcwft4Cfwcv+roRCCVh7AOQKAb2XihsuAOA5JEWzsAgGI25
         k1QSKfl+y5nfZYPRVOnTfPjDRWgWHhuLdWTEZDGDvFA8z+6pxly6HeZWpCVBzB1EAvKX
         l9N3sTC0AGeGDXmbcvtOj9X3J7JC9FqEBqEqgkXlhpU8nKju90kCheXh4Ys+N8bWXmPY
         Txpg==
X-Forwarded-Encrypted: i=1; AKwUvBxE4kk+9FaESBunpKdxexipKByhTrQhGPCUwQvsbwxyWwhJIuMWnVheyL94bv9FEOF/OzA=@vger.kernel.org
X-Gm-Message-State: AFuF++lWggaFbJrDnFqWRbGS9YPU01QOvMnuE7FuDQmYtGRGau3+rzKm
	uHeQP8rpxJ5IWvPXRufiTflapMwAiu4SwjJSDovmc5Iiqwveza7Ema/XrWLdHw1mbdU=
X-Gm-Gg: AYBFou3vUHAhwMEn5Sl64G9dk7YhloA6xecF6qoPDfuAaY0qFFeKWC0YIuM48wvepM2
	z64mgB9kt33LK9TW9XEOFJWmnxSxwYxkHBxvVDOp0JKKKg1FrRjFaXU+kbOFPltC0CG+0+03CC9
	QmGhLp/aKAvYdPqYhisE0CYnfylCdOeBpwEy0FjjcAoTpCYL/BfM0GCqqJEbXDfqpQYY1zkVh4U
	uu2Z+gGLROYlSOiwW9VkfHUFEUwNkIOTiYUX2Pn0eTLj3bSw3RXuVdeGLYzeuyLQRJZdMtofcgN
	k45TfUjWkW1r8XPJCU93eCCwtHMzpt0Y6fK08SJz9XJgC/e91CnbsAOFN0rA0RHiHnc3+vzXfl/
	YG+coKytdeyIlo6qFh4Hn2dPx1BJJSCb/hZhAIkAKbYaL1TwlkDclZcEGfBHSJxB5ar35FBIQLR
	dLB7WVokQemFMpfQn5Iug077lKL5a5zV3CLLupT6U0z3p8fAUajxRW5CyVKEqWuhMBE2HTxUkAY
	vfkT7QQ7cJquvCFB0bjktss0tiv86kDXa7a4KHweiMiC0UP0h86fZVSAatEx/JIxbA=
X-Received: by 2002:a05:6214:5d02:b0:910:705a:2c5e with SMTP id 6a1803df08f44-91254bcf2c3mr42299806d6.18.1789742993553;
        Fri, 18 Sep 2026 07:49:53 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125800e368sm14412066d6.8.2026.09.18.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:24 +0000
Subject: [PATCH RFC v4 05/13] x86/ftrace: Take a Tasks Trace reader around
 ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-5-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=9964;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EBgIXBiL5Z/I6XbFK2Nq9sAUVoT2dZ9k9OxjIjZChGA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE5RsSfIxHeGJCFPi3zOG/JnoKeCeLOBzXS0wrZafOedFHnVb+Jk6Kqa2Y7pWw6LloZYUQvCiGv
 7bLPKG2JGuwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For HAVE_RCU_TRAMPOLINE_READERS the ftrace trampolines must be Tasks
Trace RCU readers while they call out, since that -- and not the absence
of a voluntary context switch -- is what synchronize_rcu_tasks() will
wait for before ftrace_shutdown() frees a dynamic trampoline or its ops.

Open-code rcu_read_lock_trace() and rcu_read_unlock_trace() in
ftrace_caller and ftrace_regs_caller: bump current->trc_reader_nesting
and, for the outermost reader, do the SRCU-fast per-CPU increment on
rcu_tasks_trace_srcu_struct and stash the counter pointer in
current->trc_reader_scp, exactly as the C inlines do (including the
smp_mb() when CONFIG_TASKS_TRACE_RCU_NO_MB is not set).  The lock sits
before the function_trace_op load, because between that load and the
call the ops pointer is protected only by Tasks RCU, and the unlock
after the call returns.  The sequences are inside the region that
create_trampoline() copies for per-ops trampolines; their %rip-relative
references are fixed up by text_poke_apply_relocation() like
CALL_DEPTH_ACCOUNT's.  %rax and %rcx are dead at both points.

Two pieces of core text still run outside that reader while holding
the address of a Tasks-RCU-protected trampoline they are about to
enter: the static stubs themselves, whose direct-call tails keep a BPF
trampoline address on the stack until the final RET, and, under
CONFIG_MITIGATION_RETHUNK, the return thunk that RET expands to.  Add an
ftrace_static_tramp_end marker after ftrace_stub_direct_tramp and linker
symbols around .text..__x86.return_thunk and .text..__x86.rethunk_safe,
and provide arch_rcu_tasks_trampoline_text() covering
[ftrace_caller, ftrace_static_tramp_end) and both thunk ranges so the
irq-exit check treats a task interrupted there as a holdout.

All of this is built only under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
which x86 does not enable until a later patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/asm-offsets.c |  8 +++++
 arch/x86/kernel/ftrace.c      | 43 +++++++++++++++++++++++++++
 arch/x86/kernel/ftrace_64.S   | 69 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S |  4 +++
 4 files changed, 124 insertions(+)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 081816888f7a..876c3986419a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 #include <linux/crypto.h>
 #include <crypto/aria.h>
 #include <linux/sched.h>
+#include <linux/srcu.h>
 #include <linux/stddef.h>
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
@@ -46,6 +47,13 @@ static void __used common(void)
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TASK_stack_canary, task_struct, stack_canary);
 #endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	OFFSET(TASK_trc_reader_nesting, task_struct, trc_reader_nesting);
+	OFFSET(TASK_trc_reader_scp, task_struct, trc_reader_scp);
+	OFFSET(SRCU_srcu_ctrp, srcu_struct, srcu_ctrp);
+	OFFSET(SRCU_CTR_srcu_locks, srcu_ctr, srcu_locks);
+	OFFSET(SRCU_CTR_srcu_unlocks, srcu_ctr, srcu_unlocks);
+#endif
 
 	BLANK();
 	OFFSET(pbe_address, pbe, address);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 17d6edfcb7e0..9babaed483eb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -275,6 +275,49 @@ static inline void tramp_free(void *tramp)
 	execmem_free(tramp);
 }
 
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+extern void ftrace_static_tramp_end(void);
+extern char __return_thunk_start[], __return_thunk_end[];
+extern char __rethunk_safe_start[], __rethunk_safe_end[];
+
+/*
+ * The SRCU-fast increments in TRACE_RCU_READ_LOCK/UNLOCK (ftrace_64.S) are the
+ * this_cpu_inc() form.
+ */
+static_assert(!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+
+/*
+ * See rcu_tasks_trampoline_text().  Some core kernel text behaves like a
+ * trampoline for Tasks RCU purposes because a task executing there outside
+ * any Tasks Trace reader may still be about to enter a Tasks-RCU-protected
+ * trampoline whose address it already holds:
+ *
+ *  - the static ftrace_caller / ftrace_regs_caller / ftrace_stub_direct_tramp
+ *    stubs, which carry a direct-call target on the stack until their final
+ *    RET, and
+ *  - the return thunks that RET expands to under CONFIG_MITIGATION_RETHUNK,
+ *    which run after leaving the stubs above and before landing in that
+ *    target.
+ */
+bool arch_rcu_tasks_trampoline_text(unsigned long ip)
+{
+	if (ip >= (unsigned long)ftrace_caller &&
+	    ip <  (unsigned long)ftrace_static_tramp_end)
+		return true;
+#ifdef CONFIG_MITIGATION_RETPOLINE
+	if (ip >= (unsigned long)__return_thunk_start &&
+	    ip <  (unsigned long)__return_thunk_end)
+		return true;
+#endif
+#ifdef CONFIG_MITIGATION_SRSO
+	if (ip >= (unsigned long)__rethunk_safe_start &&
+	    ip <  (unsigned long)__rethunk_safe_end)
+		return true;
+#endif
+	return false;
+}
+#endif /* CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
+
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
 extern void ftrace_caller_end(void);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 62c1c93aa1c6..5d8cb3861978 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -7,6 +7,7 @@
 #include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/percpu.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
@@ -145,6 +146,53 @@ SYM_FUNC_END(ftrace_stub_graph)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace(), see
+ * include/linux/rcupdate_trace.h and CONFIG_HAVE_RCU_TRAMPOLINE_READERS: the
+ * trampoline and the ftrace_ops it is about to load are kept alive by Tasks
+ * RCU only while we are inside this reader, so the lock must precede the
+ * function_trace_op load and the unlock must follow the call.  These live
+ * inside the region copied into dynamic trampolines; the %rip-relative
+ * references are fixed up by text_poke_apply_relocation() in
+ * create_trampoline().  Clobbers %rax, %rcx and flags.
+ */
+.macro TRACE_RCU_READ_LOCK
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	movq	PER_CPU_VAR(current_task), %rcx
+	movl	TASK_trc_reader_nesting(%rcx), %eax
+	incl	TASK_trc_reader_nesting(%rcx)
+	testl	%eax, %eax
+	jnz	.Ltrl_nested_\@
+	movq	rcu_tasks_trace_srcu_struct+SRCU_srcu_ctrp(%rip), %rax
+	incq	%gs:SRCU_CTR_srcu_locks(%rax)
+	movq	%rax, TASK_trc_reader_scp(%rcx)
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	lock addl $0, -4(%rsp)		/* smp_mb() */
+#endif
+.Ltrl_nested_\@:
+#endif
+.endm
+
+.macro TRACE_RCU_READ_UNLOCK
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	movq	PER_CPU_VAR(current_task), %rcx
+	movl	TASK_trc_reader_nesting(%rcx), %eax
+	subl	$1, %eax
+	jnz	.Ltru_nested_\@
+	/* Outermost: pick up scp before an interrupt can see nesting == 0. */
+	movq	TASK_trc_reader_scp(%rcx), %rax
+	movl	$0, TASK_trc_reader_nesting(%rcx)
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	lock addl $0, -4(%rsp)		/* smp_mb() */
+#endif
+	incq	%gs:SRCU_CTR_srcu_unlocks(%rax)
+	jmp	.Ltru_done_\@
+.Ltru_nested_\@:
+	movl	%eax, TASK_trc_reader_nesting(%rcx)
+.Ltru_done_\@:
+#endif
+.endm
+
 SYM_FUNC_START(__fentry__)
 	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
@@ -163,6 +211,8 @@ SYM_FUNC_START(ftrace_caller)
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	TRACE_RCU_READ_LOCK
+
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -181,6 +231,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	TRACE_RCU_READ_UNLOCK
+
 	/* Handlers can change the RIP */
 	movq RIP(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -209,6 +261,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 
 	CALL_DEPTH_ACCOUNT
 
+	TRACE_RCU_READ_LOCK
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -246,6 +300,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	TRACE_RCU_READ_UNLOCK
+
 	/* Copy flags back to SS, to restore them */
 	movq EFLAGS(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -328,6 +384,19 @@ SYM_FUNC_START(ftrace_stub_direct_tramp)
 	RET
 SYM_FUNC_END(ftrace_stub_direct_tramp)
 
+/*
+ * [ftrace_caller, ftrace_static_tramp_end) is treated as trampoline text by
+ * rcu_tasks_trampoline_text(): outside TRACE_RCU_READ_LOCK/UNLOCK the stubs
+ * may still hold a direct-call trampoline address (ORIG_RAX / the return
+ * address they RET to) that only Tasks RCU keeps alive.  With return thunks
+ * the RET itself runs elsewhere; arch_rcu_tasks_trampoline_text() covers
+ * those too.
+ */
+SYM_CODE_START_NOALIGN(ftrace_static_tramp_end)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+SYM_CODE_END(ftrace_static_tramp_end)
+
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2438b89a4620..e546283dc267 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -151,7 +151,9 @@ SECTIONS
 		 * definition.
 		 */
 		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		__rethunk_safe_start = .;
 		*(.text..__x86.rethunk_safe)
+		__rethunk_safe_end = .;
 #endif
 		ALIGN_ENTRY_TEXT_END
 
@@ -162,7 +164,9 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_MITIGATION_RETPOLINE
 		*(.text..__x86.indirect_thunk)
+		__return_thunk_start = .;
 		*(.text..__x86.return_thunk)
+		__return_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 		*(.gnu.warning)

-- 
2.55.0

