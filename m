Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E481C84DC
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634046; cv=none; b=uCUzqpdFEUwuP+IcwNive7s3y7jR8mcFfY++Kt+9L13RHFuacyaS6e3gVG1PnKinBrIXFtohIk2qvW5JwX5U/YucJnaHds7pHlKut8OmpoVeS+2KbnjXcUOAqMo0SMlE4JLqWYKukNSlD6f2af9+zBs0x/qniBePf+5zwM9t+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634046; c=relaxed/simple;
	bh=rxCaJ8mo2YqxLlklL/GQf8zuoA2LD/UpS1IP52k7VjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3+0Llu72mqIuH/MSepyYEWK9NAqw06tQGwln41WuFHWunw2Dxz6xt9VZQVZ+XlcO3Ql4zgEM0db0dsaanKvUnWhIj2pTPMvAjeqXeh7Qk51R641nzeJcXRN4U4iYbz2UV86TXJOUDaQFPTAu3TzvgOGOoTvyFF9CPv6QK9+Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt8Nyc4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt8Nyc4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C5C4CEF7;
	Wed,  4 Mar 2026 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634045;
	bh=rxCaJ8mo2YqxLlklL/GQf8zuoA2LD/UpS1IP52k7VjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wt8Nyc4n4ffgwO7s2rP/13izDlJ0+/b7TKAHHr8P8amOXPPHA7YAlJ9jr2vjA8ozz
	 RoCyAbcxzKXn66EMgg/Nhb1CZ26RlSJO3VKAi92XwYON+nQSuAFWu1YuBgfeHq+5Yg
	 Wxhw9Jdx2Ut2CbCmyBRxPZlpnGlSeTQ9yQe6GPG093eYpcNRNZ9ARJbWxpnAf28g68
	 aASzci88xBTrZAXdJiMp4Ul5+gu7cKzA1v9eTyzPX9EtUFLPPQ0Sf/6EsHMAvo8msQ
	 1DTLmh6cKRhjJyDSGXV5s35AnvEsjnBr6g9gXiwMtY98GY4fKt2Ckgn+nehREIbc+R
	 yie90St1tuF5g==
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
Subject: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
Date: Wed,  4 Mar 2026 06:20:14 -0800
Message-ID: <20260304142026.1443666-2-puranjay@kernel.org>
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

The open-coded task_vma BPF iterator reads task->mm and acquires
mmap_read_trylock() but never calls mmget(). This violates refcount
discipline: the mm can reach mm_users == 0 if the task exits while the
iterator holds the lock.

Add mmget_not_zero() before mmap_read_trylock(). On the error path
after mmget succeeds, the mm reference must be dropped. mmput() can
sleep (exit_mmap, etc.) so it is unsuitable from BPF context.
mmput_async() is safe from hardirq but not from NMI, because
schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
which can deadlock if the NMI interrupted code holding that lock.

Add a dedicated per-CPU irq_work (bpf_iter_mmput_work) and a helper
bpf_iter_mmput() that calls mmput_async() directly when not in NMI,
or defers to the irq_work callback when in NMI context. Use it in
both the _new() error path and _destroy(). Add bpf_iter_mmput_busy()
to check irq_work slot availability, and use it alongside
bpf_mmap_unlock_get_irq_work() in _new() to verify both slots are
free before acquiring references.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 77 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..d3fa8ba0a896 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -813,6 +813,55 @@ struct bpf_iter_task_vma_kern {
 	struct bpf_iter_task_vma_kern_data *data;
 } __attribute__((aligned(8)));
 
+/*
+ * Per-CPU irq_work for NMI-safe mmput.
+ *
+ * mmput_async() is safe from hardirq context but not from NMI, because
+ * schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
+ * which can deadlock if the NMI interrupted code holding that lock.
+ *
+ * This dedicated irq_work defers mmput to hardirq context where
+ * mmput_async() is safe. BPF programs are non-preemptible, so one
+ * slot per CPU is sufficient.
+ */
+struct bpf_iter_mmput_irq_work {
+	struct irq_work irq_work;
+	struct mm_struct *mm;
+};
+
+static DEFINE_PER_CPU(struct bpf_iter_mmput_irq_work, bpf_iter_mmput_work);
+
+static void do_bpf_iter_mmput(struct irq_work *entry)
+{
+	struct bpf_iter_mmput_irq_work *work;
+
+	work = container_of(entry, struct bpf_iter_mmput_irq_work, irq_work);
+	if (work->mm) {
+		mmput_async(work->mm);
+		work->mm = NULL;
+	}
+}
+
+static void bpf_iter_mmput(struct mm_struct *mm)
+{
+	if (!in_nmi()) {
+		mmput_async(mm);
+	} else {
+		struct bpf_iter_mmput_irq_work *work;
+
+		work = this_cpu_ptr(&bpf_iter_mmput_work);
+		work->mm = mm;
+		irq_work_queue(&work->irq_work);
+	}
+}
+
+static bool bpf_iter_mmput_busy(void)
+{
+	if (!in_nmi())
+		return false;
+	return irq_work_is_busy(&this_cpu_ptr(&bpf_iter_mmput_work)->irq_work);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
@@ -840,19 +889,35 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
+	/*
+	 * Check irq_work availability for both mmap_lock release and mmput.
+	 * Both use separate per-CPU irq_work slots, and both must be free
+	 * to guarantee _destroy() can complete from NMI context.
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
@@ -874,6 +939,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 	if (kit->data) {
 		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		bpf_iter_mmput(kit->data->mm);
 		put_task_struct(kit->data->task);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
@@ -1044,12 +1110,15 @@ static void do_mmap_read_unlock(struct irq_work *entry)
 
 static int __init task_iter_init(void)
 {
+	struct bpf_iter_mmput_irq_work *mmput_work;
 	struct mmap_unlock_irq_work *work;
 	int ret, cpu;
 
 	for_each_possible_cpu(cpu) {
 		work = per_cpu_ptr(&mmap_unlock_work, cpu);
 		init_irq_work(&work->irq_work, do_mmap_read_unlock);
+		mmput_work = per_cpu_ptr(&bpf_iter_mmput_work, cpu);
+		init_irq_work(&mmput_work->irq_work, do_bpf_iter_mmput);
 	}
 
 	task_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_TASK];
-- 
2.47.3

