Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439269;
	b=IWRW9JCgraZk5jePIlFur7FXVFBdXhoga1y2v1JD3E/xFxCAb+kINv4uX+EWF7MfsXT8
	 Bu9HsH8vydfAOw8HKHBKnqBf4jS/FpdQAtBp0Dz6XQrHqXny9tTbMWWsSyluspTFLhvgq
	 CxMTq4fCgcR1Jn4iipDk2vqD1y8Z6q4w3XxV8xRQTF07aFhrsy4WOBq0YhsDc9OPORjKq
	 lwuDyDmRE3h7x6mczBVhd1Tm6QOUHLM/reumCGpSTiUQP5Q25Qqm8WazcgkA1iJMU+taC
	 V1rHOJv7R9z1EMGjhE7wqGRwE4ErxL6T9hbdNBO1m+HB63WGLS7g5/rgm2FXDf8A3xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=yLiNMvxVQruQcm1dmYQM6B9T1c0wqmTNiOzMtEKz3a0=;
	b=2FVAcoZTLlPyiHX6RJ8uS3/Y7BxUq7qhJyPDdxYV1ot3E9nKstHFnhVJDjlKeuInJcmx
	 7PEaLIdAh5817ARSiHoD1OoGyn25h9Z3r32KqVCytF4nju31StlrpEIygi5OxO6yYKhVC
	 E70WTbt1lEjXfMsLfBP87VRG+ME7uDlM/2+hyHD6HxM7+MWG7eKtszmGxsjY/v7hLQTkp
	 T/tmz3PccH0eEMCpCWXZjOluHKhCUEPdW9JBFlcsE75HpxyUOa1HSd7DuO0pgzbvwUSI2
	 QcVfhFL1vAIUcD8AxeiVYWHPDcFfvw5FulEtKikJpo8i74wi4yvpkckCbwhmttuikpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tWA/XaWh";
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925660A3813
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 23:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2925660A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWA/XaWh
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso3336359c88.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439267; x=1795044067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLiNMvxVQruQcm1dmYQM6B9T1c0wqmTNiOzMtEKz3a0=;
        b=tWA/XaWhilDIFlnze3RfmXPT3zuLapRVFasaiN9nd0tewyRhLSq/JoPBuRjVBnWEQF
         EfJ2wfgsGX9owNgchteKd1lIu6RiSP3OH9AEtymuJ65j8FrudMdGkfDxyMJoyeAIJoM5
         wXaQ1drt7KU9O2M3MfvOiG8VNWFHnGTmcWYxF43Uv/U157sVRXT6hKUfXK1PW7gw0sHJ
         RwVku3hTl++BEabzGqVclt/k2pJ9Vb6VrzAfl7t5hSqMBdtfkABefgGE5YtRN0IX4PLj
         ceM2Gr/lktRQmiB0BBCRstLwizRWtFbe4/wlxG3NV4klLz1FaaanhWSP9Z65w3fzO8E2
         J3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439267; x=1795044067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yLiNMvxVQruQcm1dmYQM6B9T1c0wqmTNiOzMtEKz3a0=;
        b=hbMMQZRELy0/zcbOdWtBuzCgPQ6ap80WLJPuFLPw5i23Ljt6TbIwObptMLIihYNnFU
         wT6oLQQactXLCc/XZluDqeKNd7kCnXBxQg8KoGN/0dqyKJKdtXK2K7IISq66SDq5CYDG
         +/TpPFWLGdbHDVQ7IVAoda7o1fYNytOroPiuQtUMtrE/cxj7fzcKTNj2XJS2gUFvuebF
         puEUMauFpcmE1fwP6FnY4AoWS2CxKxBbQPbTsjbtMYVG5eHCKpaC7tdVg1Q4YAOkBBNW
         kY57h/9GuKLzhSAFVgQXv9Ww1VlRqfBrwCIa3psMl/DmsD4F5v1uoq5xyXPKH03ifoSk
         EYTA==
X-Forwarded-Encrypted: i=1; AL+hErGSqAwjswdumSjEEJx+D2VeNzs1puh7IfV3ISc4ibSRr6Vxxto4DQsMWoOE047L/23rCUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ICbpK7awzsDEBrWGRgdpvfVhKpnj5OP9CkyTCG11/OqV6TCQN
	3afFCID7RpMPGIoWIcroPO0JFfUhT/9d8Bs9cnkpvIcl4NxpN6wijQas
X-Gm-Gg: AYBFou0k3P56lT04RV/vo9GZl89+0R3hGESmgLoDeyKEyMJGjRCFSKTsJCej4vt79Km
	nw6TzU3/YGY55T/Yt0QMidEBtHMzlYqILK4XOrPnxiAKnXRzjiiDNSoO4/hb74TX2pi8rICwWiX
	wmcW+lViJZBbDdSMdMymR8wl64eP/E/bY1Bps6VioRMvz3K7Mw+ItUipgpVidlGYZeSbbaMR1CP
	CI7Pk/ScHlZmHylc4JgPZDdu5S/ojkGC3cwHAVx4aOO1BOJOKZArAr4utA6XdKu+58rPZyuybsI
	0qGcIqcm0SwLq4lVMRL1Unkp0VZBJbLOZepTap3ZVb+EmMWbh0poisYukZudwpQyIUg1rJ4BMHE
	gMy5oJsNZcyXCPiDgJuk2vNLjEUJFIx9Ydia5+2ju2BBq1iHNcDRQVjHvFQYW/MLq/2fZnElArs
	lxBNGasc8XLmPLIde/hFWAek3Aakbp7e+D6veUjgWxLPeaTIZLkxiKhmhrkQYC1Klwg9zcxq4YF
	bf5w3CdxQMrJzhrIGlwfHvAnNIg8t8UUvRlRyxhCMYhmw88hPBnrTwHNk44VLXDgT2m/zYkKTW5
	0AiQL8rBpaA0TQapI+4tRDdsY24i9vqpeeF7m8OcbLQ8
X-Received: by 2002:a05:701b:420e:20b0:144:c112:5f24 with SMTP id a92af1059eb24-1b3c031ae2fmr3766487c88.25.1794439267244;
        Wed, 11 Nov 2026 15:21:07 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm7807640eec.2.2026.11.11.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:21:06 -0800 (PST)
Date: Wed, 11 Nov 2026 15:20:41 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without
 copying
Message-ID: <avT3vVT8iyKqyW8q@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-8-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-8-bjorn@kernel.org>

On 11/10, Björn Töpel wrote:
> A provider socket still receives through the copy path, which takes
> FILL entries without the provider's ownership checks: a chunk that a
> page pool holds could be handed out twice. No driver opts in yet.
> 
> Put packets whose buffers all belong to the socket's provider on the
> RX ring as they are, and copy others into chunks the provider claims.
> Only the queue NAPI may produce to such a socket, so generic XDP and
> CPUMAP redirects to it are dropped.
> 
> A device may place payload at chunk offset 0, as fbnic does, so only
> the first buffer of a packet keeps the UMEM headroom. Such buffers may
> be sent back as they are, so only descriptors with XDP_TX_METADATA
> need room for TX metadata in front.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/networking/af_xdp.rst          |   6 +-
>  Documentation/networking/xsk-tx-metadata.rst |   3 +-
>  include/net/page_pool/memory_provider.h      |   2 +
>  net/core/page_pool.c                         |  34 +++-
>  net/xdp/xsk.c                                |  82 ++++++++-
>  net/xdp/xsk.h                                |   5 +
>  net/xdp/xsk_pp.c                             | 165 +++++++++++++++++++
>  net/xdp/xsk_queue.h                          |  18 +-
>  8 files changed, 304 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index cc3f0d16b28f..e73a0005e169 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -428,8 +428,10 @@ area and that your largest packet size can be 2K.
>  There is also an option to set the headroom of each single buffer in
>  the UMEM. If you set this to N bytes, it means that the packet will
>  start N bytes into the buffer leaving the first N bytes for the
> -application to use. The final option is the flags field, but it will
> -be dealt with in separate sections for each UMEM flag.
> +application to use. In a multi-buffer packet, only the first buffer is
> +guaranteed this headroom; the others may start at offset 0 of their
> +chunk. The final option is the flags field, but it will be dealt with
> +in separate sections for each UMEM flag.
>  
>  SO_BINDTODEVICE setsockopt
>  --------------------------
> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> index f240930ca1df..8bb74a569c26 100644
> --- a/Documentation/networking/xsk-tx-metadata.rst
> +++ b/Documentation/networking/xsk-tx-metadata.rst
> @@ -59,7 +59,8 @@ The flags field enables the particular offload:
>  Besides the flags above, in order to trigger the offloads, the first
>  packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
>  bit in the ``options`` field. Also note that in a multi-buffer packet
> -only the first chunk should carry the metadata.
> +only the first chunk should carry the metadata. Only a descriptor with
> +``XDP_TX_METADATA`` needs ``tx_metadata_len`` bytes in front of it.
>  
>  Software TX Checksum
>  ====================
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
> index daec73c9dcee..849db08513b8 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -49,6 +49,8 @@ struct memory_provider_ops {
>  bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
> +void net_mp_release_page_pool_bulk(struct page_pool *pool,
> +				   netmem_ref *netmems, u32 count);
>  
>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		      const struct pp_memory_provider_params *p,
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index e897e79d31f1..56c299f2280d 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1401,7 +1401,7 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
>  }
>  
>  /* Associate a niov with a page pool. Should follow with a matching
> - * net_mp_niov_clear_page_pool()
> + * net_mp_niov_clear_page_pool() or net_mp_release_page_pool_bulk()
>   */
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
>  {
> @@ -1422,3 +1422,35 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov)
>  
>  	page_pool_clear_pp_info(netmem);
>  }
> +
> +/**
> + * net_mp_release_page_pool_bulk() - take net_iovs back from a page pool
> + * @pool: page pool that holds one reference to each net_iov
> + * @netmems: net_iovs of the memory provider of @pool
> + * @count: number of entries in @netmems
> + *
> + * A memory provider takes net_iovs out of a page pool without
> + * ->release_netmem(), for example to give them to userspace. @pool may be
> + * freed on return.
> + */
> +void net_mp_release_page_pool_bulk(struct page_pool *pool,
> +				   netmem_ref *netmems, u32 count)
> +{
> +	bool trace = trace_page_pool_state_release_enabled();
> +	atomic_t *release_cnt = &pool->pages_state_release_cnt;
> +	int released;
> +	u32 i;
> +
> +	for (i = 0; i < count; i++) {
> +		DEBUG_NET_WARN_ON_ONCE(netmem_get_pp(netmems[i]) != pool);
> +		page_pool_clear_pp_info(netmems[i]);
> +		if (!trace)
> +			continue;
> +
> +		released = atomic_inc_return_relaxed(release_cnt);
> +		trace_page_pool_state_release(pool, netmems[i], released);
> +	}
> +
> +	if (!trace)
> +		atomic_add(count, release_cnt);
> +}
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 113b0b08356d..b419c673e3f1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -386,6 +386,54 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	return -ENOMEM;
>  }
>  
> +static int xsk_pp_rcv_copy(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> +{
> +	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
> +	u32 headroom = xsk_pool_get_headroom(xs->pool);
> +	void *copy_from = xsk_copy_xdp_start(xdp);
> +	u32 from_len, meta_len, rem, num_desc, i;
> +	u64 addrs[MAX_SKB_FRAGS + 1];
> +	skb_frag_t *frag = NULL;
> +	u32 to_len, copied;
> +	void *to;
> +
> +	from_len = xdp->data_end - copy_from;
> +	meta_len = xdp->data - copy_from;
> +	rem = len + meta_len;
> +
> +	num_desc = (len - 1) / frame_size + 1;
> +	if (num_desc > ARRAY_SIZE(addrs)) {
> +		xs->rx_dropped++;
> +		return -ENOSPC;
> +	}
> +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> +		xs->rx_queue_full++;
> +		return -ENOBUFS;
> +	}
> +	if (!xsk_pp_claim_copy(xs->pool->pp, addrs, num_desc)) {
> +		xs->rx_dropped++;
> +		return -ENOMEM;
> +	}
> +
> +	if (xdp_buff_has_frags(xdp))
> +		frag = &xdp_get_shared_info_from_buff(xdp)->frags[0];
> +
> +	for (i = 0; rem && i < num_desc; i++) {
> +		to = xp_raw_get_data(xs->pool, addrs[i] + headroom) - meta_len;
> +		to_len = frame_size + meta_len;
> +		copied = xsk_copy_xdp(to, &copy_from, to_len, &from_len, &frag,
> +				      rem);
> +		rem -= copied;
> +
> +		__xskq_prod_reserve_desc(xs->rx, addrs[i] + headroom,
> +					 copied - meta_len,
> +					 rem ? XDP_PKT_CONTD : 0);
> +		meta_len = 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool xsk_tx_writeable(struct xdp_sock *xs)
>  {
>  	if (xskq_cons_present_entries(xs->tx) > xs->tx->nentries / 2)
> @@ -453,8 +501,14 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  
>  static void xsk_flush(struct xdp_sock *xs)
>  {
> +	struct xsk_pp *pp = xs->pool->pp;
> +
> +	if (pp)
> +		xsk_pp_flush(pp);
>  	xskq_prod_submit(xs->rx);
> -	__xskq_cons_release(xs->pool->fq);
> +	/* A provider releases FILL entries under its lock. */
> +	if (!pp)
> +		__xskq_cons_release(xs->pool->fq);
>  	sock_def_readable(&xs->sk);

optional nit:

if (pp) {
	pp_flush
	prod_submit
} else {
	prod_submit
	cons_release
}

sock_def_readable

(hard to follow these scattered if(pp) checks :-( )

>  }
>  
> @@ -464,6 +518,11 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  	int err;
>  
>  	err = xsk_rcv_check(xs, xdp, len);
> +	/* Only the NAPI of the queue feeds a memory provider socket. */
> +	if (!err && xs->pool->pp) {
> +		xs->rx_dropped++;
> +		err = -EOPNOTSUPP;
> +	}

This is confusing? Why even call xsk_rcv_check for pp case?

>  	if (!err) {
>  		spin_lock_bh(&xs->pool->rx_lock);
>  		err = __xsk_rcv(xs, xdp, len);
> @@ -488,7 +547,26 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  		return xsk_rcv_zc(xs, xdp, len);
>  	}
>  
> -	err = __xsk_rcv(xs, xdp, len);
> +	if (!xs->pool->pp) {
> +		err = __xsk_rcv(xs, xdp, len);
> +	} else {

[..]

> +		/* A CPUMAP program runs XDP on another CPU, not in NAPI. */
> +		if (unlikely(!xdp_rxq_info_is_reg(xdp->rxq))) {
> +			xs->rx_dropped++;
> +			return -EINVAL;
> +		}
> +
> +		err = xsk_pp_rcv_zc(xs->pool->pp, xs, xdp);
> +		if (err != -EXDEV)
> +			return err;
> +
> +		/* Copy only packets of the queue, from its NAPI */
> +		if (unlikely(!xsk_pp_queue_buf(xs->pool->pp, xdp))) {
> +			xs->rx_dropped++;
> +			return -EINVAL;
> +		}
> +		err = xsk_pp_rcv_copy(xs, xdp, len);

Move this into __xsk_rcv_pp ?
