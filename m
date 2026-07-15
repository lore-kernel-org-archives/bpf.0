Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985743F0A3
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153323; cv=none; b=GO6DIU0eXUJiJGKf0hfgcCjxr2D5NXyp3yIQ82HKFNY9mz6RW2NifOjvw6hkqGYQDDtBLcrq1hR+g5GFFEs32CPoURhxJzOHMjnmW82WMh8/9GIKT9v16tsvHuIzJK0hP529r+U6hRW+zhrOoB0YlavHiAZhegaqgoQeykp8+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153323; c=relaxed/simple;
	bh=jXm6jrWCNwVcSj5eIa1xyn7Utce70osTcmkDqf5KNJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DH/GMqUmzfSLYYlHs1x1FI/6l2pSlz6HpZ8jxDnhniIk5E2zNwyb2nxh21hksrL1vYaODqu90aCTwOd1P8KQkbaWpFNQ2+8WjAWd6+xbex0dcb4waySPkTnVWx6JXdUTbrsySgk+mhPkp8EZUj4pLsw+kGHsBzyyguY+Fm3dma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUZWGctB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUZWGctB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3391F000E9;
	Wed, 15 Jul 2026 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153322;
	bh=yA9gAdyLAvI9NxqltCZSlPY8NkhGW3elH7Xx1WBzeGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUZWGctBldILfCumkQNXYuOc8urNjyO0mZ27VuaG+hsg34F6mOs8qOfzlDlktF2GC
	 um5zvT5AwHPL3+ao+HKhsll00C3ynvLMmBI1nkxBwBNYK/YwxbsxdU5MecVdXEB3N8
	 oLDe0esaIhZ7taaa2kFqda99e3hPYw6DHboe/K/ikCmcsUJez97jQ6t0jQIYl+HMfG
	 GpwW61JYD1IBPK9itRcRnB/ezJQSZqClBxa8frrz+AAUL6LLQ1/f8IWo7oLn7M2U8O
	 tgUvJbI42OTxJrHzg1ltS0R3v83TKsBG8Oov1JWMNFhk8wYwOUSznh7rxxzHiAthui
	 nRTWmZmbLmgeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/8] net: veth: add xmo_rx_checksum callback
 to veth driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-2-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-2-623d5c0d0ab7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:08:41 +0000
Message-Id: <20260715220841.AD3391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] veth_xdp_rx_checksum incorrectly maps CHECKSUM_PARTIAL to XDP_CHEC=
KSUM_NONE, causing XDP programs to drop valid locally-generated packets.
--

--- Patch [2]: [PATCH bpf-next v5 2/8] net: veth: add xmo_rx_checksum callb=
ack to veth driver ---
commit 34eae1c96706424d6fb3ab7f5a60445ee0f6dd08
Author: Lorenzo Bianconi <lorenzo@kernel.org>

net: veth: add xmo_rx_checksum callback to veth driver

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the veth device.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 8170bf33ccf95..dbf30089581c8 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1701,6 +1701,37 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_m=
d *ctx, __be16 *vlan_proto,
>  	return err;
>  }
> =20
> +static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
> +				enum xdp_checksum *ip_summed,
> +				u32 *cksum, u8 *cksum_level)
> +{
> +	const struct veth_xdp_buff *_ctx =3D (void *)ctx;
> +	const struct sk_buff *skb =3D _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	switch (skb->ip_summed) {
> +	case CHECKSUM_COMPLETE:
> +		*ip_summed =3D XDP_CHECKSUM_COMPLETE;
> +		*cksum =3D skb->csum;
> +		*cksum_level =3D 0;
> +		break;
> +	case CHECKSUM_UNNECESSARY:
> +		*ip_summed =3D XDP_CHECKSUM_UNNECESSARY;
> +		*cksum_level =3D skb->csum_level;
> +		*cksum =3D 0;
> +		break;
> +	default:
> +		*ip_summed =3D XDP_CHECKSUM_NONE;
> +		*cksum_level =3D 0;
> +		*cksum =3D 0;
> +		break;
> +	}

[Severity: High]
Is there a missing case for CHECKSUM_PARTIAL in this switch statement inside
veth_xdp_rx_checksum()?

When a local process sends traffic over a veth pair with checksum offload
enabled, the packet is passed to the receiving veth with skb->ip_summed
set to CHECKSUM_PARTIAL.

By falling through to the default case, this maps CHECKSUM_PARTIAL to
XDP_CHECKSUM_NONE. An attached XDP program that validates checksums will see
XDP_CHECKSUM_NONE and attempt to compute a software checksum. The software
computation will fail because the TCP/UDP checksum field only contains a
pseudo-header checksum at this point, leading to dropped packets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-bpf-xdp-me=
ta-rxcksum-v5-0-623d5c0d0ab7@kernel.org?part=3D2
