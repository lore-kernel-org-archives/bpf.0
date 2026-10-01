Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABC531626;
	Thu,  1 Oct 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886184; cv=none; b=OFN7nt4KgiiXNJ2woc+pOxGA95XSgrtyNDAJcfVivxVul4DzWaEBFCnT32QPuEp844XnXAX9iOks8z+l+07yuPAxXNJ8nqkQPE8k2YCFpoX3cIRfys7Z1uDeXp+gwYLe6tOAD1BydlBEeO9P8MMllL4718TEnyu6Ddx075lwcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886184; c=relaxed/simple;
	bh=lm2hf+aGnKI8J17ze6ke7FrSYBBdLzmb2TVIirKJc0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nd2qtJzUpzsmp7e2VZ+9b8hs3AB6ARXv/q1uxvsH574UW5tWGWAiYTIiH1yOBFnoF6SQHkzXM1dQyhjYBslxovYMj1d5U0SqaVXj7azBs2ESKfJckSP1nRr12GAjoNDNKLf5KruuKXc7RpRLnBOIszZsyDwlKxCdlObOD5g/EUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt+DLT6S; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt+DLT6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886174; x=1822422174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lm2hf+aGnKI8J17ze6ke7FrSYBBdLzmb2TVIirKJc0M=;
  b=Yt+DLT6Sqi5foaP3HThDiOxDe71ykteEF2kW8wdvXARTNu/y6Af0olGn
   E3VdUrMZgfWzpvPVXZNVI9Ji3SW3azSL3d6H5xaOUbg6sbkcVPFUDOddZ
   dpfFhCBF8Or6Hk3O5ZfLkoDYoz/myEXwXMi96cFAIZqzXsL7nCB6HquzE
   qK1dCHCxVGzqpC3cb9nsKVer2Sk/jYctfB1jkMEGVXf5UVfqgJcg5rcm5
   QA6t/V86JxPCEjy42eTByTeITPuagy5fvKYVOBs6ff9cr4tUlMuhbN87C
   25HGl4xArgcB53sRHw0gS/fa5qrnn1zMXq9bgBvXv3XH6Kpfi8UQs88Eh
   w==;
X-CSE-ConnectionGUID: ReOOQ1O+QhiWeAZxRyIpTw==
X-CSE-MsgGUID: B8gmsG7DTjqeiEY9DxzizA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466840"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466840"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:49 -0700
X-CSE-ConnectionGUID: SwyJ255DRXKsObDyNEU8NA==
X-CSE-MsgGUID: 6JeC6pfrQuCU1/WWt+/GnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636730"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:47 -0700
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
Subject: [PATCH net-next 10/13] selftests: xsk: add a hardware mode to xskxceiver
Date: Thu,  1 Oct 2026 22:21:21 +0200
Message-Id: <20261001202124.692591-11-maciej.fijalkowski@intel.com>
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

drivers/net/hw/xsk.py, added later in this series, runs each hardware
AF_XDP case as a DUT and a remote xskxceiver endpoint over a physical
link. The DUT endpoint uses zero-copy mode and the remote endpoint uses
SKB mode, without negotiating remote capabilities.

xskxceiver gains what such a two-host run needs:

- --hw sends UDP/IPv4 test packets (--udp-src, --udp-dst, --udp-port)
  between the real interface MACs (--peer-mac) over a link that carries
  no other traffic, as the XDP programs redirect every packet;
  XDP_SHARED_UMEM, whose program picks the socket by the synthetic
  destination MAC, skips
- --queue binds a queue other than 0, and --listen makes a hardware
  endpoint listen for its peer instead of connecting and say so on
  stderr once it does
- --max-frags hands both endpoints the DUT limit for TOO_MANY_FRAGS,
  since each side builds the packet stream from its own view of it
- with --hw, zero-copy support is taken from
  NETDEV_XDP_ACT_XSK_ZEROCOPY instead of a trial attach and bind; an
  XDP_ZEROCOPY bind fails rather than falling back to copy mode, so a
  false advertisement still fails the case
- with --hw, an endpoint that only transmits skips the XDP program
  unless it runs in zero-copy mode, where a driver can require one for
  TX wakeups
- the RX and TX loops of hardware cases time out after 20s
  (HW_THREAD_TMOUT) instead of 3s
- a hardware endpoint prints no KTAP output of its own and reports
  through its exit code, as xsk.py reports the case

Skip hw_ring_size_reset() when the rings are already at their defaults.
cleanup_iface() restores the rings after every case on both hosts, and
the SIOCETHTOOL path passes such no-op requests on to the driver.
cleanup_iface() also puts back the MTU that bind_iface() found, so a
case does not leave its MTU to the next case or to the user. It does
so after detaching the XDP program, which can cap the MTU, and fails
the endpoint if it cannot. As an MTU change can reset the NIC, a
hardware endpoint in SKB mode only raises its MTU when a case needs a
larger one, which generic XDP allows, so a jumbo-MTU peer is not reset
twice for every case.

is_frag_valid() now takes the header size from pkt_hdr_size instead of
the fixed PKT_HDR_SIZE. Guard both reads it makes off that variable
length: a first fragment shorter than the header plus one word, or a
later fragment shorter than one word, must be rejected as invalid
instead of reading past the end of the buffer.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 167 +++++++++++++++---
 .../testing/selftests/net/lib/xsk/test_xsk.h  |  10 +-
 tools/testing/selftests/net/lib/xsk/xsk.c     |  37 ++++
 tools/testing/selftests/net/lib/xsk/xsk.h     |   2 +
 .../testing/selftests/net/lib/xsk/xsk_peer.c  |   5 +
 .../selftests/net/lib/xsk/xskxceiver.c        | 155 ++++++++++++++--
 6 files changed, 333 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index b6cfdefb7a18..3e2ca21bdb99 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -6,6 +6,8 @@
 #include <linux/if_link.h>
 #include <linux/mman.h>
 #include <linux/netdev.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
 #include <poll.h>
 #include <string.h>
 #include <sys/mman.h>
@@ -27,8 +29,11 @@
 #define PKT_DUMP_NB_TO_PRINT		16
 /* Just to align the data in the packet */
 #define PKT_HDR_SIZE			(sizeof(struct ethhdr) + 2)
+#define UDP_PKT_HDR_SIZE		(sizeof(struct ethhdr) + sizeof(struct iphdr) + \
+				 sizeof(struct udphdr) + 2)
 #define POLL_TMOUT			1000
 #define THREAD_TMOUT			3
+#define HW_THREAD_TMOUT		20
 #define UMEM_HEADROOM_TEST_SIZE		128
 #define XSK_DESC__INVALID_OPTION	(0xffff)
 #define XSK_UMEM__INVALID_FRAME_SIZE	(MAX_ETH_JUMBO_SIZE + 1)
@@ -36,15 +41,23 @@
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
 
 static const u8 g_mac[ETH_ALEN] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
+static bool udp_packets;
+static struct in_addr udp_src_ip;
+static struct in_addr udp_dst_ip;
+static u16 udp_port;
+static u32 pkt_hdr_size = PKT_HDR_SIZE;
+static u32 max_frags_override;
 
 bool opt_verbose;
 
 int pkts_in_flight;
 static struct xsk_peer *ctrl_peer;
+static bool hw_test;
 
-void xsk_set_endpoint(struct xsk_peer *peer)
+void xsk_set_endpoint(struct xsk_peer *peer, bool hardware)
 {
 	ctrl_peer = peer;
+	hw_test = hardware;
 }
 
 static int pacing_rx_progress(u32 pkts)
@@ -84,11 +97,70 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
 		ptr[i] = htonl(pkt_nb << 16 | (i + start));
 }
 
-static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
+int xsk_set_udp_packet_format(const char *src_ip, const char *dst_ip, u16 port)
 {
+	if (inet_pton(AF_INET, src_ip, &udp_src_ip) != 1 ||
+	    inet_pton(AF_INET, dst_ip, &udp_dst_ip) != 1 || !port)
+		return -EINVAL;
+	udp_packets = true;
+	udp_port = port;
+	pkt_hdr_size = UDP_PKT_HDR_SIZE;
+	return 0;
+}
+
+void xsk_set_max_frags(u32 max_frags)
+{
+	max_frags_override = max_frags;
+}
+
+static u16 ip_checksum(const void *buf, size_t len)
+{
+	const u16 *word = buf;
+	u32 sum = 0;
+
+	while (len > 1) {
+		sum += *word++;
+		len -= sizeof(*word);
+	}
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+	return ~sum;
+}
+
+static void gen_pkt_hdr(struct xsk_socket_info *xsk, void *data, u32 total_len)
+{
+	struct ethhdr *eth_hdr = data;
+	struct udphdr udp = {
+		.source = htons(udp_port),
+		.dest = htons(udp_port),
+		.len = htons(total_len - sizeof(*eth_hdr) -
+			     sizeof(struct iphdr)),
+	};
+	struct iphdr ip = {
+		.version = 4,
+		.ihl = 5,
+		.ttl = 64,
+		.protocol = IPPROTO_UDP,
+		.tot_len = htons(total_len - sizeof(*eth_hdr)),
+		.saddr = udp_src_ip.s_addr,
+		.daddr = udp_dst_ip.s_addr,
+	};
+	u8 *ptr = data;
+
 	memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
 	memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
-	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
+	if (!udp_packets) {
+		eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
+		return;
+	}
+
+	eth_hdr->h_proto = htons(ETH_P_IP);
+	ip.check = ip_checksum(&ip, sizeof(ip));
+	ptr += sizeof(*eth_hdr);
+	memcpy(ptr, &ip, sizeof(ip));
+	ptr += sizeof(ip);
+	memcpy(ptr, &udp, sizeof(udp));
+	memset(ptr + sizeof(udp), 0, 2);
 }
 
 static u32 mode_to_xdp_flags(enum test_mode mode)
@@ -193,7 +265,8 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, ifobject->queue_id,
+				  umem->umem, rxr, txr, &cfg);
 }
 
 static int set_ring_size(struct ifobject *ifobj)
@@ -218,6 +291,10 @@ static int set_ring_size(struct ifobject *ifobj)
 
 int hw_ring_size_reset(struct ifobject *ifobj)
 {
+	if (ifobj->ring.tx_pending == ifobj->set_ring.default_tx &&
+	    ifobj->ring.rx_pending == ifobj->set_ring.default_rx)
+		return 0;
+
 	ifobj->ring.tx_pending = ifobj->set_ring.default_tx;
 	ifobj->ring.rx_pending = ifobj->set_ring.default_rx;
 	return set_ring_size(ifobj);
@@ -230,6 +307,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
+		struct ifobject *peer = i ? ifobj_tx : ifobj_rx;
 		struct xsk_umem_info *umem;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
@@ -261,10 +339,15 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			else
 				xsk->pkt_stream = test->rx_pkt_stream_default;
 
-			memcpy(xsk->src_mac, g_mac, ETH_ALEN);
-			memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
-			xsk->src_mac[5] += ((j * 2) + 0);
-			xsk->dst_mac[5] += ((j * 2) + 1);
+			if (hw_test) {
+				memcpy(xsk->src_mac, ifobj->caps.mac, ETH_ALEN);
+				memcpy(xsk->dst_mac, peer->caps.mac, ETH_ALEN);
+			} else {
+				memcpy(xsk->src_mac, g_mac, ETH_ALEN);
+				memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
+				xsk->src_mac[5] += ((j * 2) + 0);
+				xsk->dst_mac[5] += ((j * 2) + 1);
+			}
 		}
 
 		ifobj->xsk->umem->num_frames = DEFAULT_UMEM_BUFFERS;
@@ -347,14 +430,25 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
 	test->xskmap_tx = xskmap_tx;
 }
 
-static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
+/* An MTU change can reset a NIC. A hardware SKB-mode endpoint runs a case at
+ * any larger MTU, as generic XDP does not limit it, so only raise its MTU.
+ */
+static bool mtu_change_needed(struct ifobject *ifobj, enum test_mode mode, int mtu)
+{
+	if (hw_test && mode == TEST_MODE_SKB)
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
@@ -365,11 +459,11 @@ static int test_spec_set_mtu(struct test_spec *test, int mtu)
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
@@ -654,7 +748,7 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 }
 
 static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
-			 u32 pkt_nb, u32 bytes_written)
+			 u32 total_len, u32 pkt_nb, u32 bytes_written)
 {
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 
@@ -662,12 +756,12 @@ static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 		return;
 
 	if (!bytes_written) {
-		gen_eth_hdr(xsk, data);
+		gen_pkt_hdr(xsk, data, total_len);
 
-		len -= PKT_HDR_SIZE;
-		data += PKT_HDR_SIZE;
+		len -= pkt_hdr_size;
+		data += pkt_hdr_size;
 	} else {
-		bytes_written -= PKT_HDR_SIZE;
+		bytes_written -= pkt_hdr_size;
 	}
 
 	write_payload(data, pkt_nb, bytes_written, len);
@@ -770,7 +864,7 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 		for (i = 0; i < ETH_ALEN; i++)
 			ksft_print_msg("%02X", ethhdr->h_source[i]);
 
-		data = pkt + PKT_HDR_SIZE;
+		data = pkt + pkt_hdr_size;
 	} else {
 		data = pkt;
 	}
@@ -867,11 +961,15 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	pkt_data = data;
 	if (!bytes_processed) {
-		pkt_data += PKT_HDR_SIZE / sizeof(*pkt_data);
-		len -= PKT_HDR_SIZE;
+		if (len < pkt_hdr_size + sizeof(*pkt_data))
+			return false;
+		pkt_data += pkt_hdr_size / sizeof(*pkt_data);
+		len -= pkt_hdr_size;
 	} else {
-		bytes_processed -= PKT_HDR_SIZE;
+		bytes_processed -= pkt_hdr_size;
 	}
+	if (len < sizeof(*pkt_data))
+		return false;
 
 	expected_seqnum = bytes_processed / sizeof(*pkt_data);
 	seqnum = ntohl(*pkt_data) & 0xffff;
@@ -1151,7 +1249,7 @@ bool all_packets_received(struct test_spec *test, struct xsk_socket_info *xsk, u
 
 static int receive_pkts(struct test_spec *test)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {hw_test ? HW_THREAD_TMOUT : THREAD_TMOUT, 0};
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	struct xsk_socket_info *xsk;
 	u32 sock_num = 0;
@@ -1268,8 +1366,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
-					     bytes_written);
+				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->len,
+					     pkt->pkt_nb, bytes_written);
 			bytes_written += tx_desc->len;
 
 			print_verbose("Tx addr: %llx len: %u options: %u pkt_nb: %u\n",
@@ -1316,7 +1414,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {hw_test ? HW_THREAD_TMOUT : THREAD_TMOUT, 0};
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1799,6 +1897,10 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
 		return 0;
 
+	/* A ZC driver can require XDP to be enabled for TX wakeups. */
+	if (hw_test && !ifobj_tx->rx_on && test->mode != TEST_MODE_ZC)
+		return 0;
+
 	if (xdp_prog_changed_tx(test))
 		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
 
@@ -2223,6 +2325,10 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
 	int ret;
 
+	/* The XDP program picks the socket from the synthetic destination MAC. */
+	if (hw_test)
+		return TEST_SKIP;
+
 	test->total_steps = 1;
 	test->nb_sockets = 2;
 
@@ -2265,7 +2371,9 @@ int testapp_too_many_frags(struct test_spec *test)
 	u32 max_frags, i;
 	int ret = TEST_FAILURE;
 
-	if (test->mode == TEST_MODE_ZC) {
+	if (max_frags_override) {
+		max_frags = max_frags_override;
+	} else if (test->mode == TEST_MODE_ZC) {
 		max_frags = xsk_get_cap(test, xdp_zc_max_segs);
 	} else {
 		max_frags = xsk_get_cap(test, max_skb_frags);
@@ -2359,6 +2467,7 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
+		ifobj_set_cap(ifobj, XSK_CAP_ZC_ADVERTISED);
 		if (query_opts.xdp_zc_max_segs > 1) {
 			ifobj_set_cap(ifobj, XSK_CAP_MBUF_ZC);
 			ifobj->caps.xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
@@ -2387,6 +2496,12 @@ int init_iface(struct ifobject *ifobj)
 		return err;
 	}
 
+	err = xsk_get_mac(ifobj->ifname, ifobj->caps.mac);
+	if (err) {
+		ksft_print_msg("Error reading interface MAC address\n");
+		return err;
+	}
+
 	return detect_ifobj_caps(ifobj);
 }
 
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 53e5032510a0..c37423030eb6 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -82,7 +82,9 @@ typedef int (*test_func_t)(struct test_spec *test);
 struct xsk_peer;
 
 /* The control channel to the other endpoint. */
-void xsk_set_endpoint(struct xsk_peer *peer);
+void xsk_set_endpoint(struct xsk_peer *peer, bool hw_test);
+int xsk_set_udp_packet_format(const char *src_ip, const char *dst_ip, u16 port);
+void xsk_set_max_frags(u32 max_frags);
 
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
@@ -129,6 +131,7 @@ int hw_ring_size_reset(struct ifobject *ifobj);
 #define XSK_CAP_HW_RING          (1U << 3)
 #define XSK_CAP_DRV              (1U << 4)
 #define XSK_CAP_ZC               (1U << 5)
+#define XSK_CAP_ZC_ADVERTISED    (1U << 6)
 
 struct xsk_caps {
 	u32 flags;
@@ -136,6 +139,7 @@ struct xsk_caps {
 	u32 max_skb_frags;
 	u32 umem_tailroom;
 	u32 tx_max_pending;
+	u8 mac[ETH_ALEN];
 };
 
 struct ifobject {
@@ -152,7 +156,11 @@ struct ifobject {
 	struct set_hw_ring set_ring;
 	enum test_mode mode;
 	int ifindex;
+	u32 queue_id;
 	int mtu;
+	/* Above mtu when a hardware SKB-mode endpoint keeps a larger MTU. */
+	int dev_mtu;
+	int orig_mtu;
 	u32 bind_flags;
 	bool tx_on;
 	bool rx_on;
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
index 6bd32caf5d08..bd2ef3ee9124 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -826,3 +826,40 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	close(sockfd);
 	return 0;
 }
+
+static int xsk_ifreq_ioctl(const char *ifname, unsigned long req, struct ifreq *ifr)
+{
+	int fd, err = 0;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	strncpy(ifr->ifr_name, ifname, sizeof(ifr->ifr_name) - 1);
+	if (ioctl(fd, req, ifr) < 0)
+		err = -errno;
+	close(fd);
+	return err;
+}
+
+int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN])
+{
+	struct ifreq ifr = {};
+	int err;
+
+	err = xsk_ifreq_ioctl(ifname, SIOCGIFHWADDR, &ifr);
+	if (!err)
+		memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
+	return err;
+}
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
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.h b/tools/testing/selftests/net/lib/xsk/xsk.h
index 3f1fea999763..c09ddbc38db9 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -245,6 +245,8 @@ int xsk_set_mtu(int ifindex, int mtu);
 
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN]);
+int xsk_get_mtu(const char *ifname, int *mtu);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
index 4cc5f3542e55..1228dc01f85c 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_peer.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
@@ -4,6 +4,7 @@
 #include <netdb.h>
 #include <netinet/tcp.h>
 #include <poll.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/socket.h>
 #include <unistd.h>
@@ -191,6 +192,9 @@ static int accept_tmout(int lfd)
  * The launcher starts the listener and waits for its port before starting
  * the connector, so connect() needs no retry. accept() is bounded in case
  * the connector exits before it gets that far.
+ *
+ * The listener also says on stderr when it listens, so that a launcher can
+ * wait for that line instead of polling for the port over SSH.
  */
 static int peer_open_tcp(const char *host, const char *port, bool listen_side)
 {
@@ -211,6 +215,7 @@ static int peer_open_tcp(const char *host, const char *port, bool listen_side)
 			continue;
 		setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
 		if (!bind(lfd, ai->ai_addr, ai->ai_addrlen) && !listen(lfd, 1)) {
+			fprintf(stderr, "Listening for XSK peer on port %s\n", port);
 			fd = accept_tmout(lfd);
 			saved = errno;
 			close(lfd);
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index e66625810a9d..8b94dc3709ea 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -55,6 +55,9 @@
  *    l. If multi-buffer is supported, try various nasty combinations of descriptors to
  *       check if they pass the validation or not
  *
+ * drivers/net/hw/xsk.py runs the hardware cases on a physical device in
+ * zero-copy mode, with an SKB-mode peer on a remote host.
+ *
  * Flow:
  * -----
  * - test_xsk.sh starts two processes: Tx and Rx
@@ -85,6 +88,7 @@
 #include <linux/align.h>
 #include <arpa/inet.h>
 #include <net/if.h>
+#include <netinet/ether.h>
 #include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -112,9 +116,29 @@ enum xsk_endpoint_role {
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
 static enum xsk_endpoint_role opt_endpoint_role = XSK_ENDPOINT_NONE;
+static bool opt_hw;
+static bool opt_listen;
 static const char *opt_peer_host;
 static const char *opt_peer_port;
 static const char *opt_ifname;
+static const char *opt_udp_src;
+static const char *opt_udp_dst;
+static const struct ether_addr *opt_peer_mac;
+static struct ether_addr peer_mac;
+static u16 opt_udp_port;
+static u32 opt_queue;
+static u32 opt_max_frags;
+
+enum {
+	OPT_HW = 256,
+	OPT_LISTEN,
+	OPT_UDP_SRC,
+	OPT_UDP_DST,
+	OPT_UDP_PORT,
+	OPT_PEER_MAC,
+	OPT_QUEUE,
+	OPT_MAX_FRAGS,
+};
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
@@ -178,6 +202,14 @@ static struct option long_options[] = {
 	{"endpoint", required_argument, 0, 'e'},
 	{"peer", required_argument, 0, 'p'},
 	{"peer-port", required_argument, 0, 'P'},
+	{"hw", no_argument, 0, OPT_HW},
+	{"listen", no_argument, 0, OPT_LISTEN},
+	{"udp-src", required_argument, 0, OPT_UDP_SRC},
+	{"udp-dst", required_argument, 0, OPT_UDP_DST},
+	{"udp-port", required_argument, 0, OPT_UDP_PORT},
+	{"peer-mac", required_argument, 0, OPT_PEER_MAC},
+	{"queue", required_argument, 0, OPT_QUEUE},
+	{"max-frags", required_argument, 0, OPT_MAX_FRAGS},
 	{"help", no_argument, 0, 'h'},
 	{0, 0, 0, 0}
 };
@@ -196,6 +228,14 @@ static void print_usage(char **argv)
 		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
 		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
 		"  -P, --peer-port      Control TCP port (1-65535)\n"
+		"      --listen         Listen instead of connecting (hardware peer)\n"
+		"      --hw             One physical-link case, controlled by xsk.py\n"
+		"      --udp-src IP     IPv4 source address for test packets\n"
+		"      --udp-dst IP     IPv4 destination address for test packets\n"
+		"      --udp-port PORT  UDP source and destination port\n"
+		"      --peer-mac MAC   Remote interface MAC address\n"
+		"      --queue N        AF_XDP queue to bind (default 0)\n"
+		"      --max-frags N    Fragment limit selected by the hardware runner\n"
 		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
@@ -220,6 +260,12 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
 		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
 		ksft_exit_fail();
 	}
+	if (xsk_get_mtu(ifobj->ifname, &ifobj->mtu)) {
+		ksft_print_msg("Error: cannot read MTU of interface %s\n", ifobj->ifname);
+		ksft_exit_fail();
+	}
+	ifobj->dev_mtu = ifobj->mtu;
+	ifobj->orig_mtu = ifobj->mtu;
 }
 
 static void print_tests(void)
@@ -231,6 +277,18 @@ static void print_tests(void)
 		printf("%u: %s\n", i, tests[i].name);
 }
 
+static u32 parse_u32(const char *arg, u32 min, u32 max, char **argv)
+{
+	unsigned long val;
+	char *end;
+
+	errno = 0;
+	val = strtoul(arg, &end, 10);
+	if (arg[0] < '0' || arg[0] > '9' || errno || *end || val < min || val > max)
+		print_usage(argv);
+	return val;
+}
+
 static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx, int argc,
 			       char **argv)
 {
@@ -288,6 +346,32 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		case 'P':
 			opt_peer_port = optarg;
 			break;
+		case OPT_HW:
+			opt_hw = true;
+			break;
+		case OPT_LISTEN:
+			opt_listen = true;
+			break;
+		case OPT_UDP_SRC:
+			opt_udp_src = optarg;
+			break;
+		case OPT_UDP_DST:
+			opt_udp_dst = optarg;
+			break;
+		case OPT_UDP_PORT:
+			opt_udp_port = parse_u32(optarg, 1, UINT16_MAX, argv);
+			break;
+		case OPT_PEER_MAC:
+			opt_peer_mac = ether_aton_r(optarg, &peer_mac);
+			if (!opt_peer_mac)
+				print_usage(argv);
+			break;
+		case OPT_QUEUE:
+			opt_queue = parse_u32(optarg, 0, UINT32_MAX, argv);
+			break;
+		case OPT_MAX_FRAGS:
+			opt_max_frags = parse_u32(optarg, 1, UINT16_MAX, argv);
+			break;
 		case 'h':
 		default:
 			print_usage(argv);
@@ -298,6 +382,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
 	    opt_mode == TEST_MODE_ALL)
 		print_usage(argv);
+	if (opt_hw && (!opt_udp_src || !opt_udp_dst || !opt_udp_port || !opt_peer_mac))
+		print_usage(argv);
+	if ((opt_listen || opt_max_frags) && !opt_hw)
+		print_usage(argv);
 }
 
 static void xsk_unload_xdp_programs(struct ifobject *ifobj)
@@ -305,12 +393,8 @@ static void xsk_unload_xdp_programs(struct ifobject *ifobj)
 	xsk_xdp_progs__destroy(ifobj->xdp_progs);
 }
 
-static int run_pkt_test(struct test_spec *test)
+static void report_pkt_test(struct test_spec *test, int ret)
 {
-	int ret;
-
-	ret = test->test_func(test);
-
 	switch (ret) {
 	case TEST_PASS:
 		ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test),
@@ -328,7 +412,15 @@ static int run_pkt_test(struct test_spec *test)
 		ksft_test_result_fail("FAIL: %s %s%s -- Unexpected returned value (%d)\n",
 				      mode_string(test), busy_poll_string(test), test->name, ret);
 	}
+}
 
+static int run_pkt_test(struct test_spec *test)
+{
+	int ret;
+
+	ret = test->test_func(test);
+	if (!opt_hw)
+		report_pkt_test(test, ret);
 	pkt_stream_restore_default(test);
 	return ret;
 }
@@ -363,7 +455,11 @@ static bool is_xdp_supported(int ifindex)
 
 static u32 detect_mode_caps(struct ifobject *ifobj)
 {
-	if (is_xdp_supported(ifobj->ifindex)) {
+	if (opt_hw && opt_mode == TEST_MODE_ZC &&
+	    ifobj_has_cap(ifobj, XSK_CAP_ZC_ADVERTISED)) {
+		/* Trust the advertised flag; an XDP_ZEROCOPY bind never falls back to copy. */
+		ifobj_set_cap(ifobj, XSK_CAP_DRV | XSK_CAP_ZC);
+	} else if (!opt_hw && is_xdp_supported(ifobj->ifindex)) {
 		ifobj_set_cap(ifobj, XSK_CAP_DRV);
 		if (ifobj_zc_avail(ifobj))
 			ifobj_set_cap(ifobj, XSK_CAP_ZC);
@@ -381,8 +477,10 @@ static bool mode_supported(enum test_mode mode, u32 caps)
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
@@ -393,8 +491,16 @@ static void cleanup_iface(struct ifobject *ifobj)
 		xsk_detach_xdp_program(ifobj->ifindex,
 				       ifobj->mode == TEST_MODE_SKB ?
 				       XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE);
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
@@ -405,8 +511,9 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 	if (xsk_load_xdp_programs(shadow))
 		return TEST_FAILURE;
 
-	/* TX listens and RX connects. */
+	/* Generic TX listens; Python chooses the listener for hardware cases. */
 	*peer = xsk_peer_open(opt_peer_host, opt_peer_port,
+			      opt_hw ? opt_listen :
 			      opt_endpoint_role == XSK_ENDPOINT_TX);
 	if (!*peer) {
 		ksft_print_msg("Failed to connect XSK peer: %s\n", strerror(errno));
@@ -414,7 +521,10 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 	}
 
 	shadow->caps = local->caps;
-	xsk_set_endpoint(*peer);
+	if (opt_hw)
+		memcpy(shadow->caps.mac, opt_peer_mac->ether_addr_octet, ETH_ALEN);
+
+	xsk_set_endpoint(*peer, opt_hw);
 	return TEST_PASS;
 }
 
@@ -429,6 +539,7 @@ int main(int argc, char **argv)
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
 	u32 caps;
+	int err;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -470,6 +581,11 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
+	xsk_set_max_frags(opt_max_frags);
+	if (opt_hw && xsk_set_udp_packet_format(opt_udp_src, opt_udp_dst,
+						opt_udp_port))
+		print_usage(argv);
+
 	/* swap_directions() swaps the workers, so the shadow needs one too. */
 	ifobj_tx->func_ptr = worker_testapp_validate_tx;
 	ifobj_rx->func_ptr = worker_testapp_validate_rx;
@@ -481,6 +597,8 @@ int main(int argc, char **argv)
 		shadow_ifobj = ifobj_tx;
 	}
 	bind_iface(local_ifobj, opt_ifname, argv);
+	local_ifobj->queue_id = opt_queue;
+	/* The zero-copy probe binds to queue_id, so set it first. */
 	caps = detect_mode_caps(local_ifobj);
 
 	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
@@ -501,27 +619,32 @@ int main(int argc, char **argv)
 	}
 
 	/* Line-buffer stdout so verdicts reach a capturing launcher live. */
-	ksft_print_header();
-	ksft_set_plan(1);
+	if (!opt_hw) {
+		ksft_print_header();
+		ksft_set_plan(1);
+	}
 	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, &tests[opt_run_test]);
 	ret = run_pkt_test(&test);
 
 out:
-	xsk_set_endpoint(NULL);
-	cleanup_iface(ifobj_tx);
-	cleanup_iface(ifobj_rx);
+	xsk_set_endpoint(NULL, false);
+	err = cleanup_iface(ifobj_tx);
+	err |= cleanup_iface(ifobj_rx);
+	/* xsk.py trusts a passed or skipped endpoint to have undone the MTU. */
+	if (err)
+		ret = TEST_FAILURE;
 	xsk_peer_close(peer);
 	pkt_stream_delete(test.tx_pkt_stream_default);
 	pkt_stream_delete(test.rx_pkt_stream_default);
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
-	if (ret == TEST_SKIP && ksft_test_num()) {
+	if (ret == TEST_SKIP && !opt_hw && ksft_test_num()) {
 		ksft_print_cnts();
 		return KSFT_SKIP;
 	}
 	if (ret == TEST_SKIP)
-		ksft_exit_skip("mode not supported\n");
+		ksft_exit_skip("mode or test not supported\n");
 	if (ret)
 		ksft_exit_fail();
 	else
-- 
2.43.0

