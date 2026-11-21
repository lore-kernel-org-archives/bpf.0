Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281689;
	b=pKPJcJiOyqGbeHtAjW6MBYG3AN1nPYYlJMGBlFEkj2xfiQjJ/pHpWQSO9U2+Fw4Ku56x
	 iPGsvRcpmJsf57bHM9yLO+scJhQ0XgCbbUmlWH/JBBY7aH6yKQ3/ukFkPw5NGAbiclgdX
	 /MzOS2oYsiaSdoQKsHmEIVUDmNPEUGHf/bU/yj+HDabSC3XASs2EGnxqY+qixRJ/8Z/qi
	 cZUu6EvJsPkzcuoFa9pvWX245120VuW8i08T03l5TQorDKS9UGp/Js/OEoT3dyxAgxPgZ
	 n7s+v94FqejSIIkm7Ur/O7OelLVKRCgwjEigRlPArvY5+yi6jn9u8N77oCDaj/cFYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281689;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jSHfkzBiNByvDfDTLqOlddtpy57ZmGp+HuTqJSiKH9c=;
	b=A3CwN5bC1eapdMCShkeAbFYE/6o32ld7bz7aZ102turk0x+YLIK8puE4fDqMlZTIjQhr
	 3iNxPFPcelC57liWlT/cZwBS8D2leF7RgA/JqnhVwUocK3CPELUbP6TT+S7GtQ33QDrqK
	 IXw8Enu9wfoCYvByK0dQ18RNdKUwiHfT4epcE45r5h33TXxRAmTDCs29xwMUTFy9i+Tbu
	 LiCrbObH9joejB3YjmrrnmUvpfmeDS92JX0AYX115koCPSViQplc7GZ0eJ+hZqmAvn4Ul
	 AYwzIJd9OEc+pcDi/A0VcjkxbaNIMNdRJ4beqLm4UwHpkA+4xFDfO6XBXpmHpzK8P2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R7QsBHkt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hp1+y+zI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5952606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5952606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R7QsBHkt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hp1+y+zI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFZxen000787
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jSHfkzBiNByvDfDTLqOlddtp
	y57ZmGp+HuTqJSiKH9c=; b=R7QsBHkt5xgA0Bs5j6WT3Em5PY+MKTNHpjePdnLw
	iYoyYWkmtrH9znByMBLdC/Q2/+wjNiOZdDnzuCNoS9uQ8O69TX0BYRTdseIFdqae
	lkrH158vRG43lB6VUYR4mxU9i7hJECnrN0c6S30xJC2j8l5b4HfqvQlFLQ8T6R46
	E+TJ+qx3+3rZ0si605OlitC9HeaMrnMFXrOus/5S8oLm9LJQRkD4It6V0Ugo4Nsu
	bxFN/g+1/lWtylGjEbQfcbDbS2FfgU4rLuBRo/Fq9PzE6+7JO8+kfLDpYuUDYV+Q
	Cv70wR3pjVsycAROUqPX885ssaugdoRAd6eaka9pwC0jpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka1fg8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:21:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f26dd2165so528362085a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795281687; x=1795886487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSHfkzBiNByvDfDTLqOlddtpy57ZmGp+HuTqJSiKH9c=;
        b=hp1+y+zIAXy61mo0c6tUxhyAa3gBKf37XR8UceXycTL+XMoZs/JYoBpc4ddlDGaTbJ
         qU77t/laooCyAKeAkXz/O24uAKVVZLWzfnhLT+DY7mUpbVU2zTxVwscNvXFjFgYDNBc/
         t8xlycoklz/TV9bge4s+u9qYR4geuc4TZGXIahgqOWxbRaXIU6atSu5iU2r9OnvqkjNO
         NPGwT8KehDwR/phuqT6U/FEvEYnS76qojCsR9ur2JSVMh/5Y/69Sgf5+y5d3oC1Y4ZTO
         eVzfA1GDSSbMSghSru0znN1YBXfSkqh7a15Tm8kS1e4vzdBCgE+MSf02aMdET1YH8nVX
         eRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281687; x=1795886487;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSHfkzBiNByvDfDTLqOlddtpy57ZmGp+HuTqJSiKH9c=;
        b=2nFSRVCMXEKge0OWpmwI7ZCt4EjSqNmNEwK7KTKJoW7QIcpOBnim1wI9gGqKsbZvHY
         etdXwz0Utim0Bn3YxDmJZaoXORBBmqkoEM/DHc+cFtPwy6NJZMD2qL5abo9P2BqKBKTP
         QqV9eObK4OKaHDymW0eZPWB/JGYXAWUqdFDIlD43XglGW99Vsto/6KwZooSC6Jx9CQQu
         gi5uu8P8oXanYdZNqRgKFfDdlipt0upK9bIL54jGBc01QDgToRF5In2vFUNnWvEPww5/
         pe3ZA7qtG1meJ2LB9wW8m8KDz7BIRaHtgCcJJILdtuhif+hXQ2QxUvQF1rtdkcHlIuVf
         YqoQ==
X-Forwarded-Encrypted: i=1; AL+hErGbJ488iTlGxGgCoVGKq75c9NBr4hEMztPx0C3YYXTVU+AuuDzBhYGA2NORQHDAHENOOHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z82CvWYpHn1xzuQ9JmgnfoZvhs1VeF//CD/AcZdHQLJyjl90Sck
	IWrIDIWAXGhD8wTAqLo1GMDPpsCG6WnqO9inrYb7sGdBDOq7YdGJdv/I0yPk/06qoVIv4mxutt0
	6G1alVNzXHjmMDW3fvBpNhBKQ1pp0NjDmDvaSjaviF9l+HK9yocEHLMs=
X-Gm-Gg: AZFdTZdyZN2+ZuPcZEYgEUMSd8Qap7LU9ZsTMicAs9OwZiFa9GH0Dh7/6wPJsJNnrXV
	1yZXYI/RH74Wg8VboYQxKkFs8kLWMydH1bb8qxgooLy6n6gZDxZf4/sc7wKKqzjmO2hEoA721WQ
	4tMDbyXTzfCwnkNQ96TvDwSUSvMu3gnG/+uLQ7mwYx796p8YGfM93dDmRjdn4fFRB1Ae8xIdRdn
	FYyBhXLCfIHajS1crEqcqZasksQEz5xSKBdoOyS324Memk2ffo7P02bpCbiZjvhTk+LAJqlIqeb
	58IZZHKLXxxvNW+soQd2nPJsbRt33Kez/u8ddXi4qSNOaQOh9KSaeY0JkTlUkHdYCEGbYnMkAUg
	4/LJNf0+cBLItOLKkJmf7sEae4q0W3fVnuA/fvbLmq1nujtvDUOKm7gPNUCLfGXJxJw==
X-Received: by 2002:a05:620a:130d:b0:949:61a9:5a6e with SMTP id af79cd13be357-949ba9c732emr1108783485a.31.1795281686620;
        Sat, 21 Nov 2026 09:21:26 -0800 (PST)
X-Received: by 2002:a05:620a:130d:b0:949:61a9:5a6e with SMTP id af79cd13be357-949ba9c732emr1108777185a.31.1795281685977;
        Sat, 21 Nov 2026 09:21:25 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm58576735e9.5.2026.11.21.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:21:24 -0800 (PST)
Date: Sat, 21 Nov 2026 18:21:23 +0100
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v11 0/4] net: stmmac: introduce XDP rx
 multi-buff support
Message-ID: <awHTE2FEu5SpyROj@lore-qca>
References: <20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="o+3BUnz54sJmnQtN"
Content-Disposition: inline
In-Reply-To: <20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX4xziPpc9Pcaz
 B7t0rCObZYiukzNEdlfYgxvRLcHV7c7ECDcIvkMPNhOltYQJI4HU4ngROVmBsB3Ek45FbZOBTsL
 FPNU0QynPk6junxTrZMRmhI4bMfqKQo4luN5SAuc9AV0u81BPfkDaRIs4VzPW49O5kYdwyA9M9M
 +c6/aIWxAWe6d8O0fFF/KsocNlWwQPcOKMIxJNp2xI6xiIZcrcSpdomK6xsWJaG19D4j8kpKOZT
 UdnGO7FakLVGxrWXvN2vW/bfCcpyDQu4QFsStuhKPnqo/ZEH2nP9wkTh4NyHsxi8HDRTVg7Pxpm
 KwdNfeuqW1N5w02gBmX2SWU58Ep9PHFomcRQnI9QvYofhAlJV/WxgRe7COmRWd2Y8WdKdEckwcJ
 EdVQDuh5wOGXMzLEknga00F+u5zbZsyjitvg6nj33FfN07tC9a3WrMs23vpw9BV3WpgIqkuu2Zl
 LLIz+uaMkS8zh5XKmiw==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b01d317 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iIgN2aIHOFbAZzYJiOYA:9 a=CjuIK1q_8ugA:10
 a=BKpwHOXHW2ddnCNaEzcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: QSyaR7fy0Vw0PzohUdsVA4M7H-WwjZZJ
X-Proofpoint-ORIG-GUID: QSyaR7fy0Vw0PzohUdsVA4M7H-WwjZZJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX41vhCYmCuQjL
 mL8g/28tUJnsoYKSmjSpb6mTYWKtcCozJWix4kP9XwkJgjxb+/STrO8P/jCINL5Rx+/y4SYb+IT
 lKsdDx7rTY/JGk6V6WYDgwVS0Rsz3J4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611210069

--o+3BUnz54sJmnQtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Rework stmmac_rx() to build the xdp_buff from all the descriptors that ma=
ke
> up a frame, so the XDP program runs on the whole (possibly fragmented)
> packet instead of the first buffer only. Fix possible rx_q state leaks
> when closing/opening the interface.

I will repost v12 since this no longer apply to net-next.

Regards,
Lorenzo

>=20
> ---
> Changes in v11:
> - Fix kernel-doc for __xdp_build_skb_from_buff().
> - Add sanity checks for xdp_buff_shrink_tail().
> - Link to v10: https://lore.kernel.org/r/20261112-stmmac-rx-mb-v10-0-d3d0=
4b65c6bc@oss.qualcomm.com
>=20
> Changes in v10:
> - Introduce __xdp_return_buff(), xdp_buff_shrink_tail() and
>   __xdp_build_skb_from_buff() helpers.
> - Link to v9: https://lore.kernel.org/r/20261106-stmmac-rx-mb-v9-1-c099c9=
23664b@oss.qualcomm.com
>=20
> Changes in v9:
> - Rebase on top of net-next main branch.
> - Link to v8: https://lore.kernel.org/r/20261018-stmmac-rx-mb-v8-0-5f58c0=
b25849@oss.qualcomm.com
>=20
> Changes in v8:
> - Add patch 'net: stmmac: fix VLAN tag stripping on non-linear RX
>   frames' to fix sw rx vlan parsing.
> - Rebase on top of net-next main branch.
> - Link to v7: https://lore.kernel.org/r/20261014-stmmac-rx-mb-v7-0-5d2d70=
f052cd@oss.qualcomm.com
>=20
> Changes in v7:
> - Take into account the case where buf2_len is not 0 for the single
>   descriptor case if the interface is running in xdp mode.
> - Report rx_not_ls bit if the packet is splitted over multiple
>   descriptors for dwmac100 and dwmac1000 cores.
> - Link to v6: https://lore.kernel.org/r/20261012-stmmac-rx-mb-v6-0-222505=
0915c1@oss.qualcomm.com
>=20
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
> Lorenzo Bianconi (4):
>       net: xdp: add __xdp_build_skb_from_buff() helper
>       net: xdp: add xdp_buff_shrink_tail() helper
>       net: xdp: add __xdp_return_buff() helper
>       net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 231 ++++++++++------=
------
>  include/net/xdp.h                                 |  39 +++-
>  net/core/filter.c                                 |  80 +-------
>  net/core/xdp.c                                    | 113 ++++++++++-
>  5 files changed, 254 insertions(+), 212 deletions(-)
> ---
> base-commit: 500da33276f5d81da764775223de9e9a251a4dbf
> change-id: 20260918-stmmac-rx-mb-16469a2714ea
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--o+3BUnz54sJmnQtN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawHTEwAKCRA6cBh0uS2t
rHZUAP9xBnVCVSdCg2brXWGoEWn2rM2YtD6AdXf+gJE3UiWF0QD/QsC0Hdz3Rkst
ExpAixwopSyaEXDDuDtGOW5Rw0yP9wg=
=e5ZR
-----END PGP SIGNATURE-----

--o+3BUnz54sJmnQtN--
