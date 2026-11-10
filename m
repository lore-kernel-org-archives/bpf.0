Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284603;
	b=tjtmqJhH2Gyh+vyaP8xEylzhDnPkoKuc6rWlfNVJKWtihCGywVHU0aVcW1YZUV6Iuoyx
	 5iOdvmLZCagaP6lqZZMwgRpYt+lu+zTn7hRksjQFLaTIKN+zGH2KDil0uSlW3CjSRHJwk
	 SZfZjT5DrwOjttskbm9jTz161Y1PUpGSSw52JM3w/iVkH/iQEvIKt3QfqeEF9GMvKAc3H
	 B2VEFnhHn3aOY5NQqjof/5D4thsrYPJqV4Qk+Oncr8JpMZ0OlXuAnOWV8hWZ8/9/E09X8
	 YGpf7qabotNkT+tOyBar+uuFu1IXyfBHo3J6mcIfvBPcihFuCNoBVUGhuqfCuf+AXqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FOCp646UUau/69UiSJ9TTbSvbP6+h/P178s1upowjCo=;
	b=TTJA71RbPSA8nLNm9pvtb6BnOgmrBxZYw1bB4FgiSh9Re94YG6ajLwC62HvbPVZX04ti
	 ssDd4AiLqy3xHkt6z4YpnUI2AIlo4lyJZJoItV9/NpjtOVhAvJfhqM9Oa4yq3pWVlBPFh
	 s7CZNuOMhZzXgZxXmRidt1cPBkxDk2XyQ7hSyVQD50LteCroZSHwE7IyhdupevP1sijEI
	 czXnN+xOl+lWLmj8RzJdsjRvzn5cY52SNroA3gVgRe/jcGSfkOuuOOx2Duni+geHG9ey/
	 Ovu5CcsTsgpApEtRIoMww5ItZEx21cRgQca0TMH6GqBkIX9gBiBpwAAqrmSSAhgl3cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4rRzF5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA93606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4rRzF5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D051F0089F;
	Tue, 10 Nov 2026 04:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284602;
	bh=FOCp646UUau/69UiSJ9TTbSvbP6+h/P178s1upowjCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4rRzF5+Qkzd2jxK+Zvt102FP9LqDztfp8EI51wc8rCOkQsMeLTVKDbApLtvAqVy4
	 3WuJetaFqvf/PgBqlxoOEbjieLxhXitm6weCYXQD1m+KReU3oeQuc3WZFnLgDPHVUx
	 44Lfur2Mr4NtRrlU6CPCwkntq4nNndNyhFEKTnSJhIVKl1UCv9mB1FXgx1ThPfWn5s
	 gOC/6ikErZP7z80cxxzRg3E4I3sHO+kHJSYTuEf9mMk2mrq91ZApyywPfsDQNiL07f
	 ZHMsj4xl4T6iQhH7Bki3Q+qP0MKBoiN5GIN+RHRkSXLb8qNb47z9seJ6j++gjH4DT2
	 AA+doALhlfVcw==
Message-ID: <sashiko-outbox-206188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb
 core extension area of xdp_buff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:23:22 +0000
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
- [Critical] ice: invalid page dereference and page leak in
  ice_clean_rx_irq() [1]
--

commit ba151a63223661db4511ce1634b36c26afe91c8f
Author: Tianyi Gao <tianyi@cloudflare.com>

ice: set skb RX metadata from the skb core extension area of xdp_buff

This commit populates skb RX metadata from the xdp_buff skb core extension
area on XDP_PASS in the ice driver and exports xdp_skb_ext_to_skb().

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethe=
rnet/intel/ice/ice_txrx.c
> index a2c7c4962882d..06a1a5fdc43b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
[ ... ]
> @@ -1041,6 +1042,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_=
ring, int budget)
>  		continue;
> =20
>  construct_skb:
> +		ext =3D xdp_buff_skb_ext(&xdp->base);
>  		skb =3D xdp_build_skb_from_buff(&xdp->base);
>  		xdp->data =3D NULL;

[Severity: Critical]
This problem wasn't introduced by this patch, but clearing xdp->data before
checking whether xdp_build_skb_from_buff() succeeded causes an invalid page
dereference and leaks the head buffer [1] when skb allocation fails:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_clean_rx_irq() {
	...
construct_skb:
		ext =3D xdp_buff_skb_ext(&xdp->base);
		skb =3D xdp_build_skb_from_buff(&xdp->base);
		xdp->data =3D NULL;

		/* exit if we failed to retrieve a buffer */
		if (!skb) {
			libeth_xdp_return_buff_slow(xdp);
	...
}

When napi_build_skb() fails inside xdp_build_skb_from_buff(), it returns
NULL without freeing the page_pool buffers attached to xdp. Because
xdp->data is already set to NULL, libeth_xdp_return_buff_slow() passes NULL
to libeth_xdp_return_va(), which translates NULL via virt_to_netmem() and
dereferences an invalid page pointer while leaking the head page.

Should xdp->data =3D NULL be moved after the !skb check (since
__libeth_xdp_return_buff() already clears xdp->data on the failure path)?

[1] https://sashiko.dev/#/bug/linux-d6eb94b5-df62-4b78-9f73-358fdd002a0c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D11
