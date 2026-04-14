Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E583E63A2
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173156; cv=none; b=Nvk80AEehT5ZZ4i7V91wtorJOePjNoX4u2GLFfVOGWUrEnMatb6vcq6CEC29Xil2Eu7M2Qy48jX1ZmRji9+CSPQ5q2pgpQL4B3nWbffek8CfEfKOTVncOe2JIoDOXz9tgt+jpJkcr2uCc921BCquQExRrQm5otWY/j7cnJ4kM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173156; c=relaxed/simple;
	bh=5ucUrOTfWivXiLkV+Q5pttaD4tCf4EbNldmT43mFBZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKoTxcL25gufi3b9UUTFuzMXDB5fPOYKd16aliTRRtH/Snzna7ihP0WsUO04JFf7u6aOx3xd0HKJ87bQv2pdZiSBEURZHKfrBkj5y/fnnmFAr4h3/aehdYW7kRNc3vFN1CJ7muxWIfXxvoVr9ncd/H8hYZRmh2A2Ql96s0slr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZQ4UV+q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZQ4UV+q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/egaEN0bp0OpORBjJPsgkOX323nMQDPPE59VgGtP6s=;
	b=IZQ4UV+qEXVHoVLqZQ3gBl9Uw/TN6xACLwVX/1ZhbIHNGy+DEFXk32OU/fCGkqmh/paX5J
	mPMJCtlT66tjIJ5yhhASaJ/VhNKqpehfuPs/AcHM3ti0zolSSCQt6p56yaxA7JpTcklAsf
	YLaC1y6nEpO4frPX5GFbRfrofgzDT1g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Add tests to verify global percpu data
Date: Tue, 14 Apr 2026 21:24:19 +0800
Message-ID: <20260414132421.63409-8-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the arch, like s390x, does not support percpu insn, these cases won't
test global percpu data by checking -EOPNOTSUPP after loading prog.

The following APIs have been tested for global percpu data:

1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. generated percpu struct pointer pointing to internal map's mmaped data
4. bpf_map__lookup_elem() for global percpu data map

At the same time, the case is also tested with 'bpftool gen skeleton -L'.

The verifier log is also tested.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 223 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       |  66 ++++++
 3 files changed, 290 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..39ae3583983b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -504,7 +504,7 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c
 SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406..0b0384b6515e 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "test_global_percpu_data.skel.h"
+#include "test_global_percpu_data.lskel.h"
 
 void test_global_data_init(void)
 {
@@ -60,3 +63,223 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+static void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__percpu *percpu_data = NULL;
+	struct test_global_percpu_data__percpu *init_data, *data;
+	struct test_global_percpu_data__percpu init_value = {};
+	int key, prog_fd, err, num_cpus, num_online, i;
+	struct test_global_percpu_data *skel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	size_t elem_sz, init_data_sz;
+	struct bpf_map *map;
+	bool *online;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online",
+				  &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	elem_sz = roundup(sizeof(*percpu_data), 8);
+	percpu_data = calloc(num_cpus, elem_sz);
+	if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
+		goto out;
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu, "skel->percpu"))
+		goto out;
+
+	ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
+	ASSERT_FALSE(skel->percpu->run, "skel->percpu->run");
+	ASSERT_EQ(skel->percpu->nums[6], 0, "skel->percpu->nums[6]");
+	ASSERT_EQ(skel->percpu->struct_data.i, -1, "struct_data.i");
+	ASSERT_FALSE(skel->percpu->struct_data.set, "struct_data.set");
+	ASSERT_EQ(skel->percpu->struct_data.nums[6], 0, "struct_data.nums[6]");
+
+	map = skel->maps.percpu;
+	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
+		goto out;
+
+	init_value.data = 2;
+	init_value.nums[6] = -1;
+	init_value.struct_data.i = 2;
+	init_value.struct_data.nums[6] = -1;
+	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
+	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
+		goto out;
+
+	init_data = bpf_map__initial_value(map, &init_data_sz);
+	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
+		goto out;
+
+	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
+	ASSERT_EQ(init_data->run, init_value.run, "init_value run");
+	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i,
+		  "init_value struct_data.i");
+	ASSERT_EQ(init_data->struct_data.nums[6],
+		  init_value.struct_data.nums[6],
+		  "init_value struct_data.nums[6]");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
+	ASSERT_EQ((void *) init_data, (void *) skel->percpu,
+		  "skel->percpu eq init_data");
+	ASSERT_EQ(skel->percpu->data, init_value.data,
+		  "skel->percpu->data");
+	ASSERT_EQ(skel->percpu->run, init_value.run,
+		  "skel->percpu->run");
+	ASSERT_EQ(skel->percpu->struct_data.i, init_value.struct_data.i,
+		  "skel->percpu->struct_data.i");
+	ASSERT_EQ(skel->percpu->struct_data.nums[6],
+		  init_value.struct_data.nums[6],
+		  "skel->percpu->struct_data.nums[6]");
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_OK_PTR(skel->percpu, "skel->percpu");
+
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+	}
+
+	key = 0;
+	err = bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
+				   elem_sz * num_cpus, 0);
+	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+		goto out;
+
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		data = (void *)percpu_data + elem_sz * i;
+		ASSERT_EQ(data->data, 1, "percpu_data->data");
+		ASSERT_TRUE(data->run, "percpu_data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "percpu_data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data__destroy(skel);
+	free(percpu_data);
+	free(online);
+}
+
+static void test_global_percpu_data_lskel(void)
+{
+	struct test_global_percpu_data__percpu *data, *percpu_data = NULL;
+	int key, prog_fd, map_fd, err, num_cpus, num_online, i;
+	struct test_global_percpu_data_lskel *lskel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	size_t elem_sz;
+	bool *online;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online",
+				  &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	elem_sz = roundup(sizeof(*percpu_data), 8);
+	percpu_data = calloc(num_cpus, elem_sz);
+	if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
+		goto out;
+
+	lskel = test_global_percpu_data_lskel__open();
+	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open"))
+		goto out;
+
+	err = test_global_percpu_data_lskel__load(lskel);
+	if (!ASSERT_OK(err, "test_global_percpu_data_lskel__load"))
+		goto out;
+
+	prog_fd = lskel->progs.update_percpu_data.prog_fd;
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+	}
+
+	key = 0;
+	map_fd = lskel->maps.percpu.map_fd;
+	err = bpf_map_lookup_elem(map_fd, &key, percpu_data);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		data = (void *)percpu_data + elem_sz * i;
+		ASSERT_EQ(data->data, 1, "percpu_data->data");
+		ASSERT_TRUE(data->run, "percpu_data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "percpu_data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data_lskel__destroy(lskel);
+	free(percpu_data);
+	free(online);
+}
+
+static void test_global_percpu_data_verifier_failure(void)
+{
+	RUN_TESTS(test_global_percpu_data);
+}
+
+void test_global_percpu_data(void)
+{
+	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("init"))
+		test_global_percpu_data_init();
+	if (test__start_subtest("lskel"))
+		test_global_percpu_data_lskel();
+	if (test__start_subtest("verifier_failure"))
+		test_global_percpu_data_verifier_failure();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 000000000000..947721c21f30
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int data SEC(".percpu") = -1;
+int nums[7] SEC(".percpu");
+char run SEC(".percpu") = 0;
+struct {
+	char set;
+	int i;
+	int nums[7];
+} struct_data SEC(".percpu") = {
+	.set = 0,
+	.i = -1,
+};
+
+SEC("raw_tp/task_rename")
+__auxiliary
+int update_percpu_data(void *ctx)
+{
+	struct_data.nums[6] = 0xc0de;
+	struct_data.set = 1;
+	struct_data.i = 1;
+	nums[6] = 0xc0de;
+	data = 1;
+	run = 1;
+	return 0;
+}
+
+static const char fmt[] SEC(".percpu.fmt") = "data %d\n";
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be used as const string")
+int verifier_strncmp(void *ctx)
+{
+	return bpf_strncmp("test", 5, fmt);
+}
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be used as const string")
+int verifier_snprintf(void *ctx)
+{
+	u64 args[] = { data };
+	char buf[128];
+	int len;
+
+	len = bpf_snprintf(buf, sizeof(buf), fmt, args, 1);
+	if (len > 0)
+		bpf_printk("snprintf: %s\n", buf);
+	return 0;
+}
+
+static volatile const char fmt2[] SEC(".percpu.fmt") = "data %d\n";
+
+SEC("?kprobe")
+__success
+__xlated("r{{[0-9]+}} = &(void __percpu *)(r{{[0-9]+}})")
+int verifier_percpu_read(void *ctx)
+{
+	char c = fmt2[0];
+
+	return c == 'd';
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

