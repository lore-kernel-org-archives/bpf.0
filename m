Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9293DA5C1
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412229; cv=none; b=prXCPCui4EUy7oQJ4nJDJ8BOWzrVi31SAIY3oJB1EXH/WnkCfbkM30NQ1PLqSFBlfBWXG5ZgnMjdOj1QISLA8vEwJ8ymMGG+90ttQwPS8FtbDbhHVRWzedSCnBqAbAZH9PzEhOWdObPY9qciTDqaKGJ6uAE2Nzi8nyZPT+iuxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412229; c=relaxed/simple;
	bh=+pSy3DPU2Po34m0TQbmA5G86fUmkQZxM+OSDCb/PMvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bohH36oZTltlZy1SI1BX7EixnePBNubCFl8hWNHH1a5ckSKmjK8fVIYVZQ8ycmFXq6JO9c6cvo03t2bqpRVqDn/3xIazPHuduKKqrmpjpjcJEBAM6rVDACRAO/oxXrJWkFtaQxfAdTr7M/nvmA/caOBM4DnrftMPTE+7wB5Ir8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lOpYNIT9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKMaahec; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lOpYNIT9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKMaahec"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P5me1896526
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sl2PyeEgwA2sMKNN7tpj1e7S
	nnbx1U3YT5+hgWgDo1Q=; b=lOpYNIT9Bd4SX1q+mz916Sz5yHYqWS5IfKIf96aC
	DDzL/emt8rae588DLrk/9COBhU1YD/yFfZokZeK3bcU7pjce2wGe1zqedCG6+jG0
	9d+beKOmtV6aFbraoUi4JCDUzrMOiS4Mu9DCY49Y4IhuPUqNpVeJGD1T1aRdSk7e
	IuKlvUl4m3PsFkHptj5dMet1/fg5nRZVmhEswbu7H3wZU0b0j4VnPfIHU6mjOcI4
	G7BqK2oLvI8vE0lJQEt+4u+szl3GQrKsxW791itqh6jFYBuKmbY8Q9qt/gysjKTb
	jVtbYJ/p06FagISjOXqDJxswAYtP+OjJzajnFN5Mn3tgJg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr9sm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:17:06 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc0418036bso115632137.3
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792412226; x=1793017026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sl2PyeEgwA2sMKNN7tpj1e7Snnbx1U3YT5+hgWgDo1Q=;
        b=AKMaahech9AiWcOszg6UqdYrbbmsDyY4WK0BminL0UEQ6IFdiTmLJvn8DJTRZx4zeI
         lasaf2wcNz4VRHEPrvAgWJU/vPxl4GIvGATjCzzPnRRzBwC4jlXoaz6D/hQ4QOFw6mgS
         7ypOzY6DyUmbkcsa4jTsuRoYfc0jH2pYrYqrz0SvmaQu442iGlL/cEoaowJpTo1M8ybm
         XTylTCqTfF9HBYsdnFF6jgasSO6zftECesRwX4bNh+58z2cXqRWCf1OE/PX9vxAeTYqF
         cgQVY1XB/V5Few4xBSerWSp4eaPoCWWU87UwnZIPowe36C3K7+Zkk3OOqKOHpIgZBtHB
         cbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412226; x=1793017026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sl2PyeEgwA2sMKNN7tpj1e7Snnbx1U3YT5+hgWgDo1Q=;
        b=akdIReegmbkvXRcre0doZCdDjwR2K0dTITzzFUeJifFsBebI80LDxAxv+sTyMkcv8w
         EluTx/Q8a6VeJiQgOfbi055UVH6wFgYGORjEeTH/Iy2aX84sTDy4r8VYZod1nSY9p3Wh
         XvieW1DZO64qoizHbNmauAPt6cLVh1PFq6fUyDI+k0J3ZLK6s8+cQ501Eq+YB+XdIWBx
         nnaGtMYlJuCWPNdkGsFBatkEU47h/xq+maQwB48vuvhqObLZZbZInTx3/SwJCAw0BnZj
         Uzvlpy8hzgKVCSB1JnYk67JlCffaTgR/JESbx6xJbJDWogcZQb52WkB9oqid2hhVjVir
         8e/w==
X-Forwarded-Encrypted: i=1; AKwUvBwDfR0c9CzJ9f347E5B3N2FJ36yPNRO5GOZIxZGBqoOq6t/NtKMz1BSZy0ci1jdqEGHF/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc5PgjF6rXG2aghJfNSdGiu073tGOG6GgnMhfivVf8Yhl+XPOp
	+nGtZIBE2K++MvxcWQyP6770H59mFFdfKILP6Fqay57JeV80jPMbXEpBDpIanhKnN1THT4Wzgin
	GvpngU7l9u8Y2VpmLjIRKYHxGkxh9GBKuEfC1BOCiIwSfGYvKCyB0hZv4NObZhls=
X-Gm-Gg: AYBFou2jOdCfmWIUjG1WIvxLSws8MQn7orZ2E9YJ1qoUJFDl8mcw/O3K9spG2QLRPcc
	+LicBOnrDUMqcP36XdtZsWDSMe/hI/mn9AsirjYF4Rd07WNW2VqGm91NX95riwf75VdCtxJG344
	/zZ4EsNlYmM1nnSDxxpVCIQLvWZxHcQc1KCZE0oBEevnEyRyMFFdbqPx/1oWaqFCPoASYeci7k2
	5g0ZMfrmsIjmcbVi2pGJWtcooJ++XEBxdgt8LtKEUL5kChuK5CIzQ9HyZ+L6RNQLPgsGxOkMVrz
	jKBuAYlTzs4dnZM5CJPth6X5yfWCTHX3MuIMqUXJ22zfBYAVSkm6HOOYKqNobW1u7f1HL4WXxak
	BHTsDP5XZ9rItKg==
X-Received: by 2002:a05:6102:3c92:b0:7b3:7653:5487 with SMTP id ada2fe7eead31-7cc36af1428mr1517786137.32.1792412225564;
        Mon, 19 Oct 2026 05:17:05 -0700 (PDT)
X-Received: by 2002:a05:6102:3c92:b0:7b3:7653:5487 with SMTP id ada2fe7eead31-7cc36af1428mr1517767137.32.1792412224510;
        Mon, 19 Oct 2026 05:17:04 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm271272245e9.6.2026.10.19.05.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:17:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:17:02 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
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
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/5] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Message-ID: <atYKPgSrad4jAsJM@lore-desk>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <20261018-stmmac-rx-mb-v8-2-5f58c0b25849@oss.qualcomm.com>
 <8c9e47e535ecc8190fa1c93ad5b5e32a@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RucSXeWTOi+YV0bB"
Content-Disposition: inline
In-Reply-To: <8c9e47e535ecc8190fa1c93ad5b5e32a@tipi-net.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX6gnWHqtSCTWU
 vKcfkuu4RbKh6TeHJsYgdN2L+94MWa+r8vwpFeURQo4uaHJIjs9DTiwTe9VDuZtPPWCrytbLUcE
 vOOJ5IHoPkZtHVyJpCyF30Id5Zthsruxefeyl5ugC4v7DRu9i6SskWpYh5tgurOdLeVeXaPgLPr
 +aJwvBGlLOOLyv+YfGCnDM7kx44Jc58SaW79PlPjXPmm4kvvV3WQLKhD+d4fMtcAY6s04XYaYPI
 p0klre8t7sMta56m8Lk92gpWvsTHsBDfmYG7v0Pg11VMrZgpJbsLrnQFkuW3CZJGZlXWLPeorkM
 9+RJUdg0lPGuG6qbPb5zRg0ca6fo7iHoT3Xd/ZwwgOj7FSwAjAdShjfTvR+GGL5/l/Ftky+jBYR
 Uubz1SWIx+Mf/Ram38HvSNEMBEoZMLbV3Z56RJMR+V9XAbMkXwf2we08vE5jIUPAE9wdqbwyF1f
 s8qySud1casWN5+00bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX9P+cHSijSMlc
 ktrZt8MDUVuHYaVJj2QTyKwLVKR7PpfZBbuIVsDijQKawCVHm32e0aO9z5DX6G2DsxJrq6ve6VP
 Llpqanm38CZVl8Gn7OBJmQQV8P01ifI=
X-Proofpoint-GUID: lSS5DuBd7i0ONajH5HTdzx0G8btu_R7A
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad60a42 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Hv1B4VqaJksLaqeBzrcA:9 a=CjuIK1q_8ugA:10 a=Uhvad6e0Kplh35gtGjIA:9
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: lSS5DuBd7i0ONajH5HTdzx0G8btu_R7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190048

--RucSXeWTOi+YV0bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo
>=20
> On 18.10.2026 19:07, Lorenzo Bianconi wrote:
> > stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
> > XSK pool buffer and drops any frame that spans more than one RX
> > descriptor:
> >=20
> >         /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
> >         if (likely(status & rx_not_ls)) {
> >                 xsk_buff_free(buf->xdp);
> >                 buf->xdp =3D NULL;
> >                 dirty++;
> >                 count++;
> >                 goto read_again;
> >         }
> >=20
> > The non-last descriptors are freed and dropped, but the frame is not
> > marked as errored. When the poll reaches the last descriptor of the
> > same frame, error is still 0, so the fragment is handled as a complete
> > frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
> > or converted for XDP_TX. The tail starts in the middle of the original
> > payload at a predictable offset and, parsed as a fresh frame (len =3D=
=3D 0),
> > stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
> > though the DMA engine only wrote the tail remainder into that buffer, so
> > the reads extend past the received bytes and can reach beyond the end of
> > the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
> > in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
> > when the interface MTU is left at 1500.
> >=20
> > Set error when the 1:1 mapping check drops a descriptor, so the
> > remaining descriptors of the frame - including the last one - are
> > drained and released with xsk_buff_free() instead of being processed as
> > a new frame. Account every freed buffer with dirty and count the
> > dropped frame once in the poll budget / rx_pkt_n. The direct 1:1
> > mapping drop also increments rx_dropped.
> >=20
> > Normalize the legacy normal and enhanced descriptor callbacks to report
> > rx_not_ls together with discard_frame for non-last descriptors. This
> > allows both stmmac_rx_zc() and stmmac_rx() to drain split frames on
> > dwmac100 and dwmac1000 instead of reparsing the final fragment as a new
> > packet.
> >=20
> > Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> > Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>=20
> This grew quite a bit since v6 (legacy desc changes, stmmac_rx() etc),
> so my R-b should have been dropped. I had another look and two small
> notes below.

Hi Nicolai,

ack, right.

>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
>=20
> > [...]
>=20
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5695,18 +5695,21 @@ static int stmmac_rx_zc(struct stmmac_priv
> > *priv, int limit, u32 queue)
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats,
> >  						  rx_q->dma_erx + entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > -			xsk_buff_free(buf->xdp);
> > -			buf->xdp =3D NULL;
> > -			dirty++;
> > +
> > +		if (unlikely(status & discard_frame)) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
>=20
> There's no !error check here, so on the legacy descriptors a split
> frame now counts once per descriptor in rx_errors. stmmac_rx() in 3/5
> counts it once. Could you add the !error check here too?

ack, I agree we should align stmmac_rx() and stmmac_rx_zc(). In order to av=
oid
reposting the full series for this change, do you agree to address it as a
follow-up patch?

Regards,
Lorenzo

>=20
> > [...]
>=20
> > @@ -5883,7 +5887,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int
> > limit, u32 queue)
> >=20
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx +
> > entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > +
> > +		if (unlikely(status & discard_frame)) {
>=20
> AFAIU this also changes GMAC4: a frame with an error plus an IP header
> error returns discard_frame | csum_none, which the old "=3D=3D" let
> through. Dropping it is right, but maybe worth a line in the commit
> message?
>=20
> > [...]
>=20
> With the !error check added:
>=20
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>=20
> Thanks,
> Nicolai

--RucSXeWTOi+YV0bB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatYKPgAKCRA6cBh0uS2t
rEsiAQDQamG4derazgJTTxn7SZMOZWRJHjCj7eJxazZzk/TRsQD9HW+DZjAv8DRc
o4Rs6TsL7BDw+otQr4rfMam5lAKUnwM=
=n+5w
-----END PGP SIGNATURE-----

--RucSXeWTOi+YV0bB--
