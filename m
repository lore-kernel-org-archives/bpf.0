Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109269;
	b=4+1aoqJvxOGOrF4dltd+/bY0rUDwuenIo45Whqa/+f1EcwbfMySBSBpRtiRFyfnMPJ+t
	 8yVUOqEFnKddHQv3PmHWRycTuFfvsNCIYWuS6EEPUgDZGlc2hdlPE5AkVR9TYyi/j0P+x
	 3XLP9TcJGoAQvM2Jh+w+j1kHb2892ISWbix9X+Igajyfou8MCDGwaA0dCc5tSbJDBG6kx
	 2RzuIo5wWyNkGUwXAOXFgUsBfP92GsjXdFhwL3AmcFCVAPg5cth09zBsTJFqr2/nyb0uM
	 lAomUn27+d6XqDfHm7vlkdpyHN9G0XrEORbHsL3v4ObJ5bAJ81sY5oekphAQbGGp75w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109269;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
	b=VB+w7q7gUAI58rzYuzPR+o0ezK0sD8n7246NCF1jr5F7tiBZbiMSyaW6M3K3wV2sQXSo
	 WYIEupYVtAQpo3zK7S1G5NnhP7u7uKhu2MD2bpgTBBVVknK0AyDaPe87d2B0wRm+I/tu3
	 DxBPqVVsLFvPngeTiEfWxxx7K7WNPu7/m/cVtox8Xyj7Jiq00YBHnK8e24sQBgmtLTMeB
	 xvZfH3dPuzLOYoA5zp+NfdUFJH7bm+PqquNN7VFNfceZkBXeZGIDs+Lc5WgCx2+brRV23
	 85UG7s2K6kCrUBziESaT81/KX18Ktusunilk+W5baHVxczRK2HIbDP+XsbSP1AmtMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnTpACR7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Os36awun;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA7606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FA7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnTpACR7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Os36awun
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoCTf3449802
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v9r3g5keo8SdS9B4mGrqQdco
	Tte1OjZar4nWVFfkp8s=; b=cnTpACR7Ca15wLGgLXZxFnkBR6lQFrKltQqV4MeH
	MyOGSawRypQrtAkwkKSwCIIocHhwNmD8vT1sa0Ejw58JGwNk29gUJuEW6CpH4Gf0
	XgxjpqVWjxO5NmlorvmBch2tXjvHPAX96+k1WXXEqjNk7dNpSikHjJt1nBKLs7h1
	4EYdKoREtnKcoVekxMC4VswLs1nMIvRT+gU7g0g3Wvl6W1eElypkqcc95+aQzE3B
	FGSy/T0Dq60GQU48UNPOut+Nfkt4aBMXSEidxbpwCGdE9BCtVY12kN+nMRWyw7Yk
	HJHzyJzaiD4+YFxC4ycFc8lwsQJsUvT5j0P1YS3b9kGaoQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91astr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:54:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c79ad0decso5557546d6.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793109267; x=1793714067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
        b=Os36awunu1uyJJVfiyijciFjgcYl4DhZmeuB5znX01fUX/Zy3tpeK9l/MLoeIWXA+N
         Lr5OhZ3DLUxEXjVYouvDAc0oTHjZYsTVzXIGLRvzKUJbvyCoIaY1h+gV0CzlJ3Naq5d7
         rd+OmovAtNFBVDLIkt0u+rmSv1wsdPDS+O+bOWS4R6IwnPWxR48i5emT9dF3bans7U9v
         Rhgw2zWMpwQT6Y3zL81wq04glL/xjGjIGt+1IKXlaKQfPTsSEWF3RPiQTvweqTmRB1o2
         QVdC7vpgBbXafRlQNOJmsLUMXBR0CxMy/YUqWeNQadUIods+pTqg0utlx8dRur6y6vIK
         YLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109267; x=1793714067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
        b=UvzumEissh7TqjjwoE2KVMSAtk2FYGwjSHA8Cb3tCB/7+vdnyQoLa/PCROmsKO8nQ2
         PqF/tay4DeRzYMeQPhtdLCcceSdOe+a0nfRCj3myO69oenEzHUuEumqMzyBSgHIpENyy
         kUA9r7Quc/gMsYQn4Fi6CG3Y8Gbt0uUmmBx+i9KYYvY56DUlipHgxrn4yNxxZMz/o6fZ
         8NxaO5ZiDPdJEO/CrDp7XDZ5lpRDZcbPgkzea3+oFxaQrhYfRcZm+lXMF1PdUOg1gM7b
         9tB8DFOtWQH8vpZWF8+sfhWH/v1YqPBQaOpIILlybSN1AhfCr865rLtVMHiatWVBVqrT
         0U6w==
X-Forwarded-Encrypted: i=1; AKwUvBxdrWH8z/SvBuigfOUpOfOpwC9szCtvwM2kvFb4AS/gLU4QLPtlQ957PWuJ72ycAlhlkbI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJtQn7KD4JJCaAxMMNyxiBT72FAf9vVy26M+h3WaVDUgRDp2sY
	p9ayaF93ZgMP1AMsmNHauGv9uuduujKMzW/goGOYYCYs00jOD5NIOvkApMw/tdST52qGjyUJ2Cn
	bQkUwoum7CgiBwkGy+J8RMkfSU0hMNleVgPxTquO7WPt1Uyc97UntNoo=
X-Gm-Gg: AYBFou0l91Iwyjyt8k/aGVKjc+IlA7CnCosGgbwoPljgshEaHO0lRbzUSQEdKOHeUhw
	f/AA445swBJwglI4BFEVrWRwwXlCVkEJU53E8MVB8PjqhIB1m6bCb+ecCIQD2xSe/Xh0UH07vKV
	0LSWJ67EOS16eeO0IdMQHjjBZLkog/MMVm/9hIdtQc6PejAXHq9zdeP0i0mPn1e8bBv0Sr9Ry1b
	9Ar0+oujOoxIknCkuCH+cWiiTget2ec4QA176+7g6HSRP0c6MM64wkB1CPO2luYouD8QjYU9xXg
	pgxiK6qvZr64TjaGfuBbIpj3QPGY3aUnVCeDA0nDcw4dbG/6O5Z/h5uTQk9Ef1pDL2XqsgnIuFt
	p1kqwxpJhUCM=
X-Received: by 2002:a05:620a:3945:b0:93e:f931:a886 with SMTP id af79cd13be357-940ef927359mr1664223485a.57.1793109266509;
        Tue, 27 Oct 2026 06:54:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3945:b0:93e:f931:a886 with SMTP id af79cd13be357-940ef927359mr1664218585a.57.1793109265836;
        Tue, 27 Oct 2026 06:54:25 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e208d1sm144595566b.85.2026.10.27.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:54:24 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:54:24 +0100
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
Subject: Re: [PATCH net v2 0/6] net: stmmac: XDP path fixes
Message-ID: <auCtEFmNWwGPHKxp@lore-desk>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
 <179310900894.3327.16366770051104266138@kernel.org>
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
	protocol="application/pgp-signature"; boundary="Wa2Ya5IEJj5sSuGt"
Content-Disposition: inline
In-Reply-To: <179310900894.3327.16366770051104266138@kernel.org>
X-Proofpoint-ORIG-GUID: HdR8nQOnQ-rl58JeIMoomU4wyXd_KSSy
X-Proofpoint-GUID: HdR8nQOnQ-rl58JeIMoomU4wyXd_KSSy
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0ad13 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=jeKYxtEjmYGD5WCmXysA:9 a=CjuIK1q_8ugA:10 a=LoTJxW7uYgufmn43WDUA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX8bIJPRhafSHE
 aIuV8/k8lO9GueXsuhGF2KXJvU4yugWHteKp7WMtAywVCTXJYVeEqOd8I0D3e8MzSkohGXvmhBF
 Xm7k+RXJ+HflDQBJrLOHNkm9/0IpXds1HvGRwE6z3w2BZUuiwbhpoXR7jeZJaQ6LQtEXMN47q+5
 9ymmaoKlt6G7uzt/LoqsjBBeLhc6y48HGMRsidlafY3ctTR3MJV743sG4/vda8O1XnUaQ6Q0wXN
 8YjnDueeCWTdsoX/zer3C6y4m8Oy9Xj+r8Qm8Am0QLzJvn5nwdQBW6q13FbY3CUseTvQlBqR7fy
 fp8hLgzBAHEJcXC2TrXLVoU87GAyGtDDU3Yk44ncscoc2o7zZjW5mecKQuAMoSSi+/YR7BlN6LQ
 g6fHdawChYEb0YuJtJlVvATbie9XAv7tiuQ6thQcyGoW9h5VJFXitrGX6Q06wrR2SEeZwS/wiWH
 zElYQ4Fqmfe3aOQHqrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX4VRTGIxCil5G
 E+94zMELimufHe9cpL0yj6r6A9azNfeVYXUeHknaC2M89fB1ulchnA0CUBjbUjdBmrbn5cSZC0b
 vQbLxrWDxTuy14Xru0eTtNG43Oa5eo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

--Wa2Ya5IEJj5sSuGt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sinfo@kernel.org wrote:
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

They are real issues reported by sashiko or found during code inspection

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The series has been tested on Qualcomm rb3-gen2 board.

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

--Wa2Ya5IEJj5sSuGt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCtEAAKCRA6cBh0uS2t
rIR1AQCr+nG/Dx+y/qw8KFwMjZLoidUREPuG+M43m63c8kjpngD/Smo+d7AhTLzI
C30f4bu34pPv+D7xj0sZCyysyVmqZws=
=pve4
-----END PGP SIGNATURE-----

--Wa2Ya5IEJj5sSuGt--
