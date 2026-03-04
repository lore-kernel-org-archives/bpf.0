Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAD3DA5BD;
	Wed,  4 Mar 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648643; cv=none; b=lS/8Cvd7IdTZlOEF7UIcG+cLwvxBNCLKbb3dve50ug+M53EoP9oy9rOcUTNBSXMQ1r4dDIMLYbysFbRUuYHKy6A/+vMYBooKAekXh3fJGn059zeYGO0g9+CfEqb0C1dVbf3fnNg3e592GuZeg3hNYYB7NZacgXc5I8/kvvD2RC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648643; c=relaxed/simple;
	bh=G9KhzfbRPiUfwEZc2MDjN1mlwQlI2CXVD3V8Is7hDwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/p8DARDYSaaIwn8VbEBVwpRdG/oT5tH6w9uU73sDVXOlztTc0btEvhIJKXUa+AB2EINu3t2p5Bk+nT9GErEzzjmobH2yj5C7Qn7AKa7PfDx5BBSft5oZMHIm/AOScx7g8rABd6c1zSU6oYX8ndalmU7jWDusc8TaEprZ8XUKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YJQ1dArG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YJQ1dArG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 469DE4E42545;
	Wed,  4 Mar 2026 18:24:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CA2E5FF5C;
	Wed,  4 Mar 2026 18:24:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBF60103686F7;
	Wed,  4 Mar 2026 19:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648639; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VDNyDdnQCdnj1Wd9DXlEzXJRQVE56WRRVJ8JxqxAUF4=;
	b=YJQ1dArGAXDkbHnXGeHdKIL3S1SvbylyVlTi18BV/xgQCVyznb/yFtz2NAJWpHpECG/v8y
	GF9iwT7U0vXmYwchljltSjG4NZ3Qr5FKrkElFwgaMFgdZLqvN9EKKxUdboglgLLK8tt6gs
	2Mb1AkUDbzj35WCBN7aiMtZb4ogYP8iX8v8+4chG/FRtUuw7HwEXlOEPga2gQKetwVwpkf
	MYK12NAksYMxQ4NmmSxu7Qcjodhr1/Az39s6DqpVSrC+tVHj6Eofj7ANwx01gjG3frDkrb
	e9sNOsbkXS0cw023N+qgKE1rR8L25frAjLSWqaXzlYe9R15tE+VxmWXyUd3tWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:23:47 +0100
Subject: [PATCH net-next 4/8] net: macb: drop handling of recycled buffers
 in gem_rx_refill()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-4-3d036076abf5@bootlin.com>
References: <20260304-macb-xsk-v1-0-3d036076abf5@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-3d036076abf5@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The refill operation supports detecting if a buffer is present in a
slot; if it is, then it updates its DMA descriptor reusing the same
buffer.

This behavior can be dropped; all codepaths of gem_rx() letting a buffer
lay around to be reused by refill have disappeared. Said another way:
every time queue->tx_tail is incremented, queue->rx_buff[entry] is set
to NULL.

On the same occasion, move `gfp_alloc` assignment out of the loop and
into variable declarations. Its value is constant across the function's
lifetime. Also fix tiny alignment issue with the while statement.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 64 ++++++++++++++------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c1677f1d8f23..ed94f9f0894b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1351,18 +1351,18 @@ static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
 {
+	gfp_t gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 	struct page *page;
 	dma_addr_t paddr;
-	gfp_t gfp_alloc;
 	int err = 0;
 	void *data;
 	int offset;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
-			bp->rx_ring_size) > 0) {
+			  bp->rx_ring_size) > 0) {
 		entry = macb_rx_ring_wrap(bp, queue->rx_prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1370,41 +1370,33 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_buff[entry]) {
-			gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
-			page = page_pool_alloc_frag(queue->page_pool, &offset,
-						    gem_total_rx_buffer_size(bp),
-						    gfp_alloc | __GFP_NOWARN);
-			if (!page) {
-				dev_err_ratelimited(&bp->pdev->dev,
-						    "Unable to allocate rx buffer\n");
-				err = -ENOMEM;
-				break;
-			}
-
-			paddr = page_pool_get_dma_addr(page) +
-				gem_rx_pad(bp) + offset;
-
-			dma_sync_single_for_device(&bp->pdev->dev,
-						   paddr, bp->rx_buffer_size,
-						   page_pool_get_dma_dir(queue->page_pool));
-
-			data = page_address(page) + offset;
-			queue->rx_buff[entry] = data;
-
-			if (entry == bp->rx_ring_size - 1)
-				paddr |= MACB_BIT(RX_WRAP);
-			desc->ctrl = 0;
-			/* Setting addr clears RX_USED and allows reception,
-			 * make sure ctrl is cleared first to avoid a race.
-			 */
-			dma_wmb();
-			macb_set_addr(bp, desc, paddr);
-		} else {
-			desc->ctrl = 0;
-			dma_wmb();
-			desc->addr &= ~MACB_BIT(RX_USED);
+		page = page_pool_alloc_frag(queue->page_pool, &offset,
+					    gem_total_rx_buffer_size(bp),
+					    gfp_alloc | __GFP_NOWARN);
+		if (!page) {
+			dev_err_ratelimited(&bp->pdev->dev,
+					    "Unable to allocate rx buffer\n");
+			err = -ENOMEM;
+			break;
 		}
+
+		paddr = page_pool_get_dma_addr(page) + gem_rx_pad(bp) + offset;
+
+		dma_sync_single_for_device(&bp->pdev->dev,
+					   paddr, bp->rx_buffer_size,
+					   page_pool_get_dma_dir(queue->page_pool));
+
+		data = page_address(page) + offset;
+		queue->rx_buff[entry] = data;
+
+		if (entry == bp->rx_ring_size - 1)
+			paddr |= MACB_BIT(RX_WRAP);
+		desc->ctrl = 0;
+		/* Setting addr clears RX_USED and allows reception,
+		 * make sure ctrl is cleared first to avoid a race.
+		 */
+		dma_wmb();
+		macb_set_addr(bp, desc, paddr);
 		queue->rx_prepared_head++;
 	}
 

-- 
2.53.0

