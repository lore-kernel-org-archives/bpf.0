Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF046440A34
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147520; cv=none; b=uWUxHwdH4AUB37LK9HA0NWoAiIaCNEZn1ki9bKM4qkyys6cuR9rn6Ag3WteSe0dEvUeMQDA1G1tLJPe28b9NVS45TFcPzBXtI1bQAjXmKqRGdR47ioi0YtMVQ8QKjl9E0OeApg/V9gY3FyX3ILorKZ4JMQ7J6n2dylO5P1+3P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147520; c=relaxed/simple;
	bh=qO8NqbHssvyvKxNXSQHKf+ZV3+fXThxLtxoinfAMzXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY0cEraWV6agi+PBepmg+8onuPoK9RChEmMD4FrstB9v75WWRhxJPUieliOS98ALeatfNpiKNZcOrkd0p2W4Ak9v9JZBeLJ/9eLj7daYssXXx3pxudqC2PiqXYiTpMWr1kbSO791thb8QyHiqRhOnFWILwtEWUD+TST9+FNYqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fu+58mCm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HoufMJQh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fu+58mCm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HoufMJQh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79UNJ2562687
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 07:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4L7SwgTZYrU2uezs9VS8q650
	pkDvZJeXPq9cVPhYSHQ=; b=fu+58mCmTd2HqKq/5PDEcey26N4YxLaFzyNRYZf0
	uQEZI9CMHSYj5DFxnqns7q1xRIYzSgjPj5xladloCPBmpITa0d7OlGVY039iKvv7
	CtPCEloXulDcHVTOgFtnAyhnKJ5fd6gqBObskeCTbIFnMsTEIGo0MrOyBWY9G9u9
	nn+xHDlavS3QL1V3qqXHymzz/xpL3OK/VhhhfXn3TQ8cBDy8udJo6bjijZG5fllZ
	HFGRvpvqdCKKBf08YLLDZTACwcrhKoI5w3S4xEN4LOKnomUFWYT+DjwaOjDSibwg
	7VqgLRmKjmnLIWIeX806AxWQ3WSIPgLfhuhvs7UbprgnYQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qsh66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 07:11:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939f925ba4eso135887185a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790147517; x=1790752317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4L7SwgTZYrU2uezs9VS8q650pkDvZJeXPq9cVPhYSHQ=;
        b=HoufMJQh9iHM+9HAzmZRLaG7JkpD+eM3AuTsn9jrE6282RJxEkplWRev2JrI0IxOdw
         kpaxDKXxIkHlDH52wtzbjXX9LawVVXds7EFw75x+ev0teyRr0VZ44td9GlwJUwyxjcNt
         PlQL59HT4ygwR0mq0FD1j4zOwkbd1t2eVBGtAcBDrs4p+KhmrdYTyXD5Xjk0W96T1bZR
         ORv5gHubryb95Bjzdc4HLZ404/PGs6bH1Z+MmL6JxxMwR6oqUFt3aHaz/nQZNO6dcgJf
         MSWQW/3kzTAhIke8/Y0FlpSleGMXIcO3jXUZnBpgEWG4AcWXtHB+fPPuM47MK6636N2M
         oXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147517; x=1790752317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4L7SwgTZYrU2uezs9VS8q650pkDvZJeXPq9cVPhYSHQ=;
        b=aKTzhoDJYL+QG8boz/12NnUtCZbeNCM6iQeff2KCtQISsrgei8uCw3X39nJvxab1tz
         rNUkjJqzK3i14nmpZ4zjcjAPwIQNWuEBl+c6/abRnqt/in1RdSgeFpslrcfzory1qBmS
         zw4N8gft8HiIbDxMZ8Xcyi0+jXpD5VzhVI8YID17rrZo5ftmSaNxOvEfAyggvL87Spll
         guKf3IQp1UbmyjxQ/Ny4eFPECZI6VWpDecuYRKVz+EQZig5JE877gw54ruywQ443koTH
         vLznDH0zRWj7btDogrOr1FwV0H6aw5zLG5jI0ByLeANtk84MGtwGDwMckJljd/AxhiAz
         9ymg==
X-Gm-Message-State: AFuF++mLpUyzTbpKkeHbOJfXYJhG9ZeOxYrejEK9mbAyQngnjosvoeBN
	tom+NNh4x/CTlbZa5ogaFk7WjQPLT6dBc30h4hqjKfFb7izdMrj3f+5OTumK5Il9XJgssmpCnCW
	bU3+Y8cIwABMo1ol7HxivHyQSoney6WoWzGp9ffJXjofJnpWMu2oyP/A=
X-Gm-Gg: AYBFou3Wgg6gvvHy5CSXG5Qg9VoCoPorDIp2XfeQXaVY/79QC2UuyvS4UM5QO6/fzVZ
	SmbxxYnCYiuNxX7L0cTmWHdCXaLsBluMvTbgMn4NMWJL7rk6w2NhhpAF5AmSzb5YaH19bH6E5gh
	989Q0XYFihNRebVaSfq72HqpT/k4BI5Nm0eGAb2x/LiIOJ9BsaPyH97K95XRFoOl4NxvDFpd1QB
	Sn6jQxaM9NjnFmIm87BjgYv9+YlAci7r+/bAmB3b5FVoNBM+koy7tlzIPaM4GEyAScG/hP+Xv3B
	ecKaIgYIb7ciQ5mjopcShWsUIKhGGXQfCLS65TwlNgG7Ju+fAfWcylOkFY2lIxLYSCTo1NSNjAc
	E8OI++eXvzaftcw==
X-Received: by 2002:a05:620a:d8c:b0:937:1097:feb8 with SMTP id af79cd13be357-93c2511c4edmr299667585a.24.1790147516956;
        Wed, 23 Sep 2026 00:11:56 -0700 (PDT)
X-Received: by 2002:a05:620a:d8c:b0:937:1097:feb8 with SMTP id af79cd13be357-93c2511c4edmr299663985a.24.1790147516395;
        Wed, 23 Sep 2026 00:11:56 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1d978fsm49131775e9.9.2026.09.23.00.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:11:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:11:54 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix rx Scatter-Gather support
Message-ID: <arN7uiRGaQmO0eCk@lore-desk>
References: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
 <20260922144844.B10D51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1TNf89TMGOGdcDOT"
Content-Disposition: inline
In-Reply-To: <20260922144844.B10D51F00898@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab37bbd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=fb3CDrQzkRIv9xq4yYUA:9 a=wPNLvfGTeEIA:10
 a=QUrq7jf_cUBQkAu679UA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: x5r3Hq0pZT8rOkjIfGCqn0jCOquoEs_w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyOCBTYWx0ZWRfX3+0J8Mu2beyW
 anJnyYbpST2z4l9ea53h64srMofS13x/8y2HGJdBdg30WaWaZajHH6B5lBUnFWBzgOYPNe3YJJV
 cvwUt2GQUhWiGM6uiNXwWZ0vhq+dNcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyOCBTYWx0ZWRfX/Ctj02+IvAIJ
 MYv6Gbi5lW79PpM04LDLsqOGjuxY0fkApxTq2N3Yxe7UyVzgtZqOL/5O1x/wSwzWE6+kMUgGIos
 Qfhxa/ELm87Jl31NStdCAEKwV7pxSbvr9kaPBfn8B2evwL8aaeQaQhw0r09VuSmOuJelQKIio+f
 9NVK70LNxwh//WT00TkbXZuSzUmvaTMXWHszgfKB5TImi7p7UhCpE9naMvjpEAUfwa4hrlrp2zc
 QYRQx/DGZTWZDIUUmxL5/HKePvmIb0tRRfDBWohB9S4evNBzWIzmaS/RRX7zlEJVUn6Ha2I/X42
 08bEUFlTZenqi5Fx2zX4inaSYgA5QFp9F9XloOxRjkLGLLQ5rVon500ufhVIMk1fudO3I/rfDxv
 FI/+1QXG9C6N85AO4p5K3xcPV9XBzLpTcpvbjxNe0Yf2BU4USvx86Yy7h94qy8mvfID4e9anfw1
 Mpo2fGz5+BdcciGfijA==
X-Proofpoint-ORIG-GUID: x5r3Hq0pZT8rOkjIfGCqn0jCOquoEs_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230028

--1TNf89TMGOGdcDOT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] stmmac: FCS stripping check corrupts payload on legacy cores
> - [High] net: stmmac: skb_trim() on non-linear SKB triggers WARN_ON and f=
ails
> --
>=20
> commit a400f52631710a5add56c0a39b6ab0128eae6a53
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: stmmac: fix rx Scatter-Gather support
>=20
> This commit addresses SMMU translation faults on oversized incoming frame=
s by
> allocating and enabling a secondary RX buffer (buffer2) for non-SPH
> scatter-gather frames on supported cores. Legacy cores keep buffer2 disab=
led,
> and the FCS stripping logic is adjusted to handle both linear and assembl=
ed
> frames correctly.
>=20
> Link: https://lore.kernel.org/r/20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f72=
5f@oss.qualcomm.com
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -5807,24 +5812,31 @@ static int stmmac_rx(struct stmmac_priv *priv, =
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
> > +			/* The XDP program must not see the FCS. This only
> > +			 * applies to a single-buffer frame (buf2_len =3D=3D 0),
> > +			 * where the whole frame and its FCS sit in buffer1;
> > +			 * otherwise the FCS is stripped from the assembled
> > +			 * frame with skb_trim().
> > +			 */
> > +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> > +				buf1_len -=3D ETH_FCS_LEN;
> > +				fcs_stripped =3D true;
> > +			}
>=20
> [Severity: High]
> Does this logic incorrectly strip the payload on legacy cores for
> scatter-gather frames?

I do think this issue can occur since the legacy cores never set rx_not_ls,=
 so
the packet is always contained in a single buffer.

>=20
> On legacy hardware without set_sec_addr support, stmmac_rx_check_buf2_cap=
()
> returns false, meaning buf2_len is always 0. When a multi-descriptor (jum=
bo)
> frame arrives on a legacy core with XDP enabled, the first descriptor ent=
ers
> this if (!skb) block. Since buf2_len is 0, this check evaluates to true,
> improperly subtracting ETH_FCS_LEN (4 bytes) from buf1_len and truncating=
 the
> payload. It also sets fcs_stripped =3D true, which means the actual FCS a=
t the
> end of the frame won't be trimmed later, leaving a corrupted frame.
>=20
> [Severity: Critical]
> This is a pre-existing issue, but can this underflow buf1_len and cause an
> out-of-bounds access in the BPF program?
>=20
> If a multi-descriptor frame is received and the XDP program drops the fir=
st
> fragment, the driver frees the buffer, sets skb =3D NULL, and loops to re=
ad
> the next descriptor via goto read_again. On the final descriptor,
> stmmac_rx_buf2_len() returns 0. Since skb is NULL, the code re-enters this
> if (!skb) block.
>=20
> This check evaluates to true, executing buf1_len -=3D ETH_FCS_LEN. If the=
 final
> fragment only contains 1 to 3 bytes of data, this unsigned subtraction
> underflows to a massive integer. This corrupted length is then passed to
> xdp_prepare_buff(), setting a huge data_end and allowing the BPF program =
to
> read and write out of bounds.

I think the main issue here is stmmac XDP implementation does not properly
support multi-buff. I am currently working on it.

>=20
> [ ... ]
>=20
> > @@ -5924,6 +5936,10 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> > =20
> >  		/* Got entire packet into SKB. Finish it. */
> > =20
> > +		/* Remove FCS if needed */
> > +		if (!fcs_stripped)
> > +			skb_trim(skb, len);
> > +
>=20
> [Severity: High]
> Can this trigger a WARN_ON and fail to strip the FCS for scatter-gather
> frames?
>=20
> For multi-buffer frames, data is appended using skb_add_rx_frag(), which
> creates a non-linear SKB (skb->data_len > 0). However, skb_trim() require=
s a
> linear SKB. Calling it on a non-linear SKB evaluates
> WARN_ON(skb_is_nonlinear(skb)) and returns immediately without modifying =
the
> SKB, leaving the FCS attached.
>=20
> Should this use pskb_trim(skb, len) instead to correctly handle paged SKB=
s?

corret, I will fix it in v3.

Regards,
Lorenzo

>=20
> >  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
> > =20
> >  		if (priv->hw->hw_vlan_en)
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260921-stmmac-rx-s=
g-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com?part=3D1

--1TNf89TMGOGdcDOT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarN7ugAKCRA6cBh0uS2t
rBi0AP9hcsdpac8wgxMDEs+MHETqGtUGE2Hprlajiq3NcqG/qQD+OpZXz68yccaq
RjD45w6SHo7JfADDJWps4No434m5yQs=
=Nfiq
-----END PGP SIGNATURE-----

--1TNf89TMGOGdcDOT--
