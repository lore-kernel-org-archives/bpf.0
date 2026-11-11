Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392569;
	b=ambfF+GbwSR/74fBBxazQr4vvoMvaIBZvBKJthTWYF0iVUm7C2BcDVa6qcNL0D7XUP0W
	 3z6SAk05burhUWo9MnQhig08nknXZLd7on7oCEm//G6+LisrpxHR7keI0wI/fEkU8BcIi
	 dW/SRdSah+WFQI97dGH+ysHqAWbJwNy9E24b57Wg1qF4eXTlQG+Pj/+4xRfQayqEE7xqt
	 K/Kslh3NT9KkbPavOSNSCZATExD6ypePi2LukPdt4pLUIjJAF123Fe8ZeGu3ESD6FC1Dd
	 QWlNJVeRHe5nsGMX2UN9zp2WKaMFLl4E0NYnwIC7mnkqESkkYD2Bor3JndYnUXy/AXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T6+SdNeK4N3YtroRY0lL44CGGywhKkR8TgHynVTAvSE=;
	b=0rOmo/EuDmZHGSzMbJ/xHiB56U7460FADsRY+OtkNptDnMJ7Il8EbjjDBeGjwxbwjRJY
	 8ThVpH2K+ZKWax8WqOQ9TZYgWx35jjnQtJ138W1Pl9UboXbjeHi7+XAsC0XCsaiXr9FPN
	 js+BDbe5vsdXIQk1Ic82MtcT8yUXFeRPGCuYqr+FmH+0q7aF8F+vBojzA8z6HV4MWvHI9
	 XXCmAY+Dyn7wIshYY3foGpTcEqbUpnBmeKOEzm7MzgNlMwsBg4wUutZtp+moGxQGK483y
	 RvkyrAgQ9PqYzCLHyiPOsbuQwoopixnFxY9U40Wni6978xYWSuEVBX/Hwzpx/qK95bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDjr3vMv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC01606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDjr3vMv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653531F00A05;
	Wed, 11 Nov 2026 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392569;
	bh=T6+SdNeK4N3YtroRY0lL44CGGywhKkR8TgHynVTAvSE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YDjr3vMv8dnJYnKaaT00Oc1wtGY9vfN8tRBeSGA9aSdTwDeaZKyxu1qo2a5wmDBZg
	 EVCm15214Gau8nHbsNRgQ6HMnWMY+KtfJ6NB+xFi5BQtgZquO3nnvQLdQQsVNEAGj0
	 e+fjnrRgQQgsaeXC8/pwlzwxQYb2iB9FVmX+2xCiXXYo4HLxjneHC84Lbrdo9Y3AeG
	 hf5/uMr9ohsaEMDx0OQR5cS7YrhnSLnT8ATp1mYbk3CiILYsGUu5AW0sNEg5iM0xN+
	 7JznfyvZ9pIiflemqzpev70OY1TZa6QNLT1N1RUyZjrGJsqtuBrMXa0bH+3h2ZDP7M
	 Jz4u+vlh8POIg==
Message-ID: <sashiko-outbox-208791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 08/11] eth: fbnic: Support XDP redirect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-9-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-9-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:45 +0000
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
- [High] eth: fbnic: memory leak in fbnic_pkt_prepare() [1]
--

commit 8a7293bd4896ffd0472ecd918ba40c84ba4499d4
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

eth: fbnic: Support XDP redirect

This commit adds support for the XDP_REDIRECT action in fbnic, including
flushing redirected packets at the end of the RX completion poll and
advertising NETDEV_XDP_ACT_REDIRECT.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> index 0bcee152d47c3..51d573c9c5b83 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
[ ... ]
> @@ -1336,6 +1343,16 @@ static int fbnic_clean_rcq(struct fbnic_napi_vecto=
r *nv,
>  				pkt_tail =3D nv->qt[0].sub1.tail;
>  			} else if (PTR_ERR(skb) =3D=3D -FBNIC_XDP_CONSUME) {
>  				fbnic_put_pkt_buff(qt, pkt, 1);
> +			} else if (skb =3D=3D ERR_PTR(-FBNIC_XDP_REDIRECT)) {
> +				redirect =3D true;
> +			} else if (skb =3D=3D ERR_PTR(-FBNIC_XDP_REDIRECT_ERR)) {
> +				/* A broadcast may queue frames, then fail. XDP
> +				 * consumed the packet, so it also counts as
> +				 * received.
> +				 */
> +				redirect =3D true;
> +				dropped++;
> +				fbnic_put_pkt_buff(qt, pkt, 1);

[Severity: High]
This problem wasn't introduced by this patch, but can fbnic_pkt_prepare()
leak the existing packet buffer [1]?

If fbnic_clean_rcq() sees consecutive FBNIC_RCD_TYPE_HDR_AL descriptors
without an intervening FBNIC_RCD_TYPE_META descriptor, it calls
fbnic_pkt_prepare() again on the same pkt:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:fbnic_pkt_prepare() {
	...
	/* data_hard_start should always be NULL when this is called */
	WARN_ON_ONCE(pkt->buff.data_hard_start);
	...
	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
	...
}

Reinitializing pkt->buff without first calling fbnic_put_pkt_buff() drops
the reference to the previously allocated head page and any attached
fragments, allowing a malfunctioning or compromised device to leak page_pool
buffers.

[1] https://sashiko.dev/#/bug/linux-155b4068-9e56-4cd0-bea5-9b3a787a5d5d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D8
