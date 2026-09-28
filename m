Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EA4EDCD0
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614258; cv=none; b=ZWdLrjuVjtyIs0B1d0WhsxXF6oySrevtkUchvAu37WhxGiz4hLZvISvXRbcCZMjIuccOfarv7NA22hLkIskMOyWjWlaUsvW00+wCa25h+WZYsWgHdZIiXTNsW5ewdyXb0rmH//K7sjR+VExnueNdXFCUQEjUJy/NofRkBeybE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614258; c=relaxed/simple;
	bh=KavxK1cVNSFo/f2noo9bVMLFOKSHoADbEds80VIGwnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRwRP+6eDdCDDBv2IUgAWXhRFdrUDV4o8yltVmZHJBrWN/b/RSk0bGGwWESzUF3MJqL3hNu9CgSDWkFcYtanSat6b9w1Xjv7AgABWVUj6N0n5/JWe8GC81ng9oVlJC7kZ2uOwDpV8geH6Aw2/405IL+L5bYrf0Dq12YSRswLjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvAwKN3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVTA7/ct; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvAwKN3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVTA7/ct"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe2AG1498412
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 16:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AEJwMuNdWbkUsEIiAW+C+X/O
	W25rxvd3CXrZOFKFM7w=; b=QvAwKN3pXzy0j9a/+G9Q+dWtdsyL/FyKMf9IFnXp
	bdsbTeSPJulYTmG7xRaBahf1lHfF8mqbP8ycXR/WtN8S9bzG1G/KJQoRt0HOoRrD
	KFk/BtN13NX2aNcF51zHt48QH1aSBxPmTfa3n5ubGetcY8+AQJfwPG4J6oO3gdc1
	xCf/OMR3gHv0ThJxxs2OCV3q/uh+8xWTtalwHf2U6W6JccX9OlOgtqrkn1MFnR4m
	pPZsdS4jxVemiNBsTVm4MBNguMBYFdyo5DHOlrKLPc5j6DV8ZUDi2UZPjLfX//QJ
	2sD6dO+P2kjz1XEzAZkUsVTrSy5WvfUZscPjt9YGJHSinQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mtc3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 16:50:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530f5e827c6so76521221cf.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790614255; x=1791219055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEJwMuNdWbkUsEIiAW+C+X/OW25rxvd3CXrZOFKFM7w=;
        b=iVTA7/ctYjFFB1FBCUWq/vflDBuldtZGfLJuDuqKBg2A9PvtrtmrRNP0piZchCu5g9
         cwJHEiGH64KihQwO78HrpYHwGe/4OVHQYpii8T3TrWA4oWoRzKsMQwQzL74F5K/A4dRT
         mXG+d29tERKOs4ZpEsArMXq/Ji+5PvvA+6gW4GN1p+hqh5XPN8M43UC8NERBNChA+f7q
         1LAY1yV9ZskEjMgjsiUkP2sqJ2C4T+2mswPSdTOu297bcY5ImFaiPdhljnHVDv+TIluV
         0X1UmZjcaPxELd6s/Z1sImppzwOOuBr28BlLCCTlhfm5jikWKiWmbRXALyCTntPN/fV1
         anNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614255; x=1791219055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEJwMuNdWbkUsEIiAW+C+X/OW25rxvd3CXrZOFKFM7w=;
        b=kwpuUKFIV9DCo4hcZA+QilZUIJoL1XCYnVtN1xZDteLNqsMRrRsGrEpUAA6XzQKOhX
         Zq6CcBLu9BbmhvoaU0HHbS3Pd2JjH3mNA2T4/IXlY41jnaRkDEBKFwj0MZwdMOf8xw2h
         +1WaO2lEJScolC9ZD8ICSYmlXJ5b/ISz7M5TcEEJf9jjiW0jxqnPX33+kh8Li525ee6J
         8BlK7lN0UfTNSjrTcj4hx/k4+RaWOQiUVj12Yr0ZmSjaeLo7sQGmM9LZENks7t8LB2O3
         PR0g3ds4o2Ts80Ulcsdu2bGRWYxtHj37K9VDzjIPKp+QCUaNTOjoep75/Kls8s0iYmW9
         6yhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwJAugflPytwpxrTbtuDKOMdx3CXu7k4UpZt+lkRyVgs4cGIckfTk95c2YgSuiBtYrQOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ldQi/87tdwcblYuVlGcCe414FHbsyNshH6wiWSVaSPyniapeKo
	OUMhfsKpPZaFoME3Av3tFIoY2S7oFqvyAnanikj9HyTztJLEt77CBnN297omSYli/aDBcvgxjxq
	q4zvfFbygdv32GVHePnshiAWZZ0M4tCS9dyusleycIiWHamOo/xCMTtW1BT/uwgU=
X-Gm-Gg: AYBFou1eEBeQHTwWeYgU9dGCn7ThXNuTHkJOaSMins8jvETBQ0raiFFeDjm0oaVO39h
	uh8R/0dHIC9halKXM80nPy98bwDwl6Pj1yF4JloO5jvFEf6VN5Nz6M1haJmXSrs4ZUipfGZLFKz
	ia7NgQk74T4yvf9ZsJLXqLgddf1yi3vUcl3njjegzV1Upv7IIbx8tf1GNM2VquKWAb6F+MlsMrr
	fBFMrYl8WSySkwfgqqw/wKJ9Mb8iMjxT6wQL6SIiRqDMve2/O5SWpWFMNNnuilJTYjASpCuKgyW
	QxXayYmUPOyF9713ILm5FAKn4hQRI9SGXbybZ62spJrEOW1CfdHMvC/UBHV2Dxu5lsi6bwNsykY
	OUa2uqo6JAkNRAw==
X-Received: by 2002:a05:620a:4107:b0:939:feee:630 with SMTP id af79cd13be357-93c43cd7b38mr2141950785a.30.1790614254628;
        Mon, 28 Sep 2026 09:50:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:939:feee:630 with SMTP id af79cd13be357-93c43cd7b38mr2141944285a.30.1790614254002;
        Mon, 28 Sep 2026 09:50:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm7214715e9.9.2026.09.28.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:50:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:50:52 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <arqa7KsmLQBEEFgz@lore-desk>
References: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
 <87a4p1lfx8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gy95e9gmsXRjrM3A"
Content-Disposition: inline
In-Reply-To: <87a4p1lfx8.fsf@toke.dk>
X-Proofpoint-ORIG-GUID: 2uFST4NDWCZKCB_vZTQJitLY3LV6j-Vs
X-Proofpoint-GUID: 2uFST4NDWCZKCB_vZTQJitLY3LV6j-Vs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfXyZxWHevVKENG
 sYY7Ec4ZbD3ooUo4JIWGOlZ3+Jih/eZK99x0gpysdvAV8PBeoHtyqK3xd/MShjwhM2TdrnU9vgM
 R5YfnUkiZvmk5fMx62EG+0gGRNOUOJhUI3/4AqnUqlYGex8cQsLK1OwBz1+ctgvu00+X6l9SCGT
 SzUSUp4R3bI/cirCQNTV1YbTVDsqBOUQrYNnQEHuQkJ6DwctONqh4DVoOZElSsLhyT3BEPKtXdr
 7s0EaHMlAsbi9E+IPYwktv5MebzLTHQ8NKoHHcCqGcExp8mdHHrlTCgTG9menAlRJ08FeUg2hBb
 vVWYfM9iPunauzbWpDoS8LdkhqMVdVY8zD1hnlL+ZYo9LPJbfp7s7kHXJvN/juPRGrPj4xL+8sO
 6rR0hUcHq/vX0Q4AZREAQzR6SqsuDmJEi9PmJ1K3Ri2B6V77LFyJLWt2ueHHuWqjSM5+YMGgZNW
 /s2MhVDRdUb+y/gXQ2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfX3wUFYK07SdbJ
 4E5i2O1EGCNGyP8ZEt6MvvWgG8jM977PDrajJkKLcRzh4fh61ldye6ns6G9KhcdAPR3KTfT05V3
 CwjHsYfnHvFgU/gxE4wfe3Ve5SPIMZE=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba9aef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6vfMxEDs10Kq_Iw58-sA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=CjuIK1q_8ugA:10 a=wjcY07i5F9j0dTqSbIAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280067

--Gy95e9gmsXRjrM3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28, Toke wrote:
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com> writes:
>=20
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
> >
> > Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> > for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
> >
> > Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info =
utility routine")
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Rename xdp_buff_clear_flags() in xdp_reinit_buf().
> > - Link to v2: https://lore.kernel.org/r/20260923-mvneta-xdp-clear-frag-=
fix-v2-1-298693a7ea6b@oss.qualcomm.com
> >
> > Changes in v2:
> > - Introduce xdp_buff_clear_flags() utility routine.
> > - Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-=
fix-v1-1-d7efadecf959@oss.qualcomm.com
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 2 +-
> >  include/net/xdp.h                     | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index c2b1098d8d1d..485af7e395ae 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
> > =20
> >  	/* Prefetch header */
> >  	prefetch(data);
> > -	xdp_buff_clear_frags_flag(xdp);
> > +	xdp_reinit_buf(xdp);
>=20
> nit: we spell buff with two f's everywhere else, so seems a bit odd to
> have only one here...

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> -Toke
>=20

--Gy95e9gmsXRjrM3A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarqa7AAKCRA6cBh0uS2t
rGN+AQCgzylNbBRRAVti6uywH1NlQpr2moxmRrEOlu+1BAh1SgEAzCPkDd3rgq/b
90YUCshhnIJIFbQOPGHHwyTc6JdKBwE=
=jfg4
-----END PGP SIGNATURE-----

--Gy95e9gmsXRjrM3A--
