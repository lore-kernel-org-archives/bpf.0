Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61539934D
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269876; cv=none; b=hZWipyvUomW/KBD4jC5H5PqnAM4tle+dvIDEnDK7M4dSvXTg/xKsEi+SOfjUU0YtUuVT/lSEu3IVB5DAGXCL6e490zoAL5qDvXfYKkyP7K3w6etF2FUPL78nSrHdnXk4BPy4eBebPcImWnNhjbjie39OKJdgc2I+um3ArxLOj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269876; c=relaxed/simple;
	bh=eSzS7c/zhp13S7jXTIcW3BjR668olFUTY+eUuj5KJsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2UE6WijURegHxVt10jehVJb2uol3O3fYL4ZPD58rNsI4pCKKCoAcp8haYjf3jXp4Fngx/Ue7WQ7OPB1X1tUBHs82etz1K7ApXkjjLddjG9FfE0A6f6AKIglVjrsM2OLlM5PXAe8h/4Ucgcg8cS98rC2C0fGT+CoZGYhONf6igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW3w0bkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW3w0bkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9CBC4CEF7;
	Wed, 11 Mar 2026 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773269876;
	bh=eSzS7c/zhp13S7jXTIcW3BjR668olFUTY+eUuj5KJsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BW3w0bkFUwbOWYUTRvM5DjfAnDz02QiC7P8kkoSmBXO78nwKMXLTX82cgwyvtb0DW
	 VEyHAOkESEhYm541swIfZ2xSNyz2F3SQ8ybOR6dmqfD1739X2ZI8tMcQHb3iNHzG9a
	 bf+zEItIuITSFpzIY+7RRFWVUiOClKL88fXPv05qJ4A1FEslMJdZhVnlXSeRFequ0+
	 GIHlgQC9TTAsIFlNUT4i75tTkFi+QV440yINqIgDWjATbvV8V83vNwsWR0viE/M/vi
	 yZXAtwwByxp0M5dPF0dFb+CZnYEjokH8Tty5lIWd63vHQT+2B45GIXT7YPWTt2W8h0
	 ah9gAN5QtONug==
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
Subject: [PATCH bpf v3 2/3] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
Date: Wed, 11 Mar 2026 15:57:22 -0700
Message-ID: <20260311225726.808332-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311225726.808332-1-puranjay@kernel.org>
References: <20260311225726.808332-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The open-coded task_vma iterator holds mmap_lock for the entire duration
of iteration, increasing contention on this highly contended lock.

Switch to per-VMA locking. Find the next VMA via an RCU-protected maple
tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is not
used because its fallback takes mmap_read_lock(), and the iterator must
work in non-sleepable contexts.

lock_vma_under_rcu() is a point lookup (mas_walk) that finds the VMA
containing a given address but cannot iterate across gaps. An
RCU-protected vma_next() walk (mas_find) first locates the next VMA's
vm_start to pass to lock_vma_under_rcu().

Between the RCU walk and the lock, the VMA may be removed, shrunk, or
write-locked. On failure, advance past it using vm_end from the RCU
walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
stale; fall back to PAGE_SIZE advancement when it does not make forward
progress. Concurrent VMA insertions at addresses already passed by the
iterator are not detected.

CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 105 +++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2ccdc3228063..50dbeaeafd86 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
@@ -798,9 +799,9 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct mmap_unlock_irq_work *work;
-	struct vma_iterator vmi;
+	struct vm_area_struct *locked_vma;
 	struct irq_work irq_work;
+	u64 next_addr;
 };
 
 struct bpf_iter_task_vma {
@@ -831,12 +832,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 				      struct task_struct *task, u64 addr)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-	bool irq_work_busy = false;
 	int err;
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
 
+	if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
+		kit->data = NULL;
+		return -EOPNOTSUPP;
+	}
+
 	/* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
 	 * before, so non-NULL kit->data doesn't point to previously
 	 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
@@ -852,38 +857,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy) {
-		err = -EBUSY;
-		goto err_cleanup_iter;
-	}
-
 	if (!mmget_not_zero(kit->data->mm)) {
 		err = -ENOENT;
 		goto err_cleanup_iter;
 	}
 
+	kit->data->locked_vma = NULL;
 	init_irq_work(&kit->data->irq_work, do_bpf_iter_mmput);
-
-	if (!mmap_read_trylock(kit->data->mm)) {
-		err = -EBUSY;
-		goto err_cleanup_mmget;
-	}
-
-	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
+	kit->data->next_addr = addr;
 	return 0;
 
-err_cleanup_mmget:
-	put_task_struct(kit->data->task);
-	if (!irqs_disabled()) {
-		mmput_async(kit->data->mm);
-		bpf_mem_free(&bpf_global_ma, kit->data);
-	} else {
-		irq_work_queue(&kit->data->irq_work);
-	}
-	kit->data = NULL;
-	return err;
 err_cleanup_iter:
 	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
@@ -892,13 +875,76 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	return err;
 }
 
+/*
+ * Find and lock the next VMA at or after data->next_addr.
+ *
+ * lock_vma_under_rcu() is a point lookup (mas_walk): it finds the VMA
+ * containing a given address but cannot iterate. An RCU-protected
+ * maple tree walk with vma_next() (mas_find) is needed first to locate
+ * the next VMA's vm_start across any gap.
+ *
+ * Between the RCU walk and the lock, the VMA may be removed, shrunk,
+ * or write-locked. On failure, advance past it using vm_end from the
+ * RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall back
+ * to PAGE_SIZE advancement to guarantee forward progress.
+ */
+static struct vm_area_struct *
+bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+	unsigned long start, end;
+
+retry:
+	rcu_read_lock();
+	vma_iter_init(&vmi, data->mm, data->next_addr);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	start = vma->vm_start;
+	end = vma->vm_end;
+	rcu_read_unlock();
+
+	vma = lock_vma_under_rcu(data->mm, start);
+	if (!vma) {
+		if (end > data->next_addr)
+			data->next_addr = end;
+		else
+			data->next_addr += PAGE_SIZE;
+		goto retry;
+	}
+
+	if (unlikely(data->next_addr >= vma->vm_end)) {
+		data->next_addr += PAGE_SIZE;
+		vma_end_read(vma);
+		goto retry;
+	}
+
+	return vma;
+}
+
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
+	struct vm_area_struct *vma;
 
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
-	return vma_next(&kit->data->vmi);
+
+	if (kit->data->locked_vma) {
+		vma_end_read(kit->data->locked_vma);
+		kit->data->locked_vma = NULL;
+	}
+
+	vma = bpf_iter_task_vma_find_next(kit->data);
+	if (!vma)
+		return NULL;
+
+	kit->data->locked_vma = vma;
+	kit->data->next_addr = vma->vm_end;
+	return vma;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -906,7 +952,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		if (kit->data->locked_vma)
+			vma_end_read(kit->data->locked_vma);
 		put_task_struct(kit->data->task);
 		/*
 		 * mmput_async() -> schedule_work() -> __queue_work()
-- 
2.52.0

