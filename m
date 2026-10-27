Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096630;
	b=PqXqrJByassoi2InSAS565zPGc18LIvEJ6DcDelC9kEoYvgpsKYJgxYJbcldI2PXawiZ
	 RCIwZh1yvz+e4sPEkgQGnmjjZs8Aa72IDbbHMDbdHoOlx5wjpExifa2hFiJVflRYYSv6C
	 nZ/OeQfcRBdBJuirSKEkGpiBI6Lw0KTY4ga/nK3IE1UCHbn/YVoCBROsdCrzqxoN6TDOk
	 uWn11BD696ExUeY+Kuld5isLsdUNgooCUUoO4H8qons6DOmoD9dir/2cOGQSvdB0tbQn5
	 1/+EquWhqXjDcn1dXM65A7ug0laYoUV8Ytc7uVeo8zHTjXqagAfq34HXDtppw8Mt9Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096630;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
	b=AB7x0jHc64+DJ6/KAjgZOjTSAPtnoUM2QT0PbWA65sSbwRc57VyFmgZJSBxGafe9e0UE
	 btpkDgo/H63C0oSdx8YItIlUTp/aEA4aRhIohmRPSevwv1xN00V+ixk41aUrruxCCCYFy
	 X1yG4FyLv9/Y0ib5yhvfoHXE+GeSuWaKF2VraLj2Hk9S6jIqsWNnV85ONYOSOVI83sjer
	 tI8jlitFtwCq0i3rC+ehuN4fvE4xvCGbubBMUTPjZSpKpKx9d0wmwzDqITaZEziafYiAL
	 4uxeF56n4rGdfwrSzNk7lKLSWwVw5EcwvFlvPlAOvddW0N+QzkFxj7NFy9uwRLvV2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YjpegIad;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HbwCnHug;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E3606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YjpegIad;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HbwCnHug
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gLvs1162811
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a4T8o8lcbxoyypTHmDp1YkCb
	VY4+5IakuPZVq/QfrgQ=; b=YjpegIadJSgRxIqFTcYLHmbCIlzlxa7FGhNLIyNj
	bQMz0SBO/BMYs9I5fxyO2UECFWWw7udcihltI0Nt1niz9ckrIt0meZeeNf41S6ln
	CmTshAsPcPYYapQQzgzmJ0stiQtlx7T4LTQNZx7FjtH+jSAtAv2BixrNMl2YkSmK
	051DPu/RM04hFt0HpkcOxpb3iI73SwzklYjkKCpezfjTWefDEcohU10jPnEbDgr9
	/6aZKZtK6nqpTezBOzV0fExJx5WQuXqztlof9f4YKbu8JO7QFEvNolIWsZmMmawF
	KhE71tlYvlM67kQmanHrnjtczoaBWjWhU1Mi/AaKiyn5Og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmb3ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:23:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cbf2fd504so760525585a.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793096628; x=1793701428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
        b=HbwCnHug4vM9RZTSjvfMZnjuMJw4pN99uG43iFEnx39e2VgUlPUZMwfKVKIejv2Vje
         /zvFtu6P8e6l90Rci7iWSRpJxO27lVJ4qEPnzIvbvE8T/glHFjCLne1+qEShfzirBJkQ
         Xfm+B6Hm+fzVAPzDQdL94jq224I7azT0ppcgG90VOK3NS+U7hngdcCAeyzBv0fqAmSs8
         a93T1w5aGwU8wRO61j9IrtVA1gzhQ++V+6r6B6+FvwSOa8DEuovVTTrl9JpAUumg1M7N
         hqo3Enin18kXZxIXY+61m3AK3TlsdNzRM3JPjoO7CYvkNd8rvCcfdhS8QriBukg4zPnw
         5XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096628; x=1793701428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
        b=dZm1qTrOP5Ty77wC/3771UDjRXUtlnf19X1W5gv3DMJZ4aNEpxNzOfKL3wlyRzfoBv
         CaI0fg00HJ8LYAsGOcy2Qc9NCDlWCAVXPn/2u4eRjiTcA4qCJ7SqpbzwRJfmuq+W4EJv
         svFqITDiZrZjn9FpzmnDmwU6oorCHlHQxO1w5aNMTdQGl2jE6AuZXToJ5I5nGOWCLeNj
         1dU1MxdOuw6G3vOOUpOEFh7zBeKCAblm9rCylwOwnxxUiYixXQLrI0+odXR6Mqr3/kgI
         05OBoM+gD/YOZXHov1ShegpnDXkJCjRo2/RMnk7+PG2GAQ4rr1gP6hVLOnJ6qxEQQL6S
         APSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmXMDtr0nMxuqg6kFGSMMzevX0QXIxlxeTVC6KDOkUjNMex9iX6V6pDBO1ijnkzO+JaW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9/Hvt8g95os9Px+a1S9sbQVe3okFhFxpR1311g3LJ2miKCgLQ
	cCHPF3J3dwB3yXk/+ypcNpOtm7tJXqvzbjL6VGb38j5Rx+hH5J9NKeTzEjHHmmMtO1oB/IkEf0D
	qgX5h3AT/xWm0W8u4Mlb2fm/MNOpxJiHf1miTsIjNz5nC7rYX1llO0d8=
X-Gm-Gg: AYBFou3tRn/IBJvBMtsT4FqhgGPhxBkpaUkf6Zenruh10RfEAsIp/fU+iT8mWQlREem
	X9SRmDFIJSZPvdnaUndAQ7U7zTXNieMJt3qWqsHm+vJO4rVWSthobuOvs9onC+ZUJqLGEzGuVry
	Z7LtkMGFuaok4wcxGw3DABDGdVjzzK+OAnCucYAG7YrmHWwS6g8qyVnx6omDZTHgHEM0IxwzcAY
	UiNhi5oNHwwH8gqtYqxNoFJrTHxbqECYIxsDHAikLEHStmAuQdLkekWOZRHb2dMfxww8awqmDPi
	ZAmxicbmo2TLMUfJIaJ92rvhj83qfZpXDsQdF2nh9+/dWdmOvw/ADqahfmhnh3wezSws1arNenG
	avFLyoKaWhgp9FSP7Ehr4VS59/Gk/3hDrbKV987NwMS431Bts
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr1592815185a.14.1793096627474;
        Tue, 27 Oct 2026 03:23:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr1592811785a.14.1793096626877;
        Tue, 27 Oct 2026 03:23:46 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm22130417f8f.34.2026.10.27.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:23:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:23:45 +0100
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
Subject: Re: [PATCH net 3/6] net: stmmac: drop multi-buffer frames in XDP mode
Message-ID: <auB7sd5hmULjDdHW@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
 <179309225404.3134.13890305235467768199@kernel.org>
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
	protocol="application/pgp-signature"; boundary="6H5iQYhV4nbLml5a"
Content-Disposition: inline
In-Reply-To: <179309225404.3134.13890305235467768199@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfXzibr7R+A9rWH
 zEOjSWnKz3zgroSpltMSFYi41y8sVuDpyBSR9kSD0wY4pfaKu/8s/Vq4dofekk2FQqNlqqZ2Jdt
 o93ZRu93uSr4MF0jSnCqkoxlCU1Fark=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfX3JzHs/MVM3vp
 S6NN2tNQ2lLoGwShz9+HAkNZz1JF39nUJprvrRio8KJkU/uEiAACvlSs2bcj46zYEQiFFAZ1lIk
 v8fj6oYjDoSJA/3XXeu5Ojenb7dJYnW7RrQqslQQam5AZmjECZGpj3qgG07CXe5xlCQfv9HzdD1
 9fAYn3UaDQaBPjEW/7nOr6Bsemdu9LqbLdy4plaITdTZm+H6ccJdN6P5mxhzTF+4j9iWx/aRrfE
 KOQLI6nlQN8nFLoC4ccGiyDIyP9SXzKTgzZClZX8wGMak7dz0atGSoD7iGJSU0lUCLhTLwPpuTx
 cYa3O70mCJ3nrV0vpNdOBHkaIu1Oaf3DIslNDycktB6met1GTdRiDsQ3tS2IQ6tAs9LN5ybFXyZ
 CHuF3LHpVZVaY+ieT/bT6sV0dHCG9REVOWk2IPoM+bBFSpuDQO6X+H7UrYKZlEDcKogwBY2/0GP
 6LHr+Ddo9DvADQ46F+A==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae07bb4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=S0Y5g3arb0KNKT7adY0A:9 a=QEXdDO2ut3YA:10
 a=b300ueoQ1PtkQ76yJf0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: TN9Pms2NOdJLM2MpDh5H2cYzWjyhCNIO
X-Proofpoint-GUID: TN9Pms2NOdJLM2MpDh5H2cYzWjyhCNIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270041

--6H5iQYhV4nbLml5a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The patch cites only `Fixes: 5fabb01207a2` ("net: stmmac: Add
>   initial XDP support").
>=20
> Pre-existing issues:
> - [High] Without an XDP program, stmmac_rx() still re-parses the rest of
>   a frame as a new frame when napi_build_skb() fails on a non-last=E2=80=
=A6
> - [Medium] stmmac_rx() adds its per-poll local counters to the device-
>   wide `priv->xstats.rx_dropped` and `priv->xstats.rx_errors` (plain=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: drop multi-buffer frames in XDP mode
>=20
> This patch makes stmmac_rx() drop frames that span more than one
> descriptor, or that use the second buffer of a descriptor, while an XDP
> program is attached. Discarded buffers are no longer returned to the page
> pool, so stmmac_rx_refill() can reuse them in place. The re-parse of the
> remaining descriptors after an XDP_CONSUMED verdict is also removed.
>=20
> > Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
>=20
> [Severity: Low]
> Should this also carry a Fixes tag for 88095728511e ("net: stmmac: fix rx
> Scatter-Gather support")? Two of the failures described in the commit
> message seem to come from that commit, not from the initial XDP support.
>=20
> First, the buf1_len underflow. Before 88095728511e, stmmac_rx_buf1_len()
> returned min_t(unsigned int, dma_buf_sz, plen) for the last descriptor. A
> tail re-parsed after XDP_CONSUMED therefore got dma_buf_sz bytes.
>=20
> 88095728511e changed the return to:
>=20
> 	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
>=20
> It also moved the XDP-mode FCS strip into the if (!skb) block:
>=20
> 	if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> 		buf1_len -=3D ETH_FCS_LEN;
>=20
> Together, these two changes let a 0-3 byte buf1_len underflow.
>=20
> Second, the second-buffer case. Before 88095728511e, stmmac_rx_buf2_len()
> started with:
>=20
> 	if (!priv->sph_active)
> 		return 0;
>=20
> stmmac_xdp_set_prog() clears sph_active while XDP is enabled, so buf2_len
> was always 0 in XDP mode. That check is now:
>=20
> 	if (!stmmac_rx_check_buf2_cap(priv))
> 		return 0;
>=20
> So "GMAC4/XGMAC always provide a second data buffer per descriptor" has
> only been true since 88095728511e. The new buf2_len drop fixes a condition
> that commit introduced.
>=20
> The last patch in this series ("net: stmmac: fix XDP RX buffer DMA sync
> length") already carries Fixes: 88095728511e.

ack, I will fix the commit message in v2

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3fa2c15222d88..30a2774d722b7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5903,18 +5903,23 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
>=20
> [ ... ]
>=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
> > =20
> >  		if (unlikely(error)) {
> > +			if (status & rx_not_ls)
> > +				goto read_again;
> > +
> >  			dev_kfree_skb(skb);
> >  			goto next;
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, and this patch did not introduce it. The new
> error-and-drain handling only runs when stmmac_xdp_is_enabled() is true.
> Without an XDP program, can the same re-parse still happen when
> napi_build_skb() fails on a non-last descriptor?

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> The failure branch in stmmac_rx() leaves skb =3D=3D NULL and error =3D=3D=
 0:
>=20
> 	skb =3D napi_build_skb(page_address(buf->page),
> 			     rx_q->napi_skb_frag_size);
> 	if (!skb) {
> 		page_pool_recycle_direct(rx_q->page_pool,
> 					 buf->page);
> 		buf->page =3D NULL;
> 		rx_dropped++;
> 		count++;
> 		goto drain_data;
> 	}
> 	...
> drain_data:
> 	if (likely(status & rx_not_ls))
> 		goto read_again;
>=20
> The next descriptor of the same hardware frame then passes the error check
> and is handled as the start of a new frame.
>=20
> SPH is active by default on SPH-capable GMAC4/XGMAC when no XDP program is
> attached. In that case stmmac_rx_buf1_len() returns 0 for this descriptor:
>=20
> 	if (priv->sph_active && len)
> 		return 0;
>=20
> napi_build_skb() then builds an skb with an empty linear area, and the
> payload is only in a buf2 frag. pskb_trim(skb, len) does nothing, because
> the stale len is larger than skb->len.
>=20
> With the default hw_vlan_en, nothing pulls the header into the linear area
> before this call chain:
>=20
> 	eth_type_trans()
> 	  eth_skb_pull_mac()
> 	    skb_pull_inline(skb, ETH_HLEN)
> 	      __skb_pull()
> 	        BUG()
>=20
> Under memory pressure, could an on-link peer panic the machine this way by
> sending a frame larger than one buffer? GMAC_CONFIG_JE is set in
> GMAC_CORE_INIT, so such frames are accepted even at MTU 1500.
>=20
> Without SPH, the stack instead gets a frame whose Ethernet header comes
> from the middle of the peer's payload.
>=20
> This path is still unchanged at the end of the series. The VLAN rework in
> "net: stmmac: fix VLAN tag stripping on short and non-linear RX frames"
> adds pskb_may_pull() only to the software stmmac_rx_vlan() path.
>=20
> Would it drain the frame correctly to set error =3D 1 in the
> napi_build_skb() failure branch, as this patch does for XDP mode?
>=20
> > @@ -5926,6 +5931,14 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> >  		buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
> >  		len +=3D buf2_len;
> > =20
> > +		/* Drop the packet if it is split over buf1 and buf2 on a
> > +		 * single descriptor if the interface is running in XDP mode.
> > +		 */
> > +		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> > +			rx_dropped++;
> > +			goto next;
> > +		}
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch. The new drop paths add to
> rx_dropped, which stmmac_rx() folds into a device-wide counter at the end:
>=20
> 	priv->xstats.rx_dropped +=3D rx_dropped;
> 	priv->xstats.rx_errors +=3D rx_errors;

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> These are plain unsigned long fields in struct stmmac_extra_stats. They
> are updated with a non-atomic read-modify-write, and no shared lock is
> held.
>=20
> Each RX queue has its own NAPI instance. Can two queues polled on
> different CPUs lose each other's increments here? The napi_syncp section
> just before this only protects the per-queue rxq_stats.
>=20
> The race goes back to 133466c3bbe171 ("net: stmmac: use per-queue 64 bit
> statistics where necessary").
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--6H5iQYhV4nbLml5a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauB7sQAKCRA6cBh0uS2t
rONnAQCDfR2LW22R0qwMYN7+KVy2cajIhy1x0rDeASn9b7lyKQD8DSfJFgaqLr/z
OtdSrJLjuXxDVOlLq4nSLiv2yabsSw4=
=FdEM
-----END PGP SIGNATURE-----

--6H5iQYhV4nbLml5a--
