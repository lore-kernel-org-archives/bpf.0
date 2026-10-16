Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB75599A37;
	Fri, 16 Oct 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172668; cv=none; b=M4hCyWxftZKMYFGNzruHAc2WuVrvubsIJl5RHdjNJZ3saTJLoVcStkA2Htq1Gqqt6S7n0TsKwes4zHmi9surgxK8EixfFKV5ztnJCLq98HnVre1TSPJD+UgXebvgw6JAN1yj28MF79DVLLKZLd8FDk92xHeWiijOZJq0b5kLNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172668; c=relaxed/simple;
	bh=bN144wCNAa/DaIp47Us5flfZm2q8VtdVoojPHrbAeDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5patCa3sN/C3ZDmhjdlqB3V4iyqpjgACcD7h/Prt1350sT9wznWla34ohqSXZqEWgRzerrht5N9CERTIHjo7jPir/n7E88GqPmyF4/Z8C5SRD4yS3uAx86Wnk3UQGXGtHxvxZAIPoKzG0LvoO0D4qYnPUsbQWVniMLr7YYU4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KN6gFMq0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KN6gFMq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172660; x=1823708660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bN144wCNAa/DaIp47Us5flfZm2q8VtdVoojPHrbAeDs=;
  b=KN6gFMq08TmQzzrEpHkMIr6AipfOs99HdrKEoBq47BfszjlEl1jNahW+
   TZhnfuSkqSX6ASSfcSvUuUK9L4T1ccHwFD8nl7lqxmEwjZzUM9sPUu+jd
   Fe8OyyhDUKfNvjsZOuDuuFblQh1tKYvQjtYnxm404BXncnjXUTHPTMzXh
   /vGAN492D/ydxUbTc989GZ6aA3WBjcRK5BDg0oamJAdS7aBGu4BPBfxLN
   CaWzoLxw8n5BKXoRLAxS6Q3bjBi0VvyjBEUTcRXPs86UHNyJplcA+SzAn
   qAjzaC6Q2oL80Wxzppth7Ohm9wyAIZyD4ZgwvXxUcx0eyrwxVXfz/1jE/
   w==;
X-CSE-ConnectionGUID: IXH1iHQES1uiXRFbRP1UoQ==
X-CSE-MsgGUID: wucg2DfyQ/mr7d6UHHVSxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972400"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972400"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:20 -0700
X-CSE-ConnectionGUID: 1v2OGfUsT2KoBlA2oEkEgA==
X-CSE-MsgGUID: z2u8bhokQki3gygbKF/Cpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425261"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:17 -0700
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
Subject: [PATCH v4 net-next 12/15] selftests: xsk: prepare xskxceiver for endpoints on two hosts
Date: Fri, 16 Oct 2026 19:43:35 +0200
Message-Id: <20261016174338.787135-13-maciej.fijalkowski@intel.com>
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

drivers/net/hw/xsk.py, added later in this series, runs each hardware
AF_XDP case with a zero-copy endpoint on the device under test and an
SKB-mode endpoint on a remote host, without negotiating capabilities
between them. Add what such a pair needs:

- --queue binds a queue other than 0
- --max-frags, up to 0xffff as it sizes a packet array, hands both
  endpoints the DUT limit for TOO_MANY_FRAGS, as each one builds the
  packet stream from its own view of it
- --timeout sets the RX and TX loop timeout, 3s by default, and once
  both endpoints are ready, each waits up to as long while its link is
  down, as an MTU or XDP program change on either host can reset a NIC
- an endpoint probes only the mode it runs in, taking zero-copy support
  from NETDEV_XDP_ACT_XSK_ZEROCOPY rather than from a probe bind; its
  XDP_ZEROCOPY bind fails rather than falling back to copy mode, so a
  false advertisement still fails the case
- an endpoint that only transmits attaches the XDP program only in
  zero-copy mode, where a driver can require one for TX wakeups
- an RX endpoint fills its fill ring before the bind, as a zero-copy
  driver posts its RX buffers then and would otherwise wait for the
  first wakeup, which comes only after READY lets the peer send
- an endpoint that skips a case sends SKIP on the control channel, so
  that its peer skips too rather than failing on the closed connection;
  this is how a TX endpoint learns that both XDP_ADJUST_TAIL_GROW cases
  skip on an SKB-mode RX endpoint. It then reads until the peer closes,
  for up to the timeout, as closing with unread data resets the
  connection, which drops a SKIP that the peer has yet to acknowledge

Cases now default to an MTU of 1500 (ETH_DATA_LEN) rather than the
1518 byte frame size: IFLA_MTU counts the L3 MTU, so the old default
changed a standard MTU, which can reset a NIC, for every case. An
SKB-mode endpoint raises its MTU only when a case needs a larger one,
so a jumbo-MTU peer is not reset twice per case. cleanup_iface()
restores the MTU that bind_iface() found once the XDP program, which
can cap it, is detached, and fails the endpoint if it cannot, so the
result is reported after cleanup_iface().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 143 ++++++++++++++----
 .../testing/selftests/net/lib/xsk/test_xsk.h  |   7 +
 tools/testing/selftests/net/lib/xsk/xsk.c     |  34 +++++
 tools/testing/selftests/net/lib/xsk/xsk.h     |   2 +
 .../testing/selftests/net/lib/xsk/xsk_peer.c  |  46 ++++++
 .../testing/selftests/net/lib/xsk/xsk_peer.h  |   2 +
 .../selftests/net/lib/xsk/xskxceiver.c        | 117 +++++++-------
 7 files changed, 271 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index 9c401a43da43..16669f7e0c9f 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -48,6 +48,8 @@ static union {
 } flow_src, flow_dst;
 static u16 udp_port;
 static u32 pkt_hdr_size;
+static u32 max_frags_override;
+static u32 thread_tmout = THREAD_TMOUT;
 
 bool opt_verbose;
 int min_pkt_size;
@@ -129,6 +131,16 @@ int xsk_set_flow(const char *src_ip, const char *dst_ip, u16 port)
 	return 0;
 }
 
+void xsk_set_max_frags(u32 max_frags)
+{
+	max_frags_override = max_frags;
+}
+
+void xsk_set_timeout(u32 timeout)
+{
+	thread_tmout = timeout;
+}
+
 /* Add up buf as big-endian 16-bit words, len being even. */
 static u32 csum_add(u32 sum, const void *buf, size_t len)
 {
@@ -322,7 +334,8 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, ifobject->queue_id,
+				  umem->umem, rxr, txr, &cfg);
 }
 
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
@@ -381,7 +394,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->nb_sockets = 1;
 	test->adjust_tail = false;
 	test->adjust_tail_support = false;
-	test->mtu = MAX_ETH_PKT_SIZE;
+	test->mtu = ETH_DATA_LEN;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
 	test->xdp_prog_tx = ifobj_tx->xdp_progs->progs.xsk_def_prog;
@@ -445,14 +458,25 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
 	test->xskmap_tx = xskmap_tx;
 }
 
-static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
+/* An MTU change can reset a NIC. An SKB-mode endpoint runs a case at any
+ * larger MTU, as generic XDP does not limit it, so only raise its MTU.
+ */
+static bool mtu_change_needed(struct ifobject *ifobj, enum test_mode mode, int mtu)
+{
+	if (mode == TEST_MODE_SKB)
+		return ifobj->dev_mtu < mtu;
+	return ifobj->dev_mtu != mtu;
+}
+
+static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, enum test_mode mode, int mtu)
 {
 	int err;
 
-	if (ifobj_is_local(ifobj) && ifobj->mtu != mtu) {
+	if (ifobj_is_local(ifobj) && mtu_change_needed(ifobj, mode, mtu)) {
 		err = xsk_set_mtu(ifobj->ifindex, mtu);
 		if (err)
 			return err;
+		ifobj->dev_mtu = mtu;
 	}
 
 	ifobj->mtu = mtu;
@@ -463,11 +487,11 @@ static int test_spec_set_mtu(struct test_spec *test, int mtu)
 {
 	int err;
 
-	err = test_spec_set_mtu_ifobj(test->ifobj_rx, mtu);
+	err = test_spec_set_mtu_ifobj(test->ifobj_rx, test->mode, mtu);
 	if (err)
 		return err;
 
-	return test_spec_set_mtu_ifobj(test->ifobj_tx, mtu);
+	return test_spec_set_mtu_ifobj(test->ifobj_tx, test->mode, mtu);
 }
 
 void pkt_stream_reset(struct pkt_stream *pkt_stream)
@@ -1253,7 +1277,7 @@ bool all_packets_received(struct test_spec *test, struct xsk_socket_info *xsk, u
 
 static int receive_pkts(struct test_spec *test)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {thread_tmout, 0};
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	struct xsk_socket_info *xsk;
 	u32 sock_num = 0;
@@ -1309,6 +1333,11 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
 	    buffer_len) && !test_timeout) {
 		/* Only RX progress reports can lower pkts_in_flight. */
+		if (xsk_peer_skipped(ctrl_peer)) {
+			ksft_print_msg("RX skipped the case with %d packets in flight\n",
+				       pkts_in_flight);
+			return TEST_SKIP;
+		}
 		if (xsk_peer_closed(ctrl_peer)) {
 			ksft_print_msg("ERROR: [%s] RX exited with %d packets in flight\n",
 				       __func__, pkts_in_flight);
@@ -1425,7 +1454,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {thread_tmout, 0};
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1708,20 +1737,26 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ret)
 		return ret;
 
+	ifobject->xsk = &ifobject->xsk_arr[0];
+
+	/* Before the bind: a zero-copy driver posts its RX buffers then, or in
+	 * a poll it schedules then. Otherwise it waits for a wakeup, and the
+	 * peer can send before the RX endpoint gets to it.
+	 */
+	if (ifobject->rx_on) {
+		ret = xsk_populate_fill_ring(umem, ifobject->xsk->pkt_stream,
+					     ifobject->use_fill_ring);
+		if (ret)
+			return ret;
+	}
+
 	ret = xsk_configure(test, ifobject, umem);
 	if (ret)
 		return ret;
 
-	ifobject->xsk = &ifobject->xsk_arr[0];
-
 	if (!ifobject->rx_on)
 		return 0;
 
-	ret = xsk_populate_fill_ring(umem, ifobject->xsk->pkt_stream,
-				     ifobject->use_fill_ring);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < test->nb_sockets; i++) {
 		ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk_arr[i].xsk, i);
 		if (ret)
@@ -1791,14 +1826,43 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
 	return err;
 }
 
+/* An MTU or XDP program change can reset a NIC, which takes the link down on
+ * both hosts. Each endpoint makes those changes before it is ready, so once
+ * both are, wait while the local link is down. This is best effort: it misses
+ * a reset that a driver has yet to start, and one on the bind of a TX socket,
+ * which comes after the wait.
+ */
+static int wait_link_up(struct test_spec *test)
+{
+	struct ifobject *ifobj = test->ifobj_tx;
+	int err;
+
+	if (!ifobj_is_local(ifobj))
+		ifobj = test->ifobj_rx;
+	err = xsk_wait_link_up(ifobj->ifname, thread_tmout * 1000);
+	if (err) {
+		ksft_print_msg("Link on %s is not up at step %u: %d (%s)\n",
+			       ifobj->ifname, test->current_step, err, strerror(-err));
+		xsk_peer_abort(ctrl_peer);
+	}
+	return err;
+}
+
 static int sync_endpoints(struct test_spec *test)
 {
 	int err = xsk_peer_ready(ctrl_peer);
 
-	if (err)
+	if (err && xsk_peer_skipped(ctrl_peer)) {
+		ksft_print_msg("The peer endpoint skipped the case at step %u\n",
+			       test->current_step);
+		return TEST_SKIP;
+	}
+	if (err) {
 		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
 			       test->current_step, err, strerror(-err));
-	return err;
+		return err;
+	}
+	return wait_link_up(test);
 }
 
 int worker_testapp_validate_tx(struct test_spec *test)
@@ -1810,7 +1874,7 @@ int worker_testapp_validate_tx(struct test_spec *test)
 		return err;
 
 	err = testapp_validate_tx_endpoint(test, test->ifobj_tx);
-	if (err) {
+	if (err && err != TEST_SKIP) {
 		ksft_print_msg("TX endpoint traffic failed at step %u: %d\n",
 			       test->current_step, err);
 		xsk_peer_abort(ctrl_peer);
@@ -1905,6 +1969,10 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
 		return 0;
 
+	/* A ZC driver can require XDP to be enabled for TX wakeups. */
+	if (!ifobj_tx->rx_on && test->mode != TEST_MODE_ZC)
+		return 0;
+
 	if (xdp_prog_changed_tx(test))
 		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
 
@@ -1986,6 +2054,8 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		clean_umem(test, ifobj1, ifobj2);
 	}
 
+	if (err == TEST_SKIP)
+		return TEST_SKIP;
 	return err ? TEST_FAILURE : TEST_PASS;
 }
 
@@ -2012,11 +2082,12 @@ static int testapp_validate_traffic_single_thread(struct test_spec *test, struct
 
 int testapp_teardown(struct test_spec *test)
 {
-	int i;
+	int i, ret;
 
 	for (i = 0; i < MAX_TEARDOWN_ITER; i++) {
-		if (testapp_validate_traffic(test))
-			return TEST_FAILURE;
+		ret = testapp_validate_traffic(test);
+		if (ret)
+			return ret;
 		test_spec_reset(test);
 	}
 
@@ -2042,8 +2113,9 @@ int testapp_bidirectional(struct test_spec *test)
 	test->ifobj_tx->rx_on = true;
 	test->ifobj_rx->tx_on = true;
 	test->total_steps = 2;
-	if (testapp_validate_traffic(test))
-		return TEST_FAILURE;
+	res = testapp_validate_traffic(test);
+	if (res)
+		return res;
 
 	print_verbose("Switching Tx/Rx direction\n");
 	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
@@ -2076,10 +2148,13 @@ static int swap_xsk_resources(struct test_spec *test)
 
 int testapp_xdp_prog_cleanup(struct test_spec *test)
 {
+	int ret;
+
 	test->total_steps = 2;
 	test->nb_sockets = 2;
-	if (testapp_validate_traffic(test))
-		return TEST_FAILURE;
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
 
 	if (swap_xsk_resources(test)) {
 		clean_sockets(test, test->ifobj_rx);
@@ -2361,7 +2436,9 @@ int testapp_too_many_frags(struct test_spec *test)
 	u32 max_frags, i;
 	int ret = TEST_FAILURE;
 
-	if (test->mode == TEST_MODE_ZC) {
+	if (max_frags_override) {
+		max_frags = max_frags_override;
+	} else if (test->mode == TEST_MODE_ZC) {
 		max_frags = xsk_get_cap(test, xdp_zc_max_segs);
 	} else {
 		max_frags = xsk_get_cap(test, max_skb_frags);
@@ -2457,6 +2534,7 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
+		ifobj_set_cap(ifobj, XSK_CAP_ZC_ADVERTISED);
 		if (query_opts.xdp_zc_max_segs > 1) {
 			ifobj_set_cap(ifobj, XSK_CAP_MBUF_ZC);
 			ifobj->caps.xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
@@ -2700,9 +2778,18 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 	return testapp_adjust_tail(test, -XSK_UMEM__MAX_FRAME_SIZE, XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
+/* Generic XDP leaves no room to grow the tail. Only the RX endpoint runs the
+ * program on the test flow, and the TX endpoint, which does not know the mode
+ * of its peer, learns about the skip from it.
+ */
+static bool adjust_tail_grow_skip(struct test_spec *test)
+{
+	return ifobj_is_local(test->ifobj_rx) && test->mode == TEST_MODE_SKB;
+}
+
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
-	if (test->mode == TEST_MODE_SKB)
+	if (adjust_tail_grow_skip(test))
 		return TEST_SKIP;
 
 	/* Grow by 4 bytes for testing purpose */
@@ -2713,7 +2800,7 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
 	u32 grow_size;
 
-	if (test->mode == TEST_MODE_SKB)
+	if (adjust_tail_grow_skip(test))
 		return TEST_SKIP;
 
 	/* worst case scenario is when underlying setup will work on 3k
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 4690ae2ad9c6..15534f4ec8f4 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -86,6 +86,8 @@ struct xsk_peer;
 /* The control channel to the other endpoint. */
 void xsk_set_endpoint(struct xsk_peer *peer);
 int xsk_set_flow(const char *src_ip, const char *dst_ip, u16 port);
+void xsk_set_max_frags(u32 max_frags);
+void xsk_set_timeout(u32 timeout);
 
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
@@ -126,6 +128,7 @@ struct xsk_umem_info {
 #define XSK_CAP_HW_RING          (1U << 3)
 #define XSK_CAP_DRV              (1U << 4)
 #define XSK_CAP_ZC               (1U << 5)
+#define XSK_CAP_ZC_ADVERTISED    (1U << 6)
 
 struct xsk_caps {
 	u32 flags;
@@ -149,7 +152,11 @@ struct ifobject {
 	struct ethtool_ringparam ring;
 	enum test_mode mode;
 	int ifindex;
+	u32 queue_id;
 	int mtu;
+	/* Device MTU, which an SKB-mode endpoint may keep above mtu. */
+	int dev_mtu;
+	int orig_mtu;
 	u32 bind_flags;
 	bool tx_on;
 	bool rx_on;
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
index 54e6808e3fe4..6249a4955b64 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -828,3 +828,37 @@ int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN])
 		memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
 	return err;
 }
+
+int xsk_get_mtu(const char *ifname, int *mtu)
+{
+	struct ifreq ifr = {};
+	int err;
+
+	err = xsk_ifreq_ioctl(ifname, SIOCGIFMTU, &ifr);
+	if (!err)
+		*mtu = ifr.ifr_mtu;
+	return err;
+}
+
+/* ETHTOOL_GLINK reports the carrier. SIOCGIFFLAGS cannot: IFF_LOWER_UP does
+ * not fit in ifr_flags, and IFF_RUNNING follows the carrier only once the link
+ * watch runs. A driver without .get_link has nothing to wait for.
+ */
+int xsk_wait_link_up(const char *ifname, int timeout_ms)
+{
+	struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
+	struct ifreq ifr = { .ifr_data = (void *)&edata };
+	int err;
+
+	for (;;) {
+		err = xsk_ifreq_ioctl(ifname, SIOCETHTOOL, &ifr);
+		if (err == -EOPNOTSUPP)
+			return 0;
+		if (err || edata.data)
+			return err;
+		if (timeout_ms <= 0)
+			return -ETIMEDOUT;
+		usleep(100 * 1000);
+		timeout_ms -= 100;
+	}
+}
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.h b/tools/testing/selftests/net/lib/xsk/xsk.h
index 263971a57e1e..181c706cb418 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -245,6 +245,8 @@ int xsk_set_mtu(int ifindex, int mtu);
 
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN]);
+int xsk_get_mtu(const char *ifname, int *mtu);
+int xsk_wait_link_up(const char *ifname, int timeout_ms);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
index e3e353d6abd9..256e63196f92 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_peer.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
@@ -24,6 +24,7 @@ enum xsk_peer_msg_type {
 	XSK_PEER_READY = 1,
 	XSK_PEER_PROGRESS,
 	XSK_PEER_ABORT,
+	XSK_PEER_SKIP,
 };
 
 struct xsk_peer_msg {
@@ -37,6 +38,7 @@ struct xsk_peer {
 	u32 acked;
 	bool ready_seen;
 	bool closed;
+	bool skipped;
 };
 
 static int io_full(int fd, void *buf, size_t len, bool write_op)
@@ -110,6 +112,11 @@ static int peer_recv_one(struct xsk_peer *peer)
 		return 0;
 	case XSK_PEER_ABORT:
 		return -ECANCELED;
+	case XSK_PEER_SKIP:
+		/* The peer skips the case and closes the connection. */
+		peer->closed = true;
+		peer->skipped = true;
+		return -EOPNOTSUPP;
 	default:
 		return -EPROTO;
 	}
@@ -145,6 +152,16 @@ int xsk_peer_ready(struct xsk_peer *peer)
 	int err;
 
 	err = peer_send(peer, XSK_PEER_READY, 0);
+	/*
+	 * Read what a gone peer left, such as a SKIP, up to the end, even if its
+	 * READY came early.
+	 */
+	if (peer_gone(err)) {
+		do {
+			err = peer_recv_one(peer);
+		} while (!err);
+		return err;
+	}
 	while (!err && !peer->ready_seen)
 		err = peer_recv_one(peer);
 	if (err)
@@ -162,6 +179,30 @@ void xsk_peer_abort(struct xsk_peer *peer)
 		peer_send(peer, XSK_PEER_ABORT, 0);
 }
 
+/*
+ * Tell the peer that this endpoint skips the case, so that it skips too.
+ * Closing with unread data, or getting data once closed, resets the
+ * connection and drops the SKIP if the peer has yet to acknowledge it, as
+ * when a NIC reset holds the link down. So read until the peer closes.
+ */
+void xsk_peer_skip(struct xsk_peer *peer, int timeout_ms)
+{
+	struct pollfd pfd = { .events = POLLIN };
+	struct xsk_peer_msg msg;
+	int ret;
+
+	if (!peer || peer->closed || peer_send(peer, XSK_PEER_SKIP, 0))
+		return;
+
+	shutdown(peer->fd, SHUT_WR);
+	pfd.fd = peer->fd;
+	do {
+		ret = poll(&pfd, 1, timeout_ms);
+		if (ret > 0)
+			ret = read(peer->fd, &msg, sizeof(msg));
+	} while (ret > 0 || (ret < 0 && errno == EINTR));
+}
+
 int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts)
 {
 	int err;
@@ -195,6 +236,11 @@ bool xsk_peer_closed(struct xsk_peer *peer)
 	return peer->closed;
 }
 
+bool xsk_peer_skipped(struct xsk_peer *peer)
+{
+	return peer->skipped;
+}
+
 static int accept_tmout(int lfd)
 {
 	struct pollfd pfd = { .fd = lfd, .events = POLLIN };
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.h b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
index da4462192994..26ae6b1bb384 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_peer.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
@@ -12,8 +12,10 @@ void xsk_peer_close(struct xsk_peer *peer);
 
 int xsk_peer_ready(struct xsk_peer *peer);
 void xsk_peer_abort(struct xsk_peer *peer);
+void xsk_peer_skip(struct xsk_peer *peer, int timeout_ms);
 int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts);
 int xsk_peer_tx_sync(struct xsk_peer *peer);
 bool xsk_peer_closed(struct xsk_peer *peer);
+bool xsk_peer_skipped(struct xsk_peer *peer);
 
 #endif /* XSK_PEER_H_ */
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 9704702f60fc..56ea5ac6a3c6 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -119,6 +119,9 @@ static const char *opt_dst_ip;
 static const struct ether_addr *opt_dst_mac;
 static struct ether_addr dst_mac;
 static u16 opt_udp_port;
+static u32 opt_queue;
+static u32 opt_max_frags;
+static u32 opt_timeout = 3;
 
 enum {
 	OPT_LISTEN = 256,
@@ -126,6 +129,9 @@ enum {
 	OPT_DST_IP,
 	OPT_DST_MAC,
 	OPT_UDP_PORT,
+	OPT_QUEUE,
+	OPT_MAX_FRAGS,
+	OPT_TIMEOUT,
 };
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
@@ -137,49 +143,6 @@ static void __exit_with_error(int error, const char *file, const char *func, int
 
 #define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
 
-static bool ifobj_zc_avail(struct ifobject *ifobject)
-{
-	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
-	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
-	struct xsk_socket_info *xsk;
-	struct xsk_umem_info *umem;
-	bool zc_avail = false;
-	void *bufs;
-	int ret;
-
-	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
-	if (bufs == MAP_FAILED)
-		exit_with_error(errno);
-
-	umem = calloc(1, sizeof(struct xsk_umem_info));
-	if (!umem) {
-		munmap(bufs, umem_sz);
-		exit_with_error(ENOMEM);
-	}
-	umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
-	if (ret)
-		exit_with_error(-ret);
-
-	xsk = calloc(1, sizeof(struct xsk_socket_info));
-	if (!xsk)
-		goto out;
-	ifobject->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
-	ifobject->rx_on = true;
-	xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-	ret = xsk_configure_socket(xsk, umem, ifobject, false);
-	if (!ret)
-		zc_avail = true;
-
-	xsk_socket__delete(xsk->xsk);
-	free(xsk);
-out:
-	munmap(umem->buffer, umem_sz);
-	xsk_umem__delete(umem->umem);
-	free(umem);
-	return zc_avail;
-}
-
 static struct option long_options[] = {
 	{"interface", required_argument, 0, 'i'},
 	{"busy-poll", no_argument, 0, 'b'},
@@ -195,6 +158,9 @@ static struct option long_options[] = {
 	{"dst-ip", required_argument, 0, OPT_DST_IP},
 	{"dst-mac", required_argument, 0, OPT_DST_MAC},
 	{"udp-port", required_argument, 0, OPT_UDP_PORT},
+	{"queue", required_argument, 0, OPT_QUEUE},
+	{"max-frags", required_argument, 0, OPT_MAX_FRAGS},
+	{"timeout", required_argument, 0, OPT_TIMEOUT},
 	{"help", no_argument, 0, 'h'},
 	{0, 0, 0, 0}
 };
@@ -219,6 +185,9 @@ static void print_usage(char **argv)
 		"      --dst-ip IP      Destination address, of the same family\n"
 		"      --dst-mac MAC    Destination MAC address of the test packets\n"
 		"      --udp-port PORT  UDP destination port, and source port of socket 0\n"
+		"      --queue N        AF_XDP queue to bind (default 0)\n"
+		"      --max-frags N    Fragment limit for TOO_MANY_FRAGS (default by mode)\n"
+		"      --timeout SEC    Traffic and link timeout (default 3)\n"
 		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
@@ -243,6 +212,11 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
 		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
 		ksft_exit_fail();
 	}
+	if (xsk_get_mtu(ifobj->ifname, &ifobj->dev_mtu)) {
+		ksft_print_msg("Error: cannot read MTU of interface %s\n", ifobj->ifname);
+		ksft_exit_fail();
+	}
+	ifobj->orig_mtu = ifobj->dev_mtu;
 }
 
 static void print_tests(void)
@@ -328,6 +302,18 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		case OPT_UDP_PORT:
 			opt_udp_port = strtoul(optarg, NULL, 10);
 			break;
+		case OPT_QUEUE:
+			opt_queue = strtoul(optarg, NULL, 10);
+			break;
+		case OPT_MAX_FRAGS:
+			/* It sizes the packet array of TOO_MANY_FRAGS. */
+			opt_max_frags = strtoul(optarg, NULL, 10);
+			if (opt_max_frags > 0xffff)
+				print_usage(argv);
+			break;
+		case OPT_TIMEOUT:
+			opt_timeout = strtoul(optarg, NULL, 10);
+			break;
 		case 'h':
 		default:
 			print_usage(argv);
@@ -351,7 +337,12 @@ static int run_pkt_test(struct test_spec *test)
 	int ret;
 
 	ret = test->test_func(test);
+	pkt_stream_restore_default(test);
+	return ret;
+}
 
+static void report_pkt_test(struct test_spec *test, int ret)
+{
 	switch (ret) {
 	case TEST_PASS:
 		ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test),
@@ -369,9 +360,6 @@ static int run_pkt_test(struct test_spec *test)
 		ksft_test_result_fail("FAIL: %s %s%s -- Unexpected returned value (%d)\n",
 				      mode_string(test), busy_poll_string(test), test->name, ret);
 	}
-
-	pkt_stream_restore_default(test);
-	return ret;
 }
 
 static bool is_xdp_supported(int ifindex)
@@ -402,12 +390,14 @@ static bool is_xdp_supported(int ifindex)
 	return true;
 }
 
+/* Probe only the mode that the endpoint runs in. */
 static u32 detect_mode_caps(struct ifobject *ifobj)
 {
-	if (is_xdp_supported(ifobj->ifindex)) {
+	if (opt_mode == TEST_MODE_ZC && ifobj_has_cap(ifobj, XSK_CAP_ZC_ADVERTISED)) {
+		/* Trust the advertised flag; an XDP_ZEROCOPY bind never falls back to copy. */
+		ifobj_set_cap(ifobj, XSK_CAP_DRV | XSK_CAP_ZC);
+	} else if (opt_mode == TEST_MODE_DRV && is_xdp_supported(ifobj->ifindex)) {
 		ifobj_set_cap(ifobj, XSK_CAP_DRV);
-		if (ifobj_zc_avail(ifobj))
-			ifobj_set_cap(ifobj, XSK_CAP_ZC);
 	}
 
 	return ifobj->caps.flags;
@@ -422,8 +412,10 @@ static bool mode_supported(enum test_mode mode, u32 caps)
 	return caps & XSK_CAP_ZC;
 }
 
-static void cleanup_iface(struct ifobject *ifobj)
+static int cleanup_iface(struct ifobject *ifobj)
 {
+	int err = 0;
+
 	/* A peer shadow has a skeleton but no bound interface. */
 	if (!ifobj_is_local(ifobj))
 		goto unload;
@@ -431,8 +423,16 @@ static void cleanup_iface(struct ifobject *ifobj)
 	if (ifobj->xdp_prog)
 		xsk_detach_xdp_program(ifobj->ifindex,
 				       mode_to_xdp_flags(ifobj->mode));
+	/* After the detach, as an attached program can cap the MTU. */
+	if (ifobj->dev_mtu != ifobj->orig_mtu) {
+		err = xsk_set_mtu(ifobj->ifindex, ifobj->orig_mtu);
+		if (err)
+			ksft_print_msg("Failed to restore MTU %d on %s\n",
+				       ifobj->orig_mtu, ifobj->ifname);
+	}
 unload:
 	xsk_unload_xdp_programs(ifobj);
+	return err;
 }
 
 /* Connect the two endpoints without negotiating the remote NIC's capabilities. */
@@ -469,6 +469,7 @@ int main(int argc, char **argv)
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
 	u32 caps;
+	int err;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -512,6 +513,8 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
+	xsk_set_max_frags(opt_max_frags);
+	xsk_set_timeout(opt_timeout);
 	/* Before the default packet streams, which have its minimum size. */
 	if (xsk_set_flow(opt_src_ip, opt_dst_ip, opt_udp_port))
 		print_usage(argv);
@@ -527,6 +530,7 @@ int main(int argc, char **argv)
 		shadow_ifobj = ifobj_tx;
 	}
 	bind_iface(local_ifobj, opt_ifname, argv);
+	local_ifobj->queue_id = opt_queue;
 	caps = detect_mode_caps(local_ifobj);
 
 	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
@@ -552,8 +556,17 @@ int main(int argc, char **argv)
 
 out:
 	xsk_set_endpoint(NULL);
-	cleanup_iface(ifobj_tx);
-	cleanup_iface(ifobj_rx);
+	err = cleanup_iface(ifobj_tx);
+	err |= cleanup_iface(ifobj_rx);
+	/* xsk.py trusts a passed or skipped endpoint to have undone the MTU. */
+	if (err)
+		ret = TEST_FAILURE;
+	/* After the cleanup, which can still fail a case that ran. */
+	if (test.test_func)
+		report_pkt_test(&test, ret);
+	/* The peer skips the case too, rather than fail on the closed connection. */
+	if (ret == TEST_SKIP)
+		xsk_peer_skip(peer, opt_timeout * 1000);
 	xsk_peer_close(peer);
 	pkt_stream_delete(test.tx_pkt_stream_default);
 	pkt_stream_delete(test.rx_pkt_stream_default);
-- 
2.43.0

