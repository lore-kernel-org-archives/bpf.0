Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4243AEF5E;
	Mon, 23 Mar 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293926; cv=none; b=CmjiAJbtjj9g1MJwK5iAdGEXd4qs0JYlSRVuE6/v8VV8uY5ASYUJbOyWjTaXLsdADT3O9RWTACTTFPU1nhVDLib4WFUMsKhOw+YWYSa406rBUuwMC5JhD8PjuEaGW/HF31R/22KeBMYXcnl8mb6in6xyi+GXwW5fwzp80rHU11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293926; c=relaxed/simple;
	bh=QxCmjj3rpq/jR4iNk9atW1fehzfVAdc4WebOt9f0MKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv+NXXglhpPe1GAvllk7tg1q4MP+PI6cxvoirvXD7BuKTdfCeG+xdfdGqIf5EInrPp8gf/xYyRqFZz44Pd6ynwSw3eIB+ihRzux86JbLASsdsNyWJRpZUInVmgwvF2q5xtBwJbT/dqhStlR/MjRAgKNfLXxb6KZL9QAs/6/y6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MALDR5lm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MALDR5lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293925; x=1805829925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxCmjj3rpq/jR4iNk9atW1fehzfVAdc4WebOt9f0MKw=;
  b=MALDR5lmtD2DDHbjZBcDr/2Z+RzidFjhNnbcu64NhATRn62YmuHn8bc5
   OSIXbOMgPX6Pp4SuuDQMxLCdAn2ZjUjh12Niy+J4TKi1syvNTufT09Z5y
   olTbbMpT3CcbIjCv5/zkoa6bEIo81bSLiYr66bWvk9LD7wKJErq3sfCVC
   NRlJ3oVWGyFa7lB6DsBQseRXe8wVdEp9UEHD+fziKyLG/5plRO+UibzxI
   M0vMZyMqSiBKPFgkOSC2KZPAkdAeQUuBYrVmkZRQ+ugyrEghj5yNKfVNJ
   D8MpMGfTB+4smSjYp4WLrjE8xPhZK31Cinu90eh7vkHTjbAwplyrjyRKk
   Q==;
X-CSE-ConnectionGUID: FYnypxorTleUr/EkvxZVdQ==
X-CSE-MsgGUID: L7I+dM7rSZmYCzLyeELJlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013338"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:25 -0700
X-CSE-ConnectionGUID: p2AwyL6FRGKPNcQVk9rzvQ==
X-CSE-MsgGUID: EVoBKFX5R76IKTw8Fo4mhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187910"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:22 -0700
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
Subject: [PATCH v3 net 5/8] selftests: bpf: fix pkt grow tests
Date: Mon, 23 Mar 2026 20:24:54 +0100
Message-Id: <20260323192457.504631-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Skip tail adjust tests in xskxceiver for SKB mode as it is not very
friendly for it. multi-buffer case does not work as xdp_rxq_info that is
registered for generic XDP does not report ::frag_size. The non-mbuf
path copies packet via skb_pp_cow_data() which only accounts for
headroom, leaving us with no tailroom and causing underlying XDP prog to
drop packets therefore.

For multi-buffer test on other modes, change the amount of bytes we use
for growth, assume worst-case scenario and take care of headroom and
tailroom.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..95cbbf425e9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -35,6 +35,7 @@
 #define XSK_UMEM__INVALID_FRAME_SIZE	(MAX_ETH_JUMBO_SIZE + 1)
 #define XSK_UMEM__LARGE_FRAME_SIZE	(3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
+#define XSK_UMEM__PACKET_TAILROOM 320
 
 static const u8 g_mac[ETH_ALEN] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
 
@@ -2551,16 +2552,34 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
 	/* Grow by 4 bytes for testing purpose */
 	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
 }
 
 int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
+	u32 grow_size;
+
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
+	/* worst case scenario is when underlying setup will work on 3k
+	 * buffers, let us account for it; given that we will use 6k as
+	 * pkt_len, expect that it will be broken down to 2 descs each
+	 * with 3k payload;
+	 *
+	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
+	 */
+	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
+		    XSK_UMEM__LARGE_FRAME_SIZE -
+		    XDP_PACKET_HEADROOM -
+		    XSK_UMEM__PACKET_TAILROOM;
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	/* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
-	return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
-				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
+
+	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
 int testapp_tx_queue_consumer(struct test_spec *test)
-- 
2.43.0

