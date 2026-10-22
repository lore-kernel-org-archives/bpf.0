Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652506;
	b=CczeTQm1I3CJ2yQYOfbGPCjT5vM7NvBWba8sre2To/wCkGTsiXHB95G034RfBHYmDLn7
	 EisAh5aUqDijL32PGhSZmG5CL1HH034uMFC6QtcNcR+c5vZPcaR9QphkxLb47x791p4Zq
	 3bJXPSoK2BWAId2gusoNDlg7RRUbIaxlisxPUqPYhpUIXmGivUp1xJDZM4mqXmtEQo/sU
	 xhwCuYCuhWjVdOW4jOJ+c1o6qh5id41a71yb6FWkOMZHV5qaEOmoXZlZrRHllsv0OvsaN
	 j0VtQgdPv59GvCcVwKm4p6+N6FdBqrlXo4GDLACIjfhHWveI2iqy0TLXQ6UYX2DKNSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652506;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=sCvs1/SP9Or5kUcquJYMmgtgDpHHNPbARp5a+KoBLQA=;
	b=3OB5bUItwDmc77vnnMO3ilURTLHFMATMyMLWeL32g/ZV6gHIN6RS8ADCru1IO3taH0gC
	 4oWtBoW8399M8CNg8A25VcZDo5dRdb74geWp7/kw0Vy5R4Bv9kjSd5dNpLxqWNxU9v0Ub
	 cw5XT6FDllXfCk39G8uL5U5ixVYEYY1sq1jI2oZcMsadq5HyMKKE+tSVZUZPQlVWE1ifJ
	 DtjCrXh+igTFG94kvs3ac05KA1u98QjeDkpOpsXWOBCa8tyAs/FJld4JK9nrYzVfOKguT
	 fd0JGQiH5LZZdl/otAsHovxCxLM2ZeKmId7wJKQ8GSdBF6BnBrnaX4RV5++QAL9X7Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tFVIKvpR;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="KoNL7y/D";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C7606A31B;
	Thu, 22 Oct 2026 07:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E2C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tFVIKvpR;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KoNL7y/D
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792652502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCvs1/SP9Or5kUcquJYMmgtgDpHHNPbARp5a+KoBLQA=;
	b=tFVIKvpRFJp3wOUXQX6Kwgc0ZrJ6vaf9TqGEBeqjAOVQAZ2i1GmhX4SUabMswbvsFre4Ld
	MR0/mdKLFXZGl5Xn4wRTkbeDAzgg+RRlQy965PrTQn7ni/eBcWtwHYoC6CDxgj6PrPidpY
	MZdwWd9/uHQA3Rgb9jMxpq+pODUriiUfQVVUiVtj+LK8CcESBTRxTM33nBBNgWx/7PSuQS
	qyLhnlTXR7dtwBzBlCh2nzo3dQy8b+KfVeDOZ/6M/li/e3Mfpc+fa/6ULIyQI4Dpxof0Kq
	0qaDOJ52BB8n1433jKEvkeS7WhAmO89zPZ+CQTz2URVY0l70aSbhlHKyr+xv9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792652502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCvs1/SP9Or5kUcquJYMmgtgDpHHNPbARp5a+KoBLQA=;
	b=KoNL7y/Dmw5u0J6gOeG2fEpDl+lZoFl8ySlSm1oTMlfWTfOAZ/7RJiQsSRxp+LuPvc42oJ
	SPEpRzuebnfEabBA==
Date: Thu, 22 Oct 2026 09:01:34 +0200
Subject: [PATCH net-next v4 1/2] net: stmmac: Disable NAPI before stopping
 Tx queues in stmmac_xdp_release()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-stmmac_xsk_crashes-v4-1-15c0c750bb96@linutronix.de>
References: <20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96@linutronix.de>
In-Reply-To: <20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96@linutronix.de>
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
 Mohd Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=OCa+em1H5J5wWafzD28gkNIjAwMCgeaJcWpy7TC3QkE=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBq2bTUeVH21Hx1P3muZy32DL2GnrrXQTEnZuAeP
 tE6dL3oiI6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCatm01AAKCRDBk9HyqkZz
 gl+uD/9ixxcXpdcbbYW2t/aWk7A+IHI8onqg8MPMTrA9oTTxrevRAhmOj8+4oXQfSSw+EIQBWLe
 foEtvIE1toLsFo0ZPOAW5UfG6lF/GFvEVuFsUoV4zjpL8insByxC+At62DANpTXKXYjikd2Rjqz
 fyzfv075quf56G86L6LoPWxhrHyt5rjXbrzPiFqsC7H8qCNNQ6djxqc7EIflqhItXytUOpTHNRe
 IRlE3AC21F5CmWXxmHO2lkgKkxJ6TfT64IYEjL7E7TpgjZ4ibUmgUwXOnhGM6eWMZiDbLbn+F5a
 1xDFO3v+BN+/KiUkafhCNW8E56M8LX7EMNemwXidHHjYJEJBALCQXKjqj7s20x5b8HAwN2EP4ov
 euW+8ikPGlWQRzCZPc3G3ZTgLHVdkmpVTZcXz5CzfugTTY5H/vdiNf6ZuMEYrtiQWYdAfzqiBC0
 AIoBp6zmWgSDCu6AMKZnG704E+2vXNftEaAsQvtmgXvg5FL7Y1IRNlmIW8YEU/M4vIffOFMPlBY
 IuJ6qOTp1l9QLhrKHMgitsNyIpDkuLmMKEX5W3jCO7sWK4EzoVzBQrRkgwae/dLYFrzSaX8mY8k
 gRPX5RdwJq5EFqO/DtA+CqIsdf/g1nUMzAeHv7sgeVZ6MZLyWW5SyiiWgqaZOBK2lwD2mR/aK13
 Fn+9N7EklnmkQdA==
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

Assisted-by: LLM
Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in stmmac_xdp_release()")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # stm32mp215
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fb53b1f17714..27c4a249e560 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7222,15 +7222,15 @@ void stmmac_xdp_release(struct net_device *dev)
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

