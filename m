Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744459;
	b=HNNY9hPfKnS+gBDIUlMiVcfDcrEhGFL3CWZ7vHkpvqwaEYcjyqXrDCGHvXbOFeE60POa
	 banWb4eyhjUEynLa4Yo8x3qki1WwkOVLSAgBDkTBRVm4Px34XEUFXJonFdury43ed2PD+
	 5OWtcgAljYVCXBcxpPyQcpQ60ezrXUbym2m21GUqBtYGGVVnD5YMwXDsxT/h1w3nvnB7I
	 LV7Y0fIHtpoVpUX103WYkQ9+bV2SXnMWkYA/aZzrHG/JIlH9O1pR1jvxp48gTzGgxxYJj
	 206MU+3pWYnBsl66eXybhxmRJi1fbrnAZi8Rja2114x5dXYMMH6hNKbhdxlD4Qj6i3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
	b=W8Xl9w+egTHZo8EHJlylU2T9KKWvp0PPG0r0en6T5I4TUgSZvE5Dm2MWgwJpoJYdaOt/
	 ij24IlfdgXiJ5HmF2f18Xww0i8fSUFc1f0X05CCypoy0TPfcfZfNE5u0FDrBNl84zT2Wg
	 RHeGSsBJ+uXgyj8wiEzIOoQuyk/5RwdPpUxO/Ke21mnEavOgxa72VsVNL19ekdjK4ZzHM
	 v/Se2VX/OdHb4HTMgHX9K8EL3dFDOaneS76rspFog76sVI24FoE/7XxS35lbL+Gig7k57
	 h6vin4gnNGaTH/cU//M5nLewPC/BBBR2IUVu2kFRcPvuH0QJnd4gJkFLtqqXocA5keg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlNNsFPt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UimSwaIC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CC606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 280CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlNNsFPt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UimSwaIC
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FNFX1048304
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JLouBngFmyzeStR7jpDFnM6B
	5NYmg7+fEs/IrATZkD4=; b=VlNNsFPtHpOEOLBQPIEyP7I/jaEfftcF7F+mvdHm
	sGsdlHAs/Xooz0LLYCCk0jG7pQSMecK7TOhIkM/90it1WQcsFKptZxtQkdK/bVhE
	9U3kHoD0zyE6n9EmF7MqoIdDhA3CBcaruxo+7hgNQTLQpAvHmfGecb/DCZ5OWj9d
	p+9k5t8Ov35d9WRSTgUfhM/ptvkDejcm8wx52XVo3Ty6tOIwQ3TrjjYwWaOzuXVv
	mCcgFtmO7y0KI6n9vXmBYZcann6XoaBaYgKWmT0LwPXze5N89qDVgyEtytOdD0hN
	v6wbu34r1auqFe773kYRjNGYeTmtntTDC6kxG+TVOdb+WQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjt8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:34:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53380b67cfdso13394711cf.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744457; x=1793349257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
        b=UimSwaICix95Qu4VURNh7MAuQXMsVcZYaxXdPffeIEeJbiCQbsG7A4yYiXOKKoubf1
         1if0kqWVBHMKP7Diz/w22taPESwmkzrAiwwdggIXxJdJGGQNWF07OAkIwdH8VWe1X2m/
         AmTNeSX8/lFAiHmxL5xwvhaH36YaAGA5KVLuzFcf4gXr7O98uwAQjvbDcCuHk0R8MBxa
         dxDt51Exb7zERT6CSwcuimlPOWPE2EbwluNlh2wNFCwgfneX9x5TT0TH8EtOQePjUzra
         +6RXNgDc6WYU/7YTpJG9ta0RkGpX01Kti8Mx4Dua+Qx3PuFOGRvJjnnHkEEwouFNZyfC
         /L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744457; x=1793349257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
        b=EVIUWmtZaOhlStN6BrYzke+ggyBDww7v+HEHQWg7xApUwcLk9aG8BOAGDV/SeLxst5
         yHCL8k11C3PsCfUQ+QOfG8L4rgokyXcYe7PBC4SeC936+3IAlrfghqXxJLdUfQPu9Nly
         qfN4U05sYg9qFoAdPhFX7+LjL8yMmo26WDAKJgJKchkRZxyF1TqX3Oe4XbRFTtMJJCUL
         Z5frVFHH0sDdOMDhH+BFUAciRgB22hcfOCMOB5D1NetsRb5cKtMZRueYOE5tWpjF+yh0
         ix5M28Ahz/NbL5TJDLzjnGMtujPtwTAuAdzKOL3skVQdmYbL9MzUwB3vQCE1tnD70rFz
         cggw==
X-Forwarded-Encrypted: i=1; AKwUvBzqzL1/IEwQKgBmVpAIwCyZp0IGuCvR4fo6eqiPskKLk3W9aep5q6vYRszojyJc9NtQV5s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0Vz6kV75tiRoE8rn/EQREUtwaH93biQ/QoyPt5eGZv+9Ta563
	LTwBnvPV4tmDapC+/kN3gutqLmuYDrYH+KSTwrlgLQfbmSzuZ7p2hRZ8dPnU4hKYeeMiumkt8Rb
	v3zeuKGu5pzFJpfOxSi5PF1ybMT78IlcgmkPJxZDGlFLhQp+Ucs4THQU=
X-Gm-Gg: AYBFou0BRXGIkyHOvOgbT+xLiuEJwIGIibNqsyFE6l28ObyIaSkvLkR0Ts3pUe3TOfJ
	LWj2CMBpOBhf3pACD6fAUkx2z4HvbnXTMxaLdsOiZuRm1QD20/pXh08aGV0IYuG+e/XuROtU1sr
	emNYDhuEBxm4tWQM04kt7Y4Ugeir0G3Ey9bvOydS/aIl4K5MbN0nilEeHeNjdYAxtBKSHTE9udj
	7/ySgmX7ZyWmHdVZX/fpChSNw7dWsrK87ky2SUXbqbY7VunnNJdQW1FBglxdmSrRbz2Cnqtsto9
	AsZBop2FCCLbMgWtaiI11gEXxJ3dvTBeGyujkouNg7sXF4KpajpMpADyC4bf2NW8b7fBxTzN3RG
	y+U8BOKTh8SM=
X-Received: by 2002:a05:620a:1d09:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93f6f8249cdmr284072485a.53.1792744457103;
        Fri, 23 Oct 2026 01:34:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1d09:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93f6f8249cdmr284069085a.53.1792744456592;
        Fri, 23 Oct 2026 01:34:16 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2104627e0sm58222525e9.9.2026.10.23.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:34:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 10:34:14 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net 0/6] net: stmmac: XDP path fixes
Message-ID: <atscBtA8faGJ4o01@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
 <179274313871.3327.10475535220969393247@kernel.org>
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
	protocol="application/pgp-signature"; boundary="lRlEkSG0nrXxOB84"
Content-Disposition: inline
In-Reply-To: <179274313871.3327.10475535220969393247@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfXz3VO0AOkwJxK
 +aTZmo15Wt0L9O5mfeGFQXzj67FKSdT3SPyoiHOaCnATb7U11NuSqgmzEM4kJpitycPtpH/bZxt
 SI3DuJacpBPm+/GeN3fMECVGK4z28co=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX4acgt0N7FNOV
 wZE24SoCnhaFnVOZq0uvjBNg2F3nONyxpE7teawautfRgJUamBl3h1MSfEvQDNTaBMMccRmqaro
 aVv9SnUW3pndlgm1I/tHMDRcn0JxMiqXrRdGie4QZhRtskY6+I/R0zXZPcw8b/ejUYEFzz001/7
 IJkGbfOoN51AybDgRnsGBO4tctorffG8WdIUqK4OOEcpUnMe2pcRrtdiZPGoBij66blWhypADUs
 ISv88yNGfGitpu96rBgg5FhrlHRFr4S5CHnuxKFIdNReTpOHPfAIOhcpp/WjoRJqHdEfOuCIO5x
 Azchig3FL/ud2x7/DSj4G4OKE1oQiqnY5J3h6NS9sJgFnQWb5JvVqCqubRxG3vEf98WeOsInTvi
 KzOH14H3a2ojQSzhzGRAMZVDCHuN1giOwDt7AYmcVQl7xaiMTInYa2ryc+74NzqR8251brpLO2o
 yEhtHApcE1s2Tsa6ang==
X-Proofpoint-ORIG-GUID: 0dqpDSCoSfQSt5y9Uzd1WCH0McAUr4Sa
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb1c09 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=TGL2fYcsFtN_zcw-cNEA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 0dqpDSCoSfQSt5y9Uzd1WCH0McAUr4Sa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

--lRlEkSG0nrXxOB84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issues are reported by sashiko or spotted during code development

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

They are real issues reported by sashiko or found by code inspection

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The series has been tested on Qualcomm Rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--lRlEkSG0nrXxOB84
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatscBgAKCRA6cBh0uS2t
rIpOAPwODAt8L3TAMPYqpuMKG9zg5Q3KhWAnQEHWpI/u7fuNCgEA/kCIx4D8M9eR
jTH9fhWjO4Baz9wjR/8WD+NaIz3Hegw=
=X5cW
-----END PGP SIGNATURE-----

--lRlEkSG0nrXxOB84--
