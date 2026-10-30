Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342227;
	b=kSkYHzOy5RHX1uSJzBgmAqaLY+yb74px466XoByJ7qst5FJXR36hvuR42k9BF2X9O3XK
	 FCYDUZO+cE52TNfSRMKoOF5yRz6woJKefMBhOjSrg7M8FK48kiL/l1NvM+g/iRwJgLCN8
	 qBZjF+TtbU5EOTWTyYN9f9g2cL75BY0hail1lcHAAViS81vgSmTYK+T+p+QX64SGvz7Oi
	 ycPiz4VORQ6lnMa8/7EIdlKbYWiNrliayxOwVDfIY1e5yxqLZwXIoBKoBhjm5yzNMlJ2D
	 MVb5jBuvrFgxdlYqsTUiZtqn0pc001esqEMTgXtj1cg6HREfX82UADNdKIYlMH1xKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342227;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Bo4ZhhQq3yMt0wv9i4UwU4CIn7AaRsfAQO0VX/Sm23w=;
	b=GSpZU8L1ozdix5SstsUp9NDhwRsPp2l3fNlJP+MTX8ZWQKG5mOg/iNHxguoOH2V+D+o3
	 1plF4mf1yJ85fsq1KSdIN41BVbhUiQ9qIh8tZGHA416JJMGKNxMWWF+1Rme//CxXMy28x
	 eJhWOtOKx34OtNrVjsnedLCknvBjESYnItUPi0z330SdSipBsAKGDrNW9NVc2OgFR4ZeT
	 FfGJaPzTskCCKqFCoeeVZ62lgVkQETUvd0zm7z9JlobeLkWiMMv5nVw4XTuuk6kg6VDQk
	 ekniP/9IVU18b/zAmXiGSAd3PWwQwuVulEeCxb37SRyraw9YslT3z5BASaDJOPrMJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C139ypLQ;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A65606A31A;
	Fri, 30 Oct 2026 06:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C139ypLQ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Bo4ZhhQq3yMt0wv9i4UwU4CIn7AaRsfAQO0VX/Sm23w=;
	b=C139ypLQc7vC7rupszvT/Imlc/LVfT7OLVXviMfG7SGjw0epOcAM46mKxRl+FmB/yMKBallky
	32HSMDaDTLP25vR6NVIXMzRwvjNiqrRIiHyTlgXc3kHBWPWbQbsDnttKYVIhPO+SySmG4VgP+uh
	APdoB0Y0CRFo93U+zgvvi7g=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jGBGL1gmGz1K9VX;
	Fri, 30 Oct 2026 14:36:58 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E92AB4055B;
	Fri, 30 Oct 2026 14:36:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 30 Oct
 2026 14:36:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <linux@armlinux.org.uk>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <shuah@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <stevenrwalter@gmail.com>, <will@kernel.org>,
	<wade_farnsworth@mentor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <bpf@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/2] ARM: ptrace: Fix seccomp seeing stale syscall arguments
Date: Fri, 30 Oct 2026 14:36:29 +0800
Message-ID: <20261030063630.1218302-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030063630.1218302-1-ruanjinjie@huawei.com>
References: <20261030063630.1218302-1-ruanjinjie@huawei.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

[Background]
When user space enters a syscall, the ARM entry code copies r0 into
ARM_ORIG_r0.  r0 carries the first syscall argument, but the syscall
also returns its value in r0, so the kernel keeps a copy.

4 places use the first argument:
 - seccomp and the sys_enter tracepoint read ARM_ORIG_r0, through
   syscall_get_arguments();
 - audit_syscall_entry() reads r0;
 - the syscall itself runs with r0;
 - do_signal() copies ARM_ORIG_r0 back into r0 when a syscall restarts.

[The problem]
A tracer can change r0 while the tracee is stopped before the syscall
runs, at a syscall-entry stop (PTRACE_SETREGS, PTRACE_POKEUSR) or at a
SECCOMP_RET_TRACE stop.  Only r0 changes then, so ARM_ORIG_r0 keeps the
old value:
 - seccomp and the tracepoint see the old argument, while the syscall
   runs with the new one.  With SECCOMP_RET_TRACE this is easy to hit:
   the tracer changes the argument, the filters run again, and they
   still match on the old value;
 - a syscall that returns -ERESTARTSYS restarts with the old argument,
   because the restart path copies ARM_ORIG_r0 into r0.

A tracer that uses SECCOMP_RET_TRACE to check syscalls changes the
first argument at the PTRACE_EVENT_SECCOMP stop, and expects
the filters that run again to see the new value.

arm64 has the same problem and fixed in commit 88b839ce497c ("arm64:
ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry").

x86 does not have this problem.  32-bit x86 saves only the syscall
number in orig_ax, and every reader gets it back with syscall_get_nr():

  do_int80_emulation()
    -> regs->orig_ax = regs->ax & GENMASK(31, 0)
       regs->ax = -ENOSYS
    -> nr = syscall_32_enter()
       -> regs->orig_ax
    -> nr = syscall_enter_from_user_mode_work(regs, &nr)
         -> syscall_trace_enter()
              -> arch_ptrace_report_syscall_permit_entry()
              -> __seccomp_permit_syscall()
                 -> syscall_get_nr() -> regs->orig_ax
              -> trace_syscall_enter()
                 -> syscall_get_nr() -> regs->orig_ax
              -> syscall_enter_audit()
                  -> syscall_get_nr() -> regs->orig_ax
         -> nr = syscall_get_nr() -> regs->orig_ax
    -> do_syscall_32_irqs_on(regs, nr) // Use orig_ax as the system call number
                                       // to execute the system call. This is\
                                       // consistent with seccomp, audit, and
                                       // tracepoint.

arm32 instead has two copies of the first argument.  seccomp and the
tracepoints read one copy, and the syscall runs with the other:

  vector_swi
    -> str r0, [sp, #S_OLD_R0]          // backup r0 to ARM_ORIG_r0
    -> syscall_trace_enter()
         -> report_syscall()
         -> seccomp_permit_syscall()
              -> syscall_get_arguments() -> ARM_ORIG_r0
         -> trace_sys_enter()
              -> syscall_get_arguments() -> ARM_ORIG_r0
         -> audit_syscall_entry(scno, ARM_r0, ARM_r1, ARM_r2, ARM_r3)
				      ^^^^^^
    -> invoke_syscall, reload r0-r6
       -> use r0 here!
             ^^^^

So after a tracer changes r0, seccomp and the tracepoints still read the
old ARM_ORIG_r0, audit reads the new ARM_r0, and the syscall runs with
the new ARM_r0.

riscv and loongarch also keep a copy of the first argument (orig_a0),
but they pass that copy to both the syscall and
syscall_get_arguments(), so they stay consistent.  On arm32 the syscall
runs with a different register than the one seccomp and the tracepoints
read.

The syscall number has a similar copy (abi_syscall), but there the
readers and the dispatcher both use syscall_get_nr(), so only the first
argument is affected.

[Fix]
Copy r0 into ARM_ORIG_r0 after a ptrace register write, but only when
the tracee is stopped before its syscall runs:
 - at a syscall-entry stop or a SECCOMP_RET_TRACE stop, r0 still holds
   the first argument, and seccomp, the tracepoints, audit and the
   syscall itself are about to read it;
 - at a syscall-exit stop, r0 holds the return value (-ERESTARTSYS and
   friends).  ARM_ORIG_r0 must stay, or a restarted syscall would run
   with the error code as its first argument;
 - for any other exception, the entry code sets ARM_ORIG_r0 to ~0 and it
   has no meaning, so it must not be overwritten.

The stop type is the same classification that
ptrace_get_syscall_info_op() uses for PTRACE_GET_SYSCALL_INFO.

audit_syscall_entry() takes the first argument from r0 directly.  Give
it ARM_ORIG_r0, as seccomp and the tracepoints do, so audit describes
the syscall that really runs.

Tested on arm32 with a real gdb in qemu-system-arm: after
"catch syscall getpid" the tracer sets r0 to a value the seccomp filter
rejects.  With this patch the filter refuses the syscall, without it the
syscall runs with the old argument.

Cc: stable@vger.kernel.org
Fixes: bf2c9f986692 ("ARM: 7373/1: add support for the generic syscall.h interface")
Link: https://lore.kernel.org/all/al98jdcleu-6tMDL@willie-the-truck/
Suggested-by: Will Deacon <will@kernel.org>
Link: https://lkml.org/lkml/2020/9/11/1282
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/ptrace.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ed7a2a87a670..6ec81e5a205e 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -163,6 +163,42 @@ static inline long get_user_reg(struct task_struct *task, int offset)
 	return task_pt_regs(task)->uregs[offset];
 }
 
+/*
+ * Is @target stopped after entering a syscall, but before it has been
+ * dispatched?  This is the same classification that
+ * ptrace_get_syscall_info_op() performs for PTRACE_GET_SYSCALL_INFO.
+ */
+static bool stopped_in_syscall_entry(struct task_struct *target)
+{
+	struct kernel_siginfo *info = target->last_siginfo;
+
+	if (!info)
+		return false;
+
+	if (info->si_code == (SIGTRAP | 0x80))
+		return target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY;
+
+	return info->si_code == (SIGTRAP | (PTRACE_EVENT_SECCOMP << 8));
+}
+
+static void update_syscall_orig_r0_after_ptrace(struct task_struct *target)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+
+	/*
+	 * ARM_r0 holds the first syscall argument only before the syscall is
+	 * dispatched; seccomp, the syscall tracepoints and the syscall restart
+	 * code all read that argument from ARM_ORIG_r0 instead.  At a syscall
+	 * exit stop ARM_r0 holds the return value and must not be copied, and
+	 * for other exceptions ARM_ORIG_r0 is set to ~0 and carries no
+	 * meaning.
+	 */
+	if (!stopped_in_syscall_entry(target))
+		return;
+
+	regs->ARM_ORIG_r0 = regs->ARM_r0;
+}
+
 /*
  * this routine will put a word on the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
@@ -180,6 +216,8 @@ put_user_reg(struct task_struct *task, int offset, long data)
 
 	if (valid_user_regs(&newregs)) {
 		regs->uregs[offset] = data;
+		if (offset == 0)
+			update_syscall_orig_r0_after_ptrace(task);
 		ret = 0;
 	}
 
@@ -566,6 +604,7 @@ static int gpr_set(struct task_struct *target,
 		return -EINVAL;
 
 	*task_pt_regs(target) = newregs;
+	update_syscall_orig_r0_after_ptrace(target);
 	return 0;
 }
 
@@ -868,7 +907,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, scno);
 
-	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
+	audit_syscall_entry(scno, regs->ARM_ORIG_r0, regs->ARM_r1, regs->ARM_r2,
 			    regs->ARM_r3);
 
 	return scno;
-- 
2.34.1

