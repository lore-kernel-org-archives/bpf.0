Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132D3E51F7;
	Sun, 16 Aug 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920404; cv=none; b=SBCZrkbLz7Bdp9jR06dvAuNrnhVmLckHzM6LIrS+bAcDqiaHjAYEh2vqGoWI4ZLs8u9o9ahiGptXU2BuqtS3V7LtTT7NxBaFoCBnRnQ/hzHGgg9s24MZMUCLzB7roMY0NeMCnwE1pj+SW3bq6Es6L3LmTj2yZaYHbOp5BPV6iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920404; c=relaxed/simple;
	bh=jomEwovj9b8k417t0IRW9Y93tpW80uP6vIda7Gb1KT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4UJyP4YMiCOV3wE5aqp4HnwnyQDyxszbTOg1VhNs4m5c9eLflIJl/SbpO4gaE/2JQyIhL9zLe6hYn3bNM4iIQu9uXwbB64dpOsxcfgV1pJRSmNrGFiVJMcaDCbHHafyVaplPyfAvIXHXEBV4Jf3lVmcFrBcs9VJ4VDxZ5J7Z/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dMgjTlrs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7J0K0ur; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dMgjTlrs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7J0K0ur"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7F3714000FD;
	Sun, 16 Aug 2026 18:46:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 18:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920402; x=
	1787006802; bh=NZOPrMQr1FnE5Kz+0VaDbhYd69V7nE+v+WGyJ8jLpqs=; b=d
	MgjTlrsA2TAN2Gz5Z208Bh7RwwxK4hCZ9Xp6qOXmN8dtzhGXvQ7fQZnjNFqzv5Jw
	kXfZKB2tY9yvRg7yblTrPv0aW6UT6t5F8gyVGkI8Si58SuFnE/tdQ5FrgBk76Fw7
	cZhh+dVKWLjD0hQ/W0GQj/YgWw+zNCFJWSlSllQg5p6kxgDg3+d+xPxi2ua0+6C7
	DCnp0KWYKAqNVMyrZFfrd6L9nknXvlIXL4i0Oqho9U5n2kibbaP4LNBmK0MOcFNw
	uQ4ipd8hFvpAiSo8yzX5ynoJdKckAoUKFa/oUo+tOxXfTX58LSFfg42o7bbTHtvl
	G5i6KeH+YbxggOiW3310A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920402; x=1787006802; bh=N
	ZOPrMQr1FnE5Kz+0VaDbhYd69V7nE+v+WGyJ8jLpqs=; b=j7J0K0urCx9gvHOAE
	fuXPkD8y2DAoHplqbZBj3Aa3ZUsV6wBtLdv/eKXRz6ov2B+PWXyrNpMK9OySr0hz
	KrNDP1xSt/qEwgmlp+00k8C9B7tSByxiDN3zqS+mYIYmF1+wOpq0srdNOeDtXjrp
	DfRvz5/b9v33YzZELj6CrMA62mPobzpfhyzmOegLk0zNfziW9v2T8ilIjx+UDe+f
	cIIPHqmGih8w/bQKiIYQINbL2yeqkq47y+gsD8ZxlKIy3ZcjhhE/AnKDYQShGb0x
	G9Jofik0aSdiYr6QbbbqeB1BFxqIUn+d4UGfLM/8hulSqudEI+b8ajm5wENvQFpr
	qxgIg==
X-ME-Sender: <xms:0j2CauQ3RAF5DQJii9nlCoGOuXBO75usQnR6MLtDPV50aY7iKmitDg>
    <xme:0j2CapHZ5dyNKzELd5KM8UGUXds87gpaInaxwhBQ6HmWMBqRvUy4u7-MXF69Apkx3
    auxXjDtbWIIobA8tIxF2hyP3aoMjI-ZZ5GNbvdK3m0jQgB_OzP9UQxu>
X-ME-Received: <xmr:0j2Can7gzzvjTrJyQvwWiufxG_HuUcbfyxW1_QGVDnK_rwAJJ5HX7PtQJkI>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTQ2
    FelKSTgHEKVgvkY8tHcuDNVEAPCoxnB1STILl3mSOMqFTZSay6/ZYJqGaXIjf15nNBLQkS
    eU9mF5lLSVPLb2CPUcn9gJUbtqVZ/RCOIIdYfQK21+XHkehy1IcjeQ9DMmCuHy0yD6l4Bo
    YX/xWt+2giJuXoJnKCkcQdlCkYPKsf6Ju+WbotE2ZKZ7otu5xY8ea1wm66+wob/k5mrVv2
    8kDZAoiYUG5B+oXDxbOgKDaeXqBa405IAf2lrH5h5KhqIh01oOJwJJ+HkLfWi1VRc36FAg
    hVEvqxZZK3G9CgHUJk6MTFpk8O74DQPxp8Vc6G5mmmQON0G5YZoi+6Yfhobw
X-ME-Proxy: <xmx:0j2Camms6FCa7VERWO9KpjeDzhsOgs8zqX-gzQdO4tZaoZW5ma-ctA>
    <xmx:0j2Catz_JHxZzQXR-yF5H6XxMhF-Gbk2qQZvKAzGewXBNy2yQdGwPw>
    <xmx:0j2CagO3cdCw7F6VwMhhQ9TtVxE-3A2hVGjZRsgT4DwvQeDnxIONYw>
    <xmx:0j2CavjyY5jazKAH4ooZmS1twTI9R23Llr62m7erkzqrcGIvv5QSMA>
    <xmx:0j2Cao11kBtD4UOxUZFz7kYewPzacDEqSN5eoTgzR-pbG4jVomDjv05r>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:41 -0400 (EDT)
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
Subject: [RFC PATCH 12/57] mm/collapse: allocate a destination per candidate
Date: Sun, 16 Aug 2026 23:45:24 +0100
Message-ID: <20260816224609.308019-13-kirill@shutemov.name>
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

Fill in the allocation, which happens on both sides of the freeze.

A destination is a folio of the candidate's order, charged to the memcg,
with the memcg's deferred-split list entry taken up front while sleeping
is still allowed: the PMD-order install would otherwise need one under
the pmd lock.

collapse_alloc() does all of that for one candidate with the gfp it is
handed, and counts nothing when it fails: what a miss means is up to the
caller.

collapse_provision() is the caller inside the window.  The sources are
frozen by then and a faulter on any of them is waiting, so it asks
without __GFP_DIRECT_RECLAIM: reclaim entered there would be paid for by
that faulter.

A candidate the allocator cannot spare one for is declined rather than
failed.  It keeps its freeze and records SCAN_ALLOC_LIGHT_MISS, which
asks for the reclaiming gfp so a later round can allocate for it before
freezing anything.  Where the policy forbids reclaim there is nothing
better to retry with, so the miss is the verdict: the real result is
recorded and the failure counters fire.

collapse_reserve() honours those requests, before the round takes any
lock.  This is where reclaim belongs: nothing is held or frozen, so a
long compaction costs only khugepaged's own progress, which is why the
mechanism being replaced allocated here too.  Having asked the allocator
to try hard, a miss there is a failure.

Nothing sets cand->reclaim yet, so collapse_reserve() has nothing to do.
The request comes from the selection side, which queues a region refused
at one order for another attempt.

The page table a PMD-order candidate deposits cannot be deferred the same
way.  pte_alloc_one() allocates with GFP_PGTABLE_USER and takes no gfp to
strip, so it may reclaim and sleep whatever the order asked for.
collapse_deposit() secures it ahead of the freeze and refuses the
candidate when it cannot.  A PMD-order window is a whole table, so there
is at most one such candidate and it is the first.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/trace/events/huge_memory.h |   3 +-
 mm/collapse.c                      | 126 +++++++++++++++++++++++++++++
 mm/collapse.h                      |   2 +
 mm/khugepaged.c                    |   4 +-
 4 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 778f5a56956c..68693eba82ef 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -40,7 +40,8 @@
 	EM( SCAN_STORE_FAILED,		"store_failed")			\
 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
-	EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
+	EM( SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
+	EMe(SCAN_ALLOC_LIGHT_MISS,	"alloc_light_miss")
 
 #undef EM
 #undef EMe
diff --git a/mm/collapse.c b/mm/collapse.c
index 25c0f72a9a68..58c8d83f3468 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/vmstat.h>
 
 #include <asm/tlb.h>
 #include "collapse.h"
@@ -114,6 +115,12 @@
 	min(COLLAPSE_BATCH_BYTES >> (PAGE_SHIFT + COLLAPSE_MIN_MTHP_ORDER), \
 	    COLLAPSE_TABLE_WINDOWS)
 
+/* How far a candidate got, and so what a failure has to undo for it */
+enum collapse_candidate_state {
+	CAND_SELECTED,		/* collected; nothing held on its behalf yet */
+	CAND_SKIPPED,		/* refused; nothing of it left to undo */
+};
+
 /*
  * A candidate is an (addr, order) window selected for collapse.  Selection
  * counts in PTE offsets -- the bitmap it reads and the alignment it honours are
@@ -123,7 +130,12 @@
 struct collapse_candidate {
 	unsigned long addr;
 	unsigned int order;
+	/* The light allocation missed last round: this one may reclaim for it */
+	bool reclaim;
+	enum collapse_candidate_state state;
 	enum scan_result result;
+	struct folio *new_folio;
+	pgtable_t deposit;		/* PMD order: fresh table to deposit */
 };
 
 static unsigned long candidate_start(const struct collapse_candidate *cand)
@@ -218,6 +230,43 @@ static void collapse_freeze(struct vm_area_struct *vma,
 {
 }
 
+/*
+ * Allocate one candidate's destination with @gfp: a folio of its order, charged,
+ * with the memcg's deferred-split list heads in place so the install cannot need
+ * to allocate under the pmd lock.  Those heads cost only the first collapse in a
+ * memcg.
+ *
+ * A failure counts nothing and changes nothing: what a miss means is the caller's
+ * policy.
+ */
+static enum scan_result collapse_alloc(struct mm_struct *mm,
+				       struct collapse_control *cc,
+				       struct collapse_candidate *cand,
+				       gfp_t gfp)
+{
+	struct folio *folio;
+
+	folio = __folio_alloc(gfp, cand->order, collapse_find_target_node(cc),
+			      &cc->alloc_nmask);
+	if (!folio)
+		return SCAN_ALLOC_HUGE_PAGE_FAIL;
+
+	if (unlikely(mem_cgroup_charge(folio, mm, gfp)) ||
+	    folio_memcg_alloc_deferred(folio)) {
+		folio_put(folio);
+		return SCAN_CGROUP_CHARGE_FAIL;
+	}
+
+	if (is_pmd_order(cand->order)) {
+		count_vm_event(THP_COLLAPSE_ALLOC);
+		count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
+	}
+	count_mthp_stat(cand->order, MTHP_STAT_COLLAPSE_ALLOC);
+	cand->new_folio = folio;
+
+	return SCAN_SUCCEED;
+}
+
 /*
  * Allocate ahead of the freeze for the candidates whose light allocation missed
  * last round.  This is where reclaim belongs: nothing is held or frozen, so a
@@ -227,6 +276,31 @@ static void collapse_freeze(struct vm_area_struct *vma,
  */
 static void collapse_reserve(struct mm_struct *mm, struct collapse_control *cc)
 {
+	unsigned int i;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		enum scan_result result;
+
+		if (!cand->reclaim)
+			continue;
+		cand->reclaim = false;
+
+		result = collapse_alloc(mm, cc, cand, cc->policy.gfp);
+		if (result == SCAN_SUCCEED)
+			continue;
+
+		if (result == SCAN_ALLOC_HUGE_PAGE_FAIL) {
+			/* Asked the allocator to try hard and it still missed */
+			if (is_pmd_order(cand->order))
+				count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
+			count_mthp_stat(cand->order,
+					MTHP_STAT_COLLAPSE_ALLOC_FAILED);
+		}
+
+		cand->state = CAND_SKIPPED;
+		cand->result = result;
+	}
 }
 
 /*
@@ -235,9 +309,28 @@ static void collapse_reserve(struct mm_struct *mm, struct collapse_control *cc)
  * to strip: order-0 or not, it may reclaim and sleep, which is what the window
  * exists to keep out.  The destination folio has a light gfp to fall back on and
  * so can be deferred; this has none.
+ *
+ * A round is one table and a PMD-order window is the whole of it, so such a
+ * candidate cannot share a round: if there is one it is the only one, and it is
+ * candidates[0].  This secures one page table, never a batch of them.
  */
 static void collapse_deposit(struct mm_struct *mm, struct collapse_control *cc)
 {
+	struct collapse_candidate *cand = &cc->candidates[0];
+
+	if (!is_pmd_order(cand->order))
+		return;
+
+	VM_WARN_ON_ONCE(cc->nr_candidates != 1);
+
+	if (cand->state != CAND_SELECTED)
+		return;
+
+	cand->deposit = pte_alloc_one(mm);
+	if (!cand->deposit) {
+		cand->state = CAND_SKIPPED;
+		cand->result = SCAN_ALLOC_HUGE_PAGE_FAIL;
+	}
 }
 
 /*
@@ -253,6 +346,35 @@ static void collapse_deposit(struct mm_struct *mm, struct collapse_control *cc)
 static void collapse_provision(struct mm_struct *mm,
 			       struct collapse_control *cc)
 {
+	const gfp_t gfp = cc->policy.gfp & ~__GFP_DIRECT_RECLAIM;
+	const bool may_retry = gfp != cc->policy.gfp;
+	unsigned int i;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		enum scan_result result;
+
+		if (cand->state != CAND_SELECTED || cand->new_folio)
+			continue;
+
+		result = collapse_alloc(mm, cc, cand, gfp);
+		if (result == SCAN_SUCCEED)
+			continue;
+
+		if (may_retry) {
+			/* A charge miss too: charging may reclaim when allowed */
+			cand->result = SCAN_ALLOC_LIGHT_MISS;
+		} else {
+			/* The gfp a retry would use, so this is the answer */
+			if (result == SCAN_ALLOC_HUGE_PAGE_FAIL) {
+				if (is_pmd_order(cand->order))
+					count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
+				count_mthp_stat(cand->order,
+						MTHP_STAT_COLLAPSE_ALLOC_FAILED);
+			}
+			cand->result = result;
+		}
+	}
 }
 
 /*
@@ -761,7 +883,11 @@ static void collapse_add_candidate(struct collapse_control *cc,
 	cc->nr_candidates++;
 	cand->addr = addr;
 	cand->order = order;
+	cand->reclaim = false;
+	cand->state = CAND_SELECTED;
 	cand->result = SCAN_FAIL;
+	cand->new_folio = NULL;
+	cand->deposit = NULL;
 }
 
 /*
diff --git a/mm/collapse.h b/mm/collapse.h
index c61db86dc6c2..feb2e0d57339 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -46,6 +46,7 @@ enum scan_result {
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
+	SCAN_ALLOC_LIGHT_MISS,
 };
 
 /*
@@ -148,6 +149,7 @@ unsigned long collapse_possible_orders(struct vm_area_struct *vma,
 		vm_flags_t vm_flags, enum tva_type tva_flags);
 enum scan_result find_pmd_or_thp_or_none(struct mm_struct *mm,
 		unsigned long address, pmd_t **pmd);
+int collapse_find_target_node(struct collapse_control *cc);
 bool collapse_scan_abort(int nid, struct collapse_control *cc);
 unsigned int collapse_max_ptes_none(struct collapse_control *cc,
 		struct vm_area_struct *vma, unsigned int order);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 43f6107c953a..50b520961b9b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -999,7 +999,7 @@ static void collapse_policy_forced(struct collapse_policy *p)
 }
 
 #ifdef CONFIG_NUMA
-static int collapse_find_target_node(struct collapse_control *cc)
+int collapse_find_target_node(struct collapse_control *cc)
 {
 	int nid, target_node = 0, max_value = 0;
 
@@ -1018,7 +1018,7 @@ static int collapse_find_target_node(struct collapse_control *cc)
 	return target_node;
 }
 #else
-static int collapse_find_target_node(struct collapse_control *cc)
+int collapse_find_target_node(struct collapse_control *cc)
 {
 	return 0;
 }
-- 
2.54.0

