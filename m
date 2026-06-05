Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E853806C0;
	Fri,  5 Jun 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674329; cv=none; b=VoC8LN/ZxyxBbvzVDqf3Hdml2zN0zSdsiDXBY8c8Q3vch7u0TesZZ+s06lUvwYvykmuEhkRSzNCaVlKvSoC+gYfSRMTE4eAPdaZ7hBceS8+rvx/8ffNARWn9zUNTDjp3n0El8nNjmN9MPxJmDGLH/ytih+EzAqwZzK+POFXwTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674329; c=relaxed/simple;
	bh=WKJ5UODfxYR+CfqWr+7OySQFtpSHPGfBPqs504KLb1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxoD51r8s22EpEgc/1BVNNykkMDS7dLk3uq2AK5q6W8KCe500XIFaMWJhHmfcstTOyoGB40pIXCq8eOPckG/fO9wIBJPk7+gTUVT2kyDxck/PkmyTeDWqTRxAEgxQo3d1+7lpBAeEfqzlt9uOwIpPNuJu4BCnaAZWImytjVuLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=GE9EKmtM; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="GE9EKmtM"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 1E8E6240535;
	Fri, 05 Jun 2026 17:45:26 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 7B898240513;
	Fri,  5 Jun 2026 17:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780674324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWkvo5U1ZaxF235Fa0aIZyeQWAjHdlwHnsDbK7czZ1w=;
	b=GE9EKmtM0CuwCId9SiKpHvqjQAs/GVqw8RQYcAfOcLM3UcctW7UCtyf0Zan/4DwMcY9Dqs
	yD24H80LFaKdTbHX39iqWyzkhXkIkqnwOGj9W/pNdaHrOPvxBMFh1kbxHFDx6fg3nxzrhq
	l40Mdugzq1dEIPQdBFsFHTz+HYHT5QXxHnGimz7DK+rfazcV5AeHfXunBWY2TfutE+z9Wz
	72l68K3zyI+fOSkOfOSsIQWKHQ6cEo8Yo55OA+ppqLUc/AbBSsnuZXbX4Fg0fBFE1sIh9i
	yGsDdAws2nlvvmTwuegQ5DH3F9Rh/xG+8sSlYXESVwhk7WvqXWFT9C7pEsoHaA==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 1F254240326;
	Fri,  5 Jun 2026 17:45:22 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v4 4/4] net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
Date: Fri,  5 Jun 2026 17:44:57 +0200
Message-ID: <20260605154457.163304-5-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605154457.163304-1-mail@tk154.de>
References: <20260605154457.163304-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: d8c8b9
X-Rspamd-UID: 241b20

When an XDP program uses bpf_xdp_adjust_head() or bpf_xdp_adjust_tail()
and then returns XDP_PASS, mvpp2 still builds the skb from fixed offsets
derived from the original RX descriptor. Packet geometry changes made by
the XDP program are therefore discarded before the skb reaches the stack.

Update rx_offset and rx_bytes from xdp.data and xdp.data_end for
XDP_PASS. This makes skb_reserve() and skb_put() reflect the packet seen
by XDP, and makes RX byte accounting for XDP_PASS follow the length of the
skb passed to the network stack.

Non-PASS verdicts continue to account the descriptor length because no skb
is passed up in those cases.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 481daafdc1cb..dd30674148aa 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3920,7 +3920,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		unsigned int frag_size;
 		dma_addr_t dma_addr;
 		phys_addr_t phys_addr;
-		int pool, rx_bytes, err, ret;
+		int pool, rx_bytes, rx_offset, err, ret;
 		struct page *page;
 		void *data;
 
@@ -3933,6 +3933,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		rx_status = mvpp2_rxdesc_status_get(port, rx_desc);
 		rx_bytes = mvpp2_rxdesc_size_get(port, rx_desc);
 		rx_bytes -= MVPP2_MH_SIZE;
+		rx_offset = MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 		dma_addr = mvpp2_rxdesc_dma_addr_get(port, rx_desc);
 
 		pool = (rx_status & MVPP2_RXD_BM_POOL_ID_MASK) >>
@@ -3999,6 +4000,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 				continue;
 			}
 
+			/* Update offset and length to reflect any XDP adjustments. */
+			rx_offset = xdp.data     - data;
+			rx_bytes  = xdp.data_end - xdp.data;
+
 			metasize = xdp.data - xdp.data_meta;
 		}
 
@@ -4041,7 +4046,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		ps.rx_packets++;
 		ps.rx_bytes += rx_bytes;
 
-		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
+		skb_reserve(skb, rx_offset);
 		skb_put(skb, rx_bytes);
 		if (metasize)
 			skb_metadata_set(skb, metasize);
-- 
2.54.0

