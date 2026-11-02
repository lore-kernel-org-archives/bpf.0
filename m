Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637983;
	b=TTXaqvZPbsB/0J4MhlRTYNF1tp23lO9/gEKq+1SykCw+s/8+jxk2nGKieHM5OlfmYU+f
	 yHuwUwV+Y4XlbRKBIkQJFZ5sBYJwPZU5MZO+aI9Ml3Z950e4ZXGQ1jHAdYN4J3+qW6beX
	 ht8mozGSCledu0AtE8lbLavBzwla1bS5lyGknvg09gBajZ5gdCVbvJpDuJBULDlVYo6cQ
	 NAPPoW7aHP9BarFvt9q0++gp3ZuYprgjk2oEt6Z8hAT11cOadNuBf98dzUbmcxWBdJwMt
	 4EsCFf9Y3DJNadNvkrkH7QUOQB6sZHFuFY6WJSi/r/sJ3nBOY3QR1xJb9ZcHFZrtfJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OBRwBNy98tEeJXRmz3bwvfnig1QBD5V6eWUA4Fvj20c=;
	b=cEesZOB0EW/Nzfs6ymDGEa6lZQVqWSy1P+tTnfy2rxUQe8kn06K4G7vGVwKYw8Rxy0ps
	 ReVpsJFWzLV5KZ4vHgHO0TmmsOPN+0VBIJcHb9PbTO6rALc9wSpw3iUqytwSBVo+z7stb
	 82mOIaeOpCYr8XAgGFjVQkOnRzN1jP6qAjANiPi4vnV0VXQn/44j6PMvmw+WgZLJaibOq
	 0J8vSI1cvV4wBGLjpC8AqRc2xQxh/PDaMB+/Jnai96h/zBRY2OCY6OgV/IsHmdN/Ivdhc
	 K7RzPIc5vrki0JXnQsKA3Qs9dXsJg9OxkZVLnNVRI+dOSF2L49GHC9OL0I8lq8aC2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5G5ZDVe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65173606BA4D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5G5ZDVe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1724C1F00A24;
	Mon,  2 Nov 2026 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637983;
	bh=OBRwBNy98tEeJXRmz3bwvfnig1QBD5V6eWUA4Fvj20c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5G5ZDVel5qElBqU+OqeIxT0HVAvRo/Bo5XdooVARjTgwKsrbPppxG3HiqgDqDaK8
	 CR2Q6Xcvi0kM+R+ma8Vkom5NIf6RUJHxJP+5ZfM3+4XtRT8y4cYCMv7vKM9QAG+QJm
	 povLWJvzgKREhWFWYYZUIRU3sD2SjcTe4QPRxDDmEJzsYqRswUV/y/j4TLV9U0LzQA
	 AhlBaGP0YbNNPF/KLAqwaUySyASQi1VkurokusvAT9F9NHTw0+Im9XBwSAa1FQsjGE
	 Go+u3UGduCvLVba6hf/Hoe1lA6bQ6Ju3IvNvyw/4jjRpw4JJMKwXOC6iE9MxCU+mY2
	 LUyiIKT7luiJQ==
Message-ID: <sashiko-outbox-193773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: check TCP IP IDs across tunnels
 after GRO and GSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julius Bairaktaris" <julius@bairaktaris.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <741cdd984b05c2e8bccfe6af5c2596f17b3dcccc.1792857378.git.julius@bairaktaris.de>
References: <cover.1792857378.git.julius@bairaktaris.de>
 <741cdd984b05c2e8bccfe6af5c2596f17b3dcccc.1792857378.git.julius@bairaktaris.de>
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
- [Critical] ipv6: seg6: use-after-free of hdr in ipv6_srh_rcv() after iptu=
nnel_pull_offloads()
- [Medium] selftests: net: unchecked tunnel() return status in run_decap()
- [Medium] udp: gso: inner hw_enc_features re-masking clobbers remcsum NETI=
F_F_HW_CSUM
--

commit e0a5534c2eabd4b1e53b2a69aaee94090aff3fec
Author: Julius Bairaktaris <julius@bairaktaris.de>

selftests: net: check TCP IP IDs across tunnels after GRO and GSO

This series updates GSO fixed-ID flag handling across tunnel encapsulation,
decapsulation, and segmentation paths, and adds a network selftest verifying
inner and outer IPv4 IDs across IPIP, GRE, and VXLAN tunnels.

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
When __skb_udp_tunnel_segment() processes a packet with remote checksum
offload enabled, it masks features with skb->dev->hw_enc_features, strips
all checksum bits, and sets only the hardware checksum bit:

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

With SKB_GSO_CB(skb)->encap_level =3D 0 removed here, encap_level remains
greater than zero when gso_inner_segment() invokes inet_gso_segment() in
net/ipv4/af_inet.c or ipv6_gso_segment() in net/ipv6/ip6_offload.c:

	encap =3D SKB_GSO_CB(skb)->encap_level > 0;
	if (encap)
		features &=3D skb->dev->hw_enc_features;

Won't this second masking with skb->dev->hw_enc_features clear the
NETIF_F_HW_CSUM bit that __skb_udp_tunnel_segment() just set for remcsum on
any device where hw_enc_features does not include NETIF_F_HW_CSUM (such as
devices with hw_enc_features =3D=3D 0 or devices only advertising protocol-
specific checksum flags), forcing skb_segment() into the software checksum
path?

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 96c8402a27a54..126058772bc5a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c

[ ... ]

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
In ipv6_srh_rcv(), hdr is initialized from skb_transport_header(skb) at the
start of the function:

net/ipv6/exthdrs.c:ipv6_srh_rcv() {
	...
	hdr =3D (struct ipv6_sr_hdr *)skb_transport_header(skb);

When hdr->segments_left =3D=3D 0 on entry, the skb_cloned(skb) check later =
in
ipv6_srh_rcv() has not run. Calling iptunnel_pull_offloads(skb) on a cloned
GSO packet calls skb_unclone(skb, GFP_ATOMIC) -> pskb_expand_head(), which
allocates a new skb->head buffer and frees the old one:

include/net/ip_tunnels.h:iptunnel_pull_offloads() {
	if (skb_is_gso(skb)) {
		int err;

		err =3D skb_unclone(skb, GFP_ATOMIC);
		if (unlikely(err))
			return err;
	...
}

Can checking hdr->nexthdr after iptunnel_pull_offloads(skb) returns
dereference a dangling hdr pointer into the freed skb->head buffer?

> diff --git a/tools/testing/selftests/net/tcp_fixedid.sh b/tools/testing/s=
elftests/net/tcp_fixedid.sh
> new file mode 100755
> index 0000000000000..88f9298174077
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_fixedid.sh
> @@ -0,0 +1,291 @@

[ ... ]

> +# run_decap <fixed: inner|outer>: VXLAN from NSRC, decapsulated in NRTR
> +run_decap() {
> +	local fixed=3D$1 want=3Dincr flags=3D-F
> +	local r0mac t0
> +
> +	setup || { log_test_skip "decap"; return; }
> +	ip -n "$NRTR" link add vx0 address "$VX_MAC" type vxlan id 42 \
> +		dstport 4789 local 10.1.0.2 nolearning ||
> +		{ log_test_skip "decap"; cleanup_all_ns; return; }
> +	ip -n "$NRTR" addr add 10.3.0.2/24 dev vx0
> +	ip -n "$NRTR" link set vx0 up
> +	tunnel "$NRTR" tun0 ipip 4 10.2.0.1 10.2.0.2
> +	route_into "$NRTR" tun0
> +	noseg "$NRTR" r1
> +
> +	if [ "$fixed" =3D inner ]; then
> +		want=3Dfixed
> +		flags=3D-f
> +	fi
> +	r0mac=3D$(ip -n "$NRTR" -br link show r0 | awk '{ print $3 }')
> +	capture "$NMID" m1
> +	t0=3D$(tx_packets "$NRTR" tun0)
> +	ip netns exec "$NSRC" "$TX" -T -i s0 -M "$r0mac" -s 10.3.0.1 \
> +		-d "$INNER_DST" -n "$SEGS" -b "$BURSTS" \
> +		-V 10.1.0.1,10.1.0.2 -m "$VX_MAC" $flags
> +	wait "$CAP_PID"
> +	check "decap VXLAN with fixed $fixed IDs, into IPIP" \
> +		"$(tail -n 1 "$RESULT")" "$want" 1 \
> +		$(($(tx_packets "$NRTR" tun0) - t0))
> +	cleanup_all_ns
> +}

[Severity: Medium]
Unlike run_encap() and run_encap_decap(), run_decap() does not check the
return status of the tunnel helper when creating the ipip device tun0:

	tunnel "$NRTR" tun0 ipip 4 10.2.0.1 10.2.0.2

If the kernel supports vxlan but does not have ipip support enabled, won't
tun0 creation fail silently here, causing capture to wait for its full poll
timeout and tx_packets to output an empty string that triggers an arithmetic
syntax error in:

	$(($(tx_packets "$NRTR" tun0) - t0))

and fails the test instead of skipping it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792857378.gi=
t.julius@bairaktaris.de?part=3D2
