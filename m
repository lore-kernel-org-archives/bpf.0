Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392565;
	b=Fi3Pq7HAcK4ODZp9LM/q6oYnEryfdTdfVxt4qZKoOlwYeG8M/g0kLq+5l+u6DUQkfBHY
	 QEUkMyRmq0NpEf+xUzAaD3byFXytoel2MQ7GvMHVHvmeT+bS+WgO2FmJ7LfVntgnfcUFm
	 8ipcLxD5Mg/9kcUT6e4NlAH/8QIM5gxmw1b0d/PzxSQPf1cx+0ThX06JLcQI7OR1RYIhn
	 JOI3l0hADO+dQ+IxoSO+DZ2Y3vxjl4L6vsVU+by9Nl/q8xCVGqgD9uBqmJjov/BlfqtKk
	 /nDEp9ERG9NedCHm3/TXhHFcuIPhacbg+l/EYqIaBa2pwJ86M87mOgFvzQMwUYgdQUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6/HE7IdVmiMYZ+bhf/b1/CnpEathHyRVggQU6qwBUy4=;
	b=PtN5xXIhdQ5Ks4s7JTOYrb2VydEXanThdWq75gwOZA63pVARO8VmjiFnTS67VwHZhVqR
	 CCKRolhRBW+T/SnHUZdNbH9u3xcUwsGbyGq2UgQ+MzAGrq6OEYSSFwlPkkAWieyHXDF0m
	 9quiH2EH+LAxeiUG4lEl5Rbb/L9xYO35quStsv0j86S4RyFen+1jVoz5TuUEwEDvp91wu
	 xsyOjCQs4X9lI0qgdqCM0UBKR3q+BcNd0FbcX2LeirCpqnRmAV5CtsHw91M55O2/ZrKv4
	 Cwbnazc9X69l7HOmcLRmC7S/f8i3GJyresy4eYGPyGg0HJPaBbafQG2F97ElPre6EIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PD/lT6ko";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CB606A334
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD/lT6ko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816A51F00A05;
	Wed, 11 Nov 2026 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392565;
	bh=6/HE7IdVmiMYZ+bhf/b1/CnpEathHyRVggQU6qwBUy4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PD/lT6koWUybdu8gBB3rI1arPX3ohtbAT3CauMAtV2Feqx5dOgNpxx6xKHEKCSwno
	 qhv6UJlVNAvHKNDdM/hgrK+rGjE6rS6MrnM1vbKeEEN44kG2KSQgLAnxfRHaIX451t
	 rRhDN5oCSg2bUxFGukSKuGlw1yJ/o04GcsaG8onvma937PK2Q1hsa9gjGV66Odg3qm
	 8/bAGgrKycLZxHKXLit2bkpts9IC4rPV1JavNDq5Jty1mVL47G+/NfRsygimXBenWJ
	 L4T63mhnErAOy1Ls5nfSbQMfy83Gdu/VHL1wEtOQn8n3/87hqI17Gj9PrfXBFmejd2
	 KXlYU2rsdwjjg==
Message-ID: <sashiko-outbox-208789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-7-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-7-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] xsk: use-after-free of pp->pool in xsk_pp_refill_done() after
  detach
- [Medium] net: wrong mp_napi state after netdev_rx_queue_reconfig()
  error recovery
- [Medium] net: dangling rxq->napi left by netif_mp_napi_del() and
  republished
--

commit 3fe1ff48cc345ebc097d0481e784047c7126ab42
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

page_pool: Coordinate refill with memory providers

This commit adds page_pool_refill_done() and NAPI wakeup tracking on RX
queues so that memory providers such as AF_XDP can re-poll or wake queues
when buffers return.

> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 4e2f906fbc735..3fe904b56791b 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -116,6 +116,94 @@ bool netif_all_mps_have_cap(struct net_device *dev, =
u32 cap)
>  	return true;
>  }
> =20
> +/**
> + * netif_mp_wake - schedule the NAPI that refills a memory provider queue
> + * @rxq: physical RX queue of the provider
> + *
> + * Context: IRQs enabled, not in hardirq. The caller keeps the device of
> + * @rxq alive.
> + *
> + * Return: false if no NAPI refills the queue.
> + */
> +bool netif_mp_wake(struct netdev_rx_queue *rxq)
> +{
> +	struct napi_struct *napi;
> +	bool running =3D false;
> +
> +	rcu_read_lock();
> +	napi =3D rcu_dereference(rxq->mp_napi);
> +	if (napi) {
> +		local_bh_disable();
> +		napi_schedule(napi);
> +		local_bh_enable();
> +		running =3D true;
> +	}
> +	rcu_read_unlock();
> +
> +	return running;
> +}
> +
> +/* Point wakeups at the NAPI of the running queue, and schedule it once:=
 a
> + * refill during the start may have found no buffers.
> + */
> +void netif_mp_update_napi(struct netdev_rx_queue *rxq)
> +{
> +	const struct memory_provider_ops *ops =3D rxq->mp_params.mp_ops;
> +	struct napi_struct *napi =3D NULL;
> +
> +	if (rxq->mp_armed && ops && ops->refill_done)
> +		napi =3D rxq->napi;
> +	if (rcu_access_pointer(rxq->mp_napi) =3D=3D napi)
> +		return;
> +
> +	rcu_assign_pointer(rxq->mp_napi, napi);
> +	if (napi)
> +		netif_mp_wake(rxq);
> +}
> +
> +static void netif_mp_arm_napi(struct netdev_rx_queue *rxq)
> +{
> +	rxq->mp_armed =3D true;
> +	netif_mp_update_napi(rxq);
> +}
> +
> +static void netif_mp_disarm_napi(struct netdev_rx_queue *rxq)
> +{
> +	rxq->mp_armed =3D false;
> +	RCU_INIT_POINTER(rxq->mp_napi, NULL);
> +}
> +
> +void netif_mp_arm_dev(struct net_device *dev)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < dev->real_num_rx_queues; i++)
> +		netif_mp_arm_napi(__netif_get_rx_queue(dev, i));
> +}
> +
> +void netif_mp_disarm_dev(struct net_device *dev)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < dev->num_rx_queues; i++)
> +		netif_mp_disarm_napi(&dev->_rx[i]);
> +}
> +
> +/* The grace period of netif_napi_del() covers wakeups that found @napi.=
 */
> +void netif_mp_napi_del(struct napi_struct *napi)
> +{
> +	struct net_device *dev =3D napi->dev;
> +	unsigned int i;
> +
> +	/* free_netdev() frees the queues before it deletes the last NAPIs */
> +	if (dev->reg_state !=3D NETREG_REGISTERED)
> +		return;
> +
> +	for (i =3D 0; i < dev->num_rx_queues; i++)
> +		if (rcu_access_pointer(dev->_rx[i].mp_napi) =3D=3D napi)
> +			RCU_INIT_POINTER(dev->_rx[i].mp_napi, NULL);
> +}

[Severity: Medium]
Does netif_mp_napi_del() leave a dangling pointer in dev->_rx[i].napi?

__netif_napi_del_locked() calls netif_mp_napi_del(), which clears
dev->_rx[i].mp_napi, including when mp_napi is already NULL because
__dev_close_many() or netdev_rx_queue_reconfig() disarmed the queue first.
Because dev->_rx[i].napi is left pointing to @napi, if a driver deletes a
NAPI without calling netif_queue_set_napi(..., NULL), the next
netif_mp_update_napi() copies the freed dev->_rx[i].napi back into
rxq->mp_napi and calls napi_schedule() on it, causing a use-after-free.

> @@ -152,13 +240,15 @@ static int netdev_rx_queue_reconfig(struct net_devi=
ce *dev,
>  		goto err_free_new_queue_mem;
> =20
>  	if (netif_running(dev)) {
> +		netif_mp_disarm_napi(rxq);
>  		err =3D qops->ndo_queue_stop(dev, old_mem, rxq_idx);
>  		if (err)
> -			goto err_free_new_queue_mem;
> +			goto err_arm_old_queue;
> =20
>  		err =3D qops->ndo_queue_start(dev, qcfg_new, new_mem, rxq_idx);
>  		if (err)
>  			goto err_start_queue;
> +		netif_mp_arm_napi(rxq);
>  	} else {
>  		swap(new_mem, old_mem);
>  	}
> @@ -183,8 +273,13 @@ static int netdev_rx_queue_reconfig(struct net_devic=
e *dev,
>  		     "Failed to restart old queue in error path. RX queue %d may be un=
healthy.",
>  		     rxq_idx);
>  		qops->ndo_queue_mem_free(dev, old_mem);
> +		goto err_free_new_queue_mem;
>  	}
> =20
> +err_arm_old_queue:
> +	/* The old queue may run */
> +	netif_mp_arm_napi(rxq);
> +
>  err_free_new_queue_mem:
>  	qops->ndo_queue_mem_free(dev, new_mem);

[Severity: Medium]
Does err_arm_old_queue arm rxq->mp_napi using the target rxq->mp_params
instead of the running old queue's provider state?

Both __netif_mp_open_rxq() and __netif_mp_close_rxq() mutate rxq->mp_params
before calling netdev_rx_queue_reconfig():

net/core/netdev_rx_queue.c:__netif_mp_open_rxq() {
	...
	rxq->mp_params =3D *p;
	...
	ret =3D netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
	if (ret)
		goto err_clear_mp;

	return 0;

err_clear_mp:
	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
	return ret;
}

When ndo_queue_stop() or ndo_queue_start() fails during __netif_mp_open_rxq=
(),
err_arm_old_queue sees the new provider in rxq->mp_params, sets rxq->mp_napi
to rxq->napi, and wakes NAPI before err_clear_mp zeroes rxq->mp_params,
leaving rxq->mp_napi set with no provider installed.  Conversely,
__netif_mp_close_rxq() zeroes rxq->mp_params before calling
netdev_rx_queue_reconfig(), so on failure err_arm_old_queue sees NULL mp_ops
and leaves rxq->mp_napi NULL even though the old provider-backed queue is
still running.

> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> index c2214e718cdb3..a77213f7fef6b 100644
> --- a/net/xdp/xsk_pp.c
> +++ b/net/xdp/xsk_pp.c

[ ... ]

> @@ -232,11 +253,47 @@ static bool xsk_pp_release_netmem(struct page_pool =
*pool, netmem_ref netmem)
>  		pp->state[idx] =3D XSK_PP_REUSE;
>  		pp->reuse[pp->reuse_cnt++] =3D idx;
>  	}
> +	starved =3D pp->starved;
> +	WRITE_ONCE(pp->starved, false);
>  	spin_unlock_bh(&pp->lock);
> =20
> +	/* A starved queue may wait for this release */
> +	if (starved)
> +		xsk_pp_wake(pp);
> +
>  	return false;
>  }
> =20
> +static bool xsk_pp_refill_done(struct page_pool *pool, enum pp_refill st=
ate)
> +{
> +	struct xsk_pp *pp =3D pool->mp_priv;
> +	struct xsk_buff_pool *xp =3D pp->pool;
> +	bool wait =3D xp->uses_need_wakeup;
> +	bool more;
> +
> +	if (state =3D=3D PP_REFILL_FULL && !READ_ONCE(pp->starved))
> +		return true;
> +
> +	spin_lock_bh(&pp->lock);
> +	if (!pp->fq) {
> +		spin_unlock_bh(&pp->lock);
> +		return true;
> +	}

[Severity: High]
Can xsk_pp_refill_done() dereference pp->pool after xp_destroy() has freed
it?

A page_pool holds its own reference on struct xsk_pp via pp->refs, while
pp->pool is an uncounted backpointer to struct xsk_buff_pool.  When
xp_release_deferred() tears down the pool, xsk_pp_unbind() calls
netif_mp_close_rxq() and unconditionally calls xsk_pp_detach(pp) (which sets
pp->fq =3D NULL under pp->lock and unmaps DMA), and xp_release_deferred() t=
hen
frees pp->pool in xp_destroy().  If netif_mp_close_rxq() fails in
netdev_rx_queue_reconfig(), the old queue and its page_pool keep running and
calling xsk_pp_refill_done(), which reads xp->uses_need_wakeup before taking
pp->lock and checking pp->fq, causing a use-after-free.

In addition, if netif_mp_open_rxq() fails in xsk_pp_bind() while a page_pool
still holds a reference on pp (so xsk_pp_abandon(pp) returns false),
xsk_pp_bind() leaves pp->fq non-NULL when xsk_bind() calls xp_destroy().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D6
