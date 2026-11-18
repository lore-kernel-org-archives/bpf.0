Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040849;
	b=L9P2DvP1LQnHwHdtbuItWIg08rcup821kGJtqaxkTRYb9FiRlSafxFv/txGMTAexmc8e
	 2Pz4zFOyGuygiFku6WttsS7MIyKOAor7NJ3OoY7pV9wyei3B6ckr86PAUgyas5/HENtN8
	 IhteXXseVZfudHEiRB8/EgmUC9z3WHvYuiywQ7zHva4AAkKYIBC2Ku2/o8KYXnqsRBPcG
	 48s4YK8qucnGDaILvnfH/8ZqKLwfbaGmK5wsqUFXu5KSBeOn+lQIG4lGU5ePC6TvoVkCI
	 BiC+/vxIcyq/KFHHKgoJa64GW2U0lkuk1La5KqGC3vBYmlcCME7PWydt87UWMsvUwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040849;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ftD8DmGQkcZjK15m6DJUKldknKn9HL86+LXMBeEyEhA=;
	b=Vd6FKgZVCzBOoKWS6Ssa4zMMpaFn8/nxFtjqOVvxhuzwaBkU95evXpck6NwWELOYJAEN
	 qW1OeUDB6gS68yEniXft5mAHJUV4oAIXwRW3U/ePNPZaYgd6iKM/6kLpUO7LjuXxUsfph
	 OPRqvj4FXsgiRBo3shHqY6B6vQvYT38KE9Q9nKtOj25D92Vmc8o88hWtPOhSBph7Tdoc6
	 8v3pLY8wIZWRQLd2P15CZeCPLDgPeP/Qfe+vWH1FXPqu+7QyYl6LGUtSNS7RxwzcIjgcL
	 y+qRbrYCV4mqXelJS74+7GfPD6wu2qsdQFWbkFsujxilXtH1spDwQAhsfS3fT3prnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hr05ilKQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvNFqmx3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589E606A32A
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3589E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hr05ilKQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvNFqmx3
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILD3ln3942649
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ftD8DmGQkcZjK15m6DJUKldk
	nKn9HL86+LXMBeEyEhA=; b=hr05ilKQkSd2mpJcHe5wzTnd1c7tIC+Fgh2zfTpS
	jAGjCz235xJ623wENGYLYV4Knp2AkwvmEPnIa4VA7C2Uq6bKM/ofFt++Az4NWK9m
	7q23WjxSc1LaXexEtl/A7etlb6allS3ICI4uEp91zDmcxHjWtJjWPK3U//QCBlWQ
	y59BeTvCw7nQXV/eWetnCNIpFdzAh0h669KZUSyIeKz1CrpmeAF5eB9n7W+R1dix
	FRiEs/wMzAwrdB8oLgrgIJU6HXGepMWAo9td4pOgfTJOrajXaSAeQ5DRPoZdcqzF
	Ghtv8b7M990WEEVuPsjmRZVx3RJ/ged0QNBIjUe3r+HJFg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1etnspw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:27:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so300804085a.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795040847; x=1795645647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftD8DmGQkcZjK15m6DJUKldknKn9HL86+LXMBeEyEhA=;
        b=cvNFqmx3EBa8yA7mXhX7Kvvpz52dQguUGy3PeIvN5rmfPtYED5M7TfjJDwfTxindoV
         q66cAL6/D1Daiqm+2r4Dv+9dhcVw9llclnHIOFZGPylGBMIEMR2ujDHE8z/ZXL33PjKy
         bkE3hs7N3OnTPy0T+MrK3fgv40c2DBeN1zPL6E5R9lGwzxndoeku5sXUcVMhbTTLgcgp
         OsDnATu1TQ3EJyQEaxP/Wu90s9uxotYGnTzjyAEOt+JbLW+ip2OFQsdTbNVnFzgWYhhp
         m63bJnXVj3SQFOWWGsx1NAI0DbNO+aota9KRyEQV/GvBe/5LtJ+UPBggVIacfsTbBmr7
         cgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795040847; x=1795645647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftD8DmGQkcZjK15m6DJUKldknKn9HL86+LXMBeEyEhA=;
        b=g7XVYllZmLWIdI36fvU5ONljztYIqStpfAOBlkANwZqwub4HDbr94auVlBSvfKv4Wd
         F2x9PJR61fzNpbopPWTBXFqnUfA+rWmDRJfUw5KmDe2YTPft8VCmKVPGB4jgtR2ld7Ht
         nmt2od+2jrIqEnUKvGsDeydKVhjtyzTZB54jM5hVLfsIsWzwF2gsE/JJ935UJI/5uoJ0
         Q0/FIqOUiQMsv5n0d10poXEphv9mi7IDQKddclYahFWAvcp7scdsV6q83o48Jqmh6h3C
         DzU8Ytskvn+P8N15t1Cc0yX7FKojJOfv/IPMhxwraztisFCXe3/gzz5uKlQy0L+K7Alr
         fyvw==
X-Gm-Message-State: APuU4Z+8vbmYFVFmymGI+cTHkBJgiqlEVgNwoyVHrPLcysbSvhkiHzQH
	/KwhER1Dh5aoeYYsV1pek+ollRYHSU12icOvvpiwqNxwSZnq3PNzRES0v7xge1MKR2lGGBefjEz
	afsdX1QF7rK4FczKF5huYr/b61ZbdF9hFBuRuEPA/gFIEO+s8tIR9yoo=
X-Gm-Gg: AYBFou2QZUiiWcRuW7gdVzre3MPwGqLToirhmLgbbkzQDCdZapuCcEjXo6QIopLh/4o
	5FG4vwQTcz/ntOnU6sAIT4nMarM20X8ZbB5zITFk41C2Rg0zQQseZzPwpjM4XAqWtcB5luLwzwx
	tRmfmMfsPKVPVmlkHj0zC2cBoigCI51N5vIGsQ2q1+IVoFsGmEMhhF/WBzO7/wbYqZSOWx1h7OS
	LSfRN1nd16hDSaxsLVV0BzwU9zn19BnGgInx/BdQiC/TYmFL+xE+TZqadDCP62z6C66U2YvHjrt
	neB7gdmSDcR7RTgoiX6+BYaUpTUZg7YfFLWlZx3SZU7nsZ4DqIMm+yg6SWdaYqRV11m5PGbvd1v
	w+OUXTPBENr77X59AFTgZGonKwbNew9bUJXidxPHNtZ5UY9ChdolE8rj2PW+fSIk=
X-Received: by 2002:a05:620a:450a:b0:949:94ff:9967 with SMTP id af79cd13be357-9499964e541mr712021185a.82.1795040847241;
        Wed, 18 Nov 2026 14:27:27 -0800 (PST)
X-Received: by 2002:a05:620a:450a:b0:949:94ff:9967 with SMTP id af79cd13be357-9499964e541mr712016485a.82.1795040846469;
        Wed, 18 Nov 2026 14:27:26 -0800 (PST)
Received: from localhost ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb845229easm2906505e9.14.2026.11.18.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:27:25 -0800 (PST)
Date: Wed, 18 Nov 2026 23:27:24 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix num tx queues in
 stmmac_xdp_get_tx_queue()
Message-ID: <av4mTCg0yVhGXQdU@lore-qca>
References: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
 <sashiko-outbox-221383@kernel.org>
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
	protocol="application/pgp-signature"; boundary="C73daWWgzx+5qrlj"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-221383@kernel.org>
X-Authority-Analysis: v=2.4 cv=b8UncdGx c=1 sm=1 tr=0 ts=6afe2650 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=9CbV9yVBjN83Sfyp3LgA:9 a=wPNLvfGTeEIA:10
 a=nsqPKTQ3wIGvu-rJs_4A:9 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: V1s3ELNI6oQJiFSIY8I01omrmBO4nEGw
X-Proofpoint-ORIG-GUID: V1s3ELNI6oQJiFSIY8I01omrmBO4nEGw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4MiBTYWx0ZWRfXygO0mz0bq3K2
 tr6cBkK8CBGLAfWOdjg0WAhpNJxKAGvWxreEr4+vrL06LN5dQVhKGDj1Nf+mEZhVHwXUek/CDqx
 exJg3FJvuYcJZytoWwmMwmYVYmAvYT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4MiBTYWx0ZWRfX6eYFIm0VxLw6
 6W/m2CEP9Jh1XdQx1EkZi6wr41E9oyGT+8G4+hxLTKH3IT5vBzhOYi1ZcA41Bd3qTKO0nHoUiZ/
 JVRevieXoS8mwzzXVddpHi0gdHieBUHL4F2ukAt0vPlYcsKcX8YsoQ75Pg0TYWK09/49pvShWcM
 35fculmASKFKCAkJ2jJeh0t4pUx6OwP+gxRc11q1Hmbv1KuIf+0Tx0acbTp9LvyXVL7hrnBX416
 gu+OqigVD4UCQKMJpm2kGsYY1qB9nYTLwbON4Oj/HDAJzFrV7FDeDfewpsiDuUc2BQaxcNMHN/P
 3E2D9QW+wN7C9v/qUuUmCRdkm5YZ4ELeo0HtCJIUZYAq9rIOGjJG25PYaIT3Xgna76kf9b/biDa
 zWJHXBOqoQWTypkrNzT4pD6JeedfHktJCooOcl5gvSi+cgZAZQceZaA2a1i5OcCZuF3edzZQUqq
 ZSU+ixkygTvS4j+8g0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180082

--C73daWWgzx+5qrlj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] net: stmmac: race on num_tx_queues in
>   stmmac_xdp_get_tx_queue() skips txtimer
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [High] net: stmmac: unchecked return value of
>   netif_set_real_num_tx_queues() [1]
> --
>=20
> commit f55af370614a4d0bb79d7ac40f036cd36c0c9e78
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> net: stmmac: fix num tx queues in stmmac_xdp_get_tx_queue()
>=20
> This commit bounds the CPU-based TX queue selection in
> stmmac_xdp_get_tx_queue() by priv->xmit_qdisc.num_tx_queues instead of
> priv->plat->tx_queues_to_use to stay within dev->real_num_tx_queues when
> tc-mqprio offload is active.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 25894771e9e9f..cf87afd273439 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5408,13 +5408,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_p=
riv *priv, int queue,
> >  static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
> >  				   int cpu)
> >  {
> > +	unsigned int num_tx_queues =3D priv->xmit_qdisc.num_tx_queues;
> >  	int index =3D cpu;
> > =20
> >  	if (unlikely(index < 0))
> >  		index =3D 0;
> > =20
> > -	while (index >=3D priv->plat->tx_queues_to_use)
> > -		index -=3D priv->plat->tx_queues_to_use;
> > +	while (index >=3D num_tx_queues)
> > +		index -=3D num_tx_queues;
> > =20
> >  	return index;
> >  }
>=20
> [Severity: Medium]
> Can stmmac_finalize_xdp_rx() arm txtimer on the wrong TX queue if
> priv->xmit_qdisc.num_tx_queues changes during an RX NAPI poll?
>=20
> Unlike priv->plat->tx_queues_to_use, priv->xmit_qdisc.num_tx_queues is
> updated on a running interface by tc_setup_dwmac510_mqprio() and
> stmmac_reset_tc_mqprio() without stopping RX NAPI:
>=20
> CPU0                              CPU1 (<softirq>)
>                                   stmmac_rx()
>                                     stmmac_xdp_xmit_back()
>                                       q =3D stmmac_xdp_get_tx_queue()
>                                       stmmac_xdp_xmit_xdpf(..., q, ...)
> tc_setup_dwmac510_mqprio()
>   priv->xmit_qdisc.num_tx_queues =3D n
>                                     stmmac_finalize_xdp_rx()
>                                       q' =3D stmmac_xdp_get_tx_queue()
>                                       stmmac_tx_timer_arm(..., q')
>                                       <-- q' !=3D q; q's txtimer not armed
>=20
> Because stmmac_xdp_xmit_xdpf() only sets interrupt-on-completion every
> priv->tx_coal_frames[queue] frames, uncoalesced XDP_TX descriptors queued
> on the old queue can be left without a completion interrupt or timer
> cleanup.

ack, right. I will look into this issue.

Regards,
Lorenzo

>=20
> [Severity: High]
> This problem wasn't introduced by this patch, but stmmac_hw_setup()
> ignores the return value of netif_set_real_num_tx_queues() [1]:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_hw_setup() {
> 	...
> 	/* Configure real RX and TX queues */
> 	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
> 	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);
>=20
> 	/* Start the ball rolling... */
> 	stmmac_start_all_dma(priv);
> 	...
> }
>=20
> Can netif_set_real_num_tx_queues() fail with -ENOMEM during stmmac_open()
> or stmmac_resume(), leaving dev->real_num_tx_queues out of sync with
> priv->xmit_qdisc.num_tx_queues while DMA is started anyway?
>=20
> [1] https://sashiko.dev/#/bug/linux-1bc77f7b-c8d8-4341-a8a0-49092e607be6
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20261117-stmmac-fix-=
xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com?part=3D1

--C73daWWgzx+5qrlj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCav4mTAAKCRA6cBh0uS2t
rJV1AQCnviCQwmto8ElWVktDx7u3UYI3e80KwQ2VPBGPIwgbIAEA4/BKyVksjYBS
QozICoYQwmzliuxbjmyamjii9kNzIwY=
=kcC7
-----END PGP SIGNATURE-----

--C73daWWgzx+5qrlj--
