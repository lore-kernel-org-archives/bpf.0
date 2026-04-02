Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A83E275C;
	Thu,  2 Apr 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145055; cv=none; b=Htm3niPQOlsn6QvFqtbbA9FgEt+0r4ryV6M4eQk1czBbetrkyH7MBVXlgqg6K8F9S6zhInGMkiRWtBiHlNv0AnkJViU7K9LnjwXpmZU0ZDbFiXXLb8qURzNzWyjQWL1FxAujZFjRUO+OUOyBsV6CxG5H626tH6SmIcyCVFvVh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145055; c=relaxed/simple;
	bh=S5sd9yRoghqwhQTAXiuDcN7CcdS8wAIdH6SwnMhfOHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5pvCDn72MWnr7+OSPkMSbHvECEIgqRzrafWbHjN+OWeSzTk0vlO//c3OKNF+KtlpTzVD3IYIauzCmhdp1/gXHSzZlbNiJ1Otey/OTObDthGgLXlY+ZGLSd+rq8+cUhg6Tfhy5EmnvCcxgPn1W96RTKwqiTZA9sH68fgYq4DQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nt1MD1ys; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt1MD1ys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145055; x=1806681055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5sd9yRoghqwhQTAXiuDcN7CcdS8wAIdH6SwnMhfOHI=;
  b=Nt1MD1ysjRr8dao4Ii9NTA/ZujL2tVCDZdBLobVSYpm/NCuuN9euSij5
   l7Y0oQ0qgT8JqYvY+Jlw8IoP9z+S6n1fRl+uvuoFAEzaPN3dxC1ECrlEU
   9q+r6VD3EIGSGnhqn8vJ7C6yEFJNDmnhjePS49+ejsKAcvEKJNORONUbv
   uCeyUDsCX60ZA81PkV589Hp6WqSnHuwju5/8NoL3I3iqyKdMeoHeIO/rb
   euOtdTQpu954VFttGK7E49KiYC+tZutBM+DUE0RDyu7/PMxsIQDwYhKGY
   cclBQAk2eweFZ2OoVIYMEFQsDl574e+gaOLgakHwVWRtTl0SKXNzoG3ky
   g==;
X-CSE-ConnectionGUID: yUElA2MLR/eMU95J6LKv2A==
X-CSE-MsgGUID: L7yMs029SKa2sDVXRZVVBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75928009"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75928009"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:55 -0700
X-CSE-ConnectionGUID: uVHiQL0yRG+zApoRyHn8bw==
X-CSE-MsgGUID: bY+yjtkUTb299CZldVF3Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157726"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v6 net 8/8] selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom
Date: Thu,  2 Apr 2026 17:49:58 +0200
Message-Id: <20260402154958.562179-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since we have changed how big user defined headroom in umem can be,
change the logic in testapp_stats_rx_dropped() so we pass updated
headroom validation in xdp_umem_reg() and still drop half of frames.

Test works on non-mbuf setup so __xsk_pool_get_rx_frame_size() that is
called on xsk_rcv_check() will not account skb_shared_info size. Taking
the tailroom size into account in test being fixed is needed as
xdp_umem_reg() defaults to respect it.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ee60bcc22ee4..7950c504ed28 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1959,15 +1959,17 @@ int testapp_headroom(struct test_spec *test)
 
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
+	u32 umem_tr = test->ifobj_tx->umem_tailroom;
+
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
 	}
 
-	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
+	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
 		return TEST_FAILURE;
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
-		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
+		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
-- 
2.43.0

