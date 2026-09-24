Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7F488208
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245419; cv=none; b=ThTOExjiFhQTKwCD9dRMONOTGXnaHYD97QJdvnau0Zx0Wy6H8bX5qEv4EXlfX8H//b8z3bKGB63r3L8La5Q8tfBJJEmbwTrPyOWDKkldWVzt9Gvm4ZzuSOiwmy9deDlWOe4UXNTQJixNreDVMX8aZNBjqGa7UUaNQhiMeeR59zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245419; c=relaxed/simple;
	bh=6YX6h+lVa19ibUpshe0Fzrnf6t9VpTENK7zNCAt5Y1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm7t/ivbLZV2jo3GNoSKWBD7GU4mBpeXAuDF6SxzEilww05eF1tM33lAA+ZYqViNUFbpw7Npf5z7PpqCO1HQ46CzxTjrX5pT40rq6thQayj6A4/HHP22VaPJwmwZ/5nZUK/Zc3Zp78QfRCTfLX7oEbeG3fjOkouCyWSNoQ5C4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDHCprvY; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDHCprvY"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c79fso593989a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245417; x=1790850217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfDHIscfZIaZ+G0e6fi+cyup/qsdiCf7G7ZWGqivqVU=;
        b=PDHCprvYMNfTvELc1uQm6aZk2TJdVYVP1Q6fq/5zJ0MPffMZI21DAHw7PHhYeP669u
         PA7R52RIOIe7p9evRblMmpsDCVHgBgH37/xhGtH+pNJe37mM4Mze4H5Mag2xC1Z1RlEz
         hn8KTVUWu0iK5Vvgt/6Oqf5Ut6qpQ6+MZxG2YENNXU4iFJJX24Xh+wFGImnVbBd6SgjI
         1MrGHTCG2Mj0ARHXuMZ/2ZFHeEpruBFmfe62QlqKcLSzsW7tGvR66mSH8UYWm1ri64JP
         25Tw9+z8FHZH/M5Q12Z00A5rYsEOd1PfkASy+ldswo0JxD6YDRjY35ba6olFxQqezZIn
         Pyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245417; x=1790850217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfDHIscfZIaZ+G0e6fi+cyup/qsdiCf7G7ZWGqivqVU=;
        b=DgBly+LJeQkDnzyQ2EeAo3BrMoXHJdgguaKW1tjcA9MX4EThA+RWeGh0TWR+DI0jX3
         Fb9dzE7c6/o8H27cdYoqChUCmJpUF1Jco7e0BLWycWAVPNUlHdtiHvXAIVkRN9XOzbX+
         D6AFeRYeCWlOW1xFwyKS7VWRVh7v9GJtvgSAzuSEZC4X9qqSN46rwnVEwfQ1AzNMqJ4t
         If4pLtssAddKTfysYmOCqbWPYUJS3vANjKikPir+gq3ItVDmSS3U9FZB5W3DxEQzNKjX
         PEEbyenEO/k5N4jKGhWKVBQaD7G1100gANzcXAgAFCQFoCzejB8DzcH5EKP6L/rFBuV2
         PCoQ==
X-Gm-Message-State: AFuF++miiZy4BEhExnYImUs+xe45akyzt1gIOBUhtpkWRcmfLXr291i6
	oSYGqMmMaBivDXyovFATv0bloWvDY62bK+kLUZ5ioUpso90SXK0QJGuZv7oq6m9CUw==
X-Gm-Gg: AYBFou3uoImU6CMt9xcXIR1UgFkXxwkIqO4kjBjd8NLn8dVxxbqug8s6MWHd0cfMT6e
	fCQnFczNl1NJrpS0CsijZFn0wlxdMN+Z/B6lGXfmKdIsH3sJ5jaTJVd1J9xUxMMK5Nnky+S7KgW
	sAHAC+RVCRbb3cusC+FO6vmopDut751OdRvLQi9/9Lidstf8sxUxiUQRpEIE+GfDFKcEdGvdcZq
	kClIoAcE+dWshYKaT3bj677pryidWAl8fYlYEpaPfO6TQXXGitC20tNP602fMNzOL5OtUI7E8Ge
	AykS4ZoiK/rRZaxKv0qhUy/nRPNbAjVorWB1kftCD372J/e10u9E7z7ZJEoyEySn7efQyG71Y9f
	z0Y/EblJGKdB6iBOgbn6IUKGPVz/MumL7Kc3JEuhvZVnxxOPECC8KGnrbAuy0mGAcc/KBpn0Jds
	rhRECqJr533hugJocIzJap88TMkzB8W13p0vkSYKi8FbxNUm7MxBtbKxA7+BNwck0Xinnwd+O9Z
	i8OL/P2yucTIMvaCL5vMAdj
X-Received: by 2002:a05:6a20:4394:b0:3dd:85aa:d26d with SMTP id adf61e73a8af0-3de0e7f4a52mr1881230637.37.1790245417278;
        Thu, 24 Sep 2026 03:23:37 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb9416sm2661582b3a.7.2026.09.24.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:37 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element
Date: Thu, 24 Sep 2026 19:23:21 +0900
Message-ID: <20260924102321.2120434-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
References: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing cpu_flag subtests always prime a key with BPF_F_ALL_CPUS
before any BPF_F_CPU write, so the create path is never covered.

Add a subtest that creates the element with BPF_F_CPU on a map with
max_entries 1, so the key can only reuse the element the previous key
released, and check that the CPUs the update did not name read back
zero.  Run it for PERCPU_HASH preallocated and BPF_F_NO_PREALLOC,
whose per-cpu areas come from different allocators, and for
LRU_PERCPU_HASH.

Under BPF_F_NO_PREALLOC the reuse is only guaranteed on the cpu that
ran the delete, so pin the thread across the pair, and name a cpu other
than that one in map_flags.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index a72ae0b29f6e9..7b4a1e24363b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "percpu_alloc_array.skel.h"
@@ -350,6 +352,103 @@ static void test_lru_percpu_hash_cpu_flag(void)
 	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH);
 }
 
+/*
+ * A BPF_F_CPU update that creates an element must zero the value on the other
+ * cpus, rather than leave them holding whatever the recycled element last
+ * contained. max_entries is 1 so the second key can only reuse the element
+ * the first one released.
+ */
+static void test_percpu_map_cpu_flag_create(enum bpf_map_type map_type, __u32 map_flags)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
+	const u32 stale = 0xDEADC0DE, fresh = 0xC0FFEE;
+	int nr_cpus, cpu, map_fd, err, key;
+	int pinned_cpu, value_cpu;
+	cpu_set_t old_mask, new_mask;
+	bool restore_mask = false;
+	u32 value;
+	u64 flags;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	if (nr_cpus < 2) {
+		test__skip();
+		return;
+	}
+
+	map_fd = bpf_map_create(map_type, "cpu_flag_create", sizeof(key), sizeof(value), 1, &opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	/* NO_PREALLOC recycles per cpu, so keep the delete and the create on one cpu. */
+	err = sched_getaffinity(0, sizeof(old_mask), &old_mask);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		goto out;
+
+	pinned_cpu = sched_getcpu();
+	if (!ASSERT_GE(pinned_cpu, 0, "sched_getcpu"))
+		goto out;
+
+	CPU_ZERO(&new_mask);
+	CPU_SET(pinned_cpu, &new_mask);
+	err = sched_setaffinity(0, sizeof(new_mask), &new_mask);
+	if (!ASSERT_OK(err, "sched_setaffinity"))
+		goto out;
+	restore_mask = true;
+
+	value_cpu = pinned_cpu ? 0 : 1;
+
+	key = 1;
+	value = stale;
+	err = bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS);
+	if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus"))
+		goto out;
+
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
+		goto out;
+
+	key = 2;
+	value = fresh;
+	flags = (u64)value_cpu << 32 | BPF_F_CPU;
+	err = bpf_map_update_elem(map_fd, &key, &value, flags);
+	if (!ASSERT_OK(err, "bpf_map_update_elem specified cpu"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		value = 0;
+		flags = (u64)cpu << 32 | BPF_F_CPU;
+		err = bpf_map_lookup_elem_flags(map_fd, &key, &value, flags);
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags specified cpu"))
+			goto out;
+		if (!ASSERT_EQ(value, cpu == value_cpu ? fresh : 0, "value on specified cpu"))
+			goto out;
+	}
+
+out:
+	if (restore_mask)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+	close(map_fd);
+}
+
+static void test_percpu_hash_cpu_flag_create(void)
+{
+	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_PERCPU_HASH, 0);
+}
+
+static void test_percpu_hash_cpu_flag_create_malloc(void)
+{
+	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC);
+}
+
+static void test_lru_percpu_hash_cpu_flag_create(void)
+{
+	/* lru without prealloc is -ENOTSUPP, so there is no malloc variant */
+	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
+}
+
 static void test_percpu_cgroup_storage_cpu_flag(void)
 {
 	struct percpu_alloc_array *skel = NULL;
@@ -454,6 +553,12 @@ void test_percpu_alloc(void)
 		test_percpu_hash_cpu_flag();
 	if (test__start_subtest("cpu_flag_lru_percpu_hash"))
 		test_lru_percpu_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_create_percpu_hash"))
+		test_percpu_hash_cpu_flag_create();
+	if (test__start_subtest("cpu_flag_create_percpu_hash_malloc"))
+		test_percpu_hash_cpu_flag_create_malloc();
+	if (test__start_subtest("cpu_flag_create_lru_percpu_hash"))
+		test_lru_percpu_hash_cpu_flag_create();
 	if (test__start_subtest("cpu_flag_percpu_cgroup_storage"))
 		test_percpu_cgroup_storage_cpu_flag();
 	if (test__start_subtest("cpu_flag_array"))
-- 
2.53.0

