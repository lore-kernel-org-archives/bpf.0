Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502281;
	b=QiDxOwwtBSQiTsnKCr3efOEk9s+Q3WMQKXD/FiYN7aXlQMVOQvEKz2IuU1vpY7ibH9a6
	 bkBDexGJ4C7OYF7TMVyqhndXAU2Rg8UrXKvyvlECV8UiE8j0LBQ9npjmBRhN2HZi5+FZ4
	 MqceDHpxE4oEmbz0kthSg5bruq3Aa3Ji2J5hmGLeo5Ss7pu0cZdjxomChPRCu3HL+Embk
	 LQtTVuDh5/Y7ezZmqi263c6x4MXvbCu6THMBbfrkKNXLBxyH2wFBDj7nCuUifW/5IxN/T
	 SyfFIpa88/HV293Skg9JfPi0Cvn1OHyIePDl3rbn7mO/qWX7AqiMTKjiHhD8+Kb4kfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
	b=vp5QeZSsl88PBo548kipAQg7aPExOE8iuLdxeow5v0v4PFsOVATAis3cxTir0FURs5D/
	 izt74s6L5vTb47/ODQ6sjXNw7kp0/k5ZkYZ+J0+84B2HDfATGYeYpvEfdTeLYi/0Js4v5
	 emFVZLS3obsXpWSrVfkzdBVg+nFUuTZbmdItdUMi1JtGs4k3ydDzp+YbRQSOvqlr7mkNP
	 GoacbJ6rrwoZqlxaDI+gaW/Bx3qFkt6dAPLFc1LxBKe9IOBjifebgZ6P4ZoTcQ6/LWQBU
	 kCcBLHlBbPOLakJAyopr/dc/P1emswseg9Ru96M/GNsSRvOGTj0lKCV4rqhXyvTFkaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bl9Y6qAB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cEnB75tW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B00606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bl9Y6qAB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cEnB75tW
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA51E1575214
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L1RqAEfTuGbkvUdAUwAcy8yM
	Pvcz5IhXkDHeJXVKQMg=; b=Bl9Y6qABYgqtoQKdJHCs5a8sTn62iZskwg7QMeGc
	GCkh7xI6U9HoZRs+U7tPz9GDgH6zOUeA1Pbi5ysDD+6eaYqL+lcSu7NKK6G/SdSC
	lHGVcfJEW0l/G2f8m2S9z8ZHNWY/fwApnhSoGhVR5p+VDaNO2z+F4vZHkMVpBAnn
	ljXT/lvFInhxPmR6jsHemw/8okDM6Akx8i8e5Xg0s26YLDQgh9JMAUZ0Om2dGPpR
	H8yokCtISbqgiHZgAevMNbdrr0BTms/q59poNlWRNZKT9Abi0ZMctXpA+cSpTXDD
	y+d5uso3qLhrn6/TP4KfkOeEKo2DW+eVOcWglYqtW5FKYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2mbs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:18:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f322ef7d3so581203785a.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502277; x=1793107077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
        b=cEnB75tWH4EfwquJ97aclwRylWKx9b562mVL5dCMHthGK9g22UsjiYp7VW/BBT0rv/
         +oP2Iulr9HI2I646OzFdmnrWfDtMoCLgTX6IIJUrtdrVXwV2DTSEquHDYkYEo9s9pj7d
         57ZzW0QCeIpblN403ygp1+RW2DdYryoYlhmnNktCLWi51Rm/egc4M7PGRWq65bOsxZ46
         +vuhyw5JbzQCmylftTnrki52DgeHhB68McL+DmkavxhUk5Ixvwjqt2K7//P/AjyFl+Lr
         sm9gIlignJyP36sShcNswx4Z19rhAqIFrO62BquTyzcI/ECsgU6j7RA9ZuJIS9w/DYjR
         fYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502277; x=1793107077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
        b=Ugp6CYAD0WPdDOrE8X3ONarGvSmKeYKJNmqqOLoK+gcBD5kt8XjO/0NaVTok8ow2cL
         vS4vwwKA/yfKOyA+99M6bCFNFaoMmFh/AaYp3PdT9QPWrG2QjFI6k3lGekwVYi5kcQTy
         II/85F5mmuebdslqoSTcBiwB+xs8jEFjZ0TqQ3GSh+Zhmj+ed1CavfBGmqvVBsf6Oo1k
         dN8PYVjbDLYj6zlcmf2xDezX9Y61wpldxMuhcId/y5DdJlSSRHS9x28zWzJ0Fm7a9NKa
         iaSILnyePM7xNx2MMm+xIGgovxLwu2mT2wTM2tjCHFiWgzK+WkzRKZpB3Z58COIBEJLm
         C1TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdtYJXik3tQ0W6WC2ZCkQdl+v1+mV49+lfs3EKotJZeVJkcujsnWy1POnyBOO/gsvh6QE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdlrORd62fZIVM7aK77jc5JeduXhrEeeGZbYSLe0SOkIWajJJR
	h/hPoUaE6Gsi6UkPqucQnauwzn1cgTdYjj1JnVaRl4SptMxJc6DiHD1hXFf0PGhSVJTDdgrgSD/
	ZFII1dD1B6EYO8uKdBjmhpMXN19DCKMgziw5n9RgP4VzA1YdsQJCl8FkcKafHD2k=
X-Gm-Gg: AYBFou1kWfdRbO7DV5JiqD5dledVmtn6WxH7n7pv301rV2w71dw2CvEEbKVWXYcA/z6
	q3Ve0nFOtDQetMGvpej3u5C1KFbKfsehTdsg1R599x7gDpK0rx2mdVX80dPxay5j5cOdl8kxQUO
	IPTpiurTdks855VL6iSSbzWVVUcmL4TzbudvR/A1XK5QOHn3m4JhfbDGNZC0lbyuy+tSw7fDlKc
	pgxLcXj+E1APEyvU+cWCxZsr0w0MO7jlpekiOdn7pKGpO4c11XYf0UdW2WJhrsrRFdfniVrw6PA
	6CMRV4tLGlzBGdEAc4MzbGd25NC3U8AH65rxIaWf4f+LM/JD+EIegBfovHF4ASyZJIuHUec4LnZ
	FQCaw7kSYqHuO+g==
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id af79cd13be357-93f29ceec2bmr1774235785a.17.1792502274422;
        Tue, 20 Oct 2026 06:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id af79cd13be357-93f29ceec2bmr1774228685a.17.1792502273730;
        Tue, 20 Oct 2026 06:17:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817d8bsm5401884f8f.24.2026.10.20.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:17:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:17:51 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <atdp_0QJfjR_H3U-@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <179190522792.434549.2113659711683261245@kernel.org>
 <as5PVATLFOcTHbkV@lore-desk>
 <de6dc65e-04bf-40b2-b5e6-d7035d2f9b7c@redhat.com>
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
	protocol="application/pgp-signature"; boundary="VlBw4mY3Q/Sm2KIC"
Content-Disposition: inline
In-Reply-To: <de6dc65e-04bf-40b2-b5e6-d7035d2f9b7c@redhat.com>
X-Proofpoint-GUID: w_aM7CPOrwsiOpmY9tVhqc3wKa_CvtRd
X-Proofpoint-ORIG-GUID: w_aM7CPOrwsiOpmY9tVhqc3wKa_CvtRd
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad76a08 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=xPDQizAfL9ec5cwQt_8A:9
 a=QEXdDO2ut3YA:10 a=cxd64Jjv5Ts7904Sr0EA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX0iTqK82C6Pl+
 dBldxtBTEkuFp0CScRI7lpfhbVGruLQIEpDJPxIaXJDMU3taPsGAsaTfXERVlAMRkUM6cSneet+
 zruTW0DKVrWZWllxsdehr910lSOC7XK5MavkhyapoC+Rj+/PHwCEpn6PM5NcpfbL/eYNbVC10OW
 WWxIHAxiaywwsfSOJMXywQ/hRXmFVUZIRpNdcVddavN4hdxVALJ9Hljg+235t2mrSivKr6fdiIZ
 rKoqQ+cJCvcs623RxYu2fFB72v4Rz+dhIGeRS641Rt1uI2A76Mgb8eAIV8Dhr7eriqdg1xJ13AI
 AxqStcfUzG1GOJ79qL+Xc+zhw9UpX2Bq07p9uB6N/trrbmbdrBSr/lT0zdz1CE+E1y+6kuBlhlL
 uOG6saP2XeqIq/7nckZZbng886qRNc4iEXU1FDdzT7iRCRt/MZ5J8rCY704vw6ElDAAeRGRBoHq
 kbbFLohegZSUh0yoDgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX2GwnVjmIb78i
 rHEExRHi/235juW498mV+B0tHwyGbDLCVYXfujuzQeqRRrE1ZzgYeQKWq4cvpZzCF+X8xVuWFm9
 1VzhmtjiArMbYuds5HspKL2GdJpuZB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200052

--VlBw4mY3Q/Sm2KIC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/13/26 17:33, Lorenzo Bianconi wrote:
> > > Thank you for your contribution! Sashiko AI review found more severe
> > > issue(s) in other patches of this series. This mail is only an FYI, i=
n case
> > > you want to address the nit picks below when you respin.
> > >=20
> > > Low priority / nit picks for your consideration:
> > >=20
> > > - [Low] The commit message's premise doesn't match the tree.
> > >=20
> > > Pre-existing issues:
> > > - [Medium] This problem wasn't introduced by this patch, but
> > >    stmmac_xdp_xmit_xdpf() never looks at priv->plat->tx_coe when deci=
ding=E2=80=A6
> > >=20
> > > --
> > >=20
> > > net: stmmac: disable TX checksum offload for jumbo frames on bugged c=
ores
> > >=20
> > > This patch turns off TX checksum insertion in stmmac_xdp_xmit_xdpf() =
for
> > > frames longer than ETH_FRAME_LEN on bugged_jumbo cores. It is meant to
> > > match the stmmac_fix_features() workaround that the skb path already =
uses.
> > >=20
> > > > The XDP TX
> > > > path bypasses that workaround, so once XDP is allowed at MTU >
> > > > ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> > > > device would leave the interface with a full checksum insertion ena=
bled
> > > > on those cores - exactly what the workaround is meant to avoid.
> > >=20
> > > [Severity: Low]
> > > Can this scenario happen in the current tree? XDP still can't be used=
 with
> > > a jumbo MTU. stmmac_xdp_set_prog() refuses to attach a program when t=
he MTU
> > > is above ETH_DATA_LEN:
> >=20
> > This is actually a preliminary fix needed to remove the MTU limitation =
when the
> > device is running in XDP mode.
> The point is that this patch does not address any issues, no it should not
> include a fixes tag. I'll drop it while applying the series.

ack, thx Paolo for fixing it.

Regards,
Lorenzo

>=20
> Also a more explicative cover letter would have helped.
>=20
> No need to repost.
>=20
> Thanks,
>=20
> Paolo
>=20

--VlBw4mY3Q/Sm2KIC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdp/wAKCRA6cBh0uS2t
rFmoAP414FEDjStL4n4qvHemK+O+WXPITqOkK0QE5TTAxXJutgEA+GNB2i9SNe2P
Jm3Rh13AJigugNCR10M7PsREpZKSwwc=
=zatQ
-----END PGP SIGNATURE-----

--VlBw4mY3Q/Sm2KIC--
