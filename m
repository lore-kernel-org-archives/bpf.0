Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF759481D
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066293; cv=none; b=cZ2i+abPYKTOfyjMf+k2MSdBD2e/XbN1Zq1tTxY0kPMnydHULsJBv6OJRdvlQwD9ZY7CNO7UxX7RFPXKa2+jddAk3TrBQ7B9VLS7kLldTuk1g3X/7MYCW6R+xMPGu2yQaGteII2lBH7j8zzC+JtmYTNDYeeMgPAR19aZ3IYBhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066293; c=relaxed/simple;
	bh=hPcqGdFxo+b+ijS7jNB+8GMowmEDvopzKnpNmpphVrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=du21wPy1mNMDli2sH1prSP4tlKPP7uVlkPz4V9H3VYiERWuSYzX+HKCU4FeuVxcE9GY3S1XFjYqFEycsa4H4zC8DnUEGvYtOdTYHZAOP3EI7kiL2tMtHrUJFObQPFf3eiQ3zIvJMysHtZdOdR9RCJ89w2YYJXrtxdPDXTHzQee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XDllTevf; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XDllTevf"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97ca74bd6e0so133960241.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066273; x=1789671073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32pR0m9lJbbl6oefWflQ2FM2YWt9ii7Ub9HEHMaojiA=;
        b=XDllTevfPFAA/shBdvlXSEieA74LE6VArJRuG721HwcVAX6EgcaQx+7AjWDDHhhwBf
         ZeyGft5cw9etEmo9wqwElqS/XU37xduhPVYtKhkoHTo90jOSVb59SxEJi0daPzNCfVym
         s7Ou3HS39P438WwbXUA+42OZYA0XNuFZp8G9t1W4mmVP72JHgXVRk/ziuQ31p8TIfGvW
         rwvoKkNz6PTu5tIlKUq82S5oKSAT8pW+mmBSStpOD+s/kQKXBu8XjGPIK+9b83h/88J7
         XMjVYmt+lR70Mx0zZJSeZhqJZSosgwEmq8CwDTFiC87ma7IxQMenNh+PAHh/5IU48KTt
         IEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066273; x=1789671073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32pR0m9lJbbl6oefWflQ2FM2YWt9ii7Ub9HEHMaojiA=;
        b=F6Ck6fFNxWpaR7PrVt2Vq8MqPo6Eh2r3EwTXTo8i8TM2LiC3nesTmk/2GzJIxCeFE2
         hlqqum29dZP+vGmKikKdwWwJTLl8xrmjgGbvwBd7QaWDoOXo6wcLFhU7v+HgKjwkCtyK
         SEg0xb5Lj7RqOXF9Jq/2BGTUe7KacY3jFg6UBMrxX0T4LR3BQxKIW++/ztqpcKIHRkxz
         D4o2O+jwsyoTo+7H23wIfce0sSYawTgP7YhNi+l4XbkFFaN0O1lUwJ2//TUeCbOxIExQ
         e+OuOOia2LyUsH9Bo8tVSVL1tNAfn/hQ7GNEY66rengs5sIgyJa4KmYr8Xyv/SkzlPVn
         a93A==
X-Forwarded-Encrypted: i=1; AKwUvBx0clNy3+6+Wje5YcDA8s+d8RuHUHmPeLU1wjcZS//6v3K5Q3o9QV2RvcL6Cm/xODudeM4=@vger.kernel.org
X-Gm-Message-State: AFuF++lhlrzDAOULIrvv5qP+w5dZBey8XUpnxs9umHSKoKlL/X4BFHXp
	iDPXxY82m9hPPUb7ejIxWaKpNHbrxSouXGNFTGQInRnUsWbZEbOqaANhS0TN8vk29Rs=
X-Gm-Gg: AYBFou0e3Jf/1ykDCan0gI3FPAb3R1vg2EZL8wrYWyPl0ZrqKlL+zDN3mC+E3pUnunc
	mjnuNGpPnfmkwcUapk031lq+rfsj5Znq3HStW3uV1JwBubILh+3aez9o5Qc/uLIiQK09OwM7Qca
	OROFGsHRDxXIcqm6ro4X+ZyaESGWganFYxWRkQPENSkYAJQoxwUg5igwnh0FLuGiPx7VD6Fxxo6
	5+QIp5qrYlFXHfxXh8oneXxwCU0xShdaCkkitsIrIjx3ZRq58nzidhx8EoDWZI1+LBbRnJY/unZ
	EYJB4wDYWuIONW2e0gwPTRQuYNAorlaX2yaHB5slpLz9RE9RtoQ/TfDXI0OXl272HREnyH3Dmwn
	PoMax7vyjKTfNigUY/VsYoYBTOh67ioxxWRj4fur/TPAfj11z1phHuFIKKkzYq7ehSgVO/h4hJu
	MsiP2pbqrUsHqpbOtcM2+qWU+GowKdiWIVajY2dQEZRFclXeS1KAL1jnUrSp4Z07/4yOMFUMkB7
	Dj/HBJDIS2peBdEdT21vzuyN1xrnfSsA+VW6UFzyniyvLFDYMcuT8Uh
X-Received: by 2002:a67:e117:0:b0:790:f691:2d5b with SMTP id ada2fe7eead31-792a5b8b8a7mr1152469137.4.1789066272932;
        Thu, 10 Sep 2026 11:51:12 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47aeb7sm2503906d6.24.2026.09.10.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:34 +0000
Subject: [PATCH RFC 11/13] samples: ftrace: Maintain Tasks RCU trampoline
 nesting in direct-call trampolines
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-11-d4469f4cc101@toxicpanda.com>
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

Follow the register_ftrace_direct() contract in the sample modules: on
x86-64 and arm64, have each hand-written trampoline increment
current->rcu_tramp_nesting before calling its C handler and decrement it
before returning, via a small shared samples/ftrace/ftrace-direct.h.
%r11 and x12/w13 are used as scratch; both are caller-saved, non-argument
registers and therefore dead on entry to and exit from an fentry
trampoline.

The header pulls in the generated asm-offsets.h only on those two
architectures, since it is not generally safe to include from C (PPC32's
TASK_SIZE and arm64's TRAMP_VALIAS clash with the C definitions; the
latter is worked around locally with push_macro/pop_macro).  Other
architectures get empty macros and are unchanged.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 samples/ftrace/ftrace-direct-modify.c       |  9 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  9 ++++
 samples/ftrace/ftrace-direct-multi.c        |  5 +++
 samples/ftrace/ftrace-direct-too.c          |  5 +++
 samples/ftrace/ftrace-direct.c              |  5 +++
 samples/ftrace/ftrace-direct.h              | 64 +++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 164d9dd6fd92..eb8230fa4242 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -73,7 +74,9 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	call my_direct_func1\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -85,7 +88,9 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	call my_direct_func2\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -141,11 +146,13 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func1\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -153,11 +160,13 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func2\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b03766c6217b..c8f1062e5d1a 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -77,10 +78,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -92,10 +95,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -154,6 +159,7 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -162,6 +168,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -169,6 +176,7 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -177,6 +185,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 3fe6ddaf0b69..bc6a88dd4ffc 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #include <linux/sched/stat.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
@@ -56,10 +57,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -101,6 +104,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -109,6 +113,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index bf2411aa6fd7..247e418644a2 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -61,6 +62,7 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
@@ -70,6 +72,7 @@ asm (
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -110,6 +113,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #48\n"
 "	stp	x9, x30, [sp]\n"
 "	stp	x0, x1, [sp, #16]\n"
@@ -119,6 +123,7 @@ asm (
 "	ldp	x0, x1, [sp, #16]\n"
 "	ldp	x2, x3, [sp, #32]\n"
 "	add	sp, sp, #48\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 5368c8c39cbb..9e1964baf28b 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -54,9 +55,11 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -97,6 +100,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -104,6 +108,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.h b/samples/ftrace/ftrace-direct.h
new file mode 100644
index 000000000000..d0313f33f47f
--- /dev/null
+++ b/samples/ftrace/ftrace-direct.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _SAMPLES_FTRACE_DIRECT_H
+#define _SAMPLES_FTRACE_DIRECT_H
+
+#include <linux/stringify.h>
+
+/*
+ * A direct-call trampoline is entered with no lock, refcount or RCU marker
+ * held; only Tasks RCU keeps it (and, for a module, its text) alive while a
+ * task is inside it or preempted in something it called.  On architectures
+ * that select ARCH_HAS_RCU_TASKS_PREEMPT_QS a preemption is a Tasks RCU
+ * quiescent state unless current->rcu_tramp_nesting is non-zero, so the
+ * trampoline must raise it before calling out and drop it afterwards, exactly
+ * like the ftrace and BPF trampolines do.  See rcu_tasks_trampoline_enter()
+ * and register_ftrace_direct().  The instructions before the increment and
+ * after the decrement are covered by ftrace_direct_mark_module().
+ *
+ * These expand to instruction strings for use inside the samples' asm()
+ * trampolines.  The scratch register is caller-saved and not an argument
+ * register, so it is dead on entry to and exit from an fentry trampoline.
+ *
+ * The generated asm-offsets.h is only pulled in on the architectures that need
+ * it here: it is not generally safe to include from C (e.g. PPC32's TASK_SIZE
+ * and arm64's TRAMP_VALIAS clash with the C definitions), which is why the
+ * samples themselves guard their own include of it.
+ */
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_X86_64)
+
+#include <asm/asm-offsets.h>
+
+#define RCU_TASKS_TRAMP_ENTER						\
+	"	movq %gs:current_task(%rip), %r11\n"				\
+	"	incl " __stringify(TASK_rcu_tramp_nesting) "(%r11)\n"
+#define RCU_TASKS_TRAMP_EXIT						\
+	"	movq %gs:current_task(%rip), %r11\n"				\
+	"	decl " __stringify(TASK_rcu_tramp_nesting) "(%r11)\n"
+
+#elif defined(CONFIG_TASKS_RCU) && defined(CONFIG_ARM64)
+
+/* arm64's asm-offsets.h redefines TRAMP_VALIAS from <asm/fixmap.h>. */
+#pragma push_macro("TRAMP_VALIAS")
+#undef TRAMP_VALIAS
+#include <asm/asm-offsets.h>
+#pragma pop_macro("TRAMP_VALIAS")
+
+#define RCU_TASKS_TRAMP_ENTER						\
+	"	mrs	x12, sp_el0\n"						\
+	"	ldr	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"	\
+	"	add	w13, w13, #1\n"						\
+	"	str	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"
+#define RCU_TASKS_TRAMP_EXIT						\
+	"	mrs	x12, sp_el0\n"						\
+	"	ldr	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"	\
+	"	sub	w13, w13, #1\n"						\
+	"	str	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"
+
+#else
+
+#define RCU_TASKS_TRAMP_ENTER
+#define RCU_TASKS_TRAMP_EXIT
+
+#endif
+
+#endif /* _SAMPLES_FTRACE_DIRECT_H */

-- 
2.55.0

