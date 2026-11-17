Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920172;
	b=EBmBG2p+s+spX7zpl/fVg1L4F2ZRPkMzhYIoX/SP66DnXoc+CIT2aB/PXHf2ND7moSdf
	 DP1H4KyryzfuSHnIZG0VVGQsBTjtyhxmxHheM7YLccWXgzDAQmzvzqKxbl3B68HKvcrMh
	 3rz1nM6Rf4AziX6Q0KLseLTRa7q8xdKguH7jSLDMTAoGjjo9GeofNbF7SuC18gxesbRIC
	 cNVbv6h2v+m1Mvr4IehBd+FnFZNwK5ZOlBDy90fGdJOL71HLBZiPEKodmUJCmpwTqk3DM
	 N8B8GYPFHEzut3iHbSFocovkkER766TFZCMH6jpLoOepAMB5AwhczGj/2CM02VBpVRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CRYqBTv4x5sG5yKQiqFGY54mrAYYf9g0PlzTS//Wg3Y=;
	b=aMFB229UcdOkXo9EY7VhxgavX092gpJLmU7R0V5RJ7DrCrL30khkMZ7rFm3fx9oGFY23
	 UJEaHf8meV7VO506cFVOVvyC6nANl8cof05uyuNPtqGavX5YQ4Bp2IGJ72+QyajA5KFI6
	 LblNXQyMj5bMR9Tz42j/xuCfLaUs1klz0W703V221DJ8GtvIw2ZSleLfKgJlZF+XBtWF/
	 c7KrTEU4V3S0Jqcyu3uNHn6U/dDnlccZOzSX8bu0G1QtkdI2twLzms05dvzuAW11OLT/I
	 61dNAGesqnl6rgvVrq9y466vy+UqEfCs9/AylaFCkDDvlmW8hFnzm1CrSJDwuoZFJtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nwFZS+o6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V6sAylgf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6E606A32F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E6E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nwFZS+o6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V6sAylgf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC1Cpm198261
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CRYqBTv4x5sG5yKQiqFGY54m
	rAYYf9g0PlzTS//Wg3Y=; b=nwFZS+o67KhwDPfC7G9harCmXeX98czysd8GWGuv
	tVQdksrBdJ78Z9xIVi8U0NSB+r+RPOukgdMYNPmZ4YhXYg6d/U12PP7v7qt3Ntqm
	Y3TK4z5/WsIApoTVMgJgXKexN6AsiSBII8Un54PjjUwHAoRVN7bZzHb8GS6KfCLl
	I3rXAMr5snleHPi+Hz6EnUC52M/0MiVguYtPGGT1BjSVh1AbQ+MK18otqqUIJNx+
	jsOtc9HHWJ3Q8nWV8BZs64JWWSpr+f24eixHmQl5hCudKHf2TQfPu+2qh97ExHsx
	be6dDdiMC5GVAlvslyL7yrnGg1P6a1cuIK2eACbcmWdK5w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0geh9t57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:56:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98a829c43f3so740363241.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794920170; x=1795524970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CRYqBTv4x5sG5yKQiqFGY54mrAYYf9g0PlzTS//Wg3Y=;
        b=V6sAylgfKqP+DLwtnBeZY+lqwP9ChdH9sKsMzjiZ01m/p85lehWJf7AKd8fTw4nomx
         5TLVC4nzAYu/oxn6dmZzuGMgSEWAJl0bRBoKlxJtK7whDBI16e10x/QtNftu2etSbkpb
         1umZk5Inr35giuQh73y2r8B3GU1DRNUDRnqAGBmryDJY7kNYeOvpiIlN59UszVChxqpS
         efM3E7z7q+M2whM2jCMsuM8CvIP1ENLGABPb9m6E4eidEM/zI8jLD72FO307JwX0bpb6
         wOs6d9C77bBw9ZW33I2eBd61cuzyPxWB9T5vs6kTJf1nsGeW7TghO9qB6R8Z5vhpdmNY
         +JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920170; x=1795524970;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CRYqBTv4x5sG5yKQiqFGY54mrAYYf9g0PlzTS//Wg3Y=;
        b=OpklE9RYHnjEvG5efg80HB0al25jpVsvQOjhPnL+Jcj7z3G7A1URT0cxd6s+lJ8zXn
         tCn9h039rvlZg0nfsSXZOQJqD+tTaSSp0uI1iRUadIMPR8PxZxYO9elyPmZ3mx+GPc9F
         jX6SCGheBMFFMJarLcRsOZ7hF8NtkhtStRaL6un4LtccTteUJ8sJZCCQElD80OAGndg7
         lc+H/FKQo+STiBTRORLGeTqPPFQwTuti3C4HLkEHo6BdBsYTAF2xN8hNds64bQ5VZrsu
         jHTBtpjskWfkT3qugMhyHInlLZfpSnjf6LMj+TQE08o6XXlZIrFMDpcxQtfsdr1t3QRx
         mQrA==
X-Forwarded-Encrypted: i=1; AL+hErGwD7PM/5JX9YXYBiao75cyUX3ziKomyq8L/AlgIDMnrrgTGaGQ7wd7D/miQ4NBur0oDgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R8LQ9g3NUcZNeoZyCNkcQvJU8eLHi1m/copOyHuLnt5LinnZ+
	wQmzj/0Ce66LFrg7SgtReCOWJiPY7EREolbf2ckvzf9Y5kUH+EWSnF1jtYYQggJV5h7O7C6IgYX
	chFQ9JP8RJz3ZEukRjZzpgnWpYl+dps81sHasJGCUFotOW7jRdOrXqiw=
X-Gm-Gg: AYBFou3DmUFo+IAnN/n0XcN3NXYRf/nGFg4V8O65DcfrMIlgtUJzBaNu9Qla4KPs05A
	9Asks7/EQORDeSlvqxnIVeUvZILYYxtzZ2Cd9Igzb/h8OFv4Q/xN6O5QAgXNbHRzyzmMk3/i29R
	nlHHVn4DlHD9xUfm0zeMkGatNE43MZopLWueD4/CvI9dYkTFwhD/jcLQLkqBRTithoILbWLpQqu
	08+rp7E8z86OAXm5Xf8j4l2GeV2ldRk42FexCBUHCiXduDtkpIwDaE09Ts8/F12wE73/ZC7JP8c
	K2cG0gOoIv0HHYhUkMGZRGQDdRIzWtQdOPg9Fnz0+SLYx/TasMuId+sWSoD9NB9n9NrbnSFi3jW
	WqjUFk19NwA1iwsHtriS/IahS9KDLUnGzIQE5tbxUFChOBZCnl0tKNFKLJZHzHSg=
X-Received: by 2002:a05:6102:84c2:b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7d64d6d61b4mr3074697137.10.1794920169986;
        Tue, 17 Nov 2026 04:56:09 -0800 (PST)
X-Received: by 2002:a05:6102:84c2:b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7d64d6d61b4mr3074669137.10.1794920169296;
        Tue, 17 Nov 2026 04:56:09 -0800 (PST)
Received: from localhost ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm72247915e9.4.2026.11.17.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:56:08 -0800 (PST)
Date: Tue, 17 Nov 2026 13:56:07 +0100
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
        emil@etsalapatis.com, ihor.solodrai@linux.dev, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        nb@tipi-net.de
Subject: Re: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail()
 helper
Message-ID: <avxO59MbI0ql5YhQ@lore-qca>
References: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
 <179484961693.3136.10654880889378798099@kernel.org>
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
	protocol="application/pgp-signature"; boundary="kB4YMmlds/8C4Vd2"
Content-Disposition: inline
In-Reply-To: <179484961693.3136.10654880889378798099@kernel.org>
X-Proofpoint-ORIG-GUID: hJMwt6wfgbAOiJTC1Sp4aR_urqU5m9uX
X-Authority-Analysis: v=2.4 cv=dLkzC+Zb c=1 sm=1 tr=0 ts=6afc4eeb cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=haHO5IcbFzYs7ll2q3kA:9 a=QEXdDO2ut3YA:10
 a=OVCSiOd5OdK5HwpI3AwA:9 a=1WsBpfsz9X-RYQiigVTh:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: hJMwt6wfgbAOiJTC1Sp4aR_urqU5m9uX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfXzRrD7Q2MN4Fz
 G89cIhuBsH2qq9bRNxBPqxpngssr+pgoB+DCAEwg3sYnIL3oRJQsqJFFhwSt9WSYqhhM8E8RyCW
 LYJEb4JfJgvmYZLid76hQCgKMBRCqTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfXxSWFTH2HnYTz
 X4vJi9zqc5cye733kUzQX0WEd+Idjdz88n3j4t/aiFG9GAUODjxH7CqBqXCqjExT42Z2v4Nab1U
 hkatL+ARFZDp5K6FKrUAHaJMtVMPbCtuAkqhurS6tguCMQHuy3E/emDvNZX7A04pIC3QPs6oPzT
 w0UI74JeAEetPp9vVWOE35boa3q7k4qk2nZDSba5i5TP+rfzoFzWUNwXJU/LAzr5AYFKdFpu1ET
 W8XgyxEF48Wh7+toxZ4wc0jm4ley5Enx0maiTAMNvMd7tnQrI/9ikv2bOdeW2NOF4NzLmdSY3a2
 CxaI6b4htspW/WrbG/lLo5XuzH8F+B2Aa0xly+TSvSAuYtiMdA+Qyxwzndnb4UDyP+WIlAJa+EZ
 aCZEG3GM+FDARMhB31I+/IeENW+ExoW0pO8EYQc7EuK1BzVKuSdyzJcu+yHXaPivjXv2VxjdeOy
 Phti1mmQGOmeMHwnPZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170051

--kB4YMmlds/8C4Vd2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 2 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Critical] The patch removes the lower-bound check `data_end <
>   xdp->data + ETH_HLEN` from the linear path of bpf_xdp_adjust_tail()=E2=
=80=A6
> - [Critical] The new exported xdp_buff_shrink_tail() (net/core/xdp.c)
>   checks a linear shrink only against the lower bound: `data_end =3D=E2=
=80=A6

I will fix them in v11.

Regards,
Lorenzo

>=20
> --
>=20
> net: xdp: add xdp_buff_shrink_tail() helper
>=20
> This moves the XDP tail-shrink logic out of bpf_xdp_adjust_tail() and into
> net/core/xdp.c. The frag shrink helpers move with it, and a new exported
> xdp_buff_shrink_tail() handles both the linear and frags cases.
> bpf_xdp_adjust_tail() now sends every negative offset to the new helper
> so stmmac can share it for FCS stripping.
>=20
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9b8d5191c4ba2..5ea45dfce7a22 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct x=
dp_buff *xdp, int offset)
>=20
> [ ... ]
>=20
> >  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
> >  {
> >  	void *data_hard_end =3D xdp_data_hard_end(xdp); /* use xdp->frame_sz =
*/
> >  	void *data_end =3D xdp->data_end + offset;
> > =20
> > -	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
> > -		if (offset < 0)
> > -			return bpf_xdp_frags_shrink_tail(xdp, -offset);
> > +	if (offset < 0)
> > +		return xdp_buff_shrink_tail(xdp, -offset);
> > =20
> > +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> >  		return bpf_xdp_frags_increase_tail(xdp, offset);
> > -	}
> > =20
> >  	/* Notice that xdp_data_hard_end have reserved some tailroom */
> >  	if (unlikely(data_end > data_hard_end))
> >  		return -EINVAL;
> > =20
> > -	if (unlikely(data_end < xdp->data + ETH_HLEN))
> > -		return -EINVAL;
> > -
> >  	/* Clear memory area on grow, can contain uninit kernel memory */
> >  	if (offset > 0)
> >  		memset(xdp->data_end, 0, offset);
>=20
> [Severity: Critical]
> With the ETH_HLEN check gone from this path, what stops a grow on a
> linear xdp_buff from wrapping the pointer?
>=20
> The offset argument is ARG_ANYTHING, so a program can pass any positive
> int. data_end is computed as xdp->data_end + offset. For the linear grow
> case, the only check left is data_end > data_hard_end.
>=20
> On a 32-bit kernel with the default 3G/1G split, packet buffers sit at
> or above 0xC0000000. Take xdp->data_end =3D 0xC5000100 and
> offset =3D 0x3B000000: data_end wraps to 0x100. That passes the
> data_hard_end check, and then this runs:
>=20
>     memset(xdp->data_end, 0, offset);
>=20
> It would zero about 1 GiB of kernel memory past the packet buffer. After
> that, xdp->data_end is set below xdp->data.
>=20
> Before this patch, a wrapped value was always below xdp->data + ETH_HLEN,
> so the removed check returned -EINVAL for it. That check now exists only
> in xdp_buff_shrink_tail(), which runs only when offset < 0.
>=20
> The return value also changes for short frames. A linear frame already
> shorter than ETH_HLEN used to get -EINVAL from
> bpf_xdp_adjust_tail(ctx, 0), or from a small grow that left it under 14
> bytes. It now gets 0. That seems to contradict this sentence in the
> commit message:
>=20
>     Behavior for valid offsets is unchanged.
>=20
> Should the lower-bound check stay in bpf_xdp_adjust_tail() for the
> offset >=3D 0 linear path? The later patch "net: stmmac: rework stmmac_rx
> to support XDP rx multi-buff" doesn't touch bpf_xdp_adjust_tail(), so
> this still looks present at the end of the series.
>=20
> [ ... ]
>=20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 470bf90d93ef2..7c98dbc2a770c 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const st=
ruct xdp_buff *xdp)
>=20
> [ ... ]
>=20
> > +int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
> > +{
> > +	void *data_end =3D xdp->data_end - offset;
> > +
> > +	if (unlikely(offset < 0))
> > +		return -EINVAL;
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> > +		return xdp_frags_shrink_tail(xdp, offset);
> > +
> > +	if (unlikely(data_end < xdp->data + ETH_HLEN))
> > +		return -EINVAL;
> > +
> > +	xdp->data_end =3D data_end;
>=20
> [Severity: Critical]
> Can xdp->data_end - offset wrap here and still pass the lower-bound
> check?
>=20
> bpf_xdp_adjust_tail() passes -offset, so a program can ask for a shrink
> of up to INT_MAX bytes. The old inline code also checked
> data_end > data_hard_end for shrink requests, and that rejected a
> wrapped result. This path no longer has that upper-bound check.
>=20
> Some 32-bit configurations put lowmem below 0x80000000. Examples are
> ARM with VMSPLIT_1G (PAGE_OFFSET is 0x40000000), nommu ARM (PAGE_OFFSET
> is PHYS_OFFSET), x86-32 with VMSPLIT_1G or VMSPLIT_2G_OPT, and m68k.
>=20
> On those, a shrink larger than (u32)xdp->data_end wraps to an address
> between data_end + 2^31 and 2^32. That is always above
> xdp->data + ETH_HLEN, so the check passes and the wrapped pointer is
> written to xdp->data_end.
>=20
> The packet then appears to span gigabytes of kernel memory. Direct
> packet access, bpf_xdp_load_bytes() and bpf_xdp_store_bytes(), XDP_TX,
> redirect, and skb construction on XDP_PASS all trust data_end after
> that.
>=20
> Should offset be checked against the linear length before the pointer
> subtraction? This code is also unchanged at the end of the series.
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc%40oss.qualcomm.com

--kB4YMmlds/8C4Vd2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavxO5wAKCRA6cBh0uS2t
rEaaAP0bCS+8PXbCG4IQReMWkZwemcUWcImjpdq9d1cLr9EguQD/QGWDD2EyxewI
SjOXKQpcar8Y7mQ+mx+C3VPKTfHBMQs=
=dcAu
-----END PGP SIGNATURE-----

--kB4YMmlds/8C4Vd2--
