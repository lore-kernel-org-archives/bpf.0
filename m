Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12647A0A9
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806796; cv=none; b=Gm+SAXwQFVmE5gDD6tuF1QKAG7/TVPzdnalMTjRwJqnxhBPMjjabvu4/a9a4DjJVqAByJtZNgcOshQLUiA8WdqRnxRhxQq8P4ZNTv9xSenMdeYha+LVA2Q7+PSHFQ7YQC1fDmcGvKurverTtzBXCxoTnpWulIAZSkv3JTTiahIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806796; c=relaxed/simple;
	bh=a3t9J4KhhuluYeHnkyUEnJaoH/t0rZuNGK4OciI2mfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL421Pax4ENdTiBbVCu6hKVBcfg2zV/VrZx+V2o0Q8uYmTG217SI1mPb+YPGURFhu7Zx6kSsZfXbWMPCaqVreqnyKUABMdlx1O29YRa/6VG7raUSfTH8LcEYWplqpcGFuzxcXuMRz6/PZubR954aXwW3y60swstttJaPA29xOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qu7xCNQu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu7xCNQu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so1258124a91.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806790; x=1792411590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy+eARgrFpDT0ZhRfOHwtN1niTEnWD5P7Xvkvc+A7GA=;
        b=qu7xCNQuZxg7HnZm7MZ5SyGTFeHWXbZUK2V+xehWTo6sw6xZwvT4nj9i8fu7GiDrFk
         ISxM3ESThnlH4om3Y/kop1iZwqe5Lop+bnfNbOKyrdOa4j7qL3gIYRjnIE/ta5dwDISI
         BNOYnPPBnXn3sQlD2w5Dza5Lvk8nld1T7UogXLvsUju48NhJLfqax6bwreWG9kTNvlTp
         CQR3ltoD769f5ajYqnZ9eEgmFKNO1HL7Ljt8sqXuK7NDFTTS9DJozzMIscwFhEFl2lLg
         Rgd4kxZLirAySfbL6dhVwoiy1T+NJ1o3RLxDqU725jEQDT8Lcepw0XygMB0ewdg20Iz1
         h9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806790; x=1792411590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hy+eARgrFpDT0ZhRfOHwtN1niTEnWD5P7Xvkvc+A7GA=;
        b=ew7FXxXl+7N8QJbAEECWsPx3o6LLKeF50/S1j7Iz45SKjuXehl05Fuj1PYF2qETxj3
         hEMmHT1yHanSQ5C8kY3BUDGsjFJyqTju4obPoVoxbm/nMBEBx9gE1Om9C2rSoPwRdCyS
         asr4KH7diD8XrojBRQXJGh5uY874QhMad/h/NS+U8NtnXqHeQnJo6mHN0GV7PgVVM8y/
         vp5xqPk5Y7cr1/sVHMAEvgguH9Wh6yl/N7fwc4dAfRD4RRXCwx9gtiWfVA3/IEeVIZGC
         mQ7T1zoTJD2yA9BUfHhUKqNx2a+oEMzuRusZZrjw8bq76uCTRy5wBNfWaaIY4vdS9wfF
         oW1Q==
X-Gm-Message-State: AFq9FYJOQiCIP1jRpZ3nKQRCNwrit+/C17hKf2nK+LfOuiFtbB58OgIK
	IAR5UPC4gcJGd/6yvSGPZLRfrL5nhTf1K6JiofbcRLHQa8Dz6SkguDFg
X-Gm-Gg: AYBFou0ObyWgfnNhszbWc4QR+rq8fAukNTdV7C4ZrIRLO/bdwVEl5EifVzot9hQtkZR
	AbYF5zFVBfPCy4iNMIOIFgQTgv6PMx9d6X/GDYVEo/skmpW5Ex8wvcEyUmCylbkIqleNLAuMBLD
	iakn22+dZzsfw82xo1IY55j2nVgHqBlb7nMXnUOCZPdU2CGrPJSA2QXFJSCFBwhhZ4ZY7zGqfNC
	usPiea1+epXgpdGZI095rGDVwcsVH+ZSleBO6FC2v2NJt8CEdVktjSlmFjeyxn5gnlViAyt1XEj
	OPNua+QaQCiYxA76dM7aKcLjq286wK3pJrMOms/l4k2sEPzw6FCO/2okdddkrjMJ/CsTm+etzJI
	S5SwJFnlM/uPhnvWaLEuD0SpHhJG7vohK6iTa3Q83Rc+xOyinBUiLpCGTPAtkWFUUthZopfBqc/
	qW2DF8usa6QkdU0ZzhDO5rPOCiLMhsh6rQez1Fu7d1pWPDLPJJ9377IYb+znofDSjiX9jL1jLlX
	Y/iUaTJ1l3DZ95Ylh1hO8/hV3DV6oO2NgoomneHV4yKZRN76AcoyoWx
X-Received: by 2002:a17:90b:5444:b0:3a7:9ad9:68e1 with SMTP id 98e67ed59e1d1-3ab3a735fddmr8030646a91.13.1791806789634;
        Mon, 12 Oct 2026 05:06:29 -0700 (PDT)
Received: from yafangs-Air ([101.82.170.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm15722454a91.16.2026.10.12.05.06.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 05:06:29 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 3/3] selftests/bpf: add tests for the bpf_numab_ops struct_ops
Date: Mon, 12 Oct 2026 20:04:38 +0800
Message-ID: <20261012120438.52849-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012120438.52849-1-laoar.shao@gmail.com>
References: <20261012120438.52849-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five cases:
- attach/detach with counter proof
- hierarchy aggregation
- multi-policy combination
- inheritance
- a surface-dispatching policy

Assisted-by: LLM
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_numab_ops.c  | 250 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_numab_ops.c       |  57 ++++
 2 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_numab_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c b/tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c
new file mode 100644
index 000000000000..3e5dac8e3131
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "cgroup_helpers.h"
+#include "bpf_numab_ops.skel.h"
+
+#define CGROUP_PATH	"/bpf_numab_ops"
+#define CHILD_PATH	CGROUP_PATH "/child"
+
+/*
+ * task_tick_fair() consults the per-cgroup NUMA balancing policy on every
+ * tick of a running task, so a short busy loop is enough to prove that the
+ * hook runs. This works regardless of the global numa_balancing sysctl
+ * state and regardless of the machine's NUMA topology: both the enabled
+ * and disabled code paths end up calling every attached policy.
+ */
+static void burn_cpu_ms(int ms)
+{
+	struct timespec now;
+	u64 deadline;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	deadline = now.tv_sec * 1000ULL + now.tv_nsec / 1000000ULL + ms;
+
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (now.tv_sec * 1000ULL + now.tv_nsec / 1000000ULL < deadline);
+}
+
+static void test_attach_detach(void)
+{
+	struct bpf_numab_ops *skel;
+	struct bpf_link *link = NULL;
+	int cgroup_fd, before;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = bpf_numab_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.numab_enable_ops,
+					   cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_enable_ops"))
+		goto cleanup;
+
+	skel->bss->enable_cnt = 0;
+	burn_cpu_ms(300);
+	ASSERT_GT(skel->bss->enable_cnt, 0, "enable_cnt");
+
+	/*
+	 * Detach and let a grace period pass so that no reader is still
+	 * walking the old effective array, then verify the hook stopped
+	 * running.
+	 */
+	before = skel->bss->enable_cnt;
+	bpf_link__destroy(link);
+	link = NULL;
+	sleep(1);
+	burn_cpu_ms(300);
+	ASSERT_EQ(skel->bss->enable_cnt, before, "enable_cnt_after_detach");
+
+cleanup:
+	bpf_link__destroy(link);
+	bpf_numab_ops__destroy(skel);
+	close(cgroup_fd);
+}
+
+/*
+ * Attach to the parent cgroup while the task lives in the child: the
+ * child's effective array must aggregate the parent's policy.
+ */
+static void test_hierarchy(void)
+{
+	struct bpf_numab_ops *skel;
+	struct bpf_link *plink = NULL;
+	int parent_fd, child_fd = -1;
+
+	parent_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
+		return;
+
+	child_fd = create_and_get_cgroup(CHILD_PATH);
+	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
+		goto cleanup;
+
+	if (!ASSERT_OK(join_cgroup(CHILD_PATH), "join_child_cgroup"))
+		goto cleanup;
+
+	skel = bpf_numab_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	plink = bpf_map__attach_cgroup_opts(skel->maps.numab_enable_ops,
+					    parent_fd, NULL);
+	if (!ASSERT_OK_PTR(plink, "attach_to_parent"))
+		goto cleanup;
+
+	skel->bss->enable_cnt = 0;
+	burn_cpu_ms(300);
+	ASSERT_GT(skel->bss->enable_cnt, 0, "enable_cnt_from_parent_policy");
+
+cleanup:
+	bpf_link__destroy(plink);
+	bpf_numab_ops__destroy(skel);
+	if (child_fd >= 0) {
+		close(child_fd);
+		join_cgroup(CGROUP_PATH);
+		remove_cgroup(CHILD_PATH);
+	}
+	close(parent_fd);
+}
+
+/*
+ * Attach two policies to the same cgroup. Both must run: the kernel
+ * combines what they return.
+ */
+static void test_multi(void)
+{
+	struct bpf_numab_ops *skel;
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = bpf_numab_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.numab_enable_ops,
+					    cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_enable_ops"))
+		goto cleanup;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.numab_disable_ops,
+					    cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_disable_ops"))
+		goto cleanup;
+
+	skel->bss->enable_cnt = 0;
+	skel->bss->disable_cnt = 0;
+	burn_cpu_ms(300);
+	ASSERT_GT(skel->bss->enable_cnt, 0, "enable_cnt");
+	ASSERT_GT(skel->bss->disable_cnt, 0, "disable_cnt");
+
+cleanup:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+	bpf_numab_ops__destroy(skel);
+	close(cgroup_fd);
+}
+
+/*
+ * Attach to the parent first, then create and join the child cgroup. The
+ * child must inherit the parent's effective array via cgroup_bpf_inherit().
+ */
+static void test_inherit(void)
+{
+	struct bpf_numab_ops *skel;
+	struct bpf_link *plink = NULL;
+	int parent_fd, child_fd = -1;
+
+	parent_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
+		return;
+
+	skel = bpf_numab_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	plink = bpf_map__attach_cgroup_opts(skel->maps.numab_enable_ops,
+					    parent_fd, NULL);
+	if (!ASSERT_OK_PTR(plink, "attach_to_parent"))
+		goto cleanup;
+
+	child_fd = create_and_get_cgroup(CHILD_PATH);
+	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
+		goto cleanup;
+
+	if (!ASSERT_OK(join_cgroup(CHILD_PATH), "join_child_cgroup"))
+		goto cleanup;
+
+	skel->bss->enable_cnt = 0;
+	burn_cpu_ms(300);
+	ASSERT_GT(skel->bss->enable_cnt, 0, "enable_cnt_inherited");
+
+cleanup:
+	bpf_link__destroy(plink);
+	bpf_numab_ops__destroy(skel);
+	if (child_fd >= 0) {
+		close(child_fd);
+		join_cgroup(CGROUP_PATH);
+		remove_cgroup(CHILD_PATH);
+	}
+	close(parent_fd);
+}
+
+/*
+ * A surface-dispatching policy must load, attach and run from the task
+ * surface.  The folio surface runs from the scanner and fault paths,
+ * which need a scan pass and foreign-node folios to consult, so folio_cnt
+ * is left for debugging rather than asserted here.
+ */
+static void test_mixed(void)
+{
+	struct bpf_numab_ops *skel;
+	struct bpf_link *link = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = bpf_numab_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.numab_mixed_ops,
+					   cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_mixed_ops"))
+		goto cleanup;
+
+	skel->bss->task_cnt = 0;
+	burn_cpu_ms(300);
+	ASSERT_GT(skel->bss->task_cnt, 0, "task_cnt");
+
+cleanup:
+	bpf_link__destroy(link);
+	bpf_numab_ops__destroy(skel);
+	close(cgroup_fd);
+}
+
+void serial_test_bpf_numab_ops(void)
+{
+	if (test__start_subtest("attach_detach"))
+		test_attach_detach();
+	if (test__start_subtest("hierarchy"))
+		test_hierarchy();
+	if (test__start_subtest("multi"))
+		test_multi();
+	if (test__start_subtest("mixed"))
+		test_mixed();
+	if (test__start_subtest("inherit"))
+		test_inherit();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_numab_ops.c b/tools/testing/selftests/bpf/progs/bpf_numab_ops.c
new file mode 100644
index 000000000000..c9abff2cd694
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_numab_ops.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* Counters, bumped from the NUMA balancing hot paths. */
+int enable_cnt;
+int disable_cnt;
+int task_cnt;
+int folio_cnt;
+
+SEC("struct_ops")
+u32 BPF_PROG(numab_mode_enable, struct task_struct *p, struct folio *folio)
+{
+	__sync_fetch_and_add(&enable_cnt, 1);
+	return BPF_NUMAB_NORMAL;
+}
+
+SEC(".struct_ops.link")
+struct bpf_numab_ops numab_enable_ops = {
+	.numab_mode = (void *)numab_mode_enable,
+};
+
+SEC("struct_ops")
+u32 BPF_PROG(numab_mode_disable, struct task_struct *p, struct folio *folio)
+{
+	__sync_fetch_and_add(&disable_cnt, 1);
+	return BPF_NUMAB_DISABLED;
+}
+
+SEC(".struct_ops.link")
+struct bpf_numab_ops numab_disable_ops = {
+	.numab_mode = (void *)numab_mode_disable,
+};
+
+/*
+ * A surface-dispatching policy: exactly one of @p and @folio is set, so
+ * the prog answers the task surface and the memory surface separately.
+ */
+SEC("struct_ops")
+u32 BPF_PROG(numab_mode_mixed, struct task_struct *p, struct folio *folio)
+{
+	if (p) {
+		__sync_fetch_and_add(&task_cnt, 1);
+		return BPF_NUMAB_NORMAL;
+	}
+	__sync_fetch_and_add(&folio_cnt, 1);
+	return BPF_NUMAB_TIERING;
+}
+
+SEC(".struct_ops.link")
+struct bpf_numab_ops numab_mixed_ops = {
+	.numab_mode = (void *)numab_mode_mixed,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

