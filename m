Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595751;
	b=Ks3f3/46G2D2BrFDojjDFQ77Qa1Dy3+gSpj0y8B4dnnj1QpVKPtJpWC0keL/HRNP5UtX
	 fh8fZkWplG/JZYGAUL7FtAwPCxBix8B8STLQbYcRZnDax7KZ3/ykg1AAZ+4fvnS0U/C7q
	 wxj+J182v8YmDUAFVQRT4DBvHpAm0gjCuZXgzS04vp0r8vvHiF9ohbcmzLwNL9vJqDUIZ
	 i68+165rqZffiZQlxJNCIs7UtKcWy8xtTrqkUdm3yqJXszdZKHChkqDQWU1lehDD5EptE
	 WJhuUXZTA0mcsZKGh3ZzihUy7L8kaQ2dfUXtE8B//Y8CtcIBNy3nE33PZ92LATkxZdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eo3tNC0mRRPJsmkCBGsgTI5z86ot/QGLJ6MaXREfjX0=;
	b=gUBhaC7N32lpwnsj4Nbh/N74yTFttFFktTclU9e8wO5Xk9lETAiR9I3qsXsgwou8nP0a
	 dmimHIKv0yj+x6KvMDedAV5eua+/fPH5/PWE4jJ54ADZtM98635jAbA0IKr4i698Odfiw
	 XD176hc7UWTJ2zJSviruoqWWKA6T8ss1oVTSb8t42xqrq9YiJTtJrhIVpfuOnwnK5BJfw
	 pPrPKnJFOm7Zh7Ni7DiEoyYXc+0zWkkw2NGj7Y7tWYT/eghaxe867ekCL3hdk5K4MlsIG
	 dFdvxHHEzSsAsX1gIhhTrPPJFLd6X/8QORYm2XK1h8qPxzWZJ5wPQSQJs8xZENogn8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hWm5F4/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DA606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWm5F4/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5220E1F01564;
	Wed, 25 Nov 2026 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595751;
	bh=eo3tNC0mRRPJsmkCBGsgTI5z86ot/QGLJ6MaXREfjX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWm5F4/lswfjDGd209gBuPUTFJO6gIIbueMX33ZDJpRgf5fRN+GAC4Y3+4e4sbW8b
	 gHP/yA5Ggpyd0r1PiXqrnVcyROHV5p40JCtAnGlNbSuZRxVKUGiFkjLqts5AxcxGv1
	 8I29lUYnQ4oGRNpjsuq0VC1h2pBqa3ZwIfQzTSB1JMlttrfaBvsWpCqh3a3WX98gre
	 zsXgBag3G3QEsqLf1EugOJpa/gfhx0CWGlCRGiLAxMzwqk5S/s55nmjS3UCcxCfCX4
	 7rf6FcTNTgbJaDanc8WX/2ZSb9TGPp0W93uCDFQmwaXEPjbbDpNivZIPBPfK6/UkBS
	 79XB778lGssGA==
Message-ID: <sashiko-outbox-232914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xsk: fill in header offsets for TX checksum offload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124083520.45547-1-kerneljasonxing@gmail.com>
References: <20261124083520.45547-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:35:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] xsk: missing skb_reset_mac_header() in xsk_skb_sw_csum()
- [Medium] xsk: xsk_skb_sw_csum() overwrites skb->protocol on VLAN
  frames
- [Medium] xsk: insufficient header and protocol validation in
  xsk_skb_sw_csum()
--

commit 751e231dd95b04f38f8084599c2e73e9184ffdfe
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fill in header offsets for TX checksum offload

This commit parses the Ethernet header and VLAN tag stack in
xsk_skb_sw_csum() to populate skb->protocol, the network header offset,
and the transport header offset for CHECKSUM_PARTIAL frames.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index ab2e4fa87a4f0..d599fe161857f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1026,10 +1028,37 @@ static int xsk_skb_metadata(struct sk_buff *skb, =
void *buffer,
> =20
>  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
>  {
> -	if (unlikely(pool->tx_sw_csum &&
> -		     skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +	struct ethhdr eth_buf, *eth;
> +	int nhoff =3D ETH_HLEN;
> +	__be16 proto;
> +
> +	if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL))
> +		return 0;
> +
> +	if (unlikely(pool->tx_sw_csum))
>  		return skb_checksum_help(skb);
> =20
> +	if (unlikely(skb->dev->type !=3D ARPHRD_ETHER))
> +		return 0;
> +
> +	eth =3D skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> +	if (unlikely(!eth))
> +		return -EINVAL;
> +
> +	proto =3D eth->h_proto;
> +	if (eth_type_vlan(proto)) {
> +		proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> +		if (unlikely(!proto))
> +			return -EINVAL;
> +	}

[Severity: Medium]
Should skb->protocol keep the outer eth->h_proto on VLAN frames instead of
being overwritten with the inner L3 protocol returned by
__vlan_get_protocol()?

AF_XDP TX frames carry VLAN tags in-band in skb->data with
skb_vlan_tag_present(skb) false.  When skb->protocol is set to the inner
EtherType, skb_vlan_tagged() and skb_vlan_tagged_multi() return false in
validate_xmit_skb(), which skips the dev->vlan_features intersection in
__netif_skb_features(), bypasses multi-VLAN checksum offload masking in
vlan_features_check(), and breaks driver TX checks such as
ice_tx_prepare_vlan_flags() that test eth_type_vlan(skb->protocol) for
in-band VLAN tags.

> +
> +	if (unlikely(skb_checksum_start_offset(skb) < nhoff))
> +		return -EINVAL;

[Severity: Medium]
Should this check reject skb_checksum_start_offset(skb) <=3D nhoff and
verify that the L3 and L4 headers fit within the skb?

Allowing skb_checksum_start_offset(skb) =3D=3D nhoff sets the network and
transport headers to the same offset (skb_network_header_len(skb) =3D=3D 0),
which passes ice_features_check() and causes ice_tx_csum() to read the
same offset as both the IP and L4 headers.  In addition, because
xsk_skb_metadata() only bounds-checks csum_start + csum_offset + 2 against
desc->len, a short frame with valid csum_start and csum_offset allows
drivers such as ice_tx_csum() and mana_checksum_info() to dereference IP
and TCP header fields past skb->tail.  Finally, on IFF_TX_SKB_NO_LINEAR
devices such as virtio_net where xsk_build_skb_zerocopy() leaves
skb_headlen(skb) =3D=3D 0, setting skb->protocol to an EtherType rejected by
can_checksum_protocol() (such as ETH_P_FCOE) causes harmonize_features()
to strip NETIF_F_CSUM_MASK without linearizing the skb, triggering the
offset >=3D skb_headlen(skb) WARN_ONCE in skb_checksum_help().

> +
> +	skb->protocol =3D proto;
> +	skb_set_network_header(skb, nhoff);
> +	skb_set_transport_header(skb, skb_checksum_start_offset(skb));

[Severity: High]
Does xsk_skb_sw_csum() also need to call skb_reset_mac_header(skb)?

Because __xsk_generic_xmit() transmits directly via __dev_direct_xmit(),
nothing resets skb->mac_header from its initial ~0U (0xffff) sentinel.
When a CHECKSUM_PARTIAL frame reaches drivers that compute offsets or read
headers relative to skb->mac_header, such as ice_tx_csum() (which computes
(skb->csum_start - skb->mac_header) / 2 for NETIF_F_HW_CSUM),
fbnic_tx_offloads() (via skb_mac_header_len()), or ice_xmit_frame_ring()
(which dereferences skb_mac_header(skb)), the driver programs a bogus
checksum start offset or reads out of bounds at skb->head + 0xffff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124083520.4554=
7-1-kerneljasonxing@gmail.com?part=3D1
