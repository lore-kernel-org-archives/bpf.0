Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9B52ED3C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699742; cv=none; b=P97DOSZSddSQv8RICw4xKfZ1CGD16vdRpE/27KG8XclGyK237EQJKkognPiIniCGwEeWzxzQA75jYYf32ANBIre2vkvxJ3TW90Zsr6PHUFHApUL1eNyvFezR1XDGfh+b3+QkEDKDH4vBNoXQLrwH2FdKUaV0Z18SVb+QET6IuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699742; c=relaxed/simple;
	bh=7HCAvBY31Fcso/YH0DRSom85NWi4yGpq+lk6RBQcKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgJhQqeazwAyc4K8ZyjnGgCprd67Gl9Te6mVjwIZbyeePqWE3fbL45HVMSADuEXTHPVl6MiPUZ16/UDvELpnMBrRwBOpUrAvxymkM/9VH182EbCCKtlTkn2t1fPPUnWQzfJwtsquY/YqjyfrLLKWjNTB1upzYN50UzlsxvAReIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtR+IK2y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMogzi5q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtR+IK2y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMogzi5q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqh4M858094
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KgswDTUC6heFE7Kb6HjIW/Q+
	kQDgzcu9CfQIYuxeCuk=; b=XtR+IK2y+R3kVV5rIcaJToX++TeBAbdcSFnIDHOU
	mjgG/Epwzd7BwvDbmqPZQjGYlP+LU7jCuI4bhQZhplw2NdwjxERxwE6OkY5ewNFA
	vIWVUEeUq6DVS6+BfxlTjnGSTLN68OHfLZmhvoCegxZ4NjJqpwfACiqqaCd6Bqha
	HzVyMvwaOWA+N/Ge2QzuVPxw4i5mX+Jmgmu0x5ZygJiKpCqklUwEtVlqsOPILNxp
	lXpHbuT3XirjLpEjpnziPTn1Vqsc1zKELsJ0WTS/WV2QXf8iYy15zPLR/cFCs+jT
	U786o475DpXutHii0UpwOkHQXv8sQwTJQMpmxDHin+SjSw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0jhvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:35:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988cab8e785so275938241.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790699739; x=1791304539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgswDTUC6heFE7Kb6HjIW/Q+kQDgzcu9CfQIYuxeCuk=;
        b=MMogzi5qdOowCUN5yfyu/AyTeruXq5gaYdNNBGmALyYwRuuphFiIzSEuMX8PCvNYKp
         P6WZFgaVzCFJCt7G6XPaIPdc/v2Tl4uCgdFq0zXYqah1fvAx0lDVwJ+Pcr+9j7QARwvh
         Jr3R6Pp1KojNgzJ+AHhfhYjq0tL1p6s8McC4FxDOEQznnKUuhkaad71HvV6i15Zh1KP6
         yd4lcPGnbcnYTUyj8qfCeg+2SKfz7FwJqy7avwzK/f9Ln8mfesQf6BH0GEyFxiacO6Vd
         4BJu9qq8TeBd6NHwTcap+G4hL3dCV1IhbmmginNOW+Gj/yuK+f5ZpErtlWGlka3QWUjP
         UeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699739; x=1791304539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgswDTUC6heFE7Kb6HjIW/Q+kQDgzcu9CfQIYuxeCuk=;
        b=JohlyLrC+dhrpHT3NWZfvojkUDFvLKOaSNwb6i/YoYEzuoYwA7zfs7HYZ99CGpEayH
         wSZlnSfcrU4QE4drUz8GxPVf5Z5af51+ocrLrPrDh1B5iB8L/igzsaLrs8aa2hpLDi2x
         /8COcS/vhyAA2dooX6d+KuLBKI8NsSEzUM37Drqp7xq43Nk4qkXEYQTwHhkwoIYWTu7Q
         D8tdUYlob/2J3CFvxKnezIDN5r0QGkrQgouF3DKVHvsVZk2XFO2G8UyIq1rY3ULR9FQW
         364sRm9EYJYB8z6jz8UuYWsFGjD0Dh+5feOG40j3BJPiq2GqnIEpSJDLFFW+wxfWlh/C
         L+hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxihNa6/2U2VXSCf9Gg392YPBCCCEB8XFv5pukwQmdiu/lj3dzC+Gf2cYof+q9qkcJqf/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzHtspZwlNDsLxLuCKdkvBedXkVbmm/QbHAOEyWOKrAahOzJC3
	mk2w/xjgW5P+ZdwyK/ZzzmqE9IcTtdeNBqGV6XoERVKuXhbQlbwuTy7C7R4csPTSc8HTK80VOdz
	yv0vLRlG9iWhMtuykCeIOzIFlbvzcq/YFyBoh4t5hlL6oRDp1EGNDVHI=
X-Gm-Gg: AYBFou2Uod29ZZ6UYiQ+Vwq9OPiZAH69WuDCEDHGzLQowlqofsQ6rskYDYLurDzZ1Qg
	68bKbtmRamWsMgL7b0Vy835be5Ipr0nCgyFxfopNxCxGQoZArgjCpy2I8JscfovvPRj7NYhmGeI
	UnBkE2ohKLGXIrNHPolV71V+EFnm3EcygYE+jkA+vni55UI4TiSyrccA+b2tkllNI4APd7YvAlU
	x1wOq507ayWaWSh6iW5WKant28XY+EzwFAEX4G/Ukd5YSvaZM3xnh8JKXSTQddFvOxGJ2WnAMkm
	UlJqxXAJd9gignzgQhPYm6Xw6PZ5EnC00VBXxHd63K44lSYTYFgN+i2fnO0ILBINAC6vNux3VuJ
	IxmyqDe/5e9oTFw==
X-Received: by 2002:a05:6102:1486:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7bc2ecee87cmr47634137.1.1790699738720;
        Tue, 29 Sep 2026 09:35:38 -0700 (PDT)
X-Received: by 2002:a05:6102:1486:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7bc2ecee87cmr47606137.1.1790699738086;
        Tue, 29 Sep 2026 09:35:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508bebesm5857887f8f.29.2026.09.29.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:35:37 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:35:36 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: add XDP multi-buff support for
 TX side
Message-ID: <arvo2GYtvVZ9FDyf@lore-desk>
References: <20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c@oss.qualcomm.com>
 <179069820857.434549.2531492906306099121@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lCMFkcEL7KUIgE/T"
Content-Disposition: inline
In-Reply-To: <179069820857.434549.2531492906306099121@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfXw0vK01WpWpDM
 zJ6vg2kCxw+PG+/LXYlGibCyv9RWFehO3OkXJ0ApPJHr1hnKGDFv9HZ0rbiMmg6hYhtN10ffDbU
 xv7BNcGuDj7YOCDGL+TavK1WFWTIMsU=
X-Proofpoint-ORIG-GUID: 64RspnKKz2uEBHbA_mUG5GdXfJVB1IhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX+ZyWodUXiXNG
 Iym4J7sSuVjN36bxoJZy7J/CaKPqXbAySeKFtOjrRIO3COI/SomHIqPcgXK8Dg1fGFw+c4OETkr
 jGEkpP4tSjGWdGQunwAbPS4OZGPbkXASfrjqdkgYU1tNgI0o0i8NFSc+g7PhEtp8qeROlGpL68n
 C77y/e1K4Mcr5PmKPtMKECMwanCaRwkwXWtatLmMVXxrG2Zigt7UK83Hp4oOopfpUJqpQSxSBKM
 BAv6PkvZxTKqWrZePO2sOD5NfqsW76Q1lUqFMfz/KKjxjo3hyz4b+nVtBJI+B6XiyNjWY0ZlRwa
 evKwaZXdNK0y7J9Oxm8Y2FVxkVdkcvhAUKsWTi60EwrXuMnH196Bi9duT76Y+MxCUWsxNR/cU4n
 QdjYXMFoBQLq6igv8WHeqEUxg1U8gKaRa6i4G27j4I4qRXloNW3GM5y398nOZ6kx2ENoMmVgMwo
 1PB5Tn4YMd3qsRnn/0Q==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbe8db cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=jf9qpCBZcCKH78LjphgA:9 a=QEXdDO2ut3YA:10
 a=vBZCTss2YYTdBBQYqEIA:9 a=TOPH6uDL9cOC6tEoww4z:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: 64RspnKKz2uEBHbA_mUG5GdXfJVB1IhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290066

--lCMFkcEL7KUIgE/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The patch fixes a divide-by-zero crash in the XDP TX path
>   without saying so and without a Fixes: tag.
> - [Low] In stmmac_xdp_xmit_xdpf(), the new coalescing check reads
>   priv->tx_coal_frames[queue] twice with plain loads: once for the zero=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: add XDP multi-buff support for TX side
>=20
> This commit extends stmmac_xdp_xmit_xdpf() so it can transmit XDP frames
> that carry fragments. The frame head and each frag get their own TX
> descriptor. The driver now also advertises NDO_XMIT_SG for the redirect
> target.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3ad9252bf6aea..f1e9ac2f98598 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5241,77 +5241,118 @@ static unsigned int stmmac_rx_buf2_len(struct =
stmmac_priv *priv,
> >  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> >  				struct xdp_frame *xdpf, bool dma_map)
> >  {
>=20
> [ ... ]
>=20
> > +	tx_q->tx_count_frames +=3D num_frames;
> > =20
> > -	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
> > -		set_ic =3D true;
> > -	else
> > -		set_ic =3D false;
> > +	if (priv->tx_coal_frames[queue] &&
> > +	    (tx_q->tx_count_frames % priv->tx_coal_frames[queue]) < num_frame=
s) {
>=20
> [Severity: Medium]
> The old code here divided by priv->tx_coal_frames[queue] without checking
> it for zero. That code came in with be8b38a722e6 ("net: stmmac: Add suppo=
rt
> for XDP_TX action").
>=20
> Can tx_coal_frames[queue] be 0 here? __stmmac_set_coalesce() only rejects
> the request when both values are zero:
>=20
> 	if ((ec->tx_coalesce_usecs =3D=3D 0) &&
> 	    (ec->tx_max_coalesced_frames =3D=3D 0))
> 		return -EINVAL;
>=20
> So a command like "ethtool -C ethX tx-usecs 100 tx-frames 0" is accepted
> and stores 0 in priv->tx_coal_frames[]. Before this patch, the next XDP_TX
> or ndo_xdp_xmit frame would then do a modulo by zero in softirq context.
>=20
> The new priv->tx_coal_frames[queue] guard fixes that, but the commit
> message only describes multi-buff TX support. stmmac_xmit(),
> stmmac_tso_xmit() and stmmac_xdp_xmit_zc() already have this check.
>=20
> Could the fix be split into its own patch with a
> "Fixes: be8b38a722e6" tag, so it can reach stable?

I guess we can avoid to add the 'Fixes tag' here (and so to backport this
patch) since the issue seems quite a corner case.

>=20
> [Severity: Low]
> This check does two plain loads of priv->tx_coal_frames[queue]: one for t=
he
> zero test and one for the divisor.
>=20
> __stmmac_set_coalesce() writes this field under RTNL. It does not hold the
> TX queue lock that stmmac_xdp_xmit() and stmmac_xdp_xmit_back() take, and
> it can store 0.
>=20
> If the compiler reloads the field between the two reads and a 0 is stored
> in that window, can the modulo still divide by zero? Would taking a single
> snapshot help, for example:
>=20
> 	u32 coal =3D READ_ONCE(priv->tx_coal_frames[queue]);
>=20
> and then using coal for both the test and the division?
>=20
> stmmac_xmit(), stmmac_tso_xmit() and stmmac_xdp_xmit_zc() read the field
> twice in the same way.

I agree there is a small race here, but the same issue is present in
stmmac_xmit() and in stmmac_tso_xmit(). I think we can fix them with a sing=
le
dedicated patch.

Regards,
Lorenzo

>=20
> > +		struct stmmac_txq_stats *txq_stats;
> > =20
> > -	if (set_ic) {
> > +		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> > +		stmmac_set_tx_ic(priv, desc);
> >  		tx_q->tx_count_frames =3D 0;
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c%40oss.qualcomm.com

--lCMFkcEL7KUIgE/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarvo2AAKCRA6cBh0uS2t
rPbYAQC4FHOuUC7np8NscKyMG+sNI0axYle6eOCMGcv4Wg//lgEAs5kYtXHqr0Vo
h852u1vJB4hxTP+jHlpF7k5OBbOhzAo=
=f2Al
-----END PGP SIGNATURE-----

--lCMFkcEL7KUIgE/T--
