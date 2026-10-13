Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57B15746F
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886587; cv=none; b=WtEi6eFHypCCWyMemUCffzEPR9dTU67aKnKUrit8gFlvgcjHMUEOD3g6BxcHIStKnxDw9ng+CE1NJfEmWKztLdRr/HZM9peN+aXH3T+BSvn+ywR0mzxLQvdKCpMhBTA/ReMXUbcUE3zwEhW0iz+E8K9YXtOiATQxd91BGwxRqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886587; c=relaxed/simple;
	bh=zsUrxvV5GV7v1A9KzKUaB0c3kKIBr9xlFLCsjCccsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPpRSvKyj/DxI61QmYqgn93FTRFW7H4HcM0gDklLVUQ9AfmN1S+NQcrt9f7kdGN4faWzqE0djaVcUlZ58wxjE/9ZN9BlDb27BFxhJJvwDnysbQ38gCF5mssfbL4fRURUS4AHODDtbEjIC+OWeTU3ptACcwHlCoq8KTj94aBYLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3NniW9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HrNMtwaH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3NniW9J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HrNMtwaH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9RAuv3476072
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0joQw94XiM/OPOK+JDq2n0qS
	Tv4A0S4JrAUcnweeYvA=; b=P3NniW9JLpsxlSeGSlDQqw14cuf1x1w5VWBDx7IM
	1RlASUks3lx34QJE3AL/94Nhd6ZrJCyOlpAvjqgCPRvu4wyVAKYIvvfTOlo5Bvos
	v/DgUlPe7dZX+yexPUNO0re42XTL4vGM4HgUmLAAFRFbmKQ2e2G/k7LxSONZsV1I
	o0v2WzPJ9/5tdO4trDhtEn4gF4v15Pw5PmHccgKACYnLg/eKNoM1ZAToFtaqk4nX
	kOjBXkkp9X9ADOGi2/lW5cNORpEaSLS9WwGtQrZfctGl0wnKNeswEkavY9pDAVwz
	4u0hVvDoYpFmmgxzAMSOZpzrTDVaX8xI2dY4BVStc+A5Eg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j9fx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:16:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caa0ce0cdso306576085a.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791886584; x=1792491384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0joQw94XiM/OPOK+JDq2n0qSTv4A0S4JrAUcnweeYvA=;
        b=HrNMtwaHpqMxB+MdorSxzQikOfDgp/+ForUlmFkOnc6gbuKOlsne4CGRo5bI5/GumT
         QyLhdsJjtcN4BysLd3FhTddefgrtnMxBdBOAQggvt3npv2jkOq3XEp2bnvbUn9bSbMHv
         JHV4jl+FMLJ4wNfp0EegCKKjkv/Gm4JgNO8EEzbshp6dTQzJwiQytuBe/pE4JhaJTtUX
         QYB76udTtx0MVrmDwqXlN8+1Xl53diylNbW+Bm9OuJDJ2umUlXelhMiyPHHwjeeUPDnU
         pqraiprTUnjYA/y3+QpfY4+dBULPwLjRVE462qpLMs49HgdqI0DmhLvMzcVGT8QnFIjM
         GYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886584; x=1792491384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0joQw94XiM/OPOK+JDq2n0qSTv4A0S4JrAUcnweeYvA=;
        b=r9sNZ9N9YVN+t05szpAK0SRYLD9XPvaLB688mYVQap16rrKk1+7Q6RDADF+n2gEVeM
         ttXyQ4+y+hNeAkH3uKqlk8tgvd/ggOHj/8SH43d7qQSA3Fa3jcRgvkz+VAvC8NFt9Ynn
         tKJhdk1jdfb2MwEU51ZPkcwMO5zKZrNzcoTOSOS5o4gJynrdaG6qC3bMIThmwzLmBcUH
         EEu2QBF8hXzslKZMCAXy3V7YuuLSqt3Z3HN5g7Vgga80Zo+hZAAWCLy0rdTkBMiGx1Wj
         2jJBTrK4IRq6R589IkQkyQ33jpETYeU5FmjdYK4lGJlXgvNFEXjvSBL1ymYJtfQg/d9Z
         k2pw==
X-Forwarded-Encrypted: i=1; AKwUvBw3s5WAS3JFMTXKbO6x8v9hyeOI5ATE9liaP5h9cfTbs8wfb6BiLzZdLW9IN1RMrkp4cag=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvbJb2RZuvBxjlPgyhrt8K1740KWIGpvh53BHLMPTM5Q1Sef0/
	56QBz7+nUo2rl3Z0bWnSC9b0ArqtkCBStWOTuXb56d2YhXiEPZLEqp5PaLlh6ojoIIpZwOhhaXv
	p0/RXk5V+Hc9g6LC0MnczPk4yFwKgG2aUXzXan5v1kZ0rFKxHIJRDJyE=
X-Gm-Gg: AYBFou1e3nhyiCqtsqwsLBT1vfiXRLLtRtR+cn+K1NWdgwDnqHWcbs+81qzLry7hQlm
	AOu68/QF19O8Ni0Fg/JgT+liw2+BaMAIqHBaEXr8HuuFXd7hJz994MjdlfMqPgPt71jxr5dmr7s
	mQjbh2HkOcHFeKsfSMpbYYlvKCkZesMvu+ZHLfTVPHFxiYz1xZM2EceW1d7GxNmEtutdKX9DWFU
	FwBSiMLKb461eaQOy1K8uSWCNBdu0tfHM0rFi6il8Z+vTxl1viGjCsV6Mw1VsGuSgMr0BSEL/cQ
	4+7pRv6P5GfK2NwcCSgOHHDJU179knPEkdf0oLFt9a48dXERlPmZ18WWv5rpSn7mLO81LBwF8Nx
	c6JYRUOS5iwu/Bw==
X-Received: by 2002:a05:620a:6186:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93ebd248378mr1946433385a.34.1791886583392;
        Tue, 13 Oct 2026 03:16:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6186:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93ebd248378mr1946429585a.34.1791886582699;
        Tue, 13 Oct 2026 03:16:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc51c1sm4259497f8f.46.2026.10.13.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:16:21 -0700 (PDT)
Date: Tue, 13 Oct 2026 12:16:20 +0200
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
Subject: Re: [PATCH net-next v6 4/4] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
Message-ID: <as4E9Oxr03YYE0lU@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-4-2225050915c1@oss.qualcomm.com>
 <9bf19616bc6fd8680e65272f45d14239@tipi-net.de>
 <as315RcZF2RcJGLW@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mu66gn9kz4J4GejD"
Content-Disposition: inline
In-Reply-To: <as315RcZF2RcJGLW@lore-desk>
X-Proofpoint-GUID: aJcenklvICmuSzVTU-wSbdURMMvuTG6b
X-Proofpoint-ORIG-GUID: aJcenklvICmuSzVTU-wSbdURMMvuTG6b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX+peXWw8UKx60
 o0y/DEq2NR4yXlciEOqz4rl0S1ySPanm9eUCN2wvEGgUXJKlJIDSK6auPXOP4HCesKLHOrRPlD9
 o3ppyRUxZ57CptJ9z3owyk1ZZxy4zLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX72dRxOQLWZwv
 PzBDXUGZ8Fld/FQIYBKVULg3KM5s4Oj6jY/LxSzoYetoK1ae8Xx37fs+d8htOV7AQRIC93JsiUx
 lDehXZ6GJfCeZCN5hlL7x8/Dhs1jSN/bgPUGlPBrGv//qjkCasCr+itqsGhbuFmyc/2+BmcwaUr
 KDepQ/H/Y6OHQ6cnoSwDUmOagk2CRj1MQOfaHM3RBDiSPLmXV6OwCJTnkU25AzfJHrf2L8bDY/F
 5kdMQjky0LuN66PAHyoC4dJ+rRRNv6gKqYdCIuu4XdGgFMpwmpK5HvWjkc7oaFMEUnVHuW3oxnZ
 4RZhMCwHNUckbR7zRxSjL5ISXh8LTTr3Sjq6pPesmEdhakbd297dcebG9sH8KHWhRxpuKW8D1Xw
 Srgqql9NM1wIcAmOjekX90ki5DaK3bFOzqfjgg5g2Vcvqz7WdjSmg3PxBWQ2RM38GijtZjaoyvr
 o6KFazNmI4mK4fIjt6Q==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace04f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=v17Ietvw4lErNa0x46sA:9 a=CjuIK1q_8ugA:10 a=3mV5Pt-Fye_HxHZc_IkA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130040

--Mu66gn9kz4J4GejD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13, Lorenzo Bianconi wrote:
> > Hi Lorenzo
> >=20
> > On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> > > Build the xdp_buff by accumulating all the descriptors that make up a
> > > frame, so the XDP program runs on the full (possibly fragmented) pack=
et
> > > instead of just the first buffer. When the frame is not consumed by t=
he
> > > program, assemble the skb from the head buffer and the collected
> > > fragments via napi_build_skb()/xdp_update_skb_frags_info().
> > >=20
> > > Note that XDP still rejects an MTU larger than ETH_DATA_LEN
> > > (stmmac_xdp_set_prog(), stmmac_change_mtu()) and disables SPH, so an
> > > ordinary frame fits in a single buffer. This path is therefore exerci=
sed
> > > by frames that do span several descriptors (for example jumbo frames =
the
> > > MAC admits through its jumbo-enable bit) and is groundwork for extend=
ing
> > > XDP to jumbo/SPH; it does not enable XDP jumbo support by itself.
> > >=20
> > > For those multi-descriptor frames the old code was buggy as well: it =
ran
> > > the XDP program once per descriptor buffer, so for a multi-descriptor
> > > frame the program was also invoked on continuation buffers holding
> > > mid-frame payload. It also subtracted ETH_FCS_LEN from the first buff=
er
> > > even when it was not the last descriptor (its second buffer empty),
> > > dropping four bytes from the middle of the frame while marking the FCS
> > > as
> > > already stripped and skipping the final pskb_trim(). Accumulating the
> > > whole frame before running XDP fixes both.
> >=20
> > With patch 3/4 applied, these frames are already dropped in XDP mode,
> > so this paragraph no longer matches the code this patch changes?
>=20
> ack, I will remove it in v7.
>=20
> >=20
> > >=20
> > > To do so, store the in-progress xdp_buff in rx_q->state instead of the
> > > partially built skb, so the accumulated head and fragments survive a
> > > NAPI poll boundary (mid-frame dma_own or dirty_rx break). The state is
> > > saved only while a frame is in progress and cleared once it completes,
> > > leaving it untouched when the poll does not process anything (e.g.
> > > netpoll invoked with a zero budget).
> > >=20
> > > In addition:
> > > - advertise NETDEV_XDP_ACT_RX_SG, since the RX path can now deliver
> > >   non-linear buffers to XDP;
> > > - drop multi-buffer frames when the attached program was not loaded w=
ith
> > >   BPF_F_XDP_HAS_FRAGS, since a single-buffer program must not be hand=
ed
> > > a
> > >   non-linear xdp_buff;
> > > - build the skb head with napi_build_skb() passing xdp->frame_sz, so
> > >   skb_shinfo() lands on the same shared_info the fragments were
> > >   accumulated into;
> > > - carry the XDP metadata written with bpf_xdp_adjust_meta() into the =
skb
> > >   via skb_metadata_set(), so it is no longer dropped and TC/BPF progr=
ams
> > >   can read it through data_meta;
> > > - attach fragments with xdp_buff_add_frag(), which initializes all the
> > >   shared_info fields and takes care of the pfmemalloc bit;
> > > - release the buffers collected in the xdp_buff when a frame is dropp=
ed
> > >   on RX errors; the previous code relied on dev_kfree_skb() recycling
> > > the
> > >   skb frags, which no longer applies now that the head and fragments
> > > live
> > >   in an xdp_buff rather than a partially built skb;
> > > - drop the whole frame when it would exceed MAX_SKB_FRAGS, where the
> > >   previous skb_add_rx_frag() calls were unbounded;
> > > - strip the Ethernet FCS from the accumulated xdp_buff with a
> > >   driver-local tail shrink (stmmac_xdp_shrink_tail()) for both linear
> > >   and fragmented frames, instead of trimming the skb or the first
> > >   descriptor length.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > ---
> >=20
> > > [...]
> >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >=20
> > > [...]
> >=20
> > > +static void
> > > +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *x=
dp,
> > > +		    int sync_len, bool allow_direct)
> >=20
> > This looks like xdp_return_buff(), apart from the sync length of the
> > first buffer. Could the NAPI paths (XDP_CONSUMED and error_free_frag)
> > use xdp_return_buff() instead? The teardown paths need allow_direct =3D
> > false, so they would still need something local.
>=20
> Theoretically I agree, but, since we still need stmmac_xdp_put_buff()
> for the teardown path, I guess we can keep it since it is even an
> optimized version with respect to xdp_return_buff(). What do yo think?
>=20
> >=20
> > > +{
> > > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp=
);
> > > +	int i;
> > > +
> > > +	if (likely(!xdp_buff_has_frags(xdp)))
> > > +		goto out;
> > > +
> > > +	for (i =3D 0; i < sinfo->nr_frags; i++)
> > > +		page_pool_put_full_page(rx_q->page_pool,
> > > +					skb_frag_page(&sinfo->frags[i]),
> > > +					allow_direct);
> > > +out:
> > > +	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> > > +			   sync_len, allow_direct);
> > > +}
> > > +
> > > +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> > > +{
> >=20
> > This is very close to xdp_build_skb_from_buff(). Have you checked if th=
is
> > might
> > be a fit?
>=20
> yes, but we can't use xdp_build_skb_from_buff() since it runs eth_type_tr=
ans()
> modifying the skb->data pointer (in this way we will corrupt stmmac_rx_vl=
an()).
> Agree?
>=20
> >=20
> > > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp=
);
> > > +	u32 metasize =3D xdp->data - xdp->data_meta;
> > > +	struct sk_buff *skb;
> > > +	u8 num_frags =3D 0;
> > > +
> > > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > > +		num_frags =3D sinfo->nr_frags;
> > > +
> > > +	skb =3D napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> > > +	if (!skb)
> > > +		return NULL;
> > > +
> > > +	skb_mark_for_recycle(skb);
> > > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > > +	skb_put(skb, xdp->data_end - xdp->data);
> > > +	if (metasize)
> > > +		skb_metadata_set(skb, metasize);
> > > +
> > > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > > +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> > > +					  num_frags * xdp->frame_sz,
> > > +					  xdp_buff_get_skb_flags(xdp));
> > > +	return skb;
> > > +}
> >=20
> > > [...]
> >=20
> > > +static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
> > > +				  struct xdp_buff *xdp, int offset)
> >=20
> > This is only used to drop the FCS. On the last descriptor we already
> > know the frame length, so could the 4 bytes be taken off buf1_len /
> > buf2_len before the buffers are added? Then only the rare case where
> > the last buffer has fewer than 4 bytes would need to trim the previous
> > frag, and this helper could go away.
>=20
> uhm, right. I guess we could do something like (and drop
> stmmac_xdp_shrink_tail()):
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index e80793bd6553..5cb8a6883f44 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6027,6 +6027,19 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
>  		buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
>  		len +=3D buf2_len;
> =20
> +		if (!(status & rx_not_ls)) {
> +			/* ACS is disabled; strip manually. */
> +			if (buf2_len > ETH_FCS_LEN) {
> +				buf2_len -=3D ETH_FCS_LEN;
> +			} else if (!buf2_len) {
> +				buf1_len -=3D ETH_FCS_LEN;
> +			} else {
> +				buf1_len -=3D (ETH_FCS_LEN - buf2_len);
> +				buf1_len =3D 0;

Here there is an obvious typo (buf2_len and not buf1_len) but thinking again
at the suggested approach I think there is corner case we can't really cove=
r,
the FCS can be theoretically split over different DMA descriptor, so we need
to reconstruct the full xdp buffer first and then remove it. In other words,
I do not think we can get rid of stmmac_xdp_shrink_tail(). What do you thin=
k?

Regards,
Lorenzo

> +			}
> +			len -=3D ETH_FCS_LEN;
> +		}
> +
>  		if (!frames) {
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
> @@ -6064,8 +6077,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)
>  		if (likely(status & rx_not_ls))
>  			goto read_again;
> =20
> -		/* ACS is disabled; strip manually. */
> -		len -=3D ETH_FCS_LEN;
>  		if (stmmac_xdp_shrink_tail(rx_q, &ctx.xdp, ETH_FCS_LEN)) {
>  			if (!error)
>  				rx_dropped++;
>=20
> What do you think?
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > > [...]
> >=20
> > Thanks,
> > Nicolai



--Mu66gn9kz4J4GejD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas4E9AAKCRA6cBh0uS2t
rJPeAQDerp6+n4L3MJ2rwrKWH0/G7ww+Ee+WCf0ZI8frA7mKzwEAoHyOURfMe53f
TpZha7A/0DVjAtC9yaAN0a+AT+qJ0Ak=
=VvWK
-----END PGP SIGNATURE-----

--Mu66gn9kz4J4GejD--
