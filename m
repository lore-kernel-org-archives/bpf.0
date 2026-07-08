Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400E25A655
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543382; cv=none; b=buRYAUKdoisFAz4xy3mzjv12Pr7fULGKCPlcsREdN2jBfoLv9n+Yi2VSdwvXpadal7rHLyt7T2HCQY5HdtzA5jwXVvAd9EwdfUMjKPIE95O5IoxlaKwf56T9yw5QUKn5duqABh9pYKfy3VL0JwgqXiNUCN4NJ/xHmespKnpU25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543382; c=relaxed/simple;
	bh=kp2HueeBf/PpiD+IrdGJnkoVLKURICLuSnfrL98QrFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EN5bEvICZJbg14wpeH+r5u/bnpjturfsEnLgBQhQCav0tBGsBaDiWGMKP+kd0SBpoo4MKc0NZfYMAzeAQhJrI5dHEf2xcYncv1t71tQqfRKfMywzerZjf5l4cjvuQTAGWZJldIUlXhNSb9YrAx2424oDMwrbyCUg1Lbf5Lecb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/QCKKc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/QCKKc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F267C1F000E9;
	Wed,  8 Jul 2026 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783543381;
	bh=4r+GrTdT8N9amb41Bal7Q0pmm6NJQWJZx/5cYStWsRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/QCKKc54oyU/RILmYrU4V20mJAi9kR+DXnupDYj+19V66cgYasO+L2NHGvYS3UJn
	 XIAcpThEnhiFOa2X44s3+V71GYUYZcbRsskLZh0wK1jbHr9fC9FMwPQ2HhbFlImXRL
	 M7hbSqjpsNMdux//LPwZm6QfvaH0jkZQzIyUGcT2UzTx4MV5ZqPTa+xRj1SWvW1TJ7
	 YW5cLyBJZnOK03Qf5OYyylYcS9DL4dAZA18ovotv8CWn28Q4JJGrXhW87nb3Y9jCoi
	 Ki4ME83x5upNcBJYZnR4sf0yL2TkuVz5PObWeQ9Swkn5nyGrhcw1fr4AVHZGUC5U9Q
	 8DryNXG9qdiYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/6] net: ice: Add xmo_rx_checksum callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708203410.45121-4-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-4-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:43:00 +0000
Message-Id: <20260708204300.F267C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The XDP metadata getter `ice_xdp_rx_checksum` calls `ice_get_rx_=
csum`, which increments hardware statistics (`hw_csum_rx_error` and `hw_rx_=
eipe_error`). This violates the expectation that BPF metadata getters are s=
tateless/idempotent, allowing an eBPF program to arbitrarily inflate these =
statistics by repeatedly querying the checksum, and causes double-counting =
when `XDP_PASS` is used.
--

--- Patch [3]: [PATCH bpf-next v4 3/6] net: ice: Add xmo_rx_checksum callba=
ck ---
commit 7b93052dd91e42401898b8ce9ae946cf9d0f21ec
Author: Lorenzo Bianconi <lorenzo@kernel.org>

net: ice: Add xmo_rx_checksum callback

This patch implements the xmo_rx_checksum callback in the ice driver to
report RX checksum results to eBPF programs. It introduces the
ice_get_rx_csum utility routine to make the checksum code reusable from
ice_rx_csum().

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d1..3aa82ff03d9e2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c

[ ... ]

> +static void
> +ice_get_rx_csum(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype,
> +		struct ice_rx_ring *ring, enum xdp_checksum *ip_summed,
> +		u32 *cksum, u8 *cksum_level)
>  {

[ ... ]

>  	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))=
 {
>  		ring->vsi->back->hw_rx_eipe_error++;
> -		return;
> +		goto checksum_none;
>  	}

[ ... ]

>  checksum_fail:
>  	ring->vsi->back->hw_csum_rx_error++;
> +checksum_none:
> +	*ip_summed =3D XDP_CHECKSUM_NONE;
> +	*cksum_level =3D 0;
> +	*cksum =3D 0;
> +}

[ ... ]

> +static int ice_xdp_rx_checksum(const struct xdp_md *ctx,
> +			       enum xdp_checksum *ip_summed,
> +			       u32 *cksum, u8 *cksum_level)
> +{
> +	const struct libeth_xdp_buff *xdp_ext =3D (void *)ctx;
> +	const union ice_32b_rx_flex_desc *rx_desc =3D xdp_ext->desc;
> +	struct ice_rx_ring *ring;
> +
> +	ring =3D libeth_xdp_buff_to_rq(xdp_ext, typeof(*ring), xdp_rxq);
> +	ice_get_rx_csum(rx_desc, ice_get_ptype(rx_desc), ring, ip_summed,
> +			cksum, cksum_level);

[Severity: Medium]
Will this lead to inflated hardware error statistics?

The XDP metadata getter ice_xdp_rx_checksum() calls ice_get_rx_csum(), which
increments hardware statistics like hw_csum_rx_error and hw_rx_eipe_error w=
hen
a checksum error is detected.

Since XDP metadata getters can be queried multiple times by an eBPF program,
could this cause the statistics to be incremented multiple times for a sing=
le
packet?

Additionally, if the program returns XDP_PASS, the normal SKB receive path
will call ice_rx_csum(), which again calls ice_get_rx_csum(). Does this lead
to double-counting the errors for the same packet?=20

Could the statistics increments be decoupled from the metadata getter?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708203410.4512=
1-1-deliran@verdict.gg?part=3D3
