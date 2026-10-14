Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6956C639;
	Wed, 14 Oct 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003590; cv=none; b=lPV/om55gG1j16sH23PLFgAT61Vo52xViMRdDWBFjfEWo8yIy8DWWTxqPaiPbLBCIoQMqESp18m6KctFIX+LfdmoaCzntSr1Ls95YYzcgs6aUhfCOmZoZxpX3fKrMXUjd3I3YXw8ZrvQf8n6PSDmp7LSqlbKWwFbWCLtWj9PHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003590; c=relaxed/simple;
	bh=lUE8XQtoWyQkuuiiT1EGHZoucZ6Tx3SUwt543PkYV04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQTYrKpTR56gLzjh72FcCW6qOYbA2CRRQe8jr1R713C3uzg3adcH+YySNrrFQaWqnZ4QWqHGCv2KQzOccaHCDnnk986G+yMxi4GMDDLa967eS63IzbXZQIInJOWpNqoB2QBetFxL1vGLFHCBhXbNQ1HfqV1t5tlLJ5i2xnGlc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SftybW+B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SftybW+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003588; x=1823539588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUE8XQtoWyQkuuiiT1EGHZoucZ6Tx3SUwt543PkYV04=;
  b=SftybW+BuRMH1AW0169LvdNfpwPyzySUC3gHXB2OTU8Xtgv2Mwxy+Y0+
   2b7+23QHMfItG0McfJ1BorcU8eg4sBYmVI+5QU+71he1arO02CIkIQBLn
   YrYdUKpCtD1W9ewSrGh9KAaJHvQ7pkj0DEgCoe5EtGriaiQnzC8no4RLZ
   yvVpGdnKAMi5poGf1SrPOgQ6wtFMlxJPLLxb2C4/DtoWXD9GX2iIFnhu+
   58al4W0RJCuGxYO7Ns1zFopgbaqwNiV5FBy3mHQpz/s6oL/eul3zBAxO2
   VkcxyMNhRquc10x/dv+KTNlbrAW7gf3kZbekyQnxChE+cdnO5mOQsviYG
   A==;
X-CSE-ConnectionGUID: cDBu22XbRVi/0uv4Z99Vgw==
X-CSE-MsgGUID: hBbK99tARA+5fQzuh9cuxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767374"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:28 -0700
X-CSE-ConnectionGUID: +ohTrm2DSI2oTK4jW8LYbg==
X-CSE-MsgGUID: 8XpEYVoxQ3mETyKePQVrdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420846"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:25 -0700
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
Subject: [PATCH v3 net-next 13/15] selftests: xsk: list the hardware test cases
Date: Wed, 14 Oct 2026 20:45:37 +0200
Message-Id: <20261014184539.774708-14-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware test that the next patch adds runs each case with its
zero-copy endpoint as RX, as TX or as both. A list of the cases by ID
in that runner would repeat the test table and silently go stale when a
case is added or moved.

Split tests[] into the tests that check both endpoint roles, those that
check the RX endpoint, those that check the TX endpoint, and the
generic ones, which a hardware run does not do: BIDIRECTIONAL swaps the
directions, and the others skip in hardware mode. The test IDs follow
the order of these arrays, so they change, and the runners take them
from xskxceiver. The notes that came with ci_skip_tests[] go.

-L lists each hardware test once per role that it tests, as
"ID: NAME rx" or "ID: NAME tx", while -l still lists every test by ID.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.h  | 67 +++++++++++++------
 .../selftests/net/lib/xsk/xskxceiver.c        | 47 ++++++++++---
 2 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 85c1eabbe7f0..f80e16d84a51 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -308,49 +308,72 @@ int testapp_xdp_shared_umem(struct test_spec *test);
 int worker_testapp_validate_rx(struct test_spec *test);
 int worker_testapp_validate_tx(struct test_spec *test);
 
-static const struct test_spec tests[] = {
+/* Tests by the role of the endpoint that they check. A hardware run, see
+ * xskxceiver -L, gives that role to its zero-copy endpoint. It does not do
+ * the generic tests: they swap the directions, which drivers/net/hw/xsk.py
+ * sets up one at a time, or skip in hardware mode.
+ */
+static const struct test_spec hw_rx_tx_tests[] = {
 	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
 	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
 	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
+	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
+	 .test_func = testapp_send_receive_unaligned_mb},
+	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
+	{.name = "TEARDOWN", .test_func = testapp_teardown},
+};
+
+static const struct test_spec hw_rx_tests[] = {
 	{.name = "POLL_RX", .test_func = testapp_poll_rx},
-	{.name = "POLL_TX", .test_func = testapp_poll_tx},
 	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
-	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
-	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
-	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
 	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
-	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
-	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
-	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
 	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
 	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
 	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
 	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
-	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
-	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
-	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
-	/* Flaky tests */
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
-	/* Tests with huge page dependency */
-	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
+};
+
+static const struct test_spec hw_tx_tests[] = {
+	{.name = "POLL_TX", .test_func = testapp_poll_tx},
+	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
+	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
+	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
+	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
+	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
+	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
 	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
 	 .test_func = testapp_unaligned_inv_desc_4001_frame},
-	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
-	 .test_func = testapp_send_receive_unaligned_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
-	/* Test with HW ring size dependency */
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
-	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
-	/* Too long test */
-	{.name = "TEARDOWN", .test_func = testapp_teardown},
+};
+
+static const struct test_spec generic_tests[] = {
+	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
+	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
+	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
+	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
+};
+
+/* A test ID is the index of the test in these arrays taken in order. */
+static const struct test_group {
+	const struct test_spec *tests;
+	u32 nb_tests;
+	bool hw_rx;
+	bool hw_tx;
+} test_groups[] = {
+	{hw_rx_tx_tests, ARRAY_SIZE(hw_rx_tx_tests), true, true},
+	{hw_rx_tests, ARRAY_SIZE(hw_rx_tests), true, false},
+	{hw_tx_tests, ARRAY_SIZE(hw_tx_tests), false, true},
+	{generic_tests, ARRAY_SIZE(generic_tests), false, false},
 };
 
 
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 7044822f23c0..7705a9f2b7a1 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -193,6 +193,7 @@ static struct option long_options[] = {
 	{"verbose", no_argument, 0, 'v'},
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
+	{"list-hw", no_argument, 0, 'L'},
 	{"test", required_argument, 0, 't'},
 	{"endpoint", required_argument, 0, 'e'},
 	{"peer", required_argument, 0, 'p'},
@@ -219,6 +220,7 @@ static void print_usage(char **argv)
 		"  -b, --busy-poll      Enable busy poll\n"
 		"  -m, --mode           Mode to run: skb, drv or zc\n"
 		"  -l, --list           List all available tests\n"
+		"  -L, --list-hw        List hardware tests and the roles they test\n"
 		"  -t, --test           Test case to run, a number from -l\n"
 		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
 		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
@@ -263,13 +265,38 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
 	ifobj->orig_mtu = ifobj->dev_mtu;
 }
 
-static void print_tests(void)
+/* List each test, or each hardware test once per role it tests. */
+static void print_tests(bool hw)
+{
+	const struct test_group *group;
+	u32 i, j, id = 0;
+
+	printf("%s:\n", hw ? "Hardware tests" : "Tests");
+	for (i = 0; i < ARRAY_SIZE(test_groups); i++) {
+		group = &test_groups[i];
+		for (j = 0; j < group->nb_tests; j++, id++) {
+			const char *name = group->tests[j].name;
+
+			if (!hw)
+				printf("%u: %s\n", id, name);
+			if (hw && group->hw_rx)
+				printf("%u: %s rx\n", id, name);
+			if (hw && group->hw_tx)
+				printf("%u: %s tx\n", id, name);
+		}
+	}
+}
+
+static const struct test_spec *find_test(u32 id)
 {
 	u32 i;
 
-	printf("Tests:\n");
-	for (i = 0; i < ARRAY_SIZE(tests); i++)
-		printf("%u: %s\n", i, tests[i].name);
+	for (i = 0; i < ARRAY_SIZE(test_groups); i++) {
+		if (id < test_groups[i].nb_tests)
+			return &test_groups[i].tests[id];
+		id -= test_groups[i].nb_tests;
+	}
+	return NULL;
 }
 
 static u32 parse_u32(const char *arg, u32 min, u32 max, char **argv)
@@ -292,7 +319,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:lt:e:p:P:", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:lLt:e:p:P:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -318,7 +345,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 				print_usage(argv);
 			break;
 		case 'l':
-			print_tests();
+		case 'L':
+			print_tests(c == 'L');
 			ksft_exit_pass();
 			break;
 		case 't':
@@ -529,8 +557,8 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 int main(int argc, char **argv)
 {
 	u32 cache_line_size, max_frags, umem_tailroom;
-	const size_t total_tests = ARRAY_SIZE(tests);
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	const struct test_spec *test_to_run;
 	struct ifobject *shadow_ifobj;
 	struct ifobject *local_ifobj;
 	struct xsk_peer *peer = NULL;
@@ -576,7 +604,8 @@ int main(int argc, char **argv)
 	ifobj_tx->caps.umem_tailroom = umem_tailroom;
 	ifobj_rx->caps.umem_tailroom = umem_tailroom;
 
-	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
+	test_to_run = find_test(opt_run_test);
+	if (!test_to_run) {
 		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
@@ -619,7 +648,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_set_plan(1);
-	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, &tests[opt_run_test]);
+	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, test_to_run);
 	ret = run_pkt_test(&test);
 
 out:
-- 
2.43.0

