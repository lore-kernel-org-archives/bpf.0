Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469235957
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634049; cv=none; b=JbWRgYcxprmf7fTqOnDjpxvrLyBBbhPZXdXiFEGQB0qIQD+zIUeLg9ClG2ZyJJVc5aP+QYUZgVP5D6wOMyNSxbl9Jwz5nI8CVy+vESFsYUEXE/FrBHylE5Jq/nx0gJ66aION6Wl63DjW7HJNK2FWsFfNyQ3f/X6LO9zq1/FsgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634049; c=relaxed/simple;
	bh=MXBSTw/bWa5zcC1NIt0/yW/ruRv5P2c/saAs/3YN7yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roy6t51usLHrELIyeG0G4PxQc6MeZWuJrZRsGiM7d+1ndzv7wilTitRweL/Vt4Xeti9X5GpVRikjVI6M5SNgfi0Pi5k6twss9OwT40dZTabbnuDNDBurkOoEpZrbhUybBfeSusgHRT9yzN+QQWZE6A8o2GDfxT7DnIAZKn/kY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvWM/6Jg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvWM/6Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E15C4CEF7;
	Wed,  4 Mar 2026 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634049;
	bh=MXBSTw/bWa5zcC1NIt0/yW/ruRv5P2c/saAs/3YN7yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvWM/6JgZw5PMqKpfd7SMQ7oE1jFIfWSDvSnyP7ipinJLumjl7mBF51CWOYA9hOYl
	 T5XWRHjZ85/Q4A8+5s7QAnlwyCjeL4jESu/EEiUR5VyPjSvBskROoY9rMu4DZYwqjr
	 L5k2h6imvt4043VAuuW8RohkyfqCB3spKeub3Lb4SV1I0B6cejfqmtsoPiYm7fUK3D
	 8Zj7zHej/PufM43u//hJuUMTedZklLfF0c3AD4b2w+tmn8tCZOh6rGDFFfHx/nJe6v
	 p8XKpCW0K7AMYUzb+7gSXUb6LJysVIr0jyABprJlHEtQxgRTG2kdlx+8N2ZvCzJbA4
	 zNR/uC6eexwtQ==
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
Subject: [PATCH bpf 2/3] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
Date: Wed,  4 Mar 2026 06:20:15 -0800
Message-ID: <20260304142026.1443666-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304142026.1443666-1-puranjay@kernel.org>
References: <20260304142026.1443666-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The open-coded task_vma BPF iterator holds mmap_lock for the entire
duration of the iteration, increasing contention on this highly
contended lock.

Switch to per-VMA locking. In _next(), the next VMA is found via an
RCU-protected maple tree walk, then locked with lock_vma_under_rcu()
at its vm_start address. lock_next_vma() is not used because its
fallback path takes mmap_read_lock(), and the iterator must work in
non-sleepable contexts.

Between the RCU walk and the lock attempt, the VMA may be removed,
shrunk, or write-locked. When lock_vma_under_rcu() fails or the locked
VMA was modified, the iterator advances past it and retries using vm_end
saved from the RCU walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU,
individual objects can be freed and immediately reused within an RCU
critical section. A VMA found by the maple tree walk may be recycled for
a different mm before its fields are read, making the captured vm_end
stale. When vm_end is stale and no longer ahead of the iteration
position, the iterator falls back to PAGE_SIZE advancement to guarantee
forward progress. VMAs inserted in gaps between iterations cannot be
detected without mmap_lock speculation.

The mm_struct is kept alive with mmget()/bpf_iter_mmput(). The
bpf_mmap_unlock_get_irq_work() check is no longer needed since
mmap_lock is no longer held; bpf_iter_mmput_busy() remains to guard the
mmput irq_work slot. CONFIG_PER_VMA_LOCK is required; -EOPNOTSUPP is
returned without it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 72 +++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d3fa8ba0a896..ff29d4da0267 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -797,8 +798,8 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct mmap_unlock_irq_work *work;
-	struct vma_iterator vmi;
+	struct vm_area_struct *locked_vma;
+	u64 last_addr;
 };
 
 struct bpf_iter_task_vma {
@@ -868,12 +869,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
@@ -890,13 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	}
 
 	/*
-	 * Check irq_work availability for both mmap_lock release and mmput.
-	 * Both use separate per-CPU irq_work slots, and both must be free
-	 * to guarantee _destroy() can complete from NMI context.
-	 * kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work
+	 * Ensure the mmput irq_work slot is available so _destroy() can
+	 * safely drop the mm reference from NMI context.
 	 */
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || bpf_iter_mmput_busy()) {
+	if (bpf_iter_mmput_busy()) {
 		err = -EBUSY;
 		goto err_cleanup_iter;
 	}
@@ -906,16 +908,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
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
@@ -927,10 +923,47 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+	unsigned long next_addr, next_end;
 
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
-	return vma_next(&kit->data->vmi);
+
+	if (kit->data->locked_vma)
+		vma_end_read(kit->data->locked_vma);
+
+retry:
+	rcu_read_lock();
+	vma_iter_init(&vmi, kit->data->mm, kit->data->last_addr);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		rcu_read_unlock();
+		kit->data->locked_vma = NULL;
+		return NULL;
+	}
+	next_addr = vma->vm_start;
+	next_end = vma->vm_end;
+	rcu_read_unlock();
+
+	vma = lock_vma_under_rcu(kit->data->mm, next_addr);
+	if (!vma) {
+		if (next_end > kit->data->last_addr)
+			kit->data->last_addr = next_end;
+		else
+			kit->data->last_addr += PAGE_SIZE;
+		goto retry;
+	}
+
+	if (unlikely(kit->data->last_addr >= vma->vm_end)) {
+		kit->data->last_addr = vma->vm_end;
+		vma_end_read(vma);
+		goto retry;
+	}
+
+	kit->data->locked_vma = vma;
+	kit->data->last_addr = vma->vm_end;
+	return vma;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -938,7 +971,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
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

