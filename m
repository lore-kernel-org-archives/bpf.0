Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB03451B3;
	Sun, 19 Jul 2026 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469398; cv=none; b=ZiwYXubmz4GS/cb08E/qzxZztOUmqbZnNk62S1n0ZCoaRHmZ5xyGMnJnHGbwspcVePUB9e6XY4LckEhjAwgi8ZQgBlnpN2141zi0AL5D+33+VqkGX1jQXq1bNpOJrmLVo9XbSMFWJEWlKRYZLF0eh4OoblvXCqFYC04HimzPvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469398; c=relaxed/simple;
	bh=Q8rEgFlf+zXjg+cSFlL89fadc9CluPAxcR1Spdroquo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPaPcKagKTixwYZMg3+6CzeSUaiZNmGp+HCQoO42C/rQnWDqTS0EwF5CTghellCIhX3vA0olTwhMNEnRC2ruO0agm4EolTZD2q0zpgbjiilhdS0yCZJkTozKeckxPVskAniIsIs8Yv+mb1aA+CBmcSZwwxEZqIpfxWijUdISkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAJvgqCA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAJvgqCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784469396; x=1816005396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8rEgFlf+zXjg+cSFlL89fadc9CluPAxcR1Spdroquo=;
  b=GAJvgqCAsx/RlzUn3JBExYx6nB+trbOx9o5ZWoC0tiIYtXvcezJONywc
   qbv74kPDPB1ndWNBQOVQA1COxphWkUp406ONJ9fiG+4OUp/VkuQKJ5LBo
   2sgvS40RtSuo4tWO/JX5fzInou/aCFyZT5lZefpfEd1rbZuTH/+Tjzg0Y
   WLJLIuhHe5KZRjRK+6yROWTWm+XaNx5Z1fgyCku9ShwnG6Efjs4u+E0xx
   k8k6XaX5AGf2ZKteJyGf3sr+KI4y0ZHgQBVxANzbQBpdrLtsyOeGWEZiC
   8LEEAGHLcMTDHypC7jZabSH6WkJVbd/wRtnODbqb8U6iEtChFWg5LqBuh
   w==;
X-CSE-ConnectionGUID: UkH2ONOCQ8iGCsbRqJyKyQ==
X-CSE-MsgGUID: pebrchnySF212Ae/HZbkoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88894188"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88894188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:56:36 -0700
X-CSE-ConnectionGUID: r3S9/lcGSQ613pcGlzYFaQ==
X-CSE-MsgGUID: bNOGmzohSkua7f2LLEs5jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="260791951"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Jul 2026 06:56:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v4 net 5/6] selftests/xsk: fix too-many-frags multi-buffer Tx test
Date: Sun, 19 Jul 2026 15:56:08 +0200
Message-Id: <20260719135609.147823-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The too-many-frags test describes a packet that is valid from the Tx
ring ownership point of view, but invalid for transmission because it
exceeds the supported number of fragments.

Keep the generated Tx descriptors valid so that __send_pkts() accounts
them as outstanding descriptors that must be reclaimed through the CQ.
Then mark the corresponding Rx packet invalid so the test still does
not expect the oversized packet to appear on the receive side.

Add a valid synchronization packet after the oversized packet so the
test can verify that the Tx path drains the bad packet and resumes at
the next packet boundary.

Reviewed-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 477aedbb01ba..f0e0f3c4f7a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2270,7 +2270,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2288,24 +2288,30 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with the max + 1 amount of frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
-		pkts[i].valid = false;
+		pkts[i].valid = true;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
 
+	/* The generated Tx stream must keep the too-big packet valid so that
+	 * __send_pkts() accounts its descriptors in outstanding_tx. The Rx
+	 * stream, however, must not expect this packet on the wire.
+	 */
+	test->ifobj_rx->xsk->pkt_stream->pkts[2].valid = false;
+	test->ifobj_rx->xsk->pkt_stream->nb_valid_entries--;
+
 	ret = testapp_validate_traffic(test);
 	free(pkts);
 	return ret;
-- 
2.43.0

