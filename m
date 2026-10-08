Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D738888E
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461339; cv=none; b=oa9aGMB98kKYXUQBH6GTz1Kdj+pSeGu54rSGOgtlzHcF6AV/OBQT8Ly/9Z5ii2NTfAPHxhkOGOsNAiqDnmxNEq7psuj7ogMwCc0rX+ha6b27oaEoC/xrHp/rR6x57o+pSDyn50R8dTDkoHneY20jUlD7/Iw0xaJHU3cayNQ0rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461339; c=relaxed/simple;
	bh=e+4GbCoFIH9JtVnTVybLPqP0p6QbFpOUlzl9OOC3+Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQpX/ucn9CtgDLPMgN+AXzhrKuefFSMIB2uIzn06FHU5Sam5dQsCbGu9I3rSgiwHl5N1qc4jb2/d2nG1F4ku2+Sn8Leg9JbDIYaiZ6qlpdbeXznMpMRBfD3+PKrCh7aBpBy2h40o+5puFFuWLxMbmUgnQEAPz3+nOYARrhw9tzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=M2rA6w34; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="M2rA6w34"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4773E80510;
	Thu, 08 Oct 2026 14:08:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zno-O3tpZii4; Thu,  8 Oct 2026 14:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791461334; bh=e+4GbCoFIH9JtVnTVybLPqP0p6QbFpOUlzl9OOC3+Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2rA6w34fqxCZJ9xP5/QkhAirALfkxSZlwyxn8a7j+ddCGytHTAMkoZoQozOr74gr
	 VQ9J0uJn4cp3Ry/JUWuIVfGZaRGumBXyD/GWrkI2AvHAkPWDB9o6r8rB9jdbXy/Xvr
	 R5GTfBHMZpWsnGo4Lz6fXJfmtMcOU/d3XLsYlRSWmeTTSGYxSNmYrSr7+4Jsn2qUkf
	 pT7w3E8SFhUAsNuCtetEYQYV/XCZnhFws/umiJSjv1UHPcLYFrq/2tGlCXhY+Ot74/
	 a42BWTkLxMpoFEefLcAl718tyXN3dEG8+q2Ij9aR4CVmiP6yHM/6Jva83IDO6wTTAl
	 dcjcMjePBt5yQ==
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
	john.fastabend@gmail.com,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v6 3/3] selftests/bpf: add tests for percpu map flags combination
Date: Thu,  8 Oct 2026 13:07:34 +0100
Message-ID: <20261008120734.1565972-4-maghasi@disroot.org>
In-Reply-To: <20261008120734.1565972-1-maghasi@disroot.org>
References: <20261008120734.1565972-1-maghasi@disroot.org>
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
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 254 ++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 7b4a1e24363b..67124dd4d8a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -449,6 +449,95 @@ static void test_lru_percpu_hash_cpu_flag_create(void)
 	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
 }
 
+static bool verify_map_value_all_cpus(int map_fd, void *key, void *values, size_t elem_sz,
+				      u32 expected_value, int nr_cpus)
+{
+	int i, err;
+
+	err = bpf_map_lookup_elem(map_fd, key, values);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem all_cpus"))
+		return false;
+
+	for (i = 0 ; i < nr_cpus ; i++) {
+		if (!ASSERT_EQ(*(u32 *)(values + elem_sz * i), expected_value,
+			       "bpf_map_lookup_elem value all_cpus"))
+			return false;
+	}
+
+	return true;
+}
+
+static bool verify_map_value_first_cpu(int map_fd, void *key, void *values, size_t elem_sz,
+				       u32 expected_value, int nr_cpus)
+{
+	int i, err;
+
+	err = bpf_map_lookup_elem(map_fd, key, values);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem cpu"))
+		return false;
+
+	if (!ASSERT_EQ(*(u32 *)values, expected_value, "bpf_map_lookup_elem value cpu"))
+		return false;
+
+	for (i = 1 ; i < nr_cpus ; i++) {
+		if (!ASSERT_NEQ(*(u32 *)(values + elem_sz * i), expected_value,
+				"bpf_map_lookup_elem value cpu"))
+			return false;
+	}
+
+	return true;
+}
+
+static void test_percpu_cgroup_storage_flags_combination(struct bpf_map *map, int nr_cpus,
+							 struct bpf_cgroup_storage_key *key)
+{
+	size_t value_sz = sizeof(u32), key_sz, elem_sz;
+	u32 *values, test_value = 0xAABBCCDD;
+	int err, map_fd;
+	u64 flags;
+
+	key_sz = sizeof(*key);
+	elem_sz = roundup(value_sz, 8);
+	map_fd = bpf_map__fd(map);
+	values = calloc(nr_cpus, elem_sz);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	flags = BPF_NOEXIST | BPF_EXIST;
+	err = bpf_map__update_elem(map, key, key_sz, values, elem_sz * nr_cpus, flags);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem noexist|exist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
+	err = bpf_map__update_elem(map, key, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem all_cpus|noexist"))
+		goto out;
+
+	flags = BPF_F_CPU | BPF_NOEXIST;
+	err = bpf_map__update_elem(map, key, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem cpu|noexist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	values[0] = test_value;
+	err = bpf_map__update_elem(map, key, key_sz, values, value_sz, flags);
+	if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus|exist"))
+		goto out;
+
+	if (!verify_map_value_all_cpus(map_fd, key, values, elem_sz, test_value, nr_cpus))
+		goto out;
+
+	flags = BPF_F_CPU | BPF_EXIST;
+	values[0] = --test_value;
+	err = bpf_map__update_elem(map, key, key_sz, values, value_sz, flags);
+	if (!ASSERT_OK(err, "bpf_map__update_elem cpu|exist"))
+		goto out;
+
+	verify_map_value_first_cpu(map_fd, key, values, elem_sz, test_value, nr_cpus);
+out:
+	free(values);
+}
+
 static void test_percpu_cgroup_storage_cpu_flag(void)
 {
 	struct percpu_alloc_array *skel = NULL;
@@ -489,6 +578,7 @@ static void test_percpu_cgroup_storage_cpu_flag(void)
 		goto out;
 
 	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, nr_cpus, false);
+	test_percpu_cgroup_storage_flags_combination(map, nr_cpus, &key);
 out:
 	bpf_prog_detach2(-1, cgroup, BPF_CGROUP_INET_EGRESS);
 	close(cgroup);
@@ -537,6 +627,164 @@ static void test_hash_cpu_flag(void)
 	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
 }
 
+static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
+{
+	u32 max_entries = 3, key = 0, first_value = 0xAABBCCDD, test_value = first_value;
+	size_t value_sz = sizeof(u32), elem_sz;
+	int err, map_fd, nr_cpus;
+	bool is_hash_map;
+	u32 *values;
+	u64 flags;
+
+	is_hash_map = (map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		       map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	elem_sz = roundup(value_sz, 8);
+	values = calloc(nr_cpus, elem_sz);
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
+	values[0] = test_value;
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|noexist"))
+			goto out;
+
+		if (!verify_map_value_all_cpus(map_fd, &key, values, elem_sz, test_value, nr_cpus))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &key, values, flags);
+	}
+	if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
+		goto out;
+
+	flags = BPF_F_CPU | BPF_NOEXIST;
+	values[0] = --test_value;
+	key = 1;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|noexist"))
+			goto out;
+
+		if (!verify_map_value_first_cpu(map_fd, &key, values, elem_sz, test_value, nr_cpus))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &key, values, flags);
+	}
+	if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem cpu|noexist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	values[0] = --test_value;
+	key = 2;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem all_cpus|exist"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|exist"))
+			goto out;
+
+		if (!verify_map_value_all_cpus(map_fd, &key, values, elem_sz, test_value, nr_cpus))
+			goto out;
+	}
+
+	flags = BPF_F_CPU | BPF_EXIST;
+	values[0] = --test_value;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (is_hash_map) {
+		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem cpu|exist"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|exist"))
+			goto out;
+
+		if (!verify_map_value_first_cpu(map_fd, &key, values, elem_sz, test_value, nr_cpus))
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
+	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|noexist"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS | BPF_EXIST;
+	err = bpf_map_update_elem(map_fd, &key, values, flags);
+	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|exist"))
+		goto out;
+
+	key = 0;
+	verify_map_value_all_cpus(map_fd, &key, values, elem_sz, first_value, nr_cpus);
+
+out:
+	close(map_fd);
+	free(values);
+}
+
+static bool pin_current_cpu(cpu_set_t *old_mask)
+{
+	cpu_set_t new_mask;
+	int err, cpu;
+
+	err = sched_getaffinity(0, sizeof(*old_mask), old_mask);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return false;
+
+	cpu = sched_getcpu();
+	if (!ASSERT_GE(cpu, 0, "sched_getcpu"))
+		return false;
+
+	CPU_ZERO(&new_mask);
+	CPU_SET(cpu, &new_mask);
+
+	err = sched_setaffinity(0, sizeof(new_mask), &new_mask);
+	return ASSERT_OK(err, "sched_setaffinity");
+}
+
+static void test_percpu_hash_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_PERCPU_HASH);
+}
+
+static void test_lru_percpu_hash_flags_combination(void)
+{
+	cpu_set_t old_mask;
+
+	if (!pin_current_cpu(&old_mask))
+		return;
+
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+
+	sched_setaffinity(0, sizeof(old_mask), &old_mask);
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
@@ -565,4 +813,10 @@ void test_percpu_alloc(void)
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

