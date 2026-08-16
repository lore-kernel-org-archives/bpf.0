Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC23F9F4D;
	Sun, 16 Aug 2026 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920446; cv=none; b=cNFIKDo+GxYfDUME26diFDDx5E+E54Dld+05j2PvDBemungvQLU8HNUJaE8Q8sO9IBiQvbdgkmL5FkLle28knQWRWKo5nLpB78aXAQ2vUs1AUK0v2SIt4OnHVblpGSIf/5Bc47iDFUpAgzFWdVUnSWWAoavHJvc0fVt84yzNEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920446; c=relaxed/simple;
	bh=tH7aBqcMPQp2gHhJGzoYFSPBz3m7t/BA8U185cyR/DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMse17rtjava2EoseM0cjwK2PmO+1MizCT6UxYvN9H2NvDitgNAHhyflIq4xLhVW6ZesYaoonSHDxALrSSDgWW6kZ5oEOl3a7ovNyIHomEXxRLd/bF23pfJxgxo44jKeIm6xtRHf5RVrvxhUomn2ApcjyEW0ZpA7NUTDmQh7mhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=uOcNWDuk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkAIi0+F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="uOcNWDuk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkAIi0+F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12CC214000FA;
	Sun, 16 Aug 2026 18:47:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 18:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920444; x=
	1787006844; bh=Z0cmyfIpPsi4r5/pE09ldrrp9VWmAB+T0yJDqsA9a2c=; b=u
	OcNWDuk6hsisB4OeqPabVopGNy13grQuzvgJq85TLmqA51ucU0aQ37WXnBEH/YNK
	xRzxr4yYNs1plWx6cVFdGkC/4CHlDzLZwJ5FNrMNvsXwqFRJ12YOdjCsuxnKK5Zm
	sbm0/BuPHV6sPp9Q/tPr719JszqofCKZtq28lD3HL+MK2V/IsOEMvDOjsyIVvhn7
	zbzNCExPuDv65XMmc8G6OlANQB3ADYjpseHsACi/Kpr0QbqAYA29bEEsq5fIOSsL
	BXsi1bAVxHAiyb5y/sgr6pSFp+BZnpVsRjEOaFLrQxaytlrB2/duubCkOtkx5ZDC
	B+5g7f0IbuoTH5CGKbZ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920444; x=1787006844; bh=Z
	0cmyfIpPsi4r5/pE09ldrrp9VWmAB+T0yJDqsA9a2c=; b=FkAIi0+FqJANMN1HX
	dvGYnwXMnZGnQxbrvxE9qJ+ujJP6jYfAta0Qydl/FKwcz8IC3PP1emysQBvt4ION
	Nz3AcHasVBCmHRxqVSVm5Fyyw84T2J1ss2FDyCNyVmiz7frF1A1rvqywEV0KqPhF
	H+DfeDI6zOxv8XotiiRhwedQxShlJM5nOYrusFnQ6T+g5cwR6eHP5Qh/liqtUYYp
	Izjdb3fZgtXiMW+ymZnv/ksh/nGUuXHsbREtOt+2LPnYmnFUqLRZjiLKICrU41gV
	D+OzmbIrwl5ugKHYdpIa8Z/DkRO3kHJDy3Xhw/ts+xIBTKOGwNgQ00aadEUFRzjC
	JAlVA==
X-ME-Sender: <xms:-z2Cam2LLSLri5sKKbFa3qCz3Wensyeb5Smi7bGPfMefmZWsuM-NhQ>
    <xme:-z2CauaAl1EB95jC_dBm9cLDzHnq3bXgnyhfnswSdxEXbEoFphTDPMvVv2DqYfWPN
    smHvPHT37wJnV9PzBM-et-ZBc8mBrRr1XcU4XOiZQiZImPlzg8FQko>
X-ME-Received: <xmr:-z2Caq99JoBGqtFdVZuO2dEzWliJyKNNuIs8Ohf4kr7hazhHbHXh7TtqQLk>
X-ME-Proxy-Cause: dmFkZTFlVyZDQeKVm/cv0R7Uo2AcdsoROSs+PNN+RMPWNFgEb+eGte/fI2JmPedO/gUmIe
    OeoZho3fHA3jq9U7FHaKLb7Pve0ST4uqo5iHPPAgdpzTDnnLaz+AJ6xkiozNrpK1meLIn4
    2sefU5BkNXUp9QcsQtONjZ0nUOLKoeupvv0JrZV8hAC+7fEjHSt2kKuDAbX3om+BmKbYq3
    FepF2Gq8LX713eWlXPmLkfGboRIv9L2g+Y4/FUEyMpnFgJsl0SpF+3p/+THHwbO3LtcR+N
    5KYVcWsQpsjE5I4FVrmdf0VHbzDD4H+sgFlZmgmVgtgliSro7zGS30VizlBSv+ooeZSJRL
    EqJyIKEeMiqcYtpukkHWvUxjLMWEpzHN7YOdlRnSW1LWMwkyRw9mHhg8vb7sytLMPBmOYq
    gShL0XyER5ei2tmZGVRjzvcxwS73NM45HQRDl8UV+z8O0eThEaY5NVORggJz+kwv5S0Rpt
    ufdX2pA/xxTUHhdIF1Wdck2LhiU4Kb2rberi3q4k2/E2MOq1pjRebomwn6ZV87is1ziRLa
    Y5f+B7wVSRzeuFHZnsaKZMrOyZTv3v13m+LvJzRjJZvoYi/mfKk1+4WHcVf6RYvqLO3GgY
    Sq1f1Yxu3n9naNwyx9jc1/U8r6cROKfXaEKiJDWRNYI8Cax25Ayrhnm8WK0w
X-ME-Proxy: <xmx:-z2CakagL6K8AyPnhRZhAsFaWjaoerflEDDmBv7NMFLciuREnersFg>
    <xmx:_D2CavViL0yOgjHY6fVHXHVOSx_tvdeYriPQaTFDrxWO4VC3ALsZpg>
    <xmx:_D2Caqhe8sLGW0yNBAMFwH3CJa4zAJqblfvCVIqNyPxl-YAYoY98oQ>
    <xmx:_D2CajmS5RGBRGj0dDdw8pkjZrtm_toxaHlYgpDD6KamxWLN6bMbrw>
    <xmx:_D2CagJo6gmqteZ2Gl0Z-Fz-EujJf6CbIpyRhLi_W30Z_DeHGHhR3_Ng>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:23 -0400 (EDT)
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
Subject: [RFC PATCH 35/57] mm/madvise: drop MADV_COLLAPSE's redundant mm reference
Date: Sun, 16 Aug 2026 23:45:47 +0100
Message-ID: <20260816224609.308019-36-kirill@shutemov.name>
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

madvise_collapse() holds an mmgrab() reference across its work, which
nothing needs.  mmgrab() pins the mm_struct alone; every caller already
holds mm_users, which keeps the address space itself alive and so implies
it:

 - madvise(2) works on current->mm, which lives as long as the task is in
   the syscall;
 - process_madvise(2) reaches a remote mm through mm_access(), which takes
   an mm_users reference and holds it until the syscall returns;
 - io_uring passes current->mm;
 - DAMON takes one with get_task_mm() and drops it after the call.

Drop the mmgrab()/mmdrop() pair.  It has been there since
commit 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse").

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/madvise.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 76ddf61f043f..c1bb425be3f4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -979,8 +979,6 @@ static int madvise_collapse(struct madvise_behavior *madv_behavior)
 		return err;
 	}
 
-	mmgrab(mm);
-
 	/*
 	 * Nothing below wants the lock the VMA walk left held, and
 	 * lru_add_drain_all() waits on every CPU, so give it up first.  The
@@ -1071,7 +1069,6 @@ static int madvise_collapse(struct madvise_behavior *madv_behavior)
 	/* The VMA walk this returns to expects the lock it was holding */
 	if (!vma)
 		mmap_read_lock(mm);
-	mmdrop(mm);
 	collapse_control_release(cc);
 	kfree(cc);
 
-- 
2.54.0

