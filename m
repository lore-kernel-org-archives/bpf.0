Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1C3E3165
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564038; cv=none; b=ovEp5HUpNwyk7MtMhdj26eH9Kj77x4bRdX6GJU46dhnjXFbR3Y9SHHO67pyngVdyLYq53PIIfdB+/qu7l/4d8Ma6LGjoDxf0PwBlCfex3QNLJ3XWnL1iP2X7bIrfvn0MxJvCEZmcnA2N9ULJtolQwX8KBcddG90TI9h3YaXurKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564038; c=relaxed/simple;
	bh=zh+PWWBumyjNQoqNmlFeILUqJEyvBvApeFkA+cmfv5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2K77U2I4ExbHw2FYDyHIQNUGfooAxdwn41e178kF4jvxkTWW7SA1i1CppUS+bi5+bjc5oZLD880lArn0swBxVNCo73srvJgmYWUMJ6W9SEuTsIes3czXRleNQAbjumEKY/NIBZeJ5TiBMryPdDU0Tdx8CyIBqtIW7pfkmOt2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IbG8nhMo; arc=none smtp.client-ip=95.215.58.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IbG8nhMo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zh+PWWBumyjNQoqNmlFeILUqJEyvBvApeFkA+cmfv5U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787564034; v=1; x=1788168834;
 b=IbG8nhMo2vg9r9tBI25lH79LbIqjZ8bp+ohjpbB+WJbyEe21beU41O0fHsUBZot1KsXpsR24
 0K0QUWCHiYpgByHBTOgkIZ53rXiPZmVx+EuzqWvqfM7q5tm4YByNilmgDcK69bwcAbsrKCjvLQf
 Y1qFHpltiyGW2YT7NuTeVwtg=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 5cb25e1fa7d6522b;
	Mon, 24 Aug 2026 09:33:54 +0000
X-Mizu-Trace-ID: 5cb25e1fa7d6522b
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Mon, 24 Aug 2026 17:29:55 +0800
Message-ID: <20260824093122.362135-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824093122.362135-1-jiayuan.chen@linux.dev>
References: <20260824093122.362135-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child joins a memcg capped 64M above its post-load usage and faults an
arena in until it runs out of that budget.

With the fix the arena page comes from the sleepable allocator, so
hitting memory.max goes through the memcg OOM path and the child is
OOM-killed, which the test checks via memory.events "oom_kill".

Without the fix the test may still pass, because a concurrent blocking
allocation in the child (e.g. a COW fault on an inherited page) can hit
memory.max and OOM-kill it first. The goal is only that the fixed kernel
passes reliably.

  # test_progs -v -t arena_memcg
  serial_test_arena_memcg:PASS:child killed by signal
  serial_test_arena_memcg:PASS:memcg oom_kill
  #5       arena_memcg:OK

  # dmesg (the OOM comes from the arena sleepable allocation)
  test_progs invoked oom-killer: gfp_mask=GFP_KERNEL_ACCOUNT|__GFP_ZERO
   arena_vm_fault+0x4bc/0xad0
  Memory cgroup out of memory: Killed process 473 (test_progs)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 2 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 000000000000..c57b98494cfa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "cgroup_helpers.h"
+#include "arena_memcg.skel.h"
+
+#define CG_PATH		"/arena_memcg"
+
+/* Budget the arena gets on top of whatever is already charged after load. */
+#define ARENA_BUDGET	(64 * 1024 * 1024)
+
+static void dump_memcg(int (*rd)(const char *, const char *, char *, size_t))
+{
+	char buf[512];
+
+	/*
+	 * memory.current reads 0 once the child has left the cgroup, so it only
+	 * carries information when dumped from the live child; memory.peak and
+	 * memory.events survive the child and tell the story either way.
+	 */
+	if (!rd(CG_PATH, "memory.current", buf, sizeof(buf)))
+		fprintf(stderr, "memory.current: %s", buf);
+	if (!rd(CG_PATH, "memory.max", buf, sizeof(buf)))
+		fprintf(stderr, "memory.max: %s", buf);
+	if (!rd(CG_PATH, "memory.peak", buf, sizeof(buf)))
+		fprintf(stderr, "memory.peak: %s", buf);
+	if (!rd(CG_PATH, "memory.events", buf, sizeof(buf)))
+		fprintf(stderr, "memory.events:\n%s", buf);
+	fflush(stderr);
+}
+
+/* Read one key from a flat keyed cgroup file, e.g. "oom_kill" in memory.events. */
+static long cg_read_key(const char *cg, const char *file, const char *key)
+{
+	char buf[512], *p;
+
+	if (read_cgroup_file(cg, file, buf, sizeof(buf)))
+		return -1;
+	p = strstr(buf, key);
+	if (!p)
+		return -1;
+	return strtol(p + strlen(key), NULL, 10);
+}
+
+void serial_test_arena_memcg(void)
+{
+	int cgroup_fd = -1, status, err;
+	const long ps = PAGE_SIZE;
+	char buf[64];
+	pid_t pid;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return;
+
+	cgroup_fd = create_and_get_cgroup(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
+		goto out;
+
+	/* No memory controller -> nothing to test. */
+	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
+		fprintf(stderr, "%s:SKIP:no memory controller\n", __func__);
+		test__skip();
+		goto out;
+	}
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0) {
+		struct arena_memcg *cskel;
+		__u32 i, npages;
+		char *base;
+		size_t sz;
+		long cur;
+
+		/*
+		 * Do everything from the child: the arena vma is VM_DONTCOPY so
+		 * it would not survive fork(), only the child should be under the
+		 * limit so that a memcg OOM cannot pick test_progs, and a map is
+		 * charged to the memcg of the task that creates it - so join
+		 * before load. The cgroup work dir belongs to the parent that set
+		 * the environment up, so reach it with the _parent() helpers.
+		 * Errors are reported to the parent through the exit code, since
+		 * ASSERT_* in a forked child does not reach it.
+		 */
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (write_cgroup_file_parent(CG_PATH, "cgroup.procs", buf))
+			_exit(2);
+
+		cskel = arena_memcg__open_and_load();
+		if (!cskel)
+			_exit(3);
+
+		base = bpf_map__initial_value(cskel->maps.arena, &sz);
+		if (!base)
+			_exit(4);
+		npages = bpf_map__max_entries(cskel->maps.arena);
+
+		/*
+		 * Cap only now, after load: everything but the fault-in is
+		 * charged, so the arena gets a fixed budget regardless of what
+		 * the load itself cost, and the load can never hit the limit.
+		 */
+		if (read_cgroup_file_parent(CG_PATH, "memory.current", buf, sizeof(buf)))
+			_exit(5);
+		cur = strtol(buf, NULL, 10);
+		snprintf(buf, sizeof(buf), "%ld", cur + ARENA_BUDGET);
+		if (write_cgroup_file_parent(CG_PATH, "memory.max", buf))
+			_exit(6);
+
+		for (i = 0; i < npages; i++)
+			base[(size_t)i * ps] = 1;
+		/* Faulted everything without dying: dump why (only under -v). */
+		dump_memcg(read_cgroup_file_parent);
+		_exit(0);
+	}
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+
+	/* A non-zero exit means the child failed to set up; the code says where. */
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		ASSERT_OK(WEXITSTATUS(status), "child setup");
+		goto out;
+	}
+
+	/*
+	 * Faulting a valid arena address until memory.max is hit must not look
+	 * like an invalid access. Without the fix the fault path allocated with
+	 * the non-blocking allocator, turned its -ENOMEM into VM_FAULT_SIGSEGV,
+	 * and the child died with SIGSEGV on a valid address; now it is handled
+	 * by the memcg OOM path instead. A SIGKILL alone would not prove the
+	 * memcg OOM killer did it (a global OOM or an unrelated crash could also
+	 * kill the child), so check memory.events.oom_kill, which records the
+	 * memcg OOM and survives the child.
+	 */
+	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
+		goto out;
+	if (!ASSERT_GE(cg_read_key(CG_PATH, "memory.events", "oom_kill"), 1,
+		       "memcg oom_kill"))
+		dump_memcg(read_cgroup_file);
+out:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/testing/selftests/bpf/progs/arena_memcg.c
new file mode 100644
index 000000000000..88259cfea06b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 50000); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+SEC("syscall")
+int noop(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

