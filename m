Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C43563FA7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190715; cv=none; b=B7MWI7he3rUXw+ndrafTLst3lJ6wNzxsxlMQKhm37mVQS2ngc6/6LuZmOf5/L2JBr3HF5hcwm0NIDGoPr2OSb8URU6CMhmyOAS5S321X7ldTkgc82lD4ygBh+ySw/c4ivFP1e5M8/IA25FrMtVclMqszmMlXETsuqbk/vuyqowE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190715; c=relaxed/simple;
	bh=pay9WeFGPr/mc3Sminos+XFe3OTnU4urK2CFd5mRi+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4JKzXNrqrBoYcogvTjir19MdB41J/H3a/oIMG7Glv7zUrMG19Hy/eP2uHPuyXlG2+Se+mrJaJ82/Rg6VJop+3ZEoQywLh92BYga0NYcyAEbHjkNZX1IfIheYjcWX6REs5xSX3TYkSSyeCKBcfa6tWQtNGKHmBt0gxsv3jA8gvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hiJLsNQD; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hiJLsNQD"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso843334f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190712; x=1790795512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmDSRgWhPLzoCMZYtMDekY3GhB7wiCoU2NJYZiEVdXk=;
        b=hiJLsNQDRomZ9E9hU3dYXb+RTfyoJt1R7oHDc1O5rSYt6LwSXXga4/9xVsOnXDYEE0
         YVJvILJMn6au4hf1bWuEDT4k1XbwayOPPWekVahmyi+db2cskgO3xGvgJq+wLTWdf0Gb
         NRm7C5Y5+NWl47yMRhfrnT8tcE8ZUruhw89hecCCGNEJAG7aYIQ2PS4LMrUzoWMTYUIv
         Pv9YuGu8PA7G3+E0ItHVFSdQjh9udOWpWvvg5pstVcvfMSBjiseGLDRfBzlThorBHv4F
         1sP/PZzNvzuIV8SLbi6SzKPrkSGqMvxEyEShRZKyR+bIOcqmzG0QZS/WE1cbpblYHrn2
         hVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190712; x=1790795512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmDSRgWhPLzoCMZYtMDekY3GhB7wiCoU2NJYZiEVdXk=;
        b=uCoyyZpy9nQpU2ZwQ3dmRuwRXd+u/Alg3vhssIpAHSz4RR21SNu2ka7VYbQeDeywr3
         sVTAr1jbwTyZaeKPVGVoFRZPedmL0si9G1rHMkEwTAPgF6hiLDzaa9kHCC/807KW5jD8
         N/blP6iet5V3Y5Ev43fUlDttuWDDt36klDc6LuIBDHy7rZyXKiilGGsAFVVg5cqnlZU3
         T3mXqBFg8m4vyfQS5yFiLH99vP2udt0jYVCAryw/NZnhGPxt3Aqz+6cxk2LJl+7eh0fn
         jIvxMBdP3/gFdIH62xBtFfdKewdHoHpPz/0tPSRU4RYnJlf9z90fsNedc32Aodqr73dS
         IsqA==
X-Gm-Message-State: AFuF++maTQTlk8LcZNQ/c0frTCsRdPG9lgo8wbpjDTOQECHtlCYZ2vNn
	00gxxL2CprTi34AowKqdw3HEhgsU3KJfw0qEzMEPdACn9KDCjAXa4Gl7moLI/rBsV2/U82dKzxm
	Wls3SJg+y/A==
X-Gm-Gg: AYBFou0HZSAH8icHlEbtLHFdxIV+a+SLrLZNmOlgu4OlDLa0of6n8Y8Q1lBSus3cpDf
	NR6XMpjBUJZlmny3YNTOVD0x5O0QfBw9UkpSZsQZTPkvH1/0Rm3uYy7eWrRKjNW2+UJ+yDU33v5
	8G+mXp3Z7YP5AwDslcuL6d8YKp7ZsaBsTpjjXR2AbFa7B/aCjjJXrtOfZI+qRZUFlq9+I+RR37G
	JYwuDnXypc0KZOKDXJ8ZVCjKB6+DgduPNds6SbiOXDr8RXi18w4Fw+9X3koGCSW2MhE8977mR/+
	17MLKZvHJEv3IQ0H8NfwbvygEnuhotGg3UJrCzcTY2yUnfjshhmJj6ynRpscT+18eRtbahHKF+1
	8PG2YgEQQQa3B2eYkqQIt0cfAyk1f3P+sAUNGWsZIEQHqUL6NcEZsACmcTH9H2I+zhNe+OTQPQb
	WVdeE+INSBP7LZsaYdQI4VNVaSO6tp63tpEx4CE/orcXHs1VZGYYVFeFBGV3U=
X-Received: by 2002:a05:6000:4010:b0:485:ac96:7273 with SMTP id ffacd0b85a97d-4887170e2e1mr149346f8f.10.1790190711590;
        Wed, 23 Sep 2026 12:11:51 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:51 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 5/6] bpf: Atomically update PTE and range tree in arena VM fault handler
Date: Wed, 23 Sep 2026 19:11:24 +0000
Message-ID: <20260923191125.5311-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923191125.5311-1-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena allocation code currently has a race in the fault handler
that can cause userspace threads to write to the wrong arena page.

a) The fault handler removes a range from the range tree to mark the
addresses as allocated, then installs a page A into the kernel page
tables.

b) A concurrent free/reallocation removes A and installs a page B.

c) The fault handler still goes ahead with installing page A in the
page table. The kernel sees page B, while userspace sees page A.

There is no way to protect the PTE installation and the range tree
modification simultaneously, because we cannot nest the synchronization
primitives for their respective critical sections. PTE allocation
may require allocations due to PTE reclamation, and its spinlock
becomes sleepable under PREEMPT_RT. Thus we cannot do this operation
while holding the range tree spinlock. There is no public API for
manually taking this spinlock, so we nest the range tree operation
inside it.

Solve this issue by adjusting the range tree in two steps. First,
mark the address of the page being allocated as unavailable. Then
drop the range spinlock, insert the PTE, take the range spinlock
again, and fully remove it from the range tree. Concurrent free
operations get serialized to before the fault handler, while
it is not possible to allocate the page once it has been reserved.
Concurrent page fault handler calls retry until the page is fully
allocated by the original call.

Also return VM_FAULT_RETRY for transient allocation failures. These
are a) faulting on pages that are temporarily marked unavailable in
the range tree and b) rqspinlock acquisition failures.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      | 66 ++++++++++++++++++++++++++++++-----------
 kernel/bpf/range_tree.c | 14 +++++++++
 kernel/bpf/range_tree.h |  1 +
 3 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 69c8924f4c30..5438b68d269a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -489,8 +489,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct page *page, *new_page = NULL;
 	vm_fault_t fault_ret;
+	struct range_node *unavail_node;
+	struct page *page, *new_page = NULL;
 	long kbase, kaddr;
 	unsigned long flags;
 	int ret;
@@ -512,15 +513,17 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 	}
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-		/*
-		 * A failed lock means a possible deadlock was detected. Don't
-		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
-		 * the fault path would re-take it on retry and deadlock. Fail.
-		 */
-		if (new_page)
-			free_pages_nolock(new_page, 0);
-		return VM_FAULT_SIGBUS;
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret) {
+		/* If we are deadlocking somehow, no way to ensure forward progress. */
+		if (ret == -EDEADLK) {
+			if (new_page)
+				free_pages_nolock(new_page, 0);
+			return VM_FAULT_SIGBUS;
+		}
+
+		if (ret)
+			goto retry;
 	}
 
 	page = vmalloc_to_page((void *)kaddr);
@@ -562,7 +565,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	/* If a range is unavailable, try again. */
 	if (ret == -EAGAIN) {
 		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-		goto retry;
+		goto retry_memcg;
 	} else if (ret) {
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
@@ -583,12 +586,40 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	page = new_page;
 	new_page = NULL;
 out:
-	page_ref_add(page, 1);
+	/* Reserve the page while installing its user PTE without the arena lock. */
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	unavail_node = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (new_page)
+
+	if (new_page) {
 		free_pages_nolock(new_page, 0);
-	vmf->page = page;
-	return 0;
+		new_page = NULL;
+	}
+
+	/* If we couldn't mark the page unavailable, retry. */
+	if (IS_ERR(unavail_node)) {
+		ret = PTR_ERR(unavail_node);
+		if (ret == -EAGAIN)
+			goto retry;
+		return VM_FAULT_SIGBUS;
+	}
+
+	fault_ret = vmf_insert_page(vmf->vma, vmf->address, page);
+	while ((ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags))) {
+		/* If we somehow deadlocked stop trying to take the lock. */
+		if (ret == -EDEADLK) {
+			range_node_mark_available(unavail_node);
+			return VM_FAULT_SIGBUS;
+		}
+
+		cond_resched();
+	}
+
+	ret = range_tree_remove_unavail(&arena->rt, vmf->pgoff, 1);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	WARN_ON_ONCE(ret);
+	return fault_ret;
 
 out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
@@ -598,8 +629,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		free_pages_nolock(new_page, 0);
 	return fault_ret;
 
-retry:
+retry_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+retry:
 	if (new_page)
 		free_pages_nolock(new_page, 0);
 
@@ -689,7 +721,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
 	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 9472cf1bc26d..62ebf4df51cb 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -404,6 +404,20 @@ struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32
 	return rn;
 }
 
+int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *rn;
+
+	rn = range_it_iter_first(rt, start, last);
+	if (!rn || rn->available || rn->rn_start != start || rn->rn_last != last)
+		return -EINVAL;
+
+	range_it_remove(rn, rt);
+	kfree_nolock(rn);
+	return 0;
+}
+
 void range_tree_destroy(struct range_tree *rt)
 {
 	struct range_node *rn;
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index 4f9ea2acea29..79295abe3684 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -19,6 +19,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
 struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
 void range_node_mark_available(struct range_node *rn);
+int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
-- 
2.52.0

