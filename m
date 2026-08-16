Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D333E8C64;
	Sun, 16 Aug 2026 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920416; cv=none; b=UlgZyArzQ++iBDQKTiPKXrUD6bscJ0YmoKUSMk39Yu/lVuVlpMMzJXEeRzyuMI8k2bK/ICO0Il2oLX5t2lgZ76hXxF6h01NRW3gMzCt34Siv7jRSCaM4zqsrBKSwV17zDBLmadLbvy5GEpDqXgIBuE1mNSbuFm+wPF4tmZ+JYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920416; c=relaxed/simple;
	bh=p5aYzYvIN3rJ2V10UBoXgQO98iLdbTLdlyC1OIFJX0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp53ATL6Sldg5pIQWnBXBrs/qnYSm/m7873nkEV2SwmzUoEjzTlvrfnAo01P2vb9TJjSKRvXZxDH3BsYUXx4RjfC8CHcIB0LPk1KNJYiHWL5CBe4vLFqCQvZi3yGUsMTAvUfMqiWRkj27TeuzS9iZx4sKX5l//BbTZ3kIdGyPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=A7nHQUNW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJe0v8d8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="A7nHQUNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJe0v8d8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 783DB14000FD;
	Sun, 16 Aug 2026 18:46:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920413; x=
	1787006813; bh=bt/1DtqAT/rmlcUJsAd7Y7VJ/qj4oL01k7OngiisgMs=; b=A
	7nHQUNWeeK6LwXx1dXKoJVpZq9SxvzD7JjuDWIqNRZJgGwdlcZNogrZDHOc62aCm
	9X49B4enpi/nVLJ3FV3Fy8fnVTIZcysdQfXO8+mJ6dBjpnxG5Y7POYIlAsiV6DMp
	lVhA8e7CVGx2v+TMZ3DgPX2G7SDmptIB28D05F6U7W45AIGuDAcHrtXV89uUSjtl
	9iPunvkzUZ06yv+ZGc+hguZmFClKzJ5rPTCh/MfYmWeepS4i3/pw1KSWf2M1ZfT2
	eWlT7YQ7BDVbeE4yN47SJkaiU7c//FwFZ1sJ0SAfryFqcQL1itb6ZAjjVrpuB+3e
	00PzrWkEPExcogV7Z8CUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920413; x=1787006813; bh=b
	t/1DtqAT/rmlcUJsAd7Y7VJ/qj4oL01k7OngiisgMs=; b=VJe0v8d8Lfz19Q2jd
	Ykl0QKJwzAPimFIJxtf6xYOw8WywgdGNuj4tHaI9N6/FV9fA0Y82OsW2R5uFb0vx
	uDe+PeJOIxoF4PFK6u6+NSJUMifLREsRpeWMfCc9yg7n9cgwo4zfZGtyp3aarzHc
	THu0RgDq4vqmU6akcsDPps+Xz1l3KNLyrroXRVBKXUXFa9V0yZP5rJmnpm8rA1vO
	Uv3ZhhHJuxnPU3PnA+WRJsGK3JY/11yJSRIrmY7DsDdRXKagyemHNvj+t3B/+vRt
	XFHbVrMGiWBCnKqWPMNWUTWOEiG7HyWaW/Nk6pfSmJXGWbaHrvMrRmwka3nK/OuO
	2eS6A==
X-ME-Sender: <xms:3T2CajUHBcDuaKlIZf7VJoOR-m63aHqYn5Vs9NbOilmGM-AADUYE4g>
    <xme:3T2Cag7l7KuOGAYnXKLVVHoyAbQo6lAp6VZIwhiy6P4ckjwIPGU7qTUVIOx34yydQ
    34u1Mfb2wJQdv0ErVTzxy_MLxPlKRR48kVzaJW7rh0lv-OIJk7zG6o>
X-ME-Received: <xmr:3T2CarcSXrPnsC-wrEsPuIVzu2iy1On94ssIMiMAayCn4sAI_Ei5VJut9eE>
X-ME-Proxy-Cause: dmFkZTGU6CsvhMdBtF1sno4coJRY9LqZz27w5X62/KcvcmaHPoOW0E1BwYMGQvImxADkeF
    Vrd/NWvQclh95CfVK4mxB+x5IwibSBkynFlxvp5GF5/z4jepOu57IyLHUvB8DzXymwpMun
    cyoWwWLP4hjAaD7bSTsoDmYKe03ryBERSg0IuR8ZqJolHrsaFnqWf5mL2byVsL9qLL9zPI
    9yLFlvwwZlCiJbT4IVFlRVV/9A2lZNuDFrGWvpQWw3cjqX9EcFrpnMQcn/0MdQygQWXSYC
    yXHZy2pRvgBssh5qObsL1GM1XSEE6m2uHX2m5CwJlvTSIfOodU1appS1XFI/CBVlhtQ7Sa
    oM4s3kdxff6tSMV/KSNRoNHe1vOGvdBaQHDPRfcXMYtPRiFroRQvfuDcmb5v1yCxJWEnfO
    /WmyTZQvMyyPBnEmifuOiBwpGWBSUhY0WR8/MJ34EsN3oddj+bXWoDdXMw2D/cHFi1bnI0
    CO7GHKJTqzIij4V1D0Oodu6+BZfTerMwggOGzyrZ8NL1lA7ilN6fLJXYiGSQQkRbIi2Var
    GE2q6NHWdzcvB+r+8KC06irB/u6W/vRiy7FZ8SIO3J2jy+CYXdsvFAEhb1H07a0TRm/j3G
    lZks2zzWHZy7xeuWtHbYdLFyCgPb2iXFm3eFsl984HbzWvAOJ3nUMnAJVWPQ
X-ME-Proxy: <xmx:3T2Caq5EH7RFZHcNu3uI_NJQVlDAkKcsqbu3_syEDzChRIY7w_1jPw>
    <xmx:3T2Caj3TzfxDs02dfjaXzQBr5Vrf-eCiviMWTQv6r-UBi6eRtdIdcA>
    <xmx:3T2CalDdqEEraK1GDtHHOxm52vjnVN3uQI7-2yceQvefsOBq0zqo0Q>
    <xmx:3T2CasFvRG7Oc_XcPkdeRaZ_7G1NMHGWB4NsRTjqI5Gku-NvPXTzYw>
    <xmx:3T2CaioVmRBn89_NrUyjUXB161NxfF-LiyZkqrWI7_8GJX27_jHnqBfC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:52 -0400 (EDT)
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
Subject: [RFC PATCH 18/57] mm/collapse: install the destinations at PTE level
Date: Sun, 16 Aug 2026 23:45:30 +0100
Message-ID: <20260816224609.308019-19-kirill@shutemov.name>
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

Fill in the install for sub-PMD candidates, and with it the two things
every install needs: a verify, and an abort.

The verify decides whether the window is still the round's to publish.
Under the ptl, every slot that had a source must still hold the round's
migration entry, and every slot that had none must still be none.  A hole
some fault refilled is not the round's to overwrite.  Verify and install
share one ptl hold, so a verified candidate cannot lose a slot before it
is published.

The abort undoes a frozen candidate that cannot be published: the copy
took a machine check, the provision pass could not spare it a
destination, or the verify refused it.  Slot by slot:

 - a slot still holding the round's migration entry is restored from the
   saved value.  No TLB flush: the translation is identical.
 - a slot that does not is left exactly as found, since restoring it
   would resurrect memory the user zapped.  Its rmap is dropped here,
   because the zapper fixed up rss for what it cleared but could not drop
   the rmap a frozen source keeps.

The table itself going away is that same rule at whole-table scale.  A
racing MADV_DONTNEED over the whole table, and the empty-table reclaim
behind it, can free the table between freeze and install.  Every slot
then reads as foreign, and what is left to undo is exactly the half of
the teardown a zapper cannot do for a frozen source.

Publishing is the fault path's own helper, so the destination gets rmap
and LRU insertion before its PTEs, fresh bits from the VMA, contpte
painting, and no TLB flush -- every transition is non-present to present.
Slots that had no source become anon memory no zap ever accounted for, so
rss is corrected by hand.

PMD-order candidates need a terminal layer of their own, a stub here.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/mm/collapse.c b/mm/collapse.c
index a3882d897d11..842adc30aeb0 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -129,6 +129,7 @@ enum collapse_candidate_state {
 	CAND_SELECTED,		/* collected; nothing held on its behalf yet */
 	CAND_SKIPPED,		/* refused; nothing of it left to undo */
 	CAND_FROZEN,		/* sources displaced and frozen */
+	CAND_INSTALLED,		/* the destination is mapped */
 };
 
 /*
@@ -1082,10 +1083,235 @@ static void collapse_copy(struct vm_area_struct *vma,
 	}
 }
 
+/*
+ * Undo one frozen slot: restore the saved PTE if our migration entry is still
+ * there, or drop the rmap the freeze took if a racing zap already replaced it.
+ * Returns true when the slot was zapped -- its mapping reference is then ours to
+ * release.
+ */
+static bool collapse_abort_slot(struct vm_area_struct *vma, struct folio *folio,
+				pte_t *slot, unsigned long addr, pte_t saved)
+{
+	/* No table left: the slot cannot still be holding our entry */
+	if (slot) {
+		softleaf_t entry = softleaf_from_pte(ptep_get(slot));
+
+		if (softleaf_is_migration(entry) &&
+		    softleaf_to_pfn(entry) == pte_pfn(saved)) {
+			set_pte_at(vma->vm_mm, addr, slot, saved);
+			return false;
+		}
+	}
+	folio_remove_rmap_pte(folio, pte_page(saved), vma);
+	return true;
+}
+
+/*
+ * Abort one frozen candidate at install time: it took a machine check during the
+ * copy, or some of its slots no longer hold our migration entries.  mmap_read
+ * (held freeze..putback) blocks fork, mremap and munmap, and faults wait on the
+ * migration entries -- but madvise-class operations run under mmap_read too, so a
+ * concurrent MADV_DONTNEED may have zapped frozen slots, and a fault may have
+ * refilled a zapped one.
+ *
+ * Slots still holding our entries are restored from the saved values (no TLB
+ * flush: identical translation).  Foreign slots are left exactly as found --
+ * restoring them would resurrect memory the user zapped -- but their rmap is
+ * dropped here: the zapper fixed up rss for the slots it cleared, yet could not
+ * drop the rmap a frozen source keeps, unlike a migrating one, which unmaps at
+ * freeze time.  Slots with no source follow the same rule with no rmap to drop: a
+ * cleared zeropage is restored only while its slot is still none, and a hole was
+ * never touched at all.
+ *
+ * @pte is NULL when the table itself is gone: a racing whole-table MADV_DONTNEED
+ * zapped every entry, frozen slots included, and the empty-table reclaim
+ * (CONFIG_PT_RECLAIM) freed it, clearing the pmd under the pmd lock and the pte
+ * ptl, neither of which excludes it between our freeze and install.  Every slot
+ * then reads as foreign, which is exactly right: nothing of ours survives to
+ * restore or verify, and what is left is the half of the teardown the zapper
+ * cannot perform for a frozen source -- the kept rmap, the freeze, the folio
+ * locks and the references.  The caller holds no page-table lock in that case,
+ * there being no table to lock.
+ */
+static void collapse_abort_candidate(struct vm_area_struct *vma,
+				     struct collapse_candidate *cand,
+				     pte_t *pte)
+{
+	const unsigned int nr_pages = candidate_nr_pages(cand);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long addr = cand->addr;
+	unsigned int i, nr;
+
+	for (i = 0; i < nr_pages; i += nr, addr += nr * PAGE_SIZE) {
+		pte_t saved = cand->saved_ptes[i];
+		unsigned int k, nr_dropped;
+		struct folio *folio;
+
+		nr = 1;		/* skip stride; a span overrides it */
+		if (pte_none(saved))
+			continue;
+		if (is_zero_pfn(pte_pfn(saved))) {
+			if (pte && pte_none(ptep_get(pte + i)))
+				set_pte_at(mm, addr, pte + i, saved);
+			continue;
+		}
+
+		folio = pte_folio(saved);
+		nr = collapse_saved_span_len(cand, i, nr_pages);
+
+		/*
+		 * Unfreeze before any rmap drop: rmap removal munlocks under
+		 * VM_LOCKED, and munlock_folio() takes a reference a frozen folio
+		 * forbids.  The expected count still holds every slot's mapping
+		 * reference; restored slots keep theirs, and the zapped slots'
+		 * references become ours to drop with the rmap.
+		 */
+		folio_ref_unfreeze(folio, folio_expected_ref_count(folio) + 1);
+
+		nr_dropped = 0;
+		for (k = 0; k < nr; k++) {
+			pte_t *slot = pte ? pte + i + k : NULL;
+
+			nr_dropped += collapse_abort_slot(vma, folio, slot,
+							  addr + k * PAGE_SIZE,
+							  cand->saved_ptes[i + k]);
+		}
+
+		folio_unlock(folio);
+		folio_put_refs(folio, nr_dropped + 1);
+	}
+
+	/*
+	 * Not installed; collapse_finish() releases the destination, which has to
+	 * wait for the ptl to be dropped.
+	 */
+	cand->state = CAND_SKIPPED;
+}
+
+/*
+ * Nothing may have shifted under the round: every source slot must still hold our
+ * migration entry, and every slot with no source must still be none -- the freeze
+ * cleared the zeropage ones, so both read as none by then, and a slot some fault
+ * has refilled, with a page or with a zeropage, is not ours to overwrite.
+ * @nr_populated returns how many source-less slots the install is about to make
+ * present, which is rss no zap ever accounted for.
+ */
+static bool collapse_verify_candidate(struct collapse_candidate *cand,
+				      pte_t *pte, unsigned int *nr_populated)
+{
+	const unsigned int nr_pages = candidate_nr_pages(cand);
+	unsigned int k, populated = 0;
+
+	for (k = 0; k < nr_pages; k++) {
+		pte_t live = ptep_get(pte + k);
+		softleaf_t entry;
+
+		if (pte_none_or_zero(cand->saved_ptes[k])) {
+			if (!pte_none(live))
+				return false;
+			populated++;
+			continue;
+		}
+
+		entry = softleaf_from_pte(live);
+		if (!softleaf_is_migration(entry) ||
+		    softleaf_to_pfn(entry) != pte_pfn(cand->saved_ptes[k]))
+			return false;
+	}
+	*nr_populated = populated;
+	return true;
+}
+
+/*
+ * The PMD terminal layer: verify, detach the table, deposit a fresh one and
+ * install the leaf, as one atomic section under the pmd lock.  A pmd_none window
+ * never exists -- faults stay held at pte level by the migration entries
+ * throughout -- which is what lets PMD collapse run under mmap_read like the rest
+ * of the engine.
+ */
+static void collapse_install_pmd(struct vm_area_struct *vma,
+				 struct collapse_control *cc, pmd_t *pmd)
+{
+}
+
 /* Publish each destination folio in place of the sources it replaces */
 static void collapse_install(struct vm_area_struct *vma,
 			     struct collapse_control *cc, pmd_t *pmd)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *pte, *table;
+	spinlock_t *ptl;
+	unsigned int i;
+
+	if (is_pmd_order(cc->candidates[0].order)) {
+		/* A PMD candidate fills the slot pool: always alone */
+		VM_WARN_ON_ONCE(cc->nr_candidates != 1);
+		collapse_install_pmd(vma, cc, pmd);
+		return;
+	}
+
+	pte = pte_offset_map_lock(mm, pmd, cc->candidates[0].addr, &ptl);
+	if (!pte) {
+		/*
+		 * Table gone under us (see collapse_abort_candidate() on @pte).
+		 * Tear down every frozen candidate -- stranding them would leak
+		 * frozen, locked sources.
+		 */
+		for (i = 0; i < cc->nr_candidates; i++) {
+			struct collapse_candidate *cand = &cc->candidates[i];
+
+			if (cand->state != CAND_FROZEN)
+				continue;
+
+			cand->result = SCAN_NO_PTE_TABLE;
+			collapse_abort_candidate(vma, cand, NULL);
+		}
+		return;
+	}
+	table = pte - pte_index(cc->candidates[0].addr);
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		pte_t *cand_pte = table + pte_index(cand->addr);
+		unsigned int nr_populated;
+
+		if (cand->state != CAND_FROZEN)
+			continue;
+
+		if (cand->result != SCAN_SUCCEED) {
+			/* Machine check during the copy */
+			collapse_abort_candidate(vma, cand, cand_pte);
+			continue;
+		}
+
+		/* No destination: the provision pass could not spare one */
+		if (!cand->new_folio) {
+			collapse_abort_candidate(vma, cand, cand_pte);
+			continue;
+		}
+
+		if (!collapse_verify_candidate(cand, cand_pte, &nr_populated)) {
+			cand->result = SCAN_PTE_NON_PRESENT;
+			collapse_abort_candidate(vma, cand, cand_pte);
+			continue;
+		}
+
+		/*
+		 * The smp_wmb() in __folio_mark_uptodate() orders the copied
+		 * data before the set_ptes() that publishes it.
+		 */
+		__folio_mark_uptodate(cand->new_folio);
+		map_anon_folio_pte_nopf(cand->new_folio, cand_pte, vma,
+					cand->addr, /*uffd_wp=*/ false);
+
+		/* Slots with no source gain anon memory that no zap accounted */
+		if (nr_populated)
+			add_mm_counter(mm, MM_ANONPAGES, nr_populated);
+		cand->new_folio = NULL;	/* ownership: the mappings */
+		cand->state = CAND_INSTALLED;
+	}
+
+	pte_unmap_unlock(pte, ptl);
 }
 
 /*
-- 
2.54.0

