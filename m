Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE936B939
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827981; cv=none; b=tLRkSPenrgFFEofmFKebcc+9l1z37+RMvcDPomTcqzOOq+LwpcEX1DllWy3c21iHeXmGPcQW6EHbqw1fE529mz2o6ccGrS7398ZZNHFVCXG2SSP1rCde0HsfDROQJKcDR1wQnHMluKyTjo1GinLrj3qHeVzbjlZls+AnQHlRQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827981; c=relaxed/simple;
	bh=0iEuo6gmNhutZDAzd24MtFBiVJz1RJlUMLM0CAvEAQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvAFbKJ7cZtzP4lZKq2N8W140GlntJoynGqIwto5Y4uTOSN/CL+Ly9IEIjlUrh/PGSiOp5v+m6ECP0vDetwxI5YW2bOY1x+7NpQIlXlxyO2cLtHqeRoX7eoiibVp5yd2IzU+Sv6zVg4WQ9475G6yWejYyJczsTYN1XiEw5WKiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTxy6QuH; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTxy6QuH"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80a71781323so3590480a34.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827978; x=1791432778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9cgIVeq76b/ZvdB9vw6DERB2lv+iQya4cpw9K5HZZA=;
        b=oTxy6QuHwspRxVupGDTYPSLxQYfVhj5KWQ/hSl3T1F8G8+jQMcJZI9LBVFt7GEkmwK
         pjrRrPRipzKCwAP/eZYpTcyKIXcJtzz83CtVj/0n1g6cpcbzWe8z+J0LLjz2B4CzxtEg
         41h3yGS9aYvcBIALcajc490GfOb7kb8V5/gE0WOyprEPm5MWRVnaVZ2TN3v890tTSxFk
         UOo/NzBCrgemagcz+qREGTOnFjuvnEFc78POsVzh82qTTeWgyelx2gcKfCQxxQs1PIHj
         fBVLSRKSbeJG5h2+kg0Ywk0lIzzq5WD4Yew2y49RNL0LWcbkTxefsvEu2Y+041hh/DY6
         agSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827978; x=1791432778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9cgIVeq76b/ZvdB9vw6DERB2lv+iQya4cpw9K5HZZA=;
        b=xQXvPTSNOgkfiReQKP4jIaE2Had6ZxHffnIaTjoUoTAXU04/1d3V43qlEI6MzSE2uS
         wYDYKZqkVqmaAQO7g6ixloE1oBI9pT15T+WNlJhx8aPQNev1vaZCOVqLdfvtl9rae3Ay
         DPn2zU7eqG9BQJhhbRLxyRFPLlTeZA5dO5F3iTzGP7LMwyVCWyxBTAzr1gEkXKQjbsEh
         sIcuIYHk7cWnOM4XEdxZ2n7UdgFHZrsA7KVQ9r0JyVoCaSXIBMRc/aiRm5eWlS0EJVky
         9tZPvOACLCnnz1K5T0al7PSmmgGMCM1JpIaWa2unsPPZhfRFx6ulYBXYPUgrBoYVJMFm
         7wkw==
X-Forwarded-Encrypted: i=1; AKwUvBw/6otpvo4xe1gli0hDbME1rOxakTI9eE5rBHR4ZWQ4iRkaW686QgxjL9ajqo3eWa/zchw=@vger.kernel.org
X-Gm-Message-State: AFuF++mSoJYbU1LlETpiNr7W059meM6cG7FYyMuFwiANNJGF3T+lBwno
	JiMDW+mqT0+sSP+EzmfmzYTSe5YpOJ+2YLsM7u6q0MNDVM6aw9xBIFG7
X-Gm-Gg: AYBFou17+HuwQlfiomk0bse+sGyY3MZGBvhjWgfC9wqQVluPxf1SxfukGH9p2AwMihp
	aFpdfM2qxB1Oj1IQh5IZqwCF2PLELBamH/o7LdhqNfaBLi3UdsdQ4I+FlZDu6wKtdvEi9759AsL
	llCgHq/ulD3Is1QPsEZI9jqw3Q0MWmJB9+JRaSsJQyJVM57j4d2cmjxXtwcD6yTwVCQdo5wqLgw
	FB15YWhbcfSX0CviTYRfPYz39eE4bo0qZHX9PP3jwvfVIE7rYlNWLcj2KVPzLSfSZ7GMVrgB4UP
	P+9WRMNeKYRICJKQNoJk9V3YgjzNVUxVUd7KBg+NK6X2RraGJxVjaKg6+r88CU+pT5WZA6629xG
	5yG9699p3Qo9AG+gC3YN7SdN7uDZCftXoDaWu1yCSfZX3Lxea9Q6MM5Lhs+7fQ9D9Ji8tNjuVty
	fcRdZcV8HPwr8B7rOJSSJ4aIqHAi8i4LPnKq5ck66GOSVHALnx1zAhQQLghr7Z7ft9zj8UPw10p
	JzYIE5vH7ylVmfitSET/C/4MwngtRWKc1XI+naJlDBmWGYMDWhYXiJlEX/xk4dr65uJWB0AOkgY
	J+l7VfBT1s9tXfGjnlW9XgfJsjb1l505rpjEy9JDlz3wOBItVZx0mdv0rMqeOFcP3V8rVMhIoIk
	LSy3GpHk0D+GPkd2z3ESq
X-Received: by 2002:a05:6830:6289:b0:804:ec69:3979 with SMTP id 46e09a7af769-8204b5c0229mr3897443a34.21.1790827978049;
        Wed, 30 Sep 2026 21:12:58 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:12:49 -0600
Subject: [PATCH net-next v4 1/4] net: stmmac: embed struct stmmac_est in
 stmmac_priv struct
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-1-9d4366587b73@gmail.com>
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

This is a preliminary change to fix EST reconfiguration in the open
and resume paths: the taprio offload must be re-applied after the DMA
soft reset clears the MTL_EST registers, but the current layout makes
that fragile.
priv->est is currently a pointer allocated with devm_kzalloc() on the
first taprio REPLACE, and the mutex guarding it (priv->est_lock) is
initialized at the same time. That ties the lock's validity to whether
taprio has ever been configured, so the EST parameters can not be
read under the lock (e.g. to check priv->est->enable in the open and
resume paths) before the first offload setup.
Embed struct stmmac_est into struct stmmac_priv and initialize the mutex
in probe(). This makes the code simpler (no logical changes added).
Moreover, the lock is now unconditionally valid, so the enable flag can
be inspected under the lock from any control path.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 17 +++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 61 ++++++++++-------------
 4 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..12f353fabd6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -298,7 +298,7 @@ struct stmmac_priv {
 	struct plat_stmmacenet_data *plat;
 	/* Protect est parameters */
 	struct mutex est_lock;
-	struct stmmac_est *est;
+	struct stmmac_est est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3ad9252bf6ae..e93f3238be1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2745,9 +2745,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
+		if (priv->est.enable && priv->est.max_sdu[queue] &&
+		    xdp_desc.len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4843,13 +4842,12 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_is_gso(skb))
 		return stmmac_tso_xmit(skb, dev);
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue]) {
 		sdu_len = skb->len;
 		/* Add VLAN tag length if VLAN tag insertion offload is requested */
 		if (priv->dma_cap.vlins && skb_vlan_tag_present(skb))
 			sdu_len += VLAN_HLEN;
-		if (sdu_len > priv->est->max_sdu[queue]) {
+		if (sdu_len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			goto max_sdu_err;
 		}
@@ -5253,9 +5251,8 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue] &&
-	    xdpf->len > priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue] &&
+	    xdpf->len > priv->est.max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
@@ -8106,6 +8103,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->est_lock);
 	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
@@ -8238,6 +8236,7 @@ void stmmac_dvr_remove(struct device *dev)
 	stmmac_mdio_unregister(ndev);
 
 	destroy_workqueue(priv->wq);
+	mutex_destroy(&priv->est_lock);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dce..2a4099fe470c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -69,11 +69,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->est && priv->est->enable) {
+	if (priv->est.enable) {
 		est_rst = true;
 		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
+		priv->est.enable = false;
+		stmmac_est_configure(priv, priv, &priv->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 	}
@@ -91,19 +91,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est->btr_reserve[0];
-		time.tv_sec = priv->est->btr_reserve[1];
+		time.tv_nsec = priv->est.btr_reserve[0];
+		time.tv_sec = priv->est.btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
-			     priv->est->ctr[0];
+		cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC +
+			     priv->est.ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->est->btr[0] = (u32)time.tv_nsec;
-		priv->est->btr[1] = (u32)time.tv_sec;
-		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
+		priv->est.btr[0] = (u32)time.tv_nsec;
+		priv->est.btr[1] = (u32)time.tv_sec;
+		priv->est.enable = true;
+		ret = stmmac_est_configure(priv, priv, &priv->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 42a00446e9b4..357d1eaf0d7d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -959,7 +959,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est.max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -1023,24 +1023,15 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-
-		mutex_init(&priv->est_lock);
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
-	}
+	mutex_lock(&priv->est_lock);
+	memset(&priv->est, 0, sizeof(priv->est));
+	mutex_unlock(&priv->est_lock);
 
 	size = qopt->num_entries;
 
 	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	priv->est.gcl_size = size;
+	priv->est.enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
@@ -1065,7 +1056,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est.gcl[i] = delta_ns | (gates << wid);
 	}
 
 	mutex_lock(&priv->est_lock);
@@ -1075,22 +1066,22 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->est->btr[0] = (u32)time.tv_nsec;
-	priv->est->btr[1] = (u32)time.tv_sec;
+	priv->est.btr[0] = (u32)time.tv_nsec;
+	priv->est.btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est.btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est.btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est->ctr[1] = (u32)ctr;
+	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est.ctr[1] = (u32)ctr;
 
-	priv->est->ter = qopt->cycle_time_extension;
+	priv->est.ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	ret = stmmac_est_configure(priv, priv, priv->est,
+	ret = stmmac_est_configure(priv, priv, &priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
@@ -1106,19 +1097,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->est) {
-		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
-		/* Reset taprio status */
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
-			priv->xstats.max_sdu_txq_drop[i] = 0;
-			priv->xstats.mtl_est_txq_hlbf[i] = 0;
-			priv->xstats.mtl_est_txq_hlbs[i] = 0;
-		}
-		mutex_unlock(&priv->est_lock);
+	mutex_lock(&priv->est_lock);
+	priv->est.enable = false;
+	stmmac_est_configure(priv, priv, &priv->est,
+			     priv->plat->clk_ptp_rate);
+	/* Reset taprio status */
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		priv->xstats.max_sdu_txq_drop[i] = 0;
+		priv->xstats.mtl_est_txq_hlbf[i] = 0;
+		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
+	mutex_unlock(&priv->est_lock);
 
 	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 

-- 
2.53.0

