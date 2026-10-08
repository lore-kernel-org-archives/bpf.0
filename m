Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E33C10A0;
	Thu,  8 Oct 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446098; cv=none; b=YlwXEaqowgn2gEsffwf6LbLn0xHivDt0eYIBcQ50k2M4FJeVytEQ7NHX+01iUKsOdDwuNh434aV8T9WYC13t2hObOhLwP0/nbxkSDMLYxiTRACxzAmPfM5xMQLi/b/dN5ZM0okf6w8z0cz4X1O/Fj9ZHuW+QnC9Qaq8xCi5e+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446098; c=relaxed/simple;
	bh=sced9RpvWM15YWex4SvlAM4adErT3eeshrFdAZVpJds=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=STnb8vsbtqLdZxteljJ8lnyMrBEnoTPpWJjzfbMVXRVp1JANlvoGGDrHWNVtuR7NmEcAMZbQzJoQxlVyZX5M4AgO5cIdcjdJVNb88FJ93oisOlEJV80Tagmmhbek1NTKCqGRQXB3So+cdTKOX3R4hWChWGp2Se9L6AylCgULH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=knH70O9L; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="knH70O9L"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36771A0957;
	Thu,  8 Oct 2026 09:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791446093; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nOGGehV28daWJf9qST4Dzu/SVjt55hUykjS1Zi7cwqQ=;
	b=knH70O9LDJSwXk48ooaH+Tm2qArFPgIhLyTzJz9WArPWgBeXhXWeI7Bt6sYLQAdLVXi+tB
	S6AL9rDE7A3F7wLYXSqLBxH3SjYuDneqPyQBkg4eC3q+TRjYpgTtPz3stYesNR64BFDY6R
	QNwdFOid4C/K1rNvj+wgK+qOm0hkUcMjeGJsE2STHGeLN0lWlrYcaQVSPpG8u9z5/KSHEz
	i2jWxbSPZSiRh739Upf/mspgNO/lFBGFT1ZRNMihRml8Z/sQ8H3ku1SU7WQP62MbLd83ty
	XqJVVJe7PRReJfmHj1NS+Vc7ErprwvoCe2BWzhNLTgXeT7XbfTzS5t/k39OcAQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 09:54:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Noor Azura Ahmad Tarmizi
 <noor.azura.ahmad.tarmizi@intel.com>, Mohd Faizal Abdul Rahim
 <faizal.abdul.rahim@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
Message-ID: <377d56dbc9be2874af7369112d9e49b9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kurt

On 5.10.2026 09:09, Kurt Kanzenbach wrote:
> When enabling or disabling XSK pools in parallel to Tx traffic, kernel
> crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
> dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
> dwmac4_set_addr(). Both of these functions access the Tx DMA 
> descriptors.
> 
> The XDP pool (en|dis)ablement frees and reallocates the Tx DMA 
> resources:
> 
>  stmmac_disable_tx_queue:
>    __free_dma_tx_desc_resources
> 
>  stmmac_enable_tx_queue:
>    __alloc_dma_tx_desc_resources
>    __init_dma_tx_desc_rings
> 
> NAPI is disabled during that allocation window, but the Tx queue is not
> stopped. Therefore, add the stopping of the Tx queue during the 
> enabling
> and disabling of XSK pools. Update trans_start when stopping the queue
> to avoid spurious watchdog timeouts.
> 
> The issue can be easily reproduced by:
> 
>  1. Run iperf
>  2. Run application which opens an AF_XDP/ZC socket
> 
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0..883bd3fe8089 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -6,6 +6,16 @@
>  #include "stmmac.h"
>  #include "stmmac_xdp.h"
> 
> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 
> queue)
> +{
> +	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
> +
> +	__netif_tx_lock_bh(nq);
> +	txq_trans_cond_update(nq);
> +	netif_tx_stop_queue(nq);
> +	__netif_tx_unlock_bh(nq);
> +}
> +
>  static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  				  struct xsk_buff_pool *pool, u16 queue)
>  {
> @@ -36,6 +46,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv 
> *priv,
>  	if (need_update) {
>  		napi_disable(&ch->rx_napi);
>  		napi_disable(&ch->tx_napi);
> +		stmmac_xdp_stop_tx_queue(priv, queue);

Unfortunately XDP_TX and ndo_xdp_xmit() ignore the stopped queue and 
still
hit the freed ring. I can reproduce this on STM32MP215 with a veth 
redirect
into the port while toggling the pool:

   pc : dwmac4_set_addr+0x8/0x18
   lr : stmmac_xdp_xmit_xdpf+0x1d0/0x3f0
    stmmac_xdp_xmit+0xe4/0x1a8
    bq_xmit_all+0xa0/0x208
    __dev_flush+0x60/0xc0
    xdp_do_flush+0x134/0x198
    veth_poll+0x258/0x340

Both go through stmmac_xdp_xmit_xdpf() with the queue lock held, so this
fixes it for me:

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
       dma_addr_t dma_addr;
       bool set_ic;

+     /* Ring may be torn down for an XSK pool switch */
+     if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
+             return STMMAC_XDP_CONSUMED;
+
       if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
               return STMMAC_XDP_CONSUMED;

This is older than your patch, but could you fold it in / add a oatch?

> [...]

Thanks,
Nicolai
