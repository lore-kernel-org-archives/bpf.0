Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025738;
	b=I0RuIEPuD9skl1XrfE/9yQMpBTFJOfdKfmk5asdmbVmYC10DSUA4KVpq35OehgYZ+km2
	 qxk3B09PgiGQzOL8i5H4Z3KZVTk4fu+kraXn4AZbjnEogfig8tfBQQawujES4pkmKvVWY
	 hcRwiBWavvrlgna/eXBT83qxpBiZr320CQ2CuDqPy+m2QXGgEl2O8usEnVkIZI1IH9LQk
	 fHIJLuV15a49F/6ZsJZvExM2NCmKNLV6PgBY8OZ89WWPW0PPW4PojZKqkpKPwbFT+8BHa
	 vClbnhs2Azdk7hfIhx6xjzpDXs1w+fM+030xiVajhFt3iqm4SfIFHBIXucDvPM+OE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025738;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GuObg2zm/I15sekktpBQYBiHT89xgfrDPY0IhJ4lANs=;
	b=oDYmNvw34cPwqg2CvhoGUHXPq0PARNWZSd2gZJ2lOQDF8qaCZkiVMNxUY8GSRv3MglRL
	 1/z5W7oQ+/F+SUx7fz+T1pHBgSKWKm0A/06oeH8tMUP2mT0bU93dPXBoP8qQNpc2hKh78
	 aw5Fwq/cKdZNUsx0L0KKfVNVHST/DZm3L60UfaDgsAgnWUrRL0LiAgoq1hTe+WheRUpcf
	 4S4RACFGEXZpAz04AjclzG+7Wwh1QQj9Ul0Mm/0G8KceiU1ArLmaQoDQLCb5MTvHjdR4G
	 NLIfZMHh8+oL5fvMxFE1VRVmQNrtRewTUKwTZ2jOr86e7kgqPiSsb7l9PpEHSR9ahYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQcBdgmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6E606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQcBdgmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241111F0089F;
	Sat,  7 Nov 2026 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025737;
	bh=GuObg2zm/I15sekktpBQYBiHT89xgfrDPY0IhJ4lANs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CQcBdgmzhOEyjOOX0N6chYNKvJV4AkHkeCFs2bI5gmNZOhEpcRHXfC0gzK+4Uah1S
	 cVDtXC18M4dv07p+8RcG8MVUSwP0W3rbQhtue0cCLeNom1hcTC6xj47m2YGkVWX6Uc
	 fMnrUI45ONaDguqCKaddXQHBsmX9Tqguovg4ltJ/h+rOSiBKv4POHCvSd+V3vx00Lm
	 l2j7mrHFyGA/IH06+bXZme7079AZzGQk0/uuvnoHCqtLzCdJWrmaVv3nvyFdArnH5h
	 QcdG/8uxY2Fldf2jF2sd731SkH4xbEMxV1GWuSR53UcAD/xZ9/8nQ5epbClwsb88gF
	 ueAaac5u641Xw==
Message-ID: <sashiko-outbox-202582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 32/46] bpf: A loop is one iteration shorter
 behind the jump that counts it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-33-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-33-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:28:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: signed overflow and stride corruption on moved in
  bpf_clamp_scev_regs()
--

commit bb719964b0079686d30154660558b2b4d7792c19
Author: Alexei Starovoitov <ast@kernel.org>

bpf: A loop is one iteration shorter behind the jump that counts it

This commit narrows the SCEV-derived register ranges by one iteration on the
fall-through path behind a loop-counting exit jump, including registers to
which the current iteration has already added a constant offset.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 06f485853df13..4ce8ad5d5a279 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -3878,8 +3910,22 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *e=
nv, struct bpf_func_state *cur
>  			continue;
>  clamp:
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> -		if (r =3D=3D entry->iv_reg)
> +		if (r =3D=3D entry->iv_reg && !moved)
>  			iv_bounds(&bounds, entry->iv_range);
> +		if (moved) {
> +			bounds.r64 =3D cnum64_add(bounds.r64, cnum64_from_srange(moved, moved=
));
> +			bounds.base =3D imod(bounds.base + moved, bounds.step);
> +		}

[Severity: High]
Can shifting bounds by moved here corrupt bounds.base and bounds.step when
bounds.step is not a power of two?

When entry_reg is a constant scalar, linear_bounds() sets bounds.step to
|slope| (up to S16_MAX) and tracks the signed congruence x mod step =3D=3D =
base.
If adding moved to cnum64_smin(bounds.r64) or cnum64_smax(bounds.r64) wraps
s64, 64-bit addition shifts the signed values by +/- 2^64, which is not a
multiple of a non-power-of-two step, so the wrapped range in bounds.r64 no
longer has remainder imod(bounds.base + moved, bounds.step).  Passing the
mismatched bounds.base and bounds.step to bpf_set_reg_range() ->
cnum64_intersect_linear() can then narrow reg to a bogus constant that the
register never holds at runtime, or collapse it to CNUM64_EMPTY and hit
verifier_bug().

In addition, bounds.base + moved is evaluated in signed 64-bit arithmetic a=
nd
can overflow s64 when moved is near S64_MAX (with bounds.base > 0), unlike
scalar_step_add():

kernel/bpf/verifier.c:scalar_step_add() {
	...
	if (check_add_overflow(reg_smin(reg), amount, &tmp) ||
	    check_add_overflow(reg_smax(reg), amount, &tmp)) {
		reg_step_reset(dst_reg);
		return;
	}

	dst_reg->base =3D (reg->base + imod(amount, reg->step)) % reg->step;
	dst_reg->step =3D reg->step;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D32
