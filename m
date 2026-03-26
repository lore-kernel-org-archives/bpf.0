Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2D37C901
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537883; cv=none; b=PJQTmREm+bJHHkRjG2qe4BU7msjlzrytf06dBkVmOI8UFTH0cAKtQUqYqwTTKhJx1opTxWDZbWtzkXBsL5DymhdqtcKvAWxykWgcUWjajlBqVIY433/BFrh7SEd6/Zy2RnIsRKy6PqXkCfjwvgVX+5fPuSlCFBqTGQpCSlTMvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537883; c=relaxed/simple;
	bh=quPNFAQPOCRh93QNIiYTCrbGbMGN4LyjBQWESwC/Jng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft8w+rzhIUymG+hciO6xP9bwFSJ7D6extFdYwx++nOLEl4T4igUWIMzlzwOQEbGTdFExYcxrN88mKRVZk9cD4+SUWnvfsAtB/Moj4B24Nz7X0/Fh9vpfWdxLOo154DgviWG9wHgKnssOpXwraX6NwRFesGQlctCUJ3H8XfjZmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO3LA33I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO3LA33I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68524C116C6;
	Thu, 26 Mar 2026 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774537883;
	bh=quPNFAQPOCRh93QNIiYTCrbGbMGN4LyjBQWESwC/Jng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GO3LA33IokZVhM69Uih/ZWy1ybbgcIfQGs4QSFLFnk/L5jvvW1biQfk/075MLwg9a
	 qoig5jroDXIZCWujpnyokJCn3FFeM1cshOlN3qQ+RuAeQ46XD0QLByJfIQb15zuNrd
	 4w5Qqx2n/GxePQ4dkRWxiw8sBnjiuPeKYTxXQiBQVV88jRye/BVSxTFuznNtLvtuYl
	 Q41RyOuzifk8Hi/E71ynj8jcmawlnDL2Go+wtOfmevST3K8/UY+5OM2+2ScTFwoYn9
	 RYoSwH8pB+rhehGgv+L4T+gWUWEX9VQWY9hoDdI/CUWGhVM9W2QKhWa60raADaTLxj
	 y11VRmo5Nda2A==
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
Subject: [RESEND PATCH bpf v5 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Thu, 26 Mar 2026 08:11:06 -0700
Message-ID: <20260326151111.4002475-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326151111.4002475-1-puranjay@kernel.org>
References: <20260326151111.4002475-1-puranjay@kernel.org>
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

Use get_task_mm() to safely read task->mm under task_lock() and acquire
an mm reference. Drop the reference via bpf_iter_mmput_async() in
_destroy() and error paths. bpf_iter_mmput_async() is a local wrapper
around mmput_async() with a fallback to mmput() on !CONFIG_MMU.

Reject irqs-disabled contexts (including NMI) up front. Operations used
by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
take spinlocks with IRQs disabled (pool->lock, pi_lock). Running from
NMI or from a tracepoint that fires with those locks held could
deadlock. Disable IRQs around get_task_mm() to prevent raw tracepoint
re-entrancy from deadlocking on task_lock().

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 45 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..faf4d6197608 100644
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
@@ -825,6 +835,18 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
 
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
@@ -834,7 +856,13 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		return -ENOMEM;
 
 	kit->data->task = get_task_struct(task);
-	kit->data->mm = task->mm;
+	/*
+	 * Disable IRQs so that a raw tracepoint re-entering the
+	 * iterator on this CPU cannot deadlock on task_lock().
+	 */
+	local_irq_disable();
+	kit->data->mm = get_task_mm(task);
+	local_irq_enable();
 	if (!kit->data->mm) {
 		err = -ENOENT;
 		goto err_cleanup_iter;
@@ -842,17 +870,23 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
 	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
 	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
+	if (irq_work_busy) {
 		err = -EBUSY;
-		goto err_cleanup_iter;
+		goto err_cleanup_mmget;
+	}
+
+	if (!mmap_read_trylock(kit->data->mm)) {
+		err = -EBUSY;
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
@@ -875,6 +909,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
 		put_task_struct(kit->data->task);
+		bpf_iter_mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
 }
-- 
2.52.0

