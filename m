Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8542D76F
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212197; cv=none; b=NaVBfHndeN3+B7f81fs+OVw3Km4/3ROll993Pr1sG7LzECwDycSy625vZyfZ5Z/UTjEOPggjBzlxoQxBLqpmfbh4gsB3lmQzHlwCC+U/vk55A2PuwZIbK0/fGS9nm92p/ovaXO0oZcETrDENtfsYHBovgBBXFdC/idU27l5wkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212197; c=relaxed/simple;
	bh=BxxAqyrCeGCBpKdz8J5FEt2zbeWNR4gQoleYdcIgo9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFjiJ6s0ovw5K7hW9C+pvzJR7nGJ7MUSP91utLsXryxA+x3jY9QqlPobTpY//kExlbbDx6cHThtqr+0k5YN0wQgToMh6AorP6Vx8XnB4gYg3zOycegRWKrE1KHLMzf+SNri8CqehV/J6bNuI6FY31Vs8zd+JAsoM4jAPEdsMOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pg5jj6Xz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pg5jj6Xz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784212193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plL3HlABGOEsUMf+ise3vo4iORw/dt9juCk3f8Huqvk=;
	b=Pg5jj6XzDHjqPeNr+qBMawEEos7qWCrpY7VZHl3OojDj4zI24sPWgb5tJjjaNreWc6VUJn
	4v3abesDzHRftzcK8VyFrnNAhUMAwwo13lCXaHzrQ7OQLrjpOH5F1UhP27Xv2PIAvuC5ds
	0wORqEe482fuWWcTRAv3dAWvp0XQvrM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests for memory usage for arena
Date: Thu, 16 Jul 2026 22:25:00 +0800
Message-ID: <20260716142746.8794-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260716142746.8794-1-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allocate and free arena pages, both from BPF and via user-space fault-in,
and check that the map's memlock in fdinfo tracks the number of pages that
are actually populated.

Like the other arena tests it runs serially.

test:
  ./test_progs -a arena_mem_usage
  #5       arena_mem_usage:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/arena_mem_usage.c          | 122 ++++++++++++++++++
 .../selftests/bpf/progs/arena_mem_usage.c     |  39 ++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_mem_usage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
new file mode 100644
index 000000000000..14c2d1a1d673
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "arena_mem_usage.skel.h"
+
+/*
+ * arena_map_mem_usage() is surfaced to user space through the map's
+ * /proc/<pid>/fdinfo/<fd> "memlock:" line (the same value bpftool map show
+ * prints). Read it directly so the test has no external dependency.
+ */
+static long map_memlock(int map_fd)
+{
+	char path[64], line[128];
+	long memlock = -1;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", map_fd);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, "open_fdinfo"))
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "memlock:\t%ld", &memlock) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_NEQ(memlock, -1, "parse_memlock");
+	return memlock;
+}
+
+static int run(struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+
+	if (!ASSERT_OK(err, name))
+		return -1;
+	if (!ASSERT_OK(opts.retval, name))
+		return -1;
+	return 0;
+}
+
+void serial_test_arena_mem_usage(void)
+{
+	struct arena_mem_usage *skel;
+	const long ps = PAGE_SIZE;
+	char *base;
+	size_t sz;
+	int fd, i;
+
+	skel = arena_mem_usage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+
+	/* Fresh arena: no data pages, and the scratch page is not counted. */
+	ASSERT_EQ(map_memlock(fd), 0, "initial");
+
+	/* BPF-side allocation of 17 pages. */
+	skel->bss->alloc_cnt = 17;
+	if (run(skel->progs.alloc, "alloc"))
+		goto out;
+	/*
+	 * A NULL ptr means bpf_arena_alloc_pages() itself failed (e.g. the host
+	 * is under memory pressure), not a miscount -- flag it distinctly so a
+	 * red CI run is not mistaken for a counting bug.
+	 */
+	if (!ASSERT_OK_PTR(skel->bss->ptr, "arena_alloc_pages"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), 17 * ps, "after_alloc");
+
+	/* Free a single page (arena_free_pages page_cnt==1 path). */
+	skel->bss->free_byte_off = 0;
+	skel->bss->free_cnt = 1;
+	if (run(skel->progs.free_pages, "free_one"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), 16 * ps, "after_free_one");
+
+	/* Free ten pages in one call (bulk path); only the freed pages count. */
+	skel->bss->free_byte_off = 1 * ps;
+	skel->bss->free_cnt = 10;
+	if (run(skel->progs.free_pages, "free_bulk"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), 6 * ps, "after_free_bulk");
+
+	/* Free the remaining six -> arena empty again. */
+	skel->bss->free_byte_off = 11 * ps;
+	skel->bss->free_cnt = 6;
+	if (run(skel->progs.free_pages, "free_rest"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), 0, "after_free_rest");
+
+	/*
+	 * User-space fault-in: touching unallocated arena pages allocates them
+	 * through arena_vm_fault(). libbpf mmap()s the arena at map_extra during
+	 * load, so bpf_map__initial_value() hands back that base.
+	 */
+	base = bpf_map__initial_value(skel->maps.arena, &sz);
+	if (!ASSERT_OK_PTR(base, "arena_base"))
+		goto out;
+	for (i = 0; i < 8; i++)
+		base[i * ps] = 1;
+	ASSERT_EQ(map_memlock(fd), 8 * ps, "after_faultin");
+
+	/*
+	 * Free the faulted-in pages from BPF. They are mapped into the user vma
+	 * (elevated refcount), so this also exercises the zap path.
+	 */
+	skel->bss->ptr = base;
+	skel->bss->free_byte_off = 0;
+	skel->bss->free_cnt = 8;
+	if (run(skel->progs.free_pages, "free_faulted"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), 0, "after_free_faulted");
+out:
+	arena_mem_usage__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_mem_usage.c b/tools/testing/selftests/bpf/progs/arena_mem_usage.c
new file mode 100644
index 000000000000..50d9d6ac86f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_mem_usage.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1000); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+void __arena *ptr;
+int alloc_cnt;		/* in:  pages to allocate */
+long free_byte_off;	/* in:  byte offset within ptr to start freeing */
+int free_cnt;		/* in:  pages to free */
+
+SEC("syscall")
+int alloc(void *ctx)
+{
+	ptr = bpf_arena_alloc_pages(&arena, NULL, alloc_cnt, NUMA_NO_NODE, 0);
+	return ptr ? 0 : 1;
+}
+
+SEC("syscall")
+int free_pages(void *ctx)
+{
+	if (!ptr)
+		return 1;
+	bpf_arena_free_pages(&arena, (char __arena *)ptr + free_byte_off, free_cnt);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

