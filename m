Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAF363C5F;
	Mon, 24 Aug 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582292; cv=none; b=f55i+MH1QSsns1y004xDXKt/sODxGMCa7tEJGCIifZNYpLl+/TrkD39nZyFca3BEY1A6KdxGDSlIL75NPQ4KYnUsuDN1zc3Lslp1JZxx6xq+36SCshktOLTICBfpf4SCc+XGx3E0GOvGw6UF22OYTnDAmT80PMqvmnSFRocvF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582292; c=relaxed/simple;
	bh=8TpAxauxOe5fg0/lVEVtXpzKKFdzA6e7fIzOJyWXBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKq2c8XxeEYiv4IN7rwgDC9xVSDjxiNYdtF25qgU30rDBEBhEolmHUOE/iDaIaEA/J+8sSBLYZMbPWw9BwtGnozt/l0JYuCqSjP7yH3SbXw86d0zk+uUJAIkmjqVf54XYXoD4o1UmpCXoCOebf3Mo12VFJYgDGoBWxWVnUJX4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3bLIyD8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3bLIyD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ct
	+peqGCPMUcfHs6HCx5ClFNeJruycb7Blf1DOzAfzE=; b=E3bLIyD8hu9ifPsZJx
	NkK9TflrhEhvcd9Ebv8G5Xye2Yhvi78qf1dgN95kiwAhHtjSKj4bM2PK8SwhCyFR
	r6svFSOIfs0LghMFdMEAGI8ZbLhq3y9Ne2jUDDGDdZYgXsZze0tC4nzbc0YTh8rk
	o5mwo05y78wd+jRnrymkl6VS4=
Received: from nec8-i7 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+osAV4xqIt5SMw--.54939S5;
	Mon, 24 Aug 2026 22:36:51 +0800 (CST)
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
Subject: [PATCH 3/4] selftests/bpf: Test rhtab kptr recycle from NMI context
Date: Mon, 24 Aug 2026 22:36:20 +0800
Message-ID: <20260824143621.2098856-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:PSgvCgDn+osAV4xqIt5SMw--.54939S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3CryDKw1xKFyrJF4UWFyUWrg_yoWDWryUpa
	9Y9ry5tr4Fqwn8XrsYva18J3yF9ws5ZFW5CrZ2gryYvr1qgrn7JFyxKF4YkF9ayF4DXryS
	vwsxKFW3GFWUArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWfO7UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QOTUWqMVwPdBAAA3P

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
 .../selftests/bpf/prog_tests/rhtab_kptr.c     | 146 ++++++++++++++++++
 .../testing/selftests/bpf/progs/rhtab_kptr.c  | 132 ++++++++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
new file mode 100644
index 000000000000..13158d74cbc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "rhtab_kptr.skel.h"
+
+static __u64 read_counter(struct rhtab_kptr *skel, u32 idx)
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
+void test_rhtab_kptr(void)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+		.sample_freq = read_perf_max_sample_freq(),
+		.size = sizeof(struct perf_event_attr),
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct rhtab_kptr *skel;
+	__u32 key = 0;
+	__u64 zero = 0;
+	__u64 nonnull_before;
+	int pmu_fd, i, err;
+
+	skel = rhtab_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* Create the element and stash a referenced task kptr in it. */
+	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
+					   &key, &zero, BPF_ANY), "create_elem"))
+		goto out;
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
+					      &topts), "test_run_init") ||
+	    !ASSERT_EQ(topts.retval, 0, "init_ret"))
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
+		topts.retval = 0;
+		if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.probe_elem),
+						      &topts), "test_run_probe") ||
+		    !ASSERT_EQ(topts.retval, 0, "probe_ret"))
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
+	 * least one recycle.
+	 */
+	nonnull_before = read_counter(skel, 2);
+	for (i = 0; i < 2000; i++) {
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
+					     &topts);
+		if (err || topts.retval) {
+			/* Element may be gone; recreate and retry once. */
+			if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
+							   &key, &zero, BPF_ANY),
+				       "recreate_elem"))
+				goto out;
+			topts.retval = 0;
+			err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
+						     &topts);
+		}
+		if (!ASSERT_OK(err, "test_run_init_loop") ||
+		    !ASSERT_EQ(topts.retval, 0, "init_loop_ret"))
+			goto out;
+
+		topts.retval = 0;
+		if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.del_elem),
+						      &topts), "test_run_del"))
+			goto out;
+		topts.retval = 0;
+		if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.upd_elem),
+						      &topts), "test_run_upd"))
+			goto out;
+		topts.retval = 0;
+		if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.probe_elem),
+						      &topts), "test_run_probe"))
+			goto out;
+	}
+
+	/*
+	 * Plain (non-special) value bytes must survive the recycle path:
+	 * every probe must observe the magic value written by upd_elem() in
+	 * the same iteration, regardless of whether the element memory was
+	 * recycled or freshly allocated.
+	 */
+	ASSERT_EQ(read_counter(skel, 4), 2000, "recycle_magic_roundtrip");
+
+	ASSERT_GT(read_counter(skel, 2), nonnull_before, "recycle_xchg_non_null");
+out:
+	rhtab_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
new file mode 100644
index 000000000000..fd6bd63cb405
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
@@ -0,0 +1,132 @@
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
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct val_t {
+	struct task_struct __kptr * tsk;
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
+	bpf_map_delete_elem(&rhtab, &key);
+	return 0;
+}
+
+SEC("syscall")
+int upd_elem(void *ctx)
+{
+	struct val_t val = { .magic = 0x52484153 }; /* "RHAS" */
+	u32 key = 0;
+
+	bpf_map_update_elem(&rhtab, &key, &val, BPF_ANY);
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
+	if (val->magic == 0x52484153)
+		bump(4);
+	return 0;
+}
-- 
2.54.0

