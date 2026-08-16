Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5214418A51;
	Sun, 16 Aug 2026 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920476; cv=none; b=SwWI5xXbiAiTYJA14K7rOfDauaoVxYkltoccz6EhSJPVSFLkU7DbGmeEBzsQk7et6PoRcSQBJZJ7iSapjKX16tFlEQjo80do/SM6baG9fUAKF07NCCCe+Nme4K9w4bUwlEhrU14ZpIM2agzz9NOSdmzYUKYMiqfAqV4eJmICD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920476; c=relaxed/simple;
	bh=0khGCNAZ79erovRTN27euIO+9Af+Ty/ga1jXRTOxdDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOIVFaXveH245XRB1C2NgQqFYbx9oYw1Sj9zVpqo06xajBEOI3QCz9hKXInbmsbAAjMkelBW4mjHj3+O/nVt8YKeT5nieTLhIF+IZAJ0a5fW3XU13xppSTlCW63SCt+H0/0oQI6Gnu9bcx7YTj/iAwuGGwDOTgOU4r03prT+Z+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=J2MIBzRg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/P8NbYc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="J2MIBzRg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/P8NbYc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED57E14000FA;
	Sun, 16 Aug 2026 18:47:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920473; x=
	1787006873; bh=6nKA+x05SWCXqc9tAtZ9fIuQuNqLhmkMozez9tYtOg8=; b=J
	2MIBzRgxUP1C4fIjfMGKaTm5D0/70cOQRHKAbA2pFShrgKmGO1NRT0pDfPKhBD15
	HXSqf3NsaCIleEj/q4hDHVHX9JGeoP9UY13JE55foNll6OzHp2g5Vk0uFAJIdY4w
	GoO1Yg6tsF2g+kWdbyG7BWiB5m28OxHZoMTpJ/e+M9RAaV2uFSRL40wNl1JkXpKF
	H0a9hOB0HY8+RNI0kZp1Bn1uVhNnk0D9LTLf0sAdhXUtaXB/Tg+lxrUj4edzFeL/
	njv4WlY3IIA3p8BkcnDozs2Bf6Usp5OKhLCy9kW+QzrUena3ltGTKavDK/nUVo1+
	IMeSMRBK+DmhTjOnIrvBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920473; x=1787006873; bh=6
	nKA+x05SWCXqc9tAtZ9fIuQuNqLhmkMozez9tYtOg8=; b=J/P8NbYcP6xCTt5pt
	yUGsWYlcL5jXSEBSpHo5972USkYsQ4clKoiQmAxZfiapt3giYptu6UTfctr+Ux+Z
	3RhxGo/0KNda0UZVE2m3Yruac+La6uxGyjkj6L5QP82mf8mjZK1DODa+rEi5LyAu
	cTaf8ctK+B1NMVYNCbtVDXY5yhmgL4LRnrsHm85REZi0il4ySqfrtaPo2gkjN/gS
	NzcbaykTcpMTHuwT1q9a/oStrP2GFiGnKqwUf49YL/jxsoX3XZdYDzyUwCCDAeS6
	vMUXpAuCeF89aQ8/g2ihCWhko3penp8Csz0Q401gDWY0aBssIjsDYMRm878T1f1y
	c3e7w==
X-ME-Sender: <xms:GT6CaqrvauPI-5F91b8wxSvyKJSrQbxgyHhKq3rYRhQE_BPmsmyoQQ>
    <xme:GT6Cat_8BQ8Evg857fLm8kLc33LATZeixRawXmwg0XjPRPceWiwYH_0Z2C2cs963p
    _BBgRF7KqreQxfMWRBWARslXR16ZMiFg4Ht2gI4HdcGK36kThfAP1k>
X-ME-Received: <xmr:GT6CarT8HqOaiV-BMbUlsX1maFYXlnliODeiLj2baT6o_pirxk5YOkmpi-Y>
X-ME-Proxy-Cause: dmFkZTGLjSC+Sq1mG4OxzCqJWZCyq6WBdNxixaUzytYe9+wGJyabxJMeXSGoSuAsbaseo8
    j4DSEFeK04hDwZtES01hwyaQU7EBbvB2uUyGWGXfBIvFkincgAhOfMPuQIYJEtCVnAaSQR
    A4Ax8HD1ONlE2jDjL1mVvD+0hWY7OblS1nu5BjF2+enir154N1oLAu20vju0M/bNfdRnaJ
    kR8ssngVd0jx9kVZmvlOu6xrNJDHPkWuaI7duTsmkJWDtl1nRnZmYTu08hiimZvSmFoDki
    6dltoqAKCLj0c9eKP1Vuuwv4Z4pwJTjTf79O9CtQykYTwcA2QZ7OKyC8oLqq7vFkYshLpw
    LbZeDrUOk8rhM5rSxocjaWFP41pGzRhRHl0flKSZneFSf+mPmKgFKw4251gunztkdKVNyH
    QnRYsGz5L/GXiKiy1v3S/SrN7GzTBcXp0MYjJsgYyrkQ0uihcwm0LmFwzy8ExXjXwl/DcJ
    Bqw+WfxPjvkY6ZNwBmZbpr0mZaQ4NNtCOskJtyCw9HD9a7mzzSdUorDoJlDWU180C8lZ54
    HZEFuOjndqiCWeC0hQcqgUiK5PiUEeazn7abJ+/umTML33AYxBH0wTQylP6xID9xXksZyN
    k1UDRxZM6cfUp4CdSMNeruahniVs/40VjqqWeFlJs8fuMuUCsfGpnTv8yfQA
X-ME-Proxy: <xmx:GT6CamczuDaAvElUCT6NWOqCS0uGo89Bl4-xkNsxmOS4JxDrbjHAHA>
    <xmx:GT6CagKu8X5IybB2Cr7f9AjwTUM2C_095ar5-6iwb-T70Pl8KgpptQ>
    <xmx:GT6CajEBFmVXIuW_bw2m5oU8_Z1FhEskuxmdLCX5C1oXLHXuZ9Lg9A>
    <xmx:GT6Cao7cZMP1atvMHzcNqcbIvofy0j0S5fSiwjfE3RO4RpBXbSPkGg>
    <xmx:GT6CaptNvAXrW6ozbY7ylNvb3zr1TdbgQ_lrOv-QyUQi5AD32TcU1lgY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:53 -0400 (EDT)
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
Subject: [RFC PATCH 52/57] selftests/mm: cover a hole-y window in a sub-PMD VMA
Date: Sun, 16 Aug 2026 23:46:04 +0100
Message-ID: <20260816224609.308019-53-kirill@shutemov.name>
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

A collapse over a partially populated window has to zero the slots it
found empty.  The destination comes from the allocator holding whatever
was last written to it, and a slot the process never touched must read
back zero.

Nothing in the suite checks that.  validate_memory() only re-reads the
pattern fill_memory() wrote, and every caller passes it the faulted extent
alone, so a collapse that left stale bytes behind the holes would pass
every case here.

Check it where population and sub-PMD eligibility meet, which no existing
case covers either.  One page is faulted in a window-sized VMA; the case
expects the window collapsed, the faulted page unchanged, and every byte
behind the holes zero.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 tools/testing/selftests/mm/khugepaged.c | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 85f138cfb9b2..b61e32566d47 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1599,6 +1599,55 @@ static void collapse_order_sub_pmd_range(struct collapse_context *c,
 	__collapse_order_sub_pmd_vma(c, ops, nr_windows, __func__);
 }
 
+/*
+ * A partially populated window in a sub-PMD VMA: population and
+ * sub-PMD eligibility at once. The unfaulted slots must come back
+ * zero-filled in the collapsed folio, and the faulted ones unchanged.
+ */
+static void collapse_order_sub_pmd_holes(struct collapse_context *c,
+					 struct mem_ops *ops)
+{
+	size_t size = mthp_window_size();
+	char *bytes;
+	void *p;
+	size_t i;
+
+	mthp_push_target_order();
+
+	p = mmap(BASE_ADDR, size, PROT_READ | PROT_WRITE,
+		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	bytes = p;
+	if (p != BASE_ADDR)
+		ksft_exit_fail_msg("Failed to allocate VMA at %p\n", BASE_ADDR);
+
+	fill_memory(p, 0, page_size);
+	if (!window_not_collapsed(p, size))
+		ksft_exit_fail_msg("Unexpected large folio after fault\n");
+
+	madvise(p, size, MADV_HUGEPAGE);
+	ksft_print_msg("Collapse hole-y window inside a sub-PMD VMA...");
+	if (!khugepaged_wait_full_pass()) {
+		fail("Timeout");
+	} else if (window_collapsed(p, size)) {
+		/* The unfaulted tail must be zero-filled. */
+		for (i = page_size; i < size; i++) {
+			if (bytes[i])
+				break;
+		}
+		if (i == size)
+			success("OK");
+		else
+			fail("Fail");
+	} else {
+		fail("Fail");
+	}
+
+	validate_memory(p, 0, page_size);
+	munmap(p, size);
+	thp_pop_settings();
+	ksft_test_result_report(exit_status, "%s\n", __func__);
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
@@ -1888,6 +1937,7 @@ int main(int argc, char **argv)
 		TEST(collapse_order_mixed_sources, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_sub_pmd_vma, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_sub_pmd_range, mthp_khugepaged_context, anon_ops);
+		TEST(collapse_order_sub_pmd_holes, mthp_khugepaged_context, anon_ops);
 	}
 
 	TEST(collapse_full, madvise_context, anon_ops);
-- 
2.54.0

