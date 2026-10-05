Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFA214A84
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217871; cv=none; b=FoEF3HBPF3HowjTMk+aK2sbGogqFfEgKWkowFALH2BzdT1Jm1cW6YitGxzLSPH0LcVMKqJqIRyE2oZO3vFFFBH6qrzvEY/t2uand3NQ1AGGxOg9S2dBvf6vw6N7cXoa4DUdteQoRUEq69sJVawi5oVuEvXeSe3F6h68rPJcOS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217871; c=relaxed/simple;
	bh=LLznkjl7L/oRXQDR7/Cn3RKXbnI7gnk1ng2ouRFn0a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAiZULQm6hmtEh6lbVdZ292db+Vo9qheFI3gRIc/qVlVDvnsu6kjoa8IVZTDoTisqmbJ60KrOItJjuePR9gT3R1VVXV4lpjU50EYd/pTVQV2gZFcsBMXuSyT5Gko4mgDBxl0mGFT+qiE2Po6BNc4pbjF8Y2dhPBikb7tzYPGsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMuc3yUo; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMuc3yUo"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a834ff6565so103336a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791217869; x=1791822669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRS5M1v6OmgHLfpoTm3iDWMYDPJHjQX4zt7LojDK+3M=;
        b=YMuc3yUo2WhuAIz2J3/4sZRuY46Mde6P2et8/RQRpyc33KXWPa7LkLVWqTyQIzZuKr
         z5gcFmqmSXbqU1AxhWJqmOc57Uzbj4vOK2ABsQQuB34JItKxEy6ivgs85JICfaLOhaPT
         HgiDytYH5cKyamrW06cek1VD2LNZAilEdQYlEG9zg507FVYURA10QbOaKZK2rW8FaFBo
         RrvDH2LyjultsCphFMJKVB73jNZVcVo+LZbLHBxbRS9z+UzmUigjDYi+dLH5kPmvpphS
         WLuZWP+YY9wbkJN45EjlrAmG5X/SERRP8tjFTdazrAP+XHsqP2St8OJG3V6xx3v2TIo7
         Q5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217869; x=1791822669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CRS5M1v6OmgHLfpoTm3iDWMYDPJHjQX4zt7LojDK+3M=;
        b=URPOiVm9QOH63SK05j1Jd20h/wj41HPLYpvbxKxdXra/XuIH0gideLWmLyboSq0ooC
         dE/uxt8gSifPGsorRVKGes8WdYabHbl/fdmtzlRYxwSmMp4mzS5/DK0dGS0TCU6QbqA/
         /yWW0pQZehiNdsJQmOZEsSU2/CRboKHLVJraOrlLCJed3xsURJmAJ+lB86zSmPjK5QHc
         FPVsWKlIgH+M3eI1smtlty9ynKvffBnhk7hn5aH9S+5XEYn+jd5av0mT2Xs8k5LAX+Zf
         We3hjkbqFPm9pvFkHZOYvXrabSYo0vQpfJqqGv/iNAUJ3Bgc7ZugILKm4EDRVomRenDG
         uJ4g==
X-Forwarded-Encrypted: i=1; AKwUvBwGSiCA189+WFf6rB3ruOBGDT9Usmx+uqRHI6hgRD5ZCT076Cfxd9//3UGEWSleoAgS6xU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdkPjhgvXFcWH1+MohSz2lu+p+vSIozRnSO3f0Xvapnztr5HBO
	fjvoZqwdgrIHYcCb2xVuvjX+oShRdF6YmUfC+HnLiQYYs/cLo/N9pbZL
X-Gm-Gg: AYBFou0bg4eMnyqCLA5Cug+7vuZRkiKbcmcE9Gzj9xs4v+rrf4ZlhLTqGofA/rAOGJa
	w2BGAb5Mt5H6pTy27A1bnR/X0vePEqE1i3DxMJjAzmr5oNNA7DKbqUV7akpxd6muXBbvx5tadfu
	8hwO6wY4wOGF5qRZbvmrz+pqm2FEDJYX7PnOl1Y5UzOMRzICntZ6lpzT7NUENFPZqjQvBFu12Gi
	2IrH4aDLZJ6PFiAPdN/Wd9fT5iMRe0aTKI3HgJg5RWYBxc2frSf+SOFvlxLldPTcZO9Jc6OZlN/
	wH8khpmXPa+8zs3aEvOvEhJ7vIG4DrZpogvFshsd968aJIdgrQw4FJV8UUbIZy0g2VlTNnFJ+yn
	n4JMIqqRO5NG9Y1dyR2ZEIifKyGWshilnHe5c31DmTM06Na4WyNahCZDFZrh9tZl1bCmdixfYmq
	b9O7YFSzk57dxbAmX7zsO7ramVNFrj4dkYUIRuDjaYayvx4yCoZDDEzzUVp9lDTCdE
X-Received: by 2002:a17:90b:3841:b0:3a7:250:386d with SMTP id 98e67ed59e1d1-3a8543a46c7mr87773a91.35.1791217869283;
        Mon, 05 Oct 2026 09:31:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853ce0832sm160511a91.12.2026.10.05.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:31:08 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:26:46 -0700
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
	io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
Message-ID: <asPPqXsmAygSdO94@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-4-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> The current memory providers, devmem and io_uring zero-copy RX, give
> memory that the CPU cannot read. The core allows them only on queues
> with header-data split on, a zero header-split threshold, and no XDP
> program. AF_XDP needs a provider that the CPU can read and that
> works with XDP.
> 
> Add a capability field to the provider operations, with
> MP_CAP_READABLE as the first flag. Apply the header-split and XDP
> rules only to providers without it. A queue with an AF_XDP buffer
> pool still rejects other providers, but it accepts the provider made
> from that same pool.
> 
> Provider memory can become free while a queue is restarted, and no
> device event reports it. After a restart, and after a failed restart
> is rolled back, schedule the queue's NAPI if the queue has a
> provider, so the driver tries to refill.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/networking/netmem.rst     |  7 ++-
>  include/net/page_pool/memory_provider.h | 11 +++++
>  include/net/page_pool/types.h           |  7 +--
>  net/core/dev.c                          |  4 +-
>  net/core/netdev_rx_queue.c              | 57 ++++++++++++++++++++-----
>  net/ethtool/rings.c                     | 18 +++-----
>  net/xdp/xsk_buff_pool.c                 |  3 +-
>  7 files changed, 78 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 217869d1108d..aacd185843ac 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -48,8 +48,11 @@ Driver RX Requirements
>     - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
>       by the driver. The driver must delegate the dma syncing to the page_pool,
>       which knows when dma-syncing is (or is not) appropriate.
> -   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
> -     tcp-data-split is enabled.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. This opts the page pool into the memory
> +     provider configured on its RX queue. For a provider without
> +     MP_CAP_READABLE, the driver must specify it only for a payload pool
> +     with tcp-data-split enabled. A readable provider may also back a
> +     regular or header pool.
>  
>  5. The driver must not assume the netmem is readable and/or backed by pages.
>     The netmem returned by the page_pool may be unreadable, in which case
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
> index 255ce4cfd975..d18ec079ffe2 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -9,6 +9,15 @@ struct netdev_rx_queue;
>  struct netlink_ext_ack;
>  struct sk_buff;
>  
> +/**
> + * enum mp_caps - memory provider capabilities
> + * @MP_CAP_READABLE: The CPU can access provider buffers. They may back
> + *	header and regular page pools, and XDP programs may run on them.
> + */
> +enum mp_caps {
> +	MP_CAP_READABLE		= BIT(0),
> +};
> +
>  struct memory_provider_ops {
>  	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
>  	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
> @@ -17,11 +26,13 @@ struct memory_provider_ops {
>  	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
>  		       struct netdev_rx_queue *rxq);
>  	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
> +	u32 caps;
>  };
>  
>  bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap);
>  
>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		      const struct pp_memory_provider_params *p,
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 03da138722f5..a96376613dda 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -22,9 +22,10 @@
>  					*/
>  #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
>  
> -/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers setting
> - * this must be able to support unreadable netmem, where netmem_address() would
> - * return NULL. This flag should not be set for header page_pools.
> +/* Allow memory-provider (net_iov backed) netmem in this page_pool. Drivers
> + * setting this must honor the provider's capabilities. Unless the provider has
> + * MP_CAP_READABLE, netmem_address() returns NULL, and the flag must not be set
> + * for a header page_pool.
>   *
>   * If the driver sets PP_FLAG_ALLOW_UNREADABLE_NETMEM, it should also set
>   * page_pool_params.slow.queue_idx.
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5ac08da8b9d7..12b532c09a9c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10423,7 +10423,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  		return -EBUSY;
>  	}
>  
> -	if (dev_get_min_mp_channel_count(dev)) {
> +	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
>  		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
>  		return -EBUSY;
>  	}
> @@ -10499,7 +10499,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
>  		return -EBUSY;
>  	}
>  
> -	if (dev_get_min_mp_channel_count(dev)) {
> +	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
>  		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
>  		return -EBUSY;
>  	}
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 00a7011eb4d5..610e31d1a717 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -82,8 +82,12 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
>  /* See also page_pool_is_unreadable() */
>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
>  {
> -	if (rxq_idx < dev->real_num_rx_queues)
> -		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
> +	const struct memory_provider_ops *ops;
> +
> +	if (rxq_idx < dev->real_num_rx_queues) {
> +		ops = __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
> +		return ops && !(ops->caps & MP_CAP_READABLE);
> +	}
>  	return false;
>  }
>  EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
> @@ -95,6 +99,32 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx)
>  	return false;
>  }
>  
> +/* Return true if an installed memory provider lacks @cap. */
> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap)
> +{
> +	const struct memory_provider_ops *ops;
> +	int i;
> +
> +	netdev_assert_locked_ops_compat(dev);
> +
> +	for (i = dev->real_num_rx_queues - 1; i >= 0; i--) {
> +		ops = dev->_rx[i].mp_params.mp_ops;
> +		if (ops && (ops->caps & cap) != cap)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* Provider memory may become available while the queue is replaced,
> + * without a device event to report it.
> + */
> +static void netdev_rx_queue_kick(struct netdev_rx_queue *rxq)
> +{
> +	if (rxq->mp_params.mp_ops && rxq->napi)
> +		napi_schedule(rxq->napi);
> +}
> +
>  static int netdev_rx_queue_reconfig(struct net_device *dev,
>  				    unsigned int rxq_idx,
>  				    struct netdev_queue_config *qcfg_old,

[..]

> @@ -142,6 +172,8 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
>  	}
>  
>  	qops->ndo_queue_mem_free(dev, old_mem);
> +	if (netif_running(dev))
> +		netdev_rx_queue_kick(rxq);
>  
>  	kvfree(old_mem);
>  	kvfree(new_mem);
> @@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
>  
>  err_free_new_queue_mem:
>  	qops->ndo_queue_mem_free(dev, new_mem);
> +	/* Freeing the replacement can hand provider memory back to the old
> +	 * queue, which still runs unless the rollback failed.
> +	 */
> +	if (err != -ENETDOWN && netif_running(dev))
> +		netdev_rx_queue_kick(rxq);
>  
>  err_free_old_mem:
>  	kvfree(old_mem);

These are separate fixes?
