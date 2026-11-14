Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679742;
	b=XEJ3Wj7UCPtJmtywUydCahAkKA30uFviJ+cd14AD5NkAUXj3upmP1umijCxUkjpOaYWn
	 RUpCCbgIPeVGfIdkOG3L1W146WM3gtw3Qq8BcfYbAjxdZHlLZjqE2XPH2ZvI7FK/geoFH
	 mL9uJHvJMBdhVQ1xUDiaFmh4pdZuGMgzR+x757/74Wyb9Aws6K6GWayAANERHJd1JHnCR
	 Luo55aXUGof3BpuhphoTdPHg+1iVHE4rETchjp6Uuf3Nq/QagqOzDZNUQKy2XzXdDPhxd
	 EVIhHT6NK29/RDMORuTZOZ0MkRzAiGoz/mabFQzBTLVlKJJTFGoYBoUMUqvjh+wh47A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679742;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I1RYlt1naFGIHfXy9LAq1wSz3vBwxE84cJqhd3jREb0=;
	b=Ylc+jPwElklB5XTmqrwywLq7COJNohn0UFBsrgUCrHcE48VKTQsDDXDUSEt94URIWbk8
	 XbPpFjq3LqbZLDQrcLSHglh9erV0mHHM3DmLWGF0qeoStTOrCCeKU7Zw4EaGOeO73NH+G
	 e9+5hNWERFIBJbuggXiYhP1MQwmOuk9YldMEDcPqj3oPAUhO2hJrbv+Rt4sS4E34+mJPY
	 6zG8AhDeRFfH321QNbHkNQkqRL5N1uhu5CxllOySRSEAlk6N6bwvhD6cnu8vg4AlWGA0Y
	 +DWu0OtIJ92O36luZCEJ5I5kegqR/Sg54EJ5iqNUQ9ObMdVFYBxlQHoO8wafRD933iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bc6qR2pE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ke4SAyHp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1A606A332
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E1A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bc6qR2pE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ke4SAyHp
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEHpIVb494414
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I1RYlt1naFGIHfXy9LAq1wSz
	3vBwxE84cJqhd3jREb0=; b=bc6qR2pEgPmOAIAdCXgXsDIwShgOfxg65vT9OsB4
	ORueM8/CrGg88htvkWUJ59T9fioflzGMTqLBJNZqyBi1Hz5w/nQLeCDpAxLzN79r
	JS4jyPeDS0wKcqEYpaFxXmsYdng5FQyUWx8MeFuzL7LVi5Ucdn3ovsEu4VlNU+QO
	Vgm10irtbWooCAfhiV8ExXL0Rka/edxK4K/iVcohtZnCRUU8yJn4lxRfWdj0PjCW
	LJLAUdzfNjReBAB6YQCLroYwnu/yLnlBF9WEB3UVGpo8vEl/V3CHEZkntET5WFvt
	QWFgkVppClfEtevcENmGQPT2dU3EIVZWKJIgSrEGxZ+HRw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk21djr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:09:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc36b97a77so381059137.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794679740; x=1795284540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I1RYlt1naFGIHfXy9LAq1wSz3vBwxE84cJqhd3jREb0=;
        b=ke4SAyHpGOg0vDkeFwbRk64cWtlMq/gtQmnduVnz9ZZURWNlXAgtdAh5DIChriSuWq
         D43P6mTnhuRKlMi59LVVLwVrbBsmooY4HxCfuzgbtghnPzd4IM2c2Mui4UW7z+BVKxMi
         QqzkSzspvTD/octelSXDGclpzuNd8Jfov+/UJd+3dEyOjm/hFIr9V6DRn2GCO6AHRPau
         o1u59ztEsSWRZwIbT8PJq9PiPM+HHN0tYUf+aPmuTAsqYt8OgZTtfl9DmuSSsK8usYxv
         S2TZg75JN+0qsgHU39LuSbgS6VFsc28gTIcuhNWIQvwdVLDB+s4lq3z8+MZzU760RIoI
         Ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679740; x=1795284540;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1RYlt1naFGIHfXy9LAq1wSz3vBwxE84cJqhd3jREb0=;
        b=dKQn4b40bTAuDS0PqiwVSF3Z+5HqLpDs43h5TmgkpOpXBwsFtBl9bsViqC7jod3hI/
         7AM9vB1RmCIyJFjPa2Ur9Zx9DHacTME/qvrqNEKRclGMZWF4NWB61GDpDmPIAB6nUGLQ
         +zNp5J6rSIBgnnlMZQ0HzN9O4jh7KHXuySfy5q0BnYoqvpeyRo2y2uhSgiUEh/pcY3Hd
         p4209/ic3k6OPcquEbmw5HmSxgJyRKz7+f5n6oi2C5khMS6dzDcJh9DoRxGep6i/GzEA
         KVkGi+eLToHkn47FfzvCDEF7oq7N4OXMKckM1/8gcp+s2uXA2NEqA2D6JRNSDmMFrFfl
         WODg==
X-Gm-Message-State: APuU4Z+Zr+Euox7zBkXAco1feqCegEFJmcrg9yz42Ey1R+IV6tUlt8l6
	7q2ik/jOmu6jAmcjvEDembHPyiuux76hnTqNXwOOV+jA+9Djyfo462YnNyxkiK1ggS7k7dR1zCh
	LIE5Sq7tSQjDFfDehLPkeDn3yOCwNaLFoIHpK9Gb0QdK4f7JfbtPklmGJEhzsMaQ=
X-Gm-Gg: AYBFou1glYyqWE5kQoH6ES0KGIbWIdUGvNochWBbLhvZohbR9G8DbLsMAYQPXy01E7K
	JhvVgdU6ggpFewNjTWdBwTDeWGNA3BLf1303zgU/infJzvRDpWxH8MnTyA+FXsOhNSRqheX5ODM
	+NlaR/ZlwhvLGg00I8sC08JlOVFayfgj+UeLnVkOwkVErOtqMiRBAglJuoaU9PHxWnYuc15Zd/n
	qNjMmMTTgUWgpPAbuKkEKuiOrcXF29LI0TI5gJeokLx7cKd4zB9c+UJGGCADaLjuOdeExz55gQg
	8Imc0v+R0uerzt/vwP5Xm7ZuKUTDlElJZH4O9kZ6qHnOXzDseHZEXjbb7lLB/b9MIe5tmzT9+cC
	lbogS29741hUUsmFSo8MBZX2QOVG7vacBVBYaY7xnKWVdOMDHWbkuhTIUBq6GJw==
X-Received: by 2002:a05:6102:2922:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d64db3c827mr1818125137.36.1794679739980;
        Sat, 14 Nov 2026 10:08:59 -0800 (PST)
X-Received: by 2002:a05:6102:2922:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d64db3c827mr1818123137.36.1794679739383;
        Sat, 14 Nov 2026 10:08:59 -0800 (PST)
Received: from localhost ([93.66.91.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a68c65sm158428815e9.2.2026.11.14.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:08:58 -0800 (PST)
Date: Sat, 14 Nov 2026 19:08:57 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail()
 helper
Message-ID: <avijuRbv2F1zv2Mv@lore-desk>
References: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
 <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
 <sashiko-outbox-213209@kernel.org>
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
	protocol="application/pgp-signature"; boundary="j+GmRIPqJHt53kQL"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-213209@kernel.org>
X-Proofpoint-ORIG-GUID: LYlXVrfDdErxuK_QVHQfNiEzZ15i58Gb
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af8a3bc cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=8zQ3sPA27H7dy4zktjPBAQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=jQ9fIgjvDAe6dzozTFsA:9 a=wPNLvfGTeEIA:10
 a=H4P9-98vefVEv29osREA:9 a=gYDTvv6II1OnSo0itH1n:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MiBTYWx0ZWRfX53Ilpe4RRms3
 RfStYm8uX7WT3BkRpqKyTIQBqcaJtSwFmkn+wcji5/V/i6wC4KtwdaPyo1LGW3GWI0JfG7KtZ3K
 MbTAtnEBqH/1pq/WL/koNQurWsHuAlMlsohDajnUJFphEYV6X0Rk8VNey8RkRlThNQ+3bq+rlPR
 gtpVWOeL24fOPLQ8BKuv9a1KVYZUhhSxgrRb6czGSv2SoqXpUU2g2tyCA3S/L5pMDjz/wmo8NA2
 WvZ9U7mhRRZqlSeAhjAwbQynEIkOjShkvXlmojEFu86gGFK83CE2gzO2Jnj58WzpA1Lvl15l6rv
 JIxLeNHhQZUAtW/obvs8nbNbnh6qMAfh3K8oSnWV1TuOnltB66CmG/PGhul+RLOnnvHkBIVN6rg
 khaafUZAPxu77FOLF2srErvyLREgW3APTaJKAYw1eE1JzMnwsMyMUtkmaN+0DRQ31qoUzmyOE3g
 o5vdJZbu8hcsKmb+REQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MiBTYWx0ZWRfX6eDVv5INnP3R
 JHLmP9vs6PnF/T6SAtH80ijGPmluhqgmh28mlwncWqPXNTr4WRskFedfUvgiOL7y7oIKgMVJ/Kw
 /4q2oJFOgOzG5gxH3RJvVtFDDlWCzNE=
X-Proofpoint-GUID: LYlXVrfDdErxuK_QVHQfNiEzZ15i58Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140072

--j+GmRIPqJHt53kQL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] net: xdp: bounds check split in bpf_xdp_adjust_tail() allows
>   pointer wrap
> --
>=20
> commit fe8a696967ad3281fe5305e0444a8948ebb0b12e
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: xdp: add xdp_buff_shrink_tail() helper
>=20
> This commit moves the XDP tail-shrinking helpers from net/core/filter.c to
> net/core/xdp.c and exports xdp_buff_shrink_tail() for driver use.
>=20
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9b8d5191c4ba2..5ea45dfce7a22 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct x=
dp_buff *xdp, int offset)
>=20
> [ ... ]
>=20
> >  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
> >  {
> >  	void *data_hard_end =3D xdp_data_hard_end(xdp); /* use xdp->frame_sz =
*/
> >  	void *data_end =3D xdp->data_end + offset;
> > =20
> > -	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
> > -		if (offset < 0)
> > -			return bpf_xdp_frags_shrink_tail(xdp, -offset);
> > +	if (offset < 0)
> > +		return xdp_buff_shrink_tail(xdp, -offset);
> > =20
> > +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> >  		return bpf_xdp_frags_increase_tail(xdp, offset);
> > -	}
> > =20
> >  	/* Notice that xdp_data_hard_end have reserved some tailroom */
> >  	if (unlikely(data_end > data_hard_end))
> >  		return -EINVAL;
> > =20
> > -	if (unlikely(data_end < xdp->data + ETH_HLEN))
> > -		return -EINVAL;
> > -
> >  	/* Clear memory area on grow, can contain uninit kernel memory */
> >  	if (offset > 0)
> >  		memset(xdp->data_end, 0, offset);
>=20
> [ ... ]
>=20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 470bf90d93ef2..7c98dbc2a770c 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const st=
ruct xdp_buff *xdp)
>=20
> [ ... ]
>=20
> > +int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
> > +{
> > +	void *data_end =3D xdp->data_end - offset;
> > +
> > +	if (unlikely(offset < 0))
> > +		return -EINVAL;
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> > +		return xdp_frags_shrink_tail(xdp, offset);
> > +
> > +	if (unlikely(data_end < xdp->data + ETH_HLEN))
> > +		return -EINVAL;
> > +
> > +	xdp->data_end =3D data_end;
> > +
> > +	return 0;
> > +}
>=20
> [Severity: High]
> Can splitting the upper and lower bounds checks between bpf_xdp_adjust_ta=
il()
> and xdp_buff_shrink_tail() allow pointer wraparound on linear buffers?
>=20
> Previously, bpf_xdp_adjust_tail() checked both data_end > data_hard_end a=
nd
> data_end < xdp->data + ETH_HLEN on xdp->data_end + offset, which prevented
> pointer arithmetic overflow or underflow from passing validation.
>=20
> With the checks split:
>=20
> 1. In bpf_xdp_adjust_tail(), offset >=3D 0 now only checks
>    data_end > data_hard_end. On 32-bit architectures, a large positive of=
fset
>    (e.g. 0x40000000) wraps xdp->data_end + offset past 0 to an address be=
low
>    data_hard_end, bypassing the check and passing offset to
>    memset(xdp->data_end, 0, offset) for an out-of-bounds kernel memory wr=
ite.
>    It also allows frames initially shorter than ETH_HLEN (such as L3 pack=
ets
>    on tun devices in generic XDP) to remain shorter than ETH_HLEN when
>    offset >=3D 0.
>=20
> 2. In xdp_buff_shrink_tail(), linear buffers only check
>    data_end < xdp->data + ETH_HLEN on xdp->data_end - offset. When
>    (uintptr_t)xdp->data_end < 0x80000000 (for example on s390x where
>    PAGE_OFFSET is 0, or 32-bit kernels with VMSPLIT_1G / VMSPLIT_2G_OPT),=
 a
>    positive offset larger than xdp->data_end underflows data_end to a high
>    address above xdp->data + ETH_HLEN, setting xdp->data_end past
>    data_hard_end and exposing out-of-bounds memory to BPF packet accesses.
>=20
> Checking offset against the integer buffer bounds (such as
> offset > (int)(xdp->data_end - xdp->data) - ETH_HLEN in
> xdp_buff_shrink_tail(), and keeping the ETH_HLEN and tailroom checks in
> bpf_xdp_adjust_tail() overflow-safe) would avoid both wraparounds.

ack, I will fix it in v11.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20261112-stmmac-rx-m=
b-v10-0-d3d04b65c6bc@oss.qualcomm.com?part=3D2

--j+GmRIPqJHt53kQL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavijuQAKCRA6cBh0uS2t
rJhBAP40bC8yOmvPxGlPlFGhtY97pYlL9+wVzYfWTl2nmroWYAEAlpMAEVeAzKkU
CC+AIU7DjA38RRwTDOTj0P2JWJjtgQI=
=Ckn9
-----END PGP SIGNATURE-----

--j+GmRIPqJHt53kQL--
