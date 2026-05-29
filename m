Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1823624C9
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022232; cv=none; b=Ps9c6r7vh1CSxjukz8l4g0z4NkhdXOcKrgAnaaQN1+tf6AY4Hs6H4lFPmHvNarfTl+oyiLJdtxBsemTd/atlxJ6BZM+BME5Eibnw+VLueJYbf0Bq33ws01+HyAdCxp/jCErW5VD+jNPCWJqGo2hS602vnRZhdevI6g7nJR/stQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022232; c=relaxed/simple;
	bh=1WZYeuS92m7gX/DEJJlKEcJu1Szunn6p9zq/3k3om1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQKXS4AGLe9fzIWnybu71hmKbcggCZcYMiKFx8qpgohJLjMexarZ489NCVSe3FFl3u3bponvSXAVfTu8zjQr5EpXsrlbstjiid9xoOqn88fh6+JAhrtdCZPDH8b+UQArXKfYsv/7N6XrzDD8m/40M4+/5kODfuHXV7kE9byLk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8QdBoe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8QdBoe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B71F000E9;
	Fri, 29 May 2026 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022230;
	bh=Y9jlYx8WeRDOyR+Czu2wnJutMSDv1zqJLzKzPAVoZ64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8QdBoe3bMFmPwELvn7HPbU/FbWiUin+6CjoLkVfXNRlMRzchdQsaTaOIwoXF5oes
	 SO8CmLitIA1X3vOP3o9ZEyBMX7amMqBquZ2fNsbnjuL/AVJ7Ol9z8PmslSeTWWo6LJ
	 TAJ1KlJsKrRYxc4YEoYKHYRSdMjUgDomUwD2UYnZVXVcPdraMoe5RGSD7a85EbcBOi
	 lIKHkIBo16Qo4zNNvmgItsKYWKD1/jpt/2zTW3XFhrSRqo0+PkVcO9YCv0yAQpBNIu
	 kdT2Yb5NlxJ2Wd7WnTsmaCh8DMbQ6UARtscX/Ybm70GiNObyw8Lox3LiCPvVo4+Kuk
	 BZUia5OGyd12A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 08/13] bpf: Unify release handling for
 helpers and kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529014936.2811085-9-ameryhung@gmail.com>
References: <20260529014936.2811085-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:37:09 +0000
Message-Id: <20260529023710.7F6B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoding `release_regno =3D BPF_REG_1` for `KF_RELEASE` kfuncs b=
ypasses reference tracking for kfuncs that take the release argument in a d=
ifferent register, leading to a potential double-free.
- [Low] The verifier incorrectly relies on `!!meta.dynptr.id` to determine =
if the released argument is a dynptr, introducing a latent bug that rejects=
 valid programs.
--

commit a23fc3d5455bdc1edfa4672854ea0a5f28d72d11
Author: Amery Hung <ameryhung@gmail.com>
Subject: bpf: Unify release handling for helpers and kfuncs

This commit introduces release_reg() to consolidate the release logic shared
by both helpers and kfuncs. It determines release_regno from the function
prototype/metadata before argument checking, setting it to BPF_REG_1 for
KF_RELEASE kfuncs, and extracting RCU ref tracking invalidation into helper
functions.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1a49e5194bb41..375e5e5f9131e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10116,37 +10182,11 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>  	}
> =20
>  	if (meta.release_regno) {
> -		err =3D -EINVAL;
> -		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
> -			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> -		} else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_obj.id) {
> -			u32 id =3D meta.ref_obj.id;

[ ... ]

> -		} else if (meta.ref_obj.id) {
> -			err =3D release_reference(env, meta.ref_obj.id);
> -		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
> -			/* meta.ref_obj.id can only be 0 if register that is meant to be
> -			 * released is NULL, which must be > R0.
> -			 */
> -			err =3D 0;
> -		}
> +		struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +		bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) && in_rcu_cs(=
env) &&
> +				   (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
> +
> +		err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.id);

[Severity: Low]
Does this logic correctly determine if the released argument is a dynptr?=20

By using !!meta.dynptr.id, it checks if any referenced dynptr was processed.
If a hypothetical helper takes both a normal PTR_TO_BTF_ID to release and a
separate referenced dynptr, wouldn't meta.dynptr.id be non-zero, causing
release_reg() to incorrectly treat the released argument as a dynptr and
spuriously reject the program?=20

The previous code correctly checked arg_type_is_dynptr(fn->arg_type[...]).

>  		if (err)
>  			return err;
>  	}

[ ... ]

> @@ -12403,6 +12424,10 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier=
_env *env,
> =20
>  	meta->kfunc_flags =3D *kfunc.flags;
> =20
> +	/* Only support release referenced argument passed by register */
> +	if (is_kfunc_release(meta))
> +		meta->release_regno =3D BPF_REG_1;
> +

[Severity: High]
Does hardcoding meta->release_regno =3D BPF_REG_1 bypass reference tracking=
 for
kfuncs that take the release argument in a different register?

If a new kfunc or an out-of-tree module kfunc is introduced that takes a
KF_RELEASE object in a register other than R1 (e.g., void bpf_my_release(int
flags, struct my_obj *obj)), it seems an attacker could pass 0 in R1. Since=
 R1
is a scalar, the validation loop would skip pointer checks. release_reg()
would then be called on regs[1], silently succeeding because it is NULL, wh=
ile
the runtime kfunc frees the object in R2, leading to a double-free.

The previous code correctly identified the release register dynamically in
check_kfunc_args().

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529014936.2811=
085-1-ameryhung@gmail.com?part=3D8
