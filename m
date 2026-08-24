Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E74399E5;
	Mon, 24 Aug 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582297; cv=none; b=RpW7HJgVtJgAlp0nuYDDKKMu3ZLoE/v1b/DH2JlQwJoBezNvrO8VQOaSpjOuTL+3hsbLw/4kNddjcxMohpZ3f0s5Xydkj4gaRuXeS/4tGGrcvSR9Ogasf7yScdUANPCP4xSIFNcW0YgiVo9a8WR2FEeacN+cbatUOVQgGOq55RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582297; c=relaxed/simple;
	bh=klWq5A4m8MvX34YD61Xji+aUUgui42kzirk9tGbrTDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j++QgYBAEzgX+FGSPhriomqX+9C9XRdD6nP5lapswCd0+IPY2GZZFcm4IGGRhAlmArmWdQrgRY8pIa4xX3Zl5Z+4jcXKzOPxI4IL8SNspUoyb2lp4n10SslrmuQ/jBHrPgtPlHW1PzUiBiBy5XmzmVKdgTa0ER7mPXPsDsp/gqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GaL9kVq1; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GaL9kVq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0Q
	jPRk861kKD6Bxm9sd9ewmj9GbHTqQYhsF2ap3X5rw=; b=GaL9kVq1qwSNoQNCyN
	Lb5VV5+2qRf+dG84MJ06fL09AOEJCIWlXLfQ5XiHB2nvgOIj1IaY62/XpvV4xbLC
	pkGbVNLuyuTfUIjib+lSg9M6ai52li1a3k9bN6HNxdM7OxXPOBHNQfaYNvQOBUFK
	yBD70z4Eg6wDPpKEveLtjoH/U=
Received: from nec8-i7 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+osAV4xqIt5SMw--.54939S6;
	Mon, 24 Aug 2026 22:36:52 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH 4/4] selftests/bpf: Test rhtab special-field combinations
Date: Mon, 24 Aug 2026 22:36:21 +0800
Message-ID: <20260824143621.2098856-5-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824143621.2098856-1-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+osAV4xqIt5SMw--.54939S6
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr4UAryDAFyUWryDXF1UZFb_yoW8Xry5Zo
	Z7Wr45Za18GryvgrWkWFykCF1rWayqgasrXF1Yv39rXa4IkFyUCr9rCrWxX3Wxu3W8trWU
	uas09w4fZr1fJF45n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2J3vUUUUU
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQSUUmqMVwSuBwAA3f

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
 .../selftests/bpf/prog_tests/rhtab_fields.c   | 213 ++++++++++++
 .../selftests/bpf/progs/rhtab_fields.c        | 305 ++++++++++++++++++
 2 files changed, 518 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_fields.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
new file mode 100644
index 000000000000..29de05bcbd4b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+#include <unistd.h>
+#include <test_progs.h>
+#include "rhtab_fields.skel.h"
+
+#define RECYCLE_LOOPS 2000
+#define LK_MAGIC 0x52484142
+
+/* Userspace view of the BPF value types (layouts must match the progs). */
+struct lock_kptr_val_user {
+	__u32 lock;
+	__u32 pad;
+	__u64 tsk;
+	__u32 magic;
+	__u32 pad2;
+};
+
+static __u64 read_counter(struct rhtab_fields *skel, u32 idx)
+{
+	__u64 vals[libbpf_num_possible_cpus()];
+	__u64 sum = 0;
+	int i, err;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.counters), &idx, vals);
+	if (!ASSERT_OK(err, "lookup_counter"))
+		return 0;
+	for (i = 0; i < libbpf_num_possible_cpus(); i++)
+		sum += vals[i];
+	return sum;
+}
+
+/* Returns the program retval; asserts the test_run itself succeeded. */
+static int run_prog(struct rhtab_fields *skel, const char *name)
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
+	return topts.retval;
+}
+
+static void recycle_loop(struct rhtab_fields *skel, int map_fd,
+			 const char *init, const char *del,
+			 const char *upd, const char *probe)
+{
+	u64 zero = 0;
+	u32 key = 0;
+	int i;
+
+	for (i = 0; i < RECYCLE_LOOPS; i++) {
+		if (run_prog(skel, init) != 0) {
+			/* Element may be gone; recreate and retry once. */
+			if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
+				       "recreate_elem"))
+				return;
+			if (!ASSERT_OK(run_prog(skel, init), init))
+				return;
+		}
+		if (!ASSERT_OK(run_prog(skel, del), del))
+			return;
+		if (!ASSERT_OK(run_prog(skel, upd), upd))
+			return;
+		if (!ASSERT_OK(run_prog(skel, probe), probe))
+			return;
+	}
+}
+
+static void subtest_lock_kptr(struct rhtab_fields *skel)
+{
+	struct lock_kptr_val_user val = {};
+	struct lock_kptr_val_user out = {};
+	u64 nonnull_before;
+	u32 key = 0;
+	int map_fd;
+
+	map_fd = bpf_map__fd(skel->maps.lkmap);
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &val, BPF_ANY),
+		       "create_elem"))
+		return;
+
+	/* Spin lock must be usable from the syscall path (BPF_F_LOCK). */
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
+	 */
+	nonnull_before = read_counter(skel, 1);
+	recycle_loop(skel, map_fd, "lk_init", "lk_del", "lk_upd", "lk_probe");
+	ASSERT_GT(read_counter(skel, 1), nonnull_before, "recycle_xchg_non_null");
+	ASSERT_EQ(read_counter(skel, 3), RECYCLE_LOOPS, "recycle_magic_roundtrip");
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
+	u64 zero = 0;
+	u32 key = 0;
+	int fired, map_fd;
+
+	map_fd = bpf_map__fd(skel->maps.tmap);
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
+		       "create_elem"))
+		return;
+
+	if (!ASSERT_OK(run_prog(skel, "arm_timer"), "arm_timer_first"))
+		return;
+	usleep(300000);
+	if (!ASSERT_GT(skel->bss->timer_fired, 0, "timer_fired_first"))
+		return;
+
+	/* Deleting the element must cancel the timer. */
+	fired = skel->bss->timer_fired;
+	if (!ASSERT_OK(bpf_map_delete_elem(map_fd, &key), "delete_elem"))
+		return;
+	usleep(300000);
+	ASSERT_EQ(skel->bss->timer_fired, fired, "timer_cancelled_after_delete");
+
+	/*
+	 * Re-insert (may recycle the freed element): the timer field must be
+	 * re-initialized so a fresh timer can be armed again.
+	 */
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
+		       "recreate_elem"))
+		return;
+	if (!ASSERT_OK(run_prog(skel, "arm_timer"), "arm_timer_second"))
+		return;
+	usleep(300000);
+	ASSERT_GT(skel->bss->timer_fired, fired, "timer_fired_second");
+}
+
+static void subtest_kptr_untrusted(struct rhtab_fields *skel)
+{
+	u64 nonnull_before;
+	u64 zero = 0;
+	u32 key = 0;
+	int map_fd;
+
+	map_fd = bpf_map__fd(skel->maps.umap);
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
+		       "create_elem"))
+		return;
+
+	/* The untrusted kptr must survive the recycle like a referenced one. */
+	nonnull_before = read_counter(skel, 5);
+	recycle_loop(skel, map_fd, "u_init", "u_del", "u_upd", "u_probe");
+	ASSERT_GT(read_counter(skel, 5), nonnull_before, "recycle_unref_non_null");
+}
+
+static void subtest_kptr_percpu(struct rhtab_fields *skel)
+{
+	u64 nonnull_before;
+	u64 zero = 0;
+	u32 key = 0;
+	int map_fd;
+
+	map_fd = bpf_map__fd(skel->maps.pcmap);
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
+		       "create_elem"))
+		return;
+
+	/* The per-cpu kptr reference must survive the recycle (no leak). */
+	nonnull_before = read_counter(skel, 7);
+	recycle_loop(skel, map_fd, "pc_init", "pc_del", "pc_upd", "pc_probe");
+	ASSERT_GT(read_counter(skel, 7), nonnull_before, "recycle_pcpu_non_null");
+}
+
+void test_rhtab_fields(void)
+{
+	struct rhtab_fields *skel;
+
+	skel = rhtab_fields__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (test__start_subtest("lock_kptr"))
+		subtest_lock_kptr(skel);
+	if (test__start_subtest("timer"))
+		subtest_timer(skel);
+	if (test__start_subtest("kptr_untrusted"))
+		subtest_kptr_untrusted(skel);
+	if (test__start_subtest("kptr_percpu"))
+		subtest_kptr_percpu(skel);
+
+	rhtab_fields__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhtab_fields.c b/tools/testing/selftests/bpf/progs/rhtab_fields.c
new file mode 100644
index 000000000000..85335f19f172
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhtab_fields.c
@@ -0,0 +1,305 @@
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
+ *  2. tmap: bpf_timer. The delete path must cancel the timer, and a recycled
+ *     element must be able to arm a fresh timer again.
+ *  3. umap: untrusted (unreferenced) kptr. The inherited pointer must be
+ *     preserved on recycle, matching hash map behavior.
+ *  4. pcmap: per-cpu kptr. Like the referenced kptr, the per-cpu reference
+ *     must not be dropped on recycle.
+ */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct lock_kptr_val {
+	struct bpf_spin_lock lock;
+	struct task_struct __kptr * tsk;
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
+	__u64 data;
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
+	struct task_struct __kptr_untrusted * tsk;
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
+	struct pcval __percpu_kptr * pc;
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
+	__uint(max_entries, 9);
+	__type(key, __u32);
+	__type(value, __u64);
+} counters SEC(".maps");
+
+/* 0: lk init ok, 1: lk probe xchg non-NULL, 2: lk probe xchg NULL,
+ * 3: lk probe magic ok, 4: u init ok, 5: u probe ptr non-NULL,
+ * 6: pc init ok, 7: pc probe xchg non-NULL, 8: pc probe xchg NULL
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
+
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
+	bpf_map_delete_elem(&lkmap, &key);
+	return 0;
+}
+
+SEC("syscall")
+int lk_upd(void *ctx)
+{
+	struct lock_kptr_val val = { .magic = 0x52484142 };
+	u32 key = 0;
+
+	bpf_map_update_elem(&lkmap, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("syscall")
+int lk_probe(void *ctx)
+{
+	struct lock_kptr_val *val;
+	struct task_struct *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&lkmap, &key);
+	if (!val)
+		return 1;
+	old = bpf_kptr_xchg(&val->tsk, NULL);
+	if (old) {
+		bpf_task_release(old);
+		bump(1);
+	} else {
+		bump(2);
+	}
+	if (val->magic == 0x52484142)
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
+	if (bpf_timer_start(&val->timer, 50000, 0))
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
+	bpf_map_delete_elem(&umap, &key);
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
+	struct pcval *p, *old;
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
+	bump(6);
+	return 0;
+}
+
+SEC("syscall")
+int pc_del(void *ctx)
+{
+	u32 key = 0;
+
+	bpf_map_delete_elem(&pcmap, &key);
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
+	struct pcval *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&pcmap, &key);
+	if (!val)
+		return 1;
+	old = bpf_kptr_xchg(&val->pc, NULL);
+	if (old) {
+		bpf_percpu_obj_drop(old);
+		bump(7);
+	} else {
+		bump(8);
+	}
+	return 0;
+}
-- 
2.54.0

