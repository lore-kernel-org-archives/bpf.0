Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E056C64C;
	Wed, 14 Oct 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003585; cv=none; b=KYWfC7lzbKwypn4UgRiesZVBgzX3G8HhjnU5PpfWpIg6BzhlNiTqMxXC0S9e0m7of3jmg3xNyUbBD+5R+Ztnof9IGdx1g3JzXt8YQUYGMhtqcg9vvHxaK0TUoXyJcbLH9d3WVNsdtMYp1dZPLSyOo783Mi2ngirezs5mceZCBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003585; c=relaxed/simple;
	bh=u/Yh1nZw/3yT2aDPenSioinHJ9GAs0Q45Bq29wKfhuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Frs5ZxaLNw/bURLBYoW8Gp3/CK9WzyXCBan/E4MYhRZJ8ILWs0iQ1uVBYqEHmOyeYa6FQDOX3Khzq9fohgYmfg+p1/g91Q5nx5DInRbgOUzXvLkmrspLgUeBNbegrggPGH8/mfy5gwsSoJvOwT02VqRqwRoj7uYMRhgrDVraFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjQFSxyi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjQFSxyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003583; x=1823539583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/Yh1nZw/3yT2aDPenSioinHJ9GAs0Q45Bq29wKfhuk=;
  b=HjQFSxyivRQE8k9JJJ/ImuDPXyh2sXr+sCDrsZen1gtySN7GAzaHcd6I
   PS9Y5tPugiceuquF3XErDm2JC0WAS/QSrM+niXVbKVrboj5hnUC/xdEaO
   t9wkHugP6bbuYXXxkvFVDPuidzZmBZGWWfWuc06kizqvLlabpblgJrqDJ
   qxUVDgOjjFN/sGGPhGb0ruHGBPdROvI21ljwBr/2DTMQ91c6H7gCjSU5v
   64svf/EZc4KpTJoivUWG+n8X0hB5EQ1W7x9RnKVTZ7zMknq/T1EtjPO5A
   CeHcNtnKryRq8nuwmiCQ/llRB5oIqpNMuamYyplPIA16pqvFK7C13hfMw
   Q==;
X-CSE-ConnectionGUID: S2xaMKdWS3eb77GQpe87Ag==
X-CSE-MsgGUID: AkFenKkGTSWv/+oX6fOG2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767347"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:23 -0700
X-CSE-ConnectionGUID: bfu8Ma/jQ+CXfP2ev9QJww==
X-CSE-MsgGUID: uCVTfG+uQB2ogxTQQ8Atxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420819"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:20 -0700
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
Subject: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode to xskxceiver
Date: Wed, 14 Oct 2026 20:45:35 +0200
Message-Id: <20261014184539.774708-12-maciej.fijalkowski@intel.com>
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

drivers/net/hw/xsk.py, added later in this series, runs each hardware
AF_XDP case as a zero-copy DUT endpoint and an SKB-mode remote endpoint
over a physical link, without negotiating capabilities between them.
Add what such a run needs to xskxceiver:

- --hw sends UDP/IPv4 test packets (--udp-src, --udp-dst, --udp-port)
  between the real interface MACs (--peer-mac); XDP_SHARED_UMEM, whose
  program picks the socket by a synthetic destination MAC, skips
- --queue binds a queue other than 0, and --listen makes a hardware
  endpoint listen for its peer instead of connecting
- --max-frags hands both endpoints the DUT limit for TOO_MANY_FRAGS, as
  each side builds the packet stream from its own view of it
- a hardware endpoint probes only the mode it runs in, taking zero-copy
  support from NETDEV_XDP_ACT_XSK_ZEROCOPY, and its XDP_ZEROCOPY bind
  fails rather than falling back to copy mode, so a false advertisement
  still fails the case
- a hardware endpoint that only transmits attaches the XDP program only
  in zero-copy mode, where a driver can require one for TX wakeups
- hardware RX and TX loops time out after 20s instead of 3s, and once
  both endpoints are ready, each waits up to as long for its link, as
  an MTU or XDP change on either host can reset a NIC
- an RX endpoint fills its fill ring before the bind, as a zero-copy
  driver posts its RX buffers then and would otherwise wait for the
  first wakeup, which comes only after READY lets the remote send
- each endpoint sizes the rings of its own interface, as the bursts of
  HW_SW_MAX_RING_SIZE need the largest RX ring on the receiver rather
  than on the TX interface, and leaves alone the rings that a case
  keeps at their defaults, as a driver may reset the NIC even when they
  do not change
- the cases that skip in one mode only (STAT_RX_DROPPED,
  TX_QUEUE_CONSUMER and both XDP_ADJUST_TAIL_GROW cases) skip on both
  hardware endpoints, which run different modes

Cases now default to an MTU of 1500 (ETH_DATA_LEN) rather than the
1518 byte frame size: IFLA_MTU counts the L3 MTU, so the old default
changed a standard MTU, which can reset a NIC, for every case. A
hardware SKB-mode endpoint raises its MTU only when a case needs a
larger one, so a jumbo-MTU peer is not reset twice per case.
cleanup_iface() restores the MTU that bind_iface() found once the XDP
program, which can cap it, is detached, and fails the endpoint if it
cannot, so the result is reported after cleanup_iface(). That MTU
stays out of ifobj->mtu, which would make the zero-copy probe bind
with XDP_USE_SG.

is_frag_valid() now takes the header size from pkt_hdr_size rather
than PKT_HDR_SIZE and rejects fragments too short for the words it
reads instead of reading past their end. pkt_dump() prints only the
words within the length it is given, which is_pkt_valid() now gives as
the first fragment's length.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 299 ++++++++++++++----
 .../testing/selftests/net/lib/xsk/test_xsk.h  |  10 +-
 tools/testing/selftests/net/lib/xsk/xsk.c     |  60 ++++
 tools/testing/selftests/net/lib/xsk/xsk.h     |   3 +
 .../selftests/net/lib/xsk/xskxceiver.c        | 134 +++++++-
 5 files changed, 432 insertions(+), 74 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index f67a32c0260a..a280956d53f4 100644
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
@@ -84,11 +97,72 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
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
+	const u8 *pos = buf;
+	u32 sum = 0;
+	u16 word;
+
+	/* Copy each word, the header fields are not u16 objects. */
+	for (; len > 1; len -= sizeof(word), pos += sizeof(word)) {
+		memcpy(&word, pos, sizeof(word));
+		sum += word;
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
@@ -193,7 +267,8 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
+	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, ifobject->queue_id,
+				  umem->umem, rxr, txr, &cfg);
 }
 
 static int set_ring_size(struct ifobject *ifobj)
@@ -216,13 +291,18 @@ static int set_ring_size(struct ifobject *ifobj)
 	return ret;
 }
 
+static bool hw_ring_size_changed(const struct ifobject *ifobj)
+{
+	return ifobj->ring.tx_pending != ifobj->set_ring.default_tx ||
+	       ifobj->ring.rx_pending != ifobj->set_ring.default_rx;
+}
+
 int hw_ring_size_reset(struct ifobject *ifobj)
 {
 	struct ethtool_ringparam ring = ifobj->ring;
 	int err;
 
-	if (ring.tx_pending == ifobj->set_ring.default_tx &&
-	    ring.rx_pending == ifobj->set_ring.default_rx)
+	if (!hw_ring_size_changed(ifobj))
 		return 0;
 
 	ifobj->ring.tx_pending = ifobj->set_ring.default_tx;
@@ -242,6 +322,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
+		struct ifobject *peer = i ? ifobj_tx : ifobj_rx;
 		struct xsk_umem_info *umem;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
@@ -273,19 +354,24 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
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
 		ifobj->xsk->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-	}
 
-	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING) &&
-	    ifobj_is_local(ifobj_tx))
-		hw_ring_size_reset(ifobj_tx);
+		if (ifobj_is_local(ifobj) &&
+		    ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
+			hw_ring_size_reset(ifobj);
+	}
 
 	test->ifobj_tx = ifobj_tx;
 	test->ifobj_rx = ifobj_rx;
@@ -295,7 +381,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->set_ring = false;
 	test->adjust_tail = false;
 	test->adjust_tail_support = false;
-	test->mtu = MAX_ETH_PKT_SIZE;
+	test->mtu = ETH_DATA_LEN;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
 	test->xdp_prog_tx = ifobj_tx->xdp_progs->progs.xsk_def_prog;
@@ -359,14 +445,25 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
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
@@ -377,11 +474,11 @@ static int test_spec_set_mtu(struct test_spec *test, int mtu)
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
@@ -482,6 +579,19 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	return nb_frags;
 }
 
+/* A verbatim stream has one entry per descriptor, so add up the packet's. */
+static u32 pkt_total_len(struct pkt_stream *pkt_stream, struct pkt *pkt, u32 nb_frags)
+{
+	u32 i, len = 0;
+
+	if (!pkt_stream->verbatim)
+		return pkt->len;
+
+	for (i = 0; i < nb_frags; i++)
+		len += pkt[i].len;
+	return len;
+}
+
 static bool set_pkt_valid(int offset, u32 len)
 {
 	return len <= MAX_ETH_JUMBO_SIZE;
@@ -666,7 +776,7 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 }
 
 static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
-			 u32 pkt_nb, u32 bytes_written)
+			 u32 total_len, u32 pkt_nb, u32 bytes_written)
 {
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 
@@ -674,12 +784,12 @@ static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
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
@@ -767,10 +877,11 @@ static void pkt_print_data(u32 *data, u32 cnt)
 	}
 }
 
+/* With eth_header, len counts the bytes after the test header. */
 static void pkt_dump(void *pkt, u32 len, bool eth_header)
 {
 	struct ethhdr *ethhdr = pkt;
-	u32 i, *data;
+	u32 i, words, *data;
 
 	if (eth_header) {
 		/*extract L2 frame */
@@ -782,18 +893,19 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 		for (i = 0; i < ETH_ALEN; i++)
 			ksft_print_msg("%02X", ethhdr->h_source[i]);
 
-		data = pkt + PKT_HDR_SIZE;
+		data = pkt + pkt_hdr_size;
 	} else {
 		data = pkt;
 	}
 
 	/*extract L5 frame */
+	words = len / sizeof(u32);
 	ksft_print_msg("\nDEBUG>> L5: seqnum: ");
-	pkt_print_data(data, PKT_DUMP_NB_TO_PRINT);
+	pkt_print_data(data, min_t(u32, words, PKT_DUMP_NB_TO_PRINT));
 	ksft_print_msg("....");
-	if (len > PKT_DUMP_NB_TO_PRINT * sizeof(u32)) {
+	if (words > PKT_DUMP_NB_TO_PRINT) {
 		ksft_print_msg("\n.... ");
-		pkt_print_data(data + len / sizeof(u32) - PKT_DUMP_NB_TO_PRINT,
+		pkt_print_data(data + words - PKT_DUMP_NB_TO_PRINT,
 			       PKT_DUMP_NB_TO_PRINT);
 	}
 	ksft_print_msg("\n---------------------------------------\n");
@@ -879,11 +991,15 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
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
@@ -917,12 +1033,13 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 	return false;
 }
 
-static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
+static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 frag_len, u32 len)
 {
 	if (pkt->len != len) {
 		ksft_print_msg("[%s] expected packet length [%d], got length [%d]\n",
 			       __func__, pkt->len, len);
-		pkt_dump(xsk_umem__get_data(buffer, addr), len, true);
+		/* Only the first fragment, which holds the header, is at addr. */
+		pkt_dump(xsk_umem__get_data(buffer, addr), frag_len - pkt_hdr_size, true);
 		return false;
 	}
 
@@ -1020,7 +1137,7 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
 static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 {
-	u32 frags_processed = 0, nb_frags = 0, pkt_len = 0;
+	u32 frags_processed = 0, nb_frags = 0, pkt_len = 0, first_len = 0;
 	u32 idx_rx = 0, idx_fq = 0, rcvd, pkts_sent = 0;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	struct ifobject *ifobj = test->ifobj_rx;
@@ -1097,8 +1214,10 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 		    !is_metadata_correct(pkt, umem->buffer, addr)))
 			return TEST_FAILURE;
 
-		if (!nb_frags++)
+		if (!nb_frags++) {
 			first_addr = addr;
+			first_len = desc->len;
+		}
 		frags_processed++;
 		pkt_len += desc->len;
 		if (ifobj->use_fill_ring)
@@ -1108,7 +1227,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			continue;
 
 		/* The complete packet has been received */
-		if (!is_pkt_valid(pkt, umem->buffer, first_addr, pkt_len) ||
+		if (!is_pkt_valid(pkt, umem->buffer, first_addr, first_len, pkt_len) ||
 		    !is_offset_correct(umem, pkt, addr))
 			return TEST_FAILURE;
 
@@ -1163,7 +1282,7 @@ bool all_packets_received(struct test_spec *test, struct xsk_socket_info *xsk, u
 
 static int receive_pkts(struct test_spec *test)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {hw_test ? HW_THREAD_TMOUT : THREAD_TMOUT, 0};
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	struct xsk_socket_info *xsk;
 	u32 sock_num = 0;
@@ -1258,7 +1377,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 
 	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
-		u32 nb_frags_left, nb_frags, bytes_written = 0;
+		u32 nb_frags_left, nb_frags, total_len, bytes_written = 0;
 
 		if (!pkt)
 			break;
@@ -1270,6 +1389,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 			break;
 		}
 		nb_frags_left = nb_frags;
+		total_len = pkt_total_len(pkt_stream, pkt, nb_frags);
 
 		while (nb_frags_left--) {
 			struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
@@ -1286,8 +1406,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
-					     bytes_written);
+				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, total_len,
+					     pkt->pkt_nb, bytes_written);
 			bytes_written += tx_desc->len;
 
 			print_verbose("Tx addr: %llx len: %u options: %u pkt_nb: %u\n",
@@ -1334,7 +1454,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {hw_test ? HW_THREAD_TMOUT : THREAD_TMOUT, 0};
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1617,20 +1737,26 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
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
@@ -1703,14 +1829,36 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
 	return err;
 }
 
+/* An MTU or XDP change can reset a NIC, which takes the link down on both
+ * hosts. Each endpoint makes its changes before it is ready, so once both are,
+ * wait for the local link before any traffic.
+ */
+static int wait_link_up(struct test_spec *test)
+{
+	struct ifobject *ifobj = test->ifobj_tx;
+	int err;
+
+	if (!ifobj_is_local(ifobj))
+		ifobj = test->ifobj_rx;
+	err = xsk_wait_link_up(ifobj->ifname, HW_THREAD_TMOUT * 1000);
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
+	if (err) {
 		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
 			       test->current_step, err, strerror(-err));
-	return err;
+		return err;
+	}
+	return hw_test ? wait_link_up(test) : 0;
 }
 
 int worker_testapp_validate_tx(struct test_spec *test)
@@ -1817,6 +1965,10 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
 		return 0;
 
+	/* A ZC driver can require XDP to be enabled for TX wakeups. */
+	if (hw_test && !ifobj_tx->rx_on && test->mode != TEST_MODE_ZC)
+		return 0;
+
 	if (xdp_prog_changed_tx(test))
 		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
 
@@ -1905,6 +2057,7 @@ static int testapp_validate_traffic(struct test_spec *test)
 {
 	struct ifobject *ifobj_rx = test->ifobj_rx;
 	struct ifobject *ifobj_tx = test->ifobj_tx;
+	struct ifobject *ifobj;
 
 	if (ifobj_rx->xsk->umem->unaligned_mode &&
 	    !ifobj_has_cap(ifobj_rx, XSK_CAP_UNALIGNED)) {
@@ -1913,16 +2066,16 @@ static int testapp_validate_traffic(struct test_spec *test)
 	}
 
 	if (test->set_ring) {
-		if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING)) {
-			if (ifobj_is_local(ifobj_tx) &&
-			    set_ring_size(ifobj_tx)) {
-				ksft_print_msg("Failed to change HW ring size.\n");
-				return TEST_FAILURE;
-			}
-		} else {
+		/* Each endpoint sizes the rings of its own interface. */
+		ifobj = ifobj_is_local(ifobj_tx) ? ifobj_tx : ifobj_rx;
+		if (!ifobj_has_cap(ifobj, XSK_CAP_HW_RING)) {
 			ksft_print_msg("Changing HW ring size not supported.\n");
 			return TEST_SKIP;
 		}
+		if (hw_ring_size_changed(ifobj) && set_ring_size(ifobj)) {
+			ksft_print_msg("Failed to change HW ring size.\n");
+			return TEST_FAILURE;
+		}
 	}
 
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
@@ -2025,6 +2178,9 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
 	u32 umem_tr = xsk_get_cap(test, umem_tailroom);
 
+	/* Hardware endpoints run different modes, so ZC would skip on one only. */
+	if (hw_test)
+		return TEST_SKIP;
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
@@ -2242,6 +2398,10 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
 	int ret;
 
+	/* The XDP program picks the socket from the synthetic destination MAC. */
+	if (hw_test)
+		return TEST_SKIP;
+
 	test->total_steps = 1;
 	test->nb_sockets = 2;
 
@@ -2284,7 +2444,9 @@ int testapp_too_many_frags(struct test_spec *test)
 	u32 max_frags, i;
 	int ret = TEST_FAILURE;
 
-	if (test->mode == TEST_MODE_ZC) {
+	if (max_frags_override) {
+		max_frags = max_frags_override;
+	} else if (test->mode == TEST_MODE_ZC) {
 		max_frags = xsk_get_cap(test, xdp_zc_max_segs);
 	} else {
 		max_frags = xsk_get_cap(test, max_skb_frags);
@@ -2378,6 +2540,7 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
+		ifobj_set_cap(ifobj, XSK_CAP_ZC_ADVERTISED);
 		if (query_opts.xdp_zc_max_segs > 1) {
 			ifobj_set_cap(ifobj, XSK_CAP_MBUF_ZC);
 			ifobj->caps.xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
@@ -2406,6 +2569,12 @@ int init_iface(struct ifobject *ifobj)
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
 
@@ -2519,7 +2688,8 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->set_ring = true;
 	test->total_steps = 2;
 	test->ifobj_tx->ring.tx_pending = xsk_get_cap(test, tx_max_pending);
-	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
+	/* The receiver needs its largest RX ring for these bursts. */
+	test->ifobj_rx->ring.rx_pending = test->ifobj_rx->ring.rx_max_pending;
 	test->ifobj_rx->xsk->umem->num_frames = max_descs;
 	test->ifobj_rx->xsk->umem->fill_size = max_descs;
 	test->ifobj_rx->xsk->umem->comp_size = max_descs;
@@ -2606,7 +2776,8 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
-	if (test->mode == TEST_MODE_SKB)
+	/* The XDP program numbers the grown tail after a non-UDP header. */
+	if (test->mode == TEST_MODE_SKB || hw_test)
 		return TEST_SKIP;
 
 	/* Grow by 4 bytes for testing purpose */
@@ -2617,7 +2788,8 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
 	u32 grow_size;
 
-	if (test->mode == TEST_MODE_SKB)
+	/* The XDP program numbers the grown tail after a non-UDP header. */
+	if (test->mode == TEST_MODE_SKB || hw_test)
 		return TEST_SKIP;
 
 	/* worst case scenario is when underlying setup will work on 3k
@@ -2640,6 +2812,9 @@ int testapp_tx_queue_consumer(struct test_spec *test)
 {
 	int nr_packets;
 
+	/* Hardware endpoints run different modes, so ZC would skip on one only. */
+	if (hw_test)
+		return TEST_SKIP;
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run TX_QUEUE_CONSUMER test for ZC mode\n");
 		return TEST_SKIP;
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 53e5032510a0..85c1eabbe7f0 100644
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
+	/* Device MTU, which a hardware SKB-mode endpoint may keep above mtu. */
+	int dev_mtu;
+	int orig_mtu;
 	u32 bind_flags;
 	bool tx_on;
 	bool rx_on;
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
index 6bd32caf5d08..fb0007c34532 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -826,3 +826,63 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
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
index 3f1fea999763..abff4b950214 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -245,6 +245,9 @@ int xsk_set_mtu(int ifindex, int mtu);
 
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN]);
+int xsk_get_mtu(const char *ifname, int *mtu);
+int xsk_wait_link_up(const char *ifname, int timeout_ms);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 769718cad8cd..7044822f23c0 100644
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
  * - test_xsk.py starts two processes: Tx and Rx
@@ -80,6 +83,7 @@
 #include <linux/align.h>
 #include <arpa/inet.h>
 #include <net/if.h>
+#include <netinet/ether.h>
 #include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -107,9 +111,29 @@ enum xsk_endpoint_role {
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
@@ -173,6 +197,14 @@ static struct option long_options[] = {
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
@@ -191,6 +223,14 @@ static void print_usage(char **argv)
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
@@ -215,6 +255,12 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
 		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
 		ksft_exit_fail();
 	}
+	/* Not into ifobj->mtu, which makes the zero-copy probe bind with SG. */
+	if (xsk_get_mtu(ifobj->ifname, &ifobj->dev_mtu)) {
+		ksft_print_msg("Error: cannot read MTU of interface %s\n", ifobj->ifname);
+		ksft_exit_fail();
+	}
+	ifobj->orig_mtu = ifobj->dev_mtu;
 }
 
 static void print_tests(void)
@@ -296,6 +342,32 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			parse_u32(optarg, 1, UINT16_MAX, argv);
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
@@ -306,6 +378,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
 	    opt_mode == TEST_MODE_ALL)
 		print_usage(argv);
+	if (opt_hw && (!opt_udp_src || !opt_udp_dst || !opt_udp_port || !opt_peer_mac))
+		print_usage(argv);
+	if ((opt_listen || opt_max_frags) && !opt_hw)
+		print_usage(argv);
 }
 
 static void xsk_unload_xdp_programs(struct ifobject *ifobj)
@@ -318,7 +394,12 @@ static int run_pkt_test(struct test_spec *test)
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
@@ -336,9 +417,6 @@ static int run_pkt_test(struct test_spec *test)
 		ksft_test_result_fail("FAIL: %s %s%s -- Unexpected returned value (%d)\n",
 				      mode_string(test), busy_poll_string(test), test->name, ret);
 	}
-
-	pkt_stream_restore_default(test);
-	return ret;
 }
 
 static bool is_xdp_supported(int ifindex)
@@ -371,9 +449,15 @@ static bool is_xdp_supported(int ifindex)
 
 static u32 detect_mode_caps(struct ifobject *ifobj)
 {
-	if (is_xdp_supported(ifobj->ifindex)) {
+	if (opt_hw && opt_mode == TEST_MODE_ZC &&
+	    ifobj_has_cap(ifobj, XSK_CAP_ZC_ADVERTISED)) {
+		/* Trust the advertised flag; an XDP_ZEROCOPY bind never falls back to copy. */
+		ifobj_set_cap(ifobj, XSK_CAP_DRV | XSK_CAP_ZC);
+	} else if ((!opt_hw || opt_mode == TEST_MODE_DRV) &&
+		   is_xdp_supported(ifobj->ifindex)) {
+		/* A hardware endpoint only probes the mode it runs in. */
 		ifobj_set_cap(ifobj, XSK_CAP_DRV);
-		if (ifobj_zc_avail(ifobj))
+		if (!opt_hw && ifobj_zc_avail(ifobj))
 			ifobj_set_cap(ifobj, XSK_CAP_ZC);
 	}
 
@@ -389,8 +473,10 @@ static bool mode_supported(enum test_mode mode, u32 caps)
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
@@ -401,8 +487,16 @@ static void cleanup_iface(struct ifobject *ifobj)
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
@@ -415,8 +509,9 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 	if (xsk_load_xdp_programs(shadow))
 		return TEST_FAILURE;
 
-	/* TX listens and RX connects. */
+	/* Generic TX listens; Python chooses the listener for hardware cases. */
 	*peer = xsk_peer_open(opt_peer_host, opt_peer_port,
+			      opt_hw ? opt_listen :
 			      opt_endpoint_role == XSK_ENDPOINT_TX);
 	if (!*peer) {
 		ksft_print_msg("Failed to connect XSK peer: %s\n", strerror(errno));
@@ -424,7 +519,10 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 	}
 
 	shadow->caps = local->caps;
-	xsk_set_endpoint(*peer);
+	if (opt_hw)
+		memcpy(shadow->caps.mac, opt_peer_mac->ether_addr_octet, ETH_ALEN);
+
+	xsk_set_endpoint(*peer, opt_hw);
 	return TEST_PASS;
 }
 
@@ -439,6 +537,7 @@ int main(int argc, char **argv)
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
 	u32 caps;
+	int err;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -482,6 +581,11 @@ int main(int argc, char **argv)
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
@@ -493,6 +597,8 @@ int main(int argc, char **argv)
 		shadow_ifobj = ifobj_tx;
 	}
 	bind_iface(local_ifobj, opt_ifname, argv);
+	local_ifobj->queue_id = opt_queue;
+	/* The zero-copy probe binds to queue_id, so set it first. */
 	caps = detect_mode_caps(local_ifobj);
 
 	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
@@ -517,9 +623,15 @@ int main(int argc, char **argv)
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
+	/* After the cleanup, which can still fail a case that ran. */
+	if (test.test_func)
+		report_pkt_test(&test, ret);
 	xsk_peer_close(peer);
 	pkt_stream_delete(test.tx_pkt_stream_default);
 	pkt_stream_delete(test.rx_pkt_stream_default);
-- 
2.43.0

