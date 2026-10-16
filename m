Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193958E2DC;
	Fri, 16 Oct 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172635; cv=none; b=g+B9gGnhhxIbr18pQ8Kr8T51pT8KS0oKT4BZcAimZedaydo7CscDVCbgksVYsa6egjhzkW7jI59B25ELeKZiWJvqT5hayz5AsD6Te4wICTbknMYh+S6999rPwpGUxawKYqpIPPYOxskmoPzSgRgQDXfziS9poEGVkYiglZUudWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172635; c=relaxed/simple;
	bh=0G4M7q/e75vkiOAu9RvSEO6fNSZmaRS0FLvyygDx42Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpRYCPHnuZti4Wl68KqjQNeu0GbkGq6i9YBf5XtT5CLazepvBnjYT0fPnD2jxIE9AdoG5l/j2SopXGfc74U/NXF+Uhlm0ubFvEOmvHC6XF2/T61SLLkyaqIsiYKMZecP3IvTlL7JpFsOvyeWjsde7q5uO4DSEzMtgL7zFj0yl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEsIEK/W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEsIEK/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172633; x=1823708633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0G4M7q/e75vkiOAu9RvSEO6fNSZmaRS0FLvyygDx42Y=;
  b=bEsIEK/W1VvYZ3imRcSRcIuCIG1warkT15yUGNpcpQIuqocAqmSTw1It
   iwH9UGg6JTZsfU9z9V02PyCGp8I5rdBLh9/Vfg0mUImJKHmamG38uRFjb
   cSz/B0g3T+gLcOsYkh7GvgxxLnJUAOAMykTTu4moep4N7lwld7bFXPXFg
   xoXMLSZA6IaGrfmIcsqfGRbbXxmvI7z0keSAJGE5riSaclsLAE9gJ+AXy
   94rytSxpNuWex0Up4KPhJwE7ocTDFrOjRx8X7YWQUSpQU4uknBwb3B8kG
   WDISdU2515iXRNIKfNYSJA6kVb/BXPUAgQrgaeVYAcMNPsyZJt4DA7YHW
   A==;
X-CSE-ConnectionGUID: eJ+yCifyTT6yTSnFW0DfpQ==
X-CSE-MsgGUID: qCzEVu9WTx2gDeoTg9ZLvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972338"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:43:53 -0700
X-CSE-ConnectionGUID: SKUxzNZ2TwOlbyz+eK7pLQ==
X-CSE-MsgGUID: 5B96bCteRrCQ//WxfxWeZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425185"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:51 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net-next 02/15] selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE
Date: Fri, 16 Oct 2026 19:43:25 +0200
Message-Id: <20261016174338.787135-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HW_SW_MAX_RING_SIZE gives the RX UMEM 8k frames and 8k rings, then
sends batches of 2k and of the maximum HW TX ring size minus 8. This
only works in the single-interface mode, where the TX socket uses the
RX UMEM, and veth, which cannot change its ring sizes, skips the case.
With two interfaces, TX has its own UMEM of DEFAULT_UMEM_BUFFERS (1k)
frames and 2k rings: the in-flight limit in __send_pkts() turns
negative for a 2k batch, so TX never sends and RX times out, and the
second batch would not fit in the TX ring anyway.

The next patch removes the single-interface mode, so size the TX UMEM
like the RX one. The shared UMEM setup copies the RX UMEM over the TX
one and is not affected.

With a HW TX ring of more than 8200 descriptors, the second batch would
also outgrow the 8k XSK TX ring, and __send_pkts() would spin forever
waiting to reserve it, so cap the batch below the XSK ring size.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 2a1362874092..05457f77ca52 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2504,6 +2504,7 @@ int testapp_hw_sw_min_ring_size(struct test_spec *test)
 int testapp_hw_sw_max_ring_size(struct test_spec *test)
 {
 	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
+	u32 batch_size;
 	int ret;
 
 	test->set_ring = true;
@@ -2513,6 +2514,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->ifobj_rx->xsk->umem->num_frames = max_descs;
 	test->ifobj_rx->xsk->umem->fill_size = max_descs;
 	test->ifobj_rx->xsk->umem->comp_size = max_descs;
+	test->ifobj_tx->xsk->umem->num_frames = max_descs;
+	test->ifobj_tx->xsk->umem->fill_size = max_descs;
+	test->ifobj_tx->xsk->umem->comp_size = max_descs;
 	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 
@@ -2521,10 +2525,12 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 		return ret;
 
 	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
-	 * updating the Rx HW tail register.
+	 * updating the Rx HW tail register. __send_pkts() waits until a whole batch fits
+	 * in the XSK TX ring, so keep it below that ring's size on NICs with larger rings.
 	 */
-	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
-	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
+	batch_size = min(test->ifobj_tx->ring.tx_max_pending, max_descs) - 8;
+	test->ifobj_tx->xsk->batch_size = batch_size;
+	test->ifobj_rx->xsk->batch_size = batch_size;
 	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
 		clean_sockets(test, test->ifobj_tx);
 		clean_sockets(test, test->ifobj_rx);
-- 
2.43.0

