Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BC3F1660
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649619; cv=none; b=AEa8xcxzLns659JoWS6kT6shIi+w2abUhh0r43W5O77/WplcN1l7cwDPtP1XyePnpGQoj/wTYMvettzHPSkY/n5RVL1BtCFNtJ4dHa8u6pKrbLrqcAedD2JSoirW4Hfa2RQaUB80OXZVcDcfGHi/BaIlFvbPfr+xCEa5lDJ6YmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649619; c=relaxed/simple;
	bh=NnD+lhD9+A+o9OkKxEE5WkpWKL8Rx0Ut6UVR7teDV8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODP+rwVHLcwY7aAa+J4VC7cyOLCNelstWeKQ3RjkbBQNtjfS0IdDbSet3PlNuxirSUMBgfBebD18gyyuh/zGDL5tfp7mLWinK89c1WGiP+Y3KA3oHivsBCVsaFBi6Z0xLIJIJGO7ETaZvr0WtvX8GdCaiz+r+7pUqqx7Pefwpnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2cub8tt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2cub8tt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so49239885ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649617; x=1788254417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNBcnjuWFLDFOhwY/VldMF42J5EyV88DFjmxmI2ZQhM=;
        b=d2cub8ttToy8NBWMprf0BmAlauvwpMeh/JqGIi0HCfY5csuLKEhn8nWdU44jOW7hPK
         nLDj+z2HksyXFPqqAhIl9P6T0SokF/yXP5hsfnU3JY+2o304cOPS2PwTMGDeYK34N+cT
         Py3Px0Kii/GP9Mz2Sl4Jf7+tm0zTVPfOB7XSFWUvrOfFTgLQbvBjqjJN986TRxSAo85i
         ieMVwQtl4gwBlGD0SGmuX8OdoaIWGAtdbVTq17sXhwbEIRaTUfRl7KBBxIfArUD9RgAD
         pNGXYIQuLSDEt3yaHFD+/p1GEN7wgsBwOzv9JyUXDoA0vbY/yhjRkPk9GXzSUVbbfCD5
         1KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649617; x=1788254417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNBcnjuWFLDFOhwY/VldMF42J5EyV88DFjmxmI2ZQhM=;
        b=hV8woKXI8F4kWam62QJmMMgCjTzqvcGhY+j8ZkrU13Fjvec7wF9oG7cnxFYlir0fAp
         RCn4sCc8DhXNpbx7ZhV8mlFRq96SZJlO+QETCYiR2URZORXL2eHJMV2B3n2Hzr9DGKFn
         fGMOo5zgbMocLEO/lIHgfkhY6Odwfm1GxNw738fe+BRMeEcBLdDaDuLOE+ji1paf/NaU
         +apSHT9obA0zd6E5eE+dUyruauufgs97GQJKQo9dLTa1GjRlQAHwWaq/6Gz2j2TlYm1p
         oxNUGBZijljTD/nHnIeXAohxPtBRxPl7Kc47Od/DMueJrAS3trSqAyYZ2g/R6H0QptdM
         NDAQ==
X-Gm-Message-State: AFuF++kcj7KENABKAOGWYKv40QdG2s6Y68Hk08I6q97xaeumL4SHD7p4
	5Lvo8lQdSkrsjKsM2aq+kOrDGVF/PbNxM3nWWy0k3ZKs1bHFul/4HATpg/g6MnYmnEA=
X-Gm-Gg: AR+sD11qMwkitt8vmMWdWNKaarvJ8K9D5Dluq3OGzPahw5pPAo6PNCdnacsSk+KwYun
	91ptM/bsYuADzIddlELddQk9g4u/RndGWACdLBju2pNSnJ7/7rz0Ro5O7KDvlTp6QBYxBaOVDGo
	h0OpGeHDcWwwLezqGBOhRSuWu9o+CrD7EvdRFpaN7fjMuNAHdeGPFAD8lAOEZb+VYYCIONPbeN8
	CxWpFtHlZ48cs25LkOZcMhqb76TcpmnkaIzq8wlCTo+TtPkXA9FEtEJ29cx+QtYuRPP0Vp0qej4
	Qu+m2Gb9D6XYPZYqt/5fFJ3rHjHiED/EKb5YMAxtzJVezxnuamLcQ3MRrIpKDbVqAe4t4kIXv0c
	aRcQmBogtG3op3/ug8YEYjwWDLWsSYsgiKrPYQFNQrn5w7FiVjSaC9QlQakjZq0//tBgCPMwROb
	l1Ys4rFSOIoLHmqNktWeVzPwvTwhVucXd085L6kXaDG3CcENdQb0g/OMUDWYt35BJP4iHm5VzK8
	oTSpEge4JYX/2EfMOo=
X-Received: by 2002:a17:903:40d1:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2d6f6ba2701mr37235115ad.7.1787649616699;
        Tue, 25 Aug 2026 02:20:16 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm5386163eec.30.2026.08.25.02.20.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:20:15 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH v6 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Tue, 25 Aug 2026 14:49:52 +0530
Message-ID: <20260825091952.81971-5-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

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
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 2 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 0000000000..c57b98494c
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
index 0000000000..88259cfea0
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
2.54.0 (Apple Git-157)

