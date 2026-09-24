Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1064CA79D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271895; cv=none; b=NdWhMKDjhftoLdC7KXcEbTrGKLZbuw+iaebW67PxakNcfmzV1VgX4Tq1fZKzjDcxQc4xYXdF2JeVGzfYVeAdw6Zkft6RO/4fXcHhpE+P2vp6OCIA1SS3xVuGthKfGA57MFTaa+lemG9A613j8QPBEthFZiRz9fXMxXzI+C7KoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271895; c=relaxed/simple;
	bh=5y1WY6VfQEa6z9Uv81Qr6nawVi5OWrxat0IypjeFi8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfS1DT6mEftXTmnhH/RUIdBjuu870qiuhW+zPclQRtusaNdskN8bpe+WuZyTqMPovnVnB3eBIo74p9L6CqBHdd9r7MlYYgn2LSIftvX/oecaj3Cpc9rsLuA68o29AFn+oipnqM6glKRDN7f4BkVR3AJx+7YPNWTftRh+SE5F7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIa//JnI; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIa//JnI"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-491c13d63d9so141255fac.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271891; x=1790876691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxlMLeY3xGhSrBi9Qa91jcGZfKU8ZnUsiaHuYqFMG9Y=;
        b=AIa//JnIs+JBUhYcHYD2lgpLAYTUPDWB9A00NnsQFsrZkJV4ISJyhED/D9NlKY7IZo
         YarEBdjIOXWJjvi32DgH9idgi0Mxnm4bgTNsz1Q4UsxHs+y0UEe10kAZPGQvy55wmFjZ
         hl72KyRibv08j+bg64VWLzze2C5OU5dyBpKTxQWu6j5AdCcwRe7BTT0GKWEuhTmTUOza
         7PmtMSAbkqVLS/BDXrV3oLmHUF7Mhsf6dRvNYAs+m/wvcA8P+lXpkFOFsj6WrgXskvS0
         S8P5LaP+6h+hdGCFz1Cfer9/szhciW3jYT0LWv0ein5V8HPZ1x0YxZjOrJ0W88KbD7Mk
         pjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271891; x=1790876691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxlMLeY3xGhSrBi9Qa91jcGZfKU8ZnUsiaHuYqFMG9Y=;
        b=fO4yBXlZJdbN4fKZauRl8XUgkfnDuBWpIVyA0FV4EwLFndXb4pTJKoX4p30lW8E0uI
         U6W3gSccA2buNnV7INY/m2D/CQA2g3DQC0cupsL64NKxiSRfOlhlVp56kGtIufLAXkL9
         VUXnVmeNTITjkvUjVO75X8SL2nBxRoniQuBpf0W0uyEX4gXsJIjWf/CX1kVbnU/ldDCM
         pDe/cMFykBFQWLuO8/4rVA7cytYSMcpiMmVALK/fiKmO1dkDgc/9vhdlzj6PcH8kv8pY
         1nAFCBg+4A3vS3ZL5Ln3JxnfN/aWu8NR0DMoqZ/GZaIWDQXQadfypN2tmGutiBVjTPty
         ypgg==
X-Forwarded-Encrypted: i=1; AKwUvBxbK/4EWZCGvuyYEmAbb8VNx32PJUNn0zP3nJh3QNCDWx3TcT5qfGt7B99XolG19tLyFrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kOqW36sTSA4c+0hQw6PrUtliWcRqsjugR29A/R33nWTvEDY3BL
	lzq5ZdiUNby1j3QN4NFp9WovwpLOViQNuPXekpkb5fiIRz8IbUghrQxU
X-Gm-Gg: AYBFou1pB9cRf3SOFKkaslCtcW+FFtekaBCVLns/zsmkNgZA6Hnnscp246zPL3PtGu5
	REBFHLgdaQV7E+9CrBPaT6hvdoZDoqe5HOLvQGLFE5v6/mlXYXfYLzAAkXvksWXalK/SrWMe1Fq
	zIDZhtKjvfoEztSX727PKz8rVYY2QDkt2sEVRtpx30374eTybiLgEok6vftfwydaiqbUeGTwDHo
	n5TVFOJZJxz1zzKAe+ojVORJwwkSHlAB3K3Qv4RrWcOG93+uSppVWZ68y6vsy7tUDbgJzF7/wSf
	Z7MLdb0QPU0vOQ3j8JOkrp10bWsAzNHHlfH1sGzzwEdUzrQ2CFQWIscDEpVsIIB5ay3Imns5Amb
	hTVqvOEtrk1yYNX7JV5auMDjp8ilnSqW5Jy2IvpkCivEWuRoxJOIXFKznsIwpY+8GYGmKhofr8T
	FeCAitwj6wMl0DW9XGDMk72vDnfn6Xx1aG0QyfuB1DosUMsanxhDbw1J9eABE2r2YSR5SBLQud4
	2/M0gRImhesV1vJzzjriJQJa4MReoGYzYFz/penwl4gmyA/5x2GzGMqDtmM+W2iBm3WVY/aKZCZ
	g5k2nFSTQPfogiswM4m18THwgPKQr/NwyYL0U9hnPTjfAP1Kovlfszg0cpqp5ljy2Wy7mWVfVj/
	wyeuwxlaThiH/uAxVspTPTg==
X-Received: by 2002:a05:6870:888c:b0:48f:e0f6:c033 with SMTP id 586e51a60fabf-491e753aef1mr3023509fac.49.1790271891303;
        Thu, 24 Sep 2026 10:44:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:39 -0600
Subject: [PATCH net v3 09/10] net: stmmac: retain PHY and PM ownership
 during ethtool reopening
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-9-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Changing ring sizes or channel counts calls the complete ndo_stop/open
pair while the interface remains administratively up. If reopening fails,
the PHY attachment and runtime-PM reference have already been dropped, but
the next ordinary close drops them again. The device also remains present,
allowing an MTU change to quiesce NAPI which is already disabled.

Detach the device and release only the datapath during these live changes.
Use a common reopen helper which retains the PHY attachment and runtime-PM
reference and reattaches only on success. Restore the previous ring sizes
or channel topology after failure so a subsequent down/up retries the old
configuration. Leave the failed device detached and reject further live
ethtool reconfiguration until administrative recovery.

No additional outer-lifetime flag is needed: PHY and PM ownership continue
to follow the successful ndo_open/ndo_stop pair instead of being changed
by live datapath reconfiguration.

Fixes: aa042f60e496 ("net: stmmac: Add support to Ethtool get/set ring parameters")
Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 76 ++++++++++++++++++++---
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d56b7f911db0..d17c68f55caf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4361,6 +4361,8 @@ static void __stmmac_release(struct net_device *dev)
 
 	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
 	stmmac_stop_all_dma(priv);
+	/* Link resolution need not have reached mac_link_up() yet. */
+	stmmac_mac_set(priv, priv->ioaddr, false);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, priv->dma_conf);
@@ -7658,13 +7660,37 @@ static void stmmac_napi_del(struct net_device *dev)
 	}
 }
 
-int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+/* Rebuild only the datapath. The administratively-up device still owns its
+ * PHY attachment and runtime-PM reference, even if this reopen fails.
+ */
+static int stmmac_reopen(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = 0, i;
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
+	struct stmmac_dma_conf *dma_conf;
+	int ret;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	dma_conf = stmmac_setup_dma_desc(priv, dev->mtu);
+	if (IS_ERR(dma_conf))
+		return PTR_ERR(dma_conf);
+
+	ret = __stmmac_open(dev, dma_conf);
+	if (ret) {
+		priv->dma_conf = old_conf;
+		free_dma_desc_resources(priv, dma_conf);
+		kfree(dma_conf);
+		return ret;
+	}
+
+	kfree(old_conf);
+	netif_device_attach(dev);
+	return 0;
+}
+
+static void stmmac_set_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	int i;
 
 	stmmac_napi_del(dev);
 
@@ -7676,9 +7702,31 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 									rx_cnt);
 
 	stmmac_napi_add(dev);
+}
+
+int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	u8 old_rx = priv->plat->rx_queues_to_use;
+	u8 old_tx = priv->plat->tx_queues_to_use;
+	int ret = 0;
+
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
+
+	stmmac_set_queues(dev, rx_cnt, tx_cnt);
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		stmmac_set_queues(dev, old_rx, old_tx);
+		netdev_err(dev, "failed reopening after channel change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }
@@ -7686,16 +7734,28 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	u32 old_rx = priv->dma_conf->dma_rx_size;
+	u32 old_tx = priv->dma_conf->dma_tx_size;
 	int ret = 0;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
 
 	priv->dma_conf->dma_rx_size = rx_size;
 	priv->dma_conf->dma_tx_size = tx_size;
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		priv->dma_conf->dma_rx_size = old_rx;
+		priv->dma_conf->dma_tx_size = old_tx;
+		netdev_err(dev, "failed reopening after ring change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }

-- 
2.53.0

