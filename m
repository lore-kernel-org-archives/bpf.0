Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EA3DBD4C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648689; cv=none; b=cQ+ybbawto9RnCrW5yrSekl8/vWaKDcTYxLsDIKv+7NBYOALQTigBkfXQ+9iKrh6n2weIDFkdwtKO2haig+rsSZn/QDod43nbOH4dXHKlXrkYncWhGIS31uFf253xUyhQL3bAl37MHDx9Nna0MoZodFkHNjoFEJq/rzNkVz7QwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648689; c=relaxed/simple;
	bh=lR/31OvnWqMELBpLtLx85N3MW+LVO6QwM8QgYOp7nE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tODufVz1zIWLZ6QSe9NoSVFtebxrM4r7zMeJUJKBXn6RAInH6Hr6ruWNqjUcojDZZnyX4rM2KsnjvpReurrxlrRO4zUd1kIfijqN2jibiG6SOwMATWoU6tCnhFIAZm7cwAQ5BmpbluevoKf6n+LrYqHmk0hu8zmdmU/f0fIBNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PExWwYIy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PExWwYIy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 390634E42544;
	Wed,  4 Mar 2026 18:24:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C1125FF5C;
	Wed,  4 Mar 2026 18:24:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37591103695E4;
	Wed,  4 Mar 2026 19:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RKXDnQhH/EddQZ2g7wQh6dP4jPVhKwjH602UOlRULfw=;
	b=PExWwYIydaVRfi6sme5iJpEVrkn5wpp0eKVa+L+YOanEDC8j0zYgWTO3/hJRvJDBxpQ3Jf
	hxvPPW5eHv+aGDpn4/lSpboPXUXMdk7EcvaPmGUvLsGkcJt/V+ME0zJ5969jW0aFIzkT2i
	I9LnjRI3cx0Wf4QKDs3i3ggHgtUjkU6ta+IsHIxOkR/JGqU2D3SfGKJGmmoxsYacKEoa5S
	FzWqC4dQC8UYa4aHorpGGpctkDzrmh6nTiP19Ht9LrfQd97wTfqgzTeBFBeqRvtTm4dGJI
	AeRjO3LHs8iTKtciDj2qTMh1YllXCDTjuo90h7W5aSXjgxBjXrFrQBu/0T4TFA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:25 +0100
Subject: [PATCH net-next 2/8] net: macb: account for stats in Rx XDP
 codepaths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-2-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
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

gem_xdp_run() returns an action.
Wrt stats, we land in three different cases:
 - Packet is handed to the stack (XDP_PASS), turns into an SKB and gets
   accounted for below in gem_rx(). No fix here.
 - Packet is dropped (XDP_DROP|ABORTED), we must increment the dropped
   counter. Missing; add it.
 - Packet is passed along (XDP_TX|REDIRECT), we must increment bytes &
   packets counters. Missing; add it.

Along the way, use local variables to store rx_bytes, rx_packets and
rx_dropped. Then increase stats only once at the end of gem_rx(). This
is simpler because all three stats must modified on a per interface and
per queue basis.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ab73d1a522c2..1aa90499343a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1627,6 +1627,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int packets = 0, dropped = 0, bytes = 0;
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1669,8 +1670,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (unlikely(!buff_head)) {
 			dev_err_ratelimited(&bp->pdev->dev,
 					    "inconsistent Rx descriptor chain\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
+			dropped++;
 			break;
 		}
 
@@ -1700,11 +1700,29 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			if (last_frame) {
 				ret = gem_xdp_run(queue, buff_head, &data_len,
 						  &headroom, addr - gem_rx_pad(bp));
-				if (ret == XDP_REDIRECT)
-					xdp_flush = true;
 
-				if (ret != XDP_PASS)
-					goto next_frame;
+				switch (ret) {
+				/* continue to SKB handling codepath */
+				case XDP_PASS:
+					break;
+
+				/* dropped packet cases */
+				case XDP_ABORTED:
+				case XDP_DROP:
+					dropped++;
+					queue->rx_buff[entry] = NULL;
+					continue;
+
+				/* redirect/tx cases */
+				case XDP_REDIRECT:
+					xdp_flush = true;
+					fallthrough;
+				case XDP_TX:
+					packets++;
+					bytes += data_len;
+					queue->rx_buff[entry] = NULL;
+					continue;
+				}
 			}
 
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
@@ -1743,10 +1761,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		/* now everything is ready for receiving packet */
 		if (last_frame) {
-			bp->dev->stats.rx_packets++;
-			queue->stats.rx_packets++;
-			bp->dev->stats.rx_bytes += queue->skb->len;
-			queue->stats.rx_bytes += queue->skb->len;
+			packets++;
+			bytes += queue->skb->len;
 
 			queue->skb->protocol = eth_type_trans(queue->skb, bp->dev);
 			skb_checksum_none_assert(queue->skb);
@@ -1769,7 +1785,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
-next_frame:
 		queue->rx_buff[entry] = NULL;
 		continue;
 
@@ -1784,11 +1799,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 						virt_to_head_page(buff_head),
 						false);
 
-		bp->dev->stats.rx_dropped++;
-		queue->stats.rx_dropped++;
+		dropped++;
 		queue->rx_buff[entry] = NULL;
 	}
 
+	bp->dev->stats.rx_packets += packets;
+	queue->stats.rx_packets += packets;
+	bp->dev->stats.rx_dropped += dropped;
+	queue->stats.rx_dropped += dropped;
+	bp->dev->stats.rx_bytes += bytes;
+	queue->stats.rx_bytes += bytes;
+
 	if (xdp_flush)
 		xdp_do_flush();
 

-- 
2.53.0

