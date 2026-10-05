Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BD43149D;
	Mon,  5 Oct 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191730; cv=none; b=o4wr4bbAyAaV/JOM+cvFN9MlvDUV/lrz+ZCXtKnTpCkc6Dteg3VifFOiSS+d81tBjIukXhWn1uak8wPhq+jWDLV6TKpUkjCpLHVdhBXj/yidPEZClComm7JYc+gp/D5fl4kv+pDqMaq5hfqQhXK4z1+9XuVuQWqpB85p/p/6hKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191730; c=relaxed/simple;
	bh=IvWzLE7BfpaVRZZC/2oAPLGeYslO7bCeb+PdlngvYgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+Q3XbBXjHmlSA724Z/KvpwWTQFvQJm0m1/CzdTBiiWqwPhzgxUgO0IrlEuoUPMwNA3uKIcgzmkzaJCsOMVE6ydYih81PNRz87gtpC+FauX7IG6imeWoTB/yYlLjRhxq1PCCcXscb57PfqHJIPhOO2jR2BqyzpsD943m5SxjJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dwOWGp8w; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dwOWGp8w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 806094E4117D;
	Mon,  5 Oct 2026 09:15:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FD29604FE;
	Mon,  5 Oct 2026 09:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D83721033071E;
	Mon,  5 Oct 2026 11:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791191722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YM7TE7exdYuQCUvvTDui+rJZ2DPmZv/3pJBXSuDfZEY=;
	b=dwOWGp8wKr0jZVpSpX3ZYBI4KFhl54LXQ9h6fu3/xkcdNtS7BtWiV1Hbkysk4k0skqq6N3
	/cVZrAg46Ju8MU3LPgMVJuu/6igHYukg4F3FTd8BJ6kYFX5BOqTUP6hZZptWyWvpe4on9y
	K3mJ8dY0itsAP9AVfG7omEZZJmCW2M/n1O361nbh3QvCpn7sx7DMS9/21UY9fkiGXMpbvW
	j9+bruWHVmU+tAohvm6D5pGU4KF/5S3kh5KX8g62P6ye2dURx7tGDXDVZzIHPCGQEgy6Wk
	YVmEiFX1WvgGqb6oxSX5itxoEzwaaMqUwpu8s0BDJmtuOpfv50+lLtDRs3D5dw==
Message-ID: <6bb85939-ff35-46e1-88cc-1bed0034e787@bootlin.com>
Date: Mon, 5 Oct 2026 11:15:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
To: Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>
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
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kurt,

On 10/5/26 09:09, Kurt Kanzenbach wrote:
> Attaching an XDP program while Tx traffic is running results in kernel
> crashes in stmmac_xmit() -> dwmac4_set_addr().
> 
> Loading an XDP program tears down and reallocates all DMA resources via
> stmmac_xdp_release() and stmmac_xdp_open(). stmmac_xdp_release() stops
> the Tx queues before disabling NAPI:
> 
>  stmmac_xdp_release:
>    netif_tx_disable
>    stmmac_disable_all_queues
>    ...
>    free_dma_desc_resources
> 
> A Tx NAPI poll may still be in flight at that point. stmmac_tx_clean()
> takes the Tx queue lock, reaps completed descriptors and wakes the queue
> again when it observes it stopped with enough descriptors available.
> Nothing stops the queue afterwards, so the Tx path resumes while
> free_dma_desc_resources() releases the descriptor rings underneath it.
> 
> On non-coherent platforms dma_free_coherent() tears down the vmalloc
> mapping of the descriptors, so the subsequent stmmac_xmit() faults on an
> unmapped address instead of corrupting memory silently.
> 
> Disable NAPI first and stop the Tx queues afterwards, which is the order
> already used by __stmmac_release().
> 
> The issue can be easily reproduced by:
> 
>  1. Run iperf
>  2. Run application which opens an AF_XDP/ZC socket
> 
> Assisted-by: Claude:claude-opus-5
> Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in stmmac_xdp_release()")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

This now matches the non-xdp case, great :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a..796817caf7af 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7178,15 +7178,15 @@ void stmmac_xdp_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);
> +
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  
> 

