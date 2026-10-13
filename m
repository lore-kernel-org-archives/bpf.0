Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514E51C063;
	Tue, 13 Oct 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911560; cv=none; b=TlUUNx53+q7xyFUCrXyqOS8J+HFEXimvRqJ4fUI9nmNGw8FL7HGKtpe4z0PUmuZEQ4LkRntFDik8aFR/a0nuVxDyCvcfqJ/lUDin81VHlJcAzvjT2UXD5sUzfjYDurjmWLusLyo+Zz9RZHBSrleqPFbPG1zJ92wEDAIAHLksVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911560; c=relaxed/simple;
	bh=Yen5qImqOd8DtBBqEgj6mqp4vbc1SzUl4IrzPob+tJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5qkkbaZjaQFfX2HW+TSx7pkuG8lzomIPV9EoqAa1J5svkpgMS/z3jBRAGs2RCKkS4jVL8XOW2oFL5qj3xz1RXXVmJe0JaKwMqZZK5w7I6PQdgiIf8C3k5af0Fx3nXPkv0MSdHp5kF+rqCS6oGWsLNoG/Nfpm4chKV7+YIou9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j419W5dBQzMljG;
	Tue, 13 Oct 2026 19:12:31 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: listout@listout.xyz
To: bpf@vger.kernel.org
Cc: bdas@suse.de,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <jp.kobryn@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Add tests for memcg kfuncs
Date: Tue, 13 Oct 2026 22:42:11 +0530
Message-ID: <20261013171211.1661726-1-listout@listout.xyz>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j419W5dBQzMljG

From: Brahmajit Das <bdas@suse.de>

The existing cgroup_iter_memcg test covers bpf_get_mem_cgroup(),
bpf_put_mem_cgroup(), bpf_mem_cgroup_flush_stats(),
bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(), but
bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
selftest coverage.

Add a memcg_kfuncs test that drives them from syscall programs against
a test cgroup:

 - usage: bpf_mem_cgroup_usage() agrees with memory.current.
 - invalid_idx: out-of-range and negative indices passed to
   bpf_mem_cgroup_memory_events(), bpf_mem_cgroup_vm_events() and
   bpf_mem_cgroup_page_state() return (unsigned long)-1.
 - memory_events: after pushing the cgroup over memory.high,
   MEMCG_HIGH is non-zero and the low/high/max/oom/oom_kill counters
   match memory.events.
 - root_memcg: bpf_get_root_mem_cgroup() can be acquired and released.
 - reclaim_args: bpf_proactive_reclaim() rejects sizes below PAGE_SIZE
   and out-of-range swappiness with -EINVAL, and accepts -1, 0,
   MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY.
 - reclaim: bpf_proactive_reclaim() reclaims clean page cache and
   returns a page-aligned byte count. The request is clamped to
   MEMCG_CHARGE_BATCH pages, but reclaim may overshoot its target, so
   the result is not bounded.

The page cache subtests skip, with a message, when the working
directory cannot back a reclaimable O_TMPFILE, as in arena_memcg.

Also add memcg_kfuncs_failure with verifier tests for a leaked
reference from bpf_get_root_mem_cgroup(), a missing NULL check on its
result, and a call to bpf_proactive_reclaim() from a non-syscall
program.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brahmajit Das <bdas@suse.de>
---
v2 -> v3:
- Drop the upper bound on the bpf_proactive_reclaim() result; only the
  request is clamped and reclaim may overshoot. Fix the commit message
  accordingly. (CI review)
- Print the reason before skipping. (CI review)

v1 -> v2:
- Also check that negative indices are rejected by
  bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events() (Sashiko)

v2: https://lore.kernel.org/bpf/20261013151621.1526699-1-listout@listout.xyz/
v1: https://lore.kernel.org/bpf/20261013143853.1379307-1-listout@listout.xyz/
---
 .../selftests/bpf/prog_tests/memcg_kfuncs.c   | 306 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_kfuncs.c        | 106 ++++++
 .../bpf/progs/memcg_kfuncs_failure.c          |  54 ++++
 3 files changed, 466 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_kfuncs_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
new file mode 100644
index 000000000000..4527000ae408
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <fcntl.h>
+#include <linux/magic.h>
+#include <sys/mman.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "cgroup_helpers.h"
+#include "memcg_kfuncs.skel.h"
+#include "memcg_kfuncs_failure.skel.h"
+
+#define CG_PATH		"/memcg_kfuncs"
+
+/* From mm/internal.h, not exposed in BTF. */
+#define MAX_SWAPPINESS		200
+#define SWAPPINESS_ANON_ONLY	(MAX_SWAPPINESS + 1)
+
+/* bpf_proactive_reclaim() clamps the request to MEMCG_CHARGE_BATCH pages. */
+#define MEMCG_CHARGE_BATCH	64
+
+#define ANON_SIZE		(4 * 1024 * 1024)
+#define USAGE_SLACK		(1 * 1024 * 1024)
+#define PAGECACHE_SIZE		(32 * 1024 * 1024)
+#define HIGH_HEADROOM		(1 * 1024 * 1024)
+#define RECLAIM_RETRIES		16
+
+static long page_size;
+
+static int run_prog(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		return -1;
+	if (!ASSERT_EQ(opts.retval, 0, "retval"))
+		return -1;
+	return 0;
+}
+
+static int read_memcg_ulong(const char *file, unsigned long *val)
+{
+	char buf[64];
+
+	if (read_cgroup_file(CG_PATH, file, buf, sizeof(buf)))
+		return -1;
+	*val = strtoul(buf, NULL, 10);
+	return 0;
+}
+
+static int read_memory_event(const char *key, unsigned long *val)
+{
+	char buf[512], name[64], *line, *saveptr;
+	unsigned long v;
+
+	if (read_cgroup_file(CG_PATH, "memory.events", buf, sizeof(buf)))
+		return -1;
+
+	for (line = strtok_r(buf, "\n", &saveptr); line;
+	     line = strtok_r(NULL, "\n", &saveptr)) {
+		if (sscanf(line, "%63s %lu", name, &v) != 2)
+			continue;
+		if (!strcmp(name, key)) {
+			*val = v;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Fill the page cache with @size bytes of clean, reclaimable pages by
+ * reading a sparse temp file. Returns the fd, which must stay open, or
+ * -EOPNOTSUPP if the working directory cannot back such a file, -1 on error.
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
+static int alloc_pagecache_or_skip(size_t size)
+{
+	int fd;
+
+	fd = alloc_pagecache(size);
+	if (fd == -EOPNOTSUPP) {
+		fprintf(stderr, "%s:SKIP:no disk-backed O_TMPFILE in cwd\n", __func__);
+		test__skip();
+		return -1;
+	}
+	ASSERT_OK_FD(fd, "alloc_pagecache");
+	return fd;
+}
+
+static void test_usage(struct memcg_kfuncs *skel)
+{
+	unsigned long before, after, lo, hi;
+	void *map;
+
+	map = mmap(NULL, ANON_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
+		return;
+	memset(map, 1, ANON_SIZE);
+
+	if (!ASSERT_OK(read_memcg_ulong("memory.current", &before), "read before"))
+		goto out;
+	if (run_prog(skel->progs.memcg_query))
+		goto out;
+	if (!ASSERT_OK(read_memcg_ulong("memory.current", &after), "read after"))
+		goto out;
+
+	/*
+	 * bpf_mem_cgroup_usage() and memory.current read the same counter,
+	 * but the cgroup may still be charged or uncharged in between.
+	 */
+	lo = (before < after ? before : after) - USAGE_SLACK;
+	hi = (before < after ? after : before) + USAGE_SLACK;
+	ASSERT_GE(skel->bss->usage, ANON_SIZE, "usage covers anon");
+	ASSERT_GE(skel->bss->usage, lo, "usage lower bound");
+	ASSERT_LE(skel->bss->usage, hi, "usage upper bound");
+out:
+	munmap(map, ANON_SIZE);
+}
+
+static void test_invalid_idx(struct memcg_kfuncs *skel)
+{
+	if (run_prog(skel->progs.memcg_query))
+		return;
+
+	ASSERT_EQ(skel->bss->bad_memory_event, -1UL, "bad memory event");
+	ASSERT_EQ(skel->bss->bad_vm_event, -1UL, "bad vm event");
+	ASSERT_EQ(skel->bss->bad_page_state, -1UL, "bad page state");
+	ASSERT_EQ(skel->bss->neg_memory_event, -1UL, "negative memory event");
+	ASSERT_EQ(skel->bss->neg_vm_event, -1UL, "negative vm event");
+}
+
+static void test_memory_events(struct memcg_kfuncs *skel)
+{
+	unsigned long cur, val;
+	char buf[64];
+	int fd;
+
+	if (!ASSERT_OK(read_memcg_ulong("memory.current", &cur), "memory.current"))
+		return;
+
+	/*
+	 * Push the cgroup over memory.high to raise MEMCG_HIGH. Every charge
+	 * above the limit reclaims, so only overshoot it slightly.
+	 */
+	snprintf(buf, sizeof(buf), "%lu", cur + HIGH_HEADROOM);
+	if (!ASSERT_OK(write_cgroup_file(CG_PATH, "memory.high", buf), "set memory.high"))
+		return;
+	fd = alloc_pagecache_or_skip(2 * HIGH_HEADROOM);
+	write_cgroup_file(CG_PATH, "memory.high", "max");
+	if (fd < 0)
+		return;
+
+	if (run_prog(skel->progs.memcg_query))
+		goto out;
+
+	ASSERT_GT(skel->bss->ev_high, 0, "high event raised");
+
+	if (ASSERT_OK(read_memory_event("low", &val), "read low"))
+		ASSERT_EQ(skel->bss->ev_low, val, "low");
+	if (ASSERT_OK(read_memory_event("high", &val), "read high"))
+		ASSERT_EQ(skel->bss->ev_high, val, "high");
+	if (ASSERT_OK(read_memory_event("max", &val), "read max"))
+		ASSERT_EQ(skel->bss->ev_max, val, "max");
+	if (ASSERT_OK(read_memory_event("oom", &val), "read oom"))
+		ASSERT_EQ(skel->bss->ev_oom, val, "oom");
+	if (ASSERT_OK(read_memory_event("oom_kill", &val), "read oom_kill"))
+		ASSERT_EQ(skel->bss->ev_oom_kill, val, "oom_kill");
+out:
+	close(fd);
+}
+
+static void test_root_memcg(struct memcg_kfuncs *skel)
+{
+	if (run_prog(skel->progs.root_memcg_query))
+		return;
+
+	ASSERT_GT(skel->bss->root_usage, 0, "root usage");
+}
+
+static long do_reclaim(struct memcg_kfuncs *skel, unsigned long size,
+		       int swappiness)
+{
+	skel->bss->reclaim_size = size;
+	skel->bss->reclaim_swappiness = swappiness;
+	skel->bss->reclaim_ret = 0;
+	if (run_prog(skel->progs.memcg_reclaim))
+		return LONG_MIN;
+	return skel->bss->reclaim_ret;
+}
+
+static void test_reclaim_args(struct memcg_kfuncs *skel)
+{
+	ASSERT_EQ(do_reclaim(skel, 0, -1), -EINVAL, "size 0");
+	ASSERT_EQ(do_reclaim(skel, page_size - 1, -1), -EINVAL, "size < PAGE_SIZE");
+	ASSERT_EQ(do_reclaim(skel, page_size, -2), -EINVAL, "swappiness -2");
+	ASSERT_EQ(do_reclaim(skel, page_size, SWAPPINESS_ANON_ONLY + 1), -EINVAL,
+		  "swappiness too large");
+
+	ASSERT_GE(do_reclaim(skel, page_size, -1), 0, "swappiness -1");
+	ASSERT_GE(do_reclaim(skel, page_size, 0), 0, "swappiness 0");
+	ASSERT_GE(do_reclaim(skel, page_size, MAX_SWAPPINESS), 0, "swappiness max");
+	ASSERT_GE(do_reclaim(skel, page_size, SWAPPINESS_ANON_ONLY), 0,
+		  "swappiness anon only");
+}
+
+static void test_reclaim(struct memcg_kfuncs *skel)
+{
+	long ret = 0;
+	int fd, i;
+
+	fd = alloc_pagecache_or_skip(PAGECACHE_SIZE);
+	if (fd < 0)
+		return;
+
+	/*
+	 * Ask for more than one batch. The kfunc clamps the request, but
+	 * reclaim may overshoot its target, so don't bound the result.
+	 */
+	for (i = 0; i < RECLAIM_RETRIES && ret <= 0; i++)
+		ret = do_reclaim(skel, 4 * MEMCG_CHARGE_BATCH * page_size, 0);
+
+	ASSERT_GT(ret, 0, "reclaimed");
+	ASSERT_EQ(ret % page_size, 0, "reclaim page aligned");
+
+	close(fd);
+}
+
+void test_memcg_kfuncs(void)
+{
+	struct memcg_kfuncs *skel = NULL;
+	unsigned long cur;
+	int cgroup_fd;
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	cgroup_fd = cgroup_setup_and_join(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup_setup_and_join"))
+		return;
+
+	if (read_memcg_ulong("memory.current", &cur)) {
+		fprintf(stderr, "%s:SKIP:no memory controller\n", __func__);
+		test__skip();
+		goto out;
+	}
+
+	skel = memcg_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_kfuncs__open_and_load"))
+		goto out;
+
+	skel->bss->cgid = get_cgroup_id(CG_PATH);
+	if (!ASSERT_NEQ(skel->bss->cgid, 0, "get_cgroup_id"))
+		goto out;
+
+	if (test__start_subtest("usage"))
+		test_usage(skel);
+	if (test__start_subtest("invalid_idx"))
+		test_invalid_idx(skel);
+	if (test__start_subtest("memory_events"))
+		test_memory_events(skel);
+	if (test__start_subtest("root_memcg"))
+		test_root_memcg(skel);
+	if (test__start_subtest("reclaim_args"))
+		test_reclaim_args(skel);
+	if (test__start_subtest("reclaim"))
+		test_reclaim(skel);
+
+out:
+	memcg_kfuncs__destroy(skel);
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
+
+void test_memcg_kfuncs_failure(void)
+{
+	RUN_TESTS(memcg_kfuncs_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs.c b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
new file mode 100644
index 000000000000..5e2ea19a072d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+/* in */
+u64 cgid;
+unsigned long reclaim_size;
+int reclaim_swappiness;
+
+/* out */
+unsigned long usage;
+unsigned long ev_low, ev_high, ev_max, ev_oom, ev_oom_kill;
+unsigned long bad_memory_event;
+unsigned long bad_vm_event;
+unsigned long bad_page_state;
+unsigned long neg_memory_event;
+unsigned long neg_vm_event;
+unsigned long root_usage;
+long reclaim_ret;
+
+static struct mem_cgroup *memcg_from_cgid(void)
+{
+	struct mem_cgroup *memcg;
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		return NULL;
+
+	memcg = bpf_get_mem_cgroup(&cgrp->self);
+	bpf_cgroup_release(cgrp);
+	return memcg;
+}
+
+SEC("syscall")
+int memcg_query(void *ctx)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = memcg_from_cgid();
+	if (!memcg)
+		return 1;
+
+	usage = bpf_mem_cgroup_usage(memcg);
+
+	ev_low = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_LOW));
+	ev_high = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_HIGH));
+	ev_max = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_MAX));
+	ev_oom = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_OOM));
+	ev_oom_kill = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_OOM_KILL));
+
+	/* Out-of-range indices must be rejected with (unsigned long)-1. */
+	bad_memory_event = bpf_mem_cgroup_memory_events(memcg,
+		bpf_core_enum_value(enum memcg_memory_event, MEMCG_NR_MEMORY_EVENTS));
+	bad_vm_event = bpf_mem_cgroup_vm_events(memcg,
+		bpf_core_enum_value(enum vm_event_item, NR_VM_EVENT_ITEMS));
+	bad_page_state = bpf_mem_cgroup_page_state(memcg, -1);
+	/* Negative indices must not bypass the bounds checks. */
+	neg_memory_event = bpf_mem_cgroup_memory_events(memcg, -1);
+	neg_vm_event = bpf_mem_cgroup_vm_events(memcg, -1);
+
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
+
+SEC("syscall")
+int root_memcg_query(void *ctx)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = bpf_get_root_mem_cgroup();
+	if (!memcg)
+		return 1;
+
+	root_usage = bpf_mem_cgroup_usage(memcg);
+
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
+
+SEC("syscall")
+int memcg_reclaim(void *ctx)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = memcg_from_cgid();
+	if (!memcg)
+		return 1;
+
+	reclaim_ret = bpf_proactive_reclaim(memcg, reclaim_size,
+					    reclaim_swappiness);
+
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/memcg_kfuncs_failure.c
new file mode 100644
index 000000000000..3fe9f5a14707
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_kfuncs_failure.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int root_memcg_leak(void *ctx)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = bpf_get_root_mem_cgroup();
+	if (!memcg)
+		return 0;
+
+	/* Missing bpf_put_mem_cgroup(). */
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+int root_memcg_no_null_check(void *ctx)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = bpf_get_root_mem_cgroup();
+	/* bpf_get_root_mem_cgroup() is KF_RET_NULL. */
+	bpf_mem_cgroup_usage(memcg);
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+__failure __msg("calling kernel function bpf_proactive_reclaim is not allowed")
+int proactive_reclaim_not_syscall(struct bpf_iter__cgroup *ctx)
+{
+	struct cgroup *cgrp = ctx->cgroup;
+	struct mem_cgroup *memcg;
+
+	if (!cgrp)
+		return 0;
+
+	memcg = bpf_get_mem_cgroup(&cgrp->self);
+	if (!memcg)
+		return 0;
+
+	/* Only BPF_PROG_TYPE_SYSCALL may reclaim. */
+	bpf_proactive_reclaim(memcg, 4096, -1);
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
-- 
2.56.0

