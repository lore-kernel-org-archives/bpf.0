Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58F3DBD71
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071729; cv=none; b=CJiHKpMfz1iXLPhpC6oVssb6FWrY7dcLB4sCSDjWXMArQdHqqptW1vUBHyCA/NVZltrpfyGd3lM9qTLtJNvusU9RA6ZDDW9QaJzQcSVXumqCEN474lIh44UfwqZpdbyxHC5kC2UvDVCD9fbHDCZ6MxEPs15G84sFNG6mx/iRuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071729; c=relaxed/simple;
	bh=bUIYncVzHMD/gxl0cM912tp5nd5S8dAHH7aCO41/qMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxxMlbfetC3AsGNtqge2KfhP2TiddIKuXedjsRN09yJWRtKALcsyysR9qBy24pt6qwVsbXjNZVp7QBnS6xApPs5KPOMA72fyDdrrbjeIFZjuUx2feueKzKl5swBZqJx4OmB0cmMjHSGN4Z1tnWT/kCu0vizDcEHsiN3lUKte+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPiVQ6qq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPiVQ6qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961A1C4CEF7;
	Mon,  9 Mar 2026 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071728;
	bh=bUIYncVzHMD/gxl0cM912tp5nd5S8dAHH7aCO41/qMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPiVQ6qqGZsR9n5f+O1U3oxV4UdjqOvASv6AuYzIXb4Qyhy0EoKwFT6gODgWMsHj7
	 J01C3WXhxrsniWrnZROY8QczsgzradcGyk0FcK5qM9M0gzZ4OCV3t8K4tl8dyLuHRc
	 3ACzy7yhU6C4HSUq3OgZUJZqnUimWYMTvBB6k40mQKkiLfsBmI7dGkbXoe/Jfbgd1i
	 o3it+58cVLLotXTmBoi6CfH6+VF70WORurNfAVfNngyaVeE/NH8Sp/InjUJ53OqRbv
	 KowEglJKRarAg6T2fSAU2JtWxLp3TadWKlvIEBRm3QVZTHAg6vbL1dc4pqvJrWsPbU
	 wnqiHukjzlCoQ==
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
Subject: [PATCH bpf v2 2/4] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Mon,  9 Mar 2026 08:54:56 -0700
Message-ID: <20260309155506.23490-3-puranjay@kernel.org>
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

The open-coded task_vma iterator reads task->mm and acquires
mmap_read_trylock() but never calls mmget(). The mm can reach
mm_users == 0 if the task exits while the iterator holds the lock.

Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
on error paths via mmput_async(), which is safe from process context.
From hardirq/NMI context mmput_async() can re-enter __queue_work() and
deadlock on pool->lock, so defer to irq_work in that case, following
the pattern from defer_timer_wq_op() in kernel/bpf/helpers.c.

Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/sched/mm.h |  2 +-
 kernel/bpf/task_iter.c   | 65 +++++++++++++++++++++++++++++++++++++---
 kernel/fork.c            |  2 +-
 3 files changed, 63 insertions(+), 6 deletions(-)

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
index 7c302ee78f7e..e8efc9e1f602 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
+#include <linux/sched/mm.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -813,6 +814,44 @@ struct bpf_iter_task_vma_kern {
 	struct bpf_iter_task_vma_kern_data *data;
 } __attribute__((aligned(8)));
 
+/*
+ * mmput_async() is unsafe when IRQs are disabled because it can re-enter
+ * __queue_work() and deadlock on pool->lock. Defer to irq_work in that case,
+ * same pattern as defer_timer_wq_op() in kernel/bpf/helpers.c.
+ */
+static DEFINE_PER_CPU(struct bpf_iter_mm_irq_work, bpf_iter_mmput_work);
+
+static void do_bpf_iter_mmput(struct irq_work *entry)
+{
+	struct bpf_iter_mm_irq_work *work;
+
+	work = container_of(entry, struct bpf_iter_mm_irq_work, irq_work);
+	if (work->mm) {
+		mmput_async(work->mm);
+		work->mm = NULL;
+	}
+}
+
+static void bpf_iter_mmput(struct mm_struct *mm)
+{
+	if (!in_hardirq() && !irqs_disabled()) {
+		mmput_async(mm);
+	} else {
+		struct bpf_iter_mm_irq_work *work;
+
+		work = this_cpu_ptr(&bpf_iter_mmput_work);
+		work->mm = mm;
+		irq_work_queue(&work->irq_work);
+	}
+}
+
+static bool bpf_iter_mmput_busy(void)
+{
+	if (!in_hardirq() && !irqs_disabled())
+		return false;
+	return irq_work_is_busy(&this_cpu_ptr(&bpf_iter_mmput_work)->irq_work);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
@@ -840,19 +879,33 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
+	/*
+	 * Both mmap_lock and mmput irq_work slots must be free for _destroy().
+	 * kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work
+	 */
 	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
+	if (irq_work_busy || bpf_iter_mmput_busy()) {
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
+	bpf_iter_mmput(kit->data->mm);
 err_cleanup_iter:
-	if (kit->data->task)
-		put_task_struct(kit->data->task);
+	put_task_struct(kit->data->task);
 	bpf_mem_free(&bpf_global_ma, kit->data);
 	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
 	kit->data = NULL;
@@ -874,6 +927,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		bpf_iter_mmput(kit->data->mm);
 		put_task_struct(kit->data->task);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
@@ -1044,12 +1098,15 @@ static void do_mmap_read_unlock(struct irq_work *entry)
 
 static int __init task_iter_init(void)
 {
+	struct bpf_iter_mm_irq_work *mmput_work;
 	struct bpf_iter_mm_irq_work *work;
 	int ret, cpu;
 
 	for_each_possible_cpu(cpu) {
 		work = per_cpu_ptr(&mmap_unlock_work, cpu);
 		init_irq_work(&work->irq_work, do_mmap_read_unlock);
+		mmput_work = per_cpu_ptr(&bpf_iter_mmput_work, cpu);
+		init_irq_work(&mmput_work->irq_work, do_bpf_iter_mmput);
 	}
 
 	task_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_TASK];
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
2.47.3

