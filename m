Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4831715F;
	Mon,  5 Oct 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184188; cv=none; b=iWLWAcAdx/C8YxdAvfomQR2MihsU02CCfIOlzymIZAixrkO9oT/tntXWbtsqVLi7O0V+ZJPf82IfFBU1yJsq5b3Oi4WhuVQPK0NQ8Bz6EKHViU/jk9Yk+fZY3/nUOyq9bArZD9wvDul2MCQ/TgCWCuWIdAo7iE2GrquEbBtGz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184188; c=relaxed/simple;
	bh=Npj3lyjQeWCninc643PMtbQInmY0CNbwT9gsW5wBoRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dseJ5oUnRZl0yH2odHsUGeMqXymAX/4gp/H6RNu+wczGLrh+LR9QvgIVPsIw4smcKMZFsARcEKyjIKQx0jSmaMUfpf4xmz3s9UJ9hhLIDQiOmgwOfTkprU9VVsLDH9R+5SnoLxYRAZxF/eguujvrJp1Ik7iHAK9c9pMp0rZPMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwCQZ5k9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0QeuFiF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwCQZ5k9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0QeuFiF"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791184178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykzFJf8V/2yXxJYZccH4hCRQdjDYiBaGvTlRpnHRJ9U=;
	b=zwCQZ5k9tM+8hb2GFqsnTjHUDpJRScO9qoE+kRil2TQaOelDFlTALaIvadK+6FjmS6gVOA
	Dh2mPuscoafrFDwvQjdLmPyj/rVRCR4lhQhKYnGwOQaMZbVllhwsVcgcVVODhjyRM4vH+z
	WwxloSDI7BTmRGHkLg7KfVrGFwutH1uiES1hYVmdWKU2gEz11NQGy2qwMO9KINNJ/DUunf
	40NWVXLY20Yyn+ex6zvng3kgUMUCD+0G/WSYhCwuzKWTThfHmlkpnoPGKNe31MB5CMUZgU
	Hkg6Zp+ub0YaIscZOMHOJ//U+U/ckRZrEjlnAcn1Q/4KXDmOP11blT1xi/i6yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791184178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykzFJf8V/2yXxJYZccH4hCRQdjDYiBaGvTlRpnHRJ9U=;
	b=h0QeuFiF1HZJN2n6zZM73rq/GBmaL7BOhje0g4Zovd7pjIuntYPEILCvOAuzWvZWqAGKLU
	11HOmPDAxg7Uz0AA==
Date: Mon, 05 Oct 2026 09:09:32 +0200
Subject: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>, 
 Mohd Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=Npj3lyjQeWCninc643PMtbQInmY0CNbwT9gsW5wBoRA=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqw00xXh5X24kO1xk3Cyt2Zrvz6DgUrNG1svMeJ
 CldqKaOudiJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCasNNMQAKCRDBk9HyqkZz
 gsl+EACC6Ds/eVUzFacK1iii6oJICkDSPY9RrBp76kQuXWyR+n6lFl/MjV9Xu0WfqGyPQJTDhEO
 P0R8lOTX3AyL3xJ8QZeCvJZuT8OP0hB7PK6dWKB5AGtRm1PtjVD5BDEqvuAi89dMtxRqnevFNvg
 WVvRxP1CI1UNuXDmR6yV8fSqfILLsOy97bd7ebXXq5+HKE1b+r78sCNu2eBDV+RV84n1MaYI4rk
 xuw4LEEQAwNwnKpQdz1sw31d+hUWCOZApc5vhyBPnoUvlr1DYOPXsHdYREtQrMR04r/INiqc5P2
 wzKWnG3bDpKFF6SGS4rAetxz0gHvv6XNopjG1PX4F508MU0GC4doyivnRsaT/HoOZqpGU1MNM1r
 ikHGCUluzwE3uV9UgTZutMwVfGTPxL66nexs4wkWvD4+C5hTnw+IKwjQGhnXAFHM0claeuDYfCp
 BNBCiJgxXh/VgpEwRphUn0hetFsnpVml8xMc8JI8tbahAAhsdFmgWRBpcKd+1dSiz8crxiagscJ
 k0uWRCe7k2VVuq+Fnsisp2J4YBngeyOe7ND4WYK4cBajiQR62bZOsRcHcullpYkpDCYU5cCCcUM
 DA1E9TzkjFDp4/KRibjPGY58ipgEv/vx2Hql71qqS7rRSOBTI4DJ7+ptrvxyLYPDASfRVKF/HaV
 Z8QR0/3JB3BCt2Q==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Attaching an XDP program while Tx traffic is running results in kernel
crashes in stmmac_xmit() -> dwmac4_set_addr().

Loading an XDP program tears down and reallocates all DMA resources via
stmmac_xdp_release() and stmmac_xdp_open(). stmmac_xdp_release() stops
the Tx queues before disabling NAPI:

 stmmac_xdp_release:
   netif_tx_disable
   stmmac_disable_all_queues
   ...
   free_dma_desc_resources

A Tx NAPI poll may still be in flight at that point. stmmac_tx_clean()
takes the Tx queue lock, reaps completed descriptors and wakes the queue
again when it observes it stopped with enough descriptors available.
Nothing stops the queue afterwards, so the Tx path resumes while
free_dma_desc_resources() releases the descriptor rings underneath it.

On non-coherent platforms dma_free_coherent() tears down the vmalloc
mapping of the descriptors, so the subsequent stmmac_xmit() faults on an
unmapped address instead of corrupting memory silently.

Disable NAPI first and stop the Tx queues afterwards, which is the order
already used by __stmmac_release().

The issue can be easily reproduced by:

 1. Run iperf
 2. Run application which opens an AF_XDP/ZC socket

Assisted-by: Claude:claude-opus-5
Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in stmmac_xdp_release()")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..796817caf7af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7178,15 +7178,15 @@ void stmmac_xdp_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
-
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+	/* Ensure tx function is not running */
+	netif_tx_disable(dev);
+
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 

-- 
2.47.3

