Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFE411F99
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384230; cv=none; b=cWj8By063VMsJCA1hmf8rIaUY46jVXny5qb5TbZG6dFNe/wI/c7DTsMc8hh/1tcBEo0sq35p4U0CHUxYgCjzTlJQ88tPOGyhbUxOKHf219MmfePf3Hm5d+FRxgCqIffu1yQTzYhL2yjcrpYVYPjPoUh189BumecFvRea8KssbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384230; c=relaxed/simple;
	bh=1hJpJrsYkOCzz7io5DjVEQ0CJK9Yp/EHScPEoWNpW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n912n9PN8r3+AhK1LXABLh7mW4Lr4uTR5usfyZg0xr6MYlMJFAGxfYZrCWjDvEdfNQ8c+2LtiinbJ0DAL5SuVgOl9MfrABMnw/jb15T+cySKxLLxXAub7hsnR0P7y2Y2xKS6qIR0QDBtC1poaS6jeBun/wWqhmK+Si3lN3ZIcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLEv42JC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N+hBGLMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLEv42JC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+hBGLMZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHSXM3044970
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 21:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9MrH8QKgsF8kmZ2e+B7i3zZC
	rWJpZ20RLQ1YKrlb37Q=; b=fLEv42JCfR3lh67IATHlvY8tVbgtKtkFwR9OTIuX
	zJ8Qw+K+ztcKltPfTcBPTWD90zOkJwLM2ZCGu383Ahm2e7aSQB5r7e6wYCj2b9eG
	ffKGY8t67N23VXs4Op10NvI6yIKJy9+uHkGx3sNGEnaXspHcK2GdwIqc7Ok6ATC2
	hUyX2gVjim495EQWbo5v/X2S/1aAziCZ/29gjGMygWSgKgPh4FP6vEQbZ0nWPWlI
	WwkWWCnZMMZyiUVt8QKv7C7vk1arSK55DdrXAATigDwcGDFhNXVr4MTY92TPLK3V
	50uTw9+ZmGYg12mRljFzgLsUrCtPD0i7dhuq0J5Xf3Og2g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy34h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 21:23:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so315638985a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788384212; x=1788989012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MrH8QKgsF8kmZ2e+B7i3zZCrWJpZ20RLQ1YKrlb37Q=;
        b=N+hBGLMZ2fgLdzZyuKlIb8vosrf1MfnmXnKQwEx6s15WwWAP42SvT2KzZ4vBqjZOKZ
         dhLGl7rvxYdQZUJPDIj4uhrQm/WK1PRdDf62rPLiWZX5JaTFYML9EEwwdI6ysJgC5o11
         FJFVg1GP+CPKy+7U5HkTcAXLAdSCU8oQ229QdSs0zMEhdCJ1QpbnzdEsNxZ+WzR+62Hh
         0QG8MMBr0WPmPIpGJXuIYuKQHfzgWmIjgt00GBwAoSC2aO6MInVm3Xcqpf6+Lx2SC7LI
         P3U6HykX8pUPub4x6UAqhxLEgwZmKxstaWxT/aW7bqpqZ29/3ep4j3tH3g4FkYxe6Rfz
         j5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384212; x=1788989012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MrH8QKgsF8kmZ2e+B7i3zZCrWJpZ20RLQ1YKrlb37Q=;
        b=izKIc4+/YYb/lMw8q2vJE/3NL/fro3F63W2+cnyiuY0AeuxWlbmAgXlCaN6B81qON0
         iaDlSkSIHEXLR44UFT8prRjyzlJIxGG28GqHpn3m2kPt2+KcPcvYrpCR5wmS5Ejvc3yT
         GZUD96i4vPYLAAB/UA26EeYHiFF74X0zjjmB8JQxk/rUeD1+Ghq5XGEvk92pYwfSMrm8
         ARRcrU8G5NE42t6FoD/sYdEA6Wc1f8AQ1fqg/SI1EZy8iQhvfc73nX7WLR3fI8ePV5sc
         i6CKPVoUjDhusPKin9+0jw0N1JGKgonvREObYJ6OFqs3zKp9bWJOotE2NSZN2ylHPd3O
         Hh7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy4WFLf8xR2WNocG0WLZ3wDNI0rpBGposSi/4onY7TK3cEkqhisTSWEpPqR9qYeV9hfLUk=@vger.kernel.org
X-Gm-Message-State: AFuF++nAgdKbSQiuyZ2Gz2FN6R/v8Vut09VDJtL6uclSivb8hhGcCQB4
	aDnC/HN1Z0ruoyb9JoVsKagzjlN97aASAUKUAL8C5+JuU/zeQL/jrBqH1YCwVx0HjZzhHV6zg0K
	RpOPahlGrQaCv27x6miVLIg2dmGagLCHh1snYpAQ/zrhRVl0C4h6ZdaA=
X-Gm-Gg: AYBFou2G4Jliye8GvrKBwFbfBUjETD1Na0fYtemveASw/NmtzMc3z0xg3zBNs6kw3lt
	rNoH4irU528beY9P5zrS70DY4SJStrpqgi6HkcMHHlqjd6b/sTQwY4kqDidBFwZQJI1t9Bze61N
	FIEoLzNqY4ik6KOba3hl6T7jjttRz9LldDCZ5B5I7k4HyLTZUqgLZdv2egz035duYzocwlq8zII
	ukkDeSbjArdCnRJdh3n96N43AMcfym3AkXDKL6RDnWnN5YYXxblyLTEL0mB62FclqOS8XBGY2v/
	SK9T4ubKxgQbbXvOiggxDbGP4yS3OHsHPNRNCigvkWtapXuBgJocwpqh1RmeSk87KUjgD4wKEVM
	LGT0PDqwYG8FSog==
X-Received: by 2002:a05:620a:2ad5:b0:939:6de9:4cfe with SMTP id af79cd13be357-9396de96eacmr191073085a.44.1788384212135;
        Wed, 02 Sep 2026 14:23:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2ad5:b0:939:6de9:4cfe with SMTP id af79cd13be357-9396de96eacmr191069585a.44.1788384211624;
        Wed, 02 Sep 2026 14:23:31 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm18104975e9.10.2026.09.02.14.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:23:29 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:23:29 +0200
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
Message-ID: <apiT0ZrlBMF2k8qz@lore-desk>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
 <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jVxPv4b2vhp6+CCe"
Content-Disposition: inline
In-Reply-To: <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a9893d4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=yiiVG1sZxxzmvLrpgBAA:9 a=CjuIK1q_8ugA:10 a=xvJVbJRMoKIfBHf13kYA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: dqpf1u9rIYK3Lp56dAJYfxuXy1seC6hr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4OSBTYWx0ZWRfXypTn/plQh3/D
 KlQ5mOfIEhP2Y8ogZuGNTk5vrUgPol97eaIOwAb4UPURGAe0lwyrvzt4LhNc/tlUwCWarLHhYI5
 XvJ9wFjCCtYmtjTGGR6BKRDPuIKI8HY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4OSBTYWx0ZWRfX7fsf8Zf7d0AB
 4uUyMpXamLkU6s6kZ4cIUpm8xr4neFwfdyON4yuLKOZfhBMQAXou5yntLTy5jCod4L8zVPQYK/H
 jRtEkmFHCmbT1GQpDBs8I6U6QGUB/sIRHbTrEIGrNS/jzh+descaT4E7Jph5px9JaeSOsx2VKAU
 YygQq4H6wyWbHSJiIMIGAcUe/gpssQ895dpFzGsL49ur+0Wl6gmxDkA0O2aTEUlmY37NbNuphQV
 5u0SafVG6JLCKwKF2oAJXoUxmeoUzB8aORqDaln+BzqlLDMU2Xsj5E7snSRXeRhSUTEDQ1MrTE0
 2SuLaf7qasQnaDaAcMkRqLnqkervvoPMkNfFKyvfMX2CXRQ5lqFgZ6G9puLytNpZlY185EY4NCb
 qjpLcnoT9GYXRCor3FVvBbUuYk+jPVOZHSgt8fFvwm2BCkiYIpUNZi+8FPopksNwWDKBg+/2Vyl
 1MRcJigBh7rZlM5yLqQ==
X-Proofpoint-ORIG-GUID: dqpf1u9rIYK3Lp56dAJYfxuXy1seC6hr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020189

--jVxPv4b2vhp6+CCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi Maxime,

thx for the review.

>=20
> On 9/2/26 22:15, Lorenzo Bianconi wrote:
> > stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> > the PTP reference clock enable and stmmac_init_timestamping()
> > failures are logged but never propagated. When they fail, the MAC
> > system time counter is left in its post-reset, non-running state,
> > while the driver keeps operating as if timestamping were up.
> > This matters for the upcoming taprio offload re-apply, which derives
> > the EST base time from the hardware timestamp counter: arming the
> > gate list against a non-advancing time base would leave the schedule
> > permanently stuck. Make stmmac_setup_ptp() return an error code.
> >=20
> > Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
> > Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/d=
isable")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> nice fix, this isn't the first time we have issues because ptp init silen=
tly
> failed :(
>=20
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 46 +++++++++++++++=
+-------
> >  1 file changed, 33 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index d576059c04df..47295845371a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -937,18 +937,27 @@ static int stmmac_init_timestamping(struct stmmac=
_priv *priv)
> >  	return 0;
> >  }
> > =20
> > -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> > +static int stmmac_setup_ptp(struct stmmac_priv *priv)
> >  {
> >  	int ret;
> > =20
> >  	ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >  		netdev_warn(priv->dev,
> >  			    "failed to enable PTP reference clock: %pe\n",
> >  			    ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	ret =3D stmmac_init_timestamping(priv);
> > +	if (ret) {
> > +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> > +		return ret;
> > +	}
>=20
> This can legitimately fail with -EOPNOTSUPP, we musn't failt the whole op=
en
> sequence in this case.

ops, right. I guess we should just skip -EOPNOTSUPP in this case, or do you
prefer to always not report the error from stmmac_init_timestamping()?

Regards,
Lorenzo

>=20
> Maxime
>=20

--jVxPv4b2vhp6+CCe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapiT0QAKCRA6cBh0uS2t
rAmrAQCvacwj+zCM1Or7FiHydec40FqES0Raq6bMj/X6600SfgEArHws+K9GA4SU
omKFxFomH4QsNyP2HTqaW4nH4JTC4Q0=
=ke07
-----END PGP SIGNATURE-----

--jVxPv4b2vhp6+CCe--
