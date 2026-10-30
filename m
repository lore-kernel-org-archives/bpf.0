Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350803;
	b=0IsRXTEe+thUrWahg8OhsMg+0hXamXBKw8to17WWdI2QOAGCM9vRfR3lnN6Ny8m1xDlW
	 VZ2w8eC/Jwe/TkfKWtYviqDyRvnydcPmboM2ZMZ/7YyNswaOlpizKpQ6B+iAJCDLn9dFF
	 4z6/++2868keFUHb/drBgqvttae24jvkKKIzL4ky0xd9nWlOlS3vJOpF0jwshpsUnUrB3
	 /1GEd8X3p9QUjkpkSCtGmb4xgXWrR48L7TJH9pY5IiBaOJ2dXxqXpZ4gaT8JI+67qK+VU
	 eUtMh3QjpuZZgWc5BvBwuSOzyveVJ/uFdG2XIVLyQ66CoiYdMMH5aH8qzHSuXX8lZ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350803;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IN1cRYMXslaLOWD/XJso7X64D5iaGsH1cQZ8xvAIkjM=;
	b=Rheiy/kLh/FjiBA8W+vrMbaBaDAxxD50DmntVsQhFH6XESOalw3sRNFk/2k2F+u32IRw
	 yf2orP5SwSzPcnBtYB6lFRy7V9xty0EwBlAgB6fNDFH9on8HyR4Z6aOL+af90ir+2Rhjo
	 BTQssGisPuwJaYKYQWqgqNcoCtdmfTlmCvc6Plq4qe0wfi3yENzM6gg1Eh1FgF6X9XSg4
	 Pq30SDxtwEONlr98k1vLEwppmyirTI4UcPwiwm9ZdoQR3tMiciDL1H6IS1Ul8yAD9FHAi
	 izjheuh70ftPanqNpUHplwhnbT+945dPi3W5uyDOwcOSglZK6bBr6WIv6JL8o5X6fhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkKpHdH4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="DqTNp/Ak";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A889606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A889606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkKpHdH4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DqTNp/Ak
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F9wj3267864
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IN1cRYMXslaLOWD/XJso7X64
	D5iaGsH1cQZ8xvAIkjM=; b=mkKpHdH4u0B8ifdJbKFswSaIYOB6XARZRJDv/Y/s
	4gptz9U2oiITBuMCa5m16soNJ+5Bd6qKHBN8mnU+iRLdXqEe5k9DH75c5ogGMuqW
	knz92NDRhvVWyUrX+7fNXCvaMoBDeZaWJUxxTyKdXi4f4rw2q78ouXaEI464cfzT
	cB8TqwBHvXl6dcdLycYmnEGUEAkVLlE68y2g4cSRF5V+3dks6b+bWEecCvv0Euld
	i2FgcvrzuDhw8MOQAMynb99WYTJEwqwKCNIKK+ODZlrxC0n5A626nkXmQzU0Ew+R
	XJVPT2wDz1GSWjjOVc4zabM61Ldwe7Mgq++Spqzvl7s4oA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj4v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:59:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so114341985a.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793350791; x=1793955591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IN1cRYMXslaLOWD/XJso7X64D5iaGsH1cQZ8xvAIkjM=;
        b=DqTNp/Ak4HtCcRRy1WVbmSo98YG4/qsLndPyzT3y16RDKDX4FQeqFOQYiqvCww52ZI
         W98Im7UywVT4/8A9wpNOsNKLl3B3vAZBJrKrgpkbn1/WHCborAxfp/0PlJQ3xlI0I0WM
         5gnB18xqNSDNAtbMOkiGUUzFABcpQi+XBMxpmxGpqN3gnGJ1qGMJIOJqoXeuzzMaCN+C
         Zd2q0alJt1gDYVjBWduljH34Qc24nLI4S+s/9yGTb6OcVn6n3/ySqOUeL6SX0zGSOPtC
         eOSuJ26l3g871Zva692dRxcfW+ZOAveOyKqAd7sS4pn4U3AOuQ1TXEMbegpYW5026iEm
         wxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350791; x=1793955591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IN1cRYMXslaLOWD/XJso7X64D5iaGsH1cQZ8xvAIkjM=;
        b=rJLG85FqFzwq+c3oz2DKsssurErHIkLWY/J7dUQvHheN5ELY047DUw2gKiCaxfJvFH
         u3ru8U6xyPhuCxNM/iXt6PnTx1VCNpW+JM+LTCnl4Jc1u2xVJUDDsvE0hVl4sYW1ZPeN
         X40LlkBml22i1waaL/wZvJC/KlulfozMh9B+STjYZ4+8U3jhXEigssHLj0wdG/1g+OVp
         776/R50LwbHH+v1UCfYvKB6W/4PkvNWDPkjYRnlB5IsXbOjPbGUo0NCq7TLqUAmDoa0W
         I+jku1UDtaUczwMHyIU0Awjt4Rs38L/OqlQHFCnkjMvqfJsKEmSQRfTqfM7VhyLJ78Ia
         LzXA==
X-Forwarded-Encrypted: i=1; AKwUvBxW5p/mwL4vwgEkpKpnhJyIPf1ou5/8+ekDoOIegxw/ITbL/cxKcfi+byGo3DI+dhDYP/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/1vhvGSYVkvaiRiNKa3TA1WGNuBC78zk0gx0RUkuwLuQl4B3x
	Ww+J+ajFxUGwQKz0eHMknsPzA9JMfaiW0DV5Lc3+Wez1CrXydjNdeyv6LWVoa9o/XFAYVHXqa1x
	ATF1NAANwAm22BoLVmi8LAZc9E9ljD8o9kHv1KXPowWp0VRTZTRQgnBY=
X-Gm-Gg: AYBFou0vUdKCRjt7QQ5wg045tKihQai7OqWaZv0NsjDGB6AYq1qN6SnBFWyGVl8Uggz
	ifRhyQGIt/9j4H9YGCvx8UjWhot6mp/qG9veAwNnwcK2LnoaBQYJuKAA0z3o/VG5EKWBqdnWLQy
	wGjsCx+TwYVmHqoHaUHabA0x9U4COQoAkeWylEmPGlRxc6ZOPEn1G7iYBkowlj0E9ezHj8Kk9kT
	Lvbm2yaV5wi+o1WHXfBwYlX2P5ZeVxVRepaJLaU3UExp6nM1fWq78scbEUJPt71KzFq6hLB9dZe
	E3/enquRkvzvTDtQoIAmrDqgK2iKZzzmaXONpYl2zWDd67B5d+iGw4NOOq1SmRdAKpuXxAmkTci
	l6JRLcImJvaT9CggUbuYPEOthxrKp4pNC+W0u1nOSxSn0E089hFoS6c0Fyixt6fJuYGhArPQWcZ
	ySVJZAhN8gbmU4NmK3li0QrQ==
X-Received: by 2002:a05:620a:1793:b0:93e:5e2c:8c12 with SMTP id af79cd13be357-944216f3483mr286031285a.60.1793350791026;
        Fri, 30 Oct 2026 01:59:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1793:b0:93e:5e2c:8c12 with SMTP id af79cd13be357-944216f3483mr286028585a.60.1793350790377;
        Fri, 30 Oct 2026 01:59:50 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm2226954f8f.6.2026.10.30.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:59:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:59:48 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, o.rempel@pengutronix.de,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net v2 5/6] net: stmmac: fix VLAN tag stripping on short
 and non-linear RX frames
Message-ID: <auRchAkgHoxo5QRW@lore-desk>
References: <20261027-stmmac-xdp-fixes-v2-5-10eae8a093a8@oss.qualcomm.com>
 <179334662692.3134.6357778981334990835@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ZmHyaRVMzZDh8qZ6"
Content-Disposition: inline
In-Reply-To: <179334662692.3134.6357778981334990835@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNSBTYWx0ZWRfXyGa/+Ipp0D8u
 rMFvbt+G7vVMlXdNXoDhWibsztYuEGo1bwHHmDvYMItWu16/FUvAfUbFHiSiDNyJmYR5JlEUI+4
 5UtHut23g0tYHEuH3ONulyWIuKJ2N9wvjn2bBfJ8Ud+6C/p0s8aILbEAkuIRLxOz5JisnAqKjdN
 ZcOhmwkGiRug81NT4gv8QQ+U54JExyk6DPI1IBChDU1+8gfGOAvehYZ++1DFpG+4TF0vGO/L5nC
 0cwx/my0/R5bAHC7KKG+Glh5fC+70kMBe0yuLu1DVAnUdiVdfvgVw4er0CChennzB+RNG/uPBdT
 8wkjPhZR8sfssngr1G/AdK7UjlxSiJZAPdMGZuTDBdfiRK2pN//spDSwCEbFbTy2Uxc9D+qB4n0
 VCUeo9NyMBb8Ve3eHptGWnLg1MOCqYRZo0KbZEB+BHYoHbEY3rnpNsJsONC5ndBs6qrjPolPr8s
 D6jdc1ktyEOmyzCnT/A==
X-Proofpoint-ORIG-GUID: t6Ko49xoau14-VmFb9p7E4w4ZGXZ3dvx
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae45c87 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=UbPfPrF9B-iEU43lY8AA:9 a=QEXdDO2ut3YA:10
 a=BEuUwkNlH8wHWiov8BMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNSBTYWx0ZWRfX8QaVzo0bSB9o
 MHYJsHp8CjZX/EEniNPcpDtJdnb5YLE53xsDTh+7B9NNUGON8HiI69OI9mzA32iBp0aUAbLgvUA
 +AmsLrkEiItYXhrBvChFNvhd3MJ+fvY=
X-Proofpoint-GUID: t6Ko49xoau14-VmFb9p7E4w4ZGXZ3dvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300035

--ZmHyaRVMzZDh8qZ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message says the VLAN-pop code now moves the XDP
>   metadata written with bpf_xdp_adjust_meta() along with the MAC header,=
=E2=80=A6
>=20
> Pre-existing issues:
> - [Low] priv->xstats.rx_dropped is a single device-wide unsigned long
>   (struct stmmac_extra_stats, common.h:240).
>=20
> --
>=20
> net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
>=20
> stmmac_rx_vlan() now pulls ETH_HLEN, and then VLAN_ETH_HLEN, into the
> linear area before it reads the VLAN header. It returns an error so that
> stmmac_rx() and stmmac_dispatch_skb_zc() drop malformed frames. When the
> tag is popped, it also moves any XDP metadata together with the MAC
> addresses.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index d9fc2464a160a..fb3b7174599e0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(=
struct sk_buff *skb,
>=20
> [ ... ]
>=20
> > +		__be16 vlan_proto =3D veth->h_vlan_proto;
> > +		u8 meta_len =3D skb_metadata_len(skb);
> > +		u16 vlanid;
> > +
> >  		/* pop the vlan tag */
> > +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> > +			return -EINVAL;
> > +
> > +		veth =3D skb_vlan_eth_hdr(skb);
> >  		vlanid =3D ntohs(veth->h_vlan_TCI);
> > -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> > +		memmove(skb->data - meta_len + VLAN_HLEN,
> > +			skb->data - meta_len, meta_len + ETH_ALEN * 2);
>=20
> [Severity: Medium]
> The commit message says:
>=20
>   Also move the XDP metadata written with bpf_xdp_adjust_meta() together
>   with the MAC header when the tag is popped, so data_meta still points at
>   the metadata after eth_type_trans() anchors mac_header
>=20
> Does that hold for frames coming from stmmac_rx(), or only for the AF_XDP
> zero-copy path?
>=20
> On the page_pool path, the XDP buffer is set up with meta_valid set to
> true. However, the XDP_PASS skb is built without calling
> skb_metadata_set():
>=20
> stmmac_rx() {
>     ...
> 	xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> 			 buf->page_offset, buf1_len, true);
>     ...
> 	head_pad_len =3D ctx.xdp.data - ctx.xdp.data_hard_start;
> 	skb_reserve(skb, head_pad_len);
> 	skb_put(skb, buf1_len);
> 	skb_mark_for_recycle(skb);
>     ...
> }
>=20
> napi_build_skb() clears skb_shared_info up to dataref, and meta_len sits
> before dataref. So skb_metadata_len(skb) is always 0 here.
>=20
> On that path, this memmove() does the same MAC-address-only move as
> before. The metadata written by the XDP program stays where it was, and
> TC/BPF sees an empty data_meta range.
>=20
> The only skb_metadata_set() call in the driver appears to be in
> stmmac_construct_skb_zc():
>=20
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);
>=20
> The last patch of the series does not seem to add another one either.
>=20
> The missing skb_metadata_set() in stmmac_rx() predates this patch. Still,
> the Fixes: tag points at 5fabb01207a2 ("net: stmmac: Add initial XDP
> support"), which is the page_pool path.
>=20
> Would it make sense to add something like
> skb_metadata_set(skb, ctx.xdp.data - ctx.xdp.data_meta) in stmmac_rx()?
> Alternatively, the commit message could say that the metadata handling
> only applies to the zero-copy path.

I agree this is real issue and it needs to be fixed, but it has not been
introduced by this patch and it needs to be fixed with a dedicated patch.

>=20
> >  		skb_pull(skb, VLAN_HLEN);
> >  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> >  	}
>=20
> [ ... ]
>=20
> > @@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmma=
c_priv *priv, u32 queue,
> >  	}
> > =20
> >  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> > -	if (priv->hw->hw_vlan_en)
> > +	if (priv->hw->hw_vlan_en) {
> >  		/* MAC level stripping. */
> >  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> > -	else
> > -		/* Driver level stripping. */
> > -		stmmac_rx_vlan(priv->dev, skb);
> > +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> > +		dev_kfree_skb_any(skb);
> > +		priv->xstats.rx_dropped++;
>=20
> [Severity: Low]
> This is a pre-existing issue, not one introduced by this patch. Can
> updates to priv->xstats.rx_dropped get lost here?

This issue has not been introduced by this patch and it needs to be fixed i=
n a
dedicated patch.

Regards,
Lorenzo

>=20
> The counter is a single unsigned long in struct stmmac_extra_stats, shared
> by all queues. Several per-queue NAPI contexts update it with a plain
> read-modify-write:
>=20
> stmmac_dispatch_skb_zc():
> 	priv->xstats.rx_dropped++;
>=20
> stmmac_rx_zc():
> 	priv->xstats.rx_dropped +=3D rx_dropped;
>=20
> stmmac_rx():
> 	priv->xstats.rx_dropped +=3D rx_dropped;
>=20
> With per-channel MSI or threaded NAPI, polls for different queues can run
> on different CPUs at the same time. stmmac_get_stats64() then reads the
> counter without any locking, so the reported rx_dropped value can be too
> low.
>=20
> This patch adds another writer that follows the existing pattern, and the
> new VLAN drops in stmmac_rx() go through the same shared update.
>=20
> > +		return;
> > +	}
> > +
> >  	skb->protocol =3D eth_type_trans(skb, priv->dev);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8%40oss.qualcomm.com

--ZmHyaRVMzZDh8qZ6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauRchAAKCRA6cBh0uS2t
rPDtAQCRZC6vex/rA1vhvQbGMOSOvwcL944N6j99hYdaCYyoUwEA65DD+bU0TMnF
Rv9O/xkuroJZ6GZrRz7N5RNV8mY2JQE=
=ynt4
-----END PGP SIGNATURE-----

--ZmHyaRVMzZDh8qZ6--
