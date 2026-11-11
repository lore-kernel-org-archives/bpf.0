Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392571;
	b=jojpa+cxW2GApJta5zSfT1LPtNf5k17s7mcv+2k2aGxc8ltwZjG3XEFDGJRs88SoCree
	 CWBC2AMp14/sq2dfe0cTtlZcsgY0noDpSSRsXEMVVKaIaEqCeFVOx8ykdNyb9yRpqgpVx
	 HownLeEbQSame9HmLXt82QX1c95aTMc1n8Djck2g+HVkMqfKnWOMYzNxku09J5A6XVBEt
	 ALCq/f3GHvVyzyutKJKc3AhDXL08mr7/+n4rqb/42dIaZdO6CrqdRW/PUk+UD4gcGdvBv
	 e4XsO7nDOFlNBI6xrdNVrNYVW4KIEubuxJv1Bl5sgqx6qZcpIiJev35jkIMgl6OANfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xzMr/v4OT8xsjOMJovWdhbOkwuyv+IVCCX7V2uzXePA=;
	b=41T+9yCI7qD6Yt9e4+oi1XA/ulrYDdEQlt0RMqUq2FxGApJKorEyqntP/aXOR+yDQUsY
	 rnu6mwY6tPSWu32dUCZAZ55wQwSerqdAOnvNx3mV++3Q05zCXUBVt58agk/v7+mtA+Diu
	 2Ffo4BhTbQYhdB1gXLiaw29triIHlu9Eb2oeVP0vmCPEw1t1oFJItKBH7JnqQNW4Q8GO+
	 3eoL1mks6gfhmsB0L9mGQDEQA5hKRurpS7N8ElaF1yeCFwqZEdHMILkWkP51ExK+HBhX2
	 iEyn4elIKgF0tXWVoLYtCJ3sdydk4pWhVxUjAW2VckYXeZIT9klfmqGsTmijJGEcBew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyS8+URv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA7606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyS8+URv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC57F1F00A05;
	Wed, 11 Nov 2026 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392571;
	bh=xzMr/v4OT8xsjOMJovWdhbOkwuyv+IVCCX7V2uzXePA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hyS8+URvrhMuyMDo9o8YeBVqh+WBCK4dNdSriZ1YZG7BkutzzxGxjEgNUCjYqFqEE
	 zh0zEIGCx38WN7jX/xNyr1kIfU8YmWwfcfWrmPaLxrxogxEWLd0idXyM6KWsIoQF2H
	 X9oX7edOvz63ER+Sb55h7QZ4Mid1ZFYHIYW1lUQXgN8rHBGNSYwBePCKpPLTNcpw1x
	 5LpXPyhYAoo1/fa5vMBgC6nwviFThZVPjcXrRnz7JZJfK3KyYWI2fgC4fT9Bq+oTYO
	 n6rcmBJcKjGkY9uairKYVBvwlVxAhEjUkYE3Ccg3Jayfbhbo8A3FEnL2QXaAzF2y0x
	 jpwkYO32MUqGQ==
Message-ID: <sashiko-outbox-208793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 10/11] eth: fbnic: Support RX buffers it
 cannot split
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-11-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-11-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] eth: fbnic: incomplete split-buffer checks in
  fbnic_bd_one_desc() callers
- [Medium] eth: fbnic: race on FBNIC_QUEUE_RDE_CTL0 in
  fbnic_config_drop_mode()
--

commit 054b7a97f2c49f63f4a411460a28df28be50d728
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

eth: fbnic: Support RX buffers it cannot split

This commit adds support for RX memory providers without MP_CAP_FRAG by
assigning a single reference per buffer, programming per-queue header and
payload thresholds so each descriptor uses a whole buffer, and updating
link-up drop mode configuration to preserve per-queue header split settings.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> index bfaa284e497eb..d96c957d6fbad 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

> +	/* MAX_HDR leaves no room for a second header in a whole buffer, so
> +	 * the device closes it, with PAGE_FIN, after the first.
> +	 */
> +	pkt->add_frag_failed =3D false;
> +	if (unlikely(!fbnic_bd_one_desc(nv, &qt->sub0, hdr_pg_idx,
> +					FIELD_GET(FBNIC_RCD_AL_PAGE_FIN,
> +						  rcd)))) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}
> +
>  	netmem =3D fbnic_page_pool_get_head(qt, hdr_pg_idx);
>  	pkt->head =3D netmem;
> =20
> @@ -1032,7 +1063,6 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vec=
tor *nv, u64 rcd,
>  			 len - FBNIC_RX_PAD, true);
> =20
>  	pkt->hwtstamp =3D 0;
> -	pkt->add_frag_failed =3D false;
>  }
> =20
>  static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
> @@ -1046,8 +1076,20 @@ static void fbnic_add_rx_frag(struct fbnic_napi_ve=
ctor *nv, u64 rcd,
>  	netmem_ref netmem;
>  	bool added;
> =20
> +	if (unlikely(!fbnic_bd_one_desc(nv, &qt->sub1, pg_idx, !pg_off))) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}

[Severity: Medium]
Can a split RX completion descriptor still pass fbnic_bd_one_desc() on both
the header and payload rings?

In fbnic_add_rx_frag(), fbnic_bd_one_desc() checks !pg_off but does not
check FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) (or the subpage offset from
fbnic_rcd_bd_page_offset()). If the device splits a whole payload buffer
across multiple descriptors, the first descriptor has pg_off =3D=3D 0 and
PAGE_FIN =3D=3D 0, so it passes fbnic_bd_one_desc() and consumes the buffer=
's
single netmem reference while the hardware still holds the buffer open for
subsequent descriptors.

Conversely, in fbnic_pkt_prepare(), fbnic_bd_one_desc() checks only
PAGE_FIN. When the first descriptor of a split header buffer has
PAGE_FIN =3D=3D 0, fbnic_pkt_prepare() returns before fbnic_page_pool_get_h=
ead()
decrements pagecnt_bias. Because pagecnt_bias stays 1 and the starting
offset is not checked, the trailing descriptor for that buffer (with
PAGE_FIN =3D=3D 1 at a non-zero offset) passes fbnic_bd_one_desc().

[ ... ]

> @@ -2672,6 +2724,14 @@ static void fbnic_enable_bdq(struct fbnic_ring *hp=
q, struct fbnic_ring *ppq)
>  	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_CTL, bdq_ctl);
>  }
> =20
> +static u32 fbnic_drop_mode(struct fbnic_net *fbn, bool tx_pause)
> +{
> +	if (!tx_pause && fbn->num_rx_queues > 1)
> +		return FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
> +
> +	return FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
> +}
> +
>  static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
>  				       struct fbnic_ring *rcq, bool tx_pause,
>  				       bool hdr_split)
> @@ -2679,10 +2739,7 @@ static void fbnic_config_drop_mode_rcq(struct fbni=
c_napi_vector *nv,
>  	struct fbnic_net *fbn =3D netdev_priv(nv->napi.dev);
>  	u32 drop_mode, rcq_ctl;
> =20
> -	if (!tx_pause && fbn->num_rx_queues > 1)
> -		drop_mode =3D FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
> -	else
> -		drop_mode =3D FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
> +	drop_mode =3D fbnic_drop_mode(fbn, tx_pause);
> =20
>  	/* Specify packet layout */
>  	rcq_ctl =3D FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
> @@ -2693,20 +2750,32 @@ static void fbnic_config_drop_mode_rcq(struct fbn=
ic_napi_vector *nv,
>  	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
>  }
> =20
> +static u32 fbnic_rcq_hds_thresh(const struct fbnic_net *fbn,
> +				const struct fbnic_ring *rcq)
> +{
> +	const struct fbnic_q_triad *qt;
> +
> +	qt =3D container_of_const(rcq, struct fbnic_q_triad, cmpl);
> +	return qt->hdr_max ? : fbn->hds_thresh;
> +}
> +
> +/* Only the drop mode: a queue start may write the rest of the register =
*/
>  void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
>  {
> -	bool hds;
> +	struct fbnic_ring *rcq;
> +	u32 drop_mode, rcq_ctl;
>  	int i, t;
> =20
> -	hds =3D fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
> -
> +	drop_mode =3D fbnic_drop_mode(fbn, txp);
>  	for (i =3D 0; i < fbn->num_napi; i++) {
>  		struct fbnic_napi_vector *nv =3D fbn->napi[i];
> =20
>  		for (t =3D 0; t < nv->rxt_count; t++) {
> -			struct fbnic_q_triad *qt =3D &nv->qt[nv->txt_count + t];
> -
> -			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
> +			rcq =3D &nv->qt[nv->txt_count + t].cmpl;
> +			rcq_ctl =3D fbnic_ring_rd32(rcq, FBNIC_QUEUE_RDE_CTL0);
> +			FIELD_MODIFY(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK,
> +				     &rcq_ctl, drop_mode);
> +			fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
>  		}
>  	}
>  }

[Severity: Medium]
Can the read-modify-write of FBNIC_QUEUE_RDE_CTL0 in
fbnic_config_drop_mode() race with fbnic_enable_rcq() and overwrite the
per-queue EN_HDR_SPLIT setting?

kworker (phylink_resolve)         CPU0
fbnic_phylink_mac_link_up()       fbnic_queue_start()
  fbn->tx_pause =3D tx_pause          ...
  fbnic_config_drop_mode()            fbnic_enable_rcq()
    rcq_ctl =3D fbnic_ring_rd32(...)      fbnic_config_drop_mode_rcq()
                                          fbnic_ring_wr32(rcq,
                                            FBNIC_QUEUE_RDE_CTL0, ...)
    FIELD_MODIFY(..., &rcq_ctl, ...)
    fbnic_ring_wr32(rcq,
      FBNIC_QUEUE_RDE_CTL0, rcq_ctl)  <-- clobbers EN_HDR_SPLIT

fbnic_phylink_mac_link_up() runs from the phylink workqueue without
netdev_lock(dev), while fbnic_queue_start() (or fbnic_up() after
__fbnic_open() calls phylink_resume()) programs FBNIC_QUEUE_RDE_CTL0 via
fbnic_enable_rcq(). If the two interleave, fbnic_config_drop_mode() can
restore a stale EN_HDR_SPLIT, MIN_HROOM or MIN_TROOM value, or
fbnic_enable_rcq() can write a stale fbn->tx_pause drop mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D10
