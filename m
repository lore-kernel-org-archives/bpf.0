Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D13E9290
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687481; cv=none; b=lrhqMiEVtvoAoJBFws3adSsxOHnH5sUFnglhOrXxjQ4JUO5ZrPAB5lN671kUdgG5XO4Cy4jnt8fiRwM7NC6t57/8ln2IITTmAK4vrB9rPb4kx5jVicJRN9J5Dc91W5NYpvkbZWq61OXYojYb0y1q7kM+aSpV6jHSC6OedgDLLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687481; c=relaxed/simple;
	bh=0cnu02SgWKtL0yt3aHXd7A6N+2FheJo9sRhtZf9DnJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9Mb9gJSBnCksT2AXa5Sn/q+5f1Ih8XA5iziUkmidK22Jq/rwWIqF1CRd+MDV0URbrCeButUzZnJ02DYbRQnWg913vhWdzbbfyZQ3xAMrjTkoRCddnOTsA4i5uQeuQMAr31axt9lZF7VqZhRgYmv/ITbYf2IZC2xgZ0j8oKetJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/xvYvnj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/xvYvnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64579C19421;
	Mon, 16 Mar 2026 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687480;
	bh=0cnu02SgWKtL0yt3aHXd7A6N+2FheJo9sRhtZf9DnJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/xvYvnjLkAg/fdkJ1YU6MWEukLS/CScL5scpFBv1rIwyWaIy0NU0jqs3+m4+K3KL
	 mH3Ovp3clX/Bxdor6uU7lFmy6l18YDPCQLSFt2ZddoyWFVkf5+u2tl4+jAywokV1eG
	 apdpR7vuXsb+MhbsRLmjNpLh509Hc37spMd7mzedmWQWfdwyA5ObOYBLC47lZM0sN3
	 UXTun4C7mDAq/tsrH/N0U607YqdYD/M9R1xV2cVfG56HF1SRioVjPlxoSBJTumtsoZ
	 bMqf+uEIL5NWf0KwUGPeizet5t5Nbv3euRfDx+5XRHEvuyM9U8TEEKBCro2BiEDpS8
	 bv9ZbvEJT3Hmg==
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
Subject: [PATCH bpf v4 3/3] bpf: return VMA snapshot from task_vma iterator
Date: Mon, 16 Mar 2026 11:57:33 -0700
Message-ID: <20260316185736.649940-4-puranjay@kernel.org>
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

Holding the per-VMA lock across the BPF program body creates a lock
ordering problem when helpers acquire locks that depend on mmap_lock:

  vm_lock -> i_rwsem -> mmap_lock -> vm_lock

Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
drop the lock before returning. The BPF program accesses only the
snapshot.

The verifier only trusts vm_mm and vm_file pointers (see
BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
counted with get_file() under the lock and released via fput() on the
next iteration or in _destroy(). vm_mm is already correct because
lock_vma_under_rcu() verifies vma->vm_mm == mm. All other pointers
are left as-is by memcpy() since the verifier treats them as untrusted.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index ddaf1cf0ecae..5795c5ba2a71 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct vm_area_struct *locked_vma;
+	struct vm_area_struct snapshot;
 	u64 next_addr;
 };
 
@@ -833,7 +833,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
 	/*
 	 * Reject irqs-disabled contexts including NMI. Operations used
-	 * by _next() and _destroy() (vma_end_read, mmput_async)
+	 * by _next() and _destroy() (vma_end_read, fput, mmput_async)
 	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
 	 * Running from NMI or from a tracepoint that fires with those
 	 * locks held could deadlock.
@@ -863,7 +863,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	kit->data->locked_vma = NULL;
+	kit->data->snapshot.vm_file = NULL;
 	kit->data->next_addr = addr;
 	return 0;
 
@@ -925,26 +925,45 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
 	return vma;
 }
 
+static void bpf_iter_task_vma_snapshot_reset(struct vm_area_struct *snap)
+{
+	if (snap->vm_file) {
+		fput(snap->vm_file);
+		snap->vm_file = NULL;
+	}
+}
+
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
-	}
+	snap = &kit->data->snapshot;
+
+	bpf_iter_task_vma_snapshot_reset(snap);
 
 	vma = bpf_iter_task_vma_find_next(kit->data);
 	if (!vma)
 		return NULL;
 
-	kit->data->locked_vma = vma;
+	memcpy(snap, vma, sizeof(*snap));
+
+	/*
+	 * The verifier only trusts vm_mm and vm_file (see
+	 * BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). Take a reference
+	 * on vm_file; vm_mm is already correct because lock_vma_under_rcu()
+	 * verifies vma->vm_mm == mm. All other pointers are untrusted by
+	 * the verifier and left as-is.
+	 */
+	if (snap->vm_file)
+		get_file(snap->vm_file);
+
 	kit->data->next_addr = vma->vm_end;
-	return vma;
+	vma_end_read(vma);
+	return snap;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -952,8 +971,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		if (kit->data->locked_vma)
-			vma_end_read(kit->data->locked_vma);
+		bpf_iter_task_vma_snapshot_reset(&kit->data->snapshot);
 		put_task_struct(kit->data->task);
 		mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
-- 
2.52.0

