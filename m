Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CA36F40D
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274992; cv=none; b=TQxhOAlLpl/4EJt8P37EcbnZ5CzHvRNpZDIe3fH1BDzXyDUiYrLQjo8VUesDXeIVQWDAz9zjqEi5sPC+W6LbpLVGiDYZ0uMen8QjDB/J02vswIo+3fK8zbEV/R1hJEZZhW3iqMr0SAsL04043OsCD/GcpXB4CvwSOYKEVOKDh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274992; c=relaxed/simple;
	bh=eMcEOZOj7EZhZlBZssxgm0II2gQreWcbRKzhfPRmNPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=inbtcTMHuse9HpWQCzuNT9+e99GGDbUJ7X04H3uaZyb5DTHAUWudlx9bW0UNEEIWkr5piOgTRvSWwriFheobtnXyLO/9XF15dRKgi6/FGcNRhLyqPO/7ULYLiE+TC+exWeMXm3pBTMz9dBGH8Qf9e4GGhVXZ51IImGQBWUogTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHs3J0MJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHs3J0MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052D5C2BCB0;
	Fri,  8 May 2026 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274992;
	bh=eMcEOZOj7EZhZlBZssxgm0II2gQreWcbRKzhfPRmNPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pHs3J0MJGfj6msaMRuSl5wlJtZ7UE7tfFtSsBfYWuB+okH6ZQl3vtUTDSDt0t8P0P
	 rd+JFgR8uq3tvzZRAQOrLPLkfQyCoIuRf+blnWiwwDKZo3PppMOKuk3GWUjbr0pRaI
	 aYltMKGkZv4ub0uw2QD/Io0fwnCDup7akTfATT81AaARjqO4f07wP9X0caDWWXJwOB
	 XArJRqsrV0/UtFQ1Zo8xkSHaYPQUIMya4PuroPgqhSQlEAUyKQayXyaH7Wk47oWXvx
	 /O6PdcZYzwratPBg6QtwpxGeANuizUu1iPH4hKdxFdiR2h+2kyf4Qw5zSvK95dyGbh
	 xqX6DNdy1ZvcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] net: mana: force full-page RX buffers via
 ethtool private flag
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
References: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:16:31 +0000
Message-Id: <20260508211632.052D5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Faking `apc->port_is_up =3D true` on `mana_attach()` failure c=
auses a guaranteed NULL pointer dereference in the asynchronous reset worke=
r.
- [High] Toggling the 'full-page-rx' flag OFF leaks memory when initial pac=
kets are dropped because pre-allocated buffers are saved for reuse but neve=
r consumed by the fragment refill path.
- [High] `mana_pre_alloc_rxbufs` dangerously allocates huge arrays with `km=
alloc` and thousands of pages with `GFP_ATOMIC` in process context, leading=
 to allocation failures under load.
--

commit 57f161d214770cf8af214936230e6e5eeac378bc
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: force full-page RX buffers via ethtool private flag
   =20
On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
allocation in the RX refill path can cause 15-20% throughput
regression under high connection counts. This adds an ethtool private
flag "full-page-rx" to force one RX buffer per page.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index a28ca461c135f..dfd222de11d09 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device=
 *ndev,
>  	return 0;
>  }
> =20
> +static u32 mana_get_priv_flags(struct net_device *ndev)
> +{
[ ... ]
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	u32 changed =3D apc->priv_flags ^ priv_flags;
> +	u32 old_priv_flags =3D apc->priv_flags;
> +	bool schedule_port_reset =3D false;
> +	int err =3D 0;
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Reject unknown bits */
> +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> +		return -EINVAL;
> +
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> +		apc->priv_flags =3D priv_flags;
> +
> +		if (!apc->port_is_up) {
> +			/* Port is down, flag updated to apply on next up
> +			 * so just return.
> +			 */
> +			return 0;
> +		}
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach
> +		 * later
> +		 */
> +		err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);

Since mana_set_priv_flags() runs in process context under rtnl_lock, does
calling mana_pre_alloc_rxbufs() risk memory exhaustion and fragmentation
failures?

mana_pre_alloc_rxbufs() loops num_rxb times using dev_alloc_pages(), which
allocates using GFP_ATOMIC. Could mass-allocating thousands of atomic pages
exhaust atomic memory reserves?

It also uses kmalloc_array() for rxbufs_pre and das_pre, which might require
megabytes of physically contiguous memory. Would it be safer to use
kvmalloc_array() and alloc_pages(GFP_KERNEL) here instead?

Additionally, if the full-page-rx flag is toggled OFF, does this leak memory
when initial packets are dropped?

When the flag is toggled, mana_pre_alloc_rxbufs() pre-allocates the RX ring
and the buffers are injected with from_pool =3D false. If the flag is toggl=
ed
OFF, the standard MTU configuration sets rxq->frag_count > 1.

If any initial packets are dropped (e.g. truncated packets), mana_rx_skb()
executes the drop path and saves the buffer for reuse via
rxq->xdp_save_va =3D buf_va.

However, mana_get_rxfrag() only reuses rxq->xdp_save_va if
rxq->frag_count =3D=3D 1. For frag_count > 1, it allocates new fragments fr=
om the
page pool and ignores the saved buffer. If multiple pre-allocated packets a=
re
dropped, could mana_rx_skb() repeatedly overwrite rxq->xdp_save_va, trigger=
ing
a WARN_ON_ONCE and leaking the pages?

> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags =3D old_priv_flags;
> +			return err;
> +		}
> +
> +		err =3D mana_detach(ndev, false);
[ ... ]
> +		err =3D mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags =3D old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=3Dfalse and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up =3D true;
> +			schedule_port_reset =3D true;

Does setting apc->port_is_up =3D true on mana_attach() failure cause a NULL
pointer dereference in the async reset worker?

If mana_attach() fails, its error path calls mana_cleanup_port_context(),
which ultimately frees apc->tx_qp and sets it to NULL.

When the scheduled mana_per_port_queue_reset_work_handler executes, it calls
mana_detach(). Because we faked apc->port_is_up =3D true, mana_detach() inv=
okes
mana_dealloc_queues(), which blindly iterates over apc->num_queues and
dereferences apc->tx_qp[i].txq.

Since apc->tx_qp is NULL, will this result in a kernel panic?

> +		}
> +	}
> +
> +out:
> +	mana_pre_dealloc_rxbufs(apc);
> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508115100.4885=
06-1-dipayanroy@linux.microsoft.com?part=3D2
