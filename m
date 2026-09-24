Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B31F5821
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253012; cv=none; b=tWgxHmZriIcJHN0PEjKVMeJ90axZ1I7i5CL99kbvlh2QQOBqb9JMDuvx0PMFnY693r8GbNIdhavX2y+Lh8Ma2awbyEqUjCNeDB5YvkmlmTpyPZ/WYVgF0unlYxEbedHkwXHKOFadmj4KZzrLBKcwer0mYGEtbhhXK9fzh4J1jx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253012; c=relaxed/simple;
	bh=rLoP+8AdeVcNoLEUQTPMwpKqDoL+RwcmyyA/MCerNQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYxY9eKdBkwGGXus7gi+V4qiApmHX6TpxfvlTBFnikSQNvaeWqYp/5EjzEL0nwJF/7MLw8FHIos/pJ7k6+lcBMwykXyBos1bxxR5aStPGQNeTC2fA6AgYk3WaufqfZmX2LYsxdNJl8OHpIQr0Lczn+KcNuBzkDyZHleioGlbt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eD+vxzK5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H4GeSNJi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eD+vxzK5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H4GeSNJi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4V7P3282827
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7KjYp97LSimxNB6wnmcIUULA
	nNTLiQ96GWyrzK4TKGg=; b=eD+vxzK5sxi0mRDRJzbPXBMRPA+j7uKS6c7F3hH6
	yCnWyl4FgvYDny5SCN2QcKlq4WwQldTj8guiFN6lcaNWH74nwZta7VKxaOMUyOhv
	hscbYnWj6JngdHYQakFg+DhE4LfOqMwlQD+9DZSpb+fqyjTZeDyJ4T++DP75DUKs
	FlU3NXR4gsJ0FNPC5o6Ezq7RNbNPAXATtE0LYeGuMKEV6yWISgrqKo41fvtKJe83
	Q2LNJ0V084UEqryWtRruIFUkbvax9hGyJoDb4CAdhtnsj4DU/C6cfek079/S1q0H
	9PuOsWiKCD25kbBJl4LkJuKJ9MP6XXqkHske4gebWdGoIA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstujk62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:30:09 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-983310b2d52so439271241.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790253009; x=1790857809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7KjYp97LSimxNB6wnmcIUULAnNTLiQ96GWyrzK4TKGg=;
        b=H4GeSNJidUHlmHH89AefZvB4Zs6rhtxnxAGRZUSuFb/iuQaW+V+tCaLlPrAS+dY1wg
         0Eefygtj7c3j2MhmhKtUPqOVNw8M3CQjFF8E+gWIH+9fRdIHS4T3o2MbpaUDCwvOXwty
         PqMh/SiLiA8tOxsoSc6phcXYVyc48TvXGu1DUzDIXGorwfMJGAyho+k3VkoM1KPfue7A
         4bHrTEx6NiA1Oq+3prr3BTE64wQZd9zjsy0XLwyYYWi0EF78npK+TMy1Ooxe17bbnGPQ
         V6PZmLIC4qmjTFu9/q+NDdv9sAPTI+plXXDUZIBOrrTiv1TyjBnwfvVCnRSqKAr70NC+
         RkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253009; x=1790857809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KjYp97LSimxNB6wnmcIUULAnNTLiQ96GWyrzK4TKGg=;
        b=ssPXR4oxT5mgM210Up3kqmr2LaPK6nXYDULIbmfSOAhKD7yUJuQLVlsFccYJtk3CmA
         ffcuYJLIvCKXuz6zkgvn7markF+a8R5QOjb6RW2OkP7l9wnER2c80EdQPRxTWFtMHEM5
         u8rmDNqZw6YUlH5EWeVbvHBv1SmprUvEPfsR1pCrf2PfBSJGtOkRtiW8zFNL9mOHW5Vc
         VNQsRVvZUp8A174xm76dPoOMXS2sAgeGvygQ3RYkrYrDAaCOqauoOMIFQJ33S7ZSz5P4
         Xum1ADIle44bFl0a1+Ja5kB0Ylax5TBs1w/qOxuxKEmOcTJChvJ1kIoE4PKnD5jQpHWb
         aLWw==
X-Gm-Message-State: AFuF++kEfmbSb5XSHjBnNjdOQAkI+W/5mE+MlFbAqISsECqg+tkVPeU+
	yleV2mi6DoJ5q3fNr+Y4OCHUKbLUSMMZuXVLF6/ASZOLZQC2SX3WGKhOJ2uhNs10nEXFVGV8MN+
	XEtsV9zTxBOIjA8sd9xvnX1vwyFAeILDS1aw+cUkjVbf+nnhN+inEM0fK//cS+Qo=
X-Gm-Gg: AYBFou0cQCKR5lfAWS7ZO0PMBG+sL++eY+xd7Adq+KJ13pE2Y0PBGrh8shXoD0SCS/m
	m9DS1zu67lJW7NL7rwfyoRK2eFA4eD/dEVm22zRbbc29786jpFuVFo7RBhAvRCib3msS9UP29Y9
	veU47NxrfZq5D+on/5PWbklS7FH23xNwQAAN2LDxm1+QYKizdOYMlelM4RrlIMXuBYGV2AGw14D
	qD2LjSRDfEM1+qEQ27fgpFPrD2+oOLzkzPsr6Y6BWdidAciEhs320wEWyygiuTzWm25xLaDSE0d
	y36M4CjnZIkKODDFC4KYPJLhbTG5+gtDSxWUnVO//NAcIwQ45S7nk/Fb7RlwpoeHDwbAjVmuw3v
	ii4IQiLrqJEipPQ==
X-Received: by 2002:a05:6102:1489:b0:7a7:ad9f:53c7 with SMTP id ada2fe7eead31-7af1cb95fdcmr1018496137.11.1790253008614;
        Thu, 24 Sep 2026 05:30:08 -0700 (PDT)
X-Received: by 2002:a05:6102:1489:b0:7a7:ad9f:53c7 with SMTP id ada2fe7eead31-7af1cb95fdcmr1018447137.11.1790253006112;
        Thu, 24 Sep 2026 05:30:06 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b44db6sm71327215e9.0.2026.09.24.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:30:04 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:30:04 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: add XDP multi-buff support for TX
 side
Message-ID: <arUXzOU6V-VeWOOd@lore-desk>
References: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
 <20260924100004.F06341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sUjn4NdSVny70mPK"
Content-Disposition: inline
In-Reply-To: <20260924100004.F06341F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX/iTZh9uyIzwJ
 K4oWfCB8re/d4CTDyuw63uhClCCbwOoLQ2VkB+eBq0icwYs48Idt5gHy4sr7fMnnCyOnqi88b+8
 exB2uUu/Xzr/0F0QSJGT6KVPPYZdbKM=
X-Proofpoint-ORIG-GUID: PRmzXn9LSRHqbXWc1jIN0bS2d_G49ZZk
X-Proofpoint-GUID: PRmzXn9LSRHqbXWc1jIN0bS2d_G49ZZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX2OOeVq5kr0q9
 j9RNP9TNDJGK734GVSyL8PwNt4UfDdcUASQbRzUba3o+oTMXbQloQ/xMWZ5zu6596loFJP9Pvow
 KhF/L5WAK4Hleqx2Yur9xDRU+pNXxOrOV+IGFyKCwWbtqHyfrAP475W73LRr1yFTORBuU9eFdfs
 MMvBeQHesn1ECxNs1CjQeHmIdqQIGU2zHrkr5lhytjlbwBJbmgbHYNAmb/nQakLQtzyLG7gUjnP
 Iu/9SRIWi1iGKXdSFa+S/tsVGf9e+YDHdmw+C5SFYkvyWW4LSM5Fybuq2OtEYCrmy89Rk2J5Hlz
 iGtTyFa6I3AlBeRFUap8xVn0+PhOgrrPXc/KSSvaSJA2nH3QqQhs9RqEYxrZv/Xu+zZhkRgFm+A
 00zguQobqjHqk1dRRXsKhkzE/VYoupb44/sDMT9jEx1p+TMjblZR8NeYv8EvkJgyaV1QR9hQL2k
 DwM0NPj2cVDNWWPmgFg==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab517d1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=DCGDLcMwuHKad74a2KwA:9 a=wPNLvfGTeEIA:10
 a=3NKNv0CXayPCOFLLcBMA:9 a=o1xkdb1NAhiiM49bd1HK:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240051

--sUjn4NdSVny70mPK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] stmmac: exact-match coalescing logic skips TX completion interru=
pts
> - [High] stmmac: missing memory barrier before setting TX OWN bit
> - [Medium] stmmac: XDP frame check removes SKB TX threshold reservation
> --
>=20
> commit 4955fe9fec58eed4009939eaf9ed4fcf2a742ee7
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: stmmac: add XDP multi-buff support for TX side
>=20
> This patch extends stmmac_xdp_xmit_xdpf to transmit XDP frames with fragm=
ents
> by mapping and programming each buffer into a dedicated TX descriptor.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index bf9e7e4cb1c31..41ccde6371ecd 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5239,77 +5239,114 @@ static unsigned int stmmac_rx_buf2_len(struct =
stmmac_priv *priv,
> [ ... ]
> > -	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
> > +	if (stmmac_tx_avail(priv, queue) < num_frames)
>=20
> [Severity: Medium]
> Could this change lead to TX ring starvation for standard SKB traffic?
>=20
> The STMMAC_TX_THRESH check was designed to reserve a portion of the share=
d TX
> ring for standard SKB traffic. By replacing the threshold with a check ag=
ainst
> just num_frames, heavy XDP loads could exhaust all available TX descripto=
rs,
> potentially leaving 0 descriptors for SKBs and monopolizing the TX ring.

ack, I will fix it in v2.

>=20
> >  		return STMMAC_XDP_CONSUMED;
> [ ... ]
> > +	tx_q->tx_count_frames +=3D num_frames;
> > =20
> > -	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
> > -		set_ic =3D true;
> > -	else
> > -		set_ic =3D false;
> > -
> > -	if (set_ic) {
> > +	if (!(tx_q->tx_count_frames % priv->tx_coal_frames[queue])) {
>=20
> [Severity: High]
> Will this exact-match coalescing logic reliably trigger TX completion
> interrupts?
>=20
> When transmitting XDP multi-buffer frames, tx_count_frames increases by
> num_frames, which can be greater than 1. The modulo condition relies on an
> exact match to 0 to trigger the Interrupt on Completion (IC) bit.
>=20
> If num_frames causes the counter to overshoot a multiple of tx_coal_frames
> (for example, jumping from 24 to 26 when the threshold is 25), the IC bit
> will not be set. This could indefinitely delay TX completion handling and
> exhaust the TX ring.

ack, I will fix it in v2.

>=20
> > +		struct stmmac_txq_stats *txq_stats;
> > =20
> > +		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> > +		stmmac_set_tx_ic(priv, desc);
> >  		tx_q->tx_count_frames =3D 0;
> > -		stmmac_set_tx_ic(priv, tx_desc);
> > +
> > +		txq_stats =3D &priv->xstats.txq_stats[queue];
> >  		u64_stats_update_begin(&txq_stats->q_syncp);
> >  		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
> >  		u64_stats_update_end(&txq_stats->q_syncp);
> >  	}
> > =20
> > +	/* Set the OWN bit on the first descriptor now that all descriptors
> > +	 * for this skb are populated.
> > +	 */
> > +	desc =3D stmmac_get_tx_desc(priv, tx_q, first_entry);
> > +	stmmac_set_tx_owner(priv, desc);
>=20
> [Severity: High]
> Is a dma_wmb() needed here before setting the TX OWN bit on the first
> descriptor?
>=20
> The new logic loops over fragments, calling stmmac_prepare_tx_desc() with
> tx_own=3D0 for the first descriptor. This effectively bypasses the intern=
al
> dma_wmb() inside stmmac_prepare_tx_desc(), which typically requires both
> is_fs and tx_own to be true.
>=20
> Without a preceding dma_wmb() before manually setting the OWN bit here,
> the CPU might reorder the write to the first descriptor's OWN bit before
> the writes that populated the fragment descriptors. The DMA engine could
> then process stale or uninitialized memory.

I do not think we need dma_wmb() here since this is the same logic used in
stmmac_xmit() and the barrier is already in stmmac_flush_tx_descriptors().

Regards,
Lorenzo

>=20
> > +	tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
> >  	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > =20
> > -	entry =3D STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
> > -	tx_q->cur_tx =3D entry;
> > -
> >  	return STMMAC_XDP_TX;
> [ ... ]
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260923-b4-stmmac-x=
mit-mb-v1-1-a71a1c522142@oss.qualcomm.com?part=3D1

--sUjn4NdSVny70mPK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarUXzAAKCRA6cBh0uS2t
rE2mAQDUWRyR28r7qW9noRVrFq+1hrbppbhjx5CFpQ4kZUMuogEAqHYdpXIxc76u
XE3fBz00QLmevzugPas9/IkBIRK+lAA=
=JQJ8
-----END PGP SIGNATURE-----

--sUjn4NdSVny70mPK--
