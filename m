Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4237F33A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649442; cv=none; b=jNdVCA9Jf61vGY+6jqYt4SuBMfxL3koeCUQ8rExEZIUP9Y8D3FFAKDq703ig3IQMjuFnlsSZvCtvcTCfzPpsPRJXIEfSAVnwG8mP5TRH2+FOHudlJnaRSNPCRrkkMa7yNjZR1gbSJLKEiN/++RcibvoUTcmN1MgUFc+CRkcJWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649442; c=relaxed/simple;
	bh=/BsbueomfXe2HWe7dKMC91m9BQ+gYnvao1rVqd4EO+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWSKgPmcp/4+hDaHx1dxMXrYekoXNmmgrEkd0Q9vcQtctPrcJ/pmorL/VXCrzi81FaLtHf2fGRdb4fQyXKL5O0CX8gRoevQDmPN/cqR2FUkErnss3Grqzn89NC2MYVMoJp+mznoN1Mq9D+m6mHKGphIK2YjuxWQf/670P0el5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5uisgXL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5uisgXL"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2740737a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649431; x=1788254231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XDmPbfiRnsS7eZR0pt9lG35sDknRI2CXdYIEXPZTmw=;
        b=i5uisgXLkWMnAbrfPrHRYzosq3s3pRrRE7oweJu1KYPI3XjL0jGmYE/fKtsISqGkPT
         vY9J8zKRWepNHWhSsbYqh1CFbRJuQJbIq/ZR15dLn4ce803rzXw5TI0+OTkMAYyHHcAk
         Q4nD5fGwPLqddk27+q1jjJz6MFtdN2MldFJ4hOaiib5/PMXxUnQJfNoeAmB8YGaCaU7I
         bSmTcDwYiuvgeTrm8buQcPorP7JDfcIea7h48ErwIp86EjKaoFL9QkoIgGfqdbZVS2pD
         RJ6AEC3+5Av5ymPnCQmBr5d0Ex1z6nluV6avfBTWPY+ePWInwCQ7mnrXWPyZwV3IzAv3
         qhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649431; x=1788254231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XDmPbfiRnsS7eZR0pt9lG35sDknRI2CXdYIEXPZTmw=;
        b=Zi9CItTH/SidfO4a7f1I+0fGfj4hNulhRjcdLIS21t9fXSGptswYuSVjsidgrg34qJ
         mzLz0t8fPz/ihhs5MYm+XWsTqywPsoFcMbxvqZ3QjYcViB4bqbhFPbL+FOPGoOIe+xu1
         vofo+4DkHME6xbKQVSEOvNyHbGUV9eeva8XQbR/X5vUhwoK4662zGiMtmRmfOchqckMC
         C5gLa4gLDGJ0Et/rWjPGV2Ta0qXLYsaedEkcKl/pHoJTqjb7Pj33h1VdWI/5ZjGmCEBT
         WSAwULVMZkLfxMepn6GikhWEeNz/XNz/q3Euz2rnDgHFoaJ/NwT8+otpWr4j98ncgvqj
         fbCg==
X-Gm-Message-State: AFuF++kHSM+gcqmEn1i04Ki5qpFx22OP+0PVxNrFtM4sIGElgb71ss5G
	w7z+c2WcbfTeRQOvGvpe8TXtLN1btdIBX+WvUxzOSCTBgH/1wi+qy6JO9S0Ou2Y/Pq0=
X-Gm-Gg: AR+sD12KF/sXEqtBnajkxEywch9PTx9Tk2aBzY5ZqxKVqedV9/TqNTPMpGwvSXtxqNC
	iBWiBW+pnP16Dlho9FOB7WXhFJXWdsOx2im4jogJUBS4SZOl8ddlFQztraeTw5wsVRZKixKuYfd
	KSp2FWuBd2ChOvYwmeNtLMbavm4KFXjajE3gxyNZ2/CaFwVPtphx+BiKpckyu8Ioij78CNYnsRI
	TquYlbiEZ0hBheyKF++mPsYRmHjL9eiZ0LVfcGXu6ZDocsSrP/7GUAR4q+4BbkWvIRm2QCHvaoN
	labK7XKeTdA/Wh29UF+9+dsaFWBb9VWfpy1meTzWiV44v5Da9BeKiTR6KYkvjofZq0FFmtE3gqC
	UHBHuA5CmT9jx70RcO08TlXBF7kiiy7GbtHAIRMMWcAvUJy9B/dxr6s5E2OMui+VTTJ3RZIC8OJ
	8qTZCp+ylkD4R0ykVim4bTfFtD1SYo9HZs+voQB7ysGpt7qucPe2nNkb5aGEsRW0ia4NSDnwqlS
	d8rOOLDfuZbnDDFKEs=
X-Received: by 2002:a17:90b:2f0c:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395c3847e85mr61257487a91.16.1787649431238;
        Tue, 25 Aug 2026 02:17:11 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm52122658c88.8.2026.08.25.02.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:17:10 -0700 (PDT)
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
Date: Tue, 25 Aug 2026 14:46:47 +0530
Message-ID: <20260825091647.81632-5-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
References: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
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

