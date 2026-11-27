Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773298;
	b=PfbeKiJkO/+auBBzsCW3X9//zbiUZZ1tBvtt+hi7XAjFDnc+IeL35H0N9vQcqMKKp0GM
	 ce+bc/Fg3RNuwpakhFLSpS77hCI8g6nVjSHuO1r+ajmB6qM88PcgkG8LILSd5aqZUrdkz
	 E4CIccxZgjc4oIRVe33wHM7cvgWC19eOQJnTcDaxR5uTwDirUIi3E35dcLxQJbmKhq8NQ
	 1algvxnVi+PdZHDbSziOojBUd0qRl3WS64Fyr4XoXxOKtZpNZqzfcT167CDy5coMwrQAN
	 xExCEo67blLchZ4Pqu65za2NyQMmpYZYGgFs2Tv8/5gA4YOPqvmb9D9+am7QZDK7n9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Kk7U2oDO3BkhHOVJXZPhVT8PfOsDLR12HVSj48QIZYY=;
	b=Hh9KsQ2yGElAoDNBUL8j1Ef+GCLcB7Y6oL/yI0RTmbRbd3FKWtMRiPFNQAzXVeMATuh5
	 VfmJRrvAnv0Du2G4hleaOOZOhuVW3AgEG+aFClmZoxnWvQ3luERDSh9Gmmg4P7ncBM8+k
	 pA0d3Ju666cxZChHSmk49LsYqZnY/UGUceDhWB/pS2baI9wZxyBABBUrz5z2te3dbpZxN
	 R/o0+82TmXaA+T0hdYr81lgryFxi/Ch+SjsXV02Qbi7/S8hiJ27i3pnIc6mooiULaECq0
	 9l6pg9loyZt10e9ZI++DzTpWD7ST5mLmAsrC5A2wpJYC976SFs649QIleeCAKKNVLFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ew8USA/R";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dgqHju7Y;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DD606A329
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E8DD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ew8USA/R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dgqHju7Y
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GQo41197178
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 09:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Kk7U2oDO3BkhHOVJXZPhVT8P
	fOsDLR12HVSj48QIZYY=; b=ew8USA/RPEBojo2SReGtP0RtUQB7fM+ugenv5twX
	WLb7x7LuuYa0oMmHg+AyJdvxRY+MHWhlCpd3Rq7WsYsakoG11PCc0Q1CO1IMHqIt
	z7kGyAYs8Zz3dGdgY89ZXGqxpyehEkdooAfxmgKQQLYm/XyFEUR7rEXTD4UcPUwF
	vs8XxZR507Le7ltaPG547WBYUOnGcOOVLn/JmwvgIwHC5jUpdN5UuJu3vKnQgy92
	jkfztrS46Lu/XbJz6L8iOjqia9EE1c2ABGNuGAp25H4qZlRAXX0OY0wPU3Bnl/EM
	bUA7VvRKP3FMwbW00wO+bSfq5JIZF6VIQi5Vr2uBRzhwlQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756k8npm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 09:54:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9495dd0f07eso1361111685a.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795773296; x=1796378096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kk7U2oDO3BkhHOVJXZPhVT8PfOsDLR12HVSj48QIZYY=;
        b=dgqHju7YGqTJ8yf62mgbtI2duC7t42cX0UmnjNFOKnYY4iHd7+G13IlnJcACXbshnk
         H3UG/VScHxRmnjJ+KK4pdRZKHs889tWYojvsCHhiBM31mcYGpZejjJkokqUyxcwnjt1m
         tq1zuAjbW1RIBK2hrGZis+zMDg8trtEIj7+JVKA4/X6Ca4qg9DNHNm6xW0cO5wUS4N1h
         Z9IAqegx4EVjUAM1GOfCjTEL/rJUgUYiL4dzjNrBIx8rTWSNHzfR/6+EnQ/OreIPKZax
         ncX9IzTRNwKve0nlQsoTpGsny9Rd5XNg1KEMXgPHRXAirtVWVMjP4QwjfSuwLPICUokI
         TPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795773296; x=1796378096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kk7U2oDO3BkhHOVJXZPhVT8PfOsDLR12HVSj48QIZYY=;
        b=t7h4TdROmj40e39XtBUA3ip3RJLLQauyaiqlP9VBdZcuP16vXMwR73wAyagqKa5aGv
         CKyJloNeFdpr6eeSzQ43WbIyOUmujkSwx1AyvvbBwqCtcE+Ji3QNx6ACHmX428nNVZVe
         rtCTa+KfD4zDkV99Xpw3/AOVokP/nxR3dz6EiEwWmo4zU/J17lQKHQNAhPEqG7tsYT7O
         2IiqNXJix0cOjnhLnA4jhnFpMhSxzlcVLFvyzbt6g/LgHijx1RQ5jYpC2OibKHiB/uqO
         5eLeiYCLXcX+jrW46cWTx7yIenOO8tLV9Od5p1tgC+rqiebIqPenZqSuPrmU8U4fz+0Z
         S4+Q==
X-Forwarded-Encrypted: i=1; AL+hErEoNn5nmRX+CgDJtX29AOm5nolVF183zJek/fQ7dRFMHQXX/L3oTcZZcifBMG2LwI+zLLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f78CFQoQVsWmnXwQ/CTrP3X+tgp+Wvl0xXJZZwsstH9ePNYq7
	pi+lxc5L6oEyFtKlOmbdI+NpAoiVzOsMsKOxznIgH/+8q7PFBjEss/jy7EOSsEGnM8FHrps8wVt
	KRes2ivr0oSVTbF+LH2fdN9WIGDkf3FknikR2/81pwUuwjDKQd1tfS4Q=
X-Gm-Gg: AZFdTZdbtYibTlDhoRlaZfyD50/Fqu74ETw6LBl/fnrH/gZPMpugZOkbZYTj8TXwJcS
	ohPMPEkLILpHg03VZJxnLTecLrRA/5IaQB4IRrP6M3pKqEudgoNQlHsf87qWmNvRIPb0EH57btO
	3Ts0cIA9s8iyZ7zJd8+Pv7i+GnX9yfFKCVClMnIfyP+vpCSZKsT3msPf3v33wOgWJp1OJXrOw9g
	LYJGricO7aQyTX8oRAqmiW0tTTosuJn4bkqs8uG5onbteufBqsUhz9gScQk0kUNYSfF9LcpXAhg
	DIj/yy13mAhn4UIsJpxg4yWxt3La6QZl/jqztdcRdTk69tJm5BRJNLO0Nnxdf/mcthDd+GFkEdQ
	MctmwVCsJpTzH8YCcL0im6oyOR9PuT+aA4W4bSmH1SO8hbtqjHXdXxWvtcq5lfMA=
X-Received: by 2002:a05:620a:1725:b0:93e:f931:a886 with SMTP id af79cd13be357-949bab0ee9bmr4398240085a.57.1795773295530;
        Fri, 27 Nov 2026 01:54:55 -0800 (PST)
X-Received: by 2002:a05:620a:1725:b0:93e:f931:a886 with SMTP id af79cd13be357-949bab0ee9bmr4398236185a.57.1795773294940;
        Fri, 27 Nov 2026 01:54:54 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm52877946f8f.24.2026.11.27.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:54:54 -0800 (PST)
Date: Fri, 27 Nov 2026 10:54:53 +0100
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
        emil@etsalapatis.com, ihor.solodrai@linux.dev,
        matthew.gerlach@altera.com, boon.khai.ng@altera.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, nb@tipi-net.de
Subject: Re: [PATCH net-next v13 2/5] net: stmmac: remove software VLAN tag
 stripping
Message-ID: <awlTbaxfzMZyCdzU@lore-desk>
References: <20261125-stmmac-rx-mb-v13-2-0f6bac53e8d5@oss.qualcomm.com>
 <179570462642.3135.18427694806922403936@kernel.org>
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
	protocol="application/pgp-signature"; boundary="aiSzvVqs8OuRzqhp"
Content-Disposition: inline
In-Reply-To: <179570462642.3135.18427694806922403936@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfXxB9xfUXPTuBl
 LgRM0/jLO89O04/X0QTZyIJX0zfpgt0RxlOxcbvt6Elb2qT9V8J8/s80x9VLB+7jOQggiPtdVoY
 abRczfK0o6BgoDAOhkkh9xIwEW43DxV9QUHBgSLcBRAC3PsRGSJJnEvy2Co7cwKgRFse8upOz5t
 +ViiX0QdLsvmSJ1i5h8JwR4Xkdy5xxX1AQWY8KW8FVCmcNRAnH963kPjskCCZbnRjOFG8snChjQ
 VmIK35ylKpFR6zfRW25IQbMQB6xs2f2WIYC6EIEtRrzcp086Rj6tsbiH0mJPQhft7qi1oRNyr1U
 EA2mBAuiPeCcFJ+jpSWMethYDnzRizHcDlJ96w12zPhW1hAiLgL6NzdxVcLJoiMFCuYunGq31WP
 HlGUOGx2BBvb1OZN221zukiLrqOhfBcmwjwIAgxmFBYCx2PIvduKkI/tBQKI4sNQX5O/CVERtqi
 4h1iTgkvOwj1XhjtuBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX0i+ya8xK2WvU
 TR5uvBFtziXloJ+5BGQ1pwm6nHgJS4eVRNn/Pf8yjT0cardiEE1Mork4pqgDYvdVKGMeibKGszi
 o0cqiNy/N8EoyFGnEKnFvS397TQhcYI=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b095370 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=MCknuC-Xbgb6_HTytioA:9 a=QEXdDO2ut3YA:10
 a=VSUL9KZZh9SVKvXMN8sA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: iIJP8G7iIRpfD2fSqIgEpRufMB9m5y9c
X-Proofpoint-ORIG-GUID: iIJP8G7iIRpfD2fSqIgEpRufMB9m5y9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039

--aiSzvVqs8OuRzqhp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] In __stmmac_dvr_probe()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c),=E2=80=A6
> - [Low] The patch carries 'Fixes: 534df0c1724b', which marks it for
>   stable backporting.
> - [Low] On DWXGMAC (stmmac_rx_8021ad_offload() true),
>   __stmmac_dvr_probe() now adds NETIF_F_HW_VLAN_STAG_RX to=E2=80=A6
>=20
> --
>=20
> net: stmmac: remove software VLAN tag stripping
>=20
> This removes the software VLAN stripping in stmmac_rx_vlan() and changes
> stmmac_has_ip_ethertype() so that it still recognises IPv4/IPv6 behind a
> single in-payload C-tag on RX. NETIF_F_HW_VLAN_CTAG_RX and
> NETIF_F_HW_VLAN_STAG_RX are now advertised only when the VLAN ops and the
> descriptor ops provide real RX VLAN offload.
>=20
> > The DWXLGMAC mis-advertisement was introduced when the RX VLAN offload
> > gate was widened to all xmac cores, so tag the fix accordingly.
> >
> > With NETIF_F_VLAN_FEATURES possibly empty, EEE RX clock stop may be
> > enabled on some platforms; the preceding selftests patch blocks RX
> > clock stop while the ethtool selftests run.
> >
> > This depends on the preceding selftests fix.
> >
> > Fixes: 534df0c1724b ("net: stmmac: dwxgmac2: Add support for HW-acceler=
ated VLAN stripping")
>=20
> [Severity: Low]
> Is the Fixes: tag in proportion to the change? On DWXLGMAC,
> dwxlgmac2_vlan_ops has no .rx_hw_vlan:
>=20
> const struct stmmac_vlan_ops dwxlgmac2_vlan_ops =3D {
> 	.update_vlan_hash =3D dwxgmac2_update_vlan_hash,
> 	.enable_vlan =3D vlan_enable,
> 	.set_hw_vlan_mode =3D dwxlgmac2_set_hw_vlan_mode,
> };
>=20
> With the old hw_vlan_en =3D true, stmmac_rx_hw_vlan() did nothing, and
> dwxlgmac2_set_hw_vlan_mode() only sets EDVLP. The tag stayed in the
> payload and the VLAN core removed it in software. The only visible effect
> seems to have been the wrong CTAG_RX/STAG_RX advertisement.
>=20
> The same Fixes-tagged patch also does the following:
>=20
> - removes the software stripping path;
> - drops CTAG_RX on every dwmac100/dwmac1000;
> - changes the RX checksum trust rules in stmmac_has_ip_ethertype();
> - makes STAG_RX user-visible in hw_features;
> - depends on the preceding selftests patch.
>=20
> Through the NETIF_F_VLAN_FEATURES check in stmmac_phylink_setup(), it also
> enables EEE RX clock stop on every such platform that does not set
> STMMAC_FLAG_RX_CLK_RUNS_IN_LPI, not only on "some platforms".
>=20
> Could the minimal DWXLGMAC advertisement fix be split out for net, with
> the cleanup and its EEE side effects going to net-next?
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index ca4c7fb11b73f..7896364c43e95 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -8275,15 +8248,17 @@ static int __stmmac_dvr_probe(struct device *de=
vice,
> >  	ndev->features |=3D ndev->hw_features | NETIF_F_HIGHDMA;
> >  	ndev->watchdog_timeo =3D msecs_to_jiffies(watchdog);
> >  #ifdef STMMAC_VLAN_TAG_USED
> > -	/* Both mac100 and gmac support receive VLAN tag detection */
> > -	ndev->features |=3D NETIF_F_HW_VLAN_CTAG_RX;
> > -	if (priv->plat->core_type =3D=3D DWMAC_CORE_XGMAC)
> > -		ndev->features |=3D NETIF_F_HW_VLAN_STAG_RX;
> > -
> > -	if (dwmac_is_xmac(priv->plat->core_type)) {
> > +	if (stmmac_rx_8021q_offload(priv)) {
> > +		ndev->features |=3D NETIF_F_HW_VLAN_CTAG_RX;
> >  		ndev->hw_features |=3D NETIF_F_HW_VLAN_CTAG_RX;
> >  		priv->hw->hw_vlan_en =3D true;
> >  	}
>=20
> [Severity: Medium]
> Does this make RX clock stop reachable from set_rx_mode again?
>=20
> dwmac1000 has no .vlan ops, and neither does DWXLGMAC without
> vlhash/vlins. With CONFIG_VLAN_8021Q enabled, these cores now end up with
> no NETIF_F_VLAN_FEATURES. stmmac_phylink_setup() then does:
>=20
> 	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
> 	    !(priv->dev->features & NETIF_F_VLAN_FEATURES))
> 		config->eee_rx_clk_stop_enable =3D true;
>=20
> As a result the PHY may stop RXC while the link is in LPI.
>=20
> stmmac_set_rx_mode() runs with BH disabled under netif_addr_lock_bh(). It
> cannot use phylink_rx_clk_stop_block(), which needs RTNL and a sleeping
> MDIO access:
>=20
>  *  FIXME: This may need RXC to be running, but it may be called with BH
>  *  disabled, which means we can't call phylink_rx_clk_stop*().
>  */
> static void stmmac_set_rx_mode(struct net_device *dev)
> {
> 	struct stmmac_priv *priv =3D netdev_priv(dev);
>=20
> 	stmmac_set_filter(priv, priv->hw, dev);
>=20
> Commit c171e679ee66 notes that the hardware needs RXC when MAC address
> configuration registers are written. On these platforms, could a
> multicast join/leave, a promisc/allmulti change or a secondary unicast
> address update reach stmmac_set_filter() while RXC is stopped? That would
> leave the address or hash filter unprogrammed.
>=20
> The selftests patch covers the ethtool selftests, but the commit message
> does not mention this path. dwmac100 should not be affected because it
> has no EEE.
>=20
> These platforms did run with RX clock stop before c171e679ee66, and they
> still do with CONFIG_VLAN_8021Q=3Dn. Whether dwmac1000 filter writes
> actually fail without RXC is therefore a hardware question.

I think this is a real problem, but the fix we have in place is quite frigi=
le
and error prone (we already have the same problem with CONFIG_VLAN_8021Q=3D=
n).
I think this problem should be properly addressed with a specific patch not
included in this series.

>=20
> > +
> > +	if (stmmac_rx_8021ad_offload(priv)) {
> > +		ndev->features |=3D NETIF_F_HW_VLAN_STAG_RX;
> > +		ndev->hw_features |=3D NETIF_F_HW_VLAN_STAG_RX;
> > +	}
>=20
> [Severity: Low]
> Should STAG_RX be added to hw_features here? On DWXGMAC this tells
> userspace the bit can be toggled on its own, but stmmac_fix_features()
> ties it to CTAG_RX:
>=20
> 	if (stmmac_rx_8021ad_offload(priv)) {
> 		if (features & NETIF_F_HW_VLAN_CTAG_RX)
> 			features |=3D NETIF_F_HW_VLAN_STAG_RX;
> 		else
> 			features &=3D ~NETIF_F_HW_VLAN_STAG_RX;
> 	}
>=20
> stmmac_set_features() also has only one combined hw_vlan_en state.
>=20
> So "ethtool -K <dev> rx-vlan-stag-hw-parse off" with rxvlan on, or "on"
> with rxvlan off, is always undone. ethtool then reports [requested off]
> or [requested on].
>=20
> Before this patch STAG_RX was only in features and showed as [fixed],
> which matched the coupling. The coupling in stmmac_fix_features() already
> adds STAG_RX back when CTAG_RX is re-enabled.

I guess this is managed by stmmac_fix_features() disabling
NETIF_F_HW_VLAN_STAG_RX if NETIF_F_HW_VLAN_CTAG_RX is not enabled.

Regards,
Lorenzo

>=20
> > +
> >  	if (priv->dma_cap.vlhash) {
> >  		ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER;
> >  		if (priv->plat->core_type =3D=3D DWMAC_CORE_XGMAC)
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5%40oss.qualcomm.com

--aiSzvVqs8OuRzqhp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawlTbQAKCRA6cBh0uS2t
rMjhAQD7OT4u2F91OBhSwrDdaIBx+W8JJmXwQ8kX1B39SfO7TgD+MvXCtW4fMFkJ
2oXKGDtwuLSvJwEftL9xfcwbHAZ8KA8=
=giXr
-----END PGP SIGNATURE-----

--aiSzvVqs8OuRzqhp--
