Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E23803E9
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652807; cv=none; b=iozs92Py0CWQ++9utYx9KJqwsjM2jlJk2k1rGy8dOPEdhEW4UbKNeCdj7nCuT7tWB4RiFr30bDa1zhfRoJL8Wdw1rXURqMdl8mziLsf286ucB18V6wkeCy6Zk3Ed308YFYoHBUaNAlpNTvi9mFH2+XZ1ApOGw8XZXj8DA2Vs6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652807; c=relaxed/simple;
	bh=NnMj8Hr3G5bNfq8rORCiRCyKWmmQy8YA3LAXuI8+M6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2B6afLzfIjxgzLyDc3Pp8j3iSOMMJyTbV/USFWbzbnkd50ZlsnQRN/3byb6KL2a1OREQBA1iHbOKsxK7B8G1AZfJrRt+PYjx/D6KQ/AN61oBs3A3TP98BZeTOwWPlEct3ETWl+zwGvBdtYcnpt8NRkuAEI2m7rZdfutm6PER6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nfdGedr8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nfdGedr8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770652805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GKllV3i8YUAF/OfePwgNCK21+9RjTa9TFhy6D3akBc=;
	b=nfdGedr8JSb4MvnaZgiPl+yebL7r6QHFOHVVq6x/M1j2sP8H2nPi19ER6A31MI92XgtrpP
	R6S9md9Np1iiEC60B7HoImxtDjuig/XI1tRu+SHl1bRIDfVpNYjssBEcPKroNf2sN9RILL
	OHquyGmrVoXZePeFK1jiFU5VO+/lk4s=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 4/4] selftests/bpf: Add tests for 64bit bitops kfuncs
Date: Mon,  9 Feb 2026 23:59:15 +0800
Message-ID: <20260209155919.19015-5-leon.hwang@linux.dev>
In-Reply-To: <20260209155919.19015-1-leon.hwang@linux.dev>
References: <20260209155919.19015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add selftests for bpf_clz64(), bpf_ctz64(), bpf_ffs64(), bpf_fls64(),
bpf_bitrev64(), bpf_popcnt64(), bpf_rol64(), and bpf_ror64().

Each subtest compares the kfunc result against a userspace reference
implementation across a set of test vectors. If the JIT does not support
inlining a given kfunc, the subtest is skipped (-EOPNOTSUPP at load
time).

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   9 +
 .../testing/selftests/bpf/prog_tests/bitops.c | 186 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    |  69 +++++++
 3 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..3a7d126968b3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -594,6 +594,15 @@ extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;
 
+extern __u64 bpf_clz64(__u64 x) __weak __ksym;
+extern __u64 bpf_ctz64(__u64 x) __weak __ksym;
+extern __u64 bpf_ffs64(__u64 x) __weak __ksym;
+extern __u64 bpf_fls64(__u64 x) __weak __ksym;
+extern __u64 bpf_bitrev64(__u64 x) __weak __ksym;
+extern __u64 bpf_popcnt64(__u64 x) __weak __ksym;
+extern __u64 bpf_rol64(__u64 x, __u64 s) __weak __ksym;
+extern __u64 bpf_ror64(__u64 x, __u64 s) __weak __ksym;
+
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
diff --git a/tools/testing/selftests/bpf/prog_tests/bitops.c b/tools/testing/selftests/bpf/prog_tests/bitops.c
new file mode 100644
index 000000000000..59bf1c5b5102
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bitops.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bitops.skel.h"
+
+struct bitops_case {
+	__u64 x;
+	__u64 s;
+	__u64 exp;
+};
+
+static struct bitops_case cases[] = {
+	{ 0x0ULL, 0, 0 },
+	{ 0x1ULL, 1, 0 },
+	{ 0x8000000000000000ULL, 63, 0 },
+	{ 0xffffffffffffffffULL, 64, 0 },
+	{ 0x0123456789abcdefULL, 65, 0 },
+	{ 0x0000000100000000ULL, 127, 0 },
+};
+
+static __u64 clz64(__u64 x, __u64 s)
+{
+	(void)s;
+	return x ? __builtin_clzll(x) : 64;
+}
+
+static __u64 ctz64(__u64 x, __u64 s)
+{
+	(void)s;
+	return x ? __builtin_ctzll(x) : 64;
+}
+
+static __u64 ffs64(__u64 x, __u64 s)
+{
+	(void)s;
+	return x ? (__u64)__builtin_ctzll(x) + 1 : 0;
+}
+
+static __u64 fls64(__u64 x, __u64 s)
+{
+	(void)s;
+	return x ? 64 - __builtin_clzll(x) : 0;
+}
+
+static __u64 popcnt64(__u64 x, __u64 s)
+{
+	(void)s;
+	return __builtin_popcountll(x);
+}
+
+static __u64 bitrev64(__u64 x, __u64 s)
+{
+	__u64 y = 0;
+	int i;
+
+	(void)s;
+
+	for (i = 0; i < 64; i++) {
+		y <<= 1;
+		y |= x & 1;
+		x >>= 1;
+	}
+	return y;
+}
+
+static __u64 rol64(__u64 x, __u64 s)
+{
+	s &= 63;
+	return (x << s) | (x >> ((-s) & 63));
+}
+
+static __u64 ror64(__u64 x, __u64 s)
+{
+	s &= 63;
+	return (x >> s) | (x << ((-s) & 63));
+}
+
+static void test_bitops_case(const char *prog_name)
+{
+	struct bpf_program *prog;
+	struct bitops *skel;
+	size_t i;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = bitops__open();
+	if (!ASSERT_OK_PTR(skel, "bitops__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+
+	err = bitops__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "bitops__load"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		skel->bss->in_x = cases[i].x;
+		skel->bss->in_s = cases[i].s;
+		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+			goto cleanup;
+
+		if (!ASSERT_OK(topts.retval, "retval"))
+			goto cleanup;
+
+		ASSERT_EQ(skel->bss->out, cases[i].exp, "out");
+	}
+
+cleanup:
+	bitops__destroy(skel);
+}
+
+#define RUN_BITOPS_CASE(_bitops, _prog)					\
+	do {								\
+		for (size_t i = 0; i < ARRAY_SIZE(cases); i++)		\
+			cases[i].exp = _bitops(cases[i].x, cases[i].s);	\
+		test_bitops_case(_prog);				\
+	} while (0)
+
+static void test_clz64(void)
+{
+	RUN_BITOPS_CASE(clz64, "bitops_clz64");
+}
+
+static void test_ctz64(void)
+{
+	RUN_BITOPS_CASE(ctz64, "bitops_ctz64");
+}
+
+static void test_ffs64(void)
+{
+	RUN_BITOPS_CASE(ffs64, "bitops_ffs64");
+}
+
+static void test_fls64(void)
+{
+	RUN_BITOPS_CASE(fls64, "bitops_fls64");
+}
+
+static void test_bitrev64(void)
+{
+	RUN_BITOPS_CASE(bitrev64, "bitops_bitrev");
+}
+
+static void test_popcnt64(void)
+{
+	RUN_BITOPS_CASE(popcnt64, "bitops_popcnt");
+}
+
+static void test_rol64(void)
+{
+	RUN_BITOPS_CASE(rol64, "bitops_rol64");
+}
+
+static void test_ror64(void)
+{
+	RUN_BITOPS_CASE(ror64, "bitops_ror64");
+}
+
+void test_bitops(void)
+{
+	if (test__start_subtest("clz64"))
+		test_clz64();
+	if (test__start_subtest("ctz64"))
+		test_ctz64();
+	if (test__start_subtest("ffs64"))
+		test_ffs64();
+	if (test__start_subtest("fls64"))
+		test_fls64();
+	if (test__start_subtest("bitrev64"))
+		test_bitrev64();
+	if (test__start_subtest("popcnt64"))
+		test_popcnt64();
+	if (test__start_subtest("rol64"))
+		test_rol64();
+	if (test__start_subtest("ror64"))
+		test_ror64();
+}
diff --git a/tools/testing/selftests/bpf/progs/bitops.c b/tools/testing/selftests/bpf/progs/bitops.c
new file mode 100644
index 000000000000..5d5b192bf3d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bitops.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+
+__u64 in_x;
+__u64 in_s;
+
+__u64 out;
+
+SEC("?syscall")
+int bitops_clz64(void *ctx)
+{
+	out = bpf_clz64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_ctz64(void *ctx)
+{
+	out = bpf_ctz64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_ffs64(void *ctx)
+{
+	out = bpf_ffs64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_fls64(void *ctx)
+{
+	out = bpf_fls64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_bitrev(void *ctx)
+{
+	out = bpf_bitrev64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_popcnt(void *ctx)
+{
+	out = bpf_popcnt64(in_x);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_rol64(void *ctx)
+{
+	out = bpf_rol64(in_x, in_s);
+	return 0;
+}
+
+SEC("?syscall")
+int bitops_ror64(void *ctx)
+{
+	out = bpf_ror64(in_x, in_s);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

