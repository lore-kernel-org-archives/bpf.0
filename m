Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342229;
	b=xl2FxOjvIIj2bPxM0P/qlXvdBmU36WERG13lLYf3+UK86BSe7UXAmcEEdvwNnVmKcUeI
	 OD4Nu18dCHe2QJvcMAJHctHoWHQ5bKluXCyYp/3RDuAvCvIQeHRLo/9C/M4aeeCWTHM3T
	 ciUXjbyFVo0cqVkeW37FL8rBsN3+qYcZJB+97+rTku02XWzCTpQN0aIEOoj15lsObRJdu
	 tbvqW+KOhzOC4cJ6j+yrjw4V/b/B3SAfnkIcrlq7jCByjS7XUIF/5OvhMXGyOYuOPos2p
	 4WIoPU445S4SJd18i6cCIS1/+6JDfkje/lqGrzrlX8MG9R6X7ip6TOnId15yn0ESlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342229;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=lLdiCZ1t8iPKIkvkT7nxcTkrKzmAM4/58e2AuZ79qPQ=;
	b=R+LsYfEh1rNm3491JBBFVehKxCRV+v7xZV1yhMBV80tGHDjBSicPzWLAgXwB2lmClMmq
	 ObWcUWlxp6pv9w+4XPNPMJOvZuZMIA04xtmn2QDm4Xd05DdUVvb2CbscUZEKomWhmhvTE
	 8lPj8rF0Y7QQNowcIRg/EKbt4d5oHkCy+VTyyNchvJWfwgojRhCgZwmTXrePTl5vbaVTT
	 HNpwDuUeOmiycIxHOSfopTmHOeLuR1LpE5pz6BaTL3lZ7pDLGFQRf8vx7vK+r7s1o7mkS
	 Ah2QwnL8fOsj8Yxxo4sjq804BMJAI1Kt9bh8Ssfepw5mCQF8f8gUiZBVkWAUJsDuPMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Yr9KhDr;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AF606A31D;
	Fri, 30 Oct 2026 06:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E0AF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Yr9KhDr
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lLdiCZ1t8iPKIkvkT7nxcTkrKzmAM4/58e2AuZ79qPQ=;
	b=5Yr9KhDrTEMj9KB3ai/HE/jo+6Hm8/qgQ7h5js+KUmhYFYruSNHtc8usDQrpsp2ngt9sb/Fja
	uAtz0GPlWxToxPYhKl3BrG540BJ4TrXtkpjzvSC2qVAUY+SQti60JR5O9NPuuAnH1Y28OseVFih
	yvypkIAW8fjuEnoTms8Asjs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jGBGF0F6PzmV6h;
	Fri, 30 Oct 2026 14:36:53 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 89A5240586;
	Fri, 30 Oct 2026 14:37:00 +0800 (CST)
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
Subject: [PATCH v2 2/2] selftests/seccomp: Add tests for syscall argument rewrite
Date: Fri, 30 Oct 2026 14:36:30 +0800
Message-ID: <20261030063630.1218302-3-ruanjinjie@huawei.com>
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

A tracer can change a syscall argument at two stops:

 - at a SECCOMP_RET_TRACE stop, the tracer runs first and the kernel
   checks the filters again after it;
 - at a PTRACE_SYSCALL entry stop, the tracer runs first and seccomp
   runs after it.

In both cases seccomp must see the new argument, because the syscall is
executed with the new value.

The seccomp selftests (TRACE_syscall) change the syscall number and the
return value, but not the arguments.  arm64 has two architecture
specific tests for x0, seccomp_ptrace_x0_bypass.c for the
syscall-entry stop and seccomp_ret_trace_x0_bypass.c for the
SECCOMP_RET_TRACE stop, in tools/testing/selftests/arm64/abi/, but they
run on arm64 only.

These tests call getpid() with a known first argument and install a
filter that rejects the value the tracer writes.  The return value of
getpid() shows which argument the filter saw.  They run on arm32, arm64,
x86-64 and i386, and they cover both stops above.

riscv and loongarch skip: the kernel gives orig_a0, not a0, to both the
syscall and seccomp, so a0 is not the argument register there.

Two tests run on arm32 only:
 - a syscall that returns -ERESTARTSYS and is restarted must run with the
   first argument from the entry, not with the error value;
 - a stop outside a syscall must not change ARM_ORIG_r0, which is ~0
   there.

The first two tests catch the arm32 bug where seccomp sees the old
first argument.

The tests were written with assistance from DeepSeek V4.1 Flash.

Tested on QEMU for arm32 and arm64, and on hardware for x86-64 and i386
(passed/total):
 - arm32: 4/4
 - arm64: 3/3
 - x86-64: 3/3
 - i386: 3/3

No case runs on riscv64 or loongarch64: the test skips there for the
reason above.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 tools/testing/selftests/seccomp/.gitignore    |   1 +
 tools/testing/selftests/seccomp/Makefile      |   2 +-
 .../selftests/seccomp/seccomp_ptrace_args.c   | 463 ++++++++++++++++++
 3 files changed, 465 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/seccomp/seccomp_ptrace_args.c

diff --git a/tools/testing/selftests/seccomp/.gitignore b/tools/testing/selftests/seccomp/.gitignore
index dec678577f9c..ea60bb76136b 100644
--- a/tools/testing/selftests/seccomp/.gitignore
+++ b/tools/testing/selftests/seccomp/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 seccomp_bpf
 seccomp_benchmark
+seccomp_ptrace_args
diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 584fba487037..4232068a9bd8 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -3,5 +3,5 @@ CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark seccomp_ptrace_args
 include ../lib.mk
diff --git a/tools/testing/selftests/seccomp/seccomp_ptrace_args.c b/tools/testing/selftests/seccomp/seccomp_ptrace_args.c
new file mode 100644
index 000000000000..e2e6df54e974
--- /dev/null
+++ b/tools/testing/selftests/seccomp/seccomp_ptrace_args.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check that the syscall arguments a ptrace tracer rewrites are the ones
+ * seccomp observes.
+ *
+ * A tracer can rewrite the syscall arguments at a SECCOMP_RET_TRACE stop
+ * (the syscall is re-evaluated afterwards) and at a PTRACE_SYSCALL entry
+ * stop (seccomp runs after ptrace on the entry path).  In both cases the
+ * filters and the tracepoint of the syscall that is actually executed have
+ * to see the rewritten value.
+ *
+ * On arm32 the first syscall argument is copied into ARM_ORIG_r0 when the
+ * syscall is entered because r0 is clobbered by the return value on the way
+ * out; seccomp reads that copy through syscall_get_arguments().  A tracer
+ * write to r0 therefore has to be mirrored into ARM_ORIG_r0 by the kernel.
+ * The same register also feeds the syscall restart path, so stops at which
+ * ARM_ORIG_r0 does not carry a syscall argument must be left alone.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <linux/audit.h>
+#include <linux/filter.h>
+#include <linux/ptrace.h>
+#include <linux/seccomp.h>
+#include <elf.h>
+#include <sys/uio.h>
+#if defined(__arm__) || defined(__aarch64__)
+#include <asm/ptrace.h>
+#endif
+
+#include "kselftest_harness.h"
+
+#ifndef __NR_getpid
+#define __NR_getpid 20
+#endif
+
+/* The first argument the tracee passes to getpid(). */
+#define VAL_ORIG	0x11112222UL
+/* The first argument the tracer rewrites it to. */
+#define VAL_NEW		0x33334444UL
+#define ERRNO_MARK	0x7f
+#define TRACE_MARK	0x1001
+
+#if defined(__arm__)
+#define NATIVE_AUDIT_ARCH	AUDIT_ARCH_ARM
+#elif defined(__aarch64__)
+#define NATIVE_AUDIT_ARCH	AUDIT_ARCH_AARCH64
+#elif defined(__x86_64__)
+#define NATIVE_AUDIT_ARCH	AUDIT_ARCH_X86_64
+#elif defined(__i386__)
+#define NATIVE_AUDIT_ARCH	AUDIT_ARCH_I386
+#endif
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define syscall_arg0	offsetof(struct seccomp_data, args[0])
+#else
+#define syscall_arg0	(offsetof(struct seccomp_data, args[0]) + sizeof(__u32))
+#endif
+
+#if defined(__arm__)
+# define HAVE_ARG0		1
+# define HAVE_ORIG_ARG0		1
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_ARG0(_regs)	((_regs).ARM_r0)
+# define SYSCALL_ARG0_ORIG(_regs) ((_regs).ARM_ORIG_r0)
+# define SYSCALL_RET_SET(_regs, _val) ((_regs).ARM_r0 = (_val))
+#elif defined(__x86_64__)
+# define HAVE_ARG0		1
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_ARG0(_regs)	((_regs).rdi)
+# define SYSCALL_RET_SET(_regs, _val) ((_regs).rax = (_val))
+#elif defined(__i386__)
+# define HAVE_ARG0		1
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_ARG0(_regs)	((_regs).ebx)
+# define SYSCALL_RET_SET(_regs, _val) ((_regs).eax = (_val))
+#elif defined(__aarch64__)
+# define HAVE_ARG0		1
+# define USE_REGSET		1
+# define ARCH_REGS		struct user_pt_regs
+# define SYSCALL_ARG0(_regs)	((_regs).regs[0])
+# define SYSCALL_RET_SET(_regs, _val) ((_regs).regs[0] = (_val))
+/*
+ * riscv and loongarch are deliberately left out: they hand orig_a0, not
+ * a0, to the syscall and to syscall_get_arguments(), so the register this
+ * test rewrites is not the one the syscall runs with.
+ */
+#endif
+
+#ifdef HAVE_ARG0
+
+/* getpid(VAL_NEW) is refused, getpid(VAL_ORIG) is traced. */
+static const struct sock_filter filter_trace[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, arch)),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, NATIVE_AUDIT_ARCH, 0, 7),
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_getpid, 0, 6),
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_arg0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, VAL_NEW, 0, 1),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ERRNO | ERRNO_MARK),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, VAL_ORIG, 0, 2),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRACE | TRACE_MARK),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+};
+
+/* getpid(VAL_NEW) is refused, anything else is allowed. */
+static const struct sock_filter filter_allow[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, arch)),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, NATIVE_AUDIT_ARCH, 0, 6),
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_getpid, 0, 3),
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_arg0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, VAL_NEW, 0, 1),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ERRNO | ERRNO_MARK),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
+};
+
+#define ERESTARTSYS	512
+
+static int install_filter(const struct sock_filter *filter, unsigned int count)
+{
+	struct sock_fprog prog = {
+		.len = (unsigned short)count,
+		.filter = (struct sock_filter *)filter,
+	};
+
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+		return -1;
+
+	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+}
+
+static int get_regs(pid_t pid, ARCH_REGS *regs)
+{
+#ifdef USE_REGSET
+	struct iovec iov = {
+		.iov_base = regs,
+		.iov_len = sizeof(*regs),
+	};
+
+	return ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov);
+#else
+	return ptrace(PTRACE_GETREGS, pid, NULL, regs);
+#endif
+}
+
+static int set_regs(pid_t pid, ARCH_REGS *regs)
+{
+#ifdef USE_REGSET
+	struct iovec iov = {
+		.iov_base = regs,
+		.iov_len = sizeof(*regs),
+	};
+
+	return ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov);
+#else
+	return ptrace(PTRACE_SETREGS, pid, NULL, regs);
+#endif
+}
+
+static long get_syscall_info(pid_t pid, struct ptrace_syscall_info *info)
+{
+	return ptrace(PTRACE_GET_SYSCALL_INFO, pid, sizeof(*info), info);
+}
+
+/* waitpid() with a deadline, so that a kernel bug cannot hang the run. */
+static pid_t wait_for_stop(pid_t pid, int *status, int timeout_ms)
+{
+	while (timeout_ms-- > 0) {
+		pid_t ret = waitpid(pid, status, WNOHANG);
+
+		if (ret == pid)
+			return pid;
+		if (ret < 0 && errno != EINTR)
+			return ret;
+		usleep(1000);
+	}
+
+	return 0;
+}
+
+/* Fork a tracee that stops itself, then calls getpid(VAL_ORIG). */
+static pid_t spawn_tracee(const struct sock_filter *filter, unsigned int count)
+{
+	pid_t tracee = fork();
+
+	if (tracee != 0)
+		return tracee;
+
+	ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+	raise(SIGSTOP);
+	if (install_filter(filter, count))
+		_exit(2);
+	errno = 0;
+	if (syscall(__NR_getpid, VAL_ORIG) == -1 && errno == ERRNO_MARK)
+		_exit(0);	/* seccomp saw VAL_NEW */
+	_exit(1);		/* seccomp saw VAL_ORIG */
+}
+
+static void attach(struct __test_metadata *_metadata, pid_t tracee, long options)
+{
+	int status;
+
+	ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+		kill(tracee, SIGKILL);
+	}
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_EQ(0, ptrace(PTRACE_SETOPTIONS, tracee, NULL,
+			    options | PTRACE_O_EXITKILL));
+}
+
+/*
+ * The tracer rewrites the first argument at the PTRACE_EVENT_SECCOMP stop.
+ * The syscall is re-evaluated after the stop, so the filter runs again with
+ * the new value and refuses it.
+ */
+TEST(seccomp_trace_stop_sees_rewritten_arg)
+{
+	pid_t tracee = spawn_tracee(filter_trace, ARRAY_SIZE(filter_trace));
+	int status;
+
+	ASSERT_GE(tracee, 0);
+	attach(_metadata, tracee,
+	       PTRACE_O_TRACESECCOMP | PTRACE_O_TRACESYSGOOD);
+	ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, NULL));
+
+	for (;;) {
+		ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+			kill(tracee, SIGKILL);
+		}
+		if (WIFEXITED(status))
+			break;
+		ASSERT_FALSE(WIFSIGNALED(status));
+
+		if ((status >> 8) ==
+		    (SIGTRAP | (PTRACE_EVENT_SECCOMP << 8))) {
+			ARCH_REGS regs;
+
+			ASSERT_EQ(0, get_regs(tracee, &regs));
+			SYSCALL_ARG0(regs) = VAL_NEW;
+			ASSERT_EQ(0, set_regs(tracee, &regs));
+		}
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, NULL));
+	}
+
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/*
+ * The tracer rewrites the first argument at the syscall-entry stop.  seccomp
+ * runs after ptrace, so the filter has to see the new value.
+ */
+TEST(syscall_entry_stop_sees_rewritten_arg)
+{
+	pid_t tracee = spawn_tracee(filter_allow, ARRAY_SIZE(filter_allow));
+	int status, poked = 0;
+
+	ASSERT_GE(tracee, 0);
+	attach(_metadata, tracee, PTRACE_O_TRACESYSGOOD);
+	ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
+
+	for (;;) {
+		struct ptrace_syscall_info info;
+		long len;
+
+		ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+			kill(tracee, SIGKILL);
+		}
+		if (WIFEXITED(status))
+			break;
+		ASSERT_FALSE(WIFSIGNALED(status));
+
+		len = get_syscall_info(tracee, &info);
+		if (len < 0) {
+			kill(tracee, SIGKILL);
+			SKIP(return, "PTRACE_GET_SYSCALL_INFO unsupported");
+		}
+		if (!poked && info.op == PTRACE_SYSCALL_INFO_ENTRY &&
+		    info.entry.nr == __NR_getpid) {
+			ARCH_REGS regs;
+
+			ASSERT_EQ(0, get_regs(tracee, &regs));
+			SYSCALL_ARG0(regs) = VAL_NEW;
+			ASSERT_EQ(0, set_regs(tracee, &regs));
+			poked = 1;
+		}
+		ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
+	}
+
+	EXPECT_EQ(1, poked);
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+static void sighandler(int sig)
+{
+	(void)sig;
+}
+
+/*
+ * The tracer makes write() return -ERESTARTSYS at the syscall-exit stop and
+ * delivers a signal with SA_RESTART.  The syscall restarts with the first
+ * argument as it was when the syscall was entered, so the restarted write
+ * still reaches the pipe.  If the return value had replaced the argument,
+ * write() would fail with EBADF instead.
+ */
+TEST(syscall_exit_stop_preserves_arg_for_restart)
+{
+	int pipefd[2];
+	struct sigaction sa = {
+		.sa_handler = sighandler,
+		.sa_flags = SA_RESTART,
+	};
+	pid_t tracee;
+	long last_nr = -1;
+	int status, poked = 0;
+
+	ASSERT_EQ(0, pipe(pipefd));
+
+	tracee = fork();
+	ASSERT_GE(tracee, 0);
+	if (tracee == 0) {
+		close(pipefd[0]);
+		sigaction(SIGUSR1, &sa, NULL);
+		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+		raise(SIGSTOP);
+		_exit(write(pipefd[1], "x", 1) == 1 ? 0 : 1);
+	}
+	close(pipefd[1]);
+
+	attach(_metadata, tracee, PTRACE_O_TRACESYSGOOD);
+	ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
+
+	for (;;) {
+		struct ptrace_syscall_info info;
+		long len;
+
+		ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+			kill(tracee, SIGKILL);
+		}
+		if (WIFEXITED(status))
+			break;
+		ASSERT_FALSE(WIFSIGNALED(status));
+
+		len = get_syscall_info(tracee, &info);
+		if (len < 0) {
+			kill(tracee, SIGKILL);
+			SKIP(return, "PTRACE_GET_SYSCALL_INFO unsupported");
+		}
+		if (info.op == PTRACE_SYSCALL_INFO_ENTRY)
+			last_nr = info.entry.nr;
+		if (!poked && info.op == PTRACE_SYSCALL_INFO_EXIT &&
+		    last_nr == __NR_write) {
+			ARCH_REGS regs;
+
+			ASSERT_EQ(0, get_regs(tracee, &regs));
+			SYSCALL_RET_SET(regs, -ERESTARTSYS);
+			ASSERT_EQ(0, set_regs(tracee, &regs));
+			poked = 1;
+			/* resume into the restart path */
+			ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL,
+					    SIGUSR1));
+			continue;
+		}
+		ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
+	}
+
+	close(pipefd[0]);
+	EXPECT_EQ(1, poked);
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+#ifdef HAVE_ORIG_ARG0
+
+/*
+ * The tracer rewrites r0 while the tracee is stopped on a signal delivered
+ * outside of a syscall, where ARM_ORIG_r0 holds the ~0 "no syscall" marker.
+ * The marker must not be replaced by the value the tracer wrote.
+ */
+TEST(non_syscall_stop_keeps_orig_arg)
+{
+	sig_atomic_t *got_signal = mmap(NULL, sizeof(*got_signal),
+					PROT_READ | PROT_WRITE,
+					MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	struct sigaction sa = {
+		.sa_handler = sighandler,
+	};
+	pid_t tracee;
+	int status;
+	ARCH_REGS regs;
+	unsigned long before;
+
+	ASSERT_TRUE(got_signal != MAP_FAILED);
+	ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
+
+	tracee = fork();
+	ASSERT_GE(tracee, 0);
+	if (tracee == 0) {
+		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+		raise(SIGSTOP);
+		/*
+		 * Spin in user mode so that the signal is not delivered on
+		 * the return path of a syscall.
+		 */
+		while (!__atomic_load_n(got_signal, __ATOMIC_RELAXED))
+			;
+		_exit(0);
+	}
+
+	__atomic_store_n(got_signal, 0, __ATOMIC_RELAXED);
+	attach(_metadata, tracee, 0);
+	ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, NULL));
+	usleep(200000);
+	ASSERT_EQ(0, kill(tracee, SIGUSR1));
+
+	ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+		kill(tracee, SIGKILL);
+	}
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_EQ(SIGUSR1, WSTOPSIG(status));
+
+	ASSERT_EQ(0, get_regs(tracee, &regs));
+	before = SYSCALL_ARG0_ORIG(regs);
+	SYSCALL_ARG0(regs) = 0xdeadbeefUL;
+	ASSERT_EQ(0, set_regs(tracee, &regs));
+	ASSERT_EQ(0, get_regs(tracee, &regs));
+
+	if (before == 0xffffffffUL)
+		EXPECT_EQ(before, (unsigned long)SYSCALL_ARG0_ORIG(regs));
+
+	__atomic_store_n(got_signal, 1, __ATOMIC_RELAXED);
+	ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, SIGUSR1));
+	ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
+		kill(tracee, SIGKILL);
+	}
+}
+
+#endif /* HAVE_ORIG_ARG0 */
+
+#else /* !HAVE_ARG0 */
+
+TEST(unsupported_arch)
+{
+	SKIP(return, "no syscall argument 0 accessor for this architecture");
+}
+
+#endif /* HAVE_ARG0 */
+
+TEST_HARNESS_MAIN
-- 
2.34.1

