Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6B34CFC6
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522962; cv=none; b=io4GtuRyWj/9wYJrDMV897+6DnBREQX9KVtv6dnFvXYgS5Zbr3YmEJnERvgIQRKuAewMnXCVMO65Jsb6VEb1kqFtgkf7E8EMF76RRtkTkL1hvcYSqFZ+DMEPA/6ZDtHwdfhtnq3jEhKDFYD0vy3HyGn8C26lkds5gUer/ZQlKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522962; c=relaxed/simple;
	bh=BAb0lMVqWuA8b3uFkBuo/fwOR/biU28Do/JLUd93Ra4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLRb/O+LsevkAMd6T6Le/j3XKkdNMZAQ6a/ptD6VSZCkF5dI1Nn5+hVa35r/DXwoPVFbxlOpXgtB3ba2XrdS91jwoeYV74xMv1cQj09AaWHciVVwzqR/GvppytpERYrdU4vKo92jHnlq41thbkF286prwu+1gRGAxTgtaeohWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENfuwpWj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Udyx61e2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENfuwpWj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Udyx61e2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R6Mp7N1692424
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7LtZk3OkhRu2F3AoOJ9YOqw/
	V56yStEoDJ5e6aErl5A=; b=ENfuwpWjnNoTu7y+p30NaVFQAJTVKNCCiItmzPPk
	59PUiDA0EJAgjxiXuOa8GH9KZQIYuwig0zvrK+0gNWenuMV32ZiL0IhXEhzRiYVi
	4sIBorczuruPKW12C77RHrdZ1Drhq9/r7lxotULS+La4Lpx0BsVdzGIVgPgMdxq5
	FlV/uXkGMZDE9GIrVFxfGJ6P4iT0qBEGhLp7ef11jtMtwYHrF6ZGL4ncPo0MfhHZ
	/v6ewQXRD8BroogHKKujH7cd0xcbCixdS71iCfLOQ6jyf9gkIj7UnywkbXhsLjwE
	UkD0MzAaGww+URnaOyipGXebLz2xDlxF8fyy9wkbu3UdzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cgk9v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:29:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93c444b438aso488354385a.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790522959; x=1791127759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LtZk3OkhRu2F3AoOJ9YOqw/V56yStEoDJ5e6aErl5A=;
        b=Udyx61e2OfkPkxDIOzZ4eTgjMafHyzo5/FTlUxmGLELwlsnbE2ExXJPBEkWphb3E+a
         LrqKB1w/MebWdT1ZRcdV1FvqDWiiVG6g5F0k/yoQ091+BJLahAWfXxUFqIIvDbm9kFYq
         +os33wDvl+iVsX5tutPJDva8DPk0c5CrjTfBOJ2qubxImf4sWSp8apcvm+fkDTfBCngP
         /3i01trpWf03B2BPEBxcHqPkjBAtLzPr1nHW0zElguk+Q1VV4LwEmnRPROMVzfPxOU40
         DMKtEsPFrW/nK0LPkMW52ooXU4GWIV64ovyi/BaGRQEMn/+uW/aYhcvXmeugBUm+EIKX
         ZNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790522959; x=1791127759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LtZk3OkhRu2F3AoOJ9YOqw/V56yStEoDJ5e6aErl5A=;
        b=raN2wu+YYxMun66AAivwhrX9xRsTduEGYO5aMYOZfEQT8v3brzN11T+EwylrZklKrI
         pEsBi0IizDdyfD3hXgcOoLowkyO7UXT3TXyAjrirP31058hxVdlU3b0FcLJ1fo6mIuVj
         KI/Utt/01J2uhmEGctxEPLeP41XKn6xuy3/DGs7YNrvRXbWIXe//QEBQ5cMWeV41Ozma
         5wnWpuFGCLKAtot5t6wclTbKVRYiwXUBPr+ifHXZp/SDGoP7w8gIjCNxyfyiNfWkI6at
         24FtIEJJMRVzZ5gJD9Av9cRVzKSQua6m2ZfMcZFpL9OnFO3YP5Sh4FlQT+B4UnrFtgYM
         PH5g==
X-Forwarded-Encrypted: i=1; AKwUvBxoLqlPwyx3wDHTXqTA1ibBM7oqRxBkAbt6U4E4p1UsX5edZ+SCPoNuPvvrCIaSZWJG3ZE=@vger.kernel.org
X-Gm-Message-State: AFuF++ks2b7W2roimnmoAwoeYQWFQ4xx2s+Fj/giIotTeD5amMTJkJ1t
	PYNLYaDX5pKedoHG8MlyJspmtp5NsfGuh54ox6AprjXiGUK/Li3aUoCnfZ/7ze1NGhlI4rBEx6h
	xD7BUNZmLuwyWipcgOwcoia6bwC4pd2ozlLh8duZ6N4BAnml+nren328=
X-Gm-Gg: AYBFou0D95XLwMHzqP5beZSRT/GIWLtWRd5ePumuD1n0txVIUi8cYdBgYc9io6KljfS
	sHAvf9mwPU4k9LV8OKvoiYkMtilGOrPX6mhuxbjy6r5vnd1brPLkKkd4MF+hxeBVSOYrxj+7q6g
	mihllL4rAGOncthpuGZI9D+QrWlFsO7qBOIscHLFCYwRXis0P+qodOiw7EHbSf8HBSsfBXOYnIq
	26KXtZW8uVuxqyG2AmcgYCRgmcbppXQWk7g9jsR/VwY+4OorxC5qDx+swpQGv+eEAni/XR+Zcd+
	XXzbrPnmoAhJF1instbualkT9ltdWrHjaEILMsiaHAK55i/sK5+UwEHpC8/k6oql454gmp8QsAE
	RuCdlJZDRZQhsiejpIZJXoLrKwPMZxbbCfG/C7E7dpXjfJVS1m4zZ
X-Received: by 2002:a05:620a:4686:b0:93b:d7a2:83d1 with SMTP id af79cd13be357-93c43d239c5mr1591084285a.64.1790522958256;
        Sun, 27 Sep 2026 08:29:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4686:b0:93b:d7a2:83d1 with SMTP id af79cd13be357-93c43d239c5mr1591078685a.64.1790522957525;
        Sun, 27 Sep 2026 08:29:17 -0700 (PDT)
Received: from localhost (mob-176-242-50-189.net.vodafone.it. [176.242.50.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm173876195e9.1.2026.09.27.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:29:16 -0700 (PDT)
Date: Sun, 27 Sep 2026 17:29:13 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        Jose.Abreu@synopsys.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
Message-ID: <ark2SZ3qy76V1Djg@lore-qca>
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
 <179050137856.2160803.6310706653062051206@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4EucM2glK7mDlA+/"
Content-Disposition: inline
In-Reply-To: <179050137856.2160803.6310706653062051206@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX8z5nCzkpApqS
 W1lCzppfPaI2vIlrL9RKknucWy7ppqt1WnyA62jvpfj7lylGs3R5GUpeiEPSTx3ndLbPKaM85lw
 iFeHi/dkoHRcBIFO+oryxBHTwzqAoWVFWeQLy+W0fmwULnC9Zisa3em941U7K7MO9yn3FZZXdNd
 TBw05IF1aqjEwWudQGh5qd3agVhJdoL4coQhfvIO4mxEL3q2MK4fcY8iKl1Pfk5TsRLj/8sxbt4
 NrjSrz5BCGQTZQGSWd7dDaIWuCrm7iApVULSOLlNWp5yuCEQxKDFxeXT0XJDRw5tTHVioREWt3y
 T6gDNQzMcATmWNdbDh+YVlMmA1/Q7xRcRUxh7cJJePrlcBUb7QJ85S5wN/YMgWkwU+tSqYjnOaJ
 JC7/UU//gaWyWhFBXsi/k8HAHIhYiAa6JTDxrwx1BGwukqumxdZrqqKcgLFFprYDjgT92lk5k1d
 5CszwJ2/DXWeH3hY+wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXxeRo27fXDNBz
 4FDi2tnqGDWduYw2jwWKA30P/Jdaw04Z8iiUvNAxgy/TQ4yhiHMomWJ6/QRN3cLHBGAoy/qr8b5
 Na9CfGrSKcnOxP3LEG8HFqzMl8cLDPo=
X-Proofpoint-GUID: lEwN6URg-_ScVrKrhqv3yW0phrWpjWtA
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab9364f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=g8VMylnUSI6F/lPCS48DFA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=9R54UkLUAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=gc0K1kvqfXe59VH7UJwA:9 a=QEXdDO2ut3YA:10 a=NdayeHwClfA10rAUB0AA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22 a=YTcpBFlVQWkNscrzJ_Dz:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: lEwN6URg-_ScVrKrhqv3yW0phrWpjWtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061

--4EucM2glK7mDlA+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 3 (2) =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] The new XDP FCS strip in stmmac_rx() (`if
>   (stmmac_xdp_is_enabled(priv) && !buf2_len) { buf1_len -=3D ETH_FCS_LEN;=
=E2=80=A6
> - [High] The page_pool sync length no longer matches its offset base on
>   the XDP_CONSUMED path.
> - [High] Out-of-bounds buffer2 fragment after an XDP_TX/REDIRECT verdict
>   in the middle of a frame.
> - [Medium] stmmac_rx() removes the FCS with the wrong length when XDP has
>   changed the frame.
> - [Low] Some new or kept comments do not match the code.
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the same
>   unbacked buffer2 DMA destination is still reachable on AF_XDP zero-=E2=
=80=A6
> - [High] This problem wasn't introduced by this patch, but in
>   stmmac_rx(), when napi_build_skb() fails, buf->page is returned to the=
=E2=80=A6
>=20
> --
>=20
[...]

> [Severity: High]
> Does the XDP_CONSUMED recycle path still sync the right range after this
> change?
>=20
> With XDP loaded, stmmac_xdp_set_prog() forces SPH off:
>=20
>     priv->sph_active =3D priv->sph_capable && !stmmac_xdp_is_enabled(priv=
);
>=20
> So before this patch, pp_params.offset in XDP mode was always equal to
> buf->page_offset.
>=20
> stmmac_rx() still computes sync_len relative to buf->page_offset:
>=20
>     sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
>                buf->page_offset;

I think the reported issue is real it is already present before this patch.
In particulat it is not correct to subtract buf->page_offset from the sync_=
len
since the program can push/pop headers in the headroom. I guess we should f=
ix
this issue with a dedicated patch defining sync_len as below:

	sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;

>     ...
>     page_pool_put_page(rx_q->page_pool,
>                        virt_to_head_page(ctx.xdp.data),
>                        sync_len, true);
>=20
> __page_pool_dma_sync_for_device() then syncs starting at the pool offset:
>=20
>     dma_sync_size =3D min(dma_sync_size, pool->p.max_len);
>     __dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
>                                  dma_sync_size, pool->p.dma_dir);
>=20
> With offset now 0, wouldn't this sync [0, sync_len) instead of
> [page_offset, page_offset + sync_len)? The last page_offset bytes the CPU
> touched would not be cleaned for the device. That is up to 258 bytes, and=
 it
> includes the Ethernet header that an XDP_TX program may have rewritten
> before the TX ring filled up.
>=20
> On non-coherent platforms, could a dirty line left there be written back
> over the next frame DMA'd into the recycled page? One case is
> dma_sync_single_for_cpu() on the unaligned buf->addr, which cleans and
> invalidates the first line.
>=20
> This can happen for XDP_DROP or XDP_ABORTED after the program wrote the
> packet, for a failed XDP_REDIRECT, or for XDP_TX with a full TX ring.
>=20
> [ ... ]
>=20
> > @@ -5099,7 +5101,7 @@ static inline void stmmac_rx_refill(struct stmmac=
_priv *priv, u32 queue)
> >  				break;
> >  		}
> > =20
> > -		if (priv->sph_active && !buf->sec_page) {
> > +		if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
> >  			buf->sec_page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> >  			if (!buf->sec_page)
> >  				break;
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but it concerns how refill
> reuses buf->page. In stmmac_rx(), when napi_build_skb() fails, the page is
> recycled but buf->page still points at it:
>=20
>     skb =3D napi_build_skb(page_address(buf->page),
>                          rx_q->napi_skb_frag_size);
>     if (!skb) {
>             page_pool_recycle_direct(rx_q->page_pool,
>                                      buf->page);
>             rx_dropped++;
>             count++;
>             goto drain_data;
>     }
>=20
> stmmac_rx_refill() only allocates when !buf->page, so it re-arms the
> descriptor with the recycled page. The same page also sits in the pool's
> direct cache, and the next page_pool_alloc_pages() can hand it out again.
>=20
> Refill now also allocates sec_page for every consumed secondary buffer on
> GMAC4/XGMAC, which makes that reuse more likely. Can two descriptors end =
up
> DMAing into the same page, with both owners later recycling it?
>=20
> Should buf->page be set to NULL after page_pool_recycle_direct()?

This patch is already fixed in the following commit:

commit 0a7822e34a0bfde31b194ac3da3253e5032b44cc
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date:   Mon Sep 21 16:46:18 2026 +0200

    net: stmmac: clear stale buf->page after recycling on skb build failure
   =20
    In stmmac_rx(), when napi_build_skb() fails the descriptor page is
    recycled back to the page pool with page_pool_recycle_direct(), but
    buf->page is left pointing at the recycled page, unlike every other
    consumption site in the function which clears the pointer after handing
    the page away.
   =20
    With the stale pointer stmmac_rx_refill() skips the replacement
    allocation and programs the already-recycled page back into the RX
    descriptor.
   =20
    Clear buf->page on the napi_build_skb() failure path to keep the buffer
    lifecycle consistent with the other consumption sites.
   =20
    Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX pa=
th")
    Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
    Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
    Link: https://patch.msgid.link/20260921-stmmac-fix-napi-build-skb-error=
-v1-1-3d54bf6d9bb6@oss.qualcomm.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

>=20
> > @@ -5110,10 +5112,8 @@ static inline void stmmac_rx_refill(struct stmma=
c_priv *priv, u32 queue)
> >  		buf->addr =3D page_pool_get_dma_addr(buf->page) + buf->page_offset;
> > =20
> >  		stmmac_set_desc_addr(priv, p, buf->addr);
> > -		if (priv->sph_active)
> > -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> > -		else
> > -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> > +		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
> > +					 stmmac_rx_check_buf2_cap(priv));
>=20
> [Severity: High]
> This is a pre-existing issue, and the commit message already says AF_XDP
> zero-copy is not covered. Still, the same unbacked buffer2 can be reached
> on XGMAC ZC queues. stmmac_rx_refill_zc() does:
>=20
>     stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);
>=20
> and dwxgmac2_set_sec_addr() ignores is_valid:
>=20
>     static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr=
, bool is_valid)
>     {
>             p->des2 =3D cpu_to_le32(lower_32_bits(addr));
>             p->des3 =3D cpu_to_le32(upper_32_bits(addr));
>     }
>=20
> stmmac_set_queue_rx_buf_size() gives a ZC queue a buffer size of
> xsk_pool_get_rx_frame_size(), which is about 3840 bytes with 4 KiB chunks.
> XGMAC_CORE_INIT_RX accepts frames up to 16368 bytes.
>=20
> On a ZC queue, would a frame that overflows buffer1 be written to DMA
> address 0? That would give the same SMMU fault this patch fixes, or a wri=
te
> to physical address 0 on systems without an IOMMU.

As pointed out by sashiko, this is a pre-existing issue and it needs to be
fixed with a dedicated patch.

>=20
> [ ... ]
>=20
> > @@ -5190,14 +5193,15 @@ static unsigned int stmmac_rx_buf2_len(struct s=
tmmac_priv *priv,
> >  	 * Thus 'plen - len' always gives the correct length of buf2.
> >  	 */
> > =20
> > -	/* Not GMAC4 and not last descriptor */
> > -	if (priv->plat->core_type !=3D DWMAC_CORE_GMAC4 && (status & rx_not_l=
s))
> > +	/* Not GMAC4, or non-SPH and not last descriptor */
> > +	if ((priv->plat->core_type !=3D DWMAC_CORE_GMAC4 || !priv->sph_active=
) &&
> > +	    (status & rx_not_ls))
> >  		return priv->dma_conf.dma_buf_sz;
> > =20
> >  	/* GMAC4 or last descriptor */
> >  	plen =3D stmmac_get_rx_frame_len(priv, p, coe);
> > =20
> > -	return plen - len;
> > +	return plen > len ? plen - len : 0;
> >  }
>=20
> [Severity: High]
> buffer2 is now enabled in non-SPH mode, which is always the case with XDP
> loaded. Can this return more than dma_buf_sz?
>=20
> When the XDP program returns TX or REDIRECT on a non-last descriptor,
> stmmac_rx() does:
>=20
>     } else if (xdp_res & (STMMAC_XDP_TX |
>                           STMMAC_XDP_REDIRECT)) {
>             xdp_status |=3D xdp_res;
>             buf->page =3D NULL;
>             skb =3D NULL;
>             count++;
>             continue;
>     }
>=20
> The top of the loop then resets len to 0 even though the frame isn't
> finished. The next descriptor is handled as a new frame, and on the last
> descriptor plen - len is no longer limited to one descriptor.
>=20
> For example, take GMAC4 with dma_buf_sz 1536 and a 6000 byte frame. desc0
> is transmitted, and desc1 (the last one) gets buf1_len 1536 and buf2_len
> 4464.
>=20
> If XDP then returns PASS for that chunk, stmmac_rx() does:
>=20
>     dma_sync_single_for_cpu(priv->device, buf->sec_addr,
>                             buf2_len, dma_dir);
>     skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>                     buf->sec_page, 0, buf2_len,
>                     priv->dma_conf.dma_buf_sz);
>=20
> sec_page is an order-0 page here. Wouldn't the fragment run past the end =
of
> the page, so that adjacent memory and stale pool contents reach the stack?
> GMAC4 accepts frames up to about 9018 bytes with JE set, and XGMAC up to
> 16368.
>=20
> Before this patch, buf2_len was always 0 without SPH.

This issue (as even the ones reported below) is due to the missing XDP
multi-buff support. The reported problem will be cleanly fixed adding
XDP multi-buff support (I have already posted the related patches on
the mailing list).

>=20
> [ ... ]
>=20
> > @@ -5809,24 +5814,25 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
> >  		len +=3D buf2_len;
> > =20
> >  		/* ACS is disabled; strip manually. */
> > -		if (likely(!(status & rx_not_ls))) {
> > -			if (buf2_len) {
> > -				buf2_len -=3D ETH_FCS_LEN;
> > -				len -=3D ETH_FCS_LEN;
> > -			} else if (buf1_len) {
> > -				buf1_len -=3D ETH_FCS_LEN;
> > -				len -=3D ETH_FCS_LEN;
> > -			}
> > -		}
> > +		if (likely(!(status & rx_not_ls)))
> > +			len -=3D ETH_FCS_LEN;
> > =20
> >  		if (!skb) {
> >  			unsigned int pre_len, sync_len;
> > =20
> > +			/* Each frame starts here: reset the FCS handling */
> > +			fcs_stripped =3D false;
> > +
> >  			dma_sync_single_for_cpu(priv->device, buf->addr,
> >  						buf1_len, dma_dir);
> >  			net_prefetch(page_address(buf->page) +
> >  				     buf->page_offset);
> > =20
> > +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> > +				buf1_len -=3D ETH_FCS_LEN;
> > +				fcs_stripped =3D true;
> > +			}
>=20
> [Severity: High]
> Is buf1_len guaranteed to be at least ETH_FCS_LEN here, and is this always
> the last descriptor?
>=20
> On GMAC4/XGMAC, an XDP_CONSUMED verdict on a non-last descriptor does goto
> read_again with skb =3D NULL, and len keeps the bytes counted so far. The=
 next
> descriptor then enters this block as if it were a new frame.
>=20
> Take a frame of n * 2 * dma_buf_sz + r bytes with r =3D 1..3, for example=
 3073
> to 3075 bytes with dma_buf_sz 1536. The last descriptor gets
> buf1_len =3D min(dma_buf_sz, plen - len) =3D r from stmmac_rx_buf1_len() =
and
> buf2_len =3D 0, so this subtraction wraps:
>=20
>     buf1_len -=3D ETH_FCS_LEN;
>=20
> xdp_prepare_buff() then gets data_end < data, and on XDP_PASS this passes=
 a
> value around 0xfffffffd to skb_put():
>=20
>     buf1_len =3D ctx.xdp.data_end - ctx.xdp.data;
>     ...
>     skb_put(skb, buf1_len);
>=20
> Could this send an skb with len around 4 GiB to eth_type_trans() and the =
IP
> stack, where later trims can put the tail past the napi frag?
>=20
> On legacy cores without set_sec_addr, stmmac_rx_buf2_len() returns 0 for
> every descriptor, so !buf2_len doesn't mean last descriptor there either.
> Wouldn't the first descriptor of a multi-descriptor frame lose 4 bytes of
> payload, and the final pskb_trim() then be skipped so the real FCS stays =
at
> the tail?
>=20
> Before this patch the strip only happened on the last descriptor. buf1_len
> there was min(dma_buf_sz, plen), so it could not be 1..3.

This issue is due to the missing XDP multi-buff support. The reported probl=
em
will be cleanly fixed adding XDP multi-buff support.
>=20
> > +
> >  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
> >  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> >  					 buf->page_offset, buf1_len, true);
> > @@ -5926,6 +5932,15 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> > =20
> >  		/* Got entire packet into SKB. Finish it. */
> > =20
> > +		/* Remove FCS if needed */
> > +		if (!fcs_stripped && pskb_trim(skb, len)) {
>=20
> [Severity: Medium]
> Does len still match the skb here when an XDP program has changed the size
> of the frame?
>=20
> For a frame that uses buffer2 on the first descriptor, fcs_stripped stays
> false. On XDP_PASS the skb head is built from the adjusted XDP boundaries:
>=20
>     buf1_len =3D ctx.xdp.data_end - ctx.xdp.data;
>     ...
>     skb_reserve(skb, head_pad_len);
>     skb_put(skb, buf1_len);
>=20
> len, however, comes only from the descriptor lengths minus ETH_FCS_LEN. It
> never includes the bpf_xdp_adjust_head() or bpf_xdp_adjust_tail() delta.
>=20
> pskb_trim() takes an absolute length and does nothing when len >=3D skb->=
len:
>=20
>     return (len < skb->len) ? __pskb_trim(skb, len) : 0;
>=20
> So wouldn't a program that pushes N bytes lose N bytes of payload from the
> tail? And wouldn't one that pulls or shrinks by 4 or more bytes leave the
> FCS in place?
>=20
> Would pskb_trim(skb, skb->len - ETH_FCS_LEN) be more robust here?

This issue is due to the missing XDP multi-buff support. The reported probl=
em
will be cleanly fixed adding XDP multi-buff support.

Regards,
Lorenzo

>=20
> > +			dev_kfree_skb_any(skb);
> > +			skb =3D NULL;
> > +			rx_dropped++;
> > +			count++;
> > +			continue;
> > +		}
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d%40oss.qualcomm.com

--4EucM2glK7mDlA+/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCark2SQAKCRA6cBh0uS2t
rP4xAP9rnPzs+hPOwAnDbTw+68iQUmBoYEmxrV2a7vaERUmIAQD/W7n7BWEaR0X2
fYDIbqmXlyzBCANzsGFm2LaPZCf41QM=
=VGdZ
-----END PGP SIGNATURE-----

--4EucM2glK7mDlA+/--
