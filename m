Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794108914;
	b=uSVBMYWAe27r/fDAqYYX4e4ga9/B7QBYhFQ4I55+NxNuLaAMqJgCIn97SJoz9FrtMAb2
	 WsxInmNv62hu039DeKnu1yYYCW1m9eN0eq4EboCIjP3YECt20YtBNePqn7S/sqcpabniN
	 2ZCR/Q4eHr1WYZrxn+ZHl1CePvSXj4ozAfBFn3/LP0dmLldgDR+HbvmdQdgV6Y/XSU8nc
	 cz0LXyvgg6cmsVP56bsGu8EtUOtjtLRrzduRYNrEUqPq86GRzkbL2yGTejukw1BqtRD8o
	 +r8mCEGUhJmIZd+EefuUu8Y6KuFnUEIYnY6iTPqRWkvSZJptKYQl69ygDzx3fCAI/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794108914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UermEp/kN5X2ZeI3Bgp/rn/mdlwnSlBUptenjtmn5ic=;
	b=tottxSB6pXTptWjI2A1GhjBYPl82QjfNWcW/Is89DPJJS3IGjJPpB4meanArdnRKPrV5
	 hoFSCdr9NGUyRj/QHwB4MqrkUPKC9b1zbbN0/uTCgcWichvTVXxHx3ndmvlfiYp/wtvyU
	 7V1q4vGeqXIKxx3sA5ZatROf/1j6r+481sdufreRZIofRTOIe9ObXAIbZTzP/HZAnIc7x
	 lTiMuayVhqQy3tgVYtLLpiggUKBkgX31Nf0gqMKYnKsxqreXIgKtZ6Ypgo8xF/rkHKLdI
	 ySxmqAynBJOUBkV+rZTEZAOCnkJIDeTddwc4irHnGd5ZkkZ5o0SosozrOSoGz1Tmcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHBRIBJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE2606A31A
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHBRIBJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DD01F0089F;
	Sun,  8 Nov 2026 03:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794108913;
	bh=UermEp/kN5X2ZeI3Bgp/rn/mdlwnSlBUptenjtmn5ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHBRIBJiqStJLA+maCmiRijqgdjxE04aqlklJJOxkJw1+Qa5789b0rBHhWK/9BTyf
	 QY+30+H1DGTJw6Zg1rBdMqSS8f/8hGUyde3Tv/pMoi97Sl1w4I+NOhotlmrCdywQVp
	 P5ANch7c7V8yqwy7ibYXbTJROe02iQGhn7qiqIRxuB1nTsZqoBiU43EmAQxLhnMl++
	 aSI1uzrQC2LNFltu/uBfFFMwJmpK/gk4DJLgE6bFFd4L4gUOqfLCjvWSzJqHF8pMbe
	 PrzJVozwRTItuDxuzmiuIidHvsglRWMP6vLP74X5ebSdbfTMjuAhVsTiGUGm3IdMkW
	 NHqteH5jRw/CQ==
Message-ID: <sashiko-outbox-203545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/8] net: reserve extra TX headroom for local
 egress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Gao" <tianyi@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <4b2f20b9a7bcca58fced690d20916efab55ad31a.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <4b2f20b9a7bcca58fced690d20916efab55ad31a.1794020868.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 03:35:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] xsk: u16 overflow of skb->csum_start in xsk_skb_metadata() [1]
--

commit 5b52f2c11788442c9d7cb29588e09f1fbbe3b128
Author: David Keogh <dkeogh@amazon.com>

net: reserve extra TX headroom for local egress

This commit updates local packet allocation paths in IPv4, IPv6,
AF_PACKET, and AF_XDP to include the device's configured extra TX
headroom via LL_ALLOC_SPACE(), LL_ALLOC_SPACE_EX(), and
netdev_tx_alloc_headroom().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 781ba46eb1525..3ee8ad3fd1556 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1045,7 +1045,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
>  	buffer =3D xsk_buff_raw_get_data(pool, addr);
> =20
>  	if (!skb) {
> -		hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
> +		hr =3D max(NET_SKB_PAD,
> +			 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(xs->dev)));
> =20
>  		skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
>  		if (unlikely(!skb))
> @@ -1128,7 +1129,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>  		len =3D desc->len;
> =20
>  		if (!skb) {
> -			hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> +			hr =3D max(NET_SKB_PAD,
> +				 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(dev)));
>  			tr =3D dev->needed_tailroom;
>  			skb =3D sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
>  			if (unlikely(!skb))

[Severity: High]
This problem wasn't introduced by this patch, but can hr + csum_start
overflow the u16 skb->csum_start field in xsk_skb_metadata() [1]?

net/xdp/xsk.c:xsk_skb_metadata() {
	...
	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
		csum_start =3D READ_ONCE(meta->request.csum_start);
		csum_offset =3D READ_ONCE(meta->request.csum_offset);

		if (unlikely(csum_start + csum_offset +
			     sizeof(__sum16) > desc->len))
			return -EINVAL;

		skb->csum_start =3D hr + csum_start;
		skb->csum_offset =3D csum_offset;
		skb->ip_summed =3D CHECKSUM_PARTIAL;
	}
	...
}

When a UMEM is registered with chunk_size equal to PAGE_SIZE on a 64KB
page kernel (or with a large headroom reservation), desc->len can be up to
65536 and hr + csum_start can exceed U16_MAX while still passing the
desc->len check.  Truncating the sum into skb->csum_start wraps it below
skb_headroom(skb), making skb_checksum_start_offset() negative and
triggering skb_dump() and WARN_ONCE() in skb_checksum_help() or passing a
malformed skb to the driver in validate_xmit_skb().

[1] https://sashiko.dev/#/bug/linux-38d27ef1-cee4-4d03-9410-7bc1d8e0c2f6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794020868.gi=
t.tianyi@cloudflare.com?part=3D2
