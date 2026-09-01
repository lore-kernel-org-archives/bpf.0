Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC673750DB;
	Tue,  1 Sep 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244221; cv=none; b=WAeaGG56YpUw/qf+qF22v+fI0P2zp1EfgiMV3jLniiIu/kjWhdDGCPhJS+wVXEqr/hc+F7YYCczASenguMNcs64qhOdR5WYPpUYgAnOQI/Fn9/Z+V9X+gc7j20JORFWFfhRrBnzidfMsoQDFRbqxwbbjv0Kfi0lOlvmoDHWogSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244221; c=relaxed/simple;
	bh=awYWRwZTpc803kJeb1VD2Jniuc1ElIjgAZiHBIqFLss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmmj+B8H8LhcAmKMVKjCI7JVdnnfKyVJMujD4BHojQsKxGT4zeoak15a1vovHuQicJZpkaF59xuUJIJO85BT2vJB7OUuMCwihFYWZbLDcirL68pOQByncVPA3da6PqCl5a1FF6iSVLXUcrqrv+ah1wGo6Go9yqy7P9Wf8278040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mJw7WJfc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mJw7WJfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A0
	wRnOe1OptnJji3/EBk4wcEzLHeWJp2ZtxElyEj4Xk=; b=mJw7WJfc3hZcdE2IfG
	QZhv6tMuoiLriEEtRlX3UGdJIgwjUghqWvyAwxBzaupaSNdO3NtQvPwHCuzZdHDF
	rWgw38/+Azc55h26xLzaaLGqSBOLTmcLVh/9NZVJSG/2OD+BzFCq1qMjTHEbKQXi
	2LfjyL5WI/BgHrbYSGLzn9Xdw=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n5+mcJZqA6mBNA--.25535S6;
	Tue, 01 Sep 2026 14:29:04 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Test rhtab special-field combinations
Date: Tue,  1 Sep 2026 14:28:45 +0800
Message-ID: <20260901062845.1379760-5-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901062845.1379760-1-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n5+mcJZqA6mBNA--.25535S6
X-Coremail-Antispam: 1Uf129KBjvAXoWfCFWDZFyktFyruFy8tF4Utwb_yoW8tFW8to
	Z3Ww45Za18GryvgFyvgFyvkF1rWayvg3srXF1Yg3y7Xa40kFy5ur9rCw47Xw17u3W09rWU
	ua4jq34fZF1fJFWrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFeHqDUUUU
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARCIRmqWcLB2YwAA32

From: Yuan Chen <chenyuan@kylinos.cn>

BPF_MAP_TYPE_RHASH allows spin locks, timers, workqueues, task_work,
kptrs (referenced, untrusted, per-cpu) and refcounts in map values.
The recycle fix only changes kptr slot handling, so verify each field
combination end to end:

  * lock_kptr: bpf_spin_lock + referenced kptr + plain data in one
    value. BPF_F_LOCK syscall updates/lookups must work before and
    after many delete/re-insert recycle cycles, the referenced kptr
    must be inherited on recycled elements (zeroing it would leak the
    reference), and the plain bytes must round-trip every iteration.
  * timer: arm a bpf_timer and verify it fires, delete the element and
    verify the timer is cancelled, then re-insert (possibly recycling
    the freed element) and arm a fresh timer again.
  * kptr_untrusted: the untrusted kptr must survive the recycle like a
    referenced one.
  * kptr_percpu: the per-cpu kptr reference must survive the recycle
    (zeroing it would leak the reference).

On the unfixed kernel the three kptr subtests fail at the recycle
assertions while the lock and timer paths still pass, isolating the
behavior change to kptr slots only.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../selftests/bpf/prog_tests/rhtab_fields.c   | 337 ++++++++++++++++
 .../selftests/bpf/progs/rhtab_fields.c        | 378 ++++++++++++++++++
 .../selftests/bpf/rhtab_fields_common.h       |  19 +
 3 files changed, 734 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/rhtab_fields_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
new file mode 100644
index 000000000000..93e8cbacca65
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "rhtab_fields.skel.h"
+#include "rhtab_fields_common.h"
+
+#define RECYCLE_LOOPS 2000
+
+/* Userspace view of the lkmap value. The BPF side owns the real layout;
+ * the spin lock and the kptr are special fields that value copies skip,
+ * so only the plain bytes actually matter here.
+ */
+struct lock_kptr_val_user {
+	__u32 lock;
+	__u32 pad;
+	__u64 tsk;
+	__u32 magic;
+	__u32 pad2;
+};
+
+_Static_assert(sizeof(struct lock_kptr_val_user) == 24, "lkmap layout drift");
+_Static_assert(offsetof(struct lock_kptr_val_user, magic) == 16,
+	       "lkmap magic offset drift");
+
+/*
+ * Zeroed value buffer shared by every create/update issued from userspace.
+ * The update syscall copies map->value_size bytes from this buffer (special
+ * fields among them), so a short stack variable would be read past its end;
+ * BSS is zero-filled and 64 bytes cover every map in the skeleton. Each
+ * caller re-checks the size to keep that true as maps are added.
+ */
+static __u8 zero_val[64];
+
+/* Cached CPU count and scratch buffer for percpu counter summation. */
+static __u64 *cpu_vals;
+static int ncpu;
+
+static __u64 read_counter(struct rhtab_fields *skel, __u32 idx)
+{
+	__u64 sum = 0;
+	int i, err;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.counters), &idx,
+				  cpu_vals);
+	if (!ASSERT_OK(err, "lookup_counter"))
+		return 0;
+	for (i = 0; i < ncpu; i++)
+		sum += cpu_vals[i];
+	return sum;
+}
+
+/*
+ * Run @name through BPF_PROG_TEST_RUN. Returns 0 on success and reports the
+ * program retval through @retval, so callers can tell a syscall failure,
+ * a prog that exited nonzero, and a prog that exited 0 apart.
+ */
+static int run_prog(struct rhtab_fields *skel, const char *name, int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_program *prog;
+	int err;
+
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, name))
+		return -1;
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_OK(err, name))
+		return -1;
+	if (retval)
+		*retval = topts.retval;
+	return 0;
+}
+
+/* run_prog() plus the assertion that the program exited 0. */
+static int run_prog_ok(struct rhtab_fields *skel, const char *name)
+{
+	int retval = -1;
+
+	if (!ASSERT_OK(run_prog(skel, name, &retval), name))
+		return -1;
+	if (!ASSERT_EQ(retval, 0, name))
+		return -1;
+	return 0;
+}
+
+/* Create one element filled with zero_val in @map. */
+static int create_zero_elem(struct bpf_map *map, const char *name)
+{
+	__u32 key = 0;
+	int fd;
+
+	if (!ASSERT_LE(bpf_map__value_size(map), sizeof(zero_val),
+		       "value_size_fits"))
+		return -1;
+	fd = bpf_map__fd(map);
+	return bpf_map_update_elem(fd, &key, zero_val, BPF_ANY);
+}
+
+static void recycle_loop(struct rhtab_fields *skel, int map_fd,
+			 const char *init, const char *del,
+			 const char *upd, const char *probe,
+			 int *retries)
+{
+	__u32 key = 0;
+	int i;
+
+	for (i = 0; i < RECYCLE_LOOPS; i++) {
+		if (run_prog_ok(skel, init) != 0) {
+			/* init fails only if the element is missing, which
+			 * must not happen in this single-threaded loop. Count
+			 * it so a rhtab bug cannot be absorbed silently; the
+			 * caller asserts the count is zero.
+			 */
+			(*retries)++;
+			if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key,
+							   zero_val, BPF_ANY),
+				       "recreate_elem"))
+				return;
+			if (run_prog_ok(skel, init) != 0)
+				return;
+		}
+		if (run_prog_ok(skel, del) != 0)
+			return;
+		if (run_prog_ok(skel, upd) != 0)
+			return;
+		if (run_prog_ok(skel, probe) != 0)
+			return;
+	}
+}
+
+static void subtest_lock_kptr(struct rhtab_fields *skel)
+{
+	struct lock_kptr_val_user val = {};
+	struct lock_kptr_val_user out = {};
+	__u64 nonnull_before, total;
+	int map_fd, retries = 0;
+	__u32 key = 0;
+
+	map_fd = bpf_map__fd(skel->maps.lkmap);
+
+	if (!ASSERT_OK(create_zero_elem(skel->maps.lkmap, "create_elem"),
+		       "create_elem"))
+		return;
+
+	/* The spin lock must be usable from the syscall path (BPF_F_LOCK). */
+	val.magic = LK_MAGIC;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &val, BPF_F_LOCK),
+		       "locked_update"))
+		return;
+	if (!ASSERT_OK(bpf_map_lookup_elem_flags(map_fd, &key, &out, BPF_F_LOCK),
+		       "locked_lookup"))
+		return;
+	ASSERT_EQ(out.magic, LK_MAGIC, "locked_lookup_magic");
+
+	/*
+	 * Delete/re-insert recycle cycles: the referenced kptr must be
+	 * inherited on recycled elements (zeroing it would leak the
+	 * reference) and the plain magic bytes must round-trip every time.
+	 * Every iteration runs exactly one probe, so the two probe counters
+	 * must add up to the loop count; the magic check must hold on every
+	 * single probe.
+	 */
+	nonnull_before = read_counter(skel, 1);
+	recycle_loop(skel, map_fd, "lk_init", "lk_del", "lk_upd", "lk_probe",
+		     &retries);
+	ASSERT_EQ(retries, 0, "no_unexpected_recreate");
+	ASSERT_EQ(read_counter(skel, 0), RECYCLE_LOOPS, "lk_init_count");
+	total = read_counter(skel, 1) + read_counter(skel, 2);
+	ASSERT_EQ(total, RECYCLE_LOOPS, "lk_probe_count");
+	ASSERT_EQ(read_counter(skel, 3), RECYCLE_LOOPS,
+		  "recycle_magic_roundtrip");
+	ASSERT_GT(read_counter(skel, 1), nonnull_before,
+		  "recycle_xchg_non_null");
+
+	/* The spin lock must still work after many recycles. */
+	val.magic = LK_MAGIC + 1;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &val, BPF_F_LOCK),
+		       "post_recycle_locked_update"))
+		return;
+	memset(&out, 0, sizeof(out));
+	if (!ASSERT_OK(bpf_map_lookup_elem_flags(map_fd, &key, &out, BPF_F_LOCK),
+		       "post_recycle_locked_lookup"))
+		return;
+	ASSERT_EQ(out.magic, LK_MAGIC + 1, "post_recycle_locked_magic");
+}
+
+static void subtest_timer(struct rhtab_fields *skel)
+{
+	int fired, map_fd;
+	__u32 key = 0;
+
+	map_fd = bpf_map__fd(skel->maps.tmap);
+
+	if (!ASSERT_OK(create_zero_elem(skel->maps.tmap, "create_elem"),
+		       "create_elem"))
+		return;
+
+	/* 1. A short-delay timer must fire. */
+	skel->data->timer_delay_ns = 50000;
+	if (run_prog_ok(skel, "arm_timer") != 0)
+		return;
+	usleep(300000);
+	if (!ASSERT_GT(skel->bss->timer_fired, 0, "timer_fired_first"))
+		return;
+
+	/*
+	 * 2. The real cancellation test: arm a long-delay timer on a freshly
+	 * recycled element and delete the element while the timer is still
+	 * pending. If the delete failed to cancel it, the callback would run
+	 * before the sleep below ends. The element must be deleted and
+	 * recreated between arms: bpf_timer_init() returns -EBUSY on an
+	 * element whose timer has not been cancelled and freed yet.
+	 */
+	fired = skel->bss->timer_fired;
+	if (!ASSERT_OK(bpf_map_delete_elem(map_fd, &key),
+		       "delete_before_rearm"))
+		return;
+	if (!ASSERT_OK(create_zero_elem(skel->maps.tmap, "recreate_elem"),
+		       "recreate_before_rearm"))
+		return;
+	skel->data->timer_delay_ns = 200000000;
+	if (run_prog_ok(skel, "arm_timer") != 0)
+		return;
+	if (!ASSERT_OK(bpf_map_delete_elem(map_fd, &key),
+		       "delete_cancels_timer"))
+		return;
+	usleep(300000);
+	ASSERT_EQ(skel->bss->timer_fired, fired, "timer_cancelled_after_delete");
+
+	/* 3. A recycled element can arm and fire a fresh timer again. */
+	skel->data->timer_delay_ns = 50000;
+	if (!ASSERT_OK(create_zero_elem(skel->maps.tmap, "recreate_elem"),
+		       "recreate_second"))
+		return;
+	if (run_prog_ok(skel, "arm_timer") != 0)
+		return;
+	usleep(300000);
+	ASSERT_GT(skel->bss->timer_fired, fired, "timer_fired_second");
+}
+
+struct kptr_recycle_case {
+	const char *name;
+	struct bpf_map **map;
+	const char *init;
+	const char *del;
+	const char *upd;
+	const char *probe;
+	__u32 init_idx;    /* counter bumped on every successful init */
+	__u32 nonnull_idx; /* counter bumped when the kptr was inherited */
+	__u32 null_idx;    /* counter bumped when the kptr was not inherited */
+	__u32 marker_idx;  /* percpu data roundtrip counter, 0 if none */
+};
+
+static void subtest_kptr_recycle(struct rhtab_fields *skel,
+				 const struct kptr_recycle_case *c)
+{
+	__u64 nonnull_before, total;
+	struct bpf_map *map;
+	int map_fd, retries = 0;
+
+	map = *c->map;
+	map_fd = bpf_map__fd(map);
+
+	if (!ASSERT_OK(create_zero_elem(map, "create_elem"), "create_elem"))
+		return;
+
+	/* The kptr must survive the recycle without leaking its reference,
+	 * exactly like the referenced kptr in the lkmap subtest.
+	 */
+	nonnull_before = read_counter(skel, c->nonnull_idx);
+	recycle_loop(skel, map_fd, c->init, c->del, c->upd, c->probe,
+		     &retries);
+	ASSERT_EQ(retries, 0, "no_unexpected_recreate");
+	ASSERT_EQ(read_counter(skel, c->init_idx), RECYCLE_LOOPS,
+		  "init_count");
+	total = read_counter(skel, c->nonnull_idx) +
+		read_counter(skel, c->null_idx);
+	ASSERT_EQ(total, RECYCLE_LOOPS, "probe_count");
+	ASSERT_GT(read_counter(skel, c->nonnull_idx), nonnull_before,
+		  "recycle_non_null");
+	/* The marker read is CPU-local, so assert at least one hit. */
+	if (c->marker_idx)
+		ASSERT_GT(read_counter(skel, c->marker_idx), 0,
+			  "recycle_data_roundtrip");
+}
+
+static void subtest_kptr_recycles(struct rhtab_fields *skel)
+{
+	const struct kptr_recycle_case cases[] = {
+		{ .name = "kptr_untrusted", .map = &skel->maps.umap,
+		  .init = "u_init", .del = "u_del", .upd = "u_upd",
+		  .probe = "u_probe", .init_idx = 4, .nonnull_idx = 5,
+		  .null_idx = 6 },
+		{ .name = "kptr_percpu", .map = &skel->maps.pcmap,
+		  .init = "pc_init", .del = "pc_del", .upd = "pc_upd",
+		  .probe = "pc_probe", .init_idx = 7, .nonnull_idx = 8,
+		  .null_idx = 9, .marker_idx = 10 },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (test__start_subtest(cases[i].name))
+			subtest_kptr_recycle(skel, &cases[i]);
+	}
+}
+
+void test_rhtab_fields(void)
+{
+	struct rhtab_fields *skel;
+
+	ncpu = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(ncpu, 0, "num_possible_cpus"))
+		return;
+	cpu_vals = calloc(ncpu, sizeof(*cpu_vals));
+	if (!ASSERT_OK_PTR(cpu_vals, "calloc_cpu_vals"))
+		return;
+
+	skel = rhtab_fields__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load")) {
+		free(cpu_vals);
+		return;
+	}
+
+	if (test__start_subtest("lock_kptr"))
+		subtest_lock_kptr(skel);
+	if (test__start_subtest("timer"))
+		subtest_timer(skel);
+	subtest_kptr_recycles(skel);
+
+	rhtab_fields__destroy(skel);
+	free(cpu_vals);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhtab_fields.c b/tools/testing/selftests/bpf/progs/rhtab_fields.c
new file mode 100644
index 000000000000..f8bcd88b7f34
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhtab_fields.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+/*
+ * Combined special-field tests for BPF_MAP_TYPE_RHASH. Each map carries a
+ * different field combination and is exercised through delete/re-insert
+ * cycles so the bpf memory allocator recycles element memory:
+ *
+ *  1. lkmap: bpf_spin_lock + referenced kptr + plain data in one value.
+ *     After every recycle the spin lock must still be usable (initialized by
+ *     the alloc path), the referenced kptr must be inherited instead of
+ *     zeroed (zeroing would leak the reference), and the plain bytes must
+ *     round-trip.
+ *  2. tmap: bpf_timer. The delete path must cancel a timer that is still
+ *     pending (the delay is tunable through timer_delay_ns so userspace can
+ *     arm a long timer and delete the element before it fires), and a
+ *     recycled element must be able to arm a fresh timer again.
+ *  3. umap: untrusted (unreferenced) kptr. The inherited pointer must be
+ *     preserved on recycle, matching hash map behavior.
+ *  4. pcmap: per-cpu kptr. Like the referenced kptr, the per-cpu reference
+ *     must not be dropped on recycle, and the object's contents must
+ *     survive the recycle round-trip.
+ *
+ * The delete programs check that the element really disappeared, otherwise
+ * the following update would be an in-place update whose value copy skips
+ * the special fields, and the surviving kptr would prove nothing about the
+ * recycle path.
+ */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "rhtab_fields_common.h"
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct lock_kptr_val {
+	struct bpf_spin_lock lock;
+	struct task_struct __kptr *tsk;
+	__u32 magic;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 16);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct lock_kptr_val);
+} lkmap SEC(".maps");
+
+struct timer_val {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 16);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct timer_val);
+} tmap SEC(".maps");
+
+struct unref_val {
+	struct task_struct __kptr_untrusted *tsk;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 16);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct unref_val);
+} umap SEC(".maps");
+
+struct pcval {
+	__u64 v;
+};
+
+struct pcpu_val {
+	struct pcval __percpu_kptr *pc;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 16);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct pcpu_val);
+} pcmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 11);
+	__type(key, __u32);
+	__type(value, __u64);
+} counters SEC(".maps");
+
+/*  0: lk init ok,       1: lk probe xchg non-NULL,  2: lk probe xchg NULL,
+ *  3: lk probe magic ok,
+ *  4: u init ok,        5: u probe ptr non-NULL,    6: u probe ptr NULL,
+ *  7: pc init ok,       8: pc probe xchg non-NULL,  9: pc probe xchg NULL,
+ * 10: pc probe data roundtrip
+ */
+static __always_inline void bump(u32 idx)
+{
+	u64 *v = bpf_map_lookup_elem(&counters, &idx);
+
+	if (v)
+		(*v)++;
+}
+
+extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+/* Tunable from userspace (an initialized global lands in .data, so the
+ * driver writes it through skel->data, not skel->bss).
+ */
+int timer_delay_ns = 50000;
+int timer_fired;
+
+/* Map 1: spin lock + referenced kptr + plain data. */
+
+SEC("syscall")
+int lk_init(void *ctx)
+{
+	struct lock_kptr_val *val;
+	struct task_struct *task, *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&lkmap, &key);
+	if (!val)
+		return 1;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 2;
+	old = bpf_kptr_xchg(&val->tsk, task);
+	if (old)
+		bpf_task_release(old);
+	bump(0);
+	return 0;
+}
+
+SEC("syscall")
+int lk_del(void *ctx)
+{
+	u32 key = 0;
+
+	if (bpf_map_delete_elem(&lkmap, &key))
+		return 1;
+	/* The element must really be gone: otherwise the following lk_upd()
+	 * is an in-place update on the surviving element and the kptr that
+	 * lk_probe() then observes never went through a recycle.
+	 */
+	if (bpf_map_lookup_elem(&lkmap, &key))
+		return 2;
+	return 0;
+}
+
+SEC("syscall")
+int lk_upd(void *ctx)
+{
+	struct lock_kptr_val val = { .magic = LK_MAGIC };
+	u32 key = 0;
+
+	/* BPF_ANY is safe even though the value holds a spin lock: value
+	 * copies skip special fields, so the lock word is never written and
+	 * the prog side does not need to take the lock for an update.
+	 */
+	bpf_map_update_elem(&lkmap, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("syscall")
+int lk_probe(void *ctx)
+{
+	struct lock_kptr_val *val;
+	struct task_struct *old;
+	__u32 magic;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&lkmap, &key);
+	if (!val)
+		return 1;
+	/* Take the lock directly: a recycled element that came back with a
+	 * corrupted lock word deadlocks here instead of passing. Helpers are
+	 * forbidden while the lock is held, so the xchg stays outside.
+	 */
+	bpf_spin_lock(&val->lock);
+	magic = val->magic;
+	bpf_spin_unlock(&val->lock);
+	old = bpf_kptr_xchg(&val->tsk, NULL);
+	if (old) {
+		bpf_task_release(old);
+		bump(1);
+	} else {
+		bump(2);
+	}
+	if (magic == LK_MAGIC)
+		bump(3);
+	return 0;
+}
+
+/* Map 2: bpf_timer. */
+
+static int timer_cb(void *map, void *key, struct timer_val *value)
+{
+	timer_fired++;
+	return 0;
+}
+
+SEC("syscall")
+int arm_timer(void *ctx)
+{
+	struct timer_val *val;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&tmap, &key);
+	if (!val)
+		return 1;
+	/* 1 == CLOCK_MONOTONIC */
+	if (bpf_timer_init(&val->timer, &tmap, 1))
+		return 2;
+	bpf_timer_set_callback(&val->timer, timer_cb);
+	if (bpf_timer_start(&val->timer, timer_delay_ns, 0))
+		return 3;
+	return 0;
+}
+
+/* Map 3: untrusted kptr. */
+
+SEC("syscall")
+int u_init(void *ctx)
+{
+	struct unref_val *val;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&umap, &key);
+	if (!val)
+		return 1;
+	val->tsk = bpf_get_current_task_btf();
+	bump(4);
+	return 0;
+}
+
+SEC("syscall")
+int u_del(void *ctx)
+{
+	u32 key = 0;
+
+	if (bpf_map_delete_elem(&umap, &key))
+		return 1;
+	if (bpf_map_lookup_elem(&umap, &key))
+		return 2;
+	return 0;
+}
+
+SEC("syscall")
+int u_upd(void *ctx)
+{
+	struct unref_val val = {};
+	u32 key = 0;
+
+	bpf_map_update_elem(&umap, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("syscall")
+int u_probe(void *ctx)
+{
+	struct unref_val *val;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&umap, &key);
+	if (!val)
+		return 1;
+	if (val->tsk)
+		bump(5);
+	else
+		bump(6);
+	val->tsk = NULL;
+	return 0;
+}
+
+/* Map 4: per-cpu kptr. */
+
+SEC("syscall")
+int pc_init(void *ctx)
+{
+	struct pcpu_val *val;
+	struct pcval *p, *cp, *q, *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&pcmap, &key);
+	if (!val)
+		return 1;
+	p = bpf_percpu_obj_new(struct pcval);
+	if (!p)
+		return 2;
+	old = bpf_kptr_xchg(&val->pc, p);
+	if (old)
+		bpf_percpu_obj_drop(old);
+	/* After the xchg the slot holds p, so q aliases p. Syscall progs are
+	 * sleepable, so the kptr field load only yields a trusted per-cpu
+	 * view under an explicit RCU read lock.
+	 */
+	bpf_rcu_read_lock();
+	q = val->pc;
+	if (q) {
+		cp = bpf_this_cpu_ptr(q);
+		cp->v = PC_MAGIC;
+	}
+	bpf_rcu_read_unlock();
+	bump(7);
+	return 0;
+}
+
+SEC("syscall")
+int pc_del(void *ctx)
+{
+	u32 key = 0;
+
+	if (bpf_map_delete_elem(&pcmap, &key))
+		return 1;
+	if (bpf_map_lookup_elem(&pcmap, &key))
+		return 2;
+	return 0;
+}
+
+SEC("syscall")
+int pc_upd(void *ctx)
+{
+	struct pcpu_val val = {};
+	u32 key = 0;
+
+	bpf_map_update_elem(&pcmap, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("syscall")
+int pc_probe(void *ctx)
+{
+	struct pcpu_val *val;
+	struct pcval *cp, *q, *old;
+	u32 key = 0;
+	int marker = 0;
+
+	val = bpf_map_lookup_elem(&pcmap, &key);
+	if (!val)
+		return 1;
+	/* The object was freshly allocated and marked by pc_init() within
+	 * the same iteration, so an inherited object must still carry the
+	 * marker; q aliases old until the drop. Read the marker under the
+	 * RCU read lock (which makes the field load trusted) and before the
+	 * xchg NULLs the field. The read is CPU-local and the loop may
+	 * migrate between CPUs, so userspace only asserts that this fired
+	 * at least once.
+	 */
+	bpf_rcu_read_lock();
+	q = val->pc;
+	if (q) {
+		cp = bpf_this_cpu_ptr(q);
+		if (cp->v == PC_MAGIC)
+			marker = 1;
+	}
+	bpf_rcu_read_unlock();
+	old = bpf_kptr_xchg(&val->pc, NULL);
+	if (old) {
+		if (marker)
+			bump(10);
+		bpf_percpu_obj_drop(old);
+		bump(8);
+	} else {
+		bump(9);
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/rhtab_fields_common.h b/tools/testing/selftests/bpf/rhtab_fields_common.h
new file mode 100644
index 000000000000..b52fb5e62807
--- /dev/null
+++ b/tools/testing/selftests/bpf/rhtab_fields_common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+#pragma once
+
+/*
+ * Constants shared between the rhtab_fields BPF program (progs/) and its
+ * userspace driver (prog_tests/) so the two sides cannot drift apart
+ * silently.
+ */
+
+/* Magic value stored in the plain bytes of lkmap values ("RHAB"). */
+#define LK_MAGIC 0x52484142
+
+/*
+ * Marker written into freshly allocated per-cpu objects of pcmap. Distinct
+ * from LK_MAGIC on purpose: a hit proves the data came from our own
+ * pc_init(), not from anything else.
+ */
+#define PC_MAGIC 0x43504d47
-- 
2.54.0

