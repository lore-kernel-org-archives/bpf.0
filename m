Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F43A3E9C;
	Wed, 20 May 2026 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321066; cv=none; b=oYs4yn1AOxac9B4mStZ7R6Ir+1zvobt9x1f07eScoJ2bUcW9K4jWtEw70cpWysWOuwh5Lakuiwb98wtYmtavNcJpycHgqWqWVN02R1kN3R2FlVQkWIS7lITX8V1ulVnlc+q08UPhJngddI7xJYkSNFt6goBd9RIY2Lx0a2JHg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321066; c=relaxed/simple;
	bh=CmaSxokkvlRLFrROBdPgYBc3HhKD4GVPgw+XoEV11jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2qFXJnNzwPjdaDjoGqNSGJKYwSz/IFdcUnEKxSHmV73LkqWP1T76C89AeAAfEDVYFVck2OsRgd79O75wHRQj6P/7OiKktyHAKjPCZLUqcZiN3juYvemmzmRTz98bR1AjxZyf7Jg6vxSr+P7Jw3q4kEIX/DIKy3eFBdIHSTagbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7ViVbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB7ViVbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4162F1F00A39;
	Wed, 20 May 2026 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321060;
	bh=pxPJ5Kb1pUca7gBA63ZwC2/H1JHE6paqYcxxGSFa3qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XB7ViVbI6QwMQAtAil6w+oL8bl0oAUYhmJxQH/p3CVU4rkIrtPxkP4wZHqFThxJaT
	 Quip1QtcqkbzJwbhSLN2qv+Pdjk/CoYJIeYGN5ZR0ycpdWVXnz4d/pduzbZivrz1LZ
	 4KQ2rTsPHaiUf2AQEF5jpsTgRVvJzZT3rGU9Y/0139arL3KUA2HtyxlJXnTN/JcyW2
	 zP4cHBDOsfy/v3064tbJ//EMDQgf4qI7wL6986AU/Kes8ibuahwkM6z832ag2zcnIA
	 JPyOoN1f623cxD12L7EzFewa2TcKySgmGyluNRSTYn84Y6FIQpfoBTPWZON07m542j
	 fmEfYTtQcjX+g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF arena pages
Date: Wed, 20 May 2026 13:50:51 -1000
Message-ID: <20260520235052.4180316-8-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520235052.4180316-1-tj@kernel.org>
References: <20260520235052.4180316-1-tj@kernel.org>
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

scx_arena_pool_init() creates a gen_pool. scx_arena_alloc() returns the
kernel VA. On exhaustion, the pool grows by claiming more pages via
bpf_arena_alloc_pages_sleepable(). Chunks are added at the kernel-side
mapping address; callers translate to the BPF-arena form themselves if
needed.

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
 kernel/sched/ext_arena.c    | 127 ++++++++++++++++++++++++++++++++++++
 kernel/sched/ext_arena.h    |  18 +++++
 kernel/sched/ext_internal.h |   5 ++
 5 files changed, 165 insertions(+)
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
index 56f94ac32ba0..fb91079c1244 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5003,6 +5003,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
 	kfree(sch);
@@ -7155,6 +7156,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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
@@ -7473,6 +7480,10 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
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
index 000000000000..53174033765d
--- /dev/null
+++ b/kernel/sched/ext_arena.c
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * scx_arena_pool: kernel-side sub-allocator over BPF-arena pages.
+ *
+ * Each chunk added to @sch->arena_pool comes from one
+ * bpf_arena_alloc_pages_sleepable() call and is registered at the
+ * kernel-side mapping address. Callers translate to the BPF-arena form
+ * themselves if needed.
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
+ * gen_pool_add() (which calls vzalloc(GFP_KERNEL)) require a sleepable
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
+	ret = gen_pool_add(sch->arena_pool, kern_vm_start + uaddr32,
+			   page_cnt * PAGE_SIZE, NUMA_NO_NODE);
+	if (ret) {
+		bpf_arena_free_pages_non_sleepable(sch->arena_map, p, page_cnt);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * Allocate @size bytes from the arena pool. Returns kernel VA on success, NULL
+ * on failure. May grow the pool via scx_arena_grow() which sleeps. Caller must
+ * be in a GFP_KERNEL context.
+ */
+void *scx_arena_alloc(struct scx_sched *sch, size_t size)
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
index 000000000000..4f3610160102
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
+void *scx_arena_alloc(struct scx_sched *sch, size_t size);
+void scx_arena_free(struct scx_sched *sch, void *kern_va, size_t size);
+
+#endif /* _KERNEL_SCHED_EXT_ARENA_H */
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index d40cfd29ddaa..ff7e882bd67a 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1116,8 +1116,13 @@ struct scx_sched {
 	 * Arena map auto-discovered from member progs at struct_ops attach.
 	 * cid-form schedulers must use exactly one arena across all member
 	 * progs. NULL on cpu-form.
+	 *
+	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
+	 * at the kernel-side mapping address. Grows on demand and pages are
+	 * not released until sched destroy.
 	 */
 	struct bpf_map		*arena_map;
+	struct gen_pool		*arena_pool;
 
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
-- 
2.54.0

