Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFA469840
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195139; cv=none; b=B/KIToro4CdHQYWIEKRrhLI8ZpylEkNJ81nS1bdFrkjU4LbjS96FyQ6rUjIr4vd/kwhieBd/H2fuBUP/z8j+oaQsigl9lwQJP8IDYVlJS0Cu/ZJORpBV2L8pXGRx0tF1elRgurdvTJy20HHD0dP9daZ40G1X8xjqRWsFyrSCsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195139; c=relaxed/simple;
	bh=29Ynm9Vz8sSrTkrm8NDeRK/xaPFNEqxziwHyw7DDe3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiFUMWa4ZkJmiePzOx/cJx6GzS5e6lH6d2nz14sCMY86wkCNPs8lrpc3yIQpQj7huFtrKY11qS+1V+m9+TN3rGOPtGCC4PasdcNxn2h4Pa9Cojque3ZR9biyWDBmSGHaiLWkx8VZ5YxI/ivR/l++1IAEdVgOv7+6+DUeNzP3oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJspakl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRnzsBOX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJspakl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRnzsBOX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6958xS4R1800268
	for <bpf@vger.kernel.org>; Mon, 5 Oct 2026 10:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wTpXd2xcXmR9jaqSnaJI/lPy
	n8DKYRE9YWWV6/HaoMI=; b=HJspakl/D69qWYxop7Ch866rgarzmM6aBt1VrN/G
	mcmGUKHdvQegqiobw9pjzMJyk88qynk/bAwRJ8hee69FbTgmQwjII0/kMv/4bHBi
	yaO9LB4EE7bUhqLe6/Lp4U9zEi58ZoBb5+xJFk1dmWhi7VxQDwzH4eD7vyn0QkjG
	DzgapdM/0CcFy+qFiD8mWVOWICllHIUFCwxj+ub9F8tixnifo0lg5M0+TiQKtK0j
	V2Y42MEmZUtaVPGIAl0WC0p47TUY8agIlaLT/ihZPi+hvQquefxBqF5jiC3B/A2b
	zLvU1/F2ib4w16ekdF5rLkklPU+ym0gdsIa0BnP/uw2lqA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa5f0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 10:12:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a3f673221so358888585a.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791195136; x=1791799936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wTpXd2xcXmR9jaqSnaJI/lPyn8DKYRE9YWWV6/HaoMI=;
        b=FRnzsBOXcpAu59qE6f6Gu6DD9r6Qck5A41lASAAz2vFd5lFM6MK8jcpzsQwhNN5x7J
         WHmBBerYVyHc6LIoRD/5u/8+I9yd0nj3f1ptU8Rs35KkVgtuAcATTQ+0vHYY5RCT2Z7+
         F2vGpToGYb4fTVJKWcuKzFQI9TG316otOa2r37lnd340v7dHJzM4i9Bv3pODmEOeEA23
         TVfa9qHUFh05Tn8beu+Gg0aLllcwv9yEEkXeWbDtvDj2dxasjjOt57xnzNEXIKY8eWja
         /BCoUm/Gyy3LXD2mshzKfdwooQzP8lZNOdvIWvRevYrwqJFK8xnFKYaaTZXE84v8mGoc
         Tpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195136; x=1791799936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTpXd2xcXmR9jaqSnaJI/lPyn8DKYRE9YWWV6/HaoMI=;
        b=LpaXAPSVjPQaeaJ5pw0roxpCqiqjKjOCX8yKGA7e7/slkCBWRrv079iz0+vM2Rg97a
         jY76RCNRjlJrCk38oZFDa5E1VFp9ezleFmKsjlivpx7Nj+ljWFu0mi9oUOc43sgleVZu
         V5xovuBlRm8kkwp5Hg7BY6GHErX0RFG5VjJGbIMZDqWTUNCuDC9D9T6k7fpy34LLuM3I
         Jk4D+b+vaJVbBPvrkPn0hUZvtgnIPv7hzCji9Hy1aMjYOIENQookC+dMuM9FNGoiQR7x
         WR65q2zzFy3p5yWuFKFs639y414am3gjBiimwOWAYEsl5H+DoZWsz5M4sZB+YtuXWVKv
         z+xQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvxpLNBQdeMqw0wP+1d6oRvjMRO9IK/zMkJE2vdRALYRTJ+4RVo7ami9xmE1yaDMxOXp8=@vger.kernel.org
X-Gm-Message-State: AFuF++mxVO7iGbB8FAEQAHjcc+3Cst08NdhvDRD6v6/IX9j9l/fAYGQO
	VMs0aVWqtw8Zg9x34cWh1F0+JrcEYykRc4F65iI/BddjkzBdL/euHBHYFmKUmgwR70Tp+wjg8ms
	AS+T6c8pNT6LcZgR/PlwWLxF0YkazQAMA8Dwkv1DD5v67TvSySzs6d+A=
X-Gm-Gg: AYBFou0kCWZIm1z0cLQWMwYDVrcIukkhpCqAAn1pGzx1JNCRxWrnhikcB6lFLDRvod1
	KRP0E0v/7vstYOD7Ycc7fnCWS8mgl8HUTG18SErbGgBlO9C9FF/ywkPljM7B7OuBl/denDP1H/P
	doKNTlBM3bDYQu5ZIqKu84wWi5L4eQMu4jBth4/axt3bqvtuchLuQTBEo3DuthDd7T7H7PC5psg
	SoL0PA8vgyMe7JYPRkAh/JrFmMx9Vz8vKSmBGKSUuvF/QBt6Vf9Ri4pVZ8jIB3ROoY2rV0vHN/e
	JhcCWQIfHc0K2aZkc9AChE7QM/Cv7YD1Wu/cprTv6meh4yAMwKGLKqe5l7XcUJ1WZ8UUY1OVu0i
	IQRgOGyxa3++t4A==
X-Received: by 2002:a05:620a:6f92:20b0:939:a834:98f2 with SMTP id af79cd13be357-93ce7c126d3mr1270433785a.15.1791195135297;
        Mon, 05 Oct 2026 03:12:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6f92:20b0:939:a834:98f2 with SMTP id af79cd13be357-93ce7c126d3mr1270430585a.15.1791195134577;
        Mon, 05 Oct 2026 03:12:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm306620895e9.15.2026.10.05.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:12:13 -0700 (PDT)
Date: Mon, 5 Oct 2026 12:12:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, boon.leong.ong@intel.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: fix TX coalesce race and
 div-by-zero in XDP/legacy path
Message-ID: <asN3_ExreXflhcPN@lore-desk>
References: <20261001-b4-stmmac-xmit-mb-v4-1-664e0c3eb289@oss.qualcomm.com>
 <179119366947.434549.18258387588944949725@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfQjmt/PTQh8Ar59"
Content-Disposition: inline
In-Reply-To: <179119366947.434549.18258387588944949725@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfX5T46HVCH383n
 E0EI291eM2ljQjBaq0/8/nRTeAa8asm74e4/w2fkupX16EahaKp82swkQ3zI8oedPuAFXhCMor8
 cJAlsKVO2YNjgiTWpYMfQQmbBI0elI0O02evwGuvY7KLopvoZ6cfXJE+2xZEfg72Fm8K7+xezD2
 k7A0l6/CPugTrLPIjxaJTm/eXQY+I2Bd8zx76IJQXgI4Msn/rJZAnJbcqwPLwUjUZgbOktTV638
 mch3oh1m6e4S7OxCA04rxRvfMEksxmyZUGqlmjtnh6S9rrbvY7YFC8Ugwu52m8COMeeFrNCMjsj
 tRNBacO5LVvI8DfZyZI9FeBpYr5vymylV648MkXKujYdCyLVgy6/97weCKqi2OHpIlX2+udNNwb
 IxQF84TAYyP9NwvbyeB6x5hHvyYbiZi3kDT9iXBSAIACzElos2CbhPGlqsY4nKHu1TcdZX9mYek
 oKD/0pdVLLXkJVDR3wg==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac37800 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=hMNoLFnnqX5p7295vMQA:9 a=QEXdDO2ut3YA:10
 a=UvE2pUckuqDNxODme40A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: Aa2fCwkeK7ap5LL7M1DydS_vBHrwPMtm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfXxtprcdDF2Pdf
 G4SxF/6tY8ZuMaEFbA3zlmmtSentUog41Yg68SKjY/PAt94mn2UOwSNoN5b+PFjYWbzqDJM+Ov3
 B/18O3GLlMd+bCuA6G03jPUg9oPo9Yo=
X-Proofpoint-GUID: Aa2fCwkeK7ap5LL7M1DydS_vBHrwPMtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050039

--UfQjmt/PTQh8Ar59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 05, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] The commit message says the stmmac_xdp_xmit_xdpf() divide-by-
>   zero is "only theoretical", but a privileged user can trigger it and=E2=
=80=A6
>=20
> Pre-existing issues:
> - [Low] __stmmac_set_coalesce() publishes tx_coal_frames[q] and
>   tx_coal_timer[q] as two separate stores and shares no synchronisation=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
>=20
> This patch wraps every access to tx_coal_frames[] in READ_ONCE() or
> WRITE_ONCE(), since ethtool writes the array while the TX fast paths read
> it without a lock. It also guards the modulo in stmmac_xdp_xmit_xdpf()
> against a zero tx_coal_frames[queue].
>=20
> > Both issues were found by code inspection while extending the XDP TX
> > path with multi-buff support, and neither has ever been triggered, so
> > they are only theoretical. Tested on the Qualcomm RB3-gen2 board.
>=20
> [Severity: Medium]
>=20
> Is the division by zero in stmmac_xdp_xmit_xdpf() really only
> theoretical?

with 'theoretical' I mean I spotted the issue with code inspection and I ha=
ve
never observed it in practice. I agree this is a real issue.

>=20
> __stmmac_set_coalesce() only rejects the case where both values are zero:
>=20
> 	if ((ec->tx_coalesce_usecs =3D=3D 0) &&
> 	    (ec->tx_max_coalesced_frames =3D=3D 0))
> 		return -EINVAL;
>=20
> So "ethtool -C ethX tx-frames 0" is accepted. tx-usecs keeps its default
> of STMMAC_COAL_TX_TIMER, and stmmac_ethtool_ops advertises
> ETHTOOL_COALESCE_MAX_FRAMES. After that, tx_coal_frames[queue] is 0.
>=20
> >From then on, before this patch, every XDP_TX verdict
> (stmmac_xdp_xmit_back()->stmmac_xdp_xmit_xdpf()) and every ndo_xdp_xmit
> redirect into the device would evaluate:
>=20
> 	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
>=20
> On x86, for example the dwmac-intel platforms that advertise XDP
> basic and redirect, this raises a divide error in NAPI softirq context.
>=20
> On arm64, UDIV with a zero divisor returns 0 instead of trapping. That
> may be why the RB3-gen2 board never hit it.
>=20
> CAP_NET_ADMIN can trigger this with standard tools. Could the commit
> message describe it as a reachable crash rather than a theoretical one?
> Would it also make sense to send the div-by-zero fix separately from the
> READ_ONCE()/WRITE_ONCE() annotations?
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/dri=
vers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index 1cf0f8820b337..30e0d499326d8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>=20
> [ ... ]
>=20
> > @@ -887,14 +888,14 @@ static int __stmmac_set_coalesce(struct net_devic=
e *dev,
> >  		int i;
> > =20
> >  		for (i =3D 0; i < tx_cnt; i++) {
> > -			priv->tx_coal_frames[i] =3D
> > -				ec->tx_max_coalesced_frames;
> > +			WRITE_ONCE(priv->tx_coal_frames[i],
> > +				   ec->tx_max_coalesced_frames);
> >  			priv->tx_coal_timer[i] =3D
> >  				ec->tx_coalesce_usecs;
> >  		}
> >  	} else if (queue < tx_cnt) {
> > -		priv->tx_coal_frames[queue] =3D
> > -			ec->tx_max_coalesced_frames;
> > +		WRITE_ONCE(priv->tx_coal_frames[queue],
> > +			   ec->tx_max_coalesced_frames);
> >  		priv->tx_coal_timer[queue] =3D
> >  			ec->tx_coalesce_usecs;
> >  	}
>=20
> [Severity: Low]
>=20
> This is a pre-existing issue and was not introduced by this patch.
> tx_coal_frames[] and tx_coal_timer[] are still published as two separate
> stores, with no synchronisation against the TX path.

as pointed out by sashiko, this is a pre-existing issue and it needs to be
fixed with a dedicated patch.

Regards,
Lorenzo

>=20
> Can a concurrent stmmac_xmit() see a mixed pair? Take a change from
> (frames=3DN, usecs=3D0) to (frames=3D0, usecs=3DU). The TX path could rea=
d the
> new frames value:
>=20
> 	tx_coal =3D READ_ONCE(priv->tx_coal_frames[queue]);
> 	...
> 	else if (!tx_coal)
> 		set_ic =3D false;
>=20
> It could then read the old timer value in stmmac_tx_timer_arm():
>=20
> 	u32 tx_coal_timer =3D priv->tx_coal_timer[queue];
>=20
> 	if (!tx_coal_timer)
> 		return;
>=20
> That frame would then get neither an IC interrupt nor the completion
> timer. Its completion would wait for the next TX or NAPI activity on that
> queue. The same window exists for stmmac_tso_xmit() and
> stmmac_xdp_xmit_xdpf().
>=20
> READ_ONCE()/WRITE_ONCE() make each field consistent on its own, which is
> all the commit message claims. The window across the two fields is still
> there.
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289%40oss.qualcomm.com

--UfQjmt/PTQh8Ar59
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasN3/AAKCRA6cBh0uS2t
rHGpAP4u5rsRmhyEgCWlJ1hLUiJ6poy7UiqYIcRNsGH2h4wwIgD/SAI26R14/nqi
gX/DwdFmAvUo2UpQ/YeWx60UO70Togw=
=Hpyz
-----END PGP SIGNATURE-----

--UfQjmt/PTQh8Ar59--
