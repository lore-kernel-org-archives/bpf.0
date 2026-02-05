Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4232C31D
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323235; cv=none; b=k6teG7mK16CrN9hWZJyhEVM1lW4F8EmYLvVv7IKRp8GfzS6azlHmt7CGW0Owp8DFMGgIcaRkVyQFQN+fpw8sI0x002SiUskSNq0RONAhDgEJB90ESj9bJDPqmxf0GQFt7AcVhlv+TigLausKP3+hAxtmxKoxD0nPhcgnUgkgZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323235; c=relaxed/simple;
	bh=CgvWjgwjwu3afB2p6Vi/DRzOkXq9AR1WDgKdeUfMaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fh3X1t1xv4STQCRkzgjWbWH+iVxe8YFKJ3wnNMcZM0Xh1fv8O7TE8enQdhUh6x2n5zZHipddcq/fogtUtidnp7UPYoRoSn7o1b2EQjnMofIpuOM2qYGvXQ5UrHhDx3wEiLJ/pAk+N0U4Cl29h5n9b5Ehf4YcPChufhl59P2O8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIT9OOW5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIT9OOW5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc305552so1444978f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323233; x=1770928033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9q1FRflL4a60/E4fm+RXZCnICIZ3NvCB0KloVre3Zk=;
        b=AIT9OOW5ZEBOQ632TBX5iRL66L5QtFuhRR44OJjPA7RAe1kU0peqZ3b7AdQHJFhvdL
         K6SGQ6f+1vUvoD3FN04pXFXoX3n+B6OfDyeQbD3uH1OGWZFNx89SJktYl2rxcop38Jbk
         8+0mGMxw92LV9+M3z1+XQqw+cuIO5rCsu2nRxgmuKyx46ibEEu/yut9/ca+fOqldD9gI
         ImkwWUWcWRnYBH/Gp3bH+N6/sA3Yis8Zu7VHCov9MXb04jXebNo+u5bm/KMjjYdnl9JU
         4icobebbfn3BBmWaHfNgHzmj/jb28e/nvSAfi0BRf7Ku8ipV36rzOCv4JvMCO/TTyoLq
         TLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323234; x=1770928034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9q1FRflL4a60/E4fm+RXZCnICIZ3NvCB0KloVre3Zk=;
        b=YDNWQymWXN7BK7ZKaRm/AO+RC/PqhsokKw63DC1I6myb/McJK0RyHwmkPWF3Kx7awn
         EKq+3hHHZlMoMKcDVSdDOpAuxz0h9MQ5Ef6p5hzm5jsywoMNfpNytT2TdEYFygUaEy11
         KutBGJhqSHR4Ewvis1PUv5BoaIGYhYmP1kBcASZvpapFO6Ki31vB94Xv/tHcJQTBNih+
         lZWLJTzpyoYkddRbN8ihTyYlMm9wdai1jKyw7VIttSeJuHt305u8xUNxTMCj0cuNWCa4
         Du8koN+nDl6fG7hvAPW/QnowsbTUV1zArMnu2eFyjc6ju/Ya49CqLe2Itk89xCnXWScb
         YHMg==
X-Gm-Message-State: AOJu0YyyUDJnsk5WxJL3MsdjqE7B+Kw/l6WT/2k3n5IqYj2tm6skiLgi
	Zvpmsx/myOexZohi+oTHrCPWv2io1xzveq3b0JZGm3n4BVg/WxenEBkp
X-Gm-Gg: AZuq6aImqVNw6rd4UKIRi4Uf3TVbxvNW3wRh4OQzd4mV1K0P9eIIXkB3FcQDC5i/ela
	eC87gFPX5dDZ7LNoqAea90wACvWucm6qTiQbxNIf6Nr6111B9HmmVdlzietMiMkkHv+LWqoeNtw
	4tWLTVwed+p/wQBd7xZMOThBWHph2yb3TJvnZzpwQRP7koDrRgWJX3vA7yfv1dPq8IEoqtvGiZ/
	12WX5xjv9V10JgbTU3N8R21vJl1PMnqZkiPd/RYh+tjEyRbMHRYTs/hUJazDW8iSR4NKqQTPSQY
	L4EukP0wqO8C/Efq3BfDYbT9vifjDMwlyIwd9ytB+rDVoA1K+1LfCYhEGH+V5/YDtEC6IFCvbVZ
	VFDKEO2OaaGt6VotqOfRlqD70PVw6bmDI+DpMWTkLb74IoDssDlNbEzH57bU6Lht3uf5V7d8=
X-Received: by 2002:a05:6000:26c3:b0:435:bbd7:1947 with SMTP id ffacd0b85a97d-4362933c3f2mr811730f8f.5.1770323233390;
        Thu, 05 Feb 2026 12:27:13 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ed9sm637030f8f.5.2026.02.05.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:37 +0000
Subject: [PATCH RFC bpf-next 07/12] selftests/bpf: Support resizable
 hashtab in test_maps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-7-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=11411;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=mh0xS9LngNdHirVBoyK/YWp5xPiQQHz82E+D+IKKrio=;
 b=I5WNr/Q96YCWEYVgUJL1gp+ryVtbYVYffTlAg1J+5RhZ/OUn+0u4ep/jnoN0P3DLscHN1YbwE
 QRMYapYuWiNB2d865hwqM+cFKQ2XT7wvZCI+4QhEMbV1d9JraC6dvUS
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  22 ++++-
 tools/testing/selftests/bpf/test_maps.c            | 107 +++++++++++++++------
 2 files changed, 97 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 5da493b94ae2573c50e0f0eccadb577d549062a0..e8e83bf95be478eaaad35309e1268c5053a4135d 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -74,10 +74,11 @@ static void map_batch_verify(int *visited, __u32 max_entries,
 	}
 }
 
-void __test_map_lookup_and_delete_batch(bool is_pcpu)
+void __test_map_lookup_and_delete_batch(enum bpf_map_type map_type)
 {
 	__u32 batch, count, total, total_success;
 	typedef BPF_DECLARE_PERCPU(int, value);
+	bool is_pcpu = (map_type == BPF_MAP_TYPE_PERCPU_HASH);
 	int map_fd, *keys, *visited, key;
 	const __u32 max_entries = 10;
 	value pcpu_values[max_entries];
@@ -88,9 +89,13 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 		.elem_flags = 0,
 		.flags = 0,
 	);
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = (map_type == BPF_MAP_TYPE_RHASH) ? BPF_F_NO_PREALLOC : 0,
+	};
 
-	map_fd = bpf_map_create(is_pcpu ? BPF_MAP_TYPE_PERCPU_HASH : BPF_MAP_TYPE_HASH,
-				"hash_map", sizeof(int), sizeof(int), max_entries, NULL);
+	map_fd = bpf_map_create(map_type, "hash_map", sizeof(int), sizeof(int),
+				max_entries, &map_opts);
 	CHECK(map_fd == -1,
 	      "bpf_map_create()", "error:%s\n", strerror(errno));
 
@@ -261,13 +266,19 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 
 void htab_map_batch_ops(void)
 {
-	__test_map_lookup_and_delete_batch(false);
+	__test_map_lookup_and_delete_batch(BPF_MAP_TYPE_HASH);
 	printf("test_%s:PASS\n", __func__);
 }
 
 void htab_percpu_map_batch_ops(void)
 {
-	__test_map_lookup_and_delete_batch(true);
+	__test_map_lookup_and_delete_batch(BPF_MAP_TYPE_PERCPU_HASH);
+	printf("test_%s:PASS\n", __func__);
+}
+
+void rhtab_map_batch_ops(void)
+{
+	__test_map_lookup_and_delete_batch(BPF_MAP_TYPE_RHASH);
 	printf("test_%s:PASS\n", __func__);
 }
 
@@ -275,4 +286,5 @@ void test_htab_map_batch_ops(void)
 {
 	htab_map_batch_ops();
 	htab_percpu_map_batch_ops();
+	rhtab_map_batch_ops();
 }
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index ccc5acd55ff9d522e40e32b5b2addd294e802aee..b7286f8f1b40ea1bf14589d20390924fed8fdc28 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -30,12 +30,23 @@ int skips;
 
 static struct bpf_map_create_opts map_opts = { .sz = sizeof(map_opts) };
 
+static bool skip_test(enum bpf_map_type map_type)
+{
+	return map_type == BPF_MAP_TYPE_RHASH &&
+	       !(map_opts.map_flags & BPF_F_NO_PREALLOC);
+}
+
 static void test_hashmap(unsigned int task, void *data)
 {
+	enum bpf_map_type map_type = data ? *(enum bpf_map_type *)data : BPF_MAP_TYPE_HASH;
 	long long key, next_key, first_key, value;
 	int fd;
 
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value), 2, &map_opts);
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value), 2, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create hashmap '%s'!\n", strerror(errno));
 		exit(1);
@@ -128,11 +139,16 @@ static void test_hashmap(unsigned int task, void *data)
 
 static void test_hashmap_sizes(unsigned int task, void *data)
 {
+	enum bpf_map_type map_type = data ? *(enum bpf_map_type *)data : BPF_MAP_TYPE_HASH;
 	int fd, i, j;
 
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
 	for (i = 1; i <= 512; i <<= 1)
 		for (j = 1; j <= 1 << 18; j <<= 1) {
-			fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, i, j, 2, &map_opts);
+			fd = bpf_map_create(map_type, NULL, i, j, 2, &map_opts);
 			if (fd < 0) {
 				if (errno == ENOMEM)
 					return;
@@ -261,12 +277,12 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 }
 
 #define VALUE_SIZE 3
-static int helper_fill_hashmap(int max_entries)
+static int helper_fill_hashmap(int max_entries, enum bpf_map_type map_type)
 {
 	int i, fd, ret;
 	long long key, value[VALUE_SIZE] = {};
 
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value),
 			    max_entries, &map_opts);
 	CHECK(fd < 0,
 	      "failed to create hashmap",
@@ -285,11 +301,16 @@ static int helper_fill_hashmap(int max_entries)
 
 static void test_hashmap_walk(unsigned int task, void *data)
 {
+	enum bpf_map_type map_type = data ? *(enum bpf_map_type *)data : BPF_MAP_TYPE_HASH;
 	int fd, i, max_entries = 10000;
 	long long key, value[VALUE_SIZE], next_key;
 	bool next_key_valid = true;
 
-	fd = helper_fill_hashmap(max_entries);
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
+	fd = helper_fill_hashmap(max_entries, map_type);
 
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
@@ -297,7 +318,8 @@ static void test_hashmap_walk(unsigned int task, void *data)
 		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
 	}
 
-	assert(i == max_entries);
+	/* rhash does not guarantee visiting all elements or not visiting the same element twice */
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 
 	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
 	for (i = 0; next_key_valid; i++) {
@@ -308,7 +330,7 @@ static void test_hashmap_walk(unsigned int task, void *data)
 		key = next_key;
 	}
 
-	assert(i == max_entries);
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
@@ -317,7 +339,7 @@ static void test_hashmap_walk(unsigned int task, void *data)
 		assert(value[0] - 1 == key);
 	}
 
-	assert(i == max_entries);
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 	close(fd);
 }
 
@@ -329,8 +351,8 @@ static void test_hashmap_zero_seed(void)
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_ZERO_SEED;
 
-	first = helper_fill_hashmap(3);
-	second = helper_fill_hashmap(3);
+	first = helper_fill_hashmap(3, BPF_MAP_TYPE_HASH);
+	second = helper_fill_hashmap(3, BPF_MAP_TYPE_HASH);
 
 	for (i = 0; ; i++) {
 		void *key_ptr = !i ? NULL : &key;
@@ -1301,7 +1323,7 @@ static void test_map_in_map(void)
 
 #define MAP_SIZE (32 * 1024)
 
-static void test_map_large(void)
+static void test_map_large(enum bpf_map_type map_type)
 {
 
 	struct bigkey {
@@ -1311,7 +1333,11 @@ static void test_map_large(void)
 	} key;
 	int fd, i, value;
 
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create large map '%s'!\n", strerror(errno));
@@ -1378,10 +1404,16 @@ static void __run_parallel(unsigned int tasks,
 
 static void test_map_stress(void)
 {
-	run_parallel(100, test_hashmap_walk, NULL);
-	run_parallel(100, test_hashmap, NULL);
+	enum bpf_map_type hash_type = BPF_MAP_TYPE_HASH;
+	enum bpf_map_type rhash_type = BPF_MAP_TYPE_RHASH;
+
+	run_parallel(100, test_hashmap_walk, &hash_type);
+	run_parallel(100, test_hashmap_walk, &rhash_type);
+	run_parallel(100, test_hashmap, &hash_type);
+	run_parallel(100, test_hashmap, &rhash_type);
 	run_parallel(100, test_hashmap_percpu, NULL);
-	run_parallel(100, test_hashmap_sizes, NULL);
+	run_parallel(100, test_hashmap_sizes, &hash_type);
+	run_parallel(100, test_hashmap_sizes, &rhash_type);
 
 	run_parallel(100, test_arraymap, NULL);
 	run_parallel(100, test_arraymap_percpu, NULL);
@@ -1471,12 +1503,16 @@ static void test_update_delete(unsigned int fn, void *data)
 	}
 }
 
-static void test_map_parallel(void)
+static void test_map_parallel(enum bpf_map_type map_type)
 {
 	int i, fd, key = 0, value = 0, j = 0;
 	int data[2];
 
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create map for parallel test '%s'!\n",
@@ -1529,14 +1565,18 @@ static void test_map_parallel(void)
 	close(fd);
 }
 
-static void test_map_rdonly(void)
+static void test_map_rdonly(enum bpf_map_type map_type)
 {
 	int fd, key = 0, value = 0;
 	__u32 old_flags;
 
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_RDONLY;
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
 	map_opts.map_flags = old_flags;
 	if (fd < 0) {
@@ -1558,14 +1598,18 @@ static void test_map_rdonly(void)
 	close(fd);
 }
 
-static void test_map_wronly_hash(void)
+static void test_map_wronly_hash(enum bpf_map_type map_type)
 {
 	int fd, key = 0, value = 0;
 	__u32 old_flags;
 
+	/* RHASH doesn't support prealloc mode */
+	if (skip_test(map_type))
+		return;
+
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_WRONLY;
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+	fd = bpf_map_create(map_type, NULL, sizeof(key), sizeof(value),
 			    MAP_SIZE, &map_opts);
 	map_opts.map_flags = old_flags;
 	if (fd < 0) {
@@ -1623,7 +1667,8 @@ static void test_map_wronly_stack_or_queue(enum bpf_map_type map_type)
 
 static void test_map_wronly(void)
 {
-	test_map_wronly_hash();
+	test_map_wronly_hash(BPF_MAP_TYPE_HASH);
+	test_map_wronly_hash(BPF_MAP_TYPE_RHASH);
 	test_map_wronly_stack_or_queue(BPF_MAP_TYPE_STACK);
 	test_map_wronly_stack_or_queue(BPF_MAP_TYPE_QUEUE);
 }
@@ -1883,9 +1928,14 @@ static void test_reuseport_array(void)
 
 static void run_all_tests(void)
 {
-	test_hashmap(0, NULL);
+	enum bpf_map_type hash_type = BPF_MAP_TYPE_HASH;
+	enum bpf_map_type rhash_type = BPF_MAP_TYPE_RHASH;
+
+	test_hashmap(0, &hash_type);
+	test_hashmap(0, &rhash_type);
 	test_hashmap_percpu(0, NULL);
-	test_hashmap_walk(0, NULL);
+	test_hashmap_walk(0, &hash_type);
+	test_hashmap_walk(0, &rhash_type);
 	test_hashmap_zero_seed();
 
 	test_arraymap(0, NULL);
@@ -1897,11 +1947,14 @@ static void run_all_tests(void)
 	test_devmap_hash(0, NULL);
 	test_sockmap(0, NULL);
 
-	test_map_large();
-	test_map_parallel();
+	test_map_large(BPF_MAP_TYPE_HASH);
+	test_map_large(BPF_MAP_TYPE_RHASH);
+	test_map_parallel(BPF_MAP_TYPE_HASH);
+	test_map_parallel(BPF_MAP_TYPE_RHASH);
 	test_map_stress();
 
-	test_map_rdonly();
+	test_map_rdonly(BPF_MAP_TYPE_HASH);
+	test_map_rdonly(BPF_MAP_TYPE_RHASH);
 	test_map_wronly();
 
 	test_reuseport_array();

-- 
2.53.0

