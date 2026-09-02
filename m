Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204B4AE8B2
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387865; cv=none; b=AxGVhp5rXN73BZGiwKaNCJKtdwXaIa6H4EGP2etzzXrx/QHTodqfINIdzau0FJIBRb0SA9ClqR04o6sHAZTeW+RcX+aIoJEddDPRWcSQ3+tpEOzMIJ/NyZKpwTmaPmwBW+/4b28yGwf+QnzYTee9+dL+VYK+rgTeDI4PpYXQAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387865; c=relaxed/simple;
	bh=Rz4totOzuCAyXVxPJQ7uOXwVilujvZOEhoS6wFuB4r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7JxML0XPHwioI6Zw4tIwFMBbwP/yx8K0/0zV7vJJ0NoESW2cS1t3ee9OSR9euNS7LPBeyKihjAHVRc0uSJ7yzW/iMupqs9wYfnITsDPKZr+MqYFqeS3pxmZml5Su1f3Nx83zmO/vnENXmiV7nFU4FsZOCr7IvdflxUSViw1Elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DB5w7My4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z0cjaCjl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DB5w7My4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0cjaCjl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHBX71899541
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 22:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=18vPnmJEZtEvBUuGwHJgoJZ3
	PhgzCYtMv1/K1VGThH8=; b=DB5w7My4ed+/r9Wj8JS6IRovwzDK5/P1HYQ36629
	AFmkuMI4wxbU5HGAVjmUmU840F4IUFC/Lb/ZLNBvMdAdOjgEPwotk0y5S+L9egzm
	5xjHVbwHQy5Fl2clS6ML53Q8EiOCHbiRMr2rCNNVmrt3dhBwGHUzL3p4ZZ7mFomq
	YgDcKNMx75ow0quXwvzLTHSVXZSyeKKUtUdjlNcXyd8Qp3nhwH9UeLNp6qvCbQgh
	/7NqhuLelTHZ3HlCktrPzXhma1HIM/JYm8oSgIL6QInEX4NWLFn3nwHdXOJ5Qqah
	PbfAADsj0zzjrqhfsTl6KNScP4fvqUjwUl3THhpLODeS6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemb02hy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 22:24:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e38fbc5so313821185a.2
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788387859; x=1788992659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18vPnmJEZtEvBUuGwHJgoJZ3PhgzCYtMv1/K1VGThH8=;
        b=Z0cjaCjlQYZjvzslYqKZ7SeTOFTHSlBBLDVSsn4kJSxHL/cwymhCTAMqIpmyzPfjzn
         /wD8GixXt2ql5d2ndAP9+GllVMD8MI2GJi80KzuKm3rvPo7jOQrelG+bZLlg9/xoNdzD
         CuwmloGEuYZwVudnMmhru2yKcc+jCBLau1e+VWBHe1tknKX5zcMzXI820LE14FVeGedH
         AUnCZqJ0MxVWuJ6Lcsg1nSi9khIKcQcTwexj2yQfc+EdgEbs+bBMRAMkxOtvgN+/I+lv
         yG6jDoO4d5+/d8JvT48iRL3QNcajBriGUNutRTg1Dy0ctbRNJYn/Sp3TjR1ZOF7p/LEe
         BpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788387859; x=1788992659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18vPnmJEZtEvBUuGwHJgoJZ3PhgzCYtMv1/K1VGThH8=;
        b=F3ExTcdYOWnBow598nGmdFjWUnnpQgX1ckuR0mX0PWdsMDMAR0NaEbPL187OnA0cRW
         lT0cMRetqCb/jkAx/ZY2XeMGT4SJJeXGfUx4UtUAyOdNgN0ObXlB6Ln8oinS7S+O792c
         dR/7RfFcXxkMcv7MT+D+UdLxxnFgCy/wN1Wl3Db+JF7DkDUFGqc0T0QfVTwJcCMqaupx
         qk7QInqQNYb2EIlLjk91sP6JzkKPEGkKkpK2FBjAE9sOTVZlyqyMq9V0GfOylnR5xhkz
         DvHGWOq1+BaLzNQIQ7M8Al5us9bYy3zWLPZvQQxVxi3D6os69Zi0QEYMBmz0f7vtQFMq
         LsTQ==
X-Forwarded-Encrypted: i=1; AKwUvBydfZjiqn7tqP27/p6WX8uau0j25gq5k9k3iD0DiRZ3N9zRoCWTr4wAB7LQXpIeLkhvXX0=@vger.kernel.org
X-Gm-Message-State: AFuF++kToSaKvu0XaCELpd8kExipGvp+wBzS5jacTUCSqrbWLrantz5N
	ZSeDWgA2jnfRWt2cVhKwxbiifIfRNQx5LKlkjdHvHZaJ8mBMSeecdse8J+ovco/o31+9NMgg8O7
	M/tjW7tUcFNfKOhxCZReVLE3VL8mf/seJRjHXOPXYO2f4ru+9Yj2Ihd8=
X-Gm-Gg: AYBFou2d89mSfvU5H5mOS0ymcQQ7GsF/ldgqivjydvwCgJkPj8zCae6C89wyy0rnMqt
	w37h+OYwtsjsMx9DBkuxh5wYCEn4fgn4/FwbC14OxI9dkiDyjsSRhEBas2+S+XuCUV5fF9VAZU3
	h7tsHJ+82G9EcxHuw2MjVQVGPUB2L65v5nygaLL59E8U7wDew5mN8+KDPAXwXDsml4P+yohI3R1
	7+7qKSvakLkOiQv19KRbW+2y47+i5xWNhhbE8W5YdiMwbzf3DgQebkMJfZV0P8HcM2x9fwHwhNx
	aqLV7S8wJYESlMvw97uqZQmcB0NbDc0KwpNDqGSupUhVcH9sy39kLJ+n4ChvYcq6fobyi+jqOLw
	=
X-Received: by 2002:a05:620a:4110:b0:939:639b:2e1f with SMTP id af79cd13be357-939639bdaf3mr827499185a.7.1788387858804;
        Wed, 02 Sep 2026 15:24:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4110:b0:939:639b:2e1f with SMTP id af79cd13be357-939639bdaf3mr827494285a.7.1788387858198;
        Wed, 02 Sep 2026 15:24:18 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d2019sm21672695e9.2.2026.09.02.15.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:24:17 -0700 (PDT)
Date: Thu, 3 Sep 2026 00:24:16 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
Message-ID: <apiiEIS2ExdBIPqr@lore-desk>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
 <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
 <apiT0ZrlBMF2k8qz@lore-desk>
 <ebe7d40e-4f2c-4c39-8d9d-ef588074154b@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uG7zYthDkJCX/Va"
Content-Disposition: inline
In-Reply-To: <ebe7d40e-4f2c-4c39-8d9d-ef588074154b@bootlin.com>
X-Proofpoint-ORIG-GUID: 3lmkYzM1xmtonlVUEDQV9kgCt_TTJ9qL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5OCBTYWx0ZWRfX4Ab0SK929pjZ
 R86elssT4guc7hrUn2nzeP37ickwBemg/WU+tPh0zaeyWJqjZkedNsALg55jzUFw+Puv3ylmGWF
 qaVUnJ7KOjPpEl7A6j5Yt2pRgRDtHKgEu4WubXhSRBX3L2g4+/xXqFo915vgM3izY/iu3e3TK32
 53RwPa5QFevXVvoHiQiiaE2wEvFDiXf/RSo5y3ZILFPUm6klXt+CzAk/OTVIVgQhQYC+S3/Ldvl
 mdCJNa25F5QoSdw9EvDorR3cDI8KN6qAxhiMCBWCNsTFe2qy06wm6ksbL3GmAmgkSOAj0KgY6Q6
 CKp5VCVotqsWG9Vn3ooavtTBr38X6USpmpXreS9d6PefknYDAsUS2tgKAfmGKRevgY9ugstVBqu
 9n6FQuqkuodW39TtQIG87uqodiM09eiXZsnWqA58JtOy8VQijPiI5MMV38k6H59icjteeezupDb
 1E7x3ZSu+k67YZtMQEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5OCBTYWx0ZWRfX6bAjsn2H/B0/
 c/RCP1ytVIbwcJMB9nzKmEPeWxSM2bOmJ+LgAE/p7CO21M325r4IZ14RUJ2z2Xgj33wvUnV6MFv
 bgKFmTXmFyWDptm7N4Xr+UgZzpY9KBA=
X-Authority-Analysis: v=2.4 cv=EuPiaycA c=1 sm=1 tr=0 ts=6a98a213 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=09jnV3MRIQTx9f2RKdYA:9
 a=CjuIK1q_8ugA:10 a=xbPlxFjQ-td3EfFMwg8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 3lmkYzM1xmtonlVUEDQV9kgCt_TTJ9qL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020198

--+uG7zYthDkJCX/Va
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> >>> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> >>> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
> >>>  {
> >>>  	int ret;
> >>> =20
> >>>  	ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> >>> -	if (ret < 0)
> >>> +	if (ret < 0) {
> >>>  		netdev_warn(priv->dev,
> >>>  			    "failed to enable PTP reference clock: %pe\n",
> >>>  			    ERR_PTR(ret));
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	ret =3D stmmac_init_timestamping(priv);
> >>> +	if (ret) {
> >>> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> >>> +		return ret;
> >>> +	}
> >>
> >> This can legitimately fail with -EOPNOTSUPP, we musn't failt the whole=
 open
> >> sequence in this case.
> >=20
> > ops, right. I guess we should just skip -EOPNOTSUPP in this case, or do=
 you
> > prefer to always not report the error from stmmac_init_timestamping()?
>=20
> The clean solution IMO is to gracefully handle -EOPNOTSUPP, here I think =
you
> pass it on to the caller exactly like you do (I don't think it makes sens=
e to
> still enable clk_ptp_ref if you don't have timestamping available), and i=
n the
> __stmmac_open() path you don't fail on -EOPNOTSUPP.

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> Thanks :)
>=20
> Maxime
>=20

--+uG7zYthDkJCX/Va
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapiiEAAKCRA6cBh0uS2t
rMpeAQDSlOGBUoDB8iAvL0AANqgwiQB1TA6IntKZ+pzplorvugEA+k+rry0HXitb
TP2XILNZCA5T3YbdGL2pMUmnfThEIw4=
=Q2Yi
-----END PGP SIGNATURE-----

--+uG7zYthDkJCX/Va--
