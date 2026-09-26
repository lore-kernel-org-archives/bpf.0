Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A932331EA5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433371; cv=none; b=SgS+ky6mKlpKCaL6c0DsRG7ph9sGAOFxKUm1Np5/VcTVin3+tQvcYDKRN3j3DZ9z+KVGK/7qC+FZ6WdkOZzy0uImpmEGVMrkfu9M5V3nhEzUeybP8uCE8zyZg2U0MdHVw1AO257+HmjIWyJ5Piztm3zt8FSNYlLAV6BKgEjkzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433371; c=relaxed/simple;
	bh=nfv73M/p206t8KVR3//X8lTAdfeaxgf0Y7g/e3ZaapA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9JfS9FfQpXUDoU1SOJHfr61SOz2bvkOzfnpvR7bC/KtBjEdELO6YnbmejTO6AH+kxG+xRUMigws+8vXokczkS0Qizw64mf+6aUYByWA0NJUrvOtc+8TkBGglYp3Jd2bstpoPrh7DX6EQIla4jOWJYkT7eogMOKgDDTnOBsozlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN/p0s7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN/p0s7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D181F000FF;
	Sat, 26 Sep 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433370;
	bh=IMHI3/mVusZmN3sxJuNaADpmAEDzXd6P5qYXN//4KZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SN/p0s7yLC4Ogw5GqbE05DMUEne9a02iOgTLwphCfuGYYUBbPQEC1HiSNB8WH6jdh
	 pChbUlaGxCWAm557gzJKoqZ4l9IXi6I56zxv9fXb10VeHuIIvtNLYY9lyEwbtC3LqM
	 jcuRs3L0UAVI8VHSWVcLYLU5BpD5t7SUxRdMKgFZsVUV/cFGUJ2uFo9bnhxOUYXF/p
	 kqeWkHucI5OAFL5ieN0JKEbg0xsWoKRKWhtWlNVyf+mLm1CNeqK47k5HTh1ihX9wAl
	 uamVGMcyKE843l6Q/GN1LWmt9R87RADtApNMCcFsiGeUCIx1nKUmsu92eH8Em/ViLE
	 W9Cu2s2yfgx8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/36] bpf: add bpf_set_reg_range()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-9-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-9-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:36:09 +0000
Message-Id: <20260926143609.E2D181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: build failure due to missing step and base fields in struct bp=
f_reg_state
--

commit b21e96677bd5c8c118c6f3ee527144b5d83b0c82
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: add bpf_set_reg_range()

A utility function for setting a register's range and step information.
Used by SCEV widening and clamping logic further in the series.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03dbc0e003986..f2d44e026e4bd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -16934,6 +16934,18 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	return 0;
>  }
> =20
> +int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state=
 *reg,
> +		      struct cnum64 range, u16 step)
> +{
> +	reg->r64 =3D range;
> +	reg->r32 =3D CNUM32_UNBOUNDED;
> +	reg->step =3D step;
> +	reg->base =3D imod(cnum64_smin(range), step);

[Severity: Low]
Does this code cause a build failure?

It appears that the `step` and `base` fields do not exist in
`struct bpf_reg_state` at this point in the commit history, which would
break `git bisect`.

While this patch splitting error is resolved in the subsequent commit
'[PATCH bpf-next 14/36] bpf: representation for intervals with steps' which
adds the missing fields, each patch in a series must compile independently.

> +	reg->var_off =3D tnum_unknown;
> +	reg_bounds_sync(reg); /* this should infer the tnum alignment */
> +	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
> +}
> +
>  /* check validity of 32-bit and 64-bit arithmetic operations */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D9
