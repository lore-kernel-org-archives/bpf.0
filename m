Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF567331EDA
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207934; cv=none; b=CjzpmzxfpXcq5ZwpYPozqYS+387Keh1wJAL1hS49igdnaatwS+aN8eD8/V/XxOq8HDqBXeOSDGmy7lD6TCCT8eRWjXdaIfDYqxx2crHH8ugZjQenaLwcJxZTO7BRXdkjn+fbakfJkgYJ+xLS7HPjUEqwiFoXZ7XanV/8T9jqqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207934; c=relaxed/simple;
	bh=51Sawhbl4xq7luqO5mCUiidxlvmfeEuJrX/g2kaC2sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu2xjbDLvgOsozFimCbNhf2FcwIjN9vH4+/jlKP0F0wg3MTaRfU6L/U+quH1S5CFScN1JEA13kbwI6NM6Ek55VHCa04joyN6QPuM9Y7RFXNeUC4jbiSkQ8PbeVoeZoLIhydtQOEBu9Yk9tSpJqCB2I1rRi6XvWh40jUzYiTOPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odv6uL8H; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odv6uL8H"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7f5eb760240so3865707b3.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781207932; x=1781812732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwXRZbGq6R/a0YBcwmVBZi/EB/pVEQd7cpSl0E0lHKI=;
        b=Odv6uL8HnrF+2pYOhHZkA2ebztzySJupIa0EcG3DTrQopPcEpogpMNvLYkbmOP10CW
         ZI6UDp0ZMXOoGDp4SipLC/Y9KfEeGO7YmYJFQCcEw5uRNvlNbhwgDK7JR9VYHXZ02HpN
         e48H5qpCGEupNaio8C/naaPunMtaFR/yePXqoJUcigd0CmIEPFr+FhuqDaEKMcahw0yg
         MGxMtnkWJgOVuUFC9hIN6FfC00VcoGQyZEeWYLIIKd63YUd3RYDWrAPKqkefnKaCNlz+
         QFM/jY7xDGI0h/BSBiAqR7mBFlsSHqbUQw3bcZt0ynG5oVJZ7jIuDRysddGydIdWZ1I4
         47QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207932; x=1781812732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwXRZbGq6R/a0YBcwmVBZi/EB/pVEQd7cpSl0E0lHKI=;
        b=Tp7kHtOGhead1wYwXS/yL0KOJsMK8kgWZoIMUWobrL2wnY+7zdTTeet/zVYNPq/OZB
         o2a75SWxD20zVVTg9fvHJgbwsocRZVPabEPQVCVITH22A13rZ2cbLG4CoX0SYpJCKF4f
         f4lkgn7Qd1AH1GQGiMz1UDOMPj80Owf2RW5tnvyf/9WxO9cY3y5GwdpvViVyWk9c3sTo
         XTdpGAswQX2O5HM2YkkWZarPCFswCJJ/wZjwi//8GpilH/INlx8xc7H86SaOAlrRIYA8
         dsxeEel/m69FT6m7qKdoJf/1mW7IMdDQag9Cxt02Krly6LottWol5Gk/uC3BKCJXnPkN
         R3fQ==
X-Gm-Message-State: AOJu0YyhAJ52r+go/XANDbjGtOAcqEVYw4RBgLpMuZ36QmxTZo+acU1S
	WPiPe1C8vdaqb6G3RIS8RlE+Csgr2gdBYcetq1b5iBD/7oUzdS4pFXylGh4iig==
X-Gm-Gg: Acq92OFZxUOy6pg17R7MSoRkDqN/KpCSFsfgBsKp2oHyl8IYo4BH981P0b1hZmZ6Wub
	S9sTEVoqQx06bYBPtNMvGzeRaaEHYbzYeUG1Rk2Ftt+I2KkLT7Hh0939mHc0JkRBVsgdFvFT/xe
	NBwRDbQP6Q9YhfA2bFBtHBnwEuv5sO8j/0YtFzTh38y+E2GuNrys+kSDckU0e+QrI8egoJMUsHi
	TJcg0JtO7JHd4xDAMJsmGXQYawvrWOJ+wj4WA76DqjlqjSuV6iuNv9ZCL87arvXQnbGpGNj20ui
	pnwP32mDq1dROfiouaJYbvOBNxw5VofdK5XtQR+nkjGjCFuD2EC6fw/WYfs8y/xCDMXC/vaK+d5
	lkvmQ6i36xp4+eWHcmgj5J3XDOlnGiqs3PcEdcdHUWHgDdVcpT36ZKXFY4Vs4Y+SSaDA45Jrn7z
	/3h2HbD6AIQ1VDVFZHk6oLIzgmZvgPLUDPXbKJuc5WVr7I9OoJO+Ap6XvykA==
X-Received: by 2002:a05:690c:64c6:b0:79a:b46c:e60a with SMTP id 00721157ae682-7f658bec87bmr45218197b3.44.1781207931687;
        Thu, 11 Jun 2026 12:58:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5c51:3389:aa27:97c6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f76e8991dcsm2157587b3.17.2026.06.11.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:58:51 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: memxor@gmail.com,
	alexei.starovoitov@gmail.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Add cgroup kptr NMI deadlock reproducer
Date: Thu, 11 Jun 2026 15:58:44 -0400
Message-ID: <20260611195844.2830283-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the path where a cgroup kptr stashed in a BPF map has its
destructor invoked from NMI context when the map element is freed.
bpf_cgroup_release_dtor -> cgroup_put can take sleeping/spinning paths
that are unsafe to enter from NMI; the destructor must be deferred
instead of run inline.

The test stashes a cgroup kptr from a syscall program into a HASH map
with BPF_F_NO_PREALLOC, then drives map element deletion from a
tp_btf/nmi_handler program firing on PMU cycle counter NMIs raised on a
pinned CPU. Each round:

  1. Creates a cgroup and stashes its kptr in the map.
  2. Removes the cgroup and waits for css_free_rwork_fn to fire for
     every subsystem CSS (tracked via an fexit program), so the kptr
     drop hits the window where the bug reproduces.
  3. Arms the NMI program (gated by an "nr_cgrps" counter) and waits
     for it to delete the stashed element.

After REPRO_ROUNDS iterations the test scans /dev/kmsg captured from
the start of the run: bpf_cgroup_release_dtor appearing in any splat
stack means the destructor ran inline from NMI and the fix has
regressed. Scanning kmsg catches the bug even when the inline path
does not actually wedge the CPU.

This fails and causes a kernel splat prior to commit a3a81d247651
("bpf: Cancel special fields on map value recycle") in bpf-next/master.

Runs on x86 only: relies on PMU cycle counter NMIs and the
x86-specific nmi_handler tracepoint.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Addressed bot feedback, added error handling for more failure points
to avoid false skips and used the existing cgroup helpers.
I wasn't aware of those helpers initially but they cut the diff a
lot.

 .../cgroup_kptr_nmi_deadlock_repro.c          | 273 ++++++++++++++++++
 .../progs/cgroup_kptr_nmi_deadlock_repro.c    | 116 ++++++++
 2 files changed, 389 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
new file mode 100644
index 000000000000..57887ab10f8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/compiler.h>
+#include <linux/perf_event.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <cgroup_helpers.h>
+#include <test_progs.h>
+
+#include "cgroup_kptr_nmi_deadlock_repro.skel.h"
+
+#define DELETE_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
+#define REPRO_ROUNDS 256
+#define REPRO_CGROUP_REL_PATH "/my_new_group"
+
+/*
+ * The reproducer relies on a PMU cycle counter to raise NMIs and on the
+ * x86-only nmi_handler tracepoint, so it only runs on x86.
+ */
+#if defined(__x86_64__) || defined(__i386__)
+
+static int open_kmsg_at_end(void)
+{
+	int fd, err;
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -errno;
+	if (lseek(fd, 0, SEEK_END) == (off_t)-1) {
+		err = errno;
+		close(fd);
+		return -err;
+	}
+	return fd;
+}
+
+static bool kmsg_saw_splat(int fd)
+{
+	char buf[8192];
+	ssize_t n;
+
+	/* bpf_cgroup_release_dtor in any splat stack means NMI ran the dtor. */
+	for (;;) {
+		n = read(fd, buf, sizeof(buf) - 1);
+		if (n > 0) {
+			buf[n] = '\0';
+			if (strstr(buf, "bpf_cgroup_release_dtor"))
+				return true;
+			continue;
+		}
+		if (n < 0 && errno == EPIPE)
+			continue;
+		return false;
+	}
+}
+
+static int open_nmi_pmu_event_on_cpu(int cpu)
+{
+	struct perf_event_attr attr = {
+		.freq = 1,
+		.sample_freq = 1000,
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+	};
+	int pmu_fd, err;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
+	if (pmu_fd < 0) {
+		err = errno;
+		if (err == ENOENT || err == EOPNOTSUPP) {
+			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+			test__skip();
+			return -1;
+		}
+		PRINT_FAIL("perf_event_open(cpu=%d): %s\n", cpu, strerror(err));
+		return -1;
+	}
+
+	return pmu_fd;
+}
+
+static int pick_repro_cpu(void)
+{
+	cpu_set_t mask;
+	int i;
+
+	if (!ASSERT_OK(sched_getaffinity(getpid(), sizeof(mask), &mask),
+		       "sched_getaffinity"))
+		return -1;
+
+	for (i = CPU_SETSIZE - 1; i >= 0; i--) {
+		if (CPU_ISSET(i, &mask))
+			return i;
+	}
+	return -1;
+}
+
+static bool pin_to_cpu(int cpu, cpu_set_t *old_cpuset)
+{
+	cpu_set_t cpuset;
+
+	if (!ASSERT_OK(sched_getaffinity(getpid(), sizeof(*old_cpuset), old_cpuset),
+		       "sched_getaffinity"))
+		return false;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	return ASSERT_OK(sched_setaffinity(getpid(), sizeof(cpuset), &cpuset),
+			 "sched_setaffinity");
+}
+
+static void burn_cpu(void)
+{
+	int i;
+
+	/* Keep the CPU busy so PERF_COUNT_HW_CPU_CYCLES keeps raising NMIs. */
+	for (i = 0; i < 1000000; i++)
+		barrier();
+}
+
+static bool wait_for_cgroup_nmi_delete_batch(struct cgroup_kptr_nmi_deadlock_repro *skel,
+					     int expected_deleted)
+{
+	u64 timeout_ns = get_time_ns() + DELETE_TIMEOUT_NS;
+	int spin = 0;
+
+	while (skel->bss->cgroup_kptr_nmi_deleted < expected_deleted) {
+		burn_cpu();
+		if (++spin >= 8) {
+			sched_yield();
+			spin = 0;
+		}
+		if (get_time_ns() >= timeout_ns)
+			break;
+	}
+
+	return ASSERT_EQ(skel->bss->cgroup_kptr_nmi_deleted, expected_deleted,
+			 "cgroup_kptr_nmi_deleted");
+}
+
+static bool wait_for_cgroup_css_free_batch(struct cgroup_kptr_nmi_deadlock_repro *skel,
+					   int expected_done)
+{
+	struct timespec ts = { .tv_nsec = 1000 * 1000 };
+	u64 timeout_ns = get_time_ns() + DELETE_TIMEOUT_NS;
+
+	while (skel->bss->cgroup_kptr_nmi_killed_work_done < expected_done) {
+		nanosleep(&ts, NULL);
+		if (get_time_ns() >= timeout_ns)
+			break;
+	}
+
+	return ASSERT_GE(skel->bss->cgroup_kptr_nmi_killed_work_done,
+			 expected_done, "cgroup_kptr_nmi_killed_work_done");
+}
+
+static void run_cgroup_kptr_nmi_deadlock_repro(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct cgroup_kptr_nmi_deadlock_repro *skel = NULL;
+	cpu_set_t old_cpuset;
+	bool pinned = false;
+	int pmu_fd = -1;
+	int kmsg_fd = -1;
+	int repro_cpu;
+	int round;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		return;
+
+	skel = cgroup_kptr_nmi_deadlock_repro__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto cleanup_cgroup_env;
+
+	repro_cpu = pick_repro_cpu();
+	if (!ASSERT_GE(repro_cpu, 0, "pick_repro_cpu"))
+		goto destroy_skel;
+
+	pinned = pin_to_cpu(repro_cpu, &old_cpuset);
+	if (!pinned)
+		goto destroy_skel;
+
+	skel->links.clear_cgroup_kptrs_from_nmi =
+		bpf_program__attach_trace(skel->progs.clear_cgroup_kptrs_from_nmi);
+	if (!ASSERT_OK_PTR(skel->links.clear_cgroup_kptrs_from_nmi, "attach_tp_btf"))
+		goto destroy_skel;
+
+	skel->links.mark_cgroup_killed_work_done =
+		bpf_program__attach_trace(skel->progs.mark_cgroup_killed_work_done);
+	if (!ASSERT_OK_PTR(skel->links.mark_cgroup_killed_work_done, "attach_fexit"))
+		goto destroy_skel;
+
+	pmu_fd = open_nmi_pmu_event_on_cpu(repro_cpu);
+	if (pmu_fd < 0)
+		goto destroy_skel;
+
+	kmsg_fd = open_kmsg_at_end();
+	if (!ASSERT_GE(kmsg_fd, 0, "open_kmsg_at_end"))
+		goto destroy_skel;
+
+	for (round = 0; round < REPRO_ROUNDS; round++) {
+		int expected_inserted = round + 1;
+		int expected_css_free;
+		int cg_fd;
+		int err;
+
+		cg_fd = create_and_get_cgroup(REPRO_CGROUP_REL_PATH);
+		if (!ASSERT_GE(cg_fd, 0, "create_and_get_cgroup"))
+			goto destroy_skel;
+		close(cg_fd);
+
+		skel->bss->cgroup_kptr_nmi_id = get_cgroup_id(REPRO_CGROUP_REL_PATH);
+		if (!ASSERT_NEQ(skel->bss->cgroup_kptr_nmi_id, 0, "get_cgroup_id"))
+			goto destroy_skel;
+
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.insert_cgroup_kptr),
+					     &opts);
+		if (!ASSERT_OK(err, "insert_cgroup_kptr"))
+			goto destroy_skel;
+		if (!ASSERT_EQ(opts.retval, 0, "insert_retval"))
+			goto destroy_skel;
+		if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_err, 0, "cgroup_kptr_nmi_err"))
+			goto destroy_skel;
+		if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_inserted, expected_inserted,
+			       "cgroup_kptr_nmi_inserted"))
+			goto destroy_skel;
+
+		expected_css_free = skel->bss->cgroup_kptr_nmi_clear_runs;
+
+		remove_cgroup(REPRO_CGROUP_REL_PATH);
+
+		if (!wait_for_cgroup_css_free_batch(skel, expected_css_free))
+			goto destroy_skel;
+
+		skel->bss->cgroup_kptr_nmi_nr_cgrps = expected_inserted;
+		if (!wait_for_cgroup_nmi_delete_batch(skel, expected_inserted))
+			goto destroy_skel;
+	}
+
+	ASSERT_FALSE(kmsg_saw_splat(kmsg_fd), "nmi_dtor_splat");
+
+destroy_skel:
+	if (pinned)
+		sched_setaffinity(getpid(), sizeof(old_cpuset), &old_cpuset);
+	if (kmsg_fd >= 0)
+		close(kmsg_fd);
+	if (pmu_fd >= 0)
+		close(pmu_fd);
+	cgroup_kptr_nmi_deadlock_repro__destroy(skel);
+cleanup_cgroup_env:
+	cleanup_cgroup_environment();
+}
+
+#endif
+
+void test_cgroup_kptr_nmi_deadlock_repro(void)
+{
+#if defined(__x86_64__) || defined(__i386__)
+	run_cgroup_kptr_nmi_deadlock_repro();
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c b/tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c
new file mode 100644
index 000000000000..84ce4305be06
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "errno.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct cgroup_map_value {
+	struct cgroup __kptr * cgrp;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct cgroup_map_value);
+	__uint(max_entries, 1);
+} stashed_cgroups SEC(".maps");
+
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+
+__u64 cgroup_kptr_nmi_id;
+int cgroup_kptr_nmi_nr_cgrps;
+int cgroup_kptr_nmi_inserted;
+int cgroup_kptr_nmi_deleted;
+int cgroup_kptr_nmi_killed_work_done;
+int cgroup_kptr_nmi_clear_runs;
+int cgroup_kptr_nmi_err;
+
+SEC("syscall")
+int insert_cgroup_kptr(void *ctx)
+{
+	struct cgroup_map_value init = {};
+	struct cgroup_map_value *mapval;
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp, *old;
+	__u32 key = 0;
+	int nr_csses = 0;
+	int i, ret;
+
+	cgrp = bpf_cgroup_from_id(cgroup_kptr_nmi_id);
+	if (!cgrp) {
+		cgroup_kptr_nmi_err = -ENOENT;
+		return 0;
+	}
+
+#pragma unroll
+	for (i = 0; i < CGROUP_SUBSYS_COUNT; i++) {
+		bpf_core_read(&css, sizeof(css), &cgrp->subsys[i]);
+		if (css)
+			nr_csses++;
+	}
+
+	ret = bpf_map_update_elem(&stashed_cgroups, &key, &init, BPF_NOEXIST);
+	if (ret) {
+		cgroup_kptr_nmi_err = ret;
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	mapval = bpf_map_lookup_elem(&stashed_cgroups, &key);
+	if (!mapval) {
+		cgroup_kptr_nmi_err = -ENOENT;
+		bpf_cgroup_release(cgrp);
+		bpf_map_delete_elem(&stashed_cgroups, &key);
+		return 0;
+	}
+
+	/* After the fix the slot may be recycled with a stashed cgroup; drain it. */
+	old = bpf_kptr_xchg(&mapval->cgrp, cgrp);
+	if (old)
+		bpf_cgroup_release(old);
+
+	cgroup_kptr_nmi_inserted++;
+	cgroup_kptr_nmi_clear_runs += nr_csses;
+
+	return 0;
+}
+
+SEC("fexit/css_free_rwork_fn")
+int BPF_PROG(mark_cgroup_killed_work_done, struct work_struct *work)
+{
+	struct cgroup_subsys_state *css;
+	struct rcu_work *rwork;
+	__u64 cgid;
+
+	rwork = container_of(work, struct rcu_work, work);
+	css = container_of(rwork, struct cgroup_subsys_state, destroy_rwork);
+	if (!BPF_CORE_READ(css, ss))
+		return 0;
+
+	cgid = BPF_CORE_READ(css, cgroup, kn, id);
+	if (cgid == cgroup_kptr_nmi_id)
+		__sync_fetch_and_add(&cgroup_kptr_nmi_killed_work_done, 1);
+
+	return 0;
+}
+
+SEC("tp_btf/nmi_handler")
+int BPF_PROG(clear_cgroup_kptrs_from_nmi, void *handler, s64 delta_ns,
+	     int handled)
+{
+	__u32 key = 0;
+
+	if (cgroup_kptr_nmi_deleted >= cgroup_kptr_nmi_nr_cgrps)
+		return 0;
+
+	if (!bpf_map_delete_elem(&stashed_cgroups, &key))
+		cgroup_kptr_nmi_deleted++;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.54.0

