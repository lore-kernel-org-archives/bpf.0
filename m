Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37D5326D3;
	Thu,  1 Oct 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886184; cv=none; b=YVx0LeBLcoiZYtnaDvOAEXeVa1YsFLcDa/Y8gKDYdWtntm+gAnHUqi1Phw2qYwQE+kRdQVz6vyxs1jwRfROER1qOQhZ9jnG8SC3F0nH/Ba5C0lvRYqwyd1sclJencob6j5rqd1ros+PWVH27OzdEhWS5HjgVzV1vdsAmaTW+0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886184; c=relaxed/simple;
	bh=RZJewHqjlxscL9ZlEtmqonEe6XQu08O5+HpsOA4yuWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0g56NUPF5H1cEVoSr59dilGJ1IWPHxX3PKox8SD0gpjhnP5cHuWnNnVAq56q3EJGp3sFyGXhnjejZbZR8mytEjjKiNckBTrKTp/epr4GlFrmHodglTrHrP5+jhQTqplMfTJ4EFkDkcYStUkqtmRL8CrmrxvUvEC3QTH8qnarf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo/5O1H2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo/5O1H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886177; x=1822422177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZJewHqjlxscL9ZlEtmqonEe6XQu08O5+HpsOA4yuWc=;
  b=Xo/5O1H2tl3zsQzET+DwMjxsfFi6CXFnuQBOOyaM/E/FL+lAC797Pmm5
   3E1XYU9jNSTe3Qu7ah6lirXg8Yie+/mzbeBI0CF1Yf6pIuUOt1N2uqF7Y
   eJvB9LAvWwR0Ij6U+4HsSwa9oXOt8GvYR7chx7agxgP8sMkDtZdhSlhko
   gskQWNKrZfheCzumI1oahHBX0gLnxuTlymVxvum4RvroPZH8q/97ESp7/
   LkkKXBpP5+DLceKKE6q2/dH3A4TFN0DKnq3bAuh+/Po76ho+VJ6zWeAHh
   h4KeCAuzjkjmppvRd6fhRWgUmIcilw6SyPKrp1pZUg39DEtwg3pZs1hf5
   w==;
X-CSE-ConnectionGUID: ObdJiAiRRX6Jlf+1r9VhlA==
X-CSE-MsgGUID: 0UHydkzeQU+p0uPuByosrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466845"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:51 -0700
X-CSE-ConnectionGUID: YrLftWh6RUGYMcllxOaddg==
X-CSE-MsgGUID: XvyUrzKwSIi57vUCIYD4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636737"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:50 -0700
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
Subject: [PATCH net-next 11/13] selftests: xsk: share test case definitions with hardware runner
Date: Thu,  1 Oct 2026 22:21:22 +0200
Message-Id: <20261001202124.692591-12-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep case names, functions, and hardware directions in an X-macro
header. The C test table keeps its order, so the test IDs do not
change. This allows the Python runner added by the next patch to read
the same definitions. Only the runner uses the hardware directions,
the DUT roles in which it runs a case; xskxceiver ignores them.

Install the header with selftests so the Python runner can read it
from an installed tree.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/net/lib/Makefile      |  2 +-
 .../testing/selftests/net/lib/xsk/test_xsk.h  | 46 ++-------------
 .../net/lib/xsk/test_xsk_case_defs.h          | 57 +++++++++++++++++++
 3 files changed, 62 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h

diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index cdc7469068da..faac930acf1d 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -26,7 +26,7 @@ else
 $(warning excluding xskxceiver, bpftool not found)
 endif
 
-TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
+TEST_INCLUDES := $(wildcard py/*.py sh/*.sh) xsk/test_xsk_case_defs.h
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index c37423030eb6..e1ffd054c8f7 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -309,48 +309,10 @@ int worker_testapp_validate_rx(struct test_spec *test);
 int worker_testapp_validate_tx(struct test_spec *test);
 
 static const struct test_spec tests[] = {
-	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
-	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
-	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
-	{.name = "POLL_RX", .test_func = testapp_poll_rx},
-	{.name = "POLL_TX", .test_func = testapp_poll_tx},
-	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
-	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
-	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
-	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
-	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
-	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
-	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
-	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
-	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
-	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
-	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
-	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
-	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
-	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
-	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
-	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
-	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
-	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
-	/* Flaky tests */
-	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
-	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
-	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
-	/* Tests with huge page dependency */
-	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
-	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
-	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
-	 .test_func = testapp_unaligned_inv_desc_4001_frame},
-	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
-	 .test_func = testapp_send_receive_unaligned_mb},
-	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
-	/* Test with HW ring size dependency */
-	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
-	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
-	/* Too long test */
-	{.name = "TEARDOWN", .test_func = testapp_teardown},
+#define XSK_TEST_CASE(_name, _func, ...) \
+	{ .name = #_name, .test_func = _func },
+#include "test_xsk_case_defs.h"
+#undef XSK_TEST_CASE
 };
 
 
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h b/tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h
new file mode 100644
index 000000000000..873e89c9d4d5
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Each XSK_TEST_CASE entry has a name, function, and hardware directions.
+ * Only xsk.py reads the directions, the DUT roles in which it runs a case.
+ *
+ * Keep this list in test ID order. It is shared by xskxceiver and xsk.py.
+ */
+XSK_TEST_CASE(SEND_RECEIVE, testapp_send_receive, XSK_HW_RX | XSK_HW_TX)
+XSK_TEST_CASE(SEND_RECEIVE_2K_FRAME, testapp_send_receive_2k_frame,
+	      XSK_HW_RX | XSK_HW_TX)
+XSK_TEST_CASE(SEND_RECEIVE_SINGLE_PKT, testapp_single_pkt,
+	      XSK_HW_RX | XSK_HW_TX)
+XSK_TEST_CASE(POLL_RX, testapp_poll_rx, XSK_HW_RX)
+XSK_TEST_CASE(POLL_TX, testapp_poll_tx, XSK_HW_TX)
+XSK_TEST_CASE(POLL_RXQ_FULL, testapp_poll_rxq_tmout, XSK_HW_RX)
+XSK_TEST_CASE(POLL_TXQ_FULL, testapp_poll_txq_tmout, XSK_HW_TX)
+XSK_TEST_CASE(ALIGNED_INV_DESC, testapp_aligned_inv_desc, XSK_HW_TX)
+XSK_TEST_CASE(ALIGNED_INV_DESC_2K_FRAME_SIZE,
+	      testapp_aligned_inv_desc_2k_frame, XSK_HW_TX)
+XSK_TEST_CASE(UMEM_HEADROOM, testapp_headroom, XSK_HW_RX)
+XSK_TEST_CASE(BIDIRECTIONAL, testapp_bidirectional, 0)
+XSK_TEST_CASE(STAT_RX_DROPPED, testapp_stats_rx_dropped, 0)
+XSK_TEST_CASE(STAT_TX_INVALID, testapp_stats_tx_invalid_descs, XSK_HW_TX)
+XSK_TEST_CASE(STAT_RX_FULL, testapp_stats_rx_full, 0)
+XSK_TEST_CASE(STAT_FILL_EMPTY, testapp_stats_fill_empty, 0)
+XSK_TEST_CASE(XDP_PROG_CLEANUP, testapp_xdp_prog_cleanup, XSK_HW_RX)
+XSK_TEST_CASE(XDP_DROP_HALF, testapp_xdp_drop, 0)
+XSK_TEST_CASE(XDP_SHARED_UMEM, testapp_xdp_shared_umem, 0)
+XSK_TEST_CASE(XDP_METADATA_COPY, testapp_xdp_metadata, XSK_HW_RX)
+XSK_TEST_CASE(XDP_METADATA_COPY_MULTI_BUFF, testapp_xdp_metadata_mb, 0)
+XSK_TEST_CASE(ALIGNED_INV_DESC_MULTI_BUFF, testapp_aligned_inv_desc_mb,
+	      XSK_HW_TX)
+XSK_TEST_CASE(TOO_MANY_FRAGS, testapp_too_many_frags, XSK_HW_TX)
+XSK_TEST_CASE(XDP_ADJUST_TAIL_SHRINK, testapp_adjust_tail_shrink, 0)
+XSK_TEST_CASE(TX_QUEUE_CONSUMER, testapp_tx_queue_consumer, 0)
+/* Flaky tests */
+XSK_TEST_CASE(XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF,
+	      testapp_adjust_tail_shrink_mb, 0)
+XSK_TEST_CASE(XDP_ADJUST_TAIL_GROW, testapp_adjust_tail_grow, 0)
+XSK_TEST_CASE(XDP_ADJUST_TAIL_GROW_MULTI_BUFF, testapp_adjust_tail_grow_mb, 0)
+XSK_TEST_CASE(SEND_RECEIVE_9K_PACKETS, testapp_send_receive_mb,
+	      XSK_HW_RX | XSK_HW_TX)
+/* Tests with huge page dependency */
+XSK_TEST_CASE(SEND_RECEIVE_UNALIGNED, testapp_send_receive_unaligned,
+	      XSK_HW_RX | XSK_HW_TX)
+XSK_TEST_CASE(UNALIGNED_INV_DESC, testapp_unaligned_inv_desc, XSK_HW_TX)
+XSK_TEST_CASE(UNALIGNED_INV_DESC_4001_FRAME_SIZE,
+	      testapp_unaligned_inv_desc_4001_frame, XSK_HW_TX)
+XSK_TEST_CASE(SEND_RECEIVE_UNALIGNED_9K_PACKETS,
+	      testapp_send_receive_unaligned_mb, XSK_HW_RX | XSK_HW_TX)
+XSK_TEST_CASE(UNALIGNED_INV_DESC_MULTI_BUFF, testapp_unaligned_inv_desc_mb,
+	      XSK_HW_TX)
+/* Tests with HW ring size dependency */
+XSK_TEST_CASE(HW_SW_MIN_RING_SIZE, testapp_hw_sw_min_ring_size, 0)
+XSK_TEST_CASE(HW_SW_MAX_RING_SIZE, testapp_hw_sw_max_ring_size, 0)
+/* Too long test */
+XSK_TEST_CASE(TEARDOWN, testapp_teardown, 0)
-- 
2.43.0

