Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BD3D566E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879442; cv=none; b=eeOSHgar4BLE60pFR+I7nFj9wXjSfL74NHBSzc8KpwRnWjTXO0ugUhFcsqpBwBnDOw8BND347BpbUvvspHyELMK6hQ0/KlOAMCVbVKdH3SVZNe7mCEogbP7a02WhX+6ScT+2zVlANZa/8Nc0sTJs6011EhB40iE6yq+f5ceFHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879442; c=relaxed/simple;
	bh=Td6UJVofWCDnQamk5CY5XGtu81PPv/v89CyEdQyhisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSnN9vYXzZGApMjGQamHPre0/cXgtUueKl/L+ZUM6lkmxTWdI5vDZn4L8VjsGdS/3YF9Zlhlg3I4hx1edYV8h3Ihb+66hiucQiJqYVPU85ar0tjx3RKG4qGjSnZLMM1TUVnBP314R7SWWhpBoQ8llhOzVl9YRP1SLHp65Mp+KaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFx4T6s+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJXc2rqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFx4T6s+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJXc2rqg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21Jbr4072150
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RDFKYb/m924u2VXBFcjCVaMk
	oZJEVndeSzqMZ0nALvQ=; b=TFx4T6s+vG6c2WLyALwPHKSqjTDtCN7fxBIwwo1J
	dU7J6toDY3QwVuwovF2S2kEb/grSQqpfCVP88Pj9VauALz8f5p1qZ9Bxp5osc2ph
	vVnfrKQb6faASfxul4QO1ApJ2kwEWaOGhETfWu2apCrsqyf3TObZqHgWPEOgQLhh
	Jpnfz0jCHN0kyEdJ1+M5FtNGd0ocJ05actKCyR08YPiN3TVfLRzIwpIZ6lq7Eu3K
	/BUuuasFa7IVJtOsSdtNiVQdtMTFTakXpwk2ovJmmd944coP1P693ovg32b8VC40
	5fKQICLfMUU7TMz2R+ZuGa4oQ6HVnMc2/r9FEOVCcyZX1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjug2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:17:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939c30aa9a0so249151785a.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791879436; x=1792484236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDFKYb/m924u2VXBFcjCVaMkoZJEVndeSzqMZ0nALvQ=;
        b=aJXc2rqgZAtWYGJXCckGoC9VBYKZE3uyMfdRO5vpZ6eo89vJkP/wuXjYAYWyxwHCZ+
         MzwnxFZ15kIkzjU/o1+wxv/iVnN3iqjq7Nve8pexfM0ud5fyeRexkSCzYYSozKLY8j8j
         YE9DNCLBYNUuVnftaob4l4FPNlMcmaC4Cwhm7pQGohdiwY1JIseZ3tnauz7aDvEI48bG
         x1QLovel1n84yQ88SudTCRt3crKzf1jp0Zl2gqQaJ0egmK5vTSx/ErjvM8+jyRgnp5mB
         jFSohFks0ziYhzpMlRKMgYwNU5RykcobGCsLo21V4A2cIJ0awYSH8QfqCELCTOLCglIt
         onwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879436; x=1792484236;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDFKYb/m924u2VXBFcjCVaMkoZJEVndeSzqMZ0nALvQ=;
        b=lglG7CYyRFwUH8slt1F/3JqPf0/DMO4Rrr4IG/ntSPmzHlRYRCV9WbCLE3TO0wAtV3
         B+mmD4k7Sa4lXhwsj8XYQ/2c60+7tAMQ/0cc92EgQgSs7Yv7QsT1/qL6xUAzerw4lAAB
         RKqD5ofVbBmn01yH9t3SMsQh0UcfXJjASxbrKgiblJ/+3cxq6OIT1ic5r19xqOnTquQ/
         vjUPyty8p7YI5Bay6XNDHuMl4VNQiB8FVU84v6WUG8wCJ1wxTwwUh5VTabm/9aCiyNYO
         OyPvQJpDfr3QsRBxBcE2PSjzvvRFMqXzebKbep52rC5gVOtTDnwmU+fNvDJdv/TKcAyB
         xanw==
X-Forwarded-Encrypted: i=1; AKwUvByWD/tlChSj6SltQ2HiE1jUTI+Sag3PlOOtr5g+3oNHRuV+A7JEhEwjPjSoKpSnoVhdgS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2nUIU9l3nY6F2Y4L7MojYOHT5jRHFweriqsllNkIWW1GHwWXo
	POYFTlinYMCAmBFCpDM1BbGgBz+02mUj30HS7LNtaXTGnUEKacVDrNJ1YOqvRIHaWexyP0MDqE9
	zXTpY7aaNZv//4ljrNJAnmCj2daR7PNK53bKR4tK7JFg6FlDgXp1AE7M=
X-Gm-Gg: AYBFou2FXiMHS0olmCiiK1rvObCr4omzHA8RpFbokr87YfwptpHvpi3k8+V/tWVxu4c
	o2tqiWkr81D1i9tbHZQvQ43OicIBLPlocJqhXgPRwJUBKt5wN653E1bZia0SGEUSrA8Kv550Uiz
	7YNhSlbK9MQUvPdumxOwnWwKqIyH67Y4v+zjNxKhBk4HXDIVFUdoslJ7rnoKgfBUmTcDWq5VFT8
	wOKNcnnQW3LuG8APNTuVheyoY3x9DvE3pai45UJY3YoASiSSNp5QxO+GGZ9mKkzPGj170UHpAqc
	cgILdggwLDjMq6wnaJy2zrYvjVar+nK2Y2hVGsjeO2AdT695XnAne/48nlxwANGdYUHY9rXca7W
	HGgPJ3rrvyd0Sog==
X-Received: by 2002:a05:620a:199e:b0:93c:5872:ef48 with SMTP id af79cd13be357-93ebd273616mr1824175185a.50.1791879435923;
        Tue, 13 Oct 2026 01:17:15 -0700 (PDT)
X-Received: by 2002:a05:620a:199e:b0:93c:5872:ef48 with SMTP id af79cd13be357-93ebd273616mr1824171385a.50.1791879435209;
        Tue, 13 Oct 2026 01:17:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dcd7dd3sm221979045e9.2.2026.10.13.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:17:13 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:17:11 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
Message-ID: <as3pB16af0_QhNyB@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
 <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KY7hfcVLGCw62j4b"
Content-Disposition: inline
In-Reply-To: <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
X-Proofpoint-GUID: 3er6UijPkER2n3LSVlFjPH2kEXj1ZcLr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfXzDt/OVjBu+zi
 2TqEjN5VH5jSHgUTIYyQ2X/NsYY7J3C9VjbOGcxCUmJIo1SuBCeuPqsYmOWonPTAvmNWWHyKGPI
 4GF4ehFohySSOtk46hNer1txJ5Aubjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfX7ze1A9dUPobP
 SPSbUsGCHKkCKexW0JFplz/asSx0wi+y7ZxO6AArJnJEcvjAdPCGJoE7nFpYqkZzC58wexTYC0v
 TZguCirZFU2bBTvFelVGiLITKj+/1kB4ih/OnMVOcgiZt0B28Z7nyBEfuzxLiLRklLn6iIr0Ceh
 tEmRO2M2aFElLuv5LKE/lFLMkyNUcAryl6TzsF13yg8z0JQOSun4cPBRBwgPGOhP2KSJyw7iwIw
 Snz3LT21MJfQROl2muEVcbq8x37+v4AJwbYOnM/j8dFO/FiVkvAIVamvmGVEBIF6JhUh7islYf2
 Wn6tS935Pmv7wSEr6wis1UVTcgZV+koCCzsefdc6GpD/oXL16UvZk0w/M2D68ls/5ba5uo2Tqwa
 aKWMlkZv/vSd9tlwoo7nn9yqTva/Pjsg9T0cqxxNFTcOn2i4y4ZHwQLk4C0yqNlJuKTEDIH3DpI
 EmEOoUSbYWxFOAxEheQ==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acde90f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=7PNn2skMB5_rZfgV75sA:9 a=CjuIK1q_8ugA:10 a=nfflnHfShdqUK23c0sYA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3er6UijPkER2n3LSVlFjPH2kEXj1ZcLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130032

--KY7hfcVLGCw62j4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 12, Nicolai Buchwitz wrote:
> Hi Lorenzo
>=20
> On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> > stmmac_rx() runs the XDP program once per descriptor buffer and uses
> > skb =3D=3D NULL as the only marker for the start of a frame. A frame la=
rger
> > than one buffer is split by the hardware across several descriptors;
> > GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
> > GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
> > the interface MTU is left at 1500.
> >=20
> > When an XDP verdict ends a non-last descriptor, skb is cleared and the
> > next descriptor of the same hardware frame is parsed as a new frame.
> > For XDP_CONSUMED this happens via read_again with len preserved, so
> > stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
> > last descriptor, which can be as small as 0-3 bytes. buf1_len -=3D
> > ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
> > data; on XDP_PASS this produces an skb whose length is close to 4G that
> > reaches the network stack (skb->tail and skb->len are 32-bit and wrap
> > below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
> > instead offered to the XDP program and delivered as a standalone
> > mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
> > falls through to the next iteration, resetting the running length, so
> > the tail is re-parsed as a full-size new frame.
> >=20
> > XDP does not support scatter-gather frames until the multi-buffer
> > rework, so drop the whole frame instead: mark it as errored as soon as
> > a non-last descriptor is seen while an XDP program is attached, drain
> > and release every descriptor - including the last - and account the
> > frame once in rx_dropped. Removing the re-parse lets both XDP verdict
> > branches simply complete the packet via next.
> >=20
> > Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
> > multi-buff" accumulates the whole frame into a single xdp_buff and
> > supersedes this patch; the fix is kept so the net portion of the series
> > stands on its own.
> >=20
> > Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28
> > ++++++++++-------------
> >  1 file changed, 12 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 426bb68c9bbc..8c08d44fdbd3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv,
> > int limit, u32 queue)
> >=20
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx +
> > entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> > -			buf->page =3D NULL;
> > +
> > +		if (unlikely(!error && status =3D=3D discard_frame)) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
> >=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
>=20
> AFAIU GMAC4 and XGMAC always use the second buffer of a descriptor. If
> so, at MTU 1500 a frame of up to 3072 bytes can fit in one descriptor,
> and this check would not catch it?
>=20
> The XDP program would then only see the first buffer. With XDP_TX the
> frame is cut and sent too short. With XDP_PASS the second buffer is added
> after the program already decided.
>=20
> Patch 4 fixes this. But if this patch should work on its own, should it
> also drop the frame when buf2_len is not zero? Or am I missing
> something?

Hi Nicolai,

IIUC your comment we are missing the case where we have a single descriptor
(rx_not_ls is not set in status) but the packet is splitted over buf1 and b=
uf2,
right? Something like:

	...
	buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
	len +=3D buf2_len;

	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
		rx_dropped++;
		dev_kfree_skb(skb);
		goto next;
	}
	...

Is my understanding correct?

Regards,
Lorenzo

>=20
> > [...]
>=20
> Thanks,
> Nicolai

--KY7hfcVLGCw62j4b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas3pBwAKCRA6cBh0uS2t
rKv6APsHFZSMX2dOAS1p36e6ZsqIAiOI0NDwoK6myQr0w44IyQEAuyVt58Q+sb1x
hWYvoUu5yllNvcDzIt78fFC420vYdAw=
=jWne
-----END PGP SIGNATURE-----

--KY7hfcVLGCw62j4b--
