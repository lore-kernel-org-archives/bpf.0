Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6F3F4DD7;
	Sun, 16 Aug 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920428; cv=none; b=dsePw5VXDDET76mLJZBnDsvMf4Exl310Rp+8xVr+dpIPyan/BS4ZTOcNUNAANNuzhn1LMG6FxH4fHyc4N8SlNanu/ZQmiRwPSHxesoM1f4sQGgOyew28qPPkhY1lnkc55rwaFl1mXzeXA3tpeCIvLUahr7w3EdLBlk5waKtBv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920428; c=relaxed/simple;
	bh=rXDOP2lazn8hqApcn6UuIp/qgHOhDYu0/+0jCK61xSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM63rp+x5KAJ9bHPW2TWD5sKa5GcCDMoWzAMFBfwjIuyMF8+OXgeg23BLM1eNfKoe7j8tua28s1gqwYjR7o1oT0+0IGLK+OYN5TO0v6M07eIMCv8DVBqTOhQVR3l0ASNArweeHc2n7r9dnXNMPJbA1x7+1nVw1gjcOyMfb043kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ei6Waa0k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KctISWAq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ei6Waa0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KctISWAq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33F2514000F8;
	Sun, 16 Aug 2026 18:47:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920426; x=
	1787006826; bh=g/bEmHChGXXUr4LI/M464ypgkDiKtYjukQog+PJvxwc=; b=e
	i6Waa0kx1JeztwEvkH7Ff200lYEintKhm9n8taz6+bc7eEjLWupgfwUZ7CWItYkM
	2Rn43iFJOvlPRnH51Hgg2xJ7+H7866S3YBV7YbWu1LzMtr1v8tS0Ozue/Tf1ZSYQ
	Fr9Kh7fq0yU1zBXvlJzbNWo6FVL0RQ/i6dy1wYd6jN6FAvBpvDOv19Zp7Ae4VNdK
	hqIdJA5GeQO18Qm4hGbkOS32fUXEqf512NYKfKFchNpjNRXFGPuuWYL9cK7GUupI
	E5iOXDGzSn3jQAxqA1rGfPfXYsbPcP5mf8Uu3VdY7Ng2qrsnUURbYEpMw1rXOrH+
	AhXf+0FPEOh2Y0pdB3Rqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920426; x=1787006826; bh=g
	/bEmHChGXXUr4LI/M464ypgkDiKtYjukQog+PJvxwc=; b=KctISWAqOVGNzO3uI
	qUUJkvTYfOuq8nQ9ZBuU3O7uZQDSx6Y23srlgaQ2pPIN98XBQHk0crb7X2+82lI9
	47S3CEe/ZbBo1+Yd+Q3SszJ5WYGeCCw0Pb+jekaXRk505lB06Ol0XHi2ePnP3p8p
	JCZSQT2Ct7CIBoci6RVWvambGzUrqgr70a8Nu842IaglBiwaZvCCu2oE2Wb7FteH
	44Wb4fDGgn4XCO0TNpb8iMuGW1f7r4/EMOuau7bZqwcquYtnctmwb03QbgRAzCKg
	tCxf7D/xKNQoW09nKQLobQf+vzzbuWcSTndkfMPifmJnoNcq5rFaii3A7e0mf5dJ
	jz3Yg==
X-ME-Sender: <xms:6j2Cah_2sr1iVSXmYImE-dJCURkscxE_V7MGFYQgcd-596KcxwOSIw>
    <xme:6j2CarDaWR8aP6VuAvuATaLhOOuh2tbrxoMJHVIHcj5yTmPrjr1NjChf1f6TzkSxr
    9ycyM0x21ffu0xrbnQMKXRY_7kqSnPrj1VzUvlaRv2iN2q-KzHM5NVj>
X-ME-Received: <xmr:6j2CarE0yqrEd0f2GsEVz6n-PruGtAMFlYO-E4_t0GmMcXD26B2y-r5_ghg>
X-ME-Proxy-Cause: dmFkZTGlsoL4dlGZVhjNGnyng7DWLkzd23+vL0S14uJaq1tszuZ6c/qXpcKjIN3SVavrqW
    anksLy7isjEKJzVCE9/It/QcezLPAumFeVWWYf/196d5DKxXijJBwwHlwdbhLN8+Q20ZSw
    VAcGFAGUZDfCfgJltT5NnBIG4Gh7JxdfG7re68r55pgQSoCRLBnoP1i35vKgO+O/kd9+lz
    qLG43ny3AnvUx0aE1SnxP3FJCiuv2lDE4FRTwfST8/uDABclrMy6sZKUEjfd1WPzb5NlOP
    S5qghqIOcnVKJHuC+GM/K5ckB8SXpR6Ag+KqE5QSQT/v+DpSzaOOJbUo2XdsQxu9tqIPpv
    n09TP7n+3O6PIcr4WyyYUg9u90X9r/cVsCqHguDiVmkz5B1ez36ZmXEudDYtVH55+e6bCK
    KD2uHs8jsljSrOCCQPiL6eMr8S6teHqR+yZdv5bSo99ujysnSUwODNY3DMq2uOuYhc/B1K
    zQd8gpF7lAHXJCYb5Gf3L/8gFrxBSdbUcXNXwSJdHiMT6VIr0Hbyj5mC/SwERAeAvPFx50
    mW3688759fv6PqAubbjBheKUmrOIHeCnR7QwRCZHDUwZPqhY9eJVsFYJ4M8BVHsY7amxmx
    /+VZW7YyA4oFHyCdj4h7m+U9nJCAvQgbWOMZ55UwAOCzJinUKyhZTVU0sDzA
X-ME-Proxy: <xmx:6j2CaiBYKFJ9JEQPyD4Ht4sRDGqQejtQ8K3vEEF_M-w69Czph1Kuyw>
    <xmx:6j2CaseGOzdZVy9VVB0tVx2JaQZaQc5t3rj7yw0BL5oDUxgtSBxOyg>
    <xmx:6j2CahJL5OBptOY68ktfWz7AoPlzlXqQZJcJmDxqPCZlKPu6bQXBvw>
    <xmx:6j2Calt3BgrxVe-AL65jGOfKxgsTkK47V59fEBP8Dz4GqSqA_KOIrw>
    <xmx:6j2CagwMipzX3UJtB1-Vp8W4qatAWCj_UL27CW_krc7w3RNgwzJuhCct>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:05 -0400 (EDT)
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
Subject: [RFC PATCH 25/57] mm/collapse: collapse anonymous memory with the new engine
Date: Sun, 16 Aug 2026 23:45:37 +0100
Message-ID: <20260816224609.308019-26-kirill@shutemov.name>
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

Point the anonymous path at the engine.  Everything it needs is in place,
so this is the whole switch: collapse_single_pmd() calls
collapse_scan_anon_pmd() and then collapse_anon_pmd(), where it used to
call collapse_scan_pmd().  The scan runs under the mmap_read the caller
already holds; the collapse is called after dropping it, and takes the
lock itself for each round.

Both callers hand the engine a PMD-aligned address with the whole table
inside the VMA: khugepaged walks [ALIGN(vm_start), ALIGN_DOWN(vm_end)) a
table at a time, and MADV_COLLAPSE aligns its range inwards the same way.
So the range passed is always the table.  The engine accepts a narrower
one, which nothing asks for yet.

Two things userspace sees change:

 - A collapse runs under mmap_read rather than holding mmap_write for its
   duration, so faults elsewhere in the address space are no longer
   stopped while it works.
 - A table that cannot become one huge page still yields the largest
   windows inside it, where before a single disqualified PTE gave up the
   whole table.

The result the caller gets is the engine's, and it still acts on an
allocation failure by backing off.

The mechanism this replaces is left in place, now unreferenced.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c   | 15 ++++++---------
 mm/collapse.h   |  5 +++++
 mm/khugepaged.c | 14 ++++++++++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index 91ff20138a8e..df3760e3918b 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -83,9 +83,6 @@
  * consecutive pages of one folio -- so partially mapped and compound sources
  * collapse too: any order below the window's is a source, and a PMD candidate
  * takes even a PTE-mapped THP of its own order.
- *
- * Nothing calls any of this yet: the anon path still uses the mechanism it
- * replaces, and is switched over once both halves are complete.
  */
 
 /*
@@ -1926,9 +1923,9 @@ static void collapse_anon_scan_init(struct collapse_control *cc)
  * that acts on what it found hands the range to collapse_anon_pmd() afterwards,
  * without the lock.
  */
-static enum scan_result __maybe_unused
-collapse_scan_anon_pmd(struct vm_area_struct *vma, unsigned long start,
-		       unsigned long end, struct collapse_control *cc)
+enum scan_result collapse_scan_anon_pmd(struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					struct collapse_control *cc)
 {
 	const unsigned long pmd_addr = start & HPAGE_PMD_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -2337,9 +2334,9 @@ static void collapse_add_candidate(struct collapse_control *cc,
  * largest order downwards.  Returns what the table yielded: a collapse, or
  * the reason it did not.
  */
-static enum scan_result __maybe_unused
-collapse_anon_pmd(struct mm_struct *mm, unsigned long start, unsigned long end,
-		  struct collapse_control *cc)
+enum scan_result collapse_anon_pmd(struct mm_struct *mm, unsigned long start,
+				   unsigned long end,
+				   struct collapse_control *cc)
 {
 	const unsigned long pmd_addr = start & HPAGE_PMD_MASK;
 	unsigned int offset, order;
diff --git a/mm/collapse.h b/mm/collapse.h
index 34de3ebb05e3..50a9d59bbf03 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -186,6 +186,11 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
 		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
 }
 
+enum scan_result collapse_scan_anon_pmd(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct collapse_control *cc);
+enum scan_result collapse_anon_pmd(struct mm_struct *mm, unsigned long start,
+		unsigned long end, struct collapse_control *cc);
 int collapse_control_init(struct collapse_control *cc);
 void collapse_control_release(struct collapse_control *cc);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c7c933e819e2..0662d08f7c60 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1553,7 +1553,8 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 	return last_result;
 }
 
-static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
+static enum scan_result __maybe_unused
+collapse_scan_pmd(struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		bool *lock_dropped, struct collapse_control *cc)
 {
@@ -2749,7 +2750,16 @@ static enum scan_result collapse_single_pmd(unsigned long addr,
 	mmap_assert_locked(mm);
 
 	if (vma_is_anonymous(vma)) {
-		result = collapse_scan_pmd(mm, vma, addr, lock_dropped, cc);
+		result = collapse_scan_anon_pmd(vma, addr, addr + HPAGE_PMD_SIZE,
+						cc);
+		if (!cc->select_orders)
+			goto end;
+
+		/* collapse_anon_pmd() takes mmap_lock itself, where it needs it */
+		mmap_read_unlock(mm);
+		*lock_dropped = true;
+
+		result = collapse_anon_pmd(mm, addr, addr + HPAGE_PMD_SIZE, cc);
 		goto end;
 	}
 
-- 
2.54.0

