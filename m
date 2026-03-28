Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F48376472;
	Sat, 28 Mar 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774739186; cv=none; b=VmjplWSTZqsAMoBe42xyB72i8dYLulfZGSDiXeroQyVVzGlV1FuMDlmdyN7u5/xmYJ9qHWASKNC/CC7OcrA4eXprmEA7E7Q9a3bH1EJzeMfW6hyAqeE2/evFzdZO2aN4+w4+Z/2fdLjAsAKaLLDfwTm2XxpBtVysUTCyzRVYDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774739186; c=relaxed/simple;
	bh=ddQu8CSa0I7jxFLa0WKmApTPUS6v4sR8UbmxjD+kxuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T18/O0D2uC7EH+tqe5tXKrCJRdATrlWfZIDsWqog7T/Y59G1RlbQJcA5gp+4GzSC331oqkgtDws6oVvlIAOznisGY4NabmDet+tWJt8t4uGz7H7jQuFiN9/75LB0G+9YKQFUbuL2f3x/myoF951ohycRDkPKUeB6upXrABoHeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2FXZMexg; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2FXZMexg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB993A5878;
	Sun, 29 Mar 2026 00:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774739183; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=XYuC3U0C4Bmt4rfQl8hUoMOen7Yhc3t7l8TDIPRipZY=;
	b=2FXZMexgYqt0bLpZoyiTXsQzYUSn56m/0T11jxnXkH46UlgHU5/x4nJSE4yrWgA2vt4kQH
	GPs4/69yaAo+qHC93tlIJZRciMHD4Jxx9CeunHumvplQ1pdL2F9xryOUU8X2pu8Id2GrPq
	pjMUJnvI582lUfziAhizT/XsrTB0xiVfJD82dFNJ1Ew66Hgc6ASk9pYcC/2MCmeelPZk71
	ZPT9fkwJdgEnrr0mqyeEKEmUV6wrb15Wi8IgYnKBckM25f29Jfg000JBZh3dlxHNr3qDyb
	xvAPcZ5r9JU4EX7a60Pz0RzBcBJRauErGxVqcNJmtojq/rENITL6v0wExhP/Sg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 6/6] net: bcmgenet: add XDP statistics counters
Date: Sun, 29 Mar 2026 00:05:09 +0100
Message-ID: <20260328230513.415790-7-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328230513.415790-1-nb@tipi-net.de>
References: <20260328230513.415790-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.

These use the existing soft MIB infrastructure and are incremented in
bcmgenet_run_xdp() alongside the existing driver statistics.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 0a857625af4a..29703398d28c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1170,6 +1170,13 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb", mib.tx_realloc_tsb),
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb_failed",
 			    mib.tx_realloc_tsb_failed),
+	/* XDP counters */
+	STAT_GENET_SOFT_MIB("xdp_pass", mib.xdp_pass),
+	STAT_GENET_SOFT_MIB("xdp_drop", mib.xdp_drop),
+	STAT_GENET_SOFT_MIB("xdp_tx", mib.xdp_tx),
+	STAT_GENET_SOFT_MIB("xdp_tx_err", mib.xdp_tx_err),
+	STAT_GENET_SOFT_MIB("xdp_redirect", mib.xdp_redirect),
+	STAT_GENET_SOFT_MIB("xdp_redirect_err", mib.xdp_redirect_err),
 	/* Per TX queues */
 	STAT_GENET_Q(0),
 	STAT_GENET_Q(1),
@@ -2425,6 +2432,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 
 	switch (act) {
 	case XDP_PASS:
+		priv->mib.xdp_pass++;
 		return XDP_PASS;
 	case XDP_TX:
 		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
@@ -2437,6 +2445,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		    sizeof(struct status_64)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		xdp->data -= sizeof(struct status_64);
@@ -2456,19 +2465,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 						      xdpf, false))) {
 			spin_unlock(&tx_ring->lock);
 			xdp_return_frame_rx_napi(xdpf);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
 		spin_unlock(&tx_ring->lock);
+		priv->mib.xdp_tx++;
 		return XDP_TX;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog))) {
+			priv->mib.xdp_redirect_err++;
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			return XDP_DROP;
 		}
+		priv->mib.xdp_redirect++;
 		return XDP_REDIRECT;
 	case XDP_DROP:
+		priv->mib.xdp_drop++;
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
 	default:
@@ -2476,6 +2490,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(priv->dev, prog, act);
+		priv->mib.xdp_drop++;
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_ABORTED;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 8966d32efe2f..c4e85c185702 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -156,6 +156,12 @@ struct bcmgenet_mib_counters {
 	u32	tx_dma_failed;
 	u32	tx_realloc_tsb;
 	u32	tx_realloc_tsb_failed;
+	u32	xdp_pass;
+	u32	xdp_drop;
+	u32	xdp_tx;
+	u32	xdp_tx_err;
+	u32	xdp_redirect;
+	u32	xdp_redirect_err;
 };
 
 struct bcmgenet_tx_stats64 {
-- 
2.51.0

