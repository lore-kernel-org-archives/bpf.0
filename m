Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267943E9CE
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512960; cv=none; b=gecYvslrmgX/2q/F8V8khzABoPn3McUUg46PtMglpa3o+FoZHJCkj/OgxZmNu9O30zWs2HTu2VUlyGW1yYNabGTzfeGs+TDbMTljfZP2uxcPZwwxHdxfBZwuOscYAZ1lPDMtj5fMGLHB34j22fr1rJyAO4zbfn9zLmM73cf3Xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512960; c=relaxed/simple;
	bh=ar5buwI+Rnc8aSp/RV9Hxp0rb+h586IiwjfQVuOelgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rv7lghMiYL9jKDyBoURvZBmi07FPcFQmhEs0zDIIxtEtYtB5w2m5fySR8Xrgv2To9WhNfEHyU+TJT7S7Wh7K4JM26x4mBy3ABqSQo1XULWEtfzoE5PodvBPg/bWGGeRuKeBnHeK0jiY7UCJR2Ma+ajck4vN1x/0R1AEepVUzP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+aHWGk+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+aHWGk+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so19817985e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512957; x=1781117757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6bv0sVY9C/5VH3Kd5C6+1bLqLfS/EiuMPnYBLG6sqM=;
        b=T+aHWGk+mYkR4M6Vzc9l4zPX8MLS8QHnbO3TvkOlgzRnIwJpL4qI9KRC1cMGRM981G
         7XP5RyS8Q9dB+4Txhl1CA+SYWanqrqmTxbxHkmf37h+rNwzadlnZDF3b+4hJARsKXhBY
         3S8/hClQ6eMHkE335aGNfJvQkD0DmftR0L1nJ0gqus/dlJ7TADFw/bTMTyMYjBt3LebC
         OhAw8TEl7fK4U7QDin+mYi0djAJDCK5HZE+FukjDgPveAXIe/KPTXhoPFZzRTbeLTO8N
         nus2mPa+IaXZ0H7m8euo2i3s5dNnXpaX2iC5obohHZ0gNl2TcyCd/FRWipPy0zP2sKRW
         N3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512957; x=1781117757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6bv0sVY9C/5VH3Kd5C6+1bLqLfS/EiuMPnYBLG6sqM=;
        b=hheBL1q4vzEJ3iUBUcStsfALglWJeG6ccVDRhtk3ag8Tx5ZfrvzZhYkt6vfV3SsD7I
         toyNS+VH9kLM8gOKA4uRwnCOCGVkQnOJf7A74celtx91f9nLGtsFW85u2EcucbWjEwQq
         e8O6JzytWP11ksPOhwknE8Q6Sdy9HljK6jtScMI7u0fuPt1q9IbUCdsagsratpLazTez
         lcChTq7gfEPwrfeORw68L/dljgXUoDDSCKWlkt0kBgKFJFPiHTKZhKpM2BYH/i4sa9xl
         /nIpoAq70MAvyEDEf79tJ0WtuOuORVdXoOz7l4i8HXEV5bdJ2cjQI3+1e2d91i1ZfOCk
         +buQ==
X-Gm-Message-State: AOJu0YzLEocWvdl8WaCbXzfHdVPesXDI7Kq7V5heXyz9I0r7rNMtvBm4
	0EwKj+gx/E4ndGn5N/zQqEvQMQzFIf08VyrGPcJEjYQ7gdevLhF0O5b5
X-Gm-Gg: Acq92OEd2YUfRDr8BuyVjsTVTKMHAhQ1EyosH4ZQq8eSC3fxE4BF6xjoMDsf/BSFbSZ
	NhIxLH2xl9dzq+kK4HVRphVLf24hzHVjpqFBvtU85S2mdAbY9H9juWcNFhEzWSCHIzE1iwzFm2C
	tXpeqygsk5uAnBtzs4BL3yBiamSHXaUnaEIoY+WV9S869h6OysFy6qnDnoMjyVsONE1b2nYzC0w
	/bcJiLwiRl/LeNstBuEPpxz2EA/CqVqEvHH99OKxOdiDDMHhpKetNHi4sWXBnaDraC77DLKhoqP
	B8PNQBVvC13L/AMCSkgy1QhB/CEOFcbwtbhrZBvlQYUgvQMV99VIRJIfhmVFmHUPSaQ6Od7f7CC
	Qtw3T5JjvZXwzb8PZj3/rLWgcbEFRI+F10+9BAT4AiqK3YE/VU7vi/bDB7LPMAjHJ/IJWJlWEtO
	OCixqG/TfHrNWPHWtq7oCBa9wU
X-Received: by 2002:a05:600c:348f:b0:490:b0df:9ea8 with SMTP id 5b1f17b1804b1-490b5d1cf6fmr77353655e9.1.1780512956977;
        Wed, 03 Jun 2026 11:55:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm9982948f8f.13.2026.06.03.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:55:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 03 Jun 2026 11:55:27 -0700
Subject: [PATCH RFC bpf-next v2 3/3] selftests/bpf: Stress LRU rqspinlock
 recovery paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-lru_map_spin-v2-3-7060cfb6cdac@meta.com>
References: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
In-Reply-To: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780512951; l=8787;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Kg21Y4yWnVDcmfDjxuxGakBq73qjGd/Vx0MdCXJIwow=;
 b=KQux6KjbArmvESSH943qp56Ye9yMtfmhXNHiokTtQ0+u+yRKOv9yohpFk+KzH5jaPu89OXw4k
 g8bdoBTAVekBb/CLkpvb/CXFRYhKqj1pZQEM3Mt0ln4EC1PxAcZJPAD
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

