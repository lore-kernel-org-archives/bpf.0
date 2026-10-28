Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155847;
	b=frKJxqPeYjKqEqm9ZTfwAw4ekmDXpjBZuzTGfQuxHPI0LzRLlDitSQ4E3UYoETtcfjdr
	 ubwQI9AjoORxpsVbprXl5inS88gPNGX1gE23k7fxSxs0jhOL/g5IJJBXpDqMj2zfceUc9
	 d0YsLXs3uF8Zibr1nhp+C3RB8UU3wKR9cylQJqynn3XBCeYbuxE68jdMgrHluHPN7yDfN
	 wreqyZC0Z8DYDzjb9gIcS4n+Rx7uw6Io7PEE6vDQn0XocIHWlSu0wGCIeUHqE6JQ/M1lN
	 JPiefoEs/+uDx8kIK5HbLXsB4aMxUp/0sN5VwxS40TEnY+AXuoYpsZzwOHbxlvwSzhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AzcWTO+plLWwZMdp/QBI7J2ezPiT1eBRX21oe2Waep0=;
	b=gcgJsuUJneuKe8GER2PPAib1kbd30N3jQzbmjfszeWQpp9ntu1XYFv9zYVQfEKtgPjXg
	 VuTW1E/beXuEXbXdH0UhZG8yBZhhckkLKq1q7HLlhaVVWmQAQjeZbim1k9+Ve3CcwifMg
	 Z5kO6NNFkzdy6yzabJmQqS7EOiLR5eH4z2GTJGa36TlILC7RT9Wj9CFWveW60PDq+/dWc
	 h7t+T08uAxFMronObOzFZKnR3qVgfaQ7JkKFmiHdy/lrD57bSOWlMhyjuJDvcsuzv2tG6
	 wRVVqjNXXdrMWuk4FRK65BGuF4bmgTGd1PKuh4t8TEJ7MOYwPiCT+1uati/I1EK2Z7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCxWXuMi;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3F606A325
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F3F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCxWXuMi
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e96be2196bso1228435ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155847; x=1793760647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzcWTO+plLWwZMdp/QBI7J2ezPiT1eBRX21oe2Waep0=;
        b=sCxWXuMiTRFMDv28AhbDMJMmQPvie5S0sxBQm3bJimPRpjEFtpCa1JBu5ZsUNOIKLq
         jG8U9FwN426AXiW2Y3e1Y0mQUi4KdJxku8NcE3UP6K+qjA3Q6NhPPpzCjElkoOAhef4h
         NPVeWsDcHDiG98KXSAeXMNtEvC/usBYVZvtYBlrgGSdUzZMDDWixCNG5vNtCME8IOoRA
         3V0ghIvToh3Ria/Q5f8v/8Qi5fH9YUSXbBc77iA+VLVlDFwjPJfha6puC4bx6eHiD7mU
         uP8jR+adwTQZqX0Rke4I9N4WAVGptpUu5glTdMckHu8WO9Qvk+1W0VCASPLS6Ezd5DNG
         GNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155847; x=1793760647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AzcWTO+plLWwZMdp/QBI7J2ezPiT1eBRX21oe2Waep0=;
        b=kNzagYPqpIRJ5c3sGK8DfFPMD1EqLEbDTyoqgDvhAan2um3c9ohrusjYP2vv2YCs/4
         Mt5e2NFFdCelpBMtrb6dsaaByYqm8/9A8e2YH/HGotyx+Jq5pumHMubuaHgVW9fQ5SWq
         IEcJ6vOtanpwxkd/RP1A5F6tKVdLFqwy6eFCrWRfOUEC9Duk5wUkLs1k6RONENfavTUY
         hK1LCXQ81yxv5nAGreBJyzkJXynHogRlXPb8RN+93o7psLr7dyHSh+ebTTywPWEOEeUy
         G4sxV5RsW6S3f3Tb6cliy0MNEDjmqGB4jfflfaog+IBU4EK9XLDch+RfMvdQs/Onmph7
         wobA==
X-Forwarded-Encrypted: i=1; AKwUvBzqlMEmrWiXrYu/TJQUHa2/dlNdy0U+b4fT+VJmYlbwDZdgbelsmfd8lbNL6KPme8eA11Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpufrnrzIZ/YMf/RnECPC+RT3tyt+RGsB85SOmwnBsSXCl5d2+
	s884rF3w6V9nsTNQq14hMd/LKu4ZBA4ME24iONfVuWx+G9lsxt327Rra
X-Gm-Gg: AYBFou3b6hH5qCzlx5myCLMZZkIOnoGNL3tY1whgJYT4LZFuVuA/oXXDeXe3VJXbtef
	hIQxn2YRTIT1BLVGjoOGx9n7QJNIT3o0q/9XvY5924z98SUQ34hcjXYlPC0YNWDTNhZegounQ+b
	1xbZtYFZLTExs7LL7aIoeZnlm4WcQI513q13lFOVNh2mM10AllUCDqxwtMNsXajKxOm6U6NdOZy
	QijU1P7/JlFPB8wr+KzRpIGqtXMwQoA/54GmtNe2gO3BTQTUBOYM0wAKuDb0FvZutUVGmpn+Bmz
	2rSucLAmalh4iVXdNqatE7znyIJta39CaQQTxVkjvRXjbEYGB1JRS6Wkf83JbsVurIl0bbtU0Ea
	3eAJRLHJUxkpR03U8cSiXxOaIs9xY24E+6E7GTHjjADM6/pfia/7ve0hB5vcXts+d7OKUPFoNNr
	DNfuIyGEvbEgtbDNdMGPtZS/Jeu8Nn/oAS6sroU8t68sWMbEvhVXD9sPGHS0qJUDvjm+G8B4gIJ
	/R73w7qUoFs+snm6XKQMh8ZbKXJiXbzx8IGh2prCZodaGxZiiWSL5Ghnf7uYgrEG9bfPFl6Y4M3
	pRmBzJqDKWiKbTVdClfmYBRtvZKTO6hnP9JyQpJohgCvE6rB6Ie3cl2YNBvK0/k=
X-Received: by 2002:a17:90b:280b:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3ae581049b1mr644411a91.31.1793155846816;
        Tue, 27 Oct 2026 19:50:46 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:45 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 10:50:26 +0800
Message-Id: <20261028025026.11401-3-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028025026.11401-1-testwrzwrz@gmail.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

Extend test_xdp_metadata to send the same UDP packet both as one TX
descriptor and as two descriptors, and to run the existing metadata and
checksum verification for both cases.

Reuse the existing AF_XDP setup, packet generation, completion, and receive
helpers in xdp_metadata.c instead of adding a separate test harness.

Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 122 ++++++++++++------
 1 file changed, 84 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..13de524c7fef 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -19,6 +19,8 @@
 #define RX_NAME "veRX"
 
 #define UDP_PAYLOAD_BYTES 4
+#define UDP_SPLIT_BYTES (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
+			   sizeof(struct udphdr))
 
 #define UDP_SOURCE_PORT 1234
 #define AF_XDP_CONSUMER_PORT 8080
@@ -56,13 +58,13 @@ struct xsk {
 	struct xsk_socket *socket;
 };
 
-static int open_xsk(int ifindex, struct xsk *xsk)
+static int open_xsk(int ifindex, struct xsk *xsk, __u32 bind_flags)
 {
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = bind_flags,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -133,31 +135,31 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static int generate_packet(struct xsk *xsk, __u16 dst_port)
+static int generate_packet(struct xsk *xsk, __u16 dst_port, u16 split_len)
 {
 	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
+	u16 pkt_len;
+	u32 num, addr;
 	void *data;
 	__u32 idx;
+	u8 pkt[256];
 	int ret;
 
-	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
-	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
+	pkt_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	if (!ASSERT_LT(split_len, pkt_len, "split_len"))
 		return -1;
 
-	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
-	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
-	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
-
-	meta = data - sizeof(struct xsk_tx_metadata);
-	memset(meta, 0, sizeof(*meta));
-	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
+	num = split_len ? 2 : 1;
+	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
+	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
+		return -1;
 
-	eth = data;
+	memset(pkt, 0, sizeof(pkt));
+	eth = (void *)pkt;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
 
@@ -180,18 +182,38 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
+	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
 					 ntohs(udph->len), IPPROTO_UDP, 0);
 
-	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
+	addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+	tx_desc->addr = addr + sizeof(*meta);
+	tx_desc->len = split_len ? split_len : pkt_len;
+	tx_desc->options = XDP_TX_METADATA;
+	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
+	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+	memcpy(data, pkt, tx_desc->len);
 
-	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
+	meta = data - sizeof(*meta);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP | XDP_TXMD_FLAGS_CHECKSUM;
 	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
 	meta->request.csum_offset = offsetof(struct udphdr, check);
 
-	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
-	tx_desc->options |= XDP_TX_METADATA;
-	xsk_ring_prod__submit(&xsk->tx, 1);
+	if (split_len) {
+		u32 addr2 = (idx + 1) % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+
+		tx_desc->options |= XDP_PKT_CONTD;
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + 1);
+		tx_desc->addr = addr2 + sizeof(*meta);
+		tx_desc->len = pkt_len - split_len;
+		tx_desc->options = 0;
+		data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+		memcpy(data, pkt + split_len, tx_desc->len);
+	}
+
+	xsk_ring_prod__submit(&xsk->tx, num);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
 	if (!ASSERT_GE(ret, 0, "sendto"))
@@ -224,24 +246,26 @@ static int generate_packet_inet(void)
 	return err;
 }
 
-static void complete_tx(struct xsk *xsk)
+static void complete_tx(struct xsk *xsk, u32 num)
 {
 	struct xsk_tx_metadata *meta;
 	__u64 addr;
 	void *data;
-	__u32 idx;
-
-	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
-		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
-
-		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
-
-		data = xsk_umem__get_data(xsk->umem_area, addr);
-		meta = data - sizeof(struct xsk_tx_metadata);
-
-		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
-
-		xsk_ring_cons__release(&xsk->comp, 1);
+	__u32 idx, i;
+
+	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, num, &idx), num,
+		      "xsk_ring_cons__peek")) {
+		for (i = 0; i < num; i++) {
+			addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx + i);
+			printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx + i, addr);
+
+			if (i == 0) {
+				data = xsk_umem__get_data(xsk->umem_area, addr);
+				meta = data - sizeof(*meta);
+				ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+			}
+		}
+		xsk_ring_cons__release(&xsk->comp, num);
 	}
 }
 
@@ -398,7 +422,7 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for RX interface. */
 
-	ret = open_xsk(rx_ifindex, &rx_xsk);
+	ret = open_xsk(rx_ifindex, &rx_xsk, XDP_COPY);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
 		goto out;
 
@@ -462,11 +486,11 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
 	tx_ifindex = if_nametoindex(TX_NAME);
-	ret = open_xsk(tx_ifindex, &tx_xsk);
+	ret = open_xsk(tx_ifindex, &tx_xsk, XDP_COPY | XDP_USE_SG);
 	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
 		goto out;
 
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
 		       "generate AF_XDP_CONSUMER_PORT"))
 		goto out;
 
@@ -482,7 +506,29 @@ void test_xdp_metadata(void)
 	switch_ns_to_tx(&tok);
 	if (!ASSERT_OK_PTR(tok, "setns tx"))
 		goto out;
-	complete_tx(&tx_xsk);
+	complete_tx(&tx_xsk, 1);
+
+	/* Exercise software checksumming of a packet spread over multiple
+	 * TX descriptors. The checksum is only computed once the skb is
+	 * complete, so both fragments must be accounted for.
+	 */
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT,
+				       UDP_SPLIT_BYTES), 0,
+		       "generate multi-buffer AF_XDP packet"))
+		goto out;
+
+	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
+
+	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
+		       "verify multi-buffer xsk metadata"))
+		goto out;
+
+	switch_ns_to_tx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns tx"))
+		goto out;
+	complete_tx(&tx_xsk, 2);
 
 	/* Now check metadata of packet, generated with network stack */
 	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
@@ -518,7 +564,7 @@ void test_xdp_metadata(void)
 		goto out;
 
 	/* Send packet to trigger . */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
 		       "generate freplace packet"))
 		goto out;
 
-- 
2.39.5 (Apple Git-154)

