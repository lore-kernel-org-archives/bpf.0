Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97443E49E2
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433245; cv=none; b=Lzh9ZhUWnBzrbHrKkX4+Ld4dO0Rv7AuALemIDBvDktK4qyEkJx/jfDO312Bor6usgfy7fen4UyOgCshYzwMnhHbNw7jeQx+eJ+eyBnQlaR2I+mnNpwMcfttK2YJLTCAYY41gVpSSxVYnxNv9NwagYf8mMmqcN+QSJrOLt98N4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433245; c=relaxed/simple;
	bh=lXyTs7w+mURLvA/swgD6dhh/gUjUbXabOvMpNHreIWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r4KdCN5kb7m6SrQw50OxrCcQFbiAFZUKZqw98XahVPlaAKnTfgV4Z+PZP6ad2tlX8eN22FE71+7464A5lfPmQK8G0yXCfxOBJbC22dk64p7E+8a068SznWeYPDCA8uP+xVw2ZhYTXOJTA8eNOtj9y265DnRHLhqwBAahImH6M2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBOtKv8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBOtKv8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113531F000FF;
	Sat, 26 Sep 2026 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433243;
	bh=RL+crCjwjAgTX5JN0zfXEVTyT3ilHM1s3uh4R7uAu+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBOtKv8BSr/yEaAk2oZNI3YvkeeoZyxQczbogkRSzSNy9aRWJttknyyjSuNHGhyjm
	 s9j7EwyDbLQLxwvSzBlOL3NVS06y7lXtrQmtn5fpguBzdr1Tpw6/ikHkUWzJeMdN9c
	 xymNwD/frIKslIzU3lhNSgCMR5rIPvjwmbLDdbb8zOB3uCmT4TwgU1DvajJgcVS51L
	 OX1HUWxFAo1fbZnCkVElxECMr+9I2TbHZQ3V+Yc4LuagUT27Lwa1w0HwROe2CA/cMH
	 h8t3XnX5haoUFKewutFgLqucPM58mu25g8u1O7KBPXm2VsdM8sxrQbnTqUHCmTNGEt
	 IMCel+gbpYqzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/36] bpf: add cnum64_intersect_linear()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-8-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-8-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:34:02 +0000
Message-Id: <20260926143403.113531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: cnum64_intersect_linear over-expands intervals that wrap th=
e signed boundary
--

commit 07e53bba30487c590757dc2ec233d2811a607b9a
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: add cnum64_intersect_linear()

This commit introduces cnum64_intersect_linear() to intersect a cnum64
interval with integers congruent to 'base' modulo 'step'. It tightens the
interval using signed bounds to keep residues consistent. This is a building
block for tracking scalar registers with values known to lie on a line.

> diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
> index 86142cb2aee5f..2bff2c7e0cdf5 100644
> --- a/kernel/bpf/cnum.c
> +++ b/kernel/bpf/cnum.c
[ ... ]
> @@ -118,3 +119,38 @@ struct cnum64 cnum64_cnum32_intersect(struct cnum64 =
a, struct cnum32 b)
>  	}
>  	return t;
>  }
> +
> +/* Intersect 'in' with the set of integers defined by equation 'base + s=
tep * k'. */
> +struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 st=
ep)
> +{
> +	s64 smin =3D cnum64_smin(in);
> +	s64 smax =3D cnum64_smax(in);
> +	s64 lo, hi;
> +	u16 d;
> +
> +	if (step <=3D 1 || cnum64_is_empty(in))
> +		return in;
> +	/*
> +	 * Round smin up to the next value congruent to 'base' modulo 'step',
> +	 * i.e. increase smin by d =3D (base - smin) mod step:
> +	 *
> +	 *                 |<---- d ---->|
> +	 *     |-----------|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|...
> +	 * base+step*k    smin       base+step*(k+1)
> +	 */
> +	d =3D imod(base - imod(smin, step), step);
> +	if ((u64)smax - (u64)smin < d)
> +		return CNUM64_EMPTY;
> +	lo =3D smin + d;
> +	/*
> +	 * Round smax down to the previous value congruent to 'base' modulo 'st=
ep',
> +	 * i.e. decrease smax by d =3D (smax - base) mod step:
> +	 *
> +	 *     |<--- d --->|
> +	 *  ...|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|-------------|
> +	 * base+step*k    smax       base+step*(k+1)
> +	 */
> +	d =3D imod(imod(smax, step) - base, step);
> +	hi =3D smax - d;
> +	return cnum64_from_srange(lo, hi);

[Severity: Medium]
Does this code improperly expand intervals that wrap the signed boundary?

For such intervals, cnum64_smin() returns S64_MIN and cnum64_smax() returns
S64_MAX. The function then calculates 'lo' near S64_MIN and 'hi' near
S64_MAX, returning cnum64_from_srange(lo, hi).

This replaces a potentially small wrapping interval with a massive contiguo=
us
range spanning nearly the entire 64-bit space, violating the intersection
property (A =E2=88=A9 B =E2=8A=86 A). While this over-approximation is soun=
d, it could cause
the verifier to lose precision and falsely reject valid BPF programs.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D8
