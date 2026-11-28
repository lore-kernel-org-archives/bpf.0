Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863258;
	b=clRKZE6InJegHfj8ugT1bY8+lMEpdcuJ2+nlD8S2hN0CLJ16x1ecrqeQhyOkvWN7NHFF
	 ScOCsKXlmz1Jq/c8SlK2ogtqyiW7VOzUyqN/eoYxs9Q50gdzKhkLcP7a+aYZX9ZXg54Sn
	 kSauuSOYUTflFIIUgmp6UHwBZvwd9mTVnpnyfbPvwfyJiziLywHePvbDYJolH2bxnAlFv
	 zxGeJgrkZke29L0bWVGmo6bLyimhMpSi8V4JkVHXqd1CPxAJZUb0xvSUP5bLZuiWxyfLu
	 4StqtnYXMEspIYJtAkLI8hZHiRCxETTwq9qkVmdeJWmuzMpLrxNs0l9VOGTyzbvqJtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N+Xm0XAMHoEub66IwQguW17ohk765TLJeAwH3LiTXyU=;
	b=pJwoMspfKkN5Q5md5altW18YbgLSSJWnPwvlhaQk/dS6xhTxvUkQOvXcCnEkEGJRfOjm
	 TSjqj11phJ8SrWFH/CRDFU4qulMXOZG86tvOvGDOr8u1Mrvz5b//1QLbPAmVfzQBZa091
	 gXSZKQTXfYXNd/URLv7bITt6Kfn/zLkq7n4qDIJrNhbViiCLB+u4gRzF6OTFvePsHZtp/
	 llR3dGm5M6rGXlnGsXOLA9UK+mzDEUjhSGe4ZTXd44lBVSmhv9vFUFUO0PZPmFrftmwtP
	 M1ZsmLT5LqsN1vlKbwLkC8i9/8MU5SSMCIi0Q6k7mLgP1YOdrhz+oFWS7hCkRrRSLAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHXp8vYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF2606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHXp8vYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA901F000C1;
	Sat, 28 Nov 2026 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795863258;
	bh=N+Xm0XAMHoEub66IwQguW17ohk765TLJeAwH3LiTXyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHXp8vYTUqWAmKtIp9Xy9u56MCJSd6BxMUnef/3OkCOSbKQPwobcmO0cOy/TleRi5
	 GJjMl0g0PfUfcq6/aFKnbz3ombqUUIfSBPDJH65orgxma481dtUuXRoVZ+mW35znif
	 rx7RpZ1NpyWeyHQK2eK05J7oIR+qh3tnXQcY9530kIz/8u3048sYeQ6sGqQwMEu2Zy
	 C8pmgpwOJSg7CHj0fY4PqXHpHKPGsnboh1431WpRBD93SRwczPUCPzkxSfrA5AbJzp
	 kpCC/r/zOpasaXYwV9sfN153uT5hHpR0iBl+YlcnKeJwUK3jZmiUAjG7rMF7DX9WIP
	 4l9o3nOJQuMZg==
Message-ID: <sashiko-outbox-238639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] xsk: fill in header offsets for TX checksum
 offload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261127105347.72997-3-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
 <20261127105347.72997-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 10:54:17 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] xsk: skb_checksum_help() warning in xsk_skb_sw_csum() on
  nonlinear skb
- [Medium] xsk: missing skb_checksum_help() fallback in
  xsk_skb_sw_csum() for non-Ethernet devs
--

commit 56dbb0a2d6a12181bfa80e8eb8b24e6cbe5b0a5c
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fill in header offsets for TX checksum offload

This commit parses the Ethernet and VLAN headers in xsk_skb_sw_csum() to
populate skb->protocol, the network header offset, and the transport
header offset for AF_XDP TX checksum offload, falling back to
skb_checksum_help() when header validation fails.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 18cbd50047d80..3827d8e4b642a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1028,9 +1032,48 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
> =20
>  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
>  {
> -	if (unlikely(pool->tx_sw_csum &&
> -		     skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +	struct ethhdr eth_buf, *eth;
> +	int nhoff =3D ETH_HLEN;
> +	unsigned int l3_min;
> +	__be16 proto;
> +
> +	if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL))
> +		return 0;
> +
> +	if (unlikely(pool->tx_sw_csum))
> +		return skb_checksum_help(skb);
> +
> +	if (unlikely(skb->dev->type !=3D ARPHRD_ETHER))
> +		return 0;

[Severity: Medium]
Should non-ARPHRD_ETHER devices fall back to software checksumming instead
of returning 0 here?

Returning 0 leaves skb->ip_summed as CHECKSUM_PARTIAL with skb->protocol
still 0 and csum_start unvalidated.  On non-ARPHRD_ETHER devices that
advertise NETIF_F_HW_CSUM (such as loopback with ARPHRD_LOOPBACK or tunnel
devices), can_checksum_protocol() returns true even for protocol 0, so
validate_xmit_skb() does not call skb_checksum_help() either.  On
loopback, if csum_start < ETH_HLEN, loopback_xmit() pulls ETH_HLEN bytes
and delivers a CHECKSUM_PARTIAL skb with a negative
skb_checksum_start_offset(), triggering a WARN_ONCE() in
skb_checksum_help() on the receive path.

> +
> +	eth =3D skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> +	if (unlikely(!eth))
> +		return skb_checksum_help(skb);
> +
> +	proto =3D eth->h_proto;
> +	if (eth_type_vlan(proto)) {
> +		proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> +		if (unlikely(!proto))
> +			return skb_checksum_help(skb);
> +	}
> +
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		l3_min =3D sizeof(struct iphdr);
> +		break;
> +	case htons(ETH_P_IPV6):
> +		l3_min =3D sizeof(struct ipv6hdr);
> +		break;
> +	default:
>  		return skb_checksum_help(skb);
> +	}
> +
> +	if (unlikely(skb_checksum_start_offset(skb) < nhoff + l3_min))
> +		return skb_checksum_help(skb);

[Severity: Medium]
Can calling skb_checksum_help() on these fallback paths trigger a
WARN_ONCE() when the socket is bound to an IFF_TX_SKB_NO_LINEAR device
such as virtio_net?

d73a9a63f9f7 ("xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR
devices") rejected binding in xp_assign_dev() only when pool->tx_sw_csum
is set.  When pool->tx_sw_csum is false, xsk_build_skb_zerocopy() still
builds skbs with skb_headlen(skb) =3D=3D 0 on IFF_TX_SKB_NO_LINEAR devices.
If a frame with XDP_TXMD_FLAGS_CHECKSUM hits any of these fallback
branches (for example, a non-IP ethertype or a csum_start smaller than
nhoff + l3_min), skb_checksum_help() sees offset >=3D skb_headlen(skb),
fires WARN_ONCE(), and returns -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127105347.7299=
7-1-kerneljasonxing@gmail.com?part=3D2
