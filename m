Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FA3E63B0;
	Sun, 16 Aug 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920464; cv=none; b=WWeskdCDsqWbxXl01EcJH1kBD0zO7bJ/FrNrkNng8Ss4xECRsNNvFNES4oTJk3tw6t42iU+DuDYABZSGndAEu2YdUO90Bfe9Lw2sVJR7svrDspQYhfsjGEW40DITc1p7VE08qRfpy04kfFqrTsK+aCUjOab51wzS3tdd2U9WS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920464; c=relaxed/simple;
	bh=YJNac9oYJhGUaLq234UkKNFFUy+hEfprOURyQoJSfGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehIDwTY7UtBGtrY201oamYZWLnlUXAR5toke3lT+jBsaH0y0qZDVEtb6qUaz/H4CYBimQaW7NOBapgX1fNFwiZEs8oAD984+DBiIx9DeJH+ADaIQm0c3T8TmhnxHPInupHJhBFdsjgIfCFy85+jvalzxNW2QZ3sNWh+yo26JE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KxxlfdpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HNhI9M71; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KxxlfdpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HNhI9M71"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54C8F14000FA;
	Sun, 16 Aug 2026 18:47:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920461; x=
	1787006861; bh=za2Lpztq5iqcTX4ankoznbvISTw47a74bIKVghH2CR4=; b=K
	xxlfdpLvgJbGk4rJLZ+Cu+xz0wYL/UBYzRzK0xs5M3gPCKjQvfr1XregUI4dLyaJ
	JOGJHQSXP207jlhG6Zfe2vHlEWfSGbGP+PzIVNQWZcR5F0DdIoXzZp162HVmS9yL
	5yGYd8QXngpAZZAXd+4XT4zuOGBQKze0c3PEfVpiJZ7dmKllV6CBGl4QVR/AWUQu
	0KyNVuB8fZ/EI3t5z6UoyYcnTUVPzlKo+dnZUWaV9gyqQahUjvLLKQJGXG5hlg0V
	0PqpmucS3m7VrgxF6BsVut/zin+6xNehEM0TlFcqX4sD43RIi6kY2uSsK9CUl/O1
	NZW6vo+QPsCSLItTVJB4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920461; x=1787006861; bh=z
	a2Lpztq5iqcTX4ankoznbvISTw47a74bIKVghH2CR4=; b=HNhI9M71s+Ygqkqwf
	tzm19iEIk+cG7lE1f+l5XiTXLFPAK17mb4LAOO3ru8tNF2WL6Ilh1TYgsrFMQ+An
	qHJ3Qk7U68J+JnBv+4ftfCQnjgK2asvYC2JajkJwtuzgsmsOcIFjA+348tMUpeXO
	kf2p9jXxVBycdSc42l8RMuOfcWC1HfypcoKK5b8sXGzMiQeqmlpKVRPz7g9Ve7Fm
	mLoeiKq7eo6ToEzZekyQUN3DxOuYCS6XMFQOGucpdFEDR6Q4eSdZgjALi2c1AF8D
	xZG+se2qdVYevjKlad9zTjekUReUQsVSFjO4RX8b6if+qXsy+uQcz8lXhFIipXw1
	faS6g==
X-ME-Sender: <xms:DT6Cal1oNMpfPqiSWPEH8e2eAL2OVexUtTWie2WTjEIeFnhr4jAdAw>
    <xme:DT6CahYzQ9RrKQZ3LUtK8ovRmKiqQGHod0NOsMOazp8CuKINIEcrRqY4fbfE3iMEv
    jyqzN4tEdsPPWCfOocDMzNdoMcSjAiolEcunwOivGVNbnoFJq4sPaQ>
X-ME-Received: <xmr:DT6Cah98mEkNT2p9K-JZH8LzjkorpLoJ9JibnJQykPb5zW1wrzEW3oNtFLA>
X-ME-Proxy-Cause: dmFkZTFxktHaoHQCGyR7uz2gXQdTgUX0nZzUatWYXQdVxBJb4A/qMuEZ/RMKYvGIBz31Rt
    TR5Nu17EPBqNyeZSjkVnK7sHElwU57b8x3/cyZ9PHHSfAaSWNWLOdeLuZVBbf5zubb18Bw
    fy/mf5jpQtxpZDPvMPXwjw+an+TW+7k/Tw/n4sb2tNNa7d9nLnQnX6Rw+vp6wioFQOuuev
    fpJbCZJSwa4xWiqXHUsCfuVr3o0xcsLHyTasHEYEkAGMtBoAwl7gOHcd9Yu3HcCvuVHzqL
    dMVburb2rGaTCsZcGe3UWITClIJ34iPVxiKzwGBtfazzXdWK1ezlWroYFXdEl+xlvbcPUF
    k970nTfEUWVpm0nF0GrdJhNoaD+sHupr3s1dISr8zMy52SPkaDGuLGQgwHwwOn5/OWjE7o
    iI9kR6MagxLIHHsQAOl+POPwFYCHu912UCVS+gZz4vwQZCuXJllT5y6lqgIpCHJTfZ2IXr
    2YYKg6bigb/+ehwZOUN6Q0dVru3sbYzx3M9vxSzXPmrpcxVmT9IDxjuBhNZ7lPGDXel82J
    aKkrEmSyBN2ASatCWqc3p9ztaVXMSpaLwvia8qeuOuljKZPXCFZq1jVjgkiP92CKnw3SJ2
    QrooxykOtBW4d0X/pcHN0dYnFZHWRMMnfBDOeV3njcXtRzkyCJoSSkb3PLfg
X-ME-Proxy: <xmx:DT6CavaVkYHKuoTyCtuxR3y6jjip0M-Fl03OJQm1U-ytqAwzoQJvqw>
    <xmx:DT6CauUe4YmJ6urN-UIIYIKjVAhCfyJMy3GxCy5kJQU6ImfTPj23Nw>
    <xmx:DT6CatgDuRc0cGfqdrnuxCrLtt6M1IYBRH6SMcCXH20hid1xNm6LZA>
    <xmx:DT6CaqkHI4s24GKReUU4RNyKOIxI9IOr9ZxhpP9WCch4SOVAzDY6og>
    <xmx:DT6CajIYK8qYykNqg1stV-q-0kG418yo21gnVhANEpNfqvn9ipSoH05J>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:40 -0400 (EDT)
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
Subject: [RFC PATCH 45/57] mm/collapse: take a per-VMA read lock for the round
Date: Sun, 16 Aug 2026 23:45:57 +0100
Message-ID: <20260816224609.308019-46-kirill@shutemov.name>
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

A round takes mmap_lock for reading and holds it across the freeze, the
copy and the install.  It is a read lock, so it blocks no faults -- but
every writer to the address space waits behind it, wherever in the mm that
writer is working.

A round works inside one VMA.  Everything it has to be excluded from --
fork, split, merge, unmap, and the free_pgtables() that follows them --
takes vma_start_write() on the VMA it touches first.  So a read lock on
that VMA excludes exactly what an mmap_read excluded, and an mmap_write
elsewhere in the mm stops waiting for a collapse it has nothing to do
with.

Look the VMA up with lock_vma_under_rcu() per round.  The round therefore
no longer works on the VMA the scan was given: it may be a different one
at that address, or the same one shrunk.  collapse_revalidate() already
re-asks every question the scan asked, and now also checks that the VMA
still covers what the round collected.

That lookup also fails on a VMA that is merely being written to, because
vma_start_read() fails while a writer holds vma_start_write().  A caller
cannot tell that from a VMA that has gone, so report SCAN_VMA_LOCK for
both, which MADV_COLLAPSE turns into -EAGAIN.  Treating it as a range that
shrank would report success for a collapse that never happened.

The fault-in pass gives up the same lock it was called under, so its
unlocks move with it, and the comments that carry the exclusion argument
name the lock they argue from.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/trace/events/collapse.h |  1 +
 mm/collapse.c                   | 77 +++++++++++++++++++--------------
 mm/collapse.h                   |  1 +
 mm/madvise.c                    |  1 +
 4 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/include/trace/events/collapse.h b/include/trace/events/collapse.h
index a3af5d8cc9aa..591030973d66 100644
--- a/include/trace/events/collapse.h
+++ b/include/trace/events/collapse.h
@@ -30,6 +30,7 @@
 	EM( SCAN_PAGE_COMPOUND,		"page_compound")		\
 	EM( SCAN_ANY_PROCESS,		"no_process_for_page")		\
 	EM( SCAN_VMA_NULL,		"vma_null")			\
+	EM( SCAN_VMA_LOCK,		"vma_not_lockable")		\
 	EM( SCAN_VMA_CHECK,		"vma_check_failed")		\
 	EM( SCAN_ADDRESS_RANGE,		"not_suitable_address_range")	\
 	EM( SCAN_DEL_PAGE_LRU,		"could_not_delete_page_from_lru")\
diff --git a/mm/collapse.c b/mm/collapse.c
index 76a53616b240..b6e92e24a3c5 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -52,7 +52,8 @@ enum collapse_pass {
  * The folios mapped across a window of PTEs become one folio of that window's
  * order, with the sources quiesced by the two barriers migration uses --
  * migration entries in their PTEs, then a frozen refcount -- so the copy itself
- * needs no lock.  The engine runs under mmap_read throughout.
+ * needs no lock.  A collapse takes a read lock on the VMA for each round; a
+ * scan still runs under the mmap_lock its caller holds.
  *
  * A round carries a batch of candidate windows through the passes together,
  * rather than carrying one window through the whole collapse.  [ptl] and
@@ -450,11 +451,11 @@ int collapse_control_init(struct collapse_control *cc)
 }
 
 /*
- * The scan and the allocation both dropped mmap_lock, so nothing seen before it
- * can be trusted: check the VMA the round just looked up and the PTE table
- * again, and that they still allow every provisioned candidate.
+ * The scan and the allocation both ran unlocked, so nothing seen before can be
+ * trusted: check the VMA the round just locked and the PTE table again, and
+ * that they still allow every provisioned candidate.
  *
- * The VMA was found by address, so it need not be the one the scan saw, nor
+ * The VMA was locked by address, so it need not be the one the scan saw, nor
  * still cover everything the round collected -- thp_vma_suitable_order() asks
  * that of each candidate, since a window is aligned to its own order.  A VMA
  * that shrank under a candidate therefore refuses that candidate and no more,
@@ -528,9 +529,9 @@ static enum scan_result collapse_revalidate(struct vm_area_struct *vma,
 /*
  * Bring one address to a state the freeze will accept: present, and exclusive if
  * it is anonymous.  Every fault it takes to get there counts in *nr_faults, each
- * one an allocation or a read the round is paying for.  Returns with mmap_lock
- * dropped on every failure, because the fault path may drop it and the caller
- * cannot tell which case it is in.
+ * one an allocation or a read the round is paying for.  Returns with the VMA
+ * read lock dropped on every failure, because the fault path may drop it and
+ * the caller cannot tell which case it is in.
  *
  * SCAN_EXCEED_SWAP_PTE is the exception: it is a verdict on this candidate
  * rather than on the round, nothing was faulted to reach it, and it keeps the
@@ -543,6 +544,7 @@ static enum scan_result collapse_faultin_addr(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	const unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_UNSHARE |
+		FAULT_FLAG_VMA_LOCK |
 		(mm != current->mm ? FAULT_FLAG_REMOTE : 0);
 	unsigned int tries;
 
@@ -553,7 +555,7 @@ static enum scan_result collapse_faultin_addr(struct vm_area_struct *vma,
 
 		pte = pte_offset_map(pmd, addr);
 		if (!pte) {
-			mmap_read_unlock(mm);
+			vma_end_read(vma);
 			return SCAN_NO_PTE_TABLE;
 		}
 		ptent = ptep_get_lockless(pte);
@@ -594,14 +596,14 @@ static enum scan_result collapse_faultin_addr(struct vm_area_struct *vma,
 		ret = handle_mm_fault(vma, addr, flags, NULL);
 		(*nr_faults)++;
 		/*
-		 * Not a verdict on this window: the fault dropped the lock to
-		 * wait, which is what a swap-in normally does.  Distinct from
+		 * Not a verdict on this window: the fault dropped the VMA lock
+		 * to wait, which is what a swap-in normally does.  Distinct from
 		 * SCAN_PAGE_LOCK, a folio someone else holds locked.
 		 */
 		if (ret & VM_FAULT_RETRY)
 			return SCAN_LOCK_DROPPED;
 		if (ret & VM_FAULT_ERROR) {
-			mmap_read_unlock(mm);
+			vma_end_read(vma);
 			return SCAN_FAIL;
 		}
 	}
@@ -611,7 +613,7 @@ static enum scan_result collapse_faultin_addr(struct vm_area_struct *vma,
 
 /*
  * Make every source the round needs present and exclusively owned by this mm,
- * by faulting it in as an ordinary access would.  Sleeps, and drops mmap_lock on
+ * by faulting it in as an ordinary access would.  Sleeps, and drops the VMA read
  * failure, since a fault may have to be retried with it released.
  *
  * Anything faulted in lands on a per-CPU LRU batch, holding a reference the
@@ -663,7 +665,7 @@ static enum scan_result collapse_faultin(struct vm_area_struct *vma,
 		}
 	}
 out:
-	/* @vma is unsafe on the failure path: the callee dropped mmap_lock */
+	/* @vma is unsafe on the failure path: the callee dropped its read lock */
 	trace_mm_collapse_faultin(mm, nr_faults, result);
 	return result;
 }
@@ -785,7 +787,7 @@ static void collapse_unfreeze_candidate(struct mm_struct *mm,
  * next page.  No layout is refused for its shape -- the next slot simply starts
  * its own span -- so partially mapped and compound sources collapse too.
  *
- * Caller holds mmap_read and the table's ptl.
+ * Caller holds the VMA read lock and the table's ptl.
  */
 static enum scan_result collapse_check_candidate(struct vm_area_struct *vma,
 						 struct collapse_control *cc,
@@ -929,7 +931,7 @@ static enum scan_result collapse_check_candidate(struct vm_area_struct *vma,
  *
  * On entry:
  *
- *  - mmap_read is held, and the table's ptl for the whole freeze;
+ *  - the VMA read lock is held, and the table's ptl for the whole freeze;
  *  - collapse_check_candidate() has accepted the candidate under that same ptl
  *    hold;
  *  - the round is covered by an mmu_notifier_invalidate_range_start() issued
@@ -1382,11 +1384,12 @@ static bool collapse_abort_slot(struct vm_area_struct *vma, struct folio *folio,
 
 /*
  * Abort one frozen candidate at install time: it took a machine check during the
- * copy, or some of its slots no longer hold our migration entries.  mmap_read
- * (held freeze..putback) blocks fork, mremap and munmap, and faults wait on the
- * migration entries -- but madvise-class operations run under mmap_read too, so a
- * concurrent MADV_DONTNEED may have zapped frozen slots, and a fault may have
- * refilled a zapped one.
+ * copy, or some of its slots no longer hold our migration entries.  The VMA read
+ * lock (held freeze..putback) blocks fork, mremap and munmap, each of which
+ * takes vma_start_write() on the VMA it touches, and faults wait on the
+ * migration entries -- but MADV_DONTNEED and MADV_FREE take a VMA read lock of
+ * their own, which ours does not exclude, so a concurrent zap may have taken
+ * frozen slots, and a fault may have refilled a zapped one.
  *
  * Slots still holding our entries are restored from the saved values (no TLB
  * flush: identical translation).  Foreign slots are left exactly as found --
@@ -1500,8 +1503,8 @@ static bool collapse_verify_candidate(struct collapse_candidate *cand,
  * The PMD terminal layer: verify, detach the table, deposit a fresh one and
  * install the leaf, as one atomic section under the pmd lock.  A pmd_none window
  * never exists -- faults stay held at pte level by the migration entries
- * throughout -- which is what lets PMD collapse run under mmap_read like the rest
- * of the engine.
+ * throughout -- which is what lets PMD collapse run under a VMA read lock like
+ * the rest of the engine.
  */
 static void collapse_install_pmd(struct vm_area_struct *vma,
 				 struct collapse_control *cc, pmd_t *pmd)
@@ -1571,8 +1574,8 @@ static void collapse_install_pmd(struct vm_area_struct *vma,
 	 * walks on the sources are unreachable -- refcounts frozen, folio locks
 	 * held from freeze to putback -- non-rmap pte walkers see migration
 	 * entries, pmd-level observers see the old table or the leaf and never an
-	 * intermediate, and fork, mremap and munmap take mmap_write, which our
-	 * mmap_read excludes.
+	 * intermediate, and fork, mremap and munmap take vma_start_write() on the
+	 * VMA they touch, which our VMA read lock excludes.
 	 *
 	 * The flush inside pmdp_collapse_flush() is the round's second over this
 	 * range: the freeze displaced every leaf here and flushed before dropping
@@ -1829,13 +1832,23 @@ static void collapse_round(struct mm_struct *mm, unsigned long pmd_addr,
 	collapse_reserve(mm, cc);
 	collapse_deposit(mm, cc);
 
+	/*
+	 * A read lock on the VMA rather than on the mm.  A round works inside one
+	 * VMA, and everything else it has to be excluded from -- fork, split,
+	 * merge, unmap, and the free_pgtables() that follows them -- takes
+	 * vma_start_write() on the VMA it touches first.  An mmap_write elsewhere
+	 * in the mm no longer waits behind a collapse.
+	 */
 retry:
-	mmap_read_lock(mm);
-
-	vma = find_vma(mm, pmd_addr);
+	vma = lock_vma_under_rcu(mm, pmd_addr);
 	if (!vma) {
-		result = SCAN_VMA_NULL;
-		goto out_unlock;
+		/*
+		 * Not only a VMA that has gone: lock_vma_under_rcu() also fails
+		 * on one being written to right now.  A caller cannot tell the
+		 * two apart, so say what is true of both -- try again.
+		 */
+		result = SCAN_VMA_LOCK;
+		goto out;
 	}
 
 	result = collapse_revalidate(vma, pmd_addr, cc, &pmd);
@@ -1852,7 +1865,7 @@ static void collapse_round(struct mm_struct *mm, unsigned long pmd_addr,
 	if (result == SCAN_LOCK_DROPPED && --passes)
 		goto retry;
 	if (result != SCAN_SUCCEED)
-		goto out;	/* the callee released mmap_lock */
+		goto out;	/* the callee released the VMA read lock */
 
 	/* One invalidate window spans the batch, as collapse_revalidate() left it */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
@@ -1882,7 +1895,7 @@ static void collapse_round(struct mm_struct *mm, unsigned long pmd_addr,
 	mmu_notifier_invalidate_range_end(&range);
 
 out_unlock:
-	mmap_read_unlock(mm);
+	vma_end_read(vma);
 out:
 	nr_installed = collapse_finish(mm, cc, result);
 	trace_mm_collapse_round(mm, cc->nr_candidates, nr_installed, result,
diff --git a/mm/collapse.h b/mm/collapse.h
index 74e513c5c76c..e5a0ffab049c 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -39,6 +39,7 @@ enum scan_result {
 	SCAN_PAGE_COMPOUND,
 	SCAN_ANY_PROCESS,
 	SCAN_VMA_NULL,
+	SCAN_VMA_LOCK,
 	SCAN_VMA_CHECK,
 	SCAN_ADDRESS_RANGE,
 	SCAN_DEL_PAGE_LRU,
diff --git a/mm/madvise.c b/mm/madvise.c
index c1bb425be3f4..bd9123ee3cb1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -933,6 +933,7 @@ static int madvise_collapse_errno(enum scan_result r)
 	case SCAN_PAGE_FILLED:
 	case SCAN_PAGE_HAS_PRIVATE:
 	case SCAN_PAGE_DIRTY_OR_WRITEBACK:
+	case SCAN_VMA_LOCK:
 		return -EAGAIN;
 	/*
 	 * Other: Trying again likely not to succeed / error intrinsic to
-- 
2.54.0

