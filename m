Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B97364E9E
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437775; cv=none; b=RhLWD+9eTfh8PTENqRvjL4poEFmPk7xq/yDERwwq3e7qShqTUK3pO9nj4QUbZDlYIO0RPknNODeNvNkfiEFKqWofz1p4fZXNwjFsKVVuNr2I0HrYIAim0NEsozSqg/4C4fwlFGxLpIpjcOS82P1dORGPUBTw+f/UZLYhgHWBLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437775; c=relaxed/simple;
	bh=QLLzCqU0wCcXmeIHIV8TgQgW9BBj0BKW1s7r4z+lcPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBPfnDyxmI70pAPchF11iVK+6QCmD+G1YJxceBW42ZDyjaqxy6486ks3Wk9LPQ4pQ2dr2pPPmb8RuAikkKhWo4qrvTVZkZlRsHPb00T8kC0ZMgH9t37YZDzaDsNMCpZWMKOY+Saf9YUNunrLbt9y6bUcFm78yGEOHaVCpnG5X2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emknx7si; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emknx7si"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-804f7045f3eso692861a34.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437770; x=1791042570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXuc4JFXb8UPUC0fNxWljunUCLVVXc20qC1Nh0LbmgY=;
        b=Emknx7siRYKk5lGoPo7pSlH9zRbLQHa0DpBtGnyhnfej7VTITr3FNhZL+7bKzKwGgg
         UPeG9p1HkD4RTMdTmA85HQAJHykQ6HE5zNpmoSy+anDOJ9QRYmywvGWzivwQ4cgQf1q4
         wSQkZUwRWNP+mKMhvsld/xrbeWljto3ffoJMKNJ3dMIy5zlsiRgXBr84JM7D36+OBSh/
         lMFJfwtdMb8yEfUwZbhMlCfr+JSgUiGT0QbQngmdEM1YQZe6Wxj2Q7IFv1Dy9F+o1Py7
         H+GEErAkFTK+dkfdfL4Jliks96E5rjUIxcLqNhgHBpQR7SCCG1Q2yD6TDJyV2zZD3mEe
         +2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437770; x=1791042570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXuc4JFXb8UPUC0fNxWljunUCLVVXc20qC1Nh0LbmgY=;
        b=c/mz0j26yie1HmmIRA/1wC3TInzIfJeKsMD0H0CYcES5ayUrea9xC4KtFMQJfNL6F6
         lxEf3IJUpSKSRylKznewD1hotPUFhTNo7jdYgsBv9OW05Oue1iNVqKaMevTY4ZVQbd37
         ACCc2oyO9oQ+k5E5dxEpMtwNekvPvBg4F7PKz8r0CKojbQDEadWj3YzldVOyPeW5lTOw
         Q0KfWJ6EVl8Qyc2MkALHdCzkof/Mw9qhfDUJAx+hNIn3eb7ECd3j9z4IC7t07Jt6tR+T
         UfjdwVR7YhFV01C1AnSzAoRRDkh7jekGAK2Fl2IRd7gKkW2kXdIG6Z/KtGsFSpjfA3i0
         Pcaw==
X-Forwarded-Encrypted: i=1; AKwUvBzEY0vn1SjnlqqKCA2256fDNkZ7ulhIUGv5F8v59fhdtaf0Mom8BQu+1O4OfFwbBQ9d5CI=@vger.kernel.org
X-Gm-Message-State: AFuF++neiyw/xVJa7EUxXQgad28IrU3FLfLme60EJnrgDkwoOUC0zLE2
	la5EfuABJZK4VNNuavUPgbBIaXcOuZGi2hj4LNkGPgumwzN0ZcVzo1PL
X-Gm-Gg: AYBFou1tj9i073ClshBmBYVsTC83QFDASJc0EWtMa+o+68OP4cwV+MM4xMDisEP5Yu4
	+01SFwg1//E3f4lRzhBU/bv3j0OPf16qXE4KXTUy/szhFEkJh/RXo67ZqDdge2/4i5OvaPEf9fy
	EtEwX+vbu064okENZ7PmuOHrPd/9I5sV3FjQ2Kc8NueetzMflxakK14ME7PD1IWV1MeRy/vXbjS
	vHhkmW0DnVyV0NMkVGXh7WggGBltFB4cse8VhxbNa5UkOjG6R4lLw4Zde998RKWY+YGUMfXXjF1
	xSQhOCDfRXYiQkSx4+QFqF2IV6Jp9x9pmoPgqwO1cOUEeGLSZO/Pos81yop0HP7tLNitMX3iHwQ
	d+7gkoeKICeRgQZZrEt0M9maHYiZSl4Q+DQmp1/THFFkoWkugB53UCclj0PVSYvIsg20LVIyNtc
	RK0vh4TQ2jhNLkPCh5X895yPDJ61i/wF++KquPBJExpIco+8YsPT/BurB4IGhIJhB1XsZHc+IzT
	JjdkKrTunKYhI8CKgVNHYCj/0WuISzfh9DdF+2hzzZptZBmSrVEmYtvnRVGtRi/pZpMkdyipsq7
	/Eewk2BF8OW3tYOIFp84KtPhO/gQC12l5si1tMnC8lIoYto5gt2UjefTbx++N5CJTWOR8mwya5p
	NlNExoukM/247RlzVVA13
X-Received: by 2002:a05:6830:334c:b0:819:60f4:56cd with SMTP id 46e09a7af769-81960f4adefmr3991885a34.6.1790437769815;
        Sat, 26 Sep 2026 08:49:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:00 -0600
Subject: [PATCH net v4 05/15] net: stmmac: serialize and retain PHC
 configuration across reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-5-ec1c0250b3c9@gmail.com>
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

Keep the frequency correction, PEROUT requests and EXTTS selection
independently of timestamp register contents. Cache PPS requests before
converting units so they can be replayed after reset.

Serialize timestamp writers and devlink timestamp-mode updates with a
mutex, and let atomic gettime callers observe a reset gate under
ptp_lock. Provide a common replay helper for later reset transactions,
without changing PHC registration lifetime.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   7 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  19 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 131 +++++++++++++++++++---
 3 files changed, 141 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index c7c876408d85..aa09b2defcd9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -337,6 +337,12 @@ struct stmmac_priv {
 	int use_riwt;
 	int irq_wake;
 	rwlock_t ptp_lock;
+	/* Serialize PHC changes with a hardware reset; gettime uses ptp_lock. */
+	struct mutex ptp_mutex;
+	bool ptp_blocked;
+	long ptp_scaled_ppm;
+	u32 ptp_perout;
+	u32 ptp_extts;
 	/* Protects auxiliary snapshot registers from concurrent access. */
 	struct mutex aux_ts_lock;
 	wait_queue_head_t tstamp_busy_wait;
@@ -404,6 +410,7 @@ void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
+int stmmac_ptp_restore(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
 int stmmac_get_phy_intf_sel(phy_interface_t interface);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4f3d452c3503..8b0bc7c46df9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -941,6 +941,11 @@ static void stmmac_setup_ptp(struct stmmac_priv *priv)
 {
 	int ret;
 
+	priv->ptp_scaled_ppm = 0;
+	priv->ptp_perout = 0;
+	priv->ptp_extts = 0;
+	priv->ptp_blocked = false;
+
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
 	if (ret < 0)
 		netdev_warn(priv->dev,
@@ -6285,7 +6290,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		for (queue = 0; queue < queues_count; queue++)
 			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
 
-		stmmac_timestamp_interrupt(priv, priv);
+		if (!READ_ONCE(priv->ptp_blocked))
+			stmmac_timestamp_interrupt(priv, priv);
 	}
 }
 
@@ -7696,6 +7702,14 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
+	unsigned long flags;
+
+	mutex_lock(&priv->ptp_mutex);
+	if (priv->ptp_blocked) {
+		mutex_unlock(&priv->ptp_mutex);
+		return -EBUSY;
+	}
+	write_lock_irqsave(&priv->ptp_lock, flags);
 
 	priv->tsfupdt_coarse = ctx->val.vbool;
 
@@ -7708,6 +7722,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 	 * reconfigure the systime, subsecond increment and addend.
 	 */
 	stmmac_update_subsecond_increment(priv);
+	write_unlock_irqrestore(&priv->ptp_lock, flags);
+	mutex_unlock(&priv->ptp_mutex);
 
 	return 0;
 }
@@ -8048,6 +8064,7 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 	rwlock_init(&priv->ptp_lock);
+	mutex_init(&priv->ptp_mutex);
 
 	stmmac_fpe_init(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dce..bc6fe0c87e01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -12,6 +12,16 @@
 
 #define PTP_SAFE_TIME_OFFSET_NS	500000
 
+static int stmmac_ptp_begin(struct stmmac_priv *priv)
+{
+	mutex_lock(&priv->ptp_mutex);
+	if (priv->ptp_blocked) {
+		mutex_unlock(&priv->ptp_mutex);
+		return -EBUSY;
+	}
+	return 0;
+}
+
 /**
  * stmmac_adjust_freq
  *
@@ -28,14 +38,21 @@ static int stmmac_adjust_freq(struct ptp_clock_info *ptp, long scaled_ppm)
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
 	u32 addend;
+	int ret;
 
-	addend = adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_config_addend(priv, priv->ptpaddr, addend);
+	addend = adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);
+	ret = stmmac_config_addend(priv, priv->ptpaddr, addend);
+	if (!ret)
+		priv->ptp_scaled_ppm = scaled_ppm;
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
+	mutex_unlock(&priv->ptp_mutex);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -57,6 +74,10 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	bool xmac, est_rst = false;
 	int ret;
 
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
+
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
 	if (delta < 0) {
@@ -110,6 +131,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
 
+	mutex_unlock(&priv->ptp_mutex);
 	return 0;
 }
 
@@ -128,14 +150,18 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
 	u64 ns = 0;
+	int ret = 0;
 
 	read_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_get_systime(priv, priv->ptpaddr, &ns);
+	if (priv->ptp_blocked)
+		ret = -EBUSY;
+	else
+		stmmac_get_systime(priv, priv->ptpaddr, &ns);
 	read_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	*ts = ns_to_timespec64(ns);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -153,25 +179,34 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
+	int ret;
+
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
+	ret = stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
+	mutex_unlock(&priv->ptp_mutex);
 
-	return 0;
+	return ret;
 }
 
-static int stmmac_enable(struct ptp_clock_info *ptp,
-			 struct ptp_clock_request *rq, int on)
+static int __stmmac_enable(struct ptp_clock_info *ptp,
+			   struct ptp_clock_request *rq, int on)
 {
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	void __iomem *ptpaddr = priv->ptpaddr;
-	struct stmmac_pps_cfg *cfg;
+	struct stmmac_pps_cfg pps, saved, *cfg = &pps;
 	int ret = -EOPNOTSUPP;
 	unsigned long flags;
 	u32 acr_value;
 
+	if (priv->plat->core_type == DWMAC_CORE_GMAC)
+		return dwmac1000_ptp_enable(ptp, rq, on);
+
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT: {
 		struct timespec64 curr_time;
@@ -182,8 +217,6 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
 
-		cfg = &priv->pps[rq->perout.index];
-
 		cfg->start.tv_sec = rq->perout.start.sec;
 		cfg->start.tv_nsec = rq->perout.start.nsec;
 
@@ -213,6 +246,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		cfg->period.tv_sec = rq->perout.period.sec;
 		cfg->period.tv_nsec = rq->perout.period.nsec;
+		saved = *cfg;
 
 		write_lock_irqsave(&priv->ptp_lock, flags);
 		ret = stmmac_flex_pps_config(priv, priv->ioaddr,
@@ -220,6 +254,9 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					     priv->sub_second_inc,
 					     priv->systime_flags);
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
+		/* Some cores convert cfg->start to binary rollover units. */
+		if (!ret)
+			priv->pps[rq->perout.index] = saved;
 		break;
 	}
 	case PTP_CLK_REQ_EXTTS: {
@@ -265,6 +302,64 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 	return ret;
 }
 
+static int stmmac_enable(struct ptp_clock_info *ptp,
+			 struct ptp_clock_request *rq, int on)
+{
+	struct stmmac_priv *priv =
+		container_of(ptp, struct stmmac_priv, ptp_clock_ops);
+	int ret;
+
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
+	ret = __stmmac_enable(ptp, rq, on);
+	if (!ret) {
+		if (rq->type == PTP_CLK_REQ_PEROUT) {
+			if (on)
+				priv->ptp_perout |= BIT(rq->perout.index);
+			else
+				priv->ptp_perout &= ~BIT(rq->perout.index);
+		} else if (rq->type == PTP_CLK_REQ_EXTTS) {
+			priv->ptp_extts = on ? BIT(rq->extts.index) : 0;
+		}
+	}
+	mutex_unlock(&priv->ptp_mutex);
+	return ret;
+}
+
+/* Called with ptp_mutex held and PHC access blocked across the MAC reset. */
+int stmmac_ptp_restore(struct stmmac_priv *priv)
+{
+	struct ptp_clock_request rq = { .type = PTP_CLK_REQ_EXTTS };
+	unsigned long flags;
+	u64 ns = 0, period;
+	u32 addend;
+	int i, ret;
+
+	write_lock_irqsave(&priv->ptp_lock, flags);
+	addend = adjust_by_scaled_ppm(priv->default_addend, priv->ptp_scaled_ppm);
+	ret = stmmac_config_addend(priv, priv->ptpaddr, addend);
+	for (i = 0; !ret && i < STMMAC_PPS_MAX; i++) {
+		struct stmmac_pps_cfg cfg = priv->pps[i];
+
+		if (!(priv->ptp_perout & BIT(i)))
+			continue;
+		stmmac_get_systime(priv, priv->ptpaddr, &ns);
+		period = timespec64_to_ns(&cfg.period);
+		/* Retain phase, but move an expired target into the future. */
+		cfg.start = stmmac_calc_tas_basetime(timespec64_to_ktime(cfg.start),
+						     ns + PTP_SAFE_TIME_OFFSET_NS, period);
+		ret = stmmac_flex_pps_config(priv, priv->ioaddr, i, &cfg, true,
+					     priv->sub_second_inc, priv->systime_flags);
+	}
+	write_unlock_irqrestore(&priv->ptp_lock, flags);
+	if (ret || !priv->ptp_extts)
+		return ret;
+
+	rq.extts.index = __ffs(priv->ptp_extts);
+	return __stmmac_enable(&priv->ptp_clock_ops, &rq, 1);
+}
+
 /**
  * stmmac_get_syncdevicetime
  * @device: current device time
@@ -287,9 +382,15 @@ static int stmmac_getcrosststamp(struct ptp_clock_info *ptp,
 {
 	struct stmmac_priv *priv =
 		container_of(ptp, struct stmmac_priv, ptp_clock_ops);
+	int ret;
 
-	return get_device_system_crosststamp(stmmac_get_syncdevicetime,
-					     priv, NULL, xtstamp);
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
+	ret = get_device_system_crosststamp(stmmac_get_syncdevicetime,
+					    priv, NULL, xtstamp);
+	mutex_unlock(&priv->ptp_mutex);
+	return ret;
 }
 
 /* structure describing a PTP hardware clock */
@@ -323,7 +424,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.adjtime = stmmac_adjust_time,
 	.gettime64 = stmmac_get_time,
 	.settime64 = stmmac_set_time,
-	.enable = dwmac1000_ptp_enable,
+	.enable = stmmac_enable,
 };
 
 /**

-- 
2.53.0

