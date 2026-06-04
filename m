Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9B4D8D98;
	Thu,  4 Jun 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604578; cv=none; b=tddzjXu7n0QgDvJYVG342VcA87miinYPIgdGUIltix7Gn/nNlqzgMxGZVF7hU6LO+nJ3nnfO3aAvsXVUz/RRE5XsFCWkxqw2YCVxdYasotHswI7xTBWnKfIPOCdG0GvJg6pqZiXi0DUaFW5MDc+fN6hytpxl3dqlJIkD830nBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604578; c=relaxed/simple;
	bh=Qjn4mik60Scxo8rRNRsuC8KlIr2HBzSjiYJ0R/jj42M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zt+xT6xVU0ixQr6PT9Ueb5Z7MrAztaxbxSv50xqAPBTqwRhPJqLFL3ffMSA19EZ9fjYxNa+5DUatTbtPowtAAfaq0XXVLPnyIILtyVa48HmJBvzNkKEg7mqXjqBrmlyihNWzIwwkErfRoFMSWt1wyhQBzhSwzqkotZ69e3EcL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J4UzzkKR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J4UzzkKR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 82D274E40755;
	Thu,  4 Jun 2026 20:22:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5551B5FED1;
	Thu,  4 Jun 2026 20:22:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62FE5106A1D45;
	Thu,  4 Jun 2026 22:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n2IVgNtqwqyOrL8sV0OndjLx3yPkOiO2dKXdQe2n4xU=;
	b=J4UzzkKRUkUGMie49EH2BlP5rmV6WvWqof5s7jF1pAdPFwL87N9Wj+otR7ZEcc547bq6Me
	G3MQbzD+uOOQVcLKJfwZjiu79IdsFrUG75ju+/tZ6Wahe0ZXso04syHEJFdNMg54mK03vs
	HJz9vhBQHqD6IXv1yz9UkZhXP5kOR2C923q7W41AJe3ga/KLbMV/qNlTN7h8r/uXVoOsPH
	UiuVFbaMmQMC/QyNwREw7K8R+YMPRnX/qnKzxBV02odOLfTF9dCI1AYVnJk0ODsMBpnjxp
	o10QsAXexn3Zg9CnbupiecQlSirIuYJc2hYbk7XnIWXkOaZ3zfbLyKFjROPY5A==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 04 Jun 2026 22:22:06 +0200
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate KASAN
 on JIT programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
In-Reply-To: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Add a basic KASAN test runner that loads and test-run programs that can
trigger memory management bugs. The test captures kernel logs and ensure
that the expected KASAN splat is emitted by searching for the
corresponding first lines in the report, hence validated that the needed
instrumentation has been inserted by the JIT compiler before the
relevant memory accesses.

The runner covers different cases and settings: in the nominal case, it
validates kasan reports on basic instructions (on all supported accesses
sizes) but also when report _should not_ be emitted (eg: for accesses on
program stack). The runner also comes with a few specialized tests that
are then not executed for all sizes/locations. A few of those tests
depends on cpuv4 (load_acquire and store_release).

  # ./test_progs -a kasan
  #164/1   kasan/st_1_not_on_stack:OK
  #164/2   kasan/st_1_on_stack:OK
  #164/3   kasan/st_2_not_on_stack:OK
  #164/4   kasan/st_2_on_stack:OK
  #164/5   kasan/st_4_not_on_stack:OK
  #164/6   kasan/st_4_on_stack:OK
  #164/7   kasan/st_8_not_on_stack:OK
  #164/8   kasan/st_8_on_stack:OK
  #164/9   kasan/stx_1_not_on_stack:OK
  #164/10  kasan/stx_1_on_stack:OK
  #164/11  kasan/stx_2_not_on_stack:OK
  #164/12  kasan/stx_2_on_stack:OK
  #164/13  kasan/stx_4_not_on_stack:OK
  #164/14  kasan/stx_4_on_stack:OK
  #164/15  kasan/stx_8_not_on_stack:OK
  #164/16  kasan/stx_8_on_stack:OK
  #164/17  kasan/ldx_1_not_on_stack:OK
  #164/18  kasan/ldx_1_on_stack:OK
  #164/19  kasan/ldx_2_not_on_stack:OK
  #164/20  kasan/ldx_2_on_stack:OK
  #164/21  kasan/ldx_4_not_on_stack:OK
  #164/22  kasan/ldx_4_on_stack:OK
  #164/23  kasan/ldx_8_not_on_stack:OK
  #164/24  kasan/ldx_8_on_stack:OK
  #164/25  kasan/simple_atomic_4_not_on_stack:OK
  #164/26  kasan/simple_atomic_4_on_stack:OK
  #164/27  kasan/simple_atomic_8_not_on_stack:OK
  #164/28  kasan/simple_atomic_8_on_stack:OK
  #164/29  kasan/load_acquire_1_not_on_stack:SKIP
  #164/30  kasan/load_acquire_1_on_stack:SKIP
  #164/31  kasan/load_acquire_2_not_on_stack:SKIP
  #164/32  kasan/load_acquire_2_on_stack:SKIP
  #164/33  kasan/load_acquire_4_not_on_stack:SKIP
  #164/34  kasan/load_acquire_4_on_stack:SKIP
  #164/35  kasan/load_acquire_8_not_on_stack:SKIP
  #164/36  kasan/load_acquire_8_on_stack:SKIP
  #164/37  kasan/store_release_1_not_on_stack:SKIP
  #164/38  kasan/store_release_1_on_stack:SKIP
  #164/39  kasan/store_release_2_not_on_stack:SKIP
  #164/40  kasan/store_release_2_on_stack:SKIP
  #164/41  kasan/store_release_4_not_on_stack:SKIP
  #164/42  kasan/store_release_4_on_stack:SKIP
  #164/43  kasan/store_release_8_not_on_stack:SKIP
  #164/44  kasan/store_release_8_on_stack:SKIP
  #164/45  kasan/ldx_patched:OK
  #164/46  kasan/stack_and_non_stack:OK
  #164     kasan:OK (SKIP: 16/46)
  Summary: 1/30 PASSED, 16 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
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
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 356 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 382 +++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
 3 files changed, 760 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
new file mode 100644
index 000000000000..adf61e230ec9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if_ether.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include <unpriv_helpers.h>
+#include "kasan.skel.h"
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
+	struct kasan *skel;
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
+	char record[512];
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
+		/* Each kmsg record starts with some metadata, separated
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
+	/* Searched kasan report is valid if
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
+		 is_write ? "Write" : "Read", size);
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
+static void run_subtest_with_size_and_location(struct test_ctx *ctx,
+					       struct test_spec *test,
+					       int access_size,
+					       bool on_stack)
+{
+	char subtest_name[SUBTEST_NAME_MAX_LEN];
+	char prog_name[PROG_NAME_MAX_LEN];
+	struct bpf_prog_info info;
+	uint8_t buf[ETH_HLEN];
+	__u32 info_len;
+	int ret;
+
+	if (test->skip_multi_size_testing) {
+		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s",
+			 test->prog_type);
+		strncpy(prog_name, test->prog_type, PROG_NAME_MAX_LEN);
+	} else {
+		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%d_%s",
+			 test->prog_type, access_size,
+			 on_stack ? "on_stack" : "not_on_stack");
+		snprintf(prog_name, PROG_NAME_MAX_LEN, "%s_%s", test->prog_type,
+				on_stack ? "on_stack" : "not_on_stack");
+	}
+
+	if (!test__start_subtest(subtest_name))
+		return;
+
+	if (test->needs_load_acq_store_rel &&
+	    ctx->skel->data->skip_load_acq_store_rel_tests) {
+		test__skip();
+		return;
+	}
+
+	ctx->prog = bpf_object__find_program_by_name(ctx->skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(ctx->prog, "find test prog"))
+		return;
+
+	info_len = sizeof(info);
+	memset(&info, 0, info_len);
+	ret = bpf_prog_get_info_by_fd(bpf_program__fd(ctx->prog), &info,
+				      &info_len);
+	if (!ASSERT_OK(ret, "fetch loaded program info"))
+		return;
+	memcpy(ctx->prog_tag, info.tag, BPF_TAG_SIZE);
+
+	skip_kernel_logs(ctx->klog_fd);
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	topts.sz = sizeof(struct bpf_test_run_opts);
+	topts.data_size_in = ETH_HLEN;
+	topts.data_in = buf;
+	ctx->skel->bss->access_size = access_size;
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
+		/* Make the verifier patch instruction to test
+		 * adjust_insn_aux_data logic
+		 */
+		.rnd_hi32 = true
+	},
+	{
+		.prog_type = "stack_and_non_stack",
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
+	ctx->skel = kasan__open();
+	if (!ASSERT_OK_PTR(ctx->skel, "open prog"))
+		goto end;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_program *prog;
+
+		if (!tests[i].rnd_hi32)
+			continue;
+
+		prog = bpf_object__find_program_by_name(ctx->skel->obj,
+							tests[i].prog_type);
+		if (!ASSERT_OK_PTR(prog, "find rnd_hi32 prog"))
+			goto destroy;
+		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	}
+
+	if (!ASSERT_OK(kasan__load(ctx->skel), "load prog"))
+		goto destroy;
+
+	ctx->klog_fd = open_kernel_logs();
+	if (!ASSERT_OK_FD(ctx->klog_fd, "open kernel logs"))
+		goto destroy;
+
+	/* Fill map with recognizable values */
+	ret = bpf_map__lookup_elem(ctx->skel->maps.test_map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(ret, "get map"))
+		goto close;
+	val.data_1 = 0xAA;
+	val.data_2 = 0xBBBB;
+	val.data_4 = 0xCCCCCCCC;
+	val.data_8 = 0xDDDDDDDDDDDDDDDD;
+	ret = bpf_map__update_elem(ctx->skel->maps.test_map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(ret, "set map"))
+		goto close;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		test = &tests[i];
+		run_subtest(ctx, test);
+	}
+
+close:
+	close(ctx->klog_fd);
+destroy:
+	kasan__destroy(ctx->skel);
+end:
+	free(ctx);
+}
diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
new file mode 100644
index 000000000000..670318a956a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kasan.c
@@ -0,0 +1,382 @@
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
+	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
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
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
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
+bool skip_load_acq_store_rel_tests __attribute__((section(".data"))) = 0;
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
+bool skip_load_acq_store_rel_tests __attribute__((section(".data"))) = 1;
+#endif
+
+SEC("tcx/ingress")
+int stack_and_non_stack(struct __sk_buff *skb)
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

