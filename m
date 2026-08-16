Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17F40911F;
	Sun, 16 Aug 2026 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920458; cv=none; b=c4KyG5AmXjXuPohwVFla3RU/DEPAHRQTJw7q6aelnmbsFyoMZsA29ahQsIOO6V9FcDRJ0Krq3uE4w3ywCEdGNyvGLqis9UKxTKAK1NHKvp55Mtd3hKfVvfka2BBz99NLpG4HI6ZQ6B3S8OCydjzb0tfKn9LJLQ07+xKfMjpYQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920458; c=relaxed/simple;
	bh=QED0ivctn/g84zHlwg3dHaWIpmZRCAVoxxfhuvqzEtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ946IOl7s0PPpkoPHQf5odbxN1egVfGcjrUzOLwDlMZdcIM2hq+dTYsuPhMTwpwGEQ0dNHwJm9l5YzJVC+/ZyUBc+llsnFCGUI+mekuNw5B7flbO9X+DT+qJfXntqoLf7SRW5uMVX2C10wwOD2XVSIXtO/ONPjmUZUEBKGNsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=nG9tow1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOnDi6ps; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="nG9tow1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOnDi6ps"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5785714000F8;
	Sun, 16 Aug 2026 18:47:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 18:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920456; x=
	1787006856; bh=UyrP/wXPOBJTdhoFE5YGqbURIEa1HSuJzV4RfAXPajU=; b=n
	G9tow1dkQz77VjVwwF3jcgHCENpHOmT8atxbCLLECcSiWMcmK6RFYtDpUvqxkL9w
	CDUp/5852TW8lhwrZBw4LnSUM49QS+ubiCBuP/Oc7zR+MnT7KO093rX60nzUsC8k
	WF259W3rgsUCWMJnwYpO7w3ilcTCjCDYsbN844W1SHCtSPPG2qstrHMDxqNHsLlJ
	H4Gkc9DevfM9JdR2snF+2PuW8JDFOhRAEBUlmzRJd7C3w7d5o8CPVFsE1fyzWzBQ
	rHcAlP72IyQuA3Oa18FluUCvGMft6PBoqd3uurqhboVAcG32GFWXZl/UT3Umx44e
	sLOTkOswIKKnPFy5hb0FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920456; x=1787006856; bh=U
	yrP/wXPOBJTdhoFE5YGqbURIEa1HSuJzV4RfAXPajU=; b=BOnDi6psLSSwsXcqy
	wmRIZYHNoPw/nNbEwui6al4nbqSnxczcCAJHo4343mGOYCf6oK2m18CURKPQZoZs
	xxZjGtrvx3UEn4n7ABQXcJInQWQkREL/pkyU5g+S7F8sPN341QWSiUWETqSUJ8at
	iXfU/+DnEsUhOfdIcMKtOJUrlBSisODgaAJdTHLCHvsk9q7M9gqUQvHcTf7waYn7
	o++nyGT4JgrTC538YZDVwugzrO0mxcS23JtdrqvkLoBlRIxbWz9SGDhWLHGfAdDQ
	FDs4Ee5ybxfGyhj4wF+/cg7InCmu16q9iKiW+4yBOQ4G5eYrHMPjDj6dLAXkpJpe
	fcJuQ==
X-ME-Sender: <xms:CD6Caj-CF3Y0_otzv_4ZbdHY3gFX2yND2MmM3jDxjierR0z7_MoOBA>
    <xme:CD6CalBEjuXq5U-S7q1kTm-gKv2a85jFabeIpNonbwWh4tGOrQglGJyIRSramCnJ4
    Yf6XfOVBPTsjqyxWn2m3W8NaprqcFmDHYPI15y09NsZ1AoOWSJsjlhT>
X-ME-Received: <xmr:CD6CatHtgEXI0qqNF35XcyifsmWQdkizFI3ENThStE6oxSZGPjuXV_PniyY>
X-ME-Proxy-Cause: dmFkZTFcTQrb7i2Wnr2aEeZt1aoD7asKutBPdJgU3YSD5OfcfuljRo8Y5zG4WAng55KhcU
    fdYu9dW0n+wtsUDWiYHh8AwjWiiyOeVLRvzra0gUIzgKMFXfu2OsH3wUsDwz3Dpe7vEjB9
    JjBmMfD78Db5X6Vl1RDz8Wz4IQF1tjtPvs8yYIcZ4vdtxAZhotrvrKr9o/e/MWe2qw9p1d
    u/4ngMViLbtWn8zpPvYSIgtjaF8APmxmHCU5Ga5Rd5eIGcQp1MbbGmkchmHrMFMoUd9mrv
    TpVQ9+TKNOdfLLUK+2CPoHpagx885EUQUSZxhSq0AxxU5QJRQ+JA8yzxyjEYMjW1uFFjcm
    d7hzQcIDGBAJ9Kg3rplLw7jfe4LEi0F6SofMNmrKPLYc4yjweROnOFdgG3+P+anRpdNgju
    yFWVmmTGSJ1pkA7ZfQP/zLvd+Qc57RLKd2grwoOvBrCoYfMf2/7JtIEgRKykbeQlJl1t2i
    o3a7q3cY2oo04ey7M5qY21DAFRN0hvbmP917wCqhCug8/gv9jHuXVVRBq1P4rS/xZjYMWZ
    +SfkbQhdbebpKUDV9jBzsvGf+1KfqEwOb5sbvgleSn3QvacH+qZWnvUYuTftewxhZ+GZdQ
    8ctAXFBvI8gELPNX5p5dipgHyieJ7AirBkuIwt+OgA/k+nC52hzYouNJCAlA
X-ME-Proxy: <xmx:CD6CasDqx8V6n1QCtiGUuhnFqgpylWRxWbs14mo2yFU_swQX1tzccw>
    <xmx:CD6Caue0aLuCRyziW8qesyDXAY2Pz218diWwhOcQabijGhMKJxytBQ>
    <xmx:CD6CarKuEQXWLeQMpHAA_DLMhLjch0EeW6biCjjXzyDI-ZGBE49saw>
    <xmx:CD6CanuiW9Cj_kDQHiJh12QejcAO1iKHn9vPoyaNOlWqV6Lyy3ajUA>
    <xmx:CD6Cao9rCdG_QX7fvRRJ82Zli3b-4DelKLGbYqVGJRFm2x9yP3VPSP6Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:35 -0400 (EDT)
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
Subject: [RFC PATCH 42/57] mm/collapse: allow error injection into the freeze
Date: Sun, 16 Aug 2026 23:45:54 +0100
Message-ID: <20260816224609.308019-43-kirill@shutemov.name>
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

The freeze refuses a candidate for reasons a test cannot arrange: a
co-mapper appearing between the two sweeps, a GUP-fast pin, writeback.
What the round does then -- the candidate drops out, its neighbours carry
on, the region goes back to selection at a lower order -- is worth
exercising on purpose.

Tag collapse_freeze_candidate(), noinline so fail_function can find the
symbol.  ERRNO is the only injection type for a function that returns a
value rather than a pointer or a bool, so an injected result is a negative
errno.  It only ever reaches cand->result, where every caller compares it
against SCAN_SUCCEED and finds it unequal, which is the refusal the test
wants.  Tracing prints it as a number, having no symbol for it.

A forced return happens at function entry, so this reaches the refusal,
not the freeze's own unwind path.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index 952e3f62d920..76a53616b240 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -4,6 +4,7 @@
 #include <linux/backing-dev.h>
 #include <linux/bitops.h>
 #include <linux/dax.h>
+#include <linux/error-injection.h>
 #include <linux/highmem.h>
 #include <linux/huge_mm.h>
 #include <linux/hugetlb.h>	/* x86 flush_tlb_range() uses hstate_vma() */
@@ -937,7 +938,7 @@ static enum scan_result collapse_check_candidate(struct vm_area_struct *vma,
  * collapse_freeze() issues the ranged TLB flush over everything that froze
  * before dropping the ptl.  No copy may run before it completes.
  */
-static enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
+static noinline enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
 		struct collapse_candidate *cand, pte_t *pte)
 {
 	const unsigned int nr_pages = candidate_nr_pages(cand);
@@ -1085,6 +1086,7 @@ static enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
 	collapse_unfreeze_candidate(mm, cand, pte, nr_saved, nr_frozen);
 	return result;
 }
+ALLOW_ERROR_INJECTION(collapse_freeze_candidate, ERRNO);
 
 /*
  * Raise the two barriers on the sources of every candidate: migration entries in
-- 
2.54.0

