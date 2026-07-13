Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4D371CE9;
	Mon, 13 Jul 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910660; cv=none; b=I5SyvQbentT/aoMldPk44CofOY41tf4j+09BtLECVUkNr0TCeg290T82MBIuK4n+2K7TNpVi5nxqrkCMxDT4I6csdCSQDnDPM7Y1HWD8+gvpL7wTcQM7tMsq6rG8KE+6/umO93kYA1OgJIp/raMECrPm3/NifCR5lW1KtCc+2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910660; c=relaxed/simple;
	bh=r6eZKf1Py+AjIeeMe5G+N4judbNG+2UPCdSbWq1M6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSKbqb97/gjNvd0iSBt1DrrqFtMIANB8boYMNc4xq73/G2t7+08oM4dlbGacgYHc8GiKzFg2VFOg1/qkcclQ7ueHh4QAuBFASK8pjh1hn8BkDWVPwJ28PpjCzR0i2H/KwzSdSvwifJBWYiPzwXkZwhn+2tdF7OllWK4ZOfyY7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQUOO+yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQUOO+yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F011F000E9;
	Mon, 13 Jul 2026 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910658;
	bh=RVcQpqbO4up4g0Hy0J+YgHqp9iQS+fAn5yaVmEvP0So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQUOO+yC3Pp/M8nP23+TslF1FOmsaYNqEBdIuyO/LlnvQmR0cnO5TH9k3dGzkm7aV
	 OG0m+Iy6sD57PH9i+yr+GwR3xNreIVB2LDt6QDhG0WtHf4W5zK8w80Z9gWQrfH9IMt
	 6jmwsfjak9tmqBwdAgXckiUt6zpPcciP7YnOAGIhSOtpgulDDf6ie8iovnILMRBONe
	 KuMki/NETSUGukuRaPgFd6PqHipR40wFbNz7tFKEP9wdxAAg9zUffvk8TjixVnQ3hd
	 31E95M8Esujf7N99NfuzPzOq82X/s52Hnj2c0OjJH87a++BTmX2Dq3G246dbwBips9
	 sPLHQB01jpgog==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 2/6] selftests/bpf: Add kfunc __arena argument tests
Date: Sun, 12 Jul 2026 16:44:10 -1000
Message-ID: <20260713024414.3759854-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713024414.3759854-1-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arena-argument kfuncs to bpf_testmod, which also exercises the
argument rebasing on module kfuncs, and tests covering the accepted
argument forms (arena pointer, low 32 bits as a scalar, full user address
as a scalar, NULL), five arena arguments in one call with NULLs mixed in,
a kernel-side dereference of an unpopulated page recovering through the
scratch page, and the rejections (no arena in the program, incompatible
register type).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_kfunc.c    |  14 ++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 135 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  33 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   4 +
 4 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c b/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
new file mode 100644
index 000000000000..8946184553ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+#include <test_progs.h>
+
+#include "arena_kfunc.skel.h"
+
+/* The test kfuncs live in bpf_testmod. Resolving kfuncs against module
+ * BTFs needs CAP_SYS_ADMIN, so run with full capabilities instead of
+ * through the verifier tests' capability-restricted runner.
+ */
+void test_arena_kfunc(void)
+{
+	RUN_TESTS(arena_kfunc);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
new file mode 100644
index 000000000000..b5996944ed73
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* volatile to force the scalar reloads below */
+volatile u64 stash;
+
+SEC("syscall")
+__success __retval(0)
+int arena_arg_forms(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	u64 ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	/* PTR_TO_ARENA argument */
+	*val = 41;
+	ret = bpf_kfunc_arena_arg_test((u64 *)val);
+	if (ret != 41 || *val != 42)
+		return 2;
+
+	/* the low 32 bits as a scalar */
+	stash = (u64)val;
+	ret = bpf_kfunc_arena_arg_test((u64 *)stash);
+	if (ret != 42 || *val != 43)
+		return 3;
+
+	/* the full user address as a scalar */
+	stash = (u64)val;
+	bpf_addr_space_cast(stash, 1, 0);
+	ret = bpf_kfunc_arena_arg_test((u64 *)stash);
+	if (ret != 43 || *val != 44)
+		return 4;
+
+	/* NULL is preserved */
+	ret = bpf_kfunc_arena_arg_test(NULL);
+	if (ret != 0xdeadbeef)
+		return 5;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int arena_args5(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	val[0] = 1;
+	val[1] = 2;
+	val[2] = 4;
+	val[3] = 8;
+	val[4] = 16;
+
+	if (bpf_kfunc_arena_args5_test((u64 *)&val[0], (u64 *)&val[1],
+				       (u64 *)&val[2], (u64 *)&val[3],
+				       (u64 *)&val[4]) != 31)
+		return 2;
+
+	/* mix in NULLs */
+	if (bpf_kfunc_arena_args5_test((u64 *)&val[0], NULL, (u64 *)&val[2],
+				       NULL, (u64 *)&val[4]) != 21)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+/* kernel-side faults on unpopulated pages recover via the scratch page */
+SEC("syscall")
+__success __retval(0)
+int arena_arg_unpopulated(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
+	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64))
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	stash = (u64)val + PAGE_SIZE;
+	bpf_kfunc_arena_arg_test((u64 *)stash);
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("arena pointer requires a program with an associated arena")
+int arena_arg_no_arena(void *ctx)
+{
+	bpf_kfunc_arena_arg_test((u64 *)1);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("is not a pointer to arena or scalar")
+int arena_arg_bad_reg(void *ctx)
+{
+	u64 buf = 0;
+
+	/* use the arena so the program passes the arena presence check */
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_arg_test(&buf);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..9cc10c48a2d6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -210,6 +210,37 @@ __bpf_kfunc void bpf_kfunc_common_test(void)
 {
 }
 
+__bpf_kfunc u64 bpf_kfunc_arena_arg_test(u64 *val__arena)
+{
+	u64 old;
+
+	if (!val__arena)
+		return 0xdeadbeef;
+
+	old = *val__arena;
+	*val__arena = old + 1;
+	return old;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_args5_test(u64 *a__arena, u64 *b__arena,
+					   u64 *c__arena, u64 *d__arena,
+					   u64 *e__arena)
+{
+	u64 sum = 0;
+
+	if (a__arena)
+		sum += *a__arena;
+	if (b__arena)
+		sum += *b__arena;
+	if (c__arena)
+		sum += *c__arena;
+	if (d__arena)
+		sum += *d__arena;
+	if (e__arena)
+		sum += *e__arena;
+	return sum;
+}
+
 __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 				       struct bpf_dynptr *ptr__nullable)
 {
@@ -723,6 +754,8 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c36bb911defa..932acf86c73f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -98,6 +98,10 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+__u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_args5_test(__u64 *a__arena, __u64 *b__arena,
+				 __u64 *c__arena, __u64 *d__arena,
+				 __u64 *e__arena) __ksym;
 int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-- 
2.55.0

