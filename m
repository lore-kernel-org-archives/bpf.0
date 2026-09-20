Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1C244667
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939264; cv=none; b=DWYmuCnMAHxgHF7ySfRAlTTZWgsNli3EcexbbZT+phQt3omlG42W9R92Ay4PGG9xa3ckV/HiC12ArOJxZO4oxRN7Pk7gEPYfIZJuTmqgPD6YUt0KjKHTYfshceuJisnsL9K6j+Yo4GbPxz42lG3zf6brhcx9HGhG2awUcdqzuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939264; c=relaxed/simple;
	bh=K7+BBuYWEIiY9/8uOT+/He+L26yqgSUYLTkSO3k6NI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TjSVgkwTGpSsCJfzFi7nkV8n/hjwYMqPFKpw5ns7MMW2pInNzy/iE/lVg3ADCuo7Ts2tifKGW8b0d2dWErOl/wgxMFgrBrBZZTeutuZnE/buwn7DTIyE9rWqkBulF+qv9dUcJF+bP82LA0pppLLeRBGUWtiYkOkYG8OYXJ2EXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjVHcihe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjVHcihe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE61F000FF;
	Sun, 20 Sep 2026 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789939262;
	bh=Jb0FjVtN+3FgmjbihNnaVtrEm2eMvGF5+jWdd2hmz6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjVHcihes5ZVJT2vZWO2a5qZb/da8Xf365Y5lRnds0Vc/6AIumxRoV4gq91ynJGlG
	 ayjFC9YK+fpXR8CLVStePClWpWEJwXTJ+TtznNi/n6GonC7AEXY17i7/hRe/lESMti
	 ubpmcO61EuCmS10ONU705NXnpifgJJ95lsiHMZww/tkaMdfE0pJ6wNzhb/wZ3VkU1G
	 wigrQE0vGB+Hv0lbqgnI0o0x5/kow/Q+k9b8cFZ5w3rfJjxe1SsUjNYOMlfMzQntT0
	 lP3r+9auiwfUHPvURK2VIgPJ28Vl/msCdWOO7kdYAbamvE2GyDRCOlqQqXYnhG2LOz
	 zX2bu30L4zYdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Track iterator-owned BTF pointer
 lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
References: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn>
 <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:21:01 +0000
Message-Id: <20260920212102.14CE61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: Incomplete invalidation of iter-owned dynptrs and derived m=
emory slices
--

commit 1d039be28498ad8b8b6d1373478f0903a6cc5f06
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

bpf: Track iterator-owned BTF pointer lifetimes

This commit opts specific iterators into tracking the element lifetime,
associating the PTR_TO_BTF_ID results with the iterator reference. It
invalidates the previous result before advancing the iterator or destroying
it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -7824,6 +7841,27 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_=
meta *meta, int arg_idx,
>  	return btf_param_match_suffix(meta->btf, arg, "__iter");
>  }
> =20
> +static int invalidate_iter_owned_btf_ptrs(struct bpf_verifier_env *env, =
u32 parent_id)
> +{
> +	struct bpf_func_state *unused;
> +	struct bpf_reg_state *reg;
> +	int err;
> +
> +	err =3D check_reference_children_leak(env, parent_id);
> +	if (err)
> +		return err;
> +
> +	/* Opted-in iterators can release their previous element on next. */
> +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> +		if (base_type(reg->type) !=3D PTR_TO_BTF_ID || reg->parent_id !=3D par=
ent_id)
> +			continue;
> +		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
> +		mark_reg_invalid(env, reg);
> +	}));

[Severity: Medium]
Does this loop completely invalidate all derived pointers?

In mark_stack_slots_dynptr(), the lifetime of a dynptr is explicitly tied
to the iter-owned backing object using the parent ID:

/* All non-clone constructors take their backing object in R1. */
parent_id =3D reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);

However, the invalidation logic here restricts its checks to PTR_TO_BTF_ID.
It ignores STACK_DYNPTR slots because bpf_for_each_reg_in_vstate expands
to use a mask of 1 << STACK_SPILL, skipping STACK_DYNPTR entirely.

It also misses PTR_TO_MEM slices because of the strict PTR_TO_BTF_ID
type check.

If a BPF program creates a non-referenced dynptr from an iter-owned object,
or creates a PTR_TO_MEM slice from it, will these pointers remain usable
after the iterator advances and frees the underlying element, leading to a
use-after-free?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920210432.3457=
58-1-xyx2021@mail.ustc.edu.cn?part=3D1
