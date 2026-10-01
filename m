Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337542FCA1
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827982; cv=none; b=JK7y9lSU5EZeyNnvNbvakwv8DaajAVHFr5INLCoV0ZALYpAohuya31iqYQgZbgcoghk0IpzM7FJIwEdAz2pZ2Zb08MmIlF9kEg11dK0tRWyOkGp30v6vFG1tZOHfgRIT+D5SA7UbMq2FSTfcf70dV3zVS+z3vOgbQLz6DSEMsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827982; c=relaxed/simple;
	bh=Hx5UJuxKjwprvSGWaXQVjVJ0w0ttNwljukD9w8lrWm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq7IXNgmt/9Jo1zCAcJTSLlP8Okq7FBAkSI/xbPwO4/PTatI/kU0rLNVbVJqkiMRAOuprVCfJ8jypueL2BOBLwRwziFkdZQ8eL6Bo/rgBwuefEsRgwcuhSoUqaQDSEGgp1sIVQ2IrzELL5dL/mA28yO1LKPTckZeHsoqqmASKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcUWHp7j; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcUWHp7j"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81d10e0cc02so1597610a34.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827980; x=1791432780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=CcUWHp7j9E+nNdSpLM5zkVVFJQT6pv9pYo04SvWma+tRmIjiRQWaaBYH0VFap1A6Li
         EGMa2dmmioyO6bj7p6Yt1ac2h7KReEXu92kyTi5e47rJtsYwy2M6YvyWRQ6lo/LlUXPC
         vSgufNyzMw2vQ2UsM6wDreK6BU/Ib/KikvHVp4aOuTTAto2H7Gyn6vp/X8XYMZAcXzbp
         JlWxQvBarZM1d9KkKxNxZF4aCX93WTHL4wY9HaAJWHWZI1R8iofOtBe5uD/DjY74cHQj
         wyt1ZHT3II8zUnFmuaXBMaciNvUkspp4xUZm4O/Lhd8VRxZukG2YdWcZNbaaaoIduI+c
         uJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827980; x=1791432780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=kmH+/CBgnLGJM9UK9ybjDIPoXyyQJxDfkNrFpE0r6kpnHvAOu45AuVtE7Jo2PDOLCj
         of0uQSKb1IIA22C9GC/RTThz44JBOqiNDJtOUFSW2NR0Q+8yRA9DJAk6Xtk9Usph0A+A
         Rj7zl8ePyqP0sUmMRu5crtF2aPBXCMcYbUX6LwcG54vBL3/dhjxQ1oisXwIg8oIFksUH
         Th4CZCJJwIKse3CXFXK5LflCMOpVLW+GuQOtM36Y7gk8HfvhFFBXRZwfbY3EWpX59sKG
         H5eUx8p0mvqB6YP1IDYjms4fqtyWZc3jnkRfLgixnm6zNgGCc/d8IN0s5ozfIexV6Xc1
         dxaw==
X-Forwarded-Encrypted: i=1; AKwUvByTt4qjoo10b8bMsOxoYnpmMeH14eKSrEh/rVdzP3XWpQnP0ksQtzRm5LPtYJeIJzghF3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mvvVoADrxh8qLdwYJFFELVQtFM3IxN2AN/TNp3s/sSBXArxw/m
	SSaRnnqJaTn+h0a/BNGspTIztX2j/6OLVMdj1war3ezsG2H7XUyJOSgp
X-Gm-Gg: AYBFou3x0H3rGaxUgsq4ihZWZv9cvomIi5dK9q345QSn+vCkqUaKLMBRBy+xz2NmvUE
	HlaF/gl89Pf6DEZwDTpF1+e8d6BRpU7TLhjXxNCo3+p4FnajYTcT/TLh2yRR5iXi5AzUPMmCfuC
	nlYRj1axTfSbFxo/P3/KPZhyztc5JBpMjg6jaJLkBhF1s1Ldpo0AIWRuoROoMTaZcfn9INJPp6n
	NusG4E7XDEqrgW7Y7dMrIVfhtWQqrc9lW4D8L/nTPF+i2pp9VF6HE36etzweDd6JIYiIGdTYVxI
	356XYiEIxQfquWUPcXNlrYT5AMJOR7AdwuqOp4+tndpjIZX2b1FP0QW+dYaNsEPH0s+ByB3X7Gs
	2TxFFxSXAHdjdgxpWpqkXcRLIEYATyQ2zsMlrmhV5zfwfhyEeOJ/mIzYkDKKlkBPEKyqPs1yc9Z
	5niE5Bw4zfJpJ/1jMh1z7cELQ8BosyyLxjwgf+Lv0laG07DjirWt6Co0vwn17qaxZGHPgnwKTk3
	vHTLz+ecdlVMAqVtNalzGqMHk5PHkK1E2wUQLnJ76rc0Yk6n8FUnu4WtdmC/v9RJ30uW0/QcQ9W
	7z3WOgQJ1pkYvbg7rRVDUPfchrEIHRpUHDE+V5BHS9DhANbAOU8/W6rRpktIHrhy5czhb0T0gvO
	/c8n3KxwZb963Xv2CNcT9
X-Received: by 2002:a05:6830:398b:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-82046ebb400mr4300712a34.4.1790827979789;
        Wed, 30 Sep 2026 21:12:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:12:50 -0600
Subject: [PATCH net-next v4 2/4] net: stmmac: pass the desired EST enable
 state to est_configure()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-2-9d4366587b73@gmail.com>
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
In-Reply-To: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive the EEST/EST_INT_EN bits from cfg->enable. This
decouples the hardware programming state from the priv->est.enable
flag, which records whether the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est.enable around the EST programming, as before.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index a8a5c8fdd5ed..1fd9f1ab316e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -617,7 +617,7 @@ struct stmmac_mmc_ops {
 
 struct stmmac_est_ops {
 	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
+			 unsigned int ptp_rate, bool enable);
 	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..f15d4d046aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
 }
 
 static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+			 unsigned int ptp_rate, bool enable)
 {
 	void __iomem *est_addr = priv->estaddr;
 	int i, ret = 0;
@@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
 			 EST_GMAC5_PTOV_SHIFT;
 	}
-	if (cfg->enable)
+	if (enable)
 		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
@@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	writel(ctrl, est_addr + EST_CONTROL);
 
 	/* Configure EST interrupt */
-	if (cfg->enable)
+	if (enable)
 		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
 	else
 		ctrl = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2a4099fe470c..64d890664421 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->est.enable = false;
 		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		mutex_unlock(&priv->est_lock);
 	}
 
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->est.btr[1] = (u32)time.tv_sec;
 		priv->est.enable = true;
 		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate);
+					   priv->plat->clk_ptp_rate, true);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 357d1eaf0d7d..67c6fc32d0ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1082,7 +1082,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate);
+				   priv->plat->clk_ptp_rate, true);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
@@ -1100,7 +1100,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
-			     priv->plat->clk_ptp_rate);
+			     priv->plat->clk_ptp_rate, false);
 	/* Reset taprio status */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
2.53.0

