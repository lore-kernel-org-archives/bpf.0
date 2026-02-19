Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52D86277
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511506; cv=none; b=Yxnx8kKxJGz60Q4El3dEGdn5jEZ/6r6HW30iXDqfcH5rfCgs4CKlsPQUOiH/0bC99mzeRfTCGeDix3wAQGYBXcgdrOMzzym6sNODGZnWe2wSxC5qU2RTxUjnVCDTFyZJG8Y9k/JMkcBd/fTNVzKdR0yLFxxiN2/BwNyRLYKLurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511506; c=relaxed/simple;
	bh=ypZOtjUaRaMCXC1q6gBRjeCXf2W7vKM3BCik4l5EdmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnUajEfvPdvVkMeiZtMSyDCrtCDTHjNJ45OcsaEu8Wccm4/ph+af3o3Jwfo7GuZCM32h1wzv6yaT98HSGGUyuMdy5hxM14l1XAgNVZK9rsUKDX/RbBUoFIoV+0JRPDCC6UJGIP24cp0p+RzZ6jOE37ZLKXNpzFLgevHycKFJP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmq3iPTU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmq3iPTU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNWdJdK58m69LHIGW7l7DEM1Iok2ekKHAFCQkjcDuSU=;
	b=pmq3iPTU63sGP1ZRWI1plSYlIte7DRbyd44PXvjrbFkYECiRO2VgIlPGgGYL84uz3EB28a
	l66sqiSOUYeMXIAIyJkZkrwGIRzeuQWlmkkdDPEuthjbgQ+eODaXueBFgt4EY9LOVQREtV
	jYWNkODtdCcUubHfy1Q5R3NBRGfFRHA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: Add tests for 64-bit bitops kfuncs
Date: Thu, 19 Feb 2026 22:29:26 +0800
Message-ID: <20260219142933.13904-5-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-1-leon.hwang@linux.dev>
References: <20260219142933.13904-1-leon.hwang@linux.dev>
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

Each subtest compares kfunc results against a userspace reference
implementation over a set of test vectors.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   9 +
 .../testing/selftests/bpf/prog_tests/bitops.c | 182 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    |  68 +++++++
 3 files changed, 259 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 9df77e59d4f5..02a985ef71cc 100644
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
index 000000000000..9acc3cb1908c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bitops.c
@@ -0,0 +1,182 @@
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
index 000000000000..deac09bc8683
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bitops.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
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

