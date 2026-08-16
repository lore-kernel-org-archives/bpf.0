Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E93FDC0E;
	Sun, 16 Aug 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920455; cv=none; b=BvIWNpZj8B5VOeZcgP9OnUmvc0mH7iWcYGD90S0FZh0TOLZShiQG7+BH5EORCDhDknHK0MGp9IH6IjlkjfyFIZ9PJFI/VUJLHYzBZPf00+vp/k95FPPwD5pU2PWK1OmvuOu6rbYXQStrMRvs2BdOtxeOyvxFCMoSEny56a9z5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920455; c=relaxed/simple;
	bh=pcjGGSxxxLz1h9L02X12hc7fivat5KXReUErdn4Truk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhxzJ8qqOrW4Gc3Jn87fB26hwDI3U+39AzxpcV+COBT6Gbqs7QuKzPTReujFX7raulh6avar6gAb+LcC6xgB4lS397/FxCPf8cOi+kriY5OF84v3R/5hD672vEreIuN9o7TJ/pI1cjdqE2UjcFpeEIeqpybLiUQpXcL+aVRkFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gswbJJkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1MZ5/c6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gswbJJkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1MZ5/c6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E70FEC0074;
	Sun, 16 Aug 2026 18:47:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 18:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920452; x=
	1787006852; bh=QzLUHFRii2gq6ACAxatB8F8suZiMKSOoddlYvZzHBZg=; b=g
	swbJJkID1QsVjOARJRQEemN69kiFpzyr+Mt7D34rSba1wHp/hOzc3cGXLET3iNCS
	tBqLFgEqokNSzd9iU45z844C2K+jbK5nTP3V+25a+TglzB/VUebojSICLNM1irnG
	qHqAWBB7Z3PMADn9c+fdCtnltLQ5u7uiJq08DsA6ETTRqtjAF8KJ3l0LTQVxQOF8
	+feuumKMO6IpJuTcsTHTvT6lUrwoT8DcaTCBtTpM2eqw/4AubVswrjp4QquzTU8+
	qOWKmXU01SRITpbhnsTPr0ArlNrikkjFxxgjxAdZ9agI0FJ0P/krf4dAaYwAP6Fh
	08ewTb5Gt02+1ste71YVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920452; x=1787006852; bh=Q
	zLUHFRii2gq6ACAxatB8F8suZiMKSOoddlYvZzHBZg=; b=U1MZ5/c6jWxKp9TY2
	r+UeUxfnV92NvTdQmc2rYhwT6aaj4KjUx0gmqO3ibqTzkf8IvndbM3Mi34vVJZ8O
	w0K8qDSl/6fPO5/CUWnLb24ho2vmJv3Kj24OAr/PmySFGM13wChEX5xozXFBGMOJ
	5h8jD5Br+4a1eeRHGq4e/Op43jbUeqph2FpNxW8iX6HXA3y/VLpu7UKX+Jd/GZy8
	uh7FuYijgc1+pfSNYj1rcEe4F3LkU5JUmtZbBfc50MN4O5/sRUdWrXqieArZDyy0
	EogELfhjQGNcolaF+X/BtlVDNUgbVgVzkLwSIWMlBjXx9HWaDXdLVHIl1mfYogcN
	4SNcA==
X-ME-Sender: <xms:BD6CarVQBBBgHw2kUTH4BAQTAgoW0vNo9-T_V1s-Gp8SZNL37qO3hQ>
    <xme:BD6CatTdwey4NrVUNtFdsMC4zhu38jZ6OE6ELbMhZBQ2bkGwdMMYHhn5BXu-xFR17
    2hzaP8UbHdQE2mbhz6xB9R3ThuiLuDa5WyhDZ5iGYUwyts8CGyzUYxO>
X-ME-Received: <xmr:BD6CamssqVI7mMqy3VkSXmm3JwltssFDc4jSWuOrT6m6h8af7N1_ZCRsgCc>
X-ME-Proxy-Cause: dmFkZTFcTQrb7i2Wnr2aEeZt1aoD7asKutBPdJgU3YSD5OfcfuljRo8Y5zG4WAng55KhcU
    fdYu9dW0n+wtsUDWiYHh8AwjWiiyOeVLRvzra0gUIzgKMFXfu2OsH3wUsDwz3Dpe7vEjB9
    JjBmMfD78Db5X6Vl1RDz8Wz4IQF1tjtPvs8yYIcZ4vdtxAZhotrvrKr9o/e/MWe2qw9p1d
    u/4ngMViLbtWn8zpPvYSIgtjaF8APmxmHCU5Ga5Rd5eIGcQp1MbbGmkchmHrMFMoUd9mrv
    TpVQ9+TKNOdfLLUK+2CPoHpagx885EUQUSZxhSq0AxxU5QJRQ+JA8yzxyjEYMjW1uFFjH3
    KM5L2v8sZoJpHBCvI6Nsa/j6UZDwcdngSl5LZCfOF7f6wAZPSUOnJLz4aLZzXuecwrvcr5
    zhoDLChk4xqwGS1DiTGDHhodMYwKhBIzVXpaVBMmQBuijJi+gtMZx9AYlrVSShheB7nXiE
    D9fJK66yif99eFxt4yYvz4rkygDBGnFSOyJlmhNlLizlPFuj3MnDi4HECMSMT7L57BEJem
    zxSv2Uc51Suko0811otPJ48mbAVKsa1BGF3GG2NL/bPloFW20n0QACLTfTdRZ/rZ/K/XnH
    DIZ7dAY4OKAldJMJOl+s79NAIATJ65Dt3g1HhgU92eBcsPMM9Qk9kXneLfeA
X-ME-Proxy: <xmx:BD6CauYplfxXEfleisltafahvNcy0Ua-PPDAB9dIRs5q8ZbSMhGrNQ>
    <xmx:BD6Cap_P9_949TD2TLqmmbjknm09sokO3rgCtxW-GnjiLCj6J10nYg>
    <xmx:BD6CagDlmYZFuleHsZ4G2ZMFJDGw23E8HnrLf-paMTRqjnmD4ynjSQ>
    <xmx:BD6CalveF8zZ0klvD55XC0oeKBR5d09sXLyr7wcBaW5ip9kUzdt7uw>
    <xmx:BD6CajGrvtAdRWpre7gj_gywfNTHwtItj5YhVfieKUyP7BYy_m96MDkD>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:31 -0400 (EDT)
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
Subject: [RFC PATCH 40/57] mm/collapse: remove the tracepoints of the mechanism that is gone
Date: Sun, 16 Aug 2026 23:45:52 +0100
Message-ID: <20260816224609.308019-41-kirill@shutemov.name>
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

Four tracepoints lost their only emitter when the anonymous mechanism was
deleted: mm_khugepaged_scan_pmd, mm_collapse_huge_page,
mm_collapse_huge_page_isolate and mm_collapse_huge_page_swapin.  Enabling
one now does nothing.

Remove them, and the two entries they have in raw_tp_null_args[], which
can never match again.  A tool that still asks for one fails to attach
rather than sitting on an event that never fires.

The engine's own events cover the same ground: mm_collapse_scan,
mm_collapse_candidate, mm_collapse_faultin and mm_collapse_round.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/trace/events/huge_memory.h | 123 -----------------------------
 kernel/bpf/btf.c                   |   2 -
 2 files changed, 125 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 5d0891e03bb0..6aabf4235648 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -65,67 +65,6 @@ COLLAPSE_PASS_STATUS
 #define EM(a, b)	{a, b},
 #define EMe(a, b)	{a, b}
 
-TRACE_EVENT(mm_khugepaged_scan_pmd,
-
-	TP_PROTO(struct mm_struct *mm, struct folio *folio,
-		 int referenced, int none_or_zero, int status, int unmapped),
-
-	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
-
-	TP_STRUCT__entry(
-		__field(struct mm_struct *, mm)
-		__field(unsigned long, pfn)
-		__field(int, referenced)
-		__field(int, none_or_zero)
-		__field(int, status)
-		__field(int, unmapped)
-	),
-
-	TP_fast_assign(
-		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
-		__entry->referenced = referenced;
-		__entry->none_or_zero = none_or_zero;
-		__entry->status = status;
-		__entry->unmapped = unmapped;
-	),
-
-	TP_printk("mm=%p, scan_pfn=0x%lx, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
-		__entry->mm,
-		__entry->pfn,
-		__entry->referenced,
-		__entry->none_or_zero,
-		__print_symbolic(__entry->status, SCAN_STATUS),
-		__entry->unmapped)
-);
-
-TRACE_EVENT(mm_collapse_huge_page,
-
-	TP_PROTO(struct mm_struct *mm, int isolated, int status, unsigned int order),
-
-	TP_ARGS(mm, isolated, status, order),
-
-	TP_STRUCT__entry(
-		__field(struct mm_struct *, mm)
-		__field(int, isolated)
-		__field(int, status)
-		__field(unsigned int, order)
-	),
-
-	TP_fast_assign(
-		__entry->mm = mm;
-		__entry->isolated = isolated;
-		__entry->status = status;
-		__entry->order = order;
-	),
-
-	TP_printk("mm=%p, isolated=%d, status=%s, order=%u",
-		__entry->mm,
-		__entry->isolated,
-		__print_symbolic(__entry->status, SCAN_STATUS),
-		__entry->order)
-);
-
 TRACE_EVENT(mm_collapse_scan,
 
 	TP_PROTO(struct mm_struct *mm, unsigned long addr, int none_or_zero,
@@ -246,68 +185,6 @@ TRACE_EVENT(mm_collapse_candidate,
 		__print_symbolic(__entry->result, SCAN_STATUS))
 );
 
-TRACE_EVENT(mm_collapse_huge_page_isolate,
-
-	TP_PROTO(struct folio *folio, int none_or_zero,
-		 int referenced, int status, unsigned int order),
-
-	TP_ARGS(folio, none_or_zero, referenced, status, order),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, pfn)
-		__field(int, none_or_zero)
-		__field(int, referenced)
-		__field(int, status)
-		__field(unsigned int, order)
-	),
-
-	TP_fast_assign(
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
-		__entry->none_or_zero = none_or_zero;
-		__entry->referenced = referenced;
-		__entry->status = status;
-		__entry->order = order;
-	),
-
-	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, status=%s, order=%u",
-		__entry->pfn,
-		__entry->none_or_zero,
-		__entry->referenced,
-		__print_symbolic(__entry->status, SCAN_STATUS),
-		__entry->order)
-);
-
-TRACE_EVENT(mm_collapse_huge_page_swapin,
-
-	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret,
-		 unsigned int order),
-
-	TP_ARGS(mm, swapped_in, referenced, ret, order),
-
-	TP_STRUCT__entry(
-		__field(struct mm_struct *, mm)
-		__field(int, swapped_in)
-		__field(int, referenced)
-		__field(int, ret)
-		__field(unsigned int, order)
-	),
-
-	TP_fast_assign(
-		__entry->mm = mm;
-		__entry->swapped_in = swapped_in;
-		__entry->referenced = referenced;
-		__entry->ret = ret;
-		__entry->order = order;
-	),
-
-	TP_printk("mm=%p, swapped_in=%d, referenced=%d, ret=%d, order=%u",
-		__entry->mm,
-		__entry->swapped_in,
-		__entry->referenced,
-		__entry->ret,
-		__entry->order)
-);
-
 TRACE_EVENT(mm_collapse_scan_file,
 
 	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 58f78274d989..22fc8f974be2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6703,8 +6703,6 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* host1x */
 	{ "host1x_cdma_push_gather", 0x10000 },
 	/* huge_memory */
-	{ "mm_khugepaged_scan_pmd", 0x10 },
-	{ "mm_collapse_huge_page_isolate", 0x1 },
 	{ "mm_collapse_scan_file", 0x10 },
 	{ "mm_collapse_file", 0x10 },
 	/* kmem */
-- 
2.54.0

