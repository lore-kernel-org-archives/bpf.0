Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947445;
	b=baIsK5IHJvsDRzTKafCMabqi03j/FqRyb0xXMNK6lbvq8NDm3wRSQduuIJBidm8TdvJE
	 SJ8+uVjJ2pypoPolF8iILkf8MB7C15Ov2Da5Ic5aTbXgDKhOpG4sf+WmFcUfn18pxYNOx
	 54CVkuzHXExZmJH4Hu7y9AyIC8M99FhpT8fRGIWL9fvXXx2ZMG9USHkTVxmOjpqgHH1wT
	 ZTtD1MX3hg70zSI9MiI0fgA0wXdwyArRoqOr06a7OHHFPoE794fAK+t8q/WajoYRR+Bgr
	 emtZ4C0lkv/luRLVmGGbG1b2yU84x9JBlbt+oDShBu67iiFtRCyNVMD4ypqbquz367Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7vlfoyvYuuWOMdUXO0yz9iikbBUqBGSsrzrulSnQeg4=;
	b=19Ld9o8fMhWYniZY7Fc1sMv61wieDgjdI3jUQqSTK/c00r5JhjXo4i6Byh6R/H+JMnNc
	 X20zvdVASQmqw2CeXpKI9rQvHbITZQ77SQhLoE7pYFEiIfNnFLOOE2ulBz3XAQJEiXAaG
	 LuDPq4OnlVj4nCqjEKmmgaEkPaCy0i4eWefCoiH/7cOguwbSWIOgLdqgU4jmVy4pk7Sfw
	 F8XLdl7HFhU0PScAG9lF53DiBIgoYyRStrMt0HYALY/NVoMoAf7oXACcpGQpDH385L/ev
	 sKDMs5twzbOKOV9PtL0aRmwI5ObTBeeBTg5TJB6Yve4RNz/jQrk7kLSjyJRlocLYdWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DtKLDar+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V3MJDaNg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C703606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C703606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DtKLDar+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V3MJDaNg
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6MdN2160911
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7vlfoyvYuuWOMdUXO0yz9iik
	bBUqBGSsrzrulSnQeg4=; b=DtKLDar++gsqHCZUXstn26H6vHhJPLkCPOqy9Y5o
	nG+Zaj4198Gnvhq1qwy/CwEutUbA1dJZZt7F5XNqXJFQTQVDd8p/oULQIEmmv893
	PW9MPPBhYdLIGPJ3FBEEtO8aAvRrDgc03KK2fw+Qbjt7iWtnZtZR4hiV06Ror665
	riXH8QIaxdfl+qRAz5G4YPGrc0kbWD+QeqUIKrwL7mZXKFQc0LAVDpYqisqBV38J
	KyAxKNOlHa1Pqm2oIW5mwxbg9AN+n1P3SbaUPsrC96GOdRHapJGenoGWFujboqKr
	OkSTDX69Qnwu7H9xcRcFXOZmsWYK+xY9LdMzNwuy+VRWDw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccb07s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:30:43 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d2e2cd9c85so147455137.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794947443; x=1795552243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vlfoyvYuuWOMdUXO0yz9iikbBUqBGSsrzrulSnQeg4=;
        b=V3MJDaNgRs6yYUOo0n73Lhvf6bocNDDWGLGsIPVa8skiUiZ0umleFubabOX9LZqqtM
         SZtvi/uOaN3JvjfNjrr9HdOKebmSKmEwhoX8yUaHrVFde+zVgl07U8X67/OkkZxRK0n7
         aVaKj1C2I3vOqpCRoYWS26QDVdCX6OD3l5qmTBl4+puwDrMcMoFmygHuBPvUsg0ylVCw
         rS9qD2Gmz4MIN3G4ZVG10/1SmDymyP9b/4DyY54DY6VtEh0/sjTfUZTsPY6Kgxk1g7QQ
         EzCnV9DG+ZxK3xcQxuj2u06bLBifKvmnctUXD3Y25FiMOD16os5zwPdoW2IfuKAJd73y
         SUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947443; x=1795552243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vlfoyvYuuWOMdUXO0yz9iikbBUqBGSsrzrulSnQeg4=;
        b=oaISVquqmfDHAD8UTtfc3ozw/SWlWfVWArIFzgebQz1KyHhA91gHgLO5oThve2l1Ee
         YqObXYTBMUB3LIYMDFiF+Cy51Gv7Ptnmb3E1+JOQ3JHsspCRGrC+lsmGCytUXwRis+fp
         uLUTlMJ7QeDpltsnJxVyRPPqtE+MflNbq6j0NEx+rL4hCr8/lmFKd46ajT/45bPA+TV+
         iSAkXTRT2e3fLcp/4Vt0PWq+fD658Q1zoz4iiSWM/a9Bzg4BYNOw3jzzafgWROIT8Kou
         GhtXVFLG14PwlDShTSusi9yAYIY60nFeUWyH+zDRm7s6WBiMxlE6sa1kky5F1S03Yrds
         5dIg==
X-Forwarded-Encrypted: i=1; AL+hErEdi9OkhLSa9ycY1x8tzySItmxN7rvvOEvjVlLdr5mkSPh7pjhcBm9gqcglkbVfVzH7/ns=@vger.kernel.org
X-Gm-Message-State: APuU4Z/owoe2rgVacuvDSsd3kUWgLHZKieWzxcM2hz/dKoBDfibZswau
	6Azk/5u2wDX5hLk2dWa8DqxR9RF6xMiOHs+X5UzvoOlSMMIl5P/gH+qrZv055SCsau8XF/q3vaq
	cXFHm1egL6X0IcwUfXoBfogWTuLqBeJVuIWIU95vPV9Y1iQ2/l9oncws=
X-Gm-Gg: AYBFou3UCLhk/WPWEwOndQYcRkdGFTs3QXKXlxa14C159mIbceqsevfjxdRVXgV6Fkw
	QUGGCaVUiJN7pUGdLlEgNEo4qGXpBVhIuOXNTfte8IXl/hERV0qbHm2OVkGgDYlNbNOypyL+vHA
	ZRE3dPVj7pkNKcmkYcta/LprLS7UMyoUUuV5Bg3bh1r03sLrPq0sXLQsDMrNgU2GJqzBqyNbxzc
	McAcKSbXK84tZ02VIBwiNQJ9iOr+5REsG+i/W1mhqzXNsEIsluE8BYlI4By3LTrRF/SIf9D1EiE
	psC0MHLPIhmCSh1yJAHa+mU4hW2SSe2kmcq5L18muYCg2gctIGwZiwYqdKrhn3oAgXZa29fvfBZ
	bKHgug1scgw27sHUnsUUQX6rghG+eVPO9dPQpHdjBGIXuJj+WhRFRQ/93Qpbttgc=
X-Received: by 2002:a05:6102:162a:b0:7d2:cbb5:71f9 with SMTP id ada2fe7eead31-7d6ba376502mr69177137.7.1794947441782;
        Tue, 17 Nov 2026 12:30:41 -0800 (PST)
X-Received: by 2002:a05:6102:162a:b0:7d2:cbb5:71f9 with SMTP id ada2fe7eead31-7d6ba376502mr69155137.7.1794947441181;
        Tue, 17 Nov 2026 12:30:41 -0800 (PST)
Received: from localhost ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm134085935e9.10.2026.11.17.12.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:30:38 -0800 (PST)
Date: Tue, 17 Nov 2026 21:30:28 +0100
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
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix num tx queues in
 stmmac_xdp_get_tx_queue()
Message-ID: <avy5ZB3rb3-T-W7o@lore-qca>
References: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
 <179493105581.3291.4118659695077688589@kernel.org>
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
	protocol="application/pgp-signature"; boundary="yWCWm74GHDxD+Shx"
Content-Disposition: inline
In-Reply-To: <179493105581.3291.4118659695077688589@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MSBTYWx0ZWRfXxEyoRk6oC3hc
 3tXVPeBnYH1q2IpXvSTtA7VoGtGKD2Gh+nOIoCT6cZs8siMykhRoaTrpYyE987PQFuPBiWVKpIT
 Pu+PjS9ndgSyU64yyOO1nTq6MfNL0Qc=
X-Proofpoint-ORIG-GUID: VxH2GZzyGwjn9UwbHUeujqq-AOdvm2AW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MSBTYWx0ZWRfX4y/Y7HSffAEp
 uofxCmMWzGiqGFnWjVVeADk+ng9CH9MBfaRkTn4JyE5lmzvXl1lVYhq9+HOz5ToXRTaGpxdfNe5
 N46dPL3rBj6OUzo4pVIrBaVVhwVXO6pdL8NkJW9hsCKWx3gPuhNnQ9uyCEhziLuLeeItszVkPw3
 +ZrdYe58PvsIiLGwY47VWy/qDddog//1Rh3PlUH7kEAJ2c0xGmLkJyZB2m+3wsopojTn/S2dCz1
 ROLvU3jBMS78mzuScC1R2ZWjySZw53niBvW9RQ3KRAnNahAHgRysJQyYU51YUkPz4eablVXH9Dp
 6dG1fd62NoVWS+/8ypHg5nwcN5E/SI4v4CGQ0OwIrsc5/m3DfZUjX1gCJPeKE32mm+kLgfIagPD
 GBXmBG3/Hjxo9By/iokpbRMXBRV/4YMTYeeyovDPT/YLgcrCKjbRvRIIR9S3kqkSCXPghg/Y9bl
 yLtc0/wecvo9B1YM4Og==
X-Proofpoint-GUID: VxH2GZzyGwjn9UwbHUeujqq-AOdvm2AW
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afcb973 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=m1JEaiY4i_a_Ipqe4SAA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170081

--yWCWm74GHDxD+Shx
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

I spotted the issue during code development

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

This is a theoretical issue found during code inspection

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested it on a Qualcomm rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>=20
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--yWCWm74GHDxD+Shx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavy5ZAAKCRA6cBh0uS2t
rNETAQCGRKCmAlCPuoAkpL6wjQtgkOfJzgxEyivCOFRwznyeRgEAzxJ/oRmVS7b7
WgSqNYbiG98w/qgPodTtfuyjaYDQTws=
=BxgR
-----END PGP SIGNATURE-----

--yWCWm74GHDxD+Shx--
