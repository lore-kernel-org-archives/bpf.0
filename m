Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFC40B37A
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957282; cv=none; b=J628CY6doTG5BK2tiUrdFIkrt8sDehHuLLAl+6tHPGqYTN/+4+L/nUVsLCnz4ksvuCzM7VSor+XVuZ/IfQEBiwyOYCjjya2qek826mZkZsmI2uPT6n/tu0SUTimMvCS4fH8G1u/m49ELlGE6reYHEyfq8Yl9VB7opkOW8RW7Tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957282; c=relaxed/simple;
	bh=b8mjJQjtEdXauz5qdwDZA6bsb0cJ3U+M6ZaVJpxFwfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjAnWAf+kTn+yd5fLZrcl6dG2/IF/xWSbPmPZwHQhDXI8okYZTeInGZ/K1KEQlinJvYfpLsycP4xDxAw8Fls3+MsSWaiTp+8pYueMChGg/ENMQiu2nscebqhnspxJqxuN4vrFduKt8mb14Cx8vhghMZovjA/FeDkp2NqYC74HBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gR5Ulp6H; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gR5Ulp6H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783957278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuBsOItjU5UNLGE/nAfxiyn6o+P+qbBxavh6rq9zykM=;
	b=gR5Ulp6Hsm/EGLK6AAwHK7JWWSUonsF/+8uuVwEFULg0f4edZajzuuCRS312YRt9Kp5eU4
	3d29apTUhvUo/jd27y/ku7RIj1sRgkkPjuXhzXwyofTGdtCVbDLBG/DO8kO71og5M6kIHX
	g4CCdbfJAqHDq1ZVenQdxxBFpLQHE6s=
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
Subject: [PATCH bpf-next v9 6/9] selftests/bpf: Add tests to verify global percpu data
Date: Mon, 13 Jul 2026 23:40:21 +0800
Message-ID: <20260713154024.30851-7-leon.hwang@linux.dev>
In-Reply-To: <20260713154024.30851-1-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the arch, like s390x, does not support percpu insn, these cases won't
test global percpu data by checking FEAT_PERCPU_DATA support.

The following APIs have been tested for global percpu data:

1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. generated percpu struct pointer pointing to internal map's mmaped data
4. bpf_map__lookup_elem() for global percpu data map

At the same time, the case is also tested with 'bpftool gen skeleton -L'.

Add a test to verify that the live vars of subskel won't include the vars
for global percpu data.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 151 ++++++++++++++++++
 .../bpf/prog_tests/global_percpu_subskel.c    |  37 +++++
 .../bpf/progs/test_global_percpu_data.c       |  33 ++++
 4 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..c37ed9e7b97c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -533,7 +533,7 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c
 SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406..f7a56e3fdbce 100644
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
@@ -60,3 +63,151 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+static void test_percpu_data_on_cpus(int map_fd, int prog_fd)
+{
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int i, err, key = 0, num_online;
+	bool *online;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	/* run on every online-CPU */
+	for (i = 0; i < num_online; i++) {
+		struct test_global_percpu_data__percpu data = {};
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
+		flags = ((__u64) i << 32) | BPF_F_CPU;
+		err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
+			break;
+
+		ASSERT_EQ(data.data, 1, "data.data");
+		ASSERT_TRUE(data.run, "data.run");
+		ASSERT_EQ(data.nums[6], 0xc0de, "data.nums[6]");
+		ASSERT_EQ(data.struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data.struct_data.set, "struct_data.set");
+		ASSERT_EQ(data.struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+	free(online);
+}
+
+static void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__percpu init_value = {};
+	struct test_global_percpu_data__percpu *init_data;
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
+	if (!ASSERT_OK_PTR(skel->percpu_data, "skel->percpu_data"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu_looooooooong, "skel->percpu_looooooooong"))
+		goto out;
+
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_data), ".percpu.data", "data map name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_looooooooong), ".percpu.looooooooong",
+		     "long map name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.percpu), ".percpu", "map name");
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
+	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_value struct_data.i");
+	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6],
+		  "init_value struct_data.nums[6]");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
+	ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu eq init_data");
+	ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->data");
+	ASSERT_EQ(skel->percpu->run, init_value.run, "skel->percpu->run");
+	ASSERT_EQ(skel->percpu->struct_data.i, init_value.struct_data.i,
+		  "skel->percpu->struct_data.i");
+	ASSERT_EQ(skel->percpu->struct_data.nums[6], init_value.struct_data.nums[6],
+		  "skel->percpu->struct_data.nums[6]");
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_OK_PTR(skel->percpu, "skel->percpu");
+
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+	test_percpu_data_on_cpus(bpf_map__fd(map), prog_fd);
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
+	test_percpu_data_on_cpus(map_fd, prog_fd);
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
diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
new file mode 100644
index 000000000000..8aebd533d86b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_global_percpu_data.subskel.h"
+
+void test_global_percpu_data_subskel(void)
+{
+	struct test_global_percpu_data *subskel = NULL;
+	struct bpf_object *obj;
+	int i;
+
+	obj = bpf_object__open_file("./test_global_percpu_data.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "bpf_object__open_file"))
+		return;
+
+	subskel = test_global_percpu_data__open(obj);
+	if (!ASSERT_OK_PTR(subskel, "test_global_percpu_data__open"))
+		goto out;
+
+	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
+		goto out;
+	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
+		goto out;
+	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRAY,
+		  "percpu_map_type");
+	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");
+
+	for (i = 0; i < subskel->subskel->var_cnt; i++) {
+		const struct bpf_var_skeleton *var;
+
+		var = (void *) subskel->subskel->vars + i * subskel->subskel->var_skel_sz;
+		ASSERT_NEQ(var->map, &subskel->maps.percpu, "var");
+	}
+
+out:
+	test_global_percpu_data__destroy(subskel);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 000000000000..54380dfb11a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int unused SEC(".percpu.looooooooong");
+int data2 SEC(".percpu.data");
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
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

