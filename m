Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5F3271FD
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621272; cv=none; b=FDF1Y616HJiXZwIZcz4uU9X8UovrL40T+xHidkb4cGK1BTHYmzs3qvFdehjjxjqOx8UIIFQZBWb+vCV9OFnMja01A40xaiTBVII5C0bvcaEZokTK/AWGcAauJ0xNSm6tXqGDLYN+f+QmpI0WSV4EaP6nSALlXz7nvst0dv7tLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621272; c=relaxed/simple;
	bh=rWJMdH+guxvVRg/fYfPqNZhV8vkxgoYK2GCfMJpBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toCzmN0HLGk5Bi6awiodiJ/JgJxPSKVtNjzA/MGMNhYOtUf5bPpTT1TnMi+Y/wjjnGmtnSs8ko9KWyUSHeGMqRJfJ6/1KRi6q4uf+Shj+J5HoY2dVmEuHZNvlPURqPaErzvAq0kRIgyvfFyROFomgglWKn6LZxyYisqTxEfy/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hsqAdUk3; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hsqAdUk3"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-485ecc0f2dfso1164096b6e.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780621250; x=1781226050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=hsqAdUk3g0d8hX8GwxQMCFxWfR5jrXZTsrL+A5s1cWD0QycxMcDyH1YILlMcuJJjpP
         22zvT/jDunMY5iftF2R03vk3YUgCS2FUitNn+9iIG5B2qFwbPOjwdMOFlbv5OkasBIpW
         3z44NuIu3+zijT769bbC9L5/wfQKLOIEkanKhysKMwOTGV3gd61oa949rKcU7SJ7lQ/0
         8JGG+CNVRUUIu25eaWL7IzFGKmeE6em+wFG3qJJG6h2XGourhmlZq257M+JPyMh8YjOM
         QZXv81SzWB57ryPMbtBMPXdCInLf+qn7IFOYPJEoEC1i3uHCbFQ5xBkXsr7MXt5xqJYk
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621250; x=1781226050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=DY05tMmg9zQeXlbCC31pPcSvn51UJOJaLWVptwCD4StsvSh9yfHQkMKdC6Hl17AjZu
         +GhYEt0JGIFWeCbntka1zDDxiJRaj6+VG9VNZV9COW6ZFkX/gAAXfEjp/y7qSawr+uUc
         1uOLje46yRzh48uGww5mXHEGOUTX5hmO7DNxnufw8Wm4nCn4cHM1f05qBAG01ypFb7OL
         ouCVzmckwBL4vwKqXUqqDLtB6kpvuMg+E13bTbTcynNlUqLBs+ZOy/K5jlqvIyyJzXlv
         FkfNxgdq0++gLlFT7FONHfB7SFTbkcbSGRj9oozh38AJDaO8gjpkIXu+9oNCSzuga1/x
         v9vQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jOfyFt+7lySjIZFftvy43dHihZhr3gyvvsBh9Y6R4XqkikJYRANARX9duuI7yHZjZHpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjpDpJ7436Gy0y3fqpXnIqhRGg6JDs7P0m4RFYkaIHqa/+oZEQ
	reL3kMfPfsLTbtlkVTCEyf7cYDIUR4Ky4Ij5pWIMQMLH7dkoLV+7DJexIgH9k2vf10I=
X-Gm-Gg: Acq92OHvKx6CBlVWTIIA0tHffnvzGyI1Fq9xQweSlr1C6JyMG2RDBw0YtYziCSxLiQ8
	yAfmNwBeeR3M8c4TulcUYER5WHPOyiggSEdg/uMwW/oJZbTj0vCiP9iJYoEFa8VNzC7sX31dD7W
	k+w1oJb9zTM5hbsZDBV59q8dvWMYTEVUOww2E55Fuv4ekAxatGKqkQe1ekWse7d3kULyge93LCA
	+SBbfJo/Gav4rqQLmY4St6wW4qY44flUXPu86OVB0CqlAhBnGmxCIrQUHFc7PxX4nnoHPLFi6aw
	qLwBUR1bhNFKr8ke2/b686DJBEDJ6nkQ/Bi6jWW4GV36ER932eBGsdyQDxdXM9ZuFDWGCkqXizU
	akxn+V961d+WgwSNhptf6shooP8qZgeOQpYn+qaC2gQskECoYNH0CfjhGb+vNT+jqRRv1MPg8g/
	RtDKV2oTJFWFeMFPAVD0oF8n1VDXiwPteK4Xqc7A==
X-Received: by 2002:a05:6808:d4d:b0:485:4601:9c84 with SMTP id 5614622812f47-4868de44d92mr853906b6e.29.1780621250160;
        Thu, 04 Jun 2026 18:00:50 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm5544631b6e.5.2026.06.04.18.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:00:49 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 07/14] net: stmmac: dwxgmac2: Add multi MSI interrupt mode
Date: Thu,  4 Jun 2026 20:00:14 -0500
Message-ID: <20260605010022.968612-8-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently there are no XGMAC platforms integrated using the multi MSI
interrupt mode. In other words no existing driver sets both
DWMAC_CORE_XGMAC and STMMAC_FLAG_MULTI_MSI_EN.

In order to support systems that do enable both options (such as the
Toshiba TC9564 whose driver is currently being developed) we need to
add logic to the XGMAC DMA callbacks. Happily we can simply
replicate similar code from GMAC4. Let's do that!

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b03..9b0b5cc619556 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_INTM_MASK			GENMASK(13, 12)
+#define XGMAC_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df3..a84601ac32153 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	value = readl(ioaddr + XGMAC_DMA_MODE);
+
+	if (dma_cfg->multi_msi_en)
+		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
+					 XGMAC_INTM_MASK);
+
+	writel(value, ioaddr + XGMAC_DMA_MODE);
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
-- 
2.51.0

