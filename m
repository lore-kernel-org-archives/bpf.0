Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28859574B;
	Fri, 16 Oct 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172663; cv=none; b=kpsiABP5HrITHhLu3B0Ph84bjG8OB9P+Fco6U3kFTT1TzUZUE/cUM43mo/KtSKDwCYCvEn9s2BN1hszV+hUMoVZSy2G2XqF6yK1SCfyMD55WyGB35LUSwZupD2CTG32bferirVD/kp2c7iwaRPGA8vZk95vr0DKD6NnMetblxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172663; c=relaxed/simple;
	bh=4lO/EkVACHgm02j3/fk6sLfADVH4h6L9sCHO/kXy6qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6C+dZ8lXeteN9JbS/fOzM/Jp5nDv6WFPNsCpaGWAweHkoItlk83MNACTsSC1aCUN+eXMvvftGmCRME0QkqtxaC37SkIZGnnMMyw00Cu2w3hMwHdOxGxyfatV/nKWxV6myfc2hw+bh4Od+ekJGZr+rKwqOH4tk8c2fEqFgl2S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsOGb+92; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsOGb+92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172657; x=1823708657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lO/EkVACHgm02j3/fk6sLfADVH4h6L9sCHO/kXy6qU=;
  b=bsOGb+92O/kWy/vHx6QhfUDn9+oppo2KbmpnOMOb5I5MskEK+oQoLREH
   l1wS1U4S15lJNc5jr3Tv+J8D7oNq9gh7SR8I5/jZsOhtKUlUmFIi3FQ3K
   BTs12V3o3bP+052lSNeMesTEKgPSzDBhDpvCR9Y7VyvoUgqGQLcvSvuiP
   jFoSaZhd5jqAwPb5EG+rWfdzXZG8fY+yXO6wbWKqeJFrXHZhXEptZMr4p
   n0JxTYY2+WOHx4T8TpKg/DANEisI6UmOAueWaajBGD4F0W5BnTpgUgAx7
   sMKzU6woh0cDLNv1V8MVNwR52wQarzWFburhdRxgNxtPPnw0JLFxmUeOg
   g==;
X-CSE-ConnectionGUID: mmjeH21VRQmIaGdk158TSg==
X-CSE-MsgGUID: u331v02HQluYEC8+1fW2Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972393"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:17 -0700
X-CSE-ConnectionGUID: qDuUgcg8Sx++jU3eoQUl1w==
X-CSE-MsgGUID: KNmnpqsOQpu2QnZYQHk8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425228"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:15 -0700
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
Subject: [PATCH v4 net-next 11/15] selftests: xsk: send UDP over IPv4 or IPv6 between the interface MACs
Date: Fri, 16 Oct 2026 19:43:34 +0200
Message-Id: <20261016174338.787135-12-maciej.fijalkowski@intel.com>
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

xskxceiver sends frames of the loopback ethertype between made-up MAC
addresses, and its XDP programs redirect every frame to the XSKMAP.
That suits a veth pair that carries nothing else, but not a physical
link, where the peer NIC filters out the made-up addresses and the
programs take neighbour discovery, LLDP or SSH away from the stack.

Send the test packets as UDP between the MAC addresses of the two
interfaces on any link. Each endpoint takes the IPv4 or IPv6 addresses
of the flow (--src-ip, --dst-ip), the MAC address of its peer
(--dst-mac) and the UDP port (--udp-port), and reads its own MAC
address from the interface. Over IPv4 the UDP checksum is left at zero,
as IPv4 allows; over IPv6 it is computed from the known payload.
PKT_HDR_SIZE and MIN_PKT_SIZE now stand for variables that
xsk_set_flow() sets, so the smallest packet grows with the headers to
64 bytes over IPv4 and 88 over IPv6, and a verbatim stream adds up the
descriptors of a packet for its IP and UDP lengths.

The XDP programs redirect only the UDP packets to the test port and
pass everything else to the stack, all IPv4 fragments included. The port
is written when a skeleton is loaded, so it also reaches the shadow
endpoint's copy, whose programs the local side attaches once
BIDIRECTIONAL swaps the directions. XDP_SHARED_UMEM picks the socket by
the UDP source port, the test port plus the socket index, rather than by
a made-up destination MAC, and xsk_xdp_adjust_tail() numbers a grown
tail after the UDP header.

test_xsk.py sends from 2001:db8::1 to 2001:db8::2 between the MAC
addresses of the veth pair. The veths need not have the addresses, as
the XDP program takes the packets before the stack, and IPv6 stays on.

is_adjust_tail_supported() copied all of .bss into an int with
bpf_map_lookup_elem(), past the end of the int even before the port
grew .bss; read adjust_value through the skeleton instead.
is_frag_valid() now rejects a fragment too short for the words it
reads, and pkt_dump() prints only the words within the length it is
given, which is_pkt_valid() gives as the first fragment's length.
write_payload() zeroes the bytes after the last full word, which the
IPv6 UDP checksum counts.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 240 ++++++++++++++----
 .../testing/selftests/net/lib/xsk/test_xsk.h  |   7 +-
 tools/testing/selftests/net/lib/xsk/xsk.c     |  26 ++
 tools/testing/selftests/net/lib/xsk/xsk.h     |   1 +
 .../selftests/net/lib/xsk/xsk_xdp_common.h    |   3 +-
 .../selftests/net/lib/xsk/xsk_xdp_progs.bpf.c |  91 ++++++-
 .../selftests/net/lib/xsk/xskxceiver.c        |  48 +++-
 tools/testing/selftests/net/test_xsk.py       |  30 ++-
 8 files changed, 368 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index ce88218fef00..9c401a43da43 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -3,10 +3,14 @@
 #include <bpf/bpf.h>
 #include <errno.h>
 #include <limits.h>
+#include <linux/align.h>
 #include <linux/bitmap.h>
 #include <linux/if_link.h>
 #include <linux/mman.h>
 #include <linux/netdev.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
 #include <poll.h>
 #include <string.h>
 #include <sys/mman.h>
@@ -20,14 +24,14 @@
 #include "xsk_xdp_progs.skel.h"
 
 #define DEFAULT_BATCH_SIZE		64
-#define MIN_PKT_SIZE			64
+/* Payload of the smallest packet, which is 64 bytes over IPv4 */
+#define MIN_PAYLOAD_SIZE		20
 #define MAX_ETH_JUMBO_SIZE		9000
 #define MAX_INTERFACES			2
 #define MAX_TEARDOWN_ITER		10
 #define MAX_TX_BUDGET_DEFAULT		32
 #define PKT_DUMP_NB_TO_PRINT		16
-/* Just to align the data in the packet */
-#define PKT_HDR_SIZE			(sizeof(struct ethhdr) + 2)
+#define PKT_HDR_SIZE			pkt_hdr_size
 #define POLL_TMOUT			1000
 #define THREAD_TMOUT			3
 #define UMEM_HEADROOM_TEST_SIZE		128
@@ -36,9 +40,17 @@
 #define XSK_UMEM__LARGE_FRAME_SIZE	(3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
 
-static const u8 g_mac[ETH_ALEN] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
+/* The test flow, UDP over IPv4 or IPv6 */
+static int flow_family;
+static union {
+	struct in_addr v4;
+	struct in6_addr v6;
+} flow_src, flow_dst;
+static u16 udp_port;
+static u32 pkt_hdr_size;
 
 bool opt_verbose;
+int min_pkt_size;
 
 int pkts_in_flight;
 static struct xsk_peer *ctrl_peer;
@@ -80,19 +92,132 @@ static int pacing_tx_sync(void)
  */
 static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
 {
-	u32 *ptr = (u32 *)dest, i;
+	u32 *ptr = (u32 *)dest, i, words = size / sizeof(*ptr);
 
 	start /= sizeof(*ptr);
-	size /= sizeof(*ptr);
-	for (i = 0; i < size; i++)
+	for (i = 0; i < words; i++)
 		ptr[i] = htonl(pkt_nb << 16 | (i + start));
+	/* The UDP checksum counts a partial last word as zero. */
+	memset(ptr + words, 0, size % sizeof(*ptr));
 }
 
-static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
+int xsk_set_flow(const char *src_ip, const char *dst_ip, u16 port)
 {
+	u32 ip_hdr_size;
+
+	if (inet_pton(AF_INET, src_ip, &flow_src) == 1 &&
+	    inet_pton(AF_INET, dst_ip, &flow_dst) == 1) {
+		flow_family = AF_INET;
+		ip_hdr_size = sizeof(struct iphdr);
+	} else if (inet_pton(AF_INET6, src_ip, &flow_src) == 1 &&
+		   inet_pton(AF_INET6, dst_ip, &flow_dst) == 1) {
+		flow_family = AF_INET6;
+		ip_hdr_size = sizeof(struct ipv6hdr);
+	} else {
+		return -EINVAL;
+	}
+	if (!port)
+		return -EINVAL;
+
+	udp_port = port;
+	pkt_hdr_size = sizeof(struct ethhdr) + ip_hdr_size +
+		       sizeof(struct udphdr) + PKT_HDR_PAD;
+	/* A multiple of 8, so that a packet that a case puts MIN_PKT_SIZE / 2
+	 * before a boundary keeps its payload 4-byte aligned.
+	 */
+	min_pkt_size = ALIGN(pkt_hdr_size + MIN_PAYLOAD_SIZE, 8);
+	return 0;
+}
+
+/* Add up buf as big-endian 16-bit words, len being even. */
+static u32 csum_add(u32 sum, const void *buf, size_t len)
+{
+	const u8 *pos = buf;
+
+	for (; len > 1; len -= 2, pos += 2)
+		sum += pos[0] << 8 | pos[1];
+	return sum;
+}
+
+static u16 csum_fold(u32 sum)
+{
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+	return htons((u16)~sum);
+}
+
+/* The sum of the payload of len bytes that write_payload() writes: each
+ * word holds pkt_nb and the index of the word in its two 16-bit halves.
+ */
+static u32 payload_csum(u32 pkt_nb, u32 len)
+{
+	u32 words = len / sizeof(u32);
+
+	return words * (pkt_nb & 0xffff) + words * (words - 1) / 2;
+}
+
+static u16 udp6_csum(const struct ipv6hdr *ip6, const struct udphdr *udp, u32 pkt_nb)
+{
+	u32 len = ntohs(udp->len), sum;
+
+	sum = csum_add(0, &ip6->saddr, sizeof(ip6->saddr));
+	sum = csum_add(sum, &ip6->daddr, sizeof(ip6->daddr));
+	sum += len + IPPROTO_UDP;
+	sum = csum_add(sum, udp, sizeof(*udp));
+	/* The pad in front of the payload is zero. */
+	sum += payload_csum(pkt_nb, len - sizeof(*udp) - PKT_HDR_PAD);
+	return csum_fold(sum) ?: 0xffff;
+}
+
+static void gen_pkt_hdr(struct xsk_socket_info *xsk, void *data, u32 pkt_nb, u32 total_len)
+{
+	u32 ip_len = total_len - sizeof(struct ethhdr);
+	struct ethhdr *eth_hdr = data;
+	struct udphdr udp = {
+		.source = htons(xsk->src_port),
+		.dest = htons(udp_port),
+	};
+	void *ptr = eth_hdr + 1;
+
 	memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
 	memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
-	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
+
+	if (flow_family == AF_INET6) {
+		struct ipv6hdr ip6 = {
+			.version = 6,
+			.payload_len = htons(ip_len - sizeof(ip6)),
+			.nexthdr = IPPROTO_UDP,
+			.hop_limit = 64,
+			.saddr = flow_src.v6,
+			.daddr = flow_dst.v6,
+		};
+
+		eth_hdr->h_proto = htons(ETH_P_IPV6);
+		udp.len = ip6.payload_len;
+		udp.check = udp6_csum(&ip6, &udp, pkt_nb);
+		memcpy(ptr, &ip6, sizeof(ip6));
+		ptr += sizeof(ip6);
+	} else {
+		/* Without a checksum, which UDP over IPv4 does not require */
+		struct iphdr ip = {
+			.version = 4,
+			.ihl = 5,
+			.ttl = 64,
+			.protocol = IPPROTO_UDP,
+			.tot_len = htons(ip_len),
+			.saddr = flow_src.v4.s_addr,
+			.daddr = flow_dst.v4.s_addr,
+		};
+
+		eth_hdr->h_proto = htons(ETH_P_IP);
+		udp.len = htons(ip_len - sizeof(ip));
+		ip.check = csum_fold(csum_add(0, &ip, sizeof(ip)));
+		memcpy(ptr, &ip, sizeof(ip));
+		ptr += sizeof(ip);
+	}
+
+	memcpy(ptr, &udp, sizeof(udp));
+	memset(ptr + sizeof(udp), 0, PKT_HDR_PAD);
 }
 
 u32 mode_to_xdp_flags(enum test_mode mode)
@@ -207,6 +332,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
+		struct ifobject *peer = i ? ifobj_tx : ifobj_rx;
 		struct xsk_umem_info *umem;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
@@ -238,10 +364,10 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			else
 				xsk->pkt_stream = test->rx_pkt_stream_default;
 
-			memcpy(xsk->src_mac, g_mac, ETH_ALEN);
-			memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
-			xsk->src_mac[5] += ((j * 2) + 0);
-			xsk->dst_mac[5] += ((j * 2) + 1);
+			memcpy(xsk->src_mac, ifobj->caps.mac, ETH_ALEN);
+			memcpy(xsk->dst_mac, peer->caps.mac, ETH_ALEN);
+			/* xsk_xdp_shared_umem() picks the socket by it. */
+			xsk->src_port = udp_port + j;
 		}
 
 		ifobj->xsk->umem->num_frames = DEFAULT_UMEM_BUFFERS;
@@ -442,6 +568,19 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
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
@@ -626,7 +765,7 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 }
 
 static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
-			 u32 pkt_nb, u32 bytes_written)
+			 u32 total_len, u32 pkt_nb, u32 bytes_written)
 {
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 
@@ -634,7 +773,7 @@ static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 		return;
 
 	if (!bytes_written) {
-		gen_eth_hdr(xsk, data);
+		gen_pkt_hdr(xsk, data, pkt_nb, total_len);
 
 		len -= PKT_HDR_SIZE;
 		data += PKT_HDR_SIZE;
@@ -727,10 +866,11 @@ static void pkt_print_data(u32 *data, u32 cnt)
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
@@ -748,12 +888,13 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
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
@@ -792,31 +933,12 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	return true;
 }
 
-static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
+static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
 {
-	struct bpf_map *data_map;
-	int adjust_value = 0;
-	int key = 0;
-	int ret;
-
-	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
-	if (!data_map || !bpf_map__is_internal(data_map)) {
-		ksft_print_msg("Error: could not find bss section of XDP program\n");
-		return -EINVAL;
-	}
-
-	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
-	if (ret) {
-		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
-		return ret;
-	}
-
 	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
 	 * helper is not supported. Skip the adjust_tail test case in this scenario.
 	 */
-	*supported = adjust_value != -EOPNOTSUPP;
-
-	return 0;
+	return skel_rx->bss->adjust_value != -EOPNOTSUPP;
 }
 
 static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
@@ -836,6 +958,11 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 			       (unsigned long long)addr, len);
 		return false;
 	}
+	if (len < (bytes_processed ? 0 : PKT_HDR_SIZE) + sizeof(*pkt_data)) {
+		ksft_print_msg("Frag too short addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
+		return false;
+	}
 
 	pkt_data = data;
 	if (!bytes_processed) {
@@ -877,12 +1004,13 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
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
+		pkt_dump(xsk_umem__get_data(buffer, addr), frag_len - PKT_HDR_SIZE, true);
 		return false;
 	}
 
@@ -980,7 +1108,7 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
 static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 {
-	u32 frags_processed = 0, nb_frags = 0, pkt_len = 0;
+	u32 frags_processed = 0, nb_frags = 0, pkt_len = 0, first_len = 0;
 	u32 idx_rx = 0, idx_fq = 0, rcvd, pkts_sent = 0;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	struct ifobject *ifobj = test->ifobj_rx;
@@ -1057,8 +1185,10 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
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
@@ -1068,7 +1198,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			continue;
 
 		/* The complete packet has been received */
-		if (!is_pkt_valid(pkt, umem->buffer, first_addr, pkt_len) ||
+		if (!is_pkt_valid(pkt, umem->buffer, first_addr, first_len, pkt_len) ||
 		    !is_offset_correct(umem, pkt, addr))
 			return TEST_FAILURE;
 
@@ -1218,7 +1348,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 
 	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
-		u32 nb_frags_left, nb_frags, bytes_written = 0;
+		u32 nb_frags_left, nb_frags, total_len, bytes_written = 0;
 
 		if (!pkt)
 			break;
@@ -1230,6 +1360,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 			break;
 		}
 		nb_frags_left = nb_frags;
+		total_len = pkt_total_len(pkt_stream, pkt, nb_frags);
 
 		while (nb_frags_left--) {
 			struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
@@ -1246,8 +1377,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
-					     bytes_written);
+				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, total_len,
+					     pkt->pkt_nb, bytes_written);
 			bytes_written += tx_desc->len;
 
 			print_verbose("Tx addr: %llx len: %u options: %u pkt_nb: %u\n",
@@ -1640,7 +1771,6 @@ static int testapp_prepare_rx_endpoint(struct test_spec *test,
 static int testapp_validate_rx_endpoint(struct test_spec *test,
 					struct ifobject *ifobject)
 {
-	bool supported;
 	int err;
 
 	err = receive_pkts(test);
@@ -1653,9 +1783,7 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
 	if (!test->adjust_tail)
 		return err;
 
-	if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
-		return TEST_FAILURE;
-	if (!supported) {
+	if (!is_adjust_tail_supported(ifobject->xdp_progs)) {
 		test->adjust_tail_support = false;
 		return TEST_PASS;
 	}
@@ -2293,6 +2421,8 @@ int xsk_load_xdp_programs(struct ifobject *ifobj)
 	if (libbpf_get_error(ifobj->xdp_progs))
 		return libbpf_get_error(ifobj->xdp_progs);
 
+	/* The shadow's copy too, swapped directions attach its programs. */
+	ifobj->xdp_progs->bss->test_port = udp_port;
 	return 0;
 }
 
@@ -2353,6 +2483,12 @@ int init_iface(struct ifobject *ifobj)
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
index f1fafae2d140..4690ae2ad9c6 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -24,7 +24,7 @@
 #define DEFAULT_PKT_CNT			(4 * 1024)
 #define DEFAULT_UMEM_BUFFERS		(DEFAULT_PKT_CNT / 4)
 #define HUGEPAGE_SIZE			(2 * 1024 * 1024)
-#define MIN_PKT_SIZE			64
+#define MIN_PKT_SIZE			min_pkt_size
 #define MAX_ETH_PKT_SIZE		1518
 #define MAX_INTERFACE_NAME_CHARS	16
 #define MAX_TEST_NAME_SIZE		48
@@ -35,6 +35,8 @@
 #define SMP_CACHE_BYTES_PATH "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
 
 extern bool opt_verbose;
+/* The smallest test packet, set by xsk_set_flow() */
+extern int min_pkt_size;
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
 
@@ -83,6 +85,7 @@ struct xsk_peer;
 
 /* The control channel to the other endpoint. */
 void xsk_set_endpoint(struct xsk_peer *peer);
+int xsk_set_flow(const char *src_ip, const char *dst_ip, u16 port);
 
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
@@ -95,6 +98,7 @@ struct xsk_socket_info {
 	u32 batch_size;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
+	u16 src_port;
 	bool check_consumer;
 };
 
@@ -129,6 +133,7 @@ struct xsk_caps {
 	u32 max_skb_frags;
 	u32 umem_tailroom;
 	u32 tx_max_pending;
+	u8 mac[ETH_ALEN];
 };
 
 struct ifobject {
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
index 660540efc46e..54e6808e3fe4 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -802,3 +802,29 @@ int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
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
diff --git a/tools/testing/selftests/net/lib/xsk/xsk.h b/tools/testing/selftests/net/lib/xsk/xsk.h
index 94a56dd43f2e..263971a57e1e 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -244,6 +244,7 @@ void xsk_socket__delete(struct xsk_socket *xsk);
 int xsk_set_mtu(int ifindex, int mtu);
 
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int xsk_get_mac(const char *ifname, u8 mac[ETH_ALEN]);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h b/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
index 45810ff552da..47cbceea402d 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
@@ -4,7 +4,8 @@
 #define XSK_XDP_COMMON_H_
 
 #define MAX_SOCKETS 2
-#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
+/* Pads the UDP header of a test packet so that the payload is 4-byte aligned */
+#define PKT_HDR_PAD 2
 
 struct xdp_info {
 	__u64 count;
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
index 023d8befd4ca..2b55dbaf13b2 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
@@ -5,9 +5,17 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
+#include <linux/in.h>
 #include <linux/errno.h>
+#include <bpf/bpf_endian.h>
+#include <stdbool.h>
 #include "xsk_xdp_common.h"
 
+#define IP_MF		0x2000
+#define IP_OFFSET	0x1fff
+
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
 	__uint(max_entries, 2);
@@ -15,12 +23,64 @@ struct {
 	__uint(value_size, sizeof(int));
 } xsk SEC(".maps");
 
-static unsigned int idx;
 int adjust_value = 0;
 int count = 0;
+/* UDP destination port of the test flow, other traffic goes to the stack */
+__u16 test_port;
+
+/* Return the UDP header of a test packet, and in hdr_len the size of the
+ * headers in front of its payload, or NULL for any other packet.
+ */
+static __always_inline struct udphdr *test_udp_hdr(struct xdp_md *xdp,
+						   __u32 *hdr_len)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	struct ethhdr *eth = data;
+	struct ipv6hdr *ip6;
+	struct udphdr *udp;
+	struct iphdr *ip;
+
+	if ((void *)(eth + 1) > data_end)
+		return NULL;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		ip = (void *)(eth + 1);
+		/* Fragments go to the stack, which reassembles them. */
+		if ((void *)(ip + 1) > data_end || ip->ihl != 5 ||
+		    ip->protocol != IPPROTO_UDP ||
+		    ip->frag_off & bpf_htons(IP_MF | IP_OFFSET))
+			return NULL;
+		udp = (void *)(ip + 1);
+		*hdr_len = sizeof(*eth) + sizeof(*ip);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		ip6 = (void *)(eth + 1);
+		/* The test flow carries no extension headers. */
+		if ((void *)(ip6 + 1) > data_end || ip6->nexthdr != IPPROTO_UDP)
+			return NULL;
+		udp = (void *)(ip6 + 1);
+		*hdr_len = sizeof(*eth) + sizeof(*ip6);
+	} else {
+		return NULL;
+	}
+
+	if ((void *)(udp + 1) > data_end || udp->dest != bpf_htons(test_port))
+		return NULL;
+	*hdr_len += sizeof(*udp) + PKT_HDR_PAD;
+	return udp;
+}
+
+static __always_inline bool is_test_packet(struct xdp_md *xdp)
+{
+	__u32 hdr_len;
+
+	return test_udp_hdr(xdp, &hdr_len);
+}
 
 SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 {
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
@@ -28,6 +88,8 @@ SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	static unsigned int drop_idx;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	/* Drop every other packet */
 	if (drop_idx++ % 2)
 		return XDP_DROP;
@@ -41,6 +103,9 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 	struct xdp_info *meta;
 	int err;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
+
 	/* Reserve enough for all custom metadata. */
 	err = bpf_xdp_adjust_meta(xdp, -(int)sizeof(struct xdp_info));
 	if (err)
@@ -60,16 +125,17 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 
 SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 {
-	void *data = (void *)(long)xdp->data;
-	void *data_end = (void *)(long)xdp->data_end;
-	struct ethhdr *eth = data;
+	struct udphdr *udp;
+	__u32 hdr_len;
+	__u16 idx;
 
-	if (eth + 1 > data_end)
-		return XDP_DROP;
+	udp = test_udp_hdr(xdp, &hdr_len);
+	if (!udp)
+		return XDP_PASS;
 
-	/* Redirecting packets based on the destination MAC address */
-	idx = ((unsigned int)(eth->h_dest[5])) / 2;
-	if (idx > MAX_SOCKETS)
+	/* Socket N sends from test_port + N */
+	idx = bpf_ntohs(udp->source) - test_port;
+	if (idx >= MAX_SOCKETS)
 		return XDP_DROP;
 
 	return bpf_redirect_map(&xsk, idx, XDP_DROP);
@@ -77,9 +143,12 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 
 SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 {
-	__u32 buff_len, curr_buff_len;
+	__u32 buff_len, curr_buff_len, hdr_len;
 	int ret;
 
+	if (!test_udp_hdr(xdp, &hdr_len))
+		return XDP_PASS;
+
 	buff_len = bpf_xdp_get_buff_len(xdp);
 	if (buff_len == 0)
 		return XDP_DROP;
@@ -106,7 +175,7 @@ SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 		__u32 *pkt_data = (void *)(long)xdp->data;
 		__u32 len, words_to_end, seq_num;
 
-		len = curr_buff_len - PKT_HDR_ALIGN;
+		len = curr_buff_len - hdr_len;
 		words_to_end = len / sizeof(*pkt_data) - 1;
 		seq_num = words_to_end;
 
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index fbfff586e0e5..9704702f60fc 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -63,7 +63,9 @@
  *   veth interface
  * - Tx process listens on a TCP control port (--listen), Rx process connects
  *   to it and the two synchronize each test step over that connection
- * - Tx process Transmits a number of packets from veth<xxxx> to veth<yyyy>
+ * - Tx process transmits a number of UDP packets over IPv4 or IPv6 from
+ *   veth<xxxx> to veth<yyyy>, and the XDP program of Rx passes other traffic
+ *   to the stack
  * - Rx process verifies if all packets were received and delivered in-order,
  *   and have the right content
  */
@@ -80,6 +82,7 @@
 #include <linux/align.h>
 #include <arpa/inet.h>
 #include <net/if.h>
+#include <netinet/ether.h>
 #include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -111,9 +114,18 @@ static bool opt_listen;
 static const char *opt_peer_host;
 static const char *opt_peer_port;
 static const char *opt_ifname;
+static const char *opt_src_ip;
+static const char *opt_dst_ip;
+static const struct ether_addr *opt_dst_mac;
+static struct ether_addr dst_mac;
+static u16 opt_udp_port;
 
 enum {
 	OPT_LISTEN = 256,
+	OPT_SRC_IP,
+	OPT_DST_IP,
+	OPT_DST_MAC,
+	OPT_UDP_PORT,
 };
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
@@ -179,6 +191,10 @@ static struct option long_options[] = {
 	{"peer", required_argument, 0, 'p'},
 	{"peer-port", required_argument, 0, 'P'},
 	{"listen", no_argument, 0, OPT_LISTEN},
+	{"src-ip", required_argument, 0, OPT_SRC_IP},
+	{"dst-ip", required_argument, 0, OPT_DST_IP},
+	{"dst-mac", required_argument, 0, OPT_DST_MAC},
+	{"udp-port", required_argument, 0, OPT_UDP_PORT},
 	{"help", no_argument, 0, 'h'},
 	{0, 0, 0, 0}
 };
@@ -186,7 +202,8 @@ static struct option long_options[] = {
 static void print_usage(char **argv)
 {
 	const char *str =
-		"  Usage: %s -i IFACE -e rx|tx -m MODE -t TEST -p HOST -P PORT [OPTIONS]\n"
+		"  Usage: %s -i IFACE -e rx|tx -m MODE -t TEST -p HOST -P PORT\n"
+		"                    --src-ip IP --dst-ip IP --dst-mac MAC --udp-port PORT [OPTIONS]\n"
 		"  Options:\n"
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
@@ -198,6 +215,10 @@ static void print_usage(char **argv)
 		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
 		"  -P, --peer-port      Control TCP port\n"
 		"      --listen         Listen on the control port instead of connecting\n"
+		"      --src-ip IP      IPv4 or IPv6 source address of the test packets\n"
+		"      --dst-ip IP      Destination address, of the same family\n"
+		"      --dst-mac MAC    Destination MAC address of the test packets\n"
+		"      --udp-port PORT  UDP destination port, and source port of socket 0\n"
 		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
@@ -293,6 +314,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		case OPT_LISTEN:
 			opt_listen = true;
 			break;
+		case OPT_SRC_IP:
+			opt_src_ip = optarg;
+			break;
+		case OPT_DST_IP:
+			opt_dst_ip = optarg;
+			break;
+		case OPT_DST_MAC:
+			opt_dst_mac = ether_aton_r(optarg, &dst_mac);
+			if (!opt_dst_mac)
+				print_usage(argv);
+			break;
+		case OPT_UDP_PORT:
+			opt_udp_port = strtoul(optarg, NULL, 10);
+			break;
 		case 'h':
 		default:
 			print_usage(argv);
@@ -301,7 +336,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 	if (!opt_ifname || opt_endpoint_role == XSK_ENDPOINT_NONE || !opt_peer_host ||
 	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
-	    opt_mode == TEST_MODE_ALL)
+	    opt_mode == TEST_MODE_ALL || !opt_src_ip || !opt_dst_ip || !opt_dst_mac ||
+	    !opt_udp_port)
 		print_usage(argv);
 }
 
@@ -416,6 +452,8 @@ static int setup_peer(struct ifobject *local, struct ifobject *shadow,
 	}
 
 	shadow->caps = local->caps;
+	memcpy(shadow->caps.mac, opt_dst_mac->ether_addr_octet, ETH_ALEN);
+
 	xsk_set_endpoint(*peer);
 	return TEST_PASS;
 }
@@ -474,6 +512,10 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
+	/* Before the default packet streams, which have its minimum size. */
+	if (xsk_set_flow(opt_src_ip, opt_dst_ip, opt_udp_port))
+		print_usage(argv);
+
 	/* swap_directions() swaps the workers, so the shadow needs one too. */
 	ifobj_tx->func_ptr = worker_testapp_validate_tx;
 	ifobj_rx->func_ptr = worker_testapp_validate_rx;
diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/selftests/net/test_xsk.py
index 7f9d2c04f0e5..6ca54bafc03d 100755
--- a/tools/testing/selftests/net/test_xsk.py
+++ b/tools/testing/selftests/net/test_xsk.py
@@ -21,7 +21,9 @@ Topology:
 Each case runs a TX and an RX xskxceiver process on a veth pair that the case
 creates in the current network namespace and deletes when it ends. The TX
 process listens (--listen) on a TCP control port on 127.0.0.1, and the RX
-process connects to it once TX says on stderr that it listens.
+process connects to it once TX says on stderr that it listens. The test
+packets are UDP over IPv6 between the MAC addresses of the veth pair, and the
+XDP programs pass other traffic to the stack.
 
 test_xsk runs every case that "xskxceiver -l" lists but EXCLUDED_CASES in SKB
 and DRV mode, and test_xsk_busy_poll runs them again with busy polling.
@@ -46,6 +48,9 @@ CASE_TIMEOUT = 20
 # xskxceiver waits as long for its peer to connect.
 LISTEN_TIMEOUT = 30
 SKIP_CODE = 4
+# Source addresses of the TX and RX endpoints, which the veths do not have.
+TX_ADDR = "2001:db8::1"
+RX_ADDR = "2001:db8::2"
 EXCLUDED_CASES = {
     # bpf_xdp_adjust_tail() frees a frag that it trims off as the memory type
     # of the XDP RX queue, which veth and generic XDP leave at
@@ -53,9 +58,9 @@ EXCLUDED_CASES = {
     # page leaks from its pool.
     "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF",
     # The case skips in SKB mode. In DRV mode, veth copies each frame into a
-    # page_pool fragment that leaves no room to grow the 128-byte frames of
-    # the case unless it is the last one of its page, so the XDP program
-    # drops most frames.
+    # page_pool fragment that leaves no room to grow the small frames of the
+    # case unless it is the last one of its page, so the XDP program drops
+    # most frames.
     "XDP_ADJUST_TAIL_GROW",
 }
 
@@ -85,10 +90,6 @@ def _veth_pair(busy_poll):
        f"peer name {veths[1]} numtxqueues 4 numrxqueues 4")
     defer(ip, f"link del {veths[0]}")
     for dev in veths:
-        # The XDP program redirects all traffic, keep IPv6 off the link.
-        ipv6 = Path("/proc/sys/net/ipv6/conf", dev, "disable_ipv6")
-        if ipv6.exists():
-            ipv6.write_text("1", encoding="utf-8")
         if busy_poll:
             xsk_setup_busy_poll(dev)
     for dev in veths:
@@ -96,6 +97,10 @@ def _veth_pair(busy_poll):
     return veths
 
 
+def _mac(dev):
+    return ip(f"link show dev {dev}", json=True)[0]["address"]
+
+
 def _start(args):
     return cmd([str(XSK_BIN), *args], background=True, fail=False)
 
@@ -107,15 +112,20 @@ def _test(mode, test_id, busy_poll):
             "-t", str(test_id),
             "-p", "127.0.0.1",
             "-P", str(port),
+            "--udp-port", str(rand_port()),
             *(["-b"] if busy_poll else [])]
-    tx = _start(["-i", tx_if, "-e", "tx", "--listen", *args])
+    tx = _start(["-i", tx_if, "-e", "tx", "--listen",
+                 "--src-ip", TX_ADDR, "--dst-ip", RX_ADDR,
+                 "--dst-mac", _mac(rx_if), *args])
     head = ""
     try:
         head, listening = xsk_wait_listen(tx, port, LISTEN_TIMEOUT)
         if not listening:
             tx.proc.kill()
             raise KsftFailEx(f"TX endpoint did not listen on port {port}")
-        rx = _start(["-i", rx_if, "-e", "rx", *args])
+        rx = _start(["-i", rx_if, "-e", "rx",
+                     "--src-ip", RX_ADDR, "--dst-ip", TX_ADDR,
+                     "--dst-mac", _mac(tx_if), *args])
         rx_ret = xsk_wait_endpoint_exit(rx, "rx", CASE_TIMEOUT)
     finally:
         tx_ret = xsk_wait_endpoint_exit(tx, "tx", CASE_TIMEOUT, head)
-- 
2.43.0

