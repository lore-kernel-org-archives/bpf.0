Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565E126F3B
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269873; cv=none; b=c+GZtSVAs6XL+4X01U2YTHnV629gy3JpzzEgfMeldbe8QxOzhF4kYBbbPuDLgTHreWcFp0udSdoLY8QpJo2r70VYBQrEFv/nUPmBONVRUekgPQh05OQ74qh+IdGnI0Y9ZGCfK6HdgP/VCnJStAmc8B43gjmvRPWYZvj/lzPs98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269873; c=relaxed/simple;
	bh=mO7nWxmL8StQeyuhwCVZjHnNDEThF2xh8B22/3IVgdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaeQV7eoaU0A4xzjDrbkbAqRWBJ/TUaStsxa6WGvSMabUubFFTw5VrIFD1hvL+vJ/tTPvMnNHmrb3Al5NF5wZqxM5TG9QFXKssTNyFf/IdwZsmkUqDLJ6f1hcz1dToAM0vtoe+8boadnkfxnH2ATmG/WpM8xSmt4x2IH7KZZ5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B122EJOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B122EJOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F976C4CEF7;
	Wed, 11 Mar 2026 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773269872;
	bh=mO7nWxmL8StQeyuhwCVZjHnNDEThF2xh8B22/3IVgdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B122EJOUTKtsyVk33/HtBPxfC9elLiw31UoCYa+XUktdj4GQQJ4ZR/zv/ZP7IYguW
	 BGP8vlbEbuD9kOjBYQ7XdbJW03U+ielBI0z5O+nI/3rWlItikXBerhdMBumTXFWPKn
	 GjOVe9BNzvK43pR6k9zKZOfiJOrZYmUuYCCpQ9nz/2OQrbswywOMu8SQ9Ne+vIVNy+
	 vtzcZmqDoGa9C8Dype0RDjSRB0PuKWsImNgxRcGpPcixidxuW9CnI48iSUreC18R3Z
	 2AyGpBgYxN1Ljoj3ZrAxf5SdqYmVMoVY3RcwTNGJDw7/9s/MUmEZCDxcDL50JjCtxM
	 ehl9BrnzIIFAg==
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
Subject: [PATCH bpf v3 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Wed, 11 Mar 2026 15:57:21 -0700
Message-ID: <20260311225726.808332-2-puranjay@kernel.org>
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

The open-coded task_vma iterator reads task->mm and acquires
mmap_read_trylock() but never calls mmget(). The mm can reach
mm_users == 0 if the task exits while the iterator holds the lock.

Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
via mmput_async(). mmput_async() -> schedule_work() -> __queue_work()
takes pool->lock. BPF programs on traceable functions or tracepoints
called under pool->lock, or programs running in NMI, can reach here
and try to re-acquire pool->lock, causing a deadlock. Guard with
irqs_disabled() because queue_work() disables IRQs before taking
pool->lock. Defer to irq_work when IRQs are disabled.

Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/sched/mm.h |  2 +-
 kernel/bpf/task_iter.c   | 55 +++++++++++++++++++++++++++++++++++++---
 kernel/fork.c            |  2 +-
 3 files changed, 53 insertions(+), 6 deletions(-)

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
index 98d9b4c0daff..2ccdc3228063 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -799,6 +800,7 @@ struct bpf_iter_task_vma_kern_data {
 	struct mm_struct *mm;
 	struct mmap_unlock_irq_work *work;
 	struct vma_iterator vmi;
+	struct irq_work irq_work;
 };
 
 struct bpf_iter_task_vma {
@@ -813,6 +815,16 @@ struct bpf_iter_task_vma_kern {
 	struct bpf_iter_task_vma_kern_data *data;
 } __attribute__((aligned(8)));
 
+static void do_bpf_iter_mmput(struct irq_work *entry)
+{
+	struct bpf_iter_task_vma_kern_data *data;
+
+	data = container_of(entry, struct bpf_iter_task_vma_kern_data,
+			    irq_work);
+	mmput_async(data->mm);
+	bpf_mem_free(&bpf_global_ma, data);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
@@ -842,17 +854,38 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
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
+	init_irq_work(&kit->data->irq_work, do_bpf_iter_mmput);
+
+	if (!mmap_read_trylock(kit->data->mm)) {
+		err = -EBUSY;
+		goto err_cleanup_mmget;
+	}
+
 	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
 	return 0;
 
+err_cleanup_mmget:
+	put_task_struct(kit->data->task);
+	if (!irqs_disabled()) {
+		mmput_async(kit->data->mm);
+		bpf_mem_free(&bpf_global_ma, kit->data);
+	} else {
+		irq_work_queue(&kit->data->irq_work);
+	}
+	kit->data = NULL;
+	return err;
 err_cleanup_iter:
-	if (kit->data->task)
-		put_task_struct(kit->data->task);
+	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
 	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
 	kit->data = NULL;
@@ -875,7 +908,21 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
 		put_task_struct(kit->data->task);
-		bpf_mem_free(&bpf_global_ma, kit->data);
+		/*
+		 * mmput_async() -> schedule_work() -> __queue_work()
+		 * takes pool->lock. BPF programs on traceable functions
+		 * or tracepoints called under pool->lock, or programs
+		 * running in NMI, can reach here and try to re-acquire
+		 * pool->lock, causing a deadlock. queue_work() disables
+		 * IRQs before taking pool->lock, so irqs_disabled()
+		 * detects both cases.
+		 */
+		if (!irqs_disabled()) {
+			mmput_async(kit->data->mm);
+			bpf_mem_free(&bpf_global_ma, kit->data);
+		} else {
+			irq_work_queue(&kit->data->irq_work);
+		}
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

