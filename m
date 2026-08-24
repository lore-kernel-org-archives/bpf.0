Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C494137BC
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570418; cv=none; b=EIR5V/c/7Nkjg1vSyXszr680ggvmnMubWE2qe14ViqS3ThBAyIxhKc1s3acqfZUKRLyomZeM/H2Whgy1GyZIORa/9MDhkJoYUzLTVb64IYBeKowqLSzdKOFhj54Bpy7WC929xet1qT9IUsfMFdN2Pclwtq4PQ4VI/iz4HOJjSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570418; c=relaxed/simple;
	bh=YqtmwJj1TSTjAKuc+RN5KV+zNyJi4YEBO9daURTvoKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtrwfXZWFqwjFMKswF6gdK9mI/Js4rHitiLzzDN3tjqSlXaGqDbKpS9jsG/0FZr+Q27V0guy5h5UAu/Dfp2d7ZEBHWW9DkBBTUlsCZ7WqfqiFReCsnEYQlnXBhXC1hX89njrgKV7Lc7dGH6vb3m0fp3W3lzWkt3kO6ktusWX4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cBxRjeXT; arc=none smtp.client-ip=95.215.58.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cBxRjeXT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YqtmwJj1TSTjAKuc+RN5KV+zNyJi4YEBO9daURTvoKI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787570414; v=1; x=1788175214;
 b=cBxRjeXTr4YoFroncha9ILGDO2EQVAsiq/XLTi7JFU0fh2h2l+dISPpK41qq2aJ9ayS+SWbb
 bBR7d6CG5pmQ3bY+IE2bxmx/rtb/1Cw9FRHCDILGTd23CG6X+mPHKGlJZsZTrngfostncwh1tz8
 7qbQ7fd/GKe1jfnQ9on6DEM8=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id dbcc094937eb36f3;
	Mon, 24 Aug 2026 11:20:13 +0000
X-Mizu-Trace-ID: dbcc094937eb36f3
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
Subject: Re: [RFC PATCH 12/57] mm/collapse: allocate a destination per candidate
Date: Mon, 24 Aug 2026 19:20:05 +0800
Message-Id: <20260824112005.63097-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260816224609.308019-13-kirill@shutemov.name>
References: <20260816224609.308019-13-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Aug 16, 2026 at 11:45:24PM +0100, Kiryl Shutsemau wrote:
>From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
>Fill in the allocation, which happens on both sides of the freeze.
>
>A destination is a folio of the candidate's order, charged to the memcg,
>with the memcg's deferred-split list entry taken up front while sleeping
>is still allowed: the PMD-order install would otherwise need one under
>the pmd lock.
>
>collapse_alloc() does all of that for one candidate with the gfp it is
>handed, and counts nothing when it fails: what a miss means is up to the
>caller.
>
>collapse_provision() is the caller inside the window.  The sources are
>frozen by then and a faulter on any of them is waiting, so it asks
>without __GFP_DIRECT_RECLAIM: reclaim entered there would be paid for by
>that faulter.
[...]
>+/*
>+ * Allocate one candidate's destination with @gfp: a folio of its order, charged,
>+ * with the memcg's deferred-split list heads in place so the install cannot need
>+ * to allocate under the pmd lock.  Those heads cost only the first collapse in a
>+ * memcg.
>+ *
>+ * A failure counts nothing and changes nothing: what a miss means is the caller's
>+ * policy.
>+ */
>+static enum scan_result collapse_alloc(struct mm_struct *mm,
>+				       struct collapse_control *cc,
>+				       struct collapse_candidate *cand,
>+				       gfp_t gfp)
>+{
>+	struct folio *folio;
>+
>+	folio = __folio_alloc(gfp, cand->order, collapse_find_target_node(cc),
>+			      &cc->alloc_nmask);
>+	if (!folio)
>+		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>+
>+	if (unlikely(mem_cgroup_charge(folio, mm, gfp)) ||
>+	    folio_memcg_alloc_deferred(folio)) {

One small nit: folio_memcg_alloc_deferred() passes GFP_KERNEL to the
deferred_split_lru allocation.

At the full series tip, collapse_round() invokes it after
collapse_freeze() and before collapse_putback(), while faults on the
source migration entries wait:

static void collapse_round(struct mm_struct *mm, unsigned long pmd_addr,
			   struct collapse_control *cc)
{
...
	collapse_freeze(vma, cc, pmd);
	collapse_provision(mm, cc);
...
	collapse_putback(vma, cc);
...
}

collapse_provision() strips direct reclaim before calling
collapse_alloc():

static void collapse_provision(struct mm_struct *mm,
			       struct collapse_control *cc)
{
	const gfp_t gfp = cc->policy.gfp & ~__GFP_DIRECT_RECLAIM;
...
		result = collapse_alloc(mm, cc, cand, gfp);
...
}

collapse_alloc() uses that gfp for the charge, then calls
folio_memcg_alloc_deferred():

static enum scan_result collapse_alloc(struct mm_struct *mm,
				       struct collapse_control *cc,
				       struct collapse_candidate *cand,
				       gfp_t gfp)
{
...
	if (unlikely(mem_cgroup_charge(folio, mm, gfp)) ||
	    folio_memcg_alloc_deferred(folio)) {
...
	}
...
}

The helper substitutes GFP_KERNEL:

int folio_memcg_alloc_deferred(struct folio *folio)
{
...
	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
}

When this metadata has not been allocated for a memcg yet,
folio_memcg_list_lru_alloc() can take its blocking slow branch:

int folio_memcg_list_lru_alloc(struct folio *folio, struct list_lru *lru,
			       gfp_t gfp)
{
...
	/* Fast path when list_lru heads already exist */
	rcu_read_lock();
	memcg = folio_memcg(folio);
	res = memcg_list_lru_allocated(memcg, lru);
	rcu_read_unlock();
	if (likely(res))
		return 0;

	/* Allocation may block, pin the memcg */
	memcg = get_mem_cgroup_from_folio(folio);
	res = __memcg_list_lru_alloc(memcg, lru, gfp);
...
}

GFP_KERNEL includes __GFP_DIRECT_RECLAIM:

...
#define __GFP_DIRECT_RECLAIM	((__force gfp_t)___GFP_DIRECT_RECLAIM) /* Caller can reclaim */
#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
#define __GFP_RECLAIM ((__force gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))

...
#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)

This only affects calls that find the metadata missing; after it has been
installed, later calls take the fast branch. Still, it bypasses the gfp
with direct reclaim stripped for the freeze window. Could
folio_memcg_alloc_deferred() take that gfp here?

[...]

Cheers, Lance
