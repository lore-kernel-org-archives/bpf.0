Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378869;
	b=OPNWCKoq4D+5AJkMrnfDekg4m/pyFxjofsVwbvecKQhnabWwUV4ZPFR9fgY3lMFQk7Gc
	 iGoQJgSx3X/hAUkH6vSHBY+lx5W82+BYiiAob3yq4ApwaMt/q9byH1HkVgkFopWXlyXTj
	 bJbAmOIUfDCWkTBhkElx3gKkTLhNBj44FWe+yatY0oPOTwxRMEaOn8va0C4M7W3/zMJhS
	 2USUBBS/alMPjMZqlIAeSMeSvlpAGbjFpkK+kbnLKTSzeB7Ao0v7BHkNZF4PcAXQYyJvp
	 RdLqZNFTyKZFZW0ySBPQZwCY0GEHwwEmP9ZG0hV695vyU2AwD7nNLqQV6vazla9+5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378869;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=PQ4G7FWKXf3yOQR/cwzdiaA0meyXV45WbDf7zl6Ty7Y=;
	b=C7Ubog2tcfVXlGtEOlBH/0Ts3/nN0NzGUlHGY/zurh4m5CsbJaNhxNMz5mwz+WAB+OX6
	 SEqmxGrNY3CsMVZBYraPcRZWkjdCCoAwCV1vCRFklBgS3XiNhkijV6OdpttfGMvy1iUzN
	 r7diR7IJ6wv0YHGr2KoKKOi8y0uZRoOLXKIeHfdA/DMsHOM1KIShOOvEY73rAVQc0Z2Fq
	 KG7U4HulRIkslHlMqR+zqz6Dp2xi2XJi/W9SUCb6zfuU8Te6/b8rXL8U/0WcoJSBdrqsU
	 fetWVV6BT4VQbEjvP/XaxRpCV5PLMP//D3klZxgEs51bTABz63xmlivZzaCr2/umcAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="FVn/2D+f";
	arc=none smtp.remote-ip=79.135.106.105
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A6606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 16:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=FVn/2D+f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793378865; x=1793638065;
	bh=PQ4G7FWKXf3yOQR/cwzdiaA0meyXV45WbDf7zl6Ty7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FVn/2D+flZn6H8vP2GLlWJUdJLMxbEZltl2dwzm79NEaRK/Z8naG14DvxyU87xkwk
	 wJO5ki6kmYY5rUMMh3rZcD9lXOQ6Eywmf3ICN9PhejJ6h0yjmtQZ0am8E6+jtSZF+N
	 ALA6WuLnApuJghH8566r/GXuGLyN66TtU75wZKR+/9AHzEda5jNO85vpBRxQ0OEjHa
	 c8dYnXKlVocWkNRmD2v1i386uaAVdDfFukRaqgMxIE9hz0Hccsq/FL66gTMUZhZDQL
	 hxiuA1cIhwUm/R7BUPmewtmLU6RtBFQTwxLKFBVUhKxWZZpda5w1hbOn54MWJi9bUx
	 knwa1R4xP7qpQ==
Date: Fri, 30 Oct 2026 16:47:36 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: netdev-bot+sashiko@kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, andre.guedes@intel.com, aleksandr.loktionov@intel.com, avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] igc: only strip RX timestamp header from first buffer
Message-ID: <K-58hRuSyY_aSjvzkpmwBMeDzvfjQyLMRjMsDlEL1M60FHZJTS1WXTaTrh79pf1igf7bt5MCaORbxYVJJliJ0FhGCzjtiEVvagd50w65Ssg=@1g4.org>
In-Reply-To: <auSDQtz8l8hzzr86@boxer>
References: <20261028083344.3047350-2-p@1g4.org> <179331704005.3134.12545545223659652020@kernel.org> <auSDQtz8l8hzzr86@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4c2a5fe1fa4764ac796a6e023df421e8b58cd007
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





On Friday, October 30th, 2026 at 6:45 AM, Maciej Fijalkowski <maciej.fijalk=
owski@intel.com> wrote:

> On Thu, Oct 29, 2026 at 11:37:20PM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] At this commit by itself, the new first-buffer test `!skb &&
> >   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)` in igc_clean_rx_irq(=
)=E2=80=A6
> >
> > --
> >
> > igc: only strip RX timestamp header from first buffer
> >
> > igc_clean_rx_irq() used to subtract IGC_TS_HDR_LEN from every descripto=
r
> > with TSIP set, which truncated multi-buffer packets. With this patch th=
e
> > timestamp header is only stripped when skb is NULL, which the commit tr=
eats
> > as marking the first buffer of a new packet.
> >
> > Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08=
dca@aweta.nl/
> >
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/=
ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> > >
> > >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_off=
set;
> > >
> > > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > +=09=09if (!skb &&
> > > +=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > >  =09=09=09ctx.rx_ts =3D pktbuf;
> > >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> > >  =09=09=09size -=3D IGC_TS_HDR_LEN;
> >
> > [Severity: High]
> >
> > Is skb =3D=3D NULL a reliable first-buffer marker when an XDP program i=
s
> > attached? The commit message says:
> >
> >     Only consume the timestamp header when skb is NULL, which identifie=
s the
> >     first buffer of a new packet.
> >
> > Suppose igc_xdp_run_prog() returns IGC_XDP_CONSUMED, IGC_XDP_TX or
> > IGC_XDP_REDIRECT for the first, non-EOP buffer of a multi-descriptor fr=
ame.
> > Then no skb is built, and igc_clean_rx_irq() moves on to the continuati=
on
> > descriptor with skb still NULL:
> >
> > =09=09/* fetch next buffer in frame if non-eop */
> > =09=09if (igc_is_non_eop(rx_ring, rx_desc))
> > =09=09=09continue;
> >
> > The continuation descriptor still has TSIP set, so this check strips
> > IGC_TS_HDR_LEN a second time. If that descriptor holds fewer than 16 by=
tes,
> > can the unsigned size wrap here?
> >
> > The continuation buffer then goes through the new-frame path:
> >
> > =09=09if (!skb) {
> > =09=09=09xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
> > =09=09=09xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
> > =09=09=09=09=09 igc_rx_offset(rx_ring) + pkt_offset,
> > =09=09=09=09=09 size, true);
> >
> > In that case the XDP program would see a data_end about 4 GiB past data=
.
> > On XDP_PASS, the same size would reach igc_build_skb() or
> > igc_construct_skb(), and the __skb_put() there does not check it.
> >
> > At this commit, XDP with multi-descriptor frames looks possible on kern=
els
> > with PAGE_SIZE >=3D 8192. igc_set_rx_mode() only clamps RLPML under the
> > small-page #if:
> >
> > #if (PAGE_SIZE < 8192)
> > =09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> > =09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> > #endif
> > =09wr32(IGC_RLPML, rlpml);
> >
> > On large-page kernels, RLPML therefore stays at MAX_JUMBO_FRAME_SIZE wh=
ile
> > igc_rx_bufsz() returns IGC_RXBUFFER_2048. igc_xdp_set_prog() only check=
s
> > dev->mtu > ETH_DATA_LEN, not the hardware receive length limit.
> >
> > This needs RX hardware timestamping enabled, an XDP program that return=
s a
> > non-PASS verdict for a first buffer, and a peer that sends frames large=
r
> > than about 2032 bytes.
> >
> > The next patch in this series, "igc: fix AF_XDP receive buffer size for=
 2K
> > UMEM chunks", adds igc_set_rlpml(). It caps RLPML at 1526 bytes wheneve=
r
> > XDP is enabled, whatever PAGE_SIZE is. It is called from igc_setup_rctl=
()
> > and igc_xdp_set_prog(). With that change, XDP frames always fit in a si=
ngle
> > descriptor, and skb =3D=3D NULL becomes a correct first-buffer marker.
>=20
> Wow - finally.
>=20
> >
> > This patch is tagged Cc: stable and could be backported on its own. Sho=
uld
> > it depend on that follow-up change, or should the two patches be swappe=
d in
> > the series?
>=20
> How would we make sure both commits from this set get actually backported
> together?
>=20
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261028083344.3047350-1-p%401g4.org
>=20

I did forget to tag yours for stable, so maybe the will satisfy it?

I think ultimately, it sees all related bugs as one big problem in
an effort to catch adjacent. My understanding has been that unless
there's true interdependence of patches, ie. kernel will be left broken
unless taken together, a series in itself adequately satisfies this require=
ment.

Should I do a v4 to add the tag? Or can this be rectified through=20
intel's process?

Paul
