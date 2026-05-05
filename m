Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8E48095C
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993750; cv=none; b=gpawhgmTVfqvdb4tiuY3ZGWufu7S2PoP9tbFoyt4mQxNbZPkwePEkfeb6yrN0wHuYom1hqd5hSKdGn47jesxi8gx/DYP9CA2mXq38kokR9oxTy7E0jbCHC7B4Qoit/cSRvsM4bvMPVvyrAm/wtzYKjVnqrWl4KVdhlRPgwt/GC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993750; c=relaxed/simple;
	bh=nvRlXk0SxEJ5nwLxY/r/87+3eNg5N/zIFZ+y6YU4oQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDbN+TLOW2K6QdyEEvAtgZCtRX4eEZR63n95PKF6I8cpRrGS9u6x//0g7OkFJdcPtjbQi1Bowda3gJFmtIu5Iti65hWGpX/xuM2W5FNhzEfiKZKemus8j1CVGaN9x9tCBDevnEH0tPe8Dyy9UyZcL4h2QFbyCV7dHEtXyP6Q5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNRhIrw0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNRhIrw0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7982c3b7da9so49854387b3.1
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993748; x=1778598548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvvvCn8k83hLzR9AMjFQb9M4jvzTg1YTi3t+NjKHa6M=;
        b=WNRhIrw0pTRxYdpB5Jzt2sls06GNflQBO19fv+9ANxnpKSVe7DSZ3FwExfBx6ZL9Uf
         /E5wC+SnF06I9HXuNJOL2N9RhWlkHKgP/yulB39e7GDvF9Ju/iMkMSRzNYymmKe73uBh
         08bpX6ZgU4CIE3cAKSMqueG1u49JSV/WsHLDohXTXRN/k+H6KBhww8iAaO8Goe7Z8HPe
         S2scrTh98X58UwHBCMKe3BbcAPP5H7aUjfC5brcKJDzzysj2/fJk2CTMaGLOtfzKRAKH
         dU6BkejNYTELGw+J3w43h34RxsMVpxxZvbx9cx2dv/fPw62mFK0f9pWxHlZTzoAlrfFP
         GR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993748; x=1778598548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvvvCn8k83hLzR9AMjFQb9M4jvzTg1YTi3t+NjKHa6M=;
        b=U5jX0bhuxiLw07lCf3WoeBSUeTTZm6IS8YpV87L5tgG3eQXlHn2R7LFYeyqzT/Q81N
         jPn33zWvFiKXvJ0OjymJmijNkflNrl0jGmiBtFx2SqGOiJ7BBDTfntnOnINWqtPldivq
         vDnQGkXRntqI09JbYCZvTeBhyWuXrkrgKMMUIUxnwio/QmcaEwXxTJzSP6Q8r/2yr+5y
         +Oh5VSA1AKDLwBDy2tn9Z8bWfV1bLXyw44wZcR7lKzq/wTRONBKks+zcmse8/s52Rq/z
         m1eI7Dg+GOKnu1x+5hYsCrx2oZsES4N4qCaRZw58/GYHQB50vWE40t6S3pEo3hJVRo/B
         j+tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5WZwJW0sIfsb2hsfpwqXRHRvPBAd/PIZ/mwIjJOUwdfgUrNgVVQPvKhrzgmwzx/L8bNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOj279tbVyWLJ94YiHzGgOmSyV70w933RPRA0PDMIrBxZ/EQs
	bUgUohjSlbHpqLoUOoYkSoJt2ZBeUFyOaudz6JYxagm10pZgSizrTIR1
X-Gm-Gg: AeBDievZmhMbY9Hs2flvW3WvioV9eIqP0q8lKBveN2b6XAucUkYnYF4VvkiYve4xEII
	G7G6JdVPaLCvMQnbXWMLEPlwL0t8HhC/yXiD2FzrgcJoE4GPvtSbPlB1Mt2eP97J+y8ma3g7hRF
	2Trlcu8B3aVIyMWer4JdBX8mv7yHdidihAnyFTVqTqmx8t7/+DTfugZ918ARqSFnykoXkeLZT6u
	+5IhzDgi0QHNGL7rGQhhw93T7vysYqyawC1gmZ0YQaqveq5qE0xjq2q13o1Ksskb8XRzeCQMAL6
	oGQdtPsTT9WIXGwfSjl+Jk8CY42RGm8oNQK+LBg3V3ha4UGIgJPdXU0wgqsqjdbvk3lwL2gHFmY
	1EWld56aYIAuw/j7Hhalx1D6aME7Dx/05QdA77AhYoCRus73lmLLt6161xR+tq4kw3q0GQ025er
	BKIPnbBCe9nL3HFp0L+kVoWxTe9fjbA4myVi9XbZSV6M1EmVkrQZ+0o/75NOyX8+7oNyetqNxJ3
	tiRqwGom+g=
X-Received: by 2002:a05:690c:a018:b0:7bd:4792:66ef with SMTP id 00721157ae682-7bd7714a6dcmr135180467b3.42.1777993747708;
        Tue, 05 May 2026 08:09:07 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:2fd9:17ad:6991:cb6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6688d16fsm65061117b3.42.2026.05.05.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:09:07 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [bpf-next v2 2/2] selftests/bpf: Add kptr destructor NMI exerciser
Date: Tue,  5 May 2026 11:08:51 -0400
Message-ID: <20260505150851.3090688-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505150851.3090688-1-utilityemal77@gmail.com>
References: <20260505150851.3090688-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Programs attached to tp_btf/nmi_handler can drop refcounted kptrs from
NMI context by deleting map entries or clearing map values.  Add a
dedicated BPF-side selftest program that populates hash and array maps
with cpumask kptrs and clears them again from the NMI handler.

This test fails on the upstream and results in a lockdep warning, but
passes when NMI dtors are properly offloaded by the previous commit.

The test asserts that every object queued for destruction in hardirq
from NMI had the dtor called on it. The irq_work which has the
IRQ_WORK_HARD_IRQ flag is drained with kern_sync_rcu to ensure
consistency.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/kptr_dtor_nmi.c  | 259 +++++++++++
 .../selftests/bpf/progs/kptr_dtor_nmi.c       | 414 ++++++++++++++++++
 2 files changed, 673 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c b/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
new file mode 100644
index 000000000000..a1aa8b6646b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/perf_event.h>
+#include <sched.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+
+#include "kptr_dtor_nmi.skel.h"
+
+#define KPTR_DTOR_NMI_MAX_SLOTS 8
+#define KPTR_DTOR_NMI_ROUNDS 256
+#define DELETE_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
+
+enum kptr_dtor_nmi_map_type {
+	KPTR_DTOR_NMI_MAP_HASH = 1,
+	KPTR_DTOR_NMI_MAP_ARRAY,
+};
+
+struct kptr_dtor_nmi_case {
+	const char *name;
+	__u32 map_type;
+};
+
+__maybe_unused
+static int find_test_cpu(void)
+{
+	cpu_set_t cpuset;
+	int cpu, err;
+
+	err = sched_getaffinity(0, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return -1;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &cpuset))
+			return cpu;
+	}
+
+	ASSERT_TRUE(false, "cpu_available");
+	return -1;
+}
+
+__maybe_unused
+static int open_nmi_pmu_event_on_cpu(int cpu)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+		.sample_freq = 1000,
+	};
+	int pmu_fd;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1, cpu, -1,
+			 PERF_FLAG_FD_CLOEXEC);
+	if (pmu_fd == -1) {
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			printf("SKIP:no PERF_COUNT_HW_CPU_CYCLES\n");
+			test__skip();
+		}
+		return -1;
+	}
+
+	return pmu_fd;
+}
+
+__maybe_unused
+static bool pin_to_cpu(int cpu, cpu_set_t *old_cpuset)
+{
+	cpu_set_t cpuset;
+	int err;
+
+	err = sched_getaffinity(0, sizeof(*old_cpuset), old_cpuset);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return false;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	err = sched_setaffinity(0, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "sched_setaffinity"))
+		return false;
+
+	return true;
+}
+
+__maybe_unused
+static void restore_affinity(const cpu_set_t *old_cpuset)
+{
+	ASSERT_OK(sched_setaffinity(0, sizeof(*old_cpuset), old_cpuset),
+		  "restore_affinity");
+}
+
+__maybe_unused
+static bool run_syscall_prog(struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, name))
+		return false;
+	if (!ASSERT_EQ(opts.retval, 0, name))
+		return false;
+
+	return true;
+}
+
+__maybe_unused
+static bool wait_for_nmi_drain(struct kptr_dtor_nmi *skel,
+			       __u32 expected_deleted,
+			       __u32 expected_release_calls)
+{
+	u64 now_ns, timeout_time_ns;
+
+	now_ns = get_time_ns();
+	timeout_time_ns = now_ns + DELETE_TIMEOUT_NS;
+	while (skel->bss->kptr_dtor_nmi_deleted < expected_deleted ||
+	       skel->bss->kptr_dtor_nmi_release_calls < expected_release_calls) {
+		if (skel->bss->kptr_dtor_nmi_setup_err ||
+		    skel->bss->kptr_dtor_nmi_nmi_err ||
+		    skel->bss->kptr_dtor_nmi_cleanup_err)
+			break;
+		now_ns = get_time_ns();
+		if (now_ns >= timeout_time_ns)
+			break;
+		sched_yield();
+	}
+
+	if (!ASSERT_EQ(skel->bss->kptr_dtor_nmi_setup_err, 0,
+		       "kptr_dtor_nmi_setup_err"))
+		return false;
+	if (!ASSERT_EQ(skel->bss->kptr_dtor_nmi_nmi_err, 0,
+		       "kptr_dtor_nmi_nmi_err"))
+		return false;
+	if (!ASSERT_EQ(skel->bss->kptr_dtor_nmi_cleanup_err, 0,
+		       "kptr_dtor_nmi_cleanup_err"))
+		return false;
+	if (!ASSERT_GE(skel->bss->kptr_dtor_nmi_deleted, expected_deleted,
+		       "kptr_dtor_nmi_deleted"))
+		return false;
+	if (!ASSERT_GE(skel->bss->kptr_dtor_nmi_release_calls,
+		       expected_release_calls,
+		       "kptr_dtor_nmi_release_calls"))
+		return false;
+	if (!ASSERT_LT(now_ns, timeout_time_ns, "kptr_dtor_nmi_timeout"))
+		return false;
+
+	return true;
+}
+
+__maybe_unused
+static void run_kptr_dtor_nmi_case(const struct kptr_dtor_nmi_case *test)
+{
+	struct kptr_dtor_nmi *skel;
+	cpu_set_t old_cpuset;
+	bool pinned = false;
+	int cpu = -1;
+	int pmu_fd = -1;
+	int err, round;
+
+	cpu = find_test_cpu();
+	if (cpu < 0)
+		return;
+
+	skel = kptr_dtor_nmi__open();
+	if (!ASSERT_OK_PTR(skel, "kptr_dtor_nmi__open"))
+		return;
+
+	skel->bss->kptr_dtor_nmi_map_type = test->map_type;
+	bpf_program__set_autoattach(skel->progs.clear_kptrs_from_nmi, false);
+
+	err = kptr_dtor_nmi__load(skel);
+	if (!ASSERT_OK(err, "kptr_dtor_nmi__load"))
+		goto cleanup;
+
+	err = kptr_dtor_nmi__attach(skel);
+	if (!ASSERT_OK(err, "kptr_dtor_nmi__attach"))
+		goto cleanup;
+
+	skel->links.clear_kptrs_from_nmi =
+		bpf_program__attach_trace(skel->progs.clear_kptrs_from_nmi);
+	if (!ASSERT_OK_PTR(skel->links.clear_kptrs_from_nmi,
+			   "attach_tp_btf_nmi_handler"))
+		goto cleanup;
+
+	pinned = pin_to_cpu(cpu, &old_cpuset);
+	if (!pinned)
+		goto cleanup;
+
+	pmu_fd = open_nmi_pmu_event_on_cpu(cpu);
+	if (pmu_fd < 0)
+		goto cleanup;
+
+	for (round = 0; round < KPTR_DTOR_NMI_ROUNDS; round++) {
+		__u32 expected_total;
+
+		if (!run_syscall_prog(skel->progs.populate_kptrs, "populate_kptrs"))
+			goto cleanup;
+
+		expected_total = (round + 1) * KPTR_DTOR_NMI_MAX_SLOTS;
+		if (!ASSERT_EQ(skel->bss->kptr_dtor_nmi_setup_created,
+			       expected_total,
+			       "kptr_dtor_nmi_setup_created"))
+			goto cleanup;
+
+		if (!wait_for_nmi_drain(skel, expected_total, expected_total))
+			goto cleanup;
+
+		kern_sync_rcu();
+	}
+
+	if (!run_syscall_prog(skel->progs.cleanup_kptrs, "cleanup_kptrs"))
+		goto cleanup;
+	/*
+	 * The grace period for rcu cannot complete until the CPU that ran the
+	 * hard irq_work has passed through a quiescent state after running
+	 * our dtor work. This effectively flushes our pending work and allows
+	 * the test to verify the dtor was called the expected number of times.
+	 */
+	kern_sync_rcu();
+	ASSERT_EQ(skel->bss->kptr_dtor_nmi_cleanup_deleted, 0,
+		  "kptr_dtor_nmi_cleanup_deleted");
+
+cleanup:
+	if (pmu_fd >= 0)
+		close(pmu_fd);
+	if (pinned)
+		restore_affinity(&old_cpuset);
+	kptr_dtor_nmi__destroy(skel);
+}
+
+void serial_test_kptr_dtor_nmi(void)
+{
+/*
+ * nmi_handler isn't supported for these architectures.
+ */
+#if defined(__aarch64__) || defined(__s390x__)
+	test__skip();
+	return;
+#else
+	static const struct kptr_dtor_nmi_case tests[] = {
+		{ "hash", KPTR_DTOR_NMI_MAP_HASH },
+		{ "array", KPTR_DTOR_NMI_MAP_ARRAY },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		run_kptr_dtor_nmi_case(&tests[i]);
+	}
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c b/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c
new file mode 100644
index 000000000000..1ab5951a7a22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define KPTR_DTOR_NMI_MAX_SLOTS 8
+
+enum kptr_dtor_nmi_map_type {
+	KPTR_DTOR_NMI_MAP_HASH = 1,
+	KPTR_DTOR_NMI_MAP_ARRAY,
+};
+
+enum kptr_dtor_nmi_err {
+	KPTR_DTOR_NMI_SETUP_CREATE_ERR = 1,
+	KPTR_DTOR_NMI_SETUP_LOOKUP_ERR,
+	KPTR_DTOR_NMI_SETUP_STALE_ERR,
+	KPTR_DTOR_NMI_SETUP_MAP_ERR,
+	KPTR_DTOR_NMI_DELETE_ERR,
+	KPTR_DTOR_NMI_CLEANUP_ERR,
+};
+
+struct kptr_dtor_nmi_value {
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct kptr_dtor_nmi_value);
+	__uint(max_entries, KPTR_DTOR_NMI_MAX_SLOTS);
+} kptr_dtor_nmi_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct kptr_dtor_nmi_value);
+	__uint(max_entries, KPTR_DTOR_NMI_MAX_SLOTS);
+} kptr_dtor_nmi_array SEC(".maps");
+
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym __weak;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym __weak;
+
+__u32 kptr_dtor_nmi_live_mask;
+__u32 kptr_dtor_nmi_map_type;
+__u32 kptr_dtor_nmi_setup_created;
+__u32 kptr_dtor_nmi_deleted;
+__u32 kptr_dtor_nmi_cleanup_deleted;
+__u32 kptr_dtor_nmi_release_calls;
+__u32 kptr_dtor_nmi_setup_err;
+__u32 kptr_dtor_nmi_nmi_err;
+__u32 kptr_dtor_nmi_cleanup_err;
+int kptr_dtor_nmi_setup_errno;
+int kptr_dtor_nmi_nmi_errno;
+int kptr_dtor_nmi_cleanup_errno;
+
+static void set_err(__u32 *err_dst, int *errno_dst, __u32 err, int err_no)
+{
+	if (!*err_dst) {
+		*err_dst = err;
+		*errno_dst = err_no;
+	}
+}
+
+static bool slot_is_live(__u32 slot)
+{
+	return kptr_dtor_nmi_live_mask & (1U << slot);
+}
+
+static void mark_slot_live(__u32 slot)
+{
+	kptr_dtor_nmi_live_mask |= 1U << slot;
+}
+
+static void clear_slot_live(__u32 slot)
+{
+	kptr_dtor_nmi_live_mask &= ~(1U << slot);
+}
+
+static struct kptr_dtor_nmi_value *lookup_hash_value(__u32 slot)
+{
+	return bpf_map_lookup_elem(&kptr_dtor_nmi_hash, &slot);
+}
+
+static struct kptr_dtor_nmi_value *lookup_array_value(__u32 slot)
+{
+	return bpf_map_lookup_elem(&kptr_dtor_nmi_array, &slot);
+}
+
+static int stash_mask(struct kptr_dtor_nmi_value *value, __u32 slot)
+{
+	struct bpf_cpumask *mask, *old;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	old = bpf_kptr_xchg(&value->mask, mask);
+	if (old) {
+		bpf_cpumask_release(old);
+		return -EEXIST;
+	}
+
+	mark_slot_live(slot);
+	kptr_dtor_nmi_setup_created++;
+	return 0;
+}
+
+static bool populate_hash_slot(__u32 slot)
+{
+	struct kptr_dtor_nmi_value init = {};
+	struct kptr_dtor_nmi_value *value;
+	int err;
+
+	err = bpf_map_update_elem(&kptr_dtor_nmi_hash, &slot, &init, BPF_NOEXIST);
+	if (err) {
+		set_err(&kptr_dtor_nmi_setup_err,
+				&kptr_dtor_nmi_setup_errno,
+				KPTR_DTOR_NMI_SETUP_CREATE_ERR, err);
+		return false;
+	}
+
+	value = lookup_hash_value(slot);
+	if (!value) {
+		set_err(&kptr_dtor_nmi_setup_err,
+				&kptr_dtor_nmi_setup_errno,
+				KPTR_DTOR_NMI_SETUP_LOOKUP_ERR, -ENOENT);
+		return false;
+	}
+
+	err = stash_mask(value, slot);
+	if (err) {
+		set_err(&kptr_dtor_nmi_setup_err,
+				&kptr_dtor_nmi_setup_errno,
+				KPTR_DTOR_NMI_SETUP_STALE_ERR, err);
+		return false;
+	}
+
+	return true;
+}
+
+static bool populate_array_slot(__u32 slot)
+{
+	struct kptr_dtor_nmi_value *value;
+	int err;
+
+	value = lookup_array_value(slot);
+	if (!value) {
+		set_err(&kptr_dtor_nmi_setup_err,
+				&kptr_dtor_nmi_setup_errno,
+				KPTR_DTOR_NMI_SETUP_LOOKUP_ERR, -ENOENT);
+		return false;
+	}
+
+	err = stash_mask(value, slot);
+	if (err) {
+		set_err(&kptr_dtor_nmi_setup_err,
+				&kptr_dtor_nmi_setup_errno,
+				KPTR_DTOR_NMI_SETUP_STALE_ERR, err);
+		return false;
+	}
+
+	return true;
+}
+
+static bool clear_hash_slot_from_nmi(__u32 slot)
+{
+	struct kptr_dtor_nmi_value *value;
+	int err;
+
+	if (!slot_is_live(slot))
+		return true;
+
+	err = bpf_map_delete_elem(&kptr_dtor_nmi_hash, &slot);
+	if (!err) {
+		clear_slot_live(slot);
+		kptr_dtor_nmi_deleted++;
+		return true;
+	}
+
+	/*
+	 * Hash deletes take rqspinlock-backed bucket locks. NMI reentry can lose
+	 * those acquisitions with -EDEADLK or -ETIMEDOUT even though the slot is
+	 * still valid, so leave it live and retry on a later NMI.
+	 */
+	if (err == -EDEADLK || err == -ETIMEDOUT)
+		return true;
+
+	value = lookup_hash_value(slot);
+	if (value)
+		set_err(&kptr_dtor_nmi_nmi_err,
+				&kptr_dtor_nmi_nmi_errno,
+				KPTR_DTOR_NMI_DELETE_ERR, err);
+
+	return false;
+}
+
+static bool clear_array_slot_from_nmi(__u32 slot)
+{
+	struct kptr_dtor_nmi_value init = {};
+	int err;
+
+	if (!slot_is_live(slot))
+		return true;
+
+	err = bpf_map_update_elem(&kptr_dtor_nmi_array, &slot, &init, BPF_EXIST);
+	if (err) {
+		set_err(&kptr_dtor_nmi_nmi_err,
+				&kptr_dtor_nmi_nmi_errno,
+				KPTR_DTOR_NMI_DELETE_ERR, err);
+		return false;
+	}
+
+	clear_slot_live(slot);
+	kptr_dtor_nmi_deleted++;
+	return true;
+}
+
+static bool cleanup_hash_slot(__u32 slot)
+{
+	struct kptr_dtor_nmi_value *value;
+	struct bpf_cpumask *old = NULL;
+
+	value = lookup_hash_value(slot);
+	if (!value) {
+		clear_slot_live(slot);
+		return true;
+	}
+
+	old = bpf_kptr_xchg(&value->mask, old);
+	if (old) {
+		bpf_cpumask_release(old);
+		kptr_dtor_nmi_cleanup_deleted++;
+	}
+
+	if (bpf_map_delete_elem(&kptr_dtor_nmi_hash, &slot) &&
+	    lookup_hash_value(slot)) {
+		set_err(&kptr_dtor_nmi_cleanup_err,
+				&kptr_dtor_nmi_cleanup_errno,
+				KPTR_DTOR_NMI_CLEANUP_ERR, -EIO);
+		return false;
+	}
+
+	clear_slot_live(slot);
+	return true;
+}
+
+static bool cleanup_array_slot(__u32 slot)
+{
+	struct kptr_dtor_nmi_value *value;
+	struct bpf_cpumask *old = NULL;
+
+	value = lookup_array_value(slot);
+	if (!value) {
+		set_err(&kptr_dtor_nmi_cleanup_err,
+				&kptr_dtor_nmi_cleanup_errno,
+				KPTR_DTOR_NMI_CLEANUP_ERR, -ENOENT);
+		return false;
+	}
+
+	old = bpf_kptr_xchg(&value->mask, old);
+	if (old) {
+		bpf_cpumask_release(old);
+		kptr_dtor_nmi_cleanup_deleted++;
+	}
+
+	clear_slot_live(slot);
+	return true;
+}
+
+static void populate_hash_masks(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!populate_hash_slot(slot))
+			return;
+	}
+}
+
+static void populate_array_masks(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!populate_array_slot(slot))
+			return;
+	}
+}
+
+static void clear_hash_masks_from_nmi(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!clear_hash_slot_from_nmi(slot))
+			return;
+	}
+}
+
+static void clear_array_masks_from_nmi(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!clear_array_slot_from_nmi(slot))
+			return;
+	}
+}
+
+static void cleanup_hash_masks(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!cleanup_hash_slot(slot))
+			return;
+	}
+}
+
+static void cleanup_array_masks(void)
+{
+	__u32 slot;
+
+	for (slot = 0; slot < KPTR_DTOR_NMI_MAX_SLOTS; slot++) {
+		if (!cleanup_array_slot(slot))
+			return;
+	}
+}
+
+SEC("syscall")
+int populate_kptrs(void *ctx)
+{
+	(void)ctx;
+
+	switch (kptr_dtor_nmi_map_type) {
+	case KPTR_DTOR_NMI_MAP_HASH:
+		populate_hash_masks();
+		break;
+	case KPTR_DTOR_NMI_MAP_ARRAY:
+		populate_array_masks();
+		break;
+	default:
+		set_err(&kptr_dtor_nmi_setup_err,
+			&kptr_dtor_nmi_setup_errno,
+			KPTR_DTOR_NMI_SETUP_MAP_ERR, -EINVAL);
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int cleanup_kptrs(void *ctx)
+{
+	(void)ctx;
+
+	switch (kptr_dtor_nmi_map_type) {
+	case KPTR_DTOR_NMI_MAP_HASH:
+		cleanup_hash_masks();
+		break;
+	case KPTR_DTOR_NMI_MAP_ARRAY:
+		cleanup_array_masks();
+		break;
+	default:
+		set_err(&kptr_dtor_nmi_cleanup_err,
+			&kptr_dtor_nmi_cleanup_errno,
+			KPTR_DTOR_NMI_CLEANUP_ERR, -EINVAL);
+		break;
+	}
+
+	return 0;
+}
+
+SEC("tp_btf/nmi_handler")
+int BPF_PROG(clear_kptrs_from_nmi, void *handler, void *regs, s64 delta_ns,
+	     int handled)
+{
+	(void)handler;
+	(void)regs;
+	(void)delta_ns;
+	(void)handled;
+
+	if (kptr_dtor_nmi_deleted >= kptr_dtor_nmi_setup_created)
+		return 0;
+
+	switch (kptr_dtor_nmi_map_type) {
+	case KPTR_DTOR_NMI_MAP_HASH:
+		clear_hash_masks_from_nmi();
+		break;
+	case KPTR_DTOR_NMI_MAP_ARRAY:
+		clear_array_masks_from_nmi();
+		break;
+	default:
+		set_err(&kptr_dtor_nmi_nmi_err,
+			&kptr_dtor_nmi_nmi_errno,
+			KPTR_DTOR_NMI_DELETE_ERR, -EINVAL);
+		break;
+	}
+
+	return 0;
+}
+
+SEC("fentry/bpf_cpumask_release")
+int BPF_PROG(count_cpumask_release, struct bpf_cpumask *mask)
+{
+	(void)mask;
+	kptr_dtor_nmi_release_calls++;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

