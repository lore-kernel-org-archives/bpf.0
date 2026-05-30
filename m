Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724C26ED59
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102212; cv=none; b=D3yLtcR5FioqPpyfkSUw6nTsF7PE6sLL0QE/6rMLsy6UAmCGuEo7QYQ0qGo1GskRQOXl3zQKiq+6BT65LAGg5t7nNRlbTXSqvCEvhyrmY4k4KModPzaRa160n3I8H5Is6B9Y0awgGCUSjeDKf8kxjmcltVmeXxGElnugF70M9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102212; c=relaxed/simple;
	bh=jok2ZPmuMp7TkKh4v5WcJ/wdzftl8VNVixqT+nEL4r0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTQvZYLFohwpsiLhBdtVVF51SNCyrw9TUPe5tpL6oeGldU85VI4Lf3ODAaL8RRYjFh4GYQAUUlbd1dCkhbHqrPmWMkPaCeREVemgE5IFkdqzXQk1vzfm5t5829FslNzXXqgl42LbQjjHP53dCFiNJVa2dkuGCx9vg9esVtzMrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7k52wUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7k52wUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19571F00898;
	Sat, 30 May 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102210;
	bh=xosbV0QfhICO0Y9XxO2KSlVGAy8adc2xeK1JwqsJigM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e7k52wUZQmqEWvG4FmV2HuTKY5XytEZmzArQUbcRL+0j3u58v8OZVfxkTHiY+SyUR
	 Rcktg76UcC3LGSCjNrba5KdZjXddv6l2q1caGiuE5eyNkGG6nxXlr0KTnTI12WPoRc
	 +xixZFVC9WItl4ZSuRAbiNKUhn23iPh45smV+RAPopOW1KYJmHWM915dLZhOHdllNc
	 Ey9ZjsCYXzWj4mrQkemnQoZqIZnalPRtElt78qsABTT838/hNgOQpwLsmFVuenl6vD
	 uX5n9I2J3EeFktyYYFebjPTsxLVfY9mHoxrnB+3u+IUFcxDoCi88xBiiFJqk45bqPK
	 8Qxf/VggZsuGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 2/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Reply-To: sashiko-reviews@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527135418.1166665-3-hawk@kernel.org>
References: <20260527135418.1166665-3-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:50:10 +0000
Message-Id: <20260530005010.A19571F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Flawed queue wakeup logic in veth_napi_del_range() causes permanen=
t TX stalls on the peer device by failing to schedule STACK_XOFF clearances.
- [High] BQL state permanently leaks for deactivated TX queues, causing a p=
ermanent stall if they are later reactivated.
--

commit 01e0529ce363cdc7993646292c97c9feb7c956f9
Author: Jesper Dangaard Brouer <hawk@kernel.org>

veth: implement Byte Queue Limits (BQL) for latency reduction

This commit implements Byte Queue Limits (BQL) support for veth to provide
backpressure and reduce queuing latency. It introduces a fixed unit charge
per packet under the ptr_ring producer_lock and tracks per-SKB BQL state to
safely complete it on the RX side.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0cfb19b760dd5..21ff785339431 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budg=
et,
>  			}
>  		} else {
>  			/* ndo_start_xmit */
> -			struct sk_buff *skb =3D ptr;
> +			bool bql_charged =3D veth_ptr_is_bql(ptr);
> +			struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
> =20
>  			stats->xdp_bytes +=3D skb->len;
> +			if (peer_txq && bql_charged)
> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);

[Severity: High]
If the user decreases peer->real_num_tx_queues, veth_poll() will set peer_t=
xq
to NULL for queues that are now deactivated. Will this skip completions for
in-flight packets that originated from those deactivated queues?

If the completions are permanently leaked, won't the BQL state remain corru=
pt
and immediately halt the queue if it is later reactivated?

> +
>  			skb =3D veth_xdp_rcv_skb(rq, skb, bq, stats);
>  			if (skb) {
>  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))

[ ... ]

> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device =
*dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
> =20
> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
> +	 * synchronize_net(), and NAPI can no longer clear it.
> +	 * Only wake when the device is still up.
> +	 */
> +	peer =3D rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end =3D min_t(int, end, peer->real_num_tx_queues);

[Severity: High]
Similar to the issue in veth_xdp_rcv(), bounding this loop to
peer->real_num_tx_queues skips resetting the BQL state for deactivated queu=
es.
Could this leave the state permanently corrupted if those queues are later
reactivated?

> +
> +		for (i =3D start; i < peer_end; i++) {
> +			struct netdev_queue *txq =3D netdev_get_tx_queue(peer, i);
> +
> +			netdev_tx_reset_queue(txq);
> +			if (netif_running(dev))
> +				netif_tx_wake_queue(txq);

[Severity: High]
Does this sequence cause a permanent TX stall if the queue was stopped
purely by BQL?

netdev_tx_reset_queue() clears the __QUEUE_STATE_STACK_XOFF bit. However,
netif_tx_wake_queue() only schedules the Qdisc if __QUEUE_STATE_DRV_XOFF
was set. If the queue was only stopped by BQL, the Qdisc won't be scheduled,
leaving it asleep with no stop bits set.

Also, if the device is being brought down, netif_running(dev) evaluates to
false, skipping the wake. Could this leave __QUEUE_STATE_DRV_XOFF set on the
peer, resulting in a 16-second watchdog timeout when the device is later
brought back up?

> +		}
> +	}
> +
>  	for (i =3D start; i < end; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527135418.1166=
665-1-hawk@kernel.org?part=3D2
