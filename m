Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DE427F85;
	Wed, 14 Oct 2026 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977824; cv=none; b=n4GaijNekKZyq0+MHRj4XSgTkDcMmDdy70zTtCHDQj1WH21Y3tukMIj8qxFsbs9J+oltO35Rhtuwkg4brcjO7dgf3K4MxvRXptf/piC2eu/jsOmipp70NNEozd7YSUf+Qs7CD2XopzZ348/N0ZxszErU2mbr2XVvDGqDZdFB36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977824; c=relaxed/simple;
	bh=cb5RXwy2JdsG8blil/34oe7gGzFgLLLfv23hCi6LDsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHwmns3zvGtUZ6e4U3PH+FNb7NywSRkZHRWD7ScKERQBCRb5MVZhWxjJAp/zYT0qydGoGsyprg/K1EY06eeOfr4sg5TdAb1g9ZrAWIeWnuunXfOXYRppoQ3zeuQsC2lEmBpteAQDn1U03Qotz28HTHGg1bfV6Clm6uDygx/tfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KN3wh9U2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KN3wh9U2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA5881A120D;
	Wed, 14 Oct 2026 11:36:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CEF760368;
	Wed, 14 Oct 2026 11:36:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C15210328B69;
	Wed, 14 Oct 2026 13:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791977813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RWr4W8qcelLOSOObSDeK6oL03Nao8/tZn3JtOigt+lk=;
	b=KN3wh9U25CaGmHoqLk8+9jWhf9PKPQE9q+5fQmZN+j+BygbA0yHlbpjADBoWObUtdlgFlu
	sZ+ehrjmIVmL7o1Hu82ecjFGJFa9ZjseEtw+FE0lB9CNB16860mAjGTqQ+TWByoJfxT2g2
	FZSLCYtoATRwETUg845nqSu/+JgsDvvRhcnEpXv4CQrE5jeZYGYot+z/meNrbGz16Qdj3z
	faCrCVK/hsndMY0TkEXkv3QgD0fiSr9mXycJiOaRv7c3bNo/+21tZh9N+cJr725kH2u/bv
	7DDMI01UkD4f6Ff/+qLerGkjT3JLVqCLMI3YjSvuuxPcuMZ74qDziorSrZBB7A==
Message-ID: <70b0cca1-1a59-4a86-9416-976912421bf5@bootlin.com>
Date: Wed, 14 Oct 2026 13:36:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: stmmac: handle partially allocated DMA
 queues
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ong Boon Leong <boon.leong.ong@intel.com>, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1791958735.git.kmehltretter@gmail.com>
 <3537f9a4f3e875291812486982b907b3b02bec15.1791958735.git.kmehltretter@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <3537f9a4f3e875291812486982b907b3b02bec15.1791958735.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/14/26 08:26, Karl Mehltretter wrote:
> DMA allocation failure unwinds every configured queue, including the
> failed queue and queues not yet allocated. The cleanup helpers then
> dereference buffer arrays that may not exist.
> 
> Only traverse allocated buffer arrays. Clear freed pointers because the
> queue structures persist and XDP reconfiguration can reuse them.
> 
> Found by inspection. On a BeagleV Ahead (TH1520), fault injection at
> the RX buffer metadata and TX DMA metadata allocations reached these
> invalid cleanup paths before a test guard stopped them. With this
> change, cleanup completed without the guard.
> 
> Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
> Fixes: ce736788e8a9 ("net: stmmac: adding multiple buffers for TX")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Please look at https://lore.kernel.org/netdev/20261012142458.2845385-1-dinghui1111@163.com/ .

LLMs keep finding the same bugs again and again, make sure you ask
it if there isn't already an in-flight patch for it before sending it :)

Maxime


> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b837e8e27..495ff7aef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2144,10 +2144,12 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	void *addr;
>  
>  	/* Release the DMA RX socket buffers */
> -	if (rx_q->xsk_pool)
> -		dma_free_rx_xskbufs(priv, dma_conf, queue);
> -	else
> -		dma_free_rx_skbufs(priv, dma_conf, queue);
> +	if (rx_q->buf_pool) {
> +		if (rx_q->xsk_pool)
> +			dma_free_rx_xskbufs(priv, dma_conf, queue);
> +		else
> +			dma_free_rx_skbufs(priv, dma_conf, queue);
> +	}
>  
>  	rx_q->buf_alloc_num = 0;
>  	rx_q->xsk_pool = NULL;
> @@ -2161,13 +2163,17 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
>  
>  	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>  
>  	kfree(rx_q->buf_pool);
> +	rx_q->buf_pool = NULL;
>  	if (rx_q->page_pool)
>  		page_pool_destroy(rx_q->page_pool);
> +	rx_q->page_pool = NULL;
>  }
>  
>  static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
> @@ -2196,7 +2202,8 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	void *addr;
>  
>  	/* Release the DMA TX socket buffers */
> -	dma_free_tx_skbufs(priv, dma_conf, queue);
> +	if (tx_q->tx_skbuff_dma && tx_q->tx_skbuff)
> +		dma_free_tx_skbufs(priv, dma_conf, queue);
>  
>  	if (priv->extend_desc) {
>  		addr = tx_q->dma_etx;
> @@ -2209,9 +2216,14 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;
>  
>  	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
>  	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
>  }
>  
>  static void free_dma_tx_desc_resources(struct stmmac_priv *priv,

