Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77503FADFA;
	Sun, 16 Aug 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920448; cv=none; b=Jjje3C0IE2X4BqIVEb91NxiTTJ9MO/LFskoeXEAMMg8nExagQk/LYMHzeSu2+OAoxUtADNyKShhlfsryr9W4bK/gjxm0P1Re9lWOxCa+qrhMAn59DypzTsxz3b/swlD10eN6otadFeTLD9YC/d5pk+3WwW1rJr9GsnNK2Waw8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920448; c=relaxed/simple;
	bh=jz4ij5tio1IG99wlK7+3EFva3nFMif1EfCGnf0/5n08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS90exYdgQ8qh4HAiVtqlUkldyT1ObRC2FFCHaU/kYE9bj2TM2F43zw5t4p0YEnT7fyPp/hoqlJIoSMES7hk8cbvpQnOPezEGc0MJFqhyw6h/t/ivG1wtR+WW00AJmvD8A7O2K+zZFgFpy6y2rOR2JplIGMxfpAx+9Df08qAIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=U8DMpupR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ne2vpsJ2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="U8DMpupR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ne2vpsJ2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BC2ACEC0245;
	Sun, 16 Aug 2026 18:47:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 18:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920445; x=
	1787006845; bh=jQDVLS5QXQD8PSUIRmPFOeq1RPNNLBEX8FtCDNd5u2M=; b=U
	8DMpupRPxqNtjnk8MQ2nr5Tbo5J15VHzqtBgNexbVDLBpQK8kOZV1V9VY+oTuclR
	FQwN1MvWVLuiLmcoyeMjBjAsCK5jQiMnCByX5sgQcVEV08a7dKIl5WJmD167xKsd
	yxQ7OnXROVAGW/6T7F5mwovdCEXMiXGeyCbx0Blytwa7iAXZ9fy4r4TDPHRhwZaH
	vClCvsD2KdWW3DONN2vx+ocz7EhMKeBAZdEmGRcSKeBQrFIA3qDi1+U+CcOSNLE2
	5eDbkp2Q8RBM6gtc1s0Xkg2Edc72+x+DGSpowCNEvZ8LT8Ez3oNUoKYnNGCPP2Hm
	xuahjYF0L026BXVJ9QcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920445; x=1787006845; bh=j
	QDVLS5QXQD8PSUIRmPFOeq1RPNNLBEX8FtCDNd5u2M=; b=Ne2vpsJ2pSqH37gTo
	Wmx5ryypkj6OLWQeygS4FAdp8lHexFPq9T6hnhqWd3FFoaJ8/u9jg8aewPXuAWAS
	vfFKx+JtJDAjFXvqvAkkEPEZvhLlVERfDcBvsH4T53nK2mozBL/Cvrt5pq5zfyCl
	A4+EEFq2kfAuNRTDskQydpsx9uP81j30iaWmjmWzj0Kel4UcWCky1aVAOkzvfuXa
	Cl+wdwDq8VFhMsWFJNio4nZN4wuuCYjfQ4iX5XsjVIRHlza3dfHgIMbrxIF7iRC3
	o5N+ta537koNr/JRGVSGrgGX0lKLqtbooNDWYePfkUiDFtW0Wv6uX1IcV369p2qt
	GzBww==
X-ME-Sender: <xms:_T2CasrVW5hajWbLikKl4dLJpd5a9eMTlGeM9lC1yc62Lwqk8W-Guw>
    <xme:_T2Can-42G3Fwi1izl7fzD14uBRCTbRlts_oARlDYR21KfoHOAafPYAGMXvDZwtfg
    TqYXOQUqw_q6mFU8shEp2CluRJHh4Y3gaPPJKGSaXo7Q35qDTQHx5E>
X-ME-Received: <xmr:_T2CatSf6g4kKxV-6xyJXciG5ZvJNI0ybU8Dnndpbqo5YPgEFyPXt5N9lAI>
X-ME-Proxy-Cause: dmFkZTFcTQrb7i2Wnr2aEeZt1aoD7asKutBPdJgU3YSD5OfcfuljRo8Y5zG4WAng55KhcU
    fdYu9dW0n+wtsUDWiYHh8AwjWiiyOeVLRvzra0gUIzgKMFXfu2OsH3wUsDwz3Dpe7vEjB9
    JjBmMfD78Db5X6Vl1RDz8Wz4IQF1tjtPvs8yYIcZ4vdtxAZhotrvrKr9o/e/MWe2qw9p1d
    u/4ngMViLbtWn8zpPvYSIgtjaF8APmxmHCU5Ga5Rd5eIGcQp1MbbGmkchmHrMFMoUd9mrv
    TpVQ9+TKNOdfLLUK+2CPoHpagx885EUQUSZxhSq0AxxU5QJRQ+JA8yzxyjEYMjW1uFFjmi
    LqqoNifkXB79/90TSRF1slcFxxwzddkh5G5bZ3d0l80IbLrRpgBlzopY6EpPfytjdWVjfO
    +DqxD67otuMVUFiKrSCwFY0E3gh/4zA/82p9GG1UXZlq2+64MGfIaNuCFx78ugxlx/Vxd3
    zcra6CnnMWps68YaqKx2D1rCx0QlW0Fe4XYEBXJdYnAr+DVTZT5z4gxDDkKwjNDEjaX1X+
    0qqckODmklZPLQLdNdAJbhiPAlLC0CzYGXGbs8lQ4kjAcpKVSed6BeRd67fF25naIaKKH6
    DYyWnNDoe85We2Xvv2oHM5trVYOLjMtG281TyArJBr7AEnxa79wrFeGYYOLA
X-ME-Proxy: <xmx:_T2CagdoezJWqKxXMydbSbxIDG9lyArj0l7AHk-4SpFKTBHooh1XOg>
    <xmx:_T2CaiLW1lXeF5L1I6jVyK0EIJm0CfzXd9uXG2IEb_SItVwL0Daxzw>
    <xmx:_T2CatHWNIRpSuMZlszw2kT5EhC_rxKl9vmYFA-koz1NgR9zkNOUjw>
    <xmx:_T2Caq6R82YAoFOrIWzhTPEqBgxIZKbIvnGaAaPcd36HNWC7_rI47A>
    <xmx:_T2CajsNeYuv7GPWRAu90uT4Hta4RKVmiOS_7coCKXhLeRfMVvsStC4e>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:25 -0400 (EDT)
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
Subject: [RFC PATCH 36/57] mm/collapse: report what the scan found
Date: Sun, 16 Aug 2026 23:45:48 +0100
Message-ID: <20260816224609.308019-37-kirill@shutemov.name>
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

The anonymous scan reports nothing, and its verdict decides everything
after it: which orders selection may still try, and whether the table is
refused outright.  The only way to see it was to infer it from what the
candidates did afterwards, or from their absence.

Add mm_collapse_scan: where the table was scanned, how many slots were
holes or the zeropage, how many were swapped out, which orders survived
the scan, and the verdict.

The first two counts are why a table yields a smaller window than
expected.  The third is what a PMD candidate will have to read back.  The
order mask is the scan's whole output to selection in one number: a table
refused as a unit shows an empty mask, which distinguishes it at a glance
from one that merely lost the PMD order.

The file scan already reported through mm_khugepaged_scan_file; this gives
the anonymous side the same.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/trace/events/huge_memory.h | 34 ++++++++++++++++++++++++++++++
 mm/collapse.c                      |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 86131845b761..573cf5428969 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -126,6 +126,40 @@ TRACE_EVENT(mm_collapse_huge_page,
 		__entry->order)
 );
 
+TRACE_EVENT(mm_collapse_scan,
+
+	TP_PROTO(struct mm_struct *mm, unsigned long addr, int none_or_zero,
+		 int unmapped, unsigned long orders, int result),
+
+	TP_ARGS(mm, addr, none_or_zero, unmapped, orders, result),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, addr)
+		__field(int, none_or_zero)
+		__field(int, unmapped)
+		__field(unsigned long, orders)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->addr = addr;
+		__entry->none_or_zero = none_or_zero;
+		__entry->unmapped = unmapped;
+		__entry->orders = orders;
+		__entry->result = result;
+	),
+
+	TP_printk("mm=%p, addr=0x%lx, none_or_zero=%d, unmapped=%d, orders=0x%lx, result=%s",
+		__entry->mm,
+		__entry->addr,
+		__entry->none_or_zero,
+		__entry->unmapped,
+		__entry->orders,
+		__print_symbolic(__entry->result, SCAN_STATUS))
+);
+
 TRACE_EVENT(mm_collapse_candidate,
 
 	TP_PROTO(struct mm_struct *mm, unsigned long addr, unsigned int order,
diff --git a/mm/collapse.c b/mm/collapse.c
index f0d80204c2bd..b750a1fc81a5 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -2097,6 +2097,8 @@ static enum scan_result collapse_scan_table(struct vm_area_struct *vma,
 		cc->select_orders &= ~BIT(HPAGE_PMD_ORDER);
 
 	cc->scan_unmapped = unmapped;
+	trace_mm_collapse_scan(vma->vm_mm, start, none_or_zero, unmapped,
+			       cc->select_orders, result);
 	return result;
 }
 
-- 
2.54.0

