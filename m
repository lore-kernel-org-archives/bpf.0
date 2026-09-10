Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322D58E2B0
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066292; cv=none; b=XpbDRTj7rNHQrw/uUpXAdVcFCZCvVgVdcfQH+AS0LALoTlCs8eYh5jrIRClB6AYEbWIoi76NAlcqAhO9NgVmzaKD96C/NG0oaf6qbywvQ/iS3icSvFtgiPHprknSDzXttEW1JFPN8w0l2XWVez4rrUZuW1ZA59SaHelnZg3AADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066292; c=relaxed/simple;
	bh=ZoHASPcgXPkyj8nhWq6Qxe/k1AFcC7iFexyU3IrpvR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUkqXuXhjL0TwBt+p670WnPM3AWS5mHeiPi1kxwyo9tT1akgENg7MtdLAbq/EzQsZ7LprqjA56L0GTN3KskqcmIzhO4h7QRttAJI/AFb1XH9A2yQ50L1vgqOK5PkvhFQvgW/MKFZ7hP//uSBIh7cEwnERYxixsMesT2iTe54H3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FkS5t4r7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FkS5t4r7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52fa6005224so1437401cf.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066267; x=1789671067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VM45t8rF8CqlHWPsaSwdk7BD4ox5LDNpAeDrj6m5qM=;
        b=FkS5t4r7+3j2UfZ0RLVolamkigBb+vJssuPf16u8K6YX23oCdm/HHhL3NfNXesmLkc
         AJckDRrELidS7z9cyjTlXOH6wKMTF/SzZYuA0OiRU/kgbdgSehYJfqGxaoBns7oARu43
         bQKw06h9OmHkWYoMAxkqKMDTV+XmWBupGz+IQuXsGTuAURAOG7Eihotj5Cm6jCFP8B0S
         MJbWE3cjw4/VUXbQ0M6TkMcE7c+UXpdoHAqhV1dgssC7/7/nkE766QgqdFFQ2cwscBUh
         a3m/ZBUhN9FSJUs7mFewpZaByujqKJOuZoBtNpF9cMKHyOjijeiueTPZ5iJP2aCR0a/h
         FSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066267; x=1789671067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VM45t8rF8CqlHWPsaSwdk7BD4ox5LDNpAeDrj6m5qM=;
        b=sqTtZF3VMZBbpC5iQ7FqfRrFffPxovISd2gcohfu9mZnOGf2V7joG4vub4IQfNAs2P
         kln/Hlin3lmofay6HIMQ0FWmyxCpIJGktDVQAmNsBMk7c6OvHDPGO4lQwMAx+L8kh47D
         Qj8WgfBU8JGME5ja5pUz0Pt74SPaoImfaze6QUG1G/WTsFL5U9Srik8jLBuv7AsrgkAl
         SKhDCxYliU9ziP9nTdGt/xnBFdjldL4uoMxhXJbZ6rO7k3bGNyvmqmmy6boEMgtwS5ym
         pcwuZFaK7JC28PN9DzRZiXZ1qMeVmRlEphEHUIHxn4WXKbnhRwa15z0HsxhytTIJVukl
         E+mw==
X-Forwarded-Encrypted: i=1; AKwUvBwHf6XX9sBgScBDFt5FEGBOvs8kt1qmnRFK1EeOwWifMpQLCOalx4MVEak+YcjQyDtnIgY=@vger.kernel.org
X-Gm-Message-State: AFuF++lleVKw49p8K9cLO2iu4zk7sYgldV+bixrH5qBCyHW3gOKMPDvH
	yLZKlW/vO74GR7EiWPN04O4O0+wN1pA4URJmrZVoGcYGBN76/0HlC1dXiCCK4BoUtV8=
X-Gm-Gg: AYBFou2tTtQTzu7xSIEM3DB0BFHpKXESTk1As/MX+qLQW+bnSE+s02EnnYedu3PMnQV
	a/+sMYPohZBAbcsCq9Q72ao/Gi9Gl8mDgEa4W6cxql5R5gXqXjz8DVyoN7ie9D4i4U37ABMOvyr
	4YaL6U8S1Wdo10Q3PdkDvVUd+XUFLmtpUW+J1drhIrkT+XOKDeqM7r4nybIE0Ui991Um8+IsdJr
	hS1DByf2kKGlV3aSpcOYNt/nmnHq2BSlIyOoOw8w196XWuvMHfCQ9U+UXBtXe0bd1dFkG4dz3ys
	RSVxGAKA+g4l9wrRdOB3KLvNpMoKPhBuGCG5slNdVVstvqhrp2/cGlGohtAO2g6mE43ACjRcvrm
	WTOc+5xQkta5DRqMNl3YxjFW2xbcqbC2XNOQv/2HJfFrD2MtNhMFF2CoSL242LUDTBO+sk1BWnH
	bqc5sxgm9Pxr1nBCY3GBT9N2OXyJldSqcZ8iutolmTPLEmdIyLCh2q+SNuVPp9XURIRO/ZJjM7Z
	WgT1QRcs/KovvI4zt4Q7brlSl+RXCIhUN1x5Vsv7yfTc42t56dgaOY8
X-Received: by 2002:a05:622a:2294:b0:530:b2e4:d597 with SMTP id d75a77b69052e-530c87487damr11129971cf.50.1789066266848;
        Thu, 10 Sep 2026 11:51:06 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47a239sm2556366d6.26.2026.09.10.11.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:31 +0000
Subject: [PATCH RFC 08/13] bpf, x86: Maintain Tasks RCU trampoline nesting
 in the BPF trampoline
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-8-d4469f4cc101@toxicpanda.com>
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

Emit an increment of current->rcu_tramp_nesting once the trampoline's
frame is set up and a decrement before the final register restore, so
that a task preempted while running fentry/fexit/fmod_ret/LSM programs
or the __bpf_tramp_enter()/__bpf_tramp_exit() glue is not treated as
Tasks-RCU quiescent.  Drop the count around the call to the original
function: that may run arbitrarily long without sleeping and must not pin
a Tasks RCU grace period, and the trampoline frame above it is held by
im->pcref rather than by Tasks RCU (see bpf_tramp_image_put()).  The
fmod_ret early-exit branch and the ip_after_call -> ip_epilogue poke both
skip the decrement/increment pair around the original call, so the count
stays balanced on every path.

The sequence is "mov r11, gs:[current_task]; inc/dec dword [r11 + off]";
r11 is scratch at every emission point and (u32)&current_task is a valid
sign-extended %gs-absolute with the current per-CPU layout, the same form
the JIT already uses for this_cpu_off.  The image is dynamically
allocated text, so the instructions outside the bracketed region are
covered by the irq-exit IP check.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2853e87797a7..a375c1b7bd50 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -722,6 +722,31 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 	*pprog = prog;
 }
 
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().
+ *
+ *   mov r11, QWORD PTR gs:[current_task]
+ *   inc/dec DWORD PTR [r11 + offsetof(struct task_struct, rcu_tramp_nesting)]
+ *
+ * r11 (AUX_REG) is scratch in the trampoline at every point this is emitted.
+ */
+static void emit_rcu_tasks_tramp_nesting(u8 **pprog, bool enter)
+{
+#ifdef CONFIG_TASKS_RCU
+	u8 *prog = *pprog;
+
+	/* mov r11, gs:[abs32] */
+	EMIT2(0x65, 0x4C);
+	EMIT3(0x8B, 0x1C, 0x25);
+	EMIT((u32)(unsigned long)&current_task, 4);
+	/* inc/dec dword ptr [r11 + disp32] */
+	EMIT3(0x41, 0xFF, enter ? 0x83 : 0x8B);
+	EMIT(offsetof(struct task_struct, rcu_tramp_nesting), 4);
+
+	*pprog = prog;
+#endif
+}
+
 static void emit_return(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
@@ -3610,6 +3635,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
+	/*
+	 * From here until the matching decrement before the final return, a
+	 * preemption of this task is not a Tasks RCU quiescent state.  The
+	 * instructions above this point are covered by the irq-exit IP check.
+	 */
+	emit_rcu_tasks_tramp_nesting(&prog, true);
+
 	func_meta = nr_regs;
 	/* Store number of argument registers of the traced function */
 	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
@@ -3670,6 +3702,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 		}
 
+		/*
+		 * The original function may run for a long time without
+		 * sleeping; do not let it pin a Tasks RCU grace period.  The
+		 * trampoline frame above it is held by im->pcref
+		 * (__bpf_tramp_enter()), not by Tasks RCU, across the call.
+		 */
+		emit_rcu_tasks_tramp_nesting(&prog, false);
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
 			EMIT2(0xff, 0xd3); /* call *rbx */
@@ -3680,6 +3719,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 				goto cleanup;
 			}
 		}
+		emit_rcu_tasks_tramp_nesting(&prog, true);
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
@@ -3741,6 +3781,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
+	/* Remaining instructions are covered by the irq-exit IP check. */
+	emit_rcu_tasks_tramp_nesting(&prog, false);
+
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 
 	EMIT1(0xC9); /* leave */

-- 
2.55.0

