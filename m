Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436895;
	b=fLJNhZSVMEAvYL5dXKjO/f/kvGSUai2jVHBEcYLywIPB+YKu2EVd8EVqcanYVKnE7EBj
	 9dGNLtMSXct3Q6hlZN/YZ4flnzP4vszkVfVEoJjXYJ6P8UKnJxtr7I0JcBQAqB0N0tuf0
	 ey8bub6BkovNK8F2O81Y2JKoGbnhwxyBfI+nxViM2L+FKbLRSRlAf398toBddFnNIgGFn
	 1n1xIByPdl34QnZBoKHj2Ql9519UPKfQ/EYCVvjA8/2Jjlfnhf6joKKG5bE49ur4kYgGx
	 8/qmv10JynMIUuzR4s4d8Vaexu0y2iZwGGK9jmLnm09moXWrPv3L+ruXcfkIae9CX4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436895;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5YG3G017g+DRKcZrjM4aeoqUjwUFGHSzbQrSNzK7C7g=;
	b=meRGJGP1K59svqrjH8PMLFkxs/xSYlK1Spf2FM+eut4hOUXKoHmS3hEG8vAUM7UC6e86
	 /ta1iP5nF4Pu+tk3V4e6ACQsP14s/sKRKtcmGWAUOJKbYlzzdRJn5tHBHqjFNQv07Ozrx
	 4wHz0ZzSxeAhLT5FfhK5iXVilGsnIGObmRalxy4KW1sDAM/sTWbo5bWe9U+ZbMDQ1dNxC
	 YSVMwb7yw95PmP00/ji8/Xkb5IJUvsZkLLQbkmVsDKHVtA3pJQ4s3sp21I71KOBVb7iQo
	 9ZmVgqF8ObCWA14JXW0sl2de3iauoxvmE1oDVGNjwxf9nYnPU0J9LesMIWyhoQ2p4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzNaHAfZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8539606A332;
	Wed, 11 Nov 2026 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzNaHAfZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44401F00A05;
	Wed, 11 Nov 2026 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436895;
	bh=5YG3G017g+DRKcZrjM4aeoqUjwUFGHSzbQrSNzK7C7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OzNaHAfZgHeFe0kzPfiSABT/lLSgTkJJVUdBa5p3d/BPIpVbjN32lRnNUDYuMU8ci
	 C9wpB2FSSjTwO68e4BvKfxDc5LR5RA+wnipR78D7Tkffxdz546nDTzs/NI3bWwktwz
	 4stFrWIxwomQoL3GPw0EIpCEccGFKdphi22dkj8Zjv6uJ71uO6/wgo2Eq6oSIavSEu
	 6gqef/Z8JsrM5qflOGPO7obcAgAcVyon6PP4qrK2M92ABuPWyRR/oZiCd7t+zrTsdg
	 AiGTLEQOzyMbJgToSMevfsvi77Y2O25sYI4LqABq4zz3MZ5FxVxag03Hr1+JoT7ehg
	 fDaCFNO3qnabw==
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:33 +0000
Message-ID: <179443689325.2199510.6016244708978672874@kernel.org>
In-Reply-To: <20261110102039.1002605-7-bjorn@kernel.org>
References: <20261110102039.1002605-7-bjorn@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net/xdp/xsk_pp.c: xsk_pp_refill_done() can read freed memory.
- [Medium] Provider wakeups that land on a disabled NAPI are dropped
  silently, and xsk_pp_release_netmem() clears pp->starved before it…
- [Medium] net: wrong mp_napi state after netdev_rx_queue_reconfig()
  error recovery
- [Medium] net: dangling rxq->napi left by netif_mp_napi_del() and
  republished
- [Low] Not confirmed (baseline: false positive).
- [Low] Not confirmed (baseline: false positive).

--

page_pool: Coordinate refill with memory providers

This commit adds a refill_done memory provider op and a
page_pool_refill_done() helper, so drivers can report the end of each RX
ring refill. While a queue runs, the core publishes its NAPI in
rxq->mp_napi, and a provider can use it to wake the queue when buffers
come back. The xsk provider uses this to track starvation, and AF_XDP
socket wakeups go through it instead of ndo_xsk_wakeup.

> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 4e2f906fbc735..3fe904b56791b 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -116,6 +116,94 @@ bool netif_all_mps_have_cap(struct net_device *dev, u32 cap)
>  	return true;
>  }
>  
> +/**
> + * netif_mp_wake - schedule the NAPI that refills a memory provider queue

[ ... ]

> +bool netif_mp_wake(struct netdev_rx_queue *rxq)
> +{
> +	struct napi_struct *napi;
> +	bool running = false;
> +
> +	rcu_read_lock();
> +	napi = rcu_dereference(rxq->mp_napi);
> +	if (napi) {
> +		local_bh_disable();
> +		napi_schedule(napi);
> +		local_bh_enable();
> +		running = true;
> +	}
> +	rcu_read_unlock();
> +
> +	return running;
> +}
> +
> +/* Point wakeups at the NAPI of the running queue, and schedule it once: a
> + * refill during the start may have found no buffers.
> + */
> +void netif_mp_update_napi(struct netdev_rx_queue *rxq)
> +{
> +	const struct memory_provider_ops *ops = rxq->mp_params.mp_ops;
> +	struct napi_struct *napi = NULL;
> +
> +	if (rxq->mp_armed && ops && ops->refill_done)
> +		napi = rxq->napi;
> +	if (rcu_access_pointer(rxq->mp_napi) == napi)
> +		return;
> +
> +	rcu_assign_pointer(rxq->mp_napi, napi);
> +	if (napi)
> +		netif_mp_wake(rxq);
> +}

[Severity: Medium]
Can this leave rxq->napi dangling for netif_mp_update_napi() to pick
up again?

netif_mp_napi_del() clears dev->_rx[i].mp_napi when it matches the
NAPI being deleted, but dev->_rx[i].napi still points at it.
__dev_close_many() and netdev_rx_queue_reconfig() disarm the queue
around ndo_stop() and ndo_queue_stop(). While it is disarmed, mp_napi
is already NULL, so this loop does not touch the queue at all.

Suppose the driver deletes the NAPI without first calling
netif_queue_set_napi() with a NULL napi. Suppose it also does not
register another NAPI for that queue before the next
netif_mp_arm_napi() or netif_mp_arm_dev(). Then
netif_mp_update_napi() reads the stale rxq->napi and publishes it in
rxq->mp_napi. It then calls netif_mp_wake(), which does
napi_schedule() on a deleted napi_struct.

For drivers that free the NAPI together with their queue vectors, this
is a use-after-free. Every later provider wakeup also goes through the
same pointer.

Should netif_mp_napi_del() also clear rxq->napi when it matches, or
should netif_mp_update_napi() only publish a NAPI that is still
listed? If drivers are expected to clear the association themselves,
could netmem.rst item 8 say so?

[Severity: Medium]
Can this kick be lost when it lands on a disabled NAPI?

Drivers often call netif_queue_set_napi() during ring setup, before
napi_enable(). If the NAPI is disabled, napi_schedule_prep() sees
NAPIF_STATE_SCHED already set and only sets NAPIF_STATE_MISSED.
napi_enable_locked() then clears SCHED/NPSVC/DISABLED without acting on
MISSED, so no poll runs.

netif_mp_wake() still returns true, because it ignores the result of
napi_schedule().

If the driver reuses the same napi_struct across a restart, the early
return on rcu_access_pointer(rxq->mp_napi) == napi skips the kick
entirely.

The core re-kicks only from netif_mp_arm_dev() and netif_mp_arm_napi().
Driver-internal restarts (ethtool -G/-L, MTU or XDP changes, resets)
keep mp_armed set, so this kick is the only one they get.

The starved state doesn't recover either. xsk_pp_release_netmem() clears
pp->starved before it knows whether the wakeup reached an enabled NAPI:

	starved = pp->starved;
	WRITE_ONCE(pp->starved, false);
	spin_unlock_bh(&pp->lock);

	/* A starved queue may wait for this release */
	if (starved)
		xsk_pp_wake(pp);

Here is one sequence:

- The new rings are filled while the old pool still holds the chunks,
  so the refill finds nothing and sets starved.
- The old pool then releases the chunks while mp_napi is NULL or the
  NAPI is still disabled, so the wakeup is dropped.
- Later releases don't retry, and the empty ring raises no IRQ.

Wouldn't that leave RX stalled, which is the problem this patch sets out
to fix?

fbnic avoids this because fbnic_napi_enable() and __fbnic_nv_restart()
write FBNIC_INTR_SET after napi_enable_locked(). However, netmem.rst item
8 only says "the core schedules it when provider buffers become
available", and does not ask drivers to force a poll after napi_enable().

Should the documented contract require that, or should the core handle
the disabled-NAPI case itself?

[ ... ]

> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> index c2214e718cdb3..a77213f7fef6b 100644
> --- a/net/xdp/xsk_pp.c
> +++ b/net/xdp/xsk_pp.c

[ ... ]

> @@ -232,11 +253,47 @@ static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref netmem)

[ ... ]

> +static bool xsk_pp_refill_done(struct page_pool *pool, enum pp_refill state)
> +{
> +	struct xsk_pp *pp = pool->mp_priv;
> +	struct xsk_buff_pool *xp = pp->pool;
> +	bool wait = xp->uses_need_wakeup;

[Severity: Medium]
Can this read a freed xsk_buff_pool?

pp->pool is dereferenced in the initializer, before the !pp->fq check
that handles a detached provider. So the read happens even on the
PP_REFILL_FULL fast path.

The xsk_pp can outlive the buff pool. Each page pool built on it holds a
ref taken in xsk_pp_init(), but xp_destroy() drops only the buff pool's
own ref before freeing it:

net/xdp/xsk_buff_pool.c:xp_destroy() {
    ...
	if (pool->pp)
		xsk_pp_put(pool->pp);
	kvfree(pool->tx_descs);
	kvfree(pool->heads);
	kvfree(pool);
}

One way to get there is a failed queue reconfig during unbind, after
which the old queue keeps running on the provider's page pools. The
reconfig can fail in kvzalloc() or ndo_queue_mem_alloc(), or in
ndo_queue_start(), whose error path restarts old_mem:

xsk_pp_unbind()
  netif_mp_close_rxq()
    __netif_mp_close_rxq()
      netdev_rx_queue_reconfig()   <- fails, only WARNs
  xsk_pp_detach()                  <- error ignored, fq = NULL
xp_destroy()                       <- kvfree(pool)

After that, the old queue's NAPI still calls page_pool_refill_done()
after each refill. That reaches xsk_pp_refill_done(), which reads
xp->uses_need_wakeup from the freed pool.

Before this patch, the provider callbacks that can run after detach
either didn't touch pp->pool or checked pp->fq first.

Could uses_need_wakeup be cached in struct xsk_pp when it is created, or
read only after pp->fq is confirmed under pp->lock?

> +	bool more;
> +
> +	if (state == PP_REFILL_FULL && !READ_ONCE(pp->starved))
> +		return true;
> +
> +	spin_lock_bh(&pp->lock);
> +	if (!pp->fq) {
> +		spin_unlock_bh(&pp->lock);
> +		return true;
> +	}

[ ... ]

> @@ -183,8 +273,13 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
>  		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
>  		     rxq_idx);
>  		qops->ndo_queue_mem_free(dev, old_mem);
> +		goto err_free_new_queue_mem;
>  	}
>  
> +err_arm_old_queue:
> +	/* The old queue may run */
> +	netif_mp_arm_napi(rxq);
> +
>  err_free_new_queue_mem:
>  	qops->ndo_queue_mem_free(dev, new_mem);
>  

[Severity: Medium]
Does this arm the queue from the right provider state?

When netdev_rx_queue_reconfig() runs, rxq->mp_params already holds the
target configuration. It does not hold the configuration of the queue
that is restarted on this error path.

In __netif_mp_open_rxq(), rxq->mp_params = *p is written before the
reconfig. If ndo_queue_stop() fails, or ndo_queue_start() fails and the
old queue is restarted, netif_mp_arm_napi() here sees the new
provider's refill_done. It publishes rxq->napi in rxq->mp_napi and
kicks it. The error then goes back to __netif_mp_open_rxq(), which
zeroes rxq->mp_params at err_clear_mp but never resyncs mp_napi.

That leaves mp_napi published for a queue with no provider installed,
which breaks the rule documented in struct netdev_rx_queue. A later
netif_mp_wake() on that rxq would schedule it. The early return in
netif_mp_update_napi() would also compare against a pointer that
should not be there.

The close direction is the mirror image. __netif_mp_close_rxq() clears
rxq->mp_params before the reconfig. If the stop or the restart then
fails, netif_mp_update_napi() sees no mp_ops and leaves mp_napi NULL,
even though the old queue keeps running on the provider's page pools.

Should the error path arm from the configuration that is running
again, or should __netif_mp_open_rxq() and __netif_mp_close_rxq() call
netif_mp_update_napi() once they have settled rxq->mp_params?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
