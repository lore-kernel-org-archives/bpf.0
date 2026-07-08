Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507963E7BAF
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544075; cv=none; b=MzQH6VYypWxmDejVZPb2pNg14BlahVv9tQSCbECaTHPOFCNUk4W1egJtf9fkFiu0d8/iIHpxDTrdCiak5ysDU5rJQMF9bdFBnnYd1tbrkHbdKvCvJ9AymDjc+2UeotdulQ3a6qHVVfSi10MvHARG9rmcqq3R4Ebs19ETXJOrFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544075; c=relaxed/simple;
	bh=o910hwUD0ZINJIwmbX0SjoZemCb5MCyNYfU1oz/SwRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7fGd0iBbXlBh+nBdyRMpGnQY3lie9Qi0QL+xV88air/jrGX6/qcAL2w9/UVpWA6GB71sv3B9S/dY2CU+ABmFCz1fmlz5WCtuCyyIalns2GK/Q0JXFTcGHdqxgDxIdW29NLlirQKNhYNpWV2bHC43+IE3UCpUsmO/AL5ogkRMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTWlnrMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTWlnrMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C11F000E9;
	Wed,  8 Jul 2026 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783544072;
	bh=RP2SFa0lyCKyKE9MSj57hGEfHKMAMrUYK/HD7cAMJhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTWlnrMcNo3b3xG84kezKzYZ23jck/quAo51qzWvyjQ9C3vbd7EBVjPl2VdfJ2qP0
	 l4Yu0PKr3bKuV30qwi2GBoQuJ+ZzB7FyiwlcPPjHbJBAiT2exF7C3D1/GVR5SJK7At
	 a4+lV39sTKDm1C+ccPXOjc1H42chHEQ5qF2CjR1pz/C5R8cSlV1qaPevCMyYMF/cC5
	 UoTBZ1yDX6hVpqLA47lH/R71xeVty15YnPlg0znHEgYRjBpw6CbVcHM+YBBOYw+kRh
	 rL5bMBp2SZPxHQ2Kpf+keGHl34Bqi12c3uynT1ODFaNMpl5PB4eLWglLwtCS9VbS0H
	 NNhHrQKr5cumA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum callback
 to veth driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708203410.45121-3-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-3-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:54:31 +0000
Message-Id: <20260708205432.448C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The XDP CHECKSUM_COMPLETE value returned by veth_xdp_rx_checksum l=
acks the MAC header contribution, causing XDP programs to compute incorrect=
 checksums.
- [High] veth_xdp_rx_checksum incorrectly maps CHECKSUM_PARTIAL to XDP_CHEC=
KSUM_NONE, causing XDP programs to drop valid locally generated traffic.
--

--- Patch [2]: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum callb=
ack to veth driver ---
commit 5a562d33c7a2a6e1ab983df15c58e768727ee475
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Wed Jul 8 20:34:06 2026 +0000

    net: veth: Add xmo_rx_checksum callback to veth driver
   =20
    Implement xmo_rx_checksum callback in veth driver to report RX checksum
    result to the eBPF program bounded to the veth device.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c51421491753..498d894d043da 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

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

[Severity: High]
Does this return a checksum that is out of sync with the packet data exposed
to the XDP program?

When the packet enters veth_xdp_rcv_skb(), the MAC header is pushed back
into the packet data so it is visible to the XDP program:

drivers/net/veth.c:veth_xdp_rcv_skb() {
    ...
    __skb_push(skb, skb->data - skb_mac_header(skb));
    ...
}

However, it doesn't look like skb_postpush_rcsum() is called to update the
checksum. Since the earlier eth_type_trans() subtracted the MAC header from
skb->csum, returning skb->csum here means the XDP program will receive a
checksum that lacks the MAC header contribution, which might lead to a
checksum mismatch when the program validates the packet.

> +		*cksum_level =3D 0;
> +		break;
> +	case CHECKSUM_UNNECESSARY:
> +		*ip_summed =3D XDP_CHECKSUM_UNNECESSARY;
> +		*cksum_level =3D skb->csum_level;
> +		*cksum =3D 0;
> +		break;
> +	default:

[Severity: High]
Will CHECKSUM_PARTIAL fall through to this default case and be reported as
XDP_CHECKSUM_NONE?

Locally generated traffic transmitted through a veth device defaults to
skb->ip_summed =3D=3D CHECKSUM_PARTIAL because veth advertises NETIF_F_HW_C=
SUM.

If this falls through to XDP_CHECKSUM_NONE, strict XDP firewalls might try
to manually validate the checksum. Since the payload checksum hasn't been
populated by hardware yet, the validation will fail and valid local
traffic will be incorrectly dropped. Should this explicitly handle
CHECKSUM_PARTIAL?

> +		*ip_summed =3D XDP_CHECKSUM_NONE;
> +		*cksum_level =3D 0;
> +		*cksum =3D 0;
> +		break;
> +	}
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708203410.4512=
1-1-deliran@verdict.gg?part=3D2
