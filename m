Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37C3AD516;
	Wed, 13 May 2026 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699636; cv=none; b=ireqlS5UBxpX2DqfZi2iVXyVd965F+cmUsdMGhOuB3aJtjBqwEGZYpfccENR0bUWG337zTGvUm0wf5YT+agOruMg0vEmAir7OjRvIp/6RILZCz6eMdy6bKKBtfK9SfUrGr14Gd3arH3nZ4eK4TlWQ8DUJm+Rm7latCPhHFDOoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699636; c=relaxed/simple;
	bh=u9Vi9SqU+iy7DIoB+ie/vVY+ODcrBUgIlvGHHSwspK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toBTMTYZBz1np5gP4NpA7QgsWNSAvoai4wyFAkbG9kwIwpTE3P7XdOerRYKQEvMkKLtSiit/DdlTexJhvMfyknkOebidbtrbRT43uwXryA6PGG+L3RoPe9I5KlyIayucAjwMRZqOT50+7yVzu21VkUODpwEPtGFjx1yw5uv6krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=NKZLBMGp; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=udsIzVrO; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="NKZLBMGp";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="udsIzVrO"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778699602; bh=TBUm2X5S6ssSz+qMqeLDhKM
	qDNPC+cZRaCg50wY6uh4=; b=NKZLBMGpYco2Gj/QE+jEWjHuRNly/eDaDCUWvcYrA3NmAKNizX
	ZlSN6YrJZL5zju2U95WDMDYknCn92rh9UtSDGWCuBBJPHL3dZ+OsxO/oHrCR5qH+IMUSX4sAW/q
	lFGxEiqh1zhE+lB2c5sbt0N9qO9CfbijsF/fs+OXi6BpcSO0GXDyALKYErx2cLs7ukBGJnxMvT6
	ruvmJLVhdRKQBnZ5J9kXyA+x3owHgEaNbFOfamWirHEc2hOjdZHfY45OG1Nmf8QM2SM2AjdWrJ5
	EXC18tQvOM1601E1BeFUVpmIheQpWCTkvJGOVEiMG2sgFK4jmDGgM10fveUm5QpVWxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778699602; bh=TBUm2X5S6ssSz+qMqeLDhKM
	qDNPC+cZRaCg50wY6uh4=; b=udsIzVrO8cpaM7p+GT0lxoIe351oR+j/mUntoaBlA+H2qpcfsY
	O16B9Fi1h8HI3D+B+CPygFoUMEHYgZ6reFAg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	git@danielhodges.dev,
	brho@google.com,
	hodgesd@meta.com
Subject: [PATCH 2/2] selftests/bpf: Add test validating arena VMA tracking across fork
Date: Wed, 13 May 2026 15:13:22 -0400
Message-ID: <20260513191322.21319-2-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513191322.21319-1-git@danielhodges.dev>
References: <20260513191322.21319-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate that arena page frees don't trigger a use-after-free when a
forked child holds an inherited arena mmap. The test allocates arena
pages, forks, munmaps the arena in the parent, then frees the arena
pages via BPF. With KASAN enabled, any stale VMA dereference in
zap_pages() will be caught.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Assisted-by: Claude-Code:claude-opus-4-6
---
 .../bpf/prog_tests/arena_fork_free.c          | 114 ++++++++++++++++++
 .../selftests/bpf/progs/arena_fork_free.c     |  71 +++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork_free.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork_free.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork_free.c b/tools/testing/selftests/bpf/prog_tests/arena_fork_free.c
new file mode 100644
index 000000000000..6a6e1d4197cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fork_free.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/*
+ * Validate arena VMA tracking across fork.
+ *
+ * When a process with an arena mmap forks, each VMA must be independently
+ * tracked. This test verifies that freeing arena pages after the parent
+ * munmaps does not access stale VMA pointers.
+ *
+ * Sequence:
+ *   1. Load arena, allocate pages via BPF
+ *   2. fork() — child inherits arena mmap
+ *   3. Parent: munmap the arena
+ *   4. Parent: free arena pages via BPF — zap_pages() must only touch
+ *      live VMAs
+ *
+ * With KASAN enabled, any stale VMA access will be caught.
+ */
+#include <test_progs.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE
+#define PAGE_SIZE getpagesize()
+#endif
+#include "arena_fork_free.skel.h"
+
+void test_arena_fork_free(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_fork_free *skel;
+	int pipe_fds[2] = {-1, -1};
+	size_t arena_sz;
+	void *arena_area;
+	pid_t child;
+	int ret, status;
+	char buf;
+
+	skel = arena_fork_free__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* Step 1: allocate arena pages via BPF */
+	ret = bpf_prog_test_run_opts(
+		bpf_program__fd(skel->progs.arena_alloc), &opts);
+	if (!ASSERT_OK(ret, "alloc_run"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "alloc_retval"))
+		goto out;
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+
+	arena_area = bpf_map__initial_value(skel->maps.arena, &arena_sz);
+	if (!ASSERT_OK_PTR(arena_area, "arena_area"))
+		goto out;
+	arena_sz = bpf_map__max_entries(skel->maps.arena) * PAGE_SIZE;
+
+	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
+		goto out;
+
+	/* Step 2: fork — child inherits arena mmap */
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork")) {
+		close(pipe_fds[0]);
+		close(pipe_fds[1]);
+		goto out;
+	}
+
+	if (child == 0) {
+		/* Child: keep arena mmap alive, wait for parent to signal */
+		close(pipe_fds[1]);
+		read(pipe_fds[0], &buf, 1);
+		close(pipe_fds[0]);
+		_exit(0);
+	}
+
+	/* Parent continues */
+	close(pipe_fds[0]);
+	pipe_fds[0] = -1;
+
+	/* Step 3: munmap the arena in the parent */
+	ret = munmap(arena_area, arena_sz);
+	if (!ASSERT_OK(ret, "munmap"))
+		goto signal_child;
+
+	/*
+	 * Step 4: free arena pages via BPF.
+	 *
+	 * Wait for the RCU grace period so the parent's VMA slab memory
+	 * is actually freed (VMA freeing is deferred via call_rcu).
+	 * This ensures KASAN can detect any stale VMA dereference in
+	 * zap_pages().
+	 */
+	usleep(200000);
+	opts.retval = 0;
+	ret = bpf_prog_test_run_opts(
+		bpf_program__fd(skel->progs.arena_free), &opts);
+	ASSERT_OK(ret, "free_run");
+	ASSERT_OK(opts.retval, "free_retval");
+
+signal_child:
+	close(pipe_fds[1]);
+	pipe_fds[1] = -1;
+	waitpid(child, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status), "child_exited");
+
+out:
+	arena_fork_free__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_fork_free.c b/tools/testing/selftests/bpf/progs/arena_fork_free.c
new file mode 100644
index 000000000000..81b4f9a4e94b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fork_free.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/*
+ * Validate arena VMA tracking across fork.
+ *
+ * Provides BPF programs to allocate and free arena pages, exercised by
+ * the userspace test to verify that zap_pages() correctly handles VMA
+ * lifecycle when a forked child holds an inherited arena mmap.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 10); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+bool skip = false;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+
+void __arena *alloc_ptr;
+int alloc_page_cnt;
+
+SEC("syscall")
+int arena_alloc(void *ctx)
+{
+	alloc_ptr = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (!alloc_ptr)
+		return 1;
+	alloc_page_cnt = 2;
+	return 0;
+}
+
+SEC("syscall")
+int arena_free(void *ctx)
+{
+	if (!alloc_ptr || !alloc_page_cnt)
+		return 1;
+	bpf_arena_free_pages(&arena, alloc_ptr, alloc_page_cnt);
+	alloc_ptr = NULL;
+	alloc_page_cnt = 0;
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int arena_alloc(void *ctx)
+{
+	skip = true;
+	return 0;
+}
+
+SEC("syscall")
+int arena_free(void *ctx)
+{
+	skip = true;
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

