Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFE3B38B1
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281350; cv=none; b=HHCJZmkvfmVUBvFSuRAtTupOlXAsubjrEAQMk/ywHlf+i51lWQ8vbpeXa4VkTBkrxsAcUF1zebqZMdb1GMlVOvYlzYA3E6oFU88NIXMmqEPnYv7kZoJOQ88+IGHGGZ3Zo10JgZ1LHAa0F5pc1W1Qwox6G2rRKGVKHq+B8OiOXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281350; c=relaxed/simple;
	bh=WzjAbsCldg59wLuZGHPnNC+rmOuIOCxIb8Xty26BK3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDQR00F4fzF6lnIgFbkcK0mfrjCA31BajjkNYCNPBnsZk6MWejV7h2/71P2I9bKwLpCWQtrAZtb5N+7pe4oQQRq+ecB9o2KWEHwc/vfCR0X44hM5l/B60ZAFYy7iBXHrktgkQq8M42U77XPFBGtySwv277ggLgrZq2sIcDUcAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ri99tvIN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eeRn2Kxh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ri99tvIN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eeRn2Kxh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A5RMJ871579
	for <bpf@vger.kernel.org>; Tue, 6 Oct 2026 10:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P8FAVozE5WvzCd4JZdvKH90k
	hQe7swBvImbAOZ1Mrm0=; b=Ri99tvINWq6C8UEA/OqKbxWLYBE5xUv6ubefmWhG
	scQEbLDsUabsQjcZ34uMyHbxW+qKlRn8JVpKLVIR/BKuTvD3oI0LB0rXWvTfaysk
	DT5iwkFxUY+l/QHSv/0twNMyrwj6Hq+zEEcs8YkJb2q1NXQAA9e4+YclXFqov4yo
	Y6bfq9TVi37O2Gni+0sRP7kSWmtCN8P+ro7dRxAFT55bzelayeFw35sY3qPhy7ZI
	6WinaNzBczDuAR+WoftzwQLhsc+kF9CEX8GxJrqvlm9/8nJB4/rF5WIXJ1YkbDlQ
	ViZBMRY2XTXCOZSh7wzGmYm7/eD3DVf+qP4WXdUvcSoZqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xfbg49p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:09:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so464994885a.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791281346; x=1791886146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P8FAVozE5WvzCd4JZdvKH90khQe7swBvImbAOZ1Mrm0=;
        b=eeRn2KxhYQKFOCYZ56v7u/CG8tnWm1B4a7TZHe8HgauKkyycO4qLX++CM+SqWrTZsO
         uj79nhmIUS/ms6Vi2n/r17PGTuvfI++Cr6dNBs4UiiMmF8wduvINCpPLSdCSvp6k7kEl
         ZeiSlaTmtfwoisqyN2IwJbUz/EaqjM7arncW/u+JqYp3BNLr+IoJy0jZNfUYQypYBkZP
         nwu6eDswSx2W9wx4OQEJjOfZHlnAYw2OeyDNbijEeWChOLWlOLoreM/Nj0ElHe5KreE0
         sqTHhR4LyymiWfO9QorbRuA/hEGZAn7dvpgkt/OAtaFHRFz1C11Gwpg9ZO+IsHlpmpWg
         xDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281346; x=1791886146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P8FAVozE5WvzCd4JZdvKH90khQe7swBvImbAOZ1Mrm0=;
        b=TQU3shrHCl2sMfzGUnuYXMyHsX+jE1kyU9qql9yH64t10Rle5T/J1tgtx595muMiXt
         1fiuAyMRMfnx9hADxDS8c0rqUih1G6FgmJDWpuRPRxESOg68EJYhQhhzwBtkIldlcijL
         imjyLJVE/UbSVoxYzzt5R7kfSLaPi6Z4UYsVBAsE4beJabluz06fR+ygJCaazdR7LJGV
         oT07jYUKEHlimPp0oLHRmrk3il+tile+Tb5+elL2CoD9c/KdZ46CXUf/ged+0fyD1/ik
         sQWhOHc5ym6D0Y5X1aOv5hzyk91TBj6XwIPfgcR1IFWIEYajCI4FMv9zRvxrT3xE471N
         5RKA==
X-Forwarded-Encrypted: i=1; AKwUvBzwOPzk5vQFidjXoSaIpYejnl0cibb9uAkfNd6jmN0CeazVTWFaPC7IV/5Y54pGvJAw4Is=@vger.kernel.org
X-Gm-Message-State: AFuF++mNLYyWSQweUPB/mHbZffvgh83SfcPoxC8MDd7/C9WTxSCL45fj
	Ejjq8Me9/N+Jsn2RfkQ3Lu+OZ74k6K3Bg7Jop5fEaFjirQPYCEr6aODBDh+qUutHJhzRB6TTbMZ
	hUx/hIBq3PCucYJSg8XB67afZWxgCJByJSbSM8HYWgnSbdR7xtOxoNIw=
X-Gm-Gg: AYBFou2q9QVCFmDQbrNI7Qof+/L480dsFnWSGxxxLUDfl0j3ETDdJd8QZZULwFjB7xe
	0bSlD5JCZvI1lvuOS9w6daiehliHxVI+SInGrHVNraEGoACmhcS3y6NqRVPncgkQngtFv8qLjkc
	+vp41o3YN4UyngAA4gAobFgrDap3Ubt2DnMTnnQ0sbsvf8nHG3fJ6vHDgUA5mLncH5SMqeIjfnM
	ZgWYuanlSxafdDGVjcZGMvPHIeK+9mvFP51/jCtCEI+RSzZKFrZa/41lafXdSWBIOMMSCxvNhCA
	ceAAJSDmJahRKZUpC1q2ndT3Pq4FbhVtEwLHvhyMzfiDTYThbcT/RiX64V994J1xoR0UB5/dacV
	ukQTUpQipItpTSg==
X-Received: by 2002:a05:620a:608b:b0:93e:4594:f5ce with SMTP id af79cd13be357-93e8f4d2590mr149448285a.41.1791281346468;
        Tue, 06 Oct 2026 03:09:06 -0700 (PDT)
X-Received: by 2002:a05:620a:608b:b0:93e:4594:f5ce with SMTP id af79cd13be357-93e8f4d2590mr149443085a.41.1791281345932;
        Tue, 06 Oct 2026 03:09:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8f28sm81402955e9.15.2026.10.06.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:09:04 -0700 (PDT)
Date: Tue, 6 Oct 2026 12:09:04 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asTIwPvCldoB6k6M@lore-desk>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
 <179128112868.2231598.3214023601488420681@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iX6v1ENqMiuLe7Dr"
Content-Disposition: inline
In-Reply-To: <179128112868.2231598.3214023601488420681@kernel.org>
X-Authority-Analysis: v=2.4 cv=D8TSufRj c=1 sm=1 tr=0 ts=6ac4c8c3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=t5qijVwJ5qrZhGx_HZYA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: vtTaQZ5FkKFFhfQN3GTdjMKKCAF0Z8gS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX8/oWJgdiPeh1
 OTZ4zWtwCZaCMbETGWec9sHyQNs6Kzs6alDGbfbjAVi2FHS2wq1+GPmCTJMtenQsE7naUNpYeqd
 iXO96LSgYWJAJMOVOPUHOFvU7GrdGy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX1anlQRa6xKma
 9AgAUJ3c3lN2MA6xiVrMIQxlOVLD8tUNdJinrNTpM86Ld0Zt766VHLM7YokhePB5jfpskzkm+n3
 Mj8kd4CRWxNhnGZZK9ea+kEY82MJWjFJiH/ojjLWc0ztip0j2CuF4GrlcYiPl7eQkVEcVCkVWom
 lHmezrB0y1k6BWLJin+A6VfLy5TAa/3w53rajKMCLd3VH5APfpS8GcLszjKKpVvegWZ5NQ+JegQ
 GINipLJeAxJ82y9uXEtD62myCMDzrFv9liBP/czb/R57o31gD6QqpncRI7UllypGrPuL3B0yzzF
 TGT1kAexHja3vGcXcwD4TD9Of8bXZJQ+0W46iGEUUMYyabQm7HkaYHfYB1YGSPzfYEUPrQkmfvk
 Dsi/qKc6llEhOUfT140vBZuAwPIO/4xgqjL1G2daHbzZJDWfcEfEOEfqDYd9jpuyvBaSRE+cjco
 ZSbLDyaCDlg2wQru8sQ==
X-Proofpoint-ORIG-GUID: vtTaQZ5FkKFFhfQN3GTdjMKKCAF0Z8gS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060040

--iX6v1ENqMiuLe7Dr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issue was spotted during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch on a Qualcomm Rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--iX6v1ENqMiuLe7Dr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTIwAAKCRA6cBh0uS2t
rK94AQD1ay0m6XxveCEdXhyNeswr1zCBysXJQMVwAqFY/g0HxAD/f0z+Dv7kiczT
hl+d0FIxP+dRUzNQ35LhC8xB5TtGZAE=
=avE6
-----END PGP SIGNATURE-----

--iX6v1ENqMiuLe7Dr--
