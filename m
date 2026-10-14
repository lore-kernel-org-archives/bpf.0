Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC460550DA4
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001839; cv=none; b=i3S9/Gk97AYmZShTUVXk7KmmJ2ph8WD3e1bRpRIBfs3KCDokIeXFqVMJwdlhVW0yISUQ11LTLuTKKwvtidA6y4mue7222rtycQTi00Ytxypc6WdRyoNGPWSC0SSuiLamyhSjvRR9yDWD+Xssbtz1p/tOAO+wAVEusIXZ21Bx4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001839; c=relaxed/simple;
	bh=Xx5nULan4QVuRTXNI1NFJhRusfZEsi2PG5h47ehcyrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTyZACafPHFBxqORCn78byoo9EpNi1y+5hPwPRSGrIrCKrVklt47sR9E0dfTGDeBPs2iOceUOjBzr6dlI5q5aEKJO7ZzlWBGNxlyduqxhpXUwrODFI2/RSYkSbWtlJS8TpKuZFcbyMyKE8U3tk4jejwDZVVcT21NiDPMo9j6TBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIHMrnQs; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIHMrnQs"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so1419285a91.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001837; x=1792606637; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=erxCAcUn8St8A0pOQS2bMzQYd9phLIBWFqz+yo8v1OE=;
        b=lIHMrnQsbK+FhWNaShe8SH/kOxcq1KWMK+sXBRBmCUJBmLF8r1+TuRp3WcGXgsA9tN
         BffsE1Uzy+dm+lmj1s9cCBSvmJUNZ9w+BMmb/pYqHk+s/EfONmPAB4em5OyoXfiHsRLJ
         y2Ui+nj9y4dqkUfbO7jVyk19BIzFv/Kg7mgE48gdWrPn0qVxxuN5LiXTcM3gkmgCNaUp
         98ptx6oruYvtQsrLo2YYj/ZXV6zF6BFj5H/dAsf9V2vrRdBNkao+6NF3vJS4pCZDxDIf
         bN5RxSxAvDNjtSIKwOhWxAq4kFJRmbHYJRLBiTRE/Ror1+zPEw+a1bwHTRsvILrvNQPB
         NRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001837; x=1792606637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=erxCAcUn8St8A0pOQS2bMzQYd9phLIBWFqz+yo8v1OE=;
        b=HXVqNX4wuNmgtHL3kdkowvFDYKcha3F/RyiBTEyvOfL9a7yaCb6q+K2yEx+vr1r5cd
         /EuahwQGQyY6sDRCwGhOx0YB3DPjFYexDLWeeh3T7hS5JYHKL8XR7cIWQ2f5mNlDWYFd
         ZLRbiJakSEMgRI1sgH2ZZJNoaXFLIl+TVq6rpJLY89ksET8UjIzflGQr+nDAPZebeT+p
         hcdUQb+tsKMgyfVPO/pBpWYMWW9j1xZNxHPSqk6BtIKXSo06AB7iDO6IfI2Cyogyv3rx
         rcbO0qZH5FGOEocuKBfz7SPc5tkPk1+q1OeI7GekKp3ut0YgHZxOKj4dm9D6H4H77flC
         /P7g==
X-Forwarded-Encrypted: i=1; AKwUvBx04OCOATBa7aOwG089TmkAvCoJ/HpE8AzpCTC6zTa35aGfYkrN3OEBE84Oit8dYYxAqkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3yWGOAxJg9w32bqronZo1yAl3rDkBK8OyuSDL2Y7QstgxIBxH
	OQhQgE7yiGgfoEJiAtf6LWFXeApwSUX7mJO1YhwfaWooF/2qpBUxwfdn
X-Gm-Gg: AYBFou0hH3T4dXuTgLoFFVw0H7jdcth7DF43AmxjEJVF61AXD3OEKkXgOfSI8qVNzHt
	DwN0/yAMAC4opTk9VqQvKBwg/DgN4n7B+tywvBR3VjrDfHxIWd8GyaZhkmJo3ZmOvgfRaYqIl2G
	6cZ2gxiNyd7xUMwNn9Yu4E5GQKBob0GzampNSAuaVigsEXmMFaJ4u04DS0RES9yh0x8CRSHAZew
	5tRKyP+x9nj0RGl1IcWIdeldT0NhM0Xmh2oaIVark+mB0ogu4mXwQvM0HIUwfekE9JzefB1BXie
	GP6e1Lh0cgIaRW/pEEJPY4uVzSIBVuf+XGPul4ZJZhf0705LpAC+Bune8vBYsZqIXUQ3D1d1Oc+
	FuL0c/Z+vMN1ifGphST5B1kqG5hVLHJQ7HImJYM7L11HGCIKdxuo3m6sVz19AjC+Nt8I2uFU3Hb
	bAgBOG3CrCoDTE4VZlatNfgZkTXq5FBO+cXLNLgHHmu7JJXTxroWhI8jACv7TNvp07pw==
X-Received: by 2002:a17:90a:1504:b0:3ab:9f88:8073 with SMTP id 98e67ed59e1d1-3ab9f888354mr6390202a91.65.1792001836925;
        Wed, 14 Oct 2026 11:17:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93040182sm461921a91.1.2026.10.14.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:17:16 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:17:02 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] xsk: freeze deferred pool teardown without
 blocking unregister
Message-ID: <as_G2lHKl75BdAH6@devvm7509.cco0.facebook.com>
References: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>

On 10/13, James Hilliard wrote:
> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
> 
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
> 
> Track assigned pools per netdev with netdev operations locking and detach
> remaining pools after the notifier socket walk, including copy-mode pools.
> This also covers leased queues without scanning pools from unrelated
> devices or network namespaces. Remove the entry on assignment failure and
> normal teardown. The deferred worker still owns the pool and later observes
> the cleared device pointer, avoiding a second driver detach or put.
> 
> The lifetime problem was identified by code inspection of the deferred
> release and system-sleep paths.
> 
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v3:
> - Protect the per-netdev pool list with netdev operations locking, as
>   requested by Stanislav Fomichev and Björn Töpel.
> - Assert operations locking for copy-mode assignment too, and share a
>   locked detach helper so unregister holds the lock across the pool walk.
> - Rebase onto current net.
> - Link to v2: https://patch.msgid.link/20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com
> 
> Changes in v2:
> - Track assigned pools per netdev instead of scanning a global pool list.
> - Keep deferred releases visible across queue changes and queue leases.
> - Rebase onto current net.
> - Link to v1: https://patch.msgid.link/20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com
> ---
>  include/linux/netdevice.h   |  5 +++++
>  include/net/xsk_buff_pool.h |  3 +++
>  net/xdp/xsk.c               |  5 +++++
>  net/xdp/xsk_buff_pool.c     | 46 ++++++++++++++++++++++++++++++++++++++-------
>  4 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3cff2174dc03..ac257221c7c5 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2545,6 +2545,11 @@ struct net_device {
>  	/* protected by rtnl_lock */
>  	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
>  
> +#ifdef CONFIG_XDP_SOCKETS
> +	/** @xsk_pools: assigned AF_XDP pools, ops protected */
> +	struct hlist_head	xsk_pools;
> +#endif
> +
>  	u8 dev_addr_shadow[MAX_ADDR_LEN];
>  	netdevice_tracker	linkwatch_dev_tracker;
>  	netdevice_tracker	watchdog_dev_tracker;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index a7df573784fd..02e89350faf9 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -48,6 +48,8 @@ struct xsk_buff_pool {
>  	struct device *dev;
>  	struct net_device *netdev;
>  	struct list_head xsk_tx_list;
> +	/* Assigned pools, including deferred releases; ops protected. */
> +	struct hlist_node dev_node;
>  	/* Protects modifications to the xsk_tx_list */
>  	spinlock_t xsk_tx_list_lock;
>  	refcount_t users;
> @@ -119,6 +121,7 @@ bool xp_put_pool(struct xsk_buff_pool *pool);
>  void xp_clear_dev(struct xsk_buff_pool *pool);
>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
> +void xp_clear_dev_all(struct net_device *dev);
>  
>  /* AF_XDP, and XDP core. */
>  void xp_free(struct xdp_buff_xsk *xskb);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..781ba46eb152 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2145,6 +2145,11 @@ static int xsk_notifier(struct notifier_block *this,
>  			mutex_unlock(&xs->mutex);
>  		}
>  		mutex_unlock(&net->xdp.lock);
> +		/*
> +		 * A released socket is no longer on xdp.list. Its pool can still
> +		 * hold a device reference on the frozen release workqueue.
> +		 */
> +		xp_clear_dev_all(dev);
>  		break;
>  	}
>  	return NOTIFY_DONE;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 9d2d94f1fb75..5b9dcafd6882 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -173,6 +173,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	int err = 0;
 

[..]

>  	ASSERT_RTNL();
> +	netdev_assert_locked_ops_compat(netdev);

nit: can now drop ASSERT_RTNL? netdev_assert_locked_ops_compat should be
enough.

>  
>  	force_zc = flags & XDP_ZEROCOPY;
>  	force_copy = flags & XDP_COPY;
> @@ -204,6 +205,11 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	pool->cached_need_wakeup = XDP_WAKEUP_TX;
>  
>  	dev_hold(netdev);
> +	/*
> +	 * Socket removal precedes the final pool put. Keep the pool visible to
> +	 * NETDEV_UNREGISTER even while release work is waiting for process thaw.
> +	 */
> +	hlist_add_head(&pool->dev_node, &netdev->xsk_pools);
>  
>  	if (force_copy)
>  		/* For copy-mode, we are done. */
> @@ -244,7 +250,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	bpf.xsk.pool = pool;
>  	bpf.xsk.queue_id = queue_id;
>  
> -	netdev_assert_locked_ops_compat(netdev);
>  	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
>  	if (err)
>  		goto err_unreg_pool;
> @@ -265,6 +270,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		err = 0; /* fallback to copy mode */
>  	if (err) {
>  		xsk_clear_pool_at_qid(netdev, queue_id);
> +		hlist_del(&pool->dev_node);
> +		pool->netdev = NULL;
>  		dev_put(netdev);
>  	}
>  	return err;
> @@ -287,19 +294,40 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
>  	return xp_assign_dev(pool, dev, queue_id, flags);
>  }
>  
> +static void __xp_clear_dev(struct xsk_buff_pool *pool)
> +{
> +	struct net_device *netdev = pool->netdev;
> +
> +	netdev_assert_locked_ops_compat(netdev);
> +	xp_disable_drv_zc(pool);
> +	xsk_clear_pool_at_qid(netdev, pool->queue_id);
> +	hlist_del(&pool->dev_node);
> +	pool->netdev = NULL;
> +	dev_put(netdev);
> +}
> +
>  void xp_clear_dev(struct xsk_buff_pool *pool)
>  {
>  	struct net_device *netdev = pool->netdev;
>  
> -	if (!pool->netdev)
> +	if (!netdev)
>  		return;
>  
>  	netdev_lock_ops(netdev);
> -	xp_disable_drv_zc(pool);
> -	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
> -	pool->netdev = NULL;
> +	__xp_clear_dev(pool);
>  	netdev_unlock_ops(netdev);
> -	dev_put(netdev);
> +}
> +
> +void xp_clear_dev_all(struct net_device *dev)
> +{
> +	struct xsk_buff_pool *pool;
> +	struct hlist_node *next;
> +

[..]

> +	netdev_lock_ops(dev);
> +	netdev_assert_locked_ops_compat(dev);

And here also no need for netdev_assert_locked_ops_compat right after
netdev_lock_ops. You have one in __xp_clear_dev, that should be enough.
With that:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
