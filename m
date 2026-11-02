Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648690;
	b=WK9r27CBLZgK847XT9qGW74JY1Q/aaJedV2q9ne07bVqhrnJokvuRBClGRmrK7O8Xjtt
	 4j0jc2CwLARyteKkKJLtndmxcyvho61bVjdCHt0XVPLJjblkf+mk46f29zwxLIT5qjijR
	 g9zym1DxW42Cf+hn+H7MqkmwBAjdJsaEpq0yedVQpc9mKMvC/fUlT5XKK3weIP2xhimzf
	 v2D62+D3VoiTmkPGquc0ZVIJyPL5IWYv2f4BHre0qU3LclSxPxb/Rurb7LwAgZfn7nlvo
	 Sf1M7p/u7f5QdWlriTFEoCcZEIAx8LP53Vl+k+3UKEsdlfYcw+CUTbwlYmFOHmcqaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q8lzWFcbYJouMtdLAS1/3a6jcoBfGjWkUtbKu1x5/0I=;
	b=Pi1BOcY1sMOgFVMXivkifwS4gA7YSXf2RTByjfR1FZXNg7/rOR3M8H0Q7TotPjYyiY54
	 tOglpqtdd5pRP4aN1WTCZAToM0IzpF7HQ8t9vKo0yhJN/o7/8y9C6pG42yxsQ5gS/9sza
	 2+Lf5iJupuoi/dpixtEQHumDR4n9Gw2ow3x0KIYwL2384SwzVKRge5bjgqwpe9ZEX/gGu
	 gbFsErs3R6o6jHTcvkLsktaVGKBrqF5sIPb9EqhIp4NPMezh1n7o7GUqUU312dDdCTp5o
	 esH856gTjv2RhuNTNiI5t9sdzbeyyF+jubIemqnhEK7Hjq5yquA86xKCk36c1awJZzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D98j2Gna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E82606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D98j2Gna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3311F00A16;
	Mon,  2 Nov 2026 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648690;
	bh=q8lzWFcbYJouMtdLAS1/3a6jcoBfGjWkUtbKu1x5/0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D98j2GnaFT2Kf9lkzIV954tQEaox9BlVt32XCzD6EpxGnWiFcSqzHhmB7WAmZuuMC
	 ij005krQIaXVewL5JBFX74xGjjyOCIJKXayRB9W54F25Lq4NjtPsAWhMkMt8Qp0y3Y
	 0lTP2oEdi2QqissZ35UjLM5U6Bv9TYapjkx4ZzENOPHrXSA6Gn8WwtIVAKXdf7qtLJ
	 ByKFw8BRRP6btjpbHAbM4O1QBvlH93nlHEEry2CsdIoE+jXC7fk5YNf7gCwaH9JO4X
	 qbbR0h3/gfh0JpxGs3hOqp4ygZ8L2GkrtBwHV/azjOwLiE5wsVjBgL7AouFiKuCuTX
	 ZW843+27G6uLA==
Message-ID: <sashiko-outbox-194018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:44:49 +0000
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
- [High] net: negative hdr_len in qdisc_pkt_len_segs_init() only checked fo=
r TCP
--

commit dddca5a283a51c0b9bd1d1aef355eda12933179b
Author: Alexei Starovoitov <ast@kernel.org>

net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()

This commit adds a negative offset check on hdr_len inside the TCP GSO
branch of qdisc_pkt_len_segs_init() to prevent an out-of-bounds read when
a stale transport header points in front of skb->data.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f32353b0467cd..af948e4424035 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4320,7 +4320,9 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init=
(struct sk_buff *skb)
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
>  		const struct tcphdr *th;
> =20
> -		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> +		/* A header in front of skb->data gives a negative offset. */
> +		if ((int)hdr_len < 0 ||
> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>  			return SKB_DROP_REASON_SKB_BAD_GSO;

[Severity: High]
Should the (int)hdr_len < 0 check be placed immediately after hdr_len is
computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 branch?

In net/core/dev.c:qdisc_pkt_len_segs_init(), leaving non-TCP GSO types
unguarded when skb_transport_offset(skb) or skb_inner_transport_offset(skb)
is negative appears to leave three issues:

First, for SKB_GSO_UDP_L4 packets:

	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
		if (!pskb_may_pull(skb, hdr_len + sizeof(struct udphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;
		hdr_len +=3D sizeof(struct udphdr);
	}

When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
include/linux/skbuff.h:pskb_may_pull_reason() before returning
SKB_DROP_REASON_SKB_BAD_GSO.

Second, when -8 <=3D (int)hdr_len < 0 on an SKB_GSO_UDP_L4 packet,
hdr_len + sizeof(struct udphdr) wraps to 0..7. pskb_may_pull() succeeds
without pulling the UDP header into skb->head, hdr_len wraps to 0..7, and
qdisc_pkt_len_segs_init() returns SKB_NOT_DROPPED_YET. If the packet is
then transmitted on a NETIF_F_GSO_UDP_L4 device whose driver uses the TSO
helpers in net/core/tso.c (such as bnxt_sw_udp_gso_xmit(),
enetc_map_tx_tso_buffs(), or otx2_sq_append_tso()), tso_build_hdr()
advances hdr by the negative transport offset:

	hdr +=3D skb_transport_offset(skb);
	if (tso->tlen !=3D sizeof(struct udphdr)) {
		...
	} else {
		struct udphdr *uh =3D (struct udphdr *)hdr;

		/* size is after segmentation. */
		udp_set_len_short(uh, sizeof(*uh) + size);
	}

Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
enetc_tso_hdr_csum()) before the start of the header buffer when
skb_transport_offset(skb) < -4?

Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the end
of qdisc_pkt_len_segs_init():

	qdisc_skb_cb(skb)->pkt_len +=3D (gso_segs - 1) * hdr_len;

When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_len
underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeue()
and ets_dequeue() to spin in their deficit-refill loops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101194433.2637=
113-1-alexei.starovoitov@gmail.com?part=3D1
