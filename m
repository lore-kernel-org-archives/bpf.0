Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4573E6DEB;
	Sun, 16 Aug 2026 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920485; cv=none; b=PFV+xjoP+H6fMAgZQY4lBsarBgEXiHvlb2paM5iiqpq/eQ2hlmgWCrWyV+O/LOG9XCqcnMIhEL7wmXf0W1YIyl6Rsd7yExtv9d8B16Ml7TPvsk9H5fD74GGYRGT9pwGm5VZfbUxmmf4IVK/ce/MsgPH0KQzB5eBqN9Ifv+xssAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920485; c=relaxed/simple;
	bh=y4Oe55bBTpGkU/aNbfP6J95JKmmpSt53Q4zvyPHYMcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLHvBIoLMfIXCyIktMEZIaiWm6gza8pvPT1LvchtzqpbaBqi9XwY+NLvkUnT+C/KteOM0SL7zvn7bchBYd5u7YSCE+yDZ0RBPZMGSfvLwjbkSjprIBka/kaFggFcYLtxOaobznac/vmjXD3gMbLNA9duyHU5wYuqX/grXmLp9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=GFVDPNvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hz4HNAaV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="GFVDPNvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hz4HNAaV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8B7A14000FD;
	Sun, 16 Aug 2026 18:48:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920482; x=
	1787006882; bh=Iai5LJEqyfwXNhMcgzy+VoGlTqvQD8cplGNN5rO3Gn4=; b=G
	FVDPNvEdF/lL/bDhKjUQATKlA6pTWX5pDq2Wh5U6aMTM9BzGaSDO688Im2i2YsZr
	RgZLwS2n+5inMq7Sob+xaV5+TCHHdQG1qDsXXUMDes8OSNoX72MFONQN46UfiGaT
	gmUPI3kN38+KKJmS39xN5epeDUOgbe34UYQSTXxEscLFjf44HpGbu46bsYtgURrZ
	hz6oW55iwh5iz4ibfqIA0SlbLWZgVWwx5fgQBGNHTH0sDswgjEjq2xeCLlqIwx7k
	OjZXiy7IskzyAQXUmhglwRWDYBI7GyO6jyOInK7bkJYi7godKmrDUlhG0svHBspK
	BKCCz6S1+MQLpB6oJhZ+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920482; x=1787006882; bh=I
	ai5LJEqyfwXNhMcgzy+VoGlTqvQD8cplGNN5rO3Gn4=; b=Hz4HNAaVKEcF2CWJo
	Om6xPuGHGt2tE6CzXz/iroFOtOXu9jVJ8U1KDKTNufChodRcuF6N/9cR+S45Gc7g
	U2qTpO/u8LNLszJ+pDJwpQfivAb1vmdzkS/riL3/qXvhsLcKxH0fNGh4G6ViFzFC
	tlhWV4G6yKXiImzcb3QnFXD/nY+PbuOc5yUw15F6eAa5vnCNtOnYN9ZbnxZuL//0
	qgPvJyeIyqZPA3gpeNlSE77SZhJx9bF3g3hQp2HA7hU3CDoVLugXJIMJZSUwUysW
	d7g98jMRabHLZTxC5QOF9JigdxfvevOF9qGHTsmEueBRNVNgfHonEANULwlpslQ/
	iq3cQ==
X-ME-Sender: <xms:Ij6CaioSJsqUhI4Aqnx3wt2s0nWySiT1NeBSaIjGrFArF2py7iF4RQ>
    <xme:Ij6CaqNvDc7Td3dMzxJdZ-Kt7IR2H--Sf4Cf1huLpTAyGgeUd_Dfbvp7yhcZKzlIF
    YLyqI_5sCybxeqxZGp1SVgxJMsGCxuP34foHNH741tX6Ykq-Zq66orC>
X-ME-Received: <xmr:Ij6Caird1e9QSdZLPmEkfVKsG-hEMJo4kzWBi2nFYPgFp1GlibN8QyRHddY>
X-ME-Proxy-Cause: dmFkZTEdkpHxwPvghylIRiDh2DXj/W+5rHHxiNSRAV/FnUvF+pTHTSRogpF51K0JMFOoNq
    FXR3xXOJwqbxi3xnpOR1gVnxkOx0+3lmAqj6HIZkTE7HCsj4rfJi12LdCUf4noPIB2xzxm
    G7I/52H/Ds2kSEPPWl68t4mZYEFuU9+tOum6r1AuUpSuXeb/EuVzDQV2mgKoQzhJqWy9WS
    TVItjwfT9Ds7erymUHvJC6I4UFiVodQ+tEdI5cAgcJk8Vajp+hbWnlKpegW2smcmqEpO9y
    vf97AV5jaic/zQ1Bw2Y9IMD/RUnDCUvC3h/3BgvkY0X8lg0WF0YKtDhM/4K5gFEWm8G2hC
    o7UOq1ARSQoAFN87IS8L7LmQD0NqIPY7B3lg1mFqX/Ux9m5lhs/bBn3ORbVqzOiq5xkBQH
    eMvoSuKMYDFCUz5886MTOlInYpH1NMOThGQVJpNdwJoccgzj6LI2NAzcCnEuDStOxdS3Ob
    t7IJbEzdcGjLWgq+oRueBNy4DT1TJGHM6PcqkdDdDDoeUE9kieAliwATf6dSYT+wGv4zS8
    PNNAWvqZZQE8EQod+tB+wj3MtC6rQT+AzOTnzegSlTSw16FRcdIH8OOwF9BXYH+8WCobx4
    N+1qrWjy3Npgs0clVyYZ0uus3IX3Vf/faSpYjpWgaZtEl4vpp9FuSha/Ga2Q
X-ME-Proxy: <xmx:Ij6Cagko3JAvb8fMKFhrpQD__u94Z7-YYZku2lum-7QB6QLigMaibQ>
    <xmx:Ij6CaixAAkAfGekw3AatVXYZGsAydjRbujxVMotnnR75tf2lPNujWA>
    <xmx:Ij6Cam0v9fPLp8U5tAs4LmdJjkJrrczGOd66tLnpOx7H2hI0mGhMUg>
    <xmx:Ij6CarbDdgMLosGVqBmC_0tjhS9tqo07XH2nWjprpLIOJsowtDhxPA>
    <xmx:Ij6CaqEsI3e8D_SGUBLJEtTHMZ4NMCfxEflyw8uzpoFBx1MnHHKWyloc>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:48:02 -0400 (EDT)
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
Subject: [RFC PATCH 57/57] MAINTAINERS: add an entry for collapse
Date: Sun, 16 Aug 2026 23:46:09 +0100
Message-ID: <20260816224609.308019-58-kirill@shutemov.name>
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

Collapse is now its own body of code: mm/collapse.c, a header stating what
it offers a caller, and its own tracepoint family.  It has two callers,
the khugepaged daemon and MADV_COLLAPSE, rather than living inside one of
them.

Add a section for it, and move what belongs to it out of the THP entry:
khugepaged.c and its header, the trace header, the selftests, and
mm_slot.h.

The selftests are matched as khugepaged*.c, which also covers the race and
sync-check harnesses the THP entry did not list.  mm_slot.h stays listed
under KSM as well, which is the other user of it.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 MAINTAINERS | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c179b333e4e..4e4e5030b979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16955,6 +16955,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/balloon.h
 F:	mm/balloon.c
 
+MEMORY MANAGEMENT - COLLAPSE
+M:	Kiryl Shutsemau <kas@kernel.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	include/linux/khugepaged.h
+F:	include/trace/events/collapse.h
+F:	mm/collapse.c
+F:	mm/collapse.h
+F:	mm/khugepaged.c
+F:	mm/mm_slot.h
+F:	tools/testing/selftests/mm/khugepaged*.c
+
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@kernel.org>
@@ -17272,12 +17286,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
 F:	Documentation/admin-guide/mm/transhuge.rst
 F:	include/linux/huge_mm.h
-F:	include/linux/khugepaged.h
-F:	include/trace/events/collapse.h
 F:	mm/huge_memory.c
-F:	mm/khugepaged.c
-F:	mm/mm_slot.h
-F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
 
-- 
2.54.0

