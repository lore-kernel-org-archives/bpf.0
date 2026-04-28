Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEB3D522F
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407290; cv=none; b=kPn1DEW+QmE67kvsGA3Tyk2ZzfXvj+QKHq2FZePCj6jTo/wb4FOtD9r7wWUSCsgihMXxLc+gWqXe2Lbw6yaxhLPkpAxilmhQ8K668bPIBDpbRFKwGHclEALaj/TK7ssdz9uNqsUpk02Jyj1jAhfCQNVUUXtKD9se7W75lEK6tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407290; c=relaxed/simple;
	bh=H6/fFNCWCRNNtsjnJPPYasgrF17g6bCBqXn3uaCHFlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4YumwxojWxy2VPwAVtwfUYXhxOvsxr5ywRZ8W4sYixBD3sZhDQfyDlu/dcZ3zK1l6X/yQxcdVqD7rtqbXlHBi+7WkjoG3+ib9Bo6x5RXPHsIjuogzT1QAd6cohGQoZcTwQNAZLxS9HVAMv8AXyI48gynOnsoKu32fuLpa+3kIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujj6A2jn; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujj6A2jn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501547d7edso11183641d50.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407288; x=1778012088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5iPCIdsRc2OD6JB1BiV1fQ5oIWv30ykYCfZE5LfCMA=;
        b=Ujj6A2jnYE0SOgNalLTBW0zaXUpdxp2QxTm3S/XFx4rmdYzXxTQ2RITJI2c/NFW+hd
         e62RaFrQe6WLvTaBLbJGNGSjADKYGogAFwgqx4Hj2XpsoWmbTaik+92VAK1qWeTbWdbi
         WWpkti69HLxM9EVDGV0mgsfQzqvBagG+IIyD0+fzym0cP+zZgepsUYCArJ9tw1k2/GaD
         YRU2rn/hwn5cg8DbbbS093Ldt3tat8iSgZrioo/U9MmuAYmitYSWSfTTPj3AXomLn4sp
         HL85Vo/v8yUigJMyktsXi+EktZCIdUECAeoD0YXk3IISTWnJj0fhiAeEtipKCuBhaqGm
         2Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407288; x=1778012088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5iPCIdsRc2OD6JB1BiV1fQ5oIWv30ykYCfZE5LfCMA=;
        b=UWcv05A2F05MlsyDXzra/FECSfimOiBVAePYzIQ05glcUzbrH5VhN0M6mal0B6g8N9
         Vs9UuZ8n5B2LKHYCkzzgzwul5F4Q1XQV3oKFZZ9d1MWoAZSfV6d5u4S7iMncq75m9/D2
         HiMlVaELv1h5BcRxl9hq9YrwlzpHdLjEtfHbzMwtRi8SyNVM5zxCOurUUf8h4VWsmD3D
         aJQYWT8eTy2/fpr8/HttOfr0FJKCjdb5zD4no04uMHsw5Pa27lSe1PDFMDG2JYDyO3NZ
         IMwj+sBQEY3DvB6UY7neXmYsj3ioaqCj9ZBobkOjgdCE9rIz7VAFXJbgGdVScTtQF8EU
         TceA==
X-Forwarded-Encrypted: i=1; AFNElJ/U7oCmtPAGcnvV2hCoJbvG1w2lVbfirQFAPuJvQZhyuQC7csT2NPT8k6IkwndqrlAfsIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9r7vAJNYEz9y+WrMWb5kolOgK+ax+Xsz3KP6pwmNX5tpdQv0
	fxX7rfOncp/l8ByZD1aO84UxZdVKwdr/ZKiGp87K2UQP27ZTmxevBUZm
X-Gm-Gg: AeBDiesfxqH3y0smWN/AHKr2ZBdHJUJRcGEfUnek92wt9AbxhF0I/CWel+zecp+YRzS
	BLI6ToEY/RQpGSHX4IinxPFlUYBKQQRAjcZZBzHFG9pURCqW0s3GePEowdIb/SffpyQ7nKAyHFn
	vgwKXLKLH/fkIUAmEQHSk04FQtlag9KJ9qe42s3kBombq99wbZlbBHLC581x/ECTguKIeS9An46
	W+V+YVEL144EidBHmhyfNgAjoU/6VHx8Iva2+QkMg1gUhlkBue6l1hyXXe/ZTHoEaI0k/wOgq+h
	3l4V77gHFzixpGoVeP7bgbcZXrf6e8C2vRw4IQFBDyIm68G0nllCgWEZWGIjQROI2EfP8kqRcjY
	WichIOy0MnwKeoqh50rZ7dYjGMh2RsWbfP5UBy77nuHgynd+fG+Yp/MDp1T0oEUnKP3IiW3yESK
	mctBXfO8aEY8WLqUh+CwH7c7yi/UN0cprLAeEP+rYxKxwTnEAboN873xMEPSKCLOrmUZYVBnNkO
	HUix2TaxW7dSev5lgT2bw==
X-Received: by 2002:a05:690c:4806:b0:79a:4419:71bb with SMTP id 00721157ae682-7bcf5214ee4mr46137527b3.21.1777407287608;
        Tue, 28 Apr 2026 13:14:47 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4c60:c627:eabb:73c3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25af5385sm1392077b3.48.2026.04.28.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:14:47 -0700 (PDT)
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
	Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add kptr nmi deadlock reproducer
Date: Tue, 28 Apr 2026 16:14:22 -0400
Message-ID: <20260428201422.1518903-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428201422.1518903-1-utilityemal77@gmail.com>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a deadlock reproducer for task struct kptrs.

Test artificially triggers NMI events while freeing the last
reference to a task.

Verify that program completes successfully without deadlocking.

Test for array and hash map types.

Note that this test intentionally does racy operations between
userspace and BPF. Some error codes were left unused in case this
test is to be extended to other map types with different ordering
semantics.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: GPT-4.5-Medium github-copilot-cli
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../prog_tests/task_kptr_nmi_deadlock_repro.c | 305 ++++++++++++++++++
 .../bpf/progs/task_kptr_nmi_deadlock_repro.c  | 217 +++++++++++++
 2 files changed, 522 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro.c b/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro.c
new file mode 100644
index 000000000000..9f99e9a0a138
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/perf_event.h>
+#include <sched.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <bpf/btf.h>
+#include <test_progs.h>
+
+#include "task_kptr_nmi_deadlock_repro.skel.h"
+
+#define STASHED_TASKS 4
+#define DELETE_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
+#define REPRO_ROUNDS 256
+
+enum task_kptr_nmi_map_type {
+	TASK_KPTR_NMI_MAP_HASH = 1,
+	TASK_KPTR_NMI_MAP_ARRAY,
+};
+
+enum task_kptr_nmi_err {
+	TASK_KPTR_NMI_ACQUIRE_ERR = 1,
+	TASK_KPTR_NMI_CREATE_ERR,
+	TASK_KPTR_NMI_LOOKUP_ERR,
+	TASK_KPTR_NMI_MAP_ERR,
+};
+
+struct task_kptr_nmi_repro_case {
+	const char *name;
+	__u32 map_type;
+};
+
+static int find_test_cpu(void)
+{
+	cpu_set_t cpuset;
+	int cpu, err;
+
+	err = sched_getaffinity(0, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return -1;
+
+	for (cpu = 1; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &cpuset))
+			return cpu;
+	}
+
+	ASSERT_TRUE(false, "cpu_available");
+	return -1;
+}
+
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
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, cpu,
+			 -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
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
+static bool has_nmi_handler_btf(void)
+{
+	struct btf *btf;
+	int id;
+
+	btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(btf)) {
+		printf("SKIP:no vmlinux BTF\n");
+		test__skip();
+		return false;
+	}
+
+	id = btf__find_by_name_kind(btf, "nmi_handler", BTF_KIND_FUNC);
+	btf__free(btf);
+	if (id <= 0) {
+		printf("SKIP:no BTF FUNC nmi_handler\n");
+		test__skip();
+		return false;
+	}
+
+	return true;
+}
+
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
+static void restore_affinity(const cpu_set_t *old_cpuset)
+{
+	ASSERT_OK(sched_setaffinity(0, sizeof(*old_cpuset), old_cpuset),
+		  "restore_affinity");
+}
+
+static bool stash_exited_tasks(struct task_kptr_nmi_deadlock_repro *skel)
+{
+	int i, status;
+
+	for (i = 0; i < STASHED_TASKS; i++) {
+		int pipefd[2];
+		char sync;
+		pid_t child_pid;
+
+		if (!ASSERT_OK(pipe2(pipefd, O_CLOEXEC), "pipe2"))
+			return false;
+
+		child_pid = fork();
+		if (!ASSERT_GT(child_pid, -1, "fork")) {
+			close(pipefd[0]);
+			close(pipefd[1]);
+			return false;
+		}
+
+		if (child_pid == 0) {
+			char sync;
+			int fd;
+
+			close(pipefd[1]);
+			if (read(pipefd[0], &sync, 1) != 1)
+				_exit(127);
+			close(pipefd[0]);
+			fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+			if (fd < 0)
+				_exit(127);
+			close(fd);
+			_exit(0);
+		}
+
+		close(pipefd[0]);
+		skel->bss->task_kptr_nmi_pids[i] = child_pid;
+
+		sync = 1;
+		if (!ASSERT_EQ(write(pipefd[1], &sync, 1), 1, "start_child")) {
+			close(pipefd[1]);
+			waitpid(child_pid, &status, 0);
+			return false;
+		}
+		close(pipefd[1]);
+
+		if (!ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid,
+			       "waitpid"))
+			return false;
+		if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+			return false;
+		if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child_status"))
+			return false;
+	}
+
+	return true;
+}
+
+static bool
+wait_for_task_nmi_delete_batch(struct task_kptr_nmi_deadlock_repro *skel,
+			       int expected_deleted)
+{
+	u64 now_ns, timeout_time_ns;
+	unsigned long burn = 0;
+	int i;
+
+	now_ns = get_time_ns();
+	timeout_time_ns = now_ns + DELETE_TIMEOUT_NS;
+	for (i = 0; skel->bss->task_kptr_nmi_deleted < expected_deleted; i++) {
+		int j;
+
+		if (skel->bss->task_kptr_nmi_delete_err)
+			break;
+		for (j = 0; j < 1000000; j++)
+			burn += j + i;
+		now_ns = get_time_ns();
+		if (now_ns >= timeout_time_ns)
+			break;
+	}
+
+	if (!ASSERT_EQ(skel->bss->task_kptr_nmi_delete_err, 0,
+		       "task_kptr_nmi_delete_err"))
+		return false;
+	if (!ASSERT_GE(skel->bss->task_kptr_nmi_deleted, expected_deleted,
+		       "task_kptr_nmi_deleted"))
+		return false;
+	if (!ASSERT_LT(now_ns, timeout_time_ns, "task_kptr_nmi_delete_timeout"))
+		return false;
+
+	return true;
+}
+
+static void run_task_kptr_nmi_deadlock_repro_case(const struct task_kptr_nmi_repro_case *test)
+{
+	struct task_kptr_nmi_deadlock_repro *skel;
+	cpu_set_t old_cpuset;
+	bool pinned = false;
+	__u32 expected_deleted = 0;
+	int cpu = -1;
+	int pmu_fd = -1;
+	int err, round;
+
+	if (!has_nmi_handler_btf())
+		return;
+
+	cpu = find_test_cpu();
+	if (cpu < 0)
+		return;
+
+	skel = task_kptr_nmi_deadlock_repro__open();
+	if (!ASSERT_OK_PTR(skel, "task_kptr_nmi_deadlock_repro__open"))
+		return;
+
+	skel->bss->task_kptr_nmi_map_type = test->map_type;
+	bpf_program__set_autoload(skel->progs.clear_task_kptrs_from_nmi, true);
+
+	err = task_kptr_nmi_deadlock_repro__load(skel);
+	if (!ASSERT_OK(err, "task_kptr_nmi_deadlock_repro__load"))
+		goto cleanup;
+
+	if (bpf_program__fd(skel->progs.clear_task_kptrs_from_nmi) < 0) {
+		test__skip();
+		goto cleanup;
+	}
+
+	err = task_kptr_nmi_deadlock_repro__attach(skel);
+	if (!ASSERT_OK(err, "task_kptr_nmi_deadlock_repro__attach"))
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
+	for (round = 0; round < REPRO_ROUNDS; round++) {
+		if (!stash_exited_tasks(skel))
+			goto cleanup;
+
+		/*
+		 * Hash map inserts create an empty element before looking it up
+		 * to stash the task kptr. NMI cleanup can delete that fresh
+		 * element in between, so LOOKUP_ERR here is a benign test race
+		 * and not a kernel failure.
+		 */
+		if (test->map_type == TASK_KPTR_NMI_MAP_HASH &&
+		    skel->bss->task_kptr_nmi_err == TASK_KPTR_NMI_LOOKUP_ERR)
+			skel->bss->task_kptr_nmi_err = 0;
+
+		if (!ASSERT_EQ(skel->bss->task_kptr_nmi_err, 0, "task_kptr_nmi_err"))
+			goto cleanup;
+		expected_deleted = skel->bss->task_kptr_nmi_inserted;
+		if (!wait_for_task_nmi_delete_batch(skel, expected_deleted))
+			goto cleanup;
+	}
+
+cleanup:
+	close(pmu_fd);
+	if (pinned)
+		restore_affinity(&old_cpuset);
+	task_kptr_nmi_deadlock_repro__destroy(skel);
+}
+
+void serial_test_task_kptr_nmi_deadlock_repro(void)
+{
+	static const struct task_kptr_nmi_repro_case tests[] = {
+		{ "hash", TASK_KPTR_NMI_MAP_HASH },
+		{ "array", TASK_KPTR_NMI_MAP_ARRAY },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		run_task_kptr_nmi_deadlock_repro_case(&tests[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c b/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c
new file mode 100644
index 000000000000..1ba27d9c3044
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_TARGET_PIDS 4
+
+enum {
+	TASK_KPTR_NMI_MAP_HASH = 1,
+	TASK_KPTR_NMI_MAP_ARRAY,
+};
+
+enum {
+	TASK_KPTR_NMI_ACQUIRE_ERR = 1,
+	TASK_KPTR_NMI_CREATE_ERR,
+	TASK_KPTR_NMI_LOOKUP_ERR,
+	TASK_KPTR_NMI_MAP_ERR,
+};
+
+struct task_map_value {
+	struct task_struct __kptr * task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct task_map_value);
+	__uint(max_entries, MAX_TARGET_PIDS);
+} stashed_tasks_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct task_map_value);
+	__uint(max_entries, MAX_TARGET_PIDS);
+} stashed_tasks_array SEC(".maps");
+
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+__u32 task_kptr_nmi_pids[MAX_TARGET_PIDS];
+__u8 task_kptr_nmi_live[MAX_TARGET_PIDS];
+__u32 task_kptr_nmi_map_type;
+__u32 task_kptr_nmi_inserted;
+__u32 task_kptr_nmi_deleted;
+__u32 task_kptr_nmi_err;
+int task_kptr_nmi_delete_err;
+
+static __always_inline int find_target_slot(__u32 pid)
+{
+	int i;
+
+	for (i = 0; i < MAX_TARGET_PIDS; i++) {
+		if (task_kptr_nmi_pids[i] == pid)
+			return i;
+	}
+
+	return -1;
+}
+
+static __always_inline void stash_task(int i, struct task_map_value *slot,
+				       struct task_struct *acquired)
+{
+	struct task_struct *old;
+
+	old = bpf_kptr_xchg(&slot->task, acquired);
+	if (old)
+		bpf_task_release(old);
+	else {
+		task_kptr_nmi_live[i] = 1;
+		task_kptr_nmi_inserted++;
+	}
+}
+
+static __always_inline void set_delete_err(int err)
+{
+	if (!task_kptr_nmi_delete_err)
+		task_kptr_nmi_delete_err = err;
+}
+
+SEC("lsm.s/file_open")
+int insert_task_kptr_from_lsm(struct file *ctx_file)
+{
+	struct task_map_value init = {};
+	struct task_map_value *slot;
+	struct task_struct *task, *acquired;
+	__u32 pid;
+	int i, ret;
+
+	(void)ctx_file;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	i = find_target_slot(pid);
+	if (i < 0)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	acquired = bpf_task_acquire(task);
+	if (!acquired) {
+		task_kptr_nmi_err = TASK_KPTR_NMI_ACQUIRE_ERR;
+		return 0;
+	}
+
+	/*
+	 * Race is OK for these specific map types. Userspace may
+	 * have modified the array, causing inconsistency. This
+	 * error TASK_KPTR_NMI_CREATE_ERR is non-fatal for test
+	 * purposes. But may be important if this test is
+	 * extended for other map types.
+	 */
+	switch (task_kptr_nmi_map_type) {
+	case TASK_KPTR_NMI_MAP_HASH:
+		pid = i;
+		ret = bpf_map_update_elem(&stashed_tasks_hash, &pid, &init,
+					  BPF_NOEXIST);
+		if (ret && ret != -EEXIST) {
+			task_kptr_nmi_err = TASK_KPTR_NMI_CREATE_ERR;
+			goto release_task;
+		}
+		slot = bpf_map_lookup_elem(&stashed_tasks_hash, &pid);
+		if (!slot) {
+			task_kptr_nmi_err = TASK_KPTR_NMI_LOOKUP_ERR;
+			goto release_task;
+		}
+		break;
+	case TASK_KPTR_NMI_MAP_ARRAY:
+		pid = i;
+		slot = bpf_map_lookup_elem(&stashed_tasks_array, &pid);
+		if (!slot) {
+			task_kptr_nmi_err = TASK_KPTR_NMI_LOOKUP_ERR;
+			goto release_task;
+		}
+		break;
+	default:
+		task_kptr_nmi_err = TASK_KPTR_NMI_MAP_ERR;
+		goto release_task;
+	}
+
+	stash_task(i, slot, acquired);
+	return 0;
+
+release_task:
+	bpf_task_release(acquired);
+	return 0;
+}
+
+static __always_inline void clear_hash_tasks(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_TARGET_PIDS; i++) {
+		__u32 slot = i;
+
+		if (!task_kptr_nmi_pids[i])
+			continue;
+		if (!bpf_map_delete_elem(&stashed_tasks_hash, &slot)) {
+			task_kptr_nmi_live[i] = 0;
+			task_kptr_nmi_deleted++;
+		} else if (bpf_map_lookup_elem(&stashed_tasks_hash, &slot)) {
+			set_delete_err(-EIO);
+		}
+	}
+}
+
+static __always_inline void clear_array_tasks(void)
+{
+	struct task_map_value init = {};
+	int i;
+
+	for (i = 0; i < MAX_TARGET_PIDS; i++) {
+		__u32 slot = i;
+
+		if (!task_kptr_nmi_pids[i])
+			continue;
+		if (bpf_map_update_elem(&stashed_tasks_array, &slot, &init,
+					BPF_EXIST)) {
+			set_delete_err(-EIO);
+			continue;
+		}
+		if (task_kptr_nmi_live[i]) {
+			task_kptr_nmi_live[i] = 0;
+			task_kptr_nmi_deleted++;
+		}
+	}
+}
+
+SEC("?tp_btf/nmi_handler")
+int BPF_PROG(clear_task_kptrs_from_nmi, void *handler, void *regs, s64 delta_ns,
+	     int handled)
+{
+	(void)handler;
+	(void)regs;
+	(void)delta_ns;
+	(void)handled;
+
+	if (task_kptr_nmi_deleted >= task_kptr_nmi_inserted)
+		return 0;
+
+	switch (task_kptr_nmi_map_type) {
+	case TASK_KPTR_NMI_MAP_HASH:
+		clear_hash_tasks();
+		break;
+	case TASK_KPTR_NMI_MAP_ARRAY:
+		clear_array_tasks();
+		break;
+	default:
+		task_kptr_nmi_err = TASK_KPTR_NMI_MAP_ERR;
+		break;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

