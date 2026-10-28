Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173006;
	b=0NIH/D0ztOP3uDuoOoipUwnWVTZBd+lJGF8D5DRlAd086qgEbqqf8X3xolVousSNbZmm
	 gnii0afhElkWJVuNb1kt8cLhE1L6rqsimOM838dVRhWiahX0Bvr0CrGKHaE2TNkYsq6Va
	 1SHS2V6bJkdQe9LacYn9q0TlS/YR7IsNAtdHWJnd1K0f5L3+IqzDjqAtaYBHRLtTHKpmZ
	 KZpfoa1ZegfSC6Z/4Y6cYk1nwgDxsk8Qrqs0ndD1Nmr9NWeCISPcjPP6onVlQOQ3g5SEo
	 ttNr5a4lcT4si5bScuyopyNQ68lUUeFC8Uhk715MxnE4Ky3lT6ZCxz/dBdjk9A7aJCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173006;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=yfK2jzQUerhSjLsRGgiw7mZM4o4ZRrozaZSYzwaaumc=;
	b=Hf38S9T6gp7aykHCBlwDBqLzGFnHMzo4LXKEQIJNnouxuR8O0+6KGo+MWL8GUHF5VGQo
	 d7WbgslczEjaD2ZQq8fzbdyIQn7ICeUB4B75aZ7KUYOSsn74RQFyRuRJ4hPihYCXh2mpb
	 0x5dSerBzQdjgs3YddQNd6V2yTp/+8/zHnThEgqttYbeYl27Q7HS/C0xnjlbX8DNMSgJc
	 HYQqa4DxyizmuimaTBAIrx6jThYcYoSGIu0v5DR8p3yUYLr1/gjgG3TgDIjnDBxOD2ws0
	 ljjKdcMfuff3Sluyl1uRHIaU7J7RfOl+09L+M0RwpfKTfLXWP+N5dKwiUthXM4zuvuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mJx6JI2Q;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C37606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 07:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mJx6JI2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yf
	K2jzQUerhSjLsRGgiw7mZM4o4ZRrozaZSYzwaaumc=; b=mJx6JI2Q8GroOrbmXf
	StgpobRVcucxbtT9fnD+XI9sMjIhi0r/dLn/ty015R3/QbtuYYSKRx2MZRpecKKz
	97PoEhMuhtWLR3fTrFeEsGepNBdEXH6n0hDHyyjrV7uEP1HZQ2eNov+62CQ3Pg65
	ViYShJSJT+eyhsdwTKOTUiDXk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL1DDpeFqcENQDg--.35047S4;
	Wed, 28 Oct 2026 15:35:36 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: bpf@vger.kernel.org
Cc: Yun Lu <luyun@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check task work scheduling on
Date: Wed, 28 Oct 2026 15:35:25 +0800
Message-ID: <20261028073525.1035605-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028073525.1035605-1-luyun_611@163.com>
References: <20261028073525.1035605-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL1DDpeFqcENQDg--.35047S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3tF43GrW8GFy3KFy5Kr4xtFb_yoW8JFWUWo
	WfWr4fCw18Gr90y3y8W3s7JFyrW3ykK3ZrZr40grWDAa4jva4Ikrn7Gw47J34xZFyrtay3
	AFykXw1xuFs7JF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcGYLUUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AiufWrhpcg2ugAA3d

From: Yun Lu <luyun@kylinos.cn>

Keep a map value pointer across deletion or non-preallocated HASH
replacement in a syscall program, then require scheduling through the old
pointer to return -ENOENT. Run both TWA_RESUME and TWA_SIGNAL cases for
HASH deletion, RHASH deletion and HASH replacement.

Run 32 rounds per retirement case. The first exercises a slot with no
context; subsequent rounds exercise an idle context. After each mutation,
schedule on the live element and wait for its callback to check that
retirement does not prevent subsequent scheduling on live storage. This
does not assume that the allocator returns the same address.

Also check live updates on RHASH, ARRAY, preallocated HASH and LRU_HASH in
both notification modes. Keep a spare LRU slot so an update does not
evict the target while obtaining a candidate. Drop the last map user
reference and reopen each of the five map types by ID, covering both an
unused slot and one with a completed callback. Loaded programs keep the
map alive while its user reference count is zero. Reserve the old map FD
number with /dev/null until the reopened map FD is restored, so skeleton
cleanup cannot close an unrelated descriptor.

Target the calling task and wait with bounded polling and subsequent
syscalls. A successful scheduling call only queues irq_work, which may
publish the task work after test_run has returned. Returning from another
syscall gives TWA_RESUME a further opportunity to execute the callback.

The 24 subtests comprise six retirement cases, eight live-update cases
and ten uref-reopen cases. Without the fix, the six retirement cases fail
at the exact scheduling return-value assertion (0 instead of -ENOENT),
while the other 18 pass. With the fix all 24 pass. The callback only
increments a counter and does not dereference the old value, so the
unfixed-kernel comparison can safely test the retirement gate.

These are retirement and compatibility tests. They do not force physical
reclamation, allocator address reuse or concurrent cancellation.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../bpf/prog_tests/task_work_retire.c         | 240 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_retire.c    |  84 ++++++
 2 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_retire.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_retire.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_retire.c b/tools/testing/selftests/bpf/prog_tests/task_work_retire.c
new file mode 100644
index 000000000000..af7637749a06
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_work_retire.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+#include <test_progs.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include "task_work_retire.skel.h"
+
+#define REUSE_ROUNDS 32
+#define COMPLETION_WAIT_NS 2000000000ULL
+#define COMPLETION_WAIT_ITERS 2000
+
+struct retire_value {
+	__u64 data;
+	struct bpf_task_work tw;
+};
+
+static bool run_prog(struct bpf_program *prog, int expected)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	return ASSERT_OK(err, "test_run") &&
+	       ASSERT_EQ((__s32)opts.retval, expected, "retval");
+}
+
+static __u64 completed(struct task_work_retire *skel)
+{
+	return __atomic_load_n(&skel->bss->completed, __ATOMIC_ACQUIRE);
+}
+
+static bool wait_completed(struct task_work_retire *skel, __u64 expected)
+{
+	__u64 deadline = get_time_ns() + COMPLETION_WAIT_NS;
+	__u64 count;
+	int i;
+
+	for (i = 0; i < COMPLETION_WAIT_ITERS; i++) {
+		/* irq_work may enqueue task work after test_run returned. */
+		syscall(__NR_gettid); /* Give TWA_RESUME another return to user mode. */
+		count = completed(skel);
+		if (count >= expected)
+			return ASSERT_EQ(count, expected, "completed");
+		if (get_time_ns() >= deadline)
+			break;
+		usleep(1000);
+	}
+	return ASSERT_EQ(completed(skel), expected, "callback_timeout");
+}
+
+static struct task_work_retire *open_test(enum bpf_map_type type, __u32 flags,
+					  bool use_signal)
+{
+	struct task_work_retire *skel;
+	int err;
+
+	skel = task_work_retire__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+	err = bpf_map__set_type(skel->maps.values, type);
+	if (!ASSERT_OK(err, "map_type"))
+		goto fail;
+	err = bpf_map__set_map_flags(skel->maps.values, flags);
+	if (!ASSERT_OK(err, "map_flags"))
+		goto fail;
+	/* A full LRU map evicts the target in prealloc_lru_pop() before the
+	 * BPF_EXIST lookup, so keep one spare slot for the update cases.
+	 */
+	if (type == BPF_MAP_TYPE_LRU_HASH) {
+		err = bpf_map__set_max_entries(skel->maps.values, 2);
+		if (!ASSERT_OK(err, "map_max_entries"))
+			goto fail;
+	}
+	if (!ASSERT_OK(task_work_retire__load(skel), "load"))
+		goto fail;
+	/* __open() already exposes the skeleton BSS mapping; writing after
+	 * load keeps the mode next to the other post-load setup.
+	 */
+	skel->bss->use_signal = use_signal;
+	return skel;
+fail:
+	task_work_retire__destroy(skel);
+	return NULL;
+}
+
+static bool insert_value(struct task_work_retire *skel)
+{
+	struct retire_value value = {};
+	int key = 0;
+
+	return ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.values),
+					   &key, &value, BPF_ANY), "insert");
+}
+
+static void retired_value(enum bpf_map_type type, bool use_signal, bool replace)
+{
+	struct task_work_retire *skel;
+	struct bpf_program *mutate;
+	int i;
+
+	skel = open_test(type, BPF_F_NO_PREALLOC, use_signal);
+	if (!skel)
+		return;
+	mutate = replace ? skel->progs.update_then_schedule :
+			   skel->progs.delete_then_schedule;
+	if (!insert_value(skel))
+		goto out;
+
+	for (i = 0; i < REUSE_ROUNDS; i++) {
+		/* First round has no ctx; later rounds have an idle ctx. */
+		if (!run_prog(mutate, -ENOENT) ||
+		    !ASSERT_OK(skel->bss->mutation_err, "mutation") ||
+		    !ASSERT_EQ(completed(skel), i, "retired_not_called"))
+			goto out;
+		if (!replace && !insert_value(skel))
+			goto out;
+		if (!run_prog(skel->progs.schedule_live, 0) ||
+		    !wait_completed(skel, i + 1))
+			goto out;
+	}
+out:
+	task_work_retire__destroy(skel);
+}
+
+static void live_update(enum bpf_map_type type, __u32 flags, bool use_signal)
+{
+	struct task_work_retire *skel;
+
+	skel = open_test(type, flags, use_signal);
+	if (!skel)
+		return;
+	if (!insert_value(skel) || !run_prog(skel->progs.schedule_live, 0) ||
+	    !wait_completed(skel, 1))
+		goto out;
+	if (!run_prog(skel->progs.update_then_schedule, 0) ||
+	    !ASSERT_OK(skel->bss->mutation_err, "update"))
+		goto out;
+	wait_completed(skel, 2);
+out:
+	task_work_retire__destroy(skel);
+}
+
+static void uref_reopen(enum bpf_map_type type, __u32 flags, bool used)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct task_work_retire *skel;
+	int map_fd, null_fd = -1, reopened_fd = -1;
+	int err;
+
+	skel = open_test(type, flags, false);
+	if (!skel)
+		return;
+	if (!insert_value(skel))
+		goto out;
+	if (used && (!run_prog(skel->progs.schedule_live, 0) ||
+		     !wait_completed(skel, 1)))
+		goto out;
+	map_fd = bpf_map__fd(skel->maps.values);
+	err = bpf_map_get_info_by_fd(map_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "map_info"))
+		goto out;
+	null_fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_GE(null_fd, 0, "open_dev_null"))
+		goto out;
+	/*
+	 * Drop the sole map FD, retaining only program references. Reserve
+	 * its number so skeleton cleanup cannot close an unrelated new FD.
+	 */
+	if (!ASSERT_EQ(dup3(null_fd, map_fd, O_CLOEXEC), map_fd, "drop_uref"))
+		goto out;
+	/* Leave the unused case uninitialized until after reopening. */
+	if (used && !run_prog(skel->progs.schedule_live, -EBUSY))
+		goto out;
+	reopened_fd = bpf_map_get_fd_by_id(info.id);
+	if (!ASSERT_GE(reopened_fd, 0, "reopen_by_id"))
+		goto out;
+	if (!ASSERT_EQ(dup3(reopened_fd, map_fd, O_CLOEXEC), map_fd, "restore_map_fd"))
+		goto out;
+	if (!run_prog(skel->progs.schedule_live, 0))
+		goto out;
+	wait_completed(skel, used ? 2 : 1);
+out:
+	if (reopened_fd >= 0)
+		close(reopened_fd);
+	if (null_fd >= 0)
+		close(null_fd);
+	task_work_retire__destroy(skel);
+}
+
+void test_task_work_retire(void)
+{
+	static const struct {
+		const char *name;
+		enum bpf_map_type type;
+		__u32 flags;
+	} maps[] = {
+		{ "hash", BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC },
+		{ "rhash", BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC },
+		{ "array", BPF_MAP_TYPE_ARRAY, 0 },
+		{ "prealloc_hash", BPF_MAP_TYPE_HASH, 0 },
+		{ "lru", BPF_MAP_TYPE_LRU_HASH, 0 },
+	};
+	char name[80];
+	int signal, i, used;
+
+	for (signal = 0; signal < 2; signal++) {
+		snprintf(name, sizeof(name), "hash_delete_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, signal, false);
+		snprintf(name, sizeof(name), "rhash_delete_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_RHASH, signal, false);
+		snprintf(name, sizeof(name), "hash_replace_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, signal, true);
+		snprintf(name, sizeof(name), "rhash_update_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "array_update_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_ARRAY, 0, signal);
+		snprintf(name, sizeof(name), "prealloc_hash_update_%s",
+			 signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_HASH, 0, signal);
+		snprintf(name, sizeof(name), "lru_update_%s", signal ? "signal" : "resume");
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_LRU_HASH, 0, signal);
+	}
+	for (i = 0; i < ARRAY_SIZE(maps); i++) {
+		for (used = 0; used < 2; used++) {
+			snprintf(name, sizeof(name), "%s_uref_reopen_%s", maps[i].name,
+				 used ? "used" : "unused");
+			if (test__start_subtest(name))
+				uref_reopen(maps[i].type, maps[i].flags, used);
+		}
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_retire.c b/tools/testing/selftests/bpf/progs/task_work_retire.c
new file mode 100644
index 000000000000..69dc19261724
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_retire.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	__u64 data;
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} values SEC(".maps");
+
+bool use_signal;
+int mutation_err;
+__u64 completed;
+
+static int callback(struct bpf_map *map, void *key, void *value)
+{
+	/* Also safe on the unfixed kernel: do not dereference key or value. */
+	__sync_fetch_and_add(&completed, 1);
+	return 0;
+}
+
+static __always_inline int schedule_value(struct elem *value)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (use_signal)
+		return bpf_task_work_schedule_signal(task, &value->tw, &values, callback);
+	return bpf_task_work_schedule_resume(task, &value->tw, &values, callback);
+}
+
+SEC("syscall")
+int schedule_live(void *ctx)
+{
+	int key = 0;
+	struct elem *value = bpf_map_lookup_elem(&values, &key);
+
+	return value ? schedule_value(value) : -EINVAL;
+}
+
+SEC("syscall")
+int delete_then_schedule(void *ctx)
+{
+	int key = 0;
+	struct elem *value = bpf_map_lookup_elem(&values, &key);
+
+	if (!value)
+		return -EINVAL;
+	mutation_err = bpf_map_delete_elem(&values, &key);
+	if (mutation_err)
+		return mutation_err;
+
+	/* test_run holds the trace read-side section across both operations. */
+	return schedule_value(value);
+}
+
+SEC("syscall")
+int update_then_schedule(void *ctx)
+{
+	struct elem replacement = {};
+	int key = 0;
+	struct elem *value = bpf_map_lookup_elem(&values, &key);
+
+	if (!value)
+		return -EINVAL;
+	mutation_err = bpf_map_update_elem(&values, &key, &replacement, BPF_EXIST);
+	if (mutation_err)
+		return mutation_err;
+
+	/* HASH replaces the element; RHASH and ARRAY update it in place. */
+	return schedule_value(value);
+}
-- 
2.43.0

