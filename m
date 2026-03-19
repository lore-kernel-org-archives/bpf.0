Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10754402B9D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955389; cv=none; b=fTcpjPtAgXmGyx+9ggdpCuPgpVsYFKw/TqwDrdQMxGQK3MqtKbjX42z+EYc+BZrYTy3gvoiawXsMmaPs6ZS8rZyR86v/h2zLQj15FQMb5J7Dryp4g3IQsdqrm2JexTW8vQeE/dW6kdpjc6UvuNa7EwkHfKD9fXV/cea88vkskt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955389; c=relaxed/simple;
	bh=K/XCPyc+m/DfZ3quCRmYqnABbbUHxG9UCrCKRvbCQf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT8SSy0DBUVKcWlsUdwQ9ZW32V7mWU/wRpPRbuwmHZpcj7TZU3FwPBBRkt5oXf2CV+I1G05DU7TCKF7zsu4Y5mvXP055P1JMfDSPdeqIg6o9svaYcYEOkHoAz7c1G/XR2ZyzfF5/ZZIJ4jC3P5V9jQNYbWHcluNZ/DBYLLDuZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cV5HyhMp; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cV5HyhMp"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-899fbf92bdbso14006756d6.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955387; x=1774560187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XCD7P77uKOJaU71jQh2aYICC6t2lNxcd5cbzp78RBM=;
        b=L9j1B4y95y/yS5VI7KL5T2VdNHMvqmonW5tAV1ZEWfE/qpmfvBC1yj9DmT6vK/pmak
         67Q2x/8I6Sl0RKlVaAwZiPuVw+yEKUs1LPnXnWL+bau081MXYz3ZZj9tb8lp5OhQirbF
         6agdMS/VXQlPnhX5oIhkG8a7zsxTmm3qctWzkKIIASifBy6hCp1sSTRqDQJpl3QBTNOT
         U2cFta5g55ORU54/QunOmnEt7TGtMnJN0PK0NJUvtMvNDBDyNj3MCDUJ6A/vrE1A3rU1
         xMaZKFpTGt0oVjJ2HkQQawDTisEjF93+bBoZN+KHo30KP0/8gsAkyS3wdr7zOpMb+/Ab
         h0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv7/uq1MGzgEfCuGxY/PZr3JqS36/rJYf9fNLAe+GP3nex4Pe7zF3M20jSb2HUEi3s5Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtvywOCrvrTchM/jSfSATgXzFq6dOvYBus/20HIM9Ue4VaF16
	QD8RyIRCDtXS5Yv5itJ6Vr8AqOo8vUhStPn65h0Cy9TXvmEhM3lhyXnyef8bTsavumpVYTrI1QP
	beq9lo131d3d11TRZTJ7VbRTHWsRYAZvgmcoh44+ODo7AIiF39AZ4GFkRH0iovOjBsfwJcr195M
	Kv4qqc8kNW7oUe+9fblrYFXWQkE2fjPhkaCQ031PR3SdS9uejyxEFlLxpbb2GgFbP5ze0YIuhKv
	GS4Jg==
X-Gm-Gg: ATEYQzwhDf8kUydsRpaSnVa2TfJkeiAnzx9EZXcHmuuRoviIzANq2+OhzSwFI4i96Wq
	hH+7zhFczyYgI7IeehPfgQDsIQQDlsgBYov98HT+c58zDphakRdWA7iJh89xu2tfdBUxKzL/1MI
	8sbTPfhOCRbSNYW6FqYaigyiSkr+gKhEpGlgIlLtyzG4VIKLyE6I4931ls0y96AlNMp29dA5nxK
	JqgmFbjF561O9ANBb7spm1qoXqSFZ7HMGw2jyBGKG5M/gEKweskMUT65PB8oYne2guCJrSaflb3
	Dw5Rko8EdoQvNPKdGVhPNPKkjyPX3R4dYtIFHLt/9xRSEUQ2QV7eDc6m4PshrM1tCXf8Z+oKVgx
	BLBsJbcYOBfHugTW+aMQDgXWhFR1dv11suBtQ8JR8hqF4Y0KmWWUR+0EyVjsbXXHBB4PBTS3lxl
	tD5Hz04+/uD1kPaJ/0Y3LjZhhYjX05DK78+is6ajI1chs3FfC9EOtzj1NrRg==
X-Received: by 2002:a0c:f101:0:b0:89a:6f04:ac85 with SMTP id 6a1803df08f44-89c85a9043fmr7910396d6.54.1773955386752;
        Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c8522bacdsm617286d6.10.2026.03.19.14.23.06
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c1030ca85eso7093389eec.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955385; x=1774560185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XCD7P77uKOJaU71jQh2aYICC6t2lNxcd5cbzp78RBM=;
        b=cV5HyhMpbeNi0pftRvm/737kp5kHS5QB2fsD5b9BaI3k4ooWRdAHBX+W9HJ+j8Nl4w
         vxN+r9BT8Z06nrIdrkRa8P4GgGRp8LHT1dijJZk5ODrPAsVKMpACX4lWjLWGk/eVpdGg
         OgzLOvGJmftvUt6IcQzRPYeG2pfmqFKsoEfG0=
X-Forwarded-Encrypted: i=1; AJvYcCXolXDqpBqs5spp4b4yZOeWudjBTknBd1i6AvfnkOsfytv1LMjZXTC8swaI8KAmMaC6o14=@vger.kernel.org
X-Received: by 2002:a05:7300:6423:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2c109712f8dmr558410eec.16.1773955385420;
        Thu, 19 Mar 2026 14:23:05 -0700 (PDT)
X-Received: by 2002:a05:7300:6423:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2c109712f8dmr558392eec.16.1773955384705;
        Thu, 19 Mar 2026 14:23:04 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm657777eec.10.2026.03.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:23:04 -0700 (PDT)
Message-ID: <e5ca230b-f288-4583-ab52-22d1c73fa5eb@broadcom.com>
Date: Thu, 19 Mar 2026 14:23:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
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
 <20260319115402.353509-4-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Add XDP program attachment via ndo_bpf and execute XDP programs in the
> RX path. XDP_PASS builds an SKB from the xdp_buff (handling
> xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
> SKB allocation.
> 
> XDP_TX and XDP_REDIRECT are not yet supported and return XDP_ABORTED.
> 
> Advertise NETDEV_XDP_ACT_BASIC in xdp_features.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 147 +++++++++++++++---
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
>   2 files changed, 133 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 6e610e73e12f..e8f90d6b16a2 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -35,6 +35,8 @@
>   #include <linux/ip.h>
>   #include <linux/ipv6.h>
>   #include <linux/phy.h>
> +#include <linux/bpf_trace.h>
> +#include <linux/filter.h>
>   
>   #include <linux/unaligned.h>
>   
> @@ -2274,6 +2276,53 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>   	return 0;
>   }
>   
> +static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
> +					      struct xdp_buff *xdp,
> +					      struct page *rx_page)
> +{
> +	unsigned int metasize;
> +	struct sk_buff *skb;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_mark_for_recycle(skb);
> +
> +	metasize = xdp->data - xdp->data_meta;
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	__skb_put(skb, xdp->data_end - xdp->data);
> +
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +
> +	return skb;
> +}
> +
> +static unsigned int

Perfer to not have a newline here. To match the formatting of the rest 
of the driver.

Thanks,
Justin

> +bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
> +		 struct xdp_buff *xdp, struct page *rx_page)
> +{
> +	unsigned int act;
> +
> +	act = bpf_prog_run_xdp(prog, xdp);
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return XDP_PASS;
> +	case XDP_DROP:
> +		page_pool_put_full_page(ring->page_pool, rx_page, true);
> +		return XDP_DROP;
> +	default:
> +		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(ring->priv->dev, prog, act);
> +		page_pool_put_full_page(ring->page_pool, rx_page, true);
> +		return XDP_ABORTED;
> +	}
> +}
> +
>   /* bcmgenet_desc_rx - descriptor based rx process.
>    * this could be called from bottom half, or from NAPI polling method.
>    */
> @@ -2283,6 +2332,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
>   	struct bcmgenet_priv *priv = ring->priv;
>   	struct net_device *dev = priv->dev;
> +	struct bpf_prog *xdp_prog;
>   	struct enet_cb *cb;
>   	struct sk_buff *skb;
>   	u32 dma_length_status;
> @@ -2293,6 +2343,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   	unsigned int p_index, mask;
>   	unsigned int discards;
>   
> +	xdp_prog = READ_ONCE(priv->xdp_prog);
> +
>   	/* Clear status before servicing to reduce spurious interrupts */
>   	mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
>   	bcmgenet_intrl2_1_writel(priv, mask, INTRL2_CPU_CLEAR);
> @@ -2403,26 +2455,52 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   			goto next;
>   		} /* error packet */
>   
> -		/* Build SKB from the page - data starts at hard_start,
> -		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> -		 */
> -		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
> -		if (unlikely(!skb)) {
> -			BCMGENET_STATS64_INC(stats, dropped);
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> -			goto next;
> -		}
> -
> -		skb_mark_for_recycle(skb);
> +		/* XDP: frame data starts after RSB + pad */
> +		if (xdp_prog) {
> +			struct xdp_buff xdp;
> +			unsigned int xdp_act;
> +			int pkt_len;
> +
> +			pkt_len = len - GENET_RSB_PAD;
> +			if (priv->crc_fwd_en)
> +				pkt_len -= ETH_FCS_LEN;
> +
> +			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +			xdp_prepare_buff(&xdp, page_address(rx_page),
> +					 GENET_RX_HEADROOM, pkt_len, true);
> +
> +			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
> +						   rx_page);
> +			if (xdp_act != XDP_PASS)
> +				goto next;
> +
> +			/* XDP_PASS: build SKB from (possibly modified) xdp */
> +			skb = bcmgenet_xdp_build_skb(ring, &xdp, rx_page);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
> +		} else {
> +			/* Build SKB from the page - data starts at
> +			 * hard_start, frame begins after RSB(64) + pad(2).
> +			 */
> +			skb = napi_build_skb(hard_start,
> +					     PAGE_SIZE - GENET_XDP_HEADROOM);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
>   
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +			skb_mark_for_recycle(skb);
> +			skb_reserve(skb, GENET_RSB_PAD);
> +			__skb_put(skb, len - GENET_RSB_PAD);
>   
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> -			len -= ETH_FCS_LEN;
> +			if (priv->crc_fwd_en)
> +				skb_trim(skb, skb->len - ETH_FCS_LEN);
>   		}
>   
>   		/* Set up checksum offload */
> @@ -3743,6 +3821,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>   	return 0;
>   }
>   
> +static int bcmgenet_xdp_setup(struct net_device *dev,
> +			      struct netdev_bpf *xdp)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +	struct bpf_prog *prog = xdp->prog;
> +
> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "MTU too large for single-page XDP buffer");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	old_prog = xchg(&priv->xdp_prog, prog);
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	return 0;
> +}
> +
> +static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	switch (xdp->command) {
> +	case XDP_SETUP_PROG:
> +		return bcmgenet_xdp_setup(dev, xdp);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_open		= bcmgenet_open,
>   	.ndo_stop		= bcmgenet_close,
> @@ -3754,6 +3863,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_set_features	= bcmgenet_set_features,
>   	.ndo_get_stats64	= bcmgenet_get_stats64,
>   	.ndo_change_carrier	= bcmgenet_change_carrier,
> +	.ndo_bpf		= bcmgenet_xdp,
>   };
>   
>   /* GENET hardware parameters/characteristics */
> @@ -4056,6 +4166,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   			 NETIF_F_RXCSUM;
>   	dev->hw_features |= dev->features;
>   	dev->vlan_features |= dev->features;
> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
>   
>   	netdev_sw_irq_coalesce_default_on(dev);
>   
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 82a6d29f481d..1459473ac1b0 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -16,6 +16,7 @@
>   #include <linux/dim.h>
>   #include <linux/ethtool.h>
>   #include <net/page_pool/helpers.h>
> +#include <linux/bpf.h>
>   #include <net/xdp.h>
>   
>   #include "../unimac.h"
> @@ -671,6 +672,9 @@ struct bcmgenet_priv {
>   	u8 sopass[SOPASS_MAX];
>   
>   	struct bcmgenet_mib_counters mib;
> +
> +	/* XDP */
> +	struct bpf_prog *xdp_prog;
>   };
>   
>   static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)

