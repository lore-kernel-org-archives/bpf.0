Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AD483829;
	Mon, 31 Aug 2026 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184955; cv=none; b=XhFBNyYuvAqSbOXlIp8cW2q/Wo1REotFAYLRkdd+kGXr2H0iioL9s7XS2sHpLKiruJUkY6oFqwK1oIsshmTdCx4K7hGTVNUtIBs+6gy6pdhwG9ENt7HJtt1CvSzgplVy1oNFhBLp/MEo9fKHXJbsChImBoRjYgONyaKdGZtsgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184955; c=relaxed/simple;
	bh=0AaOui0ATZSYAH51kcMfhKYq5p5RUHpEf2ydKAATlVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOR2NrOD6atc/4WYfGUjpIrVXGh3EJbDG5v6GimCvOBcxzSnyAGNExSBywndZUGMQgGHx204ZrfuSMLm+cz6DRLv1da57gBWwjSNa5Rj+Sh+3BoXBSzP47rUruuD3TyE6bLSbkXLvuRTrymwUgPOi8qv8B0G7tIWS8Qe1GCXh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IXueXC7X; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IXueXC7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SU
	eQo8DwvNCB8W1/pfXYlm6GLs+D/BOTHcngtPxlKog=; b=IXueXC7XPf9lDaoyis
	VM/5osJ2h0EBzM9AqOb8P8CClxk0flnJ9YkcFqWCv8vkXBniQIwhNULhvUza9jkm
	C79T1IZKlcknvn18bcmsML2XMqW8wDSmjmubj3GCbxL1AAqR45og+OKeHLKMQEUW
	v5m72dZltI1TyP/q6ebFTWn2s=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnuBc_iZVq6U15PA--.28139S2;
	Mon, 31 Aug 2026 22:01:36 +0800 (CST)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: add RHASH iteration stress test
Date: Mon, 31 Aug 2026 22:01:32 +0800
Message-ID: <20260831140132.117755-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831140132.117755-1-sh_def@163.com>
References: <20260831140132.117755-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnuBc_iZVq6U15PA--.28139S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF1rAFWrCw15ur43Kw45Jrb_yoWxtryDpF
	W0v34akr4rXF48Jw4fK3y2grZ8Kr4rZw4UGrZ5Kw4fAw47K3sFqr1xKF4UtFn3XrWDZ34Y
	9ws3KrW8WrWrZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI2NNUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQFy0WqViUEMEQAA3J

Add a stress test for bpf_for_each_map_elem() on
BPF_MAP_TYPE_RHASH. Update and delete entries from two threads while
repeatedly running the BPF callback, and record the maximum number of
callback invocations in one walk.

Use a large map capacity and a smaller working set so the test also
covers sparse maps where max_entries greatly exceeds current occupancy.
Concurrent rehashing may cause duplicate visits, which are permitted by
RHASH's best-effort iteration semantics. Verify that
bpf_for_each_map_elem() does not exceed the working set in one walk and
that at least one walk consumes the full working-set-sized budget.

Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Use a large map capacity and a smaller BPF rodata working set.
- Skip the stress test when fewer than two CPUs are available.
- Avoid result assertions unless a program run completed successfully.
- Record full walks to make vacuous stress passes less likely.
- Use the BPF rodata working set as the single source of truth.

Link: https://lore.kernel.org/bpf/20260828183326.3330530-2-sh_def@163.com/
---
 .../testing/selftests/bpf/prog_tests/rhash.c  | 113 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c     |  41 +++++++
 2 files changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 98bb66907b7f..f1a0a8e3fc1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -3,12 +3,16 @@
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
 
+#define RHASH_STRESS_DURATION_NS	(3ULL * 1000000000ULL)
+
 static void rhash_run(const char *prog_name)
 {
 	struct rhash *skel;
@@ -53,6 +57,112 @@ static int rhash_map_create(__u32 max_entries, __u64 map_extra)
 			      sizeof(__u32), sizeof(__u64), max_entries, &opts);
 }
 
+struct rhash_stress_arg {
+	int map_fd;
+	atomic_bool *stop;
+	__u32 nr_keys;
+	__u32 seed;
+};
+
+static void *rhash_stress_update(void *data)
+{
+	struct rhash_stress_arg *arg = data;
+	__u64 value = 0;
+	__u32 key;
+	__u32 i;
+
+	while (!atomic_load(arg->stop)) {
+		for (i = 0; i < arg->nr_keys && !atomic_load(arg->stop); i++) {
+			key = ((__u32)i * 2654435761U + arg->seed) % arg->nr_keys;
+			bpf_map_update_elem(arg->map_fd, &key, &value, BPF_ANY);
+		}
+		for (i = 0; i < arg->nr_keys && !atomic_load(arg->stop); i++) {
+			key = ((__u32)i * 2654435761U + arg->seed) % arg->nr_keys;
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
+	bool ran = false;
+	__u64 start;
+	pthread_t threads[2];
+	bool created[2] = {};
+	struct bpf_program *prog;
+	int nr_cpus;
+	__u32 working_set;
+	int map_fd, err, i;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "num_possible_cpus"))
+		return;
+	if (nr_cpus < 2) {
+		test__skip();
+		return;
+	}
+
+	skel = rhash__open();
+	if (!ASSERT_OK_PTR(skel, "rhash__open stress"))
+		return;
+	working_set = skel->rodata->stress_working_set;
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
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		args[i].map_fd = map_fd;
+		args[i].stop = &stop;
+		args[i].nr_keys = working_set;
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
+			goto stop_threads;
+		ran = true;
+	}
+
+stop_threads:
+	atomic_store(&stop, true);
+	for (i = 0; i < ARRAY_SIZE(threads); i++)
+		if (created[i])
+			pthread_join(threads[i], NULL);
+
+	if (err || !ran)
+		goto cleanup;
+
+	ASSERT_GT(skel->bss->stress_max_visits, 0, "stress callback visits");
+	ASSERT_GT(skel->bss->stress_full_walks, 0, "stress full walks");
+	ASSERT_EQ(skel->bss->stress_overruns, 0, "stress callback bound");
+	printf("stress max callback visits: %llu (limit %u)\n",
+	       (unsigned long long)skel->bss->stress_max_visits,
+	       working_set);
+cleanup:
+	rhash__destroy(skel);
+}
+
 static void rhash_map_extra_presize(void)
 {
 	const __u32 max_entries = 1024;
@@ -180,4 +290,7 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_iter"))
 		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_iter_stress"))
+		rhash_iter_stress();
 }
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index fc2dac3a719e..3d7201430bab 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -9,11 +9,18 @@
 
 #define ENOENT 2
 #define EEXIST 17
+#define RHASH_STRESS_MAX_ENTRIES (1U << 20)
 
 char _license[] SEC("license") = "GPL";
 
 int err;
 
+const volatile __u32 stress_working_set = 4096;
+
+volatile __u64 stress_max_visits;
+volatile __u64 stress_overruns;
+volatile __u64 stress_full_walks;
+
 struct elem {
 	char arr[128];
 	int val;
@@ -27,6 +34,20 @@ struct {
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
@@ -246,3 +267,23 @@ int test_rhash_delete_nonexistent(void *ctx)
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
+	if (visits > stress_working_set)
+		stress_overruns++;
+	if (visits == stress_working_set)
+		stress_full_walks++;
+	return 0;
+}
-- 
2.54.0

