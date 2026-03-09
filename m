Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B63DBD71
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071736; cv=none; b=BL9f1ldMwoN7RbnZaWaICoOiAJdp+zAKs9/H1L893s7apBlQe2ka6xFwD2M0X9+z7u6zDm8e6c4Z8CS/b+y2nvUnWOP9G6skZxG/FKbjDtBCqNAf32XeM/38Hjz5T3dgA6pLil+veBCfcmhomYyhxuiS43BLjxzPuwlhWTj9/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071736; c=relaxed/simple;
	bh=zU8zBTw1WOAqo7nbleQUtnRqpvPQF8Mhmm+Oc0QDuNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee2tmgmEwq2B5KDPOUIUAUXvsVbVaC5r3IPAMNohH0jaBgZ+U2UC9yflqu9vBoY09QtgiQzDjCcsCeE1wQa/guXgvIgdppz/IguqFHbNuOinlg1RaWoIzQgO2SlkmBqdlCrXOEdjrc4Iju/LgqQcesJFAvTSE+oUjbraIRDfCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBScxmAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBScxmAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018AAC2BCB2;
	Mon,  9 Mar 2026 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071736;
	bh=zU8zBTw1WOAqo7nbleQUtnRqpvPQF8Mhmm+Oc0QDuNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBScxmAFLBU8Iv27uxzum9v+Cl2C7zeuu12N7DxppvsYaCstdz7BfiJvzqit0EVUM
	 IdsEkWwhAumAFscM9XXTYSuPdKiKQU/BdlmSAWVmg5kzeFdHwi0dSbCfhy6/J42ddu
	 R7r9gQJgpYlKw0EURZotRE/NgS/I5MlBiTBuBtNoYyIhPytASwwkQ/u08j6KceOmvH
	 7Vflr+8vtC1utSK7GrINf7lroaAhQINFZn5l5vh16+aqIE4qB0ST+k5gzEaQMTLndF
	 O/OYGr+kwRELdQQu5/3UXBWTgTweDDKp/pejC9R+7oU0ZkROwpYDCRBwsGTpbZjOHu
	 Xu0IteoL0Vcqg==
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
Subject: [PATCH bpf v2 4/4] bpf: return VMA snapshot from task_vma iterator
Date: Mon,  9 Mar 2026 08:54:58 -0700
Message-ID: <20260309155506.23490-5-puranjay@kernel.org>
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

Holding the per-VMA lock across the BPF program body creates a lock
ordering problem when helpers acquire locks that depend on mmap_lock:

  vm_lock -> i_rwsem -> mmap_lock -> vm_lock

Snapshot VMA fields under the per-VMA lock in _next(), then drop the
lock before returning. The BPF program accesses only the snapshot.

Copy vm_start, vm_end, vm_flags, vm_pgoff, vm_page_prot, vm_file, and
vm_mm. vm_file is reference-counted with get_file() under the lock and
released via fput() on the next iteration or in _destroy(). vm_mm uses
the mm pointer already held via mmget().

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e20c85e06afa..f04d6e310fd3 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct vm_area_struct *locked_vma;
+	struct vm_area_struct snapshot;
 	u64 last_addr;
 };
 
@@ -895,8 +895,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	kit->data->locked_vma = NULL;
 	kit->data->last_addr = addr;
+	memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
 	return 0;
 
 err_cleanup_iter:
@@ -954,23 +954,33 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *snap, *vma;
 
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
 
-	if (kit->data->locked_vma)
-		vma_end_read(kit->data->locked_vma);
+	snap = &kit->data->snapshot;
+
+	if (snap->vm_file) {
+		fput(snap->vm_file);
+		snap->vm_file = NULL;
+	}
 
 	vma = bpf_iter_task_vma_find_next(kit->data);
-	if (!vma) {
-		kit->data->locked_vma = NULL;
+	if (!vma)
 		return NULL;
-	}
 
-	kit->data->locked_vma = vma;
+	snap->vm_start = vma->vm_start;
+	snap->vm_end = vma->vm_end;
+	snap->vm_mm = kit->data->mm;
+	snap->vm_page_prot = vma->vm_page_prot;
+	snap->flags = vma->flags;
+	snap->vm_pgoff = vma->vm_pgoff;
+	snap->vm_file = vma->vm_file ? get_file(vma->vm_file) : NULL;
+
 	kit->data->last_addr = vma->vm_end;
-	return vma;
+	vma_end_read(vma);
+	return snap;
 }
 
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
@@ -978,8 +988,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
 
 	if (kit->data) {
-		if (kit->data->locked_vma)
-			vma_end_read(kit->data->locked_vma);
+		if (kit->data->snapshot.vm_file)
+			fput(kit->data->snapshot.vm_file);
 		bpf_iter_mmput(kit->data->mm);
 		put_task_struct(kit->data->task);
 		bpf_mem_free(&bpf_global_ma, kit->data);
-- 
2.47.3

