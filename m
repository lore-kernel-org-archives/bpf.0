Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF34478E5A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634693; cv=none; b=ZeGCHALfPVfBwEeg7xiy/G4Uf5GzqukEsBCZejcu1o6QhYHm0zMpnzBbXyCDZqVe+C430GuucAwgwm1IJqEPHMy+NbowWVv3lw5Z5krF3gQXQdqiyEwZSzJSCipu9iWHuWhIdaM3WJegJx4K16r1ShHOybXMbZA4QK5T1pqUwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634693; c=relaxed/simple;
	bh=RBxBBkj1k7nfJOBGOm3B3B7ITIfark1MfJS6GJ2p0cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNJQRw59HNQ37Xxyc+iVaS1Mq746ng9fElW6lkexb3mezMiem2SON0PlRHmLN+VQ85yGAWNcVNHJd2+l7hYC2lAk8EhAb3GkqpdAk2yLFly0VZSUgJf9hqo+lpvfMjZhqzJJOAT59rfcTq98tVrBZuCXdhjjmcOpwETJ/htGNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eUgCa6OK; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eUgCa6OK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RBxBBkj1k7nfJOBGOm3B3B7ITIfark1MfJS6GJ2p0cw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786634688; v=1; x=1787239488;
 b=eUgCa6OKch9mChKDnFaJNc4wk5G1Qedkra7/ZNsD1Hg4ixaeuV7QIoqBT+xjn41v9NNvLOli
 u/DR8mOV1rOpSedHJIkfJkIYeeuNFqpK25j+r2pTeLNJD7kWafrNh0Yxz22TAEe3WjIfDkVfiMR
 BMC6PknD3dgL8zreX2KjIvz4=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id 774565b0785bbd38;
	Thu, 13 Aug 2026 15:24:48 +0000
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify global percpu data
Date: Thu, 13 Aug 2026 23:23:20 +0800
Message-ID: <20260813152324.97937-8-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813152324.97937-1-leon.hwang@linux.dev>
References: <20260813152324.97937-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the arch, like s390x, does not support percpu insn, these cases won't
test global percpu data by checking FEAT_PERCPU_DATA support.

The following APIs have been tested for global percpu data:

1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. bpf_map__set_value_size()
4. generated percpu struct pointer pointing to internal map's mmaped data
5. bpf_map__lookup_elem() for global percpu data map
6. bpf_map_lookup_elem_flags() for global percpu data map

At the same time, the case is also tested with 'bpftool gen skeleton -L'.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 188 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       |  41 ++++
 3 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d3655a706482..560ce4016fbf 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -531,7 +531,7 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c
 SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406..06d163a022dc 100644
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
@@ -60,3 +63,188 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_fd, int *runp)
+{
+	struct test_global_percpu_data__percpu *data = NULL;
+	int i, err, key = 0, num_online, run = 0;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	size_t data_sz;
+	bool *online;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	data_sz = map ? bpf_map__value_size(map) : sizeof(*data);
+	data = calloc(1, data_sz);
+	if (!ASSERT_OK_PTR(data, "calloc percpu data"))
+		goto out;
+
+	/* run on every online-CPU */
+	for (i = 0; i < num_online; i++) {
+		__u64 flags;
+
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = -1;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+
+		memset(data, 0, data_sz);
+		flags = ((__u64) i << 32) | BPF_F_CPU;
+		if (map)
+			err = bpf_map__lookup_elem(map, &key, sizeof(key), data, data_sz, flags);
+		else
+			err = bpf_map_lookup_elem_flags(map_fd, &key, data, flags);
+		if (!ASSERT_OK(err, "lookup_elem on cpu"))
+			break;
+
+		ASSERT_EQ(*runp, ++run, "run");
+		ASSERT_EQ(data->cpu_id[0], i, "cpu_id");
+		ASSERT_EQ(data->data, 1, "data");
+		ASSERT_TRUE(data->set, "set");
+		ASSERT_EQ(data->nums[6], 0xc0de, "nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	free(data);
+	free(online);
+}
+
+static void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__percpu init_value = {};
+	struct test_global_percpu_data__percpu *init_data;
+	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
+	struct test_global_percpu_data *skel = NULL;
+	size_t init_data_sz;
+	struct bpf_map *map;
+	int prog_fd, err;
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu, "skel->percpu"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->data_percpu, "skel->data_percpu"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu_data, "skel->percpu_data"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu_looooooooong, "skel->percpu_looooooooong"))
+		goto out;
+
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_data), ".percpu.data",
+		     ".percpu.data map name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.data_percpu), ".data.percpu",
+		     ".data.percpu map name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_looooooooong), ".percpu.looooooooong",
+		     "long map name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu), ".percpu", "map name");
+	ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
+	ASSERT_FALSE(skel->percpu->set, "skel->percpu->set");
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
+	ASSERT_EQ(init_data->set, init_value.set, "init_value set");
+	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_value struct_data.i");
+	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6],
+		  "init_value struct_data.nums[6]");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
+	ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu eq init_data");
+	ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->data");
+	ASSERT_EQ(skel->percpu->set, init_value.set, "skel->percpu->set");
+	ASSERT_EQ(skel->percpu->struct_data.i, init_value.struct_data.i,
+		  "skel->percpu->struct_data.i");
+	ASSERT_EQ(skel->percpu->struct_data.nums[6], init_value.struct_data.nums[6],
+		  "skel->percpu->struct_data.nums[6]");
+
+	ASSERT_GT(desired_sz, sizeof(init_value), "desired_sz");
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+		goto out;
+	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "percpu value size"))
+		goto out;
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "percpu BTF value type"))
+		goto out;
+
+	init_data = bpf_map__initial_value(map, &init_data_sz);
+	if (!ASSERT_OK_PTR(init_data, "resized bpf_map__initial_value"))
+		goto out;
+	if (!ASSERT_EQ(init_data_sz, desired_sz, "resized initial value size"))
+		goto out;
+	if (!ASSERT_EQ(init_data->data, init_value.data, "resized initial value data"))
+		goto out;
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_OK_PTR(skel->percpu, "skel->percpu");
+
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+	test_percpu_data_on_cpus(map, bpf_map__fd(map), prog_fd, &skel->bss->run);
+
+out:
+	test_global_percpu_data__destroy(skel);
+}
+
+static void test_global_percpu_data_lskel(void)
+{
+	struct test_global_percpu_data_lskel *lskel = NULL;
+	int prog_fd, map_fd;
+
+	lskel = test_global_percpu_data_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load"))
+		goto out;
+
+	map_fd = lskel->maps.percpu.map_fd;
+	prog_fd = lskel->progs.update_percpu_data.prog_fd;
+	test_percpu_data_on_cpus(NULL, map_fd, prog_fd, &lskel->bss->run);
+
+out:
+	test_global_percpu_data_lskel__destroy(lskel);
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
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 000000000000..416841cd3569
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Used for testing map name. */
+int loong SEC(".percpu.looooooooong");
+int data3 SEC(".data.percpu");
+int data2 SEC(".percpu.data");
+
+int run;
+/* cpu_id as array to verify map value resizing. */
+int cpu_id[1] SEC(".percpu");
+int data SEC(".percpu") = -1;
+int nums[7] SEC(".percpu");
+bool set SEC(".percpu") = false;
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
+	run++;
+	set = true;
+	cpu_id[0] = bpf_get_smp_processor_id();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

