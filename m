Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179873E6DEB;
	Sun, 16 Aug 2026 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920408; cv=none; b=RdRkakeMwXdPxdK8Jzr/Z7i/uGk2dTKvS8m4iQbKJgWGOnrhO7v9jexXgArBDyxJXnCzKU/CgHc0MPI0PC8rmY/l0HbpoZb/yJGNu1RWrbT2ifpAajtXNQVB8VJ/PWhfq+FAnFDPJAX2X9Q8bAodulaR0CJ4XveImplVB0pGBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920408; c=relaxed/simple;
	bh=/K3P6R1c6Qu5CInX6Cpfv/h92w0mnXi7XhwPhrHaGMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMLMmhT/cDI2txVFIdvR9QEuHLiVWucgDeB4QvB3B87+xYbRDfM7Pm10geXkmniUfnv8FHkDLqYNiBKGg78OwSlbBLb4JDbu8cpoPDa62P/Cnd5nSMh32J2Gqpg+u1rY2nTtLJPOZnQ1bNO0ZXg6vy26tayd4LB2CYE9+xwbXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QnZ21ipj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4kNWgV5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QnZ21ipj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4kNWgV5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 565A2EC0235;
	Sun, 16 Aug 2026 18:46:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Aug 2026 18:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920406; x=
	1787006806; bh=Zb85UJztHw3JA3M5nAcJSta5reetpMNqLHuRgU9BdLM=; b=Q
	nZ21ipjWyUd1eTzzivOv25KHiP7Eif0HV83n0n76FZgkJBH6+QvBb4xClRCGXMnS
	/1usaiI3/SVFdUYQL/Y0lBSKJXTrOtsyDZbrMkmvbSCfKBZ58m4FkBDECYTznHzW
	Ls0UUc9z4e1xXRqRjuMH7XFS2WnnPTGiLfcO3RzvifEKwKTxIZIkE+dczzErsp1M
	c83n2PCDsCn3l0FWooOP79bWMzGi0P3H1QJG5P3tYVXSdn2rrvxQwc0j5Fn7bMEr
	4/MrU7C8fsA4QNRGJJHOkBQKlXVdD+Hh/u3hdv8YRK2PjCbg1kkua2a3ICnKe1Wz
	hSPehFdTlVHRQAwbXWegQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920406; x=1787006806; bh=Z
	b85UJztHw3JA3M5nAcJSta5reetpMNqLHuRgU9BdLM=; b=R4kNWgV5fZmKgUlpr
	VjmQn+JP7FviQCcDn28QUyNuwhM85o4fAd0O/fHnZuoI0sSQixUZcOcmEL/KQWkM
	fwRXn33cAJs/eephI5MhnL4XxHxfKAGXfEc434m/am9BL4I32nFrUvIRUauRf6i6
	VjFEFqoxOQ7BdsPVOykihOBblKf9u5dF8K3vH6QoNOSTFXi+Fa+OzL7/2RFeRmMS
	pubFQZ/vEE6gyXeEJKhI+84AKASvOQyvCIhRe48rRddiwCzUVaDQDOF/TRSjFYZV
	84BThpWufY3vwLpJ0HT+tVr6J1PJA5MeMFNWLCJWOsXUhK4/8zsCB6atewy2N4BY
	wUnHw==
X-ME-Sender: <xms:1j2CaqhEqXHYPSmb7NS6ilO_OJzVa4emMuvTimKFtwd-nAMvcpvwBA>
    <xme:1j2CagVhFD7ohDps8KcOABZCN1Nb_viy_barrusV5GcKnzFgZURuDZpk2dNwAcotw
    nhDwWXNyfx8RrfDVMiJC2u5wNLHocW52w9JRgxf312vL-5c1S5UaPWZ>
X-ME-Received: <xmr:1j2CauLEQeHFku0kWS3awP0kqdlJhoE-_2YmDkbMdqpH6DhPqfwpZPOQ_KE>
X-ME-Proxy-Cause: dmFkZTGZUkmTslnKCs7to/74HclCJPP3VJxScbqVRegQUfOCFxFw5+bolWK/BzCtVpImiL
    qUoqqipYizGRZCW/QqKQsGuW1r9sawcQpPF5VVSsi50rSl4WY0FgsqPmgyX/AxTqnJEEYU
    8Aue+P7bmaQGut7CVp7DLPD3XZ1358Jxa/HMzcUO0c1V9QHT5rZ20To/M+ZhpArhbl8m0P
    Kq0bqT8wsLV5YFfKRlZGuKUSK+HqUMNqsCZaBBL3myYMmQW6NzFzYcenzms/0bYbquZQOj
    9ZI8n0ygmC7ceV93VHQH0DqBIBjKEWMiIDR7rGwkZoIdDy7gnvFabP0Z+vKHmdDDitqQqZ
    tnV91u4h5K8w3szoc0CCzwSVWOhiy31U0B+5LNf/lg0QTvO5tj8OdzdB8c1mzTelhoi0DE
    xMiHzh181hdhcz6Ku3Nes2jBg2hmcAGZG7+cYFgyNqYMHAJ0OLXvd7YW/0gQqp3qiPOoJx
    jxvd3DDT+er8jdLuKwds5D5U1bOBtrVdWkEsRc1yBLDqJIYO5inh9Xwist/oOStMUH4gzs
    sC/8orncApMqn+fYpCDusfC6dnceyI+4OYMdo9lPMUkgKfWy4bJjozpfCzIUvCXW/4evxn
    1kyBXjfE1ghcPqncM3U/d9NxCLKqAYWbIW2WxC/1Qff2w+GR1fXobzTK7EOg
X-ME-Proxy: <xmx:1j2Cav3CyFl5atEbToC4zl8tMTwXsHRDMO4ONGqZ6SUXIIMus5YAwg>
    <xmx:1j2CauCUR8BFSB6Nhfuryipx0tzBV_ScsPukcAa2VdW3HmWpZ28cpw>
    <xmx:1j2CarfBvLwnBPnLEO5gEz__TAtpz8FfdyPa_pObKoiDVZCzy04Cmg>
    <xmx:1j2Capw55ZWKlYKemr1gViSRXus4fxRIZIdl7YYOcNYDZmm-lG5T3g>
    <xmx:1j2CakBrhcj9g5LAJiqz72Kgp6jUDilpBgM3NbbeHHSLHahBrkyVaUyK>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:45 -0400 (EDT)
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
Subject: [RFC PATCH 14/57] mm/collapse: fault the sources in before the freeze
Date: Sun, 16 Aug 2026 23:45:26 +0100
Message-ID: <20260816224609.308019-15-kirill@shutemov.name>
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

Fill in the pass that makes the sources fit to freeze.  The freeze takes
the PTEs as it finds them and cannot fault, so before it starts every slot
a candidate covers has to be a hole, the zeropage, or a present page this
mm owns exclusively.

Walk each candidate slot by slot and let the fault path do the work: a
swap entry is read back in, a page shared with a fork child is unshared in
place.

Exclusivity is tested with PageAnonExclusive() rather than by asking
whether the folio looks shared.  They are not the same test.  A page whose
fork co-mapper has exited is mapped once and looks unshared, but stays
non-exclusive until some write reuses it, so a sharing test would skip the
unshare on exactly the pages that need one.

Each address gets a few tries, since an unshare can lose a race with a
co-mapper and a swap read can be interrupted; the PTE is re-read after
every fault.  What is still unfit after that is left to the freeze, which
refuses it.

Swap-in is refused outright below the PMD order, where reading pages back
to build an mTHP is not worth the latency.  That verdict is against the
one candidate, which is skipped so the rest of the batch can go on.

The pass sleeps, and on failure it returns with mmap_lock already dropped,
since the fault path may drop it and the caller cannot tell which case
happened.

A fault that has to wait for a swap read is one of those: it drops the
lock and returns VM_FAULT_RETRY, which says nothing about the window it
was working on.  Report it as SCAN_LOCK_DROPPED, so the round can take the
lock and run the pass again rather than treat it as a refusal.  Reporting
it as SCAN_PAGE_LOCK made it indistinguishable in a trace from a folio
someone else had locked.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index 1367ade721f7..4ec02071f588 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -153,6 +153,11 @@ static unsigned long candidate_end(const struct collapse_candidate *cand)
 	return candidate_start(cand) + candidate_size(cand);
 }
 
+static unsigned int candidate_nr_pages(const struct collapse_candidate *cand)
+{
+	return 1U << cand->order;
+}
+
 /* Where a candidate sits in the table, in the PTE offsets selection counts in */
 static unsigned int candidate_offset(const struct collapse_candidate *cand,
 				     unsigned long pmd_addr)
@@ -242,6 +247,93 @@ static enum scan_result collapse_revalidate(struct vm_area_struct *vma,
 	return SCAN_SUCCEED;
 }
 
+/*
+ * Faults one address may take before the freeze is left to judge it.  More than
+ * one because the unshare can race a co-mapper re-sharing the page, and a swap
+ * read can be interrupted; each try re-reads the PTE to see where it stands.
+ */
+#define COLLAPSE_FAULTIN_TRIES	3
+
+/*
+ * Bring one address to a state the freeze will accept: present, and exclusive if
+ * it is anonymous.  Returns with mmap_lock dropped on every failure, because the
+ * fault path may drop it and the caller cannot tell which case it is in.
+ *
+ * SCAN_EXCEED_SWAP_PTE is the exception: it is a verdict on this candidate
+ * rather than on the round, nothing was faulted to reach it, and it keeps the
+ * lock so the caller can refuse this candidate and carry on with the rest.
+ */
+static enum scan_result collapse_faultin_addr(struct vm_area_struct *vma,
+					      struct collapse_candidate *cand,
+					      pmd_t *pmd, unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	const unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_UNSHARE |
+		(mm != current->mm ? FAULT_FLAG_REMOTE : 0);
+	unsigned int tries;
+
+	for (tries = 0; tries <= COLLAPSE_FAULTIN_TRIES; tries++) {
+		struct page *page;
+		pte_t ptent, *pte;
+		vm_fault_t ret;
+
+		pte = pte_offset_map(pmd, addr);
+		if (!pte) {
+			mmap_read_unlock(mm);
+			return SCAN_NO_PTE_TABLE;
+		}
+		ptent = ptep_get_lockless(pte);
+		pte_unmap(pte);
+
+		/* A hole or the zeropage is population's business */
+		if (pte_none_or_zero(ptent))
+			break;
+
+		if (pte_present(ptent)) {
+			page = vm_normal_page(vma, addr, ptent);
+
+			/*
+			 * PageAnonExclusive is the invariant the freeze relies
+			 * on, and the only exact test for it.  Testing sharing
+			 * with folio_maybe_mapped_shared() is not the same: a
+			 * page whose fork co-mapper has gone away is
+			 * single-mapped, yet stays non-exclusive until a write
+			 * reuses it, so sharing would skip the unshare on
+			 * exactly the pages that need it.  Unsharing one of
+			 * those is cheap -- it reuses the page in place and
+			 * just sets the bit.
+			 */
+			if (!page || !folio_test_anon(page_folio(page)) ||
+			    PageAnonExclusive(page))
+				break;		/* already exclusive */
+		} else if (!is_pmd_order(cand->order)) {
+			/* Sub-PMD collapse does not fault swap in */
+			count_mthp_stat(cand->order,
+					MTHP_STAT_COLLAPSE_EXCEED_SWAP);
+			return SCAN_EXCEED_SWAP_PTE;
+		}
+
+		if (tries == COLLAPSE_FAULTIN_TRIES)
+			break;		/* the freeze refuses it if still unfit */
+
+		/* Only swap or shared PTEs reach here; the rest broke out */
+		ret = handle_mm_fault(vma, addr, flags, NULL);
+		/*
+		 * Not a verdict on this window: the fault dropped the lock to
+		 * wait, which is what a swap-in normally does.  Distinct from
+		 * SCAN_PAGE_LOCK, a folio someone else holds locked.
+		 */
+		if (ret & VM_FAULT_RETRY)
+			return SCAN_LOCK_DROPPED;
+		if (ret & VM_FAULT_ERROR) {
+			mmap_read_unlock(mm);
+			return SCAN_FAIL;
+		}
+	}
+
+	return SCAN_SUCCEED;
+}
+
 /*
  * Make every source the round needs present and exclusively owned by this mm,
  * by faulting it in as an ordinary access would.  Sleeps, and drops mmap_lock on
@@ -255,7 +347,43 @@ static enum scan_result collapse_faultin(struct vm_area_struct *vma,
 					 struct collapse_control *cc,
 					 pmd_t *pmd)
 {
-	return SCAN_SUCCEED;
+	enum scan_result result = SCAN_SUCCEED;
+	unsigned int i;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		unsigned long addr;
+		unsigned int j;
+
+		if (cand->state != CAND_SELECTED)
+			continue;
+
+		for (j = 0, addr = cand->addr;
+		     j < candidate_nr_pages(cand);
+		     j++, addr += PAGE_SIZE) {
+			enum scan_result r;
+
+			r = collapse_faultin_addr(vma, cand, pmd, addr);
+			/*
+			 * The one failure that judges this candidate rather
+			 * than the round, and so the one that leaves the lock
+			 * in our hands: refuse it and go on to the next.
+			 * Failing the round here would lower the order of every
+			 * candidate it carries, a verdict nobody reached.
+			 */
+			if (r == SCAN_EXCEED_SWAP_PTE) {
+				cand->state = CAND_SKIPPED;
+				cand->result = r;
+				break;
+			}
+			if (r != SCAN_SUCCEED) {
+				result = r;
+				goto out;
+			}
+		}
+	}
+out:
+	return result;
 }
 
 /*
-- 
2.54.0

