Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096255;
	b=DJ74+zi9ju8PpXkA18zpp8/8nPKreAfmUoYg13FXUxuW+fvOKPIl7wJZwP7OnTufgDj6
	 YMdQv4eL3UiHwq5WY9uEsyf4m7PCZGvAHtOw0KzygID6snGyg7IrrNxSmsq145L8eGRUY
	 esL/4ZzpBvmOkKXRMyRb0Gp+8jMw8dWgsqc4aR72BEtTFu/QT+oyvb9mVZoQVJHvZsYVM
	 kMcqDupK+4FNCyKggm2g0NP1AmMgBgwoUwOLk99DVw5XBLN0VDvOBavzfLwrdLlIyspob
	 ecVH0SdQ/nlroXLH1xrBHMuJjOKvLq8JbjB5Dxq1UXyGG6kK8uA01sbX8AFPwZvkgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096255;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/t88iT6pncol1pshGXVfM2oybT+zrFU83dtwkNkrIjE=;
	b=Kuzj/IQvX8KD4Y95wKfQSRY13XuzOrTZWxmifRlJ7TMmbG/Gln/ing1k3lawUmt9d9Td
	 sf4fjjoVcU69OqnRsHz3rnWvtKl7MpI4EC3c9Yn5G2FVYgOAJXzIaLtTsQB4oCnGHbT/b
	 aUJ+iVS9HsEFDR2NcBHgKUKyQtzLaKtlHmhYMcsAkY2TAJDcVRe+XyV6+EaFdkmx/YwFA
	 MNtbA8Sm0QaU/i1TWocFzAoOZoOSxjvYLImUf83cKSyTcs2t99oyKjWyh8puT193yTMqW
	 F4TCt0k0GGZt/qO8Rk3YagWLN09UdZXpozib2LGasQGl3zHIhGwDudqRrEbxVyoIHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qwl64+46;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XuSXvN22;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB82606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qwl64+46;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XuSXvN22
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gNIW2747371
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/t88iT6pncol1pshGXVfM2oy
	bT+zrFU83dtwkNkrIjE=; b=Qwl64+467SA6hnQNW54Xt65gR/ajEbZk7GPiqWZb
	y0CafU72GVa68Es1LrghjWsfFPFH1xeRrJ8KSyXlFgl3NItCLYTkYGIQlXTUSQ09
	CrzmBSRtkkeBDDwFFIuFt2eyZCoAwHWNZDHyqjEIuSDjzA2PbO7nKBYd2bmjxQW8
	ggKDA9+K5n+lDsmqrNhw0xhJ2JL4fB05zXo1Bq21sN56+2URpe7a4cnFG8U1ClUJ
	d2l0dwiQdn5WrLKIDDFxrJORNQCEm4Hlv+Ye0KV262w1ktKCOxnmHOr5erIemsbU
	c55qHE+22sJNuSJqBDca5xwi18n1jsm6B9wXzPoRrBMCHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3dah7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:17:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so422815885a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793096253; x=1793701053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/t88iT6pncol1pshGXVfM2oybT+zrFU83dtwkNkrIjE=;
        b=XuSXvN224RXW+2VUVZJRrMyEMqQmLZrac4RbjU59LXlSS7+zFMKkMoRCb64HM/DJhf
         QmF1pd2LrbE7zXN5c+9C/9haIIBoOAjj6hPmiHQODn0TG7sM7K09Ijzh2vP2AwVeS1J3
         IwwqUhT9l8VluERhU9WJ6ZHnYwQueFEmuQf7/noQ265w4OIGCSHjgCFhCC+nZ/Rj4N7V
         1qyWdX9e1D4PZOP7Pz6y+qHWPQzPdQvBcAEy2Q6+wIB8cY6TMc/60Dj2SUhbRjRggGk9
         9/pz2nz4XEQr0nQpzbSZUcAde/5vySZDuuvWWtDOkGfWfjSNPs/A48K9bIXfgyPbtFVj
         XrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096253; x=1793701053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/t88iT6pncol1pshGXVfM2oybT+zrFU83dtwkNkrIjE=;
        b=xBzOaDoJH9Px+E22jhicEYKyGK9gtWFsomHZ9thjNoBREF6AwYKZrWbo171QYkY3lQ
         2vs+SjC+s00UbFQmk3PholEl7ikSL29L0wjeyOgJYcCPaARa+YVKhNPEHsljSjK8bzaE
         DbL0SmF86xekooEAwnkJ9M3dUttic99I0WGbF/NwH90Jboo/eJ9Ivjsa3jkPzjHKprBB
         UP0GjkEE1YZFIA8TWWyEp16Zh8n3D/8hWK9mKo5lDTSMH7x2WejwSLtVaAKrA0EbF7y1
         X70uokyMa5OMmtp+uu2cxXK7J2wuz0+eOAX/14SQtdJtabB2W2slGAafvrpYg80YNV85
         Sx8A==
X-Forwarded-Encrypted: i=1; AKwUvBySX0qzAWguGr4r7w13gNV7wq9X2Cc1XxAf72OOpkCSj0ap6bbdKUvbfaj4HEtOfAz4FRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJw1tGsBYvmMIoGVgnpzeX77a9VE4oMbX8CrGPhGkztdctIbdSB
	GBTfj/+2weAvaMrfwhUQ4wNFYdh2qzlGW73fXjGHMnbEXYfCS+l/RDn9/wuM04R9pDt+rY/DrsG
	dq1VR+SMQhPEn6FilrS7CqNSLAc3Or09OKdjbZD9HEXcDg170VtniCxE=
X-Gm-Gg: AYBFou0GTd1AcTylLW9pE363mzEq+T3B6Qm/gmRL8JIqiQJ0ZPba7glgeCYvzJa0b6h
	jfRr1d0aLZBUpicn3ZJrUE74+HtL0HMX9IgccSMaQ6ta5bH6jE/9sB91UcIFgJsOjAkz/PuaLH+
	X4edKRKmoAPSVZtEo4jpkFfkjjDDPwFsTvIUCZlYieSGs81pXYHDym+HH39DjVLef6W0rv91XVO
	FgnELA8MSmqE7jjJ+WviN8vzwUMwHHp3YQc88qLg5U6WOdPLUd6oZTPJixy9oYf/L9Omy4SaYau
	vnhtjIYY3Z0LafCN9RZ4KPxJqIxJtG5Z8Jv0UZW/sXQjEISJqNeby8MckWRluaU+i5UT3/zjZ4V
	QL8u2Ja37pSnwwbehveCoVx2lf/yB1BNw8tqqWqkW/TRRBVRN
X-Received: by 2002:a05:620a:a883:10b0:940:f224:5a69 with SMTP id af79cd13be357-940f2245d1emr986102985a.65.1793096253116;
        Tue, 27 Oct 2026 03:17:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a883:10b0:940:f224:5a69 with SMTP id af79cd13be357-940f2245d1emr986099185a.65.1793096252391;
        Tue, 27 Oct 2026 03:17:32 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm25852940f8f.44.2026.10.27.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:17:31 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:17:30 +0100
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
Subject: Re: [PATCH net 2/6] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Message-ID: <auB6OpACJerXjBec@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-2-efb37e19f5bd@oss.qualcomm.com>
 <179309225249.3134.13360572151220701495@kernel.org>
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
	protocol="application/pgp-signature"; boundary="GP/MfWl9BvU7lFD7"
Content-Disposition: inline
In-Reply-To: <179309225249.3134.13360572151220701495@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MCBTYWx0ZWRfX41KPVQBf+RIR
 T+DbzKY9S/tiYOEM0NlgI36/ZtcR2GQExkW5llvp/eCLZe5XhuG6InOe3t2BXBbLP2N4j53HDsl
 Sf88fzVF0FaiQMXZXOGO9rcbbytxSu0=
X-Proofpoint-GUID: F-0Z9beYstcckScFdZCCvIIaxPFvZmSm
X-Proofpoint-ORIG-GUID: F-0Z9beYstcckScFdZCCvIIaxPFvZmSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MCBTYWx0ZWRfX6qfSddqkWLXU
 ZCtVgxW49EoDU4ewxQCSFCJ7iRAJGiFkB0GuNl2PX3k09tcC7ldz7fzE6SO6k697u7kuwRoQcK9
 6sqTyrUULyfb4ZpUnEck/ra/6qAKJfjTPZaJu2clDT19BOknjV9xJ8lGG3tKJE2GiTpwBzeDFDg
 PwVNJARcwhOeYtCyLK4QAYL1y6aGHL3hV70fdFUlhCmh2uo8cgAsEP9D6jH8jKwXKiOpnj4SiBq
 UWbwNaiv72kwKS5FyfSzb4w1nsOenb28iSLZkEaKAJeXVQKCBXy1EzBOU/aO/3fgam3S5ux+aCE
 bDOlOlWzCb3jl+HRu6P3CGWFlCS4NsoKKEPevzv9Hy+qXL5Nr2bo5b+tMkjfMyBm1GQC2hPmj1P
 NQrSmKMlSqRqDxleM4EYOC5jGydVF6vZNRgpZigZpWkRzSKAehwLHwTsTdYYH8Cz2LOrRNlNONZ
 4EXEdpfyTTJ3Gk8nK3w==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae07a3e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=BnUPfLnITP_tn7LcAckA:9 a=QEXdDO2ut3YA:10
 a=twnd7clgSCzMtR1pb0oA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270040

--GP/MfWl9BvU7lFD7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 (2) =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message does not describe one behaviour change the
>   patch makes, and nothing explains the second Fixes tag.
>=20
> Pre-existing issues:
> - [High] On GMAC4/XGMAC, stmmac_rx() in native (non-ZC) XDP mode still
>   handles split RX frames wrongly at this commit.
> - [High] On AF_XDP zero-copy XDP_PASS, stmmac_dispatch_skb_zc() ignores
>   the csum_none bit from the descriptor status.
> - [Medium] In stmmac_rx(), if napi_build_skb() fails on the first
>   descriptor of a multi-descriptor frame, the code does `rx_dropped++;=E2=
=80=A6
> - [Medium] priv->xstats.rx_dropped and priv->xstats.rx_errors are device-
>   wide `unsigned long` counters.
>=20
> --
>=20
> net: stmmac: drop split frames on AF_XDP zero-copy RX
>=20
> When stmmac_rx_zc() drops a frame that spans more than one RX descriptor,
> it now sets error, so the remaining descriptors are freed and the tail is
> not handled as a new frame. The dwmac100/dwmac1000 descriptor callbacks n=
ow
> return rx_not_ls together with discard_frame for non-last descriptors. The
> discard_frame checks in stmmac_rx_zc() and stmmac_rx() change from =3D=3D=
 to &.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index fba21599a5e15..3fa2c15222d88 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5710,18 +5710,21 @@ static int stmmac_rx_zc(struct stmmac_priv *pri=
v, int limit, u32 queue)
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats,
> >  						  rx_q->dma_erx + entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > -			xsk_buff_free(buf->xdp);
> > -			buf->xdp =3D NULL;
> > -			dirty++;
> > +
> > +		if (unlikely(!error && (status & discard_frame))) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, but with this test, a dwmac4 frame that only
> has csum_none set still reaches the XDP program. That covers an L4 payload
> checksum error without RDES3 ERROR_SUMMARY. On XDP_PASS the frame goes to
> stmmac_dispatch_skb_zc(), and that function never receives status:

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> stmmac_dispatch_skb_zc() {
>     ...
> 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> 		skb_checksum_none_assert(skb);
> 	else
> 		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>     ...
> }
>=20
> dwmac4_dma_rx_chan_op_mode() always sets MTL_OP_MODE_DIS_TCP_EF, so the
> hardware does not drop these frames. dwmac4_wrback_get_rx_status() reports
> them with no discard_frame:
>=20
> 	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
> 		x->ip_payload_err++;
> 		ret |=3D csum_none;
> 	}
>=20
> Can a packet with a bad TCP/UDP checksum get marked CHECKSUM_UNNECESSARY
> on the AF_XDP zero-copy XDP_PASS path and be delivered to sockets?
>=20
> stmmac_rx() checks (status & csum_none) before it sets
> CHECKSUM_UNNECESSARY. Should stmmac_dispatch_skb_zc() do the same check?
> The gap is still there at the end of the series.
>=20
> [ ... ]
>=20
> > @@ -5730,8 +5733,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv,=
 int limit, u32 queue)
> >  		if (likely(status & rx_not_ls)) {
> >  			xsk_buff_free(buf->xdp);
> >  			buf->xdp =3D NULL;
> > +			rx_dropped++;
> > +			error =3D 1;
> >  			dirty++;
> > -			count++;
> >  			goto read_again;
> >  		}
>=20
> [Severity: Medium]
> This is a pre-existing issue, but the rx_dropped count added here is added
> to the device-wide counter at the end of stmmac_rx_zc():
>=20
> 	priv->xstats.rx_dropped +=3D rx_dropped;
> 	priv->xstats.rx_errors +=3D rx_errors;
>=20
> stmmac_rx() does the same thing, and stmmac_dispatch_skb_zc() does
> priv->xstats.rx_dropped++. These are plain unsigned long read-modify-writ=
es
> with no lock, no atomic and no per-queue split.
>=20
> NAPI polls for different RX queues can finish at the same time on
> different CPUs. Can they lose increments here, so that stmmac_get_stats64=
()
> under-reports rx_dropped and rx_errors?

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> [ ... ]
>=20
> > @@ -5898,7 +5902,8 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> > =20
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entr=
y);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > +
> > +		if (unlikely(status & discard_frame)) {
> >  			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> >  			buf->page =3D NULL;
> >  			error =3D 1;
>=20
> [Severity: Medium]
> The commit message does not seem to describe this change or explain the
> second Fixes tag:
>=20
>     Fixes: 644b8437ccef9e ("net: stmmac: dwmac4: report Rx checksum error=
s in status")
>=20
> Is this change from =3D=3D to & the actual fix for 644b8437ccef9e?
> dwmac4_wrback_get_rx_status() sets ret =3D discard_frame on
> RDES3_ERROR_SUMMARY. It then ORs in csum_none on RDES1_IP_HDR_ERROR or
> RDES1_IP_PAYLOAD_ERROR, so it can return discard_frame | csum_none.
>=20
> The old status =3D=3D discard_frame test missed that value. Frames with C=
RC,
> overflow, watchdog or giant errors that also failed the IP checksum were
> passed to the stack in stmmac_rx(), or to XDP/XSK in stmmac_rx_zc().
>=20
> The fix looks correct. However, the body only covers the AF_XDP zero-copy
> 1:1 drop and the dwmac100/dwmac1000 descriptor change, and this hunk
> changes the regular non-XDP RX path on every GMAC4/XGMAC system.
>=20
> Could the commit message describe this change and the 644b8437ccef9e
> regression it fixes?
>=20
> [Severity: High]
> This is a pre-existing issue, but does stmmac_rx() in native XDP mode
> still mishandle split frames on GMAC4/XGMAC? For a non-last descriptor,
> dwmac4_wrback_get_rx_status() returns rx_not_ls without discard_frame:
>=20
> 	if (likely(!(rdes3 & RDES3_LAST_DESCRIPTOR)))
> 		return rx_not_ls;
>=20
> So the discard_frame drain above never starts, and the XDP program sees
> the first fragment as a complete frame. On XDP_DROP:
>=20
> 				if (xdp_res & STMMAC_XDP_CONSUMED) {
> 					...
> 					skb =3D NULL;
>=20
> 					if (unlikely((status & rx_not_ls)))
> 						goto read_again;
>=20
> skb is NULL and error is still 0. The tail then goes through XDP again
> and can be passed to the stack as a new packet.
>=20
> On XDP_TX or XDP_REDIRECT the code does goto next, which clears
> in_progress. The next iteration resets len to 0, so stmmac_rx_buf1_len()
> reports the full dma_buf_sz for the tail. Can that expose stale page_pool
> contents that DMA did not write for this frame?
>=20
> This is the same kind of bug the patch fixes for stmmac_rx_zc(), but here
> stmmac_rx() is only covered for dwmac100/dwmac1000. The next patch in the
> series, "net: stmmac: drop multi-buffer frames in XDP mode", appears to
> fix it. That patch sets error on rx_not_ls in XDP mode, drops frames that
> use buf2_len, and makes the XDP_CONSUMED path goto next.

I will fix the commit message in v2.

>=20
> [Severity: Medium]
> This is a pre-existing issue, but stmmac_rx() has a similar problem when
> napi_build_skb() fails on the first descriptor of a multi-descriptor
> frame:
>=20
> 			skb =3D napi_build_skb(page_address(buf->page),
> 					     rx_q->napi_skb_frag_size);
> 			if (!skb) {
> 				page_pool_recycle_direct(rx_q->page_pool,
> 							 buf->page);
> 				buf->page =3D NULL;
> 				rx_dropped++;
> 				count++;
> 				goto drain_data;
> 			}
>=20
> error is not set, so drain_data jumps to read_again with skb =3D=3D NULL =
and
> error =3D=3D 0. If allocation succeeds on the next descriptor of the same
> frame, the if (!skb) branch builds a new skb from only the tail fragment.
>=20
> At the last descriptor, pskb_trim(skb, len) does nothing. len still
> includes the dropped first fragment, so it is larger than skb->len.
>=20
> Does this pass the tail to the stack as a standalone packet with its FCS
> still attached, and count the frame against the budget twice? Should this
> path set error so the rest of the frame is drained?
>=20
> At the end of the series this only happens in non-XDP mode, because XDP
> mode now sets error on rx_not_ls.

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--GP/MfWl9BvU7lFD7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauB6OgAKCRA6cBh0uS2t
rOgfAQDIbO8+ywdj3y0cEjOd1Ng1xFi+0PbimDta7J1gyk/25AD/bjfdp9HiQ6wp
DiTWtNtRQw3Tk4vs7Nv29PoRt8pmpg4=
=klEX
-----END PGP SIGNATURE-----

--GP/MfWl9BvU7lFD7--
