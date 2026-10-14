Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEC414427
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983542; cv=none; b=GaXdt2RgTcKHHMpWab+vXopEuJpL3b9+VDh6yK/dNiM0wb9r8VexEN8k7RVmSwJSlBUv9fGCHt8lXb+C95WBkL+g1JvIeKO5dba/bM63LVjxjpkjwRFiIp9Tp3MH65GeY5WQhuVZYrbFieGQhMmaI9TGnUkQe2e6srbAcKrSnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983542; c=relaxed/simple;
	bh=rD1oI78/CsMZr9juTjHcrQwwhF4y0ThN6dI77XsFzJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cafXo42tjl36pHb2KKJsR6EXRjFOf4+xQEi52889raF/mQccEiqysKw8u+wrAM7R9vht/JPZMdw8uGzYed4cOkkm4bcIokIigXma6elOXb3iV1NGodrzPy9BQwgxYgGfiQhQhfREynAC1kk5fUnkPzo0l8eQtcImhpyVBr3O54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=du8jH2u/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DPPmAHJd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="du8jH2u/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPPmAHJd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9eBsw3696130
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4Q4tREkVd7vcO1xKvc6nTYP1
	DruPRGr6e3zl/2j3jwk=; b=du8jH2u/dd+oMW82JODINScnacuBtPztJNdXcUI0
	juO//2N2ZZ9lcS+0SZoJz8YfoZxy5bSGx3RwgtWHvljrL0kC0CShR1Kcfm9gqCjM
	JlcKI8Fh0QGcZ9525vAgjI8tQAOChqU5TnXBB36rPST5cBq31dN3Tqz2E9mHmpZ9
	s1vBsocgEN8KV6x63y29d/tcub1ifY5BUrZw+2wl0kPE8k0iVIIslvYKdI1dHBok
	6qVKKmcI4QK3vzIwt79AHLvepEt9a9fTtUAMkjPO6r1aXNE89oz3odcj0DQc5xWg
	DB5IpOA1N88mcpmiFWqb3zVSbB4080RnS97JIKTiy2X6Bg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aegt8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:12:15 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98c660a704aso210558241.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983535; x=1792588335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Q4tREkVd7vcO1xKvc6nTYP1DruPRGr6e3zl/2j3jwk=;
        b=DPPmAHJd5iCnMpbK1WaBc8XOi0Z5BsAwpgPG/M9FviCtNKJM0Xki0rSMW0xYcOmi+w
         1QUj7IiChmAhksKNo56TrhtfGZwuigNr25zZUXHh014SVs0TWr9JfUlr6v1IKu4IQ0tk
         ooXwzEHJ/c9kfOEfGCLkoUiAutQTaQatOrGB6KSX1i5aT01NX4m7r+5fQhpmX16LyDcj
         DA694rcSq7s4yefSQVE/r91m4pydVfcdJb6umOWBcT5MBqyBdLTz5iwnMmjvYdG/K4rw
         NpvaWV8rH0AilPP/hcRo+rCAuem032nIZ86ckGhvFBFg+kCmUr4R0by7GOGSLn1hhL97
         dZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983535; x=1792588335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Q4tREkVd7vcO1xKvc6nTYP1DruPRGr6e3zl/2j3jwk=;
        b=qhqHSpeKWm8RPY0LJZvS+xTQ4s6JV5Jv3wKmUxOew2agVcFxP7JmOMx53irN6zWRvX
         +709+a3o8HAvF7zMmvELYcQVSSIalL/fAXL873Pz9++6ub7eo7QYzLJDwFOozOhzd5Wp
         uBIVIzeJwBTP6l/nUepwpk6kEviGd7nT2huGNBjMI2nTSefnLOhEZLUsHl5i/lFZhafb
         yRwAP5wmoT69vqGSEjVrN5c82u/OqOeezAEg4iuoMhSySxZ936doGv0NpFV9CDPsaeAs
         xKCSPIPABMZcaAjBjkEsDLe88JXpYK17qqRV3uw8YokovZlHiWs0QHG7vB6TgsTEYUKH
         xZpQ==
X-Forwarded-Encrypted: i=1; AKwUvBybavbLUmE6a3s8kzmnoUX3zA1nuV8PS3XAlzbkeQTFSYf19cQXWx92I7fO9JtzW9oth68=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGr21zTE0LlSvxwrtQgwiLZ6CyE0Ts0LyT4hUgyFQ3dY3zSFx3
	HcuUg6VGXw8YPEHuEAaIi0nw33+gIKBCdxF7qEst5ivonHYmK94w6/XEvzKuIfBItSrHJf+4Bv/
	e53lEQgXlgvst4/27El0la1h+WodKfme5ZcR+IjQVFhOZ6a2X1LmE+1U=
X-Gm-Gg: AYBFou3/dgqfRLLl2dS27o6ES02Wd2/YT+LWcWHSNMPaVWgspRKhAQxVHUNkhBRDQwS
	/7CQRp1GkB3eNKhndBeoTov6LxV+yjdIN8PDt9zTqSGDMYkhxZyl5njcibPs49n/Sn3969VJFYC
	rG3b5RR8Wz0mbduC+F3JQLicIztVZU7zCuvpc4nZ/lzv1Q5cEs0/HFfakcNcPmchLqI0A7Q+awq
	VdxRlYu6QMPaJoOprz7o0tTDtPbhQhs3OjKQ7kkg/zsN01hcRyGcoO76IAUJDbXGSrrZ+lK+RvH
	2jjj1+5n/n1mYpLzpIKAO9mFd4SvzQyEvDS3mksqyzn3ixRJefxNzQ4uun1wn7KfwzpoU3Ocyan
	XolcpQk0YlHIDWQ==
X-Received: by 2002:a05:6122:8006:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5e96da64d4emr521228e0c.3.1791983535199;
        Wed, 14 Oct 2026 06:12:15 -0700 (PDT)
X-Received: by 2002:a05:6122:8006:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5e96da64d4emr521135e0c.3.1791983531912;
        Wed, 14 Oct 2026 06:12:11 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaad1sm11597371f8f.17.2026.10.14.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:12:10 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:12:09 +0200
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as9_qWH-Vw07Zr_f@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWwpvJ7uYLKp8rBQ"
Content-Disposition: inline
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GPyfM8WDjYqQ-Ke_3zpVIGxC-Otg_Z2V
X-Proofpoint-GUID: GPyfM8WDjYqQ-Ke_3zpVIGxC-Otg_Z2V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX0LSR7q3vTfmM
 mxKNdILr+aXeoe+YeAzlqJBsvVUdwjiU3baz2vel3anir278jx4aGW/YnpN0oiI1NFmKp46aWRS
 inQOGSV6RbZkH1NhzV6FBOFA5y3+a/k=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acf7fb0 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w_4PuGcMj9oXbp2957IA:9 a=CjuIK1q_8ugA:10
 a=2yseMgosz1EoShofO10A:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX1xYpf8kQLnbD
 V9mf4TPSC90j02wcXouqLu7Vq/wCZEli1RyxWb54J3gEaSKRH+nOJrJvP2j1pjjSqJN5gglUXWD
 fQg6BbU6uy/Eyx7O8WwEoLeFeuJ/ogoPfbTYwl2RIkSXjy67zoKcz5zZ9lbdtFKqImCFC7b/XJ9
 +bL+7rG64TxSTwtaMDlOwge9XZlCeNlgevIB466nXGzS7sQBVwxrKNCT4tPrPv9oweoKft27OxD
 zju0eFGZpQkPu2v3zf3BCSkqkBfle0GK5ACSfPqswfbFonNFeedB2aj2RQupCyJGMZncN2Mr7RC
 L2/5SJtgQSh4P/3Oy6yYS2WhCyzL8ryt/lV4IwFhSZmo0BlVmO7vQaF5e+MBCjdwcfhBPIuXf/y
 RamSH452JxHNKWANzIW7X/ZAaVjKUgAP2eewvsgB9ck/c7/4t5Q1R5Cji7IVdByduZBTFxd2whv
 7iQgDMYTxWdTKvyqf8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

--SWwpvJ7uYLKp8rBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Rework stmmac_rx() to build the xdp_buff from all the descriptors that ma=
ke
> up a frame, so the XDP program runs on the whole (possibly fragmented)
> packet instead of the first buffer only. Fix possible rx_q state leaks
> when closing/opening the interface.

I will fix sashiko's reported fixes in v7.

Regards,
Lorenzo

>=20
> ---
> Changes in v6:
> - Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
>   it requires some XDP fixes.
> - Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
>   RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
>   yet supported there.
> - Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
>   fix pending bugs due to missing XDP multi-buffer support before patch
>   'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
> - Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4=
eaa138@oss.qualcomm.com
>=20
> Changes in v5:
> - Fix possible read after bound issue in patch 1/3.
> - Do not allow parsing non-linear XDP buffers if the program loaded does
>   not support frags.
> - Add patch 3/3 to remove MTU constraint for XDP prog.
> - Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca=
974e3d@oss.qualcomm.com
>=20
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
> Lorenzo Bianconi (3):
>       net: stmmac: drop split frames on AF_XDP zero-copy RX
>       net: stmmac: drop multi-buffer frames in XDP mode
>       net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 407 ++++++++++++++--=
------
>  2 files changed, 257 insertions(+), 153 deletions(-)
> ---
> base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
> change-id: 20260918-stmmac-rx-mb-16469a2714ea
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--SWwpvJ7uYLKp8rBQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas9/qQAKCRA6cBh0uS2t
rHAeAPwK1fCt/8yBFk23UATpkL7SEGGsdCm+B2Y2kUT03z9WZgEA3eCds9amV6h7
fRwlHyRLNHXnRlCNpT1QfbCTUE5N0Q8=
=us9t
-----END PGP SIGNATURE-----

--SWwpvJ7uYLKp8rBQ--
