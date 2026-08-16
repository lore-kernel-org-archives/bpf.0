Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195283E4C98;
	Sun, 16 Aug 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920384; cv=none; b=ANDNHTebJrmVtqjFDtDsfjxTH3T3XsEKyQgv0IcYVijIEXcG3Xbl2DeCJ1fINq1WemNUVaJslXJX1z3M63+Xq9DMQK/DKKySOUruzUuH/meuYYaeBMnkTGZttuzTG36HcourbzJC51Q3RiC8oQHewGhKqLr2iyAYKuNYPpMkQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920384; c=relaxed/simple;
	bh=byyeadpcr8jQv/zrgoLcgfBdxmdzK41O0wjm6ljIN14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC0NdTpBafBbzuDDnaBHMmU3rjsBgpCMlD8LMdA1HgWiV/W2/wzfBYox7kUW3epTgicoFBxF2Iar8T3QwdIJhbBcl3rX/Dy8Zv8eV0aWcmRf/AYKD3MzDSJM2oW7XnWwU9llfPM4o5a7RLgF79XpH6x+/crMpHh9T0/R8KyMilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Nhg7kGbZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OTOxpCzs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Nhg7kGbZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTOxpCzs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C34D14000EB;
	Sun, 16 Aug 2026 18:46:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 18:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920382; x=
	1787006782; bh=BHyFDjIBobrd0qUaPZVYZ0a7uxaNjqw7aneS2s20bwA=; b=N
	hg7kGbZbS1oZ/HPIqYWFxcYj6+ij+hMYs5k9zdJjhEJjcU/ixl6HguJDYdWdoQ3+
	Nt6jnTOJvRz8DUgxKyfoMIHlryxvXrOb4j9v0P1kkEcpWRdYXg3j9gQwJ2KP1iKC
	Sq2iH4w6qvEVoCK/QJaUO2Z0Art2GmZgbABBJGytDptwdY5HZB6GQsiRajt5p/TK
	g/ffFmTeNYdP4t6TMiJLn70tdLsUSDTVFgGiPjsNuE88L0Y2dAmSkVLNVskBgqwx
	cAw/smsPGiDR7mk/8TaOH2griIwparA2ex60KTO71BK1glk9RokcEbb37RxkNc33
	yRRl7VpXXc5qin+OzG0dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920382; x=1787006782; bh=B
	HyFDjIBobrd0qUaPZVYZ0a7uxaNjqw7aneS2s20bwA=; b=OTOxpCzsBncl6WlW4
	ealynY9yom3qEKh/pQa57Bk/qtxumvlHUJ14ThdDJn3Z8RgwBIIQjvx3c3fH8Gi1
	IuKRnf9LeXs/f76M0OT7egu5SahMgoSxSuwtuCw691gjKkdLRViihx6Axp0vd0yr
	TOBmXqmYErCZ5dZVALBuPpDJmnxtfRqLPtycNTDm25KUgEf/DcWIujfGddUF/wXQ
	CRL4Za9072eZQBpzNgLo8MeFQ1+i2deso6Xh181A/vsI4+9OwSfbmBzUYkheDXAS
	CmTtriT9i8WZ4lAfp3Ug8fT39TuRVQzhDJ+uMo45oUM9C+CLqkr1U76wKlFFpNbD
	ewAlA==
X-ME-Sender: <xms:vT2CakN1SZOWRPnh1uZCVAxoSIvYw78A0Dluf85XGkUGRsVCzHNV6w>
    <xme:vT2CagRV2LOvRWYxl_HFtWuJ03Mm8PtJDtVRLK20UPMlhdytwZ7n1lS_y2Alch7Kt
    kiUsw9oKfvRl0YjL5M5BIKheC-R5InANciMFDLMUdUXrbhDphCX8yQ0>
X-ME-Received: <xmr:vT2CanXC-yNiQgz2ib1-HNCf0Qbv34stBlnSwSLHT2yOR5DTZ5Gv7-oVVvU>
X-ME-Proxy-Cause: dmFkZTGQiHMMNOd1xnoN6lXQSIrGAe7MwYo75Qud3VSOh3aIjL1T4IX+wE1i/v23Y8aWnG
    m9SHT5inuXsr6fNeLF7q+XcMZ+pkZJxjpb2XQQyKrFdYKaLz7QDFEiegvQaT+Y5rGxRgjF
    euipinLXiFMtCpFgMqQP9Dwn4SHq3YG285QsMU4KB7YfRQHYWKIG6dJTmdP/7bPKv1qUNe
    3LkhBXaaROXWrLGafj+UVrogU8Abxo2OvgWTBKIlLl3SY5Eb27sggkfdoaZJgpjY1+W5mK
    IYgTH3bmg7umgeRjJmx+WAhyhWPmGn2xLzWKHa3nzXVCTdFk2+6Uh9D41+s+1+4ThvFtOm
    978x7RbxHsQpwvbWpMsc0V7jUKZyBIK4Ghgn899w66TrjufmyMrNztYeOV/7aH+D06vSn2
    fkYq1Xxl4Ay6MsKxqBmUPt0ZykwUxbvAwpCsewJwqFzXlAMjJq9UinsYw26tdhBhGHRVMP
    24ruPq5aepnUmarI0NLCHTFHzAVmtYZHpuoq960eg6QHGBrLQRGlCZFJ4ACdQaf9TQA7JF
    IvIGuBlht/53MNG0pdSU/Y1d4iP+TKdJ1NQMcdleTlUuM1ajYvmJK4vnPYEhwTvaAqWOw0
    gXGr0c98E7XTShO9e4Oi1oOA5heJo91XV4uKcA/woltUTTyD97DvZIT80mYA
X-ME-Proxy: <xmx:vT2CapTMTxrKa_YEhVcDWQiEcCMIFXc5bXQ1S-fgQAbH-wnZFmxZvA>
    <xmx:vT2CaitUmNWg6gy3xKHmpCKG4ehUT7ylWivthpabTFHRiVsln7HE7g>
    <xmx:vT2CaqaWH7_XZQGI6cfXpe6SbrPiC5Z6fPWOHMYfGial11Ggry0RsA>
    <xmx:vT2Cal-dnPPFIujLidgJaUf1xLRVqWKD21IdN1QU_xIGXfWCZGsQ_g>
    <xmx:vj2CauDSOcAxiWOr16lpkn40GSHCGlUi-_Bj82DFTCBzPFIgh-X4AIgE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:21 -0400 (EDT)
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
Subject: [RFC PATCH 02/57] mm: add pte_none_or_zero()
Date: Sun, 16 Aug 2026 23:45:14 +0100
Message-ID: <20260816224609.308019-3-kirill@shutemov.name>
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

A PTE that is none and one that maps the shared zeropage both stand for
a page of zeroes the mapping does not own.  Code that cares only about
the contents can treat the two alike.

Move khugepaged's local helper for that test to pgtable.h, below the
is_zero_pfn() it is built on.

migrate_vma_insert_page() open-codes the same test on the slot it is
about to fill.  Convert it.  It still tells none from the zeropage, but
only to decide whether there is an old mapping to flush.

No functional change intended.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/pgtable.h | 17 +++++++++++++++++
 mm/khugepaged.c         |  7 -------
 mm/migrate_device.c     |  9 ++-------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..bbee6d31f015 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2064,6 +2064,23 @@ static inline struct page *_zero_page(unsigned long addr)
 
 #ifdef CONFIG_MMU
 
+/**
+ * pte_none_or_zero - Does this PTE map nothing, or the shared zeropage?
+ * @pte: The page table entry to test.
+ *
+ * A PTE that is none and one that maps the shared zeropage both stand for a
+ * page of zeroes the mapping does not own, so code that only cares about the
+ * contents can treat them alike.
+ *
+ * Return: %true if @pte is none or maps the shared zeropage.
+ */
+static inline bool pte_none_or_zero(pte_t pte)
+{
+	if (pte_none(pte))
+		return true;
+	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
+}
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5a06e3942e88..5f7126cf42f5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -348,13 +348,6 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
-static bool pte_none_or_zero(pte_t pte)
-{
-	if (pte_none(pte))
-		return true;
-	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
-}
-
 /**
  * collapse_max_ptes_none - Calculate maximum allowed empty PTEs or PTEs mapping
  * the shared zeropage for the given collapse operation.
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9a346162c688..60afa556b994 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1067,14 +1067,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (check_stable_address_space(mm))
 		goto unlock_abort;
 
-	if (pte_present(orig_pte)) {
-		unsigned long pfn = pte_pfn(orig_pte);
-
-		if (!is_zero_pfn(pfn))
-			goto unlock_abort;
-		flush = true;
-	} else if (!pte_none(orig_pte))
+	if (!pte_none_or_zero(orig_pte))
 		goto unlock_abort;
+	flush = pte_present(orig_pte);
 
 	/*
 	 * Check for userfaultfd but do not deliver the fault. Instead,
-- 
2.54.0

