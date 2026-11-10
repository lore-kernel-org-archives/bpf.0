Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354734;
	b=vgntvNvWbjy0g393hesKdQurRlF+iZlPmVW4TGQt14KTcsBmcD8zm+I/2nEeiZbP5rSD
	 Ag3xCqsTWcc199RTOB905SGscbM3eTppIMWdLQ4BoF2kGgWYpBjNS+BuV+PFszKJJyebS
	 OpNztabrJV4MdN4WtpMq1IMLwNWPp31UjOKdDWwj0pSVGRgXnMT/iCskUmKanDsCVsj0H
	 HZRvA4Ki/Gr2Tojr4q1seSVy628MxMc3vvsUW3hi49TtIh5cqgIAB7nwAE1DDKJYKYJVj
	 GNqgp67NADnqPpUELxkJaMILURaMWkvbEBmScMygkB3sixiaJxpFz6Y15joQYsKIbLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=1eCGG0skkY+2WaDRMPDc0FOUeJ4GIVWSumwjraevyFU=;
	b=hnu5h1UPitfc734oPQ2c527Bxdq4qIXCaMTqBcvosEZvSedf3phpkl6W2RXDMkIupLfX
	 I6wLU+f5x1MxZmcQOjHExL87amICv1RhVP72tZb24SGYTS/Tgp9aVR7U/FO9YGa1pWU7c
	 SnjMOHpd6eaz2KYeXak9fIEGBjLUJbdaTEh4izB8VQ7KbaUj/sKkBj0x8+S8hDlh5w1Id
	 bGI9UywdnLrcreZl4FY8zcmnEinSJdZBN1ShsuaFl7N3H4CXiHgZ1wGSaCPGZxXwrXFEy
	 gBxtBdHCaBc8za9DCgrpO/6KRORZbz++Z1DEoZcguhBiBoK6FXNJzKi5rgJzZkh6EKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/sW3rxy";
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069260A263E
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 23:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7069260A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/sW3rxy
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-370231dbf90so1404005eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354732; x=1794959532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1eCGG0skkY+2WaDRMPDc0FOUeJ4GIVWSumwjraevyFU=;
        b=U/sW3rxyBEjEOSRhS1wSA2ZipZkaQ4PMS0FFU2fWW3lHTdxhQQ+fJTh0m3UWa2lGEf
         mtRedqzZWwfPIXbtvdpCdETLCDmp73byFOTxav1tvQJ3l+IVFzUqQCFxeL8OVTeZnNN7
         VP+wJWZg5QEGGAuSkM1d2joAQpBXfaVr2MHjzw+/zfH48E2T7ZrwKdGuHubA/EoAORFV
         y4zE7I/TpPSFAHISpVkNDiUBh/Vu1tU3tEl0kpPdlNqOD910n0zHJtO8neOKXxOEhAIb
         ehtlieKhc5sPPqvz51H2rptoqu+NSKhxsl1jgvNFLEgQJrsrSNCmrvDz5PRnjd5AYxf8
         jQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354732; x=1794959532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1eCGG0skkY+2WaDRMPDc0FOUeJ4GIVWSumwjraevyFU=;
        b=FwV01rXsDJMPBqhemyQfb6m/7XIWgSGUCLTikxm0z+CxShxh3aEVSCpb1pXznbc6Us
         +PMM5wQXX/9w8NEG8tgHGDt/yXpnRdrlRZ4J+4Tsr0QsCLgZbp1+bv7R13o+VomhOOOh
         wPYa5iR2vTC+5B0WRXmRMWmj8W8RRcSlpklgE9VLsRSxd4B7NHi+8R8TH9BMfT9MQz/T
         k2fJB4fEs6ThBMe/Y9luGCqlHPiEPCMn3wF2/7cq2qYJb7ezM9K8Zo8KsTlLZRmw+K/m
         ERI8D6ZPtMV+jfIIH8ZkCjclKVZwwFVvo6eE8kWBt5hluEIMyxCzsCDXhXBMis3GjYOH
         O6LA==
X-Forwarded-Encrypted: i=1; AL+hErExeNRXsLEFpl2nAknPhXoq0TP1DEnT+Cc1BnclTwPtpS9mrg54KGwe0oyUvxuCrRodbYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F//ZXUAZAxhVP33J8JvBc6RrtXN+pGQPveN8wDepLqrc8nwQ2
	9zU950Yw/Ye/4IhOlS6dbdklsgdOs43+l9tYNd5pxRym+0GNjMyYiI/4
X-Gm-Gg: AYBFou0zb/Co6vXxlR3EXO7GNNkiB54BWyeQMiHz6q/ltjOKNsDhnQsdvjnaENANIpI
	D8+JxUv59Rjr1tRMlwxGLWoaAjoZ95/t5/kb4qwMPpmjX3LddrwJ6dxlvCDH4eTpD1niDrG3xC8
	gLMpcs8wUeJTVo8ZBB7aRamSfsODKNAW3+KnRPENTPNLxcWWgS3ZJBvdAkUkP6fBjfoiwF/Efew
	IxQ46m6PFhmWl6m/sbfF7fun9ycWOC7Wnx+g68PfSb6jwObUeZRwkRu8qX/iZ92sfpFomB6upyY
	YcEmXdcUTw89FzAXDGG2d8l7XkVZdkIWV4iCRIi/XGFtz1Eyo9MxHDHRd+f3orDZ3ZrigvSp2tU
	3/KwtpdfNyEnbxQez7xGbTMtrVB3wdR8EqRptQ+oHQpNefI/7DUqnKF7e7CCMhwC50PJYCh1hi3
	LLsERCU9zb6ORAD05YWcTl58hz7cMbIGtZ2GxHGi1g49NjUzrxsaKQgOBVaVTDG/J5o6gOrIV3R
	oRXe4RhOAvyEGnlJk6YC1c7JkBxwnHLRSSqZ9XlNcSJ1ev4gsmtUkHIb25SkPdqRg6sdkRc7S0A
	UPS/vuwlfDd3S4WjWtIAEIw=
X-Received: by 2002:a05:701b:261c:b0:1b2:46ca:242e with SMTP id a92af1059eb24-1b3c02f34camr642686c88.14.1794354732257;
        Tue, 10 Nov 2026 15:52:12 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6d::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm14269114c88.5.2026.11.10.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:52:11 -0800 (PST)
Date: Tue, 10 Nov 2026 15:50:15 -0800
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
Message-ID: <avOtdOaiLFoUgbK9@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
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
In-Reply-To: <20261110102039.1002605-6-bjorn@kernel.org>

On 11/10, Björn Töpel wrote:
> A page_pool driver should not need its own AF_XDP setup. When it sets
> netdev_queue_mgmt_ops.xsk_page_pool, a zero-copy bind installs the
> UMEM provider through the queue API, as devmem and io_uring do. The
> driver only judges the chunk size, headroom and multi-buffer mode
> against its MTU and XDP program, in XDP_VALIDATE_XSK_POOL; MTU and
> program changes of a bound device get the same check. The UMEM
> headroom belongs to the socket, so the queue gets it as rx_headroom,
> next to rx_page_size.
> 
> After a queue restart, the core checks that the new page pools took
> the provider. A readable provider must back the header pool, where an
> unsplit packet lands, so pools declare the buffers they supply in
> rx_roles. The old queue's pools carry the same provider during the
> check, so a per-queue generation, mp_gen, tells the new ones apart.
> 
> Generic XDP runs outside the queue NAPI, so it cannot feed the socket.
> 
> The provider needs no xdp_buff_xsk per chunk. The buffer pool
> allocates them only for copy mode and driver zero copy, which saves
> 128 bytes per chunk.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/linux/netdevice.h     |   8 ++
>  include/net/netdev_queues.h   |  12 ++
>  include/net/netdev_rx_queue.h |   2 +
>  include/net/page_pool/types.h |  12 ++
>  include/net/xdp_sock.h        |   4 +
>  include/net/xdp_sock_drv.h    |  45 +++++++
>  include/net/xsk_buff_pool.h   |   3 +
>  net/core/dev.c                |  16 +++
>  net/core/netdev_config.c      |   2 +
>  net/core/netdev_rx_queue.c    |   9 +-
>  net/core/page_pool.c          |   6 +-
>  net/core/page_pool_user.c     |  25 ++--
>  net/xdp/xsk.h                 |   7 +-
>  net/xdp/xsk_buff_pool.c       |  69 ++++++++---
>  net/xdp/xsk_pp.c              | 221 ++++++++++++++++++++++++++++++++++
>  15 files changed, 410 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 435be7880d7e..11e51e684003 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -77,6 +77,7 @@ struct udp_tunnel_info;
>  struct udp_tunnel_nic_info;
>  struct udp_tunnel_nic;
>  struct bpf_prog;
> +struct xsk_rx_check;
>  struct xdp_buff;
>  struct xdp_frame;
>  struct xdp_metadata_ops;
> @@ -1010,6 +1011,8 @@ enum bpf_netdev_command {
>  	BPF_OFFLOAD_MAP_ALLOC,
>  	BPF_OFFLOAD_MAP_FREE,
>  	XDP_SETUP_XSK_POOL,
> +	/* Check an AF_XDP page pool setup, see netdev_queue_mgmt_ops */
> +	XDP_VALIDATE_XSK_POOL,
>  };
>  
>  struct bpf_prog_offload_ops;
> @@ -1048,6 +1051,11 @@ struct netdev_bpf {
>  			struct xsk_buff_pool *pool;
>  			u16 queue_id;
>  		} xsk;
> +		/* XDP_VALIDATE_XSK_POOL */
> +		struct {
> +			const struct xsk_rx_check *check;
> +			struct netlink_ext_ack *extack;
> +		} xsk_check;
>  	};
>  };
>  
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index c5335e935b7d..ad5f0420c21d 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -45,12 +45,15 @@ struct netdev_config {
>  /**
>   * struct netdev_queue_config - rendered configuration for an RX queue
>   * @rx_page_size:	Size of one RX page-pool allocation.
> + * @rx_headroom:	Space before the packet in a head buffer, including
> + *			XDP_PACKET_HEADROOM. Zero selects the driver default.
>   * @rx_ring_size:	Configured size of the regular RX ring.
>   * @rx_mini_ring_size:	Configured size of the RX mini ring.
>   * @rx_jumbo_ring_size:	Configured size of the RX jumbo ring.
>   */
>  struct netdev_queue_config {
>  	u32	rx_page_size;
> +	u32	rx_headroom;
>  	u32	rx_ring_size;
>  	u32	rx_mini_ring_size;
>  	u32	rx_jumbo_ring_size;
> @@ -156,6 +159,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
>  enum {
>  	/* The queue checks and honours the page size qcfg parameter */
>  	QCFG_RX_PAGE_SIZE	= 0x1,
> +	/* The queue checks and honours the headroom qcfg parameter */
> +	QCFG_RX_HEADROOM	= 0x2,
>  };
>  
>  /**
> @@ -199,6 +204,12 @@ enum {
>   *
>   * @supported_params:	Bitmask of supported parameters, see QCFG_*.
>   *
> + * @xsk_page_pool:	AF_XDP zero copy installs the UMEM as the page pool
> + *			memory provider of the RX queue. The driver selects it
> + *			with PP_FLAG_MEM_PROVIDER and PP_RX_ROLE_HEAD, honours
> + *			whole buffers and QCFG_RX_HEADROOM, and accepts or
> + *			rejects the setup in XDP_VALIDATE_XSK_POOL.
> + *
>   * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
>   * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
>   * be called for an interface which is open.
> @@ -229,6 +240,7 @@ struct netdev_queue_mgmt_ops {
>  				    struct netlink_ext_ack *extack);
>  
>  	unsigned int supported_params;
> +	bool xsk_page_pool;
>  };
>  
>  void netdev_queue_config(struct net_device *dev, int rxq,
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 9415a94d333d..989120cbf452 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -31,6 +31,8 @@ struct netdev_rx_queue {
>  	struct napi_struct		*napi;
>  	struct netdev_queue_config	qcfg;
>  	struct pp_memory_provider_params mp_params;
> +	/* stamps the page pools of each queue allocation */
> +	u32				mp_gen;
>  
>  	/* If a queue is leased, then the lease pointer is always
>  	 * valid. From the physical device it points to the virtual
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 0d48c05f1462..e9f3af91e305 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -40,6 +40,12 @@
>   */
>  #define PP_FLAG_MEM_PROVIDER	BIT(4)
>  
> +/* RX buffers a page pool supplies, see page_pool_params.rx_roles */
> +enum pp_rx_role {
> +	PP_RX_ROLE_HEAD		= BIT(0),	/* packet headers */
> +	PP_RX_ROLE_PAYLOAD	= BIT(1),	/* payload after header split */
> +};
> +
>  #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
>  				 PP_FLAG_SYSTEM_POOL | \
>  				 PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
> @@ -94,6 +100,8 @@ struct pp_alloc_cache {
>   * @queue_idx:	queue idx this page_pool is being created for.
>   * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
>   *		PP_FLAG_ALLOW_UNREADABLE_NETMEM, PP_FLAG_MEM_PROVIDER.
> + * @rx_roles:	&enum pp_rx_role mask, for pools that select a memory
> + *		provider. Zero means payload buffers.
>   */
>  struct page_pool_params {
>  	struct_group_tagged(page_pool_params_fast, fast,
> @@ -110,6 +118,7 @@ struct page_pool_params {
>  		struct net_device *netdev;
>  		unsigned int queue_idx;
>  		unsigned int	flags;
> +		unsigned int	rx_roles;
>  /* private: used by test code only */
>  		void (*init_callback)(netmem_ref netmem, void *arg);
>  		void *init_arg;
> @@ -182,6 +191,7 @@ struct pp_memory_provider_params {
>  	void *mp_priv;
>  	const struct memory_provider_ops *mp_ops;
>  	u32 rx_page_size;
> +	u32 rx_headroom;
>  };
>  
>  struct page_pool {
> @@ -245,6 +255,8 @@ struct page_pool {
>  
>  	void *mp_priv;
>  	const struct memory_provider_ops *mp_ops;
> +	/* queue allocation that selected the provider */
> +	u32 mp_gen;
>  
>  	struct xarray dma_mapped;
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 6e70b320b399..e0e22ef839e1 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -19,6 +19,10 @@
>  struct net_device;
>  struct xsk_queue;
>  struct xdp_buff;
> +struct memory_provider_ops;
> +
> +/* The memory provider of AF_XDP page pool zero copy */
> +extern const struct memory_provider_ops xsk_pp_ops;
>  
>  struct xdp_umem {
>  	void *addrs;
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index d94aeb506379..5bb1949a0aa7 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -22,8 +22,29 @@ struct xsk_cb_desc {
>  	u8 bytes;
>  };
>  
> +/**
> + * struct xsk_rx_check - AF_XDP page pool RX setup a driver must accept
> + * @buf_size: size of each RX buffer
> + * @headroom: space before the packet in a head buffer, including
> + *	XDP_PACKET_HEADROOM. The UMEM headroom is the rest.
> + * @mtu: MTU of the device
> + * @sg: the socket takes packets in more than one buffer
> + * @prog: XDP program to check, or NULL for the current one
> + */
> +struct xsk_rx_check {
> +	u32 buf_size;
> +	u32 headroom;
> +	unsigned int mtu;
> +	bool sg;
> +	struct bpf_prog *prog;
> +};
> +
>  #ifdef CONFIG_XDP_SOCKETS
>  
> +int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
> +		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
> +		     struct netlink_ext_ack *extack);
> +struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id);
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
> @@ -36,6 +57,11 @@ void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_clear_tx_need_wakeup(struct xsk_buff_pool *pool);
>  bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool);
>  
> +static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
> +{
> +	return pool->umem->flags & XDP_UMEM_SG_FLAG;
> +}
> +
>  static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
>  {
>  	return XDP_PACKET_HEADROOM + pool->headroom;
> @@ -351,6 +377,20 @@ static inline void xsk_buff_raw_dma_sync_for_device(struct xsk_buff_pool *pool,
>  
>  #else
>  
> +static inline int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
> +				   struct bpf_prog *prog,
> +				   enum bpf_xdp_mode mode,
> +				   struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static inline struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev,
> +						 u16 queue_id)
> +{
> +	return NULL;
> +}
> +
>  static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
>  {
>  }
> @@ -397,6 +437,11 @@ static inline bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
>  	return false;
>  }
>  
> +static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
> +{
> +	return false;
> +}
> +
>  static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
>  {
>  	return 0;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 02e89350faf9..6d7cfdf99a8b 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -11,6 +11,7 @@
>  #include <net/xdp.h>
>  
>  struct xsk_buff_pool;
> +struct xsk_pp;
>  struct xdp_rxq_info;
>  struct xsk_cb_desc;
>  struct xsk_queue;
> @@ -54,6 +55,8 @@ struct xsk_buff_pool {
>  	spinlock_t xsk_tx_list_lock;
>  	refcount_t users;
>  	struct xdp_umem *umem;
> +	/* page pool memory provider, see net/xdp/xsk_pp.c */
> +	struct xsk_pp *pp;
>  	struct work_struct work;
>  	/* Protects generic receive in shared and non-shared umem mode. */
>  	spinlock_t rx_lock;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 663fe3e32ea0..7e985fb82488 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -163,6 +163,7 @@
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/page_pool/memory_provider.h>
> +#include <net/xdp_sock_drv.h>
>  #include <net/rps.h>
>  #include <linux/phy_link_topology.h>
>  
> @@ -10535,6 +10536,8 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
>  
>  int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  {
> +	int err;
> +
>  	if (!dev->netdev_ops->ndo_bpf)
>  		return -EOPNOTSUPP;
>  
> @@ -10552,6 +10555,13 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  		return -EBUSY;
>  	}
>  
> +	if (bpf->command == XDP_SETUP_PROG && bpf->prog) {
> +		err = xsk_validate_dev(dev, dev->mtu, bpf->prog, XDP_MODE_DRV,
> +				       bpf->extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	return dev->netdev_ops->ndo_bpf(dev, bpf);
>  }
>  EXPORT_SYMBOL_GPL(netif_xdp_propagate);
> @@ -10629,6 +10639,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
>  		return -EBUSY;
>  	}
>  
> +	if (mode != XDP_MODE_HW && prog) {
> +		err = xsk_validate_dev(dev, dev->mtu, prog, mode, extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	memset(&xdp, 0, sizeof(xdp));
>  	xdp.command = mode == XDP_MODE_HW ? XDP_SETUP_PROG_HW : XDP_SETUP_PROG;
>  	xdp.extack = extack;
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> index 1975de42a60d..97e33764737b 100644
> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -88,6 +88,8 @@ static int __netdev_queue_config(struct net_device *dev, int rxq_idx,
>  	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
>  	if (mpp->rx_page_size)
>  		qcfg->rx_page_size = mpp->rx_page_size;
> +	if (mpp->rx_headroom)
> +		qcfg->rx_headroom = mpp->rx_headroom;
>  	err = validate_cb(dev, qcfg, extack);
>  	if (err)
>  		return err;
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 9e14a747f9b5..4e2f906fbc73 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -6,6 +6,7 @@
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/memory_provider.h>
> +#include <net/xdp_sock.h>
>  
>  #include "dev.h"
>  #include "page_pool_priv.h"
> @@ -141,6 +142,7 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
>  		goto err_free_new_mem;
>  	}
>  
> +	rxq->mp_gen++;
>  	err = qops->ndo_queue_mem_alloc(dev, qcfg_new, new_mem, rxq_idx);
>  	if (err)
>  		goto err_free_old_mem;
> @@ -235,6 +237,10 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		NL_SET_ERR_MSG(extack, "device does not support: rx_page_size");
>  		return -EOPNOTSUPP;
>  	}
> +	if (p->rx_headroom && !(qops->supported_params & QCFG_RX_HEADROOM)) {
> +		NL_SET_ERR_MSG(extack, "device does not support: rx_headroom");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	rxq = __netif_get_rx_queue(dev, rxq_idx);
>  	if (rxq->mp_params.mp_ops) {
> @@ -242,7 +248,8 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		return -EEXIST;
>  	}
>  #ifdef CONFIG_XDP_SOCKETS
> -	if (rxq->pool) {
> +	/* An AF_XDP pool owns the queue, unless it installs its provider. */
> +	if (rxq->pool && p->mp_ops != &xsk_pp_ops) {
>  		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
>  		return -EBUSY;
>  	}
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8237fda598ab..e897e79d31f1 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -215,7 +215,8 @@ bool netmem_can_retain(netmem_ref netmem)
>  EXPORT_SYMBOL(netmem_can_retain);
>  
>  static int page_pool_select_mp(struct page_pool *pool,
> -			       const struct pp_memory_provider_params *mpp)
> +			       const struct pp_memory_provider_params *mpp,
> +			       u32 rxq_mp_gen)
>  {
>  	const struct memory_provider_ops *ops = mpp->mp_ops;
>  	unsigned int flags = pool->slow.flags;
> @@ -234,6 +235,7 @@ static int page_pool_select_mp(struct page_pool *pool,
>  
>  	pool->mp_priv = mpp->mp_priv;
>  	pool->mp_ops = ops;
> +	pool->mp_gen = rxq_mp_gen;
>  	return 0;
>  }
>  
> @@ -326,7 +328,7 @@ static int page_pool_init(struct page_pool *pool,
>  		netdev_assert_locked(pool->slow.netdev);
>  		rxq = __netif_get_rx_queue(pool->slow.netdev,
>  					   pool->slow.queue_idx);
> -		err = page_pool_select_mp(pool, &rxq->mp_params);
> +		err = page_pool_select_mp(pool, &rxq->mp_params, rxq->mp_gen);
>  		if (err)
>  			goto free_ptr_ring;
>  	}
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index f30f3779624c..b69da0f74756 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -398,28 +398,37 @@ void page_pool_unlist(struct page_pool *pool)
>  	mutex_unlock(&page_pools_lock);
>  }
>  
> +/* Check that the queue allocation that just ran put the provider in every
> + * pool role it needs: headers for a readable provider, payload otherwise.
> + * Pools of earlier allocations do not count.
> + */
>  int page_pool_check_memory_provider(struct net_device *dev,
>  				    struct netdev_rx_queue *rxq)
>  {
> -	void *binding = rxq->mp_params.mp_priv;
> +	const struct memory_provider_ops *ops = rxq->mp_params.mp_ops;
> +	void *mp_priv = rxq->mp_params.mp_priv;
> +	unsigned int need, have = 0;
>  	struct page_pool *pool;
>  	struct hlist_node *n;
>  
> -	if (!binding)
> +	if (!mp_priv)
>  		return 0;
>  
> +	need = PP_RX_ROLE_PAYLOAD;
> +	if (ops->caps & MP_CAP_READABLE)
> +		need = PP_RX_ROLE_HEAD;
> +
>  	mutex_lock(&page_pools_lock);
>  	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
> -		if (pool->mp_priv != binding)
> +		if (pool->mp_priv != mp_priv || pool->mp_gen != rxq->mp_gen ||
> +		    pool->slow.queue_idx != get_netdev_rx_queue_index(rxq))
>  			continue;
>  
> -		if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
> -			mutex_unlock(&page_pools_lock);
> -			return 0;
> -		}
> +		have |= pool->slow.rx_roles ? : PP_RX_ROLE_PAYLOAD;
>  	}
>  	mutex_unlock(&page_pools_lock);
> -	return -ENODATA;
> +
> +	return (have & need) == need ? 0 : -ENODATA;
>  }
>  
>  static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
> index 4dab7b9a1487..9699e9a499a3 100644
> --- a/net/xdp/xsk.h
> +++ b/net/xdp/xsk.h
> @@ -36,10 +36,13 @@ void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
>  			     struct xdp_sock __rcu **map_entry);
>  struct xsk_pp;
>  
> -extern const struct memory_provider_ops xsk_pp_ops;
> -
>  struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
>  void xsk_pp_put(struct xsk_pp *pp);
> +bool xsk_pp_supported(struct net_device *dev);
> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
> +		u16 queue_id);
> +void xsk_pp_unbind(struct xsk_buff_pool *pool);
> +int xp_alloc_heads(struct xsk_buff_pool *pool);
>  void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  			u16 queue_id);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 18966bbdb5b7..c620a0c32c17 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -38,6 +38,8 @@ void xp_destroy(struct xsk_buff_pool *pool)
>  	if (!pool)
>  		return;
>  
> +	if (pool->pp)
> +		xsk_pp_put(pool->pp);
>  	kvfree(pool->tx_descs);
>  	kvfree(pool->heads);
>  	kvfree(pool);
> @@ -62,18 +64,13 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  {
>  	bool unaligned = umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
>  	struct xsk_buff_pool *pool;
> -	struct xdp_buff_xsk *xskb;
> -	u32 i, entries;
> +	u32 entries;
>  
>  	entries = unaligned ? umem->chunks : 0;
>  	pool = kvzalloc_flex(*pool, free_heads, entries);
>  	if (!pool)
>  		goto out;
>  
> -	pool->heads = kvzalloc_objs(*pool->heads, umem->chunks);
> -	if (!pool->heads)
> -		goto out;
> -
>  	if (xs->tx)
>  		if (xp_alloc_tx_descs(pool, xs, max_segs))
>  			goto out;
> @@ -104,10 +101,30 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  	pool->fq = xs->fq_tmp;
>  	pool->cq = xs->cq_tmp;
>  
> -	for (i = 0; i < pool->free_heads_cnt; i++) {
> +	return pool;
> +
> +out:
> +	xp_destroy(pool);
> +	return NULL;
> +}
> +
> +/* Only copy mode and driver zero copy use heads */
> +int xp_alloc_heads(struct xsk_buff_pool *pool)

nit: move xp_alloc_heads rework into a separate patch? this one is quite
big already
