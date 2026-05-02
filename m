Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5554652
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706309; cv=none; b=gIEw1YjSzfSIaoAPFxauXmklrhHIPDeTsYHcDkpVlQ63Fs8vy0lZJcITEdebwj2tyzmIQemEA2nQapMRZOde653dHUG/wELx6w1676YWw2PMCHuaKuCQJ0Sz8Y21HZ8u4ZosYKojXrlbSpC6oKiWHXxZ9Uuo0loIiJ0csewaqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706309; c=relaxed/simple;
	bh=LRhJYrsL8Z/bWKXlH55jqU2ECsCQ6MvHkyVcYoDoy/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhXE5InwB5/zQ3pCdX2W5uKPRu/O8CLBV6tVkcpf2ilwVisrnbh45ZpXYKNPyT3f0vA+GWl6OsYMw6CM8S0o0Xw4xUsIQVeS6A0YoHs7J161Papckmani1rNu/L5fyrj2wK+gtqM0Wb9Kucy3u3N/MVHJfVz2EnyoZCYer1AS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCkjjeTP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCkjjeTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616C3C19425;
	Sat,  2 May 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777706308;
	bh=LRhJYrsL8Z/bWKXlH55jqU2ECsCQ6MvHkyVcYoDoy/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kCkjjeTPbutMBNxdiQTFl889CX/mxmUCYvDrkgcE+dCgmU3YmzUPogcKzmcbFOZ2d
	 iR9ySgl6blmvi1u6zCFWWV9CbLQz0DteX6bqzVcz5NSlfFgVgonhTN8g7sx4yxFy21
	 Q/6q3SoP5v+T1ejTGC5CbSGaqVh7o7TDiD85knlLzPysyn3gmnlsbtK9U91OHk3doy
	 sU/5hUAGdH9V/k6dc+K7+Jc19EIMV3ZqsppdWzO3GvStmdl1imKsg4yJ54+lJJYYZN
	 Q4jwzSON0mEWlhbzDUt+Hox7fONKM0BfnBriiCZXyjoyznmBgA2w04Xtyr2mH2aY5n
	 AfCV7jCbeRPEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/4] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Reply-To: sashiko@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501071633.644353-3-hawk@kernel.org>
References: <20260501071633.644353-3-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:18:27 +0000
Message-Id: <20260502071828.616C3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Out-of-bounds array access on peer_dev->_tx in veth_poll() whe=
n local RX queues exceed peer TX queues.
- [High] Disabling XDP permanently stops peer TX queues if they were backpr=
essured (DRV_XOFF leak).
--

commit 9bc3ed022846dda6dd5cc131e798f949f63f491f
Author: Jesper Dangaard Brouer <hawk@kernel.org>

veth: implement Byte Queue Limits (BQL) for latency reduction

This commit adds byte queue limits support to the veth driver to provide
qdiscs with feedback and reduce latency. It charges a fixed unit per
packet rather than byte-based charging.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index e35df717e65e2..3de25ba34a906 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -975,7 +1016,7 @@ static int veth_poll(struct napi_struct *napi, int b=
udget)
>  	peer_txq =3D peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> =20
>  	xdp_set_return_frame_no_direct();
> -	done =3D veth_xdp_rcv(rq, budget, &bq, &stats);
> +	done =3D veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);

Could this lead to an out-of-bounds array access on the peer device's
transmit queues?

If a veth pair is configured asymmetrically, the local device might have
more receive queues than the peer has transmit queues.

If packets are redirected from another interface into a higher-indexed
receive queue, the poll function will run with a queue_idx greater than or
equal to peer_dev->real_num_tx_queues.

Since netdev_get_tx_queue() performs a direct array access without bounds
checking, peer_txq would point out-of-bounds. This out-of-bounds pointer is
then passed into the new veth_xdp_rcv() code paths and accessed by
netif_tx_queue_stopped().

Should queue_idx be checked against peer_dev->real_num_tx_queues before
fetching the transmit queue?

[ ... ]

> @@ -1091,6 +1133,17 @@ static void veth_napi_del_range(struct net_device =
*dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
> =20
> +	/* Reset BQL on peer's txqs: remaining ring items were freed above
> +	 * without BQL completion, so DQL state must be reset.
> +	 */
> +	peer =3D rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end =3D min(end, (int)peer->real_num_tx_queues);
> +
> +		for (i =3D start; i < peer_end; i++)
> +			netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
> +	}

Does this cleanup leave peer transmit queues permanently stopped if they
were backpressured when xdp was disabled?

When the ptr_ring is full, veth_xmit() stops the transmit queue using
netif_tx_stop_queue(), which sets the __QUEUE_STATE_DRV_XOFF flag.

While netdev_tx_reset_queue() successfully clears the newly added
__QUEUE_STATE_STACK_XOFF flag, it does not clear __QUEUE_STATE_DRV_XOFF.
If a queue was backpressured exactly when xdp is disabled, it appears it
would remain locked forever.

Would it be appropriate to wake the queues using netif_tx_wake_queue() or
explicitly clear the __QUEUE_STATE_DRV_XOFF flag during this cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501071633.6443=
53-1-hawk@kernel.org?part=3D2
