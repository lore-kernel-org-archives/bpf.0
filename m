Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2E3C1978
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640541; cv=none; b=IoamWeB5nFXnZ26F5rZev2u099CNltW3FPxWAy8JKKIVCbmfhfzPm2v72B/U3fGelpz/+xvIeC4T9ZtGsWo3+P+JdDfQuMORQLBeeskBJt4mWpVb0+cpZNwDVQnuXxmpoSfyfMHvJ6wfsnu3r8q7CZaYJYv/XlbCuWAvBG1Qe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640541; c=relaxed/simple;
	bh=leFlssTWRx1UcgWYTfrxtqn2gdLNeOhJcAUCtbZrvfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW8Q/e2HRJ1sj/NxAR0FO7qcZFz+krUNjOC9JaPKn06ynwk95ouwKOLjAoY7148Ti+SKxqv/DT7ptFI8qqNiuwYIgiKh8kflfchmiHkwNcCmyb2Uv/O/0sysWTo5Khk/Y4lBGY7lDEuyfoMqpP3ZdV9ixgaaks0aW4h5zIynG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a62nMxit; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a62nMxit"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=leFlssTWRx1UcgWYTfrxtqn2gdLNeOhJcAUCtbZrvfk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787640537; v=1; x=1788245337;
 b=a62nMxituGtZ3jwRXMwXRXIxAvc825kNcaQEZCQGv9M35h15pkXSK8HFjZ801gvV8/pgVLFg
 HUCoON7vvPQUt9sJxd3e6YMRGDb4laWDXN8B3n3NgD3w94LUg8nYrMLRtJnfFhcS0GEjM1rzrp8
 CWRDVoEausUoaeqhvpamRqlQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id 47ae94857be340a8;
	Tue, 25 Aug 2026 06:48:56 +0000
X-Mizu-Trace-ID: 47ae94857be340a8
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
Subject: Re: [RFC PATCH 18/57] mm/collapse: install the destinations at PTE level
Date: Tue, 25 Aug 2026 14:48:51 +0800
Message-Id: <20260825064851.87309-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260816224609.308019-19-kirill@shutemov.name>
References: <20260816224609.308019-19-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Aug 16, 2026 at 11:45:30PM +0100, Kiryl Shutsemau wrote:
>From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
[...]
> /* Publish each destination folio in place of the sources it replaces */
> static void collapse_install(struct vm_area_struct *vma,
> 			     struct collapse_control *cc, pmd_t *pmd)
> {
>+	struct mm_struct *mm = vma->vm_mm;
>+	pte_t *pte, *table;
>+	spinlock_t *ptl;
>+	unsigned int i;
>+
>+	if (is_pmd_order(cc->candidates[0].order)) {
>+		/* A PMD candidate fills the slot pool: always alone */
>+		VM_WARN_ON_ONCE(cc->nr_candidates != 1);
>+		collapse_install_pmd(vma, cc, pmd);
>+		return;
>+	}
>+
>+	pte = pte_offset_map_lock(mm, pmd, cc->candidates[0].addr, &ptl);
>+	if (!pte) {
>+		/*
>+		 * Table gone under us (see collapse_abort_candidate() on @pte).
>+		 * Tear down every frozen candidate -- stranding them would leak
>+		 * frozen, locked sources.
>+		 */
>+		for (i = 0; i < cc->nr_candidates; i++) {
>+			struct collapse_candidate *cand = &cc->candidates[i];
>+
>+			if (cand->state != CAND_FROZEN)
>+				continue;
>+
>+			cand->result = SCAN_NO_PTE_TABLE;
>+			collapse_abort_candidate(vma, cand, NULL);
>+		}
>+		return;
>+	}
>+	table = pte - pte_index(cc->candidates[0].addr);
>+
>+	for (i = 0; i < cc->nr_candidates; i++) {
>+		struct collapse_candidate *cand = &cc->candidates[i];
>+		pte_t *cand_pte = table + pte_index(cand->addr);
>+		unsigned int nr_populated;
>+
>+		if (cand->state != CAND_FROZEN)
>+			continue;
>+
>+		if (cand->result != SCAN_SUCCEED) {
>+			/* Machine check during the copy */
>+			collapse_abort_candidate(vma, cand, cand_pte);
>+			continue;
>+		}
>+
>+		/* No destination: the provision pass could not spare one */
>+		if (!cand->new_folio) {
>+			collapse_abort_candidate(vma, cand, cand_pte);
>+			continue;
>+		}
>+
>+		if (!collapse_verify_candidate(cand, cand_pte, &nr_populated)) {
>+			cand->result = SCAN_PTE_NON_PRESENT;
>+			collapse_abort_candidate(vma, cand, cand_pte);
>+			continue;
>+		}
>+
>+		/*
>+		 * The smp_wmb() in __folio_mark_uptodate() orders the copied
>+		 * data before the set_ptes() that publishes it.
>+		 */
>+		__folio_mark_uptodate(cand->new_folio);
>+		map_anon_folio_pte_nopf(cand->new_folio, cand_pte, vma,
>+					cand->addr, /*uffd_wp=*/ false);
>+
>+		/* Slots with no source gain anon memory that no zap accounted */
>+		if (nr_populated)
>+			add_mm_counter(mm, MM_ANONPAGES, nr_populated);

Well ... KSM zero-page accounting gets out of sync here.

Say a saved zero PTE came from KSM. ksm_map_zero_page() has already
bumped global + per-mm counters. ksm_might_unmap_zero_page() uses its|
dirty bit to drop them again later:

#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))

static inline void ksm_map_zero_page(struct mm_struct *mm)
{
	atomic_long_inc(&ksm_zero_pages);
	atomic_long_inc(&mm->ksm_zero_pages);
}

static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
{
	if (is_ksm_zero_pte(pte)) {
		atomic_long_dec(&ksm_zero_pages);
		atomic_long_dec(&mm->ksm_zero_pages);
	}
}

Right, once a candidate reaches install, those counters stay valid only
if collapse_abort_candidate() restores the saved PTE. A successful PTE
install doesn't restore it. Neither does an abort after the slot was
refilled or the PTE table disappeared. Patch #19 has the same
successful-install case in collapse_install_pmd() ...

I was thinking of something like this:

---8<---
diff --git a/mm/collapse.c b/mm/collapse.c
index 7c10888031f7..68b37e706341 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -8,6 +8,7 @@
 #include <linux/highmem.h>
 #include <linux/huge_mm.h>
 #include <linux/hugetlb.h>	/* x86 flush_tlb_range() uses hstate_vma() */
+#include <linux/ksm.h>
 #include <linux/leafops.h>
 #include <linux/math64.h>
 #include <linux/memcontrol.h>
@@ -1430,6 +1431,8 @@ static void collapse_abort_candidate(struct vm_area_struct *vma,
 		if (is_zero_pfn(pte_pfn(saved))) {
 			if (pte && pte_none(ptep_get(pte + i)))
 				set_pte_at(mm, addr, pte + i, saved);
+			else
+				ksm_might_unmap_zero_page(mm, saved);
 			continue;
 		}

@@ -1499,6 +1502,16 @@ static bool collapse_verify_candidate(struct collapse_candidate *cand,
 	return true;
 }

+static void collapse_unmap_zero_pages(struct mm_struct *mm,
+				      struct collapse_candidate *cand)
+{
+	const unsigned int nr_pages = candidate_nr_pages(cand);
+	unsigned int i;
+
+	for (i = 0; i < nr_pages; i++)
+		ksm_might_unmap_zero_page(mm, cand->saved_ptes[i]);
+}
+
 /*
  * The PMD terminal layer: verify, detach the table, deposit a fresh one and
  * install the leaf, as one atomic section under the pmd lock.  A pmd_none window
@@ -1616,6 +1629,7 @@ static void collapse_install_pmd(struct vm_area_struct *vma,
 	/* Slots with no source gain anon memory that no zap accounted */
 	if (nr_populated)
 		add_mm_counter(mm, MM_ANONPAGES, nr_populated);
+	collapse_unmap_zero_pages(mm, cand);
 	cand->deposit = NULL;
 	cand->new_folio = NULL;	/* ownership: the mapping */
 	cand->state = CAND_INSTALLED;
@@ -1708,6 +1722,7 @@ static void collapse_install(struct vm_area_struct *vma,
 		/* Slots with no source gain anon memory that no zap accounted */
 		if (nr_populated)
 			add_mm_counter(mm, MM_ANONPAGES, nr_populated);
+		collapse_unmap_zero_pages(mm, cand);
 		cand->new_folio = NULL;	/* ownership: the mappings */
 		cand->state = CAND_INSTALLED;
 	}
---

Cheers, Lance

>+		cand->new_folio = NULL;	/* ownership: the mappings */
>+		cand->state = CAND_INSTALLED;
>+	}
>+
>+	pte_unmap_unlock(pte, ptl);
> }
> 
> /*
>-- 
>2.54.0
>
>
