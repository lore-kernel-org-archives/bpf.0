Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63805390204;
	Sun, 18 Oct 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314541; cv=none; b=B6Rd6KcPbgljPu2cVEz7mGuzjTcpq/I0fdD9TxfL2RAaYCK3J4yNiV9N6JCJISiD/2ttFk05JbqlZqPpOCD72mHoJzGLQHKpCffdT7dFURRkMBhq/3KivH8/8QQyFymEzvnk4eTYzDkcJ+5DVwBRJ4vvRqf2milAZWj2WzipSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314541; c=relaxed/simple;
	bh=N495F9fxm/ocCkYyFccUAlYXMPq0Sn8wNjEUiLr9yg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIvZD9M0Gfl6U68oLgKz9RLseqHCPO5mKnbtn87wUHako7/Qd34lYjpaEtsohTI6odQYU9tfCwH2NgQw43Yxwo0W7kaGm+wEWymLrbx2kgdm+lr0MpKliyR4JCXkA1hrMVD6UePijAY0Oo60SkG0tN8dFwMKrsynLxoeYp7wruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcQ+6koT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcQ+6koT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803951F000C4;
	Sun, 18 Oct 2026 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792314540;
	bh=M2E2n+hrltMvOElGh228CxO8bl+0vllTCSDQe43rOjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bcQ+6koT0Td+HNEWjbwaZWCUQ4/IlgK1Yz7IMQsUQEgQNW6XfViEv/pU48oA3KzGd
	 d/uRijf85PA1r1+AXk8oHjHMLp+88YdWZXz8zFHR51tbdFwJAguMu0+H4BJDuML5tj
	 gbAVo7f79PGI/scp064IQ7Jj+BDQjxql7g7dpVbX4TnOczNrv85v4LvbAcOzgQYWVD
	 T5tp/7WFJ594lF8GwpTxC0xU7lhiaaw1t+LCa/Dg2M/EbryFa9OpGBLqiEtQHvr7I2
	 9RVtk9b9isEMEtKMrtsxuM2pXHltMexU0Gpp/7HSuM5p80jgxT18b5bQHlTLK0LW2V
	 7oOxTmrqP2zlw==
Date: Sun, 18 Oct 2026 11:08:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	toke@redhat.com, horms@kernel.org, bpf@vger.kernel.org,
	shuah@kernel.org, hawk@kernel.org, kernel-team@cloudflare.com,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	sdf@fomichev.me, linux-kselftest@vger.kernel.org,
	bochaolucky@gmail.com, toshiaki.makita1@gmail.com
Subject: Re: [PATCH net 1/2] veth: schedule the peer's NAPI after XDP_TX when
 only GRO is enabled
Message-ID: <atSMqdB52V494aYn@lore-desk>
References: <20261016214217.16942-1-tianyi@cloudflare.com>
 <20261016214217.16942-2-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="threxb6QVOCWS9wz"
Content-Disposition: inline
In-Reply-To: <20261016214217.16942-2-tianyi@cloudflare.com>

--threxb6QVOCWS9wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> veth_xdp_xmit() queues XDP_TX frames on the peer's ring if the peer has
> NAPI. A peer with GRO enabled and no XDP program also has NAPI.
>=20
> veth_xdp_flush() then schedules the peer's NAPI, but only if the peer's
> xdp_prog is set, so for such a peer the frames are never processed.
> Nothing else schedules that NAPI by default.
>=20
> Once the ring is full, every XDP_TX frame is dropped, and so are the
> skbs that veth_xmit() queues on the same ring.
>=20
> Commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before
> xmit of XDP frame") changed the check in veth_xdp_xmit() but not the one
> in veth_xdp_flush(). Make veth_xdp_flush() check the napi pointer
> instead of xdp_prog, as veth_xdp_xmit() does.
>=20
> Fixes: 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before xmi=
t of XDP frame")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/veth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 643b97dc5245..9405ffac598a 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -612,7 +612,7 @@ static void veth_xdp_flush(struct veth_rq *rq, struct=
 veth_xdp_tx_bq *bq)
>  	rcv_priv =3D netdev_priv(rcv);
>  	rcv_rq =3D &rcv_priv->rq[veth_select_rxq(rcv)];
>  	/* xdp_ring is initialized on receive side? */
> -	if (unlikely(!rcu_access_pointer(rcv_rq->xdp_prog)))
> +	if (unlikely(!rcu_access_pointer(rcv_rq->napi)))
>  		goto out;
> =20
>  	__veth_xdp_flush(rcv_rq);
> --=20
> 2.55.0
>=20

--threxb6QVOCWS9wz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatSMqQAKCRA6cBh0uS2t
rPSYAQD5RUAZm2NgGMSYCi+SCQmjyV/IRzA/JOrJhI5wDZP82wEA9uqCGuB5bi8b
UqEIm6MiOPFm2R47mSuUhs2EnMwVxgk=
=d12M
-----END PGP SIGNATURE-----

--threxb6QVOCWS9wz--
