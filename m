Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CE40F72C;
	Sun, 16 Aug 2026 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920465; cv=none; b=QC15jGkjVGW9ImzjMrFYyn7CvCd4eaCJJRFE17xWQumAQR2jReXmJgE67CLaKwLmuLmYZm9mHZ8WOoX2FMnTiHI36KT0Sb0vLKX4fHeZ+xDCj5DJ2Qgespsrh0EkEAv/+VpyVSIEEDsEvsgwOLMwBi/qzIZOlvzkdCVA3f4L3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920465; c=relaxed/simple;
	bh=8b4LkbLMpL4QuaHUG434StKbuBjTZ2oy1sPW1STQicI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5NGQbQ2mHwIt34bR51hyqFcbsmIiHkjBGv7+kzwi3Kp0uMU+xNsnEhPZ6eF4rD1oquSgXbf7di4W+sNCVjRO/Dm4Rt1tATrRmv9ZbDh30DS6pek4vOqUF4XFvZSF4YSJ7bmn4WIpy39EN934cMXx/Dky8pX9pR7fwJWUv4FWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OSA76d6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoWhU4ye; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OSA76d6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoWhU4ye"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1197514000EB;
	Sun, 16 Aug 2026 18:47:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 18:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920463; x=
	1787006863; bh=ftB1HJ8Y15YVxr5O+cxOqWPRClS84lYkjsQI5VetnJA=; b=O
	SA76d6nMTniIxLQ415JPsCD5DMqyGlEennXopHdxKTGu8qymvPyWzNMyvAZDGpAh
	hJf8Q74k9BzfvmJSAjmYJQCNGMutYbLSPUVm8dhMKEgi6U/lgX2ErtYzuZXEIXvI
	GxBu39nmjYPX4XycBzI/f1grk/PMJwaT0YdVsz6dXCDdrqmhrqZ5d0meTTOaJlxa
	JfMCD/yl+P5VEjyHyQai3w42hESA0DEUAwKGw62UAcSBVVTRgKHk0X602Oc3ZbNR
	Nvn4lar9sCGySd6c7QFVeN7zKbdtMm88FXHM1+ZuosVQ6nJSHTM/xeR+KB7zYZ3y
	kF/HP0BU4WseZZiNC/Eiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920463; x=1787006863; bh=f
	tB1HJ8Y15YVxr5O+cxOqWPRClS84lYkjsQI5VetnJA=; b=WoWhU4yeuVWdXErGT
	FSsCSrQXGPmIxaMq8DPs7WSJw09tPvWM2cER/r/TNCJ9BYH8ZWlJISEpI4oUWF5A
	kmPb0AM4PSOX5z/iG6YXq5PvCAuXCa+H8Ns73K+etHAEVSoxSm4THccwyKdSKjy1
	BDA8bmo4cPNyiwtWDEUhWSVS/84wWVa+jCp1yG4RTGzDo60VssqMr/EG4wLQlvZU
	k0zP072hYNpL5H/sLBbS+byxeWL2PWlppyGcLF3vlgBlPeveGj/JBQvEipfOnYd4
	79IuMK9evW5eRERezTRxUxcgnpUj26TDiQRnkfrZJxHJPWyBe8nUxRj6Nox3/pAZ
	WyBUQ==
X-ME-Sender: <xms:Dj6Cav2zIIklEfM_Vq5-pbI9SZN4pRw70oRHHPtjMDMQetxa0KLyGw>
    <xme:Dj6Canroq3Q8WOutU2MSeHt3VBMr73-zoovLckArOx5Msnt5qKyB9pd5O9NDUKLqj
    aFIkjpvVKCRVrfFdCmhWFcH74gIBOONxw3Q3Ly4B8TfUH9975BQswVG>
X-ME-Received: <xmr:Dj6CarV6FBqK8O7btQ1T_JkFQmu4z0J_LG72HHFezgu4hF3YAAV39ES-ZDE>
X-ME-Proxy-Cause: dmFkZTFkhNC7YI+Ei0MrF6zu90W9yR7z714JmmtstcBEn9fnZ0JEx8KxNru7XjOIPijUAd
    VrNDumTIvQCtLJHAbrPKMRdbJsCYKY1AWxa28xNEDdkQaDqy3PIOJVA9R+OjsTN2M4dnB4
    WQk97ejO2lmWwXR5mw6146Dl5x2vSRCf1uehpA4Z3DNP/uvzS8DmGwE+/LsFmt9BQO6ZtJ
    eWd0dPZ2F0WrWW1tiYo0zV8d4Xgh8ztMbcUaDgwCK69ZeQi0ebesOWu50OSj19NNGHzec3
    w5R1etyOsXXy4NxsI/YxbKwNbzdBv+aWoLN5/PFLP+n740pr735uP0KJxEPqjezkxGUEae
    VbV3rMngkaPxQKuJpJI13Iuy9BW4VdoLWVjHaMCTYZzuReZcweII6OV6N7/eDhyeqRnM3U
    ZaRP0X5mK4wstAamKJjGnw1uyl2I1fZsgwkT91DxkdavZuHiuRFeu9WzlEiV6bYzz8TpAA
    dLfkb9PE5A3JzRKardx2vbuSZ+Ht+1ceDrUA3aw09PbBDyLGrX2AOrLz43qEIUSlbyaGxC
    tSayGSOXDkXXT0rR32+d3CFxt9XK340pkIj6m0BjxG9p46OD0dxAkc1BBoLJPIJT6NlKs5
    LWq6FThsDA/9lLgOC1LEnx6RW9EGDOFGdJ7sV1UKB0t2r9/y4E3uyLBgb/cg
X-ME-Proxy: <xmx:Dj6CajgeNJVjMjOFUvGdHB8B62tTaYEtDp5R-FK_kOXW2dmeyKcY2A>
    <xmx:Dz6Cai9M-NXN-KFHeh4OHi0nj20KmtlhpiVA3OpsYnmgy7EhxHFCFg>
    <xmx:Dz6CarT-RolCGw-rVuczxJhUjyMg_fFvJM1lUR0WHwMTILyso5fRVA>
    <xmx:Dz6CavHO-b5p_x5oDjoqf53-yvb50TvinlnsJ0zA8ALbjLbYoyKc7A>
    <xmx:Dz6CatidA6KwxzRiO4LuvG6JpL2qEzfBAJynxGBPj9bv55BCvXdR-6bh>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:42 -0400 (EDT)
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
Subject: [RFC PATCH 46/57] mm/khugepaged: scan under a per-VMA read lock
Date: Sun, 16 Aug 2026 23:45:58 +0100
Message-ID: <20260816224609.308019-47-kirill@shutemov.name>
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

A pass took mmap_lock for the whole walk: every VMA of the address space
judged, and every table of every VMA scanned, under one lock.  A writer
anywhere in the mm waits for all of it.  And a pass that finds nothing to
collapse -- which is what a pass over an already-collapsed address space
is -- holds the lock for the whole sweep to say so.

Take a read lock on one VMA at a time instead.  lock_next_vma() finds the
next VMA at or after the cursor and locks it, falling back to mmap_lock
only where it cannot.  A scan holds that lock across every table of that
VMA and no longer.

What a round has to be excluded from already takes vma_start_write() on
the VMA it touches, so the exclusion is the same.  What changes is that it
is scoped to the VMA being scanned.

Two things follow from the iterator no longer being carried by mmap_lock.

The cursor moves by hand, because nothing else advances it now: past a VMA
that was walked, past one skipped without being looked at, and past each
table a scan was offered.

And the end of the address space has to be recognised rather than fallen
out of.  scan_complete says whether lock_next_vma() ran out of VMAs: an
error is not the end, and treating it as one would release the slot with
the address space half scanned.

The scan asserted mmap_assert_locked() on the way in.  Its two callers no
longer agree on what they hold -- khugepaged a VMA read lock from here,
MADV_COLLAPSE still mmap_lock -- so there is no single lock to assert, and
the assert goes.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c   |  25 +++++-----
 mm/khugepaged.c | 128 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 96 insertions(+), 57 deletions(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index b6e92e24a3c5..b3343595bdf2 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -52,8 +52,8 @@ enum collapse_pass {
  * The folios mapped across a window of PTEs become one folio of that window's
  * order, with the sources quiesced by the two barriers migration uses --
  * migration entries in their PTEs, then a frozen refcount -- so the copy itself
- * needs no lock.  A collapse takes a read lock on the VMA for each round; a
- * scan still runs under the mmap_lock its caller holds.
+ * needs no lock.  A scan runs under a read lock on the VMA it was handed; a
+ * collapse is given none and takes its own, for one round at a time.
  *
  * A round carries a batch of candidate windows through the passes together,
  * rather than carrying one window through the whole collapse.  [ptl] and
@@ -1949,9 +1949,10 @@ static enum scan_result collapse_scan_table(struct vm_area_struct *vma,
 	 * wait for a scan of the whole table.
 	 *
 	 * pte_offset_map() holds rcu_read_lock() until pte_unmap(), which is
-	 * what keeps the table itself from being freed underneath the walk;
-	 * mmap_lock keeps the VMA attached, without which free_pgtables() could
-	 * free it without waiting for RCU at all.  Nothing below here sleeps.
+	 * what keeps the table itself from being freed underneath the walk; the
+	 * VMA read lock keeps the VMA attached, without which free_pgtables()
+	 * could free it without waiting for RCU at all.  Nothing below here
+	 * sleeps.
 	 */
 	pte = pte_offset_map(pmd, start);
 	if (!pte) {
@@ -2174,9 +2175,9 @@ static void collapse_anon_scan_init(struct collapse_control *cc)
 /*
  * Judge one table's worth of @vma, leaving in @cc what a collapse could use:
  * which orders are still worth attempting, and why the table was turned down if
- * some order was.  Holds mmap_lock throughout -- it only reads -- and a caller
- * that acts on what it found hands the range to collapse_anon_pmd() afterwards,
- * without the lock.
+ * some order was.  Holds the read lock it was called under throughout -- it only
+ * reads -- and a caller that acts on what it found hands the range to
+ * collapse_anon_pmd() afterwards, without any lock.
  */
 static enum scan_result collapse_scan_anon_pmd(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end,
@@ -3745,9 +3746,9 @@ static enum scan_result collapse_file_pmd(struct mm_struct *mm,
 
 /*
  * Scan one table's worth of @vma and decide whether there is anything to collapse
- * in it.  The caller holds mmap_lock for reading and still holds it when this
- * returns: what is looked at is either the VMA or a page table that the lock
- * keeps in place.
+ * in it.  The caller holds a read lock and still holds it when this returns:
+ * what is looked at is either the VMA or a page table that the lock keeps in
+ * place.
  *
  * Returns whether collapse_run_pmd() has anything to do, and a scan that found
  * something has to be run: the file side takes a reference on the file while it
@@ -3760,8 +3761,6 @@ bool collapse_scan_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	mmap_assert_locked(mm);
-
 	/*
 	 * What the scan answers with, so cleared before it runs.
 	 * collapse_anon_scan_init() clears the orders too, but only once the
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f3ea1846990e..1d77d9a8046d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -511,10 +511,10 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
-	struct vma_iterator vmi;
 	struct mm_slot *slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
+	bool scan_complete = false;
 	unsigned int progress_prev = cc->progress;
 
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -534,55 +534,82 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 	vma = NULL;
 
 	/*
-	 * A reference on mm_users for as long as the pass works on this address
-	 * space.  __mmput() cannot start while one is held, so neither can
-	 * exit_mmap(), and the VMAs and page tables stay where they are.
+	 * Hold the address space open for the pass.  A collapse works under a
+	 * per-VMA read lock, and the barrier __khugepaged_exit() puts in front
+	 * of exit_mmap() -- mmap_write_lock() -- waits for a reader of
+	 * mmap_lock, not for a reader of one VMA.  A reference on mm_users
+	 * stops __mmput(), and so both of those, from starting at all.
 	 *
-	 * Once per pass, not once per table: the reference is what makes the
-	 * address space safe to work on, and a pass is how long that is wanted
-	 * for.  Nothing else in mm takes it per unit of work -- DAMON takes one
-	 * per target and walks every region under it, swapoff one per mm across
-	 * the whole address space, userfaultfd one per call.
+	 * Once per pass rather than once per table: the reference is what makes
+	 * the address space safe to work on, and the pass is how long that is
+	 * wanted for.  Nothing else in mm takes it per unit of work -- DAMON
+	 * takes one per target and walks every region under it, swapoff one per
+	 * mm across the whole address space, userfaultfd one per call.  It is
+	 * dropped below before the exiting mm is judged, so that judgement still
+	 * sees the true count.
 	 */
 	if (!mmget_not_zero(mm))
 		goto breakouterloop_no_mmput;
 
-	/*
-	 * Don't wait for semaphore (to avoid long wait times).  Just move to
-	 * the next mm on the list.
-	 */
-	if (unlikely(!mmap_read_trylock(mm)))
-		goto breakouterloop_mmap_lock;
-
 	cc->progress++;
-	if (unlikely(collapse_test_exit_or_disable_mmref(mm)))
-		goto breakouterloop;
 
-	vma_iter_init(&vmi, mm, khugepaged_scan.address);
-	for_each_vma(vmi, vma) {
+	/*
+	 * One VMA at a time, each held by its own read lock rather than by
+	 * mmap_lock over the whole address space.  lock_next_vma() locks what it
+	 * finds, falling back to mmap_lock only where it cannot.
+	 *
+	 * Whether this mm still wants collapsing is asked once, at the top of
+	 * each round of the loop.  Asking again before entering it only repeats
+	 * the same question: nothing between the two can answer it differently.
+	 */
+	for (;;) {
 		unsigned long hstart, hend, window;
+		struct vma_iterator vmi;
 		unsigned long orders;
 
 		cond_resched();
+		/*
+		 * Our reference is the reason the count cannot fall to zero, so
+		 * it is also what an address space whose owner has gone looks
+		 * like.  Stopping is what frees it: nothing else here would.
+		 */
 		if (unlikely(collapse_test_exit_or_disable_mmref(mm))) {
 			cc->progress++;
-			break;
+			goto breakouterloop;
 		}
 
 		/*
-		 * Before the VMA is judged, so that a pass over an address space
-		 * of VMAs it skips is bounded by the budget too: each one is
-		 * charged for, and none of them was being asked to be scanned.
+		 * Before a VMA is locked, so that a pass over an address space
+		 * of VMAs it skips is bounded by the budget too, and so that a
+		 * collapse returning here does not lock one to be told it is
+		 * out of budget.
 		 */
 		if (cc->progress >= progress_max)
-			break;
+			goto breakouterloop;
+
+		/* The first VMA at or after the cursor, which often sits in a gap */
+		rcu_read_lock();
+		vma_iter_init(&vmi, mm, khugepaged_scan.address);
+		vma = lock_next_vma(mm, &vmi, khugepaged_scan.address);
+		rcu_read_unlock();
+
+		/*
+		 * NULL is the end of the address space, and the only thing that
+		 * finishes this mm.  An error is a fatal signal or the unlikely
+		 * reference count overflow: leave the mm for the next pass
+		 * rather than treat it as walked.
+		 */
+		if (IS_ERR_OR_NULL(vma)) {
+			scan_complete = !IS_ERR(vma);
+			vma = NULL;
+			goto breakouterloop;
+		}
 
 		orders = collapse_possible_orders(vma, vma->vm_flags,
 						  TVA_KHUGEPAGED);
 		if (!orders) {
-			khugepaged_scan.address = vma->vm_end;
 			cc->progress++;
-			continue;
+			goto next_vma;
 		}
 
 		/*
@@ -595,9 +622,8 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 		hstart = ALIGN(vma->vm_start, window);
 		hend = ALIGN_DOWN(vma->vm_end, window);
 		if (khugepaged_scan.address > hend) {
-			khugepaged_scan.address = vma->vm_end;
 			cc->progress++;
-			continue;
+			goto next_vma;
 		}
 		if (khugepaged_scan.address < hstart)
 			khugepaged_scan.address = hstart;
@@ -605,19 +631,24 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 		while (khugepaged_scan.address < hend) {
 			unsigned long pmd_addr, range_end, start;
 
+			cond_resched();
+
+			if (unlikely(collapse_test_exit_or_disable_mmref(mm)) ||
+			    cc->progress >= progress_max) {
+				vma_end_read(vma);
+				vma = NULL;
+				goto breakouterloop;
+			}
+
 			/* One table's worth at most, and never past the VMA */
 			pmd_addr = khugepaged_scan.address & HPAGE_PMD_MASK;
 			range_end = min(hend, pmd_addr + HPAGE_PMD_SIZE);
-
-			cond_resched();
-			if (unlikely(collapse_test_exit_or_disable_mmref(mm)) ||
-			    cc->progress >= progress_max)
-				goto breakouterloop;
+			start = khugepaged_scan.address;
 
 			VM_WARN_ON_ONCE(khugepaged_scan.address < hstart);
+			VM_WARN_ON_ONCE(range_end > hend);
 
-			start = khugepaged_scan.address;
-			/* move to next address */
+			/* Move the cursor on regardless of what the scan says */
 			khugepaged_scan.address = range_end;
 
 			/* If nothing to collapse, the lock is still ours */
@@ -627,21 +658,30 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			}
 
 			/* collapse_run_pmd() takes its own locks, so give this up */
-			mmap_read_unlock(mm);
+			vma_end_read(vma);
+			vma = NULL;
+
 			*result = collapse_run_pmd(mm, start, range_end, cc);
 			if (*result == SCAN_SUCCEED)
-				++khugepaged_pages_collapsed;
-			goto breakouterloop_mmap_lock;
+				khugepaged_pages_collapsed++;
+			goto breakouterloop;
 		}
+next_vma:
+		/*
+		 * Past this VMA: the cursor has to move by hand, where the
+		 * mmap_lock iterator used to carry it.  A VMA that was walked
+		 * is charged by the scan itself, one table at a time; only one
+		 * passed over without being looked at is charged here.
+		 */
+		khugepaged_scan.address = vma->vm_end;
+		vma_end_read(vma);
+		vma = NULL;
 	}
+
 breakouterloop:
-	mmap_read_unlock(mm); /* exit_mmap will destroy ptes after this */
-breakouterloop_mmap_lock:
 	/*
 	 * Not mmput(): the last reference would run exit_mmap() here, and
 	 * khugepaged is not the thread that should tear an address space down.
-	 * Dropped before the exiting mm is judged below, so that judgement still
-	 * sees the true count.
 	 */
 	mmput_async(mm);
 breakouterloop_no_mmput:
@@ -652,7 +692,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm, or THP got disabled.
 	 */
-	if (collapse_test_exit_or_disable(mm) || !vma) {
+	if (collapse_test_exit_or_disable(mm) || scan_complete) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.54.0

