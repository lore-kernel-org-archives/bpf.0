Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C226ED45;
	Thu, 11 Jun 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142817; cv=none; b=sqAAG3MbR2u8D7ayu9E+WEGpIK0vuE+U1iNSvgnHq1EgKe2Dksu/yI6r8SLwUI4x3qpfGWmZURwP3U+I8piNszDOHhRiT8FddRkVi8Mq6AylR4De9NdeREAyVhZkmtb0sYh66ABvOcfQ27ZfXaNEycvMXewCCCR/8ZiME+/p+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142817; c=relaxed/simple;
	bh=7SuxkQx5HAKal13CA0LTBZ26jzq30vMW+Gz0ll3oQDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsHAFTJke+C2jInmiKcLRKqfFgE2IsTawtm6nvglBNDPmIJI/oVwNjpShHM4J3oDCuRipfikXmy92ig7LixP3ri1mmgDe3JWjHjID4qmvJ2Recyt+Dq+2Adn6TtLO20fZ7To5wqT+rLRXUtPFHKp6gK+Gh/1Waij8Jj94+AEcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axp3gZFSpqDecSAA--.25502S3;
	Thu, 11 Jun 2026 09:53:29 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68EXFSpqrXaiAA--.43928S3;
	Thu, 11 Jun 2026 09:53:29 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Date: Thu, 11 Jun 2026 09:53:25 +0800
Message-ID: <20260611015327.12108-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260611015327.12108-1-yangtiezhu@loongson.cn>
References: <20260611015327.12108-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68EXFSpqrXaiAA--.43928S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJw47KFyxXry7tr1UZF48Xwc_yoW8AryxXo
	WavF4qyr1xJw4UWa98trnxtFW5Xr1qkayDZ3y2vanxGa1xJ347WryUGw13tFy3XFykWanr
	C34agw4v93s7trn7l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7cdbUUUUU

Like other architectures such as x86, arm64, riscv, powerpc and s390,
select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
stack into task_struct. This follows modern kernel standards and also
makes the system more secure.

With this patch, thread_info is included in task_struct at an offset
of 0 instead of being placed at the bottom of the kernel stack. Thus,
the $tp register points to both thread_info and task_struct.

To support this, introduce a per-CPU variable cpu_tasks to store the
pointer to the current task_struct. This decouples the recovery	of
the $tp register from the stack pointer during exception entry.

Then initialize cpu_tasks for the primary and secondary CPUs during
arch-specific setup and SMP boot paths. To eliminate the dangerous
windows during the early initialization where the cpu_tasks remains
uninitialized, set_current() is invoked as early as possible in both
setup_arch() (right after unwind_init) and start_secondary() (right
after cpu_probe). This ensures the $tp recovery barrier is armed in
case any early boot exceptions or kernel panics occur.

Modify SAVE_SOME and handle_syscall to restore the $tp register from
cpu_tasks, and also use the la_abs absolute addressing for cpu_tasks
access in assembly to bypass the relocation limits within exception
handling sections. By advancing the preservation of u0 in SAVE_SOME,
reuse the PERCPU_BASE_KS value in u0 for the cpu_tasks calculation,
effectively eliminating a duplicate csrrd instruction execution on
SMP platforms.

Update <asm/switch_to.h> and <kernel/switch.S> to fully support the
CONFIG_THREAD_INFO_IN_TASK feature.

Remove the obsolete next_ti argument from __switch_to(), which shifts
the remaining arguments ahead in the calling convention (sched_ra from
a3 to a2, and sched_cfa from a4 to a3). Under the new configuration,
__switch_to() now directly derives the thread pointer ($tp) from the
next task_struct pointer in a1.

To preserve the optimal and clean "move tp, a1" path for 64-bit kernels,
the thread pointer ($tp) is assigned directly from a1 in the core path.
For 32-bit kernels, where a1 carries a 2000-byte structural pointer bias
at entry, an explicit adjustment "PTR_ADDI tp, tp, -TASK_STRUCT_OFFSET"
is introduced at the function exit. Since __switch_to() executes under
the protection of Direct Window Mapping with local interrupts disabled,
the core path is immune to any exceptions, making this delayed un-biasing
sequence strictly safe before returning to the scheduler.

Additionally, evaluate the stack lookup as a single load instruction
"LONG_LPTR t0, a1, (TASK_STACK - TASK_STRUCT_OFFSET)", this perfectly
satisfies both 32-bit and 64-bit kernels. Using the "next" pointer in
a1 as the base register, rather than $tp, effectively unchains the data
dependency (RAW hazard) from the preceding move instruction, maximizing
the instruction-level parallelism and superscalar execution efficiency
while naturally adapting the structural shift.

At last, safeguard the task stack access in show_backtrace() by wrapping
the unwinding loop with try_get_task_stack() and put_task_stack(). This
prevents the potential use-after-free or severe memory anomalies if the
target task exits and its stack is freed concurrently during a backtrace.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../core/thread-info-in-task/arch-support.txt |  2 +-
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/current.h          | 31 +++++++++++++++++++
 arch/loongarch/include/asm/smp.h              |  3 +-
 arch/loongarch/include/asm/stackframe.h       |  9 ++++--
 arch/loongarch/include/asm/switch_to.h        |  6 ++--
 arch/loongarch/include/asm/thread_info.h      | 10 ------
 arch/loongarch/kernel/asm-offsets.c           |  6 ++--
 arch/loongarch/kernel/entry.S                 |  7 +++--
 arch/loongarch/kernel/head.S                  | 18 ++++++-----
 arch/loongarch/kernel/process.c               |  2 ++
 arch/loongarch/kernel/relocate.c              |  2 +-
 arch/loongarch/kernel/setup.c                 |  1 +
 arch/loongarch/kernel/smp.c                   |  6 ++--
 arch/loongarch/kernel/switch.S                | 14 +++++----
 arch/loongarch/kernel/traps.c                 |  5 +++
 16 files changed, 85 insertions(+), 38 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index f3d744c76061..e26efdfbb6b4 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -12,7 +12,7 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 606597da46b8..cf8d3cf91814 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -210,6 +210,7 @@ config LOONGARCH
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_EXCEPTION_TRACE
 	select SWIOTLB if 64BIT
+	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/loongarch/include/asm/current.h b/arch/loongarch/include/asm/current.h
new file mode 100644
index 000000000000..fa4fb7987075
--- /dev/null
+++ b/arch/loongarch/include/asm/current.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_LOONGARCH_CURRENT_H
+#define __ASM_LOONGARCH_CURRENT_H
+
+#include <linux/compiler.h>
+
+#ifndef __ASSEMBLER__
+
+#include <asm/percpu.h>
+
+struct task_struct;
+
+DECLARE_PER_CPU(struct task_struct *, cpu_tasks);
+
+register struct task_struct *current_thread_pointer __asm__("$tp");
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return current_thread_pointer;
+}
+
+#define current get_current()
+
+static __always_inline void set_current(struct task_struct *task)
+{
+	__this_cpu_write(cpu_tasks, task);
+}
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_LOONGARCH_CURRENT_H */
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 3a47f52959a8..761cc0016df8 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -82,7 +82,8 @@ struct seq_file;
 
 struct secondary_data {
 	unsigned long stack;
-	unsigned long thread_info;
+	unsigned long task;
+	unsigned long offset;
 };
 extern struct secondary_data cpuboot_data;
 
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index ecc8e50fffa8..b031152e0fc8 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -191,10 +191,15 @@
 	andi	t0, t0, 0x3	/* extract pplv bit */
 	beqz	t0, 9f
 
-	LONG_LI	tp, ~_THREAD_MASK
-	and	tp, tp, sp
 	cfi_st  u0, PT_R21, \docfi
 	csrrd	u0, PERCPU_BASE_KS
+
+	la_abs      t1, cpu_tasks
+#ifdef CONFIG_SMP
+	LONG_ADD    t1, t1, u0
+#endif
+	LONG_L      tp, t1, 0
+
 9:
 #ifdef CONFIG_KGDB
 	li.w	t0, CSR_CRMD_WE
diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
index 5b225aff3ba2..07a4c5909779 100644
--- a/arch/loongarch/include/asm/switch_to.h
+++ b/arch/loongarch/include/asm/switch_to.h
@@ -15,7 +15,6 @@ struct task_struct;
  * __switch_to - switch execution of a task
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
- * @next_ti:	task_thread_info(next).
  * @sched_ra:	__schedule return address.
  * @sched_cfa:	__schedule call frame address.
  *
@@ -23,7 +22,7 @@ struct task_struct;
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
-			struct task_struct *next, struct thread_info *next_ti,
+			struct task_struct *next,
 			void *sched_ra, void *sched_cfa);
 
 /*
@@ -37,7 +36,8 @@ do {										\
 	lose_fpu_inatomic(1, prev);						\
 	lose_lbt_inatomic(1, prev);						\
 	hw_breakpoint_thread_switch(next);					\
-	(last) = __switch_to(prev, next, task_thread_info(next),		\
+	set_current(next);							\
+	(last) = __switch_to(prev, next,					\
 		 __builtin_return_address(0), __builtin_frame_address(0));	\
 } while (0)
 
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 4d7117fcdc78..41eabe4fb647 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -22,7 +22,6 @@
  *   must also be changed
  */
 struct thread_info {
-	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
@@ -37,20 +36,11 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
 	.flags		= _TIF_FIXADE,		\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
-/* How to get the thread information struct from C. */
-register struct thread_info *__current_thread_info __asm__("$tp");
-
-static inline struct thread_info *current_thread_info(void)
-{
-	return __current_thread_info;
-}
-
 register unsigned long current_stack_pointer __asm__("$sp");
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 2cc953f113ac..453b176fa2d1 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -70,7 +70,7 @@ static void __used output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
 	OFFSET(TASK_STATE, task_struct, __state);
-	OFFSET(TASK_THREAD_INFO, task_struct, stack);
+	OFFSET(TASK_STACK, task_struct, stack);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
 	OFFSET(TASK_PID, task_struct, pid);
@@ -84,7 +84,6 @@ static void __used output_task_defines(void)
 static void __used output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
-	OFFSET(TI_TASK, thread_info, task);
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
@@ -267,7 +266,8 @@ static void __used output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
 	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
-	OFFSET(CPU_BOOT_TINFO, secondary_data, thread_info);
+	OFFSET(CPU_BOOT_TASK, secondary_data, task);
+	OFFSET(CPU_BOOT_OFFSET, secondary_data, offset);
 	BLANK();
 }
 #endif
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index b53d333a7c42..53bce27f516b 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -67,8 +67,11 @@ SYM_CODE_START(handle_syscall)
 #endif
 
 	move		u0, t0
-	LONG_LI		tp, ~_THREAD_MASK
-	and		tp, tp, sp
+	la_abs		t1, cpu_tasks
+#ifdef CONFIG_SMP
+	LONG_ADD	t1, t1, u0
+#endif
+	LONG_L		tp, t1, 0
 
 	move		a0, sp
 	bl		do_syscall
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4eed7bc312a8..ec67faab907b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -74,10 +74,11 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	/* GPR21 used for percpu base (runtime), initialized as 0 */
 	move		u0, zero
 
-	la.pcrel	tp, init_thread_union
-	/* Set the SP after an empty pt_regs.  */
-	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
-	PTR_ADD		sp, sp, tp
+	la.pcrel	tp, init_task
+	la.pcrel	t0, init_stack
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
+	PTR_ADDI	sp, t0, -PT_SIZE
 	set_saved_sp	sp, t0, t1
 
 #ifdef CONFIG_RELOCATABLE
@@ -86,8 +87,10 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 #ifdef CONFIG_RANDOMIZE_BASE
 	/* Repoint the sp into the new kernel */
-	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
-	PTR_ADD		sp, sp, tp
+	LONG_LPTR	t0, tp, TASK_STACK
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
+	PTR_ADDI	sp, t0, -PT_SIZE
 	set_saved_sp	sp, t0, t1
 
 	/* Jump to the new kernel: new_pc = current_pc + random_offset */
@@ -128,7 +131,8 @@ SYM_CODE_START(smpboot_entry)
 #endif
 	la.pcrel	t0, cpuboot_data
 	ld.d		sp, t0, CPU_BOOT_STACK
-	ld.d		tp, t0, CPU_BOOT_TINFO
+	ld.d		tp, t0, CPU_BOOT_TASK
+	ld.d		u0, t0, CPU_BOOT_OFFSET
 
 	bl		start_secondary
 	ASM_BUG()
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 5505fc355e1b..0116a7befab0 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -54,6 +54,8 @@
 #include <asm/vdso.h>
 #include <asm/vdso/vdso.h>
 
+DEFINE_PER_CPU(struct task_struct *, cpu_tasks);
+
 #ifdef CONFIG_STACKPROTECTOR
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 4b61a9632a98..2a42874e5eb7 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -313,7 +313,7 @@ unsigned long __init relocate_kernel(void)
 		reloc_offset += random_offset;
 
 		/* The current thread is now within the relocated kernel */
-		__current_thread_info = RELOCATED_KASLR(__current_thread_info);
+		current_thread_pointer = RELOCATED_KASLR(current_thread_pointer);
 
 		update_reloc_offset(&reloc_offset, random_offset);
 	}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 839b23edee87..369262117c63 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -593,6 +593,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
 	unwind_init();
+	set_current(current);
 
 	init_environ();
 	efi_init();
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 64a048f1b880..fd7b4abf0f3e 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -400,8 +400,9 @@ void loongson_boot_secondary(int cpu, struct task_struct *idle)
 	pr_info("Booting CPU#%d...\n", cpu);
 
 	entry = __pa_symbol((unsigned long)&smpboot_entry);
-	cpuboot_data.stack = (unsigned long)__KSTK_TOS(idle);
-	cpuboot_data.thread_info = (unsigned long)task_thread_info(idle);
+	cpuboot_data.stack = (unsigned long)task_pt_regs(idle);
+	cpuboot_data.task = (unsigned long)idle;
+	cpuboot_data.offset = per_cpu_offset(cpu);
 
 	csr_mail_send(entry, cpu_logical_map(cpu), 0);
 
@@ -663,6 +664,7 @@ asmlinkage void start_secondary(void)
 	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	cpu_probe();
+	set_current(current);
 	constant_clockevent_init();
 	loongson_init_secondary();
 
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index f377d8f5c51a..d6e0d05d6fd3 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -12,7 +12,7 @@
 
 /*
  * task_struct *__switch_to(task_struct *prev, task_struct *next,
- *			    struct thread_info *next_ti, void *sched_ra, void *sched_cfa)
+ *			    void *sched_ra, void *sched_cfa)
  */
 	.align	5
 SYM_FUNC_START(__switch_to)
@@ -24,8 +24,8 @@ SYM_FUNC_START(__switch_to)
 	LONG_SPTR	t1, a0, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
 
 	cpu_save_nonscratch a0
-	LONG_SPTR	a3, a0, (THREAD_SCHED_RA - TASK_STRUCT_OFFSET)
-	LONG_SPTR	a4, a0, (THREAD_SCHED_CFA - TASK_STRUCT_OFFSET)
+	LONG_SPTR	a2, a0, (THREAD_SCHED_RA - TASK_STRUCT_OFFSET)
+	LONG_SPTR	a3, a0, (THREAD_SCHED_CFA - TASK_STRUCT_OFFSET)
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	la		t7, __stack_chk_guard
@@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
 	LONG_SPTR	t8, t7, 0
 #endif
 
-	move	tp, a2
+	move		tp, a1
 	cpu_restore_nonscratch a1
 
-	li.w		t0, _THREAD_SIZE
-	PTR_ADD		t0, t0, tp
+	LONG_LPTR	t0, a1, (TASK_STACK - TASK_STRUCT_OFFSET)
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
 	set_saved_sp	t0, t1, t2
 
 	LONG_LPTR	t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
@@ -45,6 +46,7 @@ SYM_FUNC_START(__switch_to)
 
 #ifdef CONFIG_32BIT
 	PTR_ADDI	a0, a0, -TASK_STRUCT_OFFSET
+	PTR_ADDI	tp, tp, -TASK_STRUCT_OFFSET
 #endif
 	jr	ra
 SYM_FUNC_END(__switch_to)
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 5d49b742e3bf..7e4206da4876 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -90,6 +90,9 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 	if (!task)
 		task = current;
 
+	if (!try_get_task_stack(task))
+		return;
+
 	printk("%sCall Trace:", loglvl);
 	for (unwind_start(&state, task, pregs);
 	      !unwind_done(&state); unwind_next_frame(&state)) {
@@ -97,6 +100,8 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 		print_ip_sym(loglvl, addr);
 	}
 	printk("%s\n", loglvl);
+
+	put_task_stack(task);
 }
 
 static void show_stacktrace(struct task_struct *task,
-- 
2.42.0

