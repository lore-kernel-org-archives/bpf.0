Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2A3E8351;
	Sun, 16 Aug 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920418; cv=none; b=bddbJHmQzxEAd7CRYlQoFuHoKcF66QkkDvSjj/b9pDg2ZsjkGNT6rCUE7VFM20YfkIoQNR9JSD4q0DjPNmJ87fTAEIy5QQaXUjTtgCsqgw44LMFua3CLjeYk0BTu+Frbiq3ldUeujRfna3QdgErqjKK53lkxYV362R1jOpg0Yfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920418; c=relaxed/simple;
	bh=2TaYaTaJG3DUEb+2Yt76ZzAIWLcNA7Ing2Udv2Pjyjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE+hf0FtC8/05lViWnPDQGUYt3RKH24/lJ0qKObl+bVhyNhuFcF9VCdqvvUK0IJBiAPJCB5xWpSVGs5ah69XpPWstKSeli5UN8ieeL7lAor8IQEohk9+vW9XK4Bm3+rdXMQX6eKpDGbpvjxeAEzJ9Fiweb7osYS7/iTLCRE7xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=sKocDFEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pn8FC+cK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="sKocDFEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pn8FC+cK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3831214000FE;
	Sun, 16 Aug 2026 18:46:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 18:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920415; x=
	1787006815; bh=QHqKPBFVnTs29f21vr16ac6OAqWm4F4NnweEXoqIRdA=; b=s
	KocDFEWxrud+mkbmUPVtPbiu+43Yn2FKamFIEZsI8h1/8zMn+TOqdH179ImZq0r6
	cWYLXuGvF1fkFRAMw4ywLXI+WzpZcgVRCKxenmyXvhuDoXTXJXsA9giezG4P5EfC
	kvOWiCXvcK3ShC6M7rvmIKTUWXLmjF1JntkGSBWhMTWESJRubIGqMQMcqtRWRaL8
	9peyASLhyFQinM7O7SL7VGdgkjfHx4lPSK3KXyx4bBUYNyFmzhrQmx6Cg5Dr+aMh
	rDPQ4jPr/FWiaQ6xmdcaIRMUYuCycuG1ESU2mCHfYEeod50x5/CwPCT0BCaTj61k
	ZTB3rAabkvnyWmH3sM+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920415; x=1787006815; bh=Q
	HqKPBFVnTs29f21vr16ac6OAqWm4F4NnweEXoqIRdA=; b=Pn8FC+cK/ZMRgElW7
	Y2ryQGC/MlYol41rOcraOqvuS9tz98JDGzwqcbpAN6+cKxWG1j2SGamTMSQVKThD
	La/KjzbQXBrOfCGFhuvPaOiD1uZYMpPEo7m86OchlgTRnbeuayAKCcOOEpJpPFt5
	XI7W8XMlZg21XxckGOwcigBZBtAGfIwjtrc4vORVl2Aro+aPusKxCJzoULKTIW76
	sHInn6i8JGuaQDvSZGcuDEMUgyU1tNZKrtiJosDCJeUrSXwF41nK8zrM8l32Sclh
	9P/gAxclYtIliRvNM4e/pMEN8wUTumUoIl5D5Jqu3yChwWC7rMlWJaA1/7BhzbE+
	uKeQg==
X-ME-Sender: <xms:3z2CaoaX1k-LNAXM39Eo2aKqRk5KN7Cew2Q4sgQIJveUgc5djWoDyQ>
    <xme:3z2CaosdfHihshqhl023_YPBFo6fJx6Thvo29fNHz3Sg132AwvDpwaDw2FALR7Fsg
    u7bSiMtvm8AMCQtWDe1yX23RRF0Q6lalWcP_IePOC-eSLdJS61XqRg>
X-ME-Received: <xmr:3z2CavBtVfKIoZlcw6TPUFq4QpB8VMskDEmXllYhNWZv2Z0OI1M9vQ6ZwXg>
X-ME-Proxy-Cause: dmFkZTGU6CsvhMdBtF1sno4coJRY9LqZz27w5X62/KcvcmaHPoOW0E1BwYMGQvImxADkeF
    Vrd/NWvQclh95CfVK4mxB+x5IwibSBkynFlxvp5GF5/z4jepOu57IyLHUvB8DzXymwpMun
    cyoWwWLP4hjAaD7bSTsoDmYKe03ryBERSg0IuR8ZqJolHrsaFnqWf5mL2byVsL9qLL9zPI
    9yLFlvwwZlCiJbT4IVFlRVV/9A2lZNuDFrGWvpQWw3cjqX9EcFrpnMQcn/0MdQygQWXSYC
    yXHZy2pRvgBssh5qObsL1GM1XSEE6m2uHX2m5CwJlvTSIfOodU1appS1XFI/CBVlhtQ7CF
    ULG6OtC6a1s/NmdMZEoDsIJcrpBkdRdhXB11gNV50z2d4E/iJeXml3T3h/o0H7gU+64vOP
    PqPDa4EdcFe/rGNcm71i1IAqWlLhpil33moV0JBcgZQm9qfgBsqf0h59iIN1pPwwFe7xeZ
    P7twIKhdh+uX1rwSO+SB2Ua/tk/l9fjmZe+S/3gFTdptk2aaquAFLmgWmNltN4ZZAqkppG
    LpcqV7O4OtJwJTFWHt0SRtr6RBcJbb1AY6je6ZAylypaQl8WN8RmScIh8gpwmMGiCcQ2r8
    fuizZBKpxbm2PItZCAiLKBTcdO/z5AopY1nNAlm7k36xkZfTwfcgPCHgB6jQ
X-ME-Proxy: <xmx:3z2CavNR8kVdJNi9TH89lhcQ4TkpDFzBq25DfoaynU7Hn_5mSy0qFA>
    <xmx:3z2Cap53MsPQrKejKa8zra3I3QJGYB1ma_ErPALcWlGyEPZ0mHViqA>
    <xmx:3z2Cap0Ans1JV1ex615QjDXgOUsZs0E66ReSPF7luoyvvRSyvwwvSw>
    <xmx:3z2CaoqlV5Q8E9NJkzhNZaF66eQmk43LzQJInV9_Nkk30ZoMeBIBMQ>
    <xmx:3z2CascBTPNqFGz0uu4-_o7y928VHQ9qIWlb4YONvafw_9Te3AxuxTXu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:54 -0400 (EDT)
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
Subject: [RFC PATCH 19/57] mm/collapse: install a PMD leaf as the terminal layer
Date: Sun, 16 Aug 2026 23:45:31 +0100
Message-ID: <20260816224609.308019-20-kirill@shutemov.name>
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

Fill in the PMD install.  Under the pmd lock, with the pte ptl nested
inside it: verify, detach the table with pmdp_collapse_flush(), deposit a
fresh one and map the leaf.

That is one atomic section, so no pmd_none() window ever exists: faults
stay held down at pte level by the migration entries throughout.  It is
what lets PMD collapse run under mmap_read like everything else here.

Two things force that nesting, which is the one the tree already uses to
reinstall a table.  A racing zap of a frozen entry takes the pte ptl, so
the verify has to hold it.  And the table must not come apart between
verify and detach, which is the pmd lock's job.

Nothing leaves the section early, aborts included.  An abort only
restores PTEs and would need no pmd-level exclusion of its own, except
that its pte pointer came from pte_offset_map_rw_nolock(), whose caller
must establish that the pmd is stable.

The deposited table is the freshly allocated one, never the table just
detached.  A deposited table has to be quiescent, because whoever
withdraws it frees it immediately with nothing to hold a lockless walker
off first, and a table that has never been reachable is quiescent by
construction.

The detached one is not: GUP-fast and RCU pte walks that read the old PMD
may still be inside it, and on broadcast-TLBI architectures the flush
expels nobody.  Quiescing it would need an IPI, which has nowhere to go
here -- outside the pmd lock it opens the pmd_none() window this design
does not have, inside it is a broadcast under a spinlock.  So the
detached table goes to pte_free_defer(), which holds the free until those
walkers finish.  One transient table page per PMD collapse is the cost.

No anon_vma_lock_write() is taken, unlike the mechanism being replaced:

 - rmap walks on the sources are unreachable, their refcounts frozen and
   their folio locks held from freeze to putback;
 - non-rmap pte walkers see migration entries;
 - pmd-level observers see either the old table or the leaf, never an
   intermediate;
 - fork, mremap and munmap take mmap_write, which the mmap_read held here
   excludes.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/mm/collapse.c b/mm/collapse.c
index 842adc30aeb0..ab7476471b8d 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -1232,6 +1232,124 @@ static bool collapse_verify_candidate(struct collapse_candidate *cand,
 static void collapse_install_pmd(struct vm_area_struct *vma,
 				 struct collapse_control *cc, pmd_t *pmd)
 {
+	struct collapse_candidate *cand = &cc->candidates[0];
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *pmd_ptl, *pte_ptl;
+	pgtable_t old_table = NULL;
+	unsigned int nr_populated;
+	pmd_t old_pmd, pmdval;
+	pte_t *pte;
+
+	if (cand->state != CAND_FROZEN)
+		return;
+
+	/* No destination: the provision pass could not spare one */
+	if (!cand->new_folio) {
+		pte = pte_offset_map_lock(mm, pmd, cand->addr, &pte_ptl);
+		collapse_abort_candidate(vma, cand, pte);
+		if (pte)
+			pte_unmap_unlock(pte, pte_ptl);
+		return;
+	}
+
+	/*
+	 * The pte ptl nests inside the pmd lock, the nesting the tree already
+	 * uses for reinstalling a table: a racing zap of a frozen entry takes
+	 * the pte ptl, so the verify must hold it, and the table must not come
+	 * apart between verify and detach.  pmd_same() rechecks are unnecessary,
+	 * the pmd lock being held across the whole section.
+	 */
+	pmd_ptl = pmd_lock(mm, pmd);
+	pte = pte_offset_map_rw_nolock(mm, pmd, cand->addr, &pmdval, &pte_ptl);
+	if (!pte) {
+		/* Table gone under us; see collapse_abort_candidate() on @pte */
+		spin_unlock(pmd_ptl);
+		cand->result = SCAN_NO_PTE_TABLE;
+		collapse_abort_candidate(vma, cand, NULL);
+		return;
+	}
+	if (pte_ptl != pmd_ptl)
+		spin_lock_nested(pte_ptl, SINGLE_DEPTH_NESTING);
+
+	/*
+	 * Every exit is inside that section, the aborts as much as the install.
+	 * An abort needs no pmd-level exclusion of its own; it only restores
+	 * PTEs.  But the table it works on came from pte_offset_map_rw_nolock(),
+	 * which leaves its caller to establish that the pmd is stable, and the
+	 * held pmd lock is what does that here.
+	 */
+	if (cand->result != SCAN_SUCCEED) {
+		/* Machine check during the copy */
+		collapse_abort_candidate(vma, cand, pte);
+		goto out_unlock;
+	}
+
+	if (!collapse_verify_candidate(cand, pte, &nr_populated)) {
+		cand->result = SCAN_PTE_NON_PRESENT;
+		collapse_abort_candidate(vma, cand, pte);
+		goto out_unlock;
+	}
+
+	/*
+	 * Nothing fallible sits past here.  No anon_vma_lock_write either: rmap
+	 * walks on the sources are unreachable -- refcounts frozen, folio locks
+	 * held from freeze to putback -- non-rmap pte walkers see migration
+	 * entries, pmd-level observers see the old table or the leaf and never an
+	 * intermediate, and fork, mremap and munmap take mmap_write, which our
+	 * mmap_read excludes.
+	 *
+	 * The flush inside pmdp_collapse_flush() is the round's second over this
+	 * range: the freeze displaced every leaf here and flushed before dropping
+	 * the ptl, and the verify above proved nothing has been mapped since.
+	 * What it covers is the paging-structure caches -- a CPU may still hold
+	 * the pmd-to-table link, for a table that is about to be freed -- which
+	 * is why the helper shoots down a pte range rather than a pmd.
+	 */
+	old_pmd = pmdp_collapse_flush(vma, cand->addr, pmd);
+	old_table = pmd_pgtable(old_pmd);
+
+	/*
+	 * The smp_wmb() in __folio_mark_uptodate() orders the copied data before
+	 * the install below publishes it.
+	 */
+	__folio_mark_uptodate(cand->new_folio);
+
+	/*
+	 * Deposit a freshly allocated table, not the one just detached: a
+	 * deposited table has to be quiescent, because whoever withdraws it frees
+	 * it immediately (zap_huge_pmd()) with nothing to hold a lockless walker
+	 * off first.  A table that has never been reachable is quiescent by
+	 * construction, which is why collapse_alloc() secured one.
+	 *
+	 * The detached table is not.  GUP-fast and RCU pte walks that read the
+	 * old PMD before pmdp_collapse_flush() may still be inside it, and on
+	 * broadcast-TLBI arches that flush expels nobody.  Quiescing it would
+	 * take an IPI (tlb_remove_table_sync_one()), which has nowhere to go
+	 * here: outside the pmd lock it opens a pmd_none window a fault can fill,
+	 * inside it is a broadcast under a spinlock.  So it goes to
+	 * pte_free_defer(), which holds the free until those walkers finish, as
+	 * retract_page_tables() does.  One transient table page per PMD collapse
+	 * is what that costs.
+	 */
+	pgtable_trans_huge_deposit(mm, pmd, cand->deposit);
+	map_anon_folio_pmd_nopf(cand->new_folio, pmd, vma, cand->addr);
+
+	/* Slots with no source gain anon memory that no zap accounted */
+	if (nr_populated)
+		add_mm_counter(mm, MM_ANONPAGES, nr_populated);
+	cand->deposit = NULL;
+	cand->new_folio = NULL;	/* ownership: the mapping */
+	cand->state = CAND_INSTALLED;
+
+out_unlock:
+	if (pte_ptl != pmd_ptl)
+		spin_unlock(pte_ptl);
+	pte_unmap(pte);
+	spin_unlock(pmd_ptl);
+
+	/* The deposit balanced the detached table, so the count is already right */
+	if (old_table)
+		pte_free_defer(mm, old_table);
 }
 
 /* Publish each destination folio in place of the sources it replaces */
-- 
2.54.0

