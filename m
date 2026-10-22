Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688170;
	b=mw4zd8SfSCNCzwRXWT5PrV87xFpPPcafnH3tGBEkjAPkY7wwTyjxHzB2jeh3Vn3I7ugr
	 c5MC6RGcsv6SLRM4wTlYnLXYpkY54kc6KzRvNpsBgGi0eXlV1gZuZIkZK7r9zSZO0JRmd
	 bIRvcfV/ikMtSmw5iK3G0VhCx+29XzwHvmWMEVViFKQI/tMvdVh/bHK6ECAe8CDCTPlhl
	 IVsDx4ZutbQqS5oC8uf+AmWLEr5/OZwC9GUXoPTgdfHBcIZZixlNxUMsy7/UgW8XXWHKg
	 DjqfQyoqpTpf+ibxsH14T7W9OmMnh36L3hCDJW3Gn8lKJFtFsI4M8PLOWDda3ufaR+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688170;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=JFlmCiiT2/nXSNlSzFPx/z1Ts3xiQYmLMPe1wikoxjA=;
	b=qXKCaPwvIVjILgHoYpzHk/b+iOcU4LIeqYWvdA7v3ST0UEOj9QSv/TyzvtU+/YsrOkmD
	 IAp37a594Fkub1UOgvQvdFQwSROy7pJP4fMrArlUNiod3LQ03UkrbhHfbjeXio9VaBHWN
	 Au1VeKN1IisC2WeeAAOfmcqoFdWCWOP1NaVVwDcBhPLBWsedypOxrN9GRXbKpCNWBMvYM
	 FcBzmaG8vahdECcOaY8jrIKyKmL2DECE1o/mLuOD7SaFAmnkMQ2q5P/rC1DfU15qZcsSY
	 oD0D1EWjs4b3SNDeiWMHsz7Njn3XhTPyqsAwNNnqDtAQz4rowwWvTggCtSusPtHcwvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=NHbiW6lC;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65777606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 16:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65777606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=NHbiW6lC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792688166; x=1792947366;
	bh=JFlmCiiT2/nXSNlSzFPx/z1Ts3xiQYmLMPe1wikoxjA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NHbiW6lCm2LcZRh0DwmVRUem5BpBsRqYAusAMrdtEWIdKfRjHt2kkb2g/1BG2z3Jz
	 5HwZT7Moei0PAGAb6T9P2WOic9fErYf0J4vY9xXRbmLHKI4C8lap7NkQWLHRVzeTnp
	 k41ErmKkD3nFoDNGcVNKjUr+O+JdVtAWtmcKkCMapDpsRHlp6qNpglx8hT5Wp3A5tq
	 Joi6avyRxzLRvv3H/f80pYfTystqbJA3jFVYas+OHuh74Ra+3XL7atQ1wi4Xbow/fF
	 RIARX+jY43IeyUAflh3VLZ2Ky8cCDRAkxmPUvJ4QEUthEh9+8uCYOjC3Z3FrZglj+8
	 6S548inJeqIJg==
Date: Thu, 22 Oct 2026 16:55:59 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool assignment
Message-ID: <xFs3DcEr8aRQdjIeuzTZ4fmeQ3Ay8_x_94KB387XkLZDamj_rLyn4IGiFdZMi0u69fpiYrPQq9P6o1j_xixC1WbF-tl3JxDLmcMZZkPk70k=@1g4.org>
In-Reply-To: <atnKf5dNv0Vk1sCo@boxer>
References: <20261021224705.2078753-1-p@1g4.org> <atnKf5dNv0Vk1sCo@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 7d3e5e1dfa3b4d83e18d04fc9041e74619d97bde
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 22nd, 2026 at 3:34 AM, Maciej Fijalkowski <maciej.fija=
lkowski@intel.com> wrote:

> On Wed, Oct 21, 2026 at 10:47:33PM +0000, Paul Moses wrote:
> > xp_assign_dev() sets XDP_UMEM_SG_FLAG before checking whether the
> > device supports multibuffer zero-copy. If assignment fails, xsk_bind()
> > destroys the pool but retains the registered UMEM. A subsequent bind
> > without XDP_USE_SG inherits the stale flag.
>
> so you opened a socket, tried binding with XDP_USE_SG, failed then retrie=
d
> without the flag and you noticed unexpected rx frame size due to kept
> XDP_UMEM_SG_FLAG - do i get this right?
>
> socket not being closed kept the umem alive...
>
> >
> > The flag also changes RX buffer sizing after DMA mapping. On igc, a
> > failed SG bind followed by a non-SG retry with 4096-byte chunks and
> > 1792 bytes of headroom passes admission with 2048 bytes, but programs
> > a 1024-byte RX buffer. On I225-V hardware, an ordinary 1514-byte frame
> > is truncated to 1024 bytes or 1008 with RX timestamps enabled.
> > Restoring the original flags eliminates the truncation in both cases.
>
> It should be enough to state that sg flag presence takes into account
> tailroom size and therefore has influence on final rx frame size provided
> to driver.
>
> >
> > Save the UMEM flags before assignment and restore them on failure.
>
> Regarding the patch content:
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> >
> > Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing=
 umem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> >  net/xdp/xsk_buff_pool.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 0ebd4d46f7ab..7750d2ec4ee2 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -166,6 +166,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >  {
> >  =09u32 needed =3D netdev->mtu + ETH_PAD_LEN;
> >  =09u32 segs =3D netdev->xdp_zc_max_segs;
> > +=09u8 umem_flags =3D pool->umem->flags;
> >  =09bool mbuf =3D flags & XDP_USE_SG;
> >  =09bool force_zc, force_copy;
> >  =09struct netdev_bpf bpf;
> > @@ -268,6 +269,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >  =09if (!force_zc)
> >  =09=09err =3D 0; /* fallback to copy mode */
> >  =09if (err) {
> > +=09=09pool->umem->flags =3D umem_flags;
> >  =09=09xsk_clear_pool_at_qid(netdev, queue_id);
> >  =09=09hlist_del(&pool->dev_node);
> >  =09=09pool->netdev =3D NULL;
> >
> > --
> > 2.56.GIT
> >
> >
>

Right, evidence suggests igc handles it gracefully, I had attempted=20
to provide multiple examples of real world impact to satiate Sashiko,
but only igc survived final edit. It needs to be open for the failed=20
bind and successful retry, it can be closed after and bad state=20
remains. If you're looking for greater impact, look at stmmac. I'll
send out a v2 without naming drivers specifically soon.
