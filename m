Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475F4189B9
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198157; cv=none; b=fjVRJLtXfFmwPJeJ0CQUs4U76AJNyO6o1jdgA2OVAuSE10LeWfdugkh7ofq5DUipUoYRLnpe2Oz/9urOpa69lc9oinJCIBx0pklBE/9WyZhNtGQ/9Fq5XewzQHG2NG4jY9/N6KYNjV38aOikYO6aQj2WWC3aGgZ3+9t4WWXHjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198157; c=relaxed/simple;
	bh=HP0S7SBqXLlQwakWYhPQrCmlJdLm1kuafV054H6dPM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZPgnFvc/C5OJ/BMuJTMsiSgGyImxpushjD3XwyaB8HaERGvGTw1jA4DXwTZLEiuAnxCShI0xqvj0N/L0ZCRQgyFEupUB7D0COAQBUbjVAmqjpTRys2ncG1v1yyTMFbzxVKZxjh4K09GjcaXPKAY9QnzLWsEF3C4lAFUp6/GJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYVfcnTH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYVfcnTH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786198153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+wXBBS9duMVfV4UBcV/L3Z9e2eWNdKnT/eo9Gtl7NQ=;
	b=KYVfcnTH1yhxwXY34LyhOO5G6AJCR6qIJG+AZb5oCaGJJ0jqNTs6oO40thKBK4+aMe9J2T
	iUYwGxdN29eKxFvN1csUgKEF3Qc1WlEJwVEUGoN/hzwxGyHXxtJj2A63N/Nf0KZPWdTlZ/
	sV8ayqbDK6caWylF6Mr1u0zI6Wf8O/g=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Sat,  8 Aug 2026 22:05:56 +0800
Message-ID: <20260808140720.293604-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-1-jiayuan.chen@linux.dev>
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 156 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 2 files changed, 180 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 000000000000..af49d8b1b995
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -0,0 +1,156 @@
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
+	fflush(NULL); /* _exit() in the child would not flush stdio otherwise */
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
+	int cgroup_fd = -1, status;
+	const long ps = PAGE_SIZE;
+	char buf[64];
+	pid_t pid;
+
+	if (setup_cgroup_environment())
+		return;
+
+	cgroup_fd = create_and_get_cgroup(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
+		goto out;
+
+	/* No memory controller -> nothing to test. */
+	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
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
+		/* Faulted everything without dying: no pressure built, dump why. */
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
index 000000000000..adecd9e8463e
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
+	__uint(max_entries, 100000); /* number of pages */
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

