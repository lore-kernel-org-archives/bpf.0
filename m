Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8773A2E2B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560757; cv=none; b=Qhu2N1eV7nyLQ2fpn8r8GAbZwwsDHy0/5+HXVZXVz0H3zgMdCxOt3XEpsghZOXxmftAtILYqHS9W55kNmHZClzsSgvgvilb5gzcGo1QK8bbjblUD+NaZuSpE5wlxhGtEUbMipxz+lG47ZTVlNWqDsPQJrOmBov/0SWNbf4iVIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560757; c=relaxed/simple;
	bh=1njyCI97mQgHujx4ZxP/EggIo2sx526M8cgC9mSdhy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBgPvIeyD3D6XjA1g3c1LMj2gXl63gm5Qov41ly6Zn7Tc1STkUrFbLhwOuqx/hfRnUlgcsYJ9MhogTswy7Xel8EN5a8iLt6uQz2CCDUJHb7a/NklZg5VuC9fPm2yV91cwefFQlv2z1uhHx/UgziRE+tv7vyatr6FbKXI03OfJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Doxy8Ff/; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Doxy8Ff/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1njyCI97mQgHujx4ZxP/EggIo2sx526M8cgC9mSdhy0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787560751; v=1; x=1788165551;
 b=Doxy8Ff/dKkJImOMLlf/srZ1ybW2gzK6bunjN3aIu6zecrR4JBqnEOmbf5kRaRvlB6uhdgZO
 SapxqFvE3cyNjTPZMxjUg7BQ6zUywHun537iQG5Iz3IKLUZiPwmqMe7ySjtM6605u/sZRXxjWcK
 coHQEt1puW5RxIBtGBmN3Hrk=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id 7d8e2a6175a77d65;
	Mon, 24 Aug 2026 08:39:11 +0000
X-Mizu-Trace-ID: 7d8e2a6175a77d65
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: kirill@shutemov.name
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	nico.pache@linux.dev,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
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
	bpf@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC PATCH 08/57] mm/collapse: scan a table for what a collapse could use
Date: Mon, 24 Aug 2026 16:39:03 +0800
Message-Id: <20260824083903.52962-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260816224609.308019-9-kirill@shutemov.name>
References: <20260816224609.308019-9-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Aug 16, 2026 at 11:45:20PM +0100, Kiryl Shutsemau wrote:
>From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
>Fill in the scan.  Walk the range and set a bit in cc->eligible_ptes for
>every PTE a collapse may take as a source: present, anonymous, not
>uffd-armed, on the LRU and unlocked.  The bit is set last, so a PTE that
>failed anything leaves it clear.
>
>The walk takes no page table lock.  What it produces is advice: the
>freeze settles every question the scan asks, by re-reading the table
>under the lock and freezing each source to the count it expects.  A racy
>read can only cost a candidate the freeze then refuses, or miss one the
>next pass finds.  What it buys is that a fault in the range does not wait
>for a walk of the whole table.
>
>pte_offset_map() holds rcu_read_lock() until pte_unmap(), which keeps the
>table from being freed underneath the walk.  mmap_lock keeps the VMA
>attached, without which free_pgtables() could free it without waiting for
>RCU at all.
>
>The verdict is two-sided, which is the point:
>
> - A PTE that disqualifies only itself leaves the bitmap clear there and
>   drops the PMD order, since a PMD candidate needs the whole table.
>   Selection still gets the smaller windows that avoid it.
> - What refuses the table as a unit -- a limit the whole range exceeds,
>   or sources spread across nodes too distant for one folio to serve --
>   leaves no order eligible at all.
>
>Limits on swapped-out and shared PTEs are stated per PMD and scaled to
>what was actually scanned, so a partial table is held to the same density
>as a whole one.
>
>A folio whose reference count its mappings do not account for -- a GUP
>pin, say -- is left to the freeze rather than refused here.
>folio_expected_ref_count() wants a folio that cannot change order while
>it is read.  This walk holds no page table lock and no folio lock, so a
>folio splitting underneath it would have its count read for the wrong
>size.  A reference of its own would not help: that stops a folio being
>freed, not split.
>
>Whether a range has to look used at all is the caller's policy, so only a
>caller that asks gathers the young/referenced evidence.
>
>Assisted-by: Claude-Code:claude-opus-5
>Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>---
> mm/collapse.c   | 239 +++++++++++++++++++++++++++++++++++++++++++++++-
> mm/collapse.h   |   7 ++
> mm/khugepaged.c |   8 +-
> 3 files changed, 249 insertions(+), 5 deletions(-)
>
>diff --git a/mm/collapse.c b/mm/collapse.c
>index 0e6c3c68b44c..66931ef6a6d0 100644
>--- a/mm/collapse.c
>+++ b/mm/collapse.c
>@@ -86,6 +86,20 @@
>  * replaces, and is switched over once both halves are complete.
>  */
> 
>+/*
>+ * Is @count past a limit stated per PMD, when only part of a table was scanned?
>+ * Scale the comparison to the table so a partial scan is held to the same
>+ * density as a whole one.
>+ */
>+static bool collapse_exceeds_limit(unsigned int count, unsigned int max_per_pmd,
>+				   unsigned long start, unsigned long end)
>+{
>+	const unsigned long nr_scanned = (end - start) >> PAGE_SHIFT;
>+
>+	return (unsigned long)count * HPAGE_PMD_NR >
>+	       (unsigned long)max_per_pmd * nr_scanned;
>+}
>+
> /*
>  * Scan the PTEs between @start and @end and record what a collapse could use: a
>  * bit in cc->eligible_ptes for every PTE that may be a source.  Returns
>@@ -97,7 +111,230 @@ static enum scan_result collapse_scan_table(struct vm_area_struct *vma,
> 					    unsigned long end,
> 					    struct collapse_control *cc)
> {
>-	return SCAN_SUCCEED;
>+	const unsigned long pmd_addr = start & HPAGE_PMD_MASK;
>+	unsigned int max_ptes_none, max_ptes_swap, max_ptes_shared;
>+	int none_or_zero = 0, shared = 0, referenced = 0, unmapped = 0;
>+	enum scan_result result, pmd_result = SCAN_SUCCEED;
>+	unsigned int first_offset;
>+	unsigned long addr;
>+	pte_t *pte;
>+	int i;
>+
>+	max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
>+	max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
>+	max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
>+
>+	/*
>+	 * No page table lock: what this builds is advice, and the freeze settles
>+	 * every question it asks by re-reading the table under the lock and
>+	 * freezing each source to the count it expects.  A racy read can only
>+	 * cost a candidate that the freeze then refuses, or miss one that the
>+	 * next pass finds.  What it buys is that a fault in this range does not
>+	 * wait for a scan of the whole table.
>+	 *
>+	 * pte_offset_map() holds rcu_read_lock() until pte_unmap(), which is
>+	 * what keeps the table itself from being freed underneath the walk;
>+	 * mmap_lock keeps the VMA attached, without which free_pgtables() could
>+	 * free it without waiting for RCU at all.  Nothing below here sleeps.
>+	 */
>+	pte = pte_offset_map(pmd, start);
>+	if (!pte) {
>+		cc->progress++;
>+		result = SCAN_NO_PTE_TABLE;
>+		goto out_no_table;
>+	}
>+
>+	/*
>+	 * The bitmap and the selection offsets stay relative to the table:
>+	 * natural-alignment math needs the table-absolute position, not the
>+	 * position within an arbitrarily placed VMA.
>+	 */
>+	first_offset = (start - pmd_addr) >> PAGE_SHIFT;
>+	for (i = first_offset, addr = start; addr < end;
>+	     i++, addr += PAGE_SIZE) {
>+		pte_t pteval = ptep_get(pte + (i - first_offset));

Hmm, ptep_get() does not look right for a lockless scan ...

On arm64, a contiguous PTE sends ptep_get() to contpte_ptep_get():

static inline pte_t ptep_get(pte_t *ptep)
{
...
	if (likely(!pte_valid_cont(pte)))
		return pte;

	return contpte_ptep_get(ptep, pte);
}

contpte_ptep_get() explicitly assumes PTL is held and therefore has no
consistency retry:

pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
{
	/*
	 * Gather access/dirty bits, which may be populated in any of the ptes
	 * of the contig range. We are guaranteed to be holding the PTL, so any
	 * contiguous range cannot be unfolded or otherwise modified under our
	 * feet.
	 */
...
}

The lockless accessor uses the matching implementation:

static inline pte_t ptep_get_lockless(pte_t *ptep)
{
...
	if (likely(!pte_valid_cont(pte)))
		return pte;

	return contpte_ptep_get_lockless(ptep);
}

pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
{
	/*
	 * The ptep_get_lockless() API requires us to read and return *orig_ptep
	 * so that it is self-consistent, without the PTL held, so we may be
	 * racing with other threads modifying the pte. Usually a READ_ONCE()
...
	 * and we can't read all of those neighbouring ptes atomically, so any
	 * contiguous range may be unfolded/modified/refolded under our feet.
	 * Therefore we ensure we read a _consistent_ contpte range by checking
	 * that all ptes in the range are valid and have CONT_PTE set, that all
	 * pfns are contiguous and that all pgprots are the same (ignoring
	 * access/dirty). If we find a pte that is not consistent, then we must
	 * be racing with an update so start again. If the target pte does not
...
	 */
...
retry:
	orig_pte = __ptep_get(orig_ptep);

	if (!pte_valid_cont(orig_pte))
		return orig_pte;
...
	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
		pte = __ptep_get(ptep);

		if (!contpte_is_consistent(pte, pfn, orig_prot))
			goto retry;
...
}

The later freeze can reject a stale candidate, but the earlier PTE read
is still lockless. Should the read use ptep_get_lockless() so arm64 can
retry if it finds an inconsistent PTE in the contpte range?

Cheers, Lance


>+		struct folio *folio;
>+		struct page *page;
>+		int node;
>+
>+		cc->progress++;
>+
>+		if (pte_none_or_zero(pteval)) {
>+			if (++none_or_zero > max_ptes_none &&
>+			    pmd_result == SCAN_SUCCEED) {
>+				pmd_result = SCAN_EXCEED_NONE_PTE;
>+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>+				count_mthp_stat(HPAGE_PMD_ORDER,
>+						MTHP_STAT_COLLAPSE_EXCEED_NONE);
>+			}
>+			continue;
>+		}
>+		if (!pte_present(pteval)) {
>+			unmapped++;
>+			if (collapse_exceeds_limit(unmapped, max_ptes_swap,
>+						   start, end)) {
>+				result = SCAN_EXCEED_SWAP_PTE;
>+				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>+				count_mthp_stat(HPAGE_PMD_ORDER,
>+						MTHP_STAT_COLLAPSE_EXCEED_SWAP);
>+				goto out_table_refused;
>+			}
>+			/* Swap entries armed with uffd-wp are refused too */
>+			if (pte_swp_uffd_any(pteval) &&
>+			    pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PTE_UFFD;
>+			continue;
>+		}
>+		if (pte_uffd(pteval)) {
>+			/*
>+			 * The huge PMD could be marked write protected when any
>+			 * of the small ones is, but that could deliver
>+			 * userfaults outside the registered range.  Keep it
>+			 * simple and refuse the PTE.
>+			 */
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PTE_UFFD;
>+			continue;
>+		}
>+
>+		page = vm_normal_page(vma, addr, pteval);
>+		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PAGE_NULL;
>+			continue;
>+		}
>+		folio = page_folio(page);
>+
>+		/*
>+		 * A VM_DROPPABLE VMA keeps the lazyfree property across the
>+		 * collapse, so there is nothing to preserve by skipping.
>+		 */
>+		if (cc->policy.skip_lazyfree &&
>+		    !(vma->vm_flags & VM_DROPPABLE) &&
>+		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PAGE_LAZYFREE;
>+			continue;
>+		}
>+
>+		if (!folio_test_anon(folio)) {
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PAGE_ANON;
>+			continue;
>+		}
>+
>+		/*
>+		 * A page counts as shared if any part of its folio is, which
>+		 * bounds the cost of CoW-breaking rather than the count of it:
>+		 * collapse_faultin() unshares on !PageAnonExclusive(), a broader
>+		 * test -- a page whose fork co-mapper has exited is
>+		 * single-mapped, so not counted here, yet stays non-exclusive
>+		 * until a write reuses it.  Those are the cheap ones, reused in
>+		 * place.  A page that has to be copied is one this test catches,
>+		 * so the limit does bound the copying it is there to bound.
>+		 */
>+		if (folio_maybe_mapped_shared(folio)) {
>+			shared++;
>+			if (collapse_exceeds_limit(shared, max_ptes_shared,
>+						   start, end)) {
>+				result = SCAN_EXCEED_SHARED_PTE;
>+				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>+				count_mthp_stat(HPAGE_PMD_ORDER,
>+						MTHP_STAT_COLLAPSE_EXCEED_SHARED);
>+				goto out_table_refused;
>+			}
>+		}
>+
>+		/*
>+		 * Which node the sources are on decides where the destination is
>+		 * allocated: the one with the most of them wins.
>+		 */
>+		node = folio_nid(folio);
>+		if (collapse_scan_abort(node, cc)) {
>+			result = SCAN_SCAN_ABORT;
>+			goto out_table_refused;
>+		}
>+		cc->node_load[node]++;
>+
>+		/*
>+		 * Usually a folio somebody else is already isolating, whose
>+		 * reference the freeze would refuse anyway.  Not exact: one
>+		 * still on a per-CPU add batch reads the same, and the freeze
>+		 * drains those before it starts.
>+		 */
>+		if (!folio_test_lru(folio)) {
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PAGE_LRU;
>+			continue;
>+		}
>+		if (folio_test_locked(folio)) {
>+			if (pmd_result == SCAN_SUCCEED)
>+				pmd_result = SCAN_PAGE_LOCK;
>+			continue;
>+		}
>+
>+		/*
>+		 * A folio whose reference count its mappings do not account for
>+		 * -- a GUP pin, say -- is refused by the freeze, not here.
>+		 * folio_expected_ref_count() wants a folio that cannot change
>+		 * order while it is read, and this walk holds no page table lock
>+		 * and no folio lock, so a folio splitting underneath it would
>+		 * have the count read for the wrong size.  A reference of our
>+		 * own would not help: it stops the folio being freed, not split.
>+		 *
>+		 * So leave it to the freeze, which reads the table under the
>+		 * lock and settles the question by freezing each source to the
>+		 * count it expects.  What it costs is a window selected here and
>+		 * refused there.
>+		 */
>+
>+		/*
>+		 * Every check passed: this PTE can be a collapse source.  The
>+		 * bit is set last, so a disqualified PTE leaves it clear.
>+		 */
>+		__set_bit(i, cc->eligible_ptes);
>+
>+		/*
>+		 * Whether a range has to look used at all is the caller's
>+		 * policy, so only a caller that asks gathers the evidence.
>+		 */
>+		if (cc->policy.require_referenced &&
>+		    (pte_young(pteval) || folio_test_young(folio) ||
>+		     folio_test_referenced(folio) ||
>+		     mmu_notifier_test_young(vma->vm_mm, addr)))
>+			referenced++;
>+	}
>+
>+	if (cc->policy.require_referenced &&
>+	    (!referenced || (unmapped && referenced < HPAGE_PMD_NR / 2)))
>+		result = SCAN_LACK_REFERENCED_PAGE;
>+	else
>+		result = pmd_result;
>+	pte_unmap(pte);
>+	goto out;
>+
>+out_table_refused:
>+	/*
>+	 * The table is refused as a unit -- a limit the whole range exceeds, or
>+	 * pages on nodes too distant for one folio to serve them all -- so no
>+	 * window inside it is eligible either.
>+	 */
>+	pte_unmap(pte);
>+out_no_table:
>+	cc->select_orders = 0;
>+out:
>+	/*
>+	 * A PMD candidate needs the whole table, so anything that disqualified a
>+	 * single PTE rules it out.  Smaller windows that avoid the offending
>+	 * PTEs are still collapsible, so drop just that order and leave the rest
>+	 * to selection -- dropping it also lowers the order selection roots its
>+	 * windows at.  MADV_COLLAPSE has no other order enabled, so it is left
>+	 * with none.
>+	 */
>+	if (result != SCAN_SUCCEED)
>+		cc->select_orders &= ~BIT(HPAGE_PMD_ORDER);
>+
>+	return result;
> }
> 
> /* Everything a table is judged on starts empty for each table */
>diff --git a/mm/collapse.h b/mm/collapse.h
>index e2af4c47cb60..ad88b91d9a72 100644
>--- a/mm/collapse.h
>+++ b/mm/collapse.h
>@@ -130,5 +130,12 @@ unsigned long collapse_possible_orders(struct vm_area_struct *vma,
> 		vm_flags_t vm_flags, enum tva_type tva_flags);
> enum scan_result find_pmd_or_thp_or_none(struct mm_struct *mm,
> 		unsigned long address, pmd_t **pmd);
>+bool collapse_scan_abort(int nid, struct collapse_control *cc);
>+unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>+		struct vm_area_struct *vma, unsigned int order);
>+unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
>+		unsigned int order);
>+unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
>+		unsigned int order);
> 
> #endif	/* __MM_COLLAPSE_H */
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 26d25093260b..9823884a83c9 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -305,7 +305,7 @@ struct attribute_group khugepaged_attr_group = {
>  *
>  * Return: Maximum number of empty/shared zeropage PTEs for the collapse operation
>  */
>-static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>+unsigned int collapse_max_ptes_none(struct collapse_control *cc,
> 		struct vm_area_struct *vma, unsigned int order)
> {
> 	const unsigned int max_ptes_none = cc->policy.max_ptes_none;
>@@ -341,7 +341,7 @@ static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>  * Return: Maximum number of PTEs that map shared anonymous pages for the
>  * collapse operation
>  */
>-static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
>+unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
> 		unsigned int order)
> {
> 	/*
>@@ -362,7 +362,7 @@ static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
>  * Return: Maximum number of non-present PTEs or the maximum allowed non-present
>  * pagecache entries for the collapse operation.
>  */
>-static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
>+unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
> 		unsigned int order)
> {
> 	/*
>@@ -934,7 +934,7 @@ static struct collapse_control khugepaged_collapse_control = {
> 	.is_khugepaged = true,
> };
> 
>-static bool collapse_scan_abort(int nid, struct collapse_control *cc)
>+bool collapse_scan_abort(int nid, struct collapse_control *cc)
> {
> 	int i;
> 
>-- 
>2.54.0
>
>
