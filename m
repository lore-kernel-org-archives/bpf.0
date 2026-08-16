Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6641A549;
	Sun, 16 Aug 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920477; cv=none; b=evGCdNJh9rmwZXrWyKSs5ew5X6ZMsxRuRQso1MszQppQ1hhViW7YytxHbgYAMOGL3j5L5Ne5sbxip8t+duZtfctPidWOnN3hmUqloWNmdU1y7Py4gGRJ9sEyaGAHxVGUdfVH008ZHEZ8jaB0o+Goey4KX6OBBbOzrcksIIm8BEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920477; c=relaxed/simple;
	bh=RDTsAz4Oy7wezsLnEkXHTNcA0qQ8+nrFDvVHPQR253A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diGR0CuuiO4sf8Jy8gzGUEhjUwip82IN0tVbMg4bEKu0NddkMh+d+Gat+t2QfPwajepSM5qyly/Z3NGwXxiSJ3cDWdfjQ7P6rtVVSS/juE0QThQSWRK9ItJ68vlQXPoP6L7uFYdzTD7c0OYR6fPshjYu+zsAFj26HjRlyK5CYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HgHGN44b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8U1xcnF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HgHGN44b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8U1xcnF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C871A14000FB;
	Sun, 16 Aug 2026 18:47:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 16 Aug 2026 18:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920475; x=
	1787006875; bh=YVoKODTNuHH9tsvnWaADZQ9VZLR8etvBsMTlfNVNhEw=; b=H
	gHGN44biqF8ui1hgPrOaWlVx9x42CW2TrTQ1MBpnq9uZohHvhs9TFO8COYmiBtCQ
	x092f/nn0bFsT4jxcfIqh4yGHRauPzg3rM62tQd+rliAmvov/yjuGh8SL0B1rWY+
	hbGt5HaX9ZWi+CPjnEF7Gpu06s9ZzxKtL25W+JLXAm5m95PwqT58EM1QRCpYQ8Y8
	A9SznxPCoxfH4y21kjuZpwwI58y6krWsOdIdjexXUSbQAu/m2ylSEVTAiMpyulSj
	Mf89HJ7jwuv3gx0AfmaaIxd4QsMTQ3GFYKUXKqbtO6l7ASEFDRt1X9lgRkWYJoMx
	qHj4B8Rlg2SfjUyO/jiNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920475; x=1787006875; bh=Y
	VoKODTNuHH9tsvnWaADZQ9VZLR8etvBsMTlfNVNhEw=; b=G8U1xcnFalpJlNLkp
	cMJJl5lDt/0JdgftmpIqkcaVJ5istmKoLWtdXShZo572ZMnXxNWs8lUmlTfJuUVZ
	sJ0oKdAlnJeAEi8RfwsAi7Zow0AhAJpDGHKGFzUYuC9vKVZZ3PpKIcX1iGaU62fD
	ZbuD7OgEZo5Gu2GQntxsilcY+newcgsOQAAVWUddpN6x81U7xrB9zkrs+XTN8Iau
	jK2PJm6aPa/liiZhSlJ0HCJGn0lbtkeauX7LWN/kL/puId4wJ7pGTwhBDeEaN/Yb
	mXxkUN6NBnt2KB3cpwfp7jM+S6qVsdwcameuR29CIdoVXBb0UioyoXaPv5xBveZP
	C9zig==
X-ME-Sender: <xms:Gz6Caoal4FlStzYDBFIdE2tm2uGtShL8G4GQm3nQnWZ68beuoa9j3A>
    <xme:Gz6CaosTWK9QhJo2s8EFtvVm1tqYtKMLXaXM5lwdY41GHSphMHiSeNndnIxgi9agA
    PEoX_eIHdkVxqfE2UqxNMHFdx4Fc9pGihXX_HG9h2fP3_DzP7bZ0z8>
X-ME-Received: <xmr:Gz6CavArAbWlv_aIh7Wts9Fp_BPY0_i62aAeUQpeiBVUDzwHo111WdiXB_o>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTnT
    D5+QXiNA7V0+//1GAWfYdWnFUDbJ4PKAYPebwd2vIw25LxzaUn6QnwsCjtV0vOBDOG68oD
    Oqk6cCWO4XKcdDE7GZMuUoxBQVzvFGinAnfQRKXDAj//k/5a2GjRPi+pYfH35b9i57TE0h
    XMcQaJjSBsGRFRkjnhDLw4f5+2D4nvb6hkAfT4rb9iy+9cz89AU2qog1b4xomiUSaQuLKo
    YugSHkz9PMS2Kwoq88m1eRQ5YhN8GUeGt4kbhSAlFnxsssMN8NRLY8TPq77Lu3JPp+uR9g
    JtdJwGX3/UFlAhzoIkkuyY2NCBLzeHHV6BWLrw7FTIxQWDTMxU/KKrZWRpRg
X-ME-Proxy: <xmx:Gz6CavM3xp0qemypU0qR-XBXw8eaQ3nXInSdzCphmSY01aisG6dxiA>
    <xmx:Gz6Cap5lD5H8hVGTfr395LWfMDrxzEM2tcghCsf1WL9p4_PGnJjngg>
    <xmx:Gz6Cap1Wg1plDDHzez4r8oz0vBMGOG1iNK9RW5V-1p9JWxL4thpOOQ>
    <xmx:Gz6CaopDQeVzLvBLfcI8PULfw8AQf-En0bRl2QFHJRgtK1looePk5Q>
    <xmx:Gz6Case39aqqM3ygzLuRqDDXwiYAOEZii_dRxfn08yCZjZmzQlMRp-6e>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:55 -0400 (EDT)
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
Subject: [RFC PATCH 53/57] selftests/mm: cover collapse of mlocked ranges
Date: Sun, 16 Aug 2026 23:46:05 +0100
Message-ID: <20260816224609.308019-54-kirill@shutemov.name>
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

Collapsing an mlocked range makes the teardown do something it does
nowhere else: the sources have to be munlocked while the destination
arrives already mlocked, and munlocking takes a reference.  So a teardown
that reaches a source before it is unfrozen fails on a refcount that is
not allowed to move.  That is the one ordering constraint in the putback
with no other way to be caught.

An mlocked range was collapsible before, as long as the whole VMA was
locked.  This case is the other shape.  mlock() over part of a VMA splits
it, leaving the locked part smaller than a PMD, which khugepaged passed
over for as long as its coverage was rooted at PMD-aligned spans.  A
partially mlocked region therefore went uncollapsed however long it lived.

Cover it deterministically: mlock a window, collapse it, check the
contents survive.  Drive it under contention too, with a thread mlocking
and munlocking random spans across the race harness's region, since the
ordering only breaks when a teardown and an mlock overlap.  The plain
racers never touch VM_LOCKED at all.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 tools/testing/selftests/mm/khugepaged.c      | 38 ++++++++++++++++++++
 tools/testing/selftests/mm/khugepaged_race.c | 29 +++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index b61e32566d47..208300ecb344 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1599,6 +1599,43 @@ static void collapse_order_sub_pmd_range(struct collapse_context *c,
 	__collapse_order_sub_pmd_vma(c, ops, nr_windows, __func__);
 }
 
+/*
+ * Collapse of an mlocked window: source teardown munlocks the old
+ * pages while the new folio arrives mlocked via folio_add_lru_vma().
+ * A teardown that touches the sources while they are still frozen
+ * blows up exactly here (munlock_folio() takes a reference).
+ */
+static void collapse_order_mlocked(struct collapse_context *c,
+				   struct mem_ops *ops)
+{
+	size_t window = mthp_window_size();
+	void *p;
+
+	mthp_push_target_order();
+
+	p = ops->setup_area(1);
+	ops->fault(p, 0, window);
+	if (mlock(p, window))
+		ksft_exit_fail_perror("mlock()");
+	if (!window_not_collapsed(p, hpage_pmd_size))
+		ksft_exit_fail_msg("Unexpected large folio after fault\n");
+
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	ksft_print_msg("Collapse fully populated mlocked window...");
+	if (!khugepaged_wait_full_pass())
+		fail("Timeout");
+	else if (window_collapsed(p, window))
+		success("OK");
+	else
+		fail("Fail");
+
+	validate_memory(p, 0, window);
+	munlock(p, window);
+	ops->cleanup_area(p, hpage_pmd_size);
+	thp_pop_settings();
+	ksft_test_result_report(exit_status, "%s\n", __func__);
+}
+
 /*
  * A partially populated window in a sub-PMD VMA: population and
  * sub-PMD eligibility at once. The unfaulted slots must come back
@@ -1938,6 +1975,7 @@ int main(int argc, char **argv)
 		TEST(collapse_order_sub_pmd_vma, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_sub_pmd_range, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_sub_pmd_holes, mthp_khugepaged_context, anon_ops);
+		TEST(collapse_order_mlocked, mthp_khugepaged_context, anon_ops);
 	}
 
 	TEST(collapse_full, madvise_context, anon_ops);
diff --git a/tools/testing/selftests/mm/khugepaged_race.c b/tools/testing/selftests/mm/khugepaged_race.c
index 6682bbae0a8f..a4710130aabf 100644
--- a/tools/testing/selftests/mm/khugepaged_race.c
+++ b/tools/testing/selftests/mm/khugepaged_race.c
@@ -219,6 +219,29 @@ static void *forker_fn(void *arg)
 	return NULL;
 }
 
+/*
+ * mlock/munlock cycling over the shared areas: collapse of an mlocked
+ * range munlocks the sources at teardown and mlocks the new folio --
+ * the interaction the fuzzer caught (munlock on a frozen source) and
+ * the plain racers never drove.
+ */
+static void *mlocker_fn(void *arg)
+{
+	unsigned int seed = (unsigned long)arg;
+
+	while (!stop) {
+		unsigned long page_idx = rand_page(&seed);
+		unsigned long nr = 1UL << (rand_r(&seed) % 8);	/* 1..128 pages */
+
+		if (rand_r(&seed) & 1)
+			mlock(region + page_idx * page_size, nr * page_size);
+		else
+			munlock(region + page_idx * page_size, nr * page_size);
+		usleep(rand_r(&seed) % 1000);
+	}
+	return NULL;
+}
+
 static void *mremapper_fn(void *arg)
 {
 	unsigned int seed = (unsigned long)arg;
@@ -328,14 +351,14 @@ int main(int argc, char **argv)
 {
 	static const char * const thread_names[] = {
 		"faulter", "faulter2", "dontneed", "pinner", "forker",
-		"mremapper", "pageout", "compactor",
+		"mremapper", "mlocker", "pageout", "compactor",
 	};
 	void *(*const thread_fns[])(void *) = {
 		faulter_fn, faulter_fn, dontneed_fn, pinner_fn, forker_fn,
-		mremapper_fn, pageout_fn, compactor_fn,
+		mremapper_fn, mlocker_fn, pageout_fn, compactor_fn,
 	};
 	enum { T_FAULTER, T_FAULTER2, T_DONTNEED, T_PINNER, T_FORKER,
-	       T_MREMAPPER, T_PAGEOUT, T_COMPACTOR };
+	       T_MREMAPPER, T_MLOCKER, T_PAGEOUT, T_COMPACTOR };
 	const unsigned long pageout_bit = 1UL << T_PAGEOUT;
 	const unsigned long compactor_bit = 1UL << T_COMPACTOR;
 	const int nr_threads = ARRAY_SIZE(thread_names);
-- 
2.54.0

