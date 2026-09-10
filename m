Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5356510A
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066256; cv=none; b=jmvC2IykCec4I2s/n7fgO5K0DGFXFcn4W/xNcVSouc98Xst/q5McRALyr70hYg62ZsZzZEDCZgZ+fCDIA7GiA8CLDQGHhN3wpk56fG2bReZaWs0SQMsiqDn+Br05VfBVYJ7AsqKl+uQYQ48ySgw8g6281fgyVmDMNKSmvnfaTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066256; c=relaxed/simple;
	bh=5rKSSYdl2NLVDmAkfdBaLImmLnTw/j3b/n1VGeW4msc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vA+MCTlwzrVMG4uVcU3H6Jp8i/0gY4fiPKoJvoFiGptclDXWqEZkdCDe88hp9EX1/5k7afpeWWRqPxsUAxvYFUyzBmqepNbbZ0zNVmYds4m+oZ3WL+wb+WRbv0ObzhdGeMWnUJKtoaT64F5qqHVUxA6006y23ZjKeO6qtVvRSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jz9Gm+cg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jz9Gm+cg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9399daa3c8eso222685a.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066249; x=1789671049; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=04sGP5fC6+EWQ5zQqoL4aDa3rNDPdOaXISOWt+zm6Kw=;
        b=jz9Gm+cgGUs1xQF2/GuzRkLxBAc8+mpQ1Tc1X4EWpBhkou2Pak3LzXFYAG0MGdvUs+
         juIKQIdd0GMSDi6czQ0RgJjM0w5aBjyUGYhgfMBOSOiLX7g4dB13PU2ZtY8gMBohqLwP
         oG4mOOZwciiL/oltcklCn3c4JyqBBMQsiZapKQzaPB2A9JEEUm2/oTQPPBWAKltm0KiO
         S5zSvn4g7fDJxB/9RH4LYft1/nZGp0TNpd0qPPwfGcaMYbLU2Xt7yg5r0C1gU5byDYmk
         nwdyWzq0cqDyAHfmvLDknLHsoAbVK6iuG0x+jLZAF1EQOsz/9uECot6OgEkLnSadHFUE
         2bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066249; x=1789671049;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=04sGP5fC6+EWQ5zQqoL4aDa3rNDPdOaXISOWt+zm6Kw=;
        b=hfXv1wdPgM1rzU/blVerxvsdCwtVWGGhQRI+wg8WfA7dON3f69OoUe/rLeivPs44h3
         87PVO/+Wlb5tAMSd9pmPMKNlwA4mzNIoHTUAxjYBY6rWEPWkFs53upGHU7/5cEiHuTv+
         AfGTXz093AjGy4HiYWLFXkwZs7UQNXtdVkZnuPpAzevH5376y9l1CsLFe3QRPRrr1QCj
         265EJuyrBCBfm1ulSFpCSSaHmMoYZc6De1cnnK23J9BlyjqTlRLmoi67H0CrDJqbHkoE
         3cMPi7agmRlopFpU2YgA/YNRNt5sO4X9Lxw72K+D/d5AvMgW5A6dOibDlWlWu5bHQW9i
         iw1w==
X-Forwarded-Encrypted: i=1; AKwUvBx94Ov/p8CJXfRzeC/JRRhXyhw25v1Rp9ICjpLx0s0evf2vnAVQ75U8exBjIOjTrKK03T8=@vger.kernel.org
X-Gm-Message-State: AFuF++lTjJIb1rBKfOVBrIHMLjpBYkLAgRiWsi55tTisAXlKyrKlmmSE
	gilG704mGnoDMXebnMS6k/kAsYugvGkG0QVOH6AuDE3CgT/iT3PLb4MoKfiNucC1AuU=
X-Gm-Gg: AYBFou1QQ9SeaqfbNWKvn59mQR0UBBYSJVnzXPUk0T9GwgaxrBbg5Fp0SMfEBZEJUrT
	mJl1HGwT241Ihx0vlL52xja4wy40pkumoCsGli3khIBby4DxSIdll/38/IxmJNtUL6ndILpkuk8
	vV6a3mGtCL4A2EHORF27LfqhoR09tTu/6pTJw9b/7LAgFswx/lPUHAitThHiJYd/tEBeWL+vPhp
	1j8q9OomWC5Xyn/mSCUOoBZuIkyHUOAYlfHUvcaNw50HjzKIG3zC96YZSBWzRWMbWQEQFaGSC0h
	+ou4sbwjC/PPkQJwtR2ZUjYVe6mEbbshX1WzInFfcmVQyc9WB9moL0hhBzlAVF9DH8gb2wmbdxY
	X9q2vMTqsOFP4/kqkSsDrCVDwuqo8D+EOledOZpqoK8VaAXKMW2bJLavksaGFO1V6TNziZHHn0F
	KI9+99uDJ0/mvhzgJ1pcEPJkhRaV8ojdFXTvg+MVIcar64SLI/H6mKuYuC9eAndFI7gSabnW0iD
	Jzo7QbblizYxYHoqH2iHg1uKaFCPPV26Qy6YTwxsB2Y78XDMciSnjWG
X-Received: by 2002:a05:620a:454a:b0:939:8e05:27e0 with SMTP id af79cd13be357-939ea013111mr26869085a.1.1789066249021;
        Thu, 10 Sep 2026 11:50:49 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e86b7424sm40754785a.32.2026.09.10.11.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 00/13] rcu-tasks: let preemption outside trampolines be
 a quiescent state
Date: Thu, 10 Sep 2026 18:50:23 +0000
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPH7omoC/22Nyw7CIBBFf6WZtZPShtbo1sQPcGtcAA4WH4gMN
 SZN/12oW5f33NcETNERw7aaINLbsXv6LJpVBWZQ/kLozllDK9pebBqBWmI0IybFN8YQiR4h4Yt
 RisZa2cm+M2vI7WxZ91mWj3DY7+D0gzzqK5lUNktMKybUUXkzFHQPtZb1Av+9wDx/AYKBPpKyA
 AAA
X-Change-ID: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7
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

Tasks RCU only treats a voluntary context switch, usermode or idle as a
quiescent state, because a preempted task may be sitting in a trampoline
that is about to be freed. That was a fine trade when PREEMPT_NONE
servers compiled Tasks RCU away and PREEMPT desktops rarely ran
long-lived in-kernel loops. PREEMPT_LAZY changes both halves at once:
Tasks RCU is now real on server configs, and cond_resched() is a no-op,
so a CPU-bound kthread or kworker only ever loses the CPU by being
preempted, which is exactly the event Tasks RCU refuses to count.

The way this showed up for us was a cgroup writeback worker draining a
very large cgwb for around eleven minutes on an arm64 box. Nothing wrong
with that on its own, but a BPF program detach on another CPU went
bpf_trampoline_update() -> ftrace_shutdown() -> synchronize_rcu_tasks()
while holding trampoline_mutex, forty-odd tasks piled up behind the
mutex, and the hung task detector panicked the machine. The kprobe jump
optimizer is worse in principle: it does synchronize_rcu_tasks() under
kprobe_mutex, text_mutex and cpus_read_lock(), so one long-running
kthread can stall static key updates and CPU hotplug for its whole run.
The current answer is to find each such loop and add
cond_resched_tasks_rcu_qs() to it, which is the kind of annotation
PREEMPT_LAZY was supposed to let us stop writing.

This series tries the other direction: have the trampolines say when a
task is inside them, so that a preemption anywhere else can be a
quiescent state.

 - task_struct grows an int, rcu_tramp_nesting. Every trampoline whose
   lifetime Tasks RCU guards increments it before calling out and
   decrements it before returning: ftrace_caller and its dynamic copies,
   the BPF trampoline (which drops it again around the call to the
   original function, since im->pcref covers that), the x86 optprobe
   template, and out-of-line register_ftrace_direct() trampolines. Only
   current writes it and nested users are balanced, so it is a plain
   non-atomic inc/dec, one load of current plus one RMW per entry/exit.

 - The inc/dec are inside the trampoline, so there is a window of a few
   instructions on each side where the count is zero but the task is in
   (or on its way into) trampoline text. Nothing there can be preempted
   synchronously, only from an interrupt, so the irq-exit preemption path
   looks at regs->ip and holds the count across preempt_schedule_irq()
   when the IP is somewhere the counter cannot cover: outside core and
   module text (all the dynamically allocated trampolines and slots), in
   the static ftrace stubs or the x86 return thunks that still hold a
   direct-call target, in a module that hosts its own direct trampoline,
   or inside the bytes after a kprobe that the jump optimizer may be
   about to rewrite (the one synchronize_rcu_tasks() user that is not
   about trampolines at all).

 - With those in place, rcu_tasks_classic_qs() also clears the holdout
   flag on a preemption when the count is zero, on architectures that
   opt in. x86-64 and arm64 do so here. Everyone else keeps the
   voluntary-only rule and is untouched apart from the (unused) field.

A running holdout already gets poked via rcu_request_urgent_qs_task(),
which makes the next tick set NEED_RESCHED, so with this the resulting
preemption retires it and a Tasks RCU grace period is bounded by roughly
a tick plus the longest preempt-off section rather than by the longest
stretch without a voluntary schedule().

Patches 1-12 are scaffolding and change no behaviour on their own; patch
13 flips the rule and selects the option for the two architectures.

Testing so far is QEMU only: x86-64, PREEMPT_LAZY with PREEMPT_RCU=n,
PROVE_RCU and lockdep, with and without PREEMPT_DYNAMIC. A kthread
spinning in-kernel for 30s with the function tracer, an ftrace kprobe,
an optimized kprobe and fentry/fexit programs attached:
synchronize_rcu_tasks() goes from 29.7s to 0.1-0.3s, tearing down a
DYNAMIC ftrace_ops (tracefs instance function -> nop) from 27s to
0.2-0.8s, and the ftrace-direct sample modules load, fire and unload in
about 2.5s each while the spinner runs, with no warnings and the new
return-to-user assertion quiet. arm64 is build-tested only at this
point; real hardware numbers for both are the obvious next step and I
did not want to sit on the idea waiting for them.

Things I would particularly like opinions on:

 - Whether hooking rcu_tasks_classic_qs() is the right place, or whether
   Paul would rather see this expressed differently inside Tasks RCU.
 - return_to_handler and the rethook/kretprobe trampolines are not
   instrumented. Their C callees take the ftrace recursion lock before
   touching any ops and the trampolines themselves are static text, so I
   believe they do not need it, but I would like Steven and Masami to
   confirm.
 - The register_ftrace_direct() contract change: out-of-line direct
   trampolines now have to maintain the count themselves (the samples
   are converted). I do not know of out-of-tree users beyond BPF, but
   this is the one place an existing user could be silently weakened.
 - Whether arm64 folks are comfortable with the ldr/add/str in
   ftrace_caller and the BPF trampoline, and with treating all of
   ftrace_caller as trampoline text for the IP check.
 - If this holds up, cond_resched_tasks_rcu_qs() and
   rcu_softirq_qs_periodic() become unnecessary on the opted-in
   architectures; I have not touched them here.

Based on v7.3-rc2+ (893e11787f78).

---
Josef Bacik (13):
      rcu-tasks: Add per-task trampoline nesting count
      entry: Pass pt_regs to irqentry_exit_cond_resched()
      rcu-tasks: Hold trampoline nesting across irq-exit preemption in trampoline text
      kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window
      ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
      x86/ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
      x86/kprobes: Maintain Tasks RCU trampoline nesting in the optprobe template
      bpf, x86: Maintain Tasks RCU trampoline nesting in the BPF trampoline
      arm64: ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
      bpf, arm64: Maintain Tasks RCU trampoline nesting in the BPF trampoline
      samples: ftrace: Maintain Tasks RCU trampoline nesting in direct-call trampolines
      rcutorture: Bracket Tasks RCU readers with trampoline nesting
      rcu-tasks: Treat preemption outside trampolines as a quiescent state

 arch/arm64/Kconfig                          |  1 +
 arch/arm64/kernel/asm-offsets.c             |  3 ++
 arch/arm64/kernel/entry-ftrace.S            | 35 +++++++++++++
 arch/arm64/kernel/ftrace.c                  | 16 ++++++
 arch/arm64/net/bpf_jit_comp.c               | 46 ++++++++++++++++
 arch/x86/Kconfig                            |  1 +
 arch/x86/kernel/asm-offsets.c               |  3 ++
 arch/x86/kernel/ftrace.c                    | 37 +++++++++++++
 arch/x86/kernel/ftrace_64.S                 | 43 +++++++++++++++
 arch/x86/kernel/kprobes/opt.c               | 20 +++++++
 arch/x86/kernel/vmlinux.lds.S               |  4 ++
 arch/x86/net/bpf_jit_comp.c                 | 43 +++++++++++++++
 arch/x86/xen/enlighten_pv.c                 |  2 +-
 include/linux/irq-entry-common.h            | 14 ++---
 include/linux/kprobes.h                     |  8 ++-
 include/linux/module.h                      |  7 +++
 include/linux/rcupdate.h                    | 70 ++++++++++++++++++++++++-
 include/linux/sched.h                       |  1 +
 kernel/entry/common.c                       | 29 +++++++++--
 kernel/fork.c                               |  1 +
 kernel/kprobes.c                            | 24 +++++++++
 kernel/rcu/Kconfig                          | 17 ++++--
 kernel/rcu/rcutorture.c                     |  6 +++
 kernel/rcu/tasks.h                          | 81 +++++++++++++++++++++++++++--
 kernel/rcu/update.c                         |  2 +
 kernel/trace/ftrace.c                       | 39 ++++++++++++++
 samples/ftrace/ftrace-direct-modify.c       |  9 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  9 ++++
 samples/ftrace/ftrace-direct-multi.c        |  5 ++
 samples/ftrace/ftrace-direct-too.c          |  5 ++
 samples/ftrace/ftrace-direct.c              |  5 ++
 samples/ftrace/ftrace-direct.h              | 64 +++++++++++++++++++++++
 32 files changed, 629 insertions(+), 21 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

