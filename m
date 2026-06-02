Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF82387361;
	Tue,  2 Jun 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419310; cv=none; b=AcfXO/WtfK6oGkaMiVnRaYH1OprLz9aWRmbrg6J54y2K5Olwx+Ba3gzPKmNK8Nr724iiiv7FM6Ia/8gSwI/jNLLOnu7YsdDeeDnFTZrnS7Jy2q2HEXE8LMzgc9KHbyCepqtlQfBOHMTmoQfpU3y3oh1K6j10RK00vl1NyKLp03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419310; c=relaxed/simple;
	bh=L6xVsJW1n3JRrTFitY0+Isft+qNb0qUkFx79wsKhgDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxz17jNbIbLUNd6JwrK/wfXPgAN1RLWF9lX+/BY18Rriy24im3FK8Yjv+m2sP62d4ElzXlGKuVsh1iJaCpQoS+EIUx//aaUrMFwVQLutwd7Ks0Nz2OO7sggH9zgzrl3WkFgDZxGDU9XDxbupn8sU48YnvW2CDR0jTUOsHKcQyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=TTJOXr6q; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="TTJOXr6q"
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 3D873240909;
	Tue, 02 Jun 2026 18:47:13 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 978A624035A;
	Tue,  2 Jun 2026 18:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780418831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ivvgLLv6gSY8heQ+V/f8H1dO8uNi+l56MbtLBgS+NM=;
	b=TTJOXr6qq8p2TX83WWICXJ8wJOfguQ9Rj1Y38bIHTcV4whCFCGkKXxqmXuB88kve/VAX55
	cbTkOusQCsVP8dlr3JuG8bN9ms8Nosrl416J28c0GNojLG1FQY1HGhFprLq+F8RgyJONyp
	QOknnrJrQkpTwO1QpYsWc061crqSWBgzaTUr7ouvcHSElj4b/4eB0nTb7jbLPTe03Ev0oT
	Xc0A9fXUiKv5tufKx8az0dEUQmAEB2DeV7oAjRfdPmUhv2joKJHAvxswRljtySHL0V+Atp
	8eMgreMnz01l4j0eISFIeSzAip/oR1rpHLPvum5GwguIf02D4ZfnFPPw/+Tgxw==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 6D9C42400A3;
	Tue,  2 Jun 2026 18:47:09 +0200 (CEST)
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
Subject: [PATCH net v2 3/4] net: mvpp2: do not return retired RX buffers to BM
Date: Tue,  2 Jun 2026 18:46:34 +0200
Message-ID: <20260602164635.62517-4-mail@tk154.de>
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
X-Rspamd-UID: 6d1f2c
X-Rspamd-UID: 9de3f1

The RX refill failure path jumps to err_drop_frame, which returns the
descriptor buffer to the hardware BM pool. That is only valid while the
driver still owns the buffer.

After a non-PASS XDP verdict, mvpp2_run_xdp() may already have recycled,
redirected, or queued the page for XDP_TX. After build_skb(), freeing the
skb on refill failure also retires the data buffer. Returning either of
those buffers to BM lets hardware DMA into memory that is no longer owned
by the RX ring.

Split the error handling so buffers are returned to BM only while still
owned by the driver. Once XDP or an skb owns the buffer, only account the
RX error. Mark page-pool skbs for recycle before they can be freed on the
refill failure path, and unmap non-page-pool buffers before freeing them.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Fixes: d6526926de73 ("net: mvpp2: fix memory leak in mvpp2_rx")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 3372ed27cc8d..397aa5ca4992 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3991,7 +3991,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 				err = mvpp2_rx_refill(port, bm_pool, pp, pool);
 				if (err) {
 					netdev_err(port->dev, "failed to refill BM pools\n");
-					goto err_drop_frame;
+					goto err_drop_frame_retired;
 				}
 
 				ps.rx_packets++;
@@ -4010,6 +4010,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			netdev_warn(port->dev, "skb build failed\n");
 			goto err_drop_frame;
 		}
+		if (pp)
+			skb_mark_for_recycle(skb);
 
 		/* If we have RX hardware timestamping enabled, grab the
 		 * timestamp from the queue and convert.
@@ -4023,13 +4025,16 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
 		if (err) {
 			netdev_err(port->dev, "failed to refill BM pools\n");
+			if (!pp)
+				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
+						       bm_pool->buf_size,
+						       DMA_FROM_DEVICE,
+						       DMA_ATTR_SKIP_CPU_SYNC);
 			dev_kfree_skb_any(skb);
-			goto err_drop_frame;
+			goto err_drop_frame_retired;
 		}
 
-		if (pp)
-			skb_mark_for_recycle(skb);
-		else
+		if (!pp)
 			dma_unmap_single_attrs(dev->dev.parent, dma_addr,
 					       bm_pool->buf_size, DMA_FROM_DEVICE,
 					       DMA_ATTR_SKIP_CPU_SYNC);
@@ -4048,13 +4053,14 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		continue;
 
 err_drop_frame:
-		dev->stats.rx_errors++;
-		mvpp2_rx_error(port, rx_desc);
 		/* Return the buffer to the pool */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
 			mvpp2_buff_hdr_pool_put(port, rx_desc, pool, rx_status);
 		else
 			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
+err_drop_frame_retired:
+		dev->stats.rx_errors++;
+		mvpp2_rx_error(port, rx_desc);
 	}
 
 	if (xdp_ret & MVPP2_XDP_REDIR)
-- 
2.54.0

