Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB31E106
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020914; cv=none; b=MiYk1pi98e9EWncxax2gBP4yrE3aB7lzYHZx58si45t82ovwAZyQVaiQl1XMTzW5S/6nwkWck5azv/Ch56Kb4Pr2UpmQCaMLdo5P4ZOiKUvEz2aTWOq5kdZaVTIAOdUIuVfPWCu0rziggXUQWlcVP2T/vXw9Uj6YKQrnpO99Xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020914; c=relaxed/simple;
	bh=0RkpEcMiN488tK59s8M9JQPrxcO9lRoYuZG48QKlmNA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ULprkihiCy6keBaoMT/ylCEOUrKsqBOueNewWNi19i7GZbFBZ2j/6WPzYvo/ItzGSq+AZxni/cN0Om8x6+eWZlSo+W+Up6FWkKwpeqcV7NSLlovgSr8/kOcy28i++CB7z1z0BftrCtB4tb8gEPR0jTrsFkvDowTV/B+qFYynzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9zKd4UF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=proP/74Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9zKd4UF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="proP/74Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791020911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MSVzV+7zvbUIA5pRFEiBSu7+i6jPYbihTCBHKNz0yo=;
	b=G9zKd4UFYaziIDDJXyZJqy3Xx/7nxwuSSU16HGsI2pYXeklmKeQUGYF5559FVp0kRiYH7m
	uPvlCfFgJoQ7iCXN3+rpnfsHUMn59l2awZEhnPK950f6s0OCtgLB6r/YOwNqXyN3aj0D+j
	wIc76d8TTWaueKKaOy95e2H1PcmRFOI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-anF6OWxBNpOE-Dsn9_j9ww-1; Sat, 03 Oct 2026 05:48:30 -0400
X-MC-Unique: anF6OWxBNpOE-Dsn9_j9ww-1
X-Mimecast-MFC-AGG-ID: anF6OWxBNpOE-Dsn9_j9ww_1791020909
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so8840535e9.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791020909; x=1791625709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3MSVzV+7zvbUIA5pRFEiBSu7+i6jPYbihTCBHKNz0yo=;
        b=proP/74ZMYTLfzfDjmq2GqCA3dAJL0zBFCIUs/o7HasphM185vzRDTE5rDgUZP9YXC
         xwrEvnaT6bVuJuJxquIx3/nSDsgVSXkghszMjO9KEMY3jntQc2Ct0dLLNWF3hWFCboQQ
         GUfJ0HTYHYbes5VOXDWGR00sJuF1xtNwDCjkwqf5g6cXmSl5ea6ZjYKabkPhBgiFJ6yp
         1H+p3kB1bmj92+lrkzHe1EoVb/4LYUyhdqG9gjBNYaX4C+PNkkjjEA7Pk1pA0PL+uXWb
         7tVK76E6MEmeY4LBkHT4I31vQCscF83gP99CMuo6EIE7N2nAiS/8/qFaGQC82dVxcRxt
         zCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791020909; x=1791625709;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MSVzV+7zvbUIA5pRFEiBSu7+i6jPYbihTCBHKNz0yo=;
        b=PH+gFWERXYXXU5kbP2pEMk8sKBP65XlxIdRNcXsnzPmiF+2Sou/kKwCny12lKOAYRU
         SVd0MaGqcM21Cvd4HsNFSfQZ1b2j5YpPHKdGSmvUlloI5WJRYuXcKoBDbcmAeQKD6B8g
         BPY4AvoUzYIxNlr9QuFM/H7hFSb+fNPR8Rm7IV+J5N/tEvzHso1CPJUakJoLhMjmDvbX
         PnHhVWXGD85SOD2luZr+lb+9bcgxU20B4DfKZhWp/D5K090T5WQ/CBBZ8cWzxl6vOydc
         CgBCtVax3hX+CmO1rFhholzkHvrhaC80gGNp3iEhjxfoWxKpuE2Zv360dptDzXM9dQEg
         mKqw==
X-Forwarded-Encrypted: i=1; AKwUvBx3hCw5RgC5MAGPuQoDPcmrgNtF7U/58j5GWav6YX4wonFJu4mBBnoILH202UQVa3JPac0=@vger.kernel.org
X-Gm-Message-State: AFuF++kwS3LHIYKEVFJURFXsIxCG2Gp1NRiJEgYQkMyKwqwwNvpI1rCc
	2yhUqmVYD62sUg32cPNong2wFMoAEvl2GrM6oOXO/p8phMoAOdo5kuucqC27VbPGRVkHz89wqDw
	1xVsvgtHK0p8MkNlQLqCt/GSAhgkoD2FedsEBi6n/1ot00Q8tAqBZVg==
X-Gm-Gg: AYBFou0CQL5WlD5Zo4OG2S5HPoiZMnj5xpdAbdaJJs80ssuzaKaDH9fTzyrwj5+cyAs
	mjYg5nk/paPUZdnqsB1sGHqFJPwDns88D3onGZsDSOIV9MQ0mEbwEV6k56Ede4IPnpQ6kWyVH9Q
	Xu8iUKIy3rrSwJ60a9sxdEU2kSJne33nl1tnn/Wo+HM23+I+SMsINvfhEsWb807dk8PpPVcabWb
	f3d0wrsrWSqBjhXJpHlAhsQ5BUbssaXiVjrr0nkn/23r/f7/oEV5L2G+Qgx4AmADXzD+ZkD8kU0
	k8uzGCzxNUJxJoNY7pU0irlBZO7oPbWofPkNrhicdDWAhAkkDKqQvh95PxsMl6JTSRh8F6PRuPr
	EdpCFL8rFe56mC/LszbxSvQWoQa+xSwGJgC9WX9Q=
X-Received: by 2002:a05:600c:3ca4:b0:4a1:6424:41bd with SMTP id 5b1f17b1804b1-4a1681001e3mr27916875e9.27.1791020909054;
        Sat, 03 Oct 2026 02:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3ca4:b0:4a1:6424:41bd with SMTP id 5b1f17b1804b1-4a1681001e3mr27916455e9.27.1791020908587;
        Sat, 03 Oct 2026 02:48:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm37119375e9.10.2026.10.03.02.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:48:28 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:48:25 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net=5D_ice=3A_keep_the_VLAN_tag_of_p?=
 =?US-ASCII?Q?riority-tagged_frames_with_Rx_stripping_enabled?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002103108.2513191-1-poros@redhat.com>
References: <20261002103108.2513191-1-poros@redhat.com>
Message-ID: <70B89D99-E9C5-471A-BCBF-5CD56D92DDA2@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 October 2026 12:31:08 CEST, Petr Oros <poros@redhat=2Ecom> wrote:
>With Rx VLAN stripping enabled the hardware also strips tags with VID 0,
>but ice_receive_skb() only puts the stripped tag back when the VID is
>non-zero=2E Priority-tagged frames reach the stack as untagged and a vlan=
0
>upper device never sees them, while the same traffic works with rxvlan
>disabled=2E
>
>Hit by our QE VLAN test on an E810-XXV, where ping over vlan0 fails and
>tcpdump on the PF shows the peer's priority-tagged ARP requests arriving
>untagged=2E Reproduced on the net tree with a PF and its VF as the peer i=
n
>both single and double VLAN mode=2E i40e had the same bug, fixed by commi=
t
>2a508c64ad27 ("i40e: fix VLAN=2ETCI =3D=3D 0 RX HW offload")=2E
>
>Put the tag in ice_process_skb_fields() keyed on the L2TAG1P/L2TAG2P
>status bits, let ice_get_vlan_tci() report whether a tag was stripped
>(this also fixes the XDP VLAN hint for a zero TCI) and drop the now
>trivial ice_receive_skb()=2E
>
>Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
>Fixes: 714ed949c6f3 ("ice: Implement VLAN tag hint")
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_txrx=2Ec     |  5 +---
> drivers/net/ethernet/intel/ice/ice_txrx_lib=2Ec | 26 ++++--------------
> drivers/net/ethernet/intel/ice/ice_txrx_lib=2Eh | 27 +++++++++++--------
> drivers/net/ethernet/intel/ice/ice_xsk=2Ec      |  5 +---
> 4 files changed, 23 insertions(+), 40 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx=2Ec b/drivers/net/et=
hernet/intel/ice/ice_txrx=2Ec
>index 31303ab5be175a=2E=2E3935ac05a251b4 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx=2Ec
>@@ -970,7 +970,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ri=
ng, int budget)
> 		struct sk_buff *skb;
> 		unsigned int size;
> 		u16 stat_err_bits;
>-		u16 vlan_tci;
> 		bool rxe;
>=20
> 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
>@@ -1051,8 +1050,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_=
ring, int budget)
> 			continue;
> 		}
>=20
>-		vlan_tci =3D ice_get_vlan_tci(rx_desc);
>-
> 		/* probably a little skewed due to removing CRC */
> 		total_rx_bytes +=3D skb->len;
>=20
>@@ -1061,7 +1058,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_=
ring, int budget)
>=20
> 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
> 		/* send completed skb up the stack */
>-		ice_receive_skb(rx_ring, skb, vlan_tci);
>+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>=20
> 		/* update budget accounting */
> 		total_rx_pkts++;
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Ec b/drivers/ne=
t/ethernet/intel/ice/ice_txrx_lib=2Ec
>index e695a664e53d18=2E=2E19307086c238f5 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Ec
>@@ -218,6 +218,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> 		       struct sk_buff *skb)
> {
> 	u16 ptype =3D ice_get_ptype(rx_desc);
>+	u16 vlan_tci;
>=20
> 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
>=20
>@@ -238,29 +239,13 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>=20
> 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
>=20
>+	if (rx_ring->vlan_proto && ice_get_vlan_tci(rx_desc, &vlan_tci))
>+		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto, vlan_tci);
>+
> 	if (rx_ring->ptp_rx)
> 		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> }
>=20
>-/**
>- * ice_receive_skb - Send a completed packet up the stack
>- * @rx_ring: Rx ring in play
>- * @skb: packet to send up
>- * @vlan_tci: VLAN TCI for packet
>- *
>- * This function sends the completed packet (via=2E skb) up the stack us=
ing
>- * gro receive functions (with/without VLAN tag)
>- */
>-void
>-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vl=
an_tci)
>-{
>-	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
>-		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
>-				       vlan_tci);
>-
>-	napi_gro_receive(&rx_ring->q_vector->napi, skb);
>-}
>-
> /**
>  * ice_clean_xdp_tx_buf - Free and unmap XDP Tx buffer
>  * @dev: device for DMA mapping
>@@ -587,8 +572,7 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *c=
tx, __be16 *vlan_proto,
> 	if (!*vlan_proto)
> 		return -ENODATA;
>=20
>-	*vlan_tci =3D ice_get_vlan_tci(xdp_ext->desc);
>-	if (!*vlan_tci)
>+	if (!ice_get_vlan_tci(xdp_ext->desc, vlan_tci))
> 		return -ENODATA;
>=20
> 	return 0;
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Eh b/drivers/ne=
t/ethernet/intel/ice/ice_txrx_lib=2Eh
>index f17990b68b621d=2E=2E579ce56c0c3c0a 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Eh
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib=2Eh
>@@ -70,25 +70,32 @@ ice_build_tstamp_desc(u16 tx_desc, u32 tstamp)
> /**
>  * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
>  * @rx_desc: Rx 32b flex descriptor with RXDID=3D2
>+ * @vlan_tci: VLAN TCI stripped by hardware
>  *
>  * The OS and current PF implementation only support stripping a single =
VLAN tag
>- * at a time, so there should only ever be 0 or 1 tags in the l2tag* fie=
lds=2E If
>- * one is found return the tag, else return 0 to mean no VLAN tag was fo=
und=2E
>+ * at a time, so there should only ever be 0 or 1 tags in the l2tag* fie=
lds=2E
>+ *
>+ * Return: true if a VLAN tag was stripped and stored in @vlan_tci, fals=
e
>+ * otherwise=2E
>  */
>-static inline u16
>-ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
>+static inline bool
>+ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc, u16 *vlan_tc=
i)
> {
> 	u16 stat_err_bits;
>=20
> 	stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
>-	if (ice_test_staterr(rx_desc->wb=2Estatus_error0, stat_err_bits))
>-		return le16_to_cpu(rx_desc->wb=2El2tag1);
>+	if (ice_test_staterr(rx_desc->wb=2Estatus_error0, stat_err_bits)) {
>+		*vlan_tci =3D le16_to_cpu(rx_desc->wb=2El2tag1);
>+		return true;
>+	}
>=20
> 	stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
>-	if (ice_test_staterr(rx_desc->wb=2Estatus_error1, stat_err_bits))
>-		return le16_to_cpu(rx_desc->wb=2El2tag2_2nd);
>+	if (ice_test_staterr(rx_desc->wb=2Estatus_error1, stat_err_bits)) {
>+		*vlan_tci =3D le16_to_cpu(rx_desc->wb=2El2tag2_2nd);
>+		return true;
>+	}
>=20
>-	return 0;
>+	return false;
> }
>=20
> /**
>@@ -132,7 +139,5 @@ void
> ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> 		       union ice_32b_rx_flex_desc *rx_desc,
> 		       struct sk_buff *skb);
>-void
>-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vl=
an_tci);
>=20
> #endif /* !_ICE_TXRX_LIB_H_ */
>diff --git a/drivers/net/ethernet/intel/ice/ice_xsk=2Ec b/drivers/net/eth=
ernet/intel/ice/ice_xsk=2Ec
>index 0643017541c35a=2E=2Efd2e628a8bc95c 100644
>--- a/drivers/net/ethernet/intel/ice/ice_xsk=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_xsk=2Ec
>@@ -591,7 +591,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> 		struct xdp_buff *xdp;
> 		struct sk_buff *skb;
> 		u16 stat_err_bits;
>-		u16 vlan_tci;
>=20
> 		rx_desc =3D ICE_RX_DESC(rx_ring, ntc);
>=20
>@@ -667,10 +666,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> 		total_rx_bytes +=3D skb->len;
> 		total_rx_packets++;
>=20
>-		vlan_tci =3D ice_get_vlan_tci(rx_desc);
>-
> 		ice_process_skb_fields(rx_ring, rx_desc, skb);
>-		ice_receive_skb(rx_ring, skb, vlan_tci);
>+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
> 	}
>=20
> 	rx_ring->next_to_clean =3D ntc;


Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

