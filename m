Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA03B9D95;
	Mon, 27 Apr 2026 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287080; cv=none; b=Dh7/xvxC0E0wFcS08YrsjdrJ1Fh44/YNh5+zshcVXCMdQObOALHeo+X+HbgLhWH9cIQo1PbWYPrZxVU5TSvqNkbdJKAebbF+fgGQNhz5cIiDHFHA/2+D1iSb25tSCnchB5kWpB7SfMEFgFkCxSQ5+yms6cvWLRtQwkP5JnHB8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287080; c=relaxed/simple;
	bh=3QxFt14kiiXh9VlA3GBhXAqsC41hBFH8gc+EZ1mJPJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZGH1tnQWSJZrLDcoHzY/gPMn1VwYnLqGwtwgUUoSPzpoVXT1J+JlgmUIypQD/XdcKvB4WJQhCStlh4+aY2JN374Iml6ElThbxCkVjDaQBkLV6x0DkcthnFjkZwIqJHYLLj3filz//IiH1I97ic1DohfFZptrr11VXyjek6o910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umyt6Ke1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umyt6Ke1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D3EC19425;
	Mon, 27 Apr 2026 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287080;
	bh=3QxFt14kiiXh9VlA3GBhXAqsC41hBFH8gc+EZ1mJPJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umyt6Ke1UfToGu4145D2kTZAzSOxL0TJZQg/bGdzfxal2IrWIcbPRgx8Wp2b7PlQw
	 BvVpYtbFryI9ubj7WS7B8VERjODSqc1BBmVe7WHpI0eEFyz9RsKu+myAhzDNqJBURL
	 1GIEUIcetme1ndGLXQtTyOmdzVK+wXdlDhKIn5rZ3tq3sSNmiAPBkrahT3ZbvXFALR
	 z+IOVnis1bXn8phmJXFBfQ4ptsxSBqeb7J8YAu0ofczhd9h4IyvUqNWIneDwOm+Sjb
	 zX4eoep14Cfr5tN5ZOv8D7/UzfxTOsK/TyvS06LcMhhQujD+VPqCqcVPsieUaYp6Z6
	 2Xnhdn991WbMQ==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/9] sched_ext: Sub-allocator over kernel-claimed BPF arena pages
Date: Mon, 27 Apr 2026 00:51:08 -1000
Message-ID: <20260427105109.2554518-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105109.2554518-1-tj@kernel.org>
References: <20260427105109.2554518-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build a per-scheduler sub-allocator on top of pages claimed from the BPF
arena registered in the previous patch. Subsequent kernel-managed
arena-resident structures (e.g. per-CPU set_cmask cmask) carve their storage
from this pool.

scx_arena_pool_init() creates a gen_pool. scx_arena_alloc() returns a kernel
VA and the matching BPF-arena uaddr in *@uaddr_out. On exhaustion, the pool
grows by claiming more pages via bpf_arena_alloc_pages_sleepable(). Each
chunk is added to the gen_pool with kern_va as the "virt" and uaddr as the
"phys", so gen_pool_virt_to_phys() recovers the uaddr for handing to BPF.

Allocations sleep (GFP_KERNEL) - they may grow the pool through vzalloc and
arena page allocation. All current consumers run from the enable path (after
ops.init() and the kernel-side arena auto-discovery, before validate_ops()),
where sleeping is fine.

scx_arena_pool_destroy() walks each chunk, returns outstanding ranges to the
gen_pool with gen_pool_free() and then calls gen_pool_destroy(). The
underlying arena pages are released when the arena map itself is torn down,
so the pool destroy doesn't free them explicitly.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/build_policy.c |   4 ++
 kernel/sched/ext.c          |  11 ++++
 kernel/sched/ext_arena.c    | 128 ++++++++++++++++++++++++++++++++++++
 kernel/sched/ext_arena.h    |  18 +++++
 kernel/sched/ext_internal.h |   6 ++
 5 files changed, 167 insertions(+)
 create mode 100644 kernel/sched/ext_arena.c
 create mode 100644 kernel/sched/ext_arena.h

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 5e76c9177d54..067979a7b69e 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -59,12 +59,16 @@
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 # include <linux/btf_ids.h>
+# include <linux/find.h>
+# include <linux/genalloc.h>
 # include "ext_types.h"
 # include "ext_internal.h"
 # include "ext_cid.h"
+# include "ext_arena.h"
 # include "ext_idle.h"
 # include "ext.c"
 # include "ext_cid.c"
+# include "ext_arena.c"
 # include "ext_idle.c"
 #endif
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 835ac505f991..27c2b4df79d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4916,6 +4916,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
 	kfree(sch);
@@ -6975,6 +6976,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
+	ret = scx_arena_pool_init(sch);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
+
 	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
@@ -7264,6 +7271,10 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
+	ret = scx_arena_pool_init(sch);
+	if (ret)
+		goto err_disable;
+
 	if (validate_ops(sch, ops))
 		goto err_disable;
 
diff --git a/kernel/sched/ext_arena.c b/kernel/sched/ext_arena.c
new file mode 100644
index 000000000000..561cfe5418ff
--- /dev/null
+++ b/kernel/sched/ext_arena.c
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * scx_arena_pool: kernel-side sub-allocator over BPF-arena pages.
+ *
+ * Each chunk added to @sch->arena_pool comes from one
+ * bpf_arena_alloc_pages_sleepable() call. We add it to gen_pool with the
+ * kernel-VA as the "virt" address and the matching BPF uaddr as the "phys" so
+ * gen_pool_virt_to_phys() recovers the uaddr for handing back to BPF.
+ *
+ * Allocations grow the pool on demand. Underlying arena pages are released
+ * when the arena map itself is torn down.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+
+enum scx_arena_consts {
+	SCX_ARENA_MIN_ORDER		= 3,	/* 8-byte minimum sub-allocation */
+	SCX_ARENA_GROW_PAGES		= 4,	/* per growth */
+};
+
+s32 scx_arena_pool_init(struct scx_sched *sch)
+{
+	if (!sch->arena_map)
+		return 0;
+
+	sch->arena_pool = gen_pool_create(SCX_ARENA_MIN_ORDER, NUMA_NO_NODE);
+	if (!sch->arena_pool)
+		return -ENOMEM;
+	return 0;
+}
+
+static void scx_arena_clear_chunk(struct gen_pool *pool, struct gen_pool_chunk *chunk,
+				  void *data)
+{
+	int order = pool->min_alloc_order;
+	size_t chunk_sz = chunk->end_addr - chunk->start_addr + 1;
+	unsigned long end_bit = chunk_sz >> order;
+	unsigned long b, e;
+
+	for_each_set_bitrange(b, e, chunk->bits, end_bit)
+		gen_pool_free(pool, chunk->start_addr + (b << order),
+			      (e - b) << order);
+}
+
+/*
+ * Tear down the pool. Outstanding gen_pool allocations are freed via
+ * scx_arena_clear_chunk() so gen_pool_destroy() doesn't BUG. The underlying
+ * arena pages are released when the arena map itself is torn down.
+ */
+void scx_arena_pool_destroy(struct scx_sched *sch)
+{
+	if (!sch->arena_pool)
+		return;
+	gen_pool_for_each_chunk(sch->arena_pool, scx_arena_clear_chunk, NULL);
+	gen_pool_destroy(sch->arena_pool);
+	sch->arena_pool = NULL;
+}
+
+/*
+ * Grow the pool by @page_cnt pages. bpf_arena_alloc_pages_sleepable() and
+ * gen_pool_add_virt() (which calls vzalloc(GFP_KERNEL)) require a sleepable
+ * context.
+ */
+static int scx_arena_grow(struct scx_sched *sch, u32 page_cnt)
+{
+	u64 kern_vm_start;
+	u32 uaddr32;
+	void *p;
+	int ret;
+
+	if (!sch->arena_map || !sch->arena_pool)
+		return -EINVAL;
+
+	p = bpf_arena_alloc_pages_sleepable(sch->arena_map, NULL,
+					    page_cnt, NUMA_NO_NODE, 0);
+	if (!p)
+		return -ENOMEM;
+
+	uaddr32 = (u32)(unsigned long)p;
+	kern_vm_start = bpf_arena_map_kern_vm_start(sch->arena_map);
+
+	ret = gen_pool_add_virt(sch->arena_pool, kern_vm_start + uaddr32,
+				uaddr32, page_cnt * PAGE_SIZE, NUMA_NO_NODE);
+	if (ret) {
+		bpf_arena_free_pages_non_sleepable(sch->arena_map, p, page_cnt);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * Allocate @size bytes from the arena pool. Returns kernel VA on success, NULL
+ * on failure. *@uaddr_out gets the BPF-arena address. May grow the pool via
+ * scx_arena_grow() which sleeps. Caller must be in a GFP_KERNEL context.
+ */
+void *scx_arena_alloc(struct scx_sched *sch, size_t size, u32 *uaddr_out)
+{
+	unsigned long kern_va;
+	u32 page_cnt;
+
+	might_sleep();
+
+	if (!sch->arena_pool)
+		return NULL;
+
+	kern_va = gen_pool_alloc(sch->arena_pool, size);
+	if (!kern_va) {
+		page_cnt = max_t(u32, SCX_ARENA_GROW_PAGES,
+				 (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
+		if (scx_arena_grow(sch, page_cnt))
+			return NULL;
+		kern_va = gen_pool_alloc(sch->arena_pool, size);
+		if (!kern_va)
+			return NULL;
+	}
+
+	*uaddr_out = (u32)gen_pool_virt_to_phys(sch->arena_pool, kern_va);
+	return (void *)kern_va;
+}
+
+void scx_arena_free(struct scx_sched *sch, void *kern_va, size_t size)
+{
+	if (sch->arena_pool && kern_va)
+		gen_pool_free(sch->arena_pool, (unsigned long)kern_va, size);
+}
diff --git a/kernel/sched/ext_arena.h b/kernel/sched/ext_arena.h
new file mode 100644
index 000000000000..d21b2e3fac93
--- /dev/null
+++ b/kernel/sched/ext_arena.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
+ */
+#ifndef _KERNEL_SCHED_EXT_ARENA_H
+#define _KERNEL_SCHED_EXT_ARENA_H
+
+struct scx_sched;
+
+s32 scx_arena_pool_init(struct scx_sched *sch);
+void scx_arena_pool_destroy(struct scx_sched *sch);
+void *scx_arena_alloc(struct scx_sched *sch, size_t size, u32 *uaddr_out);
+void scx_arena_free(struct scx_sched *sch, void *kern_va, size_t size);
+
+#endif /* _KERNEL_SCHED_EXT_ARENA_H */
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bcffbc32541c..56d99e749c9d 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1108,8 +1108,14 @@ struct scx_sched {
 	 * cid-form schedulers must use exactly one arena with
 	 * BPF_F_ARENA_MAP_ALWAYS to enable direct arena access from kernel
 	 * side. NULL on cpu-form.
+	 *
+	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
+	 * with kern_va as the "virt" address and the matching BPF uaddr as the
+	 * "phys", so gen_pool_virt_to_phys() recovers the uaddr for handing to
+	 * BPF. Grows on demand and pages are not released until sched destroy.
 	 */
 	struct bpf_map		*arena_map;
+	struct gen_pool		*arena_pool;
 
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
-- 
2.53.0

