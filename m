Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9340803B
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537987; cv=none; b=NmCgI0rt3Ke9FUDMM7Cleo8wwFrVblpuiOAhZBUrBpt7xB98mImu8Y62g6VQoR7MteOaXogAPY5uZJM1LPm8MOvWp9oBlUYVKKIz3lh6e+Lq+bk8gTI3BofJwTl/m37YyzZ4X7obZT1naU2zefv5U/BA/GD4xxqBvevHTOgVqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537987; c=relaxed/simple;
	bh=6IXWwzNdqSTgGkLNAUxip4aq9ljzXVPLqWgPBbA4kBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0mHw7iObl9VB+5S055FekNzPGPmq27YDNPYS/MoBKEdlfijmM/ymbKoClvH5xXGzgouOn1IkDrEmKnJYyd+/2/sxu45NNhvfBsXXSrHZIehDrkhfR2cckNoT4nlRIXsvqTddmkM5DwBPKiwFSP1qeMG/Gnknq/7zJ83+V2Oqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6DH5Vay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6DH5Vay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E49B1F000E9;
	Mon, 15 Jun 2026 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537986;
	bh=DhauY8fpJn9LziXBs4nDwU1sF29v4logAtaAB11xKeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6DH5Vay87MdUpmcOhZmB2jnqEs9qRbFo9k4zXbzchH1mi4t9ikij8iPq0s8mjfgh
	 JDhlg5PM53Ude0fcHFNYXgjVkhx4n3M7Cp3rGK3/cTyEE+P8H3aimRgfntk5T1U1t/
	 oLH/iPg1xDFY5vFIYnxfAkcUsg4rUyb0baDrKp7Lj5XsjDbEcxO/q12eXJiEjM/HiA
	 Xgrno0FHkrBcro+YfWZCdsVM83jMY/rx7JUSYtnGc7EEp+sE2yMS6vlN6reYr8p6Qo
	 mWJmF3QfQjkpb3jpI1a//UKAvC7aegIkuhcC1pMdU3MFkueocwj50YQYweRIBksh2L
	 GeGCDJ5N5SuXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <76830c72d48ea174272d4a2ee9d5cc0f3ef02c8d.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
References: <76830c72d48ea174272d4a2ee9d5cc0f3ef02c8d.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 15:39:45 +0000
Message-Id: <20260615153946.8E49B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Bypasses in the packet pointer invalidation logic for global s=
ubprogram dynptrs allow Use-After-Free of reallocated SKB data.
--

commit 3d7aef2edf3e68f7deac1e4457119dd95d6770d0
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Fix packet pointer invalidation for skb dynptr writes

skb-backed dynptr writers can mutate packet data, but not all verifier
paths invalidate checked direct packet pointers after those writes.
This patch treats CONST_PTR_TO_DYNPTR local arguments as possibly
packet-backed for packet pointer invalidation.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..51468faa76a47 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9155,6 +9155,23 @@ static void clear_all_pkt_pointers(struct bpf_veri=
fier_env *env)
>  	}));
>  }
> =20
> +static bool dynptr_type_pkt_data(enum bpf_dynptr_type type)
> +{
> +	return type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +	       type =3D=3D BPF_DYNPTR_TYPE_SKB_META;
> +}
> +
> +static bool dynptr_may_be_pkt_data(const struct bpf_reg_state *reg,
> +				   enum bpf_dynptr_type type)
> +{
> +	if (dynptr_type_pkt_data(type))
> +		return true;
> +
> +	/* Global subprog dynptr args are verified as unspecialized LOCAL. */
> +	return reg->type =3D=3D CONST_PTR_TO_DYNPTR &&
> +	       type =3D=3D BPF_DYNPTR_TYPE_LOCAL;
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
This is a pre-existing issue, but does this incomplete fix leave two bypass=
es
for packet pointer invalidation?

First, if the BPF program clones the global dynptr using bpf_dynptr_clone(),
the clone is stored on the stack and typed as PTR_TO_STACK (inheriting
BPF_DYNPTR_TYPE_LOCAL). If a dynptr writer like bpf_dynptr_write() is then
called on the clone, it appears dynptr_may_be_pkt_data() will return false
since the register type is PTR_TO_STACK instead of CONST_PTR_TO_DYNPTR. This
would skip clear_all_pkt_pointers() entirely.

Second, if the BPF program obtains a direct slice from the global dynptr via
bpf_dynptr_slice_rdwr(), the returned pointer gets the type
PTR_TO_MEM | DYNPTR_TYPE_LOCAL. If a dynptr writer is subsequently called on
the original global dynptr, clear_all_pkt_pointers() is triggered but fails
to invalidate the slice because reg_is_dynptr_slice_pkt() explicitly ignores
DYNPTR_TYPE_LOCAL slices:

kernel/bpf/verifier.c:reg_is_dynptr_slice_pkt() {
	return base_type(reg->type) =3D=3D PTR_TO_MEM &&
	       (reg->type &
		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
}

Could both scenarios allow a Use-After-Free read/write on the reallocated s=
kb
data?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781535194.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
