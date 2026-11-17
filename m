Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920139;
	b=lNcbSxfdTan2cQxNmJfTaETkP1JDMG3dq+Q6iCHcQNeXCF8/bmAMhrNLv7eyGsADA35l
	 VCK8TbBfWX3102Jr33gxU/ek7XlZ+m81mOT7CeUzNfJKLOcbwP1FdhMQT14vMXBXPFBp1
	 +zQIMEhuwBHedAdEH1oVSwyhSfuFRyW4wxXLOSPUg0ttUNWkpFp0EeX5JIdy7jn7agmwN
	 PMUDF42DcKzadUrYe0IGtsht+oZ9VZkuFVtvk3xZC7NGXns0/P3f3gNwJnbBOBpM+ynl2
	 dR0njU5JqzQuhHdlJiSZ/9KZzgXiVhNQI4G4KMiO+7d0DXbxtHOxg2YHBPKpIdqDOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920139;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Z4dX78GuYSiPqA2FlATo7FmVUT99P1UESYr9b7xa8HQ=;
	b=r92gWCwtGy8B15U/dYF/x4rkqwKb8Jv2MSpfE+Kt1KDWK7yJTcMKglGpHD/Irds8NR8T
	 yWmkYaVzxCHJ10EUPa/CjCebmVp1q+vi80iufR/40aGBFS0lIuWL2YNXl/Vib20gbCNrh
	 7uVokPFsVcJgVJEg0q3wwqlymrfhUaJU2V64UwEdsywyKmhjeghtzQFinwUAYPSL0tUt3
	 5YPttuUBX9RzZMTRTxgmrOIyXNApfISDZfxKPt7GyfVtUDsi7YeKBFDi6yJBlrSiygMIF
	 9wz8p3Dk4fpoEognRYgw+dQ1Ks/wcpMPggja0SfNq9MZH/P4ejQ/sebo4q4qZB5WULg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVu1Zs6O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SrP6a0mJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510A606A323
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5510A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVu1Zs6O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SrP6a0mJ
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC1w0i4188000
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z4dX78GuYSiPqA2FlATo7FmV
	UT99P1UESYr9b7xa8HQ=; b=UVu1Zs6O5pjQrgl8jVoF/KSh952CKn4Mxao/SNKs
	kqd8b2qwDynvMxUsmaLrYj6z2BVYlmzQLy+CMsa5df9q5YFmgNcD88e53Vl3WoAu
	jiOj3LPr0c3oRHbnw7Xuu7bifE9RYQ/7/MCa3H8UEMqxMY1e/Zn6cAY1UfBlSiXx
	E15H98yH5J51/dNLeorOkf6Rpy7dzNn5KZtDQQp2WnPb6nbgReyzSmSvVjO7q0HS
	fK5bJhNLcfvjKzhKbTPRpWQuKkx/iLoJVzpDaSaRdxscycDH0+UVJvdMUFsc1gu3
	eGkWUBMWQUfiWLeFIksrtmBIBLh/ZJPJIoYhq7woprUJ7w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m0b5tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:55:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495dd0f07eso803724985a.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794920136; x=1795524936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z4dX78GuYSiPqA2FlATo7FmVUT99P1UESYr9b7xa8HQ=;
        b=SrP6a0mJSjBcZuXgQDPpoOBc1I7pTOgrlj+E10MHI7O86ryc4KAdBLQoEI/m0X5QUy
         E7ff4E8yBebQMVr5Pv9TlIallK+5Z1Ow1/E+v/08Zu8GeecnbPcLZINDMFnVaqdjTNge
         CyDcetpJ+mgT92eQZNRUcjenXefnimtgvhmy7JYmy6ONktL1lDcX1lL4F66F1oRioQ/5
         ybj2VM3PJtpNLT7zwxKlU3BtmgejzmBiR+g0+zcePAOQMpb2SfVey/CcsKfSvrRwWSFC
         tBACEOAeZYYIh9wT5W/3MUyBhsi7lJZVd+HY7MOjQIsbT6v0IjRmnaoa4HjfXwNv6jt3
         KvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920136; x=1795524936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4dX78GuYSiPqA2FlATo7FmVUT99P1UESYr9b7xa8HQ=;
        b=uNFi614pz5MIP8w3oHjHVSzENnWdZPdG4Q1YC22rFXa1VR7HtTP6Dms5nxpwKA7iay
         xrPQxMp0zaWiKhRBk6sqxsZFOxE4tNltiN6l08Vcp0Mvq/DMpouIROgSfhUiOFMpe85z
         GnGVOnXRNN555t545KA1LH7rDMBJ8N5BbumocWQyaiQGyOtKDtQuTGhU9XJujOvyHJ/a
         Y2AwU+pHiovYRJdvuB2U/PnBt7S3s2hpLE2ZQJrfNhGmlOMKLukhyQ6G1fHPDsrXiKb9
         ffoIN/R3nsPl+mQ1qoMRR4PMuD/qpzRIe+/lIHvCoizFZwaxkK+uNjtMjWKinvP0rha0
         LqtA==
X-Forwarded-Encrypted: i=1; AL+hErHpOUUbuZtNSrgjnxYnJuezQHI5eM7SyUIQmeLJMIR2lb16wSZl7wPxx0n1pbJcGr9Yr74=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pAFT8Zke3PjDtgUtONbjMwyU5jmKUBnDraLXTPLIorOWeIOUR
	4uHrf21XFnoiK/DUaV47yElwADEZzFgsKYMDZvoBX1Ue7pndb2PAHDMGac6vdUkG7tsW6h6lv6k
	1MFhCxB0WCprWO8930z6VZ6bMLLCrPs8yAjCnUqHRT1Qts1MDuteSLm8=
X-Gm-Gg: AYBFou0UIFP3hBXMmKGgfmjUkTDLFU/YVMOraltbyEFdZFtLY/yW6fD/nIys6FImK2v
	8LyxqlBxWJSZ0nWTs3BjV/eftpcklKTOt+aNmlkPS+yw3JIZmd85DQzx9hmMLjLay08QVinU/5Y
	5xSGXj1qaMP2jBWtOrt1+LcqGp2uZf0/BzKpPbC8CXVHznx4HJzF6GR9l5a5r0nobtJuMcXx868
	hMRXaYsHTtsJ7cgyjUeWmw25kMuiuOL8lYGWSeszPgFiMi3nArnY8YASz7ZjmgWgNkVQi6heeSL
	oldWWs7I2hO3o1Kkplmi4f/XGhU3y6hmziD76Oyu6BP3/NMbHRF91nV336s0ELOhHQplOzFkEha
	6aP4IhYNEr/rS4uA2Er6P2MMQVpMdVUmOaupr5pIIFUbzA/iZ9GsaClbI+LddxU8=
X-Received: by 2002:a05:620a:2a14:b0:93e:d364:c9fe with SMTP id af79cd13be357-9494bbcc105mr2188192785a.40.1794920136203;
        Tue, 17 Nov 2026 04:55:36 -0800 (PST)
X-Received: by 2002:a05:620a:2a14:b0:93e:d364:c9fe with SMTP id af79cd13be357-9494bbcc105mr2188189285a.40.1794920135649;
        Tue, 17 Nov 2026 04:55:35 -0800 (PST)
Received: from localhost ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm5159093f8f.58.2026.11.17.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:55:34 -0800 (PST)
Date: Tue, 17 Nov 2026 13:55:33 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, horms@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        emil@etsalapatis.com, ihor.solodrai@linux.dev, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        nb@tipi-net.de
Subject: Re: [PATCH net-next v10 1/4] net: xdp: add
 __xdp_build_skb_from_buff() helper
Message-ID: <avxOxc3sU3bd29-t@lore-qca>
References: <20261112-stmmac-rx-mb-v10-1-d3d04b65c6bc@oss.qualcomm.com>
 <179484961485.3136.18371294575845722948@kernel.org>
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
	protocol="application/pgp-signature"; boundary="IgpR4FCbaFWOr+d8"
Content-Disposition: inline
In-Reply-To: <179484961485.3136.18371294575845722948@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX1iOaIqEglPo1
 Z1BgQR4PNrp5YyzW/t7yKmHX1jm86SfTIZgNF0G1J8N86mjnoN6ZU4IBCLStSa2NKO2CbtRY+fl
 TzBN5mDjps7pNclwtQhAcryP39KzqJg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX1G9HCPb4LTFo
 zVcxQEW+E1mMy1DnOLgmf5p2HXdyITY/DoI/NHHC1h0wGFSCX2XMK42Mrwtz/udZbI8d0LqG1CV
 oDH9MJSzlXVp+VDcngIYAt/aHb7tzQwJjkzRD6xkFa9bfg7MwqlQ6VgvmOgrUAjDRFPyp6TPjjt
 UTcjZB4eJrXWy5hDSYLz47cb9o6p07iUh+ckRkhjOw8gEahDElC760m4dHFLFndkKrHNM4I/Ik1
 fjeLISae/c6qJ3h7wosELEBx9QQ0am5/diV/l/h6XEFCHkD03URdetB3AfstX1S76cT7qw64RXt
 rfIdSWuHsa761Oh4rzsiwfdgIbDxBKDsI7gWiqNfQI8jl+kokFk7fZk4Vldozd+XW6Cl7Sbq9cW
 oZQLOtIPVMNbKr6PaPYzV5csyqr0XQXSUqgnPqP5CGitQGfA1/aigvzQPYUQGv5pJIHe1G+FGfJ
 cEvORAJg2XbMF2LCA3g==
X-Proofpoint-GUID: EoiYTZIjxkG_wGjznq-cCYtzMkzzYSQZ
X-Proofpoint-ORIG-GUID: EoiYTZIjxkG_wGjznq-cCYtzMkzzYSQZ
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc4ec9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=--SqLFdaUOMV0DsZRZ8A:9 a=QEXdDO2ut3YA:10
 a=CvoAkVhk7Y3g_VbaP6MA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170051

--IgpR4FCbaFWOr+d8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The kerneldoc for the newly exported __xdp_build_skb_from_buff()
>   (net/core/xdp.c:622-633) says only "Protocol parsing is left to the=E2=
=80=A6
>=20
> --
>=20
> net: xdp: add __xdp_build_skb_from_buff() helper
>=20
> This patch splits xdp_build_skb_from_buff() in two. The new exported
> __xdp_build_skb_from_buff() builds the skb without calling
> eth_type_trans(). A static inline wrapper in include/net/xdp.h keeps the
> old behaviour and still calls eth_type_trans(). The goal is to let stmmac
> process the L2 header (software VLAN) before protocol parsing.
>=20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 1d679e8fd6493..470bf90d93ef2 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -620,17 +620,18 @@ void xdp_warn(const char *msg, const char *func, =
const int line)
> >  EXPORT_SYMBOL_GPL(xdp_warn);
> > =20
> >  /**
> > - * xdp_build_skb_from_buff - create an skb from &xdp_buff
> > + * __xdp_build_skb_from_buff - create an skb from &xdp_buff
> >   * @xdp: &xdp_buff to convert to an skb
> >   *
> >   * Perform common operations to create a new skb to pass up the stack =
=66rom
> >   * &xdp_buff: allocate an skb head from the NAPI percpu cache, initial=
ize
> >   * skb data pointers and offsets, set the recycle bit if the buff is
> > - * PP-backed, Rx queue index, protocol and update frags info.
> > + * PP-backed, record the Rx queue index and update frags info. Protocol
> > + * parsing is left to the caller.
>=20
> [Severity: Low]
> Does "Protocol parsing is left to the caller" fully describe what the
> caller now has to do?
>=20
> Moving eth_type_trans() out of __xdp_build_skb_from_buff() also moves out
> the other work it does:
>=20
> net/ethernet/eth.c:eth_type_trans() {
> 	skb->dev =3D dev;
> 	skb_reset_mac_header(skb);
>=20
> 	eth =3D eth_skb_pull_mac(skb);
> 	eth_skb_pkt_type(skb, dev);
>     ...
> }
>=20
> So the skb returned by __xdp_build_skb_from_buff() has skb->dev =3D=3D NU=
LL
> and no mac header, and protocol and pkt_type are not set. This is true
> even though rxq->dev is available inside the helper.
>=20
> The peer helper __xdp_build_skb_from_frame() still sets these:
>=20
> 	/* Essential SKB info: protocol and skb->dev */
> 	skb->protocol =3D eth_type_trans(skb, dev);
>=20
> As a result, the two __xdp_build_skb_* helpers now return different
> minimal skb state.
>=20
> Nothing breaks today. The only in-tree user of the underscore variant
> later in the series is stmmac_rx(), and it calls
> eth_type_trans(skb, priv->dev) before napi_gro_receive(). A future caller
> that does its own L2 handling and reads "protocol parsing" as just
> skb->protocol could pass an skb with no dev to napi_gro_receive() or
> netif_receive_skb().
>=20
> Could the kerneldoc say that the caller must also set skb->dev and reset
> the mac header, for example by calling eth_type_trans()?
>=20
> A smaller point: the public xdp_build_skb_from_buff() wrapper in
> include/net/xdp.h no longer has any kerneldoc. The kerneldoc for
> xdp_build_skb_from_zc() still refers readers to it:
>=20
>  * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an =
skb
>=20
> [ ... ]

I will fix it in v11.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc%40oss.qualcomm.com

--IgpR4FCbaFWOr+d8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavxOxQAKCRA6cBh0uS2t
rN8KAP9n5nAt1PRZw9UtpxsfE+nfrsPd8jBTaqd/v/2xmf0JLgD+LNQ8PQVLXBEM
4iO7vZYN47HIhryG3h5wueYeqlLIewo=
=S4jk
-----END PGP SIGNATURE-----

--IgpR4FCbaFWOr+d8--
