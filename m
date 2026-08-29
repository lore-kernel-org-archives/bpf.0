Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810C26ED4F
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787975775; cv=none; b=q7nhO/s04O+TnLXdth/tSgvTLsxG2a30qr+yH7lbk2ilJTtUDO5548fDrQ9F0Kra65hfDD8fVfUfryjDWCtz4cmFY51IT3Yy2Idk1Y0xoF7piLgO+tFEj92ASdBvqNXKKFkWUyReMXfayhqSn2wXw9oPuYYFZOHFTHl82ASPrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787975775; c=relaxed/simple;
	bh=Nfzgyh46bgiQeSSJH6duVELPVc+zzGf1X9vSkfHZL1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T9+kjSjsSjwT5BNmH5ucYVifL0LHxiDRTUUVD/7xIC4xwxJhPx4z+uqUWE8DJ028CJAqu+fbrPznmgGGFUlnN7mjv+4O7AWUTwxMJkUIAbZKsAQ/e9oy0ovoUX4088gA4xNCeCgxn8nc7bgiODAolCayoQjOPuixClZH2PZ00Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOr5Kp1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOr5Kp1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733421F000E9;
	Sat, 29 Aug 2026 03:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787975773;
	bh=Yh2FEq4bAQgMAs+IT8eqXYaYZPav31SahEfQo2VwqsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOr5Kp1vP0AQHlGDeFgdkcLIGjOaqMIhtfh+djq9vJ2VFRRA0PlRfYi3Hx3PMhxoX
	 Zh4B5jwHm5TErg3/Akpp6L9e8Rz3sQomC06tBQCuPBTpEE/IFbiVVFI5uFoLvg85ZK
	 9h3qYqKh93PUbyLyiAz6EJ8cLFlcefbfNNsA+c4OdYD3BON98/gSZPp2W4ZQWU1a4o
	 auuv8unpzYRutc8JCksEr7mE/9lLP5Pu7q6Abweo9mhI0pwDj2qORc1+XxLrOGr+k3
	 48Dq0meozIvcx27CWcxAlCNxqXO060Nzqa0pFHtkvoMse39gGlUJYA63DW7UEDeg6o
	 acLBW3Mc9fshg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 1/2] bpf: Invalidate dynptr slices by dynptr_id on
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829033645.2365631-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
 <20260829033645.2365631-1-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 03:56:13 +0000
Message-Id: <20260829035613.733421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `invalidate_slices_of_dynptr()` accesses `dreg->dy=
nptr_id` without verifying that `dreg->type` is `PTR_TO_MEM` or `PTR_TO_MEM=
 | PTR_MAYBE_NULL`. Because `dynptr_id` is part of a union in `struct bpf_r=
eg_state`, this leads to unsafe alias reads and incorrect register invalida=
tion.
--

commit e7cd53e464cb9cab28779b0a9fe2dde83ad7d53c
Author: Amery Hung <ameryhung@gmail.com>

bpf: Invalidate dynptr slices by dynptr_id on release

This patch invalidates dynptr slices by matching dynptr_id when a dynptr is
released. It adds invalidate_slices_of_dynptr() to iterate over registers
and invalidate those matching the released dynptr_id.

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> +static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, in=
t dynptr_id)
> +{
> +	struct bpf_func_state *fstate;
> +	struct bpf_reg_state *dreg;
> +
> +	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> +		if (dreg->dynptr_id =3D=3D dynptr_id)
[Severity: High]
Is it safe to read dreg->dynptr_id here without checking the register type?

Because dynptr_id is part of a union in struct bpf_reg_state, it aliases
other fields like btf_id and map_uid (especially on 32-bit systems where
these fields occupy the same bytes).

If a register holds a PTR_TO_BTF_ID or an inner map PTR_TO_MAP_VALUE, and
its btf_id or map_uid happens to match the released dynptr_id, could this
result in a false positive that invalidates an unrelated valid register?

For comparison, destroy_if_dynptr_stack_slot() restricts this check:

    if (dreg->type !=3D (PTR_TO_MEM | PTR_MAYBE_NULL) &&
        dreg->type !=3D PTR_TO_MEM)
        continue;
    if (dreg->dynptr_id =3D=3D dynptr_id)
        mark_reg_invalid(env, dreg);

Should invalidate_slices_of_dynptr() include a similar type check before
accessing dynptr_id?

> +			mark_reg_invalid(env, dreg);
> +	}));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829032754.2324=
760-1-xyx2021@mail.ustc.edu.cn?part=3D1
