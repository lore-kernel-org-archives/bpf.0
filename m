Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350135;
	b=MRjGgRxEAa1bHLkTXEQmMLjz1YXxEypZixo8M5eUQgAfGJUUKYs59tBTOSWxY6NCbIJh
	 DUGRRFckZAG3Ob/ImO2GKY919vvf1t2uzpWcURItHnez01+LiajFVDf7D2+FLqbqziws2
	 uNXXFkm8fFSpsD/ontd5jR4holECpZrToVZTq0cEi9XtczOzvro/uWb1Em5hjpGDTFHsA
	 Pn9OrLMAdunfV/MgOmt5M8DlcTEL5/N/0hGojKUlFkjMqHB9n8embaJC9aHQqdkDgMY8L
	 ZcNWDYajAWnxdOU7XKZMQdNqOXT0IPNmZGDabaiMk3dSRyT7UD7knGOqIXQNBmXpxbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350135;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
	b=jK6YF2Bf1EUN03U9iFQVEUeBf4Bun5fXl/OfzpSdupCIf3Ao4nUAPCvNN+dOhZV0V5fs
	 oOXGvZNskKWG1nzIPtwFrIum51n2kLsQS0QOoja6vxizemR6/k+ouLLsmyOg+xQPvxqA9
	 gLWBf6vld462ks08pyTvVO9O9/Uxo2o4fWZTkXqXfDs/JHaYm7zOuNNtb+1G9csbjHwM/
	 0k6fsjfCglAMcbOjSPYidqM2BtxhOHfwI7gIp14SNvteKakAw73pWKWJTXxIiJSbVmp08
	 NsVYrqwql8xsJryM5N61l5y2uZspAJnAgmA/E7CuXAjvtbiqQS5dm+5XZDYz6EUl57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvVna+u5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+KJCxUJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0B606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA0B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvVna+u5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+KJCxUJ
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FCgT3709484
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d2olyE8nkwfIZoPiTmTgfbY9
	lInYL1sWn+D/JJOh5/4=; b=YvVna+u5ZUvrfMKUUOJEHq3TIudxwxpc2vWcdbS9
	GOVXFvI2WINW2F5/40Yu/QSaPn86s/5MXDI+BrNR+ESUT+AebPhpLJSTePNiPQjE
	+4F8S/WfzATpeRcnOwRNWBTZjGWD9i3Gw7+5Q/teSjPQwwerRtXgUKg2Y5CFHpD3
	+kP8jsxprtoFugP+PzLHsiiJUVi6dOeCBV6Bv2DJNipFxZYHYBGpZyjdi9ZAmK1d
	7S5NyjcwHhgka9878N1BFEm/SEpxsYLTVsZx3DlaDCHjC4qUkDbDyE+Qa8jm5TmT
	bXLQxw5Cgx/uYSjapZx7sc0w0os4zbiIYDVhG3gpFpZJkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rj4sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:48:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f13c143c8so73904685a.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793350133; x=1793954933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
        b=X+KJCxUJ/Moh6gzEGgAUOFXF9DfuRgJeDUf5aexPgYLcdrOAexUMFcxU3njRrwMJpk
         f/5qDQz2VuP9qYAh+7Y+IL/B08jUGPoINS17B/glRw7aPF/qn2R9UZONZASW1RzHVIWp
         X8hC3LQkB8mfQhW5wydt4apmpf4lzlZsWx47CtoN8tDoBH6RL4r7PpqoTTirHTK9U0t/
         bU5VmzDU3xeYjZLHNtBHnWppron5BVjffZpXQClQxjyZyBPscwqGbsbkBAqn5gfHa8Tp
         8vFrV5mA9IMeyh3+3MbQ6BNsSGF9eNov07o5Up2IfXcIM8xsziedvb3yBwlfR95wWcLc
         VeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350133; x=1793954933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
        b=SzED7sr8gZiGH8/HFpw/br3pPnvm3xoquPJvynyv04Ny9m1s6JGScoij36pVZ8eTd9
         OgvZ9wrC2HA/JE01YXeAU5Hi0UrcLNk1ojruqNKK/oKRHlU69zSGoUbEMwq42u28xWJe
         LWnlEidJs4Gm427AY1Wt3QhmdztIDETPKe1bkPIWmf1iQWki0PE45lGIckf2qsZbices
         WVKkvcNZ8l21xB21HR8walKb33i3XuvrE3veFBfgNVkbrspKl2nO3+rlnO7KmYeIwkBW
         lMEskXKPzlklbjcO16GgFId9vPka4jr6RjM4QtsQxs9HKSCOvsca7JeIP/GqpPooCDTe
         J7oA==
X-Forwarded-Encrypted: i=1; AKwUvBzyQIvsqxf36fEJ40uLo7w44gudPnTkCT/hIWeiTrG1tUxQFmUlleXBoE4tVhoDpFUVYHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPpxjSBMZX89l9mDcjzMZnDU8FM5SN0woy8pxIO25CCVcX8+HK
	o65LgLffJDctDkNTjZLcEXubWjnwldMQ3lq+46lBTME7B/JgyzFGpft/BjHiM4obPagH9o4IZfg
	ugraskw6LVexTits0jALUDqLUgAi7avPgvUSUOEglrU29KupJMvOLlgU=
X-Gm-Gg: AYBFou2WgsudLW1diZ9Ss2jpAOqkMJawVr+6n6gQgX3qm5D3qNi+uNr/X2wyr5D20ah
	G1mfzi1nMNCfgnihl3Gf0RYFIXPLZVNN0LxErtLcVk+u0Q/KwkQYSpTdf/e1UY0U/LMo5rZtq/l
	gykv/tyWoXmd3jJEpbZhZ5NJZhp8dBMgRR/HLVYCA3/zpM5C4IabyTF4Ay0Izk3GTzh8uKugQUx
	qkXBcHz5VEpXnb4+0nnSAxdnlprhYXxOOGCM48LLqRH+MZ1VSxuVLbGQH9Y6PPleQi8OX7IUu58
	0hxAtZ8mcmXCJOFx/v24KCmQ3uMYvcyYLtIXLPpflJkdom/mMGv8dHjVCVzvrJk7feocWiNycmN
	6LpDIddxEgWOhFCQ8dw2pdjmIbGe1zCH5/yeW/MOhPGKR8FemEFKZQvlRgMW+pnZDdE5bMThP2H
	r5IKKwAKrecwmVhVqP+61vDA==
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr275562185a.72.1793350133084;
        Fri, 30 Oct 2026 01:48:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr275558885a.72.1793350132551;
        Fri, 30 Oct 2026 01:48:52 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm47152495e9.10.2026.10.30.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:48:51 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:48:51 +0100
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
Subject: Re: [PATCH net v2 4/6] net: stmmac: copy XDP metadata in AF_XDP
 zero-copy RX
Message-ID: <auRZ8qGf-6smpZNo@lore-desk>
References: <20261027-stmmac-xdp-fixes-v2-4-10eae8a093a8@oss.qualcomm.com>
 <179334662537.3134.7910783540285829149@kernel.org>
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
	protocol="application/pgp-signature"; boundary="uOk9qAS7xtVWcgde"
Content-Disposition: inline
In-Reply-To: <179334662537.3134.7910783540285829149@kernel.org>
X-Proofpoint-ORIG-GUID: ONmH6R5SfWCwHFDeHMpKK5XhdZAgDnb6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX9vJrc5xVKFCJ
 xj4LLQtqravrdBZAPOyU6I3VydrFUno6VzBLQtJhCZ6VMHXkpxrXndCx9vyZQBYZuqOTHsIOpaQ
 TsPs0XtzVsMtYKqbV28mOlr4rNFqUi0=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae459f6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MXY1n-zC4wgOH_4sE1YA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=7PUuv8MLwXOgIG9yGv4A:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX+UYiUl74Tmgr
 fP1qCrvmQAZ1nKm/LawVVmFea4oJ8aER6hm7yi7EboR6p4pT5cIdAJCLYGmET2CtjceE6IsgG22
 q/0zwqEt2meMiYbkBWnT5eDDfcQbV4zp4wpTNg66hOs93G45gi81gBJBrlahnFYaPKR0xot9Acg
 Wz9G1q3a+4OKtuWhKk04/XVsXjRcDFy9+rdm4VKBAH1WxCG9CUWm/XgT39r3jl4yN5aurSFWkmt
 U1iccOhwShT4HbSKxBnakCZrGUX3ibcCR2pMK5ip8reKoopWMvHzEF7BsQKbqnre8XtG1JzoJ0T
 RqlxoBZ8KzpFf9K+dEnHLs7O76DGSrCbqVqcCAjEFSfa4saJ0JK5UBD7Rt7r0xWlc8NYu6XTPo8
 HBwCbP0Oj8EcG3qd2vcfDFqxe/t9SLFc2N5E8nlJqb6sJgCQX7cn1MlyQf6SnFaYXOjyeLbnFPc
 wDu+EQspmRgLqAGk/Nw==
X-Proofpoint-GUID: ONmH6R5SfWCwHFDeHMpKK5XhdZAgDnb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300034

--uOk9qAS7xtVWcgde
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 30, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] In this patch, stmmac_construct_skb_zc()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5521-5525) copies=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
>=20
> This patch changes stmmac_construct_skb_zc() to copy the XDP metadata in
> [xdp->data_meta, xdp->data) into the new skb together with the packet
> data. The metadata sits right before skb->data, and its length is recorded
> with skb_metadata_set().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 71858af6fd66d..d9fc2464a160a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5519,7 +5519,8 @@ static struct sk_buff *stmmac_construct_skb_zc(st=
ruct stmmac_channel *ch,
> >  		return NULL;
> > =20
> >  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > -	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
> > +	__skb_put(skb, datasize);
> > +	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
> >  	if (metasize)
> >  		skb_metadata_set(skb, metasize);
>=20
> [Severity: Medium]
> Does the metadata stay valid for VLAN tagged frames that are stripped in
> software?
>=20
> The commit message says:
>=20
>   This keeps data_meta valid for the stack and TC BPF after eth_type_tran=
s()
>   anchors mac_header.
>=20
> When priv->hw->hw_vlan_en is false, stmmac_dispatch_skb_zc() calls
> stmmac_rx_vlan() after the skb is built and before eth_type_trans() runs:
>=20
> stmmac_dispatch_skb_zc() {
>     skb =3D stmmac_construct_skb_zc(ch, xdp);
>     ...
>     else
>         /* Driver level stripping. */
>         stmmac_rx_vlan(priv->dev, skb);
>     skb->protocol =3D eth_type_trans(skb, priv->dev);
>     ...
> }
>=20
> For an 802.1Q frame with NETIF_F_HW_VLAN_CTAG_RX set (or 802.1AD with
> NETIF_F_HW_VLAN_STAG_RX), stmmac_rx_vlan() moves only the MAC addresses
> and then pulls the tag:
>=20
> stmmac_rx_vlan() {
>     ...
>     memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
>     skb_pull(skb, VLAN_HLEN);
>     ...
> }
>=20
> The metadata stays at [D - metasize, D), where D is the original frame
> start. eth_type_trans() then sets mac_header to D + VLAN_HLEN. Since
> skb_metadata_end() is skb_mac_header(), TC BPF and the stack would see
> the window [D + 4 - metasize, D + 4).
>=20
> Wouldn't that window lose the first 4 bytes of metadata and end with 4
> stale destination MAC bytes?
>=20
> This can happen with AF_XDP zero-copy, an XDP program that calls
> bpf_xdp_adjust_meta() and returns XDP_PASS, and a VLAN tagged frame on a
> core where hw_vlan_en is false. stmmac_dvr_probe() sets
> NETIF_F_HW_VLAN_CTAG_RX for all cores but only sets hw_vlan_en for xmac
> cores, so dwmac100/dwmac1000 use software stripping by default.
>=20
> Before this patch the metadata was not copied at all, so this does not
> make things worse than they were. A later patch in the same series, "net:
> stmmac: fix VLAN tag stripping on short and non-linear RX frames", changes
> stmmac_rx_vlan() to move meta_len + ETH_ALEN * 2 bytes starting at
> skb->data - meta_len before skb_pull(), which fixes this case.
>=20
> Could the commit message mention that the VLAN stripping path is fixed
> separately, or could the two patches be reordered?

I guess the reported issue is fixed in the following patch: "net: stmmac: f=
ix
VLAN tag stripping on short and non-linear RX frames".

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8%40oss.qualcomm.com

--uOk9qAS7xtVWcgde
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauRZ8wAKCRA6cBh0uS2t
rEMSAP0ckjQt67ODqSh/d4rEEdTXd68ufBiuZPEyUP2VIVyEVgD8D/oK/777QoIE
JtSmhynYGNYRxd5J04Emj7z0LderAAg=
=zAho
-----END PGP SIGNATURE-----

--uOk9qAS7xtVWcgde--
