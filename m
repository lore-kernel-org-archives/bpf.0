Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1338F649;
	Tue, 13 Oct 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881864; cv=none; b=UiudbNHApp7ZiuBGx6t9239bkp4M8DpjgR3XWbTyyg32yule2+V9+Z9lJMbf9GJ2atNDSDncJHzg2BHl5LzQxuW0KHhadDO+YgpL9q0MlJEugaXCwoQbIA/CJFHKb2+arcbbARlhGCdPdujJ5OZ11bWnfFhsrxmitJInH0RhvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881864; c=relaxed/simple;
	bh=S8z+I2qn3fUP3ib3Mdb8hOU7c0gVBWfhLFwfJOqGccA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knlqXEf4LX4OFYjmcfaHTFVxkdb3YYpks23wa9pMq/+oIOUHwA2liluDKpqGP58ZmN7cTMqBVGu7oABPiHl5viy1Enc7aHVhnDc7n/KbfyiDk+O5a2cDyKUgulCEap0S5S5sxZGqSZoXH3e8uigXHkPTEHQ1v+apNKL7Y6WF7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqjJIJze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyTUJhmA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqjJIJze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyTUJhmA"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791881853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrXyBemWv7jnGNfU4QhDPOUtyZxybBdqnf686rGi3gg=;
	b=QqjJIJzeRqDDmILZP4lIyZRkSz/ek3CZHZj6Y65EjMp7GmDGg7uYGTMLGCcWbPx0gzOB68
	QQNLFdhuoNZGD0PiL47H4QPw/T8Qvz5XC7mqdVJt6xmyl4zVHbNh8N0oo0gk62d7q3ekTM
	/tFNsALN4SEIA5U3Y1qI8A43OWZ1Ue80534xf8yndFIyAzBAtjLi7Ig23XcWM+zbHb0NbU
	1DS4BbaG2qOYUx9M8GU7eeZ2NlkEpsTCk8hspwWs8lgW4geKo5+5CMaQsW8f3ptkxfrVzX
	5NM9vGZC4Uv/5J0l67+tSxzdbSBUXMTfhdXus9LOgzomJSK6xd3P6XE/CBcIoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791881853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrXyBemWv7jnGNfU4QhDPOUtyZxybBdqnf686rGi3gg=;
	b=vyTUJhmAvFRV5nYN6ZU4EgZNtTA5BxScv0T+sRq9WDAjoVFM6bS2qLOkP7uoL7Rv0Tcrta
	D7CkIQiAv7ROG1DQ==
Date: Tue, 13 Oct 2026 10:57:21 +0200
Subject: [PATCH net v3 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-stmmac_xsk_crashes-v3-1-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=S8z+I2qn3fUP3ib3Mdb8hOU7c0gVBWfhLFwfJOqGccA=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqzfJ8qnIKOhyemW9CBxZPoZbsy8uaA/POwUu3B
 S48CwgQWNKJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCas3yfAAKCRDBk9HyqkZz
 glp2D/40XljttzmsCQlBnQ8DpnUkd7udr4JVxzzMmkZqdeCM+3m0MKqibuOBHxANbtIYhQ1NoV1
 PQn8DaHoMPrHdYOlLfTmiV68IlzY+QlWBKIjJaII+/c0rhXeSjlTN55iN+IIj2e7odv6Hpf4HsI
 aPZODy9TpP7x008hia11moSK99KAIzl2IBmVyDNEiGTDy9V0E/yKvlVIcdntIgyLi+WKMgJajxe
 ravZRnHhtQpmGQ3OS15T77KeL4Q1Vwg/XOdyS3oFWvfjdF0QGdKqeF19Fyac9eejwFhpqszSwRP
 BCeC6y9laV78vku04ju9fhbmC15EeRuupfpvZHgWtdVTwmRXg60RaMEQWxVjLBMRDOJCCyNuD6Z
 BF7L3ZjGaaagqKtUoZ8YkR68dotnFY5sPfskdcN5m3nxzB48itfL6OvjrakxlcveMqL092jJ8q8
 TER9ajHWXoRz7PM+R9zQ0W8j7tbC9nGt9iEeyQazPofnRu2sC73OBIPXW14HQ+4eq5i2oLFoKrF
 5w3c44XNgW7wEdzfbjXTeD2VZIkQdGM/Ary5OxFfwGvYqbamcBcT/cPwoMLlHfLfbjDI9rVL566
 hjNqnorwvyTegv+P8Hc3vvtv6ZQvHPuXWQDfWaa3ZKQWHct2GLHxGSmbf9TGaa9bXz4y2Js0PIG
 qBxN731od/MRaGQ==
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # stm32mp215
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27a35..2aa5a2695473 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7132,15 +7132,15 @@ void stmmac_xdp_release(struct net_device *dev)
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

