Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7C3D3481;
	Mon, 27 Jul 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133660; cv=none; b=PwNjudU51y/15Wagrm7UxgBiorhhf3z5QPGxUUbmUEobz3i3hPp16zlfuqZNbxAF4nerF/TaDJSQuJKZvUTo7ao5vOGYqTkM0Bky4WYM0b5T8aUqcS0fQ8PBBPw09rQisdBZUPZkM3iBUn2nwRaqoFXFffEOVDp4iJzdHqEPdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133660; c=relaxed/simple;
	bh=hbK61ZnbCl+XYvl2g6LBOGAZMtl/K2biU1NiRp67UhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSOCAEt4SHoWnaQazOnkomQxkHd3+XEd83oP1Nk51pcibfL3Fn6QZ3PwSCBLNhK8ClK3/+cCNvmE+1eGbHiTg7N1X2A5pM6AzFsXApizWAe4XQz3rx2NMCy/CgVStgStwgfMfLhwjERSodc2gGOBS+whcmjO0pfVPk/oAx5/4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRC6+6Gl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRC6+6Gl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785133655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3mbBikFHzT9W/Rydrb9POuKqdsjN+9itl2eg03kx1Q=;
	b=jRC6+6GlkrldtFVFar/m8AVRmSXrcnURu14gPDKvhdfAx2KxRXHiHn5UzMAdJU8vz12zC9
	oHle1BuG3EmxuuzWvi/CjGPi1UYXRDLst7jfWItnWLmiIJqkaQukrwKY59DYvN9c5ULLWv
	BMypHprdPLPfrYNCBxninW6fLIzwHyU=
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
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Mon, 27 Jul 2026 14:24:14 +0800
Message-ID: <20260727062521.376231-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260727062521.376231-1-jiayuan.chen@linux.dev>
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A child joins a memcg capped at 64M and faults an arena in until it runs
out of the budget. Without the kernel fix the child dies with SIGSEGV on
a valid arena address; with it, the child is killed by the memcg OOM
killer.

With the fix:

  serial_test_arena_memcg:PASS:child killed by signal
  serial_test_arena_memcg:PASS:not killed by SIGSEGV
  #5       arena_memcg:OK

  # dmesg
   arena_vm_fault+0x655/0xa90
  Memory cgroup out of memory: Killed process 512, file-rss:67920kB

Without the fix:

  serial_test_arena_memcg:PASS:child killed by signal
  serial_test_arena_memcg:FAIL:not killed by SIGSEGV: actual 11
  #5       arena_memcg:FAIL

  # dmesg
  test_progs[508]: segfault at 100004025000 ...

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 2 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 000000000000..9665946fa29e
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
+/*
+ * cgroup_helpers builds paths from getpid(), but the work dir belongs to the
+ * process that set the environment up. The child references it through that
+ * pid, so build the path explicitly.
+ */
+static void cg_file_path(char *buf, size_t sz, pid_t owner, const char *file)
+{
+	snprintf(buf, sz, "/mnt/cgroup-test-work-dir%d%s/%s", owner, CG_PATH, file);
+}
+
+static long cg_read_ulong(pid_t owner, const char *file)
+{
+	char path[PATH_MAX], buf[64];
+	long val = -1;
+	FILE *f;
+
+	cg_file_path(path, sizeof(path), owner, file);
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+	if (fgets(buf, sizeof(buf), f))
+		val = strtol(buf, NULL, 10);
+	fclose(f);
+	return val;
+}
+
+static int cg_write(pid_t owner, const char *file, const char *val)
+{
+	char path[PATH_MAX];
+	int fd, len, ret = -1;
+
+	cg_file_path(path, sizeof(path), owner, file);
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	len = strlen(val);
+	if (write(fd, val, len) == len)
+		ret = 0;
+	close(fd);
+	return ret;
+}
+
+void serial_test_arena_memcg(void)
+{
+	int cgroup_fd = -1, status;
+	const long ps = PAGE_SIZE;
+	pid_t owner, pid;
+
+	if (setup_cgroup_environment())
+		return;
+	owner = getpid();
+
+	cgroup_fd = create_and_get_cgroup(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
+		goto out;
+
+	/* No memory controller -> nothing to test. */
+	if (cg_read_ulong(owner, "memory.current") < 0) {
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
+		char buf[32];
+		char *base;
+		size_t sz;
+		long cur;
+
+		/*
+		 * Do everything from the child: the arena vma is VM_DONTCOPY so
+		 * it would not survive fork(), only the child should be under the
+		 * limit so that a memcg OOM cannot pick test_progs, and a map is
+		 * charged to the memcg of the task that creates it - so join
+		 * before load. Errors are reported to the parent through the exit
+		 * code, since ASSERT_* in a forked child does not reach it.
+		 */
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(owner, "cgroup.procs", buf))
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
+		cur = cg_read_ulong(owner, "memory.current");
+		if (cur < 0)
+			_exit(5);
+		snprintf(buf, sizeof(buf), "%ld", cur + ARENA_BUDGET);
+		if (cg_write(owner, "memory.max", buf))
+			_exit(6);
+
+		for (i = 0; i < npages; i++)
+			base[(size_t)i * ps] = 1;
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
+	 * by the memcg OOM path and the child is killed by SIGKILL instead. A
+	 * clean exit means the child failed to set up (see the exit codes).
+	 */
+	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
+		goto out;
+	ASSERT_NEQ(WTERMSIG(status), SIGSEGV, "not killed by SIGSEGV");
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

