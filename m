Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854942;
	b=d2MhjSMjWnPHV2LNdaN0qqDDcfIIj9vtrfGDnPIvdad0pb2ZiQ+FQkvQKM4PWujkbNjZ
	 BZKjwVjlsHV5XmcuaBVqJwG2KPawFsDUAAZx2E7TAZTO0DPWiMgFPaEyqKAppCeXfI+ub
	 3VTJOSoKD+RGNDAL7GR1OFT1BPMy2L28nJpFj+HAtMNxiXVkm8LrUXY/0My42HSsEuBh6
	 ppGaDC6Uab75bSu/TI1z1qTNWDZvcG/CXX3RPdZcoPehkDzoFKsnkFsCnUWEO3Di61ney
	 TqjgBUFlanZRcJnCh+NSnFBKzUpKA9ypqpPBOOJYuRuONuhBNRTmPAEpl5R7ZOZuJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j3G1ywiLrx0DaX6rFe9rFmmqvrfjRGltmL0+DsTi2zI=;
	b=TXOBz4UyNX9SoeG4cNIl2B7559Q6j2ZaG+QkjJAqVgqxtX/sjnwWsdlcD0m7EtRx2zsU
	 nY/tmZ2eUogDVhHVbPOSrf6hZkFS8MRQUuNN1KrXlTZ+L33uxHL3W7Per4NNp6L2mdWx+
	 H4n/ghdMG3emqgvTqAmzCTSCQGPmCf0lqmsmz/KfcK9Ods8UOhej87Y8iPfscF+KffaEx
	 0hbAEKgoJm8W4y0GquFDMnUMiT9XPD7haSqV2/dds8W0MFm9Ai4nN7TRpB3TZE6zC+iSx
	 vSYXhW/OQt+v6RWvQH+xInG9SsG9rZSFbnEG2xFWy4otRRJrvOo8QD+ilYd67dkMbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ti7O2lyS;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A76606A332
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A76606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ti7O2lyS
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4478854c88.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854940; x=1795459740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3G1ywiLrx0DaX6rFe9rFmmqvrfjRGltmL0+DsTi2zI=;
        b=ti7O2lySHCTLXENn+2qZUo5FRBVZlA0I6T2IOZpmIwwxcnkaSSreB0i9zTCN3jr+Fy
         cR6eIpnV+OSt/fkY0MdDkn5VfLZG9F/VEzhWw8o9EZQp8IKM2ZVLyFHUlwQDObWYmXMh
         J2fSx+Xb8aCLffsT9MBsqq+sqwmc8ZRDCnrWwXLYZnhi6VhV6qiwZADb8n88jfZxJ5g7
         TlN+FxjpLI7YL/k1S8nuYl/7S6iXA0widaEItDoGCZlnNnHJ5aSWvmlkvPusNZm5AnZ0
         3cnpm0J81lfiY1qXqlBTFSAxXAcFo8u569ov+vf1GkTBpfjxxBS6tzS2mRroKEiJrbYi
         kayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854940; x=1795459740;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3G1ywiLrx0DaX6rFe9rFmmqvrfjRGltmL0+DsTi2zI=;
        b=xk8Sy/WPxPUhA0Q8AGYUNeNW/kKyCh6X/pqQjYHd7C6yycoiZV2cyjSUzIcSnMtR84
         j88cgSIctjZ47LJb4RwgG5wUO8++QkVnsMr9wFpiHgcAVtuj2JSSWbIKKzONEDJoWKIp
         5Z/dQn2KW0yZhFKvGlyrK0FMIToFWilXs3GK0vNLQad71qAtPSAlCgZxMusiG4JxqHVy
         VyEzzWFC5M0ziINurLnejELRBsHX1ip701/eeHIzPb0jPmgOxt2vIPQzsstWAirOi1aN
         CmqdAm23cq1ZA/qqZ67GauN607hUAyjtGmIh564dOqUX7nMSYbD4GjxGQV1NzLCaO909
         hIzg==
X-Forwarded-Encrypted: i=1; AL+hErGVqRt3RPkaNQG8N3mZWNNhUT9Yo1AFMlsQAIun9Cz9DJMM2yTs5+N500ZPtP0XHORfA50=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XkXMfq7lB0A+vodAMNdtMA7EtZFDb/WYJayCRmfaXds+m+eks
	NqUoRMWXhg6wYzmtBwP0/+sQU8TAcFlqQVXfMeu5ahgwgjq8YyV56sRs
X-Gm-Gg: AYBFou33x+M97fb3McXt/l+hLYUsKBhti8Tt4i1gt4LRQf/me3c7le8vln3SuymoXx5
	hPzlHUzjpniSTlT5P9Bj2/AJRYlNkDQVweyKvbv4Y0FqyVCej4av3Luyb+7RAiOnZi93mwnbS1R
	fJmsrlLZtn945G4MXTKkBGpKV1SIPOgTdJ8fSl1OzHz1z7WFoHQ+L2mFmUf0+eNUwHjRKPf0p5F
	CKgoXNfwgEDmo9TjORrnczp/Qe24yd57PT5TQe0a3idK9yuSoWoz/hFG86NyLv7A/ALb8DPaPK/
	oxMYTM1logMdEYwMXqa2JIpFNuEEaGZ4F/IwzfhgTw85nutE62Y/aNT8U0+Yi6uHEPVG9va4/hH
	r5DBJTEYLz5ZUo9Pj69mqz/7o4SKQ+l+by+A/QkULvoazg+N2U49lMHsCqid/QecTA8EBf9q4cm
	6tkT3UP4zNMTkzQwGW7fcScqEYa4wXe8F7mH4gvLpG1rVzBFj9uC9tn+GRbIJTVlN++YKy8og2L
	kexLwocfo6bjA000ygzrBtazZyb4LvI/YPMyIXejUomq2o7niUa22zD4wiCfRCQUhLCiCgejUnD
	zJnQ1PejVXWnmHsLvN6CyazIUTSTuL7FF8iyKIRfMfKEmRn4vONvLhBrD9opHPClQshFS625Cgj
	gbwEH+e59wl0AdtLLMqMfinnt7P7H5aNO8eQ2Sw==
X-Received: by 2002:a05:7022:b902:b0:1b2:4cc7:7db2 with SMTP id a92af1059eb24-1b503175e5dmr10752909c88.47.1794854940305;
        Mon, 16 Nov 2026 10:49:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::7:3f76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm33383125c88.2.2026.11.16.10.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 10:48:59 -0800 (PST)
Message-ID: <6303b161-0f35-47ee-ab70-ebd4e802ae09@gmail.com>
Date: Mon, 16 Nov 2026 10:48:53 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, io-uring@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>
Cc: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
 Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20261110102039.1002605-12-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/26 2:20 AM, Björn Töpel wrote:
> Header and payload rings share one provider page pool, so refills even
> them out, and a short pool does not starve one of them. Payload
> buffers start at chunk offset 0, and the UMEM headroom rules require
> headroom only in the first buffer. A chunk is one 4 KiB device page,
> also with larger kernel pages, so rings fed by the provider post one
> descriptor per chunk.
> 
[...]
>  	qt->sub0.page_pool = pp;
> +	fbnic_bdq_set_page_size(&qt->sub0, xsk ? rx_page_size : PAGE_SIZE);
>  	qt->hdr_max = 0;
>  	if (!page_pool_supports_frag(pp))
> -		qt->hdr_max = fbnic_whole_hdr_max(FBNIC_RX_HROOM);
> +		qt->hdr_max = fbnic_whole_hdr_max(qt->rx_hroom);
>  	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
>  		pp_params.order = get_order(rx_page_size);
>  		pp_params.max_len = rx_page_size;
>  		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>  		pp_params.dma_dir = DMA_FROM_DEVICE;
>  
> +		pp = page_pool_create(&pp_params);
> +		if (IS_ERR(pp))
> +			goto err_destroy_sub0;
> +	} else if (xsk && !xsk_pool_uses_sg(xsk)) {
> +		pp_params.flags &= ~PP_FLAG_MEM_PROVIDER;
> +		pp_params.rx_roles = 0;
> +		pp_params.max_len = PAGE_SIZE;
> +		rx_page_size = PAGE_SIZE;
> +
>  		pp = page_pool_create(&pp_params);
>  		if (IS_ERR(pp))
>  			goto err_destroy_sub0;

Maybe I'm misunderstanding, but why is it necessary to create a new page pool for
sub1 if !sg? All frames should be sent to sub0, and the buffers in sub1 should sit idle.

> @@ -1709,6 +1967,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
>  		page_pool_get(pp);
>  	}
>  	qt->sub1.page_pool = pp;
> +	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
>  
>  	return 0;
>  
> @@ -1717,16 +1976,6 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
>  	return PTR_ERR(pp);
>  }
>  
> -static u8 fbnic_bdq_page_shift(u32 page_size)
> -{
> -	return ilog2(page_size / FBNIC_BD_PAGE_SIZE);
> -}
> -
> -static void fbnic_bdq_set_page_size(struct fbnic_ring *bdq, u32 page_size)
> -{
> -	bdq->bd_page_shift = fbnic_bdq_page_shift(page_size);
> -}
> -
>  static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
>  			    int q_idx, u8 flags)
>  {
> @@ -1830,7 +2079,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
>  		if (xdp_count > 0) {
>  			unsigned int xdp_idx = FBNIC_MAX_TXQS + rxq_idx;
>  
> -			fbnic_ring_init(&qt->sub1, db, xdp_idx, flags);
> +			fbnic_ring_init(&qt->sub1, db, xdp_idx,
> +					flags | FBNIC_RING_F_XDP);
>  			fbn->tx[xdp_idx] = &qt->sub1;
>  			xdp_count--;
>  		} else {
> @@ -1977,6 +2227,9 @@ static int fbnic_alloc_tx_ring_buffer(struct fbnic_ring *txr)
>  {
>  	size_t size = array_size(sizeof(*txr->tx_buf), txr->size_mask + 1);
>  
> +	if (txr->flags & FBNIC_RING_F_XDP)
> +		size = array_size(sizeof(*txr->xdp_buf), txr->size_mask + 1);
> +
>  	txr->tx_buf = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
>  
>  	return txr->tx_buf ? 0 : -ENOMEM;
> @@ -2126,20 +2379,19 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
>  	return err;
>  }
>  
> -static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
> -				       struct fbnic_napi_vector *nv,
> -				       struct fbnic_q_triad *qt,
> -				       u32 rx_page_size)
> +static int
> +fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
> +			    struct fbnic_napi_vector *nv,
> +			    struct fbnic_q_triad *qt,
> +			    const struct netdev_queue_config *qcfg)
>  {
>  	struct device *dev = fbn->netdev->dev.parent;
>  	int err;
>  
> -	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, rx_page_size);
> +	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, qcfg);
>  	if (err)
>  		return err;
>  
> -	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
> -
>  	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->cmpl.q_idx,
>  			       nv->napi.napi_id);
>  	if (err)
> @@ -2203,8 +2455,7 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
>  		struct netdev_queue_config qcfg;
>  
>  		netdev_queue_config(fbn->netdev, nv->qt[i].cmpl.q_idx, &qcfg);
> -		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i],
> -						  qcfg.rx_page_size);
> +		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i], &qcfg);
>  		if (err)
>  			goto free_qt_resources;
>  	}
> @@ -2598,9 +2849,8 @@ static void fbnic_nv_fill(struct fbnic_napi_vector *nv)
>  	for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
>  		struct fbnic_q_triad *qt = &nv->qt[t];
>  
> -		/* Populate the header and payload BDQs */
> -		fbnic_fill_bdq(&qt->sub0);
> -		fbnic_fill_bdq(&qt->sub1);
> +		/* Populate the header and payload BDQs; NAPI retries */
> +		fbnic_fill_bdqs(qt);
>  	}
>  }
>  
> @@ -2736,14 +2986,20 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
>  				       struct fbnic_ring *rcq, bool tx_pause,
>  				       bool hdr_split)
>  {
> +	struct fbnic_q_triad *qt = container_of_const(rcq, struct fbnic_q_triad,
> +						     cmpl);
>  	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
> -	u32 drop_mode, rcq_ctl;
> +	u32 drop_mode, hroom, rcq_ctl;
> +
> +	/* The device aligns the maximum value up to FBNIC_RX_HROOM_MAX. */
> +	hroom = min_t(u32, qt->rx_hroom,
> +		      FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK));
>  
>  	drop_mode = fbnic_drop_mode(fbn, tx_pause);
>  
>  	/* Specify packet layout */
>  	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
> -	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
> +	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, hroom) |
>  	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM) |
>  	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT, hdr_split);
>  
> @@ -3028,8 +3284,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
>  	struct fbnic_napi_vector *nv;
>  
>  	if (!netif_running(dev))
> -		return fbnic_alloc_qt_page_pools(fbn, qt, idx,
> -						 qcfg->rx_page_size);
> +		return fbnic_alloc_qt_page_pools(fbn, qt, idx, qcfg);
>  
>  	/* A failed PCIe recovery or resume can leave the datapath torn down
>  	 * while netif_running() is still true.  This ndo runs before
> @@ -3049,7 +3304,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
>  	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
>  			real->cmpl.flags);
>  
> -	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg->rx_page_size);
> +	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg);
>  }
>  
>  static void fbnic_default_qcfg(struct net_device *dev,
> @@ -3086,6 +3341,14 @@ static int fbnic_validate_qcfg(struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (qcfg->rx_headroom &&
> +	    (qcfg->rx_headroom < XDP_PACKET_HEADROOM ||
> +	     qcfg->rx_headroom > FBNIC_RX_HROOM_MAX ||
> +	     !IS_ALIGNED(qcfg->rx_headroom, FBNIC_RX_HDR_ALIGN))) {
> +		NL_SET_ERR_MSG_MOD(extack, "rx_headroom is not supported");
> +		return -EINVAL;
> +	}
> +
>  	/* Payload fragments occupy multiples of FBNIC_RX_PAYLD_ALIGN bytes.
>  	 * Keep at least one reference in the bias until fbnic_clean_bdq()
>  	 * observes a completion from a subsequent allocation.
> @@ -3216,5 +3479,6 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
>  	.ndo_queue_stop		= fbnic_queue_stop,
>  	.ndo_default_qcfg	= fbnic_default_qcfg,
>  	.ndo_validate_qcfg	= fbnic_validate_qcfg,
> -	.supported_params	= QCFG_RX_PAGE_SIZE,
> +	.supported_params	= QCFG_RX_PAGE_SIZE | QCFG_RX_HEADROOM,
> +	.xsk_page_pool		= true,
>  };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> index 3077d9bbd587..b4baaa914585 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> @@ -14,7 +14,11 @@
>  
>  #include "fbnic_csr.h"
>  
> +struct bpf_prog;
>  struct fbnic_net;
> +struct netlink_ext_ack;
> +struct xsk_buff_pool;
> +struct xsk_rx_check;
>  
>  /* Guarantee we have space needed for storing the buffer
>   * To store the buffer we need:
> @@ -36,6 +40,8 @@ struct fbnic_net;
>   */
>  #define FBNIC_MAX_RX_PKT_DESC	7
>  #define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * 2)
> +/* All descriptors of a packet but the two metadata ones */
> +#define FBNIC_MAX_RX_BUFS	(FBNIC_MAX_RX_PKT_DESC - 2)
>  
>  #define FBNIC_MAX_TXQS			128u
>  #define FBNIC_MAX_RXQS			128u
> @@ -66,6 +72,9 @@ struct fbnic_net;
>  	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
>  #define FBNIC_RX_PAD			0
>  #define FBNIC_RX_HDR_ALIGN		128
> +#define FBNIC_RX_HROOM_MAX \
> +	ALIGN(FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK), \
> +	      FBNIC_RX_HDR_ALIGN)
>  #define FBNIC_RX_PAYLD_ALIGN		128
>  #define FBNIC_RX_PAYLD_OFFSET		0
>  #define FBNIC_RX_PAYLD_PG_CL		0
> @@ -73,6 +82,7 @@ struct fbnic_net;
>  #define FBNIC_RING_F_DISABLED		BIT(0)
>  #define FBNIC_RING_F_CTX		BIT(1)
>  #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
> +#define FBNIC_RING_F_XDP		BIT(3)	/* XDP TX ring */
>  
>  #define FBNIC_HDS_THRESH_MAX \
>  	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
> @@ -121,12 +131,18 @@ struct fbnic_rx_buf {
>  	long pagecnt_bias;
>  };
>  
> +/* XDP TX ring entry: an XDP_TX buffer, or an AF_XDP TX descriptor */
> +struct fbnic_xdp_tx_buf {
> +	netmem_ref netmem;
> +	struct xsk_buff_pool *xsk;
> +};
> +
>  struct fbnic_ring {
>  	/* Pointer to buffer specific info */
>  	union {
>  		struct fbnic_pkt_buff *pkt;	/* RCQ */
>  		struct fbnic_rx_buf *rx_buf;	/* BDQ */
> -		netmem_ref *tx_netmem;		/* TWQ1 */
> +		struct fbnic_xdp_tx_buf *xdp_buf; /* TWQ1 */
>  		void **tx_buf;			/* TWQ */
>  		void *buffer;			/* Generic pointer */
>  	};
> @@ -167,6 +183,10 @@ struct fbnic_q_triad {
>  	struct fbnic_ring sub0, sub1, cmpl;
>  	struct xdp_rxq_info xdp_rxq;
>  	u16 hdr_max;	/* Header bytes for whole header buffers, or 0 */
> +	u16 rx_hroom;	/* Headroom before a header */
> +	u16 rx_hdr_first; /* Offset of the first header in a buffer */
> +	u16 rx_frame_off; /* Offset of the frame in a header buffer */
> +	struct xsk_buff_pool *xsk_pool;	/* AF_XDP pool of an RX queue */
>  };
>  
>  struct fbnic_napi_vector {
> @@ -178,6 +198,7 @@ struct fbnic_napi_vector {
>  	u16 v_idx;
>  	u8 txt_count;
>  	u8 rxt_count;
> +	u8 xsk_tx_next;		/* RX queue that sends socket TX first */
>  
>  	struct fbnic_q_triad qt[];
>  };
> @@ -203,6 +224,8 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
>  void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
>  				       struct fbnic_ring *xdpr);
>  
> +int fbnic_xsk_validate(const struct xsk_rx_check *check,
> +		       struct bpf_prog *prog, struct netlink_ext_ack *extack);
>  int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
>  void fbnic_free_napi_vectors(struct fbnic_net *fbn);
>  int fbnic_alloc_resources(struct fbnic_net *fbn);

