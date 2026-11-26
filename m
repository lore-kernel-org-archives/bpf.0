Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682924;
	b=d0yR/JOcJjSB65CdI6d4D0e9Db7WWJ2DkBBQ/tR6Tk/PcU0cn8cwcncbh3IIrXg4ANXq
	 Z1Ou9IELXeQfi3mM/WWHmsV2hCPhWk4TlE36Z+S2T5FOFzLYzfgqU6xVdyEPq/8/qGt64
	 AjeHhzsX9tY3x7Qs5wqhQyZBmLfSbUMF6CFHIVRdjM0eHATIFPKl5hV0formDIcNhyiFZ
	 xBHrBgn7C0njPvWt89gpGPKKHGml1SX3AlLFvBPbq1kcTwOSILiYQraF3FlJ1llBvCn6q
	 w/MgVY5rq6KVeGzRdCCPWCS3qKywrMnw5vnGw+g9xTUeOseaQe0DYZru6kDbnmgHWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682924;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PqoyykxduRZqHh/+n1fjoPJ1dR9TtXkyxrARIp0l8l4=;
	b=H0igYKO9FYFYrGhM+vCPWYNhJr2VWiLj2EToExW10pbQSNYDfylVZnWcYOrKLAHebwaz
	 Tcz1xbJcUMLRt5HG93HNyszsMaUhkB5FA95cVAW5ah86GuhLAytYmIQNa1CzyBAq08IlT
	 rP1LF5z6/Qxl8DWknqysjmeO3e6HKwH5VNrmrDEm9U/Nt8nkxVFNf+Q9Xz84UFu28OYXS
	 qQY91CaqY7Cwo5FRsc9+6iLPE9L/vHmpTLGKA7TqV8enauucxcl4nHmc3tnzfJNgMzpss
	 dT7ufa2aY8s1LrSQzd4Kflb8wiWrvqwY/YTcUOTIivP6HBWXrzBlB3SGGlaMvgEycPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JiNtauQU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YJvWSTBf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF98606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF98606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JiNtauQU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YJvWSTBf
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Ax8u2175653
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PqoyykxduRZqHh/+n1fjoPJ1
	dR9TtXkyxrARIp0l8l4=; b=JiNtauQUQFwzRoWkbgRJH8J+Bv91W4qwoISIePXT
	p0hjqPVm5pTANPXG1/jIR4SBuAIOK5onipHQxTcbkj1VI6q2dPJqjPMpiYAdcpcf
	PxKqNrVReayav0BAQuh8xVFCbRXhKHgikBMz8GPXZkHhCbXwizx2FSocWIf6tMgf
	FCawkgtnJFImef+KDyFs/sj5eZUiVTqyZdI7Vtgk25yAzKFc29onTwKJkzVbPq0T
	8t6YJq45NDFmLdu1T6NmM52zaMN6iQBrzlk/qzJfp99FeDZqJUUT1F+72C9RT+Qf
	AVTFc/LU1AvzHccFxXnD98ye4rBp0zVfSZq2lGMnq0D63Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahujty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:48:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f3969a2a7so962714585a.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795682922; x=1796287722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PqoyykxduRZqHh/+n1fjoPJ1dR9TtXkyxrARIp0l8l4=;
        b=YJvWSTBfKiJukyIsx39mEIjxfiJbH25+6MISDSNpN9G+wAYG4IzvwOvf7p7yI12SEV
         KEeUZOtyF20A5WHE46qjSZ18iHS8zJd2n/n2mrjw8L3xTNvEh+23ELE3a7Px/fEfL1iQ
         q3DYUAhA6kQ0v7XAfuat4zn0ix2lOX8GZVaPHWGQfzUxojQW8ddiW9UpNdnxpfRFHpgq
         K97YBOVEmVfvJs4ZatjaXeYSUef1rSv8JafjyoUUiRDIzPcZZrjilp8gBQRC8eqzli69
         0AQEeHqk+NPGkmUUn8zolXSSioAXzYBfn1XuUzbgivI/L+Ocjj2jZ9T0oGap1yMam3X3
         5naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682922; x=1796287722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqoyykxduRZqHh/+n1fjoPJ1dR9TtXkyxrARIp0l8l4=;
        b=QOpTqFefE+0c/KQcuzTJSX0ezleIm5/fPLCkFIctC0n4DZZCX65FZgwizQ43MlpO3f
         bHRth/nX8vgC8fa7ROZ9uxRWgM3aYHeaGRGr/FjHeb6COT44dyLLpUu1LQasc9F9odnh
         Mi5l/nDJNyEcoQtpZTZ97L898n9BbV/fJTl604cCHl9HsgjfWAKvtG8kMBm9MFWKhbA6
         4I+itjC8lu+eLjKeWJmFlO+8RII2DqdAzXVnw3Cv9HbKMdSRDMtXFNA49xPTYzINPnLV
         q7+F/fpn4Jtm3Ts3BSekrPB6MOGSB8ZQEOPYY07E0WSJ3Hzg3NRcaDgR1OIagTeTeLi/
         MqxA==
X-Forwarded-Encrypted: i=1; AL+hErHnt4KOQkafzs4D+CBneJYlKbPkWknmcga1SUgMqhpeJfajW56Qe7XgBgIHQYZGhMR8AaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RguGM/9O3W0bNeNkckkDHhQkXbUYFyU7ed9FC98dW7Ft25/Ei
	fRZSRg9TWPcdj+HDQmZigNBa2+LOjVLl7+lYcbIHBPm15UUmrqKsWJ5NxXueUSZkMSi3fjuIA0T
	6/aJ+cA/55V5ULGF71iv8GPTE9EAfaT5FkJ38rxA+L8zPycfcYPBijaA=
X-Gm-Gg: AZFdTZcEbUs/iCmUb/baovCVrDzRqMulZHkkVYrqyAAqDc1N2I8aKIp5mGkPK+8RueI
	FQ13Y9b8IpNKxGs4l1iv9x0sNddJS/xle09pBI+1CCCBOwLOZh4nLGL9Blt8KzEkabU7kGflLdv
	QPQDZs69TZjzeknOW/UFaDqmVWOGdn0RP/nGEI7tmF9LRsCy3VObJUpPJmuIEqd3E+dked/hjhq
	Dm88r8kPVZJhvIiVgI3dIabKYrmkFimPHIji3PxJW9pTFfV5xirstxUZQhHNrtoUFXFe0CZ3ESr
	/JlriTBBLENG/TcqQSBcgl49SUcnXBq/9efH542X17kNc45QYl4Zn3XRqhz39RMlUtky5u5T9eP
	IjxTvx2rvlEfsHqdIvZQChodErzia+3cSqFCuzsoET5H45/70hxlSmDsPRrj0VpYOwrPo2TMZv4
	hq8pngJt2EyR3Tzj5ZMUPW/ytITyE=
X-Received: by 2002:a05:620a:4722:b0:93f:5ab9:fda7 with SMTP id af79cd13be357-949bab13ec8mr3826737785a.42.1795682922052;
        Thu, 26 Nov 2026 00:48:42 -0800 (PST)
X-Received: by 2002:a05:620a:4722:b0:93f:5ab9:fda7 with SMTP id af79cd13be357-949bab13ec8mr3826734185a.42.1795682921501;
        Thu, 26 Nov 2026 00:48:41 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm486755395e9.9.2026.11.26.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:48:40 -0800 (PST)
Date: Thu, 26 Nov 2026 09:48:39 +0100
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
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Peilin He <he.peilin@zte.com.cn>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v13 0/5] net: stmmac: introduce XDP rx
 multi-buff support
Message-ID: <awfyZw_KPtBbL4Hv@lore-desk>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
 <179561841924.3294.5101937008242312303@kernel.org>
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
	protocol="application/pgp-signature"; boundary="21Ds69qcq4+cHuSi"
Content-Disposition: inline
In-Reply-To: <179561841924.3294.5101937008242312303@kernel.org>
X-Proofpoint-GUID: k5mSP6ufwI5ACcM34QAL9kEpQUmmg99E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX8lP0FdSorWpw
 B46J74ddQ0oAoqLp5SsyplQ+EXGZm8NXuCt75QSNwz/uyjx1uapYfz8T/p9kgOzCG+TUY7b3gwB
 sls0lSICcp19y2nIQGSMtvjzrFMOILo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX4ZpfMTNKh7ds
 0iIDKxWJ7WH2yFcV4XQ5D66haPnDVvB2K8RIZQ9qR963qF8hLeYFHP8xuopCP0oU2KEn6jbwQ8r
 1VmMCGwsCPqUfpJ0sn1WwHlxo2P5bMYYkS3IWujdLWNQZD7ON80EfxydwRRlYzb/Y/hJpfrAiwC
 M0kjTTrRkuaBqgIzO3V/RKpujmoRMFMk6tvXuyraKvkfkNHOML3GLC+Os2oHts8ui85xQgMlxoZ
 Yk/wF9qGLjiQhm5mN28SmPJo0kXEALVKdN4zfd7JPi0Brd8sFiN57E5CQHGpnfnh4Jzj50ujJai
 4ep2TThJNXm+71GqVwDdpTRhhPQJiBSyLw97B+NK+WNjHtTxXTq2ij+Xn9UquPF4daZfJpjz6Pk
 y9a30JgwqXtp/4lQj9tVYb7wBBN8vrCKlnULoGh4TAaWBR4QW/WXzPohaHmIJIFPoL44Gv3bHCX
 4b9EZm5yuDBlZefBkAw==
X-Proofpoint-ORIG-GUID: k5mSP6ufwI5ACcM34QAL9kEpQUmmg99E
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b07f26b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=njfGP3QAHdpSEUKGj5kA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260033

--21Ds69qcq4+cHuSi
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

The issue has been discovered during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

This is a theoretical issue spotted during code development.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch using a Qualcomm rb3-gen2 board.

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

--21Ds69qcq4+cHuSi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawfyZwAKCRA6cBh0uS2t
rEunAQD6nl/VLCn+I8bSqRZkXf09LIErn40/UwJE7r4eCWDJDAD/VfwnrMJKYCca
oaGdT3AhfeLSpSBeDENyGX4j0s2yPAo=
=Ssfi
-----END PGP SIGNATURE-----

--21Ds69qcq4+cHuSi--
