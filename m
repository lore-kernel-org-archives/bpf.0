Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9737CD32
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067137; cv=none; b=fR/IcEz3HzRXkPeB3jsojuGpZFF34sqg4HHu8UPILkwyHtdJ4zhjktnFzjVkksbeJVY074yXlNlx6Orvh5aOU6uuvCmDPxoBeKgGO6lbwt+3GeBake7TktHodvKVo9Eq1BXt1SP7A5SuOvklakBIQH/IaW4op0Iz9JTpYH0EFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067137; c=relaxed/simple;
	bh=/f0b5nqYvRuYRrnGgcST9+/5ojWfBeBx/7ogSsZtBdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDe6OEXrXKwE3zUb/99wpcCRlplC1tsSdvsMXtbtrKqQoL9R8uV81CCcXnHND4pKyoIx803cOVIlsyfv22BHcmtsyy4+OI2GKLj4ZSKXC7GTOfA3lFVSIUxhaCKUi6vNg+LFalvvexnbmuxB0YUGzkGWsgjdWLFfzWGGVP8VmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cn24L/BW; arc=none smtp.client-ip=95.215.58.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cn24L/BW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/f0b5nqYvRuYRrnGgcST9+/5ojWfBeBx/7ogSsZtBdM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787067133; v=1; x=1787671933;
 b=cn24L/BWfwXZM7gZAV2pr5gItlHniid11RW3X/+ssR2Vj07Jb1mdnH8WAVxg61LR4I/K0J14
 UVZQa6sHmfc+I6u1sJoz2VLCcGMn13/slY3yK72VQiakZronofBmEazrnNxwnSRNxaHdHycYF4M
 wvQ/B9RoPHZ+Nw7CZYxw6vA8=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.64)
	by smtp.migadu.com with ESMTPS id 07ad087d0c7f2357;
	Tue, 18 Aug 2026 15:32:13 +0000
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test for percpu data
Date: Tue, 18 Aug 2026 23:32:01 +0800
Message-ID: <20260818153202.90714-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_map__set_value_size() test for percpu data relies on the tail
'cpu_id' field in the ".percpu" map. The test would fail, when 'cpu_id' is
not the last field in the map.

To avoid the flaky test, factor out a subtest to use a dedicated
".percpu.arr" map that only has one field 'int arr[1]' to ensure that
bpf_map__set_value_size() won't fail on 4K page systems.

And, drop 'args' in test_percpu_data_on_cpus(), which isn't used in bpf
prog side.

And, enhance the test to cover 'set' and 'nums[6]'.

Fixes: 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu data")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v1 -> v2:
* Factor out a subtest to test bpf_map__set_value_size().
* Run the new subtest only on 4K page systems. (Sashiko)
* v1: https://lore.kernel.org/bpf/20260814173206.93082-5-leon.hwang@linux.dev/
---
 .../bpf/prog_tests/global_data_init.c         | 86 ++++++++++++++-----
 .../bpf/progs/test_global_percpu_data.c       | 10 ++-
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 5671c31085cd..2b69290bcc3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -68,12 +68,9 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
 {
 	struct test_global_percpu_data__percpu *data = NULL;
 	int i, err, key = 0, num_online, run = 0;
-	__u64 args[2] = {0x1234ULL, 0x5678ULL};
 	size_t data_sz;
 	bool *online;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		    .ctx_in = args,
-		    .ctx_size_in = sizeof(args),
 		    .flags = BPF_F_TEST_RUN_ON_CPU,
 	);
 
@@ -81,7 +78,7 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
 	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
 		return;
 
-	data_sz = map ? bpf_map__value_size(map) : sizeof(*data);
+	data_sz = sizeof(*data);
 	data = calloc(1, data_sz);
 	if (!ASSERT_OK_PTR(data, "calloc percpu data"))
 		goto out;
@@ -109,7 +106,7 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
 			break;
 
 		ASSERT_EQ(*runp, ++run, "run");
-		ASSERT_EQ(data->cpu_id[0], i, "cpu_id");
+		ASSERT_EQ(data->cpu_id, i, "cpu_id");
 		ASSERT_EQ(data->data, 1, "data");
 		ASSERT_TRUE(data->set, "set");
 		ASSERT_EQ(data->nums[6], 0xc0de, "nums[6]");
@@ -127,7 +124,6 @@ static void test_global_percpu_data_init(void)
 {
 	struct test_global_percpu_data__percpu init_value = {};
 	struct test_global_percpu_data__percpu *init_data;
-	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
 	struct test_global_percpu_data *skel = NULL;
 	size_t init_data_sz;
 	struct bpf_map *map;
@@ -163,9 +159,11 @@ static void test_global_percpu_data_init(void)
 	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
 		goto out;
 
+	init_value.set = 1;
 	init_value.data = 2;
 	init_value.nums[6] = -1;
 	init_value.struct_data.i = 2;
+	init_value.struct_data.set = 1;
 	init_value.struct_data.nums[6] = -1;
 	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
 	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
@@ -177,35 +175,24 @@ static void test_global_percpu_data_init(void)
 
 	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
 	ASSERT_EQ(init_data->set, init_value.set, "init_value set");
+	ASSERT_EQ(init_data->nums[6], init_value.nums[6], "init_value nums[6]");
 	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_value struct_data.i");
+	ASSERT_EQ(init_data->struct_data.set, init_value.struct_data.set,
+		  "init_value struct_data.set");
 	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6],
 		  "init_value struct_data.nums[6]");
 	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
 	ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu eq init_data");
 	ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->data");
 	ASSERT_EQ(skel->percpu->set, init_value.set, "skel->percpu->set");
+	ASSERT_EQ(skel->percpu->nums[6], init_value.nums[6], "skel->percpu->nums[6]");
 	ASSERT_EQ(skel->percpu->struct_data.i, init_value.struct_data.i,
 		  "skel->percpu->struct_data.i");
+	ASSERT_EQ(skel->percpu->struct_data.set, init_value.struct_data.set,
+		  "skel->percpu->struct_data.set");
 	ASSERT_EQ(skel->percpu->struct_data.nums[6], init_value.struct_data.nums[6],
 		  "skel->percpu->struct_data.nums[6]");
 
-	ASSERT_GT(desired_sz, sizeof(init_value), "desired_sz");
-	err = bpf_map__set_value_size(map, desired_sz);
-	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
-		goto out;
-	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "percpu value size"))
-		goto out;
-	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "percpu BTF value type"))
-		goto out;
-
-	init_data = bpf_map__initial_value(map, &init_data_sz);
-	if (!ASSERT_OK_PTR(init_data, "resized bpf_map__initial_value"))
-		goto out;
-	if (!ASSERT_EQ(init_data_sz, desired_sz, "resized initial value size"))
-		goto out;
-	if (!ASSERT_EQ(init_data->data, init_value.data, "resized initial value data"))
-		goto out;
-
 	err = test_global_percpu_data__load(skel);
 	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
 		goto out;
@@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
 	test_global_percpu_data_lskel__destroy(lskel);
 }
 
+#define PAGE_SIZE 4096
+
+static void test_global_percpu_data_map_resize(void)
+{
+	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
+	struct test_global_percpu_data *skel;
+	const int arr_value = -1;
+	struct bpf_map *map;
+	int err, prog_fd;
+	size_t data_sz;
+
+	if (sysconf(_SC_PAGE_SIZE) != PAGE_SIZE) {
+		test__skip();
+		return;
+	}
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		return;
+
+	map = skel->maps.percpu_arr;
+	skel->percpu_arr->arr[0] = arr_value;
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+		goto out;
+	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "bpf_map__value_size"))
+		goto out;
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "bpf_map__btf_value_type_id"))
+		goto out;
+
+	skel->percpu_arr = bpf_map__initial_value(map, &data_sz);
+	if (!ASSERT_EQ(data_sz, desired_sz, "data_sz"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->percpu_arr, "skel->percpu_arr"))
+		goto out;
+	if (!ASSERT_EQ(skel->percpu_arr->arr[0], arr_value, "arr[0]"))
+		goto out;
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	map = skel->maps.percpu;
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+	test_percpu_data_on_cpus(map, bpf_map__fd(map), prog_fd, &skel->bss->run);
+	ASSERT_EQ(skel->bss->arr_sum, arr_value * skel->bss->run, "arr_sum");
+
+out:
+	test_global_percpu_data__destroy(skel);
+}
+
 static int create_rdonly_percpu_array(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
@@ -388,6 +426,8 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_init();
 	if (test__start_subtest("lskel"))
 		test_global_percpu_data_lskel();
+	if (test__start_subtest("map_resize"))
+		test_global_percpu_data_map_resize();
 	if (test__start_subtest("rdonly_direct_read"))
 		test_global_percpu_data_rdonly_direct_read();
 	if (test__start_subtest("rdonly_direct_write"))
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 5dc21b3b4cb5..2765cd46e9af 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -8,9 +8,12 @@ int loong SEC(".percpu.looooooooong");
 int data3 SEC(".data.percpu");
 int data2 SEC(".percpu.data");
 
+/* Used for testing bpf_map__set_value_size(). */
+int arr[1] SEC(".percpu.arr");
+int arr_sum;
+
 int run;
-/* cpu_id as array to verify map value resizing. */
-int cpu_id[1] SEC(".percpu");
+int cpu_id SEC(".percpu");
 int data SEC(".percpu") = -1;
 int nums[7] SEC(".percpu");
 bool set SEC(".percpu") = false;
@@ -34,7 +37,8 @@ int update_percpu_data(void *ctx)
 	data = 1;
 	run++;
 	set = true;
-	cpu_id[0] = bpf_get_smp_processor_id();
+	cpu_id = bpf_get_smp_processor_id();
+	arr_sum += arr[0];
 	return 0;
 }
 
-- 
2.55.0

