Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502986;
	b=DnPhlAGsohWaQyDCo5CKftJeQOAHE5v1EIZukB54/S8nCyZTpm5wv9bm654jFj57jDvI
	 I9MB02m4hNAKgGvBKx/VmsDzCMp/Wap27rUEsacJb6eNSbRVerRnXjCD9GDegC19W7/Dy
	 aDCE/nz1q1o8eLsXXihj5fBzkEHfk7vWFpejxK2t3xztiQukh9iC/TiTzfj9/8uR2K4Dr
	 lpH4020PfC4PYWOHDw8gBDnELlXbbd5IW/ftU5PYsr+c7Xdl0iE1SKlbKG1HOtfCNZLt8
	 t6j5cX/r+rNP5uUwY77e23XflMLusGI0eh5b+4WM7sLS49HboU8VKdKRfWMv/wnCWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9oBwEXRRzD4Ff3hTa/71jc1yF6BC+HAxpTNSMjbQEtk=;
	b=vEdRbRa8IvRoL5EavYy7I/L7lJSGTsUBrnM9soQKPI/HLg52cPCD6Fn0iYKs8W+3RBWD
	 +E9s83iBs3D5GOpoPeEZ8Yn6p1C2ea9uEv7KrPZj8r8ADOjtIWJG3XHaqcNiIx30/vt08
	 7No/SIJ2H6WWbS9QBfZzwAI3+e2k1tGuKUy+AWKsBb2fYLiVDcGmcTE68+kRXn1TLIdK1
	 IO9bql2mMAaEfLadGSpHdnZweG/H+il5VSDs9Af/B8abjlMsqmP/UT9ssA6iQIkb2ADL+
	 PQ7JNsyYqj3GE35uGBlmHRwfcxVNs2p0HtvzX2xx1VNwB6LByHcutLNNBO+GlfdMzGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2IPC+K+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cUGOdKVK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417D606A327
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A417D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2IPC+K+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cUGOdKVK
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA1a61209331
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9oBwEXRRzD4Ff3hTa/71jc1y
	F6BC+HAxpTNSMjbQEtk=; b=d2IPC+K+sazAukoGXPBqWD+uW/TP9wWPpUZsmlZA
	ieTU/Y5V6eigtfsHEUZvZIPRcQcgN6VTs+d9DebC/bx2XQ5r3SNOkOlP6+8VNAn3
	SzMwAfdWqqImZ/8ikEB6BxzpOu5JUpg6t6Fmja4TeRAXzU+IXrB3l9C9NXriBXwm
	ezRRGXOyKrD4s0rGoyHi7R0qkSzGAivd79GPZSo+mmul42rjwpMdxnuYeZ4qpy1T
	sXvrWKoJuYSjwIsk5c6/ckYv2ye4Is6TsZ8yUFIlV1u7B678JcrpiMw7JQ8nNvyD
	6qRt0wmHLXYbSo3wRmmHg8mK+g6aq6mMDZIZm7OXb7HKJw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5panxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:29:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2373e9b4so350179085a.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502983; x=1793107783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9oBwEXRRzD4Ff3hTa/71jc1yF6BC+HAxpTNSMjbQEtk=;
        b=cUGOdKVKnK/nG9yNjxXJzDxLJsYWr0E2Ub/4gQO2ZGxARRW/Tc7oPAM2Vtj1nFdkGC
         W0eeSOTG8HbLFp3piC3jO86mvUyPqX3ZN75uUWR3SSgxeJSlK45UWnTE/42f6xeR1OFX
         H6LAPBGRUr37bfCHs/ufWw2EpFRcJp0V1O0x3074Fy8GHHQWgbfW1nqnfj40Qbh7pQYR
         VURc5QMRUSGO2UOBBKyU2z+7FsNFx4rMZm+7EG5L/fbkUWUPlLjB2waANkL9GHcVBMpD
         9wvwiyCjcF+VKlWUFx6gC99VMDgyTup36s9+gAKUGzlxEyNq9eFwsigii7/Cp2d5eSmF
         RqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502983; x=1793107783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oBwEXRRzD4Ff3hTa/71jc1yF6BC+HAxpTNSMjbQEtk=;
        b=VzUdGGoF7cLRxxZA4PHuC6f/QDo/c18cLtGFgYq1qxRoluLwyw3fKhyQNLE/PsoSZw
         LSU8ILENuv08Ovh48I8xzkfH+gr2dVZI9T7yYvEaPPEgTmP4WpfeHwqraJ1K36LYjsnL
         f2uuibiI0YIphvWu7FMQ+oEJE+y+4N7NHnyyBds9biHore3dxKET92m2dimyQJ5jDSVN
         2Kag/0bef5SFL4E1a6ZGUdLpCekSI5mKqf+EUdBMGvyssUc5cCbqCgD0ii5+3F39QsMV
         Q2BL7burpqsr1Qwrs8gzEcI9OWHXbMxmgqOcHpsBu/A7J9TQr7+2LuvpNV3pMMR33LwP
         XqRw==
X-Forwarded-Encrypted: i=1; AKwUvBy4BqZkqDC+5GeCK9sqGqu4N5KIaxFhhTvpCxveJJjU9fHVXzOR4fvzLAgyZ7CHmChU8fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvjh1+k4LRMk6T+sYvq18+VWAJgWXFqleJffDgW/2BYGpCvEkp
	EvGoGVTrdOsi5z9Y7V8Aoycjc7745TxSrJPMQn/3kxiInIxPEYbUFcTny7OewvueemOFTRs7UBK
	QOE8rL+WY6FzrF1hNYPDZzNl15GreHykNKMV/6O8fEtxXbVDRBI557nc=
X-Gm-Gg: AYBFou3zykYRu0qqbr5lmfZTJc//KT8Oh579AOI5rLIpghmgHG9A8s8VM/eqpZpKO6e
	/eXPLIgMJh8xwcQ8I5dOBA0wO03iLPG09BLdVj7dqWSOAk/eksZCumEw5HL7nOUBT48gS3J1OsT
	sOgex7SEuyCkkeiYhddTCA5veKLBp+scBMzQ7negbrulGF7lcm+xmVvIUrsTUMNMui8iCYsHSN6
	xjQBM/7lshtheGMJfRS5quCLX7zmc50KyC3JUsPzcpIkvIPoHYtlb7lE+qpHynT/gBfF1za0R95
	A5jZL7sWXRB7OYEpcyUC+0HW97SmWJz9+MVF3Ce6GsQJa8zPmmwTUTp0A5OCQ8VT3kpfPIq76zi
	NhNq7DOJEpoeGrg==
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id af79cd13be357-93f29cc7983mr1918670285a.26.1792502982547;
        Tue, 20 Oct 2026 06:29:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id af79cd13be357-93f29cc7983mr1918663585a.26.1792502981752;
        Tue, 20 Oct 2026 06:29:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818d61sm6024062f8f.31.2026.10.20.06.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:40 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:29:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] net: stmmac: fix VLAN tag stripping on
 non-linear RX frames
Message-ID: <atdsxFPHU00Oc0Zk@lore-desk>
References: <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
 <179243151841.3135.10232947668205235199@kernel.org>
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
	protocol="application/pgp-signature"; boundary="INi3XEPXl+Bdj046"
Content-Disposition: inline
In-Reply-To: <179243151841.3135.10232947668205235199@kernel.org>
X-Proofpoint-GUID: 6EC6yjeB5m3_LUYux96CXBTv8rnpLxCe
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad76cc7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=a3DH8UJokq-MAUnuC1gA:9 a=QEXdDO2ut3YA:10
 a=tRD2RFjWxTLXFJH57dcA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfXxjunAvzZVy8X
 ctx6zRm6X5C+CvtEBD+hMajzSo13HzsFVL2+9g7zVH22RTufk9M+urysX51pDruTiEWkQwpl/D1
 EnqZ1ppJp3L2+JOny8y0innx5X8CtZ+OJddryCJzL/KQoWFhUJzLU/4H8WeCUQvmVuBcmLrF1ve
 s/SEGSlg7oe5t4N/Ind5L2nndvmEEgzUqJBFt7weL8jqXERAycHIYAulTpp21iHIwHH4mbaYLi/
 DLamoI112lj7aCCzNXOok4kQgh9Y9o5l+FHpz9lSiBiSn4OwO3/Meunoc6wfuXzE66E26DvhAzb
 5dqbQtcTUzWvTQQuYMe1C9i5oc/XUS2vGMxbqD2ir0hjci5mEZfOA6Pm6Xf3N5JH2J2G0wYLPdh
 DhoBSC6udF7Cr0gnDTsntKjYeqlUt4qwGLqjIqPqm40zUGMfWv9618D+1nAcKnzEFHri+MqPlCM
 l1OCwNnr32tHZc7v2ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfXxGZZj0IVh0Ds
 1ImEahOpgnHvPdr9J9ByEjjM2GAp41Iiepu9TWQ+34b3a4ATVWDajDOGhWkYCTjLpVpsd/qbD7E
 SvuQiYtbTumyUHxl8eZi9ie5woVvAPQ=
X-Proofpoint-ORIG-GUID: 6EC6yjeB5m3_LUYux96CXBTv8rnpLxCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200053

--INi3XEPXl+Bdj046
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message and Fixes: tag describe a crash that cannot
>   happen in any tree this patch would be backported to.
> - [Medium] The commit message says that moving meta_len bytes together
>   with the MAC addresses in stmmac_rx_vlan() keeps data_meta pointing at=
=E2=80=A6
> - [Low] stmmac_rx_vlan() now calls pskb_may_pull(skb, VLAN_ETH_HLEN)
>   before checking h_vlan_proto or dev->features.
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   priv->xstats.rx_dropped is a plain 'unsigned long' (common.h:241)=E2=80=
=A6
>=20
> --
>=20
> net: stmmac: fix VLAN tag stripping on non-linear RX frames
>=20
> This patch makes stmmac_rx_vlan() call pskb_may_pull(skb, VLAN_ETH_HLEN)
> before it reads the VLAN header. When the tag is popped, any XDP metadata
> is now moved along with the MAC addresses. If the pull fails, both RX
> callers drop the frame.
>=20
> > stmmac_rx_vlan() reads the VLAN header straight from skb->data and
> > removes it with skb_pull(), assuming the header is always in the linear
> > part of the skb. That is not true once non-linear skbs can reach it: a
> > program loaded with BPF_F_XDP_HAS_FRAGS can pass up a fragmented frame
> > whose linear head has been shortened to as little as ETH_HLEN by
> > bpf_xdp_adjust_head(), and the unguarded skb_pull() then drives skb->len
> > below skb->data_len, tripping BUG() in __skb_pull().
>=20
> [Severity: Medium]
> Can this scenario happen in a tree that matches the Fixes: tag?
>=20
> On the AF_XDP zero-copy path from bba2556efad6, stmmac_construct_skb_zc()
> always builds a linear skb:
>=20
> 	skb =3D napi_alloc_skb(&ch->rxtx_napi,
> 			     xdp->data_end - xdp->data_hard_start);
> 	...
> 	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
>=20
> On the regular stmmac_rx() path with XDP enabled, multi-descriptor frames
> and buf2 frames are both dropped:
>=20
> 		/* We do not support SG in XDP mode */
> 		if (unlikely(!error && (status & rx_not_ls) &&
> 			     stmmac_xdp_is_enabled(priv))) {
> 		...
> 		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> 			rx_dropped++;
> 			goto next;
> 		}
>=20
> The XDP_PASS skb there is built with napi_build_skb() plus
> skb_put(buf1_len) and has no frags. XDP_PASS skbs with frags seem to
> appear only with the later "net: stmmac: rework stmmac_rx to support XDP
> rx multi-buff" patch in this series.
>=20
> Even with a 14 byte linear head, skb_pull(skb, VLAN_HLEN) here would leave
> 10 bytes of headlen and would not BUG. Wouldn't the BUG() come from
> eth_type_trans()->eth_skb_pull_mac()->skb_pull_inline(skb, ETH_HLEN)
> instead?
>=20
> On current trees, the patch fixes a different case. An XDP program can
> use bpf_xdp_adjust_tail() to shrink a linear frame to 14..17 bytes while
> bytes 12-13 still hold a VLAN ethertype. The old code then reads
> h_vlan_TCI past skb->len and pops the tag. That leaves skb->len below
> ETH_HLEN, and eth_type_trans() passes a malformed skb up the stack.
>=20
> Could the commit message describe that case, and could the Fixes: tag be
> rechecked? As written, stable maintainers may conclude that 5.13+ kernels
> hit a BUG() they do not have.

I will fix it in the next iteration.

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index e929cc0f23125..04dc6dcaa435d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5095,22 +5095,30 @@ static netdev_features_t stmmac_features_check(=
struct sk_buff *skb,
> >  	return vlan_features_check(skb, features);
> >  }
> > =20
> > -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> > +static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -	struct vlan_ethhdr *veth =3D skb_vlan_eth_hdr(skb);
> > -	__be16 vlan_proto =3D veth->h_vlan_proto;
> > -	u16 vlanid;
> > +	struct vlan_ethhdr *veth;
> > =20
> > -	if ((vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> > +	if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> > +		return -EINVAL;
>=20
> [Severity: Low]
> Does this drop every 14..17 byte frame, including untagged ones?

I will fix it in the next iteration.

>=20
> The pull happens before h_vlan_proto and dev->features are checked. Any
> skb with skb->len < VLAN_ETH_HLEN now fails here, and both stmmac_rx()
> and stmmac_dispatch_skb_zc() free it and count it in rx_dropped.
>=20
> This also covers interfaces set with "ethtool -K rxvlan off". There,
> stmmac_set_features() clears hw_vlan_en, so stmmac_rx_vlan() runs for
> every frame. It also covers non-xmac cores, where hw_vlan_en is never
> set.
>=20
> Such frames can come from an XDP program that shrinks a frame with
> bpf_xdp_adjust_tail(), which allows lengths down to ETH_HLEN, and then
> returns XDP_PASS. Before this patch they went through eth_type_trans()
> unchanged.
>=20
> Would it work to check the ethertype and features first? ETH_HLEN is
> enough to read h_vlan_proto, and VLAN_ETH_HLEN would only be needed
> when the tag is about to be popped.
>=20
> > +
> > +	veth =3D skb_vlan_eth_hdr(skb);
> > +	if ((veth->h_vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> >  	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> > -	    (vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> > +	    (veth->h_vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> >  	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> > +		__be16 vlan_proto =3D veth->h_vlan_proto;
> > +		u16 vlanid =3D ntohs(veth->h_vlan_TCI);
> > +		u8 meta_len =3D skb_metadata_len(skb);
> > +
> >  		/* pop the vlan tag */
> > -		vlanid =3D ntohs(veth->h_vlan_TCI);
> > -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> > +		memmove(skb->data - meta_len + VLAN_HLEN,
> > +			skb->data - meta_len, meta_len + ETH_ALEN * 2);
>=20
> [Severity: Medium]
> On the AF_XDP zero-copy path, do the meta_len bytes before skb->data
> actually hold the XDP metadata?

I guess this issue is not introduced by this series. I will fix it with a
dedicated patch.

>=20
> stmmac_construct_skb_zc() records the metadata length but never copies
> the metadata bytes:
>=20
> 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> 	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);
>=20
> The skb comes from napi_alloc_skb(), which does not zero the headroom,
> so the bytes in front of skb->data are stale. This memmove() moves those
> stale bytes in front of the relocated MAC header.
>=20
> After eth_type_trans(), bpf_compute_data_pointers() sets data_meta to
> skb->data - skb_metadata_len(skb). TC BPF programs would then read
> uninitialized headroom instead of what the XDP program wrote.
>=20
> On the regular stmmac_rx() path, skb_metadata_set() is never called at
> this commit. meta_len is therefore always 0 there, and this part of the
> change does nothing until the later rework patch adds the call in
> stmmac_build_skb(). stmmac_construct_skb_zc() is still unchanged at the
> end of the series.
>=20
> Peer drivers such as igc_construct_skb_zc() copy starting at
> xdp->data_meta and then call __skb_pull(skb, metasize). Should
> stmmac_construct_skb_zc() do the same, or should the metadata claim come
> out of the commit message?
>=20
> >  		skb_pull(skb, VLAN_HLEN);
> >  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> >  	}
>=20
> [ ... ]
>=20
> > @@ -5530,12 +5538,15 @@ static void stmmac_dispatch_skb_zc(struct stmma=
c_priv *priv, u32 queue,
> >  	}
> > =20
> >  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> > -	if (priv->hw->hw_vlan_en)
> > +	if (priv->hw->hw_vlan_en) {
> >  		/* MAC level stripping. */
> >  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> > -	else
> > -		/* Driver level stripping. */
> > -		stmmac_rx_vlan(priv->dev, skb);
> > +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> > +		dev_kfree_skb_any(skb);
> > +		priv->xstats.rx_dropped++;
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but priv->xstats.rx_dropped is
> a plain unsigned long shared by all RX queues. Per-queue NAPI contexts,
> which can run at the same time on different CPUs, update it with
> unsynchronized read-modify-write:

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_dispatch_skb_zc():
> 	priv->xstats.rx_dropped++;
>=20
> stmmac_rx_zc() and stmmac_rx():
> 	priv->xstats.rx_dropped +=3D rx_dropped;
>=20
> stmmac_get_stats64() also reads it without READ_ONCE().
>=20
> Can concurrent updates from two queues lose increments here? The new
> error path adds one more writer that follows the existing pattern.
>=20
> > +		return;
> > +	}
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--INi3XEPXl+Bdj046
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdsxAAKCRA6cBh0uS2t
rKQoAP4/pJPKdXpLyqrHEoZ9hjCpzl7Ao3ihZm/BO2XQn+kadQEAiiu1toFS/K4W
U6LBTRJeuv31t0+QLs3auhpkTAQ+/AQ=
=b1Cd
-----END PGP SIGNATURE-----

--INi3XEPXl+Bdj046--
