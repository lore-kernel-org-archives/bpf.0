Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480A4D7967;
	Fri, 25 Sep 2026 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350922; cv=none; b=c654B/N9A8KDekHZpajvYj/TKRTBbBlL+qN/g1qx919mNog+r3HQupFBb8X0Xaedt2UDKNdEHqpYcCAbGcbdNKcDRDMyLFYBmjDygtIGxT61832YTIVWknIeIqFmnv2v4Vvo/Jqbr1F/UKvK9QbxVMqXZSySIN5EcL8ghgopvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350922; c=relaxed/simple;
	bh=nOg5L3rXnJJXLHa9Gw5n9n0dTe8dCCkkkL6wSOJQRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kd8tkMcOYTU/Cij0GKEOwEdrWKnAUGzNuOKPyxuBKC2p2JD5UZS9yMW9yvPEbhUszrOldv5SEWf1XRYuHM7eFd1/+9hIFdx9uZRYJArcBiPK4yNxvZduEeie7SdKQL/5U4VMq4JFCTsxkLPhZlzYmKZeD856fuEMmwjUSS2wB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=HvTP3oa3; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HvTP3oa3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=b5dwPT7oVp+eWjN8usPw2HacP4FIEd1kjOUu2mnsov8=; b=HvTP3oa3ZUtO
	J2uxWit2LXtbRzjjltF/Eyvtfd8H6yPVTofGV0rOUfpadVCsUmTtMvLEjFi5AFtzPe5IrzVT2sF+c
	btJx6c0TlAE4B+BpIsRrMQLjtAQWsjoNtWuPAEtE8soE2+MjUbPKEiOj5ww5LBbIMWPQ5r0bPsuAa
	gqFbebqBG/rZqdltEc7SP3wr8IxGgCn4q0sZZ8WSxTvsVtbrXqdbLnnlodvVCcYOoAtr66tBEJlDL
	IGztoxMCGCAREL9/fHXZ/78h0jOT1f38fiJA/KAu9RbNJTClAM7b6FjaOozp5K8MD0xiqzVcyO5nV
	hZunVvxsDEq6ORbFGFgTlw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA80c-00AsiD-0R;
	Fri, 25 Sep 2026 17:41:46 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/1] selftests: bpf: fix test_lru_sanity3
Date: Fri, 25 Sep 2026 18:38:12 +0300
Message-ID: <20260925154029.3673513-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Skip the test where __tgt_size(tgt_free) is 0 instead of forcing
  batch_size to 1. With one element per refill the forced shrink on the
  last insert evicts a live key, so v1 failed above 128 cpus, where the
  original test still passed by degenerating.
- Drop assert(__tgt_size(map_size) == batch_size), it holds for every
  batch_size and cpu count and checked nothing.
- Cut the comment above map_size to one line.
- Reword to better explain the cause of the failure.
- Sent separately from rest of v1 patchset.

Link to v1: https://lore.kernel.org/bpf/20260917015605.2464043-2-eva.kurchatova@virtuozzo.com/

Eva Kurchatova (1):
  selftests: bpf: size the map in test_lru_sanity3 to whole refills

 tools/testing/selftests/bpf/test_lru_map.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.55.0

