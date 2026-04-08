Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6F2BF00A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663149; cv=none; b=m3QH3hO3igIQO3ImuJvO8dPRE84U2rS2obyM+om0R4qS7DcgQWXJHNy3WYXzq8OnwCNrBlyN3rkGu2lGrF4CML3gW9a8o8iAN/gdUj94/ba03VqmVKugpuaoa+4kTv4Bjj2m0wLo5hwcpAgvmVQHX4y7lAMbsVE7pZ1ET5I3iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663149; c=relaxed/simple;
	bh=LROm5kFhO/yD4BmsxPDseebmkhpNsp8/iRp6P+EH8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZXAvYx8Rf4QVe0i5fs3VY177P0d/l5IlSZQz2TDSyw8oMBXCYEAyMuzsrnp4DS9ygnOgQWERSSbsXqeNI/LsH3hXjLvRuy8HsZQ6uUa3BmjVUDHxyuD+X8FzpJqDD2A+quZpaV4BwBNSLPqWdODQQmJi0decUpXJeAF2TXUe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDB3YM9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDB3YM9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E8EC19421;
	Wed,  8 Apr 2026 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663149;
	bh=LROm5kFhO/yD4BmsxPDseebmkhpNsp8/iRp6P+EH8QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDB3YM9KQtBLNE3PeYEIlJlBsxTbdX3CkUcSY86RzfYcJ/k6EYVg42m8vPd13fPuw
	 RnS9+Mmg+G/RfZcpMhtb2S5pGsJ8VMSWlKD3YHXwL3BGtUTGSQSjkRY46aQSr/kNy5
	 Vd/6JfqZtLlwK4D5GAuruHTbm0EF9Z6rt9YT5fZWm94BhRp5V0ZXi7FpW3UMtl7N7Y
	 5lbyVVfyiZInYl/DEBLf9eJg5tsxN/b/baxpfyGRPmqrLMJc+E8RnHlj6KA2bdXlAb
	 xfxLIb4UD+pEcGS99WORq8mCbLC8cIv+iuY9F+SziGx1UCWzKI5FE1kbZ7Dby9Tf6q
	 vd98uSJckuocg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf v6 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Wed,  8 Apr 2026 08:45:35 -0700
Message-ID: <20260408154539.3832150-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408154539.3832150-1-puranjay@kernel.org>
References: <20260408154539.3832150-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The open-coded task_vma iterator reads task->mm locklessly and acquires
mmap_read_trylock() but never calls mmget(). If the task exits
concurrently, the mm_struct can be freed as it is not
SLAB_TYPESAFE_BY_RCU, resulting in a use-after-free.

Safely read task->mm with a trylock on alloc_lock and acquire an mm
reference. Drop the reference via bpf_iter_mmput_async() in _destroy()
and error paths. bpf_iter_mmput_async() is a local wrapper around
mmput_async() with a fallback to mmput() on !CONFIG_MMU.

Reject irqs-disabled contexts (including NMI) up front. Operations used
by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
take spinlocks with IRQs disabled (pool->lock, pi_lock). Running from
NMI or from a tracepoint that fires with those locks held could
deadlock.

A trylock on alloc_lock is used instead of the blocking task_lock()
(get_task_mm) to avoid a deadlock when a softirq BPF program iterates
a task that already holds its alloc_lock on the same CPU.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 54 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..c1f5fbe9dc2f 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -794,6 +795,15 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+static inline void bpf_iter_mmput_async(struct mm_struct *mm)
+{
+#ifdef CONFIG_MMU
+	mmput_async(mm);
+#else
+	mmput(mm);
+#endif
+}
+
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
@@ -825,6 +835,24 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
 
+	/* bpf_iter_mmput_async() needs mmput_async() which requires CONFIG_MMU */
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		kit->data = NULL;
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Reject irqs-disabled contexts including NMI. Operations used
+	 * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
+	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
+	 * Running from NMI or from a tracepoint that fires with those
+	 * locks held could deadlock.
+	 */
+	if (irqs_disabled()) {
+		kit->data = NULL;
+		return -EBUSY;
+	}
+
 	/* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
 	 * before, so non-NULL kit->data doesn't point to previously
 	 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
@@ -834,7 +862,25 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		return -ENOMEM;
 
 	kit->data->task = get_task_struct(task);
+	/*
+	 * Safely read task->mm and acquire an mm reference.
+	 *
+	 * Cannot use get_task_mm() because its task_lock() is a
+	 * blocking spin_lock that would deadlock if the target task
+	 * already holds alloc_lock on this CPU (e.g. a softirq BPF
+	 * program iterating a task interrupted while holding its
+	 * alloc_lock).
+	 */
+	if (!spin_trylock(&task->alloc_lock)) {
+		err = -EBUSY;
+		goto err_cleanup_iter;
+	}
 	kit->data->mm = task->mm;
+	if (kit->data->mm && !(task->flags & PF_KTHREAD))
+		mmget(kit->data->mm);
+	else
+		kit->data->mm = NULL;
+	spin_unlock(&task->alloc_lock);
 	if (!kit->data->mm) {
 		err = -ENOENT;
 		goto err_cleanup_iter;
@@ -844,15 +890,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
 	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
 		err = -EBUSY;
-		goto err_cleanup_iter;
+		goto err_cleanup_mmget;
 	}
 
 	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
 	return 0;
 
+err_cleanup_mmget:
+	bpf_iter_mmput_async(kit->data->mm);
 err_cleanup_iter:
-	if (kit->data->task)
-		put_task_struct(kit->data->task);
+	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
 	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
 	kit->data = NULL;
@@ -875,6 +922,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
 		put_task_struct(kit->data->task);
+		bpf_iter_mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
 }
-- 
2.52.0

