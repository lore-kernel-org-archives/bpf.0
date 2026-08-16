Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8E4156DA;
	Sun, 16 Aug 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920470; cv=none; b=sxXUd+jJ0gNvu2hHQ6c6t+kAX0RH6k2oPuJXt40d8Q5+SKQQLF5+BZY1dg5yRco08UMfzUcl9l8uSRWLqFD/0Q/zHmvkIOUxXYIk85UVV1iA5E9GxD1Mkd9JkTRxWQWeIC7J9Esql5Hs0a2Jm2J0AmIglx9ff+8RwK+eNJTU5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920470; c=relaxed/simple;
	bh=5z8qphyv0VlAuEc2ngiQhIwupgoOuFydmJLL53f7IOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cdc/Mcf+wDwzL2ADaf1FZ7Wmo4eGlkKnwvB8NMouRT5E2xF906aofjSCJGmrY3K/3LwBs7G+KlT4eVd0uuyTDORhbRl3/z5cPgYe3uPT2TcJiozdapbXCCNE7ra75hudpHqJ+a5YT//ABRaGq6uM73t+HDUu2fBK6r4gGEYi9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=R/D9hrJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMcHegD+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="R/D9hrJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMcHegD+"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 918E714000FE;
	Sun, 16 Aug 2026 18:47:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 16 Aug 2026 18:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920468; x=
	1787006868; bh=RDFiXs9UFefjDWAntFW6mYoilxTkA+zz17UfIDflfSQ=; b=R
	/D9hrJ/A6K3alQkubIQewlCsyxKk99E71DYl22d+XE0UTS8oqhOmPEXALqrmtPT+
	fhuQgCJdw2MUES2F9umkeZgwgY7Q+WO2UprI3k8gGgT9QVoKAYH0w2Yrx3UOpMRK
	T0EH6CMchU5fZMIz+NZ7j8tTZ0ons48Jar8nhm4n4gHQPLkgbj6fAW6o25vFywcN
	f7ZtVUKrem5+kj6u9Jezo+JKRRKvfGWl1AtB9D598iwPDoetjHIJBonwWcHev36V
	fpQ2h5896OHtH4/c0B1nLJ+qk+2/ePN4qBAyPZqaVs1L0VusKect+tsF/9Topjf5
	cYlwFEB4mSG/xDuea4zLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920468; x=1787006868; bh=R
	DFiXs9UFefjDWAntFW6mYoilxTkA+zz17UfIDflfSQ=; b=cMcHegD+siSteXceA
	eORchYYJpRg5mkjZpTJ4wtDQd1qhM4icwlRxaOng9Siw3K5cRYYAp7ay9pM9UbSi
	Crhn6tlhUd9aPwxLjlsga0sRqVLTa65D6RmWWVm0Z1/+jSLfVsxsGUFqZDtsD3da
	VwPhwjZqGp4gyFSzD4nBVo39qToJWxBQlF52iv/0BRsc4m+s5VJF9th88pwnxahQ
	zmSTYQb6PCLMAAiX1c1BLtjdxHH943hWM85tvUwHXmJNmBX3SXis9thMwQiemlzn
	VFWqoNl1GjEteU5c4kuGSgUd1IXh7wV2yHsqdNjtc6VrqiO92KGGjP8LSgVjdJT3
	3cy8A==
X-ME-Sender: <xms:FD6Caij5zk7EHpJYk0SEVw8nfTitQEEu943h-uXF36WJ-orjngfDXw>
    <xme:FD6CaoU7Ta24wJTMCQqNgdekAeNJJhvn77pjj6-pJD3HyDu4ao6fcLt0ktvzm9gwD
    VxNGk0LL5lCDQiMmp1q35P8SAnkeAtm7STFPtRlp6v2tju2s1cGw58>
X-ME-Received: <xmr:FD6CamLNxb6VLNY6dmwcc0n63rIkmfjVHsD-n-qava3lM2QLm4vFk2T0lmY>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTlc
    EbUeQzhKxJEmsRwlRPWupCudTuURb990558e34xXePZqhKsdittFqFVB13AvKNBPn+zTIC
    vmM4mIxGpPzx/nK894dSAKdZpvpkCU2McTpnHaRUIk0aWa95Ge9rfXUXULEztRAndnCYbt
    4qD7P3eAyIA5OFPCP2oHhYFpAkBT0mo15kPYR7H5/b3GrpRM2b7kXKyktWAQ4dA2U9USmE
    fM3n0gonMJM6KinITZmpApKtfVndLpnhEgoZeb0eJJWbRvyWRI94p3CA2ZvaB1HejNnPzR
    Unmc2v7FvenSNzXmIHyeuDNm+B0nonswhiJxC0bKiq5ZtPtGImr9bjx9A2Bw
X-ME-Proxy: <xmx:FD6Can1hoyC6PmwnR3KJ4dbo6AaCtxi4W6oWnQ3-zNUMuqfvESwEww>
    <xmx:FD6CamARxPMeY605qB94pGmuSHRBTI814URQxpldxXLXdEAlV-iRxg>
    <xmx:FD6CajfEmEZ_BSxer4SMt38i9c-XlD2tG1D68WIaL60-b1zGoTyJBA>
    <xmx:FD6CahxK0UCDvcRAJW9wRSf3H34UNiXlP6VB0qkJ-OWmeTGneOr14A>
    <xmx:FD6CagGoFvpkcKSU7TANtFqL-or-_aq0-dmKR8_hl6WToLkaPkCRXok_>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:47 -0400 (EDT)
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
Subject: [RFC PATCH 49/57] mm/khugepaged: drop the mmap_lock barrier from __khugepaged_exit()
Date: Sun, 16 Aug 2026 23:46:01 +0100
Message-ID: <20260816224609.308019-50-kirill@shutemov.name>
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

__khugepaged_exit() took mmap_lock for writing and dropped it again, to
wait for a scan holding it for reading before exit_mmap() destroyed the
page tables underneath it.

A scan now holds a reference on mm_users for as long as it runs, so it
cannot be in flight here at all: __mmput() runs only once that count has
reached zero, and asserts so on entry.  The barrier is redundant.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/khugepaged.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1d77d9a8046d..2b3364bdb100 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -434,16 +434,6 @@ void __khugepaged_exit(struct mm_struct *mm)
 		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
 		mm_slot_free(mm_slot_cache, slot);
 		mmdrop(mm);
-	} else if (slot) {
-		/*
-		 * This is required to serialize against
-		 * collapse_test_exit() (which is guaranteed to run
-		 * under mmap_lock read mode). Stop here (after we return all
-		 * pagetables will be destroyed) until khugepaged has finished
-		 * working on the pagetables under the mmap_lock.
-		 */
-		mmap_write_lock(mm);
-		mmap_write_unlock(mm);
 	}
 }
 
-- 
2.54.0

