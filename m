Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16613FB7EB
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442192; cv=none; b=BMm/RCJ0w8H4riPYt9NZOQHQwt0zUBDaiAy8aOE2XwfgmGK59F0sJjR6mbqf/nqNHevBVK6Pb804klF9Ib0MPUFiAumEmJ9FDfNldA6qkLXi6Lib1axpxhQ9vd8G8EqHQvkFIcqubY4Z1OFZSj7ZNrp0S2FsYfZSYK//Q1jVb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442192; c=relaxed/simple;
	bh=VhQGVHiCYkwcAgEmBgN5ByGoexsZPAG8N1y7T7Rx3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ademktnO6j6XH+rmOMhxe01isTOt81crjOm2Gg7sabLTrYs0c21dHzyMnvThOkpN+qhrGIr+cOxSJUAL59+0ccqxuN0WnnRKNH5jmGbTfHkuq+TJsYgmqdBNUREsjBcOwWOxgkBZhmjirB30TaS0zDzX5CCXTGEbfin2FFJoIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VUfiS4NR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VUfiS4NR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZU
	j3P58d4QoAudqhWb0eV7Hh2K4y0lwH2appAjh9vGw=; b=VUfiS4NR54AjLQuax7
	/3a/a96j6sVfp1y+G/BDajtpsKaO+UCLcRHv8jskxKGMoExqCONCHVYG3REIf1Z/
	lvsX/SbOo/iceaw9Y3QyVnsk/y2wAc8z/6H1vRnB8IZBzh4th+d2fME42R6t47Zc
	AwxovXB0iKOsWakkroiwlH3lw=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnnhic8XpqSKdbPA--.38984S4;
	Tue, 11 Aug 2026 17:55:46 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test rhtab kptr recycle from NMI context
Date: Tue, 11 Aug 2026 17:55:31 +0800
Message-ID: <20260811095531.3294167-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811095531.3294167-1-chenyuan_fl@163.com>
References: <20260811095531.3294167-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnhic8XpqSKdbPA--.38984S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF48ZF13GF15Ar15CFW5trb_yoWxWr4Upa
	yF9Fy3tr4Fqw1DXw1fGw4UXw4FgwsYqF15CrZ2g34Yvr4vgF97XFyxKF4YyFn3tFZ8XFyf
	ZwsxKrW3GrWUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfAwxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQPdm2p68aPouAAA3W

From: Yuan Chen <chenyuan@kylinos.cn>

A perf_event program running in NMI context overwrites a rhtab element
whose value holds a referenced task kptr. The old kptr must stay attached
to the element (cancel semantics, matching hash maps); before the rhtab
recycle fix the NMI update eagerly released it and the probe observed
NULL.

The test skips when no hardware PMU is available.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../selftests/bpf/prog_tests/rhtab_kptr.c     |  87 +++++++++++++++
 .../testing/selftests/bpf/progs/rhtab_kptr.c  | 101 ++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
new file mode 100644
index 000000000000..79bdcda95555
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
@@ -0,0 +1,87 @@
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
+	int pmu_fd;
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
+	if (pmu_fd < 0) {
+		test__skip();
+		goto out;
+	}
+	skel->links.nmi_update = bpf_program__attach_perf_event(skel->progs.nmi_update,
+								pmu_fd);
+	if (!ASSERT_OK_PTR(skel->links.nmi_update, "attach_perf_event")) {
+		close(pmu_fd);
+		goto out;
+	}
+
+	/* Let the NMI handler overwrite the element. */
+	usleep(100000);
+
+	bpf_link__destroy(skel->links.nmi_update);
+	skel->links.nmi_update = NULL;
+	close(pmu_fd);
+
+	/*
+	 * The old kptr must still be attached to the element: the NMI update
+	 * path only cancels NMI-safe fields, mirroring hash map semantics.
+	 * Before the fix the kptr was released from the NMI context and the
+	 * probe below would see NULL.
+	 */
+	topts.retval = 0;
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.probe_elem),
+					      &topts), "test_run_probe") ||
+	    !ASSERT_EQ(topts.retval, 0, "probe_ret"))
+		goto out;
+
+	ASSERT_EQ(read_counter(skel, 2), 1, "xchg_non_null");
+	ASSERT_EQ(read_counter(skel, 3), 0, "xchg_null");
+out:
+	rhtab_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
new file mode 100644
index 000000000000..25800a2e24e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Co., Ltd. */
+
+/*
+ * Verify that a rhtab value update issued from a perf_event (NMI) program
+ * does not eagerly destroy referenced kptrs. rhtab must match the hash map
+ * semantics introduced by commit a3a81d247651 ("bpf: Cancel special fields
+ * on map value recycle"): only NMI-safe fields (timer, workqueue, task_work)
+ * are cancelled on update/delete, while kptrs stay attached to the recycled
+ * element until it is eventually freed.
+ *
+ * Without the fix, the NMI update releases the old kptr and probe_elem()
+ * observes NULL in the slot; with the fix the old kptr is inherited and
+ * probe_elem() observes a non-NULL pointer.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct val_t {
+	struct task_struct __kptr *tsk;
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
+	__uint(max_entries, 4);
+	__type(key, __u32);
+	__type(value, __u64);
+} counters SEC(".maps");
+
+/* 0: init ok, 1: nmi update ok, 2: probe xchg non-NULL, 3: probe xchg NULL */
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
+	return 0;
+}
-- 
2.54.0

