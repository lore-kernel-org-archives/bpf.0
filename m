Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC14CB8BC;
	Mon, 12 Oct 2026 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834204; cv=none; b=nnHy1ePUi4zMAG+OI3RUP0mpvBtM+MOsfsGg/8xN11sYe8q8JqM21WrEmCHrTNrbWtpqsrKHWRqrKYjkTEaqEjrKsDT094XITDxJca8Y8dUGB5ULyRThkOr0lN3L6rZYaHaGm54PcxhxOOXBCWL99AQsrseRDj40Rdk87R9ZmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834204; c=relaxed/simple;
	bh=46e1U6DavjbOemIRYpekVuACQIQhaJ1HQ/H/m0zwm8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwkvXEaTIpByS4EfbhJ7D8eKNbn2RvNgrJXXfaeaiEn7UF4bwODfW39ftH6tTBFHRJjgUVD0NkYYrshRBcF5cCOOI6dAPtpC9WSwng5pbMRkVF9EigTNwK4oCfPhCrhEaYHQCr70Sv3U1xikeasgRQA9WZJXlQKdzAT9QiOvxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S6YyxZoc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S6YyxZoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791834203; x=1823370203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46e1U6DavjbOemIRYpekVuACQIQhaJ1HQ/H/m0zwm8Y=;
  b=S6YyxZocILMkVLT9tUsbO/MhBIK94Sq1l0fxgOXD/E+JmMRCUm3vaei3
   EfdoWNOxgVDKHX/1rrred9bIKwwUTdYYfrVOtVK7V2SAoprEWNQRUkgqh
   OehSKrSF1bRDPLkvSRqQLp+350tm4Q7Kr+h3KTidA0dmXOTulFrJP1u8X
   COqk8ULn5hIXVGi8VpgcYX7Xvs1Xhfu1D3OliyFJ5pewSuzxBgm78W8K/
   HQnuT0YDSFWwxquwoqTfcwY35G4LWvcIWvHEhw97JzQxTy0o0Di2T/erZ
   XrFE2fc7rwQ6IJ6TGw7EyJCrXC2roPUJHUtba81NfguVKFo0EbR6OJJar
   w==;
X-CSE-ConnectionGUID: Z5px7yJ/SWqdbS/RQmR7RQ==
X-CSE-MsgGUID: ri7xwyZNQO+xB8N1XTZv9A==
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="75255144"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 12:43:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 12 Oct 2026 12:43:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 12 Oct 2026 12:43:18 -0700
Date: Mon, 12 Oct 2026 21:43:17 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Ong Boon Leong <boon.leong.ong@intel.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
Message-ID: <20261012194317.o642ym7ddsmny25x@DEN-DL-M70577.microsemi.net>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>

Hi Lorenzo,

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

Looks to me like mtu > ETH_DATA_LAN is rejected when setting a prog, and also
on mtu change when a prog is attached. So can this even happen today?

> 
> Use virt_to_head_page() to read the DMA base of the buffer and keep the
> offset relative to the head page (sizeof(*xdpf) + xdpf->headroom), which
> is correct no matter which page the data ends up in.

I think the fix looks correct.

> 
> Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
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
> -- 
> 2.56.0
> 

/Daniel
