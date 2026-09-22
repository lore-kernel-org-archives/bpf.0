Received: from mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2D5328C4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072402; cv=none; b=dpNSTIRb6SwKKuQHFnXzMA1eulzktY7ybziUDG+y2FHpCC3RCAQIZddwHZIjTTAg+RQfWYILYOU4EFTcdP0yo06u6q4gdPNUNphY+5ioWX0WKPI8BIY7D1OoN3QuRX4SBPzScu0osR/p43XoC0zeoQ3hWvi9R7vbjVal1hgss0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072402; c=relaxed/simple;
	bh=COPF3YEMiQ3Yab0KaIhKYX8PYpi8LggU23AZSVaYTms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6dQ0A1N6xNmcXLWs5FGr0xiEhXkO04qOk3Q4GY0sAzrlMZUbKa/x9CLuECDyEMYIy1UPwa7pcVxO9suJ8pd7esZnWi2SJExD5bt+aGFJ/gT+wlO2wz+eTlDk6ajVKuBdLzhlygzBbQH9or0Ew7KEtEn2s5RdolLpI3nqLKqXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8IWTWZT; arc=none smtp.client-ip=91.218.175.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8IWTWZT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=COPF3YEMiQ3Yab0KaIhKYX8PYpi8LggU23AZSVaYTms=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790072395; v=1; x=1790677195;
 b=U8IWTWZT5W1t0qmxAVvSAqw/Ag++8VW77d9MWjxQG5oloPHJBOuzvMTrtVGgQsg8ymqD6pqf
 gSLKwI5a8TkvSgLvLN+Z7p+0v5ZGauReiXwBhgZyJjP2i9+4XwCga4boRRmPu9VuSdZCSwdSC/5
 UrvlRkF/347r+UrlU7RmGNiM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e927b65a3285982;
	Tue, 22 Sep 2026 10:19:55 +0000
X-Mizu-Trace-ID: 6e927b65a3285982
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v9 3/3] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Tue, 22 Sep 2026 18:17:35 +0800
Message-ID: <20260922101831.192102-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101831.192102-1-jiayuan.chen@linux.dev>
References: <20260922101831.192102-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child joins a memcg, fills it with 128M of clean page cache by reading
a sparse temp file (the way the cgroup selftests do), caps memory.max 8M
above its usage and then faults 64M of arena in, which only fits by
reclaiming that cache.

With the fix the arena fault-in reclaims, every fault succeeds and the
child exits 0. Without it the allocation cannot reclaim, fails once the
headroom is used up, and the child dies with SIGSEGV on a valid arena
address, so the test fails.

  # test_progs -v -t arena_memcg
  serial_test_arena_memcg:PASS:child faulted the arena in
  #8       arena_memcg:OK

  # without the fix
  child killed by signal 11
  serial_test_arena_memcg:FAIL:child faulted the arena in

The page cache must be reclaimable, so the temp file has to live on a
disk-backed filesystem, not tmpfs - the same assumption the cgroup
selftests make.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
To sashiko:
- The non-arm64 1<<44 map_extra is copied from the existing arena tests.
- waitpid() without an EINTR retry is copied from the existing tests.
- fork() then work without exec follows the existing tests (the
  SIGEV_THREAD watchdog is test_progs-wide).
- Not skipping on EOPNOTSUPP (unsupported arena JIT) follows most of the
  existing arena tests; only arena_direct_value/arena_spin_lock skip.
- cgroup.memory=nobpf would charge the arena pages to the root memcg, so
  the limit would not bind and the test would pass either way; CI does
  not configure it.
- The test SKIPs when the working directory cannot host the reserve: it
  detects tmpfs (shmem pages are not reclaimable without swap) and a
  filesystem without O_TMPFILE support. The cgroup selftests make the
  same assumption about the working directory.
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 196 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  23 ++
 2 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 0000000000000..c76a7eb2f01d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <fcntl.h>
+#include <linux/magic.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "cgroup_helpers.h"
+#include "arena_memcg.skel.h"
+
+#define CG_PATH		"/arena_memcg"
+
+/* Reclaimable page cache the child builds up before it gets capped. */
+#define RECLAIMABLE	(128 * 1024 * 1024)
+/* Headroom left under memory.max, far less than the arena we fault in. */
+#define HEADROOM	(8 * 1024 * 1024)
+/* Arena to fault in; it only fits by reclaiming the page cache. */
+#define ARENA_FAULT	(64 * 1024 * 1024)
+/* Child exit code for "this environment cannot host the test". */
+#define CHILD_UNSUPPORTED	9
+
+static void dump_memcg(void)
+{
+	char buf[512];
+
+	if (!read_cgroup_file(CG_PATH, "memory.max", buf, sizeof(buf)))
+		fprintf(stderr, "memory.max: %s", buf);
+	if (!read_cgroup_file(CG_PATH, "memory.peak", buf, sizeof(buf)))
+		fprintf(stderr, "memory.peak: %s", buf);
+	if (!read_cgroup_file(CG_PATH, "memory.events", buf, sizeof(buf)))
+		fprintf(stderr, "memory.events:\n%s", buf);
+}
+
+/*
+ * Fill the page cache with @size bytes of clean, reclaimable pages by
+ * reading a sparse temp file, the way the cgroup selftests do. Returns the
+ * fd, which must stay open: closing it drops the cache. Returns -EOPNOTSUPP
+ * if the working directory cannot back such a file, -1 on error.
+ */
+static int alloc_pagecache(size_t size)
+{
+	struct statfs stfs;
+	char buf[4096];
+	size_t off;
+	int fd;
+
+	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
+	if (fd < 0)
+		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
+	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
+	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
+		close(fd);
+		return -EOPNOTSUPP;
+	}
+	if (ftruncate(fd, size))
+		goto err;
+	for (off = 0; off < size; off += sizeof(buf))
+		if (read(fd, buf, sizeof(buf)) < 0)
+			goto err;
+	return fd;
+err:
+	close(fd);
+	return -1;
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
+		goto out;
+
+	cgroup_fd = create_and_get_cgroup(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
+		goto out;
+
+	/* No memory controller -> nothing to test. */
+	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
+		fprintf(stderr, "%s:SKIP:no memory controller or other env error\n",
+			__func__);
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
+		int fd;
+
+		/*
+		 * Everything runs in the child: the arena vma is VM_DONTCOPY so
+		 * it does not survive fork(), and only the child should be under
+		 * the limit. The work dir belongs to the parent, so use the
+		 * _parent() helpers; errors come back as an exit code, ASSERT_*
+		 * does not reach the parent from here.
+		 */
+
+		/* Step 1: join the memcg, so what follows is charged to it. */
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (write_cgroup_file_parent(CG_PATH, "cgroup.procs", buf))
+			_exit(2);
+
+		/*
+		 * Step 2: load the arena. A map is charged to whoever creates
+		 * it, hence joining first.
+		 */
+		cskel = arena_memcg__open_and_load();
+		if (!cskel)
+			_exit(3);
+		base = bpf_map__initial_value(cskel->maps.arena, &sz);
+		if (!base)
+			_exit(4);
+		npages = ARENA_FAULT / ps;
+		if (npages > bpf_map__max_entries(cskel->maps.arena))
+			_exit(5);
+
+		/* Step 3: make RECLAIMABLE bytes of clean page cache. */
+		fd = alloc_pagecache(RECLAIMABLE);
+		if (fd == -EOPNOTSUPP)
+			_exit(CHILD_UNSUPPORTED);
+		if (fd < 0)
+			_exit(6);
+
+		/*
+		 * Step 4: set memory.max to what we use now plus HEADROOM. The
+		 * page cache is already inside the limit, so only HEADROOM is
+		 * left.
+		 */
+		if (read_cgroup_file_parent(CG_PATH, "memory.current", buf, sizeof(buf)))
+			_exit(7);
+		cur = strtol(buf, NULL, 10);
+		snprintf(buf, sizeof(buf), "%ld", cur + HEADROOM);
+		if (write_cgroup_file_parent(CG_PATH, "memory.max", buf))
+			_exit(8);
+
+		/*
+		 * Step 5: fault ARENA_FAULT of arena in, much more than
+		 * HEADROOM. Once it hits memory.max every further page has to
+		 * come from reclaiming the page cache. With the fix the
+		 * fault-in reclaims and all of it succeeds; without it the
+		 * allocation cannot reclaim and we die on a valid address.
+		 */
+		for (i = 0; i < npages; i++)
+			base[(size_t)i * ps] = 1;
+		_exit(0); /* fd deliberately kept open until here */
+	}
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+
+	/* The working directory cannot hold a reclaimable page cache. */
+	if (WIFEXITED(status) && WEXITSTATUS(status) == CHILD_UNSUPPORTED) {
+		fprintf(stderr, "%s:SKIP:no disk-backed O_TMPFILE in cwd\n", __func__);
+		test__skip();
+		goto out;
+	}
+
+	/* A non-zero exit means the child failed to set up; the code says where. */
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		ASSERT_OK(WEXITSTATUS(status), "child setup");
+		goto out;
+	}
+
+	/*
+	 * With the fix the arena fault-in reclaims the page cache and every
+	 * fault succeeds, so the child exits 0. Without it the allocation
+	 * cannot reclaim, fails once the headroom is used up, and the child
+	 * dies with SIGSEGV on a valid arena address.
+	 */
+	if (!ASSERT_TRUE(WIFEXITED(status) && !WEXITSTATUS(status),
+			 "child faulted the arena in")) {
+		if (WIFSIGNALED(status))
+			fprintf(stderr, "child killed by signal %d\n", WTERMSIG(status));
+		dump_memcg();
+	}
+out:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/testing/selftests/bpf/progs/arena_memcg.c
new file mode 100644
index 0000000000000..aff73757e7941
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	/*
+	 * Number of pages. Must cover ARENA_FAULT on the smallest page size
+	 * (64M/4K = 16384) yet stay under the 4G arena limit on 64K pages
+	 * (50000*64K = 3.2G).
+	 */
+	__uint(max_entries, 50000);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

