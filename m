Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53486341;
	Fri, 28 Aug 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942081; cv=none; b=WuRl580aYHq3hKaD91ySwCv1i2A9Fv3jr+GxXiynZVFXUOKDqhrF+vhhWNIqPR+hgdrG5lsAqES9IILxRnAc8s5KzFZ+o9Dm86fJU0TFHZWqmokFQCTASlv9EJPdOEYQHhmd4ANIQfF7CeH6uwGbxqoptDh9am0OGpZOUXy95uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942081; c=relaxed/simple;
	bh=vIPjKAdwMfSUiKAjp4C+U1M0lh8YoHSMDCUmTVcWsXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8emFIK+p16iOorZDDXMG0D9ZNay8HyqyUsAHWY9BGKSOFQbil67+QUl9asxGVnD9ec7fnyZ0jgRcx1UaFmNzH+tHEL0+eH6H08HFuqvZQe1C/ajBpTx/FhZ/If7Hv/e4V4tJF/vnmfii8FaWlKQO/vRu9UIFeRFWGHphmzJ2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GOrlcXWi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GOrlcXWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6n
	J1MLUy6GQPMfnh+/K+cFYlShYGwMlsA1Nyhiw2HIs=; b=GOrlcXWiFgPcowwNCe
	WXFf6Jcba4E1dLUwFEDFV20vKDFw+hTXEapuhEcHWdnSImyUpqcAvUlj6dkTagsi
	XeQICrYgUnzlmDt7S0BTY1usvMvCGOxXkQjIk1wpIvVanTGKDuCNonQSxr9Evtxx
	pXT4mB3yrngKO3L+jdzkYjq9c=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHGv181JFq5gKAQA--.3230S2;
	Sat, 29 Aug 2026 02:33:33 +0800 (CST)
From: Hui Su <sh_def@163.com>
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
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: add RHASH iteration stress test
Date: Sat, 29 Aug 2026 02:33:26 +0800
Message-ID: <20260828183326.3330530-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828183326.3330530-1-sh_def@163.com>
References: <20260828183326.3330530-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHGv181JFq5gKAQA--.3230S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1UCrWkCrWfGw1ktry7Jrb_yoW7KF4rpF
	W0v342kr4rXF47Jw4xG3yjgrZ8Krs5Zw15GrWkK3yayw17Kwn2qr1xKF48tFn3ZrZ8Zrya
	9w43KrWrCrWrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI2NNUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwh1TsmqR1H1zhAAA3b

Add a stress test for bpf_for_each_map_elem() on
BPF_MAP_TYPE_RHASH. Update and delete entries from two threads while
repeatedly running the BPF callback, and record the maximum number of
callback invocations in one walk.

Concurrent rehashing may cause duplicate visits, which are permitted by
RHASH's best-effort iteration semantics. Verify that
bpf_for_each_map_elem() nevertheless limits one walk to at most
map->max_entries callback invocations.

Signed-off-by: Hui Su <sh_def@163.com>
---
 .../testing/selftests/bpf/prog_tests/rhash.c  | 97 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c     | 36 +++++++
 2 files changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 98bb66907b7f..a2ecd7e7905f 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -3,12 +3,17 @@
 #include <test_progs.h>
 #include <string.h>
 #include <stdio.h>
+#include <pthread.h>
+#include <stdatomic.h>
 #include "rhash.skel.h"
 #include "bpf_iter_bpf_rhash_map.skel.h"
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
 
+#define RHASH_STRESS_KEYS		4096
+#define RHASH_STRESS_DURATION_NS	(3ULL * 1000000000ULL)
+
 static void rhash_run(const char *prog_name)
 {
 	struct rhash *skel;
@@ -53,6 +58,94 @@ static int rhash_map_create(__u32 max_entries, __u64 map_extra)
 			      sizeof(__u32), sizeof(__u64), max_entries, &opts);
 }
 
+struct rhash_stress_arg {
+	int map_fd;
+	atomic_bool *stop;
+	__u32 seed;
+};
+
+static void *rhash_stress_update(void *data)
+{
+	struct rhash_stress_arg *arg = data;
+	__u64 value = 0;
+	__u32 key;
+	int i;
+
+	while (!atomic_load(arg->stop)) {
+		for (i = 0; i < RHASH_STRESS_KEYS && !atomic_load(arg->stop); i++) {
+			key = ((__u32)i * 2654435761U + arg->seed) % RHASH_STRESS_KEYS;
+			bpf_map_update_elem(arg->map_fd, &key, &value, BPF_ANY);
+		}
+		for (i = 0; i < RHASH_STRESS_KEYS && !atomic_load(arg->stop); i++) {
+			key = ((__u32)i * 2654435761U + arg->seed) % RHASH_STRESS_KEYS;
+			bpf_map_delete_elem(arg->map_fd, &key);
+		}
+	}
+
+	return NULL;
+}
+
+static void rhash_iter_stress(void)
+{
+	struct rhash *skel = NULL;
+	struct rhash_stress_arg args[2];
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	atomic_bool stop = false;
+	__u64 start;
+	__u32 max_entries;
+	pthread_t threads[2];
+	bool created[2] = {};
+	struct bpf_program *prog;
+	int map_fd, err, i;
+
+	skel = rhash__open();
+	if (!ASSERT_OK_PTR(skel, "rhash__open stress"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj,
+						"test_rhash_iter_stress");
+	if (!ASSERT_OK_PTR(prog, "find stress program"))
+		goto cleanup;
+	bpf_program__set_autoload(prog, true);
+
+	err = rhash__load(skel);
+	if (!ASSERT_OK(err, "stress skel_load"))
+		goto cleanup;
+
+	map_fd = bpf_map__fd(skel->maps.stress_rhmap);
+	max_entries = bpf_map__max_entries(skel->maps.stress_rhmap);
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		args[i].map_fd = map_fd;
+		args[i].stop = &stop;
+		args[i].seed = i * 977;
+		err = pthread_create(&threads[i], NULL, rhash_stress_update,
+				     &args[i]);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto stop_threads;
+		created[i] = true;
+	}
+
+	start = get_time_ns();
+	while (get_time_ns() - start < RHASH_STRESS_DURATION_NS) {
+		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+		if (!ASSERT_OK(err, "stress prog run"))
+			break;
+	}
+
+stop_threads:
+	atomic_store(&stop, true);
+	for (i = 0; i < ARRAY_SIZE(threads); i++)
+		if (created[i])
+			pthread_join(threads[i], NULL);
+
+	ASSERT_GT(skel->bss->stress_max_visits, 0, "stress callback visits");
+	ASSERT_EQ(skel->bss->stress_overruns, 0, "stress callback bound");
+	printf("stress max callback visits: %llu (limit %u)\n",
+	       (unsigned long long)skel->bss->stress_max_visits, max_entries);
+cleanup:
+	rhash__destroy(skel);
+}
+
 static void rhash_map_extra_presize(void)
 {
 	const __u32 max_entries = 1024;
@@ -180,4 +273,8 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_iter"))
 		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_iter_stress"))
+		rhash_iter_stress();
+
 }
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index fc2dac3a719e..eca428db1fbc 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -9,11 +9,15 @@
 
 #define ENOENT 2
 #define EEXIST 17
+#define RHASH_STRESS_MAX_ENTRIES 4096
 
 char _license[] SEC("license") = "GPL";
 
 int err;
 
+volatile __u64 stress_max_visits;
+volatile __u64 stress_overruns;
+
 struct elem {
 	char arr[128];
 	int val;
@@ -27,6 +31,20 @@ struct {
 	__type(value, struct elem);
 } rhmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, RHASH_STRESS_MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} stress_rhmap SEC(".maps");
+
+static __u64 stress_iter_cb(struct bpf_map *map, __u32 *key, __u64 *val,
+			    void *ctx)
+{
+	return 0;
+}
+
 SEC("syscall")
 int test_rhash_lookup_update(void *ctx)
 {
@@ -246,3 +264,21 @@ int test_rhash_delete_nonexistent(void *ctx)
 	err = 0;
 	return 0;
 }
+
+SEC("syscall")
+int test_rhash_iter_stress(void *ctx)
+{
+	/*
+	 * Concurrent rehash may produce duplicate visits. Check that the
+	 * helper still gives one walk a finite callback bound; no snapshot
+	 * or unique-visit guarantee is expected here.
+	 */
+	long visits;
+
+	visits = bpf_for_each_map_elem(&stress_rhmap, stress_iter_cb, NULL, 0);
+	if (visits > stress_max_visits)
+		stress_max_visits = visits;
+	if (visits > RHASH_STRESS_MAX_ENTRIES)
+		stress_overruns++;
+	return 0;
+}
-- 
2.54.0

