Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C144F55A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980681; cv=none; b=BR/y/rf1qlcXGt4uaoqnFLRZV9dyTIOiNiNm6cQp/2rDEwQqo0gkC4ZR445vZ6y0EZkJhpjCNd+E9WgNp09d2TdIU7+WKkYixoxew+b4tcjdOJHPrAlaVMxCxPgMZ5F05P/FlnEZIhPVnWQh4qD2Bbi/hVjQRnc+nhT1RtDBjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980681; c=relaxed/simple;
	bh=UA2qswNCC4KFXd1yXSFusV/yF72GpwJUCYGfx3jAk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/lkXzyqIM/RUiky/+phXRPGbG75xCRIo1VtAq4mATB0CRThtgUn6OSb6H28ELhyQ9u8Dbz4ZfN/OzXXTXkmJg22LjuBWYuk8OyKzTVvtWarkdbRRCfQOMtmFhfZ4NBOjarZxgtJZ7b7dYmR2Of2BHG04i8bq5T2McxJzVoaDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=astL5GQI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAnO8UOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="astL5GQI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAnO8UOJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79vJu467205
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p1CfrvGoTRUhg6G3d7D0A29V
	ToswFi0wovgwJblAtlM=; b=astL5GQI0xLgRlekDlFX7/5PPji5US6ECDqaFxmo
	2Fz15a404kZEPDO6XlMnK59QXElIJVlpxdBgi5/vIpcr0Pyb7F62mdTyfgtD+3FU
	vJ47ht1O32qTfxVOooQ2N4aoss7Nwm4BT8jg+PT8tP1Afxv73I3zydOGPopd5+5R
	Kyll8+e7CSs3gL/RHg5VGV40+CFhwnOp2/uif7VqtQKnphFxSWE+7Vq967Z1339J
	2zOjPEabhSstVNf0NE39oAuWpKJ2dhlSB7XfVut3LEeGhPoU6P9iILvvsW58Xa0d
	FO8TCXpYmaVkoUzncw8wi3NiilH4L/+tx6fP1C44nIFIHw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9rqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:51:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93903622880so774960285a.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980673; x=1790585473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p1CfrvGoTRUhg6G3d7D0A29VToswFi0wovgwJblAtlM=;
        b=FAnO8UOJKCt0g4redLNaj7rcz9fz6Iabz2DDuZadY1U3f8gCy4SRHSK4FZaqq9cRoj
         Hdo1Ixc6U4cybgHT6xU2ZOU8LPLqhxCWAF2zmNkEb8zhey5SuCBKmM8wOx8MX4UZc/5G
         kvvzAugOlp4jusVh8jG9AmnB33qUEXwzvfGg+GMFmCAKrbtd8U5Z+oL0eCiViLw/q2ch
         NCx6fz1t2WP0PTInVQLFdoDD4A1iKl8ZgeFdBXX6uR3zBPYpTx+E4J65W9mrg4d6XsqC
         bEu1lGCjPDwGDTRmfLxjMkue9rCrYWsQ94SKDIrMFoOfMsSIH+JunEx6Dja3gc+g7pjU
         nP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980673; x=1790585473;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1CfrvGoTRUhg6G3d7D0A29VToswFi0wovgwJblAtlM=;
        b=NevCbyyA3OmBCOL9bikncbQgYOETOtAOdFO7BzLXfZYHE9jQPQQHKy9qzFZhbxsjXo
         oFCjwmKqm+WydqA1ny/Mbh5TPtAMP4IgTOCTD7YlD2113lnsZNrz8Gd7zJYxEo7RLZYo
         uv6uhIHB3bEsO8/AFZr9nZD21pBdZtAdQDmdMHhR1v/eZx82JAKFgI3Twd3k4vbhJotf
         G9MmcU+7DkB1URdkLI+Hzi4LaeGh4ynBNszbNu3VBOtNi1AAunY0p1VlRWp3bMrnxnfZ
         4b1MIteVlxgViRQUFQiayBo4VorKUgzHccTURIVlEZxvlnB3vfXCmmo+0ONtMG7Brm3a
         7mmA==
X-Gm-Message-State: AFuF++n52/iXIBPiqzfzQpMeGcHqnWOdmeOjnCXJWxXQI0PXuYRM7huZ
	WkNb2wjbIBy9pYdhhIFiWQnVuy/2BYIdpmdAxA9r1uxsw6EeITc3aK+CcQfV+kWfVjhEOZNHvqu
	HVLwXt+19YqBU5XIIYzQ6rOe9WadufGip40sRAxKJEt9iSgpaL7bP0dEpNMXWyaE=
X-Gm-Gg: AYBFou38EjRHIX+ufQ7SSiWBK3J1aOH0DxDxrMWnvgO1LHoDmOC7xZcLzSA7swcJUcy
	PY8sgyrN4/HqLPnA6jwwJp3w5QiQHatz8nMDKDf9v9LcKm+pZCI1mS9R0nuavxRmeRv8qagi6jW
	V25YUpVdCobDP7ZdKx9BD6pW5RqLzgDWlMEOyHSbXrdtnNqcTc9+jhaOkvktYrk7E1Hzh4SMPUc
	WWdNNr3Wpzfgue1dLb+0pvL0uC4fGI9H/SvEopFivQvPZg+rf6mzNgFcHZka6xmLhMRXEAIRW9P
	6FeBBG3WsRBUtMBiR1mo0yKIpLYZopKTRsK60hrXSyEKVytHT5KpU91KpJXXPAYPmqZnTcJG5+y
	e8LyH67IqOhq4zg==
X-Received: by 2002:a05:620a:618e:b0:93a:3ab6:caa8 with SMTP id af79cd13be357-93bf551bacemr865378285a.4.1789980672666;
        Mon, 21 Sep 2026 01:51:12 -0700 (PDT)
X-Received: by 2002:a05:620a:618e:b0:93a:3ab6:caa8 with SMTP id af79cd13be357-93bf551bacemr865376085a.4.1789980672042;
        Mon, 21 Sep 2026 01:51:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm208921365e9.13.2026.09.21.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:51:10 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:51:10 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: rework stmmac_rx to support XDP rx
 multi-buff
Message-ID: <arDv_snSh64pcSP3@lore-desk>
References: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
 <20260919150838.4B09A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xfOxl7a6m36ljBvI"
Content-Disposition: inline
In-Reply-To: <20260919150838.4B09A1F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNiBTYWx0ZWRfX7oK8NDxBGDx/
 K8Y15aWI6kSkqyqm8BoiyCcRYezBKlNKv6AdWCYqCSU2K9b/vtxk6RSL2yRXjkiiMtcRpWeaRba
 o8v4hNajdTSl/muTheVnthfvg/2A3JgbUVQhxPUZyLTcMWNd7NVfdltkh8F7JstVxnq0jtioIpL
 ubR0C6jbCPTt7wskHpo2z59lkI+a1FlmYGiWg9CaHgHuXawSEQQPk4dHOyeJZkizFYLRfwf0Tzr
 SntapDSMZsbyv+jNsSe3obEc1IOhNZNzt1f0w61ed/uGVBAGkJsHhD53BpVFsTF7gfcTHQTVnTO
 TRC/KaCVIA1XxbCoeJ4yZJcvflRCIzBE9X4YWDV7y4twlhy8n+KGUt7rlfZDoX5B50P3wyLXEp3
 N3mytBrg1Z+s5kgeX/mqGqMeOVR4waVDb/dogabNQ7XQJhfZDRrqaV81QSIX69O0t/CC4smfYY9
 vgGtnEZ9gjod/8mFVEg==
X-Proofpoint-GUID: TBruX_OUgt1K5XPXGAQsA1q8hUpDcQ6F
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0f006 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=9glrN42jP_Nv8INrPvgA:9 a=wPNLvfGTeEIA:10
 a=XTngdorz1_1m2fKTPJMA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: TBruX_OUgt1K5XPXGAQsA1q8hUpDcQ6F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNiBTYWx0ZWRfX12XEcGE6KAiU
 WInOVX1Xoqn6S4AoLJaNkEboDmPViAqvLQdvk3QFm1WdojxTIrkz18TMyZ1oV2zUiCwAvOxOVzJ
 HGH+CZCbKNs7PIsh+7S9Ws5vQygLsTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210126

--xfOxl7a6m36ljBvI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] stmmac: loop state leak on skb build failure causes panic and me=
mory corruption
> - [High] stmmac: uninitialized xdp_frags_truesize corrupts socket memory =
accounting
> - [High] stmmac: silently truncated frames bypass checksum errors and cau=
se data corruption
> - [Medium] stmmac: unconditional rx state clear when NAPI budget is zero =
leaks memory

I will address sashiko's comments in v2.

Regards,
Lorenzo

> --
>=20
> commit 342011b18b585ad2ea2189dab3bfe7efcf08625c
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>    =20
> Build the xdp_buff by accumulating all the descriptors that make up a
> frame, so the XDP program runs on the full (possibly fragmented) packet
> instead of just the first buffer. When the frame is not consumed by the
> program, assemble the skb from the head buffer and the collected
> fragments via napi_build_skb()/xdp_update_skb_frags_info().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index bf9e7e4cb1c31..1de8d9626c640 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5735,6 +5737,82 @@ static int stmmac_rx_zc(struct stmmac_priv *priv=
, int limit, u32 queue)
> >  	return failure ? limit : (int)count;
> >  }
> > =20
> [ ... ]
> > +static void stmmac_build_xdp_frags(struct stmmac_priv *priv,
> > +				   struct stmmac_rx_queue *rx_q,
> > +				   unsigned int len, struct page *page,
> > +				   unsigned int offset,
> > +				   enum dma_data_direction dma_dir,
> > +				   struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	dma_addr_t dma_addr =3D page_pool_get_dma_addr(page) + offset;
> > +
> > +	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
> > +
> > +	if (!xdp_buff_has_frags(xdp)) {
> > +		xdp_buff_set_frags_flag(xdp);
> > +		sinfo->xdp_frags_size =3D 0;
> > +		sinfo->nr_frags =3D 0;
> > +	}
>=20
> [Severity: High]
> Does this code fail to initialize sinfo->xdp_frags_truesize, leaving it w=
ith
> uninitialized memory?
>=20
> If the XDP program redirects the packet, generic XDP handlers like
> xdp_build_skb_from_buff() use tsize =3D sinfo->xdp_frags_truesize ? : ...
>=20
> Could this random non-zero garbage be added to skb->truesize, causing mas=
sive
> socket memory accounting (sk_rmem_alloc) corruption and subsequent drops?
>=20
> > +
> > +	if (sinfo->nr_frags < MAX_SKB_FRAGS) {
> > +		skb_frag_t *frag =3D &sinfo->frags[sinfo->nr_frags++];
> > +
> > +		skb_frag_fill_page_desc(frag, page, offset, len);
> > +		sinfo->xdp_frags_size +=3D len;
> > +
> > +		if (page_is_pfmemalloc(page))
> > +			xdp_buff_set_frag_pfmemalloc(xdp);
> > +	} else {
> > +		page_pool_put_full_page(rx_q->page_pool, page, true);
> > +	}
>=20
> [Severity: High]
> If a packet exceeds MAX_SKB_FRAGS, does returning the excess pages to the=
 pool
> here silently truncate the payload without marking the frame as errored?
>=20
> Because the hardware perfectly validated the original full frame's checks=
um,
> could the truncated frame be passed up to the network stack where stmmac_=
rx()
> will set skb->ip_summed =3D CHECKSUM_UNNECESSARY?=20
>=20
> While the IPv4/v6 stack might drop it due to length mismatch, could bridg=
ed
> Layer-2 traffic or XDP redirection forward the truncated payload with a v=
alid
> checksum, leading to silent data corruption at the destination?
>=20
> > +}
> > +
> >  /**
> >   * stmmac_rx - manage the receive process
> >   * @priv: driver private structure
> [ ... ]
> > @@ -5831,6 +5911,10 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> >  		if (unlikely(error && (status & rx_not_ls)))
> >  			goto read_again;
> >  		if (unlikely(error)) {
> > +			if (!first_desc) {
> > +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> > +				first_desc =3D true;
> > +			}
> >  			dev_kfree_skb(skb);
>=20
> [Severity: High]
> Is it possible for dev_kfree_skb(skb) to cause a kernel panic here by
> dereferencing an error pointer?
>=20
> If stmmac_build_skb() fails later in this loop, it jumps to read_again and
> skb will contain an ERR_PTR(-ENOMEM). If the next frame has an RX error,
> this path will be taken with that error pointer.
>=20
> >  			skb =3D NULL;
> >  			count++;
> [ ... ]
> > @@ -5914,51 +6014,13 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
> >  			}
> >  		}
> > =20
> > -		if (!skb) {
> > -			unsigned int head_pad_len;
> > -
> [ ... ]
> > -drain_data:
> > -		if (likely(status & rx_not_ls))
> > +		skb =3D stmmac_build_skb(&ctx.xdp);
> > +		if (IS_ERR(skb)) {
> > +			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> > +			rx_dropped++;
> > +			count++;
> >  			goto read_again;
>=20
> [Severity: High]
> Does this jump skip the loop header where skb =3D NULL and len =3D 0 rese=
t the
> state?
>=20
> As noted above, this leaves skb as an ERR_PTR for the next iteration.
> Additionally, since len is not reset, could stmmac_rx_buf2_len() later
> underflow, producing a massive unsigned length for DMA syncs and leading =
to
> memory corruption?
>=20
> > -		if (!skb)
> > -			continue;
> > +		}
> > =20
> >  		/* Got entire packet into SKB. Finish it. */
> > =20
> [ ... ]
> > @@ -5991,9 +6053,9 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  		count++;
> >  	}
> > =20
> > -	if (status & rx_not_ls || skb) {
> > -		rx_q->state_saved =3D true;
> > -		rx_q->state.skb =3D skb;
> > +	rx_q->state_saved =3D !first_desc;
> > +	if (!first_desc) {
> > +		rx_q->state.xdp =3D ctx.xdp;
> >  		rx_q->state.error =3D error;
> >  		rx_q->state.len =3D len;
> >  	}
>=20
> [Severity: Medium]
> Will this unconditionally drop previously saved state if limit =3D=3D 0?
>=20
> If stmmac_rx() is invoked with limit =3D=3D 0 (e.g., via netpoll), the lo=
op
> while (count < limit) is bypassed entirely, and first_desc remains true.
>=20
> Does setting rx_q->state_saved =3D !first_desc unconditionally overwrite =
the
> saved state to false, discarding any partially accumulated xdp_buff from a
> previous poll without freeing the associated fragments and causing a memo=
ry
> leak?
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260918-stmmac-rx-m=
b-v1-1-0b4517d404af@oss.qualcomm.com?part=3D1

--xfOxl7a6m36ljBvI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarDv/gAKCRA6cBh0uS2t
rEIrAP9holad0HbELME3+Z22O1qB4P8slvEGzOsMl+S5JSbUcAD/co60WJW4Ynxi
M0OB0N3AMwYNyQ9n/YO+mFkIG6fVDAE=
=V8kP
-----END PGP SIGNATURE-----

--xfOxl7a6m36ljBvI--
