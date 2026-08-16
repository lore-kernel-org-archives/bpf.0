Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC343F6C2A;
	Sun, 16 Aug 2026 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920437; cv=none; b=jZ2V8cBqhDYv7QRMfkC5ii1CayFhABhtLuzr3WZ1G1cdQ2FcvZPAeI0QdWSEI0WodQqMLL4IteaXq8koXErLFOUDE9iAGJi2OUho0FF97x9qgnaVSmSS2xX+EvMWbhd/0QDgn1zSO1YR51RPdaHUDT6+pUV5A5DPGDA9paIMruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920437; c=relaxed/simple;
	bh=KD4sXY94Vuz2+nX0EfaUT6taLHsHeW/DxE8KoKSqk/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihTyO7kKNb6lfWOKch1L5OW0QnTENe4Vkday4Rug31cbW7IrfiGDOg357Tv/4oaT88PxXN0fTYNjTCnFhwYZ4wpmcwOltVzGTA3pIo9Szy3NqpUmvaDY8pcX6EZtg+5QYYznfDetySychiF7ckzgjRKHvrTRmu6w5vNufqh2N84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=V5giir+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GApl5JHf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="V5giir+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GApl5JHf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 38940EC0242;
	Sun, 16 Aug 2026 18:47:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920435; x=
	1787006835; bh=0Xh3qJFy3fUbrlN8Fy5RgHt7peoEA3/8bbzab7kXN/s=; b=V
	5giir+FskG5CJ7dclo4ePNvd6SAwJqQ4yiFRkHkuQgTdwtX43TgBGCcujN18hpPC
	RtjvbXARIqnkKrr2hpRHpBYlBOeLlSJ0nyu/Al0vs+246WUCf9WlXUarCqwF2kFE
	omjK4nbjMDwDvNu6N7pPXuHBG7/Ey3yVmLU6Zv7W1ayBFV4aSyKwfQ5N04Xxtyjc
	u9glyesF+QjUFHPyqBM+qiOeyYSuAQTTlXgUCAUuC0mSsYGk9W9AxivavcATJvxf
	Gr42crPrhx4gE+UqaTqeT7txuIL8NINf/LYmAUQ8Yr9ahMsFyPw+ilLbnPy9ht8X
	RgDOoqXtnvB7pw/3FLNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920435; x=1787006835; bh=0
	Xh3qJFy3fUbrlN8Fy5RgHt7peoEA3/8bbzab7kXN/s=; b=GApl5JHf4d23ZEorQ
	EMstbMXZUb1M4UgrkGwCFZMAFdXcPxOT6ROYUSU/cH8dAgE9NiO09jAP+z9H5Xhv
	VEABoGBQvAtGiWNxDNEfau5NaGo5dfHGNdJv6fzrB6LNxrLVw55XJQ8RwVn8UiNR
	haN8wb0Ssgxm8r44TK+Kw9fwY7ZWiUvDWxZA4ElLSbfgNDrymH6sIj2P10BWjvVv
	IADR1Ntgw2akgUPcVEsyf1QHZDh+sFA5OpHEr8RISRW8FjyO7cQR1zV2NE6vPcJc
	Fpi39Ghn8vQCcTQM+xAHBOLTOWKjWchajHE8H0BYbYn6GXdfYf862gBGJ+iaZDDI
	+BTtA==
X-ME-Sender: <xms:8z2Caq4-OBD-AiIgXEWjU9hWbNHj4kVcsm9hvUsvbO9s196q3igM1g>
    <xme:8z2CapM5HufFBu0pZ05nLf5hL2AEshucIhiVZS9TAODah5Xa8IOFaOUho9WF9zGS_
    8ygme3Kzere6SIzB2bayDsQjnz9ChkzeQPCYD3ed1UBMVvDwAFZyEg>
X-ME-Received: <xmr:8z2CaliN6nn2m2UACcbQtY92IouTMO_yENw3iTs1cSQcjBWDMx84pc0n9h0>
X-ME-Proxy-Cause: dmFkZTEDk+RLLWMQ2xmtz+SLrRm4SAAyqR0dcBO/jFiSra6UqVmtacLBiFsIEc4u4O0k4e
    TprFkQPKvch8mvItdBrQvHbw0cB+L9AXDq7j8E1YHObaRHu/NhSSUGMahPtwIv/D6P/2Ck
    /ZmAzcEVmv8/4SK/QQlss/OdD6ZYE8aT6ou3Os4qcrsJTku67URPEU5YsnAJoGYWAjn3Up
    7SKj7HM1m+Bk9heCO7PBXLylkVDNPLNBQlGmsET8D8iA96BjDQqliz/FRaUJqsbc23hZYK
    6FfmpWMzIACF8l0zIVIJGtLfQU4v7CVbie56C+ilpPey1dPs7ANiSUKA9aUYDcXfVHEKIB
    CBopL77cQG0VLaTu2WtaEqdiaZ5xCAD/3YiiT0Lq44Ym9vdIpYdhzK+jQXietixt7epVkB
    if3RNtS6b9w3JJ41Es85ighZoOawaKfc83t0IoYu4uoikAtuRK+JbqxDq/gaHo9YYFOBBq
    B65m56HfcLycTC3OwAjrSioOFCBDb40VhLH64PtRBYsZjA0+1n3CrhGCunvVAvf9rb6dEp
    0jfbxFptvtcfTYM69fB3mqD0o8Q3g3qeOYT+NVvJ+WlCKBClxubhwGBnyR/4vMG7vwnYjS
    uhnzb4yQEXQ/H5n2RPqlQYRsWTuxmq3VmvuT/9rB2mqs0kuK37xxe+LH8GWw
X-ME-Proxy: <xmx:8z2CajshiB69gzwXiOvYVO9qyylDxqLk7a1iMxVPicc7T5J2EtjA9Q>
    <xmx:8z2CakZplhn4MASd4j_fbvSMDjNcFNoG-kxxMVx8BZeQEYZMcibnFQ>
    <xmx:8z2CaiXVKNiJfn49BNdWc7dKEb2CWa8_7MN9bPZq5EEHwfv1Y1r1vQ>
    <xmx:8z2CanJTxqkiZtjkNB7JUeWLHOv8BqFBkd-p0oirHcfgTrGwRT5-fg>
    <xmx:8z2Cas-SLvdtpXL2o2h3H4eBUjfSmnIzbxFWh5JZWZwoTqql0Tr3MUyX>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:14 -0400 (EDT)
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
Subject: [RFC PATCH 30/57] mm/collapse: name the max_ptes ceiling after collapse
Date: Sun, 16 Aug 2026 23:45:42 +0100
Message-ID: <20260816224609.308019-31-kirill@shutemov.name>
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

The constant lives in collapse.h and is read by the limit helpers there,
so KHUGEPAGED_MAX_PTES_LIMIT names it after one of its callers rather
than after what it is.

Rename it to COLLAPSE_MAX_PTES_LIMIT, matching the other constant the
header defines.  khugepaged keeps using it to bound what its tunables
accept.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c   | 8 ++++----
 mm/collapse.h   | 2 +-
 mm/khugepaged.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index 43a4b771bbe1..ae7c2777b279 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -193,19 +193,19 @@ unsigned int collapse_max_ptes_none(struct collapse_control *cc,
 	if (is_pmd_order(order) || !cc->policy.strict_sub_pmd)
 		return max_ptes_none;
 	/*
-	 * for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
+	 * for mTHP collapse with the sysctl value set to COLLAPSE_MAX_PTES_LIMIT,
 	 * scale the maximum number of PTEs to the order of the collapse.
 	 */
-	if (max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
+	if (max_ptes_none == COLLAPSE_MAX_PTES_LIMIT)
 		return (1 << order) - 1;
 	/*
-	 * For mTHP collapse of values other than 0 or KHUGEPAGED_MAX_PTES_LIMIT,
+	 * For mTHP collapse of values other than 0 or COLLAPSE_MAX_PTES_LIMIT,
 	 * emit a warning and return 0.
 	 */
 	if (max_ptes_none)
 		pr_warn_once("mTHP collapse does not support max_ptes_none"
 		     " values other than 0 or %u, defaulting to 0.\n",
-		     KHUGEPAGED_MAX_PTES_LIMIT);
+		     COLLAPSE_MAX_PTES_LIMIT);
 	return 0;
 }
 
diff --git a/mm/collapse.h b/mm/collapse.h
index 2fdb6418653a..94c11051f06a 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 /* Ceiling the max_ptes_* tunables accept, and the value meaning "no limit" */
-#define KHUGEPAGED_MAX_PTES_LIMIT	(HPAGE_PMD_NR - 1)
+#define COLLAPSE_MAX_PTES_LIMIT		(HPAGE_PMD_NR - 1)
 
 /* The smallest order a collapse will build, and so the finest window it cuts */
 #define COLLAPSE_MIN_MTHP_ORDER		2
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 26c0e961ac9f..8c770e251c22 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -214,7 +214,7 @@ static ssize_t max_ptes_none_store(struct kobject *kobj,
 	unsigned long max_ptes_none;
 
 	err = kstrtoul(buf, 10, &max_ptes_none);
-	if (err || max_ptes_none > KHUGEPAGED_MAX_PTES_LIMIT)
+	if (err || max_ptes_none > COLLAPSE_MAX_PTES_LIMIT)
 		return -EINVAL;
 
 	khugepaged_max_ptes_none = max_ptes_none;
@@ -239,7 +239,7 @@ static ssize_t max_ptes_swap_store(struct kobject *kobj,
 	unsigned long max_ptes_swap;
 
 	err  = kstrtoul(buf, 10, &max_ptes_swap);
-	if (err || max_ptes_swap > KHUGEPAGED_MAX_PTES_LIMIT)
+	if (err || max_ptes_swap > COLLAPSE_MAX_PTES_LIMIT)
 		return -EINVAL;
 
 	khugepaged_max_ptes_swap = max_ptes_swap;
@@ -265,7 +265,7 @@ static ssize_t max_ptes_shared_store(struct kobject *kobj,
 	unsigned long max_ptes_shared;
 
 	err  = kstrtoul(buf, 10, &max_ptes_shared);
-	if (err || max_ptes_shared > KHUGEPAGED_MAX_PTES_LIMIT)
+	if (err || max_ptes_shared > COLLAPSE_MAX_PTES_LIMIT)
 		return -EINVAL;
 
 	khugepaged_max_ptes_shared = max_ptes_shared;
@@ -330,7 +330,7 @@ int __init khugepaged_init(void)
 		return -ENOMEM;
 
 	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
-	khugepaged_max_ptes_none = KHUGEPAGED_MAX_PTES_LIMIT;
+	khugepaged_max_ptes_none = COLLAPSE_MAX_PTES_LIMIT;
 	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
 	khugepaged_max_ptes_shared = HPAGE_PMD_NR / 2;
 
-- 
2.54.0

