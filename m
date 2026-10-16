Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B3598C0A;
	Fri, 16 Oct 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172668; cv=none; b=h7NjgORhC6rDIFAh7pCSmlH766O1mmo9k2gJ3PVzdiyFZmU0tEnAlFcw3Uc0S26cVhJ8pspw79pF19LdBFoif5m4VeEwV3tG0MAikdArDdr5Qy1vaNBP00+EC03cX6hFTnWiudXxJDzvSsPjTyMN7Ou9osT5X9JRGXdgZMUu6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172668; c=relaxed/simple;
	bh=I6WAJ10Pjqa78FgyTHVybpoXsMLD+ezSiM71LSh1Za0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdIGY+EwS4r5nw+TIeq+51n5hpiQcxIS2jGK+N2m9g5m6oJZAZl/YjSX2xptd/7YZ3PssQSlnt93vN3XARbbrlgmb6kLaozkrYRD6AK2nc2qEdaAne5qATDp9T4OLfcIevwNUcxWDmZJ8GCRX2cahQEE4lZxb7NDU2fQzbsIhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiC7Swnc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiC7Swnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172663; x=1823708663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I6WAJ10Pjqa78FgyTHVybpoXsMLD+ezSiM71LSh1Za0=;
  b=jiC7SwncxTopTdXJrK4W7R4bSqzdHnmjc6bbtgac4x4WEKk+Y67KPmfO
   zVHOoL2gZIox3M6d+BuUT4rhJymKOqoyCSPWb4LOfHQ+7rYBAKTTSxEFn
   PkPnmW7ZoCvEyfn6M8GoniyKEkCgtkzmywXyqKFJBSZjqF0HzhaaPMJNg
   p5HH3FHLmQGRIldfPsmw32EHr5Wx54ZEIdb0NG232lIIKL/jhnwcQsmSk
   dsHwM8EgESob8Rhq0B2/ZdO5K20eiNhTwOBM+0gn4YPkZqI4zi5qVLM87
   hGAc41I+p42cHpVib7hEXcHuKE1k8VfG1yWdFrOWpyWxbdFzdTYzyuCUz
   w==;
X-CSE-ConnectionGUID: dv9lctTuTwmKbvl/BEWswA==
X-CSE-MsgGUID: XYw2ne1sRcqo4aQ+qB4i6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972406"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:22 -0700
X-CSE-ConnectionGUID: UTcWtk6IQg+eNUEU3yX/iQ==
X-CSE-MsgGUID: MYgIJ7V5QY27pfw8n3CJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425269"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:20 -0700
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
Subject: [PATCH v4 net-next 13/15] selftests: xsk: list the hardware test cases
Date: Fri, 16 Oct 2026 19:43:36 +0200
Message-Id: <20261016174338.787135-14-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
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
directions, and STAT_RX_DROPPED and TX_QUEUE_CONSUMER skip in zero-copy
mode. The test IDs follow the order of these arrays, so they change,
and the runners take them from xskxceiver. The notes that came with
ci_skip_tests[] go.

-L lists each hardware test once per role that it tests, as
"ID: NAME rx" or "ID: NAME tx", while -l still lists every test by ID.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.h  | 68 +++++++++++++------
 .../selftests/net/lib/xsk/xskxceiver.c        | 47 ++++++++++---
 2 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 15534f4ec8f4..a59b34b156d7 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -304,49 +304,73 @@ int testapp_xdp_shared_umem(struct test_spec *test);
 int worker_testapp_validate_rx(struct test_spec *test);
 int worker_testapp_validate_tx(struct test_spec *test);
 
-static const struct test_spec tests[] = {
+/* Tests by the role of the endpoint that they check. A hardware run, see
+ * xskxceiver -L, gives that role to its zero-copy endpoint. It does not do
+ * the generic tests: BIDIRECTIONAL swaps the directions, which
+ * drivers/net/hw/xsk.py sets up one at a time, and the others skip in
+ * zero-copy mode.
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
+	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
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
index 56ea5ac6a3c6..c52e3e376bc5 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -149,6 +149,7 @@ static struct option long_options[] = {
 	{"verbose", no_argument, 0, 'v'},
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
+	{"list-hw", no_argument, 0, 'L'},
 	{"test", required_argument, 0, 't'},
 	{"endpoint", required_argument, 0, 'e'},
 	{"peer", required_argument, 0, 'p'},
@@ -176,6 +177,7 @@ static void print_usage(char **argv)
 		"  -b, --busy-poll      Enable busy poll\n"
 		"  -m, --mode           Mode to run: skb, drv or zc\n"
 		"  -l, --list           List all available tests\n"
+		"  -L, --list-hw        List hardware tests and the roles they test\n"
 		"  -t, --test           Test case to run, a number from -l\n"
 		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
 		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
@@ -219,13 +221,38 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
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
 
 static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx, int argc,
@@ -236,7 +263,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:lt:e:p:P:", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:lLt:e:p:P:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -262,7 +289,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 				print_usage(argv);
 			break;
 		case 'l':
-			print_tests();
+		case 'L':
+			print_tests(c == 'L');
 			ksft_exit_pass();
 			break;
 		case 't':
@@ -461,8 +489,8 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 int main(int argc, char **argv)
 {
 	u32 cache_line_size, max_frags, umem_tailroom;
-	const size_t total_tests = ARRAY_SIZE(tests);
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	const struct test_spec *test_to_run;
 	struct ifobject *shadow_ifobj;
 	struct ifobject *local_ifobj;
 	struct xsk_peer *peer = NULL;
@@ -508,7 +536,8 @@ int main(int argc, char **argv)
 	ifobj_tx->caps.umem_tailroom = umem_tailroom;
 	ifobj_rx->caps.umem_tailroom = umem_tailroom;
 
-	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
+	test_to_run = find_test(opt_run_test);
+	if (!test_to_run) {
 		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
@@ -551,7 +580,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_set_plan(1);
-	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, &tests[opt_run_test]);
+	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, test_to_run);
 	ret = run_pkt_test(&test);
 
 out:
-- 
2.43.0

