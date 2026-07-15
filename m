Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860443F096
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152088; cv=none; b=eOI43r0ySRcNEBjIlIxYVCgkZJkEaoRYBWLeYCEn/ExumAatdK9okBE5EdtWDVouNsZBeJ3MKiv0O9tGpVY/lFyv6V3AGCQadIHIcSyqD2BzsNIbHFByk3LAR8ulfNXLXSNL3N0Y7iNmWzxFWSwIlMo2ieYcKnYVk6IZ154XliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152088; c=relaxed/simple;
	bh=AXNuc8HjJ6uNyB0ZiW1iXoR64TXEs5W/cdk2MMjO5Yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pT4h2xPUnYx9DLoDFmf5z2sxBlm10U4iEOFhM2o7evq5j3OF7dQSnCcxPpIca4btkJIoFmZ7wlLTiuKRdwfgO5iukePYPjAPvBKMrch2mmJg2f3g+AG81br2A9bQ3OW2NjDGitIkF1g3756lel6eBjE7BuoYB5XOahd031qkEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJZgHgGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJZgHgGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7221F000E9;
	Wed, 15 Jul 2026 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152081;
	bh=B8CMnNOqg6+mXYvBKYN1gCFrzgVNpo2gXwrtI+WTF8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJZgHgGE30BWsnoio+32bVqDKThNtl8fbobkkCzLirYQf6CZqu+5ur4ujI+f3Zavi
	 8FWUv6zDqgKL8G6HzmPCh6s1FmUN25M/9xxSo6frmuJ83XNWUV4LsZogxWdrTn7m+M
	 W0tQquuo5FIlEEppnMUn4LtGWYc/b5Dr6SatT81ABiY42N5IzUjGgXldDiHf0ffUqP
	 Pk5Cek8eKKgO/CNZyT082yD8DZBjJvyf592Mf/aUYgfFpwB7VYcFUNYDFhaC9Z+Ec7
	 O6q49jb3uEd0e/7aM9/Jy/r2PXUsW/KvFKQ0i8WAu3c+c0AD/XFh/0x373w0yEl+lO
	 qRT4pm09fUt9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/8] net: ice: add xmo_rx_checksum callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-3-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-3-623d5c0d0ab7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:48:00 +0000
Message-Id: <20260715214801.AB7221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `ice_xdp_rx_checksum()` XDP metadata getter calls `ice_get_r=
x_csum()`, which has side effects that artificially inflate hardware error =
statistics and cause double-counting.
--

--- Patch [3]: [PATCH bpf-next v5 3/8] net: ice: add xmo_rx_checksum callba=
ck ---
commit 741cd60a0647d5876e42a8815bc6526c4da474e1
Author: Lorenzo Bianconi <lorenzo@kernel.org>

net: ice: add xmo_rx_checksum callback

This patch implements the xmo_rx_checksum callback in the ice driver to rep=
ort
RX checksum results to eBPF programs. It introduces the ice_get_rx_csum uti=
lity
routine to make the RX checksum code reusable from both ice_rx_csum() and
ice_xdp_rx_checksum().

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d1..3aa82ff03d9e2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
[ ... ]
>  static void
> -ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> -	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
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
Since ice_get_rx_csum() increments hw_rx_eipe_error and hw_csum_rx_error, d=
oes
calling it from the XDP metadata getter artificially inflate these statisti=
cs?

An eBPF program can call the metadata getter multiple times on a single pac=
ket,
which would cause multi-counting. Furthermore, if the program returns XDP_P=
ASS,
the networking stack will process the packet and call ice_rx_csum() which
calls ice_get_rx_csum() again, resulting in double-counting for the error.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-bpf-xdp-me=
ta-rxcksum-v5-0-623d5c0d0ab7@kernel.org?part=3D3
