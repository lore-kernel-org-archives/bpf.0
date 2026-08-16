Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00A3DD85E;
	Sun, 16 Aug 2026 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920382; cv=none; b=KRjSUDvBL2DMXlcqzPjVNW8idU0aS3jUOyCnb0TInWlojAJtRz1dGAXb5LdXJbInjTPenv3L3YDMyha0DJ/+b+tDBCO7kUxkoG50OzqXD3zHUep8zF6O68VKDQu0syR/dTey0bl0hFDb/haGzzOf00LriYUqr46NrTGm6+v6xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920382; c=relaxed/simple;
	bh=uXb/VQqMucbwkmnH4eFidoCTDJAJTdRCAblD3zMVaKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp7RHL4NQFZMsQ9gwoL0hcVLN2CBVUsJeFZ2SM/6spGlyshFTXsf8KOZX7UtzXDNKnR9Jm5ShDihJkwAl7FXuTfzj2QNemD3rEEn9TBvBIXyOqdSndYIu6jZG0gfBFBXEe1KNjKqesu02todyEPAdHL1RLT9rPGqol0NQeqYfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RILNZ87d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7qFUhb6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RILNZ87d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7qFUhb6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 06489EC023D;
	Sun, 16 Aug 2026 18:46:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920380; x=
	1787006780; bh=sX7WB2eZz/VvYH3aSWITi7MLh+xZLicHniz1/7X+rUM=; b=R
	ILNZ87d+g1/9s1nbp82zB0mI4PrI+aktWEf19zi+pWENoo504d2e67BbgSEUH6Nh
	+NBa4zJFPaG12uZGaPW4XrJXO0eEX+8Lg1Cy9Bp7+wV1/07dGfmCj0S6ipGlpApy
	WybuVu60UGDbCSiUplMpZNqy45VWbEVnD25wsuy2KT2CPoA4pQLtwRU8X78rsSoe
	mP7YNcx4NV5pgX4otjGJ4Y7EICNj2IZ2LvoTvZFbifmEKIC5cZJ43SVA5j6zcvGD
	4Jpj5kdf8Gc09S3GmC921A5yjLuKYtydZ6Jfu3OarGHGS8GVsV3ZmWLCGYyExUns
	0oWdnpQgbBMs8cBIiGIIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920380; x=1787006780; bh=s
	X7WB2eZz/VvYH3aSWITi7MLh+xZLicHniz1/7X+rUM=; b=G7qFUhb6XtMIDY+Dr
	IW8SlbfgnPxQU0iMmKxXfLrX3fjUTufNyA8tSPbN91rcCuLXb6JNRrJYcpPkPWtL
	1v8r3662BieAIRUlD+PHAssmKR5pI3lmKJ0ejf+o89hwRyeor/7twEGVyjgLMshP
	5QoEHyPKeI+EMWyxu7ycHjmChYeh87Sa4/AvY84Ha5aKqo5xWjd0NXz/FWQBKQv9
	vG/jdqKR74QwZkCE5PDm/ciExeiC5xlO3XWDa3Qk3wj9vaMIQQpA2Lai3fihj7Aw
	5DeKbhWSC6fJBYTBZZp/cfRYSiDMlb1qpjq9OuGRiT32njRrgWFU9EaHpLqdjCQu
	orl5g==
X-ME-Sender: <xms:uz2CakEmzNk2CPTbiE2p1Byv4N8090nhPr7d_YuApe2SgB8knly4yg>
    <xme:uz2CairlqZLTTBJYJ4VrQauedIABhYQaIRNCO62bCUIV0LgYMQy2vOz1HC8o1Re9r
    bmqltBJD1n7_6Yrt7TXcaf-XC9h-4BezSbSUM9vn4_q9DssgnBW-mu9>
X-ME-Received: <xmr:uz2CaqNGwCHeKc0NxfFeDto6tdodDKr0FXnF96HvYGPhfJWx52jkqadUNy0>
X-ME-Proxy-Cause: dmFkZTGQiHMMNOd1xnoN6lXQSIrGAe7MwYo75Qud3VSOh3aIjL1T4IX+wE1i/v23Y8aWnG
    m9SHT5inuXsr6fNeLF7q+XcMZ+pkZJxjpb2XQQyKrFdYKaLz7QDFEiegvQaT+Y5rGxRgjF
    euipinLXiFMtCpFgMqQP9Dwn4SHq3YG285QsMU4KB7YfRQHYWKIG6dJTmdP/7bPKv1qUNe
    3LkhBXaaROXWrLGafj+UVrogU8Abxo2OvgWTBKIlLl3SY5Eb27sggkfdoaZJgpjY1+W5mK
    IYgTH3bmg7umgeRjJmx+WAhyhWPmGn2xLzWKHa3nzXVCTdFk2+6Uh9D41+s+1+4ThvFtH3
    TF5+acMZn3V2kyzNvRs++91DDKXew9DYXOyEQix+jcX2Yij4aOpcXX1d7+cQnG8rqBXUZ5
    POE9MfSwpz6o4uAqku2Fk/mui8mjbSq4sgrrfJ+vkfJ6Gp+5/Bhn9p5+re7C/IRKkDU64g
    4gbmTiwk8a0UUO+c+nDCpdr//c0KoiHipv/SLkGJBqgqUoywz38yFC3hmxePXhxAL6C77x
    TfWIxre0e4oICcETnXmhzjHmjO1hlQKMhyWrsIDHJfM6eV52F0dmFRugg7H7QTaq+6wnvn
    8Y57Fn2WiXpOTE/0ip6GJbvB75qJpCu/Yb2+Z3gdqHLrT5wlQqTjYKWRTCaQ
X-ME-Proxy: <xmx:uz2CaipoJXTFDXkuwZj1uFSh_9I8eKDcSGKqWeJVNjG4Zp5KvZcvjA>
    <xmx:uz2CaglXnIGPtxRjsFxz_y64AByVYWGM-8laWgS0qj7avM6dVLVhLQ>
    <xmx:uz2CaixDEMCJHpVoUJYDlSK9ZevANwVMf4Jp2VlOgzMQR1C00x_bsQ>
    <xmx:uz2Cam12ntRCaV_TLfAUU_2XLugHy7igBSV4aGax3mpurH9pfZyxLA>
    <xmx:vD2CaqFjDp0eRK0GWALfB12xcqHeQP7NPeZjtgLVwFOlVzq_CJ3sL7pj>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:18 -0400 (EDT)
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
Subject: [RFC PATCH 01/57] mm: add pte_folio()
Date: Sun, 16 Aug 2026 23:45:13 +0100
Message-ID: <20260816224609.308019-2-kirill@shutemov.name>
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

Callers that want the folio behind a present PTE spell it out as
page_folio(pte_page(pte)).

Add pte_folio() as the folio companion to pte_page(), and convert the
callers in fs/proc/task_mmu.c and mm/hugetlb.c.

Preparation for the anonymous collapse engine, which reads the folio
behind a PTE in several places.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c |  4 ++--
 include/linux/mm.h | 14 ++++++++++++++
 mm/hugetlb.c       |  8 ++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..459c779b8141 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1277,7 +1277,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
 	ptent = huge_ptep_get(walk->mm, addr, pte);
 	if (pte_present(ptent)) {
-		folio = page_folio(pte_page(ptent));
+		folio = pte_folio(ptent);
 		present = true;
 	} else {
 		const softleaf_t entry = softleaf_from_pte(ptent);
@@ -2227,7 +2227,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, ptep);
 	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
-		struct folio *folio = page_folio(pte_page(pte));
+		struct folio *folio = pte_folio(pte);
 
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0829e0d3b2d1..eb44e3dfee09 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2681,6 +2681,20 @@ static inline pte_t mk_pte(const struct page *page, pgprot_t pgprot)
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
 
+/**
+ * pte_folio - Return the folio mapped by a present PTE.
+ * @pte: A present page table entry.
+ *
+ * The folio companion to pte_page(); only meaningful for a present PTE
+ * that maps a struct-page-backed folio.
+ *
+ * Return: The folio containing the page @pte maps.
+ */
+static inline struct folio *pte_folio(pte_t pte)
+{
+	return page_folio(pte_page(pte));
+}
+
 /**
  * folio_mk_pte - Create a PTE for this folio
  * @folio: The folio to create a PTE for
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dded1768193a..bceab8e14118 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5280,7 +5280,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * are about to unmap is the actual folio of interest.
 		 */
 		if (folio_provided) {
-			if (folio != page_folio(pte_page(pte))) {
+			if (folio != pte_folio(pte)) {
 				spin_unlock(ptl);
 				continue;
 			}
@@ -5291,7 +5291,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 */
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		} else {
-			folio = page_folio(pte_page(pte));
+			folio = pte_folio(pte);
 		}
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
@@ -5514,7 +5514,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
 		return 0;
 	}
 
-	old_folio = page_folio(pte_page(pte));
+	old_folio = pte_folio(pte);
 
 	delayacct_wpcopy_start();
 
@@ -6189,7 +6189,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * checks whether we can re-use the folio exclusively
 			 * for us in case we are the only user of it.
 			 */
-			folio = page_folio(pte_page(vmf.orig_pte));
+			folio = pte_folio(vmf.orig_pte);
 			if (folio_test_anon(folio) && !folio_trylock(folio)) {
 				need_wait_lock = true;
 				goto out_ptl;
-- 
2.54.0

