Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C32F616B;
	Tue,  1 Sep 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244223; cv=none; b=Ctx1oT40XtaEycXbK+UWk2LqPTs9wn3J6U4hvEL5LDKBBQ2GThfWRWkpHQKinYCDcMK6cubay1WepsOSLiAA/zCgT5dO84bxc8lUm49Mn1u39mUYIyJsrvt0xxjr//+ZffDM7BpatcPFvCw4UHa6tfNJXOpbS3EU6oCAl4U8K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244223; c=relaxed/simple;
	bh=k/u9HlMctB2v28FpIueJbxVyDxdLj/IQFRyP4kvf0fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxL50PFBmK2eN7MA9nOf91MJKNqGshh4j3Sm276Bf4vsBTccebQ6whOL6+E1E+VEcrNs/X9aegWIMWuCCQl8sDBa/daqWmZu9TpIMWxX6xXZftYt/983ZSM8xNx90duLJ5p/wIXn2smrusaxvDH+XKcDnjajOMtrA0KIesD6Cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gK62Wvtj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gK62Wvtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lv
	bxUgIVISfLN5BI0oqpLaNIawZZ/6r+osaCkDJVSMo=; b=gK62WvtjyLPonYLRJ8
	3Z+iarOKtuWwNKjCkWFoolb5JS31LWJYgVtZ50IUH6VMM/oQFOycdiCJvnl7uuXZ
	hgzNfzWKYiWMGoouLvCCobwpK+fjjqedz5hbh9auRMQBobr1snqoyC27AJWmKGc/
	IaidITkowUvg0EFqVYf5svGh4=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n5+mcJZqA6mBNA--.25535S5;
	Tue, 01 Sep 2026 14:29:02 +0800 (CST)
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
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Test rhtab kptr recycle from NMI context
Date: Tue,  1 Sep 2026 14:28:44 +0800
Message-ID: <20260901062845.1379760-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:PCgvCgD3n5+mcJZqA6mBNA--.25535S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3CryDKw1xKFyrGF1ktrykGrg_yoW8JryUAo
	Z3Way5Zw18Gw1DKr95uFn7Gr1rW3yvga4fXw4rK3y5Xa48tay7CF98Cw4xX3W29F10qrWU
	ua4qv34fZr4fJFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUamFAUUUUU
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAg+HRWqWcK+FpgAA3P

From: Yuan Chen <chenyuan@kylinos.cn>

A perf_event program running in NMI context overwrites a rhtab
element whose value holds a referenced task kptr. The old kptr must
stay attached to the element (cancel semantics, matching hash maps);
before the rhtab recycle fix the NMI update eagerly released it and
the probe observed NULL. The test asserts the NMI program actually
ran, so the probe result is meaningful.

A second phase deletes and re-inserts the element 2000 times. The
re-insertion may recycle the freed element, which still owns the
kptr; before the fix the alloc path zeroed the inherited slot via
check_and_init_map_value(), leaking the reference, and the probe
never observed a non-NULL pointer. The test requires at least one
recycle to inherit the kptr, and also verifies that plain
(non-special) value bytes still round-trip through the recycled
element on every iteration.

The NMI phase is skipped when no hardware PMU is available.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../selftests/bpf/prog_tests/rhtab_kptr.c     | 184 ++++++++++++++++++
 .../testing/selftests/bpf/progs/rhtab_kptr.c  | 146 ++++++++++++++
 .../testing/selftests/bpf/rhtab_kptr_common.h |   6 +
 3 files changed, 336 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/rhtab_kptr_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
new file mode 100644
index 000000000000..4bdcc9ce5500
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+#include <test_progs.h>
+#include <linux/perf_event.h>
+#include <stddef.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include "rhtab_kptr.skel.h"
+
+/* Userspace mirror of the BPF-side struct val_t (progs/rhtab_kptr.c). The
+ * update syscall copies map->value_size bytes from the buffer, so it must
+ * be at least that large; special fields are skipped by the value copy but
+ * the kernel still reads the full value_size from userspace.
+ */
+struct val_t_user {
+	__u64 tsk;
+	__u32 magic;
+	__u32 pad;
+};
+
+_Static_assert(sizeof(struct val_t_user) == 16, "val_t layout drift");
+_Static_assert(offsetof(struct val_t_user, magic) == 8, "val_t magic offset drift");
+
+/* Zeroed value for creating/recreating elements; BSS is zero-filled. */
+static struct val_t_user zero;
+
+/* Cached CPU count and scratch buffer for percpu counter summation. */
+static __u64 *cpu_vals;
+static int ncpu = -1;
+
+static __u64 read_counter(struct rhtab_kptr *skel, u32 idx)
+{
+	__u64 sum = 0;
+	int i, err;
+
+	if (!cpu_vals)
+		return 0;
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.counters), &idx,
+				  cpu_vals);
+	if (!ASSERT_OK(err, "lookup_counter"))
+		return 0;
+	for (i = 0; i < ncpu; i++)
+		sum += cpu_vals[i];
+	return sum;
+}
+
+/* Run @name via BPF_PROG_TEST_RUN, asserting both the syscall status and
+ * that the program exited 0. Returns 0 on success.
+ */
+static int run_prog_ok(struct rhtab_kptr *skel, const char *name)
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
+	if (!ASSERT_EQ(topts.retval, 0, name))
+		return -1;
+	return 0;
+}
+
+void test_rhtab_kptr(void)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+		.sample_freq = read_perf_max_sample_freq(),
+		.size = sizeof(struct perf_event_attr),
+	};
+	struct rhtab_kptr *skel;
+	__u64 init_before, nonnull_before;
+	__u32 key = 0;
+	int pmu_fd, i, retries = 0;
+
+	ncpu = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(ncpu, 0, "num_possible_cpus"))
+		return;
+	cpu_vals = calloc(ncpu, sizeof(*cpu_vals));
+	if (!ASSERT_OK_PTR(cpu_vals, "calloc_cpu_vals"))
+		return;
+
+	skel = rhtab_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out_free;
+
+	/* Create the element and stash a referenced task kptr in it. */
+	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
+					   &key, &zero, BPF_ANY), "create_elem"))
+		goto out;
+	if (run_prog_ok(skel, "init_elem") != 0)
+		goto out;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
+	if (pmu_fd >= 0) {
+		skel->links.nmi_update = bpf_program__attach_perf_event(skel->progs.nmi_update,
+									pmu_fd);
+		if (!ASSERT_OK_PTR(skel->links.nmi_update, "attach_perf_event")) {
+			close(pmu_fd);
+			goto out;
+		}
+
+		/* Let the NMI handler overwrite the element, and make sure it
+		 * actually ran before probing (otherwise the probe would pass
+		 * vacuously even on an unfixed kernel).
+		 */
+		for (i = 0; i < 20 && read_counter(skel, 1) == 0; i++)
+			usleep(100000);
+		ASSERT_GT(read_counter(skel, 1), 0, "nmi_update_ran");
+
+		bpf_link__destroy(skel->links.nmi_update);
+		skel->links.nmi_update = NULL;
+		close(pmu_fd);
+
+		/*
+		 * The old kptr must still be attached to the element: the
+		 * NMI update path only cancels NMI-safe fields, mirroring
+		 * hash map semantics. Before the fix the kptr was released
+		 * from the NMI context and the probe below would see NULL.
+		 */
+		if (run_prog_ok(skel, "probe_elem") != 0)
+			goto out;
+
+		ASSERT_EQ(read_counter(skel, 2), 1, "xchg_non_null");
+		ASSERT_EQ(read_counter(skel, 3), 0, "xchg_null");
+	} else {
+		test__skip();
+	}
+
+	/*
+	 * Now exercise the delete/re-insert recycle path. The delete only
+	 * cancels NMI-safe fields, so the freed element still owns the kptr.
+	 * If the re-insertion recycles that element, the kptr must be
+	 * inherited; zeroing it (as check_and_init_map_value() did before
+	 * the fix) leaks the reference and probe_elem() observes NULL.
+	 * Fresh memory handed out by the allocator is zeroed, so NULL probes
+	 * are expected too; only require that the inherited kptr survives at
+	 * least one recycle. Every iteration runs exactly one probe, so the
+	 * counters must add up to the loop count.
+	 */
+	init_before = read_counter(skel, 0);
+	nonnull_before = read_counter(skel, 2);
+	for (i = 0; i < 2000; i++) {
+		if (run_prog_ok(skel, "init_elem") != 0) {
+			/* init_elem fails only if the element is missing,
+			 * which must not happen in this single-threaded
+			 * loop; count it so a rhtab bug cannot be absorbed
+			 * silently.
+			 */
+			retries++;
+			if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
+							   &key, &zero, BPF_ANY),
+				       "recreate_elem"))
+				goto out;
+			if (run_prog_ok(skel, "init_elem") != 0)
+				goto out;
+		}
+		if (run_prog_ok(skel, "del_elem") != 0 ||
+		    run_prog_ok(skel, "upd_elem") != 0 ||
+		    run_prog_ok(skel, "probe_elem") != 0)
+			goto out;
+	}
+
+	/*
+	 * Plain (non-special) value bytes must survive the recycle path:
+	 * every probe must observe the magic value written by upd_elem() in
+	 * the same iteration, regardless of whether the element memory was
+	 * recycled or freshly allocated.
+	 */
+	ASSERT_EQ(retries, 0, "no_unexpected_recreate");
+	ASSERT_EQ(read_counter(skel, 0) - init_before, 2000, "init_loop_count");
+	ASSERT_EQ(read_counter(skel, 4), 2000, "recycle_magic_roundtrip");
+	ASSERT_GT(read_counter(skel, 2), nonnull_before, "recycle_xchg_non_null");
+out:
+	rhtab_kptr__destroy(skel);
+out_free:
+	free(cpu_vals);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
new file mode 100644
index 000000000000..c96cf7f2d799
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+/*
+ * Verify that the rhtab update/delete recycle paths do not eagerly destroy
+ * referenced kptrs. rhtab must match the hash map semantics introduced by
+ * commit a3a81d247651 ("bpf: Cancel special fields on map value recycle"):
+ * only NMI-safe fields (timer, workqueue, task_work) are cancelled on
+ * update/delete, while kptrs stay attached to the recycled element until it
+ * is eventually freed.
+ *
+ * Two paths are exercised:
+ *  1. a perf_event (NMI) program overwrites an existing element; without the
+ *     fix the NMI update releases the old kptr and probe_elem() observes
+ *     NULL;
+ *  2. the element is deleted and re-inserted; the re-insertion may recycle
+ *     the freed element, and zeroing the inherited kptr slot (as
+ *     check_and_init_map_value() did before the fix) would drop the
+ *     reference without releasing it. probe_elem() must observe the
+ *     inherited non-NULL pointer, and plain (non-special) value bytes must
+ *     still round-trip through the recycled element.
+ *
+ * The delete program checks that the element really disappeared, otherwise
+ * the following update would be an in-place update whose value copy skips
+ * the special fields, and the surviving kptr would prove nothing about the
+ * recycle path.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "rhtab_kptr_common.h"
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct val_t {
+	struct task_struct __kptr *tsk;
+	__u32 magic;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 16);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct val_t);
+} rhtab SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} counters SEC(".maps");
+
+/* 0: init ok, 1: nmi update ok, 2: probe xchg non-NULL, 3: probe xchg NULL,
+ * 4: probe saw expected magic value
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
+SEC("perf_event")
+int nmi_update(struct bpf_perf_event_data *ctx)
+{
+	struct val_t val = {};
+	u32 key = 0;
+
+	if (bpf_map_update_elem(&rhtab, &key, &val, BPF_ANY) == 0)
+		bump(1);
+	return 0;
+}
+
+SEC("syscall")
+int init_elem(void *ctx)
+{
+	struct val_t *val;
+	struct task_struct *task, *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&rhtab, &key);
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
+int del_elem(void *ctx)
+{
+	u32 key = 0;
+
+	if (bpf_map_delete_elem(&rhtab, &key))
+		return 1;
+	/* The element must really be gone: otherwise the following upd_elem()
+	 * is an in-place update on the surviving element and the kptr that
+	 * probe_elem() observes never went through a recycle.
+	 */
+	if (bpf_map_lookup_elem(&rhtab, &key))
+		return 2;
+	return 0;
+}
+
+SEC("syscall")
+int upd_elem(void *ctx)
+{
+	struct val_t val = { .magic = RHTAB_MAGIC };
+	u32 key = 0;
+
+	if (bpf_map_update_elem(&rhtab, &key, &val, BPF_ANY))
+		return 1;
+	return 0;
+}
+
+SEC("syscall")
+int probe_elem(void *ctx)
+{
+	struct val_t *val;
+	struct task_struct *old;
+	u32 key = 0;
+
+	val = bpf_map_lookup_elem(&rhtab, &key);
+	if (!val)
+		return 1;
+	old = bpf_kptr_xchg(&val->tsk, NULL);
+	if (old) {
+		bpf_task_release(old);
+		bump(2);
+	} else {
+		bump(3);
+	}
+	if (val->magic == RHTAB_MAGIC)
+		bump(4);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/rhtab_kptr_common.h b/tools/testing/selftests/bpf/rhtab_kptr_common.h
new file mode 100644
index 000000000000..1b629fcb6742
--- /dev/null
+++ b/tools/testing/selftests/bpf/rhtab_kptr_common.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+#pragma once
+
+/* Magic value stored in the plain bytes of rhtab values ("RHAS"). */
+#define RHTAB_MAGIC 0x52484153
-- 
2.54.0

