Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001239;
	b=Q33GIxxAOS4XYnSEnooN8Fve5Dm7aT+UzozJjvYZhnfCafUxSalCovbL8cqG/cirT4nM
	 MCb9UZ2FOeXQopwmd5akhLYcoU8PeE//GTZ9DYz4AucEkWVfaICMnuWyhD0+TJ0pJXZgg
	 ENkGZw4/Ujkue3rPlOGCWgI2/bN/gsjGzux4Hnip28JCgWxjaAKli2Ko9ourmM+WHHDnt
	 2M6+ew3AZHfwAu3tX3A8jwm79oh+TmmrtvuQhHRjBTAnnPcXdu7IUJAEPq74u42An5Aui
	 c3ncnYr1pT3eQ767GtAuEhFCfbxx+kRng+KaPps1yb61i7+VM1jh6MFtRru339zoLSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001239;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
	b=Q34VPqxzdARl91Vi4Zm7iYJF64LNO+9O3MohDBRo9BXzGyKRCk43a9f4QLc+EcKox//Q
	 rS2d2XFaS9WVal5FA+qPpXdW9RhNEq7pwcskQ1dgj4UBxAc2tJ9IElGkSfngV6QA7F+M2
	 0N/ik/rFEWTaO9sXapas4XVLnSwA4siBRWaTKS7OGbMqZqQ3GxArd1upZdackYdtZijpa
	 PUwjeJgmBaSbjc/Jhd7q3wiDNxkuvF4KJYBWx57HrorYg1bbZIldzsDMZ81lxc8Ukz9Ai
	 wjySz5uWcnZeHRhRXNL7XawagCaspzX3uL7YGL0/8iUWjO1+YQZFIOBQfwkAH2PK4mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=dYr19qWL;
	arc=none smtp.remote-ip=109.224.244.118
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26512606A324
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 07:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26512606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=dYr19qWL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793001233; x=1793260433;
	bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dYr19qWLgNxaI6kjQtsrquIulqivtOAvVzDWRfdROAIHuStkIGvXwAXqZIW50JF5x
	 OQclzbLDmLn1a8IaUyIFAfnHNzbvh8YjBM7a5PG63sLjVrdhKVSQEfPzYyx9Is3VES
	 AJ6KWcjVyLqPyikmNd3dLYdNldP5DbGMcmQDrsJXYLmWokCtkC9qNU6vfEjLvmy9pH
	 8xCD0ZPAYqm7bSRoSd6pw8IW/ywlIufTr/glWjFwHrWXs6tDzE6GdhgI+nd/2AEcW3
	 CKLw5VW/u6MKimAIp+GCt+LXfXGDocjpigmzsDSusw3gGZSfzTN2+baO+Z3qlv7dGO
	 +CbU4XHcT2t0A==
Date: Mon, 26 Oct 2026 07:53:49 +0000
To: sashiko-reviews@lists.linux.dev
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <RWzBrfsuLy54ULo85bs7EUhLPBOhR88jVUxVW1TsP7bhhEDQM2T-b9R6X3F9D62O3nN9GVNqK2S9NQG-sqqOIba8bP0oHv0rOUJdn_p1QUo=@1g4.org>
In-Reply-To: <sashiko-outbox-184616@kernel.org>
References: <20261025065154.2037149-1-p@1g4.org> <sashiko-outbox-184616@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 88968fa72f3d1b8507b05439ff909c5cb132e4e1
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





On Monday, October 26th, 2026 at 1:52 AM, sashiko-bot@kernel.org <sashiko-b=
ot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] igc: off-by-one in TSIP length check in igc_clean_rx_irq() and z=
c variant
> --
>=20
> commit 7b71c87cde8117fd4a451a2a079f34aaf64bd069
> Author: Paul Moses <p@1g4.org>
>=20
> igc: track rx frame boundaries independent of skbs
>=20
> This commit tracks RX frame boundaries per ring via rx_in_frame so that
> inline RX timestamps are stripped only from the first descriptor buffer.
> It also rejects unsupported split frames before XDP, drains continuation
> descriptors, and updates NAPI budget accounting in both standard and
> AF_XDP zero-copy RX paths.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..9ca5558c762c9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>=20
> [ ... ]
>=20
> > @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> >  =09=09dma_rmb();
> >
> >  =09=09rx_buffer =3D igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt)=
;
> > +=09=09tsip =3D first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP=
);
> > +
> > +=09=09if ((!first && !skb) ||
> > +=09=09    (first && igc_xdp_is_enabled(adapter) &&
> > +=09=09     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> > +=09=09    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> > +=09=09=09if (first)
> > +=09=09=09=09dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> > +=09=09=09xdp_res =3D IGC_XDP_CONSUMED;
> > +=09=09=09goto xdp_done;
> > +=09=09}
> > +
> >  =09=09truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
> >
> > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (tsip) {
> >  =09=09=09ctx.rx_ts =3D pktbuf;
> >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> >  =09=09=09size -=3D IGC_TS_HDR_LEN;
> >  =09=09}
>=20
> [Severity: High]
> Should the length check in igc_clean_rx_irq() be size <=3D IGC_TS_HDR_LEN
> instead of size < IGC_TS_HDR_LEN?
>=20
> When a first descriptor has IGC_RXDADV_STAT_TSIP set and size =3D=3D
> IGC_TS_HDR_LEN, the buffer contains only the 16-byte inline timestamp
> header and no packet payload. With size < IGC_TS_HDR_LEN, the check passe=
s
> and size -=3D IGC_TS_HDR_LEN leaves size as 0.
>=20
> If XDP is disabled and this is a non-EOP descriptor followed by a
> continuation descriptor of at least 60 bytes (ETH_ZLEN),
> igc_construct_skb() or igc_build_skb() creates an skb with zero linear
> headlen, and igc_add_rx_frag() attaches the continuation buffer as a page=
d
> fragment where skb->len =3D=3D skb->data_len >=3D 60. Because skb->len >=
=3D
> ETH_ZLEN, igc_cleanup_headers() -> eth_skb_pad() does nothing, and
> igc_process_skb_fields() -> eth_type_trans() -> __skb_pull(skb, ETH_HLEN)
> then triggers BUG() because skb->len drops below skb->data_len.
>=20
> If EOP is set on the 16-byte descriptor, size =3D=3D 0 runs XDP on an emp=
ty
> buffer where XDP_TX calls igc_xdp_xmit_back() ->
> igc_xdp_init_tx_descriptor() with a 0-byte length, and normal RX or
> XDP_PASS allocates a 0-byte skb that eth_skb_pad() zero-pads to 60 bytes
> and hands to napi_gro_receive().
>=20
> [ ... ]
>=20
> > @@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >  =09=09dma_rmb();
> >
> >  =09=09bi =3D &ring->rx_buffer_info[ntc];
> > +=09=09tsip =3D first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
> > +=09=09eop =3D igc_test_staterr(desc, IGC_RXD_STAT_EOP);
> > +
> > +=09=09if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> > +=09=09=09if (first)
> > +=09=09=09=09dev_core_stats_rx_dropped_inc(ring->netdev);
> > +=09=09=09res =3D IGC_XDP_CONSUMED;
> > +=09=09=09goto xdp_done;
> > +=09=09}
> >
> >  =09=09ctx =3D xsk_buff_to_igc_ctx(bi->xdp);
> >  =09=09ctx->rx_desc =3D desc;
> >
> > -=09=09if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (tsip) {
> >  =09=09=09ctx->rx_ts =3D bi->xdp->data;
> >
> >  =09=09=09bi->xdp->data +=3D IGC_TS_HDR_LEN;
>=20
> [Severity: High]
> Similarly, in igc_clean_rx_irq_zc(), should the check be size <=3D
> IGC_TS_HDR_LEN so a 16-byte TSIP descriptor does not result in size =3D=
=3D 0
> after subtracting IGC_TS_HDR_LEN, which would pass a 0-byte xdp_buff to
> __igc_xdp_run_prog() and igc_dispatch_skb_zc()?
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025065154.20=
37149-1-p@1g4.org?part=3D1
>=20

I'm assuming the hardware works as documented, if someone wants
to followup on hypothetical defensive scenarios, go for it.

Even if I did change these, where does it end? 
