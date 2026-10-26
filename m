Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002190;
	b=rsK/WcmKTUlBwij+iCNsRq9U9V66UJU6kdXZo3/yoU+DDyapqlYK9QsRxQEv+eedR7TG
	 tWljHUHFo+SSeaYqsu8WZOWvkJz0Xih6H7kclwxkXB/+pKiNSKinuaV7R0LgMijkr4yq5
	 ZveNy8zzSzHDJx/sM6RZvdUwPiwU9Tv+53LxYBjh/5eRUaP3ffvLqXifFWWVdE2axa8ai
	 QqtOAMZDsaLoHLJGhLJvdnZqtY/zore4qxZ+gNRGJ2GE1cbE8GPOkGGRAhX45W162gn8+
	 muNh7t0y2roZ9+MleHKh0/4p2bhd+DpG2HX08Qn2UpGX8POOfUA92WQvqadwddNPB6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002190;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=IoIcS+gLnmzaBN1aXijYz+gNQYGjmdJtPr2Yly0VmrU=;
	b=JHKzg67amznxAsig1wlVLET8dD1TEivFKl9f+Q5BTY2abrv4K6HRp/HaSlNa6PbJxGmp
	 AJIxUE8TrPWHDBdbWGcSCKVBZWaFvIRnQMxM9nOjgs0gCYkjHtVQVDoqi9HcBF/6Nr5oS
	 lIE5PNZe/QMw+SwIYLaNQQO51DnsdZQ+vmt+/Hry1fVQyHIrUIZdG/RsLhk39nIeKiFab
	 PozLQmykdr+49DZcnLxqYPsfwPp9KrxpcKWXOfOxYYR7o8i4B5f3zy4oh50lwAOX39KtK
	 U80RSTNKi/4eJTdq236U8+CYeVtxHWBXkajMRyF1ZbmkHnyBBuioyUpw0aCb3WKpDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qwWnWELw;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CB606A322;
	Mon, 26 Oct 2026 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053CB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qwWnWELw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793002186; x=1793261386;
	bh=IoIcS+gLnmzaBN1aXijYz+gNQYGjmdJtPr2Yly0VmrU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qwWnWELwy03SN6/MZB/0dV1L2d3FEoHBxaZIzLifsiqlyKdDdvJ/y7WHYDKc740Wj
	 yhfIUFfm54tUwoBMZy8b6l253LzyHC9vmhQl7m5axdHwNBO00HZz3Tw+KJ6+uSNWZd
	 t0hbJ+53lf3m4muCp0GMhGz6Oc8b+wpQPBxuF/9n1+rxaNxk1WjJto8WwAvXElWFQK
	 N1xQ5oTZvTSer3/agHlinJ6Xjzo6+g/V0UcP2JFiruY35Dam/kViW4ynN/TU5Jcb6D
	 Pi6FUUoDkpvLNaDMRajinaUngbFeJc7oC8Xa/JZjBtqFsCdRT+qzEz5EeDxhW40k5p
	 pYUHtYXbFibLQ==
Date: Mon, 26 Oct 2026 08:09:43 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, maciej.fijalkowski@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com, andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <1EvchnNc6hsP0rVtNzqvcHlIKZ0tWYrRL3c7XpesxOlmd_fe-H2ROdacFthmJCYNjVvWa7k4JxhfQBGebKyUbUsfI5FU6gsB0IOd7_znQoQ=@1g4.org>
In-Reply-To: <179300059875.3134.14278423796840357371@kernel.org>
References: <20261025065154.2037149-1-p@1g4.org> <179300059875.3134.14278423796840357371@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 617b83583d400fe265873a1b32e7c4248d7cd7b3
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

On Monday, October 26th, 2026 at 2:43 AM, netdev-bot+sashiko@kernel.org <ne=
tdev-bot+sashiko@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The new split-frame discard paths leave frames out of
>   rx_packets and rx_bytes, which contradicts the rtnl_link_stats64=
=E2=80=A6
>=20
> Pre-existing issues:
> - [High] In igc_clean_rx_irq(), the FPE mPacket early exit leaks the RX
>   page and its DMA mapping.
> - [High] igc_xdp_set_prog(), igc_xdp_enable_pool() and
>   igc_xdp_disable_pool() tear down and rebuild the RX ring while NAPI=
=E2=80=A6
>=20
> --
>=20
> igc: track rx frame boundaries independent of skbs
>=20
> The patch adds a per-ring rx_in_frame flag so the inline TSIP timestamp
> header is stripped only from the first buffer of a frame. Split frames
> that are not supported (XDP enabled, AF_XDP zero-copy) are rejected
> before XDP runs, and their continuation descriptors are drained. The RX
> poll functions now return a work_done count that includes discarded
> descriptors, instead of total_packets.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..9ca5558c762c9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring=
)
> >  =09=09igc_clean_rx_ring_page_shared(ring);
> >
> >  =09clear_ring_uses_large_buffer(ring);
> > +=09ring->rx_in_frame =3D false;
> >
> >  =09ring->next_to_alloc =3D 0;
> >  =09ring->next_to_clean =3D 0;
> > @@ -673,6 +674,7 @@ static void igc_configure_rx_ring(struct igc_adapte=
r *adapter,
> >  =09/* reset next-to- use/clean to place SW in sync with hardware */
> >  =09ring->next_to_clean =3D 0;
> >  =09ring->next_to_use =3D 0;
> > +=09ring->rx_in_frame =3D false;
> >
> >  =09if (ring->xsk_pool)
> >  =09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but these new resets assume
> NAPI is not polling the ring. Do the XDP reconfiguration paths actually
> guarantee that?
>=20
> igc_xdp_set_prog(), igc_xdp_enable_pool() and igc_xdp_disable_pool() all
> clean the ring before they disable NAPI:
>=20
> drivers/net/ethernet/intel/igc/igc_xdp.c:igc_xdp_set_prog() {
>     ...
> =09=09for (i =3D 0; i < adapter->num_rx_queues; i++) {
> =09=09=09igc_disable_rx_ring(adapter->rx_ring[i]);
> =09=09=09igc_disable_tx_ring(adapter->tx_ring[i]);
> =09=09=09napi_disable(&adapter->rx_ring[i]->q_vector->napi);
> =09=09}
>     ...
> =09=09=09napi_enable(&adapter->rx_ring[i]->q_vector->napi);
> =09=09=09igc_enable_tx_ring(adapter->tx_ring[i]);
> =09=09=09igc_enable_rx_ring(adapter->rx_ring[i]);
>     ...
> }
>=20
> igc_disable_rx_ring() does only an RXDCTL write before it calls
> igc_clean_rx_ring(). Also, napi_enable() runs before
> igc_enable_rx_ring()->igc_configure_rx_ring().
>=20
> Suppose igc_clean_rx_irq() is running on another CPU while
> igc_clean_rx_ring_page_shared() calls dev_kfree_skb(rx_ring->skb) and
> drains the pages. Could the poll then call igc_add_rx_frag() on the freed
> skb, or drop page references a second time through igc_put_rx_buffer()?
>=20
> When the poll exits, it also writes rx_ring->skb, next_to_clean and
> rx_in_frame back, after the reset. igc_configure_rx_ring() resets
> rx_in_frame but not rx_ring->skb. A later poll could then see
> first =3D=3D true with a stale non-NULL skb, and the new (!first && !skb)
> check would not catch that.
>=20
> Triggering this needs a CAP_NET_ADMIN user to attach or detach an XDP
> program, or to bind or unbind an AF_XDP pool while XDP is loaded, while
> RX traffic keeps a poll running on another CPU.
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
>=20
> [Severity: Medium]
> Should the frames dropped here still count toward rx_packets and
> rx_bytes?
>=20
> include/uapi/linux/if_link.h describes rx_packets in rtnl_link_stats64
> as including "packets which host had to drop at various stages of
> processing (even in the driver)".
>=20
> Take a hardware-good first descriptor that is dropped only because XDP is
> enabled and EOP is not set. It jumps to xdp_done and skips the new
> total_bytes/total_packets block, so only rx_dropped and work_done are
> incremented. igc_clean_rx_irq_zc() does the same for !eop frames.
> igc_update_stats() then exports the ring totals directly as
> net_stats->rx_packets and rx_bytes.
>=20
> Frames that the XDP program drops are still counted in the same function,
> and before this patch every descriptor was counted. The commit message
> says the exclusion is intentional ("without counting successful RX"), but
> that doesn't match the documented semantics.
>=20
> >  =09=09truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
>=20
> [ ... ]
>=20
> > -=09=09if (igc_fpe_is_pmac_enabled(adapter) &&
> > +=09=09if (first && igc_fpe_is_pmac_enabled(adapter) &&
> >  =09=09    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_=
offset)) {
> >  =09=09=09/* Advance the ring next-to-clean */
> >  =09=09=09igc_is_non_eop(rx_ring, rx_desc);
> >  =09=09=09cleaned_count++;
> > +=09=09=09work_done++;
> >  =09=09=09continue;
> >  =09=09}
>=20
> [Severity: High]
> This is a pre-existing issue, but this block is being modified here. Does
> this early exit leak the RX page and its DMA mapping?
>=20
> igc_get_rx_buffer() always decrements rx_buffer->pagecnt_bias. This path
> advances next_to_clean and continues, but it never restores the bias and
> never calls igc_put_rx_buffer(). That function is the only place that
> recycles or unmaps the page and clears rx_buffer->page.
>=20
> The slot still holds the page after next_to_clean has moved past it. If
> igc_reuse_rx_page() later recycles a buffer into that slot, it overwrites
> the page without checking:
>=20
> drivers/net/ethernet/intel/igc/igc_main.c:igc_reuse_rx_page() {
>     ...
> =09new_buff =3D &rx_ring->rx_buffer_info[nta];
>     ...
> =09new_buff->page=09=09=3D old_buff->page;
>     ...
> }
>=20
> The old page and its mapping are then lost.
>=20
> If igc_alloc_rx_buffers() reaches the slot first, igc_alloc_mapped_page()
> reuses the page because bi->page is non-NULL, but the bias is one too
> low. igc_can_reuse_rx_page() would then always see
> (rx_buffer_pgcnt - pagecnt_bias) > 1, so the page is never freed.
>=20
> igc_fpe_handle_mpacket() returns true for any SMD-V or SMD-R frame. With
> pMAC enabled, the link partner can trigger this with every such frame it
> sends.
>=20
> The new drop path in this patch already releases the buffer correctly:
> pagecnt_bias++ in the IGC_XDP_CONSUMED case, then igc_put_rx_buffer(),
> cleaned_count++ and igc_is_non_eop(). Could the mPacket case release the
> buffer the same way?
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261025065154.2037149-1-p%401g4.org
>=20

I'll review and correct accounting. The other two are out of scope
unless I introduced regression.=20

pw-bot: cr
