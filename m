Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265574;
	b=05RLIfVrXwIk/oAvB6LVtPsRHR7rWDulyRyneELv7wEScrv1LMAs1XbHMvJXX9sVratz
	 Mp2c9oBGVKBJ+7wdDLwm2EnTYkskmhz+6lJLczOUA78q3tBvbqw9CEFB3bT+xlmI253Fb
	 srtujDm8v2L8FWMgJrm22boIE+Eox1Ty1JHCuHwrnkYYShPcKQLdsj9wA7hmkriTl10Pw
	 NHw1iuMt98qCGJWgo5F5kWnWlRfc4m9SL7E0hEtv8CfVR1QZ/zHcWmlgf0jeG0ncRppul
	 iYbngLIUc0qOdrP4eRiRhE3Bp3XNqgg6HYoTFKDrBltX16V5lER/C2P9J5WPkiXMVKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LIa165L0Zj2IddJatSwJxHUv82NuseVwZvDcMe7uhME=;
	b=1iUDf7rmuSm/Okn0/MXlo2vabDv3hu2Xjn+JvLa9wuvxB0G+QKxY4aiVZ6+k06aRwLaY
	 KHvvVNU+UqUh/5+IJLPmNqEgmPNsgH6Vcl3FORqFQX8Nh1gjICQJWb80oHFP3nUvF3rti
	 ht1IjlnImHNGAWbj84S1sNBbRqQNwUDE0jpOn6917d3IkrTOKihbzCMKB5xBo9nlFTIq9
	 4gNzoa1dpdvS08ckGSUhCOPtTcQJJ+vqgGqyY44EAIoiWz+wIHTN1Kglz3PpwA8T5hrKr
	 rKWGCAgGX71+PhnUYQhPJB+N5coG1lT9iOzVr2jq1r3MH1dkdLsf5tTI+1q3FHU8/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieJnPzvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D041606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieJnPzvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E2F1F031E7;
	Thu, 29 Oct 2026 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265574;
	bh=LIa165L0Zj2IddJatSwJxHUv82NuseVwZvDcMe7uhME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieJnPzvOR8RGifD3GpUulFrz6bdH4Gg1DUrJfUVh5dT/sAp6SNqVFAl0aUoDZ3oAg
	 RrmDk6x/mBk/SOj75ZfFlftiGKe1sDK0rq5IytqsGC47bJ8Gak5wWVPFER87JPgiFJ
	 7nPrc74VeZ1IU0MSt/3Q2fJuV6XapIUkNarZQpWiFkDr040aZjRtYv7I5rM2HwDve5
	 +eyi4Cy/Z8+h1wTLK8+i3n7mdV8qY+G9PA0sOs3lZN7RtsCxyP9VgZdinXfRWvoX8x
	 txVya7MmqmUvLRl/oQh8ejiMeqGSF4JkX6B2fbzX7dOPeRjCu3gkbiVR6gE6VOXDqX
	 vkbt12y/qlv/Q==
Message-ID: <sashiko-outbox-189023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:19:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: packet drop on egress in __bpf_redirect_neigh() due to mac_le=
n check
--

commit cc6241a04af2e98e3d6758d1d73c0ca8995faa4a
Author: Jamal Hadi Salim <jhs@mojatatu.com>

bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

This commit adds a check on skb->mac_len and a pskb_may_pull() call in
__bpf_redirect_neigh() before reading and pulling the Ethernet header to
prevent a BUG in __skb_pull() on short or non-linear link-layer headers.

Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kern=
el.org/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..4d344ec097361 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>  				struct bpf_nh_params *nh)
>  {
> -	struct ethhdr *ethh =3D eth_hdr(skb);
> +	struct ethhdr *ethh;
> =20
>  	if (unlikely(skb->mac_header >=3D skb->network_header))
>  		goto out;
> +	if (unlikely(skb->mac_len < ETH_HLEN ||
> +		     !pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;

[Severity: High]
Does checking skb->mac_len < ETH_HLEN here cause __bpf_redirect_neigh() to
drop valid packets on egress and netkit transmit paths?

bpf_redirect_neigh() is available to BPF_PROG_TYPE_SCHED_CLS and
BPF_PROG_TYPE_SCHED_ACT programs via tc_cls_act_func_proto(), which run on
TC egress in sch_handle_egress() and in netkit_xmit() in addition to TC
ingress.

While the receive path sets skb->mac_len in __netif_receive_skb_core() via
skb_reset_mac_len(skb), the transmit path for locally-originated or
L3-forwarded packets leaves skb->mac_len as 0 when pushing the Ethernet
header and only resets skb->mac_header:

net/core/dev.c:__dev_queue_xmit() {
	...
	skb_reset_mac_header(skb);
	skb_assert_len(skb);
	...
	skb =3D sch_handle_egress(skb, &rc, dev);
}

and in drivers/net/netkit.c:

drivers/net/netkit.c:netkit_prep_forward() {
	skb_scrub_packet(skb, false);
	nf_skip_egress(skb, true);
	skb_reset_mac_header(skb);
	...
}

drivers/net/netkit.c:netkit_xmit() {
	...
	netkit_prep_forward(skb, ! net_eq(net, peer_net), xnet_scrub);
	...
	ret =3D netkit_run(prog, skb);
	switch (ret) {
	...
	case NETKIT_REDIRECT:
		dev_sw_netstats_tx_add(dev, 1, len);
		skb_do_redirect(skb);
		break;
}

When sch_handle_egress() or netkit_xmit() calls skb_do_redirect(skb) ->
__bpf_redirect_neigh(), skb->network_header - skb->mac_header is ETH_HLEN,
but skb->mac_len is 0. This causes skb->mac_len < ETH_HLEN to evaluate to
true, freeing the skb via kfree_skb(skb) and returning -ENOTSUPP.

Conversely, if a packet received on an Ethernet device (where skb->mac_len
was set to ETH_HLEN) is forwarded via __dev_queue_xmit() out a device with a
link-layer header shorter than ETH_HLEN, __dev_queue_xmit() updates
skb->mac_header without updating skb->mac_len. The stale skb->mac_len passes
the skb->mac_len < ETH_HLEN check and skb_pull(skb, sizeof(*ethh)) pulls
past skb->network_header into the network header.

Should __bpf_redirect_neigh() instead check that skb->mac_header + ETH_HLEN
<=3D skb->network_header (or skb_network_offset(skb) >=3D ETH_HLEN), simila=
r to
__bpf_redirect_no_mac() and skb_eth_pop()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/bpf_redirect_neigh_=
short_linear.v1.r0.20261028033717-1@mojatatu.com?part=3D1
