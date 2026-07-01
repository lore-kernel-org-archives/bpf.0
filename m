Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6024192FA;
	Wed,  1 Jul 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900240; cv=none; b=U7xhmSyk++CD775xlM7V72st/euAsXl2pdO1Mzj7d7o6ZrjYcFwgGoOdOla1pKHI9xcIruh05NoGJWHJuXCwu94z0bHn6auNjeC0DinSLK0XrXbbmnBlkDXxEoQcss3NCuhcc4DBtompJCzQu3jMVOrBQfZDHEkHH937mUrFEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900240; c=relaxed/simple;
	bh=8zJin5i8gfA22HIJG9ShOlT9pA42ienL7mZZ6pkjGOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWuvdMHTfx+7w1rOX+L5iWIdiQOZ6MPmMaj7mUrz2BBnI88DUe4eZ4Vyvp42M/Z/nnqZOy8dSXNhKWSZl9pWIaYMQpfWCouKUtMIrwjGX1bFe7t9u+n40Pkox7RC4T8+/oIjOR9aEgXa5epo/xgJQ2UOaIMH6zAOElz23yMFQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uVYq9xNl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uVYq9xNl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 941FAC79AB6;
	Wed,  1 Jul 2026 10:04:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC61860288;
	Wed,  1 Jul 2026 10:03:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A418104C9A7E;
	Wed,  1 Jul 2026 12:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900234; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WT5Zo7CNNpMSS7ovTRV+VufZ6alIsGPm26Lb+OF5xmw=;
	b=uVYq9xNlpnp0TbOVpty+EnOUpzr5Ap72nUwT6rcxRn6ng5KU+QFhpa3aQ7+kwJfWHkgpU5
	/7miATXspviNiDMCd3emHNxQkLFuMjL9O3cPJOIPduLdpwaJzoS7oqi/TjEe9jpy1RdF/Q
	s5GKXvLcLSCe/XrgJKFte9yDXr1Om1SMeUlmZOTGKtmX+IAcVGePpGL0DdFZmZMHWsOuLK
	UE1rhaMC4SKwKs9m5tDsmZO2cA+CPnIwaOwc3JzjKsqTYRyatgN8TVp22TOvF8+PHLm5KN
	eAdy+4AQj8KtV5lsJUBE8jBTQ+uGaLL7kS579l7rVFvZOjbf6RBPOepnVh+bHA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:58 +0200
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-10-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Add a basic KASAN test runner that loads and test-run programs that can
trigger memory management bugs. The test captures kernel logs and ensure
that the expected KASAN splat is emitted by searching for the
corresponding first lines in the report, hence validated that the needed
instrumentation has been inserted by the JIT compiler before the
relevant memory accesses. To allow each test to trigger the expected
report, the kernel must run with the kasan_multi_shot configuration.

The runner covers different cases and settings: in the nominal case, it
validates kasan reports on basic instructions (on all supported accesses
sizes) but also when report _should not_ be emitted (eg: for accesses on
program stack). The runner also comes with a few specialized tests that
are then not executed for all sizes/locations:
- specific atomic ops
- test for instructions involving different verifier states, with some
  states flagging memory as stack, and other states as non-stack memory
- tests that validate the stack marking shifting when a patch is emitted
  by the verifier (zext/rnd_hi32, constant blindind)

A few of those tests depends on cpuv4 (load_acquire and store_release).

  # ./test_progs -a kasan
  #165/1   kasan/st_1_not_on_stack:OK
  #165/2   kasan/st_1_on_stack:OK
  #165/3   kasan/st_2_not_on_stack:OK
  #165/4   kasan/st_2_on_stack:OK
  #165/5   kasan/st_4_not_on_stack:OK
  #165/6   kasan/st_4_on_stack:OK
  #165/7   kasan/st_8_not_on_stack:OK
  #165/8   kasan/st_8_on_stack:OK
  #165/9   kasan/stx_1_not_on_stack:OK
  #165/10  kasan/stx_1_on_stack:OK
  #165/11  kasan/stx_2_not_on_stack:OK
  #165/12  kasan/stx_2_on_stack:OK
  #165/13  kasan/stx_4_not_on_stack:OK
  #165/14  kasan/stx_4_on_stack:OK
  #165/15  kasan/stx_8_not_on_stack:OK
  #165/16  kasan/stx_8_on_stack:OK
  #165/17  kasan/ldx_1_not_on_stack:OK
  #165/18  kasan/ldx_1_on_stack:OK
  #165/19  kasan/ldx_2_not_on_stack:OK
  #165/20  kasan/ldx_2_on_stack:OK
  #165/21  kasan/ldx_4_not_on_stack:OK
  #165/22  kasan/ldx_4_on_stack:OK
  #165/23  kasan/ldx_8_not_on_stack:OK
  #165/24  kasan/ldx_8_on_stack:OK
  #165/25  kasan/simple_atomic_4_not_on_stack:OK
  #165/26  kasan/simple_atomic_4_on_stack:OK
  #165/27  kasan/simple_atomic_8_not_on_stack:OK
  #165/28  kasan/simple_atomic_8_on_stack:OK
  #165/29  kasan/load_acquire_1_not_on_stack:SKIP
  #165/30  kasan/load_acquire_1_on_stack:SKIP
  #165/31  kasan/load_acquire_2_not_on_stack:SKIP
  #165/32  kasan/load_acquire_2_on_stack:SKIP
  #165/33  kasan/load_acquire_4_not_on_stack:SKIP
  #165/34  kasan/load_acquire_4_on_stack:SKIP
  #165/35  kasan/load_acquire_8_not_on_stack:SKIP
  #165/36  kasan/load_acquire_8_on_stack:SKIP
  #165/37  kasan/store_release_1_not_on_stack:SKIP
  #165/38  kasan/store_release_1_on_stack:SKIP
  #165/39  kasan/store_release_2_not_on_stack:SKIP
  #165/40  kasan/store_release_2_on_stack:SKIP
  #165/41  kasan/store_release_4_not_on_stack:SKIP
  #165/42  kasan/store_release_4_on_stack:SKIP
  #165/43  kasan/store_release_8_not_on_stack:SKIP
  #165/44  kasan/store_release_8_on_stack:SKIP
  #165/45  kasan/ldx_patched:OK
  #165/46  kasan/ldx_patched_on_stack:OK
  #165/47  kasan/verifier_paths_stack_and_non_stack:OK
  #165/48  kasan/st_blinded:OK
  #165     kasan:OK (SKIP: 16/48)
  Summary: 1/32 PASSED, 16 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- increase kernel log buffer size
- fix comment style
- check bpf_program__fd return code
- document kasan_multi_shot
- fix copy-paste mistakes on poisoning/unpoisoning sequences
- add test for patch due to constant blinding

Changes in v2:
- simplify tests by just manually poisoning test areas with a dedicated
  kfunc
- introduce one prog per covered instruction family
- make sure that tests do not consume kernel logs (use /dev/kmgs rather
  than klogctl)
- add tests for stack accesses:
  - marking correctly set when there are diverging verifier states
    leading to different memory types
  - marking kept in sync with prog when it is patched
---
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 437 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 394 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan_harden.c   |  41 ++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
 4 files changed, 894 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
new file mode 100644
index 000000000000..ff070c39eaac
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * Tests validating that KASAN reports are properly instrumented and
+ * generated on a wide variety of instructions. The running kernel needs
+ * kasan_multi_shot to run multiple kasan-generating subtests at once
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if_ether.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include <unpriv_helpers.h>
+#include "kasan.skel.h"
+#include "kasan_harden.skel.h"
+
+#define SUBTEST_NAME_MAX_LEN	128
+#define PROG_NAME_MAX_LEN	128
+
+#define MAX_LOG_SIZE		(8 * 1024)
+#define READ_CHUNK_SIZE		256
+
+#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free " \
+	"in bpf_prog_%02x%02x%02x%02x%02x%02x%02x%02x_%s"
+#define KASAN_PATTERN_REPORT "%s of size %d at addr"
+
+static char klog_buffer[MAX_LOG_SIZE];
+static char record[MAX_LOG_SIZE];
+
+struct test_spec {
+	char *prog_type;
+	bool is_write;
+	bool only_32_or_64;
+	bool needs_load_acq_store_rel;
+	bool skip_multi_size_testing;
+	bool skip_on_stack_testing;
+	int run_size;
+	bool expect_no_report;
+	bool rnd_hi32;
+};
+
+struct kasan_write_val {
+	__u8 data_1;
+	__u16 data_2;
+	__u32 data_4;
+	__u64 data_8;
+};
+
+struct test_ctx {
+	__u8  prog_tag[BPF_TAG_SIZE];
+	struct bpf_object *obj;
+	int *access_size;
+	bool skip_load_acq_store_rel;
+	struct bpf_program *prog;
+	char prog_name[SUBTEST_NAME_MAX_LEN];
+	int klog_fd;
+};
+
+static int open_kernel_logs(void)
+{
+	int fd;
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+
+	return fd;
+}
+
+static void skip_kernel_logs(int fd)
+{
+	lseek(fd, 0, SEEK_END);
+}
+
+static int read_kernel_logs(int fd, char *buf, size_t max_len)
+{
+	size_t total = 0;
+	ssize_t n;
+
+	buf[0] = '\0';
+	while (1) {
+		char *msg, *eol;
+		size_t len;
+
+		n = read(fd, record, sizeof(record) - 1);
+		if (n < 0) {
+			if (errno == EAGAIN)
+				break;
+			return n;
+		}
+		record[n] = '\0';
+
+		/*
+		 * Each kmsg record starts with some metadata, separated
+		 * from the actual content by a semi-colon
+		 */
+		msg = strchr(record, ';');
+		if (!msg)
+			continue;
+		msg++;
+		eol = strchr(msg, '\n');
+		if (eol)
+			*eol = '\0';
+
+		len = strlen(msg);
+		if (total + len + 2 > max_len)
+			break;
+		memcpy(buf + total, msg, len);
+		total += len;
+		buf[total++] = '\n';
+		buf[total] = '\0';
+	}
+
+	return total;
+}
+
+static int check_kasan_report_in_kernel_logs(char *buf, struct test_ctx *ctx,
+					     bool is_write, int size)
+{
+	char *access_desc_start, *access_desc_end, *tmp;
+	char access_log[READ_CHUNK_SIZE];
+	char *kasan_report_start;
+	int nsize;
+
+	snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_SLAB_UAF,
+		 ctx->prog_tag[0], ctx->prog_tag[1], ctx->prog_tag[2],
+		 ctx->prog_tag[3], ctx->prog_tag[4], ctx->prog_tag[5],
+		 ctx->prog_tag[6], ctx->prog_tag[7], ctx->prog_name);
+	/*
+	 * Searched kasan report is valid if
+	 * - it contains the expected kasan pattern
+	 * - the next line is the description of the faulty access
+	 * - faulty access properties match the tested type and size
+	 */
+	kasan_report_start = strstr(buf, access_log);
+
+	if (!kasan_report_start)
+		return 1;
+
+	/* Find next line */
+	access_desc_start = strchr(kasan_report_start, '\n');
+	if (!access_desc_start)
+		return 1;
+	access_desc_start++;
+
+	access_desc_end = strchr(access_desc_start, '\n');
+	if (!access_desc_end)
+		return 1;
+
+	nsize = snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_REPORT,
+			 is_write ? "Write" : "Read", size);
+
+	tmp = memmem(access_desc_start, access_desc_end - access_desc_start,
+		     access_log, nsize);
+
+	if (!tmp)
+		return 1;
+
+	return 0;
+}
+
+static void exec_subtest(struct test_ctx *ctx, struct test_spec *test,
+			 int access_size, bool on_stack)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_prog_info info;
+	uint8_t buf[ETH_HLEN];
+	int ret, prog_fd;
+	__u32 info_len;
+
+	ctx->prog = bpf_object__find_program_by_name(ctx->obj,
+						     ctx->prog_name);
+	if (!ASSERT_OK_PTR(ctx->prog, "find test prog"))
+		return;
+
+	info_len = sizeof(info);
+	memset(&info, 0, info_len);
+	prog_fd = bpf_program__fd(ctx->prog);
+	if (!ASSERT_OK_FD(prog_fd, "get prog fd"))
+		return;
+	ret = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(ret, "fetch loaded program info"))
+		return;
+	memcpy(ctx->prog_tag, info.tag, BPF_TAG_SIZE);
+
+	skip_kernel_logs(ctx->klog_fd);
+
+	topts.sz = sizeof(struct bpf_test_run_opts);
+	topts.data_size_in = ETH_HLEN;
+	topts.data_in = buf;
+	if (ctx->access_size)
+		*ctx->access_size = access_size;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(ctx->prog),
+				     &topts);
+	if (!ASSERT_OK(ret, "run prog"))
+		return;
+
+	ret = read_kernel_logs(ctx->klog_fd, klog_buffer, MAX_LOG_SIZE);
+	if (!ASSERT_GE(ret, 0, "read kernel logs"))
+		return;
+
+	ret = check_kasan_report_in_kernel_logs(klog_buffer, ctx,
+						test->is_write, access_size);
+	if (on_stack || test->expect_no_report)
+		ASSERT_NEQ(ret, 0, "no report should be generated");
+	else
+		ASSERT_OK(ret, "report should be generated");
+}
+
+static void run_subtest_with_size_and_location(struct test_ctx *ctx,
+					       struct test_spec *test,
+					       int access_size,
+					       bool on_stack)
+{
+	char subtest_name[SUBTEST_NAME_MAX_LEN];
+
+	if (test->skip_multi_size_testing) {
+		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s",
+			 test->prog_type);
+		strncpy(ctx->prog_name, test->prog_type, PROG_NAME_MAX_LEN);
+	} else {
+		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%d_%s",
+			 test->prog_type, access_size,
+			 on_stack ? "on_stack" : "not_on_stack");
+		snprintf(ctx->prog_name, PROG_NAME_MAX_LEN, "%s_%s",
+			 test->prog_type,
+			 on_stack ? "on_stack" : "not_on_stack");
+	}
+
+	if (!test__start_subtest(subtest_name))
+		return;
+
+	if (test->needs_load_acq_store_rel && ctx->skip_load_acq_store_rel) {
+		test__skip();
+		return;
+	}
+
+	exec_subtest(ctx, test, access_size, on_stack);
+}
+
+static void run_subtest_with_size(struct test_ctx *ctx, struct test_spec *test,
+				  int size)
+{
+	run_subtest_with_size_and_location(ctx, test, size, false);
+	if (!test->skip_on_stack_testing)
+		run_subtest_with_size_and_location(ctx, test, size, true);
+}
+
+static void run_subtest(struct test_ctx *ctx, struct test_spec *test)
+{
+	if (test->skip_multi_size_testing) {
+		run_subtest_with_size(ctx, test, test->run_size);
+		return;
+	}
+
+	if (!test->only_32_or_64) {
+		run_subtest_with_size(ctx, test, 1);
+		run_subtest_with_size(ctx, test, 2);
+	}
+	run_subtest_with_size(ctx, test, 4);
+	run_subtest_with_size(ctx, test, 8);
+}
+
+static void run_blinding_subtest(void)
+{
+	struct test_spec blinding_spec = {
+		.prog_type = "st_blinded",
+		.is_write = true,
+	};
+	char bpf_jit_harden = '2';
+	struct kasan_harden *skel;
+	struct test_ctx *ctx;
+
+	if (!test__start_subtest("st_blinded"))
+		return;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ASSERT_OK_PTR(ctx, "alloc blinding ctx"))
+		return;
+	ctx->klog_fd = -1;
+
+	if (set_bpf_jit_harden(&bpf_jit_harden))
+		goto free_ctx;
+
+	skel = kasan_harden__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load blinded prog"))
+		goto restore;
+
+	ctx->klog_fd = open_kernel_logs();
+	if (!ASSERT_OK_FD(ctx->klog_fd, "open kernel logs"))
+		goto destroy;
+
+	ctx->obj = skel->obj;
+	strncpy(ctx->prog_name, "st_blinded", PROG_NAME_MAX_LEN);
+
+	exec_subtest(ctx, &blinding_spec, 1, false);
+
+destroy:
+	close(ctx->klog_fd);
+	kasan_harden__destroy(skel);
+restore:
+	set_bpf_jit_harden(&bpf_jit_harden);
+free_ctx:
+	free(ctx);
+}
+
+static struct test_spec tests[] = {
+	{
+		.prog_type = "st",
+		.is_write = true
+	},
+	{
+		.prog_type = "stx",
+		.is_write = true
+	},
+	{
+		.prog_type = "ldx",
+		.is_write = false
+	},
+	{
+		.prog_type = "simple_atomic",
+		.is_write = false,
+		.only_32_or_64 = true
+	},
+	{
+		.prog_type = "load_acquire",
+		.is_write = false,
+		.needs_load_acq_store_rel = true
+	},
+	{
+		.prog_type = "store_release",
+		.is_write = true,
+		.needs_load_acq_store_rel = true
+	},
+	{
+		.prog_type = "ldx_patched",
+		.is_write = false,
+		.skip_multi_size_testing = true,
+		.skip_on_stack_testing = true,
+		.run_size = 4,
+		.rnd_hi32 = true
+	},
+	{
+		.prog_type = "ldx_patched_on_stack",
+		.is_write = false,
+		.skip_multi_size_testing = true,
+		.skip_on_stack_testing = true,
+		.run_size = 4,
+		.expect_no_report = true,
+		.rnd_hi32 = true
+	},
+	{
+		.prog_type = "verifier_paths_stack_and_non_stack",
+		.is_write = true,
+		.skip_multi_size_testing = true,
+		.skip_on_stack_testing = true,
+		.run_size = 1
+	}
+};
+
+void test_kasan(void)
+{
+	struct kasan_write_val val;
+	struct test_spec *test;
+	struct test_ctx *ctx;
+	struct kasan *skel;
+	__u32 key = 0;
+	int i, ret;
+
+	ctx = calloc(1, sizeof(struct test_ctx));
+	if (!ASSERT_OK_PTR(ctx, "alloc test ctx"))
+		return;
+
+	if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
+		test__skip();
+		goto end;
+	}
+
+	skel = kasan__open();
+	if (!ASSERT_OK_PTR(skel, "open prog"))
+		goto end;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_program *prog;
+
+		if (!tests[i].rnd_hi32)
+			continue;
+
+		prog = bpf_object__find_program_by_name(skel->obj,
+							tests[i].prog_type);
+		if (!ASSERT_OK_PTR(prog, "find rnd_hi32 prog"))
+			goto destroy;
+		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	}
+
+	if (!ASSERT_OK(kasan__load(skel), "load prog"))
+		goto destroy;
+
+	ctx->obj = skel->obj;
+	ctx->access_size = &skel->bss->access_size;
+	ctx->skip_load_acq_store_rel = skel->data->skip_load_acq_store_rel_tests;
+
+	ctx->klog_fd = open_kernel_logs();
+	if (!ASSERT_OK_FD(ctx->klog_fd, "open kernel logs"))
+		goto destroy;
+
+	/* Fill map with recognizable values */
+	ret = bpf_map__lookup_elem(skel->maps.test_map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(ret, "get map"))
+		goto close;
+	val.data_1 = 0xAA;
+	val.data_2 = 0xBBBB;
+	val.data_4 = 0xCCCCCCCC;
+	val.data_8 = 0xDDDDDDDDDDDDDDDD;
+	ret = bpf_map__update_elem(skel->maps.test_map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(ret, "set map"))
+		goto close;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		test = &tests[i];
+		run_subtest(ctx, test);
+	}
+
+	/*
+	 * Blinding subtest is handled differently as it needs the
+	 * corresponding program to be loaded with bpf_jit_harden raised
+	 */
+	run_blinding_subtest();
+
+close:
+	close(ctx->klog_fd);
+destroy:
+	kasan__destroy(skel);
+end:
+	free(ctx);
+}
diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
new file mode 100644
index 000000000000..82ddce3059ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kasan.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include <stdbool.h>
+
+extern void bpf_kfunc_kasan_poison(void *mem, __u32 mem__sz) __ksym;
+extern void bpf_kfunc_kasan_unpoison(void *mem, __u32 mem__sz) __ksym;
+
+int access_size;
+
+struct kasan_write_val {
+	__u8 data_1;
+	__u16 data_2;
+	__u32 data_4;
+	__u64 data_8;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct kasan_write_val);
+} test_map SEC(".maps");
+
+SEC("tcx/ingress")
+int st_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		val.data_1 = 0xAA;
+		break;
+	case 2:
+		val.data_2 = 0xAA;
+		break;
+	case 4:
+		val.data_4 = 0xAA;
+		break;
+	case 8:
+		val.data_8 = 0xAA;
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int st_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		val->data_1 = 0xAA;
+		break;
+	case 2:
+		val->data_2 = 0xAA;
+		break;
+	case 4:
+		val->data_4 = 0xAA;
+		break;
+	case 8:
+		val->data_8 = 0xAA;
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int stx_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		val.data_1 = access_size;
+		break;
+	case 2:
+		val.data_2 = access_size;
+		break;
+	case 4:
+		val.data_4 = access_size;
+		break;
+	case 8:
+		val.data_8 = access_size;
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int stx_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		val->data_1 = access_size;
+		break;
+	case 2:
+		val->data_2 = access_size;
+		break;
+	case 4:
+		val->data_4 = access_size;
+		break;
+	case 8:
+		val->data_8 = access_size;
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int ldx_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__sink(val.data_1);
+		break;
+	case 2:
+		__sink(val.data_2);
+		break;
+	case 4:
+		__sink(val.data_4);
+		break;
+	case 8:
+		__sink(val.data_8);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int ldx_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__sink(val->data_1);
+		break;
+	case 2:
+		__sink(val->data_2);
+		break;
+	case 4:
+		__sink(val->data_4);
+		break;
+	case 8:
+		__sink(val->data_8);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int ldx_patched(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	__sink(val->data_4);
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+
+	return 0;
+}
+
+SEC("tcx/ingress")
+int ldx_patched_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	__sink(val.data_4);
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+
+	return 0;
+}
+
+SEC("tcx/ingress")
+int simple_atomic_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 4:
+		__sync_fetch_and_add(&val.data_4, 4);
+		break;
+	case 8:
+		__sync_fetch_and_add(&val.data_8, 8);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int simple_atomic_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 4:
+		__sync_fetch_and_add(&val->data_4, 4);
+		break;
+	case 8:
+		__sync_fetch_and_add(&val->data_8, 8);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+bool skip_load_acq_store_rel_tests SEC(".data") = 0;
+
+SEC("tcx/ingress")
+int load_acquire_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__atomic_load_n(&val.data_1, __ATOMIC_ACQUIRE);
+		break;
+	case 2:
+		__atomic_load_n(&val.data_2, __ATOMIC_ACQUIRE);
+		break;
+	case 4:
+		__atomic_load_n(&val.data_4, __ATOMIC_ACQUIRE);
+		break;
+	case 8:
+		__atomic_load_n(&val.data_8, __ATOMIC_ACQUIRE);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int load_acquire_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__atomic_load_n(&val->data_1, __ATOMIC_ACQUIRE);
+		break;
+	case 2:
+		__atomic_load_n(&val->data_2, __ATOMIC_ACQUIRE);
+		break;
+	case 4:
+		__atomic_load_n(&val->data_4, __ATOMIC_ACQUIRE);
+		break;
+	case 8:
+		__atomic_load_n(&val->data_8, __ATOMIC_ACQUIRE);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int store_release_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val val;
+
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__atomic_store_n(&val.data_1, 0xAA, __ATOMIC_RELEASE);
+		break;
+	case 2:
+		__atomic_store_n(&val.data_2, 0xBBBB, __ATOMIC_RELEASE);
+		break;
+	case 4:
+		__atomic_store_n(&val.data_4, 0xCCCCCCCC, __ATOMIC_RELEASE);
+		break;
+	case 8:
+		__atomic_store_n(&val.data_8, 0xDDDDDDDDDDDDDDDD,
+				 __ATOMIC_RELEASE);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
+	return 0;
+}
+
+SEC("tcx/ingress")
+int store_release_not_on_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	switch (access_size) {
+	case 1:
+		__atomic_store_n(&val->data_1, 0xAA, __ATOMIC_RELEASE);
+		break;
+	case 2:
+		__atomic_store_n(&val->data_2, 0xBBBB, __ATOMIC_RELEASE);
+		break;
+	case 4:
+		__atomic_store_n(&val->data_4, 0xCCCCCCCC, __ATOMIC_RELEASE);
+		break;
+	case 8:
+		__atomic_store_n(&val->data_8, 0xDDDDDDDDDDDDDDDD,
+				 __ATOMIC_RELEASE);
+		break;
+	}
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+	return 0;
+}
+#else
+bool skip_load_acq_store_rel_tests SEC(".data") = 1;
+#endif
+
+SEC("tcx/ingress")
+int verifier_paths_stack_and_non_stack(struct __sk_buff *skb)
+{
+	struct kasan_write_val stack_val = {};
+	struct kasan_write_val *val;
+	void *ptr;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	if (access_size)
+		ptr = val;
+	else
+		ptr = &stack_val;
+
+	bpf_kfunc_kasan_poison(val, sizeof(*val));
+	*(__u8 *)ptr = 0xAA;
+	bpf_kfunc_kasan_unpoison(val, sizeof(*val));
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/kasan_harden.c b/tools/testing/selftests/bpf/progs/kasan_harden.c
new file mode 100644
index 000000000000..808d7da64421
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kasan_harden.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern void bpf_kfunc_kasan_poison(void *mem, __u32 mem__sz) __ksym;
+extern void bpf_kfunc_kasan_unpoison(void *mem, __u32 mem__sz) __ksym;
+
+struct kasan_write_val {
+	__u8 data_1;
+	__u16 data_2;
+	__u32 data_4;
+	__u64 data_8;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct kasan_write_val);
+} test_map SEC(".maps");
+
+SEC("tcx/ingress")
+int st_blinded(struct __sk_buff *skb)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
+	val->data_1 = 0xAA;
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..09a502a1742f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -271,6 +271,26 @@ __bpf_kfunc void bpf_kfunc_put_default_trusted_ptr_test(struct prog_test_member
 	 */
 }
 
+#ifdef CONFIG_KASAN_GENERIC
+
+extern void kasan_poison(const void *addr, size_t size, u8 value, bool init);
+
+#define KASAN_SLAB_FREE 0xFB
+
+__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz)
+{
+	kasan_poison(mem, mem__sz, KASAN_SLAB_FREE, false);
+}
+
+__bpf_kfunc void bpf_kfunc_kasan_unpoison(void *mem, u32 mem__sz)
+{
+	kasan_poison(mem, mem__sz, 0x00, false);
+}
+#else
+__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz) { }
+__bpf_kfunc void bpf_kfunc_kasan_unpoison(void *mem, u32 mem__sz) { }
+#endif
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -740,6 +760,8 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_unpoison)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)

-- 
2.54.0

