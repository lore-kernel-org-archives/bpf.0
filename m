Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F63822BB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880328; cv=none; b=ptPiFsOAtAyGhO5oa0g1LQk7i+2bg75XhRblQ7uxiW5vwlfEgBKLWuRLt71rBOYuDhnZeygV6jZ9E3RmaWLqgWHCxM1PT6XW3neeqI4NTXO8sFJGcyW+gF99c0wjxXYPJn9cI0xeumH86SZqS3G1E5rbAvU1A1admCSKfFrUbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880328; c=relaxed/simple;
	bh=4zMpqhZ55rJCQzknkvOqC1dZoM+uAeq64ZXJDJRKCSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrMvOGYewCNlXxb+QICK1RaHTUEN5Lz1lTThyl71/5Z1oSr01I0QxQWd+Kav2i3LDlifqLQPCfuZVFrQUr3pABB8ORac9IrtPph6ZAajkJs+t7lpxA++nfYcRvITtx4fzSUSQDoHx6wOL1MWt/r2rQfKYDWY4XOVBGAMZXEwmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhqBEOSN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c7s26TGU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhqBEOSN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7s26TGU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21CtX3054783
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CgEoCHdTeicYs8dHNwUpBuKb
	XP9XPOOmwmEWGVwyiIs=; b=RhqBEOSNGGNNo03Tp7noRTWEiLZ3ZuTC5vgd55vq
	iT45tRxi2JVn8DP1pebcN0MU9e5enClYO99FTYCbn1MDebinMcxVK8JTL3QS8Bn9
	qK/BCTH54jcsy2gT5cx7kCfcZy+r55XOK8UZut6ilIzWQ5fuKzutPMWE27SLCf+3
	frfr6mH9sTcEnvsIyjTOXXQJ6EkqXamW1HEgzUrZ6M5WCYxvUqR6YSuIE+/mpQte
	E0ZesVP2OITDNPNmGeIuQUfP0rt8uJLyGldHOecZdxxyQc08crBQBiZekaef1Obx
	YYViMymHYyE3t9xo6bHC35fwSzXldjZbqe/Sh7ayPxwX6g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeu9kr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:32:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc7a6e4e1so878289085a.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791880325; x=1792485125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgEoCHdTeicYs8dHNwUpBuKbXP9XPOOmwmEWGVwyiIs=;
        b=c7s26TGUQ+zpb2pShvqxGGpRXBcPZuCnpXZaCvHv1TVpH+H3TdPcL0ag1g5sD6fXh0
         Xj5bD303LxDew1Y0Tn5+MwTqSq5nnfnyT4K5otHz8N+eAEQYxwWaPLRn5hkeVft32OfI
         1gPPyEQoo09U43+oXydCP10P/1MCSeYWRLcLtVT211EspoM3GeWJjjwTCEp4tVt005IM
         N6ZC83mKtaV8lNx8NhlmR6k1+UuSKCgB9mLoHOW3Kw4TsbkmOZN6ZAJ4t8o5QDG64Lo6
         isxS+Vhijq0QIJBV0orw36+kVXWVXqmIjjZogowNHwBsotUPmlePVY6dkCzHPAjKrXiz
         noRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791880326; x=1792485126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgEoCHdTeicYs8dHNwUpBuKbXP9XPOOmwmEWGVwyiIs=;
        b=FbZamDPYdxxNYC2v4Zkx2r46S9DrHCieXsBoydRLBx0oOa+JaUD/3eyjvP0L18teSO
         GRSJIoqKeXqWZBuRoXGk5AkKmsjo36W5FdARFdDVpoB+zu2gGDBUHL85kLm8xerrTp3/
         wP2w9X0CCzZOxzX5rJwVsHrCyL6Dt2TvVWeakUYYDZ2URA8JW4La3Coau1Y0dEk/LMIW
         tk6lWPaE2XfB/TfSY/02fjoJkC70qsKsZIeVu9Luk7APNROUFAhp+JE8yfxm6AU3IeMT
         XND9gss6HQC0ILYAEoC4IaTCOF46iRYTgqWEUE2jk7JhUclpgvSWH4x45C6QM24f1O0d
         zGgA==
X-Forwarded-Encrypted: i=1; AKwUvBx/W87raVwFe3HfjKkz5ldGJQPQ2QUJx8K6a2/pdBsxu8FuBIMOb6gF06LirDAFQRUXFqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkvHrLAmfdtYfx/SoGRu5n2M/Pqz7Pu1ADnhC+ye2wo5WV+Kwj
	DYyKSbFoJqwq1syP9TpFTAI3Ui9Z9QzOvpLTYiGc+TDHJ5cnjQCpgJ473jzoWdeLNFOIxcQxt75
	U95kUH5tLSfPr17Spazh/UjpR+EnqT25UB74LJ6TGMqwzzZRVfgrFbY8=
X-Gm-Gg: AYBFou1YQlj8x5gLRkRcCV+J3n1RFIg95aXtgZpBLfVld6z+kxDnglAzaonKSUYHv9R
	QupUkZxJJqkdVAzXLHe67asMIEuFU1qmtK32QuVdbqGW6xf2uxYuQEmVPAYjkzr/k8c46QSkaFn
	9ysJ66MWaykmSEubsvdeajctu0eTSsKuB6U6B6FcIWUc6rTS2uBNxt6yM2cedi19V4qj8qF5pVu
	e64rKwAHnbk+hTNkWowpp7KYyBPAMT0+mDXkEckZJys1azhD6/2yS8JC3rn0QULEQ9zr65iTT/f
	UftErdXXvKPcB/5MCnUNgZN3F4Nf3H2hNxaRRGOtUU9IXRuxRSZQcVbYneSKeALl2rz76Bp99aw
	BlvAFUc5zh0g6DA==
X-Received: by 2002:a05:620a:3720:b0:93e:5eaf:dd87 with SMTP id af79cd13be357-93ebd2a05fbmr1975434785a.62.1791880325490;
        Tue, 13 Oct 2026 01:32:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93e:5eaf:dd87 with SMTP id af79cd13be357-93ebd2a05fbmr1975431485a.62.1791880324843;
        Tue, 13 Oct 2026 01:32:04 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm280651825e9.3.2026.10.13.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:32:03 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:32:03 +0200
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
Message-ID: <as3sg4tbl93_yEiL@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
 <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
 <as3pB16af0_QhNyB@lore-desk>
 <3a483a6fbd86f50a02435932fe4a7ea3@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qwKvKFoaOiXYisH"
Content-Disposition: inline
In-Reply-To: <3a483a6fbd86f50a02435932fe4a7ea3@tipi-net.de>
X-Proofpoint-GUID: RU1vuv3KO2SQNdGTRITNPeAirvEesTnx
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acdec86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VeR9IiojQdXVVGmY0-kA:9
 a=CjuIK1q_8ugA:10 a=hNWK7rNVVTdq26VXPtYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfX0BtXJtDUWu8i
 bBUNJCLoN8ITdMPoH8gjDAUjRPnwasWk7VCo+Yz2U06/9dEPfVmOxIfuToB41XKlFOY7gLzjvwb
 JcZmjWKh9nxQU8z8WMIpPaL7RVU4rpo=
X-Proofpoint-ORIG-GUID: RU1vuv3KO2SQNdGTRITNPeAirvEesTnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfXzfJHkr8YGhCc
 86CSag9OBjjkAoYqOqGzEEkDNHhHp7t166hGprmqsP3ZvJlP8AjcoW7c4t7fUNsyuW+TZpCyrDs
 AIfsF1qG6YPfTaZavyWgfDpi+yJDDEjWeYAp5oSaS/khjSuBNR6lyyeFdv66oA9eAn17aO3Enrc
 Dcg9JEtY07czIoUH0m0kMIVs3+D82eqVGz10O6PEQ6yRZSxPRTUSS9OqkaguSI8PFOA9dBZLiYr
 vXkU0WImv4rla1a37IF18SVswki51PADlG5hxttaRcxwjDKFQGs4IYprZWZg6KfsB7orxgXRraw
 8tEsiGLikw+XBKfxXdPAmhTL63Uoyr4x5wb78bm60vp7Czx0+t1YOgSWnqTVTV8N+6fVrZSnriq
 N0XexUaZod1VnFvhEnocbiks151SWTg9Ok9RcxUy3IulNo7yzn/sX5qCmLxoKM5OSjX4nXqhdxE
 mGNgcI4kub/+BvGVBfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130033

--3qwKvKFoaOiXYisH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13, Nicolai Buchwitz wrote:
> Hi Lorenzo
>=20
> On 13.10.2026 10:17, Lorenzo Bianconi wrote:
> > On Oct 12, Nicolai Buchwitz wrote:
>=20
> > [...]
>=20
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 426bb68c9bbc..8c08d44fdbd3 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *pr=
iv,
> > > > int limit, u32 queue)
> > > >
> > > >  		if (priv->extend_desc)
> > > >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx +
> > > > entry);
> > > > -		if (unlikely(status =3D=3D discard_frame)) {
> > > > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> > > > -			buf->page =3D NULL;
> > > > +
> > > > +		if (unlikely(!error && status =3D=3D discard_frame)) {
> > > >  			error =3D 1;
> > > >  			if (!priv->hwts_rx_en)
> > > >  				rx_errors++;
> > > >  		}
> > > >
> > > > -		if (unlikely(error && (status & rx_not_ls)))
> > > > -			goto read_again;
> > > > +		/* We do not support SG in XDP mode */
> > > > +		if (unlikely(!error && (status & rx_not_ls) &&
> > > > +			     stmmac_xdp_is_enabled(priv))) {
> > > > +			rx_dropped++;
> > > > +			error =3D 1;
> > > > +		}
> > >=20
> > > AFAIU GMAC4 and XGMAC always use the second buffer of a descriptor. If
> > > so, at MTU 1500 a frame of up to 3072 bytes can fit in one descriptor,
> > > and this check would not catch it?
> > >=20
> > > The XDP program would then only see the first buffer. With XDP_TX the
> > > frame is cut and sent too short. With XDP_PASS the second buffer is
> > > added
> > > after the program already decided.
> > >=20
> > > Patch 4 fixes this. But if this patch should work on its own, should
> > > it
> > > also drop the frame when buf2_len is not zero? Or am I missing
> > > something?
> >=20
> > Hi Nicolai,
> >=20
> > IIUC your comment we are missing the case where we have a single
> > descriptor
> > (rx_not_ls is not set in status) but the packet is splitted over buf1
> > and buf2,
> > right? Something like:
> >=20
> > 	...
> > 	buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
> > 	len +=3D buf2_len;
> >=20
> > 	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> > 		rx_dropped++;
> > 		dev_kfree_skb(skb);
> > 		goto next;
> > 	}
> > 	...
> >=20
> > Is my understanding correct?
>=20
> Yes, exactly.
>=20
> I think skb is always NULL there in XDP mode, so the dev_kfree_skb()
> can go. Both pages stay in the slot and stmmac_rx_refill() reuses them,
> so nothing leaks.
>=20
> Maybe extend the "We do not support SG in XDP mode" comment to cover
> this case too.

ack, thx for the review. I will fix it in v7.

Regards,
Lorenzo

>=20
> > [...]
>=20
> Thanks,
> Nicolai

--3qwKvKFoaOiXYisH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas3sgwAKCRA6cBh0uS2t
rEjBAP9gErlRqvxFcDyFsfPFSFOkj0MTST4iWeXLN6NZgNjN7wD8DWWqfrjLXqPl
Dp1q1qQAQUSjZYRFz2ogR2tzHG0Eeg4=
=mHzj
-----END PGP SIGNATURE-----

--3qwKvKFoaOiXYisH--
