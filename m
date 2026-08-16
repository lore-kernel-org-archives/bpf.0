Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27613EAC68;
	Sun, 16 Aug 2026 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920432; cv=none; b=L8zghN8bTTpVZyutdTgGmDy8W801m+UPQmbfHPrEKeWZ3ToSSppS7aO8ySPH//TaYF2vOGoMKz8Z/UePrF+CzGjlEmpqA4RcjNbkm8hfoFQ0h/xvJd7J4brMpVYh8H5sx8Xrqg1BtU3rUy/B4/2uk9hofrs54ICirhCdxDxrIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920432; c=relaxed/simple;
	bh=qtthvM37H3GLokDgDQmyPduLycS78KAAlnhVAkzzjjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u17YoJTAV2g9woqAVoxZJYWtnO1uTTaDnLP50hwFvpCoZEugL6XaXCcVlG2tBiRMR1vFhk+YjlG52/RB6GTSF+nyClTzlUQGEZzy+VPkeIa0v5M3TmliW6yPWlXcTw62SAnDWhUMgoM7/ucv+NQpw1GIyxlD2NdphrHkTBUPWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HW2cTKeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiLMp3B4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HW2cTKeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiLMp3B4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F3212EC0243;
	Sun, 16 Aug 2026 18:47:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920429; x=
	1787006829; bh=I4QTeWOTpJRPuh3OfF+8CEm8xjikxAxj2x56bLCOOSc=; b=H
	W2cTKeViOUFKg4ugUwcqSC2lzWJ2gzQ7Bl336yHE4NmnTD/qYiXZJsS56PyF3jb2
	vRin2AVLS4DXRf50KFmmsvo15XzGj6ZIFMCxW03WGSC/kro0ZFT6IFJAUlgtHdNy
	hM/fH6yJL6al46oPTa5NXWEtpQQTLqS3moEhY/crVlL3JyNJwfEHpbz1j3kZcrcx
	uc+i42paLfUjk4TVxpShCfb002SV7PIr7Vvvl/K8Df/Kx3R1Y8cK4Yr/qvdTv+UA
	VQt7mxI61MBPkXm1Y6/DEljs8O5n3aFOsNl2ZUr5vl8HIK07YW3x6Q/GFZBU2fur
	VXUI0Zr3/GosIsshFIHOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920429; x=1787006829; bh=I
	4QTeWOTpJRPuh3OfF+8CEm8xjikxAxj2x56bLCOOSc=; b=KiLMp3B4ag400yZym
	+u+s/kP8DjoiV1jGTUTQh2HrwXArbn4BZkhHRadCrK83d4yfJSLprdZxmKYcteHO
	2fer5H+sy+0buosPR8Jmq/oOFdb9PocomY1Io8K3Mo6iOEq6505wWMSEt/j0uJsS
	5hMv4hnkWSAXWQURzSUF6TqqU4MjMv2KmIg/QpYD/78uBX3THZSuZWfcbQGr70Ab
	EcPfrHqlhhLAdYfwzS3Apkpxct6mHHw7ChfflvQq1hghT4TjW3dKGq9D/dK1EvPJ
	zy8Uv+0mt+J8Ooliq/iNd8BAPNecVWh3XL3zw0M8TFt/CZWDZmMnVXBdtRwKT5CS
	lSIcg==
X-ME-Sender: <xms:7T2CaitN-YTQ2oxKfQAXKd9RWsPSMTeRjEMTkFIjyUirfvcgQ6viDg>
    <xme:7T2CahB17GMwG6FGD2lL-yU19_a5ttzJSzw9N_ET_U-HIz2EK6L3ye6HNIYyu4Rnb
    Wq4ggFRnLrlwTGPWQg9Gyf6cWkIZSKF0MRDiBrJLhaOF38XwO7sv9vu>
X-ME-Received: <xmr:7T2CapMaJ6U3ivIVd-QKdUewcUkIE1yzqg9h3tAxDKd9V2VTtuLnGKnTs28>
X-ME-Proxy-Cause: dmFkZTGlsoL4dlGZVhjNGnyng7DWLkzd23+vL0S14uJaq1tszuZ6c/qXpcKjIN3SVavrqW
    anksLy7isjEKJzVCE9/It/QcezLPAumFeVWWYf/196d5DKxXijJBwwHlwdbhLN8+Q20ZSw
    VAcGFAGUZDfCfgJltT5NnBIG4Gh7JxdfG7re68r55pgQSoCRLBnoP1i35vKgO+O/kd9+lz
    qLG43ny3AnvUx0aE1SnxP3FJCiuv2lDE4FRTwfST8/uDABclrMy6sZKUEjfd1WPzb5NlOP
    S5qghqIOcnVKJHuC+GM/K5ckB8SXpR6Ag+KqE5QSQT/v+DpSzaOOJbUo2XdsQxu9tqIPVC
    wtH8RrR+VRBK4rHQP5fUOUd9SDmtkxSJIuqK6X0YhrZ10zdW4WgrIMWQcAlMOIw07y45IF
    iUQPQjmY18mZD+KeADQUCZgbhRiYVOnmw5psrOcS2zb3A7Ve3TEpym00DdUWWBFRygip4Q
    Fn+i65Iy6aPDTmuKBbeNhatneA0MOXpV6XTo/iFtVU6PszWR/4qIwju3GvgPVWhmGwEaF8
    lOhqjwLWDDCkWCXUSIksZsiHNeLhW050yblRbXZhW9L1t9tojDhndbGZqh5BRIbDI62sIJ
    2pCa7pAkdvTJlFFSD2rj0hqoXUfSk4uHGCJ+7xklr79KCQBj6ko9GT3+9ngA
X-ME-Proxy: <xmx:7T2Car6ja2x14aOjb-XHTccESUVK3zzz3OlefJJuHHfOiTZuhw3NSA>
    <xmx:7T2Caj2KGqYDygko7lCUqLIWmvZFcFnvEYQvh3pneyQVUUnSeWx73A>
    <xmx:7T2Caqr-g0RdIP-pIfCMvJa223e-pezovUUZT4A6ObM08ANLGZ3Pzg>
    <xmx:7T2Caq_OsZBJl_h9di85Sw4Xk_ocFgBnlDH_aOV2I-81IjMHPW3n_g>
    <xmx:7T2Cai4cfrWa81ngUM3QzKGR4bHDyQQNX_qU-fp-iToXl_FYtO_EX8CG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:09 -0400 (EDT)
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
Subject: [RFC PATCH 27/57] mm/collapse: scan the windows a VMA can hold
Date: Sun, 16 Aug 2026 23:45:39 +0100
Message-ID: <20260816224609.308019-28-kirill@shutemov.name>
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

khugepaged covers each VMA in whole PTE tables, from its first PMD-aligned
address to its last.  A VMA smaller than a table is never scanned at all,
and in a larger one everything outside its PMD-aligned span is skipped.

That was the right shape when a collapse was always a PMD.  It keeps mTHP
collapse away from every range that is not PMD-shaped, which is most of
what an mTHP is for.

The gap is widest where a PMD is largest.  On arm64 with 64K base pages a
PMD is 512M, so the old walk reached only VMAs big enough and aligned well
enough to hold one.  A 2M mTHP -- order 5 there -- was unreachable in
anything smaller, however many such windows the VMA had room for.

Root the coverage at windows of the largest order the VMA allows, and hand
the range on one table at a time, clamped to the VMA.  The engine already
accepts a partial table; this is the first caller that gives it one.

The cursor is no longer PMD-aligned, so the assert that said it was goes.
The bound beside it goes too: the range is clamped to the VMA where it is
computed, leaving nothing for it to catch.

For a VMA whose largest allowed order is the PMD order -- every file VMA,
and any anonymous VMA with only PMD-order THP enabled -- the walk is
exactly what it was.  Where smaller orders are enabled, khugepaged now
reaches VMAs a table would not fit in, and the edges of VMAs it used to
leave out.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/khugepaged.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d1e031ed3e6f..895183d92fb8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2838,44 +2838,56 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
 	for_each_vma(vmi, vma) {
-		unsigned long hstart, hend;
+		unsigned long hstart, hend, window;
+		unsigned long orders;
 
 		cond_resched();
 		if (unlikely(collapse_test_exit_or_disable(mm))) {
 			cc->progress++;
 			break;
 		}
-		if (!collapse_possible(vma, vma->vm_flags, TVA_KHUGEPAGED)) {
+		orders = collapse_possible_orders(vma, vma->vm_flags,
+						  TVA_KHUGEPAGED);
+		if (!orders) {
 			cc->progress++;
 			continue;
 		}
-		hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
-		hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
+
+		/*
+		 * Coverage is rooted at windows of the largest order the VMA
+		 * allows: below the PMD order that reaches VMAs a whole table
+		 * would not fit in, and parts of a VMA that a whole table would
+		 * leave out.
+		 */
+		window = PAGE_SIZE << __fls(orders);
+		hstart = ALIGN(vma->vm_start, window);
+		hend = ALIGN_DOWN(vma->vm_end, window);
 		if (khugepaged_scan.address > hend) {
 			cc->progress++;
 			continue;
 		}
 		if (khugepaged_scan.address < hstart)
 			khugepaged_scan.address = hstart;
-		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
 
 		while (khugepaged_scan.address < hend) {
+			unsigned long pmd_addr, range_end;
 			bool lock_dropped = false;
 
+			/* One table's worth at most, and never past the VMA */
+			pmd_addr = khugepaged_scan.address & HPAGE_PMD_MASK;
+			range_end = min(hend, pmd_addr + HPAGE_PMD_SIZE);
+
 			cond_resched();
 			if (unlikely(collapse_test_exit_or_disable(mm)))
 				goto breakouterloop;
 
-			VM_WARN_ON_ONCE(khugepaged_scan.address < hstart ||
-				  khugepaged_scan.address + HPAGE_PMD_SIZE >
-				  hend);
+			VM_WARN_ON_ONCE(khugepaged_scan.address < hstart);
 
 			*result = collapse_single_pmd(khugepaged_scan.address,
-						      khugepaged_scan.address +
-						      HPAGE_PMD_SIZE,
-						      vma, &lock_dropped, cc);
+						      range_end, vma,
+						      &lock_dropped, cc);
 			/* move to next address */
-			khugepaged_scan.address += HPAGE_PMD_SIZE;
+			khugepaged_scan.address = range_end;
 			if (lock_dropped)
 				/*
 				 * We released mmap_lock so break loop.  Note
-- 
2.54.0

