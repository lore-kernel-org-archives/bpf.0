Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719749AA3D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399178; cv=none; b=OWWlpkt7pw2wOuKOuStDnaCfXScM4gCVY/8zP8u5hqUN1jJTon+MRBnJ9XNjdnQqw3RsAe6kIE62/WZoGSTf8VDFCGe1lhx/WkSgre5KEYeOWqKCOkwBvZ03NvrjkHGPcBdSkuGzhAfzsCTQKyfoQB9Fhq6EnC20p0+zTcQfXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399178; c=relaxed/simple;
	bh=1P6GqE7iASDXBvzURikhhnPPdIXphnlDat8oIP3DYWQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R1twCciG1s6gYRrZmKCb8CRmr+jQ45CuzW4QiK4ugq4Ty2zchH1nGaFFDppZIrVeM/C7mrffBUqKnOBZXT2V5eeEHaC7175wLoOUokaQXUBIDwe/NHJYXxMSkMs2j/TtyFbWXmczAu8MkQYRmuVROMGy3oYdRJJVWOHIMdjyXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi1Ld0op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1Ld0op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDD1F000C4;
	Mon, 19 Oct 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399168;
	bh=ARRolzGWF+9JkMPtETvDfAVJklJOhengJAuGm4xchBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oi1Ld0opU0n8wBf4xCaVxyNqB2vAzs8eTL0P3ikc45I+SV3fNmq7QcFeHfhNp90z8
	 g4qd82wQVjLP7TdP4s8IAsCv5FIh1k+kH34tVpwvmGXwelKzh6zU2Cj7sg44zMZz1S
	 T0PKhDmqrRedhmrGOG8Vohk3lfrNE4rBO7NzVI0lADuOrVNc7JqBS8Et3fc2cuo6E7
	 NArHymYMN5xq/SO2b3CRQEYNxJex2AB9I7tby41n7YhaonO2Wz6UhBJ1ZFIiuCFRDo
	 ea3sDJaWPJleiDemGAcrSDW5pikYLYmWBOudWBsdjv/xY76CqQyUymHuJu2q2+KQPp
	 gxrHqjyGyeG5g==
Message-ID: <sashiko-outbox-176817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marcin Knap" <marcin.knap@vecima.com>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:39:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] xsk: missing xsk_buff_free() on redirect error in gve and octeontx2
--

commit 2859b3e778dcb29dabcd4c998977aac223d207b7
Author: Marcin Knap <marcin.knap@vecima.com>

xsk: Do not free ZC Rx buffer when the Rx ring is full

This commit stops xsk_rcv_zc() from calling xsk_buff_free() when the XSK Rx
ring is full (-ENOBUFS) so that callers of xdp_do_redirect() do not
double-free the zero-copy buffer. It also updates i40e and ice to free the
buffer on their XDP_EXIT paths.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..0edc160c660fd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct x=
dp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd =3D 0;
>  	u32 num_desc;
> -	int err;
> =20
> -	if (likely(!frags)) {
> -		err =3D __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);
> =20
>  	contd =3D XDP_PKT_CONTD;
>  	num_desc =3D xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>  		xs->rx_queue_full++;
> -		err =3D -ENOBUFS;
> -		goto err;
> +		return -ENOBUFS;
>  	}
> =20
>  	__xsk_rcv_zc_safe(xs, xskb, len, contd);
> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp=
_buff *xdp, u32 len)
>  	}
> =20
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }

[Severity: High]
Does removing xsk_buff_free(xdp) here leak xdp_buffs in gve and octeontx2
when xdp_do_redirect() fails with -ENOBUFS?

In drivers/net/ethernet/google/gve/gve_rx_dqo.c, the call chain
gve_rx_poll_dqo() -> gve_rx_dqo() -> gve_rx_xsk_dqo() -> gve_xsk_done_dqo()
handles XDP_REDIRECT on zero-copy buffers without freeing xdp on error:

	case XDP_REDIRECT:
		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
			goto err;
		break;
	}
	...
err:
	u64_stats_update_begin(&rx->statss);
	if (xdp_act =3D=3D XDP_TX)
		rx->xdp_tx_errors++;
	if (xdp_act =3D=3D XDP_REDIRECT)
		rx->xdp_redirect_errors++;
	u64_stats_update_end(&rx->statss);

Its caller gve_rx_xsk_dqo() then releases buf_state via
gve_free_buf_state(rx, buf_state) without freeing xdp, leaking it from
rx->xsk_pool.

Similarly, in drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c, the
call chain otx2_napi_handler() -> otx2_rx_napi_handler() ->
otx2_rcv_pkt_handler() -> otx2_xdp_rcv_pkt_handler() pops xsk_buff from
pool->xdp[--cq->rbpool->xdp_top] and does not free it if xdp_do_redirect()
fails:

	case XDP_REDIRECT:
		cq->pool_ptrs++;
		if (xsk_buff) {
			err =3D xdp_do_redirect(pfvf->netdev, xsk_buff, prog);
			if (!err) {
				*need_xdp_flush =3D true;
				return true;
			}
			return false;
		}

Should gve_xsk_done_dqo() and otx2_xdp_rcv_pkt_handler() also be updated
to free the zero-copy buffer when xdp_do_redirect() fails?

>  static void *xsk_copy_xdp_start(struct xdp_buff *from)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-xsk-zc-rx-=
double-free-v1-1-2aa19f6628fb@vecima.com?part=3D1
