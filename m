Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511098;
	b=r48eeeZszubbVk4hAkWU0MACO2hlBZM3a0Ya3wpDr9Y+oFMUNESUx69oLwMwuoMnUFQg
	 gYD7KrSYqV06CsnOSmcveOaBk52sawpcLlDitJ3Ht8/VZz/TwFURAyOF8SdRneAtCItR5
	 sMmjOUqyjEyOR4z/tw02zMQydOdvviLM7I0rxWboeZw4Xnfn7uX9lV4QJmbToURKuEr1z
	 r7Fl5ZuKBeFqf2VmoV9zXPLRBnQsO2G002GKJ2g9Mu7scUggMx1tEdCKtsRJk59fxiwRV
	 dkJGF7KV6cGPTT9UmUxQQo/NNmXTz0gvKmU3oF0luUTml5IBp+MOhxwbM4WCVJSAbMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511098;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xhoLzvSdgCRdRzB82i9PymJ0nI+RzUMdCmK32Pdr6Ho=;
	b=4egG/y4NzktYcMFMbfP6kPCZzrRhHndXQ5k+0kL+Yv7w4ZwSFwxlfbsY/Ca4U/VQ/wqM
	 h4l/g7pxBxu+V2L35byGv4egtEW2NjRke6hColZYYFc8tlt10LaoukIEryTbBO8WmeUco
	 Nx+rXWwMJ2GWeKRKc6vYwW4hbaEx3aWJYdo9/p5PUcneTyr25FL9CUzAx7cnE4XoSGJPe
	 vqpuDsTRb4ON3tB1hE69cw5GS6HimGuEbqRyrtVjf4ukxlo3M6hpY7tYcidDON0gRMpU0
	 QA+WiE2+66CtUT3wKZtG45626s036FWfNdPP8zqTALwBHibAw9mcgbaV6HL5184yjaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2OPOlRv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXyrUN9q;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12F606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F12F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2OPOlRv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXyrUN9q
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8G5b5196999
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xhoLzvSdgCRdRzB82i9PymJ0
	nI+RzUMdCmK32Pdr6Ho=; b=d2OPOlRvfISVk7J6Wumi6zrZaA3PIkLQKXZwGaUG
	MbxzPORarotTEVHKI9q/7zAQVuy5UMOPIvtI+osYwYXhzTrVn9Qj90ZXvDahgTk5
	UVdXwPMaIIq3kn+rdE+38PUCNI0WevjLptazGn7FaT0YaKhVQ0WdJxeQngjAumu0
	N4Kd2PRVleyW8wZ6EoGhdR+A3tyY/PJpXB37FXia0ReP+c0cqoHjIaOM0sVL1y6U
	osuJce3d/MvXnISyo7klEX6dU1CIF1KATAgyaoQrn+c4yi4AMh6xnHppnx2ZPh/J
	f/Ini72giDWQDVsJC79jVr9GeusNXELzoUPG6GONTbzUNA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukrasxs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:04:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9496ff065bcso589958785a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 01:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795511097; x=1796115897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhoLzvSdgCRdRzB82i9PymJ0nI+RzUMdCmK32Pdr6Ho=;
        b=LXyrUN9qIWLMxWIKJD1j5aWF3NoShxjbuUIH5Vh+Y3gGbDkcxBbpJwxArboT9w/nyD
         pmmV7zkDl54IeRiYg5U2CWPIkSmrQbTNlg+O1KW9btNsl1rfzQudXtD5Hojc0A5R3R0p
         qdWmVu2IiVpuQMjrzqahbYgiIy98Ns7Sb/YAuCKEZZ1rxGQp/X0zwj8HsDNX16MLCK3H
         BBVvdwKH8Ehh+Z3u6edI/g2m+p/MYUFoCJ1ILfA5WgVDUozTj6HtrO3jUBYlp0yIpChr
         7O/mHfQb9X5DVvnS1xY126W1EBhq+weulyIpa+Sjk0uljgJq+7nr71YOAkB01PprjO4/
         UGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511097; x=1796115897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhoLzvSdgCRdRzB82i9PymJ0nI+RzUMdCmK32Pdr6Ho=;
        b=PcHvTSo0E5G8Oj0VAMztbwndSO73MjsXnhHW/795wk8gdpzd09C42yEbGayQjTUo1W
         pxraKbDXVCMwhhY8g77oMOFUo9z+PRctJZ7Xaz5k1gvuIwbDXpZSXLNF4ROtZvbYjOCq
         quB9LcT06Mo20xnxCGwc4AxOvt9XtYS5Cjyws2xqHm9EEvqM1ATIslE7N4Le17tqo4eo
         2dCpw+OYVdtFsJdpTQuTk5Wnrc2vW48XDJzyKp83jU7WwrPSl6c5md5squdDp1PZRG1k
         VjYU8+zvEBJwauX3fKosRZADtfNqIdw+KDiWODheqpkO+nV84gTzFjXnT69aigaK6GjG
         hGrQ==
X-Forwarded-Encrypted: i=1; AL+hErHDYZch/GcK3xyP8VzY+SD8mRupU5daR1LotobndImI7bG9FuXCBz7WezkyZ8Uo/74Mrg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xFwSXA2tzOJxUDm8k9jYk4FUuy4gIIVbMBofMFkIa7A4szdaO
	vRpYafN9cl0Bv0sFUZ9OghkcoGihAAlqtkbA46GKMGQDgyhu5WFx1dl6k5qrMOwhh5GCjG4EIJ3
	1zbD82thX+2O4RlSFvcQx4FUn5KupGHYkUwI+pWtujcZBC1QeBx81s1M=
X-Gm-Gg: AZFdTZeKvoXC3I9+LkcAo9j8j8cIwQvzcQ+V/HuWo9N26KyPB0+1MOFk8Ebb9GMCEt7
	FUc+O3wr+NzeY2DXbOD1nl0c4VtAnAU23DQx+00i5dE/0wByQAlLF28eMnqg0S3xB9KWRs2qom4
	+wmYuFBzAnkfhC0apIMN3ZAq1YRaWJBeqNYBImu7h411WA/gNnI4T+lHS+iGvoBt6PnKl4BUknP
	MdgYe+q00ui8XSMYnRIH13kzDK7BlA8OlvYE3q5XDY9BI82QlGM4X6IJdG0oM+exHPL3U58r5/N
	oOQxw8En9Pl/MJNhcafVpV2FswHQicMKiwF6nMe/c50msymKR9jp/eBnRq2PqW++ULFd06hQc7p
	PVDM6WsAuWr5npgYsg69bMYjJzsNE9dJ7mcCcJF41dVl0GWkw+QoWBLyeCBIsPt8=
X-Received: by 2002:a05:620a:6c18:b0:949:6841:2ba2 with SMTP id af79cd13be357-949ba96e544mr2446120885a.22.1795511096530;
        Tue, 24 Nov 2026 01:04:56 -0800 (PST)
X-Received: by 2002:a05:620a:6c18:b0:949:6841:2ba2 with SMTP id af79cd13be357-949ba96e544mr2446115485a.22.1795511095866;
        Tue, 24 Nov 2026 01:04:55 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm180427535e9.4.2026.11.24.01.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:04:54 -0800 (PST)
Date: Tue, 24 Nov 2026 10:04:53 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, peilinhe2020@163.com,
        Peilin He <he.peilin@zte.com.cn>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v12 1/4] net: xdp: add
 __xdp_build_skb_from_buff() helper
Message-ID: <awVTNSYCD-_5gE4D@lore-desk>
References: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
 <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
 <9997f4e9-9453-4511-af3e-4be664a09281@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="4rmTEbZeDTuovlI+"
Content-Disposition: inline
In-Reply-To: <9997f4e9-9453-4511-af3e-4be664a09281@bootlin.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX0xCaQ0BFK/Sw
 7m+9YZCutM3/74qK+aGq6mJ/8YQDH+FRqEDP6k7j2vgidYnilY1XdpvuRCe1j22oB+niPkc1sFN
 zly8MxlTKSFB1JsRm5S9ePYnRC/5ihE=
X-Proofpoint-ORIG-GUID: hyPR4OfmR6Y_wIj3OvG-sN3o3zO9VRvE
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b055339 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=wBYCl_nSamdfdyxXmbgA:9 a=CjuIK1q_8ugA:10
 a=NyyH46NNO2n4llnjC44A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX8CDgsTvmeSV+
 /BDnev36mjBUlTQ4K6jJgAGAVOsUcLYoXf3M9fOgzXWqB/AoWB10lmNND/aYRTH5QrPDeewVbyr
 17GkWB0OTAATeaXZH0Ujch9DqDor0vVMscsDzn7nuAVL4q+Ot7FPbT9eWQHrcLbOdoe7pHu8NVo
 w3MscN0J6VzmBRMk3O7vFUM2un4pxedtHlq5ieScW+VYoh7CBXn9Pwmr1nBUzlKmYT2ano9NaXx
 /HRHK4w/Qc4RZZB0m7wlsiiaxoUVQdvVLMoQFChedTTh+glsNO38DMwJUpee6pVLjst7HKnhkWe
 QscJb3WmmJL59zdNw8LQ2pLCqKYnMLnBKg+SVdRfYGwRSX8TXiiTZpsN+mDPZk4lJk9QcAH1zHt
 mZmyhZrZmi1FoO0wd137V6RV/ichVWT2qCq+U/X8OE8oEN66z5+bpgic+9WrjVTnWFKv/+UFtch
 EcED4C8khRLHau/Davg==
X-Proofpoint-GUID: hyPR4OfmR6Y_wIj3OvG-sN3o3zO9VRvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034

--4rmTEbZeDTuovlI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On 11/21/26 18:28, Lorenzo Bianconi wrote:
> > xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
> > builds, which pulls the Ethernet header and advances skb->data. Drivers
> > that still need to process the L2 header before protocol parsing
> > therefore cannot use the helper.
> >=20
> > stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
> > the VLAN tag at skb->data and shifts the MAC addresses over it, so it h=
as
> > to run before eth_type_trans().
> >=20
> > Split the implementation into __xdp_build_skb_from_buff(), which builds
> > the skb (including the recycle mark, the Rx queue index and the frags
> > info) but leaves skb->dev, skb->protocol, skb->pkt_type and the mac
> > header unset, so the caller must initialize them, usually by calling
> > eth_type_trans(). Make xdp_build_skb_from_buff() a static inline wrapper
> > that still calls eth_type_trans() as before, preserving the behavior of
> > existing in-tree users. A follow-up patch will let stmmac use it.
>=20
> I've been questionning why we even do that in stmmac in the first place
> actually. This pretends to offload, but it's just to deal with the tag
> in the driver instead of later down the road.
>=20
> The original idea was for GRO back when it didn't handle vlan tags, but
> this isn't necessary anymore.
>=20
> There was a series in-flight to remove stmmac_rx_vlan altogether, but it
> seems to have stalled [1]:
>=20
> [1]: https://lore.kernel.org/all/20260914150612.9798-3-peilinhe2020@163.c=
om/
>=20
> Peilin He, do you have any plans to continue this ? If not, it may be good
> to pick this up instead of working around this.

I am fine to rebase my series on top of that one or pick the required patch.

Regards,
Lorenzo

>=20
> Maxime
>=20

--4rmTEbZeDTuovlI+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawVTNQAKCRA6cBh0uS2t
rHPZAQCKAGP+HxkZclzwJBS529Ya17YdjUFEqrcVdO8FnqTQYAD/WTWY/zFW4UQM
meWv9CThxP6DrZ3uuHCcz2TqrxwnlwE=
=40vj
-----END PGP SIGNATURE-----

--4rmTEbZeDTuovlI+--
