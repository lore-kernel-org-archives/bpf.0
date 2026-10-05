Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161554D6C2D
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222689; cv=none; b=Q0yRJsMs6/WrW4jLB9meHJt3o0oDuhFOMk6upgZugdS9uLNr7AeQBYGmOnHyUJfyFzIlaigZ1the/eY/qRgaEQbq3INNv23bjG0NboYtOCeqzhrIuzco3Nrk6tu4Cbap2YYP/vo2AxYplJewLUTR9bDca7lVdS7Q3RtAlTWPsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222689; c=relaxed/simple;
	bh=OQ7plgGKu5CgQUx2/iXDOGGHD+OFijUMETEJKpvdY5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjYXWR1QqjyK6qO7xLSxmrPRnAW4bBCiFzSr1OXrYMhaOfXMyNncnk4kvCSomernbJTZYUzRLDWugvnwKf5ALMIN25YRQmSfw43w5yqQ9ztsG//8tg4ABAGVGt/fApO2y4fwA+NSfdeJV7pPDfAEDkokGpFdfEAZFTqKvTz1BoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbbMBTou; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbbMBTou"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso661400a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222686; x=1791827486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SPtuLJ5oSKS7MVMeJrd5D+AH05MZCPxwBahqJmCRhG4=;
        b=TbbMBTouibUPo880oNVELLWlkIHTH5TPDztKhDSEwAw1BI58yFVm9N38wzp8Zp38bL
         56zaoD9odRoSG6TZLb+ScFg5+qkfsWGW17UQsnaVTwEHy06cYtpjMgxrZQS6Uf6F3cg9
         Y8SW5YVSee0o7Hug2gcGfahy+WWG8Y3ui80u9yFWit0HLVwx8oAGHCo3frCt87e2jPJe
         UZjLEZco+yF8TkylL7RdEfmZe8PJj/lHw2aBaJGf8VQ8XPZgShm77Xw/WNeV3XWRe56x
         fjdq3OT84I4apTOSFm18E0jLtRqY/9UUzbAb8w3VELbvNEFCIfk8pmodMGtAHfMyODSx
         pOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222686; x=1791827486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SPtuLJ5oSKS7MVMeJrd5D+AH05MZCPxwBahqJmCRhG4=;
        b=hbYpUlslSHwgNhWjujsbVwdSt5Iqu8i1cFKrgKYmwKyTOD706+bhbpp1G6k8csqbx/
         rDLip6TRtavQZu7djJM6L2Kt73RQ1q7rxg8ry30p/3VdrT+6L3HK3QbVtazrAcxkjS+s
         Fg+5cREGsBmggvjod453Ip2qhS9SjAIHCkCnwqRucbu1kq7vVMc6fsqTa4qFK43Qimlg
         7RItsEwkfSKAuESMCS9RVt4/YOxf0vtMWESMVLaJhnd5E82fOLyu7Ic6/hhWhmdlQML+
         3T60jU1t4AT7u2c1ZoAa9/Bhska2HYBc1hONHSvh7Fu04HYgKAwdqCnlJ6L0p3nMmvW8
         WBAA==
X-Forwarded-Encrypted: i=1; AKwUvBzXjeWpJiHIkErJwIe2AhkeOtD97FBAKlmB679pEnraruDnxQAbz+Rb/4qXQ1q9dmnfcKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJooqF7S8NjeSaPmCSoP2462ImD7IU2W5P+3AC2nIOICXIOoOLd
	PVeSWEw6x53qkogcdtW9onyB0N1K/RQTC92+Jh6ngrqJTUab55LUrDFN
X-Gm-Gg: AYBFou3IBNqXImYLZCIOWq/Jg2I1qZQLzHUrM+kR3RNlRFNfFDonOEgMbhE+7Jf/5ip
	tgtlBm3EdE68Uu3jYumgUOYTfNTVxyXBL3VwpXM0mZDe7qkzahSYwjmhf5h0XYD2RMrviJInivI
	lzSEJ/2QHuB8QXeHpDB1Pb9KlAaUMtQngbFFo/W3+x5Q54OmCPCkcrzy4jqAnlU2liCjEdWgIun
	QA9SCcEZyGkWkWBk7OPSA0zWBGJC3CyIgoGAkI6XFACgiKWeP1+tB9vKS6GfCgBcrAlqmRorQXJ
	ni/VOtWOYx6V06yu6bfSHoyHsSEBX9RiE0bmWAd2Q2V5S2QcKSeHspqYDuPA+gQdXyRhBpYpnE7
	pGjXvXaT/C5WBbc9RbQjq24VAuK14kDYmq2M9fKuFNpniBgBUx40wLN2273TU3s0tlFvo1BlZtF
	5JjqNLPlD1KzsM8Uwhr8VGBddE5I/L2WGgYO2TlydxBFJhIe7MraQW3b9fy8myaF3k
X-Received: by 2002:a17:90b:58c5:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3a6cec6044emr8959513a91.29.1791222686180;
        Mon, 05 Oct 2026 10:51:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853ce2b46sm548796a91.14.2026.10.05.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:51:25 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:38:36 -0700
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
Subject: Re: [RFC net-next 09/15] xsk: Add a page-pool memory provider for
 UMEM
Message-ID: <asPfprbzjNAgKabP@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-10-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-10-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> AF_XDP zero-copy drivers get RX buffers from an xsk_buff_pool. A
> driver built on page_pool would need a second RX allocator for that.
> Instead, let an XSK buffer pool act as a page-pool memory provider.
> It hands out UMEM chunks as NET_IOV_XSK net_iovs, and the driver
> uses the normal page_pool API.
> 
> A driver calls xsk_pool_setup_page_pool() for XDP_SETUP_XSK_POOL.
> For now only 4 KiB pages and aligned UMEM with 4 KiB chunks work;
> other setups get -EOPNOTSUPP. A bind without XDP_ZEROCOPY then falls
> back to copy mode, as before. The exception is a failed setup that
> leaves an old page pool being destroyed. That page pool still uses
> the DMA mapping, so the bind fails.
> 
> The provider reads the FILL ring in batches of the page-pool cache
> refill size, and it handles RX need-wakeup. Each allocation reads at
> most one batch, which limits the work spent on bad descriptors in
> NAPI. Addresses outside the UMEM, and addresses that are already in
> use, count as invalid descriptors and are dropped. refill_done keeps
> NAPI scheduled while the FILL ring has entries. When the ring is
> empty, it sets NEED_WAKEUP and then checks the ring once more.
> 
> The provider asks for page-sized buffers with the UMEM headroom plus
> XDP_PACKET_HEADROOM. It refuses a page pool whose DMA sync range
> goes past the chunk.
> 
> During a queue restart, two page pools can use one provider at the
> same time. A provider lock protects the FILL ring, the reuse stack
> and need-wakeup. Allocation takes it once per page-pool cache refill
> of up to 64 buffers. A packet that is copied into a socket with a
> provider takes it once per packet, because the copy also reads the
> FILL ring.
> 
> A buffer has one owner at a time, as a normal page-pool page does.
> Allocation claims a buffer by setting its page pool under the
> provider lock. Release clears the link, so destroying the provider
> does not need to scan the UMEM.
> 
> Generic XDP and synthetic RX queues, such as CPUMAP, would write to
> the socket RX ring outside the queue's NAPI. While the provider is
> installed, generic XDP drops such packets and counts them in
> rx_dropped, and synthetic queues get -EINVAL. Classic zero-copy
> sockets do not change.
> 
> A failed queue restart can leave the old page pool draining. Keep
> the UMEM, the DMA mapping and the netdev until the provider's last
> page pool is destroyed. Charge the provider arrays, whose size grows
> with the UMEM, to the memory cgroup of the socket owner.
> XDP_SOCKETS now selects PAGE_POOL.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/net/xdp_sock_drv.h  |  12 +
>  include/net/xsk_buff_pool.h |   6 +-
>  net/core/page_pool.c        |   4 +-
>  net/xdp/Kconfig             |   1 +
>  net/xdp/xsk.c               |  50 ++-
>  net/xdp/xsk.h               |  58 ++++
>  net/xdp/xsk_buff_pool.c     | 654 +++++++++++++++++++++++++++++++++++-
>  7 files changed, 756 insertions(+), 29 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index d94aeb506379..b9288f5dd48b 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -9,6 +9,8 @@
>  #include <net/xdp_sock.h>
>  #include <net/xsk_buff_pool.h>
>  
> +struct netlink_ext_ack;
> +
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> @@ -28,6 +30,8 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
>  void xsk_tx_release(struct xsk_buff_pool *pool);
> +int xsk_pool_setup_page_pool(struct net_device *dev, struct xsk_buff_pool *pool,
> +			     u16 queue_id, struct netlink_ext_ack *extack);
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
>  					    u16 queue_id);
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
> @@ -370,6 +374,14 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
>  {
>  }
>  
> +static inline int xsk_pool_setup_page_pool(struct net_device *dev,
> +					   struct xsk_buff_pool *pool,
> +					   u16 queue_id,
> +					   struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct xsk_buff_pool *
>  xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
>  {
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 77264c4902c0..9eed8796a356 100644
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
> @@ -52,7 +53,8 @@ struct xsk_buff_pool {
>  	spinlock_t xsk_tx_list_lock;
>  	refcount_t users;
>  	struct xdp_umem *umem;
> -	struct work_struct work;
> +	struct xsk_pp *pp;
> +	struct delayed_work work;
>  	/* Protects generic receive in shared and non-shared umem mode. */
>  	spinlock_t rx_lock;
>  	struct list_head free_list;
> @@ -117,10 +119,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
>  void xp_destroy(struct xsk_buff_pool *pool);
>  void xp_get_pool(struct xsk_buff_pool *pool);
>  bool xp_put_pool(struct xsk_buff_pool *pool);
> -void xp_clear_dev(struct xsk_buff_pool *pool);
>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
> -
>  /* AF_XDP, and XDP core. */
>  void xp_free(struct xdp_buff_xsk *xskb);
>  
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index e36ae6123adf..1f446e9a10d7 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1397,8 +1397,8 @@ void net_mp_release_page_pool_bulk(struct page_pool *pool,
>  		atomic_add(count, release_cnt);
>  }
>  
> -/* Disassociate a niov from a page pool. Should only be used in the
> - * ->release_netmem() path.
> +/* Disassociate a niov from a page pool. Memory providers may do this either
> + * from ->release_netmem() or from ->destroy() after all objects were released.
>   */
>  void net_mp_niov_clear_page_pool(struct net_iov *niov)
>  {
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..c9c68d3b3712 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -2,6 +2,7 @@
>  config XDP_SOCKETS
>  	bool "XDP sockets"
>  	depends on BPF_SYSCALL
> +	select PAGE_POOL
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b68dda9c37d1..90c98b42a18a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -464,7 +464,9 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  static void xsk_flush(struct xdp_sock *xs)
>  {
>  	xskq_prod_submit(xs->rx);
> -	__xskq_cons_release(xs->pool->fq);
> +	/* Provider pools publish FILL consumption under the provider lock. */
> +	if (!READ_ONCE(xs->pool->pp))
> +		__xskq_cons_release(xs->pool->fq);
>  	sock_def_readable(&xs->sk);
>  }
>  
> @@ -474,16 +476,40 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  	int err;
>  
>  	err = xsk_rcv_check(xs, xdp, len);
> -	if (!err) {
> -		spin_lock_bh(&xs->pool->rx_lock);
> -		err = __xsk_rcv(xs, xdp, len);
> -		xsk_flush(xs);
> +	if (err)
> +		return err;
> +	spin_lock_bh(&xs->pool->rx_lock);
> +	if (unlikely(READ_ONCE(xs->pool->pp))) {
> +		xs->rx_dropped++;
>  		spin_unlock_bh(&xs->pool->rx_lock);
> +		return -EOPNOTSUPP;
>  	}
> +	err = __xsk_rcv(xs, xdp, len);
> +	xsk_flush(xs);
> +	spin_unlock_bh(&xs->pool->rx_lock);
>  
>  	return err;
>  }
>  
> +/* Copy into the socket's UMEM. A provider-backed pool shares its FILL ring
> + * with provider allocation, which can run for another page pool of the queue
> + * while the queue is replaced.
> + */
> +static int xsk_rcv_copy(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> +{
> +	struct xsk_pp *provider = READ_ONCE(xs->pool->pp);
> +	int err;
> +
> +	if (likely(!provider))
> +		return __xsk_rcv(xs, xdp, len);
> +
> +	spin_lock_bh(&provider->lock);
> +	err = __xsk_rcv(xs, xdp, len);
> +	__xskq_cons_release(xs->pool->fq);
> +	spin_unlock_bh(&provider->lock);
> +	return err;
> +}
> +
>  static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  {
>  	u32 len = xdp_get_buff_len(xdp);
> @@ -498,7 +524,15 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  		return xsk_rcv_zc(xs, xdp, len);
>  	}
>  
> -	err = __xsk_rcv(xs, xdp, len);
> +	/* The socket RX ring has a single producer, the queue's poll context.
> +	 * Reject synthetic RX queues before their remote context produces
> +	 * into a provider-backed socket.
> +	 */
> +	if (unlikely(READ_ONCE(xs->pool->pp) &&
> +		     !xdp_rxq_info_is_reg(xdp->rxq)))
> +		return -EINVAL;
> +
> +	err = xsk_rcv_copy(xs, xdp, len);
>  	if (!err)
>  		xdp_return_buff(xdp);
>  	return err;
> @@ -2149,8 +2183,8 @@ static int xsk_notifier(struct notifier_block *this,
>  
>  				xsk_unbind_dev(xs);
>  
> -				/* Clear device references. */
> -				xp_clear_dev(xs->pool);
> +				/* Unregister cannot hold a device reference. */
> +				xp_clear_dev(xs->pool, XSK_POOL_CLEAR_FORCE);
>  			}
>  			mutex_unlock(&xs->mutex);
>  		}
> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
> index 7c811b5cce76..8770778cd322 100644
> --- a/net/xdp/xsk.h
> +++ b/net/xdp/xsk.h
> @@ -4,6 +4,64 @@
>  #ifndef XSK_H_
>  #define XSK_H_
>  
> +#include <net/netmem.h>
> +
> +struct xsk_buff_pool;
> +
> +enum xsk_pool_clear_mode {
> +	XSK_POOL_CLEAR_NORMAL,
> +	XSK_POOL_CLEAR_FORCE,
> +};
> +
> +struct xsk_pp_info {
> +	struct net_iov_area area;
> +	struct xsk_buff_pool *pool;
> +	u32 chunk_shift;
> +};
> +
> +/* Keep page_pool descriptors independent from direct-driver XSK buffers.
> + * Queue replacement creates the new page_pool before it stops the old queue
> + * and destroys the old page_pool after the new queue started, so two
> + * page_pools can use one provider. @lock serializes the state they share.
> + * Generic XDP cannot deliver to a provider-backed socket.
> + */
> +struct xsk_pp {
> +	struct xsk_pp_info info;
> +	struct xsk_queue __rcu *fq;
> +	/* FILL consumers, @reuse and RX need_wakeup state */
> +	spinlock_t lock;
> +	u32 reuse_cnt;
> +	u32 nr_pools;
> +	u64 chunk_mask;
> +	u64 addrs_cnt;
> +	u8 release_retries;
> +	bool dma_need_sync;
> +	bool detached;
> +	u32 reuse[];
> +};
> +
> +void xp_clear_dev(struct xsk_buff_pool *pool, enum xsk_pool_clear_mode mode);
> +
> +static inline bool xp_netmem_is_xsk(netmem_ref netmem)
> +{
> +	return netmem_is_net_iov(netmem) &&
> +	       netmem_to_net_iov(netmem)->type == NET_IOV_XSK;
> +}
> +
> +static inline struct xsk_pp_info *xp_netmem_to_pp(netmem_ref netmem)
> +{
> +	struct net_iov *niov = netmem_to_net_iov(netmem);
> +
> +	return container_of(net_iov_owner(niov), struct xsk_pp_info, area);
> +}
> +
> +static inline bool xp_netmem_is_from_pool(netmem_ref netmem,
> +					  const struct xsk_buff_pool *pool)
> +{
> +	return xp_netmem_is_xsk(netmem) &&
> +	       xp_netmem_to_pp(netmem)->pool == pool;
> +}
> +
>  struct xdp_ring_offset_v1 {
>  	__u64 producer;
>  	__u64 consumer;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 244776a72961..e25347f8c208 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -1,7 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/netdevice.h>
> +#include <linux/sizes.h>
>  #include <net/netdev_lock.h>
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <net/page_pool/helpers.h>
>  #include <net/page_pool/memory_provider.h>
>  #include <net/xsk_buff_pool.h>
>  #include <net/xdp_sock.h>
> @@ -12,6 +16,20 @@
>  #include "xsk.h"
>  
>  #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
> +#define XSK_PAGE_POOL_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING | \
> +				 DMA_ATTR_SKIP_CPU_SYNC)
> +#define XSK_POOL_RELEASE_RETRY_MAX	(60 * HZ)
> +
> +static bool xp_pp_teardown(struct xsk_buff_pool *pool);
> +static void xp_pp_retry_release(struct xsk_buff_pool *pool);
> +static void xp_destroy_unbound_deferred(struct work_struct *work);
> +
> +static void __xp_destroy(struct xsk_buff_pool *pool)
> +{
> +	kvfree(pool->tx_descs);
> +	kvfree(pool->heads);
> +	kvfree(pool);
> +}
>  
>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  {
> @@ -38,9 +56,22 @@ void xp_destroy(struct xsk_buff_pool *pool)
>  	if (!pool)
>  		return;
>  
> -	kvfree(pool->tx_descs);
> -	kvfree(pool->heads);
> -	kvfree(pool);
> +	/* A failed queue replacement can leave a page_pool waiting for an
> +	 * in-flight buffer.  Keep the UMEM and pool alive until its provider
> +	 * destroy callback has run.
> +	 */

[..]

> +	if (pool->pp) {


Would be nice to do a cleanup in xsk_buff_pool: separate it into
common/generic parts and pp vs non-pp parts. And maybe pp vs non-pp can
be a union? With the addition of pp, it's gonna be hard to understand
what is new/shiny vs old/deprecated. I'm assuming, at some point, when
every driver is backed by pp umem, we can drop the non-umem path?
