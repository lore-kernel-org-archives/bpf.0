Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3783F4127
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745000; cv=none; b=pmBOSSn7Tjfu6YflKH4h3pYaP2nfWOGqZ5NuYzvndn3Z0+6TKCNk7KH6kv6Y2v9zUqdALhQvojm5tgXBHIETJ5iIeOyDNGY2hwXln4+1WQYJaXhIdaePfTx7+lFyJYnfpf/29M7+IGL9TaC+tLAwMUZkgcfdap8SpslRk7v2Zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745000; c=relaxed/simple;
	bh=Tlr2feUTpbmFNq8ie5eq90DpzQhllEdYAO0wBj6UzDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5vHv2XHKfxAllEkez7gzh1v3o7fVLjPPzk7uCfEzjKgW+RyC6+9QAEAeyMMHXg9Xcy4VwBrTHzbKI4qiPEZRb2G93gWzsznHjh/qK7QZY46nTsksdp/1G9FdL25kcx4H/dPdvITQXjAgjUyN5frRFDO1xfwcocI8XeoBqWsFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCuf9XRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCuf9XRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A5FC2BCB7;
	Thu, 14 May 2026 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778745000;
	bh=Tlr2feUTpbmFNq8ie5eq90DpzQhllEdYAO0wBj6UzDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FCuf9XRzFvYos8TDdCr7IbidmmBbV/lRBW1KMDuXLvgdEcqxY3kxIxzvavX1Wvfgu
	 8/HIDTO2fzWNKBfkPpptIkrBgwoRzd/N9OE0loK+LymQO7PcOLi4m5c10WQborfaHF
	 d88lOZa9WP/1h68fHGb04BdDAFrdbv3sxA/PoIbSiHg0JwiQ3f5xmsZdC2vqHkEZAf
	 USOZWWQ07/zM6Vqbx60ASJ9wlqNVaVqRgdspXA1IW5jPkeEjAaxoRzqq0unFT0rHn4
	 n28a5G5Le/JVIWh7v8U60oEe0prwZyxTrNoNgTteGweTZlRbMTvLPHWCq8k8dQ9SF6
	 mcCpjzllRjWpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nimrod Oren" <noren@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513072355.1083381-1-noren@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 07:49:59 +0000
Message-Id: <20260514074959.C0A5FC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incomplete checksum fold in csum_fold_helper causes persistent o=
ff-by-one errors
- [Medium] Unconditional update of IPv4 UDP checksum corrupts packets with =
no checksum
- [Medium] Offset parameter is used to modify packet headers before it is b=
ounds-checked and clamped
--

commit 2e32120c7c113684b13c8a13f5c0a114c19b097e
Author: Nimrod Oren <noren@nvidia.com>

selftests: net: Fix checksums in xdp_native

This commit fixes data adjustment cases for IPv4 by adding updates to the
IP and UDP checksums in the IPv4 branch.

> diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/tes=
ting/selftests/net/lib/xdp_native.bpf.c
> --- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
> +++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
> @@ -268,6 +268,16 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, _=
_u16 port)
>  	return XDP_PASS;
>  }
> =20
> +static __always_inline __u16 csum_fold_helper(__u32 csum)
> +{
> +	return ~((csum & 0xffff) + (csum >> 16));
> +}

Does this folding function handle the carry bit completely? Standard 1's
complement checksum folding usually requires a second addition to handle
the carry from the first addition.

Since the 32-bit seed passed to bpf_csum_diff for iph->check is constructed
via ~((__u32)iph->check), the upper 16 bits are 0xFFFF. This guarantees the
intermediate 32-bit sum will exceed 0xFFFF, producing a carry that might
be discarded here, resulting in an off-by-one checksum.

[ ... ]

> @@ -281,21 +291,22 @@ static void *update_pkt(struct xdp_md *ctx, __s16 o=
ffset, __u32 *udp_csum)
> =20
>  	if (eth->h_proto =3D=3D bpf_htons(ETH_P_IP)) {
>  		struct iphdr *iph =3D data + sizeof(*eth);
[ ... ]
> +		len =3D iph->tot_len;
> +		len_new =3D bpf_htons(bpf_ntohs(len) + offset);
> +		iph->tot_len =3D len_new;
> +		iph->check =3D csum_fold_helper(
> +			bpf_csum_diff(&len, sizeof(len), &len_new,
> +				      sizeof(len_new), ~((__u32)iph->check)));
>  	} else if (eth->h_proto  =3D=3D bpf_htons(ETH_P_IPV6)) {
[ ... ]
> +	len =3D udph->len;
> +	len_new =3D bpf_htons(bpf_ntohs(len) + offset);
> +
> +	*udp_csum =3D ~((__u32)udph->check);
> +	*udp_csum =3D bpf_csum_diff(&len, sizeof(len), &len_new,
> +				  sizeof(len_new), *udp_csum);
> +	*udp_csum =3D bpf_csum_diff(&len, sizeof(len), &len_new,
> +				  sizeof(len_new), *udp_csum);
> +
>  	udph->len =3D len_new;

If this is an IPv4 packet and the original UDP checksum is 0 (meaning no
checksum was generated by the transmitter), will this differential update
produce a non-zero, invalid checksum?

The receiver might then attempt to validate this new checksum against the
unchecksummed payload, causing the packet to be dropped. Should we skip the
UDP checksum update entirely for IPv4 when udph->check =3D=3D 0?

[ ... ]

> @@ -359,7 +364,7 @@ static int xdp_adjst_tail_shrnk_data(struct xdp_md *c=
tx, __u16 offset,
>  		return -1;
> =20
>  	udp_csum =3D bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
> -	udph->check =3D (__u16)csum_fold_helper(udp_csum);
> +	udph->check =3D (__u16)csum_fold_udp_helper(udp_csum);

Is it safe that the raw offset parameter is directly passed to update_pkt
(which modifies iph->tot_len and udph->len) before the offset is clamped
to MAX_ADJST_OFFSET (256) in this caller and others?

If the raw offset is larger than 256, the packet headers will be reduced by
the full offset amount, but the actual packet length adjustment via
bpf_xdp_adjust_tail will only use the clamped amount.

Could this result in packets with mismatched logical header lengths and
physical payload sizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513072355.1083=
381-1-noren@nvidia.com?part=3D1
