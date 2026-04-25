Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51398282F1A
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777113876; cv=none; b=gcyb0GDuLt4Uc0VR4ghcRLTi+sgw5XpcW4IXY3sleqXMN9memqiTF7ALto7WMXi5MqbYcTx1TxVi4hL89BQkQpVMXs6lgC8Sni+R5t44gt2YmZPN2lFhLdKBiBzAeZ6wn39gQt8fu1toalDxZNrbA/MGcREFJ3hZsMiKO1byb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777113876; c=relaxed/simple;
	bh=tRHZfzwEUu5vcLjoYB8ztfuRbsHKu1dL2VGNJTIRJKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srsbB88YbPWGZ1LnvfaP3SSs9eSTEt8VB8UiE62FAb24Yfz5wDoKzVK/f850KcXnSRs/rhdjJ/2laMOSkR5HuRUnHGHDAtwarQtbq+EL9vqFYgQDpVPmUox8kgjRYH4TC0PNBpbnPIvXJkptsqOJOrMEgrC/kKTCJpgv+AK3BNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQuozSCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQuozSCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED443C2BCB5;
	Sat, 25 Apr 2026 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777113876;
	bh=tRHZfzwEUu5vcLjoYB8ztfuRbsHKu1dL2VGNJTIRJKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FQuozSCQo/C2QsWilOBT5QxYKAem5oK/I51l9xi6J7BsTQ0j2CALmYxpB3bUcaG8C
	 nYPjH2GFoqRi2pg38h8+wj/Nyd2W6+HUrXsLPV3OdmBt44PXiFrMzi99aConPh1jdK
	 Q1ssIvJkMFp++bls7ZxEdULwGKCqVfQIXZ37w+kwaR/0ARyE+mGtdrU1wtWjOUX5ZK
	 wGuecVl01oZItHthCCRycuaX+Fq4sDCLnVRNq7ftVEnPWadGn2v7CvBdvSzO56hoN4
	 jKsgh3qC8GxZF4nSzC0EuhuPt/tg2DwrKwaC7/y+vA6nFwmCPzCcdUhwNTrrP1szdC
	 ctYoNyJpkPnSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/3] bpf, xdp: reject offloaded programs on link
 update
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424104201.217604-4-jiayuan.chen@linux.dev>
References: <20260424104201.217604-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 10:44:35 +0000
Message-Id: <20260425104435.ED443C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Incomplete validation mirroring in `bpf_xdp_link_update()` all=
ows device-bound programs to bypass security checks, leading to type confus=
ion and memory corruption.
--

commit 32f74494cb77525b641fbd462cda3a2dfccc0147
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, xdp: reject offloaded programs on link update

This commit mirrors the offload check from dev_xdp_attach to
bpf_xdp_link_update to reject offloaded programs when the link is not in
HW mode. This prevents a user from replacing a regular XDP link with an
offloaded program via BPF_LINK_UPDATE.

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10678,6 +10678,11 @@ static int bpf_xdp_link_update(struct bpf_link *=
link, struct bpf_prog *new_prog,
> =20
>  	netdev_lock_ops(xdp_link->dev);
>  	mode =3D dev_xdp_mode(xdp_link->dev, xdp_link->flags);
> +	if (mode !=3D XDP_MODE_HW && bpf_prog_is_offloaded(new_prog->aux)) {

Does this check omit the dev_bound validations that are already present in
dev_xdp_attach?

If a program is loaded with BPF_F_XDP_DEV_BOUND_ONLY, it has dev_bound set
to true but offload_requested set to false, meaning bpf_prog_is_offloaded
will return false. Could such a program bypass this check and be attached
to an SKB-mode link, potentially causing the generic XDP runner to execute
device-specific kfuncs that cast the generic xdp_md context to
driver-specific structures?

Additionally, if the link is in HW mode, this condition evaluates to false
and the validation is skipped. Does this allow a program offloaded to a
different device to be attached to an HW link on the current device? If so,
the driver might receive XDP_SETUP_PROG_HW and incorrectly cast the new
program's aux->offload->dev_priv to its own internal structure, resulting
in memory corruption.

> +		netdev_unlock_ops(xdp_link->dev);
> +		err =3D -EINVAL;
> +		goto out_unlock;
> +	}
>  	bpf_op =3D dev_xdp_bpf_op(xdp_link->dev, mode);
>  	err =3D dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
>  			      xdp_link->flags, new_prog);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424104201.2176=
04-1-jiayuan.chen@linux.dev?part=3D3
