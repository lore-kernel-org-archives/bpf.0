Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B92F549F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663156; cv=none; b=V+mPYWJOsXsCCGeoyx9j9oFvUTQLrJc0x1q1AIEjdJy64hvrLPXetHSNpp1YXZzqscvyab6nN+a4hqpqRqODROLm7gWwlSAJGkwcTjeZAeH2Qv+LN/UnbOPfo9AAZ6NJgNX/iJmYpVaEIzltweSIKLRLSCx/jrkl3SpjlnblGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663156; c=relaxed/simple;
	bh=M5C39eLb45AEYlFDzTGU3t3jphsse7XTmKYj5F/YJGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Yg9VGAhUoY5A0+teNU5rTYde1Rq13T8UYmg1xVeVP/WN8uryy9LNUQUKagV7M3J1PwAflybgpcCR3Y2rvE88uDXdeYmU8yVCSVLyUhyaC4g4BdKhwzHhZbBp4O6aWZYB0Tz7rchelEin/p5y+WNzAr0WzbQK+KJ5F5hJi+8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKml5BWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKml5BWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C706C2BC87;
	Wed,  8 Apr 2026 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663156;
	bh=M5C39eLb45AEYlFDzTGU3t3jphsse7XTmKYj5F/YJGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKml5BWr19lCOf4az/lImklQD4DdLVZCnq+356L5k8QoQqxhBp1MUzkPpFSDDTeir
	 i8s1TudN54ZEJtXQD3Pgamnqa1qm7L5XgebSMYfx/bFue26y4p8J80dreV3hm03lom
	 QSJkn1pOiIWG/IWVjU20v4CKj3AoE4Dznoy8LRkCQWMGIJPQ23lPQkHaTkXoAxyaFH
	 Aq038h1v0KHZU7G/2FuhlsKVWqkPfE+d3dSbxNQgEc4HnfUOjq8rx2DFEkC6Pccs9u
	 /1KseYaRTbNF8RM8OvkfzJlQZBhteSJAaILyEZcigmjEt6fRrICF09MpSqt4FkkjE9
	 douRW+sTXLjHQ==
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
Subject: [PATCH bpf v6 3/3] bpf: return VMA snapshot from task_vma iterator
Date: Wed,  8 Apr 2026 08:45:37 -0700
Message-ID: <20260408154539.3832150-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408154539.3832150-1-puranjay@kernel.org>
References: <20260408154539.3832150-1-puranjay@kernel.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/task_iter.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 87e87f18913d..e791ae065c39 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -808,7 +808,7 @@ static inline void bpf_iter_mmput_async(struct mm_struct *mm)
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct vm_area_struct *locked_vma;
+	struct vm_area_struct snapshot;
 	u64 next_addr;
 };
 
@@ -842,7 +842,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
 	/*
 	 * Reject irqs-disabled contexts including NMI. Operations used
-	 * by _next() and _destroy() (vma_end_read, bpf_iter_mmput_async)
+	 * by _next() and _destroy() (vma_end_read, fput, bpf_iter_mmput_async)
 	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
 	 * Running from NMI or from a tracepoint that fires with those
 	 * locks held could deadlock.
@@ -885,7 +885,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	kit->data->locked_vma = NULL;
+	kit->data->snapshot.vm_file = NULL;
 	kit->data->next_addr = addr;
 	return 0;
 
@@ -947,26 +947,45 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
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
@@ -974,8 +993,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		if (kit->data->locked_vma)
-			vma_end_read(kit->data->locked_vma);
+		bpf_iter_task_vma_snapshot_reset(&kit->data->snapshot);
 		put_task_struct(kit->data->task);
 		bpf_iter_mmput_async(kit->data->mm);
 		bpf_mem_free(&bpf_global_ma, kit->data);
-- 
2.52.0

