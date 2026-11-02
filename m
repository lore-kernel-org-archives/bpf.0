Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637983;
	b=2bLkMnZSRk0TyHj7ziXczdMQa63jmDsl2uHjmL0WVRhJCORnS+WidHISCV2Ybq5LP8z0
	 xSYTb5CqZ1NgCW+zgPWCFp1qPd71pNt9RGwzzmZ1e22tnG3VZtM1/CKN777MkF0IARMvE
	 pQGL0G/V1+TXiztzNpMPdbpx2IJqiljf1Vxau7GWx+9J8+/oDePE+UAkpQGLgu/5f8Fn/
	 ysqHAsT32do3sjADjj/wUdahBAZbxjojKXM4QQlE1XSKhMSxFyrailhP4miTH405Lbxht
	 VEPfPbdahxFvPojjNM9sf8JrhfpUm26Meldb1BhDpIgzMb+Vf+aqQw/WI6sUqhYCzRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O0cioEyNIbVMT9/FruIe1KQh7GqPh9wABUT7BjLKGLc=;
	b=eo9rTQ4s4Vlx96L2Z8tZlhAIMmg8m2jhivqQWP/zjSujdJ9LfG4spGM1uQ0apfuwUlAp
	 tQ0VL3eRKRTSUR/tdeG9e0Zblvx+cPPb2lFx8xBLWrHvaRTRNtq6oAmzvNtb2jeuFbtSr
	 s6l4ZFQrsRhEFBbJ6bpCxi9+bYiJjzDPR/1TLJzp3xtEJ31ys+vXOlv4K9ZK6QKt8Li8W
	 V/dkyRTG+lXlroT6SVYO9Uw2FQtZcfaXFNkTSaklNn+nuGUcl5FeWx7L0oZ0FbFVjJmwU
	 VhgVYGHy7KX1SLC30rR2EzVq7Y34xKAZwWciuW1G2KeB8MVPSoyCzDXEK9fAbj+vYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LcSFG/zJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C7606B0E7
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcSFG/zJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D91F01577;
	Mon,  2 Nov 2026 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637982;
	bh=O0cioEyNIbVMT9/FruIe1KQh7GqPh9wABUT7BjLKGLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LcSFG/zJpXpfwms4UokFQYzTXUVM9JX0O2Xc8At+BiFaFZOfOktM67YkjI6FBu2GT
	 6BjZK7YT0D8elJAozLz1taM8vanZSnw7+RJ3FO0nONKkw3I50LcO8XAWGcWoivt7Lg
	 CN1PCUWJjrBCuI37OrBEivBTvKDVA0roXzxVSJtgs4m7TJzxlpg5xYhQrSEow49IIL
	 NgPNsiHZdRXhuDYLVFfRAbAgHLFf3iOXRKwv5piMZK39jEIKPQT9fei2kwfuHF/dW5
	 C6slTfL8SXx3qxa4dJj1HThLeikXuHnZg2frtZzDgtM3s+SUXZfekcmpXXaz7gWbRX
	 Y/ltV12onADDw==
Message-ID: <sashiko-outbox-193772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: keep the TCP fixed-ID flags on the header
 they describe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julius Bairaktaris" <julius@bairaktaris.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
References: <cover.1792857378.git.julius@bairaktaris.de>
 <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:46:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] ipv6: use-after-free of hdr in ipv6_srh_rcv() after iptunnel_p=
ull_offloads()
- [Medium] net: __skb_udp_tunnel_segment() loses remcsum NETIF_F_HW_CSUM wh=
en encap_level > 0
- [Medium] net: geneve_post_decap_hint() leaves fixed-ID flag on outer head=
er after decap
--

commit f6a9b837efd7885691511746c504ec36f4d4eb89
Author: Julius Bairaktaris <julius@bairaktaris.de>

net: keep the TCP fixed-ID flags on the header they describe

This commit introduces skb_gso_fixedid_encap() and skb_gso_fixedid_decap() =
to
move the SKB_GSO_TCP_FIXEDID and SKB_GSO_TCP_FIXEDID_INNER flags between
headers during tunnel encapsulation and decapsulation. It also preserves
SKB_GSO_CB(skb)->encap_level in gre_gso_segment() and
__skb_udp_tunnel_segment() so inner IPv4 headers are segmented using the in=
ner
fixed-ID flag.

[ ... ]

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 5cccf4c0e6913..c2ffda6029a06 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -665,6 +665,8 @@ static inline int iptunnel_pull_offloads(struct sk_bu=
ff *skb)
>  		err =3D skb_unclone(skb, GFP_ATOMIC);
>  		if (unlikely(err))
>  			return err;
> +		if (skb->encapsulation)
> +			skb_gso_fixedid_decap(skb_shinfo(skb));
>  		skb_shinfo(skb)->gso_type &=3D ~(NETIF_F_GSO_ENCAP_ALL >>
>  					       NETIF_F_GSO_SHIFT);
>  	}

[Severity: Medium]
When a double-encapsulated Geneve GSO packet carrying a GRO hint option is
decapsulated in geneve_udp_encap_recv(), iptunnel_pull_header() calls
iptunnel_pull_offloads(), which shifts SKB_GSO_TCP_FIXEDID_INNER into
SKB_GSO_TCP_FIXEDID and clears skb->encapsulation.

Immediately afterwards, geneve_udp_encap_recv() calls geneve_post_decap_hin=
t()
to restore encapsulation state for the nested tunnel:

drivers/net/geneve.c:geneve_udp_encap_recv() {
    ...
	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len, inner_proto,
				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
		dev_dstats_rx_dropped(geneve->dev);
		goto drop;
	}
    ...
	if (geneve_post_decap_hint(sk, skb, sizeof(struct genevehdr) +
				   opts_len, &geneveh)) {
    ...
}

drivers/net/geneve.c:geneve_post_decap_hint() {
    ...
	skb->encapsulation =3D 1;
	skb_set_transport_header(skb, gro_hint->nested_tp_offset);
    ...
	if (uh->check) {
		...
		skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL_CSUM;
		...
	} else {
		skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL;
	}
    ...
}

Doesn't this leave the fixed-ID flag for the innermost TCP/IPv4 header in
SKB_GSO_TCP_FIXEDID instead of SKB_GSO_TCP_FIXEDID_INNER while
skb->encapsulation is 1, causing subsequent segmentation or decapsulation of
the nested tunnel to apply the inner TCP fixed-ID state to the nested tunne=
l's
outer header and lose the fixed-ID state for the innermost IPv4 header?

[ ... ]

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a2..edcabe1115a60 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -205,7 +205,6 @@ static struct sk_buff *__skb_udp_tunnel_segment(struc=
t sk_buff *skb,
> =20
>  	/* setup inner skb. */
>  	skb->encapsulation =3D 0;
> -	SKB_GSO_CB(skb)->encap_level =3D 0;
>  	__skb_pull(skb, tnl_hlen);
>  	skb_reset_mac_header(skb);
>  	skb_set_network_header(skb, skb_inner_network_offset(skb));

[Severity: Medium]
In __skb_udp_tunnel_segment(), when SKB_GSO_TUNNEL_REMCSUM is active, featu=
res
is first masked with skb->dev->hw_enc_features and then updated to strip
NETIF_F_CSUM_MASK and set NETIF_F_HW_CSUM before calling gso_inner_segment(=
):

net/ipv4/udp_offload.c:__skb_udp_tunnel_segment() {
    ...
	features &=3D skb->dev->hw_enc_features;
	if (need_csum)
		features &=3D ~NETIF_F_SCTP_CRC;

	if (remcsum) {
		features &=3D ~NETIF_F_CSUM_MASK;
		if (!need_csum || offload_csum)
			features |=3D NETIF_F_HW_CSUM;
	}

	/* segment inner packet. */
	segs =3D gso_inner_segment(skb, features);
    ...
}

With SKB_GSO_CB(skb)->encap_level remaining non-zero, both inet_gso_segment=
()
and ipv6_gso_segment() see encap as true and mask features with
skb->dev->hw_enc_features a second time:

net/ipv4/af_inet.c:inet_gso_segment() {
    ...
	encap =3D SKB_GSO_CB(skb)->encap_level > 0;
	if (encap)
		features &=3D skb->dev->hw_enc_features;
    ...
}

Won't this second masking clear NETIF_F_HW_CSUM on any device where
hw_enc_features does not include NETIF_F_HW_CSUM (such as devices without
hardware tunnel checksum offload or NICs that only advertise
NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM in hw_enc_features), forcing software
segmentation to compute unnecessary inner payload checksums and disabling
GSO_PARTIAL and frag_list segmentation for remcsum packets?

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 96c8402a27a54..126058772bc5a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -53,6 +53,7 @@
>  #include <linux/ioam6_genl.h>
>  #include <net/ioam6.h>
>  #include <net/dst_metadata.h>
> +#include <net/ip_tunnels.h>
> =20
>  #include <linux/uaccess.h>
> =20
> @@ -406,7 +407,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct =
inet6_dev *idev)
> =20
>  			skb_reset_network_header(skb);
>  			skb_reset_transport_header(skb);
> -			skb->encapsulation =3D 0;
> +			if (iptunnel_pull_offloads(skb)) {
> +				kfree_skb(skb);
> +				return -1;
> +			}
>  			if (hdr->nexthdr =3D=3D NEXTHDR_IPV4)
>  				skb->protocol =3D htons(ETH_P_IP);
>  			__skb_tunnel_rx(skb, skb->dev, net);

[Severity: Critical]
In ipv6_srh_rcv(), hdr points into skb->head via skb_transport_header(skb)
before entering the segments_left =3D=3D 0 decapsulation block:

net/ipv6/exthdrs.c:ipv6_srh_rcv() {
	hdr =3D (struct ipv6_sr_hdr *)skb_transport_header(skb);
    ...
looped_back:
	if (hdr->segments_left =3D=3D 0) {
		if (hdr->nexthdr =3D=3D NEXTHDR_IPV6 || hdr->nexthdr =3D=3D NEXTHDR_IPV4)=
 {
			...
			if (iptunnel_pull_offloads(skb)) {
				kfree_skb(skb);
				return -1;
			}
			if (hdr->nexthdr =3D=3D NEXTHDR_IPV4)
				skb->protocol =3D htons(ETH_P_IP);
    ...
}

When skb_is_gso(skb) && skb_cloned(skb) is true, iptunnel_pull_offloads()
calls skb_unclone(skb, GFP_ATOMIC) -> pskb_expand_head(), which reallocates
skb->head and frees the old buffer.

Doesn't reading hdr->nexthdr after iptunnel_pull_offloads(skb) cause a
use-after-free read from the old skb->head buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792857378.gi=
t.julius@bairaktaris.de?part=3D1
