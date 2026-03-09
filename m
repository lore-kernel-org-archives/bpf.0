Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B931AAAA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071733; cv=none; b=M4SKOik4T0+QFVrGvWavQU1qmW0S8s7aUKxOa3dfKJHPiTS1DMqi9ebtSTU88Ljz8a3J1M6fHs5n1Kjsj9f9SAku9RnMKZ2PfG99M+fld5s2Q4scXpSI1w6jvYG4rrVN06NXatY7coLuI57Mk3h26RxbeX7pW7hgi0slJEzagDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071733; c=relaxed/simple;
	bh=F9x0krFAISFq0UnFgVHYXG8BUpXhH47G6yhGZnr3kn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtzZ0JnQfWWGx25dt+Gp1qGlJk0k/yQx2nw0kX12IcYnR6+nBlLXK/PWqdcTxE0Mo24GzW/W5kEgItlmZsp8LCMTU8Z2T0bI1Bbhsw820h8/i1v1IEU+08DR5IEe67H4RDpNPb2ruLPrRhqg4GsQDqyA8j+sYI1Ueq1xJLECFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lncYkJ+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lncYkJ+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B11FC4CEF7;
	Mon,  9 Mar 2026 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071732;
	bh=F9x0krFAISFq0UnFgVHYXG8BUpXhH47G6yhGZnr3kn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lncYkJ+ToPQ9zvM+Nnfo8mNNEOFxanrnNpI4D+ZihhOEzNA5drvHpyt1t5SJPiKsD
	 TsoxMYrmxdHT/GTrQbzRBBwmAoIzTQrInEYgr8s0XJW/4FJdTkcsqxFP0Q4abfE5No
	 ZHNinfQ4cDoP4UJvkPdlhbpWVoQkvbIPxKgttIsbXhhEe3uycr1EGh9kp9iGY7pN28
	 INO87LqFRpdPpU/swMgL/V/34VggyFN9rNOoiowKSeCx9Qf53hwXcH4Nw8WL6XnOZL
	 qT5z9i8QsuQZXr6MOu6HioDg0BHVQaDHSdc4WNhKopMsgFn+fHO9EJs7JGIW/Z2c7s
	 WIqiwUQ9ZY+tg==
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
	kernel-team@meta.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf v2 3/4] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
Date: Mon,  9 Mar 2026 08:54:57 -0700
Message-ID: <20260309155506.23490-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309155506.23490-1-puranjay@kernel.org>
References: <20260309155506.23490-1-puranjay@kernel.org>
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

Between the RCU walk and the lock, the VMA may be removed, shrunk, or
write-locked. On failure, advance past it using vm_end from the RCU
walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
stale; fall back to PAGE_SIZE advancement when it does not make forward
progress. VMAs inserted in gaps between iterations are not detected.

CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/task_iter.c | 91 +++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e8efc9e1f602..e20c85e06afa 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
@@ -798,8 +799,8 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct bpf_iter_mm_irq_work *work;
-	struct vma_iterator vmi;
+	struct vm_area_struct *locked_vma;
+	u64 last_addr;
 };
 
 struct bpf_iter_task_vma {
@@ -858,12 +859,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
@@ -879,12 +884,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	/*
-	 * Both mmap_lock and mmput irq_work slots must be free for _destroy().
-	 * kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work
-	 */
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || bpf_iter_mmput_busy()) {
+	/* Ensure the mmput irq_work slot is free for _destroy(). */
+	if (bpf_iter_mmput_busy()) {
 		err = -EBUSY;
 		goto err_cleanup_iter;
 	}
@@ -894,16 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	if (!mmap_read_trylock(kit->data->mm)) {
-		err = -EBUSY;
-		goto err_cleanup_mmget;
-	}
-
-	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
+	kit->data->locked_vma = NULL;
+	kit->data->last_addr = addr;
 	return 0;
 
-err_cleanup_mmget:
-	bpf_iter_mmput(kit->data->mm);
 err_cleanup_iter:
 	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
@@ -912,13 +907,70 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	return err;
 }
 
+/*
+ * Find and lock the next VMA at or after data->last_addr using an
+ * RCU-protected maple tree walk followed by lock_vma_under_rcu().
+ * On failure or if the VMA changed, advance past it using vm_end from
+ * the RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall
+ * back to PAGE_SIZE advancement to guarantee forward progress.
+ */
+static struct vm_area_struct *
+bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+	unsigned long next_addr, next_end;
+
+retry:
+	rcu_read_lock();
+	vma_iter_init(&vmi, data->mm, data->last_addr);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	next_addr = vma->vm_start;
+	next_end = vma->vm_end;
+	rcu_read_unlock();
+
+	vma = lock_vma_under_rcu(data->mm, next_addr);
+	if (!vma) {
+		if (next_end > data->last_addr)
+			data->last_addr = next_end;
+		else
+			data->last_addr += PAGE_SIZE;
+		goto retry;
+	}
+
+	if (unlikely(data->last_addr >= vma->vm_end)) {
+		data->last_addr = vma->vm_end;
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
+	if (kit->data->locked_vma)
+		vma_end_read(kit->data->locked_vma);
+
+	vma = bpf_iter_task_vma_find_next(kit->data);
+	if (!vma) {
+		kit->data->locked_vma = NULL;
+		return NULL;
+	}
+
+	kit->data->locked_vma = vma;
+	kit->data->last_addr = vma->vm_end;
+	return vma;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -926,7 +978,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		if (kit->data->locked_vma)
+			vma_end_read(kit->data->locked_vma);
 		bpf_iter_mmput(kit->data->mm);
 		put_task_struct(kit->data->task);
 		bpf_mem_free(&bpf_global_ma, kit->data);
-- 
2.47.3

