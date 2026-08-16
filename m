Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337433E7151;
	Sun, 16 Aug 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920391; cv=none; b=OaGmH/K56A4vtnL4Of/0ms0ppvE67pIxQGRLQUYe+RwaKGk6QgkC1CHiWyrtgMF1S0vSrm75Gbx0H2sFQjuJEy0+GPUgjK97w9VjmJm3QigfnapiSTACnE33ZF7vj4b2bV7SjOO/DJ9oIUATqilzTv36F1JZPCUf+59qbCroma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920391; c=relaxed/simple;
	bh=fVVigGbJs6r6fUgXMmmASKEboV4jeGdkVi4xoCZtqcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFddAcL93earOLF6eQBfB5XljGWP3F3vO9nP09DIbjGVGh84xgNQn+4ioebHcD5OY6irQDPdDnhFHaxBYpft5eeJ+JKCp4IolOya5nVJr4VnOUmc1nLGXkVpdTFffPBTGoJd1TH/z9TQ6hqz72bhVooL8+51zsQAoxkJQkzltIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=aYM3CqxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c55YAllF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="aYM3CqxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c55YAllF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57CE514000F8;
	Sun, 16 Aug 2026 18:46:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Aug 2026 18:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920389; x=
	1787006789; bh=mHXoaFr3Xl7m0kg4SnYsmksRc4op7lmfQDtkE+LuXY4=; b=a
	YM3CqxMWC4w8Dbescu6PN7PKi8swtEa0wj40y1BxGNKVLIC8LIkPUUZWJl3pOr9r
	msff05iZkLAaHhIOo/2wMh+Mi3ElwpB767fs6iPJsVcbY+pkVpR16896Qo9qLPLQ
	LIJKGkfrEp6TZlYGJJAiJgKViA6HXiPSk6NUJCwbGkkO1K0X93NL5kKeVqJfXE5N
	AuX0SflMysadufZy0zdx6azcQVtGLNh09aHN5A6RuXlHGtM8wQVsqtn8Z2BJyLq9
	DazIskgVX6xE9q8CsHMjPlb9F5MaQS/je0MFrwJFHHX1EkoiK4P61wg43FFYuDTs
	rYICP8xqwmnUm0JOJGO7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920389; x=1787006789; bh=m
	HXoaFr3Xl7m0kg4SnYsmksRc4op7lmfQDtkE+LuXY4=; b=c55YAllFLUgt4HnS4
	SvDhPrbmHQ4iv3qKX0c2kkTJNECgf0+UoXVmAELh9yNotkkECH66scAHGi4xerT2
	o6+FOnt5TbdCS9n4e73bDTXeddHCiNB9AD6q4VHbo3h31k4XheCOw4aufxmg3+Sb
	Ld9ODcFi3vQxb0TLNjT6CzBkH8qieQLcjNQc3RL/ps5SQd7nLUv+p54wUGiqqyIe
	c/wJMpRKbhdblmkR7D8kqKA/djKYK1tQ9LaxXLJ+oAyXkWM1VINdja0pPfgUpyh5
	AMpRYhG5f3zTKN604St16D5mdW7QLHKuWQe31YXfmuiRujsezJ6BHWtpwoEWUOTA
	+kZ/w==
X-ME-Sender: <xms:xT2CaoRa_6WfbJ-awybMEd4thXCTC3QSoCCUv014zOzB1AzAOAeaGg>
    <xme:xT2CarFXL82Qvj4RA7I9G4g2S7sgq-Oo5yo2_mwBs1sX2Kx9OkmoasiwE4z-teRTb
    KFFgmbf4k0y951erxmUChwfF2-PeAYLjQiHw8uv_r8WOMFU1yjoNs0>
X-ME-Received: <xmr:xT2Cah5U65dmWeqYbSSRV2WnNqQVRSpNU1ZK_Z_pFyT2HVygH-UXydG0e3I>
X-ME-Proxy-Cause: dmFkZTGj1BuhETEStCjbN/L6JrGmiaqzRpeX6rRNWhHsAzwzRlY9AKzqCvfWqke6XA7GOE
    A6FFYRRSvteD9S264L5lew1YUpPhGI3TlhRe1mYLYRUsBMnidhJP2r2PMm5Lpq2ztO8wmr
    yF1ddTX1W5NBA6qs0+EDXUaWwTs6UQPsEiicZ6SmY6z0vOVnZaAe+3gsuR1dg3g0gP4peZ
    U6KBKKlAxat5APGrEFg0r1ubDi9svGZRyISInygLcwTo8cXqakBbn35auVMrKeg7PKmswS
    qkEQEJGI+h4SGQWw8a8xHcXO10CUTBpRtdxlbIKv4nbtwWiZJ1jrVLIQttQS09NS+fWjmx
    kJfkCJarA+CKWoFELrMO+xFyN9skUAkWMIJFCoZs0ww52p03xN5269uqaLdXJZhhJnw51P
    pJAiV6KgxOayjzcdbjHznmIWAtiXC/kL1MmpHj1sKlILUfzdm+nj9opRb7cSWJO6WPUn87
    TpYeNZUjHs66wSPOBwVossQcukDWjK1YuqqPDPxP05a5pGxfw/QiM8DBKJqlZMeN1rT2T7
    u3O+T/BPulsGv+glBoLmjhm4blSdkZpIliMw28KCjwtdcq1eMRy6TLLfQMjDwHcYdEoLf5
    a7Ry8XeDa8Y/LOz3sWyJsySoSKZd6miYbNeg3WRmbo3sBb9qvpeES3J9zOfQ
X-ME-Proxy: <xmx:xT2Caomn-ommuBwWXyq0UjENinUCiifQW1LnOML_svDTviZODkAZPg>
    <xmx:xT2Canys6zGcz7znJevx_4XRgA6SralREnF_SmQUSOIMdQNFNAUrPQ>
    <xmx:xT2CaiP3oJg91WWc8Gh3-SuMFPAOWeGgdGyCzzmm7w4M_ie3Kva1Aw>
    <xmx:xT2CapgAnyVr01dmyzl0nOXAFl1l1ji_zZmfgHFoQR1oa6AZtwWsTQ>
    <xmx:xT2Caq2HqLsAyaWSkrlcRWKixnzG4mLwzgVDONR4MfyN1lP3VeMa5Gkf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:28 -0400 (EDT)
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
Subject: [RFC PATCH 06/57] mm/collapse: move the smallest collapse order to collapse.h
Date: Sun, 16 Aug 2026 23:45:18 +0100
Message-ID: <20260816224609.308019-7-kirill@shutemov.name>
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

The floor on the order a collapse will build is a property of collapse,
not of khugepaged.  MADV_COLLAPSE reaches the same code and is held to
the same floor.

Move KHUGEPAGED_MIN_MTHP_ORDER to the shared header as
COLLAPSE_MIN_MTHP_ORDER.  Preparation for the collapse engine, which
sizes its per-window arrays from the same floor.

No functional change intended.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.h   | 3 +++
 mm/khugepaged.c | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/collapse.h b/mm/collapse.h
index 44f52ea5bbb8..1e969292edcb 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -7,6 +7,9 @@
 #include <linux/pgtable.h>
 #include <linux/types.h>
 
+/* The smallest order a collapse will build, and so the finest window it cuts */
+#define COLLAPSE_MIN_MTHP_ORDER		2
+
 enum scan_result {
 	SCAN_FAIL,
 	SCAN_SUCCEED,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eebc044a930e..f31689bf75a6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -67,8 +67,6 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
-#define KHUGEPAGED_MIN_MTHP_ORDER	2
-
 /**
  * struct khugepaged_scan - cursor for scanning
  * @mm_head: the head of the mm list to scan
@@ -1540,8 +1538,8 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 		 * any smaller order enabled. When at the smallest order
 		 * we must always move to the next offset.
 		 */
-		if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
-			(enabled_orders & GENMASK(order - 1, 0))) {
+		if (order > COLLAPSE_MIN_MTHP_ORDER &&
+		    (enabled_orders & GENMASK(order - 1, 0))) {
 			order--;
 			continue;
 		}
-- 
2.54.0

