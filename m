Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A7438FF2
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122543; cv=none; b=skJCGWlTEToHRAwMrGMCSCGUEHkqQ1ObqtngIYauBjf2r/pjlI/MEhnmQKuZL6sv3JGE6piHFjeJd6Hc3qpxTllRoHrmOYSKhrQUIPoSAbzSiDSDVHnP74Afs6LadjfSNXKugv7FKlbRBEHTLSsF9NJLanuCdzp9FGoTfOKa2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122543; c=relaxed/simple;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG7RP6UIjYBO7e7Xt57w1f5pJh1fROhp5fqKALUl7rMnrP+wF6eAH0wUICjvVdfxPqyJjz4CcNPSswuOJEmVSsogIStud296iGotFni0L1aRtckGKwNBfSfluGTe/TX9aQtCzCNuyc/dRDnfUeD2/e6nzH1V2Su5XPWaorfZaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW2hZMrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW2hZMrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31857C116C6;
	Thu, 26 Feb 2026 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122543;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TW2hZMrSAVCcmEB3H5aE9An5QIEa2YzkHcKjoKu6Hs82xcwdABLu9J/ZTMsjNH38e
	 PuQq9EUH0Be4CMSQlNRrxKwsSjaTGvpWQj1t+78w8Sz4J0hL9beqdYisqAdFIBULxs
	 +l5jLxSx7mG+D73utv3i9R0FnZa6UgdURYLDe8LoZPrJRaQNzghFE3NZIzarZIsIsA
	 8sMhrwwh2vILrt1Tm+yKBW6f7ivK6VFPX/EyNR99YpwStvTlUu4E2m3CV35K1eZuL4
	 LFVLK9D4fCOO01q8/5AXBuTC+xheuV0Fp6VV+93n60z4a5qOYx3sc9bP2uetUY//6b
	 H6xC6JdaxOUXA==
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
Subject: [PATCH bpf v5 6/8] bpf: Move locking to bpf_iter_task_vma_next()
Date: Thu, 26 Feb 2026 08:14:55 -0800
Message-ID: <20260226161500.775715-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226161500.775715-1-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of task_vma iterator takes the mmap_lock in
the _new() function and holds it for the entire duration of the
iterator. The next commits will allow releasing the lock in the middle
of the iteration and it would mean that the _next() call should re-take
the mmap_lock.

Move the mmap_lock setup to bpf_iter_task_vma_next()

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..a85115c191e4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -799,6 +799,8 @@ struct bpf_iter_task_vma_kern_data {
 	struct mm_struct *mm;
 	struct mmap_unlock_irq_work *work;
 	struct vma_iterator vmi;
+	u64 last_addr;
+	bool locked;
 };
 
 struct bpf_iter_task_vma {
@@ -819,7 +821,6 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 				      struct task_struct *task, u64 addr)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-	bool irq_work_busy = false;
 	int err;
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
@@ -840,14 +841,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
-	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
-		err = -EBUSY;
-		goto err_cleanup_iter;
-	}
-
-	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
+	kit->data->locked = false;
+	kit->data->last_addr = addr;
 	return 0;
 
 err_cleanup_iter:
@@ -862,10 +857,26 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
+	struct vm_area_struct *vma;
 
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
-	return vma_next(&kit->data->vmi);
+
+	if (!kit->data->locked) {
+		bool irq_work_busy;
+
+		irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
+		if (irq_work_busy || !mmap_read_trylock(kit->data->mm))
+			return NULL;
+
+		kit->data->locked = true;
+		vma_iter_init(&kit->data->vmi, kit->data->mm, kit->data->last_addr);
+	}
+
+	vma = vma_next(&kit->data->vmi);
+	if (vma)
+		kit->data->last_addr = vma->vm_end;
+	return vma;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -873,7 +884,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		if (kit->data->locked)
+			bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
 		put_task_struct(kit->data->task);
 		bpf_mem_free(&bpf_global_ma, kit->data);
 	}
-- 
2.47.3

