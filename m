Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961158635D
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787975821; cv=none; b=a9xg77WH0bxSX7ksrvmcIT4aOv54NuuFsovEG0/dQE7fDzJRNugj8WYmEHeK+2gGTb4ookmPLpOC2I4qPOKfzTFnUuh7gUhewPPyOr+h7l1JKp/gFz13uVt05jTZ6/Cp7Ksn6uBx37uaQR6oMslJqVvC7zk9vS6Usw1mqXDoSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787975821; c=relaxed/simple;
	bh=A9VqQlcNoDBhk8tfQI14jDbiL6y3iiUL2BcTMq3Zw6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kgqtZ8c0UOpJFLqUe4HBbC/R/JGazaIneMQo4u1yYKZiNlQ3PTOahk6dT5q85qyKHVIZkLFG08Z9CMIvghADLkrVeNeTnvS2X4G1x7QE6udEQkIvgXZ4ik0R8DtdAF1XbkX548NznG0vTpAIRihVfb23P71mq3C4v46OXDwhMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNZKA4/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNZKA4/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044281F000E9;
	Sat, 29 Aug 2026 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787975820;
	bh=1oDH8OULIwuT1DaEpcBGVn9b+yDzja1woK4Rl+xNQ4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNZKA4/a2wLmSCh8wpAtSFSAsggvzupxT4gPCfG4Lrl0KWopuPvRZ7jTmjx1uCZTR
	 wfVec/wWLf38ZwIQfzWQUSf9BJcfuLIx1UCVj8pm8Ev5so0jiNGYV6nkgqv7dSlTny
	 V6ZYhhEWVub2k541uGErPsPArY9FGZ+XUEzvXS01UQg+RVP6U+DSr98vXpVy3FXEfU
	 BuIEnePLv7zyMdQq2kitn6xjcNvglXCQTsVHB0ieWZos9tzcynKOnNdDPvVyS3BJRH
	 esewYlI3iQcmC78GnNFh0wM9KYvgrx9ztlvyvbNl05jLSoS98PAtt3Ls3Eo8l3SwzW
	 gQIEaeJ9xPRdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2 1/2] bpf: Invalidate dynptr slices by
 dynptr_id on release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829033725.2365697-2-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
 <20260829033725.2365697-2-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 03:56:59 +0000
Message-Id: <20260829035700.044281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `invalidate_slices_of_dynptr` function reads the `=
dynptr_id` union field without verifying the register's type, causing it to=
 erroneously invalidate unrelated registers due to memory aliasing.
--

commit e9eb0688f5ef0c81c32aeb93616da3b5719b04da
Author: Amery Hung <ameryhung@gmail.com>
bpf: Invalidate dynptr slices by dynptr_id on release

This patch invalidates dynptr slices when their parent dynptr is released by
walking registers with a matching dynptr_id in unmark_stack_slots_dynptr().
This addresses an issue where LDX/STX through slices remains allowed after
submitting or discarding the dynptr.

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 99b3f539e431f..5d0874a09a8db 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -862,6 +874,17 @@ static void mark_reg_invalid(const struct bpf_verifi=
er_env *env, struct bpf_reg_
>  		__mark_reg_unknown(env, reg);
>  }
> =20
> +static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, in=
t dynptr_id)
> +{
> +	struct bpf_func_state *fstate;
> +	struct bpf_reg_state *dreg;
> +
> +	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> +		if (dreg->dynptr_id =3D=3D dynptr_id)
		^^^^

[Severity: High]
Does this code risk misinterpreting union fields in unrelated registers
due to memory aliasing in invalidate_slices_of_dynptr()?

Because dynptr_id shares a union with other fields in struct bpf_reg_state
(such as btf_id on 32-bit architectures, or first_slot for dynptrs), if the
register is not explicitly checked for type PTR_TO_MEM, this comparison
might match unrelated registers.

For instance, a program that acquires a dynptr reference (assigning it
id_gen =3D 1) could use a register where the union happens to alias to 1
(like a CONST_PTR_TO_DYNPTR callback argument where first_slot =3D true, or=
 a
PTR_TO_BTF_ID where the BTF ID is 1). Releasing the dynptr triggers
invalidate_slices_of_dynptr(env, 1), which unconditionally checks
dreg->dynptr_id =3D=3D 1 and misinterprets the aliased union field as a mat=
ch.
This could incorrectly invalidate valid registers, leading to spurious
verification failures.

Could we add a check for dreg->type before accessing dreg->dynptr_id to
prevent this?

> +			mark_reg_invalid(env, dreg);
> +	}));
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829033725.2365=
697-1-xyx2021@mail.ustc.edu.cn?part=3D1
