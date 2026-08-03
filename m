Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC41FBE90;
	Mon,  3 Aug 2026 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716314; cv=none; b=ptPPmVjPB6v+LbSYy/hSsMNXI+F7jLDhELxmm2b2TYclwbcgfnhqZ8LsVm7Jtv4vup2UM2pai4viBG2Gj80y7Ji6JbJQtqzApfmQK+5HRBK4qqz6NgbPa+6YmGcF3PY1WYT05cVv3hzD5KrvTQzbku8zfw6Tr6JGjMbwoNr8W4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716314; c=relaxed/simple;
	bh=4G4qkqcfZJqsxDoMwOpwGSK3L4CO0VbzmkKKK274Dko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wd/77fKCMzSgHRFGwHnmGTT7vKxfL7Mv0nvQaZrhIkSPX+Tnr58ubA2kddUb3LOrR61bFvb5D1wt36Uw+/MME39gN+YMzpImZdD0+6RfnewK5c4aO2H5hhCbR3wYKKHDMPsrJUXCLzP9VVPob/7hJm2hGI/opEvLMyT+mtU6f28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rBhbQh9U; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rBhbQh9U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=NtvZNxuGXBE6cCwIJ9jXeZKQzir6kUFrZef6tlTlq3Y=; b=
	rBhbQh9UcM8s+a3xoAtdYgcjrFfPejWVAP02zixW4ane1I+KWzZ1dc6wyz/G8RWUE0AkJpiQxcttp
	+qjuf6fQLE5qz93AHAGPb/3DVUnA72hPqGazbnRNA0tcGhZnswBLyMqTDVXivYmkanJxr9lVFFmaQ
	YaZ7DrTe27LEs6LFzHb1HwHkpX3f69xyAx+JFQBO8UBT4M6CxgDq8NR5wlp8vY0IF00OQV05Ri3Mq
	9Vifvi/Q3EK1xsLGeRkWE6AicAK0F3F5sdKNhgtsvUS56OqnyB5jiWisS3eUdA+8P1bL0n249FM5z
	v6Sb/9xeHYE3OreRvZ3aHw6nJcbC39itfw==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wqgNj-00CkKO-F9; Mon, 03 Aug 2026 02:18:16 +0200
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH] selftests/bpf: Remove duplicate copies of the arena spinlock qnodes
Date: Mon,  3 Aug 2026 09:18:07 +0900
Message-ID: <20260803001807.646357-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
every translation unit including it emits a copy. __weak makes them all
resolve to one instance, but bpftool gen object merges only the symbols
and concatenates each input's .addr_space.1 bytes, leaving the surplus
copies unreferenced in the linked object.

libarena links ten such units, so nine copies were dead weight (bytes):

  object                             before       after
  -----------------------------------------------------
  .addr_space.1 in libarena.bpf.o    676200       86376
  libarena.skel.h                   2100123      892371
  libarena_asan.skel.h              2641124     1466477

Declare qnodes in the header and let each program define it once:
libarena in src/common.bpf.c, and the arena_spin_lock test beside the
lock it guards.

Tested with test_progs -t arena_spin_lock and -t libarena.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h   | 7 +------
 tools/testing/selftests/bpf/libarena/src/common.bpf.c      | 7 +++++++
 tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 7 +++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index ae6b72d15bb6..71d9db610263 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -103,12 +103,7 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-/*
- * The qnodes are marked __weak so we can define them in the header
- * while still ensuring all compilation units use the same struct
- * instance.
- */
-struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+extern struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
 {
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 50be57213dfb..06481f2a2892 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -8,6 +8,13 @@ const volatile u32 zero = 0;
 
 struct buddy __arena buddy;
 
+/*
+ * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each program
+ * linking the arena spinlock provides exactly one definition, so that the array
+ * is emitted once rather than once per translation unit.
+ */
+struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+
 int arena_fls(__u64 word)
 {
 	if (!word)
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index cf7cda79c16c..92e75ec3844c 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -23,6 +23,13 @@ int cs_count;
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 arena_spinlock_t __arena lock;
 int test_skip = 1;
+
+/*
+ * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each program
+ * linking the arena spinlock provides exactly one definition; libarena's lives
+ * in libarena/src/common.bpf.c.
+ */
+struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 #else
 int test_skip = 2;
 #endif
-- 
2.55.0

