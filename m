Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CB3EC2CB
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847869; cv=none; b=lgbHvmBVIXIGt5RdHfxvens8QpDKo7wSwzViucOoKWXqp7cM4DJ64s8Nh3Z19UGjmHFTRTxt+MzVn3MwOu7ZOvipIrtfQDK6kFeXgQlZtY1cw/vLoSQXXMOGTd1trwWwqWBbnD4RL+fy2VBLfsD4ZfxfvZcQR+i20EIC8H2KEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847869; c=relaxed/simple;
	bh=JhwAUaXn0mSpc8XvOeTASLnY5qtu+82mzYjJ8e/8S/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QUrKWGAv/kkivtV8Tzguu2af9/SnZLOf23nR0HkJMgYAxgpgOiZri2+orGk0Oe6GOSzQ453twj2hXkv6Enf7udfh4TXoWX/Tn9Ya1n0GK8DqIlgWcfmpyPa3W6m21meTYhT/HZ+xKpu6FYzOKWoETjb/1caAI6atyu0NEX1Qyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSDFIsfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSDFIsfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CC21F000E9;
	Tue, 30 Jun 2026 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847868;
	bh=xOglWLJLfMUi7851E+e5M1F+gONZBWwTmEA9ZaxSmzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSDFIsfr63xClu85i0iFEHYeeT1CsBeX+Rty31We56PVmE5yCC8GD/8VSwv0NJ+oU
	 Yk1GfsaNtedYwDIaQIbxzTT1IniLfy1HhxQCJJ+KjJgiOzmwiE+/mqBK9bmpAEzy73
	 RzrSC9jonAuZJyU9nRsFodKPlyFm0xjOx2fyDuao03xdcCes8HrkU48uzRsVGHA779
	 EnzwimTRPLrj6Er+2BqR46ADTHcEApTIWgzSTUIfz7mbUXpBv5ek31LZzDhLdf+C+U
	 DD/1qPMVF5XiwmlEQkNH7VLPvv2aWj4QvAXqeMMa0A/i/ZpRH1/m3851z1ikJKFSUD
	 hvR3uJn1sxXfg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/7] xdp: let XDP programs assert the RX
 checksum over redirect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630191510.81402-2-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <20260630191510.81402-2-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:31:07 +0000
Message-Id: <20260630193108.32CC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The XDP_FLAGS_RX_CSUM_UNNECESSARY flag is lost when an AF_XDP ze=
ro-copy buffer is converted to an xdp_frame during XDP_REDIRECT.
--

commit ba787c7855bcf7d5c0ecdc2fe7e6a11cde6a4c00
Author: Vladimir Vdovin <deliran@verdict.gg>

xdp: let XDP programs assert the RX checksum over redirect

This patch adds a non-dev-bound kfunc, bpf_xdp_assert_rx_csum(), allowing X=
DP
programs to assert that an L4 checksum is correct. It sets a new flag on the
buffer, XDP_FLAGS_RX_CSUM_UNNECESSARY, which is translated to=20
CHECKSUM_UNNECESSARY when an skb is built out of the frame.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..63ee36ec93de2 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c

[ ... ]

> @@ -961,6 +964,31 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const s=
truct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
> =20
> +/**
> + * bpf_xdp_assert_rx_csum - Assert the packet's L4 checksum is correct.
> + * @ctx: XDP context pointer.
> + *
> + * Mark the frame so that an skb later built out of it (e.g. on the cpum=
ap
> + * redirect path, see __xdp_build_skb_from_frame()) is set to
> + * CHECKSUM_UNNECESSARY instead of being validated in software when it e=
nters
> + * the stack.
> + *
> + * This is an assertion made by the XDP program: the kernel cannot verif=
y it.
> + * The program takes responsibility for the checksum being correct, the =
same
> + * way it is already trusted to rewrite arbitrary packet contents. If the
> + * program modifies L4 data after calling this kfunc the assertion may no
> + * longer hold.
> + *
> + * Return: 0.
> + */
> +__bpf_kfunc int bpf_xdp_assert_rx_csum(struct xdp_md *ctx)
> +{
> +	struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +
> +	xdp->flags |=3D XDP_FLAGS_RX_CSUM_UNNECESSARY;

[Severity: Medium]
Does this flag get lost when an AF_XDP zero-copy buffer is redirected?

Looking at xdp_convert_zc_to_xdp_frame() in net/core/xdp.c, it initializes
the new frame with memset() but does not copy the flags from the original
xdp_buff:

net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
	...
	memset(xdpf, 0, sizeof(*xdpf));
	...
	xdpf->frame_sz =3D PAGE_SIZE;
	xdpf->mem_type =3D MEM_TYPE_PAGE_ORDER0;

	xsk_buff_free(xdp);
	return xdpf;
}

Should xdp_convert_zc_to_xdp_frame() be updated to copy xdp->flags to
xdpf->flags so the RX checksum assertion survives redirect for zero-copy
frames?

> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630191510.8140=
2-1-deliran@verdict.gg?part=3D1
