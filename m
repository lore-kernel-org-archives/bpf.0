Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18CC3BB675
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332568; cv=none; b=LJ4B9Enjsjhj0AhsuaLN2erUf5/iTF6io7/iwR81xP4LqGryqFRDIoqLfs34RdqtUfv8CODlIscsduDKy1Ot460yvbto7rMsFZQw1zdM+ywZIg29OwXFbVnRjAO/0NBdFL0D3nI8OH06+ioPiHgjleiR2ESaTqkz6ARdhfsxHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332568; c=relaxed/simple;
	bh=uz8ArxSUiGpn7xp7VTHWz282qjyuAMjzavyBh/Jp4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElsLRKlUUPX9opPvda1u0o4jUCnza1PZjmG2v1HS/J+xa8zoWGo9P98GFguHi+XybUL4IWjawK3OkU8xG1YxZ4H662YvbIJRG4xdr4kBinJzN6gKEQSja1r+c+8aflUfBq+zjGXuj3tJF/twsRPoUsR0z77ymSXHEDbcx11tkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s0H8CM3H; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s0H8CM3H"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39927410578so1348958a91.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332566; x=1788937366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9kTMAk9huBRlOhdnqCDb0Ss9/+lsJRFS9JAXpEtcWk=;
        b=s0H8CM3HuooonoWyEyPSBK/F7gwwfHmSI9Qop397xH0Xsev4UNJ8L37rSEjxIS9NON
         dR/zvh0T0McaNiT6R9nnM2LmAPSpVSBlcVKCTb0Gpy+HeUMTdsqxR1BDskJXkB6xIZfK
         uXHUf69oOsqbzzwu6fb3GsEQASTUuAcFRUGExTmmy6yIa+7TCa4trv/Bao80T2EZMWa0
         pfxGEvHBq6wovr5+XwC8gdIXr3PO3WF3KRVpmSye4AyoVcRCeDdIcnJpMCF4as5PTjVK
         jfNQT6KC6IYtSQNIK4tgC5d7T7ICsgUZagx+c4nZ+J5tw5cgQeF7BAYI3qKdvPcQRKUM
         6TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332566; x=1788937366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9kTMAk9huBRlOhdnqCDb0Ss9/+lsJRFS9JAXpEtcWk=;
        b=D7IKm5oPswQzHapX72SqLn4lpvJKVbOUXHHSt5i0jsIov5GqJ596idjJvyv4KeDcA6
         09WPH9ZqYeKL1fH374qO4LbDze8M6cMo/ngJeM2e9M+1nKx3glKsBqkDCap9GcpBkWTQ
         Hhdy69hNuFQj5xAWV1yiOSXF+pwwSg2aIActh0TgaBmoHiB9H1x++wZhQfWHcdb4zYVl
         f0qgdD+h6ijyBxLJcdUHQQxOzJySev+MYvSXgEiCgoFYNKgJrJToHy+6W9lTFlXUZnXB
         bDAYIXPm6D+vfv+W2DLiJhwOR+NIfP+tA5nl9u2Xz2UIyMVpObj2ggIaDp+Ih1RRzqZD
         SssA==
X-Gm-Message-State: AFuF++n6v/igiYhdBD1IzsLPvVkPYQ+sOHZPGxSsCP0YtWBy8pR39m0v
	3WnpbqGDzywjocQhlYKq7oUasYiamqoautNmazyXzVcP8Q9sWsphgAaBkVGf8Ylhi82f+PegQY/
	wYxWW
X-Gm-Gg: AYBFou2LmIqHo1Gb7l2f4e01tvdqx/vsoDV7gpXcPsAWhtpYnuNXlFESNYHVYlRoHyu
	QcIzo2OaAzNTvUaLDcr/p+aj8y6DzWKEGhswKciZYCD6R+N1aheFYTDxrrpvCIpt1HqAoy5ca3j
	QUD6ZX4ft0xMpvS9o2jPYRPNYkFJvPCx+WmivEhMvjSJoEAmOWtmIPyTNpsyTk5zccp84pJMtz3
	yRGPPimBg0wvBk5dwaSxNwStBisWc8ipaqCPxAJogrcnj75iFkydTe5ZPDllGSZe5gEOy7niy7s
	YeVfXrA1qfYHNo2LLMSRN2EcwAqLyaZvZQ2QLqYgyzoqU69iGZR08rCvRvxlXnp2k5voCLMk1xg
	2tJWOozLk/IvN+TpSCCQpm9g9hFTi+GOjfvcD/HqtsoX7bfu6JzAguHwuVQbhQsbc8m0+qI1/PR
	ydrwo/xazBezr1aooDW6p05Rg6yel/Q7f08iRAYEcFTM/gXAgjiykQLBWq0x29jnAZ5voUGOSWi
	A5Y+59AJdXh1QlXNHOM1sY=
X-Received: by 2002:a17:90b:2f06:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39aee26dfc9mr4381272a91.24.1788332565843;
        Wed, 02 Sep 2026 00:02:45 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 4/5] bpf: Atomically update PTE and range tree in arena VM fault handler
Date: Wed,  2 Sep 2026 03:02:38 -0400
Message-ID: <20260902070239.16968-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070239.16968-1-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
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

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      | 56 ++++++++++++++++++++++++++++++++---------
 kernel/bpf/range_tree.c | 14 +++++++++++
 kernel/bpf/range_tree.h |  1 +
 3 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index d22b71a791db..d7006cdb9899 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -485,18 +485,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct page *page;
 	long kbase, kaddr;
 	unsigned long flags;
+	vm_fault_t ret_fault;
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
-		/*
-		 * A failed lock means a possible deadlock was detected. Don't
-		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
-		 * the fault path would re-take it on retry and deadlock. Fail.
-		 */
-		return VM_FAULT_SIGBUS;
+		goto retry;
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
@@ -514,6 +510,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_sigsegv_memcg;
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
+	/* If a range is unavailable, try again. */
+	if (ret == -EAGAIN) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+
+		goto retry;
+	}
+
 	if (ret)
 		goto out_sigsegv_memcg;
 
@@ -534,15 +538,41 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	flush_vmap_cache(kaddr, PAGE_SIZE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out:
-	page_ref_add(page, 1);
+	/* Reserve the page while installing its user PTE without the arena lock. */
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	ret = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	vmf->page = page;
-	return 0;
+	if (ret) {
+		if (ret == -EAGAIN)
+			goto retry;
+		return VM_FAULT_OOM;
+	}
+
+	ret_fault = vmf_insert_page(vmf->vma, vmf->address, page);
+
+	while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		cond_resched();
+	ret = range_tree_remove_unavail(&arena->rt, vmf->pgoff, 1);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	WARN_ON_ONCE(ret);
+	return ret_fault;
 out_sigsegv_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out_sigsegv:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	return VM_FAULT_SIGSEGV;
+
+retry:
+
+	/* Only for special cases (GUP/device drivers). */
+	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
+		return VM_FAULT_SIGBUS;
+
+	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
+
+	return VM_FAULT_RETRY;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
@@ -622,7 +652,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
 	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }
@@ -888,7 +918,9 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 		if (ret == -ENOMEM)
 			goto defer;
-		WARN_ON_ONCE(ret);
+		/* An overlapping fault reserves the range before installing its PTE. */
+		if (ret != -EAGAIN)
+			WARN_ON_ONCE(ret);
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return;
 	}
@@ -1043,7 +1075,7 @@ static void arena_free_worker(struct work_struct *work)
 			 * the defer: path of arena_free_pages(). Do not treat
 			 * the leak as a bug.
 			 */
-			if (ret != -ENOMEM)
+			if (ret != -ENOMEM && ret != -EAGAIN)
 				WARN_ON_ONCE(ret);
 
 			kfree_nolock(s);
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 515e72f054f5..1c23937041a6 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -378,6 +378,20 @@ int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
 	return range_tree_set(rt, start, len, false);
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
index aa27edf451bc..4b12ef51cc0b 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -16,6 +16,7 @@ void range_tree_destroy(struct range_tree *rt);
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
-- 
2.55.0

