Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED8398912
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269881; cv=none; b=QQ1wHDBaOI2tmGIEtZnJoVoVL3aPC1QGmIxGF44RLCGl1iJQQlhhc+MZUQ0ecCSr9Y/EnPwIO+r1yaQQDFiaLk76XVc53D5jH0xoquFVQFBuy8MAXiJ7UF0rLUdYDS6cRA8w4QU8X9yF35Ujq7yxWukYWll7zChCbrUjM1++Se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269881; c=relaxed/simple;
	bh=+Uly96rY5im5/yN+dyEkiK7eh/e2BjgL+IpqI4rFd28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDdO7itaU7geqjvB3eliMIbq9S9SejYU0i0JoSvLy7z53CcPAR2HZA8BoBrvK+3fipGk1WcBvdCTZNT37r7H+X4tphMugm3fssW8q3RX7adyvnkv9LsGSSdTXz2grd2ghmWjYP76pacDhQqXkBLkZ46C2ClAns01afZOyv2ribE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9NGrcti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9NGrcti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D0C4CEF7;
	Wed, 11 Mar 2026 22:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773269880;
	bh=+Uly96rY5im5/yN+dyEkiK7eh/e2BjgL+IpqI4rFd28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9NGrcti4ltDFwz2O1yZtTEmsMJ7TcumvYADjiEZh8Vd6YI5/SWqlExyINchFKg/t
	 ODq9ZsZ4LqLm00/hFz3YrKzQJyZlT1xWaD34Cz7FiQ00goqKkaHGqlwMLcnfW/U6v1
	 gvqaON8Eg/eheDOEABheO3sKdDZpib4FKQ30d0NJL0gdZyIILQb5xwiQUfbPUgxU/2
	 xojiVu4mETW8aoD0KPVUyJZb8g/uSIZhUH6Zi7Ogk1EnInyh7CzaRUTORL1MVCRqM/
	 s+9V9XLf6+dRlOe+mNW1UoZauoHKK5rKB/HgGzjS0V4OYvrt6G6DdjL3PKB4pexekh
	 KHxtIMALKpN2g==
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
Subject: [PATCH bpf v3 3/3] bpf: return VMA snapshot from task_vma iterator
Date: Wed, 11 Mar 2026 15:57:23 -0700
Message-ID: <20260311225726.808332-4-puranjay@kernel.org>
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

Holding the per-VMA lock across the BPF program body creates a lock
ordering problem when helpers acquire locks that depend on mmap_lock:

  vm_lock -> i_rwsem -> mmap_lock -> vm_lock

Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
drop the lock before returning. The BPF program accesses only the
snapshot.

The verifier only trusts vm_mm and vm_file pointers (see
BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
counted with get_file() under the lock and released via fput() on the
next iteration or in _destroy(). vm_mm is set to the mm pointer held
via mmget(). All other pointers are left as-is by memcpy() since the
verifier treats them as untrusted.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 50dbeaeafd86..83e3c3983341 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct vm_area_struct *locked_vma;
+	struct vm_area_struct snapshot;
 	struct irq_work irq_work;
 	u64 next_addr;
 };
@@ -862,7 +862,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	kit->data->locked_vma = NULL;
+	kit->data->snapshot.vm_file = NULL;
 	init_irq_work(&kit->data->irq_work, do_bpf_iter_mmput);
 	kit->data->next_addr = addr;
 	return 0;
@@ -928,23 +928,37 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *snap, *vma;
 
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
 
-	if (kit->data->locked_vma) {
-		vma_end_read(kit->data->locked_vma);
-		kit->data->locked_vma = NULL;
+	snap = &kit->data->snapshot;
+
+	if (snap->vm_file) {
+		fput(snap->vm_file);
+		snap->vm_file = NULL;
 	}
 
 	vma = bpf_iter_task_vma_find_next(kit->data);
 	if (!vma)
 		return NULL;
 
-	kit->data->locked_vma = vma;
+	memcpy(snap, vma, sizeof(*snap));
+
+	/*
+	 * The verifier only trusts vm_mm and vm_file (see
+	 * BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). Take a reference
+	 * on vm_file; set vm_mm to the mm held via mmget(). All other
+	 * pointers are untrusted by the verifier and left as-is.
+	 */
+	if (snap->vm_file)
+		get_file(snap->vm_file);
+	snap->vm_mm = kit->data->mm;
+
 	kit->data->next_addr = vma->vm_end;
-	return vma;
+	vma_end_read(vma);
+	return snap;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -952,8 +966,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		if (kit->data->locked_vma)
-			vma_end_read(kit->data->locked_vma);
+		if (kit->data->snapshot.vm_file)
+			fput(kit->data->snapshot.vm_file);
 		put_task_struct(kit->data->task);
 		/*
 		 * mmput_async() -> schedule_work() -> __queue_work()
-- 
2.52.0

