Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D143E92B2
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687477; cv=none; b=IIdE+PEhzI+zpLJRlY2jt0jQwYxyu8vUPFvW0T/UuQpfIANmgjJ77GyTMboE3I3EAjrVm1yAhkAKSQ4CnciYdaAdeAEzg4yA3t4jQk9zYgzHYzc74PsLiAadydzRzvsLgy22judWz5c6Yb19ypf9ES1iYqAdAbJJ6Hm3Tmpe9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687477; c=relaxed/simple;
	bh=sGAShIPg7+jUUzSM1C6eSf6v479ZKam3pd0iQ2+kvJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU0y4B+iOkK9+owEOZzx6Pb67dmd0LiiaWvEiJw1U2M9NCCRjHLn7OXO/h0su5ut5RqsHCNvli4OOJiZR6ZYzfoUnq/r7v8yqD2grM5NCB8biU8gl5m6wVDeT00xs8+S/Ue4ydjRuBHRbc2hqjNaAWnfWmGf6AAE7sV6VXqMuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkEyxhW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkEyxhW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB9C19421;
	Mon, 16 Mar 2026 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687477;
	bh=sGAShIPg7+jUUzSM1C6eSf6v479ZKam3pd0iQ2+kvJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkEyxhW7n2SNs/SSutl+I80VKoAS32KCHuLa51h9UGyWVaAIjsCZLu/w7ms1qsK57
	 3GHrYwWrrRaol+b4NsOwjxW1MYMy3PpqWNb8JV7+CE1JRA4CPjhIindDphTCjscOuI
	 YWL0HYiaV7mdQH/Jt5o5ZlvSoaM6X0b+204hv7+dVBAJST2Gh3PUL2/BAAuj9M+02N
	 NpeGXLBhb6hANNw4LyVwObxDoZLVst0bfJHnsCqdXAOi1sCWlZs9AUDlYraK2mHV7K
	 JFM9LFAFTSIfvrmt3+jZEWSS1kIweJl5f6vs/Q5z+tkkkckD99Fxp6zCNt41CHHyaX
	 e1rP479vsesJQ==
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
Subject: [PATCH bpf v4 2/3] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
Date: Mon, 16 Mar 2026 11:57:32 -0700
Message-ID: <20260316185736.649940-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316185736.649940-1-puranjay@kernel.org>
References: <20260316185736.649940-1-puranjay@kernel.org>
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
 kernel/bpf/task_iter.c | 98 +++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 718f0f9b6396..ddaf1cf0ecae 100644
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
-	struct mmap_unlock_irq_work *work;
-	struct vma_iterator vmi;
+	struct vm_area_struct *locked_vma;
+	u64 next_addr;
 };
 
 struct bpf_iter_task_vma {
@@ -820,15 +821,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
 	/*
 	 * Reject irqs-disabled contexts including NMI. Operations used
-	 * by _next() and _destroy() (mmap_read_unlock, mmput_async)
+	 * by _next() and _destroy() (vma_end_read, mmput_async)
 	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
 	 * Running from NMI or from a tracepoint that fires with those
 	 * locks held could deadlock.
@@ -853,28 +858,15 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
 
-	if (!mmap_read_trylock(kit->data->mm)) {
-		err = -EBUSY;
-		goto err_cleanup_mmget;
-	}
-
-	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
+	kit->data->locked_vma = NULL;
+	kit->data->next_addr = addr;
 	return 0;
 
-err_cleanup_mmget:
-	mmput_async(kit->data->mm);
 err_cleanup_iter:
 	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
@@ -883,13 +875,76 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
@@ -897,7 +952,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		if (kit->data->locked_vma)
+			vma_end_read(kit->data->locked_vma);
 		put_task_struct(kit->data->task);
 		mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
-- 
2.52.0

