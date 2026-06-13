Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746737AA9A
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339768; cv=none; b=qWujPz8Pfvw946IEaLSsgiNWLYAws2UKd3qqYofeeVcbqAnJzKsOG1wTbuaH8KJs0f9EDoUy67+1kGVrtrfirAuwjBqSIx+UTc/MyeTeSvJOXQS8TEzCxsTmZ3nc2QAeZlS5CQJwOD4OQKTT+TenlqHpFgJaW/gGGy5us2JGrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339768; c=relaxed/simple;
	bh=XyDt+6x2x1nQN/wNXHV2Tg91LNZNQygk7XNBZPHdv/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcY+qntXV9t7etvINfaSeBZVgUlqTqH7rj9Nk0O5vfKBK8ohkRMqpkApsIOkiLuQiZUX3QeUT+Myc20eTeUmXT890pdGnaB/0bem5lcIki8YmGoj5UTwykgoBZJ/C/E5dG1y7cjgOFAo4Q5Ee+CGvdrTTKNT0voPWvqp0aFkOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNtrWEon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNtrWEon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69951F000E9;
	Sat, 13 Jun 2026 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339765;
	bh=LuqwmUwm8KRQDlJkJNT2aZvuPLZkILOQDzsfGnO0jgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNtrWEonHU/8JaIs+54Orb3i16XhS3J4FgouLQKA1kqCWS7SIVLI+QEV6zmsqRI4H
	 cL4l5DAb8BkxhzNRE2IaMLNf1POy48Sc/F06Zsz17mWH7xxOXahyMOwTfzLCytBsRZ
	 GS0/06kym0tDB/XCmnSBURyq7qRmVCrVpmZO7+xLfzC7tpkuGn73eSlUQYC9941pjT
	 1OhfAKwVpZfmBlK8WbpQSLpWw0kQEke6WQhWC0q7eQAB/7VKZ9BlTZE84NeLbF7jrS
	 mjdwWE335xokTb36avQ7xvcQbj+Ct3mm1Rp24L7bIPm026Jj7neh6VfR0XyEm5XBqV
	 /ef6V8dyUHryw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 2/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Reply-To: sashiko-reviews@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612083530.1650245-3-hawk@kernel.org>
References: <20260612083530.1650245-3-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 08:36:05 +0000
Message-Id: <20260613083605.A69951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The attempt to clear DRV_XOFF during teardown incorrectly checks n=
etif_running(dev), leaving the peer's TX queue stalled for 16 seconds on in=
terface restart.
--

commit 9a6517a905c3dcf9d565963659494eab75fbf1f5
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Subject: veth: implement Byte Queue Limits (BQL) for latency reduction

This commit implements Byte Queue Limits (BQL) in the veth driver to give
qdiscs visibility into the ptr_ring fill level and reduce base latency. It
charges a fixed unit per packet rather than byte lengths, and introduces
logic to drain leftover ring entries and balance DQL accounting at teardown.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0cfb19b760dd5..a3505627f49e4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -1085,11 +1155,49 @@ static void veth_napi_del_range(struct net_device=
 *dev, int start, int end)
>  	}
>  	synchronize_net();
> =20
> +	/* This rq's frames were BQL-charged on the peer's txq[i]. */
> +	peer =3D rtnl_dereference(priv->peer);
> +
>  	for (i =3D start; i < end; i++) {
>  		struct veth_rq *rq =3D &priv->rq[i];
> +		struct netdev_queue *txq;
> +		unsigned int n_bql;
> =20
>  		rq->rx_notify_masked =3D false;
> +
> +		/* Drain leftover ring frames, counting BQL-charged SKBs that
> +		 * were charged via netdev_tx_sent_queue() but never consumed.
> +		 */
> +		n_bql =3D veth_ptr_ring_drain(&rq->xdp_ring);
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
> +
> +		if (!peer || i >=3D peer->num_tx_queues)
> +			continue;
> +
> +		txq =3D netdev_get_tx_queue(peer, i);
> +
> +		/* Balance the peer txq's DQL accounting by completing the
> +		 * outstanding charges instead of netdev_tx_reset_queue():
> +		 * dql_reset() races with a concurrent producer, while
> +		 * netdev_tx_completed_queue() is the normal single-completer
> +		 * path and is safe here -- NAPI is gone (synchronize_net()
> +		 * above) and the producer stopped charging BQL once it
> +		 * observed rq->napi =3D=3D NULL.  Completing every charge drives
> +		 * DQL inflight to 0 and clears STACK_XOFF.
> +		 */
> +		if (n_bql)
> +			netdev_tx_completed_queue(txq, n_bql,
> +						  n_bql * VETH_BQL_UNIT);
> +
> +		/* DRV_XOFF is independent of BQL/STACK_XOFF: a concurrent
> +		 * veth_xmit() may have set it between rcu_assign_pointer(napi,
> +		 * NULL) and synchronize_net(); with NAPI gone nothing else
> +		 * clears it.  The completion above only clears STACK_XOFF, so
> +		 * still wake the txq to clear DRV_XOFF -- but only when the
> +		 * device is still up.
> +		 */
> +		if (netif_running(dev))
> +			netif_tx_wake_queue(txq);

[Severity: High]
This isn't a bug introduced by this patch, but the attempt to clear DRV_XOFF
during teardown relies on netif_running(dev) which will always be false
during dev_close().

Will this leave the peer's TX queue stalled?

When the local RX ring fills up, veth_xmit() stops the peer's TX queue
by setting the __QUEUE_STATE_DRV_XOFF bit. During device close, the
driver core in __dev_close_many() clears the __LINK_STATE_START bit before
the ndo_stop callback is reached. Because of this, netif_running(dev) will
always evaluate to false when veth_napi_del_range() is called.

Consequently, the netif_tx_wake_queue() call is bypassed and the peer's
transmit queue remains frozen. When the local device is brought back up,
nothing clears the DRV_XOFF bit on the peer, leaving the transmit path
completely stalled until the TX watchdog timer expires 16 seconds later.

Could this check be adjusted or removed so the peer's queue can be
properly woken and cleared of DRV_XOFF during teardown?

>  	}
> =20
>  	for (i =3D start; i < end; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612083530.1650=
245-1-hawk@kernel.org?part=3D2
