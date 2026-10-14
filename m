Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D54FD799;
	Wed, 14 Oct 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977358; cv=none; b=aBR8Fps0dJgTkWND99P/VD86euPaWmBPBx6YwPGrdEmUHjnnx1KKtaEZ4QJggLpuUVpu+Tb1XV4/qN++FfWvgdqn+jWznEx0zyZegEuBjjbwnMK979KKrR/qeZ7mGDWO4WyJG9XDAET2uiah5uyWyBeGWNjhHpVgxGslh3pHa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977358; c=relaxed/simple;
	bh=AMxI6xjPLXgL60o9TjfB2lYUdKc2uiqhILt0euv+65k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+gU595QaxRPXzjb3+W4STWNM0jnQJ86pjMA2sgtnibhODIE0Q60GXTue3h61x5IgzVpDnsGeJhTpT9Lgbg5bV5Z+/2G/VUECjG4H5vM6qvXyU1S/zgEoyu5/7FptFkmN8XWoej+/VeC+67aka294M+EuGvZjTHhwGeqCpWDkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LQL9USjl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LQL9USjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791977357; x=1823513357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMxI6xjPLXgL60o9TjfB2lYUdKc2uiqhILt0euv+65k=;
  b=LQL9USjlpuJZJgjrEm5FZ/dKzM6wkNwiR2DHjq7pCaxl2QvXvhOS8rSF
   uhHYEKroHYQR0c2cLjsre855eIgk1WzWY+WdutgLZL+WWRyXG+yqY0A8Z
   8aqZLGZfh1o3mcqvIv6JEa74qgdkjAjDPGSaebDjOTwyZWg7eofh0dbhb
   VvcKUjYA3FIgS8ElJYlvhu035E4sOdeKjXqOK45zCTndxz+0fch3+qXLp
   xpNi0TBOtnVEB9MwOgIx1dU54Qp8R+P+L/B8wfYWLEl0yKJMUW6VL5SZc
   31siliuqL+CMbtIcoOgOoYP1rwp9vcrt80efXNNzaEK0G+UeKLW4yh/zd
   A==;
X-CSE-ConnectionGUID: xLoVMOOZRiyv16RTtLxe+w==
X-CSE-MsgGUID: 4pCQEFWfQvGQNii/bNe3QQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="232114399"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:29:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 04:29:15 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 14 Oct 2026 04:29:11 -0700
Date: Wed, 14 Oct 2026 13:29:11 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Joao Pinto
	<Joao.Pinto@synopsys.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>, Ong Boon Leong
	<boon.leong.ong@intel.com>, <bpf@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: stmmac: stop DMA when IRQ registration fails
Message-ID: <20261014112911.endm5wgbvl6rvn5k@DEN-DL-M70577>
References: <cover.1791958735.git.kmehltretter@gmail.com>
 <2b70886410b5e9207ef170a48aca1d2d7ce24a68.1791958735.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b70886410b5e9207ef170a48aca1d2d7ce24a68.1791958735.git.kmehltretter@gmail.com>

Hi,

> Both __stmmac_open() and stmmac_xdp_open() start DMA before requesting
> IRQs. If IRQ registration fails, their error paths release descriptors
> and packet buffers while the DMA channels remain active.
> 
> Stop all DMA channels before releasing those resources, matching the
> normal close paths.
> 
> Found by inspection. On a BeagleV Ahead (TH1520), fault injection in
> both normal-open and native-XDP-open paths reached IRQ unwind with DMA
> active on the baseline kernel. With this change, the DMA process states
> were idle before unwind and resource cleanup in both paths.

This fix looks suspiciously similar to a fix already accepted into net-next [1].

> 
> Fixes: 523f11b5d4fd ("net: stmmac: move hardware setup for stmmac_open to new function")
> Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 8fd7d2173..5c4df26a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4206,6 +4206,7 @@ irq_error:
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> +	stmmac_stop_all_dma(priv);
>  	stmmac_release_ptp(priv);
>  init_error:
>  	return ret;
> @@ -7259,6 +7260,7 @@ int stmmac_xdp_open(struct net_device *dev)
>  irq_error:
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> +	stmmac_stop_all_dma(priv);
>  
>  init_error:
>  	free_dma_desc_resources(priv, &priv->dma_conf);
> -- 
> 2.39.5 (Apple Git-154)
> 

[1] https://lore.kernel.org/netdev/32EB352EB66D74E7+20260827025415.2684733-1-zhaojinming@uniontech.com/
