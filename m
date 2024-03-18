Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23892E413
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754313; cv=none; b=Jp1iB7FT4QG9GT5KA2gKEgcaIoMcPv3eZLe7GoEhLEjO0gl+jctXqJP+E+fQo8qBg2uiYgeX/A/PAnf4Ss1unV5QqAh4byecygvi4+q3R78NqCy+b+hy9O5CAzC05vE/Wow0yZwg1O9dRv4+OoPQ/xvGumKKVBc/bu7GQwO3EV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754313; c=relaxed/simple;
	bh=sJtRldE1jKSykBRamDo7kUT1GdmxrO/Lg8QfvT88p2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS0qsRszXKoljSvQiBnKinL6XrBHX+1JNvGwXbnD8HohnH3aG/Vor5NtDlGGgYWywln8L9CYFuxvlrPl2qUO7HIlwesfq+Eui7neG7y7UvBPS7dAdtxyL8EEDcnH6pkFZ/UETJCbh8CmW5vvlfFfRTGrS/WEDxYYnWzKi/fTS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVqV8p4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVqV8p4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D53C433F1;
	Mon, 18 Mar 2024 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754313;
	bh=sJtRldE1jKSykBRamDo7kUT1GdmxrO/Lg8QfvT88p2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVqV8p4VocPWsC7LvYsReF6AvmEbDJl3KXUsnqKpYpnSOaU2BDrF5pU0BhGLsfAyA
	 0tHLO3clyQR1FEXPi1ZqjmDdxq7QAM6NjHaeLzPQ59LUyJ5hGFAzfGqd7VCYMnM6gZ
	 RN7P9FfxRHjO6YpU6P+6vxlLRdwUjjX7UE6kamJN3JOMNW3gWEFtjvGHKrjgFt6cNE
	 2Nqqbxih6ReK8r8Htp81SbS88UN1OwkQ8bk/OIrH3rdw6R9cXg1ZVziY297rmPkYS5
	 npLgUgL905TTmctKE3TvbeyBM2D4VaWTQIldgMW8Ozh8oVBKuTVb24yAt7XKjG3j7I
	 7SXjPEfyoRMrw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed up return probe
Date: Mon, 18 Mar 2024 10:31:36 +0100
Message-ID: <20240318093139.293497-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093139.293497-1-jolsa@kernel.org>
References: <20240318093139.293497-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding uretprobe syscall instead of trap to speed up return probe.

At the moment the uretprobe setup/path is:

  - install entry uprobe

  - when the uprobe is hit overwrite probed function's return address on stack
    with address of the trampoline that contains breakpoint instruction

  - the breakpoint trap code handles the uretprobe consumers execution and
    jumps back to original return address

This patch changes the above trampoline's breakpoint instruction to new
ureprobe syscall call. This syscall does exactly the same job as the trap
with some extra work:

  - syscall trampoline must save original value for rax/r11/rcx registers
    on stack - rax is set to syscall number and r11/rcx are changed and
    used by syscall instruction

  - the syscall code reads the original values of those registers and restore
    those values in task's pt_regs area

Even with the extra registers handling code the having uretprobes handled
by syscalls shows speed improvement.

  On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)

  current:

    base           :   15.173 ± 0.052M/s
    uprobe-nop     :    2.797 ± 0.090M/s
    uprobe-push    :    2.580 ± 0.007M/s
    uprobe-ret     :    1.001 ± 0.003M/s
    uretprobe-nop  :    1.373 ± 0.002M/s
    uretprobe-push :    1.346 ± 0.002M/s
    uretprobe-ret  :    0.747 ± 0.001M/s

  with the fix:

    base           :   15.704 ± 0.076M/s
    uprobe-nop     :    2.841 ± 0.008M/s
    uprobe-push    :    2.666 ± 0.029M/s
    uprobe-ret     :    1.037 ± 0.008M/s
    uretprobe-nop  :    1.718 ± 0.010M/s  < ~25% speed up
    uretprobe-push :    1.658 ± 0.008M/s  < ~23% speed up
    uretprobe-ret  :    0.853 ± 0.004M/s  < ~14% speed up

  On Amd (AMD Ryzen 7 5700U)

  current:

    base           :    5.702 ± 0.003M/s
    uprobe-nop     :    1.505 ± 0.011M/s
    uprobe-push    :    1.388 ± 0.008M/s
    uprobe-ret     :    0.825 ± 0.001M/s
    uretprobe-nop  :    0.782 ± 0.001M/s
    uretprobe-push :    0.750 ± 0.001M/s
    uretprobe-ret  :    0.544 ± 0.001M/s

  with the fix:

    base           :    5.669 ± 0.004M/s
    uprobe-nop     :    1.539 ± 0.001M/s
    uprobe-push    :    1.385 ± 0.003M/s
    uprobe-ret     :    0.819 ± 0.001M/s
    uretprobe-nop  :    0.889 ± 0.001M/s < ~13% speed up
    uretprobe-push :    0.846 ± 0.001M/s < ~12% speed up
    uretprobe-ret  :    0.594 ± 0.000M/s <  ~9% speed up

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/kernel/uprobes.c              | 48 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  2 ++
 include/linux/uprobes.h                |  2 ++
 include/uapi/asm-generic/unistd.h      |  5 ++-
 kernel/events/uprobes.c                | 18 +++++++---
 kernel/sys_ni.c                        |  2 ++
 7 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..af0a33ab06ee 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462	64	uretprobe		sys_uretprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6c07f6daaa22..069371e86180 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -12,6 +12,7 @@
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
+#include <linux/syscalls.h>
 
 #include <linux/kdebug.h>
 #include <asm/processor.h>
@@ -308,6 +309,53 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 }
 
 #ifdef CONFIG_X86_64
+
+asm (
+	".pushsection .rodata\n"
+	".global uretprobe_syscall_entry\n"
+	"uretprobe_syscall_entry:\n"
+	"pushq %rax\n"
+	"pushq %rcx\n"
+	"pushq %r11\n"
+	"movq $462, %rax\n"
+	"syscall\n"
+	".global uretprobe_syscall_end\n"
+	"uretprobe_syscall_end:\n"
+	".popsection\n"
+);
+
+extern u8 uretprobe_syscall_entry[];
+extern u8 uretprobe_syscall_end[];
+
+void *arch_uprobe_trampoline(unsigned long *psize)
+{
+	*psize = uretprobe_syscall_end - uretprobe_syscall_entry;
+	return uretprobe_syscall_entry;
+}
+
+SYSCALL_DEFINE0(uretprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long sregs[3], err;
+
+	/*
+	 * We set rax and syscall itself changes rcx and r11, so the syscall
+	 * trampoline saves their original values on stack. We need to read
+	 * them and set original register values and fix the rsp pointer back.
+	 */
+	err = copy_from_user((void *) &sregs, (void *) regs->sp, sizeof(sregs));
+	WARN_ON_ONCE(err);
+
+	regs->r11 = sregs[0];
+	regs->cx = sregs[1];
+	regs->ax = sregs[2];
+	regs->orig_ax = -1;
+	regs->sp += sizeof(sregs);
+
+	uprobe_handle_trampoline(regs);
+	return regs->ax;
+}
+
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..db150794f89d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 /* x86 */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
+asmlinkage long sys_uretprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..a490146ad89d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern void uprobe_handle_trampoline(struct pt_regs *regs);
+extern void *arch_uprobe_trampoline(unsigned long *psize);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..8a747cd1d735 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_uretprobe 462
+__SYSCALL(__NR_uretprobe, sys_uretprobe)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 929e98c62965..90395b16bde0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
+void * __weak arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	unsigned long insns_size;
 	struct xol_area *area;
+	void *insns;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
-	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
+	insns = arch_uprobe_trampoline(&insns_size);
+	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
 		return area;
@@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 	return ri;
 }
 
-static void handle_trampoline(struct pt_regs *regs)
+void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
@@ -2188,7 +2198,7 @@ static void handle_swbp(struct pt_regs *regs)
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
-		return handle_trampoline(regs);
+		return uprobe_handle_trampoline(regs);
 
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..be6195e0d078 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+COND_SYSCALL(uretprobe);
-- 
2.44.0

