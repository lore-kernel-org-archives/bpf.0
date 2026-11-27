Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774932;
	b=DyMsTUEF/s54TNzsVu37be1k9Xd5sHlozbNoziZuENXmj0pMGe6gJqieFaY+MtPbwQZ9
	 xOBSv8pcbCLPYRgNXHId8MJZS2tibEsBQKk+U6y+Nq9HbruxDAo8ZfvOUS4VhnOGi88/i
	 1oHWI8ordkWHfKKNnB5CHKKLkVvGQh6lDD2IfIkNemB0D/YIqwPuTWsCI3A2BrAl2wvgt
	 6MxbJhYA/hn944Ed34E8IavNt89LfOx0UlCBZKTB/TpkPDKjvaeMX6EezNHFT9KZhDnDE
	 QYDDijN7iznOlNQJtpswY5bNDvJfpzRjvsW9+cbhJr2sNoOdDR1Xdl70dQKN+3VGodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774932;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wo4YS7qq8Q1RMcBOkwyWTqRSF4hG/DoIce2rCzWWJAo=;
	b=zTOrlANpfzN0pclGHVPBU5NmWliUiv2ltTXF2AqqJXkELxS1YWtlvkoF09FGzd81K8JM
	 OePI3qmxH0KS4SufIU0BzbzfAfoQ84Eyst3Wg8oaqlemz93E6fKVAtklQmniLdtuIyRKz
	 5uDmxvRIiFqe4bdhIGudoOd/nNhslfg78VnhvL0qpcESaShr64nQ+5eLguCpGOKSOMz1Q
	 wBZnIFskF1SByd1EF23H6AUPBotYA9iUbjUkuf0evSb4zfWd8XKYnmSwO3DAmf+4GMiS3
	 gAx+cIe5DRDUZ3yNZmSnwY5ReQ+kcaKkGAR+xvn7Xbgh6jzq1QgPwJscB3quICxJ5zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UADvuU8k;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hehGXlTC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC80606A31E
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC80606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UADvuU8k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hehGXlTC
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7Gckp1564733
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wo4YS7qq8Q1RMcBOkwyWTqRS
	F4hG/DoIce2rCzWWJAo=; b=UADvuU8kqNs7LtzLY7K0mdBLDDZowLw8A9vKQ0Q9
	K7ZzcBH+IlMbWs0ieN5xCjfu9Y2cgANvh33rTabtAZv4GiwpxrMfkh22JdGe5Ed2
	Hjg1HBpvyr0/ahBjT7h1a9xqZe1Zrcx1LnlP7Gm3Lp4SJ0Afq0RAUjdyhQ5o/mna
	4St312Oo1tHSIf213iDHdrC9IJVWIZsPFoQB/Tl22yXLH6ISsQ6E7MIeBCM25CKw
	IhKX8MY6FxzK9piGOZ5W9C3NL1BzBXTubuo5+Mvl6eRmn+7NwhiNEClZLSUCtxyo
	K6q6vQwFkv9We2tVVBTmprSRE8cTUYLIKv2RA3nVfsRlbA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74garyth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:22:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495c71055bso573120685a.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795774926; x=1796379726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wo4YS7qq8Q1RMcBOkwyWTqRSF4hG/DoIce2rCzWWJAo=;
        b=hehGXlTCvnHmflM0GNFM78cfc8D4Bo4vLBUUjYelXFLCv2GRFjwBvXL8Wlro1loZaR
         G+uiY4Y3ZTz9xv2lixafwaQOVWEJscbCnGHZoEKdPRJbQX4MwK/k//UC343SssXJgdMO
         w2LgLnJXCPLqnAxS9BNMOyGj6bJi+/uUvyayomQHi8dYiHTuMRqBg+VqvIQGioUAER3o
         5EosAWhuUxgTq/pDLmwmVccGnHAkCxaY7uBsk590vrsb/WVpD4grHlBk/YinnrxAwcD4
         Yms5OgBbaZPQuycuIbX9ovMXOtsZMkYWUqeHfTyToFkNzcZtzETT/Nn/iGKAUxMxkmDi
         4W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774926; x=1796379726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wo4YS7qq8Q1RMcBOkwyWTqRSF4hG/DoIce2rCzWWJAo=;
        b=CFxu+tNo31DbU+UtRY1ALGoB93mqXenafMvLr0K+FO2xkTDFouxYuUh3jyZS2WBcyE
         ZJDn95nR4QJaGBvP6TB8xffrbc9l20guOgbGfFjIpwY7begSVdXKxBnarY4piPChY37C
         7qX/I0ei/7lkoh8oZ6YulpgpAl21gBfbG2R9OoKdT9xb4TORW4OcG0aIriEwaUDYrxdP
         ALxl1g4xp5LlbxXtZ85kgRwUQDLU5o5tARO7uQaUo1NgGN0kWpALAjeUqjAtmiYFWlvF
         OOsMtpJe24PzavHHIBsmtT+FNffjm+ZnmbrGckfYMtB7NtkW2RlS+7qYghfs8ik7SZMu
         ZCzQ==
X-Forwarded-Encrypted: i=1; AL+hErFRQZ5Krq0Wo8sj22k2uB9YSsdhtVmgpIGysTKuoLH1qpMGgWD8HiNxDP/ufc7jr42uSNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qsLKtyik3KD2MXQFaLVhkBXBj9yLurVypXk3URoIQrDvEV9Yk
	BPxceBFjalVniNCChptRu6iYO5jCxdFGp/bJRKjwLILbb3zcbn4F/0bEpEhDM/VYWR3qLl0rqC6
	rDo6EfixD7JmWxZInywBeVTAFpIJXKCXEgEevd0hC8pb9czd0CoOF7jc=
X-Gm-Gg: AZFdTZfdaYcnT4RCiGW3LynvdD6CemaogRTZvNqzNUWhUmfiI7ePw8DflIC9JnW/0NP
	wrlzrhXvxiDCJqKjX0ewOqcNq0oSwIkH5EhXBMEUUyxMbSK2N5M7vIwRqr6ybAV4U793JiHIEug
	nr55XKbVWhWdtc5e3zSeE6xVUyWATV7SbY4yDMMbvsSJbppqv/NM4HsF0OP7sVWWFPDy7OwObWW
	MT86vURCd6Nwog943ksxZhSvAsLH21yS5rUKSOqriDBzKKzXeRauufTl5p5MKvVg2Vkzo4GehVb
	LLljPlyYQyftfpIWQEW76KJxnSnKeofk5nbwyLdAV6lTQppw1vLefRw3BGmsRUzBe6z7Vn/bR9r
	QA7TdagvYD0+F3eSn9iMEWOuWnfwDbxODCeWCX7s6KV590x5wrK87JuHQM9r/Tqs=
X-Received: by 2002:a05:620a:4708:b0:949:686f:6267 with SMTP id af79cd13be357-949bac8158emr4595217485a.76.1795774925595;
        Fri, 27 Nov 2026 02:22:05 -0800 (PST)
X-Received: by 2002:a05:620a:4708:b0:949:686f:6267 with SMTP id af79cd13be357-949bac8158emr4595212685a.76.1795774925050;
        Fri, 27 Nov 2026 02:22:05 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm45511482f8f.37.2026.11.27.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:22:04 -0800 (PST)
Date: Fri, 27 Nov 2026 11:22:03 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, horms@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        emil@etsalapatis.com, ihor.solodrai@linux.dev,
        matthew.gerlach@altera.com, boon.khai.ng@altera.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, nb@tipi-net.de
Subject: Re: [PATCH net-next v13 5/5] net: stmmac: rework stmmac_rx to
 support XDP rx multi-buff
Message-ID: <awlZyw8WzCp_Di4e@lore-desk>
References: <20261125-stmmac-rx-mb-v13-5-0f6bac53e8d5@oss.qualcomm.com>
 <179570462877.3135.11557910879568810263@kernel.org>
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
	protocol="application/pgp-signature"; boundary="FUatV4zdk/zdrcyz"
Content-Disposition: inline
In-Reply-To: <179570462877.3135.11557910879568810263@kernel.org>
X-Proofpoint-ORIG-GUID: ZVZA0vCmS25i5DkIbrdzIAsVfEePKD83
X-Proofpoint-GUID: ZVZA0vCmS25i5DkIbrdzIAsVfEePKD83
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MSBTYWx0ZWRfX4BnOsD43xwT8
 JbRCFo63SvFHAet/XRyOqyVmG1h7Bsuv+txTjl9n9tfk/wnFTfJim/esImF8uAWvF2lVfUNnXeX
 Ur2JTtm6A3C4O4d7cP91Q9qnin5WZXoSPI6X9Dscdb+fuSvfH1+05J3HDL5b2F/BzGfzWdNIDLa
 Yg4WBtwasFyPMNxRwV889RlIpRhPVfYStpQS/jax4OBb25qp/VRwAhCXtCTm8U/PDJpU/N2O1U4
 LUGTkKyHVweBvfpHvlKSwRfLgEejB5hrZJi0pKs2JITGbm5r6WLjU89s/D6bC2IYsE8xPV72k52
 wc3WiGAqrzuQF8DF1kOaOvRX3CUyjAcgsaAPNnZIilffXHJP3RyvzVp42UAOW3PRSGja5NKdyYz
 KeCEShSZTuTWMSBHaw2Yq6GvnNjL3338przcrlEJIFvMaosa7yjeusa6CErQlB7PFhB08nK53ta
 bZmLnhBxvX4rMOClPuQ==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b0959ce cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5qxvQf1LLhRIni3EHqwA:9 a=QEXdDO2ut3YA:10
 a=2jtd2hDFVpeCqjqGLGIA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MSBTYWx0ZWRfXy3o53vVTpt/G
 Wz09OwVUqfrQqpEQh0moJnDkYU7wgX4OuqJoGNnxy5mi7A2DeWdTsntaxaoeUX45Gp0yesPvpyo
 tjQkKvj8L0Yc3uxBZ1S5tJHvVXLEl74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270041

--FUatV4zdk/zdrcyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 26, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] In stmmac_rx()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:6056), the FCS is=E2=
=80=A6
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch
>   extends it.
>=20
> --
>=20
> net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
> This reworks stmmac_rx() to collect all the descriptors of a frame in an
> xdp_buff. XDP programs loaded with BPF_F_XDP_HAS_FRAGS now see the whole
> fragmented packet, and the skb is built with xdp_build_skb_from_buff().
> The in-progress xdp_buff is saved in rx_q->state across NAPI polls, and
> the FCS is stripped with xdp_buff_shrink_tail().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 7896364c43e95..56355d80ba161 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -5999,120 +6014,79 @@ static int stmmac_rx(struct stmmac_priv *priv,=
 int limit, u32 queue)
>=20
> [ ... ]
>=20
> > +		n_descs++;
> > =20
> > -drain_data:
> >  		if (likely(status & rx_not_ls))
> >  			goto read_again;
> > -		if (!skb)
> > -			goto next;
> > =20
> > -		/* Got entire packet into SKB. Finish it. */
> > +		/* ACS is disabled; strip manually. */
> > +		len -=3D ETH_FCS_LEN;
> > +		if (xdp_buff_shrink_tail(&ctx.xdp, ETH_FCS_LEN)) {
> > +			if (!error)
> > +				rx_dropped++;
> > +			error =3D 1;
> > +		}
>=20
> [Severity: Low]
> Is skb->truesize overstated when a frame spans several buffers and the
> last buffer holds only FCS bytes (1 to 4 bytes)?
>=20
> For a fragmented xdp_buff, xdp_buff_shrink_tail() calls
> xdp_frags_shrink_tail(). That function returns the FCS-only page to the
> pool through xdp_buff_shrink_data(), but it only adjusts nr_frags and
> xdp_frags_size:
>=20
> net/core/xdp.c:xdp_frags_shrink_tail() {
>     ...
> 	sinfo->nr_frags -=3D n_frags_free;
> 	sinfo->xdp_frags_size -=3D len_free;
>     ...
> }
>=20
> sinfo->xdp_frags_truesize still counts the xdp->frame_sz that
> stmmac_build_xdp_frags() charged for that page through
> xdp_buff_add_frag(). If at least one fragment is left,
> xdp_build_skb_from_buff() uses that value unchanged:
>=20
> net/core/xdp.c:xdp_build_skb_from_buff() {
>     ...
> 		tsize =3D sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
>     ...
> }
>=20
> As a result, skb->truesize includes a full page_pool allocation
> (PAGE_SIZE << order) for a page that has already been released.
>=20
> In the common case the old code fixed this up. pskb_trim(), removed
> below, went through ___pskb_trim()->skb_condense() (skb->sk is NULL on
> RX), which pulled small leftover frags into the head and recomputed
> truesize.
>=20
> The commit message says the new truesize "is more accurate". Does that
> hold for this case?

This issue has not been introduced by this series since here we are just
relying on xdp_buff_shrink_tail(). Moreover, commit "net: xdp: add
xdp_buff_shrink_tail() helper" does not introduce any logic change, it just
make the symbol available to the driver. I think the problem should be fixed
with a dedicated patch.

>=20
> > =20
> > -		/* Remove FCS if needed */
> > -		if (!fcs_stripped && pskb_trim(skb, len)) {
> > -			dev_kfree_skb_any(skb);
> > -			rx_dropped++;
> > +		if (unlikely(error))
> > +			goto error_free_frag;
> > +
> > +		ctx.desc =3D p;
> > +		ctx.ndesc =3D np;
> > +
> > +		skb =3D stmmac_xdp_run_prog(priv, &ctx.xdp);
> > +		/* For Not XDP_PASS verdict */
> > +		if (IS_ERR(skb)) {
> > +			unsigned int xdp_res =3D -PTR_ERR(skb);
> > +
> > +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> > +				__xdp_return_buff(&ctx.xdp, true);
> > +				rx_dropped++;
> > +			} else if (xdp_res & (STMMAC_XDP_TX |
> > +					      STMMAC_XDP_REDIRECT)) {
> > +				xdp_status |=3D xdp_res;
> > +			}
> >  			goto next;
> >  		}
>=20
> [Severity: High]
> This issue was not introduced by this patch, but the patch makes it
> wider. With the stmmac_xdp_run_prog() change, programs with
> xdp_has_frags can now return XDP_TX on fragmented buffs. Is the direct
> recycling done when the TX completes safe here?
>=20
> stmmac_tx_clean() returns XDP_TX frames like this:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_tx_clean() {
>     ...
> 		if (xdpf &&
> 		    tx_q->tx_skbuff_dma[entry].buf_type =3D=3D STMMAC_TXBUF_T_XDP_TX) {
> 			xdp_return_frame_rx_napi(xdpf);
>     ...
> }
>=20
> xdp_return_frame_rx_napi() calls __xdp_return() with napi_direct set to
> true. That path ends in page_pool_recycle_in_cache(), which writes
> pool->alloc.cache[pool->alloc.count++] with no locking.
>=20
> stmmac_tx_clean() runs from stmmac_napi_poll_tx() on ch->tx_napi. That
> is not the ch->rx_napi which owns and refills rx_q->page_pool.
>=20
> stmmac_xdp_xmit_back() also picks the TX queue by CPU through
> stmmac_xdp_get_tx_queue(priv, smp_processor_id()). The completion can
> therefore run on a different channel's tx_napi.
>=20
> The pool is created without pp_params.napi, so page_pool has no way to
> detect the foreign context.
>=20
> Some setups put the two NAPI contexts on different CPUs:
>=20
>   - MSI with independent rx/tx IRQ affinity, for example 4 RX and 2 TX
>     queues on 4 CPUs
>   - irqbalance
>   - threaded NAPI
>   - busy polling
>=20
> In those setups rx_napi can pop from pool->alloc.cache while tx_napi
> pushes into it from another CPU. With this patch, rx_napi uses that
> cache more, through __xdp_return_buff(&ctx.xdp, true) and
> page_pool_put_full_page(..., true).
>=20
> Could the racing alloc.count updates lose a page, so that the pool never
> drains? Could they also hand the same page out twice, so that two RX
> descriptors DMA into it, or a page is DMA-written while the stack still
> owns it?
>=20
> This race already exists for head pages. With fragmented XDP_TX,
> xdp_return_frame_rx_napi() now also direct-recycles every fragment page
> from that context.

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5%40oss.qualcomm.com

--FUatV4zdk/zdrcyz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawlZywAKCRA6cBh0uS2t
rKATAP48t9HWKKWhMcCUejxJ2aT4ODYRLwtTRjtI+ZSEjBJ9jQD/Ybn2Fpz0BoX0
4kVlsb0VZFY0ci8MrTtIQAwpBArA2wQ=
=eStD
-----END PGP SIGNATURE-----

--FUatV4zdk/zdrcyz--
