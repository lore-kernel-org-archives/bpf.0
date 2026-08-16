Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD53E3152;
	Sun, 16 Aug 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920388; cv=none; b=eHEI5bOf19EmH2Ixn33lZYNMFe6640HsfCml1s5W5xJAVp6xIN5G7NUMaFRvNFUwe8+TtWhgiFNkFdPty1WiNvJ7M6DdRQFuZV/C311HA0Ei1zK4yfBtewAZ04oRGMaiqOD4iWtsB13uoBuEyxGsmcW38plI6kXsXW45/AwZLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920388; c=relaxed/simple;
	bh=Syuy4JD6Oq0GAssmdTBBD6hlSmTyaCJxJFgG6ptkOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfytTgd5ErwMyF19/eCoGjqKCc6l6OO5EIamxcf7juQaxS2+vWca6Lw3Kmo0h5V9pD7lcuPdvf8QiihGv1pmy0otj+F03h63tdlizByGaAMrt5MzwDblukfpcR6KN1yk3dVL63VcOebl9rHz3wQkNpKydHoaWmZWSHUSlrvwouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=D3Ni3tbJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEPsT0B+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="D3Ni3tbJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEPsT0B+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 91497EC0242;
	Sun, 16 Aug 2026 18:46:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 18:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920385; x=
	1787006785; bh=2u63L0ngEfZ0oZc5UJMeb03US//762Pv3O79FLFlVN8=; b=D
	3Ni3tbJD9MHvRzagaj9i5rQ+7ZHnppGXYfpjw2FMYRVFugWxwF2lndP58rlS8Tkg
	i8BmzBwEv4BnalDdR6aqfy7bXtflnh8yvRW6wN64fynJJmH5QtlpBVF8DFmbl22n
	5CZwd5ICB9pds79B5RXAf1QCr2PVbAF+uGOSrl9bve/wnBQCWKIrnvm6ftSygTN6
	TsNRaGsZ/xSNFSz5/dOPQRxbxcy4WpAP1XQIvtFJ1sNjZHLg7B9Neyz7wCiH86zo
	/jIuqyMr58LpUUuk9WXLnERRSfgWF/F1bFjkKrJXQfIEOqD9e9UUvleg+5Rvrhl5
	3zmzJEeCGEJQhUrwPgT0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920385; x=1787006785; bh=2
	u63L0ngEfZ0oZc5UJMeb03US//762Pv3O79FLFlVN8=; b=cEPsT0B+Xjq4pdpqh
	LRcDAkqohAJ+F3LI8aRpaHyCnmDweNb34uftCX1p0uIJvCRUpmJD0rSOE/RJM2mK
	Phf5Fn/xR9li1nkJDl2nsiHD7b/Xl9WcW1ux9pX5OQ+IHheVJ/WaDVIO9fZ/Sj1o
	pA8bbp883MtVJa8WGyFN1dvm6H8gpFxNYkXNJPZetaNoQ89MHIyzd0uSKjxcDscw
	ACrlaQFWotIay+ZxEl0oGs6DvFLAJlgB0P9Fl0ce87hCDdPzriuoXGfigcurwBcR
	sFzkKM/KGO1leZpLI2e0DVTEnOAIDkEg7z7CtMt3Z8EZZYiufT7pEts8YZboMYUO
	Z5SdA==
X-ME-Sender: <xms:wT2CatT6VVOfaQyi-7v82S6qkb0kuqWgTpb33dJ3KmNPISXD19oAvA>
    <xme:wT2CasF52ZgOP7Wau6vkrK304WJrztDVQSE6ZmZljRZn1xF1_9wUY1GYe3TV1RCWm
    Vo8fAKwRpLaLL1ORL3KlRpEgqeZxLQuOXLacI4rIXxD3JJb1Pa_adQ>
X-ME-Received: <xmr:wT2Cau40tnCFhUsoT4EW18icUYMer9gWKfk7YsFA09QwqcHPeqYXMH7UNy8>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTOe
    O2T+e6i2Gb6iXpx6u856YCM0Twl2zjRv6jsf0mu3PZPrhPjoJp43+TcgdmbLSiZaIa3ttT
    Xtv3uffV61LDU9Bxx8ngiLZEpCG/jF7lw3dGmsuX6sYHJKahwa5GXZ9nam8ziMSeI1kra1
    48PX9SyKC5GvF0rAs+rjraJErRymPbrT3FHL6+nlhWTPQ1cNs+YTdOTsO+Dl3vMKOgjwoZ
    DqQuTq/btPOXP6J7W2Wo+83UdwvraRj7Hw3QYH/7wgDoOk1mjJLYwF0YAfuJAnZePL/9ld
    8D3vhPzRY4A8pdb3x4tFK7UN0/lbov4pDTOoRfRpRgcix+lPNecjcwqamMUA
X-ME-Proxy: <xmx:wT2CahlAF74-b50w1H4nUKOFfjdXf9JX7zz9m6hvZZ8-f8a58wODfA>
    <xmx:wT2CaswB6pcgyFhBUizUKRKVz7yW8Q3nkZDyP8Ps4_XPvbXZZ_eDAw>
    <xmx:wT2CajMqUYwQ0Y3Xe18XWCz38p9mRLctkWt7bQnPttHlCEIdH3Qn-w>
    <xmx:wT2CamgeRSgLN_UOqFqPwK4aKJ9ENYFCGv-buMiBGf_UEjdRbPoj2g>
    <xmx:wT2Car3TcRplushI8ivcH2lATUhKbDMvc90CJFl4CdcfbtDHTYOD4WC9>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:24 -0400 (EDT)
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
Subject: [RFC PATCH 04/57] mm/collapse: rename mthp_present_ptes to eligible_ptes
Date: Sun, 16 Aug 2026 23:45:16 +0100
Message-ID: <20260816224609.308019-5-kirill@shutemov.name>
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

Neither half of the name holds.  A bit is set only after the PTE has
passed every check the scan makes: uffd, lazyfree, anonymity and sharing
among them.  Presence is the first of those criteria, not the whole of
it.

mthp_collapse() then reads the bitmap starting at the PMD order, so the
bitmap is not specific to mTHP either.

Name the bitmap for what a set bit means: the scan accepted that PTE as
a collapse source.

No functional change.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.h   |  4 ++--
 mm/khugepaged.c | 13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/collapse.h b/mm/collapse.h
index 26dbac7beddd..9c82e71533df 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -53,8 +53,8 @@ struct collapse_control {
 	/* nodemask for allocation fallback */
 	nodemask_t alloc_nmask;
 
-	/* Each bit represents a single occupied (!none/zero) page. */
-	DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
+	/* Each bit marks a PTE the scan accepted as a collapse source */
+	DECLARE_BITMAP(eligible_ptes, MAX_PTRS_PER_PTE);
 };
 
 #endif	/* __MM_COLLAPSE_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 804b1d35f52a..a12aafae8d9c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -576,7 +576,7 @@ static void collapse_control_init_scan(struct collapse_control *cc)
 {
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
-	bitmap_zero(cc->mthp_present_ptes, MAX_PTRS_PER_PTE);
+	bitmap_zero(cc->eligible_ptes, MAX_PTRS_PER_PTE);
 }
 
 static void release_pte_folio(struct folio *folio)
@@ -1437,8 +1437,8 @@ static unsigned int max_order_from_offset(unsigned int offset)
  * mthp_collapse() consumes the bitmap that is generated during
  * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
  *
- * Each bit in cc->mthp_present_ptes represents a single occupied (!none/zero)
- * page. We start at the PMD order and check if it is eligible for collapse;
+ * Each bit in cc->eligible_ptes marks a PTE the scan accepted as a collapse
+ * source. We start at the PMD order and check if it is eligible for collapse;
  * if not, we check the left and right halves of the PTE page table we are
  * examining at a lower order.
  *
@@ -1469,12 +1469,12 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 			goto next_order;
 
 		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
-		nr_occupied_ptes = bitmap_weight_from(cc->mthp_present_ptes, offset,
+		nr_occupied_ptes = bitmap_weight_from(cc->eligible_ptes, offset,
 						      offset + nr_ptes);
 
 		/*
 		 * Swap PTEs accepted during the scan are counted in @unmapped,
-		 * not in the present-PTE bitmap. Account them for the PMD-order
+		 * not in the eligible bitmap. Account them for the PMD-order
 		 * candidate.
 		 */
 		if (is_pmd_order(order))
@@ -1682,8 +1682,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
-		/* Set bit for occupied pages */
-		__set_bit(i, cc->mthp_present_ptes);
+		__set_bit(i, cc->eligible_ptes);
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
-- 
2.54.0

