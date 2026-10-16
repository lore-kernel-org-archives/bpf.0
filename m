Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6858E2A9;
	Fri, 16 Oct 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172640; cv=none; b=bsYkhsqZS6sHlVEZuESLGujTRzkDFF2WXwAuZ0I5hYcV5dS8xHu4OBne+/vUh9R+fOn+hHXdf/7ZGdPmazsaAFZq0e0N0sehXUPhO9VFLENM/q3IpGryuLFPu+A3knEtH2yovd7xO9hCiIg47/nKlV/nWi32N2UNRbfgniHvEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172640; c=relaxed/simple;
	bh=bBniwHmStKK/qMiMLUEFzgotKofNl/SzaucHH+5KcDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moKtRZsyV/Bt1UGzqoL9le2nNXvxeyXKBn6hJXba9Cwo57300sdOiPhyzD7PLPmoURXj7H5kWO6cim5qwrDl0g/LLwc2DJbKNFImZg8ulMCHEp/GwiIpBT1gyyUUIRkhfH8a/14Kjq7fMQC+y7w13yfyXR/od6lSrLmn04pM96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1FvFp8E; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1FvFp8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172638; x=1823708638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bBniwHmStKK/qMiMLUEFzgotKofNl/SzaucHH+5KcDM=;
  b=e1FvFp8EkQb0XTPAwuSWlvWmPk5jXmOjGGF8pBj3PnOTJi3KFKORiUZR
   tT4hrpHCDiFmMgKzIvCT9Ve5lKp7+FqYTXUHkazHOZQ5oO7dQSU6FMqaQ
   0VF5Fntw4RROA4qbklAvOL/DzUUESDZRvZ8z82KEN/xX8f7dakOM06QQM
   WDFcjriHzrxF/NFDKPkK0vWjWbsLOb9mL5w9uN00DWsOa9C2LLDPCDTY5
   H9y8Goa9b2+S6gLkNu4jZCVs4MUwVULHIau7Oqo+jqnyLtD+ZByut+FPK
   q09LW4dc5IJKJTXiOVf58U9wLtpAUacj1dbnZhPiUcNdlgD1Wh3C+Ouvh
   A==;
X-CSE-ConnectionGUID: uOPzWDbbQPms1vUuSvPvMA==
X-CSE-MsgGUID: Hr6z/Q+HS16AO6Q1A2bYhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972351"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972351"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:43:58 -0700
X-CSE-ConnectionGUID: pxc89iWFS46jy5caFlJMHw==
X-CSE-MsgGUID: 9X1TVNgEQdiBKzeAlueocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425191"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:56 -0700
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
Subject: [PATCH v4 net-next 04/15] selftests/bpf: drop the test_progs AF_XDP wrapper
Date: Fri, 16 Oct 2026 19:43:27 +0200
Message-Id: <20261016174338.787135-5-maciej.fijalkowski@intel.com>
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

prog_tests/xsk.c runs the xskxceiver cases inside test_progs, driving
the TX and RX sockets of a veth pair from two threads. The following
patches turn each endpoint into a process of its own that can run
against a peer on another host. Keeping the wrapper would mean rewiring
it at every step of that split and teaching test_progs to spawn and
synchronize peer processes, so drop it. BPF CI loses the ns_xsk_skb and
ns_xsk_drv entries; the same veth coverage stays with test_xsk.sh,
which moves to selftests/net together with the engine.

ci_skip_tests[] held the cases that the wrapper left out: flaky and
slow ones and those that need hugepages or HW ring size support.
Nothing runs only one of the lists anymore, so fold ci_skip_tests[]
into tests[]. The test IDs do not change.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.h       |   3 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 160 ------------------
 tools/testing/selftests/bpf/xskxceiver.c      |  10 +-
 3 files changed, 2 insertions(+), 171 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 33331fbee6f5..b3007923e8ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -285,9 +285,6 @@ static const struct test_spec tests[] = {
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
 	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
-	};
-
-static const struct test_spec ci_skip_tests[] = {
 	/* Flaky tests */
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
deleted file mode 100644
index af67e2605818..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ /dev/null
@@ -1,160 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <net/if.h>
-#include <stdarg.h>
-
-#include "network_helpers.h"
-#include "test_progs.h"
-#include "test_xsk.h"
-#include "xsk_xdp_progs.skel.h"
-
-#define VETH_RX "veth0"
-#define VETH_TX "veth1"
-#define MTU	1500
-
-int setup_veth(bool busy_poll)
-{
-	SYS(fail,
-	"ip link add %s numtxqueues 4 numrxqueues 4 type veth peer name %s numtxqueues 4 numrxqueues 4",
-	VETH_RX, VETH_TX);
-	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_RX);
-	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_TX);
-
-	if (busy_poll) {
-		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_RX);
-		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_RX);
-		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_TX);
-		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_TX);
-	}
-
-	SYS(fail, "ip link set %s mtu %d", VETH_RX, MTU);
-	SYS(fail, "ip link set %s mtu %d", VETH_TX, MTU);
-	SYS(fail, "ip link set %s up", VETH_RX);
-	SYS(fail, "ip link set %s up", VETH_TX);
-
-	return 0;
-
-fail:
-	return -1;
-}
-
-void delete_veth(void)
-{
-	SYS_NOFAIL("ip link del %s", VETH_RX);
-	SYS_NOFAIL("ip link del %s", VETH_TX);
-}
-
-int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
-{
-	rx->ifindex = if_nametoindex(VETH_RX);
-	if (!ASSERT_OK_FD(rx->ifindex, "get RX ifindex"))
-		return -1;
-
-	tx->ifindex = if_nametoindex(VETH_TX);
-	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
-		return -1;
-
-	return 0;
-}
-
-static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
-{
-	u32 max_frags, umem_tailroom, cache_line_size;
-	struct ifobject *ifobj_tx, *ifobj_rx;
-	struct test_spec test;
-	int ret;
-
-	ifobj_tx = ifobject_create();
-	if (!ASSERT_OK_PTR(ifobj_tx, "create ifobj_tx"))
-		return;
-
-	ifobj_rx = ifobject_create();
-	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
-		goto delete_tx;
-
-	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
-		goto delete_rx;
-
-	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-	if (!ret)
-		ifobj_tx->hw_ring_size_supp = true;
-
-	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
-	if (!cache_line_size)
-		cache_line_size = 64;
-
-	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
-	if (!max_frags)
-		max_frags = 17;
-
-	ifobj_tx->max_skb_frags = max_frags;
-	ifobj_rx->max_skb_frags = max_frags;
-
-	/* 48 bytes is a part of skb_shared_info w/o frags array;
-	 * 16 bytes is sizeof(skb_frag_t)
-	 */
-	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
-	ifobj_tx->umem_tailroom = umem_tailroom;
-	ifobj_rx->umem_tailroom = umem_tailroom;
-
-	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
-		goto delete_rx;
-	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
-		goto delete_rx;
-
-	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
-
-	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	if (!ASSERT_OK_PTR(test.tx_pkt_stream_default, "TX pkt generation"))
-		goto delete_rx;
-	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	if (!ASSERT_OK_PTR(test.rx_pkt_stream_default, "RX pkt generation"))
-		goto delete_rx;
-
-
-	test_init(&test, ifobj_tx, ifobj_rx, mode, test_to_run);
-	ret = test.test_func(&test);
-	if (ret != TEST_SKIP)
-		ASSERT_OK(ret, "Run test");
-	pkt_stream_restore_default(&test);
-
-	pkt_stream_delete(test.tx_pkt_stream_default);
-	pkt_stream_delete(test.rx_pkt_stream_default);
-	xsk_xdp_progs__destroy(ifobj_tx->xdp_progs);
-	xsk_xdp_progs__destroy(ifobj_rx->xdp_progs);
-
-delete_rx:
-	ifobject_delete(ifobj_rx);
-delete_tx:
-	ifobject_delete(ifobj_tx);
-}
-
-void test_ns_xsk_skb(void)
-{
-	int i;
-
-	if (!ASSERT_OK(setup_veth(false), "setup veth"))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (test__start_subtest(tests[i].name))
-			test_xsk(&tests[i], TEST_MODE_SKB);
-	}
-
-	delete_veth();
-}
-
-void test_ns_xsk_drv(void)
-{
-	int i;
-
-	if (!ASSERT_OK(setup_veth(false), "setup veth"))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (test__start_subtest(tests[i].name))
-			test_xsk(&tests[i], TEST_MODE_DRV);
-	}
-
-	delete_veth();
-}
-
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 300cb354f421..102283480a9a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -327,14 +327,12 @@ static void print_tests(void)
 	printf("Tests:\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		printf("%u: %s\n", i, tests[i].name);
-	for (i = ARRAY_SIZE(tests); i < ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests); i++)
-		printf("%u: %s\n", i, ci_skip_tests[i - ARRAY_SIZE(tests)].name);
 }
 
 int main(int argc, char **argv)
 {
-	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
 	u32 cache_line_size, max_frags, umem_tailroom;
+	const size_t total_tests = ARRAY_SIZE(tests);
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -441,11 +439,7 @@ int main(int argc, char **argv)
 			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
 				continue;
 
-			if (j < ARRAY_SIZE(tests))
-				test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
-			else
-				test_init(&test, ifobj_tx, ifobj_rx, i,
-					  &ci_skip_tests[j - ARRAY_SIZE(tests)]);
+			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 
-- 
2.43.0

