Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118788;
	b=W7w3pz71eQmNiK/JHjGwijxlN/Vxs2poUeAg+6t82ejb9ioYK2NuMi8buJFOCJye585y
	 t52MZUCVKdTfT/9wWTshPPPWARMgROYKXyc/oy3OhmGgrZ/DKoK+x7OsP7AveBT/3bpqi
	 PuM99A9XPALPUC3NE7OTG/SP4EEbolVfJLHjiL6Rkewwod8CfsGgwyKE8tzhLg+NJ4kvh
	 imXT2VWx4PgG0/yn5w2WalOv6rJPs419+KZnodjm0BcN0K/Z+wQ0iPXYH0yFHZDIAhBX4
	 gxrT+CxHuv7vw9RXM2+qiqkK4Qr+NRZvjfrWsBdcpD4WofWanrbHlZH9QyZSQGFt/3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118788;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	b=bW6PhiNXGwtjK2ha10CFqmwBhKl0dvwyqL4IKG4GeHx1cknP5/shMFleP1v+OlTdn3hw
	 yV3JPnbIowUkmjs5UpuNlqqF1WdC/IyXZ/LksMDnNkA3MYmtelUdDhDblDAemWuNYNTaC
	 Zs3Z87IAjqL6lB1s+oPhLq5PadcpXLzJlmqH834zFaNZ+755cVPFgLRqExFGT+rZdSno4
	 5vgLBUEnivY+kh5j7lT1r4G9uZn8sHz2cbT7Ax2oXoxw3+ByiakloZekJ9dKTkmr9UHt7
	 l1djNc40cgm4JHj3g2ElMOq0Ap37OB6PJdtiuzZGNKn71PP6CpfVFnseAVM5nQNbynw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=obR0omlz;
	arc=none smtp.remote-ip=185.70.43.99
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77682606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77682606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=obR0omlz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793118785; x=1793377985;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=obR0omlz+RH9skUK/AijjQJ0MbxcBbLaq7bLBd+ZpUKNrs6DZIiO03GL5wtCPo4tU
	 oxLSsRs6PHG8SP/+utakZfh3tB6mub8qUPGxwgV/IpqiRTGtsAFyWH/w6biugAASJL
	 3oRf38MGoR6/+0DToGYWTq/JQckkQg99rkiqXbE+knIq5yKQxZmsMrcJ/PtYNi4whL
	 mGSW+uToCK9TQO0TECEevVoO/rADbQ1Qm7wx4E7bXCKHanRLimHQngryr1pCy5hU5Z
	 FS+z6Av0bvsU+H9mKg4N9ixa/kk3bNu4VLmVofYZWHIBWPZTiGMul+YrhgIkRBEgGD
	 idF/xJ5XQGSQQ==
Date: Tue, 27 Oct 2026 16:32:59 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <R7FJ9H2Yqq7aJ5dcgVzcIZN-iI5qNsSVTCHlGTVoz9-HMbzAcMqJ6qCtNLlpjc6DATjNq67fgeC6paxLm4r5hBf4s85vmMOlLqB8MbAFTr0=@1g4.org>
In-Reply-To: <auBehtniOJTRGfaD@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer> <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org> <auBehtniOJTRGfaD@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 31b7716a514270b0b4fbc73d35c670e646ea2b41
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





On Tuesday, October 27th, 2026 at 3:19 AM, Maciej Fijalkowski <maciej.fijal=
kowski@intel.com> wrote:

> On Mon, Oct 26, 2026 at 10:18:03PM +0000, Paul Moses wrote:
> > On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fi=
jalkowski@intel.com> wrote:
> >
> > > On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > > > Converting an XSK buffer to an XDP frame allocates a page and retur=
ns
> > > > the original buffer to its pool. If the TX ring is full or DMA mapp=
ing
> > > > fails, igc_xdp_xmit_back() returns an error without freeing the cop=
y.
> > > > The RX cleaner cannot release it, so the page leaks.
> > > >
> > > > Return the copied frame on TX failure. Save the RX memory type befo=
re
> > > > conversion so native frames remain RX-owned on failure.
> > > >
> > > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses <p@1g4.org>
> > > > ---
> > > > Tested on Intel I225-V with baseline and patched kernels. Physical
> > > > pause-frame backpressure caused 46 leaked copies on the baseline.
> > > > With the fix, all 72 rejected copies were returned once and freed,
> > > > and all 192 copies were accounted for.
> > > >
> > > >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/ne=
t/ethernet/intel/igc/igc_main.c
> > > > index 1fb5f3cbe93c..39263fd04aa9 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_a=
dapter *adapter, int cpu)
> > > >
> > > >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct x=
dp_buff *xdp)
> > > >  {
> > > > +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> > >
> > > small nit is we require a concept called RCT (reverse christmas tree)
> > > which makes you to order variable declarations from longest line to
> > > shortest.
> > >
> > > >  =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> > > >  =09int cpu =3D smp_processor_id();
> > > >  =09struct netdev_queue *nq;
> > > > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adap=
ter *adapter, struct xdp_buff *xdp)
> > > >  =09txq_trans_cond_update(nq);
> > > >  =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
> > > >  =09__netif_tx_unlock(nq);
> > > > +
> > > > +=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
> > > > +=09=09xdp_return_frame(xdpf);
> > >
> > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >
> > > > +
> > > >  =09return res;
> > > >  }
> > > >
> > > > --
> > > > 2.56.GIT
> > > >
> > > >
> > > >
> > >
> >
> > Never know what to do in these cases, order matters here, so
> > do I touch more lines to move the assignment down below?
>=20
> =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> =09int cpu =3D smp_processor_id();
> =09struct netdev_queue *nq;
>=20
> this would satisfy the RCT rule.
>=20

Ok I'll send soon.
