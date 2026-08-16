Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F53EE1EA;
	Sun, 16 Aug 2026 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920410; cv=none; b=FZQw/CfDJN8GhA5W9HZseqJw3nquWsUsP9JQc02lcd1kqWaMDi9iYnjwJGzrCWeG5vQDaso3Mi54+MmLhB9wu+A17o21NFTKqDawwcqkEqZLQd+vpu85DO4jvGUjdzmIOPTEqiyyNiUoNL4iBISc+UjbO5xaA5ANwMjd0yyw7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920410; c=relaxed/simple;
	bh=0HtoTUgdKn4MCSLvYCOYck5ILC37qSnuMNZoMgnMGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiTJkJ6Wmvhb+vKKdrN3NOfOL2VgkXEKxYzSXxnFGI+KdhFaPdUSTXAL7uElXKLKa9ANuPnQpLUjXGv41XVVAD5PMudNuHqkfM7m8LNbFMsni++rjd9dMFNGchTYrYUKe7w/RU8spDxOGiWlypLqPRo3b+x3kNpa4CwuD1Epnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=u2eiQZS+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MorGnxWR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="u2eiQZS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MorGnxWR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2012814000FB;
	Sun, 16 Aug 2026 18:46:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 18:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920408; x=
	1787006808; bh=rUR3Zpc/XHDoRz+IWnP+uEJLJCI5tm2EqK26zu94310=; b=u
	2eiQZS+PPcnEmgXisrRYA6y9wwXZOsne4YxKehtUO3tQk3gZLV5Uqbmm8zPeW72v
	ycl5cv/UWjL+l1OglOPprBxLB6LbFW/UNZLzaHNDQY2C+IimYiVcYleAX10hq1vR
	2Ro2s5VBVSs71o46dPqcocLLQn4/OglqLYNoZ9xFpwmpf0v2bMdg0o/8UNWN5+XX
	WK494ewheYgmhL284NzvvHrek66pOVjDnufTOnOOoPQJO26UbBPSccDPAajf+PMq
	TjtMeKxRpvEhO+MzLM3RvryGrk9egyKNVmST/6HgP1UL2VjVmEWN0JiE1uq5ogHT
	pOS+/jCAxNrh1Y9NUppRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920408; x=1787006808; bh=r
	UR3Zpc/XHDoRz+IWnP+uEJLJCI5tm2EqK26zu94310=; b=MorGnxWRAxibSJlMq
	CuFoPjBKqc9op52AmmngkdTrU5U13L6qUMiC7OGDS0Abr0MvAavpBbH4wC1asHAd
	xOqiF4n6Pb2hZlZXUO4aCQJ/oP8N5r5yMVvvdM6rmwc8PS35dlh0NOUbK3Hm1+ua
	W59YwUdgcKCryrzT8giPQ88sqxPniiOPdq6ZtAmVnpAgGOQ3cu5ko21eO7BPNy+2
	ii603Z6dtn47t80Q+8irE5o6H+NS8rtXCIXafEBGzC1e8xlGOnZKVGGaPQse7Ozu
	fYL2zNBZ+iCNfJldyQyhniN1u8ZzY5gwKVByvy/vhKF9mGYIFBWIX4d+7mAoSOve
	96hQQ==
X-ME-Sender: <xms:2D2Caksjm-i003RTXK--vFUV_kCVuZkIhs89kKotnoNhalqIdz4SvA>
    <xme:2D2CamyeWsnS1_ujP13XBA-0MlcgUeoh5dt8PScEL47mZoj_6ANiS8cWwMkSo3CaG
    UDj6f0wCRGDyMMQugdzsh3Twlz2lREuIOGAKS05uf6j-d5PPbx_7E0U>
X-ME-Received: <xmr:2D2Car1zSDZj1qFD_Vh3Z_7kwhMbsUUOBxscB_tgzBPzNSCSDeXuw1fOzNk>
X-ME-Proxy-Cause: dmFkZTGU6CsvhMdBtF1sno4coJRY9LqZz27w5X62/KcvcmaHPoOW0E1BwYMGQvImxADkeF
    Vrd/NWvQclh95CfVK4mxB+x5IwibSBkynFlxvp5GF5/z4jepOu57IyLHUvB8DzXymwpMun
    cyoWwWLP4hjAaD7bSTsoDmYKe03ryBERSg0IuR8ZqJolHrsaFnqWf5mL2byVsL9qLL9zPI
    9yLFlvwwZlCiJbT4IVFlRVV/9A2lZNuDFrGWvpQWw3cjqX9EcFrpnMQcn/0MdQygQWXSYC
    yXHZy2pRvgBssh5qObsL1GM1XSEE6m2uHX2m5CwJlvTSIfOodU1appS1XFI/CBVlhtQ7Np
    6woFLzhF1hDHTk9QeVB0U2SY8KNjMUPT0K/OFRCJ5NqYQs5V8G3gGWet0vT437YNR6DToW
    /gIXHEXzbuC4u+J7MRVGXHvi6R37UNnaUIBS1CWMVm3C9IWXgDMNOz1H19R6kIfoYFHHNM
    WnDie5YX6XYhQ12+CGbhXjbEWTvlVvRGLTpuTDTSL8zLja5nBpRTet3lSYowUoPCOAdex6
    zpObjG0Nn4tYu6EmkcOqvXVkDv9wJkReKSomq/wNVDF7nLboDGymkyErZb9niUdqfxvI6g
    LV1S6ltfp5cEKg49QpYiq0df5oTJC9zv+GRSx7+nPicgLRGUqtfWdxfHONDA
X-ME-Proxy: <xmx:2D2Cajz4nao0D53Q47p5IOyawFsSNKgLrUArgLZoNEVtRCrrcYyHaA>
    <xmx:2D2CarPa-XAQqXny2AMW_7CYnZoPwTnziuiAQ6P4euwfi_sb4Y1A7w>
    <xmx:2D2Cao4O5HtLfc7RVBewK1wnmuyD_MtdSlZ0w7uG4QvWBUzdnyeXnw>
    <xmx:2D2Caicb3pCxOoP620Rkbdh7e5li5HCo4wXcRzRc4gf-v5y7siziLA>
    <xmx:2D2Cakgt8o31aVieqbUx6QtMMo2f8vpUNUpfFwvcoidepxQTiQAWpq5b>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:47 -0400 (EDT)
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
Subject: [RFC PATCH 15/57] mm/collapse: check what a candidate would freeze
Date: Sun, 16 Aug 2026 23:45:27 +0100
Message-ID: <20260816224609.308019-16-kirill@shutemov.name>
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

The freeze takes folio locks, rewrites PTEs and flushes the TLB, and any
of that has to be undone slot by slot if the candidate turns out unfit --
while faulters on those sources wait.  So it decides first and acts
second.

This is the deciding half: walk every slot a candidate covers, under the
table's ptl, and answer whether all of it can be frozen.  It touches
nothing, so a refusal costs the round only the walk.

The walk goes in source spans, a span being consecutive PTEs mapping
consecutive pages of one folio.  No layout is refused for its shape:
where a span ends, the next slot starts one of its own, which is what
lets partially mapped and compound sources collapse.  A slot may also be
a hole or the zeropage, both of which the destination just zero-fills.

What a span has to satisfy, beyond being present, anonymous and not
uffd-armed:

 - Every live mapping of its folio is this span.  The freeze is
   whole-folio, so a live PTE anywhere else would race a zap whose
   folio_put() underflows the frozen count.  Under the ptl this is exact,
   since fork -- the only way an exclusive anon folio gains mappings --
   takes mmap_write.

 - Every page of it is PageAnonExclusive().  A shared folio has no
   refcount the freeze can pin down without the other mappers' ptls.

 - It is not MADV_FREE'd, unless the caller asked for the collapse.
   Copying a lazyfree page into a folio that is not lazyfree would quietly
   make memory the user offered up undroppable again, which is why the
   policy carries that choice.

Sub-PMD candidates also refuse folios already at or above their own order,
there being nothing to gain; a PMD candidate takes them, that being the
PTE-mapped-THP re-collapse case.

SCAN_PAGE_NOT_EXCLUSIVE joins enum scan_result and the trace symbol list.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/trace/events/huge_memory.h |   1 +
 mm/collapse.c                      | 177 +++++++++++++++++++++++++++++
 mm/collapse.h                      |   1 +
 3 files changed, 179 insertions(+)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 68693eba82ef..ff938ac9c43c 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -41,6 +41,7 @@
 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
 	EM( SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
+	EM( SCAN_PAGE_NOT_EXCLUSIVE,	"page_not_exclusive")		\
 	EMe(SCAN_ALLOC_LIGHT_MISS,	"alloc_light_miss")
 
 #undef EM
diff --git a/mm/collapse.c b/mm/collapse.c
index 4ec02071f588..c75d91cb9d48 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -386,6 +386,145 @@ static enum scan_result collapse_faultin(struct vm_area_struct *vma,
 	return result;
 }
 
+/*
+ * How many slots a source span starting at @first may cover: the pages left in
+ * its folio, capped at @max.  Every freeze-side walker bounds spans with this,
+ * so per-span batching of clears, locks and freezes cannot reach a slot the span
+ * does not cover.
+ */
+static unsigned int collapse_span_max(pte_t first, unsigned int max)
+{
+	struct page *page = pte_page(first);
+	struct folio *folio = page_folio(page);
+	unsigned int left = folio_nr_pages(folio) - folio_page_idx(folio, page);
+
+	return min(max, left);
+}
+
+/*
+ * Can this candidate's sources be frozen?  Every slot is checked and nothing is
+ * touched, so a refusal costs the round nothing but the walk.
+ *
+ * The walk is in source spans: a span is consecutive PTEs mapping consecutive
+ * pages of one folio, and it ends wherever the next PTE stops being the folio's
+ * next page.  No layout is refused for its shape -- the next slot simply starts
+ * its own span -- so partially mapped and compound sources collapse too.
+ *
+ * Caller holds mmap_read and the table's ptl.
+ */
+static enum scan_result collapse_check_candidate(struct vm_area_struct *vma,
+						 struct collapse_control *cc,
+						 struct collapse_candidate *cand,
+						 pte_t *pte)
+{
+	const unsigned int nr_pages = candidate_nr_pages(cand);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0, addr = cand->addr; i < nr_pages;) {
+		pte_t ptent = ptep_get(pte + i);
+		unsigned int nr, nr_max, k;
+		struct folio *folio;
+		struct page *page;
+
+		if (!pte_present(ptent)) {
+			/* Holes are population; swap and markers are not */
+			if (pte_none(ptent)) {
+				i++;
+				addr += PAGE_SIZE;
+				continue;
+			}
+			return SCAN_PTE_NON_PRESENT;
+		}
+		if (pte_uffd(ptent))
+			return SCAN_PTE_UFFD;
+
+		/* The zeropage zero-fills like a hole, and has no normal page */
+		if (is_zero_pfn(pte_pfn(ptent))) {
+			i++;
+			addr += PAGE_SIZE;
+			continue;
+		}
+		page = vm_normal_page(vma, addr, ptent);
+		if (!page || unlikely(is_zone_device_page(page)))
+			return SCAN_PAGE_NULL;
+
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			return SCAN_PAGE_ANON;
+
+		/*
+		 * Collapsing a MADV_FREE'd page would copy it into a folio that
+		 * is not lazyfree, quietly making memory the user offered up
+		 * undroppable again.
+		 */
+		if (cc->policy.skip_lazyfree &&
+		    !(vma->vm_flags & VM_DROPPABLE) &&
+		    folio_test_lazyfree(folio) && !pte_dirty(ptent))
+			return SCAN_PAGE_LAZYFREE;
+
+		/*
+		 * A sub-PMD candidate refuses folios of its own order and above:
+		 * collapsing those would gain nothing.  A PMD candidate accepts
+		 * every order up to its own -- the PTE-mapped-THP re-collapse
+		 * class.
+		 */
+		if (folio_order(folio) >= cand->order &&
+		    !is_pmd_order(cand->order))
+			return SCAN_PTE_MAPPED_HUGEPAGE;
+
+		/*
+		 * Exclusive anon only: the expected refcount of a shared folio
+		 * cannot be pinned down without its other mappers' ptls.
+		 * Swapcache membership is fine -- folio_expected_ref_count()
+		 * accounts those references.
+		 */
+		if (folio_maybe_mapped_shared(folio))
+			return SCAN_PAGE_NOT_EXCLUSIVE;
+
+		nr_max = collapse_span_max(ptent, nr_pages - i);
+		for (nr = 1; nr < nr_max; nr++) {
+			pte_t tail = ptep_get(pte + i + nr);
+
+			if (!pte_present(tail) ||
+			    pte_pfn(tail) != pte_pfn(ptent) + nr)
+				break;
+			if (pte_uffd(tail))
+				return SCAN_PTE_UFFD;
+		}
+
+		/*
+		 * Every live mapping of the folio must be this span: the freeze
+		 * is whole-folio, and a live PTE left anywhere else loses to a
+		 * racing zap -- its rmap drop is paired with a folio_put() that
+		 * would underflow the frozen count.  The check is race-free
+		 * under our ptl: in-window PTEs are ours, fork (the only way
+		 * exclusive anon gains mappings) takes mmap_write, and a folio
+		 * whose mappings all sit under this ptl cannot lose one either.
+		 * This also refuses a folio scattered across several spans of
+		 * the window, whose mapcount exceeds any single span.
+		 */
+		if (folio_mapcount(folio) != nr)
+			return SCAN_PAGE_COUNT;
+
+		/*
+		 * Every page of the span must be exclusive: the freeze accounts
+		 * only references it can see, and a non-exclusive page may be
+		 * unshared under us.  collapse_faultin() should have arranged
+		 * this; enforce it here, where it is depended on.
+		 */
+		for (k = 0; k < nr; k++) {
+			if (!PageAnonExclusive(pte_page(ptep_get(pte + i + k))))
+				return SCAN_PAGE_NOT_EXCLUSIVE;
+		}
+
+		i += nr;
+		addr += nr * PAGE_SIZE;
+	}
+
+	return SCAN_SUCCEED;
+}
+
 /*
  * Raise the two barriers on the sources of every candidate: migration entries in
  * their PTEs, then a frozen refcount.  Takes the table's ptl once for the whole
@@ -395,6 +534,44 @@ static enum scan_result collapse_faultin(struct vm_area_struct *vma,
 static void collapse_freeze(struct vm_area_struct *vma,
 			    struct collapse_control *cc, pmd_t *pmd)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *pte, *table;
+	spinlock_t *ptl;
+	unsigned int i;
+
+	pte = pte_offset_map_lock(mm, pmd, cc->candidates[0].addr, &ptl);
+	if (!pte) {
+		for (i = 0; i < cc->nr_candidates; i++) {
+			struct collapse_candidate *cand = &cc->candidates[i];
+
+			if (cand->state != CAND_SELECTED)
+				continue;
+			cand->state = CAND_SKIPPED;
+			cand->result = SCAN_NO_PTE_TABLE;
+		}
+		return;
+	}
+
+	/*
+	 * Index each candidate from the table base, not relative to
+	 * candidates[0]: a round is not necessarily address-ordered, so
+	 * candidates[0] need not be the lowest.  They all share one table.
+	 */
+	table = pte - pte_index(cc->candidates[0].addr);
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		pte_t *cand_pte = table + pte_index(cand->addr);
+
+		if (cand->state != CAND_SELECTED)
+			continue;
+
+		cand->result = collapse_check_candidate(vma, cc, cand, cand_pte);
+		if (cand->result != SCAN_SUCCEED)
+			cand->state = CAND_SKIPPED;
+	}
+
+	pte_unmap_unlock(pte, ptl);
 }
 
 /*
diff --git a/mm/collapse.h b/mm/collapse.h
index 0d6f77a7233b..747168104a72 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -46,6 +46,7 @@ enum scan_result {
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
+	SCAN_PAGE_NOT_EXCLUSIVE,
 	SCAN_ALLOC_LIGHT_MISS,
 };
 
-- 
2.54.0

