Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470C3DA5AE
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648687; cv=none; b=jM2TcRqBavXcjDK1VDhPTjKJydBayJuPiV1Zx1+F9c4WX0IkTWNe8FcXiu71jby1SXpOzaTUPpro1Rz2DUcenUKzLGUavbBM9DH/8z2rjWk6ohbkYFfhpjbdgJUrtXbF5TLhKWZmR4u+x3QeFPeK2cbOoerylEh27r+FV/jwHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648687; c=relaxed/simple;
	bh=1kn1psIhiJQGixudWstdQUGbMnl65a2Ws9qkxb0h6vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaGzgutBMo0XZiZ+MY5vqnEjSqmyq1ZQPSGRAJpYkv+dKyVNoJ3XAwVpCLVlonq0sXdozCcwyLXS8s2JFhT+XVE298AmSQ/cyRVmGHlSmMEZRKaDNjsPT8lBkcx4VfPQAReDACa+goZrfHteYfib0UeWXCUQoU5HePcoI3AhxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSOTSxrp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSOTSxrp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F7AB1A2C8D;
	Wed,  4 Mar 2026 18:24:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63F6C5FF5C;
	Wed,  4 Mar 2026 18:24:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10862103695FE;
	Wed,  4 Mar 2026 19:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=afu30LFlXgCnEzNfi1TzEAIspkrLSXKZZ9DD7cZcOIc=;
	b=KSOTSxrpWkZQgzLiyoGhPRhMXy7ijJemYXH/1A9i1v912AqXLRj21WYaD9tFiOGBrCKjaC
	DPrNlF+fuYRgVpUeRfJGTKdDULcpjE5WWGS8rLuv8M1FtLNK10d3HfQyh3VAjAQO7GNHEX
	tsHKcUrF0nnXG62J3WnXVQETPMSYvVSnE4HXJG3jc+rahGYNtv6RMb6YdfKcnLLbt89bkR
	kfIhmWd+QrNxUb7kuK2YwM5aWlE/boa4/Q3eoV0/LCJULuX0fdaTQrq6JnVCPMhxsRbAio
	uKEWZGI7o6Y5u2FYBkocnEWkGixsWmIPk7W6Ke4J7TKrCONEj3kc53DKSvjrdw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:24 +0100
Subject: [PATCH net-next 1/8] net: macb: make rx error messages
 rate-limited
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-1-ba2ebe2bdaa3@bootlin.com>
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

If Rx codepath error messages trigger, they do not interrupt reception.
Kernel log gets spammed, we lose useful history and everything crawls
to a halt. Instead, make them rate-limited to keep old useful
information in the log and keep the system responsive.

No netdev_*_ratelimited() variants exist so we switch to dev_*().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a79daad275ba..ab73d1a522c2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1303,11 +1303,12 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 				  u32 desc_ctrl, bool rx_sof, bool rx_eof)
 {
+	struct device *dev = &bp->pdev->dev;
 	int len;
 
 	if (unlikely(!rx_sof && !queue->skb)) {
-		netdev_err(bp->dev,
-			   "Received non-starting frame while expecting a starting one\n");
+		dev_err_ratelimited(dev,
+				    "Received non-starting frame while expecting a starting one\n");
 		return -1;
 	}
 
@@ -1322,7 +1323,7 @@ static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 
 	if (rx_eof && !rx_sof) {
 		if (unlikely(queue->skb->len > len)) {
-			netdev_err(bp->dev, "Unexpected frame len: %d\n", len);
+			dev_err_ratelimited(dev, "Unexpected frame len: %d\n", len);
 			return -1;
 		}
 
@@ -1382,8 +1383,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 						    gem_total_rx_buffer_size(bp),
 						    gfp_alloc | __GFP_NOWARN);
 			if (!page) {
-				netdev_err(bp->dev,
-					   "Unable to allocate rx buffer\n");
+				dev_err_ratelimited(&bp->pdev->dev,
+						    "Unable to allocate rx buffer\n");
 				err = -ENOMEM;
 				break;
 			}
@@ -1666,8 +1667,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		buff_head = queue->rx_buff[entry];
 		if (unlikely(!buff_head)) {
-			netdev_err(bp->dev,
-				   "inconsistent Rx descriptor chain\n");
+			dev_err_ratelimited(&bp->pdev->dev,
+					    "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;

-- 
2.53.0

