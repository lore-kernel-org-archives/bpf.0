Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD072E738D
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102212; cv=none; b=XZj2OdxeON2tk7mb7Eny7bbBhDYUNfoQz3wrOguC7bx+4wbn6XJN36bs++535vvdzzqZurLNnscrjd8BIbs/El6Z5aO9GGK3NSCjbwUx9v6g3pWJJD2cZLYmP4vur4lF4N0iX06MpbxS1UiAkH3LFTHXbdUFuoINR8JwZV4Yoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102212; c=relaxed/simple;
	bh=zjkEWyctfF9lWvUtfPnaoMGL98fWF0naFmj8URKbkT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkQIF7qg22geww/J6kMSIbsUwAfYWt/RqGDY6d/yQw4OqGA6Z+FNxaZ/eRi273R1rRdB/imb8kYb1RXGvdnIyoOfBQ0m4I+AHbIrrU+NvZDEMXFDyuOo4rA82/xjle1lH1ox6siTxPGh/43ooTKuPEao/CjzxZZoWm1jsTodyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwNK2uZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwNK2uZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4E51F00899;
	Sat, 30 May 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102211;
	bh=ogf+grTNuwk9LfDROG+RJdG53S4GhWvXYOaLgzGDOXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwNK2uZ7sVZVcE5lddSJmW0MPvvAh9ZWd2buovOrRV43ORFYs3FQpqRKnGRBMmb25
	 QqTJmOUxzifDOKM+GxODHgHEUDHeE/tXEkcU8aJDDXJKr4SN3oBJUk+nR9jZianQih
	 MITe+ktsoGA+0Fjiq/NseCSamNFStVVCeiq2xLEdawPP08MrUYxGi6T0z3HB1DnbNy
	 UbOaqCwx/yRHX/uZtgqDwl27cKVnLtb0X5emjRRvIZ1wB0ss+djOZ4wii9B0L577uT
	 1EYR4zxgcVektG7oV3Ms+F8KNc69KbIsJPdRLL9TCpehdY13VQmV6yi7hZw7HRTurj
	 sDAxSbXWwtR4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
Reply-To: sashiko-reviews@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
References: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:50:10 +0000
Message-Id: <20260530005011.3F4E51F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Coalesced BQL completions are left pending indefinitely when the r=
eceive ring is empty and NAPI yields, corrupting DQL timing.
- [Medium] Disabling BQL coalescing at runtime (tx-usecs =3D 0) orphans pre=
viously accumulated completions, permanently skewing DQL state.
- [Low] Data race on `priv->tx_coal_usecs` between ethtool configuration an=
d the NAPI poll data path.
--

commit d710fd75a7c5d61400890032084a8df84bc9498d
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

    veth: time-based BQL completion coalescing via ethtool tx-usecs

This patch implements time-based batching of BQL completions for the veth
driver to reduce NAPI scheduling overhead. It accumulates BQL completions
and flushes them when a configurable time threshold is exceeded, letting
DQL discover a limit that bounds actual queuing delay to the configured
interval.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index d5675d9d52361..743d17b37223e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -265,7 +275,30 @@ static void veth_get_channels(struct net_device *dev,
>  static int veth_set_channels(struct net_device *dev,
>  			     struct ethtool_channels *ch);
> =20
> +static int veth_get_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv =3D netdev_priv(dev);
> +
> +	ec->tx_coalesce_usecs =3D priv->tx_coal_usecs;
> +	return 0;
> +}
> +
> +static int veth_set_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv =3D netdev_priv(dev);
> +
> +	priv->tx_coal_usecs =3D ec->tx_coalesce_usecs;

[Severity: Low]
Are we missing a WRITE_ONCE() here? priv->tx_coal_usecs is modified under
the RTNL lock but read by veth_xdp_rcv() in softirq context during NAPI
polling without any synchronization. Using WRITE_ONCE() and READ_ONCE()
would prevent compiler reordering and load tearing.

> +	return 0;
> +}

[ ... ]

>  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats,
>  			struct netdev_queue *peer_txq)
>  {
> +	struct veth_bql_state *state =3D &rq->bql_state;
>  	int i, done =3D 0, n_xdpf =3D 0;
>  	void *xdpf[VETH_XDP_BATCH];
> +	struct veth_priv *priv;
> +	u64 bql_flush_ns;
> +
> +	priv =3D netdev_priv(rq->dev);
> +	bql_flush_ns =3D (u64)priv->tx_coal_usecs * 1000;
> +
> +	/* Clamp stored timestamp in case we migrated to a CPU with a behind
> +	 * sched_clock(); prevents the deadline from never firing.
> +	 */
> +	state->time =3D min(state->time, sched_clock());
> +
> +	/* Flush completions that timed out since the previous NAPI poll. */
> +	if (peer_txq && bql_flush_ns)
> +		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);

[Severity: Medium]
What happens if the user disables coalescing by setting tx-usecs to 0 while
there are accumulated completions?

Because bql_flush_ns becomes 0, this pre-loop time-based flush check will
evaluate to false, skipping the flush of previously batched completions.
Inside the loop, new packets are completed individually, ignoring the old
state->n_bql count.

If those pending completions remain stranded indefinitely, won't the
in-flight byte count tracked by DQL become permanently inflated,
artificially reducing the available queue capacity?

>  	for (i =3D 0; i < budget; i++) {
>  		void *ptr =3D __ptr_ring_consume(&rq->xdp_ring);

[ ... ]

> @@ -989,6 +1064,18 @@ static int veth_xdp_rcv(struct veth_rq *rq, int bud=
get,
>  	if (n_xdpf)
>  		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);
> =20
> +	/* If the ring is now empty and the peer TX queue is stalled by DQL
> +	 * backpressure, release completions immediately to unblock it.
> +	 */
> +	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
> +		/* Pairs with smp_wmb() in __ptr_ring_produce(); ensure ring
> +		 * emptiness is observed before reading peer_txq->state.
> +		 */
> +		smp_rmb();
> +		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
> +			veth_bql_complete(state, peer_txq);
> +	}

[Severity: High]
Does this leave coalesced BQL completions pending indefinitely if the
receive ring is empty but the peer TX queue isn't stalled by DQL?

When the NAPI budget loop finishes and the RX ring is empty, the device may
go idle and NAPI polling stops. The batched completions (state->n_bql) are
only flushed if the TX queue is currently stalled by DQL.

If the queue is not stalled, these completions are left pending indefinitely
without a timer to flush them. Since DQL measures the time between enqueue
and completion, wouldn't this arbitrary delay (until the next packet
arrives) be perceived by DQL as a massive transmission delay?

This could cause it to incorrectly shrink the dynamic limit to its minimum
and severely throttle transmission performance.

> +
>  	u64_stats_update_begin(&rq->stats.syncp);
>  	rq->stats.vs.xdp_redirect +=3D stats->xdp_redirect;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527135418.1166=
665-1-hawk@kernel.org?part=3D5
