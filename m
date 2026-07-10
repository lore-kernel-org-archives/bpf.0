Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D00385D98;
	Fri, 10 Jul 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712706; cv=none; b=RBQb60R+ZGmPpnwStz4yrF0CLR43vkY8x7HOesRoFcz89Gi2yabtn9bPCXvRuG8NuDKNn2EykeyK9zVq5K+stP5OounYuZecBACD/NgGoSbqJ9Wnk9pc0j93asuQSjCi5IsjwQAzRq4+MlEyJ8LLrgJWwAQWMpT+CcSFWEgZyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712706; c=relaxed/simple;
	bh=u478NMbtsRva1LZrqkCrRxxL0J701DD1osUrLGCq5mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7S59GV873oj3aDk3jlCfea5JKCVtIyMePykQhZPam0F8GVwxR/V1gs/gGSfgFNPJ/bf36eT6sdvI/G7A5pT00tXknsoHq1udbYY+5xWnDwnUiYnRz5xYMvMyNBWN1yQq/Be9oYCm2H+X0UCQAx46dBhJ/A43z/5JhPCplWNcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7F/QQb/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7F/QQb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712705; x=1815248705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u478NMbtsRva1LZrqkCrRxxL0J701DD1osUrLGCq5mQ=;
  b=L7F/QQb/TnVVdph0TyD7h1Nxgas+Um0WYnhKH5GAHFyBMvFEqrgAEfCb
   FhgeDFExWSV74xYRuM+X5GAjwhemv1DKnU1JMzQGsqH5jXIMEyYh1mZoE
   0r/pSyD8pSy39nZsWT9TnMbky16F13j+V+5X8LSIze+PkxDVeMTmaQTtf
   sN73Vn12uYDk0JwffS1C+YXATb19KjPXEqmOZvClza/avgirTfrw5bLTZ
   f/zC+lKCb/QOdl3BhhkKbw3icgAGaSCZZvYu2etdw3fKzXwj1Lbo+WvkI
   dUO2fYZ0ZfkiTBrMrkDQXuq009RAmivulPHYQkbHybhapCkKJesjTULcB
   g==;
X-CSE-ConnectionGUID: PW0klLaYSrScTHg1Fdkf8w==
X-CSE-MsgGUID: HOOUZa9GSgqAaNqqX1zncA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965227"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965227"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:45:04 -0700
X-CSE-ConnectionGUID: M+kRrPV3SfGX7Dj4AmHEXg==
X-CSE-MsgGUID: Hs3hU7lzQeK92iuj6+bwbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157344"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:45:01 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 4/5] selftests/xsk: fix too-many-frags multi-buffer Tx test
Date: Fri, 10 Jul 2026 21:44:23 +0200
Message-Id: <20260710194424.84844-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
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

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 6eb9096d084c..de17dd48f176 100644
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

