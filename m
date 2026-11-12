Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481790;
	b=ok2ENidc6tzKBsGVPxxPk+o95Qq8YLCwVB2sGSJlBYk/tQZk9Nnzyl74qjWzzVopN4o2
	 1+zyjr/RLNwcHLxlmkKSwsi4axt+o/hFqJOQM/XKgLAEdi94IYXS3gx9EwbA4AReNXPyf
	 N+VRl92oBCj90wsIAbvP9P/siSfe92IAfTbPF2wXhoq4uj/8h5jlOq3zt4IfdifVGTo8G
	 MnCl5baWNoixltb7DHWLT62H5jfpb8pDB4VtXLFFMHnBd50DyWVan3JCoVLUHCcyNO0Fk
	 QJdRS3UZERSquc3SMtvDhHALeVHYPqmbqkGEEzBM8/jLGBo4aCwdRxy+SSKnmXbYOgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481790;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:o:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
	b=RwVyMDwyQKdD/io3g7xaoFOWewuBnrl7hoHhcrJgfJ2x0IFKUwwvPQk70TDOGXnFlG5F
	 DySxm9j+Yg4LHVjBHspzGlxF01OIjKJ0atqmOYc/Iia5D2CaPy1mFO5pZnUMcM068dOFc
	 3EcuKgmtcIFQEqsHwBLvq7EVXgQqkMjiBZYQlmeZfB2SAQ3KdUCZppsOPRFeJocXaPniA
	 qD303JQxZAiMG/ynEDoM7kEtzuulrkHIBDUW2RgpaNXt9cRxFvwALKO+Q0I6bvn6IQ0Vn
	 ZW6FwiNY/hxk6PSj/53j3pC2r4lxyeMKJSvb30/jJaAm7/zEJImik3RAL/cnPZKWHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZRczmZN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTZjtkJy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9A606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F9A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZRczmZN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTZjtkJy
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACB4cj63893148
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject; s=qcppdkim1; bh=N8Sxm8XiSudcNG9BW8w5hvCi8/C
	mVau/gswvd5wgkPk=; b=aZRczmZNEnYsaFzeBhuPfu4rnEXN04hXMUB5/K7TEDg
	I/Ww4v8ot1+yIuz0l3V0LWg3kplM2IweieQ+Ga6VIhcJpbK2enkqkKywJ0jVqXUD
	FmOWV6/mnzhWUM9wAG29dHJEd+QE48nTlX4ga/AiOwk/Rq5nafrQORIBGzTaaBnk
	/enlTcT6fCXQPuxivCspDFfp8tKlVxt/TjEtsuFkNMNv8O3iMAPDW+yaCrlFQWUq
	ftvzQOWzupdzxSXKCiJ69t1EcQSYbAi8pJ4yhwpvLmOwyEldRkkK/6dUd0Jvtvcg
	L8KFnOttc4fEshfUlaEHwRatzwPpRqcxexLL9gdstJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re19j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:09:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f5844cb60so164373285a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794481788; x=1795086588; darn=vger.kernel.org;
        h=o:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
        b=ZTZjtkJylXZu4lpuwE4nE+o+M6DP2vhg9Uxb2VlJcFNPpnkPeK77zaTMRxAMOteVr3
         9Tm6NWIG91u+pSOfthuw/KqZ8/9MWcvRBEoIsIz7ig2xfGHjcz9BkSx7yGWKAW10K7LS
         7+JenCZ3j7nNFN9kCVO7hKJah+mrU0cB6Vq0ozeps2OANijbDqS29QWTXp4Sq0nHfE84
         i6BTH6FpwRaVOlMIZWMj6aYQPsz9yBjaOpynMV6hfNiXuBcfqznnUTzEYxd/H46P2zcC
         g2Ed1w90n0c83z4Qeoc/us88o3ybk9JbBWZK7aiC/XwGoASae/JtxoW7dHSnHE5QJn9Q
         RZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481788; x=1795086588;
        h=o:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
        b=sf/aekrPzLsCky5jGsAIdAxMt8sCJdOvhudsgyHOaojrrkSUs0syXvHTZ1Eoo2NTie
         WevjuUrPLj4I+nvcx2zJstgIv2uLNWzBeC6nm0ePei5owlc3Anr9Uxzi2qv8KXYedeLC
         MEnZHAfgI8OzL6XCD6LDD02Xtefy72/ErVBNLPS/6N6VWJ6uqnoNstIVpIrNUtvp+enV
         Vo/wnmVYW+6YRmvRI3GA2JalmPbLd3mOQsh3jHotQD9/wvcZXFhou7442u27s5Ez4VHk
         qhQTh/ENEaXqG6frJLMcHdlGdVQjZEUMfmRM6FJU11C9bQl2cVrvWUwE+WLExPgZQEjT
         Zwiw==
X-Forwarded-Encrypted: i=1; AL+hErHAp+b4uRF9EXKgZhaoVPRWg11ZnnD/BkqRLn9tanFSO/qdmrc1t1AluJLMxuR+P3AxymA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q8/JbsXWdoslWlVSTzEucz6WP2uFo2ukAUHr9PDD8vQ0NH/9h
	J9Y7P2jtQAEc1HsOWHA/7vDkw1kSeTRmV9/pU0rBCOFrU6z7/xhH3vOo5Xw4WGHHGAmH9q3OC3d
	4aV51I+Vt5wnMDbPPWuNAzJcBk2GTfIJn/d0B7CrishefWllPOxRr/9A=
X-Gm-Gg: AYBFou1AQYD2TxIO9rDLL3s9ohHRfepmEc1uv5AuTjDsxRw9hUGWYUhdXO+kCIfRJZN
	/Ul676EpiM1QE8W17nEyYZwaXta3vjqa46bl9odifZTl+dyByWqrhZMlsv6TYQZZNC77WCjhnyy
	ahiJTIC5H3Jc4Ru2b3MhSRyJtTld0BHJOflYf/tUJXa3IJZmxFWwNycwrwFwAcauPhfuwGw9OPP
	8/I4edXi867OqOeiKeDJJu2ZXMBU7XpsIOl5xuTKqYPAYY7Sc1slFbn6cF2lsGpH9NfEwWgdgMk
	LsifG55QvxjEL2zSTGyrGxRaM7PHv/eZB9x1oA5Hwn0lQJ37ZKnkShXyM06mHhen93oxsO4XWAC
	Z12xLp9xg9BtvBsw1QAJ8xPu3Eb2rXK1/y+gAXp0AurDE5ZxzHy2diFgRdYZzWiQ=
X-Received: by 2002:a05:620a:412:b0:93f:4498:603a with SMTP id af79cd13be357-94933140d8cmr273168085a.35.1794481788206;
        Thu, 12 Nov 2026 03:09:48 -0800 (PST)
X-Received: by 2002:a05:620a:412:b0:93f:4498:603a with SMTP id af79cd13be357-94933140d8cmr273166685a.35.1794481787607;
        Thu, 12 Nov 2026 03:09:47 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e423dfsm120060095e9.1.2026.11.12.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:09:46 -0800 (PST)
Date: Thu, 12 Nov 2026 12:09:45 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v9] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
Message-ID: <avWeeUAo-87qexve@lore-desk>
References: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
 <20261111181341.56706354@kernel.org>
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
	protocol="application/pgp-signature"; boundary="b5Zoifa3Cp4gU6eN"
Content-Disposition: inline
In-Reply-To: <20261111181341.56706354@kernel.org>
o: Jakub Kicinski <kuba@kernel.org>
X-Proofpoint-ORIG-GUID: TsSLPF8Hg3SL7qPvUCf38DcaQDY-Rlag
X-Proofpoint-GUID: TsSLPF8Hg3SL7qPvUCf38DcaQDY-Rlag
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af59e7d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=9cW_t1CCXrUA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=07NEhHcJ6ct1wQha1QwA:9 a=CjuIK1q_8ugA:10 a=HwC5dmO7DALaZ-7ppEoA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXz/MCjloF7tGS
 /ffsE+BlpxBl9tP7NWbf2XJvRXUny3jVNofC8tEo2iM0BPNtttcmTn9ozzhe2uQ7Kwtrwl+uy38
 MOAUUtdyOCJxw9ETLPSglVdVdL5ItVo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX+tReSVuVr0dR
 tWpecX/N8F5MqHDR2DLX5qqhUEG/0nkFcUgbPWzx+eux8/mN08uLCQmv3IZx5TcqOzigLLQ+R4q
 HPwA0k0CBt1T+5nqF2NTw/3txQ+zDXZNfrhFe3y8DwwtTWiAffdCIhlaBSdhPIlYwXlKyukjaE0
 snqHBxYagekrztWWugWgu4ru6VIIj6HIDZUDKm2jpuCfvEMQErj5ZndDhOt3GwfxR0Urw12FdDj
 mHg89I4h3vAjJlo8nPj2l0TVHe6cUn1OLfHx6thXh1jiHQPwVex5bGO7QItJEfgpfwJdbXtPL02
 Khw/m7sFSyaN2rfuxKqIXFLDlvtoEIpqE6oE5Eg2oflxTYyDJX3i2YxrJq61ScjphDQlF8Yh3vK
 CuFGf76xOQ/7QEBOjtWXveSBf+4Tm3kBbTiwDzxi4dQP6BYxUOVbxW1OsdPEhPhjKVec0+ovjyV
 qO5cOixMDLMnjGUZ9GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

--b5Zoifa3Cp4gU6eN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 06 Nov 2026 11:54:19 +0100 Lorenzo Bianconi wrote:
> > +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	u32 metasize =3D xdp->data - xdp->data_meta;
> > +	struct sk_buff *skb;
> > +	u8 num_frags =3D 0;
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > +		num_frags =3D sinfo->nr_frags;
> > +
> > +	skb =3D napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> > +	if (!skb)
> > +		return NULL;
> > +
> > +	skb_mark_for_recycle(skb);
> > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > +	skb_put(skb, xdp->data_end - xdp->data);
> > +	if (metasize)
> > +		skb_metadata_set(skb, metasize);
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> > +					  sinfo->xdp_frags_truesize,
> > +					  xdp_buff_get_skb_flags(xdp));
> > +	return skb;
> > +}
>=20
> This is almost identical to xdp_build_skb_from_buff(), why not use the
> common code?

Right, this is almost xdp_build_skb_from_buff() but we can't use directly it
here since it runs eth_type_trans() and we would need to run stmmac_rx_vlan=
().
I guess we can refactor xdp_build_skb_from_buff() in something like:

struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
{
	// Do not run eth_type_trans()
	....
	return skb;
}

static inline struct sk_buff *dp_build_skb_from_buff(const struct xdp_buff =
*xdp)
{
	__xdp_build_skb_from_buff()
	skb->protocol =3D eth_type_trans();

	return skb;
}


>=20
> > +static void
> > +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
> > +		    bool allow_direct)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	int i;
> > +
> > +	if (likely(!xdp_buff_has_frags(xdp)))
> > +		goto out;
> > +
> > +	for (i =3D 0; i < sinfo->nr_frags; i++)
> > +		page_pool_put_full_page(rx_q->page_pool,
> > +					skb_frag_page(&sinfo->frags[i]),
> > +					allow_direct);
> > +out:
> > +	page_pool_put_full_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> > +				allow_direct);
> > +}

ack, we can rework xdp_return_buff() adding the capability to specify
napi_direct.

> > +
> > +static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
> > +				  struct xdp_buff *xdp, int offset)
> > +{
> > +	struct skb_shared_info *sinfo;
> > +	int i;
> > +
> > +	if (unlikely(offset < 0 ||
> > +		     offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
> > +		return -EINVAL;
> > +
> > +	if (likely(!xdp_buff_has_frags(xdp))) {
> > +		xdp->data_end -=3D offset;
> > +		return 0;
> > +	}
> > +
> > +	sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	for (i =3D sinfo->nr_frags - 1; i >=3D 0 && offset > 0; i--) {
> > +		skb_frag_t *frag =3D &sinfo->frags[i];
> > +		int delta =3D min_t(int, offset, skb_frag_size(frag));
> > +
> > +		if (delta =3D=3D skb_frag_size(frag)) {
> > +			/* The whole frag is consumed by the strip: return it
> > +			 * to the page pool right away. Its ring slot still
> > +			 * carries the page DMA address until stmmac_rx_refill()
> > +			 * re-arms it at the end of the NAPI poll. This is
> > +			 * safe because HW cannot touch the slot until then.
> > +			 */
> > +			page_pool_put_full_page(rx_q->page_pool,
> > +						skb_frag_page(frag), true);
> > +			sinfo->nr_frags--;
> > +			sinfo->xdp_frags_truesize -=3D xdp->frame_sz;
> > +		} else {
> > +			skb_frag_size_sub(frag, delta);
> > +		}
> > +
> > +		sinfo->xdp_frags_size -=3D delta;
> > +		offset -=3D delta;
> > +	}
> > +
> > +	if (unlikely(!sinfo->nr_frags)) {
> > +		xdp_buff_clear_frags_flag(xdp);
> > +		xdp_buff_clear_frag_pfmemalloc(xdp);
> > +		xdp->data_end -=3D offset;
> > +	}
> > +
> > +	return 0;
> > +}

I guess we can exctract the logic from
bpf_xdp_adjust_tail()/bpf_xdp_frags_shrink_tail() and create a helper we can
reuse it in stmmac and filter.c. What do you think?

Regards,
Lorenzo

>=20
> These two OTOH could easily become new common helpers, they seem to do
> nothing stmmac specific?

--b5Zoifa3Cp4gU6eN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavWeeQAKCRA6cBh0uS2t
rPFeAP0VMe/78PkVnBIxUEdWOxWNS8mn/VHlUChXe7LArItcnAD/Z3cRi1H98JVr
c0eziNWwRX+hmLoGHFwU5ALqhPHhXg8=
=ojdi
-----END PGP SIGNATURE-----

--b5Zoifa3Cp4gU6eN--
