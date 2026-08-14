Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50D4908D7
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728770; cv=none; b=J11ALcc/exlWOefwx8nGI/7UjXIYKkILtd0GSXTCgPyygDRWT33xnT25Vwuaz3FMnSX/P17s5/ksb7FkABu4ZNFraq0NLUYGfEbtr4tPjcJ66bdWUEBisfmTO4UeuVZDHc7UEJ+euMYvcZOHRnKlMQejP67pHGiX1DUoG7PaSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728770; c=relaxed/simple;
	bh=1aV1XDI4s/WVLabyMqFu9ojxvxHts71p/dqwCwPQ+xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMx33GNKNdof9GO8oXUEpyP9qQ7gbZ+naXtmU8tquA3NCoMwFdd2tWlxPfPnN7keOk7n2QsIY8EvxtKVgmir2J8g1uC6pqLTwD1QghTAu/06SzxdOKxzyqeCeKkFUcVzrH3goDMk5bG+KcILSqAKcukFVnX8JH+2DkcEV7Aa9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmDH1JpG; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmDH1JpG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1aV1XDI4s/WVLabyMqFu9ojxvxHts71p/dqwCwPQ+xE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728765; v=1; x=1787333565;
 b=VmDH1JpGk8HrhsGsupNW6AYjX24wA3I+h8Laxi9ZQA9frXXUdxk+9vlWwVBlOJwmbeTI60Wm
 5dvlAwz+EmhMTO3HbboFoO3ox9TnjviqoUwq6Ld5ucGs5f3tTpiJYHd//7jrkS7fJ6sERsSx62C
 dR1VX9r14lzvDH961jMKgL/4=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id 7a6cdb775b05e8d1;
	Fri, 14 Aug 2026 17:32:45 +0000
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 4/5] selftests/bpf: Avoid flaky resize value test for percpu data
Date: Sat, 15 Aug 2026 01:32:05 +0800
Message-ID: <20260814173206.93082-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
References: <20260814173206.93082-1-leon.hwang@linux.dev>
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

To avoid the flaky test, use a dedicated ".percpu.arr" map that only has
one field 'int arr[1]' to ensure that bpf_map__set_value_size() won't
fail.

And, drop 'args' in test_percpu_data_on_cpus(), which isn't used in bpf
prog side.

And, enhance the test to cover 'set' and 'nums[6]' to distinguish a broken
copy.

Fixes: 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu data")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 37 ++++++++++---------
 .../bpf/progs/test_global_percpu_data.c       |  8 ++--
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 7d6bda909295..2f0dbeb88934 100644
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
@@ -126,11 +123,11 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
 static void test_global_percpu_data_init(void)
 {
 	struct test_global_percpu_data__percpu init_value = {};
+	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
 	struct test_global_percpu_data__percpu *init_data;
-	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
 	struct test_global_percpu_data *skel = NULL;
+	struct bpf_map *map, *map_percpu_arr;
 	size_t init_data_sz;
-	struct bpf_map *map;
 	int prog_fd, err;
 
 	skel = test_global_percpu_data__open();
@@ -163,9 +160,11 @@ static void test_global_percpu_data_init(void)
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
@@ -177,33 +176,37 @@ static void test_global_percpu_data_init(void)
 
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
+	skel->percpu_arr->arr[0] = -1;
+	map_percpu_arr = skel->maps.percpu_arr;
+	err = bpf_map__set_value_size(map_percpu_arr, desired_sz);
 	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
 		goto out;
-	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "percpu value size"))
-		goto out;
-	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "percpu BTF value type"))
+	if (!ASSERT_EQ(bpf_map__value_size(map_percpu_arr), desired_sz, "percpu value size"))
 		goto out;
-
-	init_data = bpf_map__initial_value(map, &init_data_sz);
-	if (!ASSERT_OK_PTR(init_data, "resized bpf_map__initial_value"))
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map_percpu_arr), 0, "percpu BTF value type"))
 		goto out;
-	if (!ASSERT_EQ(init_data_sz, desired_sz, "resized initial value size"))
+	skel->percpu_arr = bpf_map__initial_value(map_percpu_arr, &init_data_sz);
+	if (!ASSERT_OK_PTR(skel->percpu_arr, "resized percpu_arr value"))
 		goto out;
-	if (!ASSERT_EQ(init_data->data, init_value.data, "resized initial value data"))
+	if (!ASSERT_EQ(skel->percpu_arr->arr[0], -1, "arr[0]"))
 		goto out;
 
 	err = test_global_percpu_data__load(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 71ff8d1bf49e..12556590b647 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -8,9 +8,11 @@ int loong SEC(".percpu.looooooooong");
 int data3 SEC(".data.percpu");
 int data2 SEC(".percpu.data");
 
+/* Used for testing bpf_map__set_value_size(). */
+int arr[1] SEC(".percpu.arr");
+
 int run;
-/* cpu_id as array to verify map value resizing. */
-int cpu_id[1] SEC(".percpu");
+int cpu_id SEC(".percpu");
 int data SEC(".percpu") = -1;
 int nums[7] SEC(".percpu");
 bool set SEC(".percpu") = false;
@@ -34,7 +36,7 @@ int update_percpu_data(void *ctx)
 	data = 1;
 	run++;
 	set = true;
-	cpu_id[0] = bpf_get_smp_processor_id();
+	cpu_id = bpf_get_smp_processor_id();
 	return 0;
 }
 
-- 
2.55.0

