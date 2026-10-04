Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E539A04C
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122356; cv=none; b=s0stw4/wjsMhd8/Dy8/Br5ITWNzIWsNLuqi/wWY+7gWJdGxpArsdU0d2hLwpj1dUImSkfZyi3jHYELA27m8c0sTgYj+T2QcAq9J/oAqJMl1Xst8D0nTjdF6SclPumsVhSkC+bMcILCwIkE6gBvixnizBsQVZSCzyFGyXzOHZKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122356; c=relaxed/simple;
	bh=F0x8Hf6DnzapFRlkqXmoL/Baz55Q4hJCpP7twCejzD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pwFkp4ATDDAhfQkwLBGuxafyyfyK0nrsyBhFa+dCG1BOqHOP9QcKNl1Md4wvw6ea/ICnOLGGlQs1qewtUxlx+nFrKSHuC9+9jGjxCAitAAlLxQcGu56QnjuCWbwwpPu62iszwaAjshn6QyIYWkJkupwydBanSVoZwecY2l61YPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NENq4zG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NENq4zG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004EE1F000FF;
	Sun,  4 Oct 2026 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122355;
	bh=iGlnzejirjVyACkQmxJFWZE7fCdKCiKcg1WloHMLtOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NENq4zG1oHjjF6O5wIJLfEFPpk6V9HbQORYnAxNC1ecFSoa+iznRfSS50TvrzGlKT
	 wVseg8hTgv7UypJjFQc0qUAFARUhsSKgitTxan3mpM/5iIhTkr+eJW0eTwt4qmRs7j
	 qjuHr1BVl8lgjpf2W5TahQXssAKK6cgBp7Ak/80aXjpo4DR6H8WaBoGdDzIjDW24H4
	 xiUMkTWMxyZXS56qOaXvZ/ZTEJVVh/PtogzFF5ZpanfxiY/QWtt7Pl28+68Szn6RwY
	 MxaRHGaL13I0/2aAWPcA0g+4gprPftGXooeVhHwt5qtuB7usLlqq/J5wmj4K5pvW/b
	 bewA95VnhbnYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 22/43] bpf: add bpf_reg_union()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-22-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-22-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:59:14 +0000
Message-Id: <20261004135915.004EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: division by zero in bpf_reg_union() due to step=3D0
- [Medium] bpf: bpf_reg_union loses alignment precision by missing optimal =
common congruence
--

commit f2da61545238e5504547c2ded4955ae49831e34d
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: add bpf_reg_union()

This commit adds a utility function bpf_reg_union() to merge the scalar val=
ues
of two registers. It combines the circular 32-bit and 64-bit bounds, tnums,=
 and
base/step equations, synchronizing the result.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5fd6376da1710..28c16e35b1f36 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17164,6 +17165,33 @@ int bpf_set_reg_range(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *reg,
>  	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
>  }
> =20
> +/* acc :=3D acc U src, matching types only. Caller must clear acc's scal=
ar ID. */
> +int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *ac=
c,
> +		  const struct bpf_reg_state *src)
> +{
> +	u16 base, step;
> +
> +	if (acc->type !=3D src->type) {
> +		verifier_bug(env, "union of registers with different types");
> +		return -EFAULT;
> +	}
> +	acc->r64 =3D cnum64_union(acc->r64, src->r64);
> +	acc->r32 =3D cnum32_union(acc->r32, src->r32);
> +	acc->var_off =3D tnum_union(acc->var_off, src->var_off);
> +
> +	/* Retain a common congruence if the bases agree modulo the gcd. */
> +	step =3D gcd(acc->step, src->step);
> +	base =3D acc->base % step;

[Severity: Critical]
Does this code risk a division by zero exception and subsequent kernel pani=
c?

BPF programs can create ANY nodes in Scalar Evolution (SCEV) loops. If a lo=
op
combines two loop-invariant pointers (e.g., PTR_TO_MAP_VALUE from different
map lookups) in a phi-node, they are tracked by SCEV (since
is_widenable_reg_type() permits pointers) and passed to bpf_reg_union().

Because pointers are initialized via kzalloc or mark_reg_known_zero(), their
step field is 0. Calling gcd(0, 0) returns 0, leading to a modulo by zero on
this line.

> +	if (base !=3D src->base % step) {
> +		reg_step_reset(acc);

[Severity: Medium]
Does this condition needlessly discard linear alignment information for val=
id
congruences?

If bpf_reg_union() merges registers with steps 15/base 10 and step 15/base =
5,
it evaluates gcd(15,15)=3D15, sees 10!=3D5, and resets the step to 1.

The optimal step would be gcd(gcd(acc->step, src->step), abs(acc->base -
src->base)), which would correctly yield step 5/base 0. This unnecessary
precision loss might cause the verifier to incorrectly reject valid programs
due to a perceived loss of alignment constraints.

> +	} else {
> +		acc->base =3D base;
> +		acc->step =3D step;
> +	}
> +	reg_bounds_sync(acc);
> +	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D22
