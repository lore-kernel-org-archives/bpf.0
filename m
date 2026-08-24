Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244E42125A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577156; cv=none; b=YyYVsE6nf9StCu4Q1WDbcMCOWsiCtH5TEaBZQPi25o5FiEg0hIwchn/NDaiF6xo9NwzJrWakF3o68aneX0R57Xv5ZGzwhB2TCl+6otoaC+BWNxf3TylJcEF+s5bMeGH+wTw1IOVRgVibvRUOiATEWYECDdVZaTW9QHrlTdjXk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577156; c=relaxed/simple;
	bh=/b5A6pKJXdJDFq/apoa26JYD1JiLS7wRusBfDVE9t8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y368UltrYHjK0SvAAhakPqpaENLb/3TWa8gCzGkt3tBDKToUh9GJ4TaPbF67yzNlWyKkcw1tiE80BzbVdk75utbSoVEqbbu44QrGqEvlHW4MpZ9M1k/yivYkpg9ZrVlWDtglW7Jbu9BxtJi/PDvwpSsw7uzrK1bS6gGBVa0w2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BOoEAsLQ; arc=none smtp.client-ip=95.215.58.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BOoEAsLQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/b5A6pKJXdJDFq/apoa26JYD1JiLS7wRusBfDVE9t8A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787577152; v=1; x=1788181952;
 b=BOoEAsLQzmYT5bu8nMEdHCRy4VSguhfQDyPBJVE08HYsAbcPlwtozpevsCGaw0BmAWqGImn7
 AU0stAAd9jWj1TN8fShNItWqm8sIy0sP8mZ5iVm7oU3ymin3EQBGctmsWLcDkGNhQmhJT5R2prP
 xdKZGsGtcsafYgphfDWmYcsU=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id c9d12fd6d0b2f922;
	Mon, 24 Aug 2026 13:12:32 +0000
X-Mizu-Trace-ID: c9d12fd6d0b2f922
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
Subject: Re: [RFC PATCH 16/57] mm/collapse: freeze the sources behind migration entries
Date: Mon, 24 Aug 2026 21:12:24 +0800
Message-Id: <20260824131224.73344-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260816224609.308019-17-kirill@shutemov.name>
References: <20260816224609.308019-17-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Aug 16, 2026 at 11:45:28PM +0100, Kiryl Shutsemau wrote:
>From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
[...]
>+static enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
>+		struct collapse_candidate *cand, pte_t *pte)
>+{
>+	const unsigned int nr_pages = candidate_nr_pages(cand);
>+	unsigned int nr_saved = 0, nr_frozen = 0;
>+	enum scan_result result;
>+	struct folio *folio;
>+	unsigned long addr;
>+	unsigned int i;
>+
>+	for (i = 0, addr = cand->addr; i < nr_pages;) {
>+		pte_t ptent = ptep_get(pte + i);
>+		unsigned int nr, nr_max, k;
>+		pte_t rep;
>+
>+		if (pte_none(ptent)) {
>+			/* Hole: nothing to freeze; install verifies it stayed one */
>+			cand->saved_ptes[i] = ptent;
>+			nr_saved = ++i;
>+			addr += PAGE_SIZE;
>+			continue;
>+		}
>+		if (is_zero_pfn(pte_pfn(ptent))) {
>+			/*
>+			 * Clear the zeropage mapping now, covered by the round's
>+			 * ranged flush: overwriting a live PTE at install would
>+			 * be a valid->valid transition, breaking arm64's
>+			 * break-before-make.  The zeropage has neither rmap nor
>+			 * per-map references -- the saved value alone undoes it.
>+			 */
>+			cand->saved_ptes[i] =
>+				ptep_get_and_clear(mm, addr, pte + i);
>+			nr_saved = ++i;
>+			addr += PAGE_SIZE;
>+			continue;
>+		}
>+
>+		folio = pte_folio(ptent);
>+
>+		/*
>+		 * A folio revisited by a second span of this round is already
>+		 * ours and frozen at its first span: folio_get() on a zero count
>+		 * is a bug, and try-get fails cleanly.  Scrambled layouts
>+		 * (mremap) construct this; nothing else can hold a folio frozen
>+		 * while its PTE is live under our ptl, so it is not transient.
>+		 */
>+		if (!folio_try_get(folio)) {
>+			result = SCAN_PAGE_COUNT;
>+			goto unfreeze;
>+		}
>+		if (!folio_trylock(folio)) {
>+			folio_put(folio);
>+			result = SCAN_PAGE_LOCK;
>+			goto unfreeze;
>+		}
>+
>+		/*
>+		 * Never freeze a folio under writeback.  PG_writeback holds no
>+		 * reference of its own -- the swapcache reference keeps the folio
>+		 * alive, and everything that would drop it waits for the flag --
>+		 * so folio_end_writeback() plain folio_get()s a folio it may
>+		 * assume is alive: a BUG on a frozen one, or with
>+		 * CONFIG_DEBUG_VM off, a free under our copy.
>+		 *
>+		 * Unlike every other hazard here, the freeze does not catch it.
>+		 * folio_expected_ref_count() counts the swapcache reference, so
>+		 * the count is exactly right and the freeze succeeds.  Nor can
>+		 * "is it in the swapcache" stand in for this test: that would
>+		 * refuse the pages the fault-in pass just swapped in.
>+		 *
>+		 * Reachable even though writeback starts on an unmapped folio: a
>+		 * re-fault from the swapcache maps it back before the bio
>+		 * completes, and folio_free_swap() will not drop the cache entry
>+		 * under writeback.  Testing once is enough -- writeback starts
>+		 * only under the folio lock, which we hold from here through
>+		 * putback.
>+		 */
>+		if (folio_test_writeback(folio)) {
>+			folio_unlock(folio);
>+			folio_put(folio);
>+			result = SCAN_PAGE_DIRTY_OR_WRITEBACK;
>+			goto unfreeze;
>+		}
>+
>+		/* Each slot's own value: a span agrees on the PFN, not the rest */
>+		cand->saved_ptes[i] = ptent;
>+		nr_max = collapse_span_max(ptent, nr_pages - i);
>+		for (nr = 1; nr < nr_max; nr++) {
>+			pte_t tail = ptep_get(pte + i + nr);
>+
>+			if (!pte_present(tail) ||
>+			    pte_pfn(tail) != pte_pfn(ptent) + nr)
>+				break;
>+			cand->saved_ptes[i + nr] = tail;
>+		}
>+
>+		/*
>+		 * The clear is the GUP-fast linearization point: a grab landing
>+		 * before it elevates the refcount and the freeze below fails
>+		 * (the candidate unfreezes); one landing after fails its PTE
>+		 * re-read and retries.  Clear and store sit adjacent under one
>+		 * uninterrupted ptl hold, batched per span
>+		 * (get_and_clear_full_ptes() unfolds contpte), so the transient
>+		 * none window is invisible to installers, which all take the ptl.
>+		 */
>+		rep = get_and_clear_full_ptes(mm, addr, pte + i, nr, 0);
>+
>+		/*
>+		 * Dirty from the clear -- including any the hardware set since
>+		 * the reads above -- goes to the folio, the way unmap does,
>+		 * rather than onto PTEs that never had it.  Young needs no such
>+		 * care: a migration entry drops it either way.
>+		 */
>+		if (pte_dirty(rep))
>+			folio_mark_dirty(folio);
>+
>+		for (k = 0; k < nr; k++) {
>+			pte_t saved = cand->saved_ptes[i + k];
>+			swp_entry_t entry;
>+			pte_t swp_pte;
>+
>+			entry = make_readable_migration_entry(pte_pfn(saved));
>+			swp_pte = swp_entry_to_pte(entry);
>+			if (pte_soft_dirty(saved))
>+				swp_pte = pte_swp_mksoft_dirty(swp_pte);
>+			set_pte_at(mm, addr + k * PAGE_SIZE, pte + i + k,
>+				   swp_pte);
>+		}
>+		nr_saved = i + nr;
>+
>+		if (!folio_ref_freeze(folio,
>+				      folio_expected_ref_count(folio) + 1)) {
>+			result = SCAN_PAGE_COUNT;
>+			goto unfreeze;
>+		}
>+		nr_frozen = nr_saved;

Just one thing I was wondering about ... can deferred_split_isolate()
remove a source folio from deferred_split_lru while its refcount is
frozen by collapse_freeze_candidate()?

Assume an earlier span belongs to an anonymous large folio on the
deferred split queue, then a later span fails folio_trylock().
collapse_freeze_candidate() continues after freezing each source folio
and calls collapse_unfreeze_candidate() on a later failure:

static noinline enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
		struct collapse_candidate *cand, pte_t *pte)
{
...
	for (i = 0, addr = cand->addr; i < nr_pages;) {
...
		if (!folio_trylock(folio)) {
			folio_put(folio);
			result = SCAN_PAGE_LOCK;
			goto unfreeze;
		}
...
		nr_saved = i + nr;

		if (!folio_ref_freeze(folio,
				      folio_expected_ref_count(folio) + 1)) {
			result = SCAN_PAGE_COUNT;
			goto unfreeze;
		}
		nr_frozen = nr_saved;

		i += nr;
		addr += nr * PAGE_SIZE;
	}

...
unfreeze:
	collapse_unfreeze_candidate(mm, cand, pte, nr_saved, nr_frozen);
	return result;
}

folio_ref_freeze() takes the source folio's refcount to zero:

static inline int folio_ref_freeze(struct folio *folio, int count)
{
	return page_ref_freeze(&folio->page, count);
}

static inline int page_ref_freeze(struct page *page, int count)
{
	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);

...
	return ret;
}

While collapse_freeze_candidate() still holds the source folio lock,
deferred_split_scan() can call deferred_split_isolate():

static unsigned long deferred_split_scan(struct shrinker *shrink,
		struct shrink_control *sc)
{
	LIST_HEAD(dispose);
	struct folio *folio, *next;
	int split = 0;
	unsigned long isolated;

	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
					    deferred_split_isolate, &dispose);
}

static enum lru_status deferred_split_isolate(struct list_head *item,
					      struct list_lru_one *lru,
					      void *cb_arg)
{
	struct folio *folio = container_of(item, struct folio, _deferred_list);
	struct list_head *freeable = cb_arg;

	if (folio_try_get(folio)) {
		list_lru_isolate_move(lru, item, freeable);
		return LRU_REMOVED;
	}

	/*
	 * We lost race with folio_put(). Read folio state before the
	 * isolate: folio_unqueue_deferred_split() checks list_empty()
	 * locklessly, so once removed the folio can be freed any time.
	 */
	if (folio_test_partially_mapped(folio)) {
		folio_clear_partially_mapped(folio);
		mod_mthp_stat(folio_order(folio),
			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
	}
	list_lru_isolate(lru, item);
	return LRU_REMOVED;
}

And folio_try_get() fails because the source folio has a frozen refcount.
deferred_split_isolate() treats the failure as a race with folio_put(),
clears PG_partially_mapped and its MTHP_STAT_NR_ANON_PARTIALLY_MAPPED
accounting when set, then removes the folio from deferred_split_lru ...

>+
>+		i += nr;
>+		addr += nr * PAGE_SIZE;
>+	}
>+
>+	cand->state = CAND_FROZEN;
>+	return SCAN_SUCCEED;
>+
>+unfreeze:
>+	collapse_unfreeze_candidate(mm, cand, pte, nr_saved, nr_frozen);
>+	return result;

And collapse_unfreeze_candidate() restores the source PTEs and refcount,
then unlocks and puts the source folio :)

The source folio is not added back to the deferred split queue, so an
underused or partially mapped folio can remain off the queue.

Should collapse unqueue the source folio after folio_ref_freeze()
succeeds, remember whether it was on the deferred split queue and whether
PG_partially_mapped was set, then requeue it if
collapse_unfreeze_candidate() restores the source folio?

[...]

Cheers, Lance
