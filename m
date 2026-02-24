Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C832D592E
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968381; cv=none; b=VpzFEidhIFZ9E/4kSXcJXk7xSHwdMSQZGmz/l9LQwC1yvtaGUlNiyNtBkykn8zj6qdGF5epB+KHVAB8W0Y+ZCkZpzz8QC/rWA5CYZQteagkb+LmslDB32jUhLb4D/jY51QKkcAFe/dw/XeHYYRCSOlSY28vRvFEcCBCudzV3k0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968381; c=relaxed/simple;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZk/KFtoezx0WCveEAmGGl3cOlPLyibM1b8M/B1eG/tbadV5S6wUzovJrB+vyYBpy6bXBefFtpwdhsIoFf0oyk146moFmHC8Y0eCYIwN0I87k7pcx/WNZXF1EerOXgkl7mj1oirUowe6ItOSEtLnrwmKHdtYPqdpyxNRTNmdPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyzVviFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyzVviFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C7C116D0;
	Tue, 24 Feb 2026 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968380;
	bh=P50e03jljWUwr+RC0fxADHpVUNY/O9ECSvf16ExqZ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyzVviFT4TPZ3QB1nLF01vTy2fpx31MJfRxOnd4SH2gl4GDMSSq5sN12v67/KIo2a
	 lp42c3C35tAzM6v6s8evxKNPQxCa8hPBVz5/whdW40f9lGjAnhhTsywAcqOgrytbFJ
	 nbKlc81r8Ap4DF+8JssHB0apqcz+Dk7zx5VHzA5L/e9Ta8/Z+rIpZJfBNCIL42ksRc
	 5LkQMEP+ywGE3mruXts/uuljCci/HxiPRto2BrVMnQIY1ohXBlv5bZWfa+QGWu0Nil
	 cGQc5Y4B3EQFr83gQ161WuAQhQrQR0LUiG+aVpDl5HEikL7/5umlUgllqtZbSblSmI
	 3/Hyqb07W8qGw==
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
Subject: [PATCH bpf-next v4 5/7] bpf: Move locking to bpf_iter_task_vma_next()
Date: Tue, 24 Feb 2026 13:25:27 -0800
Message-ID: <20260224212535.1165151-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
References: <20260224212535.1165151-1-puranjay@kernel.org>
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

