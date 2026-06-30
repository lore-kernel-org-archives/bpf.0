Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC7272E7C
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847669; cv=none; b=HQELqiWEoLbsvaoflAC7sz/YVTFwHiC5t0qknrOZVskHPKp7xgrF997WHEwGm4x53m5rjxXR43yPcO2wdtumsIENstGg0gU8CfAvWAC5Az/AuaclU5qeLzxCY7cyD/Z7nAUf8+N6zgbuJ1V6NoJ4SJFMBuCmlu26oaI+y8cKsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847669; c=relaxed/simple;
	bh=cA9OGehl3YsK/X/CVXD4+idyTaxSG3Yi9PqWZ9o5+k8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SaRURh6x0v9gQohA3e3yCbs1QU5o5QzEWOeQFGL5IbtlOkUbIIG3jP4Q86Aw1Fm+J7imMUngx5zGp6YMqQv9tfkqLYlvjD2r8PCTESEM5DAbJjm/8VFqbfMDwSpeMXiaMdNWbFyuHuacVhnKW4eOfrsCY9iHTd5wMoNb57mRlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9kdySuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9kdySuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6711F000E9;
	Tue, 30 Jun 2026 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847667;
	bh=yObKjyj7f0VUgKPp6iRlHmSWGJNm6I1Ki1oLMG2bbO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9kdySuBy7//0V8UOxGdxRA+qbRAM+hZ/eEZOE9LNyOkeZ+qrdMBAQ8pzZJhGsXvy
	 td6Szd4Wz1A1zH5szEaXjwvpOKPhbJCHP2NmPRVsUUC5OMGtmIUqfTlkghM1v4j4F/
	 aoXEPuXDmLObFOz9vFN7iJvRmswFEYhp3WT1o2l1Nu2kiNSwEt0pfTdJaffgVwmXFu
	 sVwn9zTrtFOy03YPIrHE3ng60tUub/YW3VjR8hB7WZQtCnyK3IVthueBr7EoS+yShL
	 ElVPCP6LrX4fx7VAeQiIfR6v5+CUUvXQ2v0w8zA/hwvjsogcZDVXzBZU3zDLHJ0aqe
	 ijNJGwbyEoKJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 6/7] veth: support the rx_csum XDP
 metadata hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630191510.81402-7-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <20260630191510.81402-7-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:27:47 +0000
Message-Id: <20260630192747.9E6711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrectly mapping CHECKSUM_PARTIAL to XDP_CSUM_VERIFIED violates=
 the metadata kfunc UAPI and leads to corrupted checksums on forwarded pack=
ets.
--

commit 43f8c99f073896fcdca62b5034e71d604e446b2b
Author: Vladimir Vdovin <deliran@verdict.gg>

veth: support the rx_csum XDP metadata hint

This commit implements xmo_rx_csum from skb->ip_summed. It surfaces whatever
checksum verdict the skb already carries, making the metadata kfunc testable
without a NIC since veth has no real hardware.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c51421491753..b7bc5a3b07e50 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -1700,6 +1700,28 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_m=
d *ctx, __be16 *vlan_proto,

[ ... ]

> +static int veth_xdp_rx_csum(const struct xdp_md *ctx,
> +			    enum xdp_csum_status *csum_status)
> +{
> +	const struct veth_xdp_buff *_ctx =3D (void *)ctx;
> +	const struct sk_buff *skb =3D _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	/* veth has no real hardware; surface whatever checksum verdict the
> +	 * skb already carries (e.g. CHECKSUM_PARTIAL/UNNECESSARY from a local
> +	 * sender or a previous validation).
> +	 */
> +	if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY ||
> +	    skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> +		*csum_status =3D XDP_CSUM_VERIFIED;

[Severity: High]
Does mapping CHECKSUM_PARTIAL to XDP_CSUM_VERIFIED introduce a regression by
violating the metadata kfunc UAPI? CHECKSUM_PARTIAL indicates that the
payload checksum is incomplete.

If a packet is generated locally and sent over veth, it can carry
skb->ip_summed =3D=3D CHECKSUM_PARTIAL. If an XDP program reads this metada=
ta
via bpf_xdp_metadata_rx_csum(), it will see XDP_CSUM_VERIFIED. If the
program then forwards the packet out a physical NIC via bpf_redirect(), the
transmitted packet would have an incomplete, invalid checksum on the wire
since only the pseudo-header checksum was computed.

> +	else
> +		*csum_status =3D XDP_CSUM_NONE;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630191510.8140=
2-1-deliran@verdict.gg?part=3D6
