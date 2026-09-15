Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A647A887;
	Tue, 15 Sep 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462528; cv=none; b=PmpQB1tuM0S0zUpLGtCepls4cWcDlkNZEsUvQYMB+yK2saEs78pSrTOxP0EXbhhLuSwesiuXJeTIRg9hwYgcglLFUCfipYIMsOlKEJnoUWRq158I398XNetGehHw5wrDdZBX+ddaOXUm6KJobqG1vXYM33UWr8tdEkMTvxz17AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462528; c=relaxed/simple;
	bh=jR0H34vdiv7W/SJ2FsE8rZ6PylOArSBFOR8UWIe5QP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=So1pyV6mEjD7O1klaFdRcBnG3PSAjO3LXQv1F6rh+vqekjvZmzjhY4YntrEQu/ZZ65Ord1n4ASmztq2Ii8YHUOooH5CT0ValW3qUSCx0hstnwosSdDh12TjuxJ5orakxRWmMLbtY3fpT6FNdlCIWzg+WF5hjWpHpqX1sTqEPBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQxa4rTG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xEfU9KKd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQxa4rTG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xEfU9KKd"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789462525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMJ3kAH2H7v1EwMfvPitDPV9QPEVx96053JJoMhRZJs=;
	b=eQxa4rTGWLcefuQCDvytS+cTBpXko4P99kaxBvTKuykFGBaJJ9CJYlLTBvu2wQi0lT/0bD
	ri5Urk8/SD3FfrH1EsHvgwLVbz5qBY3M2Oc+21II3alrKg3XIDNpEib4nVGod0ShSms6oZ
	Fea1aXKOM5V0vPiPafql09JaOGK1a0W6lZrFtSX1ccS8kqN6uitVkpLRBt9aonwK3Uq0tW
	cg1XnXApr0vcgp5y1RkzYMbw6ZJLpwkltXwBeE6kPtpZHXAymEFhO1+1lylH0bBDQ8Xkeh
	E9H3P1YjRDPYDRwfR92zTuq/7ASHQ2vw/o0f/2yXgeAHZwB90QwWiErcSc3b/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789462525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMJ3kAH2H7v1EwMfvPitDPV9QPEVx96053JJoMhRZJs=;
	b=xEfU9KKd6yg1EZ6ZmZjqz1H/aDxa/KnzJuJ1gBEOLClsH394695bMxx/lyEbjSahU3FISL
	gsU7p7hAGRsvagCQ==
Date: Tue, 15 Sep 2026 10:55:05 +0200
Subject: [PATCH RFC net 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-stmmac_xsk_crashes-v1-1-e14553fcf553@linutronix.de>
References: <20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de>
In-Reply-To: <20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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
 h=from:subject:message-id; bh=jR0H34vdiv7W/SJ2FsE8rZ6PylOArSBFOR8UWIe5QP4=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqqQf7VRjiE33xEjX5HXdvVzeunnvJsx+68sJZ8
 CyIsgNhPymJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaqkH+wAKCRDBk9HyqkZz
 glBiD/92mTGGrKpOeUztqwXY2V5plO6OoGyiU+j5cgP1leoX/hJ5NOef0QMobjCueVorAy5t7lM
 B5E5ZnNqv7G3fT/MKvIUAOGeGwU3WsDztSxWbD57kIHBZLZyqo8iLoSW/MHUbmRdWVpNBS5eGPe
 hz0wXI8eO8pKXPu/udFlGGHfIMzzm1F5cYKZO0vf1kIgxSNrChuBRXTYVqtlgulkFTAR/TRFcsc
 Fdq7KN2NiUhOxhbj7cQxj1vEFRD6Pf3Q9SdJn4CqT2p2zjy9smZFAtv0n1nwDsIQz3W/Q5PurrC
 Yq1yK5ny3qgwNCZCDTa3b4xOqVCsvfzc+2H2Cl2u4Qy1KtUoBH9PAFKc8FiMfyjZ80nGQt4Pkrh
 yJ74cWJNFtnJCcQHgWtwFIg2cQ9wJEFoddjCZEF2UM/L0GwivF8CahL1FiG0U+wqPLSH+Ld/MwU
 9qQutwhsevpetjYVKPJYV5+xvBKyNdKYbe/qBW++6tVKRRPlHyuU8xg1TAbwj9a7N3J6Sv/AbGI
 u5K7BBXk81qrnpILF3Z7maLOeegTZ7TybjvDLjVTeqA39kssBqeSoSjVYOQqZGXDc5Wkog/MBLI
 bbIMQj67o35mKQnKZBCcJ2MN16G/Ya6xgFG26FJYRNoVae0otVMDJYIpjVGrZ2wjzx06eTf0AQj
 8fHP5dMYKPbeYjQ==
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
index 62c3441911e7..928aa05aa87d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7118,15 +7118,15 @@ void stmmac_xdp_release(struct net_device *dev)
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

