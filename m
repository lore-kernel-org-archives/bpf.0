Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62633CFF6B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930383; cv=none; b=PpeoZM4Dt84yW21wkFi8RX2Pm/8ElJO7Ao4FHOUYIMtsrXhYsWBjiPF7JArtFme8WmOL/LXfNYGN2YzxowExS/5RA9gzF6i/Atgk6eMmjmO9G+W/me/T5ud+vI1u5lBhJocJno6lz4tkmf7hk2MC3Phz7eTRtGzLPj5PV7gHLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930383; c=relaxed/simple;
	bh=oyhxrSemb1noXgepQWnJgE9WX6/0hjX85bBI9Lbl3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/lXIylHTUdnl2CAjdBBp1u6Nf6vsdHB0H867VB8jBg9HdHAmkLkN2NO6rbHsMa+Hw7yu6m3givnzLINNkAXYi84VgM99Uen2EjT9KqIThrx69+ZRs8GJl85aIFlIypoou5xWU2dk6dqFuhcrNlR89FUCUUDeAbDaITJcaWx9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G9vz/Afa; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G9vz/Afa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780930379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQWGf9PgHHiN4LgqWh+hMjcdGL2T+v4U6xdfCelxvDQ=;
	b=G9vz/AfaWEe6BhEH2iLuxJoMsBaLASn6JO6QWuAxS60zHRXCPh2YrAmxesFuot9d/Nc9Ov
	iGCzSW4V8tGdaIGA4eG73SVteDPMigkADhUUOZmc9er4x0wHJEEBa+hZGC5WrbWDYjXvIB
	+kf/muVRKMN0r2+neAUCgrrUj6bGn+E=
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
Subject: [PATCH bpf-next v5 6/9] selftests/bpf: Add tests to verify global percpu data
Date: Mon,  8 Jun 2026 22:51:10 +0800
Message-ID: <20260608145113.65857-7-leon.hwang@linux.dev>
In-Reply-To: <20260608145113.65857-1-leon.hwang@linux.dev>
References: <20260608145113.65857-1-leon.hwang@linux.dev>
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

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 196 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       |  31 +++
 3 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d53b7e496ac9..d21064cfc066 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -526,7 +526,7 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c
 SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406..5abdb0b8b8b3 100644
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
@@ -60,3 +63,196 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+static void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__percpu *init_data, *data = NULL;
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
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	elem_sz = roundup(sizeof(*data), 8);
+	data = calloc(1, elem_sz);
+	if (!ASSERT_OK_PTR(data, "calloc data"))
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
+	key = 0;
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		__u64 flags;
+
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+
+		flags = ((__u64) i << 32) | BPF_F_CPU;
+		err = bpf_map__lookup_elem(map, &key, sizeof(key), data, elem_sz, flags);
+		if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+			goto out;
+
+		ASSERT_EQ(data->data, 1, "data->data");
+		ASSERT_TRUE(data->run, "data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data__destroy(skel);
+	free(data);
+	free(online);
+}
+
+static void test_global_percpu_data_lskel(void)
+{
+	int key, prog_fd, map_fd, err, num_cpus, num_online, i;
+	struct test_global_percpu_data__percpu *data = NULL;
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
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	elem_sz = roundup(sizeof(*data), 8);
+	data = calloc(1, elem_sz);
+	if (!ASSERT_OK_PTR(data, "calloc data"))
+		goto out;
+
+	lskel = test_global_percpu_data_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load"))
+		goto out;
+
+	key = 0;
+	map_fd = lskel->maps.percpu.map_fd;
+	prog_fd = lskel->progs.update_percpu_data.prog_fd;
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		__u64 flags;
+
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+
+		flags = ((__u64) i << 32) | BPF_F_CPU;
+		err = bpf_map_lookup_elem_flags(map_fd, &key, data, flags);
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
+			goto out;
+
+		ASSERT_EQ(data->data, 1, "data->data");
+		ASSERT_TRUE(data->run, "data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data_lskel__destroy(lskel);
+	free(data);
+	free(online);
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
index 000000000000..ba92ffb0ca49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,31 @@
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
+char _license[] SEC("license") = "GPL";
-- 
2.54.0

