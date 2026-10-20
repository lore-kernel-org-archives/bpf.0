Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502746;
	b=mPgg+e1s9umTAYl/kpBicRHLqIeA2tn6e19K01CELWENxVnqDLaL75oV9X0oL3PCdXtO
	 dmiqPWdVS/oqZ5DrvdBxTyQACma6MzMW2FP7sjHX3URkSItUsHGX5XGgK8CUQRIJaMt1I
	 lk6v2glAGQIGIclOspawbXbjIOUUlW/2xhKK7Id+cuKlN18cvTRS2A70y2utlkP1yHc2j
	 E2OwSUipUHN5djv4aT7ewGSSuGQxOUMdhluWB0PXHP0bOZOsX4HENFuHno3bQ6N2Aeep4
	 aF2fNj7hL0D5PpMW5yecV+cSQsSzio8kQXtLBu0O7DFM9LSUUwI5w+qfde/tZPSv66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
	b=k4Zx67h9gKeMr/oR3DcRKp16IOTaDq1NOHwDL8MXaZL/hOBuARGHrTKvi3ESuap8cS0L
	 UE1i+02WwVgq3j1B/k3eIDuJD6qbQ3kk+Yzn/0hAQ45xWF4VwqIy51AhuIqC44i6/4+Lf
	 4PH8qBRGjlxqrIB0hVH6+5GcdnGm9oWo/AoIOsrahjAhV6M+F010QnXtXvpZeUz98MpME
	 qt1NxEgCRMhgLSa/AgrfwtvtPTVWs/4r9wNKLmSRY8IGuHY4snnbEipRg80ZgkFbbg6Np
	 t0zIB3dleuQdQgxL+28YlKe5vRMiH5+fbygYIdbglEcRWzctxoflInR7doO6VolWtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TZ+1xYDT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6jagHkf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B710606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B710606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TZ+1xYDT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6jagHkf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAM7W1430156
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TqphKuuzdQfZj8vC8DGTuD4k
	crG3fghciLwkO9jLrUc=; b=TZ+1xYDTCOweYc3NVCBnbpA4EmccBikSPN8shBC2
	VjAI1tyaEqOSGl47xUIIyarYRg7jlIl2vudoYbHxUovAvAlSsRMZCKThdeQyFx9X
	ONH/iujzpXDo7m37t5nXJ3OjX2reb8OjSRzIiQ6wrq8ReruE1osHFRdBbksDes0x
	WDQHXYQqm+/+/UcTjxit7A4hgy2OprFLb76OD+uHB8K1qkXR6Zxi3kJHN7rit+bv
	DjOi9rL1CcEbmWaaEyunuxcFMoG5oy03tGVaAM0jusEaqWartsb0LNucDwwAbOdT
	SvugRnLjVOL7Up/JBfmX7j8gUHDLHj5Av25RIHlWpbYTwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qamg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:25:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso129981085a.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502743; x=1793107543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
        b=Q6jagHkfkxsIACtjtGRotLMqYoKxBfoKMxc/a/jZiqSHZw5S7cWB6RjZjFz0X2GPMU
         8cM4+gF1oQycZIIiWf8VYipv/tcEhQo5K8WHCN+1l65SaRR5zze4kH5P+4COxsEB8WbN
         TIO8lKHm+xVNa8g3Va+2iuKlvaB7sQEOjVmsRfjmiKrlPN5Q6FUF0zh6V83rcsBQqV1d
         G+LCvSeEXiNpJM37twQrCKOCjngUslEIZUkCwYUCLpq8Abj0HSEdEMe6RDUjEmvqujAS
         H/yxeyS+h6xSkY6ID+VhsFDVto8evlI3LTxKe2V0rMMhXYApBspxcmq7i5bTT6hy3cR4
         1A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502743; x=1793107543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
        b=KyaDD39LH8TyEo8KZqv/W0oO9J8VrsWQ61WJokKg1m/zP9jSMFFqpHMm0hM0fM039r
         z8lFsyk4/DD9lsxll6Rak9iUoxtsZRRH4BLezAqg76V6DRPQ80AwMt1yV09v6WKI5kIT
         rNdvKmL1X33qy5mvJh1PmXq335zKnK7yb9Lk8GM96ABUKofNQFU2vraa8lPvlNkyCbTz
         4CXLFMNiy4EG7Qsd6E/tpyJwc2deYNdvEzLrxrNWOhEHeMIqUNlgOXi9GrY9zNdLlZGR
         61hH1y3RrF9C81M66jPMwKG2SZYhgdqmzeho2csVkJjWgW3Fite7PG9T4zUhVGyzMscr
         rYZg==
X-Forwarded-Encrypted: i=1; AKwUvBw6BFCSNxk0rjkWUZjM0fN7dnAfP9CMPmJC0Z9UyiS+czFM9dA2Z6pBjYqUQtXQYf5MoXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWZjxTtv4+OwTqLluV7q2VEqzD3BnmNgR+YXY1OBgF1euxS7Qe
	qCtz6Srck4/fJjoK0TyKqL3ak8Peo/zFfS7lIQKTlJ6V1v06aS3EBEBGSx2XHO2HD6PFqp2t/bB
	yzVdzY4r5DmDNnKMlhUvlUbW/oiXpZrHVHgyz0qkTFgZkDUK32W/TDuo=
X-Gm-Gg: AYBFou0WuII/2/GoAmkeCp5+JcJPrqJEL+DA6xcK975Q0RTj6j/f8LfEGEU0bJfP5lK
	iFvgvcimrFQXFYGsGCqHnb2JZwV+ud+KtoqN0bzLMK6iKTlHj16IyQ2lNUPLHoiO70YjWKKPrFV
	4Y6FJDodp30ecvcgprCif7KuMs1iNvt6qZObSl2NLy8LM++KW9Uexb7tGz3mKc+7NfDGhAOKhp0
	1JZB4wPP4F1X64kLdsdfej4ziCvCi0x9kcjqJQV0bI/OnV2NBtTNfI8F8fruO1ltU7lSx8Z9ywZ
	juRvWOOFY6tGfn3dYIyH6xilSQTETkQMLAknaZ4GTHNu2o7rxPXiT8iFc3N/yM78fAU7WGl9ze9
	YVWFw1oSV/Q8Zxw==
X-Received: by 2002:a05:620a:294a:b0:93f:3834:31f9 with SMTP id af79cd13be357-93f4c54760amr297016285a.12.1792502742986;
        Tue, 20 Oct 2026 06:25:42 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:93f:3834:31f9 with SMTP id af79cd13be357-93f4c54760amr297010885a.12.1792502742352;
        Tue, 20 Oct 2026 06:25:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm6766343f8f.42.2026.10.20.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:25:40 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:25:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/5] net: stmmac: drop multi-buffer frames in
 XDP mode
Message-ID: <atdr1N29Z3X0V2hR@lore-desk>
References: <20261018-stmmac-rx-mb-v8-3-5f58c0b25849@oss.qualcomm.com>
 <179243151663.3135.5003290847659035107@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxBQXxJ5vVdF3FzZ"
Content-Disposition: inline
In-Reply-To: <179243151663.3135.5003290847659035107@kernel.org>
X-Proofpoint-ORIG-GUID: YdHCz5Lg3r5_SpIUoFcxan0HWHi_KpDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfXwFLTP+rBeENA
 Oq0En4N6kdfZgztG2SQ8rDNVORHD+zL0GGwI0o/PmslmvFa0Om7NOMcap6Fuwa7hxEKDQjpf+gW
 YInAHDiuA/uMHSi7IGG0bYzlh7HNZsyJ6QRNCAXIRg87Homsy2CXGo6ENAWXBokribVLAiR2zIO
 m2DxZ2qTU7ZgcJtZIZYGP1054FAZzBMnirwFqZBXFcLjNJy2VB7H80BdjkANmtbKbzRmFuCqdpx
 fVXAnA+QaPvvdBaKgRkoZtIQfwFeh9AMwH0hTF1id2SDEPaJ433owm4qqLBNLuYZCmRPbJFHqHd
 PqDJvUIy8BsI3xZ6f6QO61RFbKkcwvmIXg+ClDKpSRB9b8xoTmebxxT2SoeSiX110eMrajVS8uQ
 CVgmTX7DoDoQrV5Hh8l9/HVnjH/gsZlpKmcYcx59q8jPjOLcgrY1mDMALltm5bwe2dvS5fqZku5
 asYiUVkUHc92RgZbCsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfXxMkoRI+RRgo8
 T/+9ze2V9o0ulP6P25XVzCI1ep5dmFUGf8Q0RAnv+IO4DIGl5clSMc6mOV1PlmV+9sbqXY+hwXT
 KDNnpz9m2rFjx1U+Xe7i21+mAakOrQI=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad76bd7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=TDT_cie5QS2Ta5137pIA:9 a=wPNLvfGTeEIA:10
 a=JLkvtGKUs3jDVbLDuzwA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: YdHCz5Lg3r5_SpIUoFcxan0HWHi_KpDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200053

--vxBQXxJ5vVdF3FzZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The commit message does not describe what the patch actually
>   does, and it hides changes to the non-XDP RX path.
>=20
> --
>=20
> net: stmmac: drop multi-buffer frames in XDP mode
>=20
> When an XDP program is attached, stmmac_rx() now drops any frame that
> spans more than one descriptor, or that uses the second buffer of a
> descriptor. This prevents the XDP program from running on partial
> frames. Both XDP_CONSUMED and XDP_TX/XDP_REDIRECT now finish the packet
> via next instead of re-parsing the following descriptor.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index efa88cd359dac..e929cc0f23125 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5888,18 +5888,23 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entr=
y);
> > =20
> > -		if (unlikely(status & discard_frame)) {
> > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> > -			buf->page =3D NULL;
> > +		if (unlikely(!error && (status & discard_frame))) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
>=20
> [Severity: Low]
> The commit message says the patch will:
>=20
>   "mark it as errored as soon as a non-last descriptor, or a descriptor
>   using its second buffer, is seen while an XDP program is attached,
>   drain and release every descriptor - including the last."
>=20
> Is this description accurate? This hunk removes the only
> page_pool_put_page() call on the error path in stmmac_rx(). After the
> patch, none of the drop paths returns a page to the page_pool. That
> covers the hardware discard_frame drop, the new XDP SG drop and the new
> buf2 drop.

I will fix it in the next iteration.

Regards,
Lorenzo

>=20
> The dropped buffers stay in rx_q->buf_pool[], and stmmac_rx_refill()
> reuses them in place because it only allocates when the slot is empty:
>=20
> stmmac_rx_refill() {
>     ...
> 		if (!buf->page) {
> 			buf->page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
>     ...
> }
>=20
> The reuse itself looks safe. All three drop checks run before any
> dma_sync_single_for_cpu() or net_prefetch() on the buffer.
>=20
> The new !error guard also changes rx_errors from once per descriptor
> carrying discard_frame to once per frame. Both changes apply whether or
> not an XDP program is attached, but the subject says "in XDP mode".
>=20
> On dwmac100/dwmac1000, the previous patch in this series makes non-last
> descriptors report discard_frame | rx_not_ls. So an errored frame
> spread over N descriptors used to add N-1 or N to rx_errors, and now
> adds 1.
>=20
> Separately, the new buf2 drop in the later hunk doesn't set error, even
> though the message says the frame is marked as errored:
>=20
> 	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> 		rx_dropped++;
> 		goto next;
> 	}
>=20
> It only behaves the same way because, in XDP mode, that descriptor is
> always the last one.
>=20
> This patch carries a Fixes: tag for net/stable. Could the commit message
> describe the in-place buffer reuse and the rx_errors accounting change
> for the non-XDP path? The later "net: stmmac: rework stmmac_rx to
> support XDP rx multi-buff" patch keeps both the !error guard and the
> in-place reuse, so it doesn't change the picture here.
>=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--vxBQXxJ5vVdF3FzZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdr1AAKCRA6cBh0uS2t
rN3jAQCaiApD3+2JS+qQm+aR4BOcf3d7wVouCDJRsCQXljaJFwEAj5TJnQHUlrQ5
XvtiDdwp2G+QPXu/Ke2Mxtl5AN4IGgs=
=bcEw
-----END PGP SIGNATURE-----

--vxBQXxJ5vVdF3FzZ--
