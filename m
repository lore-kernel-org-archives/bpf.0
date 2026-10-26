Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997541;
	b=okS7rBT5z9hu4c/SSK0XI5vFIm8/Q0pRgBK53eicsm6oGNhyaKojHrgjrrO/btjcUtOA
	 g380jvQ6vGOnxqQY+nrRjWjsNE0aDPKXGSSVW2MN52E67Ic55UhZQUqMwpqt3/b+gE5zz
	 2boIZpjMK7/9W/Lf5qopEVO6dSAKUlK62a2UV/TscpY9herd/bjD6SxolYsYSlsRCcoui
	 KKn5ZAsR0Gd/iyGap3tMbjPn0SgC9e5RD/57dN6NPJVv3TEQv1H6NY2ZvmryrYtiWjNWM
	 hL5vtz3esq7NDQIAAuvP6y2CTuwSEeDn1eqitaGmq78m80cqWkLshb3lHhqqb+r631Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
	b=zoTRwnSZHfffOTrP/LyJvXZ59XXqeqmcOQFDpTpRkSU0aRXh2l1ULIdvDQjYiDmM+MxP
	 N5BcqDaIxahRA8cFxCAHfXxWHpaqaBx14p+s/Mo7h+2JnqSh261jgdYXW7b30Mog+CQwj
	 8pyNRXY9/SI9LmUYvx/bT1LuFz3dYEoWPQdTy7O9wpScdgXuUfbqbz6bBjUZgPqZ9bEVe
	 layqWHLCSyMWfKmFi7BXsLRcb7yGNOKI+1eDdm7SivbHhfVkH0dn5tOyoxIbt1Ych5xZ6
	 5RF72BwSGCt/hQ+NTw7oet4yBMiaTZVcE2Apv67VeHfYXBxZnLCgnOsQFPtZu3d4d2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0jfaQvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF484606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0jfaQvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627FD1F01825;
	Mon, 26 Oct 2026 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792997540;
	bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y0jfaQvysQzIVWOeMQpkE29ZV2HFvBbwzVX8SszINIZUJppjYFcOvMbsCAO8Rs2el
	 fq5xvxgM1Wpk6hvkWWM5L9NQOxRRvDd17/Mn89mhUX5I6pI6oMpN+C12telC5W77i8
	 soB1rWVlE2r6nNJ9utvvUkPseMHu222uXkyX+0Q1e8ATnR6O89zss5wLnHdcRBCOXT
	 Uwb71djC3kTC03vjpXO+RWHWeaeoETtmQfXdB72NgB0KzdoLcLKUle1Wy06rd+NnR9
	 YUqcHL0BB4+ZeFg7QVN6DwFjpHa7lU6TYfGPp9lb0rW7cg9uOOOYFKn6vhdJrhqFYE
	 SZ3WidDcfXWkg==
Message-ID: <sashiko-outbox-184616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Moses" <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
References: <20261025065154.2037149-1-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 06:52:19 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] igc: off-by-one in TSIP length check in igc_clean_rx_irq() and zc =
variant
--

commit 7b71c87cde8117fd4a451a2a079f34aaf64bd069
Author: Paul Moses <p@1g4.org>

igc: track rx frame boundaries independent of skbs

This commit tracks RX frame boundaries per ring via rx_in_frame so that
inline RX timestamps are stripped only from the first descriptor buffer.
It also rejects unsupported split frames before XDP, drains continuation
descriptors, and updates NAPI budget accounting in both standard and
AF_XDP zero-copy RX paths.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..9ca5558c762c9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

[ ... ]

> @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
>  		dma_rmb();
> =20
>  		rx_buffer =3D igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt);
> +		tsip =3D first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP);
> +
> +		if ((!first && !skb) ||
> +		    (first && igc_xdp_is_enabled(adapter) &&
> +		     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> +		    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> +			xdp_res =3D IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> +
>  		truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> =20
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> =20
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx.rx_ts =3D pktbuf;
>  			pkt_offset =3D IGC_TS_HDR_LEN;
>  			size -=3D IGC_TS_HDR_LEN;
>  		}

[Severity: High]
Should the length check in igc_clean_rx_irq() be size <=3D IGC_TS_HDR_LEN
instead of size < IGC_TS_HDR_LEN?

When a first descriptor has IGC_RXDADV_STAT_TSIP set and size =3D=3D
IGC_TS_HDR_LEN, the buffer contains only the 16-byte inline timestamp
header and no packet payload. With size < IGC_TS_HDR_LEN, the check passes
and size -=3D IGC_TS_HDR_LEN leaves size as 0.

If XDP is disabled and this is a non-EOP descriptor followed by a
continuation descriptor of at least 60 bytes (ETH_ZLEN),
igc_construct_skb() or igc_build_skb() creates an skb with zero linear
headlen, and igc_add_rx_frag() attaches the continuation buffer as a paged
fragment where skb->len =3D=3D skb->data_len >=3D 60. Because skb->len >=3D
ETH_ZLEN, igc_cleanup_headers() -> eth_skb_pad() does nothing, and
igc_process_skb_fields() -> eth_type_trans() -> __skb_pull(skb, ETH_HLEN)
then triggers BUG() because skb->len drops below skb->data_len.

If EOP is set on the 16-byte descriptor, size =3D=3D 0 runs XDP on an empty
buffer where XDP_TX calls igc_xdp_xmit_back() ->
igc_xdp_init_tx_descriptor() with a 0-byte length, and normal RX or
XDP_PASS allocates a 0-byte skb that eth_skb_pad() zero-pads to 60 bytes
and hands to napi_gro_receive().

[ ... ]

> @@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vecto=
r *q_vector, const int budget)
>  		dma_rmb();
> =20
>  		bi =3D &ring->rx_buffer_info[ntc];
> +		tsip =3D first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
> +		eop =3D igc_test_staterr(desc, IGC_RXD_STAT_EOP);
> +
> +		if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(ring->netdev);
> +			res =3D IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> =20
>  		ctx =3D xsk_buff_to_igc_ctx(bi->xdp);
>  		ctx->rx_desc =3D desc;
> =20
> -		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx->rx_ts =3D bi->xdp->data;
> =20
>  			bi->xdp->data +=3D IGC_TS_HDR_LEN;

[Severity: High]
Similarly, in igc_clean_rx_irq_zc(), should the check be size <=3D
IGC_TS_HDR_LEN so a 16-byte TSIP descriptor does not result in size =3D=3D 0
after subtracting IGC_TS_HDR_LEN, which would pass a 0-byte xdp_buff to
__igc_xdp_run_prog() and igc_dispatch_skb_zc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025065154.2037=
149-1-p@1g4.org?part=3D1
