Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101147;
	b=YEaJsrVbuzGm7tcG7Z6oWqLySHu61mQxzoIiyjypN6z/eVg3OTRnj2U7qSm3yOH643vl
	 3NHCOxIQZwjT6JmQMJinc2+npUkDxShqFOLfQuXmMEtFlwY2p2T2C7FX8glmIfZ1IGv7h
	 b6pT0ybDREagOtqLi53tQ23i3z+vDujgwxnljrOUV7Yo1GD4zORWPqDtWJoYyl+sG6wGE
	 1MZiG3V+FjCB3TsSMxtMvpL4sCVhphjOl5qUwgDcFPsqmBHfjppRYJqSbm9t+nFk6oLMG
	 d5lkA2Leo34if492L0/+4G9Jx9bL9MUqp3o7bRWMPToFi94NJe+ulUEpf/7VMwbuGDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101147;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
	b=RJt1wau0ShL22SOt8Eh6Sm61lELcLhr48kKra+VzGlEhIa8GulBnhj2PSGNtMdhsNJc+
	 1NEIZdBLfofuR9dLRcyDrf9TnKGjMMHp7pQ7FrFN+TBGpz2XHrtu1z8N8lQJudjPBMdII
	 iaZ5OkZRFVwz2LZKiLrBKlgxxSRkMiyR8gJoAuIhInubk6MCZJWOR/jYqGnfyu2zbgTwe
	 cl/w6pRjI7jdACJi5Sn6rn22p+fPrOnhqH7OqUDNqtvq8cEKgwICqxpCWuv5zP88cuPFp
	 mmqAVgGjSzPo7Oa9KiZKAalUEb6+ngATJ9ec5ky5KtC1LgQj0eku856MaMBPJfbNwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="VuCRiRC/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvrbCq4V;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89960A261F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F89960A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VuCRiRC/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvrbCq4V
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeJw21427422
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iqD5vVTTBfwoyL27JJNk8QW9
	87++ASEipnY8mTx2+X8=; b=VuCRiRC/VaFyAGrn6r+gYBN1zvuZ/8RX7thyBd7U
	XuGZU3AtaQzIPZ642s80omtQq4OPa7YVpGQNnWd0aM7Yx8ICHzQD0+bjfUEEaF/Y
	USegby5gMJG84trbWA+mgM9AKi24d+CpFx/jkpXkLzZFEFOqA0eGJfZR3GrkMeYK
	pouWkLCbRomvOO79HB26LtD1tDnLYTssi7N1U5+6HMqhFmBOXtOu3V2symLqsZiG
	M4jsJQD3G0F+slbafLirjxbPFJmVeA8XWL+XgMfDXcm5dYkCx3M9/kzvGDnJBSmK
	lUvhGtxZCyK6bmLTxHrST4SVGPRM4k+h4qcH/hUkESavpw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbcgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:39:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1f2fafeaso539714185a.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101145; x=1793705945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
        b=hvrbCq4Vjfzrqrjh8cvT/34/cYa3fmIkMWz9qOLQT3LOHC1mejhBYQqc8AMN3PRJU/
         fcUQ/NOGX6VZPjU+yHzeYgL9nwnM4J1gX4DdJ3cWQ1wPFgrQTC5mvrYi/nXBDjlYhW/S
         3LDNMJKy7rFu0ffBVC6e4jWtsjr4l3VKxbpyl8JgzqkKoFyW6QYD4P2OMTuCXL+ZnzWW
         rx1XU5iPk2KMKFL2TGAtzf7tQttxseHcQCIO0vvPBphVOndICDKfKSVohdSbZLLHkCDK
         oRKkTFbnbfVtyXhRds47sq3hOo1ahktbMQubs0143Hgfzd1rLSEtVlRGlTDYkEmyWSd6
         7YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101145; x=1793705945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
        b=LhucNpSTEZLVSeC9T/YBa64s/ONVlHWcFSQKUxkRiyEgyiBUrzwR3XIJq3gMOaxoU1
         Xw9MqduLMahvtcw5QWKtof4O3xFzyzb+khk3xyEUQVuE86BA2wPamJrtsDxW08gT7pRd
         e4CBA5nL7UWjCnaVJmvHngP20ZKdpr4dkJT+HxkC7KOhB2Ij6YM5YYLOPbZA4RqtpANc
         g1h08WOBRV51zWe36XWLVjGo46z2yB5dq69ggI1xLK54CeWu7dGhsyWuXmCM5iNscOxT
         vQ1StQlumifkj+c6TsN+qR6ZTGsSCv62Qa3gmIM9ZAJMJlxZEw8d+DCZM8TI1C2Te9Lu
         qf9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcf1PNLPwUXB/qHb8VBs6JYMYlyxzJZIxHqC809deHY7C5aOxpMCUpNYCOvo/RHF6GRew=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHH+T+NvtcaZ0HhK0Yoa1Xn2gVONNb2KbYFscLSYr7Uok7NBEv
	WQJrUjLJvL/5sFib1zn66iQ2IW+wPs3XgX3pWdl7mx6ZtlB8xKCO4vHCSuiC9PuJiTFhrB++OX9
	oZt+Zb3n99fJLFcrswwyJKUPSlFB27Ch5rUbcbMJj/uf+HGkTEVjsjZM=
X-Gm-Gg: AYBFou1FSb4wXgXHqMH1rUniejks5jjqjsNUAturAKGnIyEnXBTgXA4IyEkfujhaKRn
	Eowc6WxvxRXBty9wAF3QxgjUmHMUGEkTMtaBkCVU4PSuu0x86P77kOSaOAEjvXQmfb/zFPcRNjU
	3jd5BNBJIbAwujd6629XNqFF/Bpy2nWJLVwKR8p8Ra0xQd0pRaC/fzXhLEGehCMPJPwaaEr5TjC
	/WUDfHeeM842ra23qFPCfvqIaZZyehzhqnqfPa7Th8bjdd10t+4Xw7jM/bW+NoDdoNB/1+3FM0o
	XgnDuQ3b6ZtekNlg89P/3mWerwQfZi11Zey/Qvxv57IqhPpYQ44Q268l5SNy/4f4klmJlFImfTJ
	V0OohQ5+epJl78000dE7qgUtpb/HGaJ1NizebtbbD7atWxUu0
X-Received: by 2002:a05:620a:4515:b0:93e:48fc:aa85 with SMTP id af79cd13be357-940ef9571aamr1426244485a.43.1793101144179;
        Tue, 27 Oct 2026 04:39:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93e:48fc:aa85 with SMTP id af79cd13be357-940ef9571aamr1426228385a.43.1793101143118;
        Tue, 27 Oct 2026 04:39:03 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd39a9sm22840875f8f.46.2026.10.27.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:39:02 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:39:01 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, o.rempel@pengutronix.de,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net 6/6] net: stmmac: fix XDP RX buffer DMA sync length
Message-ID: <auCNVe1pMumVcF3s@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
 <179309225887.3134.17502896212947474889@kernel.org>
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
	protocol="application/pgp-signature"; boundary="meEQn4EyMsDIqBx+"
Content-Disposition: inline
In-Reply-To: <179309225887.3134.17502896212947474889@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX8z4NafGTEZZg
 Er3rxNDPKWDUKPqdqIgVNx7Ai3Jc08szHbRuQI4M+4ZHIt8d1v2yGxVW/y1Fe+ISCROByLlySY1
 uQoLgFaGqS0QZGCpZFUSuYK4/SaqLHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX7scS/Aqv8jF3
 JRl50TlYQbd/dVYYqqfrVtyD5IN5Hn8N83NsWZCVWKZuBmJ1CK51gGRt8vC/7uH+f6W0nzNMPmo
 x7UzdBN/pZ1uXVVWxbjM7NdmfajA5gfutebVoJCwFYEpV8dpOgVCiNFhuQPkUjGyKzAwOt1lW/Q
 SEoRkmnNyazWHp9U7hZeuCHYOUUNFDRMQ+2kpfTXjM6yUOMGMud39d2RZ2kf/WBTtPNKhiqhHiq
 lTZ0TMtWYG37zQN7/lhdPXEAdlN0X1JJXeJyKNwBnOaLpkNqBaFOjVeGrwgPNXhZePLIhvvyvyQ
 22MXcVr/5xTjWsV8ics54BOfuuO9bpTgKO62CDK+NizclHdVJiE7jmfIIFgfIAXtuZOJt8Xk+7f
 hAFjW3EqhNY4Zi6iLtTzVn4+xlP7zRLDF99YNjZpsP1DTsa/noYqeRKAAzNJaP5hZ+ZZtUWX/aG
 RyIBmHytXx77fvnyc4Q==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae08d59 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=3lS5nG9XOEgB1YPr8hIA:9 a=QEXdDO2ut3YA:10
 a=R8n3WUYfiK2D1sPUeuAA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: VK_etDN7um7NVu0svevkJ70CctTGqRBJ
X-Proofpoint-GUID: VK_etDN7um7NVu0svevkJ70CctTGqRBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046

--meEQn4EyMsDIqBx+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] In stmmac_rx()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the length passed=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: fix XDP RX buffer DMA sync length
>=20
> This commit changes the XDP path in stmmac_rx() so that pre_len and
> sync_len are measured from data_hard_start, and buf->page_offset is no
> longer subtracted. That matches the page_pool DMA window, which now
> starts at offset 0. The goal is for page_pool_put_page() on the
> consumed XDP path to sync the whole region the CPU touched.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 32b2c5834c340..c51358c51fae7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5980,8 +5980,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> >  					 buf->page_offset, buf1_len, true);
> > =20
> > -			pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
> > -				  buf->page_offset;
> > +			pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> > =20
> >  			ctx.priv =3D priv;
> >  			ctx.desc =3D p;
> > @@ -5991,8 +5990,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  			/* Due xdp_adjust_tail: DMA sync for_device
> >  			 * cover max len CPU touch
> >  			 */
> > -			sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
> > -				   buf->page_offset;
> > +			sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> >  			sync_len =3D max(sync_len, pre_len);
>=20
> [Severity: High]
>=20
> Does this cover the furthest point the CPU touched if the XDP program
> grows the tail and then shrinks it again before it returns?

ack, I agree this is a real problem. I will fix it in v2.

Regards,
Lorenzo

>=20
> The comment says the sync covers the "max len CPU touch". However,
> max(sync_len, pre_len) only looks at data_end before the program runs
> and after it returns. bpf_xdp_adjust_tail() writes to the grown area
> when the tail grows:
>=20
> net/core/filter.c:bpf_xdp_adjust_tail() {
>     ...
> 	/* Clear memory area on grow, can contain uninit kernel memory */
> 	if (offset > 0)
> 		memset(xdp->data_end, 0, offset);
>=20
> 	xdp->data_end =3D data_end;
>     ...
> }
>=20
> A later negative adjust only moves data_end back.
>=20
> Take a 64 byte frame at page_offset 256 and a program that does
> adjust_tail(+512), then adjust_tail(-512), then returns XDP_DROP. Both
> pre_len and sync_len end up at the original end, around 316. The memset
> dirtied the cache lines in [316, 828), but this call does not clean
> them:
>=20
>     page_pool_put_page(rx_q->page_pool,
>                        virt_to_head_page(ctx.xdp.data),
>                        sync_len, true);
>=20
> __page_pool_dma_sync_for_device() caps the length at p.max_len but
> never extends it. The direct recycle cache does no further sync.
> stmmac_rx_refill() gives the buffer back to the device after dma_wmb(),
> with no more cache maintenance.
>=20
> max_len is dma_buf_sz + stmmac_rx_offset(priv), which is 1792 with
> dma_buf_sz =3D 1536. So that range lies inside the window the device DMAs
> into.
>=20
> On a non-coherent platform, could one of those dirty lines be evicted
> after the device has written the next frame into the recycled page, and
> corrupt that frame? It looks like the same failure the commit message
> describes:
>=20
>     Dirty cache lines in the tail of the frame can be written back
>     after the device has DMA'd a new frame into that page.
>=20
> The commit message names "grow the tail" as a trigger and says "the
> whole CPU-touched window is synced". The max(pre, post) approach was
> already there before this patch.
>=20
> Would it be better for the STMMAC_XDP_CONSUMED path to sync the full
> pool window instead of checking only the two endpoints? Passing
> p.max_len, or using page_pool_recycle_direct(), would do that.
>=20
> > =20
> >  			/* For Not XDP_PASS verdict */
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--meEQn4EyMsDIqBx+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCNVQAKCRA6cBh0uS2t
rC55AP9UGxsbij3J4aUzASRo/KyX2he35yAIxxiEqHkTq1acuwD9H5JR/kGUZHLc
maP+Ju/MorEuwb/frXx/LrWFlgWzdgQ=
=hxk0
-----END PGP SIGNATURE-----

--meEQn4EyMsDIqBx+--
