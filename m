Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052780;
	b=PbVqI0lA+4GG1WUN05q87SnB6Am/iFY1Y8vy8+Ku5DjOMT8CBFWVqWNBTz8BhY2xFyv0
	 0rUmiLvEowMFGSPXdReSINJ/0aOrD33+VLgNZtn6zJ9ed79m6ivH7Gb6AIvPrXe1ME9qU
	 fTc2IUrhUdsTqiEOTioq/YPoI5YQdqcv5uwQspTr7KnywzALlvdL6H5V4PitZn+4EAr4a
	 3QdCMYGS7KG6fBbZx3Y6R0NGyDCzw32KYWz7wf8foqUnxgL0rixJ/U9izdo9s5Zg5mxZ8
	 JlTf2K6pzD3smJoaR6xmh5zYdXI2NOxS7t+WKruRPObwN2+3zT/WvdYgCOcdGOOp7cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052780;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
	b=VDRVfdRpovF1XW9O7BYwamt1PGHJPOwGt7pL6ghKP65MhzJlSsC3aTllqPmQHKpz+iST
	 xriQwMkR5tPS/5Bsn35WYmjd5RdKl9D6mhtVaZ+2fTiy4XlTKkvsUVpmMTmyKiOHfw3pw
	 v8VwTzVM6Oy7hcWdVVcXl2huCWujaMCQOSYlcKiEl99VnKFMN5azRZgD9mVdbGPGfu4st
	 xxKQ94xNhAoUbOkF+xERP5PcO2+XyMHSkUb88Rb9Dodbtrwu7DJhiC7SjlO3hzVp2EXQZ
	 mkWQsYMgyVYmveOsgwVeTAOF+zeqsUKclr6jZg5ROhRB4Vvl6AhSfoquVvK0L4/prrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=E2pTaF4I;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0195606A31F;
	Mon, 26 Oct 2026 22:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0195606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=E2pTaF4I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793052776; x=1793311976;
	bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E2pTaF4IHfCB5bU4RuhRkXhZvCfTmH3d1oCLK7CeOVhuxG7WnpzFfSWxm0ckTvv3l
	 FgrrXutYFGD2bckDM1CMUkxgkc+9IE9x3VVX1cOw0qSAtMPW5aIRjop+BAehf6F4Bc
	 dnRm5i8T+RXlb0joRV5msZOqPODJOP1hLEfOEPvYZfKvMc5f9NQgwdT+h3yFSNHBC0
	 3rKnslJNGF3G/dhGQYCxy63DFRKz1A598lCF/W4RHRd1fKKMZH/i8+p/GJnjpcHNKw
	 YE8OCXGRGxiVy2x6UgYnduL7hrrv0iv6rkEP37/0rf7U/SdIbW0dCOp8xMKKepZhPc
	 HCXaGaNfrIZpQ==
Date: Mon, 26 Oct 2026 22:12:51 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org>
In-Reply-To: <at+t/jHczGvyXKRN@boxer>
References: <20261025065154.2037149-1-p@1g4.org> <at+t/jHczGvyXKRN@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ac7101c3c05c84577692eb23b23ecea516f2e015
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





On Monday, October 26th, 2026 at 2:46 PM, Maciej Fijalkowski <maciej.fijalk=
owski@intel.com> wrote:

> On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> > TSIP remains set on continuation descriptors, but the inline timestamp
> > header exists only in the first buffer. Stripping it from every
> > descriptor truncates split frames and can underflow short buffers.
> >
> > skb ownership cannot identify frame boundaries when XDP consumes the
> > first buffer or AF_XDP uses zero-copy.
> >
> > Track rx_in_frame per ring and update it as descriptors are consumed.
> > Strip timestamps only from first buffers, reject unsupported split
> > frames before XDP and drain continuations. Account discarded
> > descriptors against NAPI work without counting successful RX.
> >
> > Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> > Fixes: 26575105d6ed ("igc: Add initial XDP support")
> > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> > - This supersedes "igc: only strip RX timestamp header from first buffe=
r"
> >   following feedback from Simon Horman, Maciej Fijalkowski and Sashiko.
> >
> > Changes:
> > - track frame boundaries independently of skb ownership
> > - guard timestamp stripping and drain unsupported split frames
> > - cover the AF_XDP zero-copy RX path
> > ---
> >  drivers/net/ethernet/intel/igc/igc.h      |  1 +
> >  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++-------
> >  2 files changed, 64 insertions(+), 24 deletions(-)
>=20
> Hi Paul,
>=20
> I think this implementation went off track. We should make sure we *never=
*
> enter data path for XDP/AF_XDP multi-buffer scenario until we add real
> support to it within this driver. Now you sorta handle fragmented packets
> in data path.
>=20
> I tried to argue with bot reports that it hallucinated for
> igc_clean_rx_irq() content (which was concise and to the point) and agree=
d
> the AF_XDP should *not* be exposed to any fragmented traffic, which shoul=
d
> be addressed on HW RX ring configuration side, not within data path.
>=20
> Also this should have been a v3 with a link to previous revisions so we
> could keep track what has been changing between versions.
>=20
> Here's something that would address ZC fragmentation issue. Could you giv=
e
> it a spin on your side as I don't currently have igc in my setup handy.
>=20
>=20
> From a3edec7db135f13a567565a652da5cc850505f7f Mon Sep 17 00:00:00 2001
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Mon, 26 Oct 2026 15:00:00 +0100
> Subject: [PATCH net] igc: fix AF_XDP receive buffer size for 2K UMEM chun=
ks
>=20
> SRRCTL.BSIZEPKT has a granularity of 1 KiB. With a 2 KiB UMEM
> chunk and the default XDP headroom, xsk_pool_get_rx_frame_size()
> returns 1792. Programming this value truncates the hardware receive
> buffer size to 1 KiB, even though an MTU-sized frame fits in the
> usable UMEM area.
>=20
> XDP on igc is limited to MTU 1500, so configure a 2 KiB receive
> buffer for XSK rings. Limit RLPML to the maximum supported Ethernet
> frame size while XDP is attached, regardless of PAGE_SIZE, to avoid
> oversized frames spanning descriptors or exceeding the usable UMEM
> space.
>=20
> RLPML is currently programmed from igc_set_rx_mode(), which can run
> without RTNL, for example on an IPv6 multicast join, and could then
> use a stale XDP state. RLPML does not depend on the address lists.
> Program it from igc_setup_rctl() instead, next to RCTL.LPE, and from
> igc_xdp_set_prog() while the rings are disabled. This avoids
> netif_addr_lock_bh() usage.
>=20
> Validate that the XSK frame size accommodates a maximum-size frame
> with two VLAN tags, FCS and the optional inline RX timestamp. Check
> against the maximum supported XDP MTU, rather than the current MTU,
> which can change after the socket is bound.
>=20
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++++------
>  drivers/net/ethernet/intel/igc/igc_xdp.c  | 11 +++++---
>  3 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/=
intel/igc/igc.h
> index 17f213cc93e4..ad1062f8531a 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -765,6 +765,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw,=
 u32 offset, u16 *data)
>  =09return -EOPNOTSUPP;
>  }
>=20
> +void igc_set_rlpml(struct igc_adapter *adapter);
>  void igc_reinit_locked(struct igc_adapter *);
>  struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
>  =09=09=09=09      u32 location);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..38a5702647f4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter=
 *adapter,
>  =09ring->next_to_clean =3D 0;
>  =09ring->next_to_use =3D 0;
>=20
> +=09/* igc's XDP limits MTU to 1500; all XSK RX buffers can use 2kb;
> +=09 * RLPML limits the receive length to fit after UMEM headroom.
> +=09 */
>  =09if (ring->xsk_pool)
> -=09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +=09=09buf_size =3D IGC_RXBUFFER_2048;
>  =09else if (ring_uses_large_buffer(ring))
>  =09=09buf_size =3D IGC_RXBUFFER_3072;
>  =09else
> @@ -830,6 +833,25 @@ static void igc_setup_mrqc(struct igc_adapter *adapt=
er)
>  =09wr32(IGC_MRQC, mrqc);
>  }
>=20
> +void igc_set_rlpml(struct igc_adapter *adapter)
> +{
> +=09struct igc_hw *hw =3D &adapter->hw;
> +=09u32 rlpml =3D MAX_JUMBO_FRAME_SIZE;
> +
> +#if (PAGE_SIZE < 8192)
> +=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> +=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> +#endif
> +=09/* igc's XDP currently does not support jumbo frames. Limit the
> +=09 * accepted packet size regardless of PAGE_SIZE so it fits in a 2kb
> +=09 * XSK chunk.
> +=09 */
> +=09if (igc_xdp_is_enabled(adapter))
> +=09=09rlpml =3D ETH_FRAME_LEN + VLAN_HLEN * 2 + ETH_FCS_LEN;
> +
> +=09wr32(IGC_RLPML, rlpml);
> +}
> +
>  /**
>   * igc_setup_rctl - configure the receive control registers
>   * @adapter: Board private structure
> @@ -874,6 +896,7 @@ static void igc_setup_rctl(struct igc_adapter *adapte=
r)
>  =09=09=09  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
>  =09}
>=20
> +=09igc_set_rlpml(adapter);
>  =09wr32(IGC_RCTL, rctl);
>  }
>=20
> @@ -4116,7 +4139,7 @@ static void igc_set_rx_mode(struct net_device *netd=
ev)
>  {
>  =09struct igc_adapter *adapter =3D netdev_priv(netdev);
>  =09struct igc_hw *hw =3D &adapter->hw;
> -=09u32 rctl =3D 0, rlpml =3D MAX_JUMBO_FRAME_SIZE;
> +=09u32 rctl =3D 0;
>  =09int count;
>=20
>  =09/* Check for Promiscuous and All Multicast modes */
> @@ -4146,12 +4169,6 @@ static void igc_set_rx_mode(struct net_device *net=
dev)
>  =09/* update state of unicast and multicast */
>  =09rctl |=3D rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
>  =09wr32(IGC_RCTL, rctl);
> -
> -#if (PAGE_SIZE < 8192)
> -=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> -=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> -#endif
> -=09wr32(IGC_RLPML, rlpml);
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ether=
net/intel/igc/igc_xdp.c
> index 9eb47b4beb06..a0f1ecb2ed5f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -34,6 +34,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struc=
t bpf_prog *prog,
>  =09}
>=20
>  =09old_prog =3D xchg(&adapter->xdp_prog, prog);
> +=09if (if_running && need_update)
> +=09=09igc_set_rlpml(adapter);
>  =09if (old_prog)
>  =09=09bpf_prog_put(old_prog);
>=20
> @@ -69,11 +71,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *ad=
apter,
>  =09=09return -EINVAL;
>=20
>  =09frame_size =3D xsk_pool_get_rx_frame_size(pool);
> -=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> +=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2 +
> +=09=09=09 ETH_FCS_LEN + IGC_TS_HDR_LEN) {
>  =09=09/* When XDP is enabled, the driver doesn't support frames that
> -=09=09 * span over multiple buffers. To avoid that, we check if xsk
> -=09=09 * frame size is big enough to fit the max ethernet frame size
> -=09=09 * + vlan double tagging.
> +=09=09 * span multiple buffers. Check the maximum supported MTU, not
> +=09=09 * current MTU, as it may change while the pool is bound. Account
> +=09=09 * for double VLAN tags, FCS and inline RX timestamping.
>  =09=09 */
>  =09=09return -EOPNOTSUPP;
>  =09}
> --
> 2.43.0
>=20
>=20
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/etherne=
t/intel/igc/igc.h
> > index 17f213cc93e4..635d49701e62 100644
> > --- a/drivers/net/ethernet/intel/igc/igc.h
> > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > @@ -198,6 +198,7 @@ struct igc_ring {
> >  =09=09=09struct igc_rx_packet_stats pkt_stats;
> >  =09=09=09struct u64_stats_sync rx_syncp;
> >  =09=09=09struct sk_buff *skb;
> > +=09=09=09bool rx_in_frame;
> >  =09=09};
> >  =09};
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c..9ca5558c762c 100644
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
> > @@ -2111,10 +2113,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_=
buffer *rx_buffer,
> >   * @rx_ring: Rx ring being processed
> >   * @rx_desc: Rx descriptor for current buffer
> >   *
> > - * This function updates next to clean.  If the buffer is an EOP buffe=
r
> > - * this function exits returning false, otherwise it will place the
> > - * sk_buff in the next buffer to be chained and return true indicating
> > - * that this is in fact a non-EOP buffer.
> > + * Advance next to clean and retain frame position for the next descri=
ptor.
> > + * Return true if the consumed descriptor does not end the frame.
> >   */
> >  static bool igc_is_non_eop(struct igc_ring *rx_ring,
> >  =09=09=09   union igc_adv_rx_desc *rx_desc)
> > @@ -2127,10 +2127,8 @@ static bool igc_is_non_eop(struct igc_ring *rx_r=
ing,
> >
> >  =09prefetch(IGC_RX_DESC(rx_ring, ntc));
> >
> > -=09if (likely(igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)))
> > -=09=09return false;
> > -
> > -=09return true;
> > +=09rx_ring->rx_in_frame =3D !igc_test_staterr(rx_desc, IGC_RXD_STAT_EO=
P);
> > +=09return unlikely(rx_ring->rx_in_frame);
> >  }
> >
> >  /**
> > @@ -2601,7 +2599,7 @@ static void igc_update_rx_stats(struct igc_q_vect=
or *q_vector,
> >
> >  static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int b=
udget)
> >  {
> > -=09unsigned int total_bytes =3D 0, total_packets =3D 0;
> > +=09unsigned int total_bytes =3D 0, total_packets =3D 0, work_done =3D =
0;
> >  =09struct igc_adapter *adapter =3D q_vector->adapter;
> >  =09struct igc_ring *rx_ring =3D q_vector->rx.ring;
> >  =09struct sk_buff *skb =3D rx_ring->skb;
> > @@ -2609,13 +2607,15 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> >  =09int xdp_status =3D 0, rx_buffer_pgcnt;
> >  =09int xdp_res =3D 0;
> >
> > -=09while (likely(total_packets < budget)) {
> > +=09while (likely(work_done < budget)) {
> >  =09=09struct igc_xdp_buff ctx =3D { .rx_ts =3D NULL };
> > +=09=09bool first =3D !rx_ring->rx_in_frame;
> >  =09=09struct igc_rx_buffer *rx_buffer;
> >  =09=09union igc_adv_rx_desc *rx_desc;
> >  =09=09unsigned int size, truesize;
> >  =09=09int pkt_offset =3D 0;
> >  =09=09void *pktbuf;
> > +=09=09bool tsip;
> >
> >  =09=09/* return some buffers to hardware, one at a time is too slow */
> >  =09=09if (cleaned_count >=3D IGC_RX_BUFFER_WRITE) {
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
> >
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
> >
> > @@ -2664,6 +2677,12 @@ static int igc_clean_rx_irq(struct igc_q_vector =
*q_vector, const int budget)
> >  =09=09=09xdp_res =3D igc_xdp_run_prog(adapter, &ctx.xdp);
> >  =09=09}
> >
> > +=09=09if (xdp_res) {
> > +=09=09=09total_bytes +=3D size;
> > +=09=09=09total_packets++;
> > +=09=09}
> > +
> > +xdp_done:
> >  =09=09if (xdp_res) {
> >  =09=09=09switch (xdp_res) {
> >  =09=09=09case IGC_XDP_CONSUMED:
> > @@ -2676,8 +2695,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09=09=09=09break;
> >  =09=09=09}
> >
> > -=09=09=09total_packets++;
> > -=09=09=09total_bytes +=3D size;
> > +=09=09=09work_done++;
> >  =09=09} else if (skb)
> >  =09=09=09igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
> >  =09=09else if (ring_uses_build_skb(rx_ring))
> > @@ -2700,8 +2718,15 @@ static int igc_clean_rx_irq(struct igc_q_vector =
*q_vector, const int budget)
> >  =09=09if (igc_is_non_eop(rx_ring, rx_desc))
> >  =09=09=09continue;
> >
> > +=09=09if (xdp_res) {
> > +=09=09=09skb =3D NULL;
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09work_done++;
> > +
> >  =09=09/* verify the packet layout is correct */
> > -=09=09if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> > +=09=09if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> >  =09=09=09skb =3D NULL;
> >  =09=09=09continue;
> >  =09=09}
> > @@ -2717,7 +2742,6 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09=09/* reset skb pointer */
> >  =09=09skb =3D NULL;
> >
> > -=09=09/* update budget accounting */
> >  =09=09total_packets++;
> >  =09}
> >
> > @@ -2732,7 +2756,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09if (cleaned_count)
> >  =09=09igc_alloc_rx_buffers(rx_ring, cleaned_count);
> >
> > -=09return total_packets;
> > +=09return work_done;
> >  }
> >
> >  static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> > @@ -2797,10 +2821,10 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx=
(struct xdp_buff *xdp)
> >
> >  static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const in=
t budget)
> >  {
> > +=09int total_bytes =3D 0, total_packets =3D 0, work_done =3D 0;
> >  =09struct igc_adapter *adapter =3D q_vector->adapter;
> >  =09struct igc_ring *ring =3D q_vector->rx.ring;
> >  =09u16 cleaned_count =3D igc_desc_unused(ring);
> > -=09int total_bytes =3D 0, total_packets =3D 0;
> >  =09u16 ntc =3D ring->next_to_clean;
> >  =09struct bpf_prog *prog;
> >  =09bool failure =3D false;
> > @@ -2810,11 +2834,13 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >
> >  =09prog =3D READ_ONCE(adapter->xdp_prog);
> >
> > -=09while (likely(total_packets < budget)) {
> > +=09while (likely(work_done < budget)) {
> > +=09=09bool first =3D !ring->rx_in_frame;
> >  =09=09union igc_adv_rx_desc *desc;
> >  =09=09struct igc_rx_buffer *bi;
> >  =09=09struct igc_xdp_buff *ctx;
> >  =09=09unsigned int size;
> > +=09=09bool eop, tsip;
> >  =09=09int res;
> >
> >  =09=09desc =3D IGC_RX_DESC(ring, ntc);
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
> > @@ -2851,6 +2886,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vect=
or *q_vector, const int budget)
> >  =09=09xsk_buff_dma_sync_for_cpu(bi->xdp);
> >
> >  =09=09res =3D __igc_xdp_run_prog(adapter, prog, bi->xdp);
> > +=09=09total_bytes +=3D size;
> > +=09=09total_packets++;
> > +
> > +xdp_done:
> >  =09=09switch (res) {
> >  =09=09case IGC_XDP_PASS:
> >  =09=09=09igc_dispatch_skb_zc(q_vector, desc, ctx);
> > @@ -2865,8 +2904,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vecto=
r *q_vector, const int budget)
> >  =09=09}
> >
> >  =09=09bi->xdp =3D NULL;
> > -=09=09total_bytes +=3D size;
> > -=09=09total_packets++;
> > +=09=09ring->rx_in_frame =3D !eop;
> > +=09=09work_done++;
> >  =09=09cleaned_count++;
> >  =09=09ntc++;
> >  =09=09if (ntc =3D=3D ring->count)
> > @@ -2889,10 +2928,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >  =09=09=09xsk_set_rx_need_wakeup(ring->xsk_pool);
> >  =09=09else
> >  =09=09=09xsk_clear_rx_need_wakeup(ring->xsk_pool);
> > -=09=09return total_packets;
> > +=09=09return work_done;
> >  =09}
> >
> > -=09return failure ? budget : total_packets;
> > +=09return failure ? budget : work_done;
> >  }
> >
> >  static void igc_update_tx_stats(struct igc_q_vector *q_vector,
> >
>=20

Looks good to me, passes basic testing, and I would rather you/intel do thi=
s patch

For posterity, I did email Tony with handoff notes stating I'd rather not d=
o the=20
xdp/xsk/af_xdp/fpe side of things, but hadn't heard back so I kept going. 
