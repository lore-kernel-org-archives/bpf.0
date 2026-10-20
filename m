Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502213;
	b=KTqkQZkrCx0OIW+w6iekFgOmgi2sqBr2NsJTfJwlxT0lTk5sLHXHW2a/RguKa4XvPfQV
	 neUQ89PMsS4LNyE+Y7iWy2RrlTuwyfKyfent4QOXhx0BvHrbdRylHhKEaDUgENWg+FEX0
	 IkRmHg4KP055J06FDvVW2JVLcAeWQ3L+Dhaj57sT5XkUYdE5+2GHRcCbtZ1ZlMW72iO0j
	 gn2dYH1b32iQ+lzG14doVKnnODmOgvQ9nEVOpwEjW4E3ZXUojmOWcR6tYpzLZrQjSCmak
	 7SbfWCz08yvwQ6OmL0t+m070IDr9Epsd7TcwuA56kBFIpBgQ3RCZ1PN3/3wI95EGp6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
	b=WS31laJWGpb+ufNdZYYy8AvOXrSZVu87uUNPLyiayc2fXwbBB57UN7jZXeOgZ0RAENP9
	 DhYywvzDMobzg2xP5Z+CaJWjwXjRtn5SL2d5bYzXH8qWdGxrhe8ypGp7M4D1oM8uH+xpx
	 3l/RBLds59VdyA0REOExwXaT7fid4U2kZv/nFEFzB25Kpn4QDx3CNXeK5NqNPDfAqh3oC
	 Dq2AOwiAtbMc29L6gzyurZE4NY6vIqN4iP2dAQTIpqqUeqpCQ8wKuV3YApaNGCOV53x2e
	 FHpWHBg+JF+ojumHb2DLnWSmOUEXpbCyEvy0/p0G4XZ/bbImDNpcGs7+eDeJTXHXeGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYSeA1t5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eiTUZHuW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F8606A31F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648F8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYSeA1t5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eiTUZHuW
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA27p1731547
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3lr7ieTrcyple3oJEv/wP9Vl
	YTXentXfrpGTCLa6BCU=; b=cYSeA1t5hXejILz6jvWAz+7FyfJtYYRBR+9pKqd7
	G94J9hsTDSi9XtBM3cfZJLdKjrrc5ApXdQiJ/hL+ybiWCCbBfiZEIL+2ykACF0sW
	DfLDVwXXil/VNSivso4ewm5B5j4GX6UbzbtM8CqLdOWhM4vCwNie9PiE+cXJJ98U
	aZ0uM0TlLgRvStKSM5Wi05JhArygcQrvQutaalffY+DsznG2L89bjgFQIqSsignT
	smYg9yXdwnNB5oxZjhn0/Y5jUDxdXNY5sfhucJMAVpD4AsDs6fsKf/6ZULJCgEmG
	9xu54cWTppmN3FHQYtCchxUurEZlKCfkogLvCy1saO67EQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2m1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:16:52 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c124d17880so678844137.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502212; x=1793107012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
        b=eiTUZHuWd6Qu97lTJGlWVVPQ8JqMymq063vLNsI+ULPh94VRu5Nn85bKlOyy9nUCuu
         RY1K4PFv7AfnnqCpuwJf/2MpeyUNQp2FhvVJTRdNziEqw+/4WB1TN9Wbm3XpscOU++Gn
         Q4jRmjHm2rVUXSvQq/UIPKx0/FdBR3fkkBdnrhOKhVAra4gPVBh0yhLZaCirimuhkf7y
         F0aWszN/WebvPr84TomsLaF3ZVI72kkmGOHnkZiSLK10vT4yQSEBqrv4DZXbBkwSltj6
         ZZ26RA6atHHfohSXAH9HDjedM6gSJvzgCw+h0oOYhtlJkG6sraNKbrN6yGkMn97Waxag
         B4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502212; x=1793107012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
        b=Ba8WWmk8cmpCwpVdKwRqBfLkQP1UlCWRieG8hAckAkSj6Z6hhg5GSrt5FvS4DpKllz
         lTwwdf8b6b9GzYlU/pyQA0mawaiPFMNaDbAQUo9ls7eNPEtyrA9xqjlZU63AHBZEikPx
         FGnp9Tz3QBbjcdy05bpTbNR3+dqHfKq12IdtKZxYYxNjbhLKym+4tO70/nR3/r7GBt20
         1Q6q2DzKxBsF6coCQIAoNHRXwul2URqcf+Z4Y3TE1VWJgHhgb+PIJ7x/Z6G6z7yx2nih
         bgwXfh15VHQX46eJ/Cyw/G5RdS4IS+IWcwikfKoVFoCGheIYPSzgwWNhr6XxDKyBUksa
         Z/VQ==
X-Forwarded-Encrypted: i=1; AKwUvByo+gCSmoIC0cH1SsOYHJpKpt4/xSeM+ptEPB19Aw6r+udpprHxf4jhLUS5RRin9PyGrc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL89Em8hUS71oGYml8SOj7M0uXoRLiKXRnRvmBbkT/TEw/jTtY1
	/i4p1R387sgqtP4Xlvj+eAW8BwPCq7D75h0p8zYXBWTcuTNJivEpL8PTJRFCeWyahpeJKCzLflU
	pVcYHq5LmbqppafzxMI3nRXJ22pREL1PtDHx/VAfvIuE7j3xUsQ+MZ+0=
X-Gm-Gg: AYBFou08gtILvBuLQ2+5sJhBtCNAShkstoHLcmsG5vTR41TmqRv5RtqbNFPAwWs6gvw
	gu/3Q6j/UaRwfXEMISRqju2oA63vIyqsVcOqz0mPKZIYw5MWMpKpUY1v8NU1dPvCnHtOlcorUsC
	NPgjznZ4lHocOTrKDe5Rl5KQpj/cBwvbk3l25MI9w4qEdIPpC53ZABpIiH/uZm/UOg1/+ZDRNWh
	RRJX9SaIJdJrmrgT8ysZjLJD2gpEce1eCR1QfoUm94+ltJEiE3RdEVU2lHBUf97R6rG0vxP/dYS
	1pOMhEkJQaOuOtt8vmeHYCtR2ah+A/MCM7cREdq8l95szRnXfXlGwkvPQIRA9TOtUOxuCJGsjup
	bSQo4gT1BYYuBog==
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr2260012137.31.1792502211266;
        Tue, 20 Oct 2026 06:16:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr2259987137.31.1792502209897;
        Tue, 20 Oct 2026 06:16:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm6391505f8f.33.2026.10.20.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:16:48 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:16:48 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/5] net: stmmac: take ownership of saved RX
 state at poll entry
Message-ID: <atdpwITVxsWcDIWG@lore-desk>
References: <20261018-stmmac-rx-mb-v8-1-5f58c0b25849@oss.qualcomm.com>
 <179243151310.3135.16032115262445521338@kernel.org>
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
	protocol="application/pgp-signature"; boundary="NxY+HFPlk8WKRDAH"
Content-Disposition: inline
In-Reply-To: <179243151310.3135.16032115262445521338@kernel.org>
X-Proofpoint-GUID: W4rZn3EKM10O1H0zD8hRjQz3NzITlb9Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX8Ydkw8Fyg4QK
 mGob8fuTh+0z/EjwucEDTgeSVogqEbf+NM73c099s21KNBo7+uotH7Kbq2b46wNxIyx2h5S4A5x
 gGBrDC/GyR0forYbthnbKSg+wIxpVgY=
X-Proofpoint-ORIG-GUID: W4rZn3EKM10O1H0zD8hRjQz3NzITlb9Z
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad769c4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PemzsjJJBjkDWbXggMwA:9 a=wPNLvfGTeEIA:10
 a=uEPnGdNO0VHfa3VMbwkA:9 a=ODZdjJIeia2B_SHc_B0f:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX0uDwX3DTpX0z
 Cnxi+aHZRREtl/uxDQEbu1xiMYWmO7Dm8xUgUK+Y+1pvBja/x3YFlqtXTxqPBtrYJnd/Z8+fCF3
 p9JD8bUvRvFn+M9WZj9LBsXUDc2Keqyip50vOtD4IjBfYGQK+XKIPb0eIHEfysMLyn4pdJ93gPP
 wP5AHxuxfujV/D/hzzwqWlxlcYt13Ur1GgTz2tdIR+YgXhIqCi2QD5Js32RNgJ5aC9AMPmcVN2u
 07GY16S30BP0a0Ch3c3dGN1oZ9IX4H6bP6uDCxzdvepxGxmFQSDow/0uPIX5ouxs5QS3w6zYfE7
 rl0CG5ILKv+jDIGtsLrHWu++hISRfyHwhUS9FDbSv4MyguBLF5FovlmyKdxv1sj3cVPTSmw0WJa
 h+o21uMf6QUtSq20sks67uUfHRDDEzQdKyuuj6HQN6XK52xk+az6Ia+WNwoFp9pGocv6DRN5bRp
 GszqWFENpZjkq3mOO3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200052

--NxY+HFPlk8WKRDAH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The authorship and Signed-off-by chain disagree.
>=20
> Pre-existing issues:
> - [High] At this commit, stmmac_rx() still uses `skb =3D=3D NULL` to deci=
de
>   that a descriptor starts a new frame.
> - [High] This problem wasn't introduced by this patch, but the commit
>   message relies on it being absent.
>=20
> --
>=20
> net: stmmac: take ownership of saved RX state at poll entry
>=20
> This commit makes stmmac_rx() and stmmac_rx_zc() take the saved
> partial-frame state at poll entry. A new in_progress flag tracks whether
> a frame is still incomplete, and the state is saved again only in that
> case. It also frees the saved skb in stmmac_reset_rx_queue() and in
> __free_dma_rx_desc_resources().
>=20
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> [Severity: Low]
> This isn't a bug, but the author field and the Signed-off-by chain don't
> match. The commit author is Lorenzo Bianconi. The first Signed-off-by is
> James Hilliard, and there is no Co-developed-by tag.

I will fix in the next revision.

>=20
> If James wrote the patch, should it carry a "From: James Hilliard
> <james.hilliard1@gmail.com>" line so git credits him as the author? If
> Lorenzo is the author, does James's sign-off need a matching
> Co-developed-by tag?
>=20
> The other patches in the series carry only Lorenzo's sign-off. That
> suggests this patch was written by James and picked into the series.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 53782ab55e125..8fd2acb25fb60 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -5958,9 +5970,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  						      STMMAC_XDP_REDIRECT)) {
> >  					xdp_status |=3D xdp_res;
> >  					buf->page =3D NULL;
> > -					skb =3D NULL;
> > -					count++;
> > -					continue;
> > +					goto next;
> >  				}
> >  			}
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, and this patch doesn't change how it
> behaves. What happens here when the XDP verdict is taken on a descriptor
> that still has rx_not_ls set?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

>=20
> stmmac_rx() uses skb =3D=3D NULL to mean a new frame is starting. The goto
> next now also clears in_progress, and error stays 0. The remaining
> descriptors of the same hardware frame would then each be handled as the
> first descriptor of a new frame.
>=20
> The XDP_CONSUMED branch just above has the same shape:
>=20
> 	skb =3D NULL;
>=20
> 	if (unlikely((status & rx_not_ls)))
> 		goto read_again;
>=20
> So does the napi_build_skb() failure path:
>=20
> 	if (!skb) {
> 		page_pool_recycle_direct(rx_q->page_pool,
> 					 buf->page);
> 		buf->page =3D NULL;
> 		rx_dropped++;
> 		count++;
> 		goto drain_data;
> 	}
>=20
> In each of these three cases, could the middle and tail descriptors be
> passed to XDP and built into an skb with a stale or zero len? Could
> buf1_len then underflow and produce an skb length near 4G?
>=20
> An on-link peer can reach this by sending a frame that spans several
> descriptors while an XDP program returns a non-PASS verdict. A
> napi_build_skb() failure on such a frame reaches it too.
>=20
> Later patches in this series seem to fix it. "net: stmmac: drop
> multi-buffer frames in XDP mode" sets error on non-last descriptors when
> XDP is attached. "net: stmmac: rework stmmac_rx to support XDP rx
> multi-buff" runs XDP and stmmac_build_skb() only on the last descriptor
> and sends build failures to error_free_frag.
>=20
> [ ... ]
>=20
> > @@ -8399,6 +8408,9 @@ static void stmmac_reset_rx_queue(struct stmmac_p=
riv *priv, u32 queue)
> >  {
> >  	struct stmmac_rx_queue *rx_q =3D &priv->dma_conf.rx_queue[queue];
> > =20
> > +	dev_kfree_skb_any(rx_q->state.skb);
> > +	rx_q->state.skb =3D NULL;
> > +	rx_q->state_saved =3D false;
> >  	rx_q->cur_rx =3D 0;
> >  	rx_q->dirty_rx =3D 0;
> >  }
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but the commit message says
> that, without this change, the first poll "resumes that stale skb with
> descriptors from the freshly initialized ring". Is the ring actually
> re-initialized on the stmmac_resume() path?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_resume() does:
>=20
> 	stmmac_reset_queues_param(priv);
>=20
> 	stmmac_free_tx_skbufs(priv);
> 	stmmac_clear_descriptors(priv, &priv->dma_conf);
>=20
> 	ret =3D stmmac_hw_setup(ndev);
>=20
> None of these calls refills buf_pool or rewrites the descriptor buffer
> addresses. stmmac_clear_rx_descriptors() calls stmmac_init_rx_desc() on
> every entry. On dwmac4 that only sets the owner bits:
>=20
> static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
> 				   u8 descriptor_mode, int end, int bfsize)
> {
> 	dwmac4_set_rx_owner(p, disable_rx_ic);
> }
>=20
> Suppose stmmac_rx_refill() hit a page_pool allocation failure before
> suspend:
>=20
> 		if (!buf->page) {
> 			buf->page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> 			if (!buf->page)
> 				break;
> 		}
>=20
> Then the entries between dirty_rx and cur_rx still have buf->page =3D=3D
> NULL. On resume, cur_rx and dirty_rx are reset to 0 and every descriptor
> goes back to the DMA. When one of those entries completes, can
> stmmac_rx() call page_address(buf->page) and napi_build_skb() on a NULL
> page?
>=20
> There is a similar problem on dwmac4/xgmac. Descriptors that the hardware
> writes back between napi_disable() in stmmac_suspend() and
> stmmac_stop_all_dma() have RDES0/RDES1 overwritten with status words.
> If those descriptors are given back to the DMA, would it write to a
> bogus buffer address?
>=20
> The resume sequence is the same at the end of the series.
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--NxY+HFPlk8WKRDAH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdpwAAKCRA6cBh0uS2t
rK/rAP9eeUWDw5jEkLXbZGZjD44MWM5eQ7vU1AdbT4Lc6/gFZAD9HjzeJTtHr8HQ
TZlUcSBRhfUzqQDfqiP15dZDUnPK4gw=
=ieLd
-----END PGP SIGNATURE-----

--NxY+HFPlk8WKRDAH--
