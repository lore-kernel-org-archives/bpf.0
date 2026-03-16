Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9D39FCB6
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687474; cv=none; b=Lf5L0GpvjhxLzohIGp56LzphQg13TJn19IRxEISZ6DmEcPcf8NPZKXm7JpZ8XxAILzrk7wMS3mwMferVoEL7ktNviBwDKG0l20UOaIDCT8bnrmt0CBIPLAyE/W8gErLjnJSZpFYDNArBmMXkrSn9e9YtSOzoVwvh6VhDlZ0phsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687474; c=relaxed/simple;
	bh=q3N4rcGCPIhnIS+Z8K0dN7TWF7UMBZ/V246dN8PwsNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6QtEq8B9EKnjGdYBkfIEipZvcNw0PZtVAXb9rvaxdBhElIizYg18OfOImRwUV7+ERCx00BNHZ5CDBd69szJvzMJiINJaYmiHP2JPvZDM7ktoYiCFitU7reFJERtHWuurPeN6YFiXthujhv311F0auBvJLrQhE2lnYe/DJ/zACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmMQ+YB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmMQ+YB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E07C2BC87;
	Mon, 16 Mar 2026 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687473;
	bh=q3N4rcGCPIhnIS+Z8K0dN7TWF7UMBZ/V246dN8PwsNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmMQ+YB9SeEHKdvZFoNI/9TNexayL69bwTmaKm0H/fa7YqZpiHcs44CHBqcDfAoOF
	 it3HtNsFARm7BlZcFokVPXsmaYnpy5CQQqm5zf5HeMOVL9kaokX+aGb07pfU58qOoq
	 7jI8hGYvPnROGNEx3HOOcPrkFAoh9WUjCwdEoAs8RuxWcKXFmHwW5p4buXyE6EGgG+
	 /Jp35m6eb7f5EcGGIpynKo7Z6rs4SM3QralcMq2JI+mEUYX5cbs+ADJWPxO0u0+4N7
	 brDAB1ZHBW9ZkV7JfFOY630upbWkQcHDaoY9EJIrJd6owMTvdU+Dv/PeqRNpBVVTjl
	 iArUAv5oeCT3g==
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
Subject: [PATCH bpf v4 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Mon, 16 Mar 2026 11:57:31 -0700
Message-ID: <20260316185736.649940-2-puranjay@kernel.org>
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

The open-coded task_vma iterator reads task->mm and acquires
mmap_read_trylock() but never calls mmget(). The mm can reach
mm_users == 0 if the task exits while the iterator holds the lock.

Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
via mmput_async() in _destroy() and the error path.

Reject irqs-disabled contexts (including NMI) up front. Operations used
by _next() and _destroy() (mmap_read_unlock, mmput_async) take
spinlocks with IRQs disabled (pool->lock, pi_lock). Running from NMI
or from a tracepoint that fires with those locks held could deadlock.

Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/sched/mm.h |  2 +-
 kernel/bpf/task_iter.c   | 31 ++++++++++++++++++++++++++++---
 kernel/fork.c            |  2 +-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 95d0040df584..5908de0c2f82 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
 
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
-#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_BPF_SYSCALL)
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
  */
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..718f0f9b6396 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -825,6 +826,18 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
 
+	/*
+	 * Reject irqs-disabled contexts including NMI. Operations used
+	 * by _next() and _destroy() (mmap_read_unlock, mmput_async)
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
@@ -842,17 +855,28 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
 	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
 	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
+	if (irq_work_busy) {
 		err = -EBUSY;
 		goto err_cleanup_iter;
 	}
 
+	if (!mmget_not_zero(kit->data->mm)) {
+		err = -ENOENT;
+		goto err_cleanup_iter;
+	}
+
+	if (!mmap_read_trylock(kit->data->mm)) {
+		err = -EBUSY;
+		goto err_cleanup_mmget;
+	}
+
 	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
 	return 0;
 
+err_cleanup_mmget:
+	mmput_async(kit->data->mm);
 err_cleanup_iter:
-	if (kit->data->task)
-		put_task_struct(kit->data->task);
+	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
 	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
 	kit->data = NULL;
@@ -875,6 +899,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
 		put_task_struct(kit->data->task);
+		mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518..d0411a63d4ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1198,7 +1198,7 @@ void mmput(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmput);
 
-#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_BPF_SYSCALL)
 static void mmput_async_fn(struct work_struct *work)
 {
 	struct mm_struct *mm = container_of(work, struct mm_struct,
-- 
2.52.0

