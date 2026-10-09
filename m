Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2B4A2A48
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541816; cv=none; b=s7OjAR6As4Qk0nScpADcNBHE4HOhBjGzMSqOprZmXxQftzKUy0B6DHplVm2HZiz7gFc2Muz5YR0+crmzZIE5qIKJmGoAYKMydfCNKC5zUQ9PR2GyF75Me3EOJHqtFrwiygKDl5RKpi4J28MaOmY0TfQ86u9XbxnSUiOSWysC1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541816; c=relaxed/simple;
	bh=1lXUr4WIy2+N71VuzaN+tojkq98xBegTiKarMt8wm8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqd+E0YVA0PkvMxGrFsoD1yxX2Zsr/whwS3jeWrMJ1zQoWDj5MnopUaQjkYghPYq575sDI5mAlNUTENrxYA0VaOPKfmVxtQ2zVpHsYe0pMSdMOP4B1igTZc1zjcFCJVHOw7qgsbBrkOope21BMOZxk1obO76j784iKENYpAY8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7AUX2to; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sj7e2hdn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7AUX2to";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sj7e2hdn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KN501223232
	for <bpf@vger.kernel.org>; Fri, 9 Oct 2026 10:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NgcRvQ8TaWMkNOqOe2pfYdXq
	Lm8BXmdUD+Z1gEAZJbs=; b=a7AUX2togmSo52xyBK+4RlrWQzV2B2+VWqeCb6Gi
	FWz3p69gFWF2psgrpUKCzkand4b9LRPtXvDHUHsyFMVW+2zecGgsDBnaPG+D9a53
	VjHvkFaJfQFJzBh7bju+56GWvTsmn1LvxzSzN+u09OHaFM+c0YnspQvgs9iCM5Wn
	kHW38v06aVaCg6N1hKt3fdy49q6VH7372T222fge3lm8KbWO95k0PDSgsKTnvInB
	GNnT0CzzIAuPJtwO+HQoyXGxUujyek3AdZOAQhivjVPtixaVzbcjvXjBlHGhnVnu
	PKLNoETNARzr96ChMO+hWJByR6N6bk+Wj9OXNvWQvcphJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkb27f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:30:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338ff2cf14so121660961cf.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541813; x=1792146613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgcRvQ8TaWMkNOqOe2pfYdXqLm8BXmdUD+Z1gEAZJbs=;
        b=Sj7e2hdnt8AN2xgryJkulKzVnxodJX7VtjpaZ3i8ddvz/eGzY/Sop6A9lD7wUJkuXJ
         mNWr8EjZ2GqWHT3ZJuRRKHc0+OPrNo0/mNfT3ViY/Huy+ZoaY9Dbka6bZTtpeO1b/l9g
         ljp9Z9KUZSdW/6TstujY6Iztip9QonpEH7JI6hirpKGXMREZFG2Xy8ktSErN0AkMJa5S
         Tlq2IZzIvobQC1vEJWU0cJAgboahiGdm4y1lSqWTPwTl3zPfdPzeeVuoVe+sJqRKi2il
         EWzblp72NJ1DY/oh0C/kXtL2ryED2tSUwqGJHgBYhdep6vmIkzXe2OGxRdAUhR/RPuW0
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541814; x=1792146614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgcRvQ8TaWMkNOqOe2pfYdXqLm8BXmdUD+Z1gEAZJbs=;
        b=aL9DHhe+i50qCC92f9796dHQhM+XN9WXccptCu9SU/HkvrOXxDxFi+19JgJUpfCRtI
         QvfE3QUm3yB530zOTid1opj041XSTMPwvVue4NpBYDA9za0coUikVhqxVH17XtZpObiR
         +Yovs0R2e8MxQvxPcOPQ5V75W82UxI0aCF3IL1HvTVUODpmh7VwDeWpKzlNdGwxMDov7
         v2B1Ab9yeA1wTvvx8Y3JR1F5RQeu7vP1tcQ06ogoS59Ahsx3TYEWzmiFgGPdMNP7fWzT
         rGyG3eltKKw61VgACUZ6dz5NPOzqq+rRIrHDKzZybWCdb1xolahPx4oREY487RpfYfs5
         +Dag==
X-Forwarded-Encrypted: i=1; AKwUvBwqJGztEdW7p6VIUX8qxy+VXnDFaz56hZvkqna55xWiH7yu2FODwsFnM6W/hSDdLB4fYlM=@vger.kernel.org
X-Gm-Message-State: AFuF++lxbVd/aLZ7LZJU+ziAo0/Qt2jVO9nPyb5LkpZziUtWYkPzjwS0
	XR+EwthzZcpF2MdNJhjKoa20CeqfwqJePjotS0Aj2Rbj7riHgjF7bu1izlGzmHPyE4GbEyeq9tz
	cfC0piRXuWK3ZiF05Njjy/aNuQXUsAAB2POrPcOXEfBDloYwdKYrnSr8=
X-Gm-Gg: AYBFou3MM7OpnH4vGqkZ4YuyH97FHvzteDAkMjxQjTvIxuhK9ihNXOFeMR7FiDsFVkE
	5myfXCUThQgh+Cv9NdqXxbKtg5Tq5+PY7xANTwrrNMQzYJeVAX2f3QhQfliVXh9xYYzsHRVhyZr
	dOttjP32BfG92xEzpIZKCZWbnarFqyjW58PERwUe8nBFQXqSOjAFxCRelxlCqdO1Z2kItesZnO8
	CISYdw1NQHa4QI+d6LXyv+Mr+yvUE3KSPqU7+y6UlkXzqlJ+3a5uPpAIlrZWo8PnX6Ke17NOeUC
	R7rj+MaVqJOkfD7048Rcl8JnsKSTTUY1GqqyZS43w4KDLflWCPtTno8MbMYcoo4APX0/qMNpdxL
	Au8is4REh8+UOjQ==
X-Received: by 2002:a05:620a:8905:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93ebd2ab621mr200231285a.64.1791541813356;
        Fri, 09 Oct 2026 03:30:13 -0700 (PDT)
X-Received: by 2002:a05:620a:8905:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93ebd2ab621mr200224085a.64.1791541812787;
        Fri, 09 Oct 2026 03:30:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18eb4485dsm71173225e9.2.2026.10.09.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:30:10 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:30:10 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asjCMltF_qO8-mIv@lore-desk>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgndA7NxLnWRH+t1"
Content-Disposition: inline
In-Reply-To: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
X-Proofpoint-GUID: Dc9OENQdHflNHT7sGekSIxGtLv-zEA69
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX8TcelQ9gpvUc
 uYQgJFRo4M9Ef2wxxpUVRhU3c5o+nyZ/2M24KUnXdlbtO2s6ZIzycdQCmXYFAQeuklEhQOVsY2s
 gFZNHeduq6oVhTnOnWTiKz0oAdgK/9s=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8c236 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w_4PuGcMj9oXbp2957IA:9 a=CjuIK1q_8ugA:10
 a=iAawtVTI3XspOHW-ZK8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX3JBDfzU+rh7e
 2/Ri05+OWYWrnvAYp2P3o5JVYZctJcg+HdA0tvbkvgMhzwwVNFPQ0MmN0dOi3pPXAmeenITVBvg
 ph9cNHNEFBxIH56hMmnxJCJ2kPTdrwBOaGnNeUEtZ8nQHqxKskQFX1og8ofUZ+dXj32/PLuPFgX
 rIfdPXsrhm78j1Gr8755MRVkrbxxiHbXhTctBv+rYSCH7GBlwsq3FmqCd0iZybkp+MKqjiAvkDW
 ui/a1nAonkcNl+i3HdzNr8eOBzGntMuUpHygXnBuFsp74GuOzLc6eLMO48adTboWq7VS/gsUKCC
 4/0jaMBp1sDr/jCGO0o7SmPDaNEeFU+pgByuwgOoFgRDItt3r+qjr7xb6dw4jEUQWLhd5UqzpAh
 vk6MH27mNuIYpx/0J49sPfeWcaEG6z5u0aY8s9rbZ/HkY4IHpWeQb9mn+xGVI4e6xt8lYGWhefz
 Ea3ZG1HGC1z/JDy/xQg==
X-Proofpoint-ORIG-GUID: Dc9OENQdHflNHT7sGekSIxGtLv-zEA69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090041

--wgndA7NxLnWRH+t1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Rework stmmac_rx() to build the xdp_buff from all the descriptors that ma=
ke
> up a frame, so the XDP program runs on the whole (possibly fragmented)
> packet instead of the first buffer only. Fix possible rx_q state leaks
> when closing/opening the interface.
>=20
> Note that an XDP program still cannot be attached with an MTU larger than
> ETH_DATA_LEN and SPH is disabled while XDP is enabled, so an ordinary
> frame fits in a single buffer. The multi-buffer path is exercised by
> frames that do span several descriptors (for example jumbo frames the MAC
> admits through its jumbo-enable bit) and is groundwork for extending XDP
> to jumbo/SPH; it does not enable XDP jumbo support by itself.

I will fix issues reported by sashiko in v5.

Regards,
Lorenzo

>=20
> ---
> Changes in v4:
> - Reset in_progress flag when the packet is fully consumed.
> - Advetise NETDEV_XDP_ACT_RX_SG capability.
> - Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa17=
1af9ec@oss.qualcomm.com
>=20
> Changes in v3:
> - Return secondary page in case of error.
> - Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
> - Add patch 'net: stmmac: take ownership of saved RX state at poll
>   entry' from James.
> - Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e=
1ff306@oss.qualcomm.com
>=20
> Changes in v2:
> - Rely on xdp_buff_add_frag() to create xdp fragments
> - Fix bugs in rx_q state recording
> - Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
> - Cosmetics
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517=
d404af@oss.qualcomm.com
>=20
> ---
> James Hilliard (1):
>       net: stmmac: take ownership of saved RX state at poll entry
>=20
> Lorenzo Bianconi (1):
>       net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 390 ++++++++++++++--=
------
>  2 files changed, 250 insertions(+), 143 deletions(-)
> ---
> base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
> change-id: 20260918-stmmac-rx-mb-16469a2714ea
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--wgndA7NxLnWRH+t1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasjCMgAKCRA6cBh0uS2t
rG50AQCJYxpyUnrWTKBC3SmBXC/JWh1W3xsif267HbbxwknqiAD9HAjk7mvQ9cxN
BvH8j35NkTDGkCOs7eHeKweP/asd7As=
=5yYK
-----END PGP SIGNATURE-----

--wgndA7NxLnWRH+t1--
