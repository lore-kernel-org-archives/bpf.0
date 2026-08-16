Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1623EC6BE;
	Sun, 16 Aug 2026 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920445; cv=none; b=rJLQ89RsmM7c69cMmC3vsBxtbb/F0REVTw+FgmjzIY35DFDtnAHQ6p4X2MtwQ0/+kiP/KlVKAdpgWHchJc9axe0NB83rQks+wPI/SY/VMjKmN5TyhxszS5qCTp4KIl6T+j8/ptV8jWeEVlj3Ikdf4qdUIe/bXjYaeoAd98Uxnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920445; c=relaxed/simple;
	bh=8AlcU4/uD5ioAfM0LSoQ50JrdK2H5vgan7P2Fzte1tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uswvTSPcIj5dHPYHoiZY6VDndupLMtjQ/cke2pahSQAQx+CQgO6mrX5WBa0H2mc7Ohn/VadLzrkpGLMqyF+M9SZ4ws81FvSyVMA9TLG/MZwlGTDk2PSlmUSyAS2874equ/XLZ7G94yGe7Kqpovzrzt3thenIPFM4DKjIAgxFLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=0TKJLNxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qt1zivLi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="0TKJLNxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qt1zivLi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6ACC9EC0243;
	Sun, 16 Aug 2026 18:47:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 16 Aug 2026 18:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920442; x=
	1787006842; bh=4iXJOXAQHj2CY1FuoUAjEsT25SgdR4G2WYeHbr672pA=; b=0
	TKJLNxHxHvDTi1JO5KJFcfrhZXanz89LFVOf4ilaSlwQgpSTm7QWtQRimntdF5p0
	n/EF9qklNjR2uCIUuju2KAWMJconEDDI495F5fd5elc8QcCjl04Xw/HqGjgwwPDy
	LVmCJPf7Zym5bLWqQoLBElgKw0KaINCDJwYq5PEWclF5fahzo+Al+tVzVZduzc8V
	iq/kKSfK8pqQSFP26270CsOOjSP14QNSTn3cbn4MiOF0356ySRInnronoVsxOsYo
	zwiVM3T3eCshiUGrfSZe2bt0w0AU3a8u3ylEZqzIlJhajEFrNxgO/be7y9iknHtj
	NRgN5LRz2RFsqLwsAnikA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920442; x=1787006842; bh=4
	iXJOXAQHj2CY1FuoUAjEsT25SgdR4G2WYeHbr672pA=; b=Qt1zivLiWpZFt3wta
	bvZjbH7EaUemCPXzSummZwE1ZYZZ+6g95taLyQ5c5hMMMuXVQ/ilzOkJgaxb0puk
	0nTZDEf5RW9ym/62Hb3gWGIYzHDgFP8RM/fOS95BZBrzZ89obtp+2N13jNwTVcdI
	e5913E0SIptTjhlwKKcMAfLybKLnNWDf/8BDWifYF146YNmqh54PiWDeeFELOHK/
	Frw4AAZohmormhTAtH4Zhp8BGUAY5zke/tK3SbhhfD558L27tgsKDZbL/bPCbId3
	l407ebVIaTf7VKi3FXwmxA1FouJCNGepkRskrPVhE3dZISl/4d0lfWJNApLkm+N0
	LAjng==
X-ME-Sender: <xms:-j2CatpOsRSeIzXwzJjVN6iN-YKGHJXF7KHAFYYA4UKNHOeqfYdesA>
    <xme:-j2Cavmvr9jsnn_Hnua-KN4Q5cfOCVKJ9M9Ye_p9yykq2DseAztpl4hXM7QnTBFk9
    R7X99TC0VO1LveYo_7bn0yQwswZXxpwUTBrV5DVOarRWNROkhYOzPR1>
X-ME-Received: <xmr:-j2CalzBdFJVfCxzvh9XKkL1d--pWSi8DqtWH6uhPuJwpOvtuaNjHYNMgvU>
X-ME-Proxy-Cause: dmFkZTGQiHMMNOd1xnoN6lXQSIrGAe7MwYo75Qud3VSOh3aIjL1T4IX+wE1i/v23Y8aWnG
    m9SHT5inuXsr6fNeLF7q+XcMZ+pkZJxjpb2XQQyKrFdYKaLz7QDFEiegvQaT+Y5rGxRgjF
    euipinLXiFMtCpFgMqQP9Dwn4SHq3YG285QsMU4KB7YfRQHYWKIG6dJTmdP/7bPKv1qUNe
    3LkhBXaaROXWrLGafj+UVrogU8Abxo2OvgWTBKIlLl3SY5Eb27sggkfdoaZJgpjY1+W5mK
    IYgTH3bmg7umgeRjJmx+WAhyhWPmGn2xLzWKHa3nzXVCTdFk2+6Uh9D41+s+1+4ThvFtWC
    NAyvoHSHbEIY0NAsm0LaLE+G1U7bQRd7xlETqJv5zW95qYCPd700IVMa68R8Moc34GA1i+
    gm9TISZCFWIb/mVF32aBjGXoy9/OTcQw1SJLqFnJ6MVH8f+sWdnXGMmNW9GJViGimaynlq
    Bgx2NQMcbYJRpelOJJtGx1D9s5SAzCfWiUQHyjvO4/TDl+cGEWwR6X5GpK7r/VDxSI0yQM
    Dekgauzsswp5pbCNuPQ8dAYstyi2KSMy+pRNFz4PJ2Ef5H5Gbge/Q8j2nN2vOVsoIApq4q
    u2dDI9evWydLU7pmgESPRnN5Pdm1JBhAmbUcJZHRjU0rpmb9GBH+ONBAp33Q
X-ME-Proxy: <xmx:-j2Cat1QB2e4JtilKVL7vUJi-dduDBHXCDQJEAY3SLsYJNWP-T2CgQ>
    <xmx:-j2CamageT91UOjGGsIoKRAdtY3DXtAfV-bSYkAblP2dzBP6iLEvtQ>
    <xmx:-j2CaslMwLuey05SWgD3U837nfZvDXsLlmfcFE_og_pG3FiCqgNu7A>
    <xmx:-j2CanxdVkZXhUlqdGsalLPzsNCzmG1IWn8xDP_H2DJpWHXOkpdX2w>
    <xmx:-j2CasA802Rjs8caf0x8B44jsYS_t0Zk-Thr-aTrKNOJ5s2xjq0lctsD>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:21 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	mhocko@suse.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com,
	usama.anjum@arm.com,
	agordeev@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	jannh@google.com,
	willy@infradead.org,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 34/57] mm/collapse: implement MADV_COLLAPSE in madvise.c
Date: Sun, 16 Aug 2026 23:45:46 +0100
Message-ID: <20260816224609.308019-35-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816224609.308019-1-kirill@shutemov.name>
References: <20260816224609.308019-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

MADV_COLLAPSE is a madvise operation, but its implementation sat in
khugepaged.c.  The daemon's file therefore also held a syscall's worth of
code that has nothing to do with the daemon: the walk over the user's
range, the per-PMD loop, and the errno translation that reports back
through madvise(2).

Move it to madvise.c, among the operations it belongs with, along with the
errno map and the policy it states for itself.  It takes a struct
madvise_behavior like every one of those operations, which is where the
range, the VMA and the lock-dropped flag it used to be handed separately
already live.

It stays a caller of the same interface khugepaged uses, so nothing about
the collapse changes.  The eligibility test reads
collapse_possible_orders() rather than collapse_possible(), a static
wrapper around it that madvise.c cannot reach.

With the declaration in huge_mm.h no longer needed, the
!CONFIG_TRANSPARENT_HUGEPAGE stub moves in with it.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/huge_mm.h |   9 --
 mm/khugepaged.c         | 182 -------------------------------------
 mm/madvise.c            | 195 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 193 insertions(+), 193 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c745f7ad2298..8ca0fa3be2ac 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -510,8 +510,6 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
 		     int advice);
-int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end, bool *lock_dropped);
 void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, struct vm_area_struct *next);
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
@@ -715,13 +713,6 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
 	return -EINVAL;
 }
 
-static inline int madvise_collapse(struct vm_area_struct *vma,
-				   unsigned long start,
-				   unsigned long end, bool *lock_dropped)
-{
-	return -EINVAL;
-}
-
 static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 unsigned long start,
 					 unsigned long end,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 47c134cd4129..967cc472b6dc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -844,185 +844,3 @@ bool current_is_khugepaged(void)
 {
 	return kthread_func(current) == khugepaged;
 }
-
-/* MADV_COLLAPSE was asked for explicitly, so it is not held to those. */
-static void collapse_policy_forced(struct collapse_policy *p)
-{
-	p->max_ptes_none = HPAGE_PMD_NR;
-	p->max_ptes_swap = HPAGE_PMD_NR;
-	p->max_ptes_shared = HPAGE_PMD_NR;
-	p->strict_sub_pmd = false;
-	p->skip_lazyfree = false;
-	p->require_referenced = false;
-	p->install_pmd = true;
-	p->writeback_dirty = true;
-	p->gfp = GFP_TRANSHUGE;
-	p->tva_type = TVA_FORCED_COLLAPSE;
-}
-
-static int madvise_collapse_errno(enum scan_result r)
-{
-	/*
-	 * MADV_COLLAPSE breaks from existing madvise(2) conventions to provide
-	 * actionable feedback to caller, so they may take an appropriate
-	 * fallback measure depending on the nature of the failure.
-	 */
-	switch (r) {
-	case SCAN_ALLOC_HUGE_PAGE_FAIL:
-		return -ENOMEM;
-	case SCAN_CGROUP_CHARGE_FAIL:
-	case SCAN_EXCEED_NONE_PTE:
-		return -EBUSY;
-	/* Resource temporary unavailable - trying again might succeed */
-	case SCAN_PAGE_COUNT:
-	case SCAN_PAGE_LOCK:
-	case SCAN_PAGE_LRU:
-	case SCAN_DEL_PAGE_LRU:
-	case SCAN_PAGE_FILLED:
-	case SCAN_PAGE_HAS_PRIVATE:
-	case SCAN_PAGE_DIRTY_OR_WRITEBACK:
-		return -EAGAIN;
-	/*
-	 * Other: Trying again likely not to succeed / error intrinsic to
-	 * specified memory range. khugepaged likely won't be able to collapse
-	 * either.
-	 */
-	default:
-		return -EINVAL;
-	}
-}
-
-int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end, bool *lock_dropped)
-{
-	struct collapse_control *cc;
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long hstart, hend, addr;
-	/* What the VMA allows; valid only while its lock is held */
-	unsigned long vma_orders;
-	enum scan_result last_fail = SCAN_FAIL;
-	int thps = 0;
-	int err;
-
-	BUG_ON(vma->vm_start > start);
-	BUG_ON(vma->vm_end < end);
-
-	if (!collapse_possible(vma, vma->vm_flags, TVA_FORCED_COLLAPSE))
-		return -EINVAL;
-
-	hstart = ALIGN(start, HPAGE_PMD_SIZE);
-	hend = ALIGN_DOWN(end, HPAGE_PMD_SIZE);
-
-	if (hstart >= hend)
-		return 0;
-
-	cc = kmalloc_obj(*cc);
-	if (!cc)
-		return -ENOMEM;
-	collapse_policy_forced(&cc->policy);
-	cc->progress = 0;
-	err = collapse_control_init(cc);
-	if (err) {
-		kfree(cc);
-		return err;
-	}
-
-	mmgrab(mm);
-
-	/*
-	 * Nothing below wants the lock the VMA walk left held, and
-	 * lru_add_drain_all() waits on every CPU, so give it up first.  The
-	 * walk carries on under mmap_lock and its own caller is what drops it,
-	 * so reporting this only tells the walk that its VMA is now stale.
-	 */
-	mmap_read_unlock(mm);
-	*lock_dropped = true;
-	vma = NULL;
-	vma_orders = 0;
-	lru_add_drain_all();
-
-	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
-		enum scan_result result;
-
-		/*
-		 * A collapse gives the lock up, and the VMA has to be found
-		 * again after one: it can shrink while nothing is held.  A scan
-		 * that finds nothing to collapse leaves the lock alone, so a
-		 * range that is already collapsed walks it without relocking.
-		 *
-		 * Reschedule only here, where nothing is held: a preemption
-		 * point under a lock is a writer waiting longer.
-		 */
-		if (!vma) {
-			cond_resched();
-			mmap_read_lock(mm);
-			vma = vma_lookup(mm, addr);
-			if (!vma) {
-				mmap_read_unlock(mm);
-				hend = addr;
-				break;
-			}
-			vma_orders = collapse_possible_orders(vma,
-					vma->vm_flags, TVA_FORCED_COLLAPSE);
-		}
-
-		/* If nothing to collapse, the lock is still ours */
-		if (!collapse_scan_pmd(vma, addr, addr + HPAGE_PMD_SIZE, cc,
-				       vma_orders)) {
-			result = cc->scan_refusal;
-		} else {
-			/* collapse_run_pmd() takes its own locks, so give this up */
-			mmap_read_unlock(mm);
-			vma = NULL;
-			/* The mask belonged to that lock, not to this range */
-			vma_orders = 0;
-
-			result = collapse_run_pmd(mm, addr,
-						  addr + HPAGE_PMD_SIZE, cc);
-		}
-
-		/*
-		 * The VMA shrank under us, so the rest of the range was never
-		 * ours to collapse: stop, and expect only what came before.
-		 */
-		if (result == SCAN_VMA_NULL || result == SCAN_ADDRESS_RANGE) {
-			hend = addr;
-			break;
-		}
-
-		switch (result) {
-		case SCAN_SUCCEED:
-		case SCAN_PMD_MAPPED:
-			++thps;
-			break;
-		/* Whitelisted set of results where continuing OK */
-		case SCAN_NO_PTE_TABLE:
-		case SCAN_PTE_NON_PRESENT:
-		case SCAN_PTE_UFFD:
-		case SCAN_LACK_REFERENCED_PAGE:
-		case SCAN_PAGE_NULL:
-		case SCAN_PAGE_COUNT:
-		case SCAN_PAGE_LOCK:
-		case SCAN_PAGE_COMPOUND:
-		case SCAN_PAGE_LRU:
-		case SCAN_DEL_PAGE_LRU:
-			last_fail = result;
-			break;
-		default:
-			last_fail = result;
-			/* Other error, exit */
-			goto out;
-		}
-	}
-
-out:
-	/* The VMA walk this returns to expects the lock it was holding */
-	if (!vma)
-		mmap_read_lock(mm);
-	mmdrop(mm);
-	collapse_control_release(cc);
-	kfree(cc);
-
-	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
-			: madvise_collapse_errno(last_fail);
-}
diff --git a/mm/madvise.c b/mm/madvise.c
index c179938097bf..76ddf61f043f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -894,6 +894,198 @@ bool madvise_dontneed_free_valid_vma(struct madvise_behavior *madv_behavior)
 	return true;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#include "collapse.h"
+
+/* MADV_COLLAPSE was asked for explicitly, so it is not held to those. */
+static void collapse_policy_forced(struct collapse_policy *p)
+{
+	p->max_ptes_none = HPAGE_PMD_NR;
+	p->max_ptes_swap = HPAGE_PMD_NR;
+	p->max_ptes_shared = HPAGE_PMD_NR;
+	p->strict_sub_pmd = false;
+	p->skip_lazyfree = false;
+	p->require_referenced = false;
+	p->install_pmd = true;
+	p->writeback_dirty = true;
+	p->gfp = GFP_TRANSHUGE;
+	p->tva_type = TVA_FORCED_COLLAPSE;
+}
+
+static int madvise_collapse_errno(enum scan_result r)
+{
+	/*
+	 * MADV_COLLAPSE breaks from existing madvise(2) conventions to provide
+	 * actionable feedback to caller, so they may take an appropriate
+	 * fallback measure depending on the nature of the failure.
+	 */
+	switch (r) {
+	case SCAN_ALLOC_HUGE_PAGE_FAIL:
+		return -ENOMEM;
+	case SCAN_CGROUP_CHARGE_FAIL:
+	case SCAN_EXCEED_NONE_PTE:
+		return -EBUSY;
+	/* Resource temporary unavailable - trying again might succeed */
+	case SCAN_PAGE_COUNT:
+	case SCAN_PAGE_LOCK:
+	case SCAN_PAGE_LRU:
+	case SCAN_DEL_PAGE_LRU:
+	case SCAN_PAGE_FILLED:
+	case SCAN_PAGE_HAS_PRIVATE:
+	case SCAN_PAGE_DIRTY_OR_WRITEBACK:
+		return -EAGAIN;
+	/*
+	 * Other: Trying again likely not to succeed / error intrinsic to
+	 * specified memory range. khugepaged likely won't be able to collapse
+	 * either.
+	 */
+	default:
+		return -EINVAL;
+	}
+}
+
+static int madvise_collapse(struct madvise_behavior *madv_behavior)
+{
+	struct madvise_behavior_range *range = &madv_behavior->range;
+	struct vm_area_struct *vma = madv_behavior->vma;
+	struct mm_struct *mm = madv_behavior->mm;
+	unsigned long hstart, hend, addr;
+	struct collapse_control *cc;
+	unsigned long vma_orders;
+	enum scan_result last_fail = SCAN_FAIL;
+	int thps = 0;
+	int err;
+
+	BUG_ON(vma->vm_start > range->start);
+	BUG_ON(vma->vm_end < range->end);
+
+	if (!collapse_possible_orders(vma, vma->vm_flags, TVA_FORCED_COLLAPSE))
+		return -EINVAL;
+
+	hstart = ALIGN(range->start, HPAGE_PMD_SIZE);
+	hend = ALIGN_DOWN(range->end, HPAGE_PMD_SIZE);
+
+	if (hstart >= hend)
+		return 0;
+
+	cc = kmalloc_obj(*cc);
+	if (!cc)
+		return -ENOMEM;
+	collapse_policy_forced(&cc->policy);
+	cc->progress = 0;
+	err = collapse_control_init(cc);
+	if (err) {
+		kfree(cc);
+		return err;
+	}
+
+	mmgrab(mm);
+
+	/*
+	 * Nothing below wants the lock the VMA walk left held, and
+	 * lru_add_drain_all() waits on every CPU, so give it up first.  The
+	 * walk carries on under mmap_lock and its own caller is what drops it,
+	 * so reporting this only tells the walk that its VMA is now stale.
+	 */
+	mmap_read_unlock(mm);
+	mark_mmap_lock_dropped(madv_behavior);
+	vma = NULL;
+	vma_orders = 0;
+	lru_add_drain_all();
+
+	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
+		enum scan_result result;
+
+		/*
+		 * A collapse gives the lock up, and the VMA has to be found
+		 * again after one: it can shrink while nothing is held.  A scan
+		 * that finds nothing to collapse leaves the lock alone, so a
+		 * range that is already collapsed walks it without relocking.
+		 *
+		 * Reschedule only here, where nothing is held: a preemption
+		 * point under a lock is a writer waiting longer.
+		 */
+		if (!vma) {
+			cond_resched();
+			mmap_read_lock(mm);
+			vma = vma_lookup(mm, addr);
+			if (!vma) {
+				mmap_read_unlock(mm);
+				hend = addr;
+				break;
+			}
+			vma_orders = collapse_possible_orders(vma,
+					vma->vm_flags, TVA_FORCED_COLLAPSE);
+		}
+
+		/* If nothing to collapse, the lock is still ours */
+		if (!collapse_scan_pmd(vma, addr, addr + HPAGE_PMD_SIZE, cc,
+				       vma_orders)) {
+			result = cc->scan_refusal;
+		} else {
+			/* collapse_run_pmd() takes its own locks, so give this up */
+			mmap_read_unlock(mm);
+			vma = NULL;
+			/* The mask belonged to that lock, not to this range */
+			vma_orders = 0;
+
+			result = collapse_run_pmd(mm, addr,
+						  addr + HPAGE_PMD_SIZE, cc);
+		}
+
+		/*
+		 * The VMA shrank under us, so the rest of the range was never
+		 * ours to collapse: stop, and expect only what came before.
+		 */
+		if (result == SCAN_VMA_NULL || result == SCAN_ADDRESS_RANGE) {
+			hend = addr;
+			break;
+		}
+
+		switch (result) {
+		case SCAN_SUCCEED:
+		case SCAN_PMD_MAPPED:
+			++thps;
+			break;
+		/* Whitelisted set of results where continuing OK */
+		case SCAN_NO_PTE_TABLE:
+		case SCAN_PTE_NON_PRESENT:
+		case SCAN_PTE_UFFD:
+		case SCAN_LACK_REFERENCED_PAGE:
+		case SCAN_PAGE_NULL:
+		case SCAN_PAGE_COUNT:
+		case SCAN_PAGE_LOCK:
+		case SCAN_PAGE_COMPOUND:
+		case SCAN_PAGE_LRU:
+		case SCAN_DEL_PAGE_LRU:
+			last_fail = result;
+			break;
+		default:
+			last_fail = result;
+			/* Other error, exit */
+			goto out;
+		}
+	}
+
+out:
+	/* The VMA walk this returns to expects the lock it was holding */
+	if (!vma)
+		mmap_read_lock(mm);
+	mmdrop(mm);
+	collapse_control_release(cc);
+	kfree(cc);
+
+	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
+			: madvise_collapse_errno(last_fail);
+}
+
+#else
+static int madvise_collapse(struct madvise_behavior *madv_behavior)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 static long madvise_dontneed_free(struct madvise_behavior *madv_behavior)
 {
 	struct mm_struct *mm = madv_behavior->mm;
@@ -1361,8 +1553,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	case MADV_DONTNEED_LOCKED:
 		return madvise_dontneed_free(madv_behavior);
 	case MADV_COLLAPSE:
-		return madvise_collapse(vma, range->start, range->end,
-			&madv_behavior->lock_dropped);
+		return madvise_collapse(madv_behavior);
 	case MADV_GUARD_INSTALL:
 		return madvise_guard_install(madv_behavior);
 	case MADV_GUARD_REMOVE:
-- 
2.54.0

