Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD8265620
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728865; cv=none; b=lM1Of2LhD+DocoJjh83P3IKrjZYmY3ancSHKG8r2rh5ygLKOS4dyC8TIN4CAiH9z7+qulwK9ATal3TTaYbIBjWBl0l3ZV96lalNTWTkFWqmP8q/B5b4ShrZCv9TPPjlIeJvJLZB5BT4kyDzF3Y4NhuTizakIRJI30EcIeIj1INU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728865; c=relaxed/simple;
	bh=jYtcECzVlp/tojihwJioNEtjJqVbrNTq7HCP/tKg8Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ksep6t+zJXq3+kfX6NWER/rmNNd0l+23iS8Qkx0y30HEbwi/xBwc4KgFXdfncpmevsdgT9qXiGetMvd9ui6KtijlOFkdZHzP6bsxqN2cKLVHXYkgzxr6HSUquo3UJ2vqHpIiTX9xoPs4g2zfNUhxSDpnNLZCUApTNIyasT4R4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwB1rFm2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwB1rFm2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso9393701b3a.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728864; x=1785333664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmw/vOOFxAmrHxAo+1GzxM/5GGe32N4p7+qg3hLMUYs=;
        b=UwB1rFm2qlD7eYioGfknMRvH3MN+ZbOLwLiqQHZM9IrVi268w9orvOuTXUZ3rmgh8a
         Yz9+jhI2HvYJri5HySw+8o+zcoUmra6hkXWq04uaepC7sry4EL+a4tK18xKYbxgXhxju
         hQI8mK5XAsRaxJko1yu4zOOWP6XrEza7iKgQWSQkZtXj1UFTlLn5UxYyENZ/+rgBF/CW
         Mc1TVYufqdYGGypfqIYr/K873ulMiO45NURaXe1WnsGFOn8BkRPu5RFhHBIVN2745+n7
         ppnyqWJ9EtnRWsmU0u8TyyOrigaV51VVs6y3TIPzMmlKYpOmzPOUNZdpBecIYeIAgz3Z
         sCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728864; x=1785333664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmw/vOOFxAmrHxAo+1GzxM/5GGe32N4p7+qg3hLMUYs=;
        b=ZFEmEnmLzlDgXdoBME7cQgXh6GG/zcFW5CgwNiy2dnyjb4o6fsE4InFPpeB/2wcZDd
         um+5/aswd6U3D0q7zKrsUBR0QE35sdSlJZV57xYoikbn+79jtI9guxF5QfCtlBVF/X8z
         NIX/6v5ZZC1mueivNxtnA2/tI2WdE7TkVZQb+oSR0TRH95fBaIpJyA2zEoaG9enEbVQ8
         doOVeoP1giX+WRH4dTBwKwmZH6MRgYUrag6Ve0EaBNRt0kGS+MHuxk1+05Tkc/fPSggB
         YleGF/o4G2WGY5HwbXxArqTf8su3Bkbqcu2m4RM1scGfY9S1hA4OZ/deHZSjr1vz5gSO
         kX1A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6BpPWsVFiAerGcgsVHS/BYwCpDim5UG4Vs3hEJbnRQ7E/VkynszRUd67/H5gFaYru8sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAs8EmnpKnfshJPNKN9SSgVmOA/zKIIbMO+zVvUYOEp4C8XJu
	DsLWFZmtIrx02Vm4bcgmcUPOSJCtrIlUNqzP+PdnnSHZzkYbGm/7wH3A
X-Gm-Gg: AR+sD12se67aj5gltDEA486I1Eb3n/AsSPbBaHadEYq1XSmjY2rNKGI33wktYeFSFxF
	UeLKt312+AyvpJDUjGxY4prAhgDuM6INhJ8s+lU8v7s6PwzAe5DfrP0Q7yNBEbdulx0LaAwumqT
	jvw/KSd12d28NNfLSTUi8bolc2BQpWIBA+wEvow6LfI8BjhCcs1M8BPWPbc+J6CgKS29hXTrmaJ
	npRcCKALMwjLtZdhb85ohE1Z67AW9fTbGWV+e2N14LIa4CREwHTp/F+3KPDAENjGKEEKjzcZN7Z
	yoqf401EfXnUlXaB12X2wJuDhU4xN9KFmzPfqKIVC94MOOPxCs4CmKV6rT53V+8g1LYy10dJlrP
	V/2muHmBkBrF3IT52VkiUBoXfx2SlmiukUuVoUL1Zl9f7ddQbpk23OvTl/y7Ck+zRJjRmn0nKEA
	AeqaCXoOjAARbLex+MCEjCnfvsMkBilAk5U6tjM+evN0+waQw=
X-Received: by 2002:a05:6a00:1f09:b0:845:c662:2be with SMTP id d2e1a72fcca58-84c2946f795mr22779930b3a.42.1784728856923;
        Wed, 22 Jul 2026 07:00:56 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm1242281a12.26.2026.07.22.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:00:56 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v3 2/6] riscv, stacktrace: Pass sp and fp to the walk_stackframe() callback
Date: Wed, 22 Jul 2026 19:30:09 +0530
Message-ID: <20260722140015.1982158-3-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722140015.1982158-1-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the walk_stackframe() consume callback so it receives the stack
pointer and frame pointer of each frame, in addition to the pc. The
extra state is needed by the BPF exceptions machinery.
bpf_throw() unwinds the kernel stack looking for the BPF program that
acts as the exception boundary and needs (pc, stack and frame pointers)
of that frame to invoke the exception callback in its stack context.

This mirrors what arm64 does, where kunwind_stack_walk() hands the full
unwind state to its consume functions and arch_stack_walk() adapts the
generic stack_trace_consume_fn via a small wrapper
(kunwind_consume_entry_data), so that a single unwinder serves the
generic stacktrace API and BPF alike.

The pc-only callbacks print_trace_address() and save_wchan() simply
gain ignored arguments, and arch_stack_walk() now adapts the generic
stack_trace_consume_fn with a wrapper struct. In the
!CONFIG_FRAME_POINTER variant there is no frame pointer to report, so
pass the scan position as sp and 0 as fp.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/include/asm/stacktrace.h |  5 +++-
 arch/riscv/kernel/stacktrace.c      | 39 +++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index b1495a7e06ce..fd1ff04a040e 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -11,8 +11,11 @@ struct stackframe {
 	unsigned long ra;
 };
 
+typedef bool (*walk_stackframe_fn)(void *arg, unsigned long pc,
+				   unsigned long sp, unsigned long fp);
+
 extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-				    bool (*fn)(void *, unsigned long), void *arg);
+				    walk_stackframe_fn fn, void *arg);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index c7555447149b..30b369dd2815 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -46,7 +46,7 @@ static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 }
 
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-			     bool (*fn)(void *, unsigned long), void *arg)
+			     walk_stackframe_fn fn, void *arg)
 {
 	unsigned long fp, sp, pc;
 	int graph_idx = 0;
@@ -71,7 +71,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	for (;;) {
 		struct stackframe *frame;
 
-		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
+		/* pc belongs to the function whose frame pointer is fp */
+		if (unlikely(!__kernel_text_address(pc) ||
+			     (level++ >= 0 && !fn(arg, pc, sp, fp))))
 			break;
 
 		if (unlikely(!fp_is_valid(fp, sp)))
@@ -91,7 +93,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 						   &frame->ra);
 			if (pc >= (unsigned long)handle_exception &&
 			    pc < (unsigned long)&ret_from_exception_end) {
-				if (unlikely(!fn(arg, pc)))
+				if (unlikely(!fn(arg, pc, sp, fp)))
 					break;
 
 				pc = ((struct pt_regs *)sp)->epc;
@@ -105,7 +107,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 #else /* !CONFIG_FRAME_POINTER */
 
 void notrace walk_stackframe(struct task_struct *task,
-	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
+	struct pt_regs *regs, walk_stackframe_fn fn, void *arg)
 {
 	unsigned long sp, pc;
 	unsigned long *ksp;
@@ -127,7 +129,8 @@ void notrace walk_stackframe(struct task_struct *task,
 
 	ksp = (unsigned long *)sp;
 	while (!kstack_end(ksp)) {
-		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
+		if (__kernel_text_address(pc) &&
+		    unlikely(!fn(arg, pc, (unsigned long)ksp, 0)))
 			break;
 		pc = READ_ONCE_NOCHECK(*ksp++);
 	}
@@ -135,7 +138,8 @@ void notrace walk_stackframe(struct task_struct *task,
 
 #endif /* CONFIG_FRAME_POINTER */
 
-static bool print_trace_address(void *arg, unsigned long pc)
+static bool print_trace_address(void *arg, unsigned long pc,
+				unsigned long sp, unsigned long fp)
 {
 	const char *loglvl = arg;
 
@@ -155,7 +159,8 @@ void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 	dump_backtrace(NULL, task, loglvl);
 }
 
-static bool save_wchan(void *arg, unsigned long pc)
+static bool save_wchan(void *arg, unsigned long pc,
+		       unsigned long sp, unsigned long fp)
 {
 	if (!in_sched_functions(pc)) {
 		unsigned long *p = arg;
@@ -176,10 +181,28 @@ unsigned long __get_wchan(struct task_struct *task)
 	return pc;
 }
 
+struct walk_stackframe_consume_entry_data {
+	stack_trace_consume_fn consume_entry;
+	void *cookie;
+};
+
+static bool walk_stackframe_consume_entry(void *arg, unsigned long pc,
+					  unsigned long sp, unsigned long fp)
+{
+	struct walk_stackframe_consume_entry_data *data = arg;
+
+	return data->consume_entry(data->cookie, pc);
+}
+
 noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
-	walk_stackframe(task, regs, consume_entry, cookie);
+	struct walk_stackframe_consume_entry_data data = {
+		.consume_entry = consume_entry,
+		.cookie = cookie,
+	};
+
+	walk_stackframe(task, regs, walk_stackframe_consume_entry, &data);
 }
 
 /*
-- 
2.55.0

