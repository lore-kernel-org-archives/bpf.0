Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DF3E6DEC;
	Sun, 16 Aug 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920460; cv=none; b=rEhubbYycPXIUfMwaUZoitqqpWoTLz9hJ47z4rYTkTVJrF6FctpAiCnRghaK4vb+EG9d08oyMHxEyCwL52U0HzHIfKVPB6NhRUVPEO5c0aBFhfqQxfkZIiAK0jLCsEqKGg/lmo8vp50lj1/Wz8jfR5BjJ463VuRpRm1XVnRqUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920460; c=relaxed/simple;
	bh=lG+OMVFM3ZFKjzFKQUYMMsSJ6jytNMBH6dhA8jU2SEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeMMbdebbLVCJlVpA+TWPkTKnT/uFT2q6ySQl6SiHR/2pPDu3N5dWu1uoTu+GNtnbQ9J+S8CqQIUH051CdUPUTgjYl4r29lFY8nCZXQXRTnXKrant1f8Uar7L2PfaKXR9EQylhTPhnqArINZuWwYl2yw5kTaXWB7OqIiu8EtjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fu2iY+kc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrkuiCXN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fu2iY+kc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrkuiCXN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A975EC0235;
	Sun, 16 Aug 2026 18:47:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920458; x=
	1787006858; bh=hsbtWGmnLS8gNA6v/OmuTl4g7B7VvEJrlwoMT5rjl2I=; b=f
	u2iY+kcbdqg8XZ7qkFdaWgez1i5hIWQAqWtxE4ir7o14H6QTMAJOsoArRisr8+zF
	XKgXHadiin9jdcqGoR2OnqoC40c2jyr/XvrAdX2LfRqrDWd3bLnUQTkcfD6EHDVj
	D4I7m+ZK9rL2kJWu66YtJqYb1oLcF25VQrF9+2dad/xkK71QaojHbSgoznDIOpBW
	cIkyw02O9OYt0r81b5abH4orCiBcMOCblMYhFVVN8xX2Akp1dVWilQFjS77rI1Mj
	66kS42c5eYiXYqmJvRekO+PxrO/rzkJDTG11PqQDWJIswNS0G21VmTRLAStxJZPL
	PykDV2ghQyRM18uwklarQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920458; x=1787006858; bh=h
	sbtWGmnLS8gNA6v/OmuTl4g7B7VvEJrlwoMT5rjl2I=; b=QrkuiCXNu9Ag8fKym
	7s3tQryl5qs35v3JLJkB8cW2oZM5UeI+B6Y11iiR9Zp5PloR6bNbcTcicmuTnw8J
	lVP4mCH2TikjEdOjGX1x5Zr5UhMkUfHXOFrFEDpSIO2EZveoX6nS27vjEq+Vy4Px
	k7DS7Zz/TeZ1h5JsO5TG/3bm5dQdq3v2CTlWHQ3BWl/Jg2ZnVWC+CN1FU3rFPxxq
	JWnzKxdhJWbGRXRwVewUho2MIIaXdEAY6t7E4nHBipdGWCl5uBesALz3spA3/8Bg
	vcB6C9sMvd9e7HA0J840icixCdVA0ZoFl6RbinUEjij2zfrZ4Q5cFgIMg4DZkdkC
	DasBg==
X-ME-Sender: <xms:CT6Carm9G-x2NVenuQt7DYfIn9f7yv9N_OwRV6eLcEMQXTDj_lsCcw>
    <xme:CT6CakIzQ5P8pH3sMYRDklrE0M-RYmTOCmPlnJGgVaAzoRHZCw99i8P_FGxQEND4o
    ogZMnlFnfA7UrOXqQotXvTe7H1VhTdJyYddYaR8sh9BLMA1ROtTXolU>
X-ME-Received: <xmr:CT6CatsWUO3qF_nAyhGWZBJf6gij0BNLc_sovt8HRRdHOxDqIu1pjHdapmM>
X-ME-Proxy-Cause: dmFkZTFxktHaoHQCGyR7uz2gXQdTgUX0nZzUatWYXQdVxBJb4A/qMuEZ/RMKYvGIBz31Rt
    TR5Nu17EPBqNyeZSjkVnK7sHElwU57b8x3/cyZ9PHHSfAaSWNWLOdeLuZVBbf5zubb18Bw
    fy/mf5jpQtxpZDPvMPXwjw+an+TW+7k/Tw/n4sb2tNNa7d9nLnQnX6Rw+vp6wioFQOuuev
    fpJbCZJSwa4xWiqXHUsCfuVr3o0xcsLHyTasHEYEkAGMtBoAwl7gOHcd9Yu3HcCvuVHzqL
    dMVburb2rGaTCsZcGe3UWITClIJ34iPVxiKzwGBtfazzXdWK1ezlWroYFXdEl+xlvbcPMN
    vZtr4rHndVJB562/WoDkew1Y03j21tKV2cnjL43Ck1uOBZ8NRyVlM3puHQQJb8vttWvbCT
    Vub/4J6dev06TTYjDujIcAGui6NrZT7E0xqFxmiu9BmjvwUAj0YhVXNi3R3McxnqEuozCs
    Cg+X7m9F7uqX2U6p6Xyjjpfd5s6+mLEaC2r7NYfvnpAv6qt2q0FyIdVJus0Zu4lfXxl41X
    Ho6g80JFqnXt8OaS01tjl26CBO9wiBFx/ns5VSZG0hA3WGnD4j3/8rFwsQ9O4oX5Shk/Hx
    K0jzuV1jZV8vH/x8VLuU4iFg4PHzM1/90qd2/8TgEM/6D9aaOPm8UyuE0hvA
X-ME-Proxy: <xmx:CT6CagJgE9kztDHM6-XPR-SR2o5kgXZiK-cTFL0qeJrQ0PJIGX2zWw>
    <xmx:CT6CagHuuhIwq4SvG_N8P-BS727mhFVkXru6E338dz6KBc-yOG_Zqw>
    <xmx:CT6CasRaWUKuFDiO-XbCdO5DsWgyRoJFmwJ9bmKQhsi2ya_TBfoZ9g>
    <xmx:CT6CaiUSEIlXqgUmW2LI0PYUkJLmULf_ujIyHBt6813C8Y_mqtirfw>
    <xmx:Cj6CatnmcMoHwRQv7955E4KTzPM8XXoCsZRMvv22Hw0hDLnz-yaR-8Db>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:37 -0400 (EDT)
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
Subject: [RFC PATCH 43/57] mm/khugepaged: check the scan budget before the work, not after
Date: Sun, 16 Aug 2026 23:45:55 +0100
Message-ID: <20260816224609.308019-44-kirill@shutemov.name>
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

pages_to_scan is meant to bound what one khugepaged pass does, but
collapse_scan_mm_slot() tested it in only one place: after a table had
been scanned and turned out to hold nothing.

Neither of the other two ways of spending the budget reached that test.  A
VMA the pass skips is charged for and walked past without asking -- one no
order can be collapsed at, or one the cursor is already past the end of.
A table that does hold a candidate leaves through the collapse.

So a pass over an address space of thousands of VMAs khugepaged cannot use
walks every one of them, however low pages_to_scan is set.

Ask at the top of both loops instead, where the other reasons to stop a
pass are already asked.  The outer loop asks before it judges a VMA, the
inner one before it scans a table.

Stopping the outer loop only works if the cursor moves, and it did not for
a skipped VMA.  Advance khugepaged_scan.address past one, so a pass that
runs out of budget resumes after the VMAs it has already judged.  Without
that, an address space with more skippable VMAs than the budget would be
walked from the same place every pass and never scanned at all.

pages_to_scan now bounds a pass that finds nothing to collapse, where
before it did not.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/khugepaged.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f3a7aad5e8f2..cc5ff429d811 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -553,9 +553,19 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			cc->progress++;
 			break;
 		}
+
+		/*
+		 * Before the VMA is judged, so that a pass over an address space
+		 * of VMAs it skips is bounded by the budget too: each one is
+		 * charged for, and none of them was being asked to be scanned.
+		 */
+		if (cc->progress >= progress_max)
+			break;
+
 		orders = collapse_possible_orders(vma, vma->vm_flags,
 						  TVA_KHUGEPAGED);
 		if (!orders) {
+			khugepaged_scan.address = vma->vm_end;
 			cc->progress++;
 			continue;
 		}
@@ -570,6 +580,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 		hstart = ALIGN(vma->vm_start, window);
 		hend = ALIGN_DOWN(vma->vm_end, window);
 		if (khugepaged_scan.address > hend) {
+			khugepaged_scan.address = vma->vm_end;
 			cc->progress++;
 			continue;
 		}
@@ -584,7 +595,8 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			range_end = min(hend, pmd_addr + HPAGE_PMD_SIZE);
 
 			cond_resched();
-			if (unlikely(collapse_test_exit_or_disable(mm)))
+			if (unlikely(collapse_test_exit_or_disable(mm)) ||
+			    cc->progress >= progress_max)
 				goto breakouterloop;
 
 			VM_WARN_ON_ONCE(khugepaged_scan.address < hstart);
@@ -596,8 +608,6 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			/* If nothing to collapse, the lock is still ours */
 			if (!collapse_scan_pmd(vma, start, range_end, cc, orders)) {
 				*result = cc->scan_refusal;
-				if (cc->progress >= progress_max)
-					goto breakouterloop;
 				continue;
 			}
 
-- 
2.54.0

