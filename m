Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392421;
	b=iWbZwnUKiYIXa5UI75pQz6bU3Hv/LN1PfsUlx1sGAXN7RREy+DVeDYGLyW/vK0kXL8zt
	 Av+e+uRy0CGSlvXM3TVb+yNkiGXkeM4XsaHacW4xMHShImsXqBc/pGTcIojeapwBB1AkD
	 VR1F+4iF14GDKxKjzocdg3Q7H5j31CBlZcqqM+huOzXvWMhldoU9c/f9VT/zo9zY5umhy
	 HgqGk2igo7tuwKrHe6c5AHuHbN01CRCo4HzUmbTGnQ+6N0a8tlDsi4oBMe6sXE5V0DPbp
	 mIFUDfnGefOSd1vdsC1zGL1sZIUWI7cv7+FiYwhfKgwMcsNuPJDYE/OMJ9t582IVJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6auIGLTfPSmrmdzt3Z0TYyWHEobGtiqSj3GqSpi1uoM=;
	b=NuMX/cFD8s/eIqifVd2uLSqzpc1gRx+vVr11g9RxdwdFLLRya8VRpaTq5lhRvsvL0lar
	 mVe9c74lFBBrOkRSB+Y8zr/VAWjaO/GwUKd8s7UIkj/hCufXo2t5e91p/1nAuHQ5zJEEm
	 Fav+rXzAm88K5ZSegtNP8lZmKT7IbzVH0HAobp3Nqw33vY4Uy7tv5YMujl95VsA+0m0lI
	 ZPWio3gceVyYKy6N95bIRS8414Wz32p0XDZ8mlxAXXw5TjFAmXaMQxTXryolG6qe7ltDu
	 VCIKLKitf4KUBTPOWKzgD09ICWsVxx01y4B4LADZE0ag+bqsR2go85StYfbArx/9zmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIQ3Xm9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B0606A332
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIQ3Xm9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41461F00A07;
	Wed, 11 Nov 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392421;
	bh=6auIGLTfPSmrmdzt3Z0TYyWHEobGtiqSj3GqSpi1uoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WIQ3Xm9t0BzgijcEGT5nlwdjanashRbCV/I9WvR0bGB37Yl1bGGtmBN74A1n8eKKG
	 37vfea5mKh7UJ0btLMzELViG3gmzZolu+aDgAYePO/NuhXRc2/CvyfciuoivDJ4abu
	 AvJ3Lah1Evn8wWG8vsLnxB9+Tciee25Z+xe4bMwR81KDIzWY0WlMzAOLadmGdOuQgQ
	 m3fI+D7v53qUe/9UmEz7Uo2GpseDBcJw9l8q90iUVsTvLyYpj+p4OhKhHumMMPoHhR
	 Ic5iBDiVWPJInaHhusMMMwl+eQuKIVjyEZCWbyLdx6CpYsWpyKFLSgQJXiyckeJoiS
	 xw4HmNFSJRMrg==
Message-ID: <sashiko-outbox-208778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 4/4] veth: use generic skb XDP handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110101941.1059662-5-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
 <20261110101941.1059662-5-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:20:20 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] veth: peer NAPI ring bypassed in veth_xmit() on skb-backed
  XDP_TX
- [High] veth: native XDP bypassed in veth_xdp_rcv_skb() on redirected
  skbs
- [High] net: corrupted skb->tail in __bpf_prog_run_generic_xdp() on
  tail adjust
- [Medium] veth: dropped XDP_TX skbs miscounted as sent in
  veth_xdp_rcv_skb()
- [Medium] veth: pre-XDP COW failure miscounted and warns on shared skb
--

commit 50d191b571e1e34c4b0f0b9a37ee28f9c686bec9
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

veth: use generic skb XDP handling

This commit switches veth's skb-backed XDP receive path in veth_xdp_rcv_skb=
()
to use __do_xdp_generic() instead of converting skbs to xdp_frames for XDP_=
TX
and XDP_REDIRECT.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a61842b2585bf..049c95dbb8be5 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -741,71 +746,26 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *r=
q, void **frames,
>  static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  					struct sk_buff *skb,
> -					struct veth_xdp_tx_bq *bq,
>  					struct veth_stats *stats)
>  {
> -	void *orig_data, *orig_data_end;
>  	struct bpf_prog *xdp_prog;
>  	struct veth_xdp_buff vxbuf;
> -	struct xdp_buff *xdp =3D &vxbuf.xdp;
> -	u32 act, metalen;
> -	int off;
> +	struct xdp_generic_ctx ctx =3D {
> +		.page_pool =3D rq->page_pool,
> +		.xdp_rxq =3D &rq->xdp_rxq,
> +		.xdp_skb =3D &vxbuf.skb,
> +		.xdp =3D &vxbuf.xdp,
> +	};
> +	int ret;
> =20
>  	skb_prepare_for_gro(skb);
> +	/* Generic XDP expects skb->mac_len to be set, as
> +	 * __netif_receive_skb_core() does before running it: the generic
> +	 * cpumap redirect pulls it before queueing the skb.
> +	 */
> +	skb->mac_len =3D skb->data - skb_mac_header(skb);
> =20
>  	rcu_read_lock();
>  	xdp_prog =3D rcu_dereference(rq->xdp_prog);
> @@ -814,100 +774,36 @@ static struct sk_buff *veth_xdp_rcv_skb(struct vet=
h_rq *rq,
>  		goto out;
>  	}
> =20
> -	__skb_push(skb, skb->data - skb_mac_header(skb));
> -	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> -		goto drop;
> -	vxbuf.skb =3D skb;
> -
> -	orig_data =3D xdp->data;
> -	orig_data_end =3D xdp->data_end;
> -
> -	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
> -
> -	switch (act) {
> +	ret =3D __do_xdp_generic(xdp_prog, &skb, &ctx);

[Severity: High]
Does calling __do_xdp_generic() here cause veth's native XDP program to be
skipped whenever an skb arrives from the peer with skb->redirected set?

When a packet is redirected to the peer veth's egress (for example via TC
bpf_redirect() in __bpf_tx_skb(), which calls skb_set_redirected_noclear()),
skb->redirected remains set across veth_xmit() -> ____dev_forward_skb() ->
skb_scrub_packet().  In __do_xdp_generic() -> netif_receive_generic_xdp():

net/core/dev.c:netif_receive_generic_xdp() {
    ...
	if (skb_is_redirected(skb))
		return XDP_PASS;
    ...
}

Previously veth_xdp_rcv_skb() always ran rq->xdp_prog via bpf_prog_run_xdp(=
).
With this change, any skb with skb->redirected set bypasses rq->xdp_prog and
is passed straight up the stack as XDP_PASS.

> +	switch (ctx.act) {
>  	case XDP_PASS:
>  		break;
>  	case XDP_TX:

[Severity: High]
Does routing skb-backed XDP_TX through generic_xdp_tx() -> veth_xmit()
bypass the peer's NAPI receive ring when the peer has GRO enabled without an
XDP program?

Previously XDP_TX went through veth_xdp_tx() -> veth_xdp_flush_bq() ->
veth_xdp_xmit(), which queued frames into the peer's rq->xdp_ring whenever
rcu_access_pointer(rq->napi) was non-NULL.  Now generic_xdp_tx() calls
veth_xmit(), which requires veth_skb_is_eligible_for_gro(dev, rcv, skb) to
use rq->napi:

drivers/net/veth.c:veth_xmit() {
    ...
		use_napi =3D rcu_access_pointer(rq->napi) &&
			   veth_skb_is_eligible_for_gro(dev, rcv, skb);
    ...
}

When the peer only has GRO enabled and no XDP program, the XDP-enabled devi=
ce
still has NETIF_F_ALL_TSO set in dev->features while skb->destructor has be=
en
cleared by skb_prepare_for_gro() or skb_pp_cow_data().  As a result,
veth_skb_is_eligible_for_gro() returns false, veth_forward_skb() falls back=
 to
__netif_rx() instead of queueing to the peer's rq->xdp_ring, and the
"xdp_tx to peer with gro on" test in tools/testing/selftests/net/veth.sh
fails with 0 packets on the peer's XDP/NAPI ring.

> -		veth_xdp_get(xdp);
> -		consume_skb(skb);
> -		xdp->rxq->mem =3D rq->xdp_mem;
> -		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> -			trace_xdp_exception(rq->dev, xdp_prog, act);
> -			stats->rx_drops++;
> -			goto err_xdp;
> -		}
> -		stats->xdp_tx++;
> -		rcu_read_unlock();
> -		goto xdp_xmit;
> +		/* A failed transmit is counted in the device's tx_dropped
> +		 * by generic_xdp_tx(), so it is not added to xdp_tx_err.
> +		 */
> +		if (!ctx.err)
> +			stats->xdp_skb_tx++;
> +		break;

[Severity: Medium]
Does !ctx.err miscount packets dropped inside veth_xmit() as successful
stats->xdp_skb_tx transmits?

In generic_xdp_tx(), netdev_start_xmit() calls veth_xmit() and checks
dev_xmit_complete(rc).  On every drop path in veth_xmit() (such as when the
peer is down, the packet exceeds the peer MTU, or the peer's xdp_ring is fu=
ll
with veth's default IFF_NO_QUEUE), veth_xmit() frees the skb and returns
NET_XMIT_DROP.  Because dev_xmit_complete(NET_XMIT_DROP) is true,
generic_xdp_tx() returns 0 without firing trace_xdp_exception(), and
veth_xdp_rcv_skb() increments stats->xdp_skb_tx (and rq->stats.vs.xdp_tx) f=
or
dropped packets.

[ ... ]

>  	default:
> -		bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
> -		fallthrough;
>  	case XDP_ABORTED:
> -		trace_xdp_exception(rq->dev, xdp_prog, act);
> -		fallthrough;
>  	case XDP_DROP:
>  		stats->xdp_drops++;
> -		goto xdp_drop;
> +		break;
>  	}

[Severity: Medium]
When pre-XDP skb COW fails in netif_skb_check_for_xdp(), doesn't
netif_receive_generic_xdp() return XDP_DROP and cause this switch to count
the allocation failure in stats->xdp_drops instead of stats->rx_drops?

Previously a failure in veth_convert_skb_to_xdp_buff() jumped to drop and
incremented stats->rx_drops (which feeds rx_dropped in veth_get_stats64()).
In addition, when skb_needs_xdp_cow(skb) is true because skb_shared(skb) is
set and skb_pp_cow_data() fails, netif_skb_check_for_xdp() falls back to
pskb_expand_head(skb, ...), which triggers DEBUG_NET_WARN_ON_ONCE(1) on
shared skbs.

>  	rcu_read_unlock();
> =20
> -	/* check if bpf_xdp_adjust_head was used */
> -	off =3D orig_data - xdp->data;
> -	if (off > 0)
> -		__skb_push(skb, off);
> -	else if (off < 0)
> -		__skb_pull(skb, -off);
> -
> -	skb_reset_mac_header(skb);
> -
> -	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> -	 * from skb->len before updating data_len, then add the new one back.
> -	 */
> -	skb->len -=3D skb->data_len;
> -	if (xdp_buff_has_frags(xdp)) {
> -		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> -		skb->len +=3D skb->data_len;
> -	} else {
> -		skb->data_len =3D 0;
> -	}
> -
> -	/* Synchronize the skb tail with XDP's updated linear area. */
> -	off =3D xdp->data_end - orig_data_end;
> -	if (off !=3D 0) {
> -		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
> -		skb->len +=3D off; /* positive on grow, negative on shrink */
> -	}
> -
> -	skb->protocol =3D eth_type_trans(skb, rq->dev);
> -
> -	metalen =3D xdp->data - xdp->data_meta;
> -	if (metalen)
> -		skb_metadata_set(skb, metalen);
> +	if (ret =3D=3D XDP_PASS)
> +		return skb;

[Severity: High]
Does replacing this tail-pointer update with __do_xdp_generic() corrupt
skb->tail when the XDP program adjusts xdp->data_end (via
bpf_xdp_adjust_tail() or bpf_xdp_pull_data())?

In the removed code (from cb6379feaaff ("veth: fix skb length accounting
after XDP frag adjustment")), skb->data was at the MAC header (equal to
xdp->data) when skb_set_tail_pointer(skb, xdp->data_end - xdp->data) ran, a=
nd
eth_type_trans() pulled ETH_HLEN afterwards.  In netif_receive_generic_xdp(=
),
__skb_pull(*pskb, mac_len) pulls mac_len before calling
__bpf_prog_run_generic_xdp():

net/core/dev.c:__bpf_prog_run_generic_xdp() {
    ...
	/* check if bpf_xdp_adjust_tail was used */
	off =3D xdp->data_end - orig_data_end;
	if (off !=3D 0) {
		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
		skb->len +=3D off; /* positive on grow, negative on shrink */
	}
    ...
}

Because skb->data is at xdp->data + mac_len there, skb_set_tail_pointer()
adds xdp->data_end - xdp->data to skb->data and sets skb_tail_pointer(skb) =
to
xdp->data_end + mac_len (14 bytes past the end of the linear data).  This
corrupts consumers of skb_tail_pointer(skb) such as __pskb_pull_tail() and
skb_try_coalesce(), and if xdp->data_end was grown to within mac_len bytes =
of
xdp_data_hard_end(xdp), skb->tail exceeds skb->end into skb_shared_info.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110101941.1059=
662-1-sst@poczta.fm?part=3D4
