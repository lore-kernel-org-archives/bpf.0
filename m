Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8724A6CCD
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544291; cv=none; b=d15KJ94wIwS+9uQZb+IFFCv+CerH0Yi8VcOIAb5OQrKsfTzc9rlYS9b57KPxqbfoTXFpmGYjMi1wGd1S99yF49ykcz9+uiL8guXMtMDlWc9qn0x4Ifi+r3KRRKPXnIH3TQ8ibaWfRzdJMNHYhQoDEQ0axoQHqGfU9s9mRWH0XKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544291; c=relaxed/simple;
	bh=SfkXslGx8sgCZpir/PS+vZbRiYluff5p3RdxGssUd4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqklip99gXLGpPl8YxUE6sFeMtYrPAAntAVBov73tY2IwJg/iAZw/6xS4YWV107tgC0dNaBUh3eSrg+kwrlDTSiIIG4YA4B+BFhYVI7rub8vYfVwfJBuvR9/k8mzsUgQzAAQ4YUDiuBxbGWBezSFp+yjZxID6TWlabyIsVe5Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUGhl/OX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XviILO+d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUGhl/OX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XviILO+d"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KChL2257077
	for <bpf@vger.kernel.org>; Fri, 9 Oct 2026 11:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jJ0C2lXXTxby71lnZlxrL1Qv
	aq608lZ8/YfqHwgkQmY=; b=WUGhl/OXzYmTiOa2sAGdDjWti01L7sojaGGZvnFn
	QEXTmo+umM+EIfoKulybB6yiqRiajp4F/kJmFCZO6ZBedF6wJuEEtmXJlInbWqUy
	+dpw0d5+wGHoc6LO90UU5O0jRgJ6n5+uC6bKtHNlLO2DScxMLWdlUlgseCogXxn/
	uY2XeDeEZyXUBy4+UvGH43rWZUOJ+D38a3jkipQuQAvHKPDEK1N+9Iswh8XpAy2x
	1TTFkIbS9DntHNh+BE0g1hqiCiHKgvaIjwl1DiOtZk1AHuB3c+wVZ+27BwXAQnXd
	k5yetvaU/JCv6It+majDrLsZscUUGiZX5yHuyiev7Ds0iQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nuft20m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 11:11:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc7a6e4e1so1748261685a.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791544282; x=1792149082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJ0C2lXXTxby71lnZlxrL1Qvaq608lZ8/YfqHwgkQmY=;
        b=XviILO+dP/IoBQNaVdFBqV5QNNVtK+5tOjc0ibePQkzmqSUQFpmRApCGmR2nxf1O88
         eYG7ahBnoSBqx1atrFovN4FXxHecNjbKVPCL251PW+wTtrdcxdTzgUWa8mwqbPLRh/MW
         D70C6PEXuBWy8IwVYyUvkmYcJ8BOTxpp/lCyoDa+3p2B9RkUhUYkHHuzn3CR6T1wLxPQ
         7M0pAVoLOXdXykA+LmO1ITazA7mtoDfHQHglUlnXc+LkORlV2kA7yKghwOdK9wXTrWwk
         KdK6bJDndovzVMQzSfh9+PYGgeEaOn9I9e3hzQ6e1oolHDVoxWFrRcaccFZMHaPY+kk1
         t36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544282; x=1792149082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJ0C2lXXTxby71lnZlxrL1Qvaq608lZ8/YfqHwgkQmY=;
        b=Bkn31vEzcJACBWnT1TGGDXH5OY5IGGgas7T9x7W4v4dUcmRH6HfnrBK8hrXinPp3U+
         6aEgyG1cOp1SmiKEM2wlwbyCMiPwAXcG2rb/lh4g2ZcIUZwA/RLQo9d6ealtKTfNZB/N
         O9UuIGTv/tFn+Dt7N96mXgYZTU4FE99TB09rh+5anNPCGHt5DQkxzTZnZ5KhLi6T3WEx
         EXQjHk74zB3/H2MJPiX2F0/rffRThw62Pvl0rNgBE7yAfJamL5OW0/fsFT45hiWzPndd
         /X3wwGbndg5i1OfAj5uIYkspPhjpmonXicrOtGAK8duI1sDdGEI+2fUVmiz187ku3V1I
         uz0w==
X-Forwarded-Encrypted: i=1; AKwUvByOfMJpPP17lXpka869oksXwOtvbCm0O0CGpNShWxgYUYbhUJWieUhxCpe6ofw7lQikW0k=@vger.kernel.org
X-Gm-Message-State: AFuF++lavGX1P7B0MeoxXM36BFFiZiYrsVLAMJyVTLv4wgiAn3aB2U1K
	YIyj6aDu3poM+u6kOuLGm9eZBodJtYGPGQeiXjLbtiQPYmPGNj9rDrduBinj4S4dpzF9Yrk1Exn
	nN//dyG7F0lqLy23jU3REnQlm3r+8hTrC/CgnGmimN9glsAs6/SHm2ZQ=
X-Gm-Gg: AYBFou2iIJMO4WJvaPkMXv1gEsFnFmTDl1/htid/5PKxXG/1ciVW8UAcu0l5+x760h2
	xD/rmEl5Zrq9i109c5rxDkK74CRLzXq+5uAnydW6BPyVZCfqsj81EUbpcpkdcSpGyHmpxTIEiSq
	heWzOddHpqG1BRgInuaVmINP6vdEi4fxXfsI9xTWU5E2tHVX+ssh0o/wLM6sLYcwBesQEX4IzeY
	8gQEg2lW2jGUbvv75LLPeKQEEp+aogEhQ4eVn+HR0d6JyWfDQZZ/KtFZRXVlsN/4TaEKGtt4jnJ
	RNuwp/OM7rd4W/wAW28lx29s0utH6/C4P8vByjDertIzhDob4VwaPuHM/1h0OGnQwgfUT5MccHY
	fMw+nWa0b+LTSHw==
X-Received: by 2002:a05:620a:4503:b0:93e:985c:43b0 with SMTP id af79cd13be357-93ebd248388mr200963085a.35.1791544281952;
        Fri, 09 Oct 2026 04:11:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93e:985c:43b0 with SMTP id af79cd13be357-93ebd248388mr200956485a.35.1791544281341;
        Fri, 09 Oct 2026 04:11:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm51414655e9.13.2026.10.09.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:11:20 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:11:19 +0200
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
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asjL1y_IlFSc5mx_@lore-desk>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <179154182368.2527009.383686573505818394@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iNGO0y3tjkkSqUbG"
Content-Disposition: inline
In-Reply-To: <179154182368.2527009.383686573505818394@kernel.org>
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8cbdb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=KWmWMJlhrGjfyJj_RUYA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NCBTYWx0ZWRfXylWB7e64JYLf
 b+7WOBQr/XPCLl272cR090owIRFlgE8d0EWWHu6AqdXC1gkIcLoXw11J3IV5XRFk+aZE0oZfRyx
 oq8zYYxUdUaOrhlPwBXgoI7Jm5N+mFY=
X-Proofpoint-GUID: wlQl1w_ZyhUOPATsmJNN7PhFeB_yeR2Z
X-Proofpoint-ORIG-GUID: wlQl1w_ZyhUOPATsmJNN7PhFeB_yeR2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NCBTYWx0ZWRfX4dNjktjYldE6
 ibIsOWT6Zv7f3DDgspt/MIYFD6HYI6lE6UkZXxS8X+Ka3tthLgb0VfLWZFvmxvC1VYnlbY3WemN
 pD43rAT6ec4hmXz5rgSNH7XyFS6tqlQjbwPuFpfqCrDUFcZNKETiO3e1M4lSAEpqvJIfi8+qdN5
 3tN8X5ad+9JJG5OoeJGqXo4MFhKte8ykT/GibnPgtFyoLyX+x7gaULlY0Fe/aF0vlGIZTFPePbL
 WGfN+SQcrn4Qv8GyyifD9ZCaKyKydGrMuqSQd73mJbeASAyFKuzwCAu0LcBnScVQ3L7oyLLv8Cg
 B95bjdx/5RvU/mtc8NHazvH71Anf10nNrCS2IBLVJmOdAeRDlQk2BuKCXQlpHOgCcEw41uN2PmW
 l+COpMr3cUrFtYBBB5Czl/KoN4dgdKDfFF4S9mnXG5GuPZlAmqw4Hs9uW0uwsrKiQdNEAKd5aAQ
 zKpdMNDYp0Tztm+KlFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090044

--iNGO0y3tjkkSqUbG
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

The issues were spotted during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

these are theoretical issues found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm Rb3-gen2 board.

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

--iNGO0y3tjkkSqUbG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasjL1wAKCRA6cBh0uS2t
rDZBAP41yvTFMU8+1QZM1eCpABAni8FZUvsNZWn43rp4Cy0JTwEArQJ0ZljVQcWc
ZhQ5t8p8rc1b3QXidv3jo7SQGsDLkQg=
=Q0sA
-----END PGP SIGNATURE-----

--iNGO0y3tjkkSqUbG--
