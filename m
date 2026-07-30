Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071D42C4F5
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424153; cv=none; b=oGNdjJDf3UQ1z8C2kViNPdcubhIsxpzgiMGuAZftCbskJkDhMkVVW9OlYOJj5EnVrKnn0GEKyWVK6ig4L72Y0qkgdAMtVvO5SlLtOovw6yilcRlE13MyqLBdEMAL7FwyiMQB8PIWYqzUIdzA8uVoQl8DDSNs+NVrEwTfAU/oJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424153; c=relaxed/simple;
	bh=EjBhwYlGGfyzM1BU3Vc6X9Oo/bOBu2s2CFyDUXj54AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TYMck45evNRxjda700WnRSzK22Xo8U3SXcdTzI4HoCcTiJsWU6yxJgZbZno1zwRFQ3x410FX0H1rQ0IUe9KvbhPNftVaRvo/NJ+tVokaUbBLX6iTHIVxQNvf97uWkU37Dtl0ZK5KBIcPnfbKvBqUWOsvTpUC3F1cfgGK46ucEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aS9jF0YU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aS9jF0YU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so14929945e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785424150; x=1786028950; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Zf5vzNxpI+VaRkKc/ROtdJkeuI2Ow3+SYSByBSVT7Q=;
        b=aS9jF0YUhFDViZMaW8Rr26wDBjEg46ww96hmQY3ynkq38aTwnYdFLUTVpzw/6qDxqy
         3DAu+QN/P4/invP89PG+qmd2M7UcY4jFSCaD2oZoep7d8TiDv1Ni/N56eV/GBt4JvYEa
         M8/YDIVKQABnR+0Oz2FNLSfdWRGBURWkUrWCBhq+gZ7ybWaMJXCTjw9HYe/CemBBOYT2
         lOPM/29fTeQsBhdOisoWyAz2KTmGcmMNAFjjJgBCp7T93KkVR183HRz3i/aXklCOQ+W4
         DYF6q4YGJFzGbBXvZ5xKTyibmKWpV7qLVcaOfRk/cgytX58AXzr+StyJ5ned+aMJYX/Q
         FCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424150; x=1786028950;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Zf5vzNxpI+VaRkKc/ROtdJkeuI2Ow3+SYSByBSVT7Q=;
        b=tYVDU1G+C9e6tKSSyjRmlsOlXjA0Eps+g2HIFnf1Ku3GLYdlPbAw6uCdecVKHqLSqo
         1Gi052Y0LH67gukjGNjvhPePlwYwegzT+xibT7TToGjSm5KUZddU4wsF5+/7J6khtwZo
         VIhmau/9Sy3To/HIGp0+Hhl+mJKhKU5bDXZw62eaa6S8R11VLXPMRoWmNtRZuQ8sN5wO
         CnT+ROpbdzDnE6w21sDiBuMymCPpyjNFHXZZiWp1bg6ekcijypStxGXJVM6YN69EY0wR
         KhuwgLpWUBqfD6lKdMqtzFSt/Ay1/jagtNlv4zUiEiZ05EBQ4098d3vN41+YWQ0mJ2e8
         LdWA==
X-Forwarded-Encrypted: i=1; AHgh+RobMbeq+pRuGMUFlKGkFaH0pEIXTGiakpmLbBsfA9goti7YRzJmaX5KMpgpls0flyvbBQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD50y3yj+tFaOuAcDs7rjkO+SzYupcfjqxSlKN8ZkLhbhHeSgV
	BoinUpm81hPdfyQSCP7DPJiv975dV05LYIS0AUOOJsm5cUQ2hBp8Es2WIKPRUTEnUcA=
X-Gm-Gg: AR+sD11sODDiAAvRm0c56jbfdsyziPTI6wp8onIhD+eWyWZ42mQaekl8s948x7LtK5C
	Hc/QAWguVp7qcflvB1H5MKH58N863/A/2/eKL7ew9lCzsWA7u6KXZ3T41hZ1OcNuBTDQgqIhbSU
	NVvbiMtUReMC6zDcO6iylPoxpk3uBzcxc0L1kVExapPJ+kNN5ojNH2/fkCGKuHjl2qe8zsZPrZD
	ACZ/X4HjBky/bRx+hgxGbxRnBl++pCqM7klKB0/+ebvByr2ztpQ+MhwDCd2HuVfTZ7NF4sfAZMs
	iOgLuEQ84mPupeSXt9W6XdqplrhaxXlNduq6ZqWvYjFt7U4K17YVHOMVZTrcUdwPVAHABTH8jZw
	OVI6rN6XPc9NlL4kW771wD9fAyps3sseXbMj9KwLSU4U1ZnqImfsiuju1Am5GhdGsbGFromFcun
	qtXxKB/DOIG2GoKzv4to2IUa2PMkKOCgngu8z97jo0JmC/9srVMpOTIt06RLSL4kuxWGCbBMvmB
	BJ7jD9Hq5L1L6RLjjp/WvVlP0IxUCZXrb1BS5PMddsvbvpZSKZjC7Ncx1jcNOZZYHJB7hMZZCW1
	rS8OHkblIoNJbwpvn7Ol+QiVg3DmF+Bt0dfZW1m8Y82RhQ==
X-Received: by 2002:a05:600c:19cb:b0:497:fefa:6728 with SMTP id 5b1f17b1804b1-49800ea4a20mr42370975e9.24.1785424148974;
        Thu, 30 Jul 2026 08:09:08 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980120b64asm71465485e9.12.2026.07.30.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:09:08 -0700 (PDT)
From: Daniel Thompson <daniel@riscstar.com>
Date: Thu, 30 Jul 2026 16:08:35 +0100
Subject: [PATCH net-next v2] net: stmmac: Avoid freeing and re-requesting
 IRQ during XDP set prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tc956x-stmmac-no_irq_teardown-v2-1-a6c31932ba84@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAPJoa2oC/42NSwqDMBQAryJv3VdiwE+66j2KSMynvoVJ+xKsR
 bx7gyfochiY2SE5JpfgVu3AbqVEMRSQlwrMrMPTIdnCIIVsRSdazEY17YYpL4s2GOJI/B6z02z
 jJ2Cvu0bJSfne1FAaL3aetrP/gOAyBrdlGIqZKeXI33O81qf/87HWWKP1QigrZCcnf2dKJmXNV
 xMXGI7j+AHlF/wu1wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5779; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=EjBhwYlGGfyzM1BU3Vc6X9Oo/bOBu2s2CFyDUXj54AM=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBqa2kCPgWUwlb8AgcHHBi4cViRqgIFDvkySxlCE
 SY/qiTYJTaJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCamtpAgAKCRB84yVdOfeI
 oZR1D/4jb9C+dx4soJJvWVNeQDXplnucPK8Ko48P4S4yIrNAA2l5n3btcK0/OMKlpubG0ROEQmH
 udnGiXBxMl7IYcJzIu1YbCFamq36uI+tJ8Pc4o7JRhiObDzxFRg2JWos1T0LPVyxFBtgzgp3TRg
 e9Lq8aoaw6hOFalnvh3C5kb6HBNanWAQHAeHq9bsJvKWj/ccz3cMrTisd4bw2YQC3T/O6JC2zAs
 nGXwUjJ7sKXNUdtqXFfuQ5y6DCVl6CcTFvJ7whHG7TGIna6kwxYu8MzxxbH9HUQqN/kayFArnXT
 oIXlfvl9Q3ASaqZ938Zk2pFyWxg/cuWxlwqxvt9VphS5wJ/FulANBpVQSqNambQeE6bawlf3xXM
 RRgPjK1bMKnsbmamSWy4NWptmW6dhSpKT2sLxB/DddWmHYT62xlm9MeQZYRs+sDjPgQtWm6TM28
 xXDHG+0kF9UsHL+ehL4laM+BBVxty9aaxs2QblqU35lm6ITmOzW5VtVHdDfeprAdlEfhnhmQwvw
 C0F73ae1Ht2C7MMFnmXeK7hUwioVL3R5GBsdXAic5oxoWs6wIQR8F3ykyAxIFJPpncyUFOqhEy4
 fKRxCrf6RVvyCCbr+Z6fkT7u8Y6quOA2MgB53My2fYrrx8JyTzEyoF0sW0hY3e+PtGXT73ohI3B
 JFM9KnPQ5Lpvx1w==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently stmmac will run a full cycle of IRQ tear down and setup when
setting up a new XDP program. This makes tuning TSN systems difficult
because whenever a new XDP program is installed then the irq threads will
be stopped and restarted which will undo any thread tuning.

The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
from stmmac_xdp_release()/stmmac_xdp_open().

stmmac_free_irq() implicitly synchronizes interrupts and, with that
removed, nothing else disabled interrupts or makes later actions in
stmmac_xdp_release() safe when there are concurrent interrupts. Thus the
in addition to removing the code to free the IRQ we must:

 * disable DMA interrupts and explicitly sync the handlers in
   stmmac_xdp_release()
 * remove the code that (needlessly) reinits each channel to
   avoid the DMA interrupts being re-enabled (and which is
   safe because the content of priv->dma_cfg does not change
   due to XDP activity).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
This patch was developed (and tested) as part of the TC956x work that
Alex Elder and I have been working on. However the change should work with
any driver that uses the stmmac core so it it fully independant of that
work.
---
Changes in v2:
- Added net-next prefix
- Remove stmmac_init_chan() from stmmac_xdp_open() because it will re-enable
  interrupts
- Link to v1: https://lore.kernel.org/r/20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 64 +++++++++++++++++------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3ff1ffa57e224c25f9e77bc28ed10..3cf436014686ad2b65aa69a8fecea97379532576 100644
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
@@ -7132,7 +7177,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 rx_cnt = priv->plat->rx_queues_to_use;
 	u8 tx_cnt = priv->plat->tx_queues_to_use;
-	u8 dma_csr_ch = max(rx_cnt, tx_cnt);
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
 	bool sph_en;
@@ -7155,12 +7199,6 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	stmmac_reset_queues_param(priv);
 
-	/* DMA CSR Channel configuration */
-	for (chan = 0; chan < dma_csr_ch; chan++) {
-		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
-		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
-	}
-
 	/* Adjust Split header */
 	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
 
@@ -7197,10 +7235,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
-	ret = stmmac_request_irq(dev);
-	if (ret)
-		goto irq_error;
-
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
 	netif_carrier_on(dev);
@@ -7209,10 +7243,6 @@ int stmmac_xdp_open(struct net_device *dev)
 
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

