Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376E3DDDBD
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106781; cv=none; b=A4lgmRZB7o/F6HALPqcgPzb40s4mUg8NLlGCslC5XKGcLgt3vsBkxtJOoP/lm1zcPteFFZbKXXOW02Omw1sgSK4ynlZQjK4T0aWKRnRm1M5whipdM3STnx57ABqYBGD75cWPVjaz5dDU1f8h8VTrTaMus1UB1B6MzRYgOt9qfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106781; c=relaxed/simple;
	bh=XNYfHPezAt39Q9HkLGgX1fw7EFYN3xqWiHkURM4M4qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCOYEZGt7SKRVDozwZBy80akz+YF4EQ3w1scpBVRMNpC+qSrYFpmtmIdCkxquqiDGYKp2WPInA18smyF4MGq/l1odZTNiI2tnOmW+0n76eEuHcXd2A1kw//aLEL03kusfom1fct9Fccr+kDX83/WBrL/h9I3ePjnIE70CELNTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA2ER8kD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA2ER8kD"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e87602f26aso27737b3.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106779; x=1781711579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdCsR60Q0yw3/aBQd4hO/4T5QCHVDjDG4lL/FPqyV50=;
        b=kA2ER8kD+bi6d86JtI5oYYfto6SMVOMtKeN3OZjwl5NgKCZxFfjWJvWIxNYBLVMieq
         pKf7/0p16RENfBkIbgvIgAmCaouJdWg6buerLiY+IC9r/Sf+QcZ6huG9moWOPknFlBVN
         YrZqhftiJeqEwuuG24ymZzgoP+oZ1mkfbl2QHuGoEsZvfpfXRnacqs4TVn0g3wAnNg1O
         3kuO2L8+7CkzTHlh4U2I0ZZXKaLElIXv2zdiuxmkhBgeveepYXxwLN7YnGEshOoBBUSC
         8gqAbCaX28p3j0xJPBoLhl5ZREv8pYfTvKKeHmGSu9WQIwLjBXB3PHo+DPHXfVhBOOJB
         rBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106779; x=1781711579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdCsR60Q0yw3/aBQd4hO/4T5QCHVDjDG4lL/FPqyV50=;
        b=b9yVzdTZuTLQb9S9ls6hQd0RzaSy41KYkz9nL9FojzT7SIi/961hiMbF7rThPcXGC8
         oH73BYBuRkwDk/fPO1KAdw/Ttx1I+Vx4c4kkuCt4ZLEmiZgKumXmaiGmNTmo9I7BD6pg
         Vg+iSAztu27JIC7FEgBins9fbnVdqA3zhqWIGSVPbnpwH41mMiAf6rCOBCUJwERQkXhU
         +V/wTqKDxckeCQkltiLoeV1GMD2oX3ZbBttO2oMwPqooXE0inmlDQnIA+zgjeRj38Zta
         wIkPOUOMqrFTfL80yPqQOWSv8U02xa8Yhb/61vm9iyRfu9nM3eXx+U14ylybDwBMBmG0
         N1AA==
X-Forwarded-Encrypted: i=1; AFNElJ/NPOMNHypVANXw2TZrNoLQcyQFdKIBtkdRmW4yhH7xZMXQZB/Uyh5LW7j13mdWyzFrvXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbx3lyU5c2sd+9TW3A4mq2yRanmbJaC0TrpBvTFgk3HxqTVIY
	ufRl9gK8DBZ91FiQ5sDVt7gwj/d2fMsOO46RSB9l2d3smbhpEoxpC3Xi
X-Gm-Gg: Acq92OH1H8UYhYns/pmq1UWGCLZKcD8927X86gtQpzyh5dZA3Zelx7M7p5gSkpHu8dh
	gxsnmGnTK6581Sk+gJxt23+KmXqrHxtOG3kfc8Av822c/fVhqJDXiwZ7RBMG2oE5vd8Zb4ujhV/
	arYyY5S4/AipkWKfAiJ5ztGDBrrzDq9Qp0U8O7sZCSv61H+bRFZ7n/0nRyI9EjT/87F9Qorlev1
	w0AmP3+10ayF9AEcMMAmfUBftrCemgNJ/w1t7FH8IgnTQANqbcr2T3zFjWEqRGIY7uWvmXpqEFm
	sg+/qwkjJ3QT7XcrmX5XZ3RB/Ix4WAm8f9zpMFxUvr7KyGYMDYXU4HJcr5cX66CK7S7dw5wIift
	iElFM2NQINL6MGtMB9/Yd1sCsEa84fj2KvpVdbDKNPXxZ1s7yFlrjFlKrTAUHkAkv7zlJ3BFlpG
	jTMZ3cArKYb0kwTWTQBk4srmDXDs4ekIy1SYMxfppvelGN5MFXSZbgIV6BQ91z87x3435qAKJ6Z
	fjgrns=
X-Received: by 2002:a05:690c:6087:b0:7e9:ea36:f256 with SMTP id 00721157ae682-7ed526f0135mr178686387b3.17.1781106779026;
        Wed, 10 Jun 2026 08:52:59 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f221:3708:8563:6234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a95b77sm111779107b3.34.2026.06.10.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:52:58 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: memxor@gmail.com,
	Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Add cgroup kptr NMI deadlock reproducer
Date: Wed, 10 Jun 2026 11:52:25 -0400
Message-ID: <20260610155225.1221740-1-utilityemal77@gmail.com>
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
regressed. The task variant only proved no hard hang; scanning kmsg
catches the bug even when the inline path does not actually wedge the
CPU.

This fails and causes a kernel splat prior to commit a3a81d247651
("bpf: Cancel special fields on map value recycle") in bpf-next/master.

Runs on x86 only: relies on PMU cycle counter NMIs and the
x86-specific nmi_handler tracepoint.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Sending this reproducer instead of the task one, since the task kptr
reproducer is more dependent on timing conditions and fails to
reproduce reliably if CONFIG_RCU_NOCB_CPU=n.

 .../cgroup_kptr_nmi_deadlock_repro.c          | 327 ++++++++++++++++++
 .../progs/cgroup_kptr_nmi_deadlock_repro.c    | 122 +++++++
 2 files changed, 449 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
new file mode 100644
index 000000000000..428e321865ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/compiler.h>
+#include <linux/limits.h>
+#include <linux/perf_event.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include <cgroup_helpers.h>
+#include <test_progs.h>
+
+#include "cgroup_kptr_nmi_deadlock_repro.skel.h"
+
+#define DELETE_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
+#define REPRO_ROUNDS 256
+#define REPRO_CPU 1
+#define REPRO_CGROUP_REL_PATH "/my_new_group"
+#define REPRO_CGROUP_MOUNT_PATH "/mnt"
+#define REPRO_CGROUP_WORK_DIR "/cgroup-test-work-dir"
+
+/*
+ * The reproducer relies on a PMU cycle counter to raise NMIs and on the
+ * x86-only nmi_handler tracepoint, so it only runs on x86.
+ */
+#if defined(__x86_64__) || defined(__i386__)
+
+static void close_fd(int fd)
+{
+	if (fd >= 0)
+		close(fd);
+}
+
+static int open_kmsg_at_end(void)
+{
+	int fd, saved_errno;
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -errno;
+	if (lseek(fd, 0, SEEK_END) == (off_t)-1) {
+		saved_errno = errno;
+		close(fd);
+		return -saved_errno;
+	}
+	return fd;
+}
+
+static bool kmsg_saw_splat(int fd)
+{
+	char buf[8192];
+	ssize_t n;
+	bool saw = false;
+
+	/* bpf_cgroup_release_dtor in any splat stack means NMI ran the dtor. */
+	while ((n = read(fd, buf, sizeof(buf) - 1)) > 0) {
+		buf[n] = '\0';
+		if (strstr(buf, "bpf_cgroup_release_dtor"))
+			saw = true;
+	}
+	return saw;
+}
+
+static void format_repro_cgroup_path(char *path, size_t path_sz,
+				     const char *relative_path)
+{
+	snprintf(path, path_sz, "%s%s%d%s", REPRO_CGROUP_MOUNT_PATH,
+		 REPRO_CGROUP_WORK_DIR, getpid(), relative_path);
+}
+
+static int create_repro_cgroup(char *cgroup_path, size_t cgroup_path_sz)
+{
+	format_repro_cgroup_path(cgroup_path, cgroup_path_sz,
+				 REPRO_CGROUP_REL_PATH);
+	if (mkdir(cgroup_path, 0777))
+		return -errno;
+
+	return 0;
+}
+
+static int remove_repro_cgroup(const char *cgroup_path)
+{
+	if (rmdir(cgroup_path))
+		return -errno;
+
+	return 0;
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
+	int pmu_fd;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, cpu,
+			 -1 /* group_fd */, 0 /* flags */);
+	if (pmu_fd == -1) {
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+			test__skip();
+		}
+		return -1;
+	}
+
+	return pmu_fd;
+}
+
+static bool pin_to_cpu(int cpu, cpu_set_t *old_cpuset)
+{
+	cpu_set_t cpuset;
+	int err;
+
+	err = sched_getaffinity(getpid(), sizeof(*old_cpuset), old_cpuset);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return false;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	err = sched_setaffinity(getpid(), sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "sched_setaffinity"))
+		return false;
+
+	return true;
+}
+
+static void restore_affinity(const cpu_set_t *old_cpuset)
+{
+	sched_setaffinity(getpid(), sizeof(*old_cpuset), old_cpuset);
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
+static struct cgroup_kptr_nmi_deadlock_repro *open_loaded_repro_skel(void)
+{
+	struct cgroup_kptr_nmi_deadlock_repro *skel;
+	int err;
+
+	skel = cgroup_kptr_nmi_deadlock_repro__open();
+	if (!ASSERT_OK_PTR(skel, "cgroup_kptr_nmi_deadlock_repro__open"))
+		return NULL;
+
+	err = cgroup_kptr_nmi_deadlock_repro__load(skel);
+	if (!ASSERT_OK(err, "cgroup_kptr_nmi_deadlock_repro__load"))
+		goto destroy_skel;
+
+	return skel;
+
+destroy_skel:
+	cgroup_kptr_nmi_deadlock_repro__destroy(skel);
+	return NULL;
+}
+
+static bool wait_for_cgroup_nmi_delete_batch(struct cgroup_kptr_nmi_deadlock_repro *skel,
+					     int expected_deleted)
+{
+	u64 now_ns, timeout_time_ns;
+
+	now_ns = get_time_ns();
+	timeout_time_ns = now_ns + DELETE_TIMEOUT_NS;
+	while (skel->bss->cgroup_kptr_nmi_deleted < expected_deleted) {
+		burn_cpu();
+		now_ns = get_time_ns();
+		if (now_ns >= timeout_time_ns)
+			break;
+	}
+
+	if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_deleted, expected_deleted,
+		       "cgroup_kptr_nmi_deleted"))
+		return false;
+	if (!ASSERT_LT(now_ns, timeout_time_ns,
+		       "cgroup_kptr_nmi_delete_timeout"))
+		return false;
+
+	return true;
+}
+
+static bool wait_for_cgroup_css_free_batch(struct cgroup_kptr_nmi_deadlock_repro *skel,
+					   int expected_done)
+{
+	u64 now_ns, timeout_time_ns;
+
+	now_ns = get_time_ns();
+	timeout_time_ns = now_ns + DELETE_TIMEOUT_NS;
+	while (skel->bss->cgroup_kptr_nmi_killed_work_done < expected_done) {
+		burn_cpu();
+		now_ns = get_time_ns();
+		if (now_ns >= timeout_time_ns)
+			break;
+	}
+
+	if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_killed_work_done, expected_done,
+		       "cgroup_kptr_nmi_killed_work_done"))
+		return false;
+	if (!ASSERT_LT(now_ns, timeout_time_ns,
+		       "cgroup_kptr_nmi_css_free_timeout"))
+		return false;
+
+	return true;
+}
+
+static void run_cgroup_kptr_nmi_deadlock_repro(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct cgroup_kptr_nmi_deadlock_repro *skel = NULL;
+	cpu_set_t old_cpuset;
+	char cgroup_path[PATH_MAX + 1];
+	bool pinned = false;
+	int pmu_fd = -1;
+	int kmsg_fd = -1;
+	int round;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		return;
+
+	skel = open_loaded_repro_skel();
+	if (!skel)
+		goto cleanup_cgroup_env;
+
+	pinned = pin_to_cpu(REPRO_CPU, &old_cpuset);
+	if (!pinned)
+		goto destroy_skel;
+
+	skel->links.clear_cgroup_kptrs_from_nmi =
+		bpf_program__attach_trace(skel->progs.clear_cgroup_kptrs_from_nmi);
+	if (!ASSERT_OK_PTR(skel->links.clear_cgroup_kptrs_from_nmi,
+			   "attach_tp_btf"))
+		goto destroy_skel;
+
+	skel->links.mark_cgroup_killed_work_done =
+		bpf_program__attach_trace(skel->progs.mark_cgroup_killed_work_done);
+	if (!ASSERT_OK_PTR(skel->links.mark_cgroup_killed_work_done,
+			   "attach_css_free_rwork_fexit"))
+		goto destroy_skel;
+
+	pmu_fd = open_nmi_pmu_event_on_cpu(REPRO_CPU);
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
+		int err;
+
+		err = create_repro_cgroup(cgroup_path, sizeof(cgroup_path));
+		if (!ASSERT_OK(err, "create_repro_cgroup"))
+			goto destroy_skel;
+
+		skel->bss->cgroup_kptr_nmi_id = get_cgroup_id(REPRO_CGROUP_REL_PATH);
+		if (!ASSERT_NEQ(skel->bss->cgroup_kptr_nmi_id, 0,
+				"get_cgroup_id"))
+			goto destroy_skel;
+
+		err = bpf_prog_test_run_opts(
+			bpf_program__fd(skel->progs.insert_cgroup_kptr_from_syscall),
+			&opts);
+		if (!ASSERT_OK(err, "insert_cgroup_kptr_from_syscall"))
+			goto destroy_skel;
+		if (!ASSERT_EQ(opts.retval, 0,
+			       "insert_cgroup_kptr_from_syscall_retval"))
+			goto destroy_skel;
+
+		if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_err, 0,
+			       "cgroup_kptr_nmi_err"))
+			goto destroy_skel;
+		if (!ASSERT_EQ(skel->bss->cgroup_kptr_nmi_inserted,
+			       expected_inserted,
+			       "cgroup_kptr_nmi_inserted"))
+			goto destroy_skel;
+
+		expected_css_free = skel->bss->cgroup_kptr_nmi_clear_runs;
+
+		err = remove_repro_cgroup(cgroup_path);
+		if (!ASSERT_OK(err, "remove_repro_cgroup"))
+			goto destroy_skel;
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
+		restore_affinity(&old_cpuset);
+	close_fd(kmsg_fd);
+	close_fd(pmu_fd);
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
index 000000000000..94404a59e086
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,122 @@
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
+int insert_cgroup_kptr_from_syscall(void *ctx)
+{
+	struct cgroup_map_value init = {};
+	struct cgroup_map_value *mapval;
+	struct cgroup *cgrp, *old;
+	struct cgroup_subsys_state *css;
+	__u32 key = 0;
+	int nonself_csses = 0;
+	int i;
+	int ret;
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
+			nonself_csses++;
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
+	old = bpf_kptr_xchg(&mapval->cgrp, cgrp);
+	/*
+	 * After the fix, deleting a map element no longer eagerly frees its
+	 * referenced kptr; the field is left attached and the slot's memory may
+	 * be recycled by this update with the previous cgroup still stashed.
+	 * Drain that leftover reference instead of flagging it as an error.
+	 */
+	if (old)
+		bpf_cgroup_release(old);
+
+	cgroup_kptr_nmi_inserted++;
+	cgroup_kptr_nmi_clear_runs += nonself_csses;
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

base-commit: 2e8ad1ff712d2a397e407c9fde60901f68d077dc
-- 
2.54.0

