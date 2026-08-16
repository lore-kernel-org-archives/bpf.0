Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FE3F3285;
	Sun, 16 Aug 2026 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920421; cv=none; b=BKVGM2Tnq00eYAU/0j1NFPCIyyQfSgss/9w9elmXLi9C/3idPhTh2ZymtIdeojzsrWW5pE9C70S2O2ij1hUb319jM75wgGfDnEcyYE9YpS4OQrkpZK+jelSmqcrXgEK8P+dg6F6FG4TYdGq4CA+qMr5V1+C3vIGh0mhC1W9ZSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920421; c=relaxed/simple;
	bh=qxezClCXR1oALlFl7oDnUW813LKJ437GJTADJ3u48dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auvk4JLudOlQIefWbQdl51J4OZkQTTDrzO7ma4Yze19tpYV9PKxEKnWT9Ak/QorW+BMceZLyHsSwsDckfDbJrTUm7BiI2qseB6VuVkEdBWAY+DBLliE7BQhTDYL8JiP1rJL76/bvokpr582Iq4zfnWUsPjQgXLGc81kDvhClxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=d7WK9YCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJUIGH96; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="d7WK9YCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJUIGH96"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EF0B3EC0242;
	Sun, 16 Aug 2026 18:46:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920418; x=
	1787006818; bh=mo9/YyuZ+27uiSkLEdlk6rzsMwO0ifUZXBUSyhK0NkI=; b=d
	7WK9YCRZJRHPwU0pAQUS10+wHOnpDVzzsLoMHT4KYOSJTernWLvI5zEDM0UkfP6l
	sDfoB0P4LSOIrmvVWaMZU5WgPwdOZ26zGOGxOQnDXF7zH9//nENd0dCVsng3FqEi
	OfNRivgTRghzdRb6B7imJ3QTM3oow78pgAp7RWFlnqlPDWREvgcw7lTuNGFIMucN
	HHliw5wwSFtsS8pIfixDSCSHfsp2yV+7TtjaDqxBOCz9kYofyi62Najmtyg7aEcI
	FSR1kV7BgaHkM7t0KShfBPl5TJt3QZi4a4CzjmLD/tozU/ZJZUyg8b/oNakVgcKt
	9arG4B0r60J5KjF9IK80g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920418; x=1787006818; bh=m
	o9/YyuZ+27uiSkLEdlk6rzsMwO0ifUZXBUSyhK0NkI=; b=GJUIGH96wLw4Ae4b/
	KotBYngP01kE9QSEmFZ40LRhjCHLB0RR2+4JbCP2BK0l/nh2BSKndFsJe3TmuVr/
	Uvk1WU/Z8DtRr0wK4C0ws33aKKox37XCxk05NgPvaKBYWbrmrDtzPktez79HbNmi
	JHctxjj5epxyWTBslwvYTB7Ti9pz2NQHCXgz9OYdXjGXA+aTU8TsreCpgNHaMWK5
	LTznPv6P4TCcJjocAe0tKvz25zwiJRIW6II/5pxqD06ZMfbFHk5GatQ2wvvlCz5S
	qXRwGf68w9y0T4WgtoHJxrkkgdWtZuIOOEzoHb92rsS9hg/YC+ZdTZWQ4m4J5+Zn
	ahRpQ==
X-ME-Sender: <xms:4j2CanQqScaubasMLkTsysJw-SK7UfwGJd7eoSwFYVX2L5_o5AmVvQ>
    <xme:4j2CauGArq4GUP4XjGMM3XggInpA_aUCDPkf74NbM9pfE8qYwzYpN1LvtPDUInE5K
    N-9XRxVWBWMMee-iU-K1pINfPFkr3SZKV9WI7KAhtlTE18MuweGkgJu>
X-ME-Received: <xmr:4j2Cao79UHKeyM1kBRBZ3tKSjAYqTy2tTxq6UKqARBtFB5dVCRDwDg7FGfY>
X-ME-Proxy-Cause: dmFkZTFkhNC7YI+Ei0MrF6zu90W9yR7z714JmmtstcBEn9fnZ0JEx8KxNru7XjOIPijUAd
    VrNDumTIvQCtLJHAbrPKMRdbJsCYKY1AWxa28xNEDdkQaDqy3PIOJVA9R+OjsTN2M4dnB4
    WQk97ejO2lmWwXR5mw6146Dl5x2vSRCf1uehpA4Z3DNP/uvzS8DmGwE+/LsFmt9BQO6ZtJ
    eWd0dPZ2F0WrWW1tiYo0zV8d4Xgh8ztMbcUaDgwCK69ZeQi0ebesOWu50OSj19NNGHzec3
    w5R1etyOsXXy4NxsI/YxbKwNbzdBv+aWoLN5/PFLP+n740pr735uP0KJxEPqjezkxGUEYw
    zcznv5swWAyw6XmESrxIGM8A1bTTyyCb8TGgw+qEShLJxmw0H1QgFlfOeuxPMpjGoxHDtp
    PCjigTxTQQ2SQYH+g1Zjow5z90rNIRRpTNdfes5gZJF781hKtVjYAOe4if7ktPzJJA4yNg
    SoS74FodWm5MlganZ52ThBjBAI0zsQCzKw1kMNWmaHUySWEGqzr+6R499T3SjVD8uPcKN/
    4SLidXdUPP7GCHgXfbqC5pStWuEVCtQYOB96tZz4WWjhPZl2k+r4upntklA4ZEhZgnxts8
    Lxz66rlvmgByz0pVLkrls4qWwn+V7sbwBmY/Z6EOmYn3bFnzh2lepzJSEjtg
X-ME-Proxy: <xmx:4j2CajlsvjAN_IEHAIV1kdp5qFXcSIkYNgoGFY8LAx7-GMiLIVyIkA>
    <xmx:4j2CamyLPAh9iniFOlqmrcrm1VGdAlLtldJw-Q25y0HYU9VT0elSKg>
    <xmx:4j2CalODmyYrz0w_UYvd--3ZMZ88iSP2eG9dXy7GQuMAp6S8f0v36g>
    <xmx:4j2CagjRf48cFh8tnR00-qMgeKzkwFPTMv9-xyTkeoMwOiCkBud3zg>
    <xmx:4j2Cat0OGWz64CT28dddn965QWPo0PjRSa2NkonwE7g1N9uko2NxaYeC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:58 -0400 (EDT)
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
Subject: [RFC PATCH 21/57] mm/collapse: settle whatever the round reached
Date: Sun, 16 Aug 2026 23:45:33 +0100
Message-ID: <20260816224609.308019-22-kirill@shutemov.name>
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

Fill in the last pass.  A candidate that never froze is recorded as given
up on, with whatever result ended the round.  Anything no pass took
ownership of -- a destination folio, a table meant for deposit -- goes
back.  The count of installed candidates is what the round reports.

Holding no lock here is the point.  Every refusal before this happens
under a page-table lock: the freeze unwinds under the ptl it took, and
the install aborts under that ptl or the pmd lock.

Dropping the last reference to a folio, and the memcg uncharge behind it,
is not spinlock work.  So a refused candidate keeps its folio and its
table until the round is over, and this is where they are released.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/collapse.c b/mm/collapse.c
index f65f413339bf..2da1f8ddcca8 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -1500,7 +1500,30 @@ static unsigned int collapse_finish(struct mm_struct *mm,
 				    struct collapse_control *cc,
 				    enum scan_result result)
 {
-	return 0;
+	unsigned int i, nr_installed = 0;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+
+		/* Never froze: the round gave up before it got that far */
+		if (cand->state == CAND_SELECTED) {
+			cand->state = CAND_SKIPPED;
+			cand->result = result;
+		}
+
+		if (cand->new_folio) {
+			folio_put(cand->new_folio);
+			cand->new_folio = NULL;
+		}
+		if (cand->deposit) {
+			pte_free(mm, cand->deposit);
+			cand->deposit = NULL;
+		}
+		if (cand->state == CAND_INSTALLED)
+			nr_installed++;
+	}
+
+	return nr_installed;
 }
 
 /*
-- 
2.54.0

