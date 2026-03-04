Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493A36C9D5
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634053; cv=none; b=ejSG0O6CSrmh9Zg/lO58NKtrM1lfNzPf8qUKEbb6gU4ca01kN1D8/gc+P4D6gTcLWMeO3ixtQsdc5lnJB7gNvRz/3WYD0D4yHKumWVBmYGOJp7X8fu/XuACvHmKPeCENhwSRYmqORaxoJNI2frPMaT0KrI/YgREOWyuwYSOBaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634053; c=relaxed/simple;
	bh=yNTwxOhvzybTcCpcOyhdZoRUIUHdf6JvReRkm5XJgSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbqhCPR81Z/LZgvb0f/W59DGjRVbOPBS8ymAyiNaImgcrl3twCp7Hs3h7bv7uSZbEUhkJYJik1vblMXkPEqpBGptUKoh6CO3d+xnah8Ed8XJ08ttg99RhH7ZhRIMnruTLsHSB6obbo1bS/pt0O80KG3YVc/7fxZw5YoLccnGyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ62cERX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ62cERX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A05FC4CEF7;
	Wed,  4 Mar 2026 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634053;
	bh=yNTwxOhvzybTcCpcOyhdZoRUIUHdf6JvReRkm5XJgSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJ62cERXb3U1uUzmxdcLki88xWqQ8BvzAXHuQ7EV/9a4VQK0OXZqO/nQpyYS1gyP4
	 tSWAUrnIIrAbLASKaDSqIJ/Q0Za10DAOxXfobw/QZRwWj+FmHELp55wI/LE+p90p5M
	 2SJl0kR66aCQetZu/4ovA6OqZplcwao8H213r/iumLHSYp8BeU5o+nk8r+BSmrz3aN
	 XFfJKQEbDEFkF95y59cQDxy1LFrZ1q2Y1r3MWjGET3lacpg4Jgsp39z60fBkvzWdVu
	 /V+5riYwSMvoTAqljwyqJy9oIZuJrJh+sktxPoz8aS6BuYyQAMWw1gAJGERlDNKpbn
	 fqwafytplINkQ==
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
Subject: [PATCH bpf 3/3] bpf: return VMA snapshot from task_vma iterator
Date: Wed,  4 Mar 2026 06:20:16 -0800
Message-ID: <20260304142026.1443666-4-puranjay@kernel.org>
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

Holding the per-VMA lock across the BPF program's loop body creates a
lock ordering problem when helpers acquire locks with a dependency on
mmap_lock (e.g., bpf_dynptr_read -> __kernel_read -> i_rwsem):

  vm_lock -> i_rwsem -> mmap_lock -> vm_lock

Snapshot VMA fields into an embedded struct vm_area_struct under the
per-VMA lock in _next(), then drop the lock before returning. The BPF
program accesses only the snapshot, so no lock is held during execution.
For vm_file, get_file() takes a reference under the lock, released via
fput() on the next iteration or in _destroy(). The snapshot's vm_file is
set to NULL after fput() so _destroy() does not double-release the
reference when _next() has already dropped it. For vm_mm, the snapshot
uses the mm pointer held via mmget().

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/task_iter.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index ff29d4da0267..4bf93cff69c7 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -798,7 +798,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct vm_area_struct *locked_vma;
+	struct vm_area_struct snapshot;
 	u64 last_addr;
 };
 
@@ -908,8 +908,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 		goto err_cleanup_iter;
 	}
 
-	kit->data->locked_vma = NULL;
 	kit->data->last_addr = addr;
+	memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
 	return 0;
 
 err_cleanup_iter:
@@ -923,15 +923,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *snap, *vma;
 	struct vma_iterator vmi;
 	unsigned long next_addr, next_end;
 
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
 
 retry:
 	rcu_read_lock();
@@ -939,7 +943,6 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
 	vma = vma_next(&vmi);
 	if (!vma) {
 		rcu_read_unlock();
-		kit->data->locked_vma = NULL;
 		return NULL;
 	}
 	next_addr = vma->vm_start;
@@ -961,9 +964,17 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
 		goto retry;
 	}
 
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
@@ -971,8 +982,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
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

