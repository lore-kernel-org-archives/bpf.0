Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701643370FE
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868927; cv=none; b=eA+G7fx4neu7Eo4L0kI8n9knpIqeOKgzyqDdSQxwcvb0RAmyWURn0QLk07esEyhYT1ZIT3gYNtHleeG0qN2qr/xcohpklnN6uKgy4zLtNsnVj+A4+h16HslRu4gcx+lzlJX26MHt8lv9+nnPReJWP3badfD8FRSygxe9A1cqUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868927; c=relaxed/simple;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8gAFemrEd4FXnuVkN5INMMhprOnJXbBLMjZKj3FQEGm7h3b2Ao2u2XqtBiAmoeTVLGrOJ0wTRTcFMpfELBgJ/12m/3pM7MnswCCASjqRDjGRewZecXn2b/KRQnATwCs/jaBhUDuF6imBluuiS63YhLqFgDwKwGibc8qWTzUOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVYZZwP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVYZZwP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9219EC116C6;
	Mon, 23 Feb 2026 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868926;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVYZZwP98cetj6DWjphnrQLwnJ6JKF3jfc+UslXNqIM+whc8+OAB7HstzDFRVNd8D
	 taPkUxchpoL3oHNR2404XOxT8Dyhur6Ay1hNM9PdntTyA9xS4XIQSYLBLwfLZcGnsr
	 kIEynddh/4Z/gxAMr/Dtl5neKgrC42YmK47HNr3aRsU9kf2nthqjprHUsjz0gHAhMS
	 JkaGnHjXneFg6ife2W9sMEuRKZ+stfztLAiImV1UQ7EwNzU6lHppth5dcFuFV1sn/h
	 dZPQLh9yqLA3FKxjqWcZYcGp6ZVqRKoJlC++xGAn1R+J+Hpfns46WVzHk7fM8NGLO1
	 fYUpqdKM3sNcQ==
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
Subject: [PATCH bpf-next v3 4/6] bpf: Move locking to bpf_iter_task_vma_next()
Date: Mon, 23 Feb 2026 09:46:54 -0800
Message-ID: <20260223174659.2749964-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174659.2749964-1-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
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

