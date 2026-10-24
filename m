Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833188;
	b=K70LVUEvj98kFDTJ4BIj+WGGs/FWIXUqAwAig6+mtHO8RdlTwBvnjV8RhQ4mWOmOxL9d
	 uhw4PxV2//uIr8NUPjxaHOjzyKvMjlLyNPZ2dDEvslg9epg88GWet3RbdcWmXgLGIpwLi
	 ojO8G74Tr71CiWX1IVYhH0RJtxihJ0TH54pwAC/MLWcTmqL/ubwj4NGmRLF84WIdzijzM
	 w91Le2KLbwv/Vlwqq8aveUJCXrUy6Cruh/K49pISztQFPE9Orq4KRQSmC7bqdaeE6b9U+
	 Hu2IutDRaSOmKx2AXWzyxccj31Wa9+r7Gz2oDovyH7nmjNkEdTyt/DMU/GuEeRT/caQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YDNhZ9YjK/zlIe5trqHYSdI1fhNBLfzLRTmRchXqEEw=;
	b=Tktx8TdKZ2VaT7J+9th70Jo5w+WoTDVlBrd6XDIQuC634gAhj0kQ+Dl1GnZsIm8Oaxax
	 n8+Bl1jNobvXjnw7dCeOBQ8JsVlxz29nxDJRaYhFz5Dqb1iwoJvlD90el7h0Tv8mSjSev
	 u5CM/PLQGVfSCQ/2QL1HYRj6/dI2ss4xhsWlE/RV2C4XTQdGY15Ch+Ny3yVtPri2ybvoj
	 kel7KTX4mManHyQTdup83LychKYwGmR2HX8HN4EMFA7P7bJM04q3nJO11rqn+Yu8Be5f3
	 cjD5EbQpaGf8m4xPq1uhR0tRGQ7KgmChC3/SPWoBUtQTS32YUSbfrqrdCZQW4hI4G7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gF6+xCNs;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E30606A31E
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 09:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E30606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gF6+xCNs
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso329679a91.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833187; x=1793437987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDNhZ9YjK/zlIe5trqHYSdI1fhNBLfzLRTmRchXqEEw=;
        b=gF6+xCNsFTFYDaeJwwaq/P0+Cter9G1tJ7K2lri5LvrpFg2QxpZ/855aj5nDmzMM/l
         ncGai+D5muYDxpER3I+DJZSavGtTB7ugxRCv26Jw6osKn7nIozGUxE7ZKgYwXIaZIIIP
         iTc++CeBx3MPgD3F+BcsNRzeou49sF3M2jVfz8fjtAhHLVJDiF8r8ubrVxQRl/I928zg
         5fnxLcu1bzDSlpy42jrX4iQOkWIzXMiP4/yOoKIYabdouie/84SUTboFMjGMMYtBDS9H
         1zuSC5Bsu4OkmVbl2+LBl5ilM7kzRyAsfmsCirmoKEr3dSWH1JfckoCWIWPHoxXcQDqZ
         /DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833187; x=1793437987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDNhZ9YjK/zlIe5trqHYSdI1fhNBLfzLRTmRchXqEEw=;
        b=xhBOpz6cB+4tu5FixOhp3T5E8ud41DMgo+vC2AoFwJqVonfhCoIweve96+e7l8Q/KI
         nVehhpB2EVfdNJjk10vLh2v/47bdZS0sKW9ms4ToNcwWkc4zao93AgaNsaMxuq3kiAKx
         zzo4QBoq6EoVHR16ZlGS3300LeT0kWc7gnBxMDRCpIpGIwB0KlbP4R6WT72GU2otzOvf
         ARYQFwOE5KML0Bsmbe4//uURC+giySUIzq3atVuAtQTG853Zwe+3owxa2lHlCOYH5X/0
         t5reLdE1NyIyWxq6p1DOFPneUpHiT5q9gGeBqcHx2bmoJ6wn2sYqvXcoN9WVVuMEIBpo
         8hlA==
X-Forwarded-Encrypted: i=1; AKwUvBxhoR/xF7qavOMwDRhF3uygUKVXRkPMSfsyGpRs1oN8pwn7W7zqmLXlb+k9Gbp+efg+QJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrxumyE/EvJUDQa2Ux5Kze1ewgq2CAxgeDYDyc+p6+5bezwG7+
	/fsJ+6yoJ5AAJWu8LYkBEFCJhJWvbo4J5ZdG5wakK0OMF4XZdGMaQicw
X-Gm-Gg: AYBFou3LTiGXn9lSeWe467msYzaxY8uCTIymRU2AsWwTVvk8cL0Y1T3ZQPKhZFCIA2E
	exvpkp4USdH/h+l5ovKVuLLd4soR6a+M/P0EAtRRaG9D7mvY2PxZppNlrMxB2jnHdB+OxpLq0Dq
	eKj4V9TLFSJ8J+vJkTtyijMA/zK4ZYacT7fY1NAkzU0MchfuZkRO+NTOA7x0yOji75OEraa1SIS
	DIMEzHhRXQW2JYyJ79/pbtkhTAucanJYnwuP5ejpWc02QSJk0t0Er/KbupJ0sTN2NjxWWyuPvN+
	WE4DVfP/BbqEhVqnL1ZzsD7EO3BjoTY8d3sKMETUcZs0qIu7gutvPb+iwzLi8mt9lmQIkWGygqw
	6v6q1xNXJIkda7rBsmvnZo9PPzVYrny94JoiLA7d3OmXDfKm3XV5u7GIrY5dScugVQ/3swIHIB4
	R9PZQRmitgSw98WJXOxPUmw9RCryYP3MeIMdO3ssZo8VB3lFx7TNM6U3hPkOmY7wHX7BAWzEDpy
	7mfwB5ZTZg5HCgbtGyMdbw8idJQUbwIZ9tNWourYkAlnsHyPcEp+TkEkYY82E/eZ6xfuacoPH5x
	leM=
X-Received: by 2002:a17:90a:da85:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3adeabde800mr1418906a91.29.1792833187236;
        Sat, 24 Oct 2026 02:13:07 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:20e4:738f:8d42:88af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebbb1a13sm2231965a91.2.2026.10.24.02.13.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 02:13:06 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] xsk: defer software checksum until the skb is complete
Date: Sat, 24 Oct 2026 17:12:56 +0800
Message-Id: <20261024091256.17918-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Add a selftest that sends the same packet as a single descriptor and as two
descriptors, verifies the expected UDP checksum, and compares the frames
captured on the peer.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c                                 |  25 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 299 ++++++++++++++++++
 2 files changed, 316 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..845ae6bde987 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	return skb_checksum_help(skb);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1270,6 +1270,15 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		if (!xp_mb_desc(&desc)) {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xskq_cons_release(xs->tx);
+				xsk_drop_skb(skb);
+				goto out;
+			}
+		}
+
 		xskq_cons_release(xs->tx);
 
 		if (xp_mb_desc(&desc)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..21a11300076a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -6,9 +6,12 @@
 #include "xdp_metadata.h"
 #include "xsk.h"
 
+#include <arpa/inet.h>
 #include <bpf/btf.h>
 #include <linux/errqueue.h>
+#include <linux/if_ether.h>
 #include <linux/if_link.h>
+#include <linux/if_packet.h>
 #include <linux/net_tstamp.h>
 #include <netinet/udp.h>
 #include <sys/mman.h>
@@ -38,6 +41,22 @@
 #define TX_MAC "00:00:00:00:00:01"
 #define RX_MAC "00:00:00:00:00:02"
 
+#define MB_TX_NAME "mb_tx0"
+#define MB_RX_NAME "mb_rx0"
+#define MB_NETNS_NAME "xdp_mb_csum"
+#define MB_UMEM_NUM 4
+#define MB_UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
+#define MB_UMEM_SIZE (MB_UMEM_FRAME_SIZE * MB_UMEM_NUM)
+#define MB_METADATA_LEN sizeof(struct xsk_tx_metadata)
+#define MB_PAYLOAD_LEN 128
+#define MB_SPLIT_LEN 64
+#define MB_PKT_LEN (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
+		    sizeof(struct udphdr) + MB_PAYLOAD_LEN)
+#define MB_TX_ADDR "10.1.0.1"
+#define MB_RX_ADDR "10.1.0.2"
+#define MB_SOURCE_PORT 1234
+#define MB_DEST_PORT 8080
+
 #define VLAN_ID 59
 #define VLAN_PROTO "802.1Q"
 #define VLAN_PID htons(ETH_P_8021Q)
@@ -543,3 +562,283 @@ void test_xdp_metadata(void)
 	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
 	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
 }
+
+static int open_xsk_mb(int ifindex, struct xsk *xsk)
+{
+	const struct xsk_socket_config socket_config = {
+		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.bind_flags = XDP_COPY | XDP_USE_SG,
+	};
+	const struct xsk_umem_config umem_config = {
+		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
+		.frame_size = MB_UMEM_FRAME_SIZE,
+		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG | XDP_UMEM_TX_SW_CSUM |
+			 XDP_UMEM_TX_METADATA_LEN,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
+	};
+	int ret;
+
+	xsk->umem_area = mmap(NULL, MB_UMEM_SIZE, PROT_READ | PROT_WRITE,
+			      MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+	if (!ASSERT_NEQ(xsk->umem_area, MAP_FAILED, "mmap"))
+		return -1;
+
+	ret = xsk_umem__create(&xsk->umem, xsk->umem_area, MB_UMEM_SIZE,
+			       &xsk->fill, &xsk->comp, &umem_config);
+	if (!ASSERT_OK(ret, "xsk_umem__create"))
+		return ret;
+
+	ret = xsk_socket__create(&xsk->socket, ifindex, QUEUE_ID, xsk->umem,
+				 &xsk->rx, &xsk->tx, &socket_config);
+	if (!ASSERT_OK(ret, "xsk_socket__create"))
+		return ret;
+
+	return 0;
+}
+
+static void close_xsk_mb(struct xsk *xsk)
+{
+	if (xsk->socket)
+		xsk_socket__delete(xsk->socket);
+	if (xsk->umem)
+		xsk_umem__delete(xsk->umem);
+	if (xsk->umem_area && xsk->umem_area != MAP_FAILED)
+		munmap(xsk->umem_area, MB_UMEM_SIZE);
+}
+
+static __sum16 mb_build_packet(u8 *pkt)
+{
+	struct ethhdr *eth = (void *)pkt;
+	struct iphdr *iph = (void *)(eth + 1);
+	struct udphdr *udph = (void *)(iph + 1);
+	__sum16 expected;
+
+	memset(pkt, 0, MB_PKT_LEN);
+	memcpy(eth->h_dest, RX_MAC, ETH_ALEN);
+	memcpy(eth->h_source, TX_MAC, ETH_ALEN);
+	eth->h_proto = htons(ETH_P_IP);
+
+	iph->version = 4;
+	iph->ihl = 5;
+	iph->tot_len = htons((u16)(MB_PKT_LEN - sizeof(*eth)));
+	iph->id = htons(1);
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = inet_addr(MB_TX_ADDR);
+	iph->daddr = inet_addr(MB_RX_ADDR);
+	iph->check = build_ip_csum(iph);
+
+	udph->source = htons(MB_SOURCE_PORT);
+	udph->dest = htons(MB_DEST_PORT);
+	udph->len = htons((u16)(sizeof(*udph) + MB_PAYLOAD_LEN));
+	memset(udph + 1, 0xaa, MB_PAYLOAD_LEN);
+
+	expected = build_udp_v4_csum(iph, udph);
+	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 ntohs(udph->len), IPPROTO_UDP, 0);
+	return expected;
+}
+
+static int mb_send_packet(struct xsk *xsk, const u8 *pkt, bool split)
+{
+	struct xsk_tx_metadata *meta;
+	struct xdp_desc *tx_desc;
+	u32 idx, num = split ? 2 : 1;
+	u8 *frame;
+	int ret;
+
+	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
+	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
+		return -1;
+
+	if (split) {
+		frame = xsk_umem__get_data(xsk->umem_area, MB_UMEM_FRAME_SIZE);
+		meta = (struct xsk_tx_metadata *)frame;
+		memcpy(frame + MB_METADATA_LEN, pkt, MB_SPLIT_LEN);
+
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+		tx_desc->addr = MB_UMEM_FRAME_SIZE + MB_METADATA_LEN;
+		tx_desc->len = MB_SPLIT_LEN;
+		tx_desc->options = XDP_TX_METADATA | XDP_PKT_CONTD;
+
+		frame = xsk_umem__get_data(xsk->umem_area,
+					   2 * MB_UMEM_FRAME_SIZE);
+		memcpy(frame + MB_METADATA_LEN, pkt + MB_SPLIT_LEN,
+		       MB_PKT_LEN - MB_SPLIT_LEN);
+
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + 1);
+		tx_desc->addr = 2 * MB_UMEM_FRAME_SIZE + MB_METADATA_LEN;
+		tx_desc->len = (u32)(MB_PKT_LEN - MB_SPLIT_LEN);
+		tx_desc->options = 0;
+	} else {
+		frame = xsk_umem__get_data(xsk->umem_area, 0);
+		meta = (struct xsk_tx_metadata *)frame;
+		memcpy(frame + MB_METADATA_LEN, pkt, MB_PKT_LEN);
+
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+		tx_desc->addr = MB_METADATA_LEN;
+		tx_desc->len = (u32)MB_PKT_LEN;
+		tx_desc->options = XDP_TX_METADATA;
+	}
+
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_CHECKSUM;
+	meta->request.csum_start = (u16)(sizeof(struct ethhdr) + sizeof(struct iphdr));
+	meta->request.csum_offset = (u16)offsetof(struct udphdr, check);
+
+	xsk_ring_prod__submit(&xsk->tx, num);
+
+	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT,
+		     NULL, 0);
+	if (!ASSERT_GE(ret, 0, "sendto"))
+		return -1;
+
+	return 0;
+}
+
+static int mb_wait_completion(struct xsk *xsk, u32 num)
+{
+	struct pollfd pfd = {
+		.fd = xsk_socket__fd(xsk->socket),
+		.events = POLLOUT,
+	};
+	u32 idx;
+	int ret, i;
+
+	for (i = 0; i < 100; i++) {
+		ret = xsk_ring_cons__peek(&xsk->comp, num, &idx);
+		if (ret == num) {
+			xsk_ring_cons__release(&xsk->comp, num);
+			return 0;
+		}
+		poll(&pfd, 1, 1);
+	}
+
+	return -1;
+}
+
+static int mb_recv_packet(int fd, u8 *buf, size_t len)
+{
+	struct sockaddr_ll sll;
+	socklen_t sll_len;
+	struct pollfd pfd = {
+		.fd = fd,
+		.events = POLLIN,
+	};
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct udphdr *udph;
+	int ret;
+
+	for (;;) {
+		ret = poll(&pfd, 1, 1000);
+		if (ret <= 0)
+			return -1;
+
+		sll_len = sizeof(sll);
+		ret = recvfrom(fd, buf, len, 0, (struct sockaddr *)&sll,
+			       &sll_len);
+		if (ret < 0)
+			return -1;
+		if (ret < (int)(sizeof(*eth) + sizeof(*iph) + sizeof(*udph)))
+			continue;
+
+		eth = (void *)buf;
+		if (eth->h_proto != htons(ETH_P_IP))
+			continue;
+		iph = (void *)(eth + 1);
+		if (iph->protocol != IPPROTO_UDP)
+			continue;
+		udph = (void *)(iph + 1);
+		if (udph->dest != htons(MB_DEST_PORT))
+			continue;
+
+		return ret;
+	}
+}
+
+void test_xdp_metadata_mb_csum(void)
+{
+	struct nstoken *tok = NULL;
+	struct sockaddr_ll sll = {};
+	struct udphdr *single_udp;
+	struct udphdr *multi_udp;
+	__sum16 expected_csum;
+	u8 pkt[MB_PKT_LEN];
+	u8 single[MB_PKT_LEN];
+	u8 multi[MB_PKT_LEN];
+	struct xsk xsk = {};
+	int tx_ifindex, rx_ifindex;
+	int pkt_fd = -1;
+	int single_len;
+	int multi_len;
+	int ret;
+
+	SYS_NOFAIL("ip netns del " MB_NETNS_NAME);
+	SYS(out, "ip netns add " MB_NETNS_NAME);
+	tok = open_netns(MB_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip link add " MB_TX_NAME " type veth peer name " MB_RX_NAME);
+	SYS(out, "ip link set dev " MB_TX_NAME " up");
+	SYS(out, "ip link set dev " MB_RX_NAME " up");
+
+	tx_ifindex = if_nametoindex(MB_TX_NAME);
+	rx_ifindex = if_nametoindex(MB_RX_NAME);
+	if (!ASSERT_NEQ(tx_ifindex, 0, "if_nametoindex(tx)") ||
+	    !ASSERT_NEQ(rx_ifindex, 0, "if_nametoindex(rx)"))
+		goto out;
+
+	ret = open_xsk_mb(tx_ifindex, &xsk);
+	if (!ASSERT_OK(ret, "open_xsk_mb"))
+		goto out;
+
+	pkt_fd = socket(AF_PACKET, SOCK_RAW | SOCK_CLOEXEC, htons(ETH_P_ALL));
+	if (!ASSERT_GE(pkt_fd, 0, "socket(AF_PACKET)"))
+		goto out;
+
+	sll.sll_family = AF_PACKET;
+	sll.sll_protocol = htons(ETH_P_ALL);
+	sll.sll_ifindex = rx_ifindex;
+	if (!ASSERT_OK(bind(pkt_fd, (struct sockaddr *)&sll, sizeof(sll)),
+		       "bind(AF_PACKET)"))
+		goto out;
+
+	expected_csum = mb_build_packet(pkt);
+
+	if (!ASSERT_OK(mb_send_packet(&xsk, pkt, false), "send single"))
+		goto out;
+	single_len = mb_recv_packet(pkt_fd, single, sizeof(single));
+	if (!ASSERT_EQ(single_len, (int)MB_PKT_LEN, "recv single"))
+		goto out;
+	single_udp = (void *)(single + sizeof(struct ethhdr) + sizeof(struct iphdr));
+	if (!ASSERT_EQ(single_udp->check, expected_csum, "single checksum"))
+		goto out;
+	if (!ASSERT_OK(mb_wait_completion(&xsk, 1), "complete single"))
+		goto out;
+
+	if (!ASSERT_OK(mb_send_packet(&xsk, pkt, true), "send multi"))
+		goto out;
+	multi_len = mb_recv_packet(pkt_fd, multi, sizeof(multi));
+	if (!ASSERT_EQ(multi_len, (int)MB_PKT_LEN, "recv multi"))
+		goto out;
+	multi_udp = (void *)(multi + sizeof(struct ethhdr) + sizeof(struct iphdr));
+	if (!ASSERT_EQ(multi_udp->check, expected_csum, "multi checksum"))
+		goto out;
+	if (!ASSERT_OK(mb_wait_completion(&xsk, 2), "complete multi"))
+		goto out;
+
+	ASSERT_EQ(memcmp(single, multi, MB_PKT_LEN), 0,
+		  "single and multi-buffer packets differ");
+
+out:
+	if (pkt_fd >= 0)
+		close(pkt_fd);
+	close_xsk_mb(&xsk);
+	if (tok)
+		close_netns(tok);
+	SYS_NOFAIL("ip netns del " MB_NETNS_NAME);
+}
-- 
2.39.5 (Apple Git-154)

