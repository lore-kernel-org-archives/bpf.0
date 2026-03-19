Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCD3B8924
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956059; cv=none; b=LE9eI+ONPnPA9/hPJKeSlaF59H+M2hB/dOi+B4sn7dvBQOe3K2IAw1IxsYpDe+lNM///QSzZuSG04Gj3xIbF6PzOXLoRGOZygVw1Bd6sGEaYRH8HdMniMZIPW6HLV/YaytcKVQ+jn4Ju76fp9B7rc7+bhEQ8dnrNDQ9gelLOUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956059; c=relaxed/simple;
	bh=lG7rGzi3OC6nDMoSjr9UVsfX8Z+lay1soEw8+JaEcLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQqp7+LFEmhBOEM1Pmw2r+csp0z1L3fK7lpm+fxnYoWFOjl3OGwUEJdhay3B8F9bqTEfucUVI3b3JroiIDXq6aPmiAL+dkKZqXWgrnXLLhMn6SPopMWPHz1WmtzkDIwVHYm4wtHdqlTUx1xepGzzGFrijbGXRz+C9i7Pl2USgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gUKLIXJt; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUKLIXJt"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c742d7c8acfso520053a12.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956057; x=1774560857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Nrx0bSsouA08qG3vFSADaw9hcTHYzowASvPsD/ztQ=;
        b=iZOz0vEEjqGakGL5I2EWqTbFIlUTsdIHnmv/2Fv7Jj+/dEWoQtHv7gRKXt6M24yeiX
         5W/ZRLKukFLocLOSVK/3S2FTQPR9n32DIB3nexBuwK4Ricq9g3N9zUE6HYf9JHlKMdIg
         FEyLIEHCRhX5eOlHMwiPd3ABy2FwhcKCqbBP3IjHICcTs0T6uVEsTTAGuZ6aGQP5tJUH
         WbEwiD9rQhwqerCFtPiJXKWNOI3serRfAZ1XaLoP/5BAus8364fYqxUtKnz4ptItOoMl
         Lb2PYGuVk9wm2HFETI0c98x90FbxRqf8vsGxTZRUzQuOjHF42xSbHXt35YiZj7kWjxxT
         Olaw==
X-Forwarded-Encrypted: i=1; AJvYcCXH9RKPY2JRXcF52LhDFgdPQS7CXmFqbTjWhEDylTS0Kna/hlASLehgxD9MYKro5UkDomY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGX+upwGrYcywDPoOovAfE2s2et8DaPriJ9abPB+TxZ3PFBdTR
	E/RuPUqi3p0SexYa/6MmUK3nRxLSoKSBfRHFdzFYhQQhZjz2kIFGzbeodmR3+grNTHjh0rgMLBp
	fBF80jhCAeeaneU5vCR/PWmpVYdjyeO48yR/hHyNcVFg4MNzE25GycgrLBOM3Ed3Py+cO60gd5a
	mS0LfOlnzWQdM64/w+2m1TC6/14++p79kjEz9QbEd7nfO1l4FtCS5FSdZDisr0Iw2p2yNXmdB5G
	m1zCA==
X-Gm-Gg: ATEYQzzVsa2BAfAZbEf5fguweZpDV9HcMq2iRXY+s0fIAo0LEegX0wms04sgCZBRtgl
	AsuXxSNMgdHyDEIH1n3h1a/iyeCckivVWyoTYSz4vsoR/yanhPSqqGjwk7+cZvhXqKNj4/o3T5+
	GQIdLhCO4y3kuW6blVFOjoQOBO3e/wURxi7cNVp0p+fJRAT5Iylarp/Y1z0dblYIZ6aILV1jmgX
	js69AUHfCDVdGO8sWG2dN2aK584IlDn4rS6NuNqEB9wd6+SCmVj5LEfOuY0Vc29WHZFppd+uPff
	icaHUNUck8CV/Q/fzGqfGwkiuPbuzEcLazBquqkVWYJ3oMPUOOvZkMQ5TWm0rCHcOEoAmZYfigZ
	X628bmjfBCyEGDTiZUCQw0ie+8n9/J7KfVvIOCAxOJ7KV2ZDY0/7dyXD1UHWCUbqQGLy4nBVD5p
	aMQ8zqCEPjOhcxPTcKsJWEo8GkpDa/QuEXcTZjIMmeJXYrcaGb2GkeM4w6Ig==
X-Received: by 2002:a17:903:1a0f:b0:2b0:4f82:74b1 with SMTP id d9443c01a7336-2b0827c165emr5653525ad.44.1773956056617;
        Thu, 19 Mar 2026 14:34:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0835211ccsm327915ad.23.2026.03.19.14.34.16
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:34:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81be6f05so937461185a.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773956055; x=1774560855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Nrx0bSsouA08qG3vFSADaw9hcTHYzowASvPsD/ztQ=;
        b=gUKLIXJtmfg8uvX5mQnBOeOo/Jj+Sws5yi8LdsZs7TTvyaHjBbqy51czR52OzKYG+I
         ZwlYovAZllkIxA//KVt0CiZ45Y/3l+/WVfjaP7grU6FHWCJ9YPeKucM1V6x2QFksX3c8
         FiPFklXpyuZ6iMYZk353vl84uN4WpKVE7ToKk=
X-Forwarded-Encrypted: i=1; AJvYcCU5e3SHPyApN7vJDnHjJVxIiz6FDVfxeLoTiUEESUN+u9y+xr/6AvNNsOA0sc9r+6I27fI=@vger.kernel.org
X-Received: by 2002:a05:620a:290d:b0:8cd:bfd9:b947 with SMTP id af79cd13be357-8cfc7e670abmr132470985a.5.1773956055438;
        Thu, 19 Mar 2026 14:34:15 -0700 (PDT)
X-Received: by 2002:a05:620a:290d:b0:8cd:bfd9:b947 with SMTP id af79cd13be357-8cfc7e670abmr132466285a.5.1773956054831;
        Thu, 19 Mar 2026 14:34:14 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f93489sm21780785a.15.2026.03.19.14.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:34:14 -0700 (PDT)
Message-ID: <94f75509-ac47-42ab-a46d-4082b9c2acb0@broadcom.com>
Date: Thu, 19 Mar 2026 14:34:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-6-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-6-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Add XDP_REDIRECT support and implement ndo_xdp_xmit for receiving
> redirected frames from other devices.
> 
> XDP_REDIRECT calls xdp_do_redirect() in the RX path with
> xdp_do_flush() once per NAPI poll cycle. ndo_xdp_xmit batches frames
> into ring 16 under a single spinlock acquisition.
> 
> Advertise NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT in
> xdp_features.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 98 +++++++++++++++----
>   1 file changed, 80 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 54df1694f1cd..a5ad25ccb148 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2320,23 +2320,23 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>   	return skb;
>   }
>   
> +/* Submit a single XDP frame to the TX ring. Caller must hold ring->lock.
> + * Returns true on success. Does not ring the doorbell - caller must
> + * write TDMA_PROD_INDEX after batching.
> + */
>   static bool
>   bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +			struct bcmgenet_tx_ring *ring,
>   			struct xdp_frame *xdpf, bool dma_map)
>   {
> -	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
>   	struct device *kdev = &priv->pdev->dev;
>   	struct enet_cb *tx_cb_ptr;
>   	dma_addr_t mapping;
>   	unsigned int dma_len;
>   	u32 len_stat;
>   
> -	spin_lock(&ring->lock);
> -
> -	if (ring->free_bds < 1) {
> -		spin_unlock(&ring->lock);
> +	if (ring->free_bds < 1)
>   		return false;
> -	}
>   
>   	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
>   
> @@ -2350,7 +2350,6 @@ bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>   		 */
>   		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
>   			bcmgenet_put_txcb(priv, ring);
> -			spin_unlock(&ring->lock);
>   			return false;
>   		}
>   
> @@ -2364,7 +2363,6 @@ bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>   			tx_cb_ptr->skb = NULL;
>   			tx_cb_ptr->xdpf = NULL;
>   			bcmgenet_put_txcb(priv, ring);
> -			spin_unlock(&ring->lock);
>   			return false;
>   		}
>   	} else {
> @@ -2396,12 +2394,15 @@ bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>   	ring->prod_index++;
>   	ring->prod_index &= DMA_P_INDEX_MASK;
>   
> +	return true;
> +}
> +
> +static void

Perfer to remove newline.

> +bcmgenet_xdp_ring_doorbell(struct bcmgenet_priv *priv,
> +			   struct bcmgenet_tx_ring *ring)
> +{
>   	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
>   				  TDMA_PROD_INDEX);
> -
> -	spin_unlock(&ring->lock);
> -
> -	return true;
>   }
>   
>   static unsigned int
> @@ -2417,7 +2418,11 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   	switch (act) {
>   	case XDP_PASS:
>   		return XDP_PASS;
> -	case XDP_TX:
> +	case XDP_TX: {
> +		struct bcmgenet_tx_ring *tx_ring;
> +
> +		tx_ring = &priv->tx_rings[DESC_INDEX];
> +
>   		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
>   		 * MAC has TBUF_64B_EN set globally, so hardware expects every
>   		 * TX buffer to begin with a 64-byte struct status_64.  Back
> @@ -2429,14 +2434,26 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   		memset(xdp->data, 0, sizeof(struct status_64));
>   
>   		xdpf = xdp_convert_buff_to_frame(xdp);
> -		if (unlikely(!xdpf) ||
> -		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> +		if (unlikely(!xdpf))
> +			goto drop_page;
> +
> +		spin_lock(&tx_ring->lock);
> +		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring,
> +						      xdpf, false))) {
> +			spin_unlock(&tx_ring->lock);
> +			xdp_return_frame_rx_napi(xdpf);
>   			return XDP_DROP;
>   		}
> +		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
> +		spin_unlock(&tx_ring->lock);
>   		return XDP_TX;
> +	}

Don't think we need this extra curly bracket here.

> +	case XDP_REDIRECT:
> +		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog)))
> +			goto drop_page;
> +		return XDP_REDIRECT;
>   	case XDP_DROP:
> +drop_page:

Not a big fan of jumping like this within switch statements.

>   		page_pool_put_full_page(ring->page_pool, rx_page, true);
>   		return XDP_DROP;
>   	default:
> @@ -2459,6 +2476,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   	struct bcmgenet_priv *priv = ring->priv;
>   	struct net_device *dev = priv->dev;
>   	struct bpf_prog *xdp_prog;
> +	bool xdp_flush = false;
>   	struct enet_cb *cb;
>   	struct sk_buff *skb;
>   	u32 dma_length_status;
> @@ -2597,6 +2615,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   
>   			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
>   						   rx_page);
> +			if (xdp_act == XDP_REDIRECT)
> +				xdp_flush = true;
>   			if (xdp_act != XDP_PASS)
>   				goto next;
>   
> @@ -2670,6 +2690,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   		bcmgenet_rdma_ring_writel(priv, ring->index, ring->c_index, RDMA_CONS_INDEX);
>   	}
>   
> +	if (xdp_flush)
> +		xdp_do_flush();
> +
>   	ring->dim.bytes = bytes_processed;
>   	ring->dim.packets = rxpktprocessed;
>   
> @@ -3995,10 +4018,16 @@ static int bcmgenet_xdp_setup(struct net_device *dev,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	if (!prog)
> +		xdp_features_clear_redirect_target(dev);
> +
>   	old_prog = xchg(&priv->xdp_prog, prog);
>   	if (old_prog)
>   		bpf_prog_put(old_prog);
>   
> +	if (prog)
> +		xdp_features_set_redirect_target(dev, false);
> +
>   	return 0;
>   }
>   
> @@ -4012,6 +4041,37 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   	}
>   }
>   
> +static int

Same as before

> +bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
> +		  struct xdp_frame **frames, u32 flags)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	int sent = 0;
> +	int i;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	if (unlikely(!netif_running(dev)))
> +		return -ENETDOWN;
> +
> +	spin_lock(&ring->lock);
> +
> +	for (i = 0; i < num_frames; i++) {
> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
> +			break;
> +		sent++;
> +	}
> +
> +	if (sent)
> +		bcmgenet_xdp_ring_doorbell(priv, ring);
> +
> +	spin_unlock(&ring->lock);
> +
> +	return sent;
> +}
> +
>   static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_open		= bcmgenet_open,
>   	.ndo_stop		= bcmgenet_close,
> @@ -4024,6 +4084,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_get_stats64	= bcmgenet_get_stats64,
>   	.ndo_change_carrier	= bcmgenet_change_carrier,
>   	.ndo_bpf		= bcmgenet_xdp,
> +	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
>   };
>   
>   /* GENET hardware parameters/characteristics */
> @@ -4326,7 +4387,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   			 NETIF_F_RXCSUM;
>   	dev->hw_features |= dev->features;
>   	dev->vlan_features |= dev->features;
> -	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			    NETDEV_XDP_ACT_NDO_XMIT;
>   
>   	netdev_sw_irq_coalesce_default_on(dev);
>   

