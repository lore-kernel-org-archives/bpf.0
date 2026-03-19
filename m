Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCC28F935
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955902; cv=none; b=M6Ww0oXFKGZkWzUxzT4vhnv1HfytaqOcqshZN7TM9OeoYf8Nniq8kmQQ2YBPlYX0ngkkz/hf+uCmCbGy0HKoLRzyqbNLDwTuIHMgfOy0k0eQ54TMKLukITNY9YdMV07U1OZ0Sxwc5RL/5vUdRixE68wtCHV4fawM2xCJQrLjX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955902; c=relaxed/simple;
	bh=GtumRf9Hnr7mzKctDO7NBkPlSfbVhRO1qgZNUo3pCyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlKPExsbntpW42sHW0XXi+Mb8Y4omzaYYaLvuAkzXE2SDZRA80ppiInjrMNLFIHDaRy8+VOx5A4DyQ0/A+xPHBXUkxq1SAWKfgzJPxFRImRCoNM+/f4VkjHIHoEqk/aqbecrC0l6AFnwjFreiyz+0p9X74lBDhXJcUWmJgpib80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JKalKqIK; arc=none smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JKalKqIK"
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-463a0e14abfso705269b6e.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955899; x=1774560699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYR1hRHQabBPcbUT7i4RJJHIilqZNEUs6+JSY+yrheg=;
        b=P1MQWSRStXJNHpXUwS+j6ZHrlyn5Jc7wV/O3kHrr0RbYoURActMUBv2sL3ft36+g9s
         M02EEol8T0/1peyj6GdcPfBlx+z2MGlwJrLhP6UmQ9LIOxrp/2i1Sgl1JUcuWH9qKVFC
         bKVPrylotgA+ciZlKGje7/VtMbOHjxfJsIVSj3x/1IZUK0UfaFaXoHMzBOn5dbbutGIL
         2eJf9pP1nShuNDQxHiHt2SeJyjgZEcsf/qJueS/pQm/ajCmMr4jqyk374r5yG8WxC1YG
         q4Zkqu6EGf0nPLOSzizHZUK+4viqW+eOVuXy2DaS7YkHag2lH93jtTUziEqIa8bWpR7a
         +O0w==
X-Forwarded-Encrypted: i=1; AJvYcCXXO3DytZhEY13LW6Z0DHd88R2w3AcyxszuoXj+nNEIKbz7OBmfW0fQtfHLBl3rT51F/D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlv9uIJzVR7mgHJ5B7cL2o0lDNh8oCMqrK2SFYNi84elK8q5E
	yHTQCGTzQxD8o+u0oS97T6f6N3prQUOrO2Jo8WwcmCHWT1vxxMZwWAEMcJbx7tuiN8Mqwq2w+sh
	1/vEUJ5d+DaD/Yjb2cc12NxSP69dHYiLRQKb0r392SLx8UZFIQr0GaPc3jkSJJyFXvEdnmIgTuh
	MWgNkwK6VgIPdyFSRveMHWo7fnjA5SgV64yjtx++hGGr3J9QxO1zMWl2FxAuWbwNLihVx0c15oj
	5+eKg==
X-Gm-Gg: ATEYQzzE2emzuFE1o7lDYx5zg/OxBR7JzxADen+7PLgVRHPbdtsbJy98mEoehtudGb8
	5YpJI19oeimAVwJ0IF4rE6kp2BQht71YF7wgOJVMIAB/su4i+lyXHDa6Dpr2NA4XCCS2FQzBbbc
	XOAyjGbbjV+2OJacM5t4OUyv6WyzdtB3jcv75vw4zbf+9mMd57cbXys4hHOU2t43KfRxKAvX9ZA
	+L+ZJ5UMEggZRGNrnHdwoN0f6ez4msKIVhUCB9AXIeDk9e2ywZM63Lu3fMpzd3iqoVfgvNCOYqw
	2FURuYqQhFYnw1QyTJ7uafY1dV9Jbyfb+PB+xxxsW7sbYzeklYyKBDUTzUUguihwPl2AXaJPr1F
	K2uNiAIlnAkABYtaThumNnmSq2L2z7RaL4RRVP7JUM4ZDxB9D5+HbOuQnUuKx2GBAPKyvLM9Soe
	P6+zCerzomW5Y1mwMAaVdwPLpvgfE2JQiNxTDnx41f0XH13CDnc4WxHGM=
X-Received: by 2002:a05:6808:4fca:b0:464:a1ee:c412 with SMTP id 5614622812f47-467e5f419d4mr397129b6e.31.1773955899027;
        Thu, 19 Mar 2026 14:31:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41c14e0a584sm22152fac.13.2026.03.19.14.31.38
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:31:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7f6ac239so743541185a.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955898; x=1774560698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYR1hRHQabBPcbUT7i4RJJHIilqZNEUs6+JSY+yrheg=;
        b=JKalKqIKvV4QM2szytjntPwUxoJDPr3lJDHBPn98joObie6JWuutNNioy3MgUR1afV
         fERakJovjs9yfAfMWus7qdBeG42p00oWknSRezafvPaAOvdgze4I172qUhshNYv+DASV
         OhwXCZHZhPCMEfeA4HoJ7w+l2uxYeaS3et+Bk=
X-Forwarded-Encrypted: i=1; AJvYcCV7jL6BOPxakR+p6TMFU6cmoWqiDnl94jZ3IDQXVzwTSphRtYWzD1sH1WJEdbxhFIjkPBw=@vger.kernel.org
X-Received: by 2002:a05:620a:25d3:b0:8cd:8785:eff4 with SMTP id af79cd13be357-8cfc7b65c11mr135869985a.15.1773955897984;
        Thu, 19 Mar 2026 14:31:37 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:8cd:8785:eff4 with SMTP id af79cd13be357-8cfc7b65c11mr135862185a.15.1773955897225;
        Thu, 19 Mar 2026 14:31:37 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f934a4sm23212285a.16.2026.03.19.14.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:31:36 -0700 (PDT)
Message-ID: <47c7a6d1-c8e3-45c8-a2e1-213f44671306@broadcom.com>
Date: Thu, 19 Mar 2026 14:31:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
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
 <20260319115402.353509-5-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-5-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
> 
> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
> completion within the RX poll path.
> 
> The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
> to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
> TSB is prepended by backing xdp->data into the RSB area (unused after
> BPF execution) and zeroing it. For foreign frames (ndo_xdp_xmit), the
> TSB is written into the xdp_frame headroom.
> 
> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
> DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 195 ++++++++++++++++--
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +-
>   2 files changed, 181 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8f90d6b16a2..54df1694f1cd 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -48,8 +48,10 @@
>   
>   #define GENET_Q0_RX_BD_CNT	\
>   	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
> +#define GENET_Q16_TX_BD_CNT	64
>   #define GENET_Q0_TX_BD_CNT	\
> -	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
> +	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q \
> +	 - GENET_Q16_TX_BD_CNT)
>   
>   #define RX_BUF_LENGTH		2048
>   #define SKB_ALIGNMENT		32
> @@ -1893,6 +1895,14 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
>   		if (cb == GENET_CB(skb)->last_cb)
>   			return skb;
>   
> +	} else if (cb->xdpf) {
> +		if (cb->xdp_dma_map)
> +			dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
> +					 dma_unmap_len(cb, dma_len),
> +					 DMA_TO_DEVICE);
> +		dma_unmap_addr_set(cb, dma_addr, 0);
> +		xdp_return_frame(cb->xdpf);
> +		cb->xdpf = NULL;
>   	} else if (dma_unmap_addr(cb, dma_addr)) {
>   		dma_unmap_page(dev,
>   			       dma_unmap_addr(cb, dma_addr),
> @@ -1927,8 +1937,13 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   	unsigned int c_index;
>   	struct sk_buff *skb;
>   
> -	/* Clear status before servicing to reduce spurious interrupts */
> -	bcmgenet_intrl2_1_writel(priv, (1 << ring->index), INTRL2_CPU_CLEAR);
> +	/* Clear status before servicing to reduce spurious interrupts.
> +	 * Ring DESC_INDEX (XDP TX) has no interrupt; skip the clear to
> +	 * avoid clobbering RX ring 0's bit at the same position.
> +	 */
> +	if (ring->index != DESC_INDEX)
> +		bcmgenet_intrl2_1_writel(priv, BIT(ring->index),
> +					 INTRL2_CPU_CLEAR);
>   
>   	/* Compute how many buffers are transmitted since last xmit call */
>   	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX)
> @@ -1964,8 +1979,11 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   	u64_stats_add(&stats->bytes, bytes_compl);
>   	u64_stats_update_end(&stats->syncp);
>   
> -	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
> -				  pkts_compl, bytes_compl);
> +	/* Ring DESC_INDEX (XDP TX) has no netdev TX queue; skip BQL */
> +	if (ring->index != DESC_INDEX)
> +		netdev_tx_completed_queue(netdev_get_tx_queue(dev,
> +							      ring->index),
> +					  pkts_compl, bytes_compl);
>   
>   	return txbds_processed;
>   }
> @@ -2042,6 +2060,9 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
>   	do {
>   		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
>   	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
> +
> +	/* Also reclaim XDP TX ring */
> +	bcmgenet_tx_reclaim(dev, &priv->tx_rings[DESC_INDEX], true);
>   }
>   
>   /* Reallocate the SKB to put enough headroom in front of it and insert
> @@ -2299,10 +2320,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>   	return skb;
>   }
>   
> +static bool

Same as last patch. Perfer to remove newline here.

> +bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +			struct xdp_frame *xdpf, bool dma_map)
> +{
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	struct device *kdev = &priv->pdev->dev;
> +	struct enet_cb *tx_cb_ptr;
> +	dma_addr_t mapping;
> +	unsigned int dma_len;
> +	u32 len_stat;
> +
> +	spin_lock(&ring->lock);
> +
> +	if (ring->free_bds < 1) {
> +		spin_unlock(&ring->lock);
> +		return false;
> +	}
> +
> +	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
> +
> +	if (dma_map) {
> +		void *tsb_start;
> +
> +		/* The GENET MAC has TBUF_64B_EN set globally, so hardware
> +		 * expects a 64-byte TSB prefix on every TX buffer.  For
> +		 * redirected frames (ndo_xdp_xmit) we prepend a zeroed TSB
> +		 * using the frame's headroom.
> +		 */
> +		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +
> +		tsb_start = xdpf->data - sizeof(struct status_64);
> +		memset(tsb_start, 0, sizeof(struct status_64));
> +
> +		dma_len = xdpf->len + sizeof(struct status_64);
> +		mapping = dma_map_single(kdev, tsb_start, dma_len,
> +					 DMA_TO_DEVICE);
> +		if (dma_mapping_error(kdev, mapping)) {
> +			tx_cb_ptr->skb = NULL;
> +			tx_cb_ptr->xdpf = NULL;
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +	} else {
> +		struct page *page = virt_to_page(xdpf->data);
> +
> +		/* For local XDP_TX the caller already prepended the TSB
> +		 * into xdpf->data/len, so dma_len == xdpf->len.
> +		 */
> +		dma_len = xdpf->len;
> +		mapping = page_pool_get_dma_addr(page) +
> +			  sizeof(*xdpf) + xdpf->headroom;
> +		dma_sync_single_for_device(kdev, mapping, dma_len,
> +					   DMA_BIDIRECTIONAL);
> +	}
> +
> +	dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
> +	dma_unmap_len_set(tx_cb_ptr, dma_len, dma_len);
> +	tx_cb_ptr->skb = NULL;
> +	tx_cb_ptr->xdpf = xdpf;
> +	tx_cb_ptr->xdp_dma_map = dma_map;
> +
> +	len_stat = (dma_len << DMA_BUFLENGTH_SHIFT) |
> +		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT) |
> +		   DMA_TX_APPEND_CRC | DMA_SOP | DMA_EOP;
> +
> +	dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
> +
> +	ring->free_bds--;
> +	ring->prod_index++;
> +	ring->prod_index &= DMA_P_INDEX_MASK;
> +
> +	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
> +				  TDMA_PROD_INDEX);
> +
> +	spin_unlock(&ring->lock);
> +
> +	return true;
> +}
> +
>   static unsigned int
>   bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   		 struct xdp_buff *xdp, struct page *rx_page)
>   {
> +	struct bcmgenet_priv *priv = ring->priv;
> +	struct xdp_frame *xdpf;
>   	unsigned int act;
>   
>   	act = bpf_prog_run_xdp(prog, xdp);
> @@ -2310,14 +2417,33 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   	switch (act) {
>   	case XDP_PASS:
>   		return XDP_PASS;
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		xdp->data -= sizeof(struct status_64);
> +		xdp->data_meta -= sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));
> +
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf) ||
> +		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		return XDP_TX;
>   	case XDP_DROP:
>   		page_pool_put_full_page(ring->page_pool, rx_page, true);
>   		return XDP_DROP;
>   	default:
> -		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
> +		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
>   		fallthrough;
>   	case XDP_ABORTED:
> -		trace_xdp_exception(ring->priv->dev, prog, act);
> +		trace_xdp_exception(priv->dev, prog, act);
>   		page_pool_put_full_page(ring->page_pool, rx_page, true);
>   		return XDP_ABORTED;
>   	}
> @@ -2555,9 +2681,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
>   {
>   	struct bcmgenet_rx_ring *ring = container_of(napi,
>   			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv = ring->priv;
>   	struct dim_sample dim_sample = {};
>   	unsigned int work_done;
>   
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_prog)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->tx_rings[DESC_INDEX], false);
> +
>   	work_done = bcmgenet_desc_rx(ring, budget);
>   
>   	if (work_done < budget && napi_complete_done(napi, work_done))
> @@ -2832,8 +2964,11 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
>   	bcmgenet_tdma_ring_writel(priv, index, end_ptr * words_per_bd - 1,
>   				  DMA_END_ADDR);
>   
> -	/* Initialize Tx NAPI */
> -	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
> +	/* Initialize Tx NAPI for priority queues only; ring DESC_INDEX
> +	 * (XDP TX) has its completions handled inline in RX NAPI.
> +	 */
> +	if (index != DESC_INDEX)
> +		netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
>   }
>   
>   static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
> @@ -2845,7 +2980,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
>   		.pool_size = ring->size,
>   		.nid = NUMA_NO_NODE,
>   		.dev = &priv->pdev->dev,
> -		.dma_dir = DMA_FROM_DEVICE,
> +		.dma_dir = DMA_BIDIRECTIONAL,
>   		.offset = GENET_XDP_HEADROOM,
>   		.max_len = RX_BUF_LENGTH,
>   	};
> @@ -2977,6 +3112,7 @@ static int bcmgenet_tdma_disable(struct bcmgenet_priv *priv)
>   
>   	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
>   	mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
> +	mask |= BIT(DESC_INDEX);
>   	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
>   	reg &= ~mask;
>   	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
> @@ -3022,14 +3158,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
>    * with queue 1 being the highest priority queue.
>    *
>    * Queue 0 is the default Tx queue with
> - * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
> + * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 - 32 = 96 descriptors.
> + *
> + * Ring 16 (DESC_INDEX) is used for XDP TX with
> + * GENET_Q16_TX_BD_CNT = 32 descriptors.
>    *
>    * The transmit control block pool is then partitioned as follows:
> - * - Tx queue 0 uses tx_cbs[0..127]
> - * - Tx queue 1 uses tx_cbs[128..159]
> - * - Tx queue 2 uses tx_cbs[160..191]
> - * - Tx queue 3 uses tx_cbs[192..223]
> - * - Tx queue 4 uses tx_cbs[224..255]
> + * - Tx queue 0 uses tx_cbs[0..95]
> + * - Tx queue 1 uses tx_cbs[96..127]
> + * - Tx queue 2 uses tx_cbs[128..159]
> + * - Tx queue 3 uses tx_cbs[160..191]
> + * - Tx queue 4 uses tx_cbs[192..223]
> + * - Tx ring 16 uses tx_cbs[224..255]

Can keep the term tx queue? Unless we are trying to highlight something 
different here.

>    */
>   static void bcmgenet_init_tx_queues(struct net_device *dev)
>   {
> @@ -3050,13 +3190,18 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
>   			<< DMA_PRIO_REG_SHIFT(i);
>   	}
>   
> +	/* Initialize ring 16 (descriptor ring) for XDP TX */
> +	bcmgenet_init_tx_ring(priv, DESC_INDEX, GENET_Q16_TX_BD_CNT,
> +			      TOTAL_DESC - GENET_Q16_TX_BD_CNT, TOTAL_DESC);
> +
>   	/* Set Tx queue priorities */
>   	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
>   	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
>   	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);
>   
> -	/* Configure Tx queues as descriptor rings */
> +	/* Configure Tx queues as descriptor rings, including ring 16 */
>   	ring_mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
> +	ring_mask |= BIT(DESC_INDEX);
>   	bcmgenet_tdma_writel(priv, ring_mask, DMA_RING_CFG);
>   
>   	/* Enable Tx rings */
> @@ -3770,6 +3915,21 @@ static void bcmgenet_get_stats64(struct net_device *dev,
>   		stats->tx_dropped += tx_dropped;
>   	}
>   
> +	/* Include XDP TX ring (DESC_INDEX) stats */
> +	tx_stats = &priv->tx_rings[DESC_INDEX].stats64;
> +	do {
> +		start = u64_stats_fetch_begin(&tx_stats->syncp);
> +		tx_bytes = u64_stats_read(&tx_stats->bytes);
> +		tx_packets = u64_stats_read(&tx_stats->packets);
> +		tx_errors = u64_stats_read(&tx_stats->errors);
> +		tx_dropped = u64_stats_read(&tx_stats->dropped);
> +	} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
> +
> +	stats->tx_bytes += tx_bytes;
> +	stats->tx_packets += tx_packets;
> +	stats->tx_errors += tx_errors;
> +	stats->tx_dropped += tx_dropped;
> +
>   	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
>   		rx_stats = &priv->rx_rings[q].stats64;
>   		do {
> @@ -4273,6 +4433,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
>   	for (i = 0; i <= priv->hw_params->tx_queues; i++)
>   		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
> +	u64_stats_init(&priv->tx_rings[DESC_INDEX].stats64.syncp);
>   
>   	/* libphy will determine the link state */
>   	netif_carrier_off(dev);
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 1459473ac1b0..fce598c29a96 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -472,6 +472,8 @@ struct bcmgenet_rx_stats64 {
>   
>   struct enet_cb {
>   	struct sk_buff      *skb;
> +	struct xdp_frame    *xdpf;
> +	bool                xdp_dma_map;
>   	struct page         *rx_page;
>   	unsigned int        rx_page_offset;
>   	void __iomem *bd_addr;
> @@ -610,7 +612,7 @@ struct bcmgenet_priv {
>   	struct enet_cb *tx_cbs;
>   	unsigned int num_tx_bds;
>   
> -	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
> +	struct bcmgenet_tx_ring tx_rings[DESC_INDEX + 1];

This creates a bunch of tx_rings that aren't used. I don't see why we 
need them in the same array. The logic above loops through the queue 
rings, then hits the DESC_INDEX ring last. So not too much value of 
keeping them in the same array.

Thanks,
Justin

>   
>   	/* receive variables */
>   	void __iomem *rx_bds;

