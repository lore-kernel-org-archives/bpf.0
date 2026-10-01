Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13733EC6A9
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840339; cv=none; b=XcqG0AmZ94jm9c32VN56CH7RoEH49VYwTeW+SMvcyFURGYucJcxV5hhcPe8Lt4fcPU/2QTXCF13FZxvs7X1kXSsvsFAZr8YTTdDIUPYEyT4vd+Csy0jrF7fLK7KWaJ6UBwCiHO2eK7la3Wuf5UDDb1jPHoZWOD5xBA3eXKo6Ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840339; c=relaxed/simple;
	bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH0qzEd3JO+TPgQOcQJFXbwzndc0dnErbBcLPPJDhNhGGyq7at7m+i8gBdjYLX8HRIuI8DK9WeVbMdq7wpadYFOYexWFWaKGOdyJoisPreAPrFuxsEeUlvx8vA532vTe3OYCRJLWAfPa0iBFeyxQbBFJhDDpP6YcEGt5BBDJEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+Jpc+D0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PfdugEVC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+Jpc+D0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PfdugEVC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xQxj2887820
	for <bpf@vger.kernel.org>; Thu, 1 Oct 2026 07:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YhTbhaT44QAyG0Cs+DvgfplU
	2GijMISZ0oYsDe7E7yI=; b=W+Jpc+D08wXsaRPIiuiDDOQ9lgwTJWezDzT3BEXY
	byIPIxxPXbkw1hVsm+wigLyH4Og6wIdG+jYQ7FAKyZPXao6aO0lKPjy0cVcvj24J
	A8J7IINLiMGJOKQrNaqqQMs5bOhai1e3A2+JwOcQRYn0nvtFqrVHljJP3u93CygU
	s1ke6zdVuAU/t6yI38cHgSYdwmdWscmDhLA9W6EjwNK2mWMbmBcVKyXzNKwJMtcH
	Xzj8R7LzZ+JVQydCSJNUf4lJ79nwPH0GqR5LKTpcqupBjmDM3POI5zjXfXXBoRY8
	yPwW6upKTpf/3HkoHBP3azN4+M9XN4OzPXZssB3Ygx9GrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tkyae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 07:38:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-532d420abc1so127193781cf.1
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790840336; x=1791445136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
        b=PfdugEVConOSR0+9iDGLS5642uKrc4gbJfB5qRbkVOJ58SiHiHOBaKyu5IUIK26lCv
         GJ7q0WcWkJXHjZijqyi3xi/VP/hemuEuvz9G2gqAaxrBaMSFHs9qEHVlap9Ut476yR3I
         wHMYpcb6h0cvKgI4QTqzaGNJcgVfqOpp1VhzHVoga6KJ76cmI8aO1b4dYDYLpoNpe9/a
         VeLiqwgqThSBikCzh6pnmWsXy1wIQZtviLWgl74WWZWFruTSy0Ev4IhaJlG+2K1W8egB
         j8wTGA1I87cTJXxRrA/XD5Rqh9iL4ukt36gDEKA3PLo5n1aIyMxv3v00YSt6tDePV7ee
         OOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840336; x=1791445136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
        b=Ed9g1xhaIjfr1g579utYtMZJtBfMG8oOhrD4ZLVzYA3vhsH5IRy580i6h0G3BebF37
         PknHOgYRnxZWjK41+edXqf32eyjYd2plat0zOibBau2VUNICZPnSE8oG2eReCisA17UI
         s0TRfD58HFdBGQeYzJnx3G8q09KbR7CJlNCFNatZUdceUCkRnr43D98HJtUrcj5Iw+J0
         dmzmuQxTOvyBHV2k4X9L898+L2mVlqdvdI+fzqqZ81n8kF++X1ZTOoNP8vP6/1ZsNdVF
         hO0iuXGzYw0QSSMOoLgNdDO0PUm/6mwE40+ml9jZ0ts4u9Iqvvhl0YkYB+5+aJTWLS0j
         l7OA==
X-Forwarded-Encrypted: i=1; AKwUvBy3p22hlYwGcns9pEtZ4mBRv2YOEWz9oVHAT3g9R3jJ5rNCbe/oyiwYFwdEAb0z2Z+CWnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lBt4rpzgYUQhKwgMb8n9BCcJ3W4HBv0kqFgWoS5EyEpd6Cs7Xa
	XFrQLXgX1OHrpFHlxyYZ22muo/6Zvia9Nt6FEu5nvUX3/+xOlrqkLy9ZFw5IcnofKBoynb2cJnh
	PTl1UazapnLArW5MRhi1WJqOwZ9EEleQtNXrwXH9Imbi4GO8SxjxAM2c=
X-Gm-Gg: AYBFou1QYXC/++EgowmT8rn+NdHuVBsZ+XjoicmonKWHCxwwKZ1oxsK54FfdSjfqLie
	mTvlI+YPCPpqh81L2HzxMIEzgkI1IiG9Ne0l7OG12RCenXjUf8flDyn4wY1ULEc4mTg11XdgJ+O
	CPWrNWkVFwE6box8093ph2HBkVsrjHKchvY2QMbrbjoJWnM0j0GrLSE6xrkNIsvyOa8gWr6hSru
	VdAk1rQEhcHJRd8ETJYlN6grdE+4w39NO/p4jO0VS1VAZAZ6BO/wo8wIZyy+1QbFnN1DUUwIr0i
	UJHKyDDD5xvoc6GZt+pKLEO1W22C+5qdkl8sQhEH9z082XNWjhMpK3fNxiYJlqVwxE/RL2Myc0u
	KFbYa9OS3nuEglA==
X-Received: by 2002:a05:622a:e3ce:10b0:533:8e6b:260e with SMTP id d75a77b69052e-5338e6b28ffmr7739911cf.31.1790840335668;
        Thu, 01 Oct 2026 00:38:55 -0700 (PDT)
X-Received: by 2002:a05:622a:e3ce:10b0:533:8e6b:260e with SMTP id d75a77b69052e-5338e6b28ffmr7739681cf.31.1790840334995;
        Thu, 01 Oct 2026 00:38:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98f72fsm43817135e9.11.2026.10.01.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:38:54 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:38:53 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <ar4ODcdhTW9YkZmD@lore-desk>
References: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
 <20260930173940.1c5f55c0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rodYHr3sibE3NhxX"
Content-Disposition: inline
In-Reply-To: <20260930173940.1c5f55c0@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX5NmJWmAy3jun
 zzgtQv+0HBKVVNQktk/xiKCWC/D2sbd8SZvZnqTnOZhB4rbWk06xYr5/dTJgFJqHVfvS8p7biWR
 mHK0aW/vs0yxpEHvwQOEoovLfyGJ7qM=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abe0e10 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=uF5hQ00_2t6gHad61HsA:9
 a=CjuIK1q_8ugA:10 a=2r8B7bCDcRZpvO-uCnwA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: J5FR4D003vGTRsQ1_0LH-C8fgvY-qJ_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX/asOD1Ec9vBf
 QX4+h3M+5NJkHmfE2EbWT31qDK4KVQhGg9P/mrpTWtEXLuLzjoVCPJZXKL7wmHR6aApAl7HyxPU
 6XmOx4HCg6pgV9+ECglonIPFtzmmdXNVFxW5NqVmnx5Pgm0J1b5CFrY61lskqPTK5jU6AkggTO6
 wGd0MPwqT0eWEJvW7RI2DtPOuOhmR8zW+JGzI/BEhP9qXc0vQQcMI1MLzIozsk5L1tQhlHjce9z
 A9MUfn+RrjdoJruL6tbFFKVPgkJuLngDLSJwccCx2yWuWljSIfIVoS0tVn0RMzIkTWo3+Gkmv2J
 TnGZTdZPTy6YPGV9lqkItnT4P8iOcY1CcXOg52grwskbx2Dm6Se/+XvL4JyG2uUGUQNno1+0/Wq
 fznY0T93zzYraPuHL0dUjJO0BPmOo7b94cwFOlxrW8xfsWrFyWuWPt+h7KGS41VOrHYz6AFqpny
 iNCgV71Y8ZGkGQNkBeA==
X-Proofpoint-GUID: J5FR4D003vGTRsQ1_0LH-C8fgvY-qJ_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010030

--rodYHr3sibE3NhxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 29 Sep 2026 15:43:03 +0200 Lorenzo Bianconi wrote:
> > mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> > xdp_buff when a fragment page is a pfmemalloc one (page under memory
> > pressure). The xdp_buff is reused for the next frame, but only the
> > XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> > bit leaked from one frame into the following ones. mvneta_swbm_build_sk=
b()
> > propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_inf=
o(),
> > so the skb of a subsequent fragmented frame could be wrongly marked as
> > pfmemalloc even if none of its pages are under pressure.
> >=20
> > Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> > for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
>=20
> Is there a reason you're not adding the info sinfo bot is asking for?

nope sorry :(. I have just forgot to reply. I will do next time.

Regards,
Lorenzo

--rodYHr3sibE3NhxX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar4ODQAKCRA6cBh0uS2t
rJQAAQDg5ax7C/+1yFaZ+e2cR9P90DLOCk7ivKjVB04+eLBX3QD+OAvRTExhY5q9
b3+WBnS2kKrC44PnWWBkKHqVLVoC1AM=
=VXRl
-----END PGP SIGNATURE-----

--rodYHr3sibE3NhxX--
