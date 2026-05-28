Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619A40800B
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992146; cv=none; b=ICTcvlcIi2yNUKvDD8hOWvkiHIrPBLZpPfuujHoumlxEPPuiA5XIbhVV5KP60YdIGimxXWrZYMJoacUT/6hNDWVxQwrvyznJOkNeNV4KDZK7CWnMcmHtspo7N9kTMlzyqfUKOtSa7a04C2oIfHHHZ+5XhrQnRx343QRUS7Ynz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992146; c=relaxed/simple;
	bh=xQPcVpxK35717u5GI9UkWfCzinJeminl9hKlV4j2pZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFHjS77zT00veiPfrcLYNEHx9eD6eLkUOw7hI4M2qVxA4a1gCixeovihg+mNEeu3bxQZYU7ztdkfubRVYVnXg9C3ZMO7e8zQBnoh6OX7vBT4i+xEvE3zO3fbofJmA3JiMDnkOO+1lcUXaS0P8BqAjHiucwbfiRtrJ6RhG/toz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b40oilNT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b40oilNT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso51029435e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992143; x=1780596943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRvnZKZO84uvupr78bIT+wZQq6XSqIm1dx7+8pLCUO0=;
        b=b40oilNTZ2KGVhad65ZQUU5QmyBdcdA2pF6cuqCUUWCG8uzU64WBV5AHr80Q0rwd3h
         YU/HCRHQ3HLi+nY8uAEsFzoxstndBachT/sgR7KA4Qn70bPtskEJyxS1qdBJ7kxXksZn
         7RpQUplBUxU1k+OTAur7VqJ1gqbG0WdzkSBmH+i9jC+cLD2h9Z1tls2xRbCz0XebcVbP
         CpQOzNQaKrf/jjiGGlmc92xfJljIkB+VTx/OUvPYRzM3F62cFhw6OEf20bcmqeoqylu7
         seIbZnWRnD03jgf9YpJ/o6HPw7iw2wcipgXZSWg7DqqNbJoIU31rN11A1gb8VKAtsOx5
         ELsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992143; x=1780596943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRvnZKZO84uvupr78bIT+wZQq6XSqIm1dx7+8pLCUO0=;
        b=buUis+g1n2oMLIZOOcbh01fHi4S9haUL8YIu7bJuXLYcT4w1e9v23mKnjb7srJPEUW
         NL2rX0ayqZCtB/3lB4Ckk1TvyhLJ2t0ocyNlIQHCqo3H4iRdqAngTUcBxw1JWg4NEVYn
         XorDdXf54yyWng6Kkz5E4pHJuO3ojz3/MqeXd0naMR3q29ftWQlPxuTZ2sriLmRbWBkb
         g7gRo465lUBM0b3g7CxWhmLCuxv9qz3+z682KYBNJJfptHt1i0TKUU0h7ru5FJKeUGfy
         jFomXSeB1eQ9KtvobA4q2oRK+HXWkSPVIzuJaP5QYP0Fo5PSyCGMR81mU4mHUhct/uQT
         yqIA==
X-Gm-Message-State: AOJu0YxK1isuAqg81jL6d51/vqCMfojlJQd2fSsIPmz+Wb+n5r57ET3v
	Wa9WclyaPiQidYA/54omEnT9Ly/ll9mhZWGXCwJ11QcoMG8YZy0rXad0Mphpz2uD
X-Gm-Gg: Acq92OE3iYGu8ZPyzSPH4nGpZn4/n6+BHGhspHjPTKGeuMCyT2PQvwdCRMbF/FFSSWS
	yHBPS4Iq3uYhq/YFCJMGkMUAR5Wro6IYzePbgPGchx3fijA15RKoYHeZ3H3vjWseTIPtlClSSBo
	OIKODFiyF+AtaHcXsZQ8ZRRKOo/VVDPR/uDCRRlWUBfftcedqspXlYCjVSGb7Ovq6xW1+sb6kF0
	Akqo4bAPGcEcNVQALSUsIa8j98o0gXyuuQcOdGjT6LSvTdJz6ayTLSVqgNabUTTIwIYgaWb/Amq
	GYuWAXUoFMr6cZETL8vD1slqWrRbmamKMK4xN4PZMlecK6CMU2m4JwdC1BazSBJGDEnyh4dVfQu
	9ncFOHV5DufiWZhMPyVNIPkFjWLJlUw/byN0uwRz9VCurJol0aD6GtE+bry/jTpHFjAzty+WM4e
	6vSFCHGHiRQFWxH1culX2jmgSE
X-Received: by 2002:a05:600c:354f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-4906e11c4b1mr262033235e9.13.1779992142554;
        Thu, 28 May 2026 11:15:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909298d41bsm54167975e9.11.2026.05.28.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 11:13:26 -0700
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: Stress LRU rqspinlock
 recovery paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-lru_map_spin-v1-3-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
In-Reply-To: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779992135; l=8600;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=wWgihGjz6uAJN2fAYBZvC0DfZ9G+TV0fIsm+hnDSbqw=;
 b=DU47v2czSTjOLaOJbY7KgoSl2Ld3JlhXlnRIQ8Nw3O/TxKsL9TNHUE3xuibxpqOYiNHJXn4G6
 vnSNhWkfO8zBohM+YXndc8utQAKQjcPX+wKwklH3dR1mBJPOn6tC6+3
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replaces the single-CPU NMI re-entry reproducer with a parameterized
stress harness that exercises every lock-failure and orphan-recovery
branch added by the LRU rqspinlock conversion: per-CPU loc_l->lock
NMI re-entry, cross-CPU steal contention, post-steal local lock fail
with free_llist recovery, and pending_free reclaim via flush,
shrink_inactive, and the new __local_list_pop_pending path.

Runs three subtests: common LRU, per-CPU LRU lists (BPF_F_NO_COMMON_LRU),
and per-CPU LRU map. Each pins one userspace hammer per CPU and attaches
the perf_event NMI BPF prog (update+delete mix) on every online CPU.
Pre-fix, lockdep fires the "INITIAL USE -> IN-NMI" splat during stress.

Post-stress, the test drains all keys and refills max_entries fresh
slots with bounded retries on -ENOMEM. A permanently stranded node
from a failed push_free recovery would surface as -ENOMEM that never
clears.

Marked serial_ because per-CPU pinning and high-rate HW perf events
would perturb parallel tests.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        | 202 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |  33 ++++
 2 files changed, 235 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c b/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
new file mode 100644
index 000000000000..15b6606fef4d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stress every LRU lock-failure and orphan-recovery branch added by the
+ * rqspinlock conversion. perf_event NMI BPF on every online CPU does
+ * update+delete on a small LRU map; userspace threads on every CPU do
+ * the same from syscall context. Exercises:
+ *
+ *   - per-CPU loc_l->lock NMI re-entry (the original syzbot deadlock)
+ *   - cross-CPU steal-loop victim lock contention
+ *   - post-steal local lock contention and free_llist recovery
+ *   - push_free lock failure and pending_free recovery via flush,
+ *     shrink_inactive, and the new __local_list_pop_pending path
+ *
+ * Runs against three map flavors:
+ *   - BPF_MAP_TYPE_LRU_HASH (common LRU)
+ *   - BPF_MAP_TYPE_LRU_HASH | BPF_F_NO_COMMON_LRU (per-CPU LRU lists,
+ *     common values)
+ *   - BPF_MAP_TYPE_LRU_PERCPU_HASH (per-CPU LRU + per-CPU values)
+ *
+ * Post-stress: every map slot must be re-allocatable, proving no node
+ * was permanently stranded by a failed push_free recovery. Transient
+ * -ENOMEM during the drain is allowed and retried.
+ *
+ * With PROVE_LOCKING enabled, the pre-fix kernel fires a lockdep splat
+ * during stress; the framework's dmesg capture surfaces it.
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
+#define KEY_RANGE	(MAP_ENTRIES * 2)	/* wider than capacity to force eviction */
+#define STRESS_NS	(500 * 1000 * 1000ULL)
+
+struct hammer_arg {
+	int map_fd;
+	int cpu;
+	int nr_cpus;
+	__u64 deadline_ns;
+};
+
+static void *hammer_thread(void *p)
+{
+	struct hammer_arg *a = p;
+	__u64 val[a->nr_cpus];
+	cpu_set_t cs;
+	__u32 key;
+
+	memset(val, 0, sizeof(val));
+	CPU_ZERO(&cs);
+	CPU_SET(a->cpu, &cs);
+	pthread_setaffinity_np(pthread_self(), sizeof(cs), &cs);
+
+	while (get_time_ns() < a->deadline_ns) {
+		bool do_update = rand() & 1;
+
+		key = rand() % KEY_RANGE;
+		if (do_update)
+			bpf_map_update_elem(a->map_fd, &key, val, BPF_ANY);
+		else
+			bpf_map_delete_elem(a->map_fd, &key);
+	}
+	return NULL;
+}
+
+/*
+ * After stress, the map must accept MAP_ENTRIES fresh allocations.
+ * A node permanently stranded by a failed push_free recovery would
+ * surface as -ENOMEM from update_elem: shrink_inactive cannot find
+ * either a pending_free=1 marker or a del_from_htab=true elem.
+ * No retry needed - by the time drain runs, NMI is detached and no
+ * userspace contention is present, so every update either pulls
+ * from FREE or evicts a previously-added entry on the same CPU.
+ */
+static int drain_and_refill(int map_fd, int nr_cpus)
+{
+	__u64 val[nr_cpus];
+	__u32 key;
+
+	memset(val, 0, sizeof(val));
+	for (key = 0; key < KEY_RANGE; key++)
+		bpf_map_delete_elem(map_fd, &key);
+
+	for (key = 0; key < MAP_ENTRIES; key++)
+		if (bpf_map_update_elem(map_fd, &key, val, BPF_ANY))
+			return -ENOMEM;
+	return 0;
+}
+
+static void run_variant(enum bpf_map_type type, __u32 map_flags,
+			const char *name)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+	};
+	int nr_cpus = libbpf_num_possible_cpus();
+	int pmu_fds[nr_cpus];
+	struct bpf_link *links[nr_cpus];
+	pthread_t threads[nr_cpus];
+	struct hammer_arg args[nr_cpus];
+	struct lru_lock_nmi *skel = NULL;
+	int map_fd, i, err, nr_threads = 0;
+	__u64 deadline;
+
+	if (!test__start_subtest(name))
+		return;
+
+	memset(pmu_fds, 0xff, sizeof(pmu_fds));	/* -1 sentinel */
+	memset(links, 0, sizeof(links));
+
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
+		pmu_fds[i] = syscall(__NR_perf_event_open, &attr, -1, i,
+				     -1, 0);
+		if (pmu_fds[i] < 0) {
+			if (i == 0 &&
+			    (errno == ENOENT || errno == EOPNOTSUPP)) {
+				test__skip();
+				goto cleanup;
+			}
+			continue;
+		}
+		links[i] = bpf_program__attach_perf_event(skel->progs.oncpu,
+							  pmu_fds[i]);
+		if (!links[i]) {
+			close(pmu_fds[i]);
+			pmu_fds[i] = -1;
+		}
+	}
+
+	deadline = get_time_ns() + STRESS_NS;
+	for (i = 0; i < nr_cpus; i++) {
+		args[i].map_fd = map_fd;
+		args[i].cpu = i;
+		args[i].nr_cpus = nr_cpus;
+		args[i].deadline_ns = deadline;
+		if (pthread_create(&threads[nr_threads], NULL, hammer_thread,
+				   &args[i]) == 0)
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
+		if (pmu_fds[i] >= 0) {
+			close(pmu_fds[i]);
+			pmu_fds[i] = -1;
+		}
+	}
+
+	ASSERT_GT(skel->bss->hits, 0, "nmi_bpf_ran");
+	ASSERT_OK(drain_and_refill(map_fd, nr_cpus), "drain_and_refill");
+
+cleanup:
+	for (i = 0; i < nr_cpus; i++) {
+		if (links[i])
+			bpf_link__destroy(links[i]);
+		if (pmu_fds[i] >= 0)
+			close(pmu_fds[i]);
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

