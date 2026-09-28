Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDD3B7B6E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577465; cv=none; b=dEvkU3ct5Lz2/U896BNl9MpQwyj683ZAxlFGNLNGPq4uWYaNkt1MATtypBVhGaj8Sko6CBS1O6IVVY081CBtCzEEqxl3MGTHXgzTeL0xg3N5dNEyJjIxARUE/cygB9L5R7IXWGvPYsXbu4NWFG5X9iUi6p2qaGNubHGBYP6w8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577465; c=relaxed/simple;
	bh=hUT/auhZhasn1dAsICGATUHjPsDMpF0qXhUrLgaODL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxRsldRZRLH/Jeuq4lou9IeU+KjxXb40d82YpUQWrncfYEh3ZkfUoN0GzVKLeyJeNpIIST4eFoY9mqERYvI9S2jxOfAzYzknXsqIcQd1Bok6ptSbrtBvh6nWmHoajnyaGE64gqZ09X2pl8O7skE8yVGBlBrqHebOoIBhNd+EWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqm6sYcZ; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqm6sYcZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hUT/auhZhasn1dAsICGATUHjPsDMpF0qXhUrLgaODL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790577460; v=1; x=1791182260;
 b=mqm6sYcZZxdI07RCjmEa4jjwz/ayN9ZVbZYuI/6DzdGXqHKXfsmcdaOYRz9jSsKAmNzdIVU4
 svOuCUTnClNx2eHCbf22qH1Es5FXrLg5ONzdOyddse1gNWYYSh4jumPlGKc8G0ktWVooXkQcMPu
 W+n10sO6qefzlqFwO7aebrkk=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 10f09c6742e8c7e8;
	Mon, 28 Sep 2026 06:37:40 +0000
X-Mizu-Trace-ID: 10f09c6742e8c7e8
X-Migadu-Flow: FLOW_OUT
From: Hui Zhu <hui.zhu@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	David Hildenbrand <david@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v2] selftests/bpf: Add bpf_proactive_reclaim test
Date: Mon, 28 Sep 2026 14:37:24 +0800
Message-ID: <20260928063724.24008-1-hui.zhu@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

bpf_proactive_reclaim() performs one bounded reclaim pass per call and,
unlike a write to memory.reclaim, does not retry until the goal is
reached.

Charge 32 MiB of page cache to a cgroup, ask for all of it in one call,
and check that the result is positive but well below the request: one
pass is capped at MEMCG_CHARGE_BATCH pages, far short of 32 MiB on both
4K and 64K page kernels.

The test deliberately covers only the kfunc itself. A full example of
the intended asynchronous use, where a BPF program watches one cgroup's
workingset refaults and reclaims another one from bpf_wq callbacks, is
maintained out of tree at [1], released under GPLv2.

Add CONFIG_MEMCG to the config fragment, without which mm/bpf_memcontrol.c
is not built at all.

[1] https://github.com/teawater/memcg-async-reclaim

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
Changelog:
v2:
According to the comment of Alexei, remove the samples/bpf sample patch.
Ship it out-of-tree as a standalone project.

 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/memcg_proactive_reclaim.c  | 124 ++++++++++++++++++
 .../bpf/progs/memcg_proactive_reclaim.c       |  34 +++++
 3 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index d292cb60a5a4..21bb0d4a37cb 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -57,6 +57,7 @@ CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
 CONFIG_LWTUNNEL_BPF=y
+CONFIG_MEMCG=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
new file mode 100644
index 000000000000..d642658a2198
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <limits.h>
+#include <linux/magic.h>
+#include <sys/statfs.h>
+#include <unistd.h>
+
+#include "cgroup_helpers.h"
+#include "memcg_proactive_reclaim.skel.h"
+
+#define CG_PATH "/memcg_proactive_reclaim"
+
+/*
+ * Large enough that a single reclaim pass cannot come close to it, so that
+ * "reclaimed less than was asked for" is not page-size noise: one pass is
+ * capped at MEMCG_CHARGE_BATCH pages, which is 256 KiB on 4K pages but 4 MiB
+ * on 64K pages.
+ */
+#define FILE_SIZE (32 * 1024 * 1024UL)
+#define BUF_SIZE (64 * 1024)
+
+struct reclaim_args {
+	__u64 cgroup_id;
+	__u64 size;
+};
+
+/*
+ * The data file has to sit on a regular filesystem: tmpfs pages are charged
+ * as shmem, so whether they can be reclaimed at all depends on swap being
+ * available. /tmp is tmpfs on many systems, and test_progs is routinely run
+ * from a tmpfs working directory, so both candidates need the check.
+ */
+static const char *workload_dir(void)
+{
+	static const char * const dirs[] = { "/tmp", "." };
+	struct statfs st;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dirs); i++)
+		if (!statfs(dirs[i], &st) && st.f_type != TMPFS_MAGIC &&
+		    st.f_type != RAMFS_MAGIC)
+			return dirs[i];
+
+	return NULL;
+}
+
+void test_memcg_proactive_reclaim(void)
+{
+	struct memcg_proactive_reclaim *skel = NULL;
+	struct reclaim_args args = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .ctx_in = &args,
+		    .ctx_size_in = sizeof(args));
+
+	char data_file[PATH_MAX];
+	static char buf[BUF_SIZE];
+	__u64 cgroup_id;
+	const char *dir;
+	off_t off;
+	int cg_fd = -1, data_fd = -1, err;
+
+	dir = workload_dir();
+	if (!ASSERT_OK_PTR(dir, "workload dir on a regular filesystem"))
+		return;
+
+	snprintf(data_file, sizeof(data_file),
+		 "%s/memcg_proactive_reclaim_XXXXXX", dir);
+	data_fd = mkstemp(data_file);
+	if (!ASSERT_GE(data_fd, 0, "mkstemp"))
+		return;
+
+	cg_fd = cgroup_setup_and_join(CG_PATH);
+	if (!ASSERT_OK_FD(cg_fd, "cgroup_setup_and_join"))
+		goto out;
+
+	cgroup_id = get_cgroup_id(CG_PATH);
+	if (!ASSERT_GT(cgroup_id, 0, "get_cgroup_id"))
+		goto out;
+
+	skel = memcg_proactive_reclaim__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+
+	/*
+	 * Charge FILE_SIZE of page cache to the cgroup. Reading rather than
+	 * writing keeps the pages clean, so reclaim does not have to start
+	 * writeback before it can evict them.
+	 */
+	if (!ASSERT_OK(ftruncate(data_fd, FILE_SIZE), "ftruncate"))
+		goto out;
+	for (off = 0; off < (off_t)FILE_SIZE; off += sizeof(buf))
+		if (!ASSERT_GT(read(data_fd, buf, sizeof(buf)), 0, "read"))
+			goto out;
+
+	args.cgroup_id = cgroup_id;
+	args.size = FILE_SIZE;
+	skel->bss->reclaimed = 0;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.memcg_proactive_reclaim),
+				     &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 0, "retval"))
+		goto out;
+
+	/*
+	 * A single call is a single bounded pass: it reclaims something, but
+	 * stops well short of the requested size instead of retrying until the
+	 * goal is reached the way a write to memory.reclaim does.
+	 */
+	ASSERT_GT(skel->bss->reclaimed, 0, "reclaimed");
+	ASSERT_LT(skel->bss->reclaimed, (__s64)FILE_SIZE, "single pass");
+
+out:
+	if (skel)
+		memcg_proactive_reclaim__destroy(skel);
+	if (cg_fd >= 0)
+		close(cg_fd);
+	if (data_fd >= 0) {
+		close(data_fd);
+		unlink(data_file);
+	}
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c
new file mode 100644
index 000000000000..b551192526fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct reclaim_args {
+	__u64 cgroup_id;
+	__u64 size;
+};
+
+/* Signed, because bpf_test_run_opts.retval is a __u32. */
+__s64 reclaimed;
+
+SEC("syscall")
+int memcg_proactive_reclaim(struct reclaim_args *ctx)
+{
+	struct mem_cgroup *memcg;
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(ctx->cgroup_id);
+	if (!cgrp)
+		return 0;
+
+	memcg = bpf_get_mem_cgroup(&cgrp->self);
+	if (memcg) {
+		reclaimed = bpf_proactive_reclaim(memcg, ctx->size, -1);
+		bpf_put_mem_cgroup(memcg);
+	}
+	bpf_cgroup_release(cgrp);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

