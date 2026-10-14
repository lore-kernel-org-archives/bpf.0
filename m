Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48D56C63C;
	Wed, 14 Oct 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003573; cv=none; b=Iu0z+AaOaW/+E5F1bw/oIBUQFJUJhsbWxvMi3E9kdIbZCYP4iV4ib8XBzDMzqs+qCHWIXO5iN60Bth8s8zAOY6sjQJ4UksgUVjuYmNP4c9c2/73QDY97ITtveF2VP7JcSqECYgFDhU7DK9O2Vk5EhMF78gKyo+umh8aPygRgRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003573; c=relaxed/simple;
	bh=eCTudaPpyQQxeYgPTYX2pMTByjHWok6FgwJETmZlZVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PayAQgj0NJ9S692U22YkQqO+V94sI4ApFx6Z+3Sp7ZOHlh7fq/6HyhyRNb5pn5KX+5xHTPxuGeFWVkkGgp1sTkp52zqkgpc3aF+rOnnj2JdRVH6hysJzdFQaet9ul1BBG6oodvlBZCGP/Xwjenq4Fz6y3KZV1XsX2G7EnaCoetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHmqFcOF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHmqFcOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003572; x=1823539572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCTudaPpyQQxeYgPTYX2pMTByjHWok6FgwJETmZlZVY=;
  b=UHmqFcOFOGbN3lK8PFCZG1dOdhPzvsDKWxIhPPQx4r9/cvuY3H4gWUZQ
   GlBi/e+TKwlhzH1ie5IyihPTMJesxM2yHdGC9+BMnxMr6N5u1ZwVeD1Z4
   YZNQ8xTEwsd7+jyrYDFBXeBojMF9r9Rcd/UyyojrE2EI/HAvzQNM3s3UG
   2DnNtxmlalIYDhgguXcVfiWKDS9TamGmGEU9+eC8AEfRXkTatGSxRf2WP
   /9nQVDFha7ULirA8y7tl59oGDEZDtMO+WJfbEaa+xteumimGla8FYAzyN
   U+gLEFU8HaAgif7/wISNMKHIx8ZKJRvWOv3FqQMajaYxaQAd2k0E8fPI4
   g==;
X-CSE-ConnectionGUID: D3mqhJPtQK+8n0DUgE+Fsg==
X-CSE-MsgGUID: ZneBqe6VTJm8/cUkPhGJ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767310"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:11 -0700
X-CSE-ConnectionGUID: XbUmMzlNTQSH9iZPIgVtcA==
X-CSE-MsgGUID: MShVzC30TjSqdIo3+JOtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420753"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:09 -0700
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
Subject: [PATCH v3 net-next 07/15] selftests: xsk: collect interface capabilities in struct xsk_caps
Date: Wed, 14 Oct 2026 20:45:31 +0200
Message-Id: <20261014184539.774708-8-maciej.fijalkowski@intel.com>
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

A later patch runs the TX and RX endpoints of a case as separate
processes, possibly on different hosts, each binding only its own
interface. The shared test code still looks at the capabilities of both
ifobjects, e.g. to check both for multi-buffer support or to size the
RX batch from the TX ring limit. As the endpoints do not exchange
capabilities, a process will represent the other side by a shadow
ifobject that mirrors the local ones.

Prepare for that by replacing the per-interface support booleans and
limits in struct ifobject with one struct xsk_caps, so that mirroring
takes a single struct assignment and a capability added later cannot
be left out of the copy. The maximum TX ring size, which comes from the
ethtool ring parameters that a shadow does not mirror, is copied there
too. ifobj_has_cap() and ifobj_set_cap() test and set the flags, and
xsk_get_cap() reads a limit from the TX ifobject, the only one that has
all of them set, as the open-coded reads did.

The unaligned UMEM check now looks at the RX ifobject only: the flag
comes from a huge page probe that does not depend on the interface, and
test_spec_set_unaligned() switches both UMEMs together.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 84 +++++++++++--------
 .../testing/selftests/net/lib/xsk/test_xsk.h  | 34 ++++++--
 .../selftests/net/lib/xsk/xskxceiver.c        | 13 +--
 3 files changed, 81 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index 211b8c150965..8ee4b4f7edd9 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -244,7 +244,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->xsk->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 	}
 
-	if (ifobj_tx->hw_ring_size_supp)
+	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING))
 		hw_ring_size_reset(ifobj_tx);
 
 	test->ifobj_tx = ifobj_tx;
@@ -1774,20 +1774,24 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 				      struct ifobject *ifobj2)
 {
 	pthread_t t0, t1;
+	u32 mbuf_cap;
 	int err;
 
-	if (test->mtu > MAX_ETH_PKT_SIZE) {
-		if (test->mode == TEST_MODE_ZC && (!ifobj1->multi_buff_zc_supp ||
-						   (ifobj2 && !ifobj2->multi_buff_zc_supp))) {
-			ksft_print_msg("Multi buffer for zero-copy not supported.\n");
-			return TEST_SKIP;
-		}
-		if (test->mode != TEST_MODE_ZC && (!ifobj1->multi_buff_supp ||
-						   (ifobj2 && !ifobj2->multi_buff_supp))) {
-			ksft_print_msg("Multi buffer not supported.\n");
-			return TEST_SKIP;
-		}
+	if (test->mtu <= MAX_ETH_PKT_SIZE)
+		goto skip_mbuf_check;
+
+	mbuf_cap = test->mode == TEST_MODE_ZC ? XSK_CAP_MBUF_ZC :
+						XSK_CAP_MBUF;
+
+	if (!ifobj_has_cap(ifobj1, mbuf_cap) ||
+	    (ifobj2 && !ifobj_has_cap(ifobj2, mbuf_cap))) {
+		ksft_print_msg("Multi buffer%s not supported.\n",
+			       mbuf_cap == XSK_CAP_MBUF_ZC ?
+			       " for zero-copy" : "");
+		return TEST_SKIP;
 	}
+
+skip_mbuf_check:
 	err = test_spec_set_mtu(test, test->mtu);
 	if (err) {
 		ksft_print_msg("Error, could not set mtu.\n");
@@ -1852,14 +1856,14 @@ static int testapp_validate_traffic(struct test_spec *test)
 	struct ifobject *ifobj_rx = test->ifobj_rx;
 	struct ifobject *ifobj_tx = test->ifobj_tx;
 
-	if ((ifobj_rx->xsk->umem->unaligned_mode && !ifobj_rx->unaligned_supp) ||
-	    (ifobj_tx->xsk->umem->unaligned_mode && !ifobj_tx->unaligned_supp)) {
+	if (ifobj_rx->xsk->umem->unaligned_mode &&
+	    !ifobj_has_cap(ifobj_rx, XSK_CAP_UNALIGNED)) {
 		ksft_print_msg("No huge pages present.\n");
 		return TEST_SKIP;
 	}
 
 	if (test->set_ring) {
-		if (ifobj_tx->hw_ring_size_supp) {
+		if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING)) {
 			if (set_ring_size(ifobj_tx)) {
 				ksft_print_msg("Failed to change HW ring size.\n");
 				return TEST_FAILURE;
@@ -1965,7 +1969,7 @@ int testapp_headroom(struct test_spec *test)
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
-	u32 umem_tr = test->ifobj_tx->umem_tailroom;
+	u32 umem_tr = xsk_get_cap(test, umem_tailroom);
 
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
@@ -2227,9 +2231,9 @@ int testapp_too_many_frags(struct test_spec *test)
 	int ret = TEST_FAILURE;
 
 	if (test->mode == TEST_MODE_ZC) {
-		max_frags = test->ifobj_tx->xdp_zc_max_segs;
+		max_frags = xsk_get_cap(test, xdp_zc_max_segs);
 	} else {
-		max_frags = test->ifobj_tx->max_skb_frags;
+		max_frags = xsk_get_cap(test, max_skb_frags);
 		max_frags += 1;
 	}
 
@@ -2289,7 +2293,6 @@ static int xsk_load_xdp_programs(struct ifobject *ifobj)
 	return 0;
 }
 
-/* Simple test */
 static bool hugepages_present(void)
 {
 	size_t mmap_sz = 2 * DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
@@ -2305,21 +2308,13 @@ static bool hugepages_present(void)
 	return true;
 }
 
-int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+static int detect_ifobj_caps(struct ifobject *ifobj)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
 
-	ifobj->func_ptr = func_ptr;
-
-	err = xsk_load_xdp_programs(ifobj);
-	if (err) {
-		ksft_print_msg("Error loading XDP program\n");
-		return err;
-	}
-
 	if (hugepages_present())
-		ifobj->unaligned_supp = true;
+		ifobj_set_cap(ifobj, XSK_CAP_UNALIGNED);
 
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
@@ -2327,19 +2322,34 @@ int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 		return err;
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
-		ifobj->multi_buff_supp = true;
+		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
 		if (query_opts.xdp_zc_max_segs > 1) {
-			ifobj->multi_buff_zc_supp = true;
-			ifobj->xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
+			ifobj_set_cap(ifobj, XSK_CAP_MBUF_ZC);
+			ifobj->caps.xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
 		} else {
-			ifobj->xdp_zc_max_segs = 0;
+			ifobj->caps.xdp_zc_max_segs = 0;
 		}
 	}
 
 	return 0;
 }
 
+int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+{
+	int err;
+
+	ifobj->func_ptr = func_ptr;
+
+	err = xsk_load_xdp_programs(ifobj);
+	if (err) {
+		ksft_print_msg("Error loading XDP program\n");
+		return err;
+	}
+
+	return detect_ifobj_caps(ifobj);
+}
+
 int testapp_send_receive(struct test_spec *test)
 {
 	return testapp_validate_traffic(test);
@@ -2449,7 +2459,7 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 
 	test->set_ring = true;
 	test->total_steps = 2;
-	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
+	test->ifobj_tx->ring.tx_pending = xsk_get_cap(test, tx_max_pending);
 	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
 	test->ifobj_rx->xsk->umem->num_frames = max_descs;
 	test->ifobj_rx->xsk->umem->fill_size = max_descs;
@@ -2467,8 +2477,8 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
 	 * updating the Rx HW tail register.
 	 */
-	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
-	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
+	test->ifobj_tx->xsk->batch_size = xsk_get_cap(test, tx_max_pending) - 8;
+	test->ifobj_rx->xsk->batch_size = xsk_get_cap(test, tx_max_pending) - 8;
 	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
 		clean_sockets(test, test->ifobj_tx);
 		clean_sockets(test, test->ifobj_rx);
@@ -2561,7 +2571,7 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
 	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
 		    XSK_UMEM__LARGE_FRAME_SIZE -
 		    XDP_PACKET_HEADROOM -
-		    test->ifobj_tx->umem_tailroom;
+		    xsk_get_cap(test, umem_tailroom);
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 
 	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 0717d855e4df..1d17e214db91 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -119,8 +119,22 @@ struct set_hw_ring {
 
 int hw_ring_size_reset(struct ifobject *ifobj);
 
+#define XSK_CAP_UNALIGNED        (1U << 0)
+#define XSK_CAP_MBUF             (1U << 1)
+#define XSK_CAP_MBUF_ZC          (1U << 2)
+#define XSK_CAP_HW_RING          (1U << 3)
+
+struct xsk_caps {
+	u32 flags;
+	u32 xdp_zc_max_segs;
+	u32 max_skb_frags;
+	u32 umem_tailroom;
+	u32 tx_max_pending;
+};
+
 struct ifobject {
 	char ifname[MAX_INTERFACE_NAME_CHARS];
+	struct xsk_caps caps;
 	struct xsk_socket_info *xsk;
 	struct xsk_socket_info *xsk_arr;
 	thread_func_t func_ptr;
@@ -134,9 +148,6 @@ struct ifobject {
 	int ifindex;
 	int mtu;
 	u32 bind_flags;
-	u32 xdp_zc_max_segs;
-	u32 umem_tailroom;
-	u32 max_skb_frags;
 	bool tx_on;
 	bool rx_on;
 	bool use_poll;
@@ -144,11 +155,20 @@ struct ifobject {
 	bool use_fill_ring;
 	bool release_rx;
 	bool use_metadata;
-	bool unaligned_supp;
-	bool multi_buff_supp;
-	bool multi_buff_zc_supp;
-	bool hw_ring_size_supp;
 };
+
+static inline bool ifobj_has_cap(const struct ifobject *ifobj, u32 cap)
+{
+	return ifobj && (ifobj->caps.flags & cap);
+}
+
+static inline void ifobj_set_cap(struct ifobject *ifobj, u32 cap)
+{
+	ifobj->caps.flags |= cap;
+}
+
+#define xsk_get_cap(test, cap) ((test)->ifobj_tx->caps.cap)
+
 struct ifobject *ifobject_create(void);
 void ifobject_delete(struct ifobject *ifobj);
 int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index f4a2f45a6752..8b3e4d18e982 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -361,15 +361,15 @@ int main(int argc, char **argv)
 		ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
 		max_frags = 17;
 	}
-	ifobj_tx->max_skb_frags = max_frags;
-	ifobj_rx->max_skb_frags = max_frags;
+	ifobj_tx->caps.max_skb_frags = max_frags;
+	ifobj_rx->caps.max_skb_frags = max_frags;
 
 	/* 48 bytes is a part of skb_shared_info w/o frags array;
 	 * 16 bytes is sizeof(skb_frag_t)
 	 */
 	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
-	ifobj_tx->umem_tailroom = umem_tailroom;
-	ifobj_rx->umem_tailroom = umem_tailroom;
+	ifobj_tx->caps.umem_tailroom = umem_tailroom;
+	ifobj_rx->caps.umem_tailroom = umem_tailroom;
 
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
 
@@ -393,7 +393,8 @@ int main(int argc, char **argv)
 
 	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
 	if (!ret) {
-		ifobj_tx->hw_ring_size_supp = true;
+		ifobj_set_cap(ifobj_tx, XSK_CAP_HW_RING);
+		ifobj_tx->caps.tx_max_pending = ifobj_tx->ring.tx_max_pending;
 		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
 		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
 	}
@@ -448,7 +449,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (ifobj_tx->hw_ring_size_supp)
+	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING))
 		hw_ring_size_reset(ifobj_tx);
 
 	pkt_stream_delete(tx_pkt_stream_default);
-- 
2.43.0

