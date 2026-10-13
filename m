Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C043CAE8D
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882731; cv=none; b=ghj4DqnkJTL6/W6zd/Umnb1hVzwXVSIyNDGt8HUBWnZrdPP83bLb8ARyReUhhzxK0By/tMzm0x5q8r2Hc9w2FI+FcPNcKL7tjkRnEPu0z9Nglq078BPR+1uQPAfmVz4whJA5H+pgoGc5ZlAih/bSdlOvW1JJvXmxRyherZUdbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882731; c=relaxed/simple;
	bh=5x4goBb5zd47qS6TpZK6Qb6gasA1LL1gKzRS7pO0Nrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia4Tk8QZ2CAxSF1CfcFUCw2EgZmMB92eCHnPpOlk+d4Q2NNxl1xfxA/k9JqJLV9L87M9pQHnTKFHbqdERw1xYycUh3GOBBaRIBdwRAQjCZnPYHy4hD893sm3VWMLZF/CvRNXO0x/igmFWEw2rxPbLLOfIO7G56Sagyu8wUGk/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QCaDrP1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCkcTjEy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCaDrP1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCkcTjEy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8bEUr302956
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=E2Pp+9YizOBDl9Z2JWZti07f
	bnD+Dxt3FH6Ir7Jb7Bk=; b=QCaDrP1qxyYBRIWjVNYHJ6lTXMqNSEIA5MrikGrH
	IptJH3JAd5J8fLQ5ihe5PAT2dTsT/WHsOBU+wMKfbJcbVMC5UiHZwTpbTDirNOC7
	yv+2vg21R1tf9otq28vVsSSnL5Ew6Jx+AevvuXJ9t2HEx6hrK5UoWX6RCbWopS+t
	p8xKPh2MPvNuuTbr2dKDZ0asHLsfWGsC0hiJb8TN2oT13UYTARJ5MX0107qF4j4z
	x4djFILlz5ogK5xpY7NbdN3ER95vatqWFn6eu9OUjgBmn5SUbdRbKj5wv7/yUfM7
	LeFWio/TVmBZVfmas8irAuv4gNTyny0FbvNvleKOexeMUA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqa249-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:12:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e49a1d3b1so647784285a.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791882728; x=1792487528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2Pp+9YizOBDl9Z2JWZti07fbnD+Dxt3FH6Ir7Jb7Bk=;
        b=bCkcTjEybFQV5xOUKOhmEHFk/TOjjMCk83N+jqqSufL5Zd/evhDi3RO74MIYDVRtDZ
         p9/VP2qa0i46gR43SynM1szqnaDgm/R/JK8a2uw8Spun8XxYGNPyE3q6HKyi144mU2Fv
         5xdsRAsrGz+Vy69MztLnLOYkqX4P12QBshfGz8fpMtPgX+Dg0AZDDOE9VTjByUX05qJS
         6GhP4NhrAA0u8e1QF/7P8dzZUVNDAErInGTsUZPgP4vE7xAeCNSfnSZTrQJVBZSGFVlu
         9gXyOEFLNBHNZvwNsmuFgtG0HeWh9cnq5TmiTqbkZuPm6Rnjr7LG+SXa/Y05MCVf0VIa
         7KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882728; x=1792487528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2Pp+9YizOBDl9Z2JWZti07fbnD+Dxt3FH6Ir7Jb7Bk=;
        b=AxTSiUaNkmCwE1NdgkTMYq5dMKAlWShhbed6iPucKDft3E/7tIQDOPhZR6h7CX401d
         SJgF+OeZyMQnqVcALASC4Cq35Oxig64HfEJxMXSCohsU4U6/pcmUQ5RWJ8zfe6gS2Jk8
         DpI2LBFFgRxT9TH56aY7gWNgPPVagZV/BFlmAAxa6gSqS9Eca2Y/4K6ueOPiFwQYbNL5
         /A1GpRKy9iDb4B7KuSdEjrWVg3p9PZn0rww2nvSZhw3dC023xf66RCcnGWW0UjsUHDK7
         aSsXBT+PrhL5WyzEIbky1VdOfiBQv21r2xfn8OFExBIaPPwrFPN6WoS+6z7D4TtzqAxf
         O40w==
X-Forwarded-Encrypted: i=1; AKwUvBwqbl+mxELh1uurFMzvu9dwTdrSHjQeqjPKUAXyGZdPtO0Y0A49QdyEsE8SeDeuoOdEDZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxPic0CRWU/2K8Y7ItGgVDt8Il+RQzm7ce8YnUbSyhh7gXYaXG
	tIq9shIGrVamm2jJFMfunoc6O69W3in4dWsdwdoEl99gczZnSHx+CGU5UskukvulmikVA3IALuO
	stslPbAD8WDEKV52yKdipm9rOEEWH+XSseHmB2Av4Jq1CslozEy7z8P0=
X-Gm-Gg: AYBFou3pH9OF65N6F7kQ+BFc+f134zCLegAG3+2MjdH5MLcubN7kgGCFhzXjtUNl4MO
	EI2Cuz2k6n/tpmvFNhxVuDl9+jfjPqO4j73uP56/NVVYShFATt/L+7fRx8dA/34FqKNfuUc2/V7
	/IyCoA9A0Ibr7TqU1/DeC4KnqorUJj6say5C/cmwaFoc51RcEwn3LVywJa7Nk95ly7OB2KkUlte
	+w/DlbbcG8mhtgR5zUPIoA2n2zDkVX7iTAjdU0uGSq5t2Z6CecJuuGsVDpkVkBe+PzjuVUmjPbP
	mv9/ZT+ufhOUFa+r/Gu9d0F1MfqHBcIRXXuAqGae3rUPmuZBnKsuv1rHerxtYmqo7bsVAvosqFM
	DVnn3xzDr6RKRJQ==
X-Received: by 2002:a05:620a:4689:b0:93e:5312:3c96 with SMTP id af79cd13be357-93ebd20e0c1mr2124290385a.26.1791882727698;
        Tue, 13 Oct 2026 02:12:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:93e:5312:3c96 with SMTP id af79cd13be357-93ebd20e0c1mr2124284985a.26.1791882726961;
        Tue, 13 Oct 2026 02:12:06 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4e8csm3810292f8f.23.2026.10.13.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:12:05 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:12:05 +0200
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
Message-ID: <as315RcZF2RcJGLW@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-4-2225050915c1@oss.qualcomm.com>
 <9bf19616bc6fd8680e65272f45d14239@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hJUbagSp6rWj5w8"
Content-Disposition: inline
In-Reply-To: <9bf19616bc6fd8680e65272f45d14239@tipi-net.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfXyZlY7077Xeju
 VM+eRaWIa07C7iDBaHvt/hCWKRMyf4+52XoP0ZAoCqds3yhNlZF6yusBzwuAd0cSrT0TIDlp7HI
 5Uif83dtfX7MYb4l94rEillvq64vMtdCkdi8vVzFYngxEVqZ6xbYt83JF7uO2Fo33+ikDHS/kkG
 ketCBaZbGLUO0x5vKgefdRXrSoDUR9BgVvegdfLLjgBwQ6HU0BINZtRdKP8R3SwEPDCypzkPHRc
 D1v04trnEtLfMhdTDslPD6q0KGtB5Zay0kqb/T0xRNOUb8uDjFLtEfgTmHE6xWRRRRLIB/k627S
 xWYBDVUz/0e7jpbkz15mGeHKS/dAyz3HuSVmtUCZm6J+f9dKdjRpEFy4Lsht++y6fFCnwV21MSK
 ANn5Q0i7n+d1aERKAclXnXIO1JFX2bIoRB0XwpB/C70FaQNC4EPeQrh61+gfIoMhOHYGoqmnkIb
 S9oP5+b8zdbV54aRQdQ==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdf5e8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=3yKrCuJdiH5fJuTJ9mQA:9 a=CjuIK1q_8ugA:10 a=EJuJvaCN_CdamGs11FwA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfXwZ12RwV4y8ms
 YpDdszF1Zc46+05C0h577eq0132BO6wAfY4Z8uk2Hl/VvXWNfoLVNEwNCGjbPSxl8/5Du2DuWT6
 ChHpaLran5Zq3W/DMWHa4qNoUGzjLxE=
X-Proofpoint-ORIG-GUID: 5ZrO1zSvAX1tpis9xYV1sTDEou8ZmZ-I
X-Proofpoint-GUID: 5ZrO1zSvAX1tpis9xYV1sTDEou8ZmZ-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130036

--5hJUbagSp6rWj5w8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo
>=20
> On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> > Build the xdp_buff by accumulating all the descriptors that make up a
> > frame, so the XDP program runs on the full (possibly fragmented) packet
> > instead of just the first buffer. When the frame is not consumed by the
> > program, assemble the skb from the head buffer and the collected
> > fragments via napi_build_skb()/xdp_update_skb_frags_info().
> >=20
> > Note that XDP still rejects an MTU larger than ETH_DATA_LEN
> > (stmmac_xdp_set_prog(), stmmac_change_mtu()) and disables SPH, so an
> > ordinary frame fits in a single buffer. This path is therefore exercised
> > by frames that do span several descriptors (for example jumbo frames the
> > MAC admits through its jumbo-enable bit) and is groundwork for extending
> > XDP to jumbo/SPH; it does not enable XDP jumbo support by itself.
> >=20
> > For those multi-descriptor frames the old code was buggy as well: it ran
> > the XDP program once per descriptor buffer, so for a multi-descriptor
> > frame the program was also invoked on continuation buffers holding
> > mid-frame payload. It also subtracted ETH_FCS_LEN from the first buffer
> > even when it was not the last descriptor (its second buffer empty),
> > dropping four bytes from the middle of the frame while marking the FCS
> > as
> > already stripped and skipping the final pskb_trim(). Accumulating the
> > whole frame before running XDP fixes both.
>=20
> With patch 3/4 applied, these frames are already dropped in XDP mode,
> so this paragraph no longer matches the code this patch changes?

ack, I will remove it in v7.

>=20
> >=20
> > To do so, store the in-progress xdp_buff in rx_q->state instead of the
> > partially built skb, so the accumulated head and fragments survive a
> > NAPI poll boundary (mid-frame dma_own or dirty_rx break). The state is
> > saved only while a frame is in progress and cleared once it completes,
> > leaving it untouched when the poll does not process anything (e.g.
> > netpoll invoked with a zero budget).
> >=20
> > In addition:
> > - advertise NETDEV_XDP_ACT_RX_SG, since the RX path can now deliver
> >   non-linear buffers to XDP;
> > - drop multi-buffer frames when the attached program was not loaded with
> >   BPF_F_XDP_HAS_FRAGS, since a single-buffer program must not be handed
> > a
> >   non-linear xdp_buff;
> > - build the skb head with napi_build_skb() passing xdp->frame_sz, so
> >   skb_shinfo() lands on the same shared_info the fragments were
> >   accumulated into;
> > - carry the XDP metadata written with bpf_xdp_adjust_meta() into the skb
> >   via skb_metadata_set(), so it is no longer dropped and TC/BPF programs
> >   can read it through data_meta;
> > - attach fragments with xdp_buff_add_frag(), which initializes all the
> >   shared_info fields and takes care of the pfmemalloc bit;
> > - release the buffers collected in the xdp_buff when a frame is dropped
> >   on RX errors; the previous code relied on dev_kfree_skb() recycling
> > the
> >   skb frags, which no longer applies now that the head and fragments
> > live
> >   in an xdp_buff rather than a partially built skb;
> > - drop the whole frame when it would exceed MAX_SKB_FRAGS, where the
> >   previous skb_add_rx_frag() calls were unbounded;
> > - strip the Ethernet FCS from the accumulated xdp_buff with a
> >   driver-local tail shrink (stmmac_xdp_shrink_tail()) for both linear
> >   and fragmented frames, instead of trimming the skb or the first
> >   descriptor length.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
>=20
> > [...]
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> > [...]
>=20
> > +static void
> > +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
> > +		    int sync_len, bool allow_direct)
>=20
> This looks like xdp_return_buff(), apart from the sync length of the
> first buffer. Could the NAPI paths (XDP_CONSUMED and error_free_frag)
> use xdp_return_buff() instead? The teardown paths need allow_direct =3D
> false, so they would still need something local.

Theoretically I agree, but, since we still need stmmac_xdp_put_buff()
for the teardown path, I guess we can keep it since it is even an
optimized version with respect to xdp_return_buff(). What do yo think?

>=20
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
> > +	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> > +			   sync_len, allow_direct);
> > +}
> > +
> > +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> > +{
>=20
> This is very close to xdp_build_skb_from_buff(). Have you checked if this
> might
> be a fit?

yes, but we can't use xdp_build_skb_from_buff() since it runs eth_type_tran=
s()
modifying the skb->data pointer (in this way we will corrupt stmmac_rx_vlan=
()).
Agree?

>=20
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
> > +					  num_frags * xdp->frame_sz,
> > +					  xdp_buff_get_skb_flags(xdp));
> > +	return skb;
> > +}
>=20
> > [...]
>=20
> > +static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
> > +				  struct xdp_buff *xdp, int offset)
>=20
> This is only used to drop the FCS. On the last descriptor we already
> know the frame length, so could the 4 bytes be taken off buf1_len /
> buf2_len before the buffers are added? Then only the rare case where
> the last buffer has fewer than 4 bytes would need to trim the previous
> frag, and this helper could go away.

uhm, right. I guess we could do something like (and drop
stmmac_xdp_shrink_tail()):

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index e80793bd6553..5cb8a6883f44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6027,6 +6027,19 @@ static int stmmac_rx(struct stmmac_priv *priv, int l=
imit, u32 queue)
 		buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
 		len +=3D buf2_len;
=20
+		if (!(status & rx_not_ls)) {
+			/* ACS is disabled; strip manually. */
+			if (buf2_len > ETH_FCS_LEN) {
+				buf2_len -=3D ETH_FCS_LEN;
+			} else if (!buf2_len) {
+				buf1_len -=3D ETH_FCS_LEN;
+			} else {
+				buf1_len -=3D (ETH_FCS_LEN - buf2_len);
+				buf1_len =3D 0;
+			}
+			len -=3D ETH_FCS_LEN;
+		}
+
 		if (!frames) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
@@ -6064,8 +6077,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int li=
mit, u32 queue)
 		if (likely(status & rx_not_ls))
 			goto read_again;
=20
-		/* ACS is disabled; strip manually. */
-		len -=3D ETH_FCS_LEN;
 		if (stmmac_xdp_shrink_tail(rx_q, &ctx.xdp, ETH_FCS_LEN)) {
 			if (!error)
 				rx_dropped++;

What do you think?

Regards,
Lorenzo

>=20
> > [...]
>=20
> Thanks,
> Nicolai

--5hJUbagSp6rWj5w8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas315QAKCRA6cBh0uS2t
rObYAQCy2tajGOULWzFImhcto8r0a2JaQpBQZNR/TbsHXIWUGwEApvfNEspODcun
ATgcQCea768H+tODWf15+U67WK1FxAY=
=2BN4
-----END PGP SIGNATURE-----

--5hJUbagSp6rWj5w8--
