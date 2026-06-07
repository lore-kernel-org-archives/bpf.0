Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBF32B12F
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864276; cv=none; b=Pdwefb4KWgNod30DOL+yWsTxDghNUM1O4/YxBSOXN/TvTx0i2Prs43lpCG0GCBE5o1s5DqicvBRk1DiAv4YY+giB5YqWgbGE8PJJmg5R1VhdDY34BQoJARdSfPxzvfjvhxXOKXbJSU711A+gIgSInBnx93eJkaom1DDO91qF0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864276; c=relaxed/simple;
	bh=ar5buwI+Rnc8aSp/RV9Hxp0rb+h586IiwjfQVuOelgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqeYeUB93Owwz6ysp6rYq9c80/LKXs3b2lylFc79A0kHzf8S33aIhXbIJsKM7Z0XNdlNtuL1DmdjaYz14LHFQ5WRXKkrn7MApk9b/JP6cpufvkos4E6UARE3KEE8wniNpdDCfT4o8cUD705Mo2Kk2ynv8zXzQ7+q1lFz5HFa5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Zii8qS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Zii8qS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b613a17bso34598245e9.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780864273; x=1781469073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6bv0sVY9C/5VH3Kd5C6+1bLqLfS/EiuMPnYBLG6sqM=;
        b=d0Zii8qSOEysxl11YybSgC5wmoUtn4qvw2yHs9JHG87dqW+W/jD/37AgJEHJQFA6be
         mki8vX9dcbDSqlMo22/e8OfNC5YBjPx4BBYWkBwFlcld5SBnOKEUxYOpizjedUogT5pP
         wUDUF2SQVLpz22x7OWN77X9MXdsqsMnBUeNu3bo4ns9DWGO7T0pSGP+RFQSBEe0in2tw
         8gf3vXk66xQiLWXO+IKbY62SSmMDFs3j9nKsaOong0nq803LBgl83k3qel4Xmt/Ji68W
         tov3w289LNh00Lg85DMD8gv966lo6pbf1P0lsh50aRzKh4CwviaNy7BHlWsjWrD9xu9h
         /Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864273; x=1781469073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6bv0sVY9C/5VH3Kd5C6+1bLqLfS/EiuMPnYBLG6sqM=;
        b=EdTM9FwespstLIqLSq1X7CYnQ2hB7TEW5BLcfF2bo5Gyi6V4dhajvxd6drTuD2kK3o
         6Z61A1FEcW2vuIU5GF/HCvGDXKgN+5fdUoizH8c4qZqcuUewEiOCivoGcWviX4WbF+gr
         9If368App3RfrH9EenEG8HneURfX/3qqvlQ9XWmV+CGHjgKvTgCE8Q/Kk2edpROGBVXJ
         +HSFlV+EVAGx0mCpI2ZoXW1wUlQxlfgRfObRdfa/JrX4V1gYy0xW19gAyM9YSdSp4lQO
         S7vnb4AVIxgasT6uhQQyZ2faN32Rmynu3lhZBc23DmjKENw52Vjo8FtcJdksCkMnglJq
         yr9Q==
X-Gm-Message-State: AOJu0Yxw2Dc9vLQWkTOk80UJ6EB/oEwK5GNkQjGGIPnyCOWbmA/dHrmc
	vQVj6UUByQJXeYtlQT+JmFt84RXQfxBQbdwHwC6d5ZSXPQlbrqawr5UC
X-Gm-Gg: Acq92OF4xZCz/sNj1lHHA+GQlSLFyczLeBJAM2nxSQaLwY2QghtNWNqMXv747Kdnlnl
	xJ+anLxJNyqD42qjavelSB7pOamsXT11qbztymeMqanLlZDbymJyhq+YdEiWJpjdOdwKXCW0XA1
	XWbaEDbvNTdDYz8RIqEGecZkQLNBOXouhgd3Tbc94OyN1PksV3vY6FhTHK9ReR4NnnyqJDQkm3A
	aOutrEgb3Wc5xW7sExQmPabNop/cJqEd0LB9NLNlmwqGek55s1DeHVnlsScHX3q2r0mfqSYPf/1
	9i9OV/5SZBysW/RHrH2wYv6D9E/EljWWHIh7kgGddE4rJ34BJwKhAmQM7LBG366ObaUbCc4ZVes
	ASNpc6GOdW9pIOH2dW61HmMsj+0hOeaBgez/Wl3vwrp2xPklKG+x77XRajIKdJhe5G58MPCETDa
	teSgT8nNco3honmV/amumYoA8=
X-Received: by 2002:a05:600c:4e43:b0:490:b9c3:6c69 with SMTP id 5b1f17b1804b1-490c2622cf7mr211015275e9.30.1780864272586;
        Sun, 07 Jun 2026 13:31:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm49900538f8f.23.2026.06.07.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:31:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Sun, 07 Jun 2026 13:30:43 -0700
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Stress LRU rqspinlock
 recovery paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-lru_map_spin-v3-3-bcd9332e911b@meta.com>
References: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
In-Reply-To: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780864266; l=8787;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Kg21Y4yWnVDcmfDjxuxGakBq73qjGd/Vx0MdCXJIwow=;
 b=QJAO5GvbAGCrewkNi7gETe3jWVBj25o7hG6v/B/JZ6p/3ZTdGD1oUgyEJOn5CZ1/cEQfzmo/z
 s0SRP41QoJZD0wvGhAAvZUiYwUut7PYKGa/TEW0Mb5XsVChuCMQoZ/z
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduces stress test for bpf_lru_list that exercises
lock-failures and orphan-recovery, added by the LRU rqspinlock
conversion.

Runs three subtests: common LRU, per-CPU LRU lists (BPF_F_NO_COMMON_LRU),
and per-CPU LRU map. Each pins one userspace hammer per CPU and attaches
the perf_event NMI BPF prog (update+delete mix) on every online CPU.
Pre-fix, lockdep fires the "INITIAL USE -> IN-NMI" splat during stress.

After stress test, drain_then_verify_capacity() drains every key
and refills the lru map.
A stranded node on any CPU's pool would have forced eviction of
a just-inserted key on that CPU, surfacing here as a missing lookup.

Marked serial_ because per-CPU pinning and high-rate HW perf events
would perturb parallel tests.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        | 243 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |  33 +++
 2 files changed, 276 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c b/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
new file mode 100644
index 000000000000..60666a9ba41f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stress every LRU lock-failure and orphan-recovery.
+ * perf_event NMI BPF on every online CPU does
+ * update+delete on a small LRU map; userspace threads on every CPU do
+ * the same from syscall context.
+ */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/syscall.h>
+#include <linux/perf_event.h>
+#include <test_progs.h>
+#include "testing_helpers.h"
+#include "lru_lock_nmi.skel.h"
+
+#define MAP_ENTRIES	64
+#define KEY_RANGE	(MAP_ENTRIES * 2)
+#define STRESS_NS	(500 * 1000 * 1000ULL)
+
+struct hammer_arg {
+	int map_fd;
+	int cpu;
+	__u64 deadline_ns;
+};
+
+struct refill_arg {
+	int map_fd;
+	int cpu;
+	int per_cpu_quota;
+	int update_errors;
+};
+
+/*
+ * Pin the calling thread to @cpu. Uses dynamically-allocated CPU sets so
+ * we stay correct on hosts with @cpu >= CPU_SETSIZE (default 1024).
+ */
+static int pin_to_cpu(int cpu)
+{
+	cpu_set_t *cs;
+	size_t cs_size;
+	int err;
+
+	cs = CPU_ALLOC(cpu + 1);
+	if (!cs)
+		return -ENOMEM;
+	cs_size = CPU_ALLOC_SIZE(cpu + 1);
+
+	CPU_ZERO_S(cs_size, cs);
+	CPU_SET_S(cpu, cs_size, cs);
+	err = pthread_setaffinity_np(pthread_self(), cs_size, cs);
+	CPU_FREE(cs);
+	return err;
+}
+
+static void *hammer_thread(void *p)
+{
+	struct hammer_arg *a = p;
+	int nr_possible_cpus = libbpf_num_possible_cpus();
+	__u64 val[nr_possible_cpus];
+	unsigned int seed;
+	__u32 key;
+
+	memset(val, 0, sizeof(val));
+	pin_to_cpu(a->cpu);
+
+	seed = (unsigned int)a->cpu ^ (unsigned int)(uintptr_t)pthread_self();
+
+	while (get_time_ns() < a->deadline_ns) {
+		bool do_update = rand_r(&seed) & 1;
+
+		key = rand_r(&seed) % KEY_RANGE;
+		if (do_update)
+			bpf_map_update_elem(a->map_fd, &key, val, BPF_ANY);
+		else
+			bpf_map_delete_elem(a->map_fd, &key);
+	}
+	return NULL;
+}
+
+static void *refill_thread(void *p)
+{
+	struct refill_arg *a = p;
+	int nr_possible_cpus = libbpf_num_possible_cpus();
+	__u64 val[nr_possible_cpus];
+	__u32 start, end, key;
+
+	memset(val, 0, sizeof(val));
+	pin_to_cpu(a->cpu);
+
+	start = (__u32)a->cpu * (__u32)a->per_cpu_quota;
+	end   = start + (__u32)a->per_cpu_quota;
+	for (key = start; key < end; key++)
+		if (bpf_map_update_elem(a->map_fd, &key, val, BPF_ANY))
+			a->update_errors++;
+	return NULL;
+}
+
+/*
+ * Drain the map, then refill it with each CPU inserting only its own
+ * quota of keys.
+ * After refill, lookup every key we inserted - a stranded node on any
+ * CPU's pool would have forced eviction.
+ */
+static int drain_then_verify_capacity(int map_fd, int nr_cpus)
+{
+	int per_cpu_quota = MAP_ENTRIES / nr_cpus;
+	int total = per_cpu_quota * nr_cpus;
+	int nr_possible_cpus = libbpf_num_possible_cpus();
+	pthread_t threads[nr_cpus];
+	struct refill_arg args[nr_cpus];
+	__u64 val[nr_possible_cpus];
+	int i, hits = 0, nthreads = 0;
+	__u32 key;
+
+	memset(val, 0, sizeof(val));
+
+	for (key = 0; key < KEY_RANGE; key++)
+		bpf_map_delete_elem(map_fd, &key);
+
+	for (i = 0; i < nr_cpus; i++) {
+		args[i] = (struct refill_arg){
+			.map_fd = map_fd,
+			.cpu = i,
+			.per_cpu_quota = per_cpu_quota,
+		};
+		if (pthread_create(&threads[nthreads], NULL, refill_thread, &args[i]) == 0)
+			nthreads++;
+	}
+	for (i = 0; i < nthreads; i++)
+		pthread_join(threads[i], NULL);
+
+	for (i = 0; i < nr_cpus; i++)
+		if (args[i].update_errors)
+			return -ENOMEM;
+
+	for (key = 0; key < (__u32)total; key++)
+		if (bpf_map_lookup_elem(map_fd, &key, val) == 0)
+			hits++;
+
+	return hits == total ? 0 : -EIO;
+}
+
+static void run_variant(enum bpf_map_type type, __u32 map_flags, const char *name)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+	};
+	int nr_cpus, max_cpus = 64;
+	struct bpf_link *links[max_cpus];
+	pthread_t threads[max_cpus];
+	struct hammer_arg args[max_cpus];
+	struct lru_lock_nmi *skel = NULL;
+	int map_fd, i, err, nr_threads = 0, pmu_fd = -1;
+	__u64 deadline;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "num_cpus"))
+		return;
+
+	if (nr_cpus > max_cpus)
+		nr_cpus = max_cpus;
+
+	if (!test__start_subtest(name))
+		return;
+
+	memset(links, 0, sizeof(links));
+	skel = lru_lock_nmi__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	err = bpf_map__set_type(skel->maps.lru_map, type);
+	if (!ASSERT_OK(err, "set_type"))
+		goto cleanup;
+	err = bpf_map__set_map_flags(skel->maps.lru_map, map_flags);
+	if (!ASSERT_OK(err, "set_flags"))
+		goto cleanup;
+	err = bpf_map__set_max_entries(skel->maps.lru_map, MAP_ENTRIES);
+	if (!ASSERT_OK(err, "set_max_entries"))
+		goto cleanup;
+
+	err = lru_lock_nmi__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->hits = 0;
+	map_fd = bpf_map__fd(skel->maps.lru_map);
+	attr.sample_freq = read_perf_max_sample_freq();
+
+	for (i = 0; i < nr_cpus; i++) {
+		pmu_fd = syscall(__NR_perf_event_open, &attr, -1, i, -1, 0);
+		if (pmu_fd < 0) {
+			if (i == 0 &&
+			    (errno == ENOENT || errno == EOPNOTSUPP)) {
+				test__skip();
+				goto cleanup;
+			}
+			continue;
+		}
+		/* libbpf takes ownership of pfd on success */
+		links[i] = bpf_program__attach_perf_event(skel->progs.oncpu, pmu_fd);
+		if (!links[i])
+			close(pmu_fd);
+	}
+
+	deadline = get_time_ns() + STRESS_NS;
+	for (i = 0; i < nr_cpus; i++) {
+		args[i].map_fd = map_fd;
+		args[i].cpu = i;
+		args[i].deadline_ns = deadline;
+		if (pthread_create(&threads[nr_threads], NULL, hammer_thread, &args[i]) == 0)
+			nr_threads++;
+	}
+	for (i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (links[i]) {
+			bpf_link__destroy(links[i]);
+			links[i] = NULL;
+		}
+	}
+
+	ASSERT_GT(skel->bss->hits, 0, "nmi_bpf_ran");
+	ASSERT_OK(drain_then_verify_capacity(map_fd, nr_cpus), "drain_then_verify_capacity");
+
+cleanup:
+	for (i = 0; i < nr_cpus; i++) {
+		if (links[i])
+			bpf_link__destroy(links[i]);
+	}
+	lru_lock_nmi__destroy(skel);
+}
+
+void serial_test_lru_lock_nmi(void)
+{
+	run_variant(BPF_MAP_TYPE_LRU_HASH, 0, "common_lru");
+	run_variant(BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU, "no_common_lru");
+	run_variant(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0, "percpu_lru");
+}
diff --git a/tools/testing/selftests/bpf/progs/lru_lock_nmi.c b/tools/testing/selftests/bpf/progs/lru_lock_nmi.c
new file mode 100644
index 000000000000..c0692cd54237
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lru_lock_nmi.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u64);
+} lru_map SEC(".maps");
+
+int hits;
+
+SEC("perf_event")
+int oncpu(void *ctx)
+{
+	/*
+	 * Key range deliberately wider than max_entries to force LRU
+	 * eviction on every other update.
+	 */
+	__u32 key = bpf_get_prandom_u32() % 128;
+	bool do_update = bpf_get_prandom_u32() & 1;
+	__u64 val = 1;
+
+	if (do_update)
+		bpf_map_update_elem(&lru_map, &key, &val, BPF_ANY);
+	else
+		bpf_map_delete_elem(&lru_map, &key);
+	__sync_fetch_and_add(&hits, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0-Meta

