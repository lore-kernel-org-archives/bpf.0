Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848103EFFC3;
	Sun, 16 Aug 2026 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920414; cv=none; b=cu70oyhamweUIiGVQj/C9E9NG4EgRAqV68mGeLF0CmyguTKlyk18gHz6fM2xB+zUFQIVkVRhLX1ecYf1VZjgjnqcmX11jO7PN2y4YTDWnu9rg5JElCymrw6lhnLHhssfOfFsj1/H6mTN9hV2CrSDjTGngZbzNTm/a5s+8KuNJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920414; c=relaxed/simple;
	bh=AAv8HDLt8yoFB9hlA4V4PCnVkSVozL46bnU1yZP1v8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1lp/bzpyrqEAsCfeZgBUuIEr5jAdbs9JakHke4xIojNQ1Q345U4cN/jSLzc5l9YjNRiX/WzxABM/uMKhzRPicctgHrolf3YEukeA2AlU0Q2JiF+L0Va5C0/KjIdpdv5mMvNbDDFJSKu38yH7oTDyIFgayf2Pk7lrutUm1vuUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=jLMSO2l2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AN+XvE2s; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="jLMSO2l2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AN+XvE2s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC4A214000F8;
	Sun, 16 Aug 2026 18:46:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920411; x=
	1787006811; bh=R4W786WotZ/WyKgbYqzGFWEVUdrtVlmGMAxyFOyzC0s=; b=j
	LMSO2l2Tkn4IFDjiBFITPmcvC6gilrwaaIUKad64wuKspAqfgKmPLxgHAtwpa0hd
	Cowwi8p0wmo+w5zBptY8Ar+2SYh6//rz9dekEMx4YM1ZaVOriFY3an9e9pymOv+1
	YofpPsXPcvoYHiOzqZWKpKup6k/TZkYlYUaNCacAi8LxUdpP84uzZCGZrkr+0mAd
	R0Tpi0EsdDPp+GtcEbsqHxPGWXADj/Hevv9aOrFShhPfPkhfBhzdpm0Vd5HdTI/4
	K9WAEMZMBV2TOqaPEKjVHO3x2pLVEqMrKyZKOdr3KPoPezK+jKFoMzHLT9jRv4gD
	bHzZ2gjchcdyi3WtcFZWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920411; x=1787006811; bh=R
	4W786WotZ/WyKgbYqzGFWEVUdrtVlmGMAxyFOyzC0s=; b=AN+XvE2soozc02UQ6
	wFmVllwTbQ5Hiyh809UHjROYJ/bfJWm0R+R1YrJ6BMm1fga1TsbOfKwzaMdWKko4
	GmFoiO1TDchv7Gaoi7vs/pE+GqZKxfdE3ZAkzxZh2HWUjleFBFkBqYQcEdGSKJXg
	qhhaIHDp4B/RE+5pid3tGDoMxXtqwW/4drWZ90ZiIvDFthbkSjAH8kybytaO2mTG
	aGqQg01TnMpLOtoV4fY/qTjS6OPwALS7iCEccaVQ1Wlf68hGyCAEW6lyO0CEjGCc
	cQjpQNncbF3uVOUbTvHYDwk1TX/R5KYv+zCq3gc4cmZagzB5xnLGenLWzaQYQfTE
	GU4BA==
X-ME-Sender: <xms:2z2CanFEDxIrpO-1GXqx2wHMSV_nIfb0du0Z7HhRcyZs3SwH4H0bXw>
    <xme:2z2CaprfnEhM_5TxSP4fo-E_rqi6zMdmRQFEOEXgdV3O-Zh1Ed18zr9AMHrmjNOP0
    Jt3vjSKRuaME6HdkhsC7EyYFn38e7YPqGTmUwXrIgBnHCdQXMTxDs4Q>
X-ME-Received: <xmr:2z2CalOIdebOqG4ps6NCa7bQ0_u-GZABzSHNhFWUUsPzJbCaJGPSguqMRBU>
X-ME-Proxy-Cause: dmFkZTGU6CsvhMdBtF1sno4coJRY9LqZz27w5X62/KcvcmaHPoOW0E1BwYMGQvImxADkeF
    Vrd/NWvQclh95CfVK4mxB+x5IwibSBkynFlxvp5GF5/z4jepOu57IyLHUvB8DzXymwpMun
    cyoWwWLP4hjAaD7bSTsoDmYKe03ryBERSg0IuR8ZqJolHrsaFnqWf5mL2byVsL9qLL9zPI
    9yLFlvwwZlCiJbT4IVFlRVV/9A2lZNuDFrGWvpQWw3cjqX9EcFrpnMQcn/0MdQygQWXSYC
    yXHZy2pRvgBssh5qObsL1GM1XSEE6m2uHX2m5CwJlvTSIfOodU1appS1XFI/CBVlhtQ7Uq
    ItwriLCF+51TbxcwytB+TuK/breu65MYkkuLOzLs+ujqeaqn/pevMWVPqxiCoRFuWTt1yI
    TxkkSazc/sdb4Gg8JwC+VYHvOTdGOHidP4yQvZ0WzHzRxfXn3JCvWJI5/w7HnYISzKfmf4
    lx2xOWgTIQD4t8lfY1ZHKlwyJBrXBk7m1l4H44gDmSDmr01V9EJgxP9vje8PjesT29WW9U
    Wn1swMWva1/FrKKdWnLsKPlXMe2VAw53yMdNbCjFGXO01sPl+lPJIorm93GO0kVZaGXukD
    Y0IOMQTB7hYFxrqc7rQT1O08VIOytVqdHlzChlJ5Y0HyJoZFd8c5dXbdQXxg
X-ME-Proxy: <xmx:2z2CahqAljzrfNM_UH7fc9C4to-TL2lALgfqWmti3KzuuBiRCQhNYg>
    <xmx:2z2CajkohaZk1YHK0aMPQyIQ67FcNrj4qGlrCqhIRQggPvs2NVthkw>
    <xmx:2z2Capx0Yhu117OnSDjF06gvGO_oJi7i6zwFeLNTcM15wpcXle6quA>
    <xmx:2z2Cah0jSEKwYJFuMH1YIZseva-ZDSrqF7FZPGAKPhUuTQI7NWtSdQ>
    <xmx:2z2CajYP-3lG2FKhX9WkUeRBzFrVwLoHE7TXuFtPCyFSlE7NLpL2AfGm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:51 -0400 (EDT)
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
Subject: [RFC PATCH 17/57] mm/collapse: copy the sources into the destinations
Date: Sun, 16 Aug 2026 23:45:29 +0100
Message-ID: <20260816224609.308019-18-kirill@shutemov.name>
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

Fill in the copy.  For each candidate that both froze and has a
destination folio, the page mapped at slot k of its window becomes page k
of that folio.  A slot with no source -- a hole, or a zeropage the freeze
cleared -- is zero-filled instead.

Neither condition implies the other.  A reserve before the lock can leave
a folio on a candidate that then fails to freeze, and the provision
inside the window can decline one for a candidate that froze.

Nothing else is carried across: the destination's PTE bits are not
derived from the sources, and the install rebuilds them the way a fault
would.

A machine check reading a source is the only failure the copy can report,
and only where the architecture provides an MC-safe copy.  The candidate
records SCAN_COPY_MC and the install undoes it, that being where the ptl
the undoing needs is held.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/collapse.c b/mm/collapse.c
index cf2b9b3640ae..a3882d897d11 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -1040,6 +1040,46 @@ static void collapse_provision(struct mm_struct *mm,
 static void collapse_copy(struct vm_area_struct *vma,
 			  struct collapse_control *cc)
 {
+	unsigned int i;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		const unsigned int nr_pages = candidate_nr_pages(cand);
+		unsigned long addr = cand->addr;
+		unsigned int k;
+
+		/* A folio does not imply a freeze: reserve runs before the lock */
+		if (cand->state != CAND_FROZEN)
+			continue;
+
+		/* A freeze does not imply a folio: provision may have declined */
+		if (!cand->new_folio)
+			continue;
+
+		/* Each source lands where its address puts it: slot k, page k */
+		for (k = 0; k < nr_pages; k++, addr += PAGE_SIZE) {
+			struct page *dst = folio_page(cand->new_folio, k);
+			struct page *src;
+
+			/* No source: a hole, or a zeropage the freeze cleared */
+			if (pte_none_or_zero(cand->saved_ptes[k])) {
+				clear_user_highpage(dst, addr);
+				continue;
+			}
+
+			src = pte_page(cand->saved_ptes[k]);
+
+			/*
+			 * A machine check on a source is the only way this
+			 * fails, and the install is what undoes the candidate:
+			 * that is where the ptl the undoing needs is held.
+			 */
+			if (copy_mc_user_highpage(dst, src, addr, vma)) {
+				cand->result = SCAN_COPY_MC;
+				break;
+			}
+		}
+	}
 }
 
 /* Publish each destination folio in place of the sources it replaces */
-- 
2.54.0

