Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF33EFFC3;
	Sun, 16 Aug 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920419; cv=none; b=Pr5lXkRSklYBvh9IVoQ+FJlV2Gduzz1Si5Rbzcx8sp7tsiLNTIxEVDhRrhyNFt3i+5pYVv46909+5KJYockAmIITJEKUMpA2aTaeZwwqWk2YQV/rlZN1P9BirXUwwxVC0h6HGd/H9VaaX0EajYQOTyKLWjyFHxXuOHN4tgy5tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920419; c=relaxed/simple;
	bh=rkYUDi4omK53ksGFAid26gCCWZwhOAmjSe1EwS0KNXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI1DZixn+39bF5GgqruAl9+BkX1xMjxsdzkvF8XtkaKXs0iKUngd6NKhUOj3D61eQfYlI2hok+noSR6dI9BhWbXA5lpfM6rrtn3mXc2oMf7CxVkpELJevWQWWpdD1lgL2d1bccGyGa9T7PgyU3mCJyb0t6UJ2+Ed8uPfTzCZrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ump2JR5L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJUR1o9r; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ump2JR5L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJUR1o9r"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44C3E1400100;
	Sun, 16 Aug 2026 18:46:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 18:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920417; x=
	1787006817; bh=EQu6T+lgU+FFDqaM3vM2kEMbX9/iIUBJ0iT3p7UidZk=; b=U
	mp2JR5Lu9hjjdwu6/ZQWvKVFtdYnlCBZG+uicCmp+SUg/360NTTX1awYM5jaoqq2
	rBY/rWk3tYkopKExR3nFX6CXwEIDu3GqAYgcvF5HSAAr9p0jKEgvP06bLA870RJO
	C/V99/ZpKmrxhDz+JR9cuFEYDKptM6bu5e/aNUTftGd6h4I5v00obUcT6eAs3ZKl
	6KEHWUv7yieowRBiie8GeA+ivB03mFSfnzN7C5Y6ssAW98kuIVppF/t6ZU1ODjbQ
	f//EjGkc2FNOpg4mdb3pZYgkLl7K+EAHmWWb6wdBQXci1w7Z7MF+3aihS3zjHmBj
	vMVxRKxXiMYB69T1wx43Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920417; x=1787006817; bh=E
	Qu6T+lgU+FFDqaM3vM2kEMbX9/iIUBJ0iT3p7UidZk=; b=VJUR1o9rvJbGtzh3V
	VBs2bRwDDvy0aLsr2PnsD192uCbrJwf4UDphyR3f4nds3mKvDMF/Qkn2Dv8qopVU
	sggwudKzLaKJnsjzhDdPBMkEtZUZVPTxEhNQkQVVjHDHvMtHh4kPROHRGHshkJTJ
	PFgAv6Qp82RR6b5GylgrOe8Sf7OJ0eeSMdoFqB7bGAVZJetzgrFciY5o8bjBvRo0
	GfjAJsrkScVza4YoCtb1PA6UR3CvIDX7iT5cKq/1c/V5G7HPY0hvFL7pGPGfWfjp
	EkHJP84c0Q6bQY8V2p7bwKZLv0Wcye+gZ7GoqcBheq5L4c4yIiFqFvJwNTOf4V6S
	PhD1Q==
X-ME-Sender: <xms:4D2Capbl5tx0I6fFocuZYOPGGsKLzFJ0l18GKGCWFEwUByQ6tg6kwQ>
    <xme:4D2Calu6TwVXjzsu13SKbLrC4boSweREleMu-HunV-fp7-8ae74zxgPV8Cum1x4C2
    aSPAiEd0aeRiXD5Qat3MMfZveP8vyLxc42nYxT9oXXuzpogUVh68qU>
X-ME-Received: <xmr:4D2CaoASEvcZ0xitd4j7cMkJdAsIe1b03N_IM9CT6c8VC3kYmYJ1Tx520AM>
X-ME-Proxy-Cause: dmFkZTGj1BuhETEStCjbN/L6JrGmiaqzRpeX6rRNWhHsAzwzRlY9AKzqCvfWqke6XA7GOE
    A6FFYRRSvteD9S264L5lew1YUpPhGI3TlhRe1mYLYRUsBMnidhJP2r2PMm5Lpq2ztO8wmr
    yF1ddTX1W5NBA6qs0+EDXUaWwTs6UQPsEiicZ6SmY6z0vOVnZaAe+3gsuR1dg3g0gP4peZ
    U6KBKKlAxat5APGrEFg0r1ubDi9svGZRyISInygLcwTo8cXqakBbn35auVMrKeg7PKmswS
    qkEQEJGI+h4SGQWw8a8xHcXO10CUTBpRtdxlbIKv4nbtwWiZJ1jrVLIQttQS09NS+fWjUx
    bbU18ME9VB5GU2gZOkOiPzSzfvLBB2gKm3VPT4Jvs4WJlASKQCrcJfkt1KsUDLDw5GtOlj
    5h1b8gVcH+y8R4+XAP4fykvX9OA01NzIsYP1flpH2DxLcDCL/Z74+wcUZ3/rUdosCzCYPa
    4QOUrJOowaj8VVpAyzhIuwB6AzFzUdB5E0IHAQgBsmOZddb9BEIKS+sLlBCjYjgErEhYF+
    UTKZzgA+PYxdRSZgiTUWwWkTaCL28GJwHzQ3SUyJ0fGZmD2knP1midXv4+VODV1YSbH3HT
    dK/V64rcrhNHP3t/5YY3nBM7Po8YEWEv2Ay2k37+bp3BgltPHNNAT6tlhQuQ
X-ME-Proxy: <xmx:4D2CakPD3VqdPbSc1Xx1grOGXoWxSuVWVWRmXhVi1SK3PM5ldSRJZg>
    <xmx:4D2Caq6W_wioMh4q_Edx-LlutNy-fs6CubbcrGYhGCpJycppIvc0VA>
    <xmx:4D2Cam2anFIBWp_5R8DmO6rl7mmZKFbIQdXjFUUUCbTDOfDf6hrbWQ>
    <xmx:4D2CahoDsB7RDmWPt3QXK3LBOIbB0cxKQx4b17rML7cKs2UBjxltwA>
    <xmx:4T2Cap4_bWX8jDVTQqnsG5DhJdIVn6uLkJnOgQIVQOlNwsRyydgrf6RV>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:56 -0400 (EDT)
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
Subject: [RFC PATCH 20/57] mm/collapse: put the sources back
Date: Sun, 16 Aug 2026 23:45:32 +0100
Message-ID: <20260816224609.308019-21-kirill@shutemov.name>
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

Fill in the putback: for every installed candidate, lower the barriers
the freeze raised, span by span.

This is also what wakes the faulters the collapse held up.  They sleep on
a source folio's lock; once it is dropped they refault and find present
PTEs pointing at the new folio.

The order within a span is important:

 - Unfreeze first.  Rmap removal munlocks under VM_LOCKED, and
   munlock_folio() takes a reference a frozen folio forbids.

 - Then drop the rmap.  Until it is gone the expected count still holds
   the span's mapping references; afterwards they belong to the round, so
   every folio_remove_rmap_ptes() is paired with a folio_put_refs() for
   the same slots.

 - Then unlock, which is the wake.  Holding the lock until here keeps
   lock-taking rmap walkers out, and the window it leaves -- a live folio
   with no PTEs -- is one any teardown of a mapped folio passes through.

 - Drop the references strictly last, the round's included.  Waiters wait
   without a reference of their own, so the round's has to outlive the
   unlock.

The stale swapcache entry goes too: the copy has replaced what it
described.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/collapse.c b/mm/collapse.c
index ab7476471b8d..f65f413339bf 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -1439,6 +1439,56 @@ static void collapse_install(struct vm_area_struct *vma,
 static void collapse_putback(struct vm_area_struct *vma,
 			     struct collapse_control *cc)
 {
+	unsigned int i;
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		const unsigned int nr_pages = candidate_nr_pages(cand);
+		unsigned int k = 0;
+
+		if (cand->state != CAND_INSTALLED)
+			continue;
+
+		while (k < nr_pages) {
+			struct folio *folio;
+			unsigned int nr;
+
+			/* A slot with no source has nothing to put back */
+			if (pte_none_or_zero(cand->saved_ptes[k])) {
+				k++;
+				continue;
+			}
+
+			folio = pte_folio(cand->saved_ptes[k]);
+			nr = collapse_saved_span_len(cand, k, nr_pages);
+
+			/*
+			 * Unfreeze before the rmap drop: rmap removal munlocks
+			 * under VM_LOCKED, and munlock_folio() takes a reference
+			 * a frozen folio forbids.  The expected count still
+			 * holds the span's mapping references; once the rmap is
+			 * gone they are ours to drop, so every
+			 * folio_remove_rmap_ptes() is paired with a
+			 * folio_put_refs() for the same slots.  The folio lock
+			 * is held until the wake below, so lock-taking rmap
+			 * walkers stay excluded, and the stale-rmap window this
+			 * leaves -- live folio, no PTEs -- is one any teardown of
+			 * a mapped folio passes through.
+			 */
+			folio_ref_unfreeze(folio,
+					   folio_expected_ref_count(folio) + 1);
+			folio_remove_rmap_ptes(folio,
+					       pte_page(cand->saved_ptes[k]),
+					       nr, vma);
+			folio_unlock(folio);
+
+			/* The copy replaced it; drop the stale swap entry */
+			free_swap_cache(folio);
+			folio_put_refs(folio, nr + 1);
+
+			k += nr;
+		}
+	}
 }
 
 /*
-- 
2.54.0

