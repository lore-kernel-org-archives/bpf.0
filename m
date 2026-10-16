Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D594DD3C6
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160021; cv=none; b=E3j/QfH71MbjdyxtdhIbzuXmea2GnzhgKO8/nFQPFA75qMzzi+YcgXsmDG0JeMFRU3soeBQoGcVK+Mt0A+BHP4oT1c7CsTZCrOR7Gc1DrRWh2qeLyquAEnwx4Lr3P6UOoMOZCGS6qIXHDzdnv48P+5YAeswjweAY3cez+8Ax8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160021; c=relaxed/simple;
	bh=KJgCaBKgzhlQ6j4VpKM2iFyUAr1RpvtkySGD+mGP2zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG6VjmV1Roln68K4smUER1CUV3Uf1uxgFqKQiJfg6EcwX9lr8Gc2HsCqhn1S1/d4rOGqBSIaMqO0FgxXCjSGXZFDKFhFquB7qRxgDphJh0+zwuOevjUfTuDqumA2scikC4732YWmNHNA/7M8DtFAyjJGsRPx5SpNAKWNXZv7Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JFRXNfY/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JFRXNfY/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A42DFC62214;
	Fri, 16 Oct 2026 14:14:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF8F06075D;
	Fri, 16 Oct 2026 14:13:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4AF1103281F4;
	Fri, 16 Oct 2026 16:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792160010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=blwq1pXBCQjTGMl+JWvwWp+PQ7nHppX+egLYS89xJeg=;
	b=JFRXNfY/cQ7P5wBnYY3ft07I0gMR2s634u1n99dDArTUzg20EF9olCxy8ILqkbo0repWYr
	i+RrkZdPbVFBgH55Aqc1KO+IXoxfihLwqJsuAYnJ86Xjor29wt8YmkhHh4DjIdxTIQq3lL
	uLQBczkD04IIx3RGgqLe0Jogt5UcIlwv2LTduSz15I27CbTwUNkNOqBlH2M9NgFAvD2z1B
	ig27IjqWg5Wp8kzHYklPqM5rW4wvVPq6QFNJnSf6PBQV7tPHgdXy3JuAPbyoRt1xqt85Mq
	f7JsigUmSzMK3tcvmm4b93soNc46q7k2pfSvC/zMV0DTgz1MlnKzLOVXsA3JOg==
Message-ID: <84af909c-a94e-4408-a24d-d3fd729cd90e@bootlin.com>
Date: Fri, 16 Oct 2026 16:13:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 10/12/26 17:24, Lorenzo Bianconi wrote:
> When RX buffers are compound pages (order > 0), only the head page
> carries the DMA address programmed by the page pool
> (page_pool_get_dma_addr()). stmmac_xdp_xmit_xdpf() computed the head
> buffer's bus address from the page that happens to contain the data:
> 
> 	page = frag ? skb_frag_page(frag)
> 		    : virt_to_page(xdpf->data);
> 	dma_addr = page_pool_get_dma_addr(page);
> 	...
> 
> RX pages become compound as soon as dma_buf_sz needs more than one page
> (pp_params.order = order_base_2(num_pages) > 0), which happens from an
> MTU around 3000 bytes once dma_buf_sz reaches 4096. If an XDP program
> moves the data forward with bpf_xdp_adjust_head() by more than about a
> page, xdpf->data points into a tail page whose struct page has no DMA
> address: page_pool_get_dma_addr() then returns a bogus bus address, and
> dma_sync_single_for_device() together with the TX descriptor transmit
> from the wrong location.
> 
> Use virt_to_head_page() to read the DMA base of the buffer and keep the
> offset relative to the head page (sizeof(*xdpf) + xdpf->headroom), which
> is correct no matter which page the data ends up in.
> 
> Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b8b4de4c5b1a..ca61ab449e32 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5301,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  			struct page *page;
>  
>  			page = frag ? skb_frag_page(frag)
> -				    : virt_to_page(xdpf->data);
> +				    : virt_to_head_page(xdpf->data);
>  			dma_addr = page_pool_get_dma_addr(page);
>  			if (frag)
>  				dma_addr += skb_frag_off(frag);
> 

