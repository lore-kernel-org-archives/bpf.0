Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D594499A4
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255370; cv=none; b=T+iqsMdM9YSWR5AWPqeqMqP3CAWGvbQ//yuood77hfpJj1n6fM5xjgfduIwTl98NWz7IeR/IcXLwxXVnQU/WKWD54r7AjuRt+9ZtH19TGmu2OA2t/IrGkwHOijTiKLVfPuj5IqebHducUBNqxMbr0dg9NTvJkwPEICsZ999r/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255370; c=relaxed/simple;
	bh=K20z5KdEDNBYJjms9B6M7bbuf2L45raKVNV06fzhODU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY4Q2I0xEeG56yOXisVDshDN+Du+bBEy/oX0WzR02FGG1qlwYcnGeFwTwgRTZGN/fhKz/jm0zy02XEfJ0cMr9pyWqPwsj1S1AW5p9DCOgZjwWy6hZiqzwmBep2L4JZh7IV20bevJ8L0yvpbZ0KoXjXOn26hrl3BHayngZmbGPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2LVtzll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B5JZErDk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2LVtzll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B5JZErDk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4aFr2285586
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KJblM9eQe24SP0aeNv4kejjE
	EyuI+il0QPjmzJ8Cpu4=; b=Z2LVtzllDpynAhqcIKhamXkCC+sXNPYYB1bsNP8C
	QjruEfbcuwmsw7u9uVcTBK1wnqWW+OzW6L12ceCjRfDCje5xV1Bs/B9a9U1WvymB
	tK5LkIR2A16H7fxj1X45tqJuB3XSQ6VTQrvE6tT8Yx9GmE4m1LSHvmWeckXPLJE8
	juf3Cpv3DGFPXIJRRdub1tuJL/pYQSqg4KtMSZzK7o2OfZS9rDL72H/BhV9R1aWA
	RF/DsHQ1UtQoFNof+lJwaXybrnmkrRF7EG7xvaabP2avSPfgg+DkVqubGL8dRxm7
	/7yq4Jz6SOOsH/k5yx+3c6gPhVJq6ZYI6teInCu5dW+wxw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvx8ahrkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:09:25 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78a58df134aso583130137.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790255365; x=1790860165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KJblM9eQe24SP0aeNv4kejjEEyuI+il0QPjmzJ8Cpu4=;
        b=B5JZErDkT4Krj+ImqbZSUsVHBAT/ULycFY6AugEH5FGTjZ1WljgSW7Y59crUeQngTf
         GOTTj0uKW5BULmbix4cmyUHmqnYHgqi8gFZn4zqotsU+pBc8mLe16jmjc0qqcEZsl58g
         GpSROibi4KewEaC1YJ5Ko5ujwQffeCBs3hNNPLksmk9Kz0/QJk0yKFr4DO3l3HGRr0lw
         CENrDo5PVuyoQuTuXXZeBVsox+2+lIZyD0vb1myXhhEFKnZTmlejBnpnbT5Zbmw2IYzd
         aNKxGKyBZNaFep+LozzoduwD1yzqy1OYEGFDwA6ZH0xkw86PomtkPDzo4Ws13WWZebwn
         oDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255365; x=1790860165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJblM9eQe24SP0aeNv4kejjEEyuI+il0QPjmzJ8Cpu4=;
        b=fzwcwVVYbB5SbybZKJehClTzVHfZfUeZBC6zV9AJqDzYMGjMwRna9LftnUtNugLVcZ
         xJqVZMUX6+h7AE5J5hUOmLEJ/+Yz7g9jbUcPBkDSjXLwQR9wx0m51J8I7g1qPZDsLqGH
         AKKPSBS3sNvHZoWDRkvBIhh+FsxOYvhtRf9Xsz/mXwDQ4gJADoujuOCsrRhVI8JtQHvc
         7O5s6mlGibZQA0pkr948w54jTuRWjST/1sYj4bR65nHaPnidfB5shbdocFW3/wqh4zPC
         JYD8WAbI2uepO4CXjaTC9SyojoYtar2cureMLey3x6SpiiXEF359alqbac4HGQXkYhSr
         hC2w==
X-Gm-Message-State: AFuF++mOv9eFaSFIYvfIWRc5ZVGUOSnUBOPGVFj239u9fEsfmeVxHDiO
	wdd++l2cgzSFbQKSz3B6cc3zi4AEb1GdAvvsSR74j8yo2sG+95k/611PcprzlP0rgyyifoqaEys
	7cq+joMJTz5x76WduT/hp6dSxFk8q42yi4zBV3ziNAQ4GjCWAfxjhypE=
X-Gm-Gg: AYBFou39U/z3/tN5jJf1E7J6u01bI62wbc1LB8CxnMnSk068shgSRmrW2EHdO52nPTX
	VHWKFLFRPDhQKKzX/vtXqGBDpxivWCKWPtlunhT+cArR00bfXM9zuri69y/R0f2rOBE96CkmiPL
	4OpddB9zEL8BIRT8Tf+pzjcJbA8DQoRDb3Ee189t6RNYOu8KXnV8bPI/1XZnfS4Pa3kgGJnVJtu
	8xbBC6YWZ4vbK9O2wRngfnwvuU4L45if5fFqRruhaMDXL/2Sbyp2DG8QQ6ejAbOpJf973n2SLBW
	tCBTd8fbNZ+kb448RFSEn2KlKyeyMEwHaqU2/dMXiHIurpRNLEegYGzevUP32cWH5eLYWnu+d7Y
	FCQuyBlDWtXA0Vw==
X-Received: by 2002:a05:6102:809c:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7af1c99c6c7mr1206536137.7.1790255364480;
        Thu, 24 Sep 2026 06:09:24 -0700 (PDT)
X-Received: by 2002:a05:6102:809c:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7af1c99c6c7mr1206513137.7.1790255363640;
        Thu, 24 Sep 2026 06:09:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868779472sm15181766f8f.23.2026.09.24.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:09:22 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:09:22 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
Message-ID: <arUhAnZ_Kw1x_bTr@lore-desk>
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
 <20260924091530.0D9131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kJ0SgG2RFZtc+RiN"
Content-Disposition: inline
In-Reply-To: <20260924091530.0D9131F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX8W7lstB5LD07
 pGcL2TnU33mgvTcP9rkiJeIuAJwYn0ldu/ISFcBEUxi4B7ZFEvFWxDS6V31kJXSSBIMnWuKr9P0
 Y5yYcGHnXoZwJLXJWG6EbHpADedWmQE=
X-Proofpoint-ORIG-GUID: zxKSnPAgXldYTkBK3LCDn7tS2CTjrnCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX1M2mA7LWvsEa
 CFUeOjmOucN/j1bPrHkXvOR6T1uSt2+Be9tx7xfL0RD4sYufnRSJrPGRJKdQR2pQnwNUKpcfMYd
 8JBYUz4CFY2oPDO9eQZigOk3nWFlTr5LyLIB6IwjNt1S8fSw44kxJda23O3/jC9Ek7LQzX+rBx5
 b8remOIqjH/j7DW1Gt1ojgHwoW/JJumHiTB+nLVneHX0G4Dg2Pk6iP8zNR9Mdio6hbOI5tQZrIL
 /aXNXyRE/aKw6TZRh1f0ffV9nIrTt7okb5b64/HLr5Kjk2pVI9XnVLCcLnKLk+qTlM8peKNukYB
 jHYi3Z26l2CR9Ehaxcw3X1ZGdwdJTpf+GVM2ceXVQUTuwJGficLv7VRj5Umhn4gbeLk9BIq0WTd
 7F54nN+LlF4WIZkBHQbZuwqQ9Ami42DVVskaJ54FKd4v/lAMgm45dr/LiicUFmvuO09Xh2Uq0XW
 +DGTxRk85Ig1i1mdCvw==
X-Authority-Analysis: v=2.4 cv=a6SlZkSF c=1 sm=1 tr=0 ts=6ab52105 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-FYCnWXEDJGIweOeXlsA:9 a=wPNLvfGTeEIA:10
 a=Uk23vyCusddH8UGuAsIA:9 a=gYDTvv6II1OnSo0itH1n:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: zxKSnPAgXldYTkBK3LCDn7tS2CTjrnCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240054

--kJ0SgG2RFZtc+RiN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: stmmac: data corruption in multi-descriptor frames with XDP=
 on legacy MACs
> --
>=20
> commit bffa481d7cb386a04b24759408cee45add543fcd
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: stmmac: fix rx Scatter-Gather support
>=20
> This commit enables scatter-gather for non-SPH frames on GMAC4/XGMAC core=
s to
> address an SMMU translation fault on oversized frames overflowing the buf=
fer. It
> also updates FCS trimming to use pskb_trim() on the assembled skb instead=
 of
> subtracting it from individual buffers.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
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
> Does this incorrectly strip the FCS from the first descriptor of a
> multi-descriptor frame on legacy MACs?
>=20
> On legacy MACs, buffer2 is not used, so buf2_len is always 0. When a scat=
tered
> (multi-descriptor) frame is received with XDP enabled, this condition eva=
luates
> to true on the first descriptor.
>=20
> Because there is no check for whether this is the last descriptor
> (!(status & rx_not_ls)), it incorrectly subtracts 4 bytes (ETH_FCS_LEN) f=
rom the
> payload in the first descriptor, corrupting the packet data.
>=20
> Additionally, because fcs_stripped is set to true, the actual FCS at the =
end of
> the frame will not be removed when the final descriptor is processed.

This is a real issue, but it is confined to multi-descriptor frames in XDP =
mode,
which is explicitly unsupported. Within the supported scope (single-buffer =
XDP),
buf2_len =3D=3D 0 on the frame-start descriptor implies a single-buffer fra=
me,
so the FCS strip is correct. The proper fix is to handle multi-buffer frame=
s in XDP
(including FCS placement) as part of XDP multi-buffer support, which will s=
upersede
this logic. XDP-mb support is already posted on the mailing list for review.

Regards,
Lorenzo

>=20
> > +
> >  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
> >  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> >  					 buf->page_offset, buf1_len, true);
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260923-stmmac-rx-s=
g-fix-v3-1-ed26fea7180d@oss.qualcomm.com?part=3D1

--kJ0SgG2RFZtc+RiN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarUhAgAKCRA6cBh0uS2t
rEs7AP91neyBZB2mEyZP1PxNK2PZNPyU86jzGSOqbd5buOwCuAEAk8YTqwSKGDn3
T0dNZ8C674N7jIOSTQABTvFyrzFd+go=
=EEEF
-----END PGP SIGNATURE-----

--kJ0SgG2RFZtc+RiN--
