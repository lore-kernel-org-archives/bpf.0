Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC33D6461
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661058; cv=none; b=mfW2ZAfcn6HayawhUAw4Z0vtvioPr6T5KixQu3hQPXk+Mk1hil0nGptGHfD6Ub8PV19/uFBHujH6clq0EBTLm09lmDDHpmjZjJAinxx8Wba4rEXa5KIvVXgWR+vU+dWVfrEWgl42mxu1jENvWyE1sDqUlQuYnitnASorsVZ2tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661058; c=relaxed/simple;
	bh=cwqdI/DFZN9WvliwUb+igdwUCfAOqvxKQlUjPv+mqXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZANFpoeKzSgG4bY4rJnB9ZaDMfCyz0TLEKO3oNqoylYP27KpVjUQrvz0kkrUe/PYtLxGjysETitTZJruxQFZGB2rZI8439RVGRHtegJdkUZj4svlbw3OAAivUnlN0jcXdplPgxP20ZyJ4Obj7MvX0VSKjLmePX8MG0gdSr6jUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw3GhUrJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw3GhUrJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso34503335e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661055; x=1776265855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q/gyezux7aLiUgEChmhybs/IvmjchLYvs3RkndwHvQ=;
        b=Qw3GhUrJm/ExXaCAWZEv4t1eFy/2vImhii59NBu2R8KgxftSrx4qyh7ZiNEW2wD1oD
         qiWSbXdoA3+U+09K7C0zGVobOjaCSTNA+Qp9YL4UiSqwws5XjORmSNFCJVH1+521Np9d
         yWcQmk8Eoz2cKfURTfzn0JoIAH+rQlH0UQpzJ/VvHgTM9dmuJYaOeMxu4Q93iuOZsi44
         N/6XfFuCcPafyQfsihJzgDwWR0EJiD49VMCoC9/jBI5oHaOy7aYzPNu+LhuHLE5oSsCg
         q7riGDeSkkgF6Kn7BwuVek7tEkKwCNTaPwk9oZrmjvspIzlliTBnoRjRfxhOnkqwcP7c
         +xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661055; x=1776265855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+q/gyezux7aLiUgEChmhybs/IvmjchLYvs3RkndwHvQ=;
        b=hdrBpU5TNr+8LZiFlScFnmDA18cWxBNQF1wbqvDFSyGgSY8xVKrqXLDaD9pOCblkjv
         1lj2UiEVsUzMCaG/N9gkhPHeA7CVQESfUHW9dksqaa2BKh58ujyNccPmkkxo0SO2xD0u
         3FhXjRMLKAmhBKvMQRccUDD0BR+r0yaM7ZXJhbeqc0rfjo8eTxN2xB1jy4gkfHj1kFzG
         EfsW9DnXaUgpvuyyiggsc4PGD4KFcWjalShsLDiIRV51G7YFnBOwxBfVd+IK576TeXmm
         P9JBF7KiFtd0nQlkqu2RfXkjqzPM++v23Bl7oFr1jwI/DdogubW1RI94Ju+aIkgsbygx
         MN6w==
X-Gm-Message-State: AOJu0YxHK3dibxz/0CG06lV05CdQsJ6ME4YOTMqQRK2Y6PkTKethfpZE
	Y8j4xaLen+lvJA7sXKxH2dSdILqBcofPy9nlRlniAX78h4MBHWN5/Jgt
X-Gm-Gg: AeBDies2ukbXWxT0Yx/obqJKA9aoCdxnfK2ksnAm7ARz8RT1xSJQ6buGKp/tZq96msR
	1nCdndu7EqyZO43lrzn0yEAqthR1z6ch2TBAN/VpPf2JIAREIa5eKOCtVAS88VWcEb690IV010A
	bWJrj6h6zTqIbUboCp8ejocN6qFcOqWqZ1p4hnDO8QvkD7vPjJ/cfRpGh/urc22b2WIPYABSkGH
	v4VfFUWmSW1xF0HtmV1ne50OBnNEMhPGF2r93CFix1pdHsvvKCKGG8rIbTmZGhksylmAbFn4a/A
	e/4ELxqcFG8CLw8XTsxS5aIufk2jSLx3HCgxUOxIEIiugDcYTplALNtBNUKG648xDfaaIsfpRwa
	SatczCj9qY2e85C7FwTfW45Te1WTXkR+wI1AgH58CtwNAo2d1NwpKmCChFgIP2EcAv+sw1BeR3m
	M9wgu9Y4nk91yRoM0IvPhkv+8u
X-Received: by 2002:a05:600c:a418:b0:488:ae4e:51a5 with SMTP id 5b1f17b1804b1-488ae4e5464mr143413745e9.15.1775661055250;
        Wed, 08 Apr 2026 08:10:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm361435775e9.11.2026.04.08.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:54 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:18 -0700
Subject: [PATCH RFC bpf-next v2 13/18] selftests/bpf: Support resizable
 hashtab in test_maps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-13-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=12383;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=3S9yMmSe/117/IpDrIlKAISGKKDyKDrOzxRNu3Bj5pY=;
 b=W8brEefjY/xcjQtDWyKaMkn8dtBBfzNXVXWAiD5zjiTtMamqJTePawzi10eILnhDiIcfLjHGW
 5iiIy1K5+cYCY3+FQ8/bES8o55Qr+yTInIUa5Z5JGpKbsIdnBCno+Xo
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Parameterize existing htab tests (test_hashmap, test_hashmap_sizes,
test_hashmap_walk, htab_map_batch_ops) by map type so they run
against BPF_MAP_TYPE_RHASH as well. Relax ordering and exact-count
assertions where rhashtable resize makes them non-deterministic.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  22 +++-
 tools/testing/selftests/bpf/test_maps.c            | 127 ++++++++++++++++-----
 2 files changed, 114 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 5da493b94ae2..e8e83bf95be4 100644
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
index ccc5acd55ff9..2e06b7e0c3ba 100644
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
@@ -285,19 +301,32 @@ static int helper_fill_hashmap(int max_entries)
 
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
 		key = next_key;
-		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
+		if (map_type == BPF_MAP_TYPE_RHASH)
+			/*
+			 * During chained rhashtable resize, a key visible to
+			 * get_next_key can be transiently invisible to lookup.
+			 */
+			bpf_map_lookup_elem(fd, &key, value);
+		else
+			assert(bpf_map_lookup_elem(fd, &key, value) == 0);
 	}
 
-	assert(i == max_entries);
+	/* rhash does not guarantee visiting all elements or not visiting the same element twice */
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 
 	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
 	for (i = 0; next_key_valid; i++) {
@@ -308,16 +337,23 @@ static void test_hashmap_walk(unsigned int task, void *data)
 		key = next_key;
 	}
 
-	assert(i == max_entries);
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
 		key = next_key;
 		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
-		assert(value[0] - 1 == key);
+		/*
+		 * Async rhashtable resize (triggered by the fill above) can
+		 * still be in progress.  get_next_key follows future_tbl and
+		 * may revisit elements, so some values get incremented more
+		 * than once.
+		 */
+		assert(map_type == BPF_MAP_TYPE_RHASH ||
+		       value[0] - 1 == key);
 	}
 
-	assert(i == max_entries);
+	assert(map_type == BPF_MAP_TYPE_RHASH || i == max_entries);
 	close(fd);
 }
 
@@ -329,8 +365,8 @@ static void test_hashmap_zero_seed(void)
 	old_flags = map_opts.map_flags;
 	map_opts.map_flags |= BPF_F_ZERO_SEED;
 
-	first = helper_fill_hashmap(3);
-	second = helper_fill_hashmap(3);
+	first = helper_fill_hashmap(3, BPF_MAP_TYPE_HASH);
+	second = helper_fill_hashmap(3, BPF_MAP_TYPE_HASH);
 
 	for (i = 0; ; i++) {
 		void *key_ptr = !i ? NULL : &key;
@@ -1301,7 +1337,7 @@ static void test_map_in_map(void)
 
 #define MAP_SIZE (32 * 1024)
 
-static void test_map_large(void)
+static void test_map_large(enum bpf_map_type map_type)
 {
 
 	struct bigkey {
@@ -1311,7 +1347,11 @@ static void test_map_large(void)
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
@@ -1378,10 +1418,16 @@ static void __run_parallel(unsigned int tasks,
 
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
@@ -1399,7 +1445,7 @@ static void test_map_stress(void)
 static bool can_retry(int err)
 {
 	return (err == EAGAIN || err == EBUSY ||
-		((err == ENOMEM || err == E2BIG) &&
+		((err == ENOMEM || err == E2BIG || err == ENOENT) &&
 		 map_opts.map_flags == BPF_F_NO_PREALLOC));
 }
 
@@ -1471,12 +1517,16 @@ static void test_update_delete(unsigned int fn, void *data)
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
@@ -1529,14 +1579,18 @@ static void test_map_parallel(void)
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
@@ -1558,14 +1612,18 @@ static void test_map_rdonly(void)
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
@@ -1623,7 +1681,8 @@ static void test_map_wronly_stack_or_queue(enum bpf_map_type map_type)
 
 static void test_map_wronly(void)
 {
-	test_map_wronly_hash();
+	test_map_wronly_hash(BPF_MAP_TYPE_HASH);
+	test_map_wronly_hash(BPF_MAP_TYPE_RHASH);
 	test_map_wronly_stack_or_queue(BPF_MAP_TYPE_STACK);
 	test_map_wronly_stack_or_queue(BPF_MAP_TYPE_QUEUE);
 }
@@ -1883,9 +1942,14 @@ static void test_reuseport_array(void)
 
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
@@ -1897,11 +1961,14 @@ static void run_all_tests(void)
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
2.52.0

