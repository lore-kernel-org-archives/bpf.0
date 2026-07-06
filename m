Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36953876BE
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354704; cv=none; b=HwAfKfKIHqJhaZInuxHFdMkgfLWxSK/xfPN5ZHZkdcm4t/aUjP0VqxwM0pZnUujFx3+Z0x8MhEE07YVOwGsrvNNz5JnHOj+FEndOZnfKHpHqL1u4JMRSuEx0pGzqwbIF1BkSloIzjOWlP7cDMlMhCX4piqSS11YMQE/PatGOvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354704; c=relaxed/simple;
	bh=ouoDiKxWTnKt6awRW6bwvPT2mUd8MHBQltXVbya7+3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EtmBr6yq6D2Et/P6QJjKtCNxmUhdaDWxUVCkN2jyquxuXiQ0+UOJvkLctp+nYci4wNc4l58ULPTeq3nTzMWR5/zoHcXjo13zvGmHX06ER4BDgH7HGlul47wti95S3jAfZiFC/Iqr4Gcc5Xlayl1xxYSMdSMlIqZYE74NURjetTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=PPHeES6/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="PPHeES6/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4758bd3731bso2248115f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783354701; x=1783959501; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfbCqchrlviXWCGPv/jztbOY6XLQs0x4v6xEVILnr0I=;
        b=PPHeES6/QaJF90DEwIrvL7o7zdF2C1306eiHy+WmCAMC03UkbCtlt/vdb1A/qxebO5
         db2XACO4Ag5kX9h3Uz4WmoVgygfmMEuc2IsMCbSHmDGg6c23RxHoI+yM2fAxZXAS3x70
         cp8FZl3r73b+upvhqRxFvQl+L+BQnyTqzgOAidN1xHfqL0T0cmeKMyVbQWWWeYEwyQG/
         WnJQUOMP0rbkPrk9BVCO5fFujpO4DrKVEn+RlRPhuFyCjemcEKTEJWlKkXPEekkadNqt
         P/pnEEm+0LCGQFtsF1rPmdZmN2JxgAsyiaesf/qiRYGODjL80e3pUsfasHZWDcIqfn93
         RFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354701; x=1783959501;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfbCqchrlviXWCGPv/jztbOY6XLQs0x4v6xEVILnr0I=;
        b=F2LgtcBz0scMCNkmYik9TrQqZe4d9nD0vVUeXMLxrqRVsddcp991E+veNfmMqyA6l7
         aaVu7TmLDBpgfRid40avlzq694Y+QMcD3LRgcLzH7sFQtiNnbnguCgc4L8x6QfxMcU6+
         vMxo+Q8WlrUcVvmp2AMDJQ358t3kgiKzO5EACwVLJNd4CNLTHftCZh5PjVpCshaEjnGc
         Ic2rKeWkxF3NRhlAhcd1F6tsmGOrxMlOsgM0YBrEfMc6k2QIsJ0Df1W5VBHR6v0stv2c
         gwBN2HdrH0mEnWBF81pYcx551UNEUlO/n9SzTciOmEa4zmPW2/pjs+4A6qCziF9rhJ+Z
         E5Yg==
X-Forwarded-Encrypted: i=1; AHgh+RrgSCQge1N172HVO4qRaqpSCPQqYpO0ZWNBWKvWXYlesnpnPqX/ElEWpWUaaEC/rQQ7oWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYXKvDqnkIxYH9Qowflc7WPf1OfU6zvgDGICTaBpvQvmiFHo9
	kXbAu1BVBVy21bwBapMb+nyOEJhsckVqV10KP5FE+YeALs4nJbcqBELg30ttAjVbOcg=
X-Gm-Gg: AfdE7cnlGiWjXbrAqYNAAxhEmtr8Uh/9HqcoL1oM0UGOFvTK/+eZraXeiFCWMTQ93Dp
	ZMFIz+sNzbylFq1vwXUUmx+2dJjMiK/RtoY2JZ5WSBGFa2JZXvLb8OEM5BUY2c0p4Al2Tl1ogFI
	pZJ4dS3hLxMBu5keRHz4bBIWUrNQ2qG4r+UWlrIMl7Qa0htAYw14gHWSUxuOmFMKl2Cp883lx2A
	tDhoOKe1TWLXjDsVUGPv/ybCuvzUuRUb+TdeNN0wxe9S38VxYAzqAKKRjHka9YJEl894PAJOvK3
	Zg3YhtJa5+O6SJ4ch62DlmdAORCFxmRYb8j19ddtMQsx04HOa7EVj01r83AFb01JEbqsc2YPgbU
	w+iVF/wdhIHCVr1mluuCkKkR6bVJPEj7Rav0tY3nCoLLKLF89txl/ugOk+CeXAw8p9XOpoWhhAX
	zSap823+JERjZS3axvI+KukGBpXcajJV5q1qekq6aWcNLlujJNdoC6DRXfY/fSXL62FhvJTXTr2
	bgR0t1/AY6Z2TBAQ7U5vCq0EzoN0xJ/V8UKZVajBFdCJJJEAhd2w1xGdsIwPpVq4RdlDlQEzg==
X-Received: by 2002:a5d:6f06:0:b0:460:d18:865c with SMTP id ffacd0b85a97d-479343d1d48mr18732847f8f.1.1783354700990;
        Mon, 06 Jul 2026 09:18:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm27210959f8f.37.2026.07.06.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:18:20 -0700 (PDT)
From: Daniel Thompson <daniel@riscstar.com>
Date: Mon, 06 Jul 2026 17:17:58 +0100
Subject: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
X-B4-Tracking: v=1; b=H4sIADXVS2oC/x3MQQqDMBAAwK/Inl2IAaPpV0QkjWu7B5O6CVYQ/
 27wOJc5IZEwJXhVJwjtnDiGgqauwH9d+BDyXAxaaaM6ZTB725oDU15X5zHEiWWbMjmZ4z9g77r
 W6rddet9AOX5CCx/PP4zXdQO0r0DCbwAAAA==
X-Change-ID: 20260706-tc956x-stmmac-no_irq_teardown-8a7592b9f8c1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5016; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=ouoDiKxWTnKt6awRW6bwvPT2mUd8MHBQltXVbya7+3Y=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBqS9U84VEoQ7ihoE0hX+1OTuNAmOcBS548F96qN
 5yoLvilNcCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCakvVPAAKCRB84yVdOfeI
 oZRjD/4loyK8Dfw5UMFNwkUH9J6/cduTpTFyaslQOTZJTESnRVyseHrhkeVw7cHf3Fi6SVgNmiG
 5yiOYnCAl2WRYSqjGDED6k0mI8ZSVLsz7XS0yFVoke/YtvpQFMAzF/OwWv+Y8iLVLBcQcYlOqYz
 KH4EWYUIQILEvgWHcqWoRmMylNh5ynvN//1ZfG6AISVM/NW7aWToqxh3gC6Mact5sUGFCaScdF2
 O29pPBz6ZWdVJO0sS/Ru7Jw3mK25+al+R4RO3zNF+RpnFy78jIqme7dronYMV59e0vqgrJMG4Eg
 VoqmBXNq2AQNiYIJsOCY+zvvaeOPkhovbZqHWOx3+TVLvj2s2Ycf1aUjJfzWg2fE9IxiqWHuTL3
 261j9O07uS0cnFKvYVPJjQrUpLhYaE9W7jb+KZDnrf/rBDrGC92b4AQhjy2ZDxK8aY7n+zUgtMv
 jehciE0ZzbEy8695AZ1hGEqAkefjWmgAI4QEv4VZWMdJwiCi7q8r3/jGZ0fgft7+XKVwGiZ1+YQ
 rmTGklEohkpxwxFUPQ+AqbHT6avTd7ViPUjfiRMUk2E6M2Brjqdo7vYN5W5pWLJooqG+hJw3zuW
 3Ryqi2C43hWrDS5bmTTMPtY649iAbbgYk8jVLjtT09V7pFHRRAYSZRa5ISCIdBXICaMnEahwzri
 n33WXOa1mrqhCAg==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently stmmac will run a full cycle of IRQ tear down and setup when
setting up a new XDP program. This makes tuning TSN systems difficult
because whenever a new XDP program is installed then the irq threads will
be stopped and restarted which will undo any thread tuning.

The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
from stmmac_xdp_release()/stmmac_xdp_open().

stmmac_free_irq() implicitly synchronizes interrupts and, with that
removed, I was unable to prove that later actions in
stmmac_xdp_release() are safe when there are concurrent interrupts. To
avoid problems let's also move the code to disable DMA interrupts earlier
in the sequence and explicitly sync the interrupts handler(s).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
This patch was developed (and tested) as part of the TC956x work that
Alex Elder and I have been working on. However the change should work with
any driver that uses the stmmac core so it makes sense to submit it as
a separate patch.
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 61 ++++++++++++++++++-----
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3ff1ffa57e224c25f9e77bc28ed10..acd145f1f3069fde6043a9118c793758c5c8f4c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2531,6 +2531,23 @@ static void stmmac_enable_all_dma_irq(struct stmmac_priv *priv)
 	}
 }
 
+static void stmmac_disable_all_dma_irq(struct stmmac_priv *priv)
+{
+	u8 rx_channels_count = priv->plat->rx_queues_to_use;
+	u8 tx_channels_count = priv->plat->tx_queues_to_use;
+	u8 dma_csr_ch = max(rx_channels_count, tx_channels_count);
+	u8 chan;
+
+	for (chan = 0; chan < dma_csr_ch; chan++) {
+		struct stmmac_channel *ch = &priv->channel[chan];
+		unsigned long flags;
+
+		spin_lock_irqsave(&ch->lock, flags);
+		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+}
+
 /**
  * stmmac_start_all_dma - start all RX and TX DMA channels
  * @priv: driver private structure
@@ -3814,6 +3831,33 @@ static void stmmac_free_irq(struct net_device *dev,
 	}
 }
 
+static void stmmac_synchronize_irq(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_msi *msi = priv->msi;
+	int j;
+
+	for (j = priv->plat->tx_queues_to_use - 1; msi && j >= 0; j--) {
+		if (msi->tx_irq[j] > 0)
+			synchronize_irq(msi->tx_irq[j]);
+	}
+
+	for (j = priv->plat->rx_queues_to_use - 1; msi && j >= 0; j--) {
+		if (msi->rx_irq[j] > 0)
+			synchronize_irq(msi->rx_irq[j]);
+	}
+
+	if (msi && msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq)
+		synchronize_irq(msi->sfty_ue_irq);
+	if (msi && msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq)
+		synchronize_irq(msi->sfty_ce_irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
+		synchronize_irq(priv->wol_irq);
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
+		synchronize_irq(priv->sfty_irq);
+	synchronize_irq(dev->irq);
+}
+
 static int stmmac_msi_init(struct stmmac_priv *priv,
 			   struct stmmac_resources *res)
 {
@@ -7108,8 +7152,9 @@ void stmmac_xdp_release(struct net_device *dev)
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	/* Free the IRQ lines */
-	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	/* Silence DMA interrupts */
+	stmmac_disable_all_dma_irq(priv);
+	stmmac_synchronize_irq(dev);
 
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
@@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
 	stmmac_reset_queues_param(priv);
 
 	/* DMA CSR Channel configuration */
-	for (chan = 0; chan < dma_csr_ch; chan++) {
+	for (chan = 0; chan < dma_csr_ch; chan++)
 		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
-		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
-	}
 
 	/* Adjust Split header */
 	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
@@ -7197,10 +7240,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
-	ret = stmmac_request_irq(dev);
-	if (ret)
-		goto irq_error;
-
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
 	netif_carrier_on(dev);
@@ -7209,10 +7248,6 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	return 0;
 
-irq_error:
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
-
 init_error:
 	free_dma_desc_resources(priv, &priv->dma_conf);
 dma_desc_error:

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260706-tc956x-stmmac-no_irq_teardown-8a7592b9f8c1

Best regards,
-- 
Daniel Thompson <daniel@riscstar.com>

