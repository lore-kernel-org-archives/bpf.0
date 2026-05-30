Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F937AA99
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122797; cv=none; b=gxwW6X3traVsm0MJ5UBsG0fY0UXHfxzmHZn4U2UMEQqGkFiZQMPvSoqh1K7YCfxPSWeuzDTjLvEeZBZ1CWHLVL+7/rykKmNSXEihcxkmZzTiLvXUUH/1Ibz/2umVmgkF5KZ9O3TBzSdfurCuYDx3xn5UzhglGhdUgbkJaQgwSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122797; c=relaxed/simple;
	bh=+IArviZqnv194MZqQ3lyv9ocaX5sQNiapjaHEEJBIBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLUmJq6s6vl/H4j1g0EhJ/zsvMxcKRvFNL/tWKFkC/Nl5+FGYLOZtIW4rEkiUJimCOI8X++gMZndH5oRFrljDKAJshI2XfNcxFbU6Gh1O0QuWgPcT/EBoUGqm6dq3i+hIArndrpIX8apBSAt4rWUH5LvkkTRVFFtBDfA2WJPf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrkLImWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrkLImWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5D41F00893;
	Sat, 30 May 2026 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780122795;
	bh=50r2Aek0nZxAXNQvkj3X6HGYpdI+wtiU2uS4gsLYfyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FrkLImWOl0vPPgsSdXBRBpA+qOqFmLtQDyTbRPzrIFDS13n74GUTKYE+ydKtq2Rtm
	 gDTh0Z16zj7gavT6z8rKFcwGguoADL+5nlpvgavelA6ExIF7l4v9ANgd1Cs85uaY/W
	 2sdHEOFlXw0xHmu5zkQx3RHWY54KojbFvTCAPtoOVIVihW03Mng2T1Kzh/bvXsAmpa
	 zxta08FEQ0gLUJQk92KcjHoWvKTzZmkcrcvY4+nV4qVwKtkA1UOCsC2Nc8IXTqfw4f
	 jjdnIdJ+gDQpW1qNa+E6Tghc9beZJP2RnK5skfBd2kuAWdoX2b3z2T0bADjz7fQ+zi
	 HgXIu4D6eq0AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf: Add validation for bpf_set_retval
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530055557.549474-2-xukuohai@huaweicloud.com>
References: <20260530055557.549474-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:33:15 +0000
Message-Id: <20260530063315.7C5D41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing register precision tracking allows state pruning bypass of=
 bpf_set_retval bounds validation.
--

commit 5f718982401054a9851d6767974e35ed4b2c276e
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add validation for bpf_set_retval argument

This patch adds validation for the argument passed to the bpf_set_retval()
helper in cgroup BPF programs. It restricts the return value to the LSM hook
specific range or [-MAX_ERRNO, 0] to prevent positive return values that
can bypass error checking and cause NULL pointer dereferences.

Link: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.=
uestc.edu.cn

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..e82dedf871e81 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		}
>  		break;
>  	case BPF_FUNC_set_retval:
> +	{
> +		struct bpf_retval_range range =3D {
> +			.minval =3D -MAX_ERRNO,
> +			.maxval =3D 0,
> +			.return_32bit =3D true
> +		};
> +		struct bpf_reg_state *r1 =3D &regs[BPF_REG_1];
> +
> +		if (r1->type !=3D SCALAR_VALUE) {
> +			verbose(env, "R1 is not a scalar\n");
> +			return -EINVAL;
> +		}
> +
>  		if (prog_type =3D=3D BPF_PROG_TYPE_LSM &&
>  		    env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {
>  			if (!env->prog->aux->attach_func_proto->type) {
> @@ -10469,8 +10482,16 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't mod=
ify return value!\n");
>  				return -EINVAL;
>  			}
> +			bpf_lsm_get_retval_range(env->prog, &range);
>  		}
> +
> +		if (!retval_range_within(range, r1)) {
> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
> +			return -EINVAL;
> +		}

[Severity: High]
Because bpf_set_retval() takes ARG_ANYTHING, does this bounds check need a
call to mark_chain_precision(env, BPF_REG_1) to prevent a state pruning
regression?

Since ARG_ANYTHING doesn't automatically mark the register as precise in
check_func_arg(), it looks like the verifier's state pruning logic in
regsafe() might treat this register as equivalent to any other scalar value
if it remains imprecise.

Could this allow a program with two branches to bypass this bounds check?
If a safe branch (e.g., passing 0) is explored first and saved with an
imprecise R1, the verifier might prune an unsafe branch (e.g., passing 1)
because it matches the imprecise scalar state. This would skip the bounds
check on the unsafe branch and potentially allow the exact bypass issue this
patch is trying to fix.

>  		break;
> +	}
>  	case BPF_FUNC_dynptr_data:
>  	{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530055557.5494=
74-1-xukuohai@huaweicloud.com?part=3D1
