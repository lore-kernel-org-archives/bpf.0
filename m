Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE23D890B
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546416; cv=none; b=JbmgFi1B5WYX74VgWe9kOyH13N3ioygvUhsU0Ot56LgKEKxITY3Z0qYK6wgp/DegxCO21WczsR0uFqG4IxLiL3IPKu2A7rjnF2/mmzIs6lIyGJEuksCL08YgF3cbxqY++2uXvmITxZf5ZHiPLrCaPp5Wfnl5eM9+C/6N3GzzCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546416; c=relaxed/simple;
	bh=fNZ5W/2/Y9NhrCFRu5mYO39BRvhOqZwKJ2T11wGGYzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaH1sQZXi1xYa930Qww7ccUyPEi+82v1vFbgUV9NAq2eThJdT8wYScMYMDuERe5ltaes2Dl1rA9eQ1LAdIIfTSu4irNn2WgaRuCbjmWPMZJES9c5lZlRRBwL2RYXiyKgyP0ob+6/Hh0NwB7TjkQRGr2I7yIQhd43G/DArG8nHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJsfzpXJ; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJsfzpXJ"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so1519760a34.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546406; x=1791151206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNKzZPMQKhE7hSuOi9nkQONCJww90d0QAWF4qh7OtfY=;
        b=KJsfzpXJ6zBr4ANn1zMo76eJ4vUQ+Q/UAniVWHM08KcY7I8LlKLjRZ2IYJWimkU0dP
         vG3mKWIoEiLLF3WYiMEGlmA6iYHw5G3jphoUa9ysv1KcUuPRvZOYqUYUGCEZzDGnYeNI
         VREN9wakPpIbSNiJMMVquywfRj3IPLCSumQpu0jiemSYbfbhRrSRM06MXpRMwXir43JO
         wqff3DEEd0jO7VxbTxHFx1fj+VorTaD9lEb0+ispHS+Sh+9ceJirr2VjLpl6Pwh1TEad
         hk/YlwE9bOP+SLb011IF/wAAljUOacghOO6syE3lpdx+mGWR38Nwi6pbP4KzfdkNQ/Rj
         z4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546406; x=1791151206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNKzZPMQKhE7hSuOi9nkQONCJww90d0QAWF4qh7OtfY=;
        b=HHA75HiRVq36Q8TL4h/SAcG5Tijhw254f4mgUXdSLng+lAtl5Me0pTCAgmk4Ym0qLT
         dZB7FrPsbytDcyX5o9/tmI+hDOFmNjyv5jLFalEDT5IV6jCd1vyFBK8Z5TPQ8+NjgXmq
         5dJUx6cQV8b5CW4TNgL3Q7hpM3WeiUSJnUn9ZWNEajwjGV2PPcUXbejHPNp1pJYiYNGf
         9ReU1Ph0kvWMyUaJJAA97PrUwgj+usu9REZsTgM7BRprs8ePLZs3Vcs9+IT0otqzOFwd
         mI+UhGNV0hOZuXsoFjmEKotBM421fU151xrtCMl+n/X7SWGlab3bUjRFltc04AiSI5+m
         BsoA==
X-Forwarded-Encrypted: i=1; AKwUvBwdeH2UznRb2Ql02sFimgRz9ll4DrlsLC8wEoZmdoXP1xTTXw2Rmb1agAPWwwBtBVPu1Rs=@vger.kernel.org
X-Gm-Message-State: AFuF++ky36lzukZobYbMyCB13AfRZ/VBprOYrRsEoKYiwBjYs48NYzlm
	NA/NoX3zu5dUmvCaocFMTOycO9wV7WTXFDArMajC/KCaIa5kzyO8kwZ3
X-Gm-Gg: AYBFou3h6xo8q5wcRY9R632pYfp7kh6BshCjOao49xZ2CZeETM+BEiSkuLC6UgvqJA9
	bkeCgMoYbJk2Cpwqec3nkvM7UDxFPQxPSe+bperHSQ+IULWmDEW8Grub6iR3s0qLafsSOWo1YzF
	q/OdX6NblW5WGZK5UXFEiYAJ5FH4CJm6C/uiwX8K/QyjOgN0Xlauvcgw67Xdlx9LBiVWJCUz6h2
	tMvr2953i18DwDi1NIZJ+HqRBpDIpe/dhksXnkpEWbr2fTIutrHzW8Pqw3hgBzusXqeDnVgN7Mo
	C0Livmv2WJsKcKGtoa9PrKgIUNNuExMflRmsyqQKibn4RHbIXxS7synAiIbCAgtODjKpkq23abk
	q77HDw9wxCQA7v7TmBeo243cy9K7P/JNSGl+G7s+051XS3Viiy6d9LDIprYcOJLrOuoYrtuZ804
	nTnW6yaJNovWvpab87u++6UoI3/jsF4811H9T/NlP6azjDECjKO9xtIIIoP3ua/CIMsR62k23m8
	KcTuQ/OQ/fBwAFoIUnUUp4zvppgtAMXEuuwj6fvo7TWbs3EtT3LRAYK5sdd1Suhl4NS9anQGhDO
	9eq1Gh1mJv/jdzm+YOMnVCeORNuNhWlF9Echapmq5A795KB+WqH3aLkScAbRLICrLGQrMlPjDL4
	YMvbyme+L69Sf0F/49LzA
X-Received: by 2002:a05:6830:2992:b0:814:8259:780c with SMTP id 46e09a7af769-81782b84589mr12482123a34.19.1790546406167;
        Sun, 27 Sep 2026 15:00:06 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:43 -0600
Subject: [PATCH net-next v5 08/19] net: stmmac: serialize and retain PHC
 configuration across reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-8-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Keep the frequency correction, PEROUT requests and EXTTS selection
independently of timestamp register contents. Cache PPS requests before
converting units so they can be replayed after reset.

Serialize timestamp writers and devlink timestamp-mode updates with a
mutex, and let atomic gettime callers observe a reset gate under
ptp_lock. Provide a common replay helper for later reset transactions,
without changing PHC registration lifetime. Reapply the cached frequency
correction when recalculating the timestamp increment, including a
devlink change back to fine adjustment mode.

Hold est_lock across the whole PHC time adjustment, including EST
disable and replay. Return hardware errors instead of reporting a
successful clock step with EST left disabled. If the clock update
fails after disabling EST, still try to restore the installed schedule
and preserve the first error.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Keep the programmed addend consistent with the cached frequency
  correction when changing timestamp increment or adjustment mode.
- Propagate EST disable, clock-update and replay failures from adjtime,
  keeping est_lock held throughout the transition.
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   7 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  23 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 163 ++++++++++++++++++----
 3 files changed, 164 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index c65d95fc4760..23fd883d0509 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -340,6 +340,12 @@ struct stmmac_priv {
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
@@ -407,6 +413,7 @@ void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
+int stmmac_ptp_restore(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
 int stmmac_get_phy_intf_sel(phy_interface_t interface);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4e80548ecfe9..a8e5e86e0ead 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -607,6 +607,7 @@ static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
 	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	u32 sec_inc = 0;
 	u64 temp = 0;
+	u32 addend;
 
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
@@ -626,7 +627,8 @@ static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
 	 */
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	addend = adjust_by_scaled_ppm(priv->default_addend, priv->ptp_scaled_ppm);
+	stmmac_config_addend(priv, priv->ptpaddr, addend);
 }
 
 /**
@@ -954,6 +956,11 @@ static int stmmac_setup_ptp(struct stmmac_priv *priv)
 		return 0;
 	}
 
+	priv->ptp_scaled_ppm = 0;
+	priv->ptp_perout = 0;
+	priv->ptp_extts = 0;
+	priv->ptp_blocked = false;
+
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
 	if (ret < 0) {
 		netdev_warn(priv->dev,
@@ -6329,7 +6336,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		for (queue = 0; queue < queues_count; queue++)
 			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
 
-		stmmac_timestamp_interrupt(priv, priv);
+		if (!READ_ONCE(priv->ptp_blocked))
+			stmmac_timestamp_interrupt(priv, priv);
 	}
 }
 
@@ -7762,6 +7770,14 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
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
 
@@ -7774,6 +7790,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 	 * reconfigure the systime, subsecond increment and addend.
 	 */
 	stmmac_update_subsecond_increment(priv);
+	write_unlock_irqrestore(&priv->ptp_lock, flags);
+	mutex_unlock(&priv->ptp_mutex);
 
 	return 0;
 }
@@ -8114,6 +8132,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	mutex_init(&priv->lock);
 	mutex_init(&priv->est_lock);
 	rwlock_init(&priv->ptp_lock);
+	mutex_init(&priv->ptp_mutex);
 
 	stmmac_fpe_init(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index db5610f0fbab..b34711231227 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -13,6 +13,16 @@
 
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
@@ -29,14 +39,21 @@ static int stmmac_adjust_freq(struct ptp_clock_info *ptp, long scaled_ppm)
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
@@ -55,7 +72,12 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	u32 sec, nsec;
 	u32 quotient, reminder;
 	int neg_adj = 0;
-	bool xmac, est_rst = false;
+	bool xmac;
+	int ret, err;
+
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
 
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
@@ -68,24 +90,32 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	sec = quotient;
 	nsec = reminder;
 
-	/* If EST is enabled, disabled it before adjust ptp time. */
+	/* Keep the installed schedule stable across the entire clock step. */
 	mutex_lock(&priv->est_lock);
 	if (priv->est.enable) {
-		est_rst = true;
-		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate, false);
+		ret = stmmac_est_configure(priv, priv, &priv->est,
+					   priv->plat->clk_ptp_rate, false);
+		if (ret)
+			goto out_unlock;
 	}
-	mutex_unlock(&priv->est_lock);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
+	ret = stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
-	/* Calculate new basetime and re-configured EST after PTP time adjust. */
-	if (est_rst)
-		stmmac_setup_est(priv);
+	/* Also try to restore EST after a failed clock update. Keep the first
+	 * error, but do not report success if only schedule replay failed.
+	 */
+	if (priv->est.enable) {
+		err = __stmmac_setup_est(priv);
+		if (!ret)
+			ret = err;
+	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&priv->est_lock);
+	mutex_unlock(&priv->ptp_mutex);
+	return ret;
 }
 
 /**
@@ -103,14 +133,18 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
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
@@ -128,25 +162,34 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
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
@@ -157,8 +200,6 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
 
-		cfg = &priv->pps[rq->perout.index];
-
 		cfg->start.tv_sec = rq->perout.start.sec;
 		cfg->start.tv_nsec = rq->perout.start.nsec;
 
@@ -188,6 +229,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		cfg->period.tv_sec = rq->perout.period.sec;
 		cfg->period.tv_nsec = rq->perout.period.nsec;
+		saved = *cfg;
 
 		write_lock_irqsave(&priv->ptp_lock, flags);
 		ret = stmmac_flex_pps_config(priv, priv->ioaddr,
@@ -195,6 +237,9 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					     priv->sub_second_inc,
 					     priv->systime_flags);
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
+		/* Some cores convert cfg->start to binary rollover units. */
+		if (!ret)
+			priv->pps[rq->perout.index] = saved;
 		break;
 	}
 	case PTP_CLK_REQ_EXTTS: {
@@ -240,6 +285,64 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
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
@@ -262,9 +365,15 @@ static int stmmac_getcrosststamp(struct ptp_clock_info *ptp,
 {
 	struct stmmac_priv *priv =
 		container_of(ptp, struct stmmac_priv, ptp_clock_ops);
-
-	return get_device_system_crosststamp(stmmac_get_syncdevicetime,
-					     priv, NULL, xtstamp);
+	int ret;
+
+	ret = stmmac_ptp_begin(priv);
+	if (ret)
+		return ret;
+	ret = get_device_system_crosststamp(stmmac_get_syncdevicetime,
+					    priv, NULL, xtstamp);
+	mutex_unlock(&priv->ptp_mutex);
+	return ret;
 }
 
 /* structure describing a PTP hardware clock */
@@ -298,7 +407,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.adjtime = stmmac_adjust_time,
 	.gettime64 = stmmac_get_time,
 	.settime64 = stmmac_set_time,
-	.enable = dwmac1000_ptp_enable,
+	.enable = stmmac_enable,
 };
 
 /**

-- 
2.53.0

