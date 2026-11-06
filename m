Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959133;
	b=j8uko+jxnmg7JPCggGp+rL+PfUaW5+iENZISvh2Y0gO1gr/Jx9W/++0punHfe/OuHDSB
	 Nl3/rL/tmtCrVZ32WvSgY7uAaFBvlL6fpEFeU2c0OAYXfDJJG+9eovf9YsnRqO3pu46tf
	 9AEcA59h8yizsmyc/sNaR9IzO//6iDxihCKld/y9i4iGHQkeTG8Tj7/UIkZqkPbZ2/fMp
	 dVjXsXjQvRO9lEhIPqCcxCUm5TdKAUKEu6TX+PhbUdy9WP1EICtSvpzZsbPHdjeCy2ySj
	 +RVMIxtjcU0irXFa0zhVFcm/4sOLVCqWDeBmbQJvaYU6Hm7awjie8gKqqRHZs/k0ReQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=kyfGUNn7JBhu3pEcr6qcWN+PMeEkA+M3QerAMyz6Xio=;
	b=AGP0D9yOjao88RLrA+mZVLh8e28OIKbVDO1/pP/7iYOs4+yAM2zoVVKL73fa7xIkRae2
	 V528EU4f115Y9fSCemnub4XgXqputvOZ4GEVVG96OGzzxyAKh81nDIuKDt35XiqNMYoSU
	 DpB2Olb4Ve5EacKGeN+8QlmW51UhttKpstvX0SPLLUMHZrPjXkZ4FhApZ+pZOuCDBtyn/
	 Wa5R28K1vVE5wAgnuwuZSMc4oiPdGEVWqpGuVBA+veFXK3M9IlkKn/sdLShBEjJPOXLT0
	 f0NToAcc4d/nLFV+XGgXVkB8l6/B+svBQtcMJpUOlbBXB1WB+WYhkt97hisKegCTohg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DC6r9Y9S;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190B606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2190B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DC6r9Y9S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ky
	fGUNn7JBhu3pEcr6qcWN+PMeEkA+M3QerAMyz6Xio=; b=DC6r9Y9S/FlTP7f4zE
	MhEExpcQFxrI37N3ZHV2NGpNiIt+DoGcMHNIInx0JuJWdTYAm1idOMWI209LGwrg
	Lh4sWZACmOgTA0Ip/1+zs0BMCLbz0w16AlSRHEWnwNIXSrrBMlqJM6sVBu0F/ZiG
	fH7RBQ9QN26K6lOLLyy1mTBYY=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S5;
	Fri, 06 Nov 2026 17:58:00 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/8] selftests/bpf: Check task work value membership
Date: Fri,  6 Nov 2026 17:57:42 +0800
Message-ID: <20261106095747.471718-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3KrWUtF1DtF48Wr17tF4fZrb_yoW8Cw4rKo
	Z3Wr1rAw18Xr90y3y8W3s7AF1fuaykKFnrXr4YgrWDA3Wjka4SkryDGw47J3W7ZF1rt3Zx
	uF4vqan3uFs7Jryrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU33CzDUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AhpOGrtpKjCggAA3+

From: Yun Lu <luyun@kylinos.cn>

Exercise scheduling through value pointers retained across deletion,
replacement and same-key reinsertion. The lookup fix must reject a value
that is no longer the current member, including preallocated values that
previously accepted a new context after cancellation.

Add 46 subtests for both notification modes across HASH with and without
preallocation, RHASH, LRU HASH and ARRAY. Require -ENOENT for removed
values; record old/new addresses to distinguish replacement from a
same-address reinsertion, which is the current member. Also cover live
in-place updates, BPF_F_LOCK updates and last-user-reference cleanup
followed by reopening the map by ID.

Repeat removal after a successful live schedule to exercise a populated
slot as well as the initial empty one. The callback counts deliveries
without dereferencing key or value, so the negative comparison does not
deliberately access removed storage from the BPF callback.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../bpf/prog_tests/task_work_membership.c     | 392 ++++++++++++++++++
 .../bpf/progs/task_work_membership.c          | 158 +++++++
 2 files changed, 550 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_membership.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_membership.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_membership.c b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c
new file mode 100644
index 000000000000..0f5cdef3a24c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+#include <test_progs.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include "task_work_membership.skel.h"
+
+#define REUSE_ROUNDS 8
+#define COMPLETION_WAIT_NS 2000000000ULL
+#define COMPLETION_WAIT_ITERS 2000
+
+struct membership_value {
+	__u64 data;
+	struct bpf_task_work tw;
+};
+
+struct lock_value {
+	__u64 data;
+	struct bpf_spin_lock lock;
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
+static int run_prog_ret(struct bpf_program *prog, bool *ok)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	*ok = ASSERT_OK(err, "test_run");
+	return *ok ? (__s32)opts.retval : 0;
+}
+
+static __u64 completed(struct task_work_membership *skel)
+{
+	return __atomic_load_n(&skel->bss->completed, __ATOMIC_ACQUIRE);
+}
+
+static bool wait_completed(struct task_work_membership *skel, __u64 expected)
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
+static struct task_work_membership *open_test(enum bpf_map_type type, __u32 flags,
+					      bool use_signal)
+{
+	struct task_work_membership *skel;
+	int err;
+
+	skel = task_work_membership__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+	err = bpf_map__set_type(skel->maps.values, type);
+	if (!ASSERT_OK(err, "map_type"))
+		goto fail;
+	err = bpf_map__set_map_flags(skel->maps.values, flags);
+	if (!ASSERT_OK(err, "map_flags"))
+		goto fail;
+	/* A full LRU map can evict the target while obtaining a candidate. */
+	if (type == BPF_MAP_TYPE_LRU_HASH) {
+		err = bpf_map__set_max_entries(skel->maps.values, 2);
+		if (!ASSERT_OK(err, "map_max_entries"))
+			goto fail;
+	}
+	if (!ASSERT_OK(task_work_membership__load(skel), "load"))
+		goto fail;
+	skel->bss->use_signal = use_signal;
+	return skel;
+fail:
+	task_work_membership__destroy(skel);
+	return NULL;
+}
+
+static bool insert_value(struct task_work_membership *skel)
+{
+	struct membership_value value = {};
+	int key = 0;
+
+	return ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.values),
+					     &key, &value, BPF_ANY), "insert");
+}
+
+static bool insert_lock_value(struct task_work_membership *skel)
+{
+	struct lock_value value = {};
+	int key = 0;
+
+	return ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.lock_values),
+					     &key, &value, BPF_ANY), "insert_lock");
+}
+
+static void retired_value(enum bpf_map_type type, __u32 flags, bool use_signal,
+			  bool replace)
+{
+	struct task_work_membership *skel;
+	struct bpf_program *mutate;
+	bool ok;
+	int i;
+
+	skel = open_test(type, flags, use_signal);
+	if (!skel)
+		return;
+	mutate = replace ? skel->progs.update_then_schedule :
+			   skel->progs.delete_then_schedule;
+	if (!insert_value(skel))
+		goto out;
+
+	for (i = 0; i < REUSE_ROUNDS; i++) {
+		/* Later rounds start with a ctx left by the live schedule below. */
+		ok = run_prog(mutate, -ENOENT);
+		if (replace)
+			fprintf(stderr,
+				"replace address map_type=%d old=%#llx new=%#llx\n",
+				(int)type,
+				(unsigned long long)skel->bss->old_value,
+				(unsigned long long)skel->bss->new_value);
+		if (!ok ||
+		    !ASSERT_OK(skel->bss->mutation_err, "mutation") ||
+		    !ASSERT_EQ(completed(skel), i, "retired_not_called"))
+			goto out;
+		if (replace)
+			ASSERT_NEQ(skel->bss->old_value, skel->bss->new_value,
+				   "replace_address");
+		if (!replace && !insert_value(skel))
+			goto out;
+		if (!run_prog(skel->progs.schedule_live, 0) ||
+		    !wait_completed(skel, i + 1))
+			goto out;
+	}
+out:
+	task_work_membership__destroy(skel);
+}
+
+static void live_update(enum bpf_map_type type, __u32 flags, bool use_signal)
+{
+	struct task_work_membership *skel;
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
+	task_work_membership__destroy(skel);
+}
+
+static void reinsert(enum bpf_map_type type, __u32 flags, bool use_signal)
+{
+	struct task_work_membership *skel;
+	bool ok;
+	int ret;
+
+	skel = open_test(type, flags, use_signal);
+	if (!skel)
+		return;
+	if (!insert_value(skel))
+		goto out;
+	ret = run_prog_ret(skel->progs.reinsert_then_schedule, &ok);
+	fprintf(stderr, "%s address map_type=%d old=%#llx new=%#llx same=%d\n",
+		__func__, (int)type, (unsigned long long)skel->bss->old_value,
+		(unsigned long long)skel->bss->new_value,
+		skel->bss->old_value == skel->bss->new_value);
+	if (!ok || !ASSERT_OK(skel->bss->mutation_err, "mutation"))
+		goto out;
+
+	if (skel->bss->old_value == skel->bss->new_value) {
+		/* Same-address reinsertion is the current member. */
+		if (!ASSERT_EQ(ret, 0, "same_address_retval"))
+			goto out;
+		wait_completed(skel, 1);
+	} else {
+		ASSERT_EQ(ret, -ENOENT, "different_address_retval");
+		ASSERT_EQ(completed(skel), 0, "different_address_not_called");
+	}
+out:
+	task_work_membership__destroy(skel);
+}
+
+static void lock_update(__u32 flags, bool use_signal)
+{
+	struct task_work_membership *skel;
+	int err;
+
+	skel = task_work_membership__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	err = bpf_map__set_map_flags(skel->maps.lock_values, flags);
+	if (!ASSERT_OK(err, "lock_map_flags"))
+		goto out;
+	if (!ASSERT_OK(task_work_membership__load(skel), "load"))
+		goto out;
+	skel->bss->use_signal = use_signal;
+	if (!insert_lock_value(skel) ||
+	    !run_prog(skel->progs.lock_schedule_live, 0) ||
+	    !wait_completed(skel, 1))
+		goto out;
+	if (!run_prog(skel->progs.lock_update_then_schedule, 0) ||
+	    !ASSERT_OK(skel->bss->mutation_err, "lock_update"))
+		goto out;
+	wait_completed(skel, 2);
+out:
+	task_work_membership__destroy(skel);
+}
+
+static void uref_reopen(enum bpf_map_type type, __u32 flags, bool used)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct task_work_membership *skel;
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
+	if (!run_prog(skel->progs.schedule_live, -EBUSY))
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
+	task_work_membership__destroy(skel);
+}
+
+static void usercnt_zero_deleted(enum bpf_map_type type, __u32 flags, bool use_signal)
+{
+	struct task_work_membership *skel;
+	int map_fd, null_fd = -1;
+
+	skel = open_test(type, flags, use_signal);
+	if (!skel)
+		return;
+	if (!insert_value(skel))
+		goto out;
+	map_fd = bpf_map__fd(skel->maps.values);
+	null_fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_GE(null_fd, 0, "open_dev_null"))
+		goto out;
+	if (!ASSERT_EQ(dup3(null_fd, map_fd, O_CLOEXEC), map_fd, "drop_uref"))
+		goto out;
+	/*
+	 * Membership is checked before the usercnt policy: a deleted value
+	 * returns -ENOENT even after the last user reference is gone.
+	 */
+	if (!run_prog(skel->progs.delete_then_schedule, -ENOENT))
+		goto out;
+	ASSERT_OK(skel->bss->mutation_err, "delete");
+out:
+	if (null_fd >= 0)
+		close(null_fd);
+	task_work_membership__destroy(skel);
+}
+
+void test_task_work_membership(void)
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
+	char name[96];
+	int signal, i, used;
+
+	for (signal = 0; signal < 2; signal++) {
+		const char *mode = signal ? "signal" : "resume";
+
+		snprintf(name, sizeof(name), "hash_delete_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC, signal, false);
+		snprintf(name, sizeof(name), "prealloc_hash_delete_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, 0, signal, false);
+		snprintf(name, sizeof(name), "rhash_delete_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, signal, false);
+		snprintf(name, sizeof(name), "lru_delete_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_LRU_HASH, 0, signal, false);
+		snprintf(name, sizeof(name), "hash_replace_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC, signal, true);
+		snprintf(name, sizeof(name), "prealloc_hash_replace_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_HASH, 0, signal, true);
+		snprintf(name, sizeof(name), "lru_replace_%s", mode);
+		if (test__start_subtest(name))
+			retired_value(BPF_MAP_TYPE_LRU_HASH, 0, signal, true);
+		snprintf(name, sizeof(name), "hash_reinsert_%s", mode);
+		if (test__start_subtest(name))
+			reinsert(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "prealloc_hash_reinsert_%s", mode);
+		if (test__start_subtest(name))
+			reinsert(BPF_MAP_TYPE_HASH, 0, signal);
+		snprintf(name, sizeof(name), "lru_reinsert_%s", mode);
+		if (test__start_subtest(name))
+			reinsert(BPF_MAP_TYPE_LRU_HASH, 0, signal);
+		snprintf(name, sizeof(name), "rhash_update_%s", mode);
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "array_update_%s", mode);
+		if (test__start_subtest(name))
+			live_update(BPF_MAP_TYPE_ARRAY, 0, signal);
+		snprintf(name, sizeof(name), "lock_hash_update_%s", mode);
+		if (test__start_subtest(name))
+			lock_update(BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "lock_hash_prealloc_update_%s", mode);
+		if (test__start_subtest(name))
+			lock_update(0, signal);
+		snprintf(name, sizeof(name), "usercnt_zero_deleted_hash_%s", mode);
+		if (test__start_subtest(name))
+			usercnt_zero_deleted(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "usercnt_zero_deleted_prealloc_hash_%s", mode);
+		if (test__start_subtest(name))
+			usercnt_zero_deleted(BPF_MAP_TYPE_HASH, 0, signal);
+		snprintf(name, sizeof(name), "usercnt_zero_deleted_rhash_%s", mode);
+		if (test__start_subtest(name))
+			usercnt_zero_deleted(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, signal);
+		snprintf(name, sizeof(name), "usercnt_zero_deleted_lru_%s", mode);
+		if (test__start_subtest(name))
+			usercnt_zero_deleted(BPF_MAP_TYPE_LRU_HASH, 0, signal);
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
diff --git a/tools/testing/selftests/bpf/progs/task_work_membership.c b/tools/testing/selftests/bpf/progs/task_work_membership.c
new file mode 100644
index 000000000000..025f8c1bfb70
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_membership.c
@@ -0,0 +1,158 @@
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
+struct lock_elem {
+	__u64 data;
+	struct bpf_spin_lock lock;
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
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct lock_elem);
+} lock_values SEC(".maps");
+
+bool use_signal;
+int mutation_err;
+__u64 old_value;
+__u64 new_value;
+__u64 completed;
+
+static int callback(struct bpf_map *map, void *key, void *value)
+{
+	/* Count deliveries without dereferencing a possibly removed value. */
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
+static __always_inline int schedule_lock_value(struct lock_elem *value)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (use_signal)
+		return bpf_task_work_schedule_signal(task, &value->tw, &lock_values, callback);
+	return bpf_task_work_schedule_resume(task, &value->tw, &lock_values, callback);
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
+	old_value = (u64)(long)value;
+	mutation_err = bpf_map_update_elem(&values, &key, &replacement, BPF_EXIST);
+	if (mutation_err)
+		return mutation_err;
+	new_value = (u64)(long)bpf_map_lookup_elem(&values, &key);
+
+	/* HASH replaces the element; RHASH and ARRAY update it in place. */
+	return schedule_value(value);
+}
+
+SEC("syscall")
+int reinsert_then_schedule(void *ctx)
+{
+	struct elem replacement = {};
+	int key = 0;
+	struct elem *value = bpf_map_lookup_elem(&values, &key);
+
+	if (!value)
+		return -EINVAL;
+	mutation_err = bpf_map_delete_elem(&values, &key);
+	if (mutation_err)
+		return mutation_err;
+	mutation_err = bpf_map_update_elem(&values, &key, &replacement, BPF_ANY);
+	if (mutation_err)
+		return mutation_err;
+
+	old_value = (u64)(long)value;
+	new_value = (u64)(long)bpf_map_lookup_elem(&values, &key);
+	return schedule_value(value);
+}
+
+SEC("syscall")
+int lock_schedule_live(void *ctx)
+{
+	int key = 0;
+	struct lock_elem *value = bpf_map_lookup_elem(&lock_values, &key);
+
+	return value ? schedule_lock_value(value) : -EINVAL;
+}
+
+SEC("syscall")
+int lock_update_then_schedule(void *ctx)
+{
+	struct lock_elem replacement = {};
+	int key = 0;
+	struct lock_elem *value = bpf_map_lookup_elem(&lock_values, &key);
+
+	if (!value)
+		return -EINVAL;
+	mutation_err = bpf_map_update_elem(&lock_values, &key, &replacement,
+					   BPF_EXIST | BPF_F_LOCK);
+	if (mutation_err)
+		return mutation_err;
+
+	return schedule_lock_value(value);
+}
-- 
2.43.0

