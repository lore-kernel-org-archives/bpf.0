Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694514;
	b=bHZcOiIC7L7XQpmxLTQhtASunuVgjwia8gZk3s/qxAxeWOJ6PXZHwv1o5x8uEjsNlndu
	 Kv1XBtUmCvohH5bEOenBCAVvNt8eKexJ5I1thpJ2JQ/jJ9R2zrYhwOruEmlkNfuHLImnv
	 PJvzWWuaSJ9eZklYt5oeOrvaWs97rJuHl7xt1OynAq6XA46aimtY2/BiK9lGbIG79BX/b
	 OrjXCdvDkkkhmMSOiuvlGfXVE0ga/i0M7QyPWDldY3E7gkm8XrYxwoK7h8pL86wEHEnmn
	 ydOlqDObNOurtUtgVL+wiNWx9TmcWcyKXH7OVzuztzo7vPDTikODNXs6zWxoieYPdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694514;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lWZCpgpSE4xczAweJE+uPCbv7xVI0QoZiK1kGNr3f8c=;
	b=AARlpEKmHqIRtBejuknmkPbNHZax+DRASMmttWgeRMxqbgWXaPr3NbmtUFmYZtNqv1e1
	 VpsLc/9hdhJv+3fUsw+N6+prJDsDAPsA0cEoBXf1vpM7M6Zs490vuNuj8XsPPlpG3STds
	 xv+yP+ad8xNQhQPCLBdKWdPGH6arw74sFZSb3akH8xhs0i7lvleWdUd8L/thO2IA8UJW6
	 f2frYQOKGfem2HXcmop6WwrCi7HDJJIerbMkFTBGe8CBQrDSm6jfpqbkLjdBLbZs5zj+E
	 VycyegtN8Sw0vnazrED9Hh693Am/QKvG+rtTlW+iwMNT7jquHl5slEP5yQeLfpHh9nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z31I8IqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E45606A329;
	Tue,  3 Nov 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z31I8IqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D095F1F000C1;
	Tue,  3 Nov 2026 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694513;
	bh=lWZCpgpSE4xczAweJE+uPCbv7xVI0QoZiK1kGNr3f8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z31I8IqMVbsI8+Br+RX+8tnZmcDMO745pd+5tnTuguMk45nAQd38B9mrIL5aqw+Xo
	 3abS0yWUrNrIZOiOdsSyq10uxZYLtvTL2vxM72c3AvjILs7IatM/SO1nKBdOqOKWcf
	 9uLmReebTlj9mTXY8Rv509ejntJL7zSK/nEyrPB4DmtZY/m+8AyKdIE/1bFVAfRzfl
	 jxW9fcEXUrMSAraG4QghGpQQ5Rv4Oz9QpukNmMVruOun39vetPZVysexoHGKSd6ycS
	 v02e2SLVBqLUHI2Stt4zfmf4A+icUlekHo+Ueh4xcBeemE6G8OCDMk6r2qPYWMyb/A
	 xw+cCe+jf+YfA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 03 Nov 2026 08:27:45 +0000
Subject: [PATCH 4/5] mm: add and use mmap_read_lock[_killable]_nosteal() on
 contention
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-khugepaged-latency-fix-v1-4-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
In-Reply-To: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
To: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4017; i=ljs@kernel.org;
 h=from:subject:message-id; bh=EoPq0IDllGnii01JUoCaBZU0cOdJF95yfNLtLlINCG4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJezuZp/7ta5d2DUpN9O2IXfJ7SxFSTyR76R/zjnzeHj
 j3xtU617yhlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEGgIZ/kqnZN2YUfNf72AR
 u8Xyt+z9pRYHDLcKOwt+ZAjojZ+Q+Izhf2Ka5aL80pXMHxoOVE8w4uyZuPEny/wcedcbBvtSHrU
 7MgIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

With down_read[_killable]_nosteal() available, it becomes possible to
release the mmap read lock in such a way that a queued write lock always
takes precedence.

Expose this to mm through two new wrappers - mmap_read_lock_nosteal() and
mmap_read_lock_killable_nosteal().

Make use of this in scenarios where the mmap read lock is dropped
explicitly for the purposes of relieving mmap_lock contention - the BPF
task VMA iterator, and lock_next_vma_under_mmap_lock(), which is where
/proc/$pid/smaps_rollup re-acquires the mmap lock after dropping it on
contention and falling back from per-VMA locking.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mmap_lock.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/task_iter.c    |  2 +-
 mm/mmap_lock.c            |  2 +-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9ccbbcbd7aca..88906ecd6ca3 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -627,6 +627,31 @@ static inline int __must_check mmap_read_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
+/**
+ * mmap_read_lock_killable_nosteal() - Acquire a killable mmap read lock, but
+ * yield to any queued write locks.
+ * @mm: The mm whose mmap read lock is required.
+ *
+ * If an mmap write lock is queued behind readers, but its handoff timeout has
+ * yet to expire, releasing then re-acquiring a read lock can steal the lock
+ * from it.
+ *
+ * mmap_read_lock_killable_nosteal() will queue in this case instead, which is
+ * useful when releasing the mmap read lock specifically to relieve lock
+ * contention.
+ *
+ * Returns: 0 on success, or an error otherwise.
+ */
+static inline int __must_check mmap_read_lock_killable_nosteal(struct mm_struct *mm)
+{
+	int ret;
+
+	__mmap_lock_trace_start_locking(mm, false);
+	ret = down_read_killable_nosteal(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, ret == 0);
+	return ret;
+}
+
 static inline bool __must_check mmap_read_trylock(struct mm_struct *mm)
 {
 	bool ret;
@@ -637,6 +662,25 @@ static inline bool __must_check mmap_read_trylock(struct mm_struct *mm)
 	return ret;
 }
 
+/**
+ * mmap_read_lock_nosteal() - Acquire the mmap read lock, but yield to
+ * any queued write locks.
+ * @mm: The mm whose mmap read lock is required.
+ *
+ * If an mmap write lock is queued behind readers, but its handoff timeout has
+ * yet to expire, releasing then re-acquiring a read lock can steal the lock
+ * from it.
+ *
+ * mmap_read_lock_nosteal() will queue in this case instead, which is useful when
+ * releasing the mmap read lock specifically to relieve lock contention.
+ */
+static inline void mmap_read_lock_nosteal(struct mm_struct *mm)
+{
+	__mmap_lock_trace_start_locking(mm, false);
+	down_read_nosteal(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, true);
+}
+
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, false);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2ee7b3b3c10b..b455306a6b52 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -486,7 +486,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
 			info->prev_vm_end = curr_vma->vm_end;
 			op = task_vma_iter_find_vma;
 			mmap_read_unlock(curr_mm);
-			if (mmap_read_lock_killable(curr_mm)) {
+			if (mmap_read_lock_killable_nosteal(curr_mm)) {
 				mmput(curr_mm);
 				goto finish;
 			}
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 834bbf86e004..41b11b843211 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -412,7 +412,7 @@ static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm
 	struct vm_area_struct *vma;
 	int ret;
 
-	ret = mmap_read_lock_killable(mm);
+	ret = mmap_read_lock_killable_nosteal(mm);
 	if (ret)
 		return ERR_PTR(ret);
 

-- 
2.56.0

