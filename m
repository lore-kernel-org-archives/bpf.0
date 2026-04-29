Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C0274B3B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497424; cv=none; b=AgsbjO8aR9xHuC2ANugSHy6V+S6SfTpwRkSlUh/VKEWJzdZFe5oNbXDl69QvY2ImALyQdQZ7tahVGq+eKy51pw3ar5qUKEAyZhn0JD0RI64pheejF4QlReTUg0vTzfDfcyvSMK5c3OuNkcnKtipQz3vytSyqltGHZ8exQJpz+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497424; c=relaxed/simple;
	bh=MufoovC3LZu/KkkZHOuip6xx9Ifb8/Ytao7olmQ9oXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K2XQkaBCq+mprnCuOxoGbHYpEigbp+zNvgVlXMdYyhnw/OaerZ3HYueIRN85f9O3W01bTzTgEdj7dC/3U+KnNCf+MrYmoU/aIPpptKc1qCmMicq/X7GAO0yG6bbAtj6JEhzJe89JiwuwlRkCeL8xSq3I4HMeeqAmpPQKOV5m1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrRWASCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrRWASCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D9C19425;
	Wed, 29 Apr 2026 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497424;
	bh=MufoovC3LZu/KkkZHOuip6xx9Ifb8/Ytao7olmQ9oXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MrRWASCQ5acxfurZ+NPV2qXHVtAfMT/Kjx8cLDluMHyHOkZIShGBRXxjgNdggVYAl
	 BZreT3IapMFYWrnPyqmvN0LumsFh4/pYnf+2i0yU65WlIOE9nz63haeA9+7FPCX/ro
	 eofNLIOao9gP9nIfUJxomW2QdiHOa+TvrJ0llCMiarx3Sco3wa0EpxPDYJILwp1qds
	 0/e625R9NFArNBeFktF5115atzn592JFuUFRXNzeetyOuoKrwmhOlE6/QrQZJG+AUU
	 HVpU/ON5+CTKDEoUE/Tt/F1aHXygwNUgyi9sT/L0z2PJ/lRI8gvf83+BhJ4UzOSSaN
	 pMwBIOciu6EpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 6/7] net: bcmgenet: add XDP statistics
 counters
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428205846.2625550-7-nb@tipi-net.de>
References: <20260428205846.2625550-7-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:17:03 +0000
Message-Id: <20260429211704.710D9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] XDP_TX headroom check ignores metadata size, and TSB insertion cor=
rupts metadata state.
- [Medium] Non-atomic updates to global XDP statistics from concurrent NAPI=
 contexts cause data races and cache-line bouncing.
- [Medium] Missing counter increment when `xdp_convert_buff_to_frame()` fai=
ls in the `XDP_TX` path.
--

commit 9febde2d94a02157dc480d909cc304c59196d72f
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP statistics counters

This commit exposes per-action XDP counters via ethtool -S. It uses
the soft MIB infrastructure and increments the counters in
bcmgenet_run_xdp().

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 9dd258567824..02ad2f410d6c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2428,6 +2435,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgene=
t_rx_ring *ring,
> =20
>  	switch (act) {
>  	case XDP_PASS:
> +		priv->mib.xdp_pass++;

Is it safe to update global priv->mib statistics here?

Since bcmgenet_run_xdp() can execute concurrently in multiple independent
NAPI polling contexts (one per RX ring), non-atomic increments to shared
global variables can cause data races and lost increments.

Continually modifying a shared cacheline on the fast-path for every packet
could also force cacheline bouncing across CPUs and degrade XDP performance.
Should these statistics be maintained per-queue or using per-CPU variables
instead?

>  		return XDP_PASS;
>  	case XDP_TX:
>  		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
>  		 * MAC has TBUF_64B_EN set globally, so hardware expects every
>  		 * TX buffer to begin with a 64-byte struct status_64.  Back
>  		 * up xdp->data into the RSB area (which is no longer needed
>  		 * after the BPF program ran) and zero it.
>  		 */
>  		if (xdp->data - xdp->data_hard_start <
>  		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
>  			page_pool_put_full_page(ring->page_pool, rx_page,
>  						true);
> +			priv->mib.xdp_tx_err++;
>  			return XDP_DROP;
>  		}
>  		xdp->data -=3D sizeof(struct status_64);
>  		xdp->data_meta -=3D sizeof(struct status_64);
>  		memset(xdp->data, 0, sizeof(struct status_64));

While not introduced by this patch, does this headroom check and TSB
insertion handle metadata correctly?

The headroom check doesn't account for metasize, which could cause
xdp_convert_buff_to_frame() to fail its own bounds check later.

Additionally, if the XDP program added metadata, it would be located at
[old_data - metasize, old_data]. The memset writes zeroes to
[new_data, new_data + 64], which is [old_data - 64, old_data], potentially
overwriting the original metadata.

Since xdp->data_meta is shifted back by 64 bytes, could it now point to
garbage memory and corrupt the metadata state?

> =20
>  		xdpf =3D xdp_convert_buff_to_frame(xdp);
>  		if (unlikely(!xdpf)) {
>  			page_pool_put_full_page(ring->page_pool, rx_page,
>  						true);
>  			return XDP_DROP;
>  		}

Are we missing a counter increment on this failure path?

The preceding headroom check failure explicitly increments xdp_tx_err before
dropping, but this path returns directly. Since it doesn't fall through to
the XDP_DROP switch case, the dropped packet appears to be unaccounted for
in the new statistics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428205846.2625=
550-1-nb@tipi-net.de?part=3D6
