Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B53B9933
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838044; cv=none; b=jXsfRL796/Xhh3WM27QybnUCcGwkPt+7M9y8Sls4RsRpFCU1raVb/A+E5E7zX+foa49HJ+mVj07VzIONSbcCNDBTT9B45yL3q/Yh2aOS05jTHgmLyXTEzkJ2p3QDXHh++7WkbigLuzwGkE0hEA+WRmOtuFKS08oHucGjoJSKKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838044; c=relaxed/simple;
	bh=q6Q4p9L2p5sbRwQUJO3Ou0yNu2TiX+tOHHXXPtjGu9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEer1RjCSOXrmQVELoVv/OuwKzIo+upX/o1QHwyCLCpW93DnL8NiA1QQ5L8V+WYv1KBiosDjuuKT6MMswvy0YBuEycLjJKb+3zz5WtR/mCvwOVObA+k4UHtgOVg0fHHrxXshuiRXG32V2L36DxyA4IEu4Wga0dNVq4MRRrqL4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EX45kSNR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h25My5Ra; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EX45kSNR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h25My5Ra"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJN00C2384357
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9ui4j5yz4g/dtRXMgKLud1I1
	DvziHiRoVyUoK39Y/Zc=; b=EX45kSNRSaYQtkyMnaXXe8ey+pfV9qDzQ+gww7g1
	zxp7/sIks3/O1C3cWygmAWJ+ZqJY+JgsZlqWfU7oWk+CduN6mh5jCEljRfbzcLNn
	9hZ5IdEqu2YuJe0BhaX6aKExUoC9d4+ACYNVIS5twZ3mhPuKu3iLUOrFOq3iwguq
	SsdIvgqGxW6ynwnkKMZ7ouGtD5t3jlzwFoPO5xEA4m8xVoqhOrJ3UE67M5c3w/Nn
	hqXsaac86FlJtzA7qYBfmbsfk5OS4o8eYU8y39ldiQKNJfJ4hfHTKcD9PgIn8fkr
	d3a8ak/QL10bcjayLiaXXXlU2S1nz/Mdgbk2aGZgxjJBVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ku4qx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:47:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dea1b6c89so448796085a.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791838041; x=1792442841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ui4j5yz4g/dtRXMgKLud1I1DvziHiRoVyUoK39Y/Zc=;
        b=h25My5Ra3R2CWGiJvIjDARZlX75T7do/q1b0oBKx4HsHGQyFtSeYe2Y2IBiYmXpMAf
         Pz+hdfJ1MjriT97f891NlUY+ZAKlyeg//FCbGMNjhOikCSZvLo+6+UquLD47h/E1a614
         IXOE7AGJEHe4fgF54+i1mdKsdC/SdrblKFFu5FUNTS5Nz7sHI2rHViZZeOcaVNVOSTww
         VF3BAAdsY2izHFq+WwleXcL6eupAM3BW3ImcUTYsmZ5+NM6YRh132oyR/4kIDLqc4su8
         xHkoxw1xDpXmDLZHdM+K5yB061Bf7KipiP2xNxIWe1qq48qy8JR6Jo3jSW41TyKtP+cg
         /ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838041; x=1792442841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ui4j5yz4g/dtRXMgKLud1I1DvziHiRoVyUoK39Y/Zc=;
        b=N15vMZZ3j7/Sj0BCviL6+AIsKmKHQgGZNeHqSEGYkN/EEWzUpSS95WsnzNr8SkeDyo
         i+Bycot/1tBYYDLlk2rlYpDHeQ3+7KfbLF7ENvL3czOTE5TqslYH53fZ6Ajei2Fd74qO
         ns7Z0T/Lt8mkGiVnMgVARk0KTky9tY/foScfk/GnXL0c2Gj2ZsC3pt7F3La7tor2zrPx
         8UQJAZQs/1BKyBWlwpAOB3J5EG0u5L2nmCO8BDTn789qpW8bJaGkjDUuXW+RXRoSYg4E
         7vaDrPXQpSPk6wIXdz+rXVy2it4xagkm++xs3aItxn48XUBl8VfSe1RXufbAId9Ab6Gj
         b7MQ==
X-Forwarded-Encrypted: i=1; AKwUvByR30bs5BZo3mtCHF59N85oLs/2DH+EohVdhCvluJm31PevpNCDkgBngIAEeh1lgDUwrlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgifjRfwR+kdU2ewxJ2nIJ+1oL8gNDA/YUpBXZpXUGj9N864HD
	73rdW/iU0CDbgzJmCkuWaZ6n2Nws7S2OodtL6Oepnq6mQ9Gt5kj8Wp5D0hOzVjXqJZVWb0nvfbE
	2n1CCRS9g7iz4HC+AONL+qhJKmgYf7CATd/C0K9NREGjPdnqyZoZQKLA=
X-Gm-Gg: AYBFou0D8HDB4u0hUGGv44wgLVedKmWptG/m/dGHNldt2ohPC+P+BqNylDPx9eBTevn
	ZdVAAwTDDM6IGfqT5V/Jo7AB5YaA3LuGoWyGoXTPjmpd3GilyttTrp7YSfc9hkaSDtfPrWkhJgA
	3bSglsvZ1vQvO+EjmP2KFUHwz4gWZq9WF1SB3oNpjpV5ENDXFfcGNLn6TdWCjNmrIa5Gcgy7LSx
	4gaLo/pkTpTh5gbFE4kkKXOKnmkoP9ZLa+y675t0DRg4daTXxC0uSy2fpGvR6AFC60WJS+17V6Q
	xsDBjc6BWqQ+E89H4Zc+3Sc3t0s05uYGrn4A5/G1KyrbsmGdyCzv0T8iy+t68UxUNFKIag4yGQz
	gMYRg3E4roXc1RQ==
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id af79cd13be357-93ebd26b606mr1757756085a.58.1791838040348;
        Mon, 12 Oct 2026 13:47:20 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id af79cd13be357-93ebd26b606mr1757752685a.58.1791838039787;
        Mon, 12 Oct 2026 13:47:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm1192371f8f.51.2026.10.12.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:47:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:47:17 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Daniel Machon <daniel.machon@microchip.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
Message-ID: <as1HVdDa4yN4yp11@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
 <20261012194317.o642ym7ddsmny25x@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OnyHBvnZ49WjZumz"
Content-Disposition: inline
In-Reply-To: <20261012194317.o642ym7ddsmny25x@DEN-DL-M70577.microsemi.net>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX4qFrBQfvQ7jn
 1BIu+3zDjqOoxLqfiK0+JzzlytrFaE/Ks1H2ffyyVkdl3CNhv/iDIB/XbczVUZ9St/sAfWACgde
 RLjH7ZyXh3xYdRXa6dBGyMYa6KHiuUAblPXG9WRhNolCJ+9jL0z7Icey2zvshWXgUM7y7atOAcl
 eCdiAziRxmJMsaEOsB7kUIsjndKlqXL7J38RUjk9P5PMwWY/0bVoWZiT93FOaTClISvcDGKjK7G
 +ilF0VEYI6tib7MvCneUAtUZHx02oEfqOAEm68g5mKJAhftObk9N6AIhV/nxbAy77K2JpdIl4//
 nqYW+l76XDKdbyK5IltD0cavv/gh89Mgeh95VzAFfUtmSxiim3rQ8SFpPoziJ3QtMXUJ4GpKdB4
 j+laWv33GkkYfZN/fhELwdmj2AOADC4VBqRnNcdH800zwC2E18adjJROf1dPq03B0iEa6KMXmTD
 PtK21fYcjSJ60APU0UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX6kJ5wWFXnmwJ
 ODBWLVeLFE6quy11apuc9Q+Ned1kWzpBu1w3jSuG/nm8RVgGajb1hZ/2l9H+mmZho5hiR2aaenC
 pYz8TT8Cy6bpHIDX5PtTktkJBLLeQRg=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd4759 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Q9ur2bmSGazcmIiCI3kA:9 a=CjuIK1q_8ugA:10 a=Lm50YIOymODnlXrnE8UA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: AICXTygEUNbxti5B2b_DDpPCaWu-ToKj
X-Proofpoint-ORIG-GUID: AICXTygEUNbxti5B2b_DDpPCaWu-ToKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120082

--OnyHBvnZ49WjZumz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Daniel,

>=20
> > When RX buffers are compound pages (order > 0), only the head page
> > carries the DMA address programmed by the page pool
> > (page_pool_get_dma_addr()). stmmac_xdp_xmit_xdpf() computed the head
> > buffer's bus address from the page that happens to contain the data:
> >=20
> > 	page =3D frag ? skb_frag_page(frag)
> > 		    : virt_to_page(xdpf->data);
> > 	dma_addr =3D page_pool_get_dma_addr(page);
> > 	...
> >=20
> > RX pages become compound as soon as dma_buf_sz needs more than one page
> > (pp_params.order =3D order_base_2(num_pages) > 0), which happens from an
> > MTU around 3000 bytes once dma_buf_sz reaches 4096. If an XDP program
> > moves the data forward with bpf_xdp_adjust_head() by more than about a
> > page, xdpf->data points into a tail page whose struct page has no DMA
> > address: page_pool_get_dma_addr() then returns a bogus bus address, and
> > dma_sync_single_for_device() together with the TX descriptor transmit
> > from the wrong location.
>=20
> Looks to me like mtu > ETH_DATA_LAN is rejected when setting a prog, and =
also
> on mtu change when a prog is attached. So can this even happen today?

yes, these issues are real but at the moment we can't trigger them since we
have the MTU limitation in stmmac_change_mtu()/stmmac_xdp_set_prog().
These are preliminary fixes in order to remove this limitation.
There is a leftover issue we still need to fix about jumbo frames in
stmmac_xdp_xmit_xdpf().

Regards,
Lorenzo

>=20
> >=20
> > Use virt_to_head_page() to read the DMA base of the buffer and keep the
> > offset relative to the head page (sizeof(*xdpf) + xdpf->headroom), which
> > is correct no matter which page the data ends up in.
>=20
> I think the fix looks correct.
>=20
> >=20
> > Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index b8b4de4c5b1a..ca61ab449e32 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5301,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_pri=
v *priv, int queue,
> >  			struct page *page;
> > =20
> >  			page =3D frag ? skb_frag_page(frag)
> > -				    : virt_to_page(xdpf->data);
> > +				    : virt_to_head_page(xdpf->data);
> >  			dma_addr =3D page_pool_get_dma_addr(page);
> >  			if (frag)
> >  				dma_addr +=3D skb_frag_off(frag);
> >=20
> > --=20
> > 2.56.0
> >=20
>=20
> /Daniel

--OnyHBvnZ49WjZumz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas1HVQAKCRA6cBh0uS2t
rIgPAQCjz6dgW4WzgWlr9t4ttzrDaei6tXlT3nHR4akPNo83RAD+JXVPBbU0Xk0O
2ElGsVp8MPfiFKQMvS5xx31fZ8o3kgg=
=OIOM
-----END PGP SIGNATURE-----

--OnyHBvnZ49WjZumz--
