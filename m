Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C03522EED
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906022; cv=none; b=mzUoroFh8pzAVRcHSDLH/Dk8NzUmIKgNaNpNxSJ+jlvDiMo8cnPdsdOvd6RuQRMNZWLCOeBRqC9x36Imr2/a8YMe3xTxpU4WuZdFTqJdnjq8qNeD/fHxiTh0XbMKqolnnorSdKrO69raldICyaPLgCa1zSIatfR8w3QcF8RgNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906022; c=relaxed/simple;
	bh=3tf0t70+1j7vmN9MWEATy/9ZvLdau/ePYX9tpEmCQGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLkjclTujxKEzVfvLriP3gDMFEMkTqrzz9jBI8IjDjAPCVF77zt0GDXySDOg2+57aATECh/SsxasRntSFF+g2D5yaUxRxItJJzrEI6ofUd7FR3iuMsv0bxYDOhdol0j2XtcUk3oKXnGe7ghqpcxJUIPL/J0JQTOs+TeQ5FXzP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JerztOAl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dN/3DUHv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JerztOAl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dN/3DUHv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE3f2i1143614
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xkkriaE2WU0d2VqRJJ5Pyd25
	3q7mRiLih0MdgW2VeWA=; b=JerztOAlwck8NrXvvn8jzhjao46aiQd7pPF6Jr/R
	rdPqciWn4xsnj9hBCNon+abtPOc91ECuVjK0PoQnTBAgLhpx0tKYy6M2YRK8YS5e
	U2fmKmueG/TMmOKmgqwt907dCLIeT6jZPsu3hwPcTZDaTb+MfDBPOocpyyZJyD5o
	SdfDnkKsItqNV2rx+KeWIJ6jPoMd8j3VoiD8JTrPG3W4kBpCeo4HOl9TKngPatzo
	31m6vT7gdyaUD/oDUp0em00G1ggyxLmDjoooVneBsxZXJdY+GqgcpqbVrrpU0tyn
	tl4uBdRQHrm9OhJ0hrvx9+izzAgZpBHR0LhiEkczPgaoRw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hpg9ptj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:40:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso543765085a.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791906019; x=1792510819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkkriaE2WU0d2VqRJJ5Pyd253q7mRiLih0MdgW2VeWA=;
        b=dN/3DUHvnkHxaw/KwTa87BiO3QJe5s0FT3C9Xsvj367TOTs/LELtQX29zxF4N+w8Tp
         ZzXGLR636oaGIS7Z9BaNdyLl/ug+Maxpi+K1Uvta189q91obczrgRoJgZEUkxrlEiGq2
         Klp25P+bJVCQ+pu2hPOAv4CdLkRBxlTyOjJROM4879Eir1/9uXV4jFOuKYwQ9cnbEueO
         Qvvf0xraosq536YeJPNeMZo78LyvxocByLvdfrLUQeqJLY7fFlDspWfsYaNvsmJ/5VFO
         vIYL9VMxI3SXTVOsVF1qJgxKXZ0U32SQX3jrp3tOAuoinOWE7jA9fqrjbO/u26yXuH4K
         Corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906019; x=1792510819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkkriaE2WU0d2VqRJJ5Pyd253q7mRiLih0MdgW2VeWA=;
        b=ejKnk/bQLpVdtyIFLZixBHQL2i9Jbg7c8dScBkMZ/ZA2hQ1i2z2AjDLBdtfQnmJjvY
         WseMl1N2WCdIYrXSSnbCQu0snnGBsIBsNjQaVa1TuAZ0pm2xtq0EEb28Eb30C17nmmMg
         /TK50CWpTNkb4rnNgkyi23pCYU5W05l7iybwtikZCfY2cIQ4DpQKJTCwQtIqZP2/BOCk
         jWPpGMaKjxIe/KmUlwCCsGZYuDn77HvZyFki8QuMX8sVzyVRGZugpc5d5yEyeAopEyD4
         wdlkA71Rb6qlTCobgEpEZHR71XW42hn61wKTZeWrwAPrxYJ5a6C+NiF8dePrUPuBoo0j
         Mw2g==
X-Forwarded-Encrypted: i=1; AKwUvByuUQkTMjier/G7JSlXDirtC/8glihAzlMn9PTbz0mqch7Alllb+vRldxOxCkjXghKlzPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdOXC9IxLl4LjwScL3EtMjB/tKMLxcdc85vaZHDUIAr3EtjFWA
	2udrFOTxOTGCifOc1KWUD2C5NsK/j2qqizlxBK7CO7USjt6nQYe+YeRG9awlT8ZjbhE58kCcXhN
	1HVX1WG5AnyiIf+W7UmVNFYugYRuYulifzYM4TCsaWm6P4R1h+XbMU6E=
X-Gm-Gg: AYBFou229FnjzELYD6mraFRBmaEDzpFqhIck2ElJETG4nERlFJijTZFHRl949j4koFS
	6jPG3/lr+cfkF3DXOauj04bArUU19wl1aS6wSfUdWac8RRmTA0e8zL6I8Xe+7vwV0RE5OathgLs
	jQdyw735/vjXLmjmQu1/Dwa7dGjtX5ujAIe1q8En+0BMbLlgV6TrhxYMrNKJZS968Tsvtd531Yb
	Npk9bc/ydc+FomGFmuE5RyanGhaZwyu1Q9Zzuw5n6XDYTBRDTUa8DHzyNxGI09SMB1jsLEymjWe
	4XLICXP1YHvVh7FtuaVFFehd5qJK1TZXT7Cbl2Xr1nvPTz1cSbLKZHwIcHfnCmeZI/Cz45EfMv6
	ej8WOxPf+c/R4vQ==
X-Received: by 2002:a05:620a:17a3:b0:93e:6283:eba6 with SMTP id af79cd13be357-93ebd225b0dmr2202768885a.38.1791906018434;
        Tue, 13 Oct 2026 08:40:18 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:93e:6283:eba6 with SMTP id af79cd13be357-93ebd225b0dmr2202762885a.38.1791906017768;
        Tue, 13 Oct 2026 08:40:17 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6ddcsm5815044f8f.52.2026.10.13.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:40:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:40:16 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, boon.leong.ong@intel.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
Message-ID: <as5Q4C4FNjwitjdI@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
 <179190522641.434549.12034764335349832312@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QzzmAfyjxSP9etro"
Content-Disposition: inline
In-Reply-To: <179190522641.434549.12034764335349832312@kernel.org>
X-Proofpoint-GUID: npkjdWDqQt5r_k19VxNIN6jWXZzRlQBY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MiBTYWx0ZWRfXxk1CXSU5xKzt
 oTAnig13U7J4PurVOALVIIgfM9KByAAJhhFFR1e4xgQ6jZJdvSTnJGwWtB/nSH+Ho80yPN2HIB+
 pgV9KJtD8T4th4h1Y9ITDQcst5RPot8=
X-Proofpoint-ORIG-GUID: npkjdWDqQt5r_k19VxNIN6jWXZzRlQBY
X-Authority-Analysis: v=2.4 cv=Z4Z5j3RA c=1 sm=1 tr=0 ts=6ace50e3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JpPTAQJ_t0xbM4wxcasA:9 a=QEXdDO2ut3YA:10
 a=c1kjC2Rka8qAMGtkAJwA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MiBTYWx0ZWRfX3UPQEVdR9kgc
 nZj9ujGs91e77W5/biGm16WOcVY8rg8NRcmSEVvFMYv/hPmU2QyhZkpjMVBLf0283XI47rx98uP
 3SS96t8GUUIAgmkLOR2smWmTlUH61M9ppRXhpxNutLrqWMy9uZS+sE1L6CT9SVis3HGQmpsK6XN
 5yxu3YXUW2OJgO017P6N9CCP0QvK9VMkUxxCeFz5AbjIGDxRXckiW+CgbeUgVbjRyOz4joaHfxW
 v/4jZqmosWd2wr+dDyh1Tf49cDuuvMJgN4LquaqhrUOfkRlJjFw82u7MPXI7is1ZWN9AHignroQ
 7ghetcECzkv/dwsN4VLle8In4Yg9fifnD+RK1t+C64keSp7hMx5z7TlFO4jLMZAjHCR2gHoMfsZ
 hLGdHJ+cVMdtABVMdZqi2b8hYsjGWlA8APXbQyvDnZuwEoXXjfUlmRvM0fBb+4uxJn7rLqdp7nA
 ieqk1VExNBGP6EOSGZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130062

--QzzmAfyjxSP9etro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message describes a bug that the current driver
>   cannot reach.
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but on cores with
>   normal (non-enhanced) descriptors in ring mode, which is the default=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: fix XDP TX DMA address for compound RX pages
>=20
> This commit changes stmmac_xdp_xmit_xdpf() to use virt_to_head_page()
> instead of virt_to_page() when it looks up the page_pool DMA address for
> the XDP_TX head buffer. The goal is that a data pointer sitting in a tail
> page of a compound RX page still resolves to the DMA base of the head pag=
e.
>=20
> > RX pages become compound as soon as dma_buf_sz needs more than one page
> > (pp_params.order =3D order_base_2(num_pages) > 0), which happens from an
> > MTU around 3000 bytes once dma_buf_sz reaches 4096. If an XDP program
> > moves the data forward with bpf_xdp_adjust_head() by more than about a
> > page, xdpf->data points into a tail page whose struct page has no DMA
> > address: page_pool_get_dma_addr() then returns a bogus bus address, and
> > dma_sync_single_for_device() together with the TX descriptor transmit
> > from the wrong location.
>=20
> [Severity: Medium]
>=20
> Can the driver reach this configuration today? stmmac_xdp_set_prog()
> refuses to attach a program when the MTU is above ETH_DATA_LEN:

Similar to patch 2/2, this is a preliminary fix needed to remove the MTU
limitation when the interface is running in XDP mode.

>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
>     ...
> 	if (prog && dev->mtu > ETH_DATA_LEN) {
> 		/* For now, the driver doesn't support XDP functionality with
> 		 * jumbo frames so we return error.
> 		 */
> 		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
> 		return -EOPNOTSUPP;
> 	}
>     ...
> }
>=20
> stmmac_change_mtu() blocks the other order too:
>=20
> 	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
> 		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
> 		return -EINVAL;
> 	}
>=20
> When XDP is enabled the MTU is at most 1500, so stmmac_set_bfsize() retur=
ns
> DEFAULT_BUFSIZE (1536). Then in __alloc_dma_rx_desc_resources():
>=20
> 	dma_buf_sz_pad =3D stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
> 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> 	num_pages =3D DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
> 	...
> 	pp_params.order =3D order_base_2(num_pages);
>=20
> dma_buf_sz_pad stays below PAGE_SIZE, so num_pages is 1 and the order is =
0.
> stmmac_rx() also sets frame_sz to a single page.
>=20
> On an order-0 page, virt_to_page() and virt_to_head_page() return the same
> struct page. Does this change behaviour at runtime in any configuration t=
he
> driver currently allows?
>=20
> The threshold in the message also looks off. By the driver's own sizing,
> dma_buf_sz reaches 4096 once the MTU goes above roughly 2022, not 3000.
>=20
> The later patch in the series, "net: stmmac: disable TX checksum offload
> for jumbo frames on bugged cores", only adds a csum override. It does not
> lift the XDP/jumbo restriction, so the described trigger still can't happ=
en
> at the end of the series.
>=20
> The change is reasonable hardening, and it matches the existing
> virt_to_head_page(ctx.xdp.data) use in stmmac_rx(). Could the message
> describe it as hardening, or as a prerequisite for jumbo or multi-buffer
> XDP? Could the Fixes: tag also be reconsidered? As written, stable will
> treat this as a fix for a reachable DMA corruption bug.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index b8b4de4c5b1a7..ca61ab449e32b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5301,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_pri=
v *priv, int queue,
> >  			struct page *page;
> > =20
> >  			page =3D frag ? skb_frag_page(frag)
> > -				    : virt_to_page(xdpf->data);
> > +				    : virt_to_head_page(xdpf->data);
> >  			dma_addr =3D page_pool_get_dma_addr(page);
> >  			if (frag)
> >  				dma_addr +=3D skb_frag_off(frag);
>=20
> [Severity: High]
>=20
> This isn't a bug introduced by this patch, but it has the same symptom.
> On cores with normal (non-enhanced) descriptors in ring mode, the default
> when chain_mode is not set, can the XDP_TX path in stmmac_xdp_xmit_xdpf()
> make the DMA engine fetch part of the frame from an address that was never
> programmed?

I am working on this fix with a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_rx() builds the xdp_buff with a full-page frame_sz:
>=20
> 	bufsz =3D DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
> 	...
> 	xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>=20
> That means an XDP program can use bpf_xdp_adjust_tail() to grow the frame
> well past 2047 bytes and return XDP_TX, even with the MTU at 1500.
>=20
> Further down in stmmac_xdp_xmit_xdpf(), only TDES2 is programmed:
>=20
> 		stmmac_set_desc_addr(priv, desc, dma_addr);
> 		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> 				       priv->descriptor_mode, !!i, last_frame,
> 				       xdp_get_frame_len(xdpf));
>=20
> With normal descriptors, the call chain
> stmmac_prepare_tx_desc()->ndesc_prepare_tx_desc()->norm_set_tx_desc_len_o=
n_ring()
> splits the length between buffer 1 and buffer 2:
>=20
> 	unsigned int buffer1_max_length =3D BUF_SIZE_2KiB - 1;
>=20
> 	if (unlikely(len > buffer1_max_length)) {
> 		p->des1 |=3D cpu_to_le32(FIELD_PREP(TDES1_BUFFER2_SIZE_MASK,
> 						  len - buffer1_max_length) |
> 				       FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
> 						  buffer1_max_length));
>=20
> In ring mode, TDES3 holds the buffer 2 address. That is why jumbo_frm() in
> ring_mode.c sets it explicitly:
>=20
> 	desc->des3 =3D cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);
>=20
> The XDP path never writes des3, and ndesc_release_tx_desc() only clears
> des0 and des1:
>=20
> 	memset(p, 0, offsetof(struct dma_desc, des2));
>=20
> So des3 still holds either 0 (from the coherent allocation, or after
> clean_desc3() runs on completion) or a stale buffer address. Would the MAC
> then read len - 2047 bytes from that address and transmit them?
>=20
> Without an IOMMU, this could send arbitrary memory out on the wire. With
> an IOMMU, the read would fault and TX DMA would be restarted.
>=20
> ndev->xdp_features is set unconditionally, so nothing blocks XDP on these
> cores. The behaviour goes back to be8b38a722e6, which added XDP_TX.
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1%40oss.qualcomm.com

--QzzmAfyjxSP9etro
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas5Q4AAKCRA6cBh0uS2t
rE9eAQDRnphJd2YEURo3Zv5ds7wVmuatyCa4F5XUEYd3yznfkgD+ILzKa5TclYSI
bYNDFU8b9ChVojcAYT5PwQ/F9AvPzg4=
=9D03
-----END PGP SIGNATURE-----

--QzzmAfyjxSP9etro--
