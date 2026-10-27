Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099462;
	b=wzon2oWA7MwDi/OtBW7WSmBASY0PWT0yfOk+9K8zBoujXiE2Pi+/pVt+ZxxkczNHmSyX
	 z8dV7DF41R14wna9r5ZiKg+T/QxJSUJRNcdPGdJVhxu5tY6ETn1TQMJ37kuugD/qbDp4h
	 4MCTUawuYqlM00IgDuU/4cx2q+w6kpSrdhH6OP0MryMrztqkbKC2l54f8X40lO5a2EJXu
	 6EbAdrlDtqCB9XgL3d027U07PA8Lx+0ZGiNz0CK5X5NYU7O/b27u14UgKu0ir+t1lPsni
	 4qj4V2wMJ2dJNS6AP4191fvGT1NaWYvWjwlwoRhxtxrHxP+7ao1syGqnkT8JI2dgVBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
	b=vGNpSGKLVursjqQyfwg5tNl6gwTV7o+mYkxbh8sfmZZonu5QnMcX4ZbNqPFLHYWUV3Zz
	 vLGrkLqmCu1Qgxm2CtvVQbhOcESgKsDk+KTetwg6YK+e9y8/VZaDI8qE5zktLVerS49rM
	 4nChrVWm0DJAtWkHe32w+JwUaPmz8irz/wBtbFQCYdxwyTRsrrhXptzp7a7Oyq3l+8+9C
	 PbkfbE2Na2LESIvBLsb3dEtdYVNk9rbsRCby1Kbd5JjFW23aWbPxNbjKvIsmJbKmB6BJ5
	 6j7v+cZowxxPXUCT6nd52J5W1z/ruuc+C+kDq6jql1Jc6zQQ3Vwukz32sJsE+gjhjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mr8GBc5N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGkp2Hgu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D3606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA7D3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mr8GBc5N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGkp2Hgu
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdwld1921733
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/CxXgblb1WraVgSV86I4Vysb
	zdPhIpd24MIpyC6IrWA=; b=Mr8GBc5Nvz13YHEJS/SNjAEMNAZe4ggH45/KfNPi
	WIiZN+rwSxJBJ2WGukpie89sCuDtGdfba8u14PJBDbfKjvOhgM0+UpZsqrtUvZOj
	iAb/URiegWg7+7GZdMaGj8oN0qdrkvPS0ap5ATWbjGt7/oB21aRCxX0MnVY98Ewz
	KVYXjh56IM5fxCxfmrj3N5oKz9qOlRM7DKOvHBnxWYkvyq2vI6pbcYTXwoKk5wGs
	YLpHgWoiinnFcuJC8/DpOAvcfc+NCDhAVYp3MkKMPi2PzrBh0Fp8vjYdgO6Fv5pq
	u1/yV3D3qxJIX/ZW+Ci23ASQ0Jlfo+pWmnHwM+tDdJdvAg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq68jck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:11:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1e62510cso980013885a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793099460; x=1793704260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
        b=kGkp2HgubaX5SSpSOjL087ODbb1i8VjnarPjBsiqxYpto9LiKyABRoz/Rkr4TvdrNj
         JqzW3GkrKgrvG07mtlwfFsxhUN3hhA0UH6bWvi25/fT+h+qClkAzL8VIKKNpTlfjPIjd
         6EUvzVs0I2YYwniqn2W+k6B80VDAfSpDK9FWf06JmMmFlhmAs5pcfOmT1KWY3MjfBUFl
         uF72ozKrqKtEY0+udJ2ym5OrDGjIHBvzVflW+V9MCdmgxAMsJwpWOv9Bw71d2O5ouPdb
         cFqWfeAuzwHE8dLlnDJzBxzp1WFOjqSpsrmkEZH8mCgEZSl0c3rZWxXEIDmrGRTqaxJD
         /hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099460; x=1793704260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
        b=CLuj+UqUKnhRz92l5RLxoXh8bdHZcwHy9jMpLGpoPX7dMKPer81ygHPtYgZSfK8elQ
         25AAARhgD7iOtaI11ArSIEG66AoqlnszELE2ZPVUbnZH7Eq//24hF0r8xLdQwyCTyQ/N
         6ebSk8ahKWVs0y10VdBXT37k3rp4OaY+mHK81lQDRx1mK/g1NYQgbyysGz4IzO9qohzW
         fxpYViOVDLhQfpj1d8EvGcQd/vYxCTX0wqlwtuAtM4sVNIHBfMT4ldadvlpFWUkMwwYB
         +3TFGTLqY94C5MxZFiNiox/nbyem/yoKX6d6ycU1SfoKgeTpn9WHKmp/qacJHofJDdaM
         ImKw==
X-Forwarded-Encrypted: i=1; AKwUvByQAnWaSSYayUqGBkSQejGHCLUH7C57mgdgavH+0s0c/00PA5eO6Tcuu6u+zSZrPLbk9K4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD6PYViW5sQJJwQOsuymgSUxw/bwP9HOsWvnKpFT/Icz2pec6B
	X7eltK7O8MIzzYuwDP7rqMvyMuhC4/dDQeQhO84fnq0d3TpXAUkBxmJVDY9SRxV26gZb2MHSszf
	i0dVBu43R8vbRvJOn2nSWTo8Uiv6/UhLVJ2moLLeOz7upCHYRsU/9GNs=
X-Gm-Gg: AYBFou2GCgm71Nw7EQYGzAcgLac6fuos3VmnHYCIOf0k7VpRLDUe7e+iZiplv+wKdjl
	cxTLQiM3UgHNhFCf/IXoXgpSdCQYhww3Xs9odDHv+dVAJI+QAt2f/rQLjMiursCe/MEFeq5KRCq
	6kRmIVo2L5of+CiDZh4EOqKvruiO1xP1whr36caKJ6pkPqa78SdMNdBBRNEYoUROD5JogGFS92h
	nfEDqWBr4/ksIRx3csG3kJNJ7AeMvRcp5BPATkElGfF3KL+TRuV36NLuSKP8DgEL1yjRcbTx3x3
	wMA0+A4nSZevprOcDLHUOQuTpVquWJMxDywTdTcZa+1t8J3uKu00akMVPZIjHXzxlSCns7425V9
	JyzuDh2ww1DbchovSpBFZbV/cCpoNd8PVXtTxlibqG4B8jTa/
X-Received: by 2002:a05:620a:4482:b0:93e:c12c:9b73 with SMTP id af79cd13be357-940ef9dfbfemr1490756685a.78.1793099459557;
        Tue, 27 Oct 2026 04:10:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:93e:c12c:9b73 with SMTP id af79cd13be357-940ef9dfbfemr1490752985a.78.1793099458961;
        Tue, 27 Oct 2026 04:10:58 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm675152295e9.1.2026.10.27.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:10:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:10:57 +0100
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
Subject: Re: [PATCH net 5/6] net: stmmac: fix VLAN tag stripping on short and
 non-linear RX frames
Message-ID: <auCGwWCHK6e9cbxk@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
 <179309225715.3134.11251912403308890296@kernel.org>
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
	protocol="application/pgp-signature"; boundary="cZrf2fHhcABm3x1K"
Content-Disposition: inline
In-Reply-To: <179309225715.3134.11251912403308890296@kernel.org>
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae086c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=kOcqg-R2egU1R50GgGQA:9 a=QEXdDO2ut3YA:10
 a=gJhHHGP7ekgXX11HjIMA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: qwRAAnOL2I1UQB9clpdjfcYw_hMdcF_6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX24AAah0eCZoy
 rDD4cdQzhk8qXP81NJQHsp3JAco5qj2y7u8FqejnCwuBa8OEQLkPWduZPVhlA2nOQFohsql+nGB
 1om3902vL2Uno33N21nQQ3kDTeEZd5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX0+Cjj51rjQ0Z
 O8EbyHccCDMkvz7+QxaFTECTpSDZ3koiAl64Jv3cN5/0yV5FORMkfvyfNgXhc25ICEkfVVeFiXF
 vboUE4KS+9qWc+XgVsgnxh0BEodc/98Okxv42sy60yfQN7L/TFKhWa229KDNQmkaa9iHjTHS/dj
 wj+qHk1f3DilQCZoXrfSqqUhKzPzQucbfAVcRBirjAlZ6m1CYqnvaFsthRU/UF2Ol5bHwwRClPA
 b7yr9B2qhFrMkld7U/Ms8eWw4thereIsSw7XJo3122Vaza462VKIHoGg1jDrvSR3W2FHwXpDYEc
 AN5INDF5+RVvbzrIZB4GFt9+szTusNkt2rEdAobNIMS/kXLEr7Ql3e/912xdnCbnP35RViCmxYR
 QrkXGod0t12vSRvRc5ubsKY98U6Gs/qmcE4+6y8LZPXOVwNn6KVcY6AwMlpH3WnsbQMCZlF2FjU
 QAL34uZhLvgW3gTaDBA==
X-Proofpoint-ORIG-GUID: qwRAAnOL2I1UQB9clpdjfcYw_hMdcF_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270044

--cZrf2fHhcABm3x1K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] In stmmac_rx_vlan()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch adds an=
=E2=80=A6
>=20
> Pre-existing issues:
> - [Medium] Only one of the two stmmac RX paths that call stmmac_rx_vlan()
>   records XDP metadata in the skb.
> - [Medium] The new VLAN-error drop branch in stmmac_dispatch_skb_zc()
>   does a plain `priv->xstats.rx_dropped++` (line 5567).
>=20
> --
>=20
> net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
>=20
> This patch changes stmmac_rx_vlan() so that it pulls ETH_HLEN before
> reading h_vlan_proto, and pulls VLAN_ETH_HLEN before reading the TCI. It
> returns an error so callers can drop frames that claim a VLAN tag but lack
> the full header. It also moves XDP metadata together with the MAC
> addresses when the tag is popped.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 8a2faf50d6957..32b2c5834c340 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(=
struct sk_buff *skb,
> >  	return vlan_features_check(skb, features);
> >  }
> > =20
> > -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> > +static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -	struct vlan_ethhdr *veth =3D skb_vlan_eth_hdr(skb);
> > -	__be16 vlan_proto =3D veth->h_vlan_proto;
> > -	u16 vlanid;
> > +	struct vlan_ethhdr *veth;
> > =20
> > -	if ((vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> > +	if (!pskb_may_pull(skb, ETH_HLEN))
> > +		return -EINVAL;
>=20
> [Severity: Low]
> This pull happens before the h_vlan_proto and dev->features checks. A fra=
me
> shorter than ETH_HLEN is now freed and counted in rx_dropped by both
> stmmac_rx() and stmmac_dispatch_skb_zc(), even with CTAG/STAG RX stripping
> disabled. The hw_vlan_en branch in those callers has no matching check.
>=20
> Is that intended? The commit message says:
>=20
>     untagged frames, including short ones, are left untouched.
>=20
> That holds only for frames between ETH_HLEN and VLAN_ETH_HLEN in length.
>=20
> XDP doesn't seem able to reach this case, because bpf_xdp_adjust_head()
> and bpf_xdp_adjust_tail() both refuse to go below ETH_HLEN. Dropping such
> a runt is also arguably safer than handing it to eth_type_trans().
>=20
> Could the commit message mention that frames shorter than ETH_HLEN are now
> dropped?

ack, I will fix the commit message in v2.

>=20
> > +
> > +	veth =3D skb_vlan_eth_hdr(skb);
> > +	if ((veth->h_vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> >  	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> > -	    (vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> > +	    (veth->h_vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> >  	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> > +		__be16 vlan_proto =3D veth->h_vlan_proto;
> > +		u8 meta_len =3D skb_metadata_len(skb);
> > +		u16 vlanid;
> > +
> >  		/* pop the vlan tag */
> > +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> > +			return -EINVAL;
> > +
> > +		veth =3D skb_vlan_eth_hdr(skb);
> >  		vlanid =3D ntohs(veth->h_vlan_TCI);
> > -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> > +		memmove(skb->data - meta_len + VLAN_HLEN,
> > +			skb->data - meta_len, meta_len + ETH_ALEN * 2);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but skb_metadata_len() can only
> be non-zero for skbs built by stmmac_construct_skb_zc() on the AF_XDP
> zero-copy path:

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> stmmac_construct_skb_zc() {
>     ...
> 	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);
>     ...
> }
>=20
> On the page_pool path, stmmac_rx() calls xdp_prepare_buff() with
> meta_valid set to true, so bpf_xdp_adjust_meta() succeeds there. The
> XDP_PASS skb is then built without recording the metadata length:
>=20
> stmmac_rx() {
>     ...
> 			/* XDP program may adjust header */
> 			head_pad_len =3D ctx.xdp.data - ctx.xdp.data_hard_start;
> 			skb_reserve(skb, head_pad_len);
> 			skb_put(skb, buf1_len);
> 			skb_mark_for_recycle(skb);
>     ...
> }
>=20
> So skb_shinfo(skb)->meta_len stays 0 for these skbs. Doesn't that mean
> metadata written by a non-ZC XDP program is lost before tc BPF can see it?
> It would also mean this memmove only moves metadata for zero-copy skbs.
>=20
> Should stmmac_rx() also call skb_metadata_set() with
> ctx.xdp.data - ctx.xdp.data_meta?
>=20
> This patch's own claim still holds on that path, since meta_len is 0
> there and data_meta cannot end up pointing at the wrong bytes.
>=20
> >  		skb_pull(skb, VLAN_HLEN);
> >  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> >  	}
> > +
> > +	return 0;
> >  }
>=20
> [ ... ]
>=20
> > @@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmma=
c_priv *priv, u32 queue,
> >  	}
> > =20
> >  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> > -	if (priv->hw->hw_vlan_en)
> > +	if (priv->hw->hw_vlan_en) {
> >  		/* MAC level stripping. */
> >  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> > -	else
> > -		/* Driver level stripping. */
> > -		stmmac_rx_vlan(priv->dev, skb);
> > +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> > +		dev_kfree_skb_any(skb);
> > +		priv->xstats.rx_dropped++;
>=20
> [Severity: Medium]
> This is a pre-existing issue, but priv->xstats.rx_dropped is one
> device-wide unsigned long in struct stmmac_extra_stats. Every channel's
> NAPI poll updates it with a plain read-modify-write:

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_dispatch_skb_zc()
>     priv->xstats.rx_dropped++;
>=20
> stmmac_rx_zc() and stmmac_rx()
>     priv->xstats.rx_dropped +=3D rx_dropped;
>=20
> stmmac_napi_add() registers a separate rx_napi/rxtx_napi for each channel,
> so these polls can run at the same time on different CPUs. No lock, atomic
> or u64_stats_sync protects the counter.
>=20
> Can drop increments be lost this way? stmmac_get_stats64() also reads the
> field without READ_ONCE().
>=20
> This patch only adds one more site that follows the existing pattern.
>=20
> > +		return;
> > +	}
> > +
> >  	skb->protocol =3D eth_type_trans(skb, priv->dev);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--cZrf2fHhcABm3x1K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCGwQAKCRA6cBh0uS2t
rNS8AP9vDBU1B16g84NKTu+DGkJz4a9j4jXoPXayJlU+Ccd4hwD/UxCB1EnTG7St
rJuvmD5GPjc+BNjLxoEiuLLIwhYbjQg=
=511R
-----END PGP SIGNATURE-----

--cZrf2fHhcABm3x1K--
