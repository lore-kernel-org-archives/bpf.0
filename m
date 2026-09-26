Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C238656C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437795; cv=none; b=o5TcsdQvAg9/u/InPUp3MdelqzNgdINjEWRWvoq2HQjYox0lk6arEQvGgQVnU31UuG/pFoIAth5MQ5upYomI2DUKa/8NJmDlYhwTMsbeLEUfv7QJipuHL4NIQWnupJSsTAa9gxpz82L1vX0SQldOsjctowaTXMgWQ7mwC83iGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437795; c=relaxed/simple;
	bh=pXC6u2z4QzCd600gWVJtWtoFgabkjBB/NCPNcLpiYqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ju1LNM95OwYQ4PiLrDQWa4BqcXgQL3o+vECiXGiNNlIKnudIvaLBUD7WqiUav8JxXevJYEId0Rwpm/3U2kqd91Gu7ARwSILuFSgJYn5dW4eOaUQTCuMowIvKgOP8eiEb9x9pGMSn6RZl0o/D2JkPJNb99hsDbiPy96nic/eaJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glg8gZsx; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glg8gZsx"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81b8e8e9cb0so10248a34.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437790; x=1791042590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5KjS+S3ybo0qYcHE4tpSaMdCm52N9S5u9el69I6IvdE=;
        b=Glg8gZsxDBwwQ3v3m0xjVQ7Z8qBX/1N+dDd05ozo2melldlq/rovrQqFKynOgbUJ4o
         6tj4qQ95Ts9lWAumv956+bPRQOedRXbhzsqgxIcJCoK2thbIDic8ljGlAU5W1UD51KdL
         IjYTpQ51mLb+LnTwhzZmxN/T2LcN7cc8EGvSJBXgzJhXVMc//ny5JFmN6yUZFOkkWWz2
         xRFDW22E8WiYiCAbtQucfmKOODum6gtCrE88/WHabVOJI22x29aUECGJ8hYSB/ORpNm1
         qhit6hrrz/d0s5nzM0xOD3vivfeGUGL6mZ478PyrRiU1luzvx3i83dK0Z1vP7PKKWGGm
         DUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437790; x=1791042590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KjS+S3ybo0qYcHE4tpSaMdCm52N9S5u9el69I6IvdE=;
        b=UU+U5SK0Mp3JtyIJsHnCUk7TLwTd5lYd7HXMKZazhR2gg+GKmEBi5c78eXhxhxRk7N
         oNeagQEkxtYYpCNbDGbicGtVemSu7ArjJShU+AUWQG+rl+IpFHRr6AANFZnkn8ZpkrGY
         WpJyH3ErnHJ6oWxaw/+OkUNBQXm6R4oIjroHDX6vIoSPvaMN+jYKQV1OKsAb7pMQmScL
         s5rlGYHsJIEfXBmYgnt86C8lQSxqMlOmZtzkUY2H18evnRQ/V6EGdQat3hQQKzAKLXe4
         Eoo4PydupmIgMsteFryxRpHvU+4ETXiu0KneAyZiC8flEOppIDfNfNByrEW69J9vfwnz
         NoDw==
X-Forwarded-Encrypted: i=1; AKwUvBzM5aqJ7mCj/seKRAZdApTGVZzxC6ufBbbf1kO0y53thMj8ic8hNDPqKvuxwsdiu6Et8eI=@vger.kernel.org
X-Gm-Message-State: AFuF++n7GhNOnJdPKh6D7pdkZKXKQ1NfqUxgM8L9lKBql3fuaO9VoOow
	iCaU5VA3KLocKV9yRd78zXJBw4gRSpkA9g6KNpGBeWRtvBcrvzxOI0wg
X-Gm-Gg: AYBFou201W8JhBiWbktsckwbpGhZMajP4plJlrqd/CaFZAyMcZOaEG0glSqF92PAlFw
	gOaOpp/EtNZJeduWrSyYJDUx2Z0QZJ8tlWZaLIFveBQqaA6tCLohYcsAGHIO9SfpKQI/8idp/vZ
	avwX5PbfG4Tokg3sDqi/3cO0uFuUmdOhnZJllVhppGh+eqfOIFjggqQICwJ8GBKykoQLk0FV8+d
	2XUZuPrx/enHiAqZkBSCS+Og98mWULYePV74NaE6NQwh/BQijvQ1r58dVFbivVLkk92oqcqfrm5
	K52bTzUPBNf9ip1YsiBeZJdRq2OQ5X9Evl1cuIruSSXDq/u2QXjWwa/6PbmpVs+5nv6XFqEkRp4
	4jRAXDXn6bNmjngrCo7Qu2JHXauY7ke9iauAUMSfkeELKtIoG6vx7R5DGMUmci5LjlPVM//Xn8H
	QfDw38jQ554Mll5gi9s4sonjMPORZWg2L98304tHO0hH2hCQdcOfZHZXeY0tMzpQ5896Zbbz/FW
	4veh/urohtkuKp7Sp8eIA+q4a6AAeiDdN0WKkdYuSlvWTszYHF+WOS0GD1EQp1HE/ArwWP9n9w+
	X9jKqC1nfDgxTTOvDSJoAyfLV6e+UTCecivcpYwi9aknvucdMlPXHjfA2nO0NzvozdOywIOAwGM
	Oo3wUGl13ZD5TaygExZ3x
X-Received: by 2002:a05:6830:6b07:b0:811:72c5:bd19 with SMTP id 46e09a7af769-81783684b1bmr9913596a34.25.1790437789641;
        Sat, 26 Sep 2026 08:49:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:09 -0600
Subject: [PATCH net v4 14/15] net: stmmac: prepare device-local DMA
 interrupt quiescence
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-14-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
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
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.15.2

Add DMA interrupt-mask accessors for the supported cores and a
per-channel gate protected by the channel lock. A handler invoked on a
shared IRQ can then mask newly enabled device sources without
acknowledging pending events or touching rings being replaced.

The retained-ring MTU transaction will save and restore these masks and
synchronize the registered handlers. No interrupt-controller line needs
to be disabled, so other devices sharing the IRQ remain serviceable.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 11 ++++++++
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   | 11 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    | 10 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 11 ++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  5 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 30 ++++++++++++++++------
 12 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 422d3df21ed9..31bebb2a9bab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -374,6 +374,16 @@ static void sun8i_dwmac_disable_dma_irq(struct stmmac_priv *priv,
 	writel(value, ioaddr + EMAC_INT_EN);
 }
 
+static u32 sun8i_dwmac_set_dma_irq_mask(struct stmmac_priv *priv,
+					void __iomem *ioaddr, u32 chan, u32 mask)
+{
+	u32 old_mask = readl(ioaddr + EMAC_INT_EN);
+
+	writel(mask, ioaddr + EMAC_INT_EN);
+	readl(ioaddr + EMAC_INT_EN);
+	return old_mask;
+}
+
 static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 chan)
 {
@@ -579,6 +589,7 @@ static const struct stmmac_dma_ops sun8i_dwmac_dma_ops = {
 	.enable_dma_transmission = sun8i_dwmac_enable_dma_transmission,
 	.enable_dma_irq = sun8i_dwmac_enable_dma_irq,
 	.disable_dma_irq = sun8i_dwmac_disable_dma_irq,
+	.set_irq_mask = sun8i_dwmac_set_dma_irq_mask,
 	.start_tx = sun8i_dwmac_dma_start_tx,
 	.stop_tx = sun8i_dwmac_dma_stop_tx,
 	.start_rx = sun8i_dwmac_dma_start_rx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 4cb7e6c16bdd..2285eac69071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -264,6 +264,7 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.enable_dma_reception = dwmac_enable_dma_reception,
 	.enable_dma_irq = dwmac_enable_dma_irq,
 	.disable_dma_irq = dwmac_disable_dma_irq,
+	.set_irq_mask = dwmac_set_dma_irq_mask,
 	.start_tx = dwmac_dma_start_tx,
 	.stop_tx = dwmac_dma_stop_tx,
 	.start_rx = dwmac_dma_start_rx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index 5ffd3c1471c4..41579d10af3c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -118,6 +118,7 @@ const struct stmmac_dma_ops dwmac100_dma_ops = {
 	.enable_dma_transmission = dwmac_enable_dma_transmission,
 	.enable_dma_irq = dwmac_enable_dma_irq,
 	.disable_dma_irq = dwmac_disable_dma_irq,
+	.set_irq_mask = dwmac_set_dma_irq_mask,
 	.start_tx = dwmac_dma_start_tx,
 	.stop_tx = dwmac_dma_stop_tx,
 	.start_rx = dwmac_dma_start_rx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index fb0a4e156a7b..86b23ce39d6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -580,6 +580,7 @@ const struct stmmac_dma_ops dwmac4_dma_ops = {
 	.dma_tx_mode = dwmac4_dma_tx_chan_op_mode,
 	.enable_dma_irq = dwmac4_enable_dma_irq,
 	.disable_dma_irq = dwmac4_disable_dma_irq,
+	.set_irq_mask = dwmac4_set_dma_irq_mask,
 	.start_tx = dwmac4_dma_start_tx,
 	.stop_tx = dwmac4_dma_stop_tx,
 	.start_rx = dwmac4_dma_start_rx,
@@ -611,6 +612,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops = {
 	.dma_tx_mode = dwmac4_dma_tx_chan_op_mode,
 	.enable_dma_irq = dwmac4_enable_dma_irq,
 	.disable_dma_irq = dwmac4_disable_dma_irq,
+	.set_irq_mask = dwmac4_set_dma_irq_mask,
 	.start_tx = dwmac4_dma_start_tx,
 	.stop_tx = dwmac4_dma_stop_tx,
 	.start_rx = dwmac4_dma_start_rx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 9352107204eb..edccc09f0b03 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -184,6 +184,8 @@ void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx);
 void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    u32 chan, bool rx, bool tx);
+u32 dwmac4_set_dma_irq_mask(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 chan, u32 mask);
 void dwmac4_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			 u32 chan);
 void dwmac4_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 9af0565a9bca..477bdb081c52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -155,6 +155,17 @@ void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
+u32 dwmac4_set_dma_irq_mask(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 chan, u32 mask)
+{
+	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
+	u32 old_mask = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+
+	writel(mask, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+	readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+	return old_mask;
+}
+
 int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			 struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 970495bccfd2..4726801253f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -150,6 +150,8 @@ void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx);
+u32 dwmac_set_dma_irq_mask(struct stmmac_priv *priv, void __iomem *ioaddr,
+			   u32 chan, u32 mask);
 void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan);
 void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index bb907db8fca1..88d904ed4685 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -84,6 +84,16 @@ void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
 }
 
+u32 dwmac_set_dma_irq_mask(struct stmmac_priv *priv, void __iomem *ioaddr,
+			   u32 chan, u32 mask)
+{
+	u32 old_mask = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
+
+	writel(mask, ioaddr + DMA_CHAN_INTR_ENA(chan));
+	readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
+	return old_mask;
+}
+
 void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index ff83858ebc1f..30915d3f5230 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -256,6 +256,16 @@ static void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
 	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
 
+static u32 dwxgmac2_set_dma_irq_mask(struct stmmac_priv *priv,
+				     void __iomem *ioaddr, u32 chan, u32 mask)
+{
+	u32 old_mask = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+
+	writel(mask, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	return old_mask;
+}
+
 static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 				  void __iomem *ioaddr, u32 chan)
 {
@@ -604,6 +614,7 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.dma_tx_mode = dwxgmac2_dma_tx_mode,
 	.enable_dma_irq = dwxgmac2_enable_dma_irq,
 	.disable_dma_irq = dwxgmac2_disable_dma_irq,
+	.set_irq_mask = dwxgmac2_set_dma_irq_mask,
 	.start_tx = dwxgmac2_dma_start_tx,
 	.stop_tx = dwxgmac2_dma_stop_tx,
 	.start_rx = dwxgmac2_dma_start_rx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 3bc4d955ef5f..e1630e84e91d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -197,6 +197,9 @@ struct stmmac_dma_ops {
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 				u32 chan, bool rx, bool tx);
+	/* Replace and flush the full interrupt enable mask; return the old mask. */
+	u32 (*set_irq_mask)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 chan, u32 mask);
 	void (*start_tx)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			 u32 chan);
 	void (*stop_tx)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -263,6 +266,8 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
 #define stmmac_disable_dma_irq(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, disable_dma_irq, __priv, __args)
+#define stmmac_set_dma_irq_mask(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, set_irq_mask, __priv, __args)
 #define stmmac_start_tx(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, start_tx, __priv, __args)
 #define stmmac_stop_tx(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index e15bab9accce..9e711acb81fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,6 +146,8 @@ struct stmmac_channel {
 	struct stmmac_priv *priv_data;
 	spinlock_t lock;
 	u32 index;
+	/* Protected by lock; IRQ handlers must not access the DMA rings. */
+	bool irq_quiesced;
 };
 
 struct stmmac_fpe_cfg {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4d70645c4a4f..08049c05ffc4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3267,14 +3267,30 @@ static bool stmmac_safety_feat_interrupt(struct stmmac_priv *priv)
 
 static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
 {
-	int status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
-						 &priv->xstats, chan, dir);
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
 	struct stmmac_channel *ch = &priv->channel[chan];
+	struct stmmac_rx_queue *rx_q;
+	struct stmmac_tx_queue *tx_q;
 	struct napi_struct *rx_napi;
 	struct napi_struct *tx_napi;
 	unsigned long flags;
+	int status;
+
+	spin_lock_irqsave(&ch->lock, flags);
+	if (unlikely(ch->irq_quiesced)) {
+		/* A shared IRQ may still invoke us, and DMA initialization can
+		 * restore interrupt enables. Mask them again without acknowledging
+		 * pending events or accessing the configuration being replaced.
+		 */
+		stmmac_set_dma_irq_mask(priv, priv->ioaddr, chan, 0);
+		spin_unlock_irqrestore(&ch->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&ch->lock, flags);
+
+	status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
+					     &priv->xstats, chan, dir);
+	rx_q = &priv->dma_conf->rx_queue[chan];
+	tx_q = &priv->dma_conf->tx_queue[chan];
 
 	rx_napi = rx_q->xsk_pool ? &ch->rxtx_napi : &ch->rx_napi;
 	tx_napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
@@ -3995,8 +4011,7 @@ static void stmmac_free_irq(struct net_device *dev,
 		for (j = irq_idx - 1; msi && j >= 0; j--) {
 			if (msi->tx_irq[j] > 0) {
 				irq_set_affinity_hint(msi->tx_irq[j], NULL);
-				free_irq(msi->tx_irq[j],
-					 &priv->channel[j]);
+				free_irq(msi->tx_irq[j], &priv->channel[j]);
 			}
 		}
 		irq_idx = priv->plat->rx_queues_to_use;
@@ -4005,8 +4020,7 @@ static void stmmac_free_irq(struct net_device *dev,
 		for (j = irq_idx - 1; msi && j >= 0; j--) {
 			if (msi->rx_irq[j] > 0) {
 				irq_set_affinity_hint(msi->rx_irq[j], NULL);
-				free_irq(msi->rx_irq[j],
-					 &priv->channel[j]);
+				free_irq(msi->rx_irq[j], &priv->channel[j]);
 			}
 		}
 

-- 
2.53.0

