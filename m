Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01116374183;
	Tue,  2 Jun 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418842; cv=none; b=EbfuHslsn/1XatP0Ok8rvaQI3w+b+fcdIFeIj5vlRlEHqlJmj76uQ2eg/nA5nU2fjMxZMf8nbqEXJyH2GFy4mCVFDTgxQtMPug7sJc0Z6vT9XgeDYy0nGmV0dFMTWdF1vqjIx7yhU6TPtg56tbi1ElYneTTOsXdLddX3lNkM4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418842; c=relaxed/simple;
	bh=ifHszVRjFrIBcanDMdPrRhRVBf0l7st2Cz2vpTvYTfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBjS4Rp0lgQLI9cOWHsnaDCK1zNeudmyT4IbNPH++js2y+muz7t6FbIdOcpiQC78cNoQClEbx9m+s8+ezMrmzAX9VKj+TrjNin+viRA8jBGRVPSikbKf8FvwhmWufVqofjrAR5dfkNJYAXrDhFUrsCOkmltquE0pkR0ulCwL15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=otSnGF9i; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="otSnGF9i"
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 04ECE240952;
	Tue, 02 Jun 2026 18:47:16 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 5FB47240182;
	Tue,  2 Jun 2026 18:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780418834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WruLMJA0iJ7S2ar6pJyRzkagUYROHtj8HxN0Iab8eis=;
	b=otSnGF9i1TeJ4hfhm9JTcyd8qxTgvJiKPLMBhFK/sqKxObqFi4lTB9E0MdARkXrjWhGmAO
	sf7wsCtx240uNDAb1+RRfnQAKnmS/bT3cCKX0cZDXePBL/UOjeplKbqIErqfJvoh8lUCbf
	kb5mXeqixawztuH+0iaaWPR0R7pBprveEV/vY7DmXMabsY5M4DG+8TSOM23vB0f7zzmwGP
	J1hbCljww2BmI+7gJGq6Gl69Zvh1EvIt7FIxzOrc5VvAQmhpAgWy5vqrhT7O6CdA6BecN9
	gwnkqZA+9kBOk7XqJN3XsztALVTp4DRQrnegc0hqstpckTHSkQVXNY29NGRKBQ==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 94051240027;
	Tue,  2 Jun 2026 18:47:11 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Matteo Croce <mcroce@redhat.com>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v2 4/4] net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
Date: Tue,  2 Jun 2026 18:46:35 +0200
Message-ID: <20260602164635.62517-5-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602164635.62517-1-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: a692a4
X-Rspamd-UID: f03eed

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
index 397aa5ca4992..844f433975ed 100644
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
 
@@ -4042,7 +4047,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		ps.rx_packets++;
 		ps.rx_bytes += rx_bytes;
 
-		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
+		skb_reserve(skb, rx_offset);
 		skb_put(skb, rx_bytes);
 		if (metasize)
 			skb_metadata_set(skb, metasize);
-- 
2.54.0

