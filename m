Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF160479863
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158189; cv=none; b=nRU8kJUAWnPTVVaF7rchqDA0w0bsZXaVuf3eOdePIcF0OxgsHvFRYPyX6xOJnQesBQcKYdO/69ffc/XDHWRjnBBXKHsC/W0KNLnFPABKx3pS9yV/hPZw8rUcCdKKHTmeKYzEmKolDIekV4pQ/6xSDfiHPjZ/+z62Wdkpk4iU53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158189; c=relaxed/simple;
	bh=27NDRv7p/PzfpWXoS/zZNQr2ctrGSxIFX0ZQ0a9Tp7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5VqQiiLqVEqvDUezO0jcvsnFykCfdP2KziqrHUnPl9Mr9d8KqK68DB8F3ZGiwWTxDrMt2h22h5UB9yXh6qbWrqOd8NVBKqmGGtfLChCuSeU5z5XQRJqrSW2z5PNAhinOC2KGVJM9jlB4bDRR203z+Yi8wYAl9VN3Vs+CF3tS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJ042nM3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PEc2cd/c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJ042nM3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEc2cd/c"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2v6k3409851
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WjGscos/B1PE5WOtCOqAZRk+
	UbUZMAQeunmZh02EZbs=; b=bJ042nM3DgRDhzbpaz3QpPZ4KeDxXVzNjcgvQq+Z
	/PgINWDk+drldnqz9WtBd1EKq2uodv8YpmHIypSVtJnRCrH091PGUbkL7JjaTinI
	z3j4WSiH3bR/yr5rxS9DpFY+1SkY8S9KqpGnlH252XDD0hcCH4M/NWOm6vj8kPG5
	YQ30BPb6wgqtfzX3WSzkht0HfF5w8hi8TSlR7s8vnZaI4MVpoe6xJteo6VCivLIl
	D+fTUWHC8Q2bQhMiZoWi4KvYZy3bv05IIUw52yPNVu6l6rlv4+d0kkn8dafHS6BF
	6CKFR7h6x1FbJDqxkweCYCBQC4Y2q15SP9/gnK3biAiEKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux863tr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:09:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f925ba4eso160427785a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790158178; x=1790762978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WjGscos/B1PE5WOtCOqAZRk+UbUZMAQeunmZh02EZbs=;
        b=PEc2cd/ceE5PaZURQUR2I01QrmVp4/4/Tu9e5KIgi/0Z2m5aKeVB8cHTaFddCnepeh
         h64UfE5aYc/bssKLzCsbHD2z3RCqD4HFBKsacbmnrXsb4IfCrwc8aFrjhd+awwzdpmC4
         gJSyZevQoRBchBl37Z8u0MYyu6MFqGIqe0mazE4F4pYZMI4kpsWzZZLoLociK02z59OG
         TKThPwvXo1X3KCRLYbrEEO4DLMVmxZq7Qq9E/eWHOYm9+xsaNUvA6Kyr589gwsApj86r
         3caKBQBwVYHReJLzJYtptXQ9XQgVWhBBLDanZecwdODhEW1kB62OZ/tfXA6/iTMcIy92
         tS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158178; x=1790762978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjGscos/B1PE5WOtCOqAZRk+UbUZMAQeunmZh02EZbs=;
        b=puWqWFazsxM/Ib3B3a0vtgV3Zm77YUyI7UJ6UQwM154hiqPinCrPJbAz8EqgFgXalQ
         AH/qcsUrsnOs+nbO/CcVa9OTUJVbrW+6xBWea+Y2BOr7y9u6BuOAeeMKII3lS2l1V2ZL
         YThkrzvXQS1L6mS6NXM8tS3VmRYXmAL5fgJfRyZObZVWPWEVyTdKmQ0gYmBOXh17fGvB
         gVPmYM51nDawC8M1e1xp0tjiG5VLNNC4uRAMx0jsbo7w5BT7gL296ro2BSKvupTCGOaU
         Zl541BneuR2+5vizbBIXME+8L3MFuRqTc9mzvOLHU4tv8HfZr9820WbNt9yvZq9lmE/4
         WuPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbu9a2Rqlq82oO3J8uQGYH5Bfvq3v/uQyGyQG5ZLcAdVlyTfBluKU6HjaUoRrPTyU+ij0=@vger.kernel.org
X-Gm-Message-State: AFuF++mD2/aEtFGyxVOZZEOu7iyerjzBR5i7KglwyVnVTqX0hNhUr2Fa
	Bi32WH6d/kYQFcoxrjYxpMPxLdcGO/ySNDejPjciZKvCQH/l4o/ncphiA8LPwK/kDdHOuM2XmGX
	tf8EdpDji0qu89THxeu5O+cmIl9B+D1W2ZdRhVSgEbTkasjVQG2olL4c=
X-Gm-Gg: AYBFou2WBSw1Mcr+ixZl5wM8v+oIQIQUqpuU8gIyPgvodqYuNntCmFi24+12BTVjXAd
	doAxaQ8rllgWdKyebQA9AFT/mZMAnYhSb8e5WpVRasRUSsv+JtTGdhWEtBAmdRdF3hUiCKlXCQt
	NISOvidtQ1RvIX6ZMYFi1I4seXZBFD2hz2w3wF9eLh1aw4adLrSxsfxlFv38kcwkMWS+sMOpiwh
	u09HU/tczSm59ITJCImQ9mWtbOQzey2Xfu6km3WQBqrYpRLcpPsdlPPTD0Wgvm8hZe3qzulKsnQ
	SGJh6cz8i7SyOfkL1X15ASl09+3YZkzS0QYrK+8ZLoHqJHeVUqGp1daOPdwcNY2bq5mL8pUrqEc
	MTED7GCp2YkeFqA==
X-Received: by 2002:a05:620a:6f9a:20b0:93c:29b3:3536 with SMTP id af79cd13be357-93c29b3421dmr114400885a.36.1790158177759;
        Wed, 23 Sep 2026 03:09:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6f9a:20b0:93c:29b3:3536 with SMTP id af79cd13be357-93c29b3421dmr114397585a.36.1790158177068;
        Wed, 23 Sep 2026 03:09:37 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm63138295e9.15.2026.09.23.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:09:36 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:09:35 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between frames
Message-ID: <arOlX0y3-wNMoB8L@lore-desk>
References: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
 <20260922190118.1f1ffb81@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qzm8HG7bSHfYQdPa"
Content-Disposition: inline
In-Reply-To: <20260922190118.1f1ffb81@kernel.org>
X-Proofpoint-GUID: jR03fdu8kEQ7pzG6KaOVITAGCtB-uDJt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX6mbYku/EvZRy
 Ol0nvck4g30zyLmPFh8wlBHTlUmKyfTyqjRscl0ndPNMLfNRTwk32bdD4foW3tLb2GxjyA/dz5M
 WolEXCM09ZVUp283UDAghj9YD/o+/uI=
X-Proofpoint-ORIG-GUID: jR03fdu8kEQ7pzG6KaOVITAGCtB-uDJt
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3a567 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Wk1q40mINxl-DWuuGNYA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
 a=2q5E11mNeA-3wjOBgwEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX4/SdA7163N3W
 XhWBYgClXUsgCBp8KuCGHz0repo7xmGJnKxJY6l1A9gl5Jb7apUuwf98NrMdMJTp6+hEBKdwlYK
 9J0CzGzJv92bTbACjqtCS0LD0wwlFcUEC7twl+ss+q/0+A+GeA9s9qSmg5q127DbFCj2rNMfZTW
 9yoEYas6ERB6xEI8sCBKc4R6wsdU3jXMndE+Nr4eEVHSdndQoUgZDTTS6Y7JFumA6YwY6KWKCIx
 iQagtXI7VlfrV/InPU3dAMqBJMs9dCbjx0qf4chS9HZmKZxUPqpEJgsBJp8ux85pXiGd6sNXBCN
 DDtgsO3O3no4SmZEsgvWRzwW5VD7sA23gWdsOi137EwXrH0fRz+KWujaTuRuaBHZndEaVcI46oI
 tDAhPGpY6spaLMLFgUKWr6+HgCeWRl/N22j6G6xOorWEDKb4emNwc1ffoJPTU4Zk1IRQ85rk1dx
 cO+aMrmHZlK5za6oe1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230039

--Qzm8HG7bSHfYQdPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 20 Sep 2026 09:55:09 +0200 Lorenzo Bianconi wrote:
> > In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
> > xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
> > reused for the next packet and the flag is never cleared, so a pfmemall=
oc
> > fragment in one packet wrongly marks the skb of a subsequent packet as
> > pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked =
for
> > each new frame.
> >=20
> > Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info =
utility routine")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index 543e566425c1..32416999f3d6 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2341,6 +2341,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
> >  	/* Prefetch header */
> >  	prefetch(data);
> >  	xdp_buff_clear_frags_flag(xdp);
> > +	xdp_buff_clear_frag_pfmemalloc(xdp);
>=20
> bit of a trap for your future self to clear the flags one by one.
> Should we not write the flags to 0 ? Or maybe add:
>=20
> /* Clear xdp_buf state for reuse on the same ring */
> static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
> {
> 	xdp->flags =3D 0;
> }
>=20
> and call that?

ack, I agree. I will fix it in v2.

Regards,
Lorenzo

>=20
> >  	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
> >  			 data_len, true);
> >  }
>=20

--Qzm8HG7bSHfYQdPa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarOlXwAKCRA6cBh0uS2t
rM3tAQCYKmgng//tYI4+xIQ2ArUjBsrSxxUUtF4YIPt1WcG6EgD/Qn+Q84ka9ZDQ
9fGp7+cYn26JOsS60d0sMg3NhFxx8A8=
=rdTF
-----END PGP SIGNATURE-----

--Qzm8HG7bSHfYQdPa--
