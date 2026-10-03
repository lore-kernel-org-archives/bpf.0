Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C8469840
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043432; cv=none; b=YT1aRmKPP6kPS8HkMfzzamtvj5IsZQKBcDfdj2swOKDY7EvosA2Si9/Hx0V44gN2fKjZiR/kgdTtoFAnMA45Z3cTTxPThEGfw38eErKu0XepYMuO+IAZT2+tYMBrM6+gQB2jsRgpChIkZ8qlhgRFxHI51wufQS1YpoBkZDELhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043432; c=relaxed/simple;
	bh=Yh4CJ0FH9zdXYc4XcJohpevikI3ectvynvrlfRB6vOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB8NX6u6e7O/DjCudLmjQMFVPekDKIoy6fWa2WDPu4OFDGUNsG6edgTH2xfWZjDMn4o3HJb/XVhe9MsA06AePbBq/ktXNDta2PxJeFEHrAF5ZdjfhNDlE8lyUamPnSe8sbcKD4TdDjgLSAEsU3EdOOhKAdRlTQ+4R1yLFrG5ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DB4PMp1C; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DB4PMp1C"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3430282B55;
	Sat, 03 Oct 2026 18:03:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHHjd4lRirOC; Sat,  3 Oct 2026 18:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791043425; bh=Yh4CJ0FH9zdXYc4XcJohpevikI3ectvynvrlfRB6vOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DB4PMp1C4Ezvvo2EAit10629Wno8p41css3SKr7qB69bSzg6zYW0YJGW6ADjT0qNL
	 L3iUi5j4c0fsubkDxMAZ7Pmrs+9HXVLCxZ8ofb6QwwFFHPSlrDJDK4jE92QxfZTMZy
	 HGuM6NzTlRgUGD91uKFmMBXmiv2UvPCsj/6MsOYg2UHBUxtOQwxr2Y069mA4PpOud0
	 lUe0K8OV95wlu72Eid9/KK6TG3Tws5G4PGzPhH0zm0tVBK7Deqdh3Ec99hMCdgsTiY
	 8mOOuL1Akmh6n+WpRrOdCCrwa6GnZbY8E32X8/ljBldX5mSq0fFeV6KUb8rB/iiLht
	 Pq2amiCWZB30w==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v3 3/3] selftests/bpf: add tests for percpu map flags combination
Date: Sat,  3 Oct 2026 17:02:13 +0100
Message-ID: <20261003160213.2641506-4-maghasi@disroot.org>
In-Reply-To: <20261003160213.2641506-1-maghasi@disroot.org>
References: <20261003160213.2641506-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All possible combinations of (BPF_EXIST, BPF_NOEXIST) and
(BPF_F_ALL_CPUS, BPF_F_CPU) flags are covered for all percpu map types.

As BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE does not support BPF_NOEXIST and
also in order to reduce the amount of code duplicates, I added its
new test scenarios to the existing cpu_flag_percpu_cgroup_storage test.

But for other percpu map types, I added new tests to be able to
exercise all flag combinations and the edge cases such as percpu LRU
unnecessary deletion issue.

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 7b4a1e24363b..f50f51c91164 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -449,6 +449,37 @@ static void test_lru_percpu_hash_cpu_flag_create(void)
 	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
 }
 
+static void test_percpu_cgroup_storage_flags_combination(struct bpf_map *map, int nr_cpus,
+							  struct bpf_cgroup_storage_key *key)
+{
+	int err;
+	u64 flags = 0;
+	size_t value_sz = sizeof(u32);
+	u32 *values = NULL;
+
+	values = calloc(nr_cpus, value_sz);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	flags = BPF_NOEXIST | BPF_EXIST;
+	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem noexist|exist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
+	if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus|exist"))
+		goto out;
+
+	flags = BPF_F_CPU | BPF_EXIST;
+	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
+	if (!ASSERT_OK(err, "bpf_map__update_elem cpu|exist"))
+		goto out;
+
+out:
+	free(values);
+}
+
 static void test_percpu_cgroup_storage_cpu_flag(void)
 {
 	struct percpu_alloc_array *skel = NULL;
@@ -489,6 +520,7 @@ static void test_percpu_cgroup_storage_cpu_flag(void)
 		goto out;
 
 	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, nr_cpus, false);
+	test_percpu_cgroup_storage_flags_combination(map, nr_cpus, &key);
 out:
 	bpf_prog_detach2(-1, cgroup, BPF_CGROUP_INET_EGRESS);
 	close(cgroup);
@@ -537,6 +569,127 @@ static void test_hash_cpu_flag(void)
 	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
 }
 
+static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
+{
+	size_t value_sz = 8;
+	void *values = NULL;
+	u32 max_entries = 3, key = 0;
+	u64 flags = 0;
+	int err, map_fd, nr_cpus;
+	bool is_hash_map = (map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+			    map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	values = calloc(nr_cpus, value_sz);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	map_fd = bpf_map_create(map_type, "test_flags_combination_map",
+				sizeof(u32), value_sz, max_entries, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create")) {
+		free(values);
+		return;
+	}
+
+	flags = BPF_NOEXIST | BPF_EXIST;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem noexist|exist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|noexist"))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &key, values, flags);
+		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
+			goto out;
+	} else {
+		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
+			goto out;
+	}
+
+	flags = BPF_F_CPU | BPF_NOEXIST;
+	key = 1;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|noexist"))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &key, values, flags);
+		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem cpu|noexist"))
+			goto out;
+	} else {
+		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem cpu|noexist"))
+			goto out;
+	}
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	key = 2;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem all_cpus|exist"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|exist"))
+			goto out;
+	}
+
+	flags = BPF_F_CPU | BPF_EXIST;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem cpu|exist"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|exist"))
+			goto out;
+	}
+
+	if (map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
+		goto out;
+
+	/* Percpu LRU hash map should not delete old entries unnecessarily */
+	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
+	key = 2;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))
+		goto out;
+
+	key = 0;
+	err = bpf_map_lookup_elem(map_fd, &key, values);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem unnecessary_deletion"))
+		goto out;
+
+out:
+	close(map_fd);
+	free(values);
+}
+
+static void test_percpu_hash_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_PERCPU_HASH);
+}
+
+static void test_lru_percpu_hash_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+}
+
+static void test_percpu_array_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_PERCPU_ARRAY);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -565,4 +718,10 @@ void test_percpu_alloc(void)
 		test_array_cpu_flag();
 	if (test__start_subtest("cpu_flag_hash"))
 		test_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_combination_percpu_hash"))
+		test_percpu_hash_flags_combination();
+	if (test__start_subtest("cpu_flag_combination_lru_percpu_hash"))
+		test_lru_percpu_hash_flags_combination();
+	if (test__start_subtest("cpu_flag_combination_percpu_array"))
+		test_percpu_array_flags_combination();
 }
-- 
2.47.3

