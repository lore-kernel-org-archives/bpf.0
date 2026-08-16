Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A63F823C;
	Sun, 16 Aug 2026 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920439; cv=none; b=i8IM+l9UwId3zvT3MjfhHnbqfP71iNYJUNIuo+t3n+pF5rMyGL3TEoTG+3CsybKnc0gYehsfKaA3gO7PYH44r8BpLPBFoPKA8yVwgE3Nbegs3YRDJ0cCMaRj+HKr/mgFL2akDLCAVYIhBnVaSGMarvzuL+Nf22/cTAs8a/CZrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920439; c=relaxed/simple;
	bh=toGrETRjFAsfJJZlY7GOsW89MNqqeWVBezibGn00oKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVD382TkiMp01am8bNAvWaklaPqgTmUtEL5DZ6GR75ShEqZadPeaVwnkaSIwZndfeluD1F3AG2pAfsG0fLaGDsqC1X6c8Ga7DUU9JR5WPSNbhY8j9l69nFGCqVnRmjpiW8GKgmt7VK09R1Oep8zNgCYlsRneC/+s5nT+vv1H0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=nFwpijY7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kzT8VXqp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="nFwpijY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzT8VXqp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D792414000F8;
	Sun, 16 Aug 2026 18:47:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 18:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920436; x=
	1787006836; bh=j0njKa/sU97UuU9BC7LS/teFWmvcsdJR3szFnz2Zzu0=; b=n
	FwpijY7TTDo0MOviKSKnc53xYc9LVC2yNmby+rLfbuoxdBpQG/3VfPzA5ScaZeQk
	VJBprsmLnSS9QYbRHPPzoMg7QYsT+NyU/2WTHigZ6gqh7N5H0aRa+obNo5lMnz9+
	LIUDzFyF/ZjCZErzr6zVwQ1Bqrn2IKjWUutXndjWljG5vv3jDQQftjn0QIoD64xC
	2f3eqT0rHMRdKWY2omcSMPpKCKRv08oyTTG89ScCptgCjx1VNjOa5VqeDkOPl38C
	cUpqL5oI7MPT6jutBz2ks6pLq9EAP+cGTQHvOQC0TApQdjIbK8mUwp1tIg001iOI
	S0IJE7xr9gVjevZ4YO4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920436; x=1787006836; bh=j
	0njKa/sU97UuU9BC7LS/teFWmvcsdJR3szFnz2Zzu0=; b=kzT8VXqpML+W8GnWr
	QIdRiSkVJ/ZiLN2FHS7sFEVJfNIkVJg351UzPogM2LODLj3cfPmCV2O9dlYdokxr
	umwrk5AyQHqeMU7FJZzpfG6+TZuCyKnYVn3KOU6almFI5JnAvIrL+MV99NFSX5SW
	BtosKOzNt3bvMBShA6ykTWrhsT0qdk38rzrhAHFBCDBJL/gjhrbFym1ENyCWWliM
	zZmoMQCjlY9/SJJOUQperbWC6Je6wJBw+2Dfw1mNkNjIR06KkwiROJR3rtRq3F5/
	zbmaOWTlngBrg331nR1ETZ1AKbvzjLjbaWWCILyxzYcPsjs4w8vqyype7S48NZtx
	Y5b1Q==
X-ME-Sender: <xms:9D2Cao6T5Am1e-r5CD0avxfP5709yrBmlLEORGHXdGmAIC39KeJx7Q>
    <xme:9D2CavOcP4jGWAHUNEcMvIego9GeLyH2Wk3_s1cXQKLobntMaDZ5UV67XMxRhlexi
    Hxl7qJW8likbxSG6ag_v-5yHAUOBItXmZS4iyJw6GpdXbTfahOmV-8D>
X-ME-Received: <xmr:9D2Cajgd6vC6RFnaGmhCQBGP17PPITMPDvGVHdwBty4dSVubsGVqrW-7L80>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTD5
    ylGlg2zq7m16jfM5uHJgPlIYbMxnPsaFzwmzt7lRLFaMXcTaKz54PlFbIvjMQOW6UMRTdo
    qJTi5mkLOtGPpWwYdcJg3eekaqRuyFT/TOyP3TJ0aR58vKWg9nB3VYpnFoaCeuEyCZDDvw
    1qnFPw7SZrPjoeir7CLHWxY6h3tVea27Z8Lz3Tztdek1L3AyXroPtcmRBi7gaOu/mMWaiG
    rWJ7/Akg0ggNjjzmQJ916tdv+9CwLGhh6B0ikeVXChonVeoq7RofIRBCPlDV8zcgCVXDWt
    nLtTsuB2Kqk3/b5bDoi4k+l6PtTz8vhwuFM3WW6Bwr3j7x1JzGPB+AxSWHrg
X-ME-Proxy: <xmx:9D2CapujG0eb3guYgTN0rUcgfdYrtbP7M1C2IyVqEfJk4AK6_R5Mpg>
    <xmx:9D2CaiYsB1iNLiiYVHWmUOe3GE9Qc42J1jvBVhp6rRcUeRFfx8nOaw>
    <xmx:9D2CaoUOwaM1cqyfUTQlZ0Ov3O0XdM8OS0SXWww0LlS2ShvswIXv6g>
    <xmx:9D2CalIBo0GVTkOiwUPSyb6LqXojuXSGUrcbPgbTltcL5pjE75c8CQ>
    <xmx:9D2Cai9S2yg3REmeiq1hjM5akrxYFYgRDzntBVAlYzqDtQ8kirDAfWtd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:16 -0400 (EDT)
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
Subject: [RFC PATCH 31/57] mm/khugepaged: count collapses where khugepaged makes them
Date: Sun, 16 Aug 2026 23:45:43 +0100
Message-ID: <20260816224609.308019-32-kirill@shutemov.name>
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

collapse_single_pmd() bumps khugepaged_pages_collapsed for its caller, and
tests cc->is_khugepaged to know whether it should: the counter belongs to
the daemon, and MADV_COLLAPSE must not touch it.  So the one thing the
shared path still asks about its caller is bookkeeping, not policy.

Count in khugepaged's own walk instead, at the call it already makes.  The
question goes away, and cc->is_khugepaged with it -- nothing else read it.
current_is_khugepaged() is a different test, on the task rather than on
the request.

Preparation for moving the dispatcher into collapse.c, from where a static
in khugepaged.c is out of reach.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.h   | 2 --
 mm/khugepaged.c | 9 +++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/collapse.h b/mm/collapse.h
index 94c11051f06a..11f51c6ea444 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -114,8 +114,6 @@ struct collapse_policy {
 struct collapse_control {
 	struct collapse_policy policy;
 
-	bool is_khugepaged;
-
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8c770e251c22..907ed1131460 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -458,9 +458,7 @@ static void khugepaged_alloc_sleep(void)
 	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
-static struct collapse_control khugepaged_collapse_control = {
-	.is_khugepaged = true,
-};
+static struct collapse_control khugepaged_collapse_control;
 
 #define khugepaged_defrag()					\
 	(transparent_hugepage_flags &				\
@@ -1639,8 +1637,6 @@ static enum scan_result collapse_single_pmd(unsigned long addr,
 		mmap_read_unlock(mm);
 	}
 end:
-	if (cc->is_khugepaged && result == SCAN_SUCCEED)
-		++khugepaged_pages_collapsed;
 	return result;
 }
 
@@ -1731,6 +1727,8 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			*result = collapse_single_pmd(khugepaged_scan.address,
 						      range_end, vma,
 						      &lock_dropped, cc);
+			if (*result == SCAN_SUCCEED)
+				++khugepaged_pages_collapsed;
 			/* move to next address */
 			khugepaged_scan.address = range_end;
 			if (lock_dropped)
@@ -2039,7 +2037,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	cc = kmalloc_obj(*cc);
 	if (!cc)
 		return -ENOMEM;
-	cc->is_khugepaged = false;
 	collapse_policy_forced(&cc->policy);
 	cc->progress = 0;
 	err = collapse_control_init(cc);
-- 
2.54.0

