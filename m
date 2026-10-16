Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F9595746;
	Fri, 16 Oct 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172638; cv=none; b=NUQyHPwY9YON92R68CPbqv7QlOgM2s8JXZODPL72ISTm1hng9mFY15/qcjVgt6yRVGxIcpg0aCjQH2tJtikylMdwQ1bBbgMf2hmEQAGoP017k8zss/oDNg0Put90dUcfCvwfLbI7BG2qM1zjlTDWuff83dAqwZXCU/kzSF2liQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172638; c=relaxed/simple;
	bh=G1oIY6Zc8EVHSxIf0jKlB7e8ySMymdnuFpEw4tNH7vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9TJMehC/ph+oZdiM2Ic+rMQL6O1VFFd9vPwFMkbtr+soZ0Ycp+Y0dDyMq4AtqKlobca+V02VLZY4Idv06d7wcB6z4gXKJmJqmIpsUBqKe+dNPnllnZypwTgyr1VBMpkuAM7AUxo6JD6CYi4/zDb7dwMDz/3qs0raCtQIM514Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXphiD0c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXphiD0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172636; x=1823708636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G1oIY6Zc8EVHSxIf0jKlB7e8ySMymdnuFpEw4tNH7vo=;
  b=iXphiD0cSs+dlOT/tKpkbRa5zBwqxnmXj1UxzRyJpik51Coi0sN3YEBh
   91Pys5MVKEzMbFN3ImhGjbnCwVBMBGe+0oP0m0SqsRIfBhziPzqcBIHXi
   VzHu35K+Seygwh34p4zDvesyAZoI7YMIU1dJUiD7QDpf2EVoIPMVLfQuY
   x5m4K3cBiok6LBkIy4gwgQ1HHZ+B+gt3y63m8/mJ+7vUqySm4TIvd+V5z
   o/SEBQB5N+F6iQaVyQyvZoKk0QvUoH4Yt06sq32M2L9OFzpyORt/yUFo+
   ALoXj8B7fLfgDvrUdZ9Ie15JrToYEy+QEvQdoCaQB8DWUbkA/bMzG58PT
   w==;
X-CSE-ConnectionGUID: 8DcUUwK+QzyRLL6yDDgWZg==
X-CSE-MsgGUID: ZniijtLdR0SG4HQSFqDy5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972344"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:43:55 -0700
X-CSE-ConnectionGUID: WMBg8U5dRuC3KNHkURhzIQ==
X-CSE-MsgGUID: J6FR6ljmTrieVn8PqCnfSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425188"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:53 -0700
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
Subject: [PATCH v4 net-next 03/15] selftests: xsk: drop the single-interface loopback mode
Date: Fri, 16 Oct 2026 19:43:26 +0200
Message-Id: <20261016174338.787135-4-maciej.fijalkowski@intel.com>
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

xskxceiver -i ethX -i ethX, used for HW tests, bound both sockets to
queue 0 of one interface, which the kernel only allows with a shared
UMEM. With the endpoints about to become separate processes, they would
have to share the UMEM mapping and the socket fd.

The mode also relied on the interface being set up by hand with a
single queue and promiscuous mode, which does not suit CI. The hardware
test added later in this series steers its traffic with ntuple and RSS
configuration instead.

Remove the shared-UMEM TX setup, the split UMEM addressing and the
POLL_TXQ_FULL workaround it needed, and drop the -i IFACE option of
test_xsk.sh that used it. XDP_SHARED_UMEM (two sockets of one endpoint)
is unaffected.

test_xsk.sh ran HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE only in
this mode, as veth has no ring parameters. xskxceiver resized the rings
for them and restored the sizes it had found only when it exited, so a
killed run left the test sizes behind for the next run to take as the
defaults. Drop the resizing with the mode, and set_hw_ring_size() with
it, as nothing else uses it: the hardware test sizes the rings with
ethtool -G and restores them after each case, however the endpoints
end. Both cases still skip on interfaces without ring parameters, and
HW_SW_MAX_RING_SIZE still reads the maximum TX ring size for its
batches.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c |  24 ---
 tools/testing/selftests/bpf/network_helpers.h |   1 -
 .../selftests/bpf/prog_tests/test_xsk.c       | 162 ++++--------------
 .../selftests/bpf/prog_tests/test_xsk.h       |  12 --
 tools/testing/selftests/bpf/prog_tests/xsk.c  |  12 +-
 tools/testing/selftests/bpf/test_xsk.sh       |  49 ++----
 tools/testing/selftests/bpf/xsk_prereqs.sh    |   7 -
 tools/testing/selftests/bpf/xskxceiver.c      |  13 +-
 8 files changed, 51 insertions(+), 229 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index cdf2d7d3ab32..888f03609175 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -646,30 +646,6 @@ int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	return 0;
 }
 
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_SRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
-
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 75133119c04a..c7c52597c33f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -90,7 +90,6 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 int open_tuntap(const char *dev_name, bool need_mac);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 05457f77ca52..b9126fe66e1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -101,10 +101,6 @@ int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void
 		return ret;
 
 	umem->buffer = buffer;
-	if (ifobj->shared_umem && ifobj->rx_on) {
-		umem->base_addr = umem_size(umem);
-		umem->next_buffer = umem_size(umem);
-	}
 
 	return 0;
 }
@@ -115,8 +111,8 @@ static u64 umem_alloc_buffer(struct xsk_umem_info *umem)
 
 	addr = umem->next_buffer;
 	umem->next_buffer += umem->frame_size;
-	if (umem->next_buffer >= umem->base_addr + umem_size(umem))
-		umem->next_buffer = umem->base_addr;
+	if (umem->next_buffer >= umem_size(umem))
+		umem->next_buffer = 0;
 
 	return addr;
 }
@@ -173,33 +169,6 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
 }
 
-static int set_ring_size(struct ifobject *ifobj)
-{
-	int ret;
-	u32 ctr = 0;
-
-	while (ctr++ < SOCK_RECONF_CTR) {
-		ret = set_hw_ring_size(ifobj->ifname, &ifobj->ring);
-		if (!ret)
-			break;
-
-		/* Retry if it fails */
-		if (ctr >= SOCK_RECONF_CTR || errno != EBUSY)
-			return -errno;
-
-		usleep(USLEEP_MAX);
-	}
-
-	return ret;
-}
-
-int hw_ring_size_reset(struct ifobject *ifobj)
-{
-	ifobj->ring.tx_pending = ifobj->set_ring.default_tx;
-	ifobj->ring.rx_pending = ifobj->set_ring.default_rx;
-	return set_ring_size(ifobj);
-}
-
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
@@ -207,7 +176,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
-		struct xsk_umem_info *umem_real;
+		struct xsk_umem_info *umem;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
 		ifobj->use_poll = false;
@@ -224,16 +193,14 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->tx_on = false;
 		}
 
-		umem_real = ifobj->xsk_arr[0].umem_real;
-		memset(umem_real, 0, sizeof(*umem_real));
+		umem = ifobj->xsk_arr[0].umem;
+		memset(umem, 0, sizeof(*umem));
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			struct xsk_socket_info *xsk = &ifobj->xsk_arr[j];
 
 			memset(xsk, 0, sizeof(*xsk));
 			xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-			if (j == 0)
-				xsk->umem_real = umem_real;
-			xsk->umem = umem_real;
+			xsk->umem = umem;
 			xsk->batch_size = DEFAULT_BATCH_SIZE;
 			if (i == 0)
 				xsk->pkt_stream = test->tx_pkt_stream_default;
@@ -250,16 +217,12 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->xsk->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 	}
 
-	if (ifobj_tx->hw_ring_size_supp)
-		hw_ring_size_reset(ifobj_tx);
-
 	test->ifobj_tx = ifobj_tx;
 	test->ifobj_rx = ifobj_rx;
 	test->current_step = 0;
 	test->total_steps = 1;
 	test->nb_sockets = 1;
 	test->fail = false;
-	test->set_ring = false;
 	test->adjust_tail = false;
 	test->adjust_tail_support = false;
 	test->mtu = MAX_ETH_PKT_SIZE;
@@ -825,8 +788,6 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 	u64 umem_sz = umem_size(umem);
 
-	addr -= umem->base_addr;
-
 	if (addr >= umem_sz || addr + len > umem_sz) {
 		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
@@ -1164,7 +1125,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		       bool test_timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
-	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
+	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
@@ -1468,12 +1429,12 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 }
 
 static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
-			  struct xsk_umem_info *umem, bool tx)
+			  struct xsk_umem_info *umem)
 {
 	int i, ret;
 
 	for (i = 0; i < test->nb_sockets; i++) {
-		bool shared = (ifobject->shared_umem && tx) ? true : !!i;
+		bool shared = !!i;
 		u32 ctr = 0;
 
 		while (ctr++ < SOCK_RECONF_CTR) {
@@ -1497,31 +1458,6 @@ static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 	return 0;
 }
 
-static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
-{
-	struct xsk_umem_info *umem_rx, *umem_tx;
-	int ret;
-
-	if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem->umem) {
-		ksft_print_msg("Error: RX UMEM is not initialized before shared-UMEM TX setup\n");
-		return -EINVAL;
-	}
-
-	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
-	umem_tx = ifobject->xsk_arr[0].umem_real;
-	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
-	umem_tx->base_addr = 0;
-	umem_tx->next_buffer = 0;
-
-	ret = xsk_configure(test, ifobject, umem_rx, true);
-	if (ret)
-		return ret;
-	ifobject->xsk = &ifobject->xsk_arr[0];
-	ifobject->xskmap = test->ifobj_rx->xskmap;
-
-	return 0;
-}
-
 static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream,
 				   bool fill_up)
 {
@@ -1547,7 +1483,7 @@ static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 			if (!pkt) {
 				if (!fill_up)
 					break;
-				addr = filled * umem->frame_size + umem->base_addr;
+				addr = filled * umem->frame_size;
 			} else if (pkt->offset >= 0) {
 				addr = pkt->offset % umem->frame_size + umem_alloc_buffer(umem);
 			} else {
@@ -1584,9 +1520,6 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
 
-	if (ifobject->shared_umem)
-		umem_sz *= 2;
-
 	mmap_sz = umem->unaligned_mode ?
 		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
 
@@ -1600,7 +1533,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ret)
 		return ret;
 
-	ret = xsk_configure(test, ifobject, umem, false);
+	ret = xsk_configure(test, ifobject, umem);
 	if (ret)
 		return ret;
 
@@ -1629,10 +1562,7 @@ static int testapp_validate_tx_endpoint(struct test_spec *test,
 	int err;
 
 	if (test->current_step == 1) {
-		if (!ifobject->shared_umem)
-			err = thread_common_ops(test, ifobject);
-		else
-			err = thread_common_ops_tx(test, ifobject);
+		err = thread_common_ops(test, ifobject);
 		if (err)
 			return err;
 	}
@@ -1779,7 +1709,7 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 			return err;
 	}
 
-	if (!ifobj_tx || ifobj_tx->shared_umem)
+	if (!ifobj_tx)
 		return 0;
 
 	if (xdp_prog_changed_tx(test))
@@ -1805,7 +1735,7 @@ static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct i
 		return;
 
 	testapp_clean_xsk_umem(ifobj1);
-	if (ifobj2 && !ifobj2->shared_umem)
+	if (ifobj2)
 		testapp_clean_xsk_umem(ifobj2);
 }
 
@@ -1897,18 +1827,6 @@ static int testapp_validate_traffic(struct test_spec *test)
 		return TEST_SKIP;
 	}
 
-	if (test->set_ring) {
-		if (ifobj_tx->hw_ring_size_supp) {
-			if (set_ring_size(ifobj_tx)) {
-				ksft_print_msg("Failed to change HW ring size.\n");
-				return TEST_FAILURE;
-			}
-		} else {
-			ksft_print_msg("Changing HW ring size not supported.\n");
-			return TEST_SKIP;
-		}
-	}
-
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
 
@@ -2184,12 +2102,6 @@ int testapp_invalid_desc(struct test_spec *test)
 		pkts[8].valid = false;
 	}
 
-	if (test->ifobj_tx->shared_umem) {
-		pkts[4].offset += umem_sz;
-		pkts[5].offset += umem_sz;
-		pkts[6].offset += umem_sz;
-	}
-
 	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2248,28 +2160,14 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
-	bool shared_umem = test->ifobj_tx->shared_umem;
-	int ret;
-
 	test->poll_tmout = true;
-	/*
-	 * POLL_TXQ_FULL exercises TX timeout setup in isolation.
-	 * Keep TX out of shared-UMEM mode here so TX setup does not require
-	 * RX UMEM to be initialized first.
-	 */
-	test->ifobj_tx->shared_umem = false;
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->xsk->umem->frame_size = 2048;
-	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048)) {
-		test->ifobj_tx->shared_umem = shared_umem;
+	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
 		return TEST_FAILURE;
-	}
 
-	ret = testapp_validate_traffic_single_thread(test, test->ifobj_tx);
-	test->ifobj_tx->shared_umem = shared_umem;
-
-	return ret;
+	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
 }
 
 int testapp_poll_rxq_tmout(struct test_spec *test)
@@ -2481,14 +2379,19 @@ int testapp_xdp_metadata_mb(struct test_spec *test)
 	return testapp_xdp_metadata_copy(test);
 }
 
+/* Expects the HW TX ring of the sender to hold DEFAULT_BATCH_SIZE
+ * descriptors.
+ */
 int testapp_hw_sw_min_ring_size(struct test_spec *test)
 {
 	int ret;
 
-	test->set_ring = true;
+	if (!test->ifobj_tx->hw_ring_size_supp) {
+		ksft_print_msg("HW ring sizes not supported.\n");
+		return TEST_SKIP;
+	}
+
 	test->total_steps = 2;
-	test->ifobj_tx->ring.tx_pending = DEFAULT_BATCH_SIZE;
-	test->ifobj_tx->ring.rx_pending = DEFAULT_BATCH_SIZE * 2;
 	test->ifobj_tx->xsk->batch_size = 1;
 	test->ifobj_rx->xsk->batch_size = 1;
 	ret = testapp_validate_traffic(test);
@@ -2501,16 +2404,21 @@ int testapp_hw_sw_min_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+/* Expects the HW TX ring of the sender and the HW RX ring of the receiver
+ * at their maximum sizes.
+ */
 int testapp_hw_sw_max_ring_size(struct test_spec *test)
 {
 	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
 	u32 batch_size;
 	int ret;
 
-	test->set_ring = true;
+	if (!test->ifobj_tx->hw_ring_size_supp) {
+		ksft_print_msg("HW ring sizes not supported.\n");
+		return TEST_SKIP;
+	}
+
 	test->total_steps = 2;
-	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
-	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
 	test->ifobj_rx->xsk->umem->num_frames = max_descs;
 	test->ifobj_rx->xsk->umem->fill_size = max_descs;
 	test->ifobj_rx->xsk->umem->comp_size = max_descs;
@@ -2659,8 +2567,8 @@ struct ifobject *ifobject_create(void)
 	if (!ifobj->xsk_arr)
 		goto out_xsk_arr;
 
-	ifobj->xsk_arr[0].umem_real = calloc(1, sizeof(struct xsk_umem_info));
-	if (!ifobj->xsk_arr[0].umem_real)
+	ifobj->xsk_arr[0].umem = calloc(1, sizeof(struct xsk_umem_info));
+	if (!ifobj->xsk_arr[0].umem)
 		goto out_umem;
 
 	return ifobj;
@@ -2675,7 +2583,7 @@ struct ifobject *ifobject_create(void)
 void ifobject_delete(struct ifobject *ifobj)
 {
 	if (ifobj->xsk_arr)
-		free(ifobj->xsk_arr[0].umem_real);
+		free(ifobj->xsk_arr[0].umem);
 
 	free(ifobj->xsk_arr);
 	free(ifobj);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..33331fbee6f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -83,7 +83,6 @@ typedef int (*test_func_t)(struct test_spec *test);
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
 	struct xsk_ring_prod tx;
-	struct xsk_umem_info *umem_real;
 	struct xsk_umem_info *umem;
 	struct xsk_socket *xsk;
 	struct pkt_stream *pkt_stream;
@@ -108,19 +107,11 @@ struct xsk_umem_info {
 	u32 frame_headroom;
 	void *buffer;
 	u32 frame_size;
-	u32 base_addr;
 	u32 fill_size;
 	u32 comp_size;
 	bool unaligned_mode;
 };
 
-struct set_hw_ring {
-	u32 default_tx;
-	u32 default_rx;
-};
-
-int hw_ring_size_reset(struct ifobject *ifobj);
-
 struct ifobject {
 	char ifname[MAX_INTERFACE_NAME_CHARS];
 	struct xsk_socket_info *xsk;
@@ -131,7 +122,6 @@ struct ifobject {
 	struct bpf_map *xskmap;
 	struct bpf_program *xdp_prog;
 	struct ethtool_ringparam ring;
-	struct set_hw_ring set_ring;
 	enum test_mode mode;
 	int ifindex;
 	int mtu;
@@ -145,7 +135,6 @@ struct ifobject {
 	bool busy_poll;
 	bool use_fill_ring;
 	bool release_rx;
-	bool shared_umem;
 	bool use_metadata;
 	bool unaligned_supp;
 	bool multi_buff_supp;
@@ -204,7 +193,6 @@ struct test_spec {
 	u16 current_step;
 	u16 nb_sockets;
 	bool fail;
-	bool set_ring;
 	bool adjust_tail;
 	bool adjust_tail_support;
 	bool poll_tmout;
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
index 6e2f63ee2a6c..af67e2605818 100644
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -53,10 +53,6 @@ int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
 	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
 		return -1;
 
-	tx->shared_umem = false;
-	rx->shared_umem = false;
-
-
 	return 0;
 }
 
@@ -79,11 +75,8 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 		goto delete_rx;
 
 	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-	if (!ret) {
+	if (!ret)
 		ifobj_tx->hw_ring_size_supp = true;
-		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
-		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
-	}
 
 	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
 	if (!cache_line_size)
@@ -124,9 +117,6 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 		ASSERT_OK(ret, "Run test");
 	pkt_stream_restore_default(&test);
 
-	if (ifobj_tx->hw_ring_size_supp)
-		hw_ring_size_reset(ifobj_tx);
-
 	pkt_stream_delete(test.tx_pkt_stream_default);
 	pkt_stream_delete(test.rx_pkt_stream_default);
 	xsk_xdp_progs__destroy(ifobj_tx->xdp_progs);
diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 62db060298a4..69fac65f073c 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -71,9 +71,6 @@
 # Set up veth interfaces and leave them up so xskxceiver can be launched in a debugger:
 #   sudo ./test_xsk.sh -d
 #
-# Run test suite for physical device in loopback mode
-#   sudo ./test_xsk.sh -i IFACE
-#
 # Run test suite in a specific mode only [skb,drv,zc]
 #   sudo ./test_xsk.sh -m MODE
 #
@@ -88,14 +85,11 @@
 
 . xsk_prereqs.sh
 
-ETH=""
-
-while getopts "vi:dm:lt:h" flag
+while getopts "vdm:lt:h" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		d) debug=1;;
-		i) ETH=${OPTARG};;
 		m) MODE=${OPTARG};;
 		l) list=1;;
 		t) TEST=${OPTARG};;
@@ -157,21 +151,16 @@ if [[ $help -eq 1 ]]; then
         exit
 fi
 
-if [ ! -z $ETH ]; then
-	VETH0=${ETH}
-	VETH1=${ETH}
-else
-	validate_root_exec
-	validate_veth_support ${VETH0}
-	validate_ip_utility
-	setup_vethPairs
-
-	retval=$?
-	if [ $retval -ne 0 ]; then
-		test_status $retval "${TEST_NAME}"
-		cleanup_exit ${VETH0} ${VETH1}
-		exit $retval
-	fi
+validate_root_exec
+validate_veth_support ${VETH0}
+validate_ip_utility
+setup_vethPairs
+
+retval=$?
+if [ $retval -ne 0 ]; then
+	test_status $retval "${TEST_NAME}"
+	cleanup_exit ${VETH0} ${VETH1}
+	exit $retval
 fi
 
 
@@ -203,11 +192,7 @@ fi
 
 exec_xskxceiver
 
-if [ -z $ETH ]; then
-	cleanup_exit ${VETH0} ${VETH1}
-else
-	cleanup_iface ${ETH} ${MTU}
-fi
+cleanup_exit ${VETH0} ${VETH1}
 
 if [[ $list -eq 1 ]]; then
     exit
@@ -216,18 +201,12 @@ fi
 TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
-if [ -z $ETH ]; then
-	setup_vethPairs
-fi
+setup_vethPairs
 exec_xskxceiver
 
 ## END TESTS
 
-if [ -z $ETH ]; then
-	cleanup_exit ${VETH0} ${VETH1}
-else
-	cleanup_iface ${ETH} ${MTU}
-fi
+cleanup_exit ${VETH0} ${VETH1}
 
 failures=0
 echo -e "\nSummary:"
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index 47c7b8064f38..ebff0f95d14b 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -53,13 +53,6 @@ test_exit()
 	exit 1
 }
 
-cleanup_iface()
-{
-	ip link set $1 mtu $2
-	ip link set $1 xdp off
-	ip link set $1 xdpgeneric off
-}
-
 clear_configs()
 {
 	[ $(ip link show $1 &>/dev/null; echo $?;) == 0 ] &&
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..300cb354f421 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -341,7 +341,6 @@ int main(int argc, char **argv)
 	u32 i, j, failed_tests = 0, nb_tests;
 	int modes = TEST_MODE_SKB + 1;
 	struct test_spec test;
-	bool shared_netdev;
 	int ret;
 
 	/* Use libbpf 1.0 API mode */
@@ -388,10 +387,6 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
-	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
-	ifobj_tx->shared_umem = shared_netdev;
-	ifobj_rx->shared_umem = shared_netdev;
-
 	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
 		print_usage(argv);
 
@@ -402,11 +397,8 @@ int main(int argc, char **argv)
 	}
 
 	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-	if (!ret) {
+	if (!ret)
 		ifobj_tx->hw_ring_size_supp = true;
-		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
-		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
-	}
 
 	if (init_iface(ifobj_rx, worker_testapp_validate_rx) ||
 	    init_iface(ifobj_tx, worker_testapp_validate_tx)) {
@@ -462,9 +454,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (ifobj_tx->hw_ring_size_supp)
-		hw_ring_size_reset(ifobj_tx);
-
 	pkt_stream_delete(tx_pkt_stream_default);
 	pkt_stream_delete(rx_pkt_stream_default);
 	xsk_unload_xdp_programs(ifobj_tx);
-- 
2.43.0

