Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31649D5AD
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211271; cv=none; b=Yvm/nMBvjLDSEHc3aVJny+BwCsKhC81zrc7T+Qb+d0Y+D9W8CIVTdwt1yzCn4gBV4sYdL25DwFZqafPx4W9wzRBD+cx/ZfTUDQ3K7IBgfRuatadcGXwsyAqbSJLAYB1WPu1BYut7zRrDrX+wSBBzcFpsjbDzprIYMSRD41KqfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211271; c=relaxed/simple;
	bh=UtlEWJHGw/dKkPdUVywbwvC9VhlqSUbymO07xd3lUcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMLEc73+lmmVqtrVEdJrR7e3ZaJWR3hws1TppwD69ht7AA2SqH7B/9TrLVPPUhRqDclR3X+MHPoIdNo6YeYbWKl6ftGkxa6Ncbir7PQ+ax1yZq2EH988B6QXjMRXI5HcE1YDc+/l/znsP3WwER0sQJyQ5Wc2PUSyVWzZ5aVWZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqYpnqV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqYpnqV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F78A1F000FF;
	Mon,  5 Oct 2026 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211267;
	bh=NHj4+vZGC6IjOFs/5ij/G9499SyxWnCDFY2y0sQ879Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqYpnqV/nUms7dFpIf7nfs8GA+tv7gChYw/LocpWW8J2APzgNOuOhE2d2f4KFvZuq
	 2m71pWqll6AM2Dl8uoGfbowYkHuAHPufxtkwU6bjQgQrePohNq3scwHJPuNwL7GFAj
	 WUW3L/J4u+a7AgY62Q4zsSh95iMallNkGdWOLc4/2brMDoCjEBcRLdl9OPu2t/x0EP
	 PoJu93D1l2IbYIDVFp+SsoX8A0SOmzIuxYYuuMB60auuJue2nIoXQZEM9e7WnAttB+
	 4me/G+xUVGlkrHfylzQP8yzStF+0Cv8X/sfTqoaRFxD929zFYLdGHppyhA6DLBd34j
	 u0rPzn1vkeNpw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Verify calls of kfuncs with a
 body through the body
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yusheng Zheng" <yunwei356@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005142219.33451-3-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
 <20261005142219.33451-3-yunwei356@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:41:06 +0000
Message-Id: <20261005144107.0F78A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: uninitialized data leak and state mismatch for void kfuncs
- [Critical] bpf: argument checking bypass for nested kfunc calls
- [High] bpf: value truncation of 64-bit constant arguments in kfunc_bind
--

commit 0eafd0ff2fd1aa892e8a507b878aae0d4eedd33b
Author: Yusheng Zheng <yunwei356@gmail.com>

bpf: Verify calls of kfuncs with a body through the body

This commit allows the BPF verifier to inline the bodies of certain kfuncs
for context-aware analysis. It updates the CFG to replace kfunc calls with
their respective bodies before verification, tracks constant arguments, and
attempts to natively execute these inlined kfuncs if supported by the JIT.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> +/* A call of a kfunc with a body, which the verifier replaced by the bod=
y */
> +struct bpf_kfunc_inline {
> +	struct bpf_insn call;
> +	const struct bpf_kfunc_body *body;
> +	unsigned long addr;		/* of the compiled kfunc */
> +	u8 *image;			/* native code for the JIT */
> +	u32 start;
> +	/* the BPF registers that R0-R5 are bound to, and the constant argument=
s */
> +	u8 reg[MAX_BPF_FUNC_REG_ARGS + 1];
> +	s32 imm[MAX_BPF_FUNC_REG_ARGS + 1];

[Severity: High]
Is it intentional to use s32 for the constant arguments here? Since BPF
registers hold 64-bit values, could this lead to truncating 64-bit constants
if a kfunc expects a u64 or s64?

[ ... ]

> diff --git a/kernel/bpf/kfunc_inline.c b/kernel/bpf/kfunc_inline.c
> --- a/kernel/bpf/kfunc_inline.c
> +++ b/kernel/bpf/kfunc_inline.c

[ ... ]

> +int bpf_inline_kfunc_bodies(struct bpf_verifier_env *env)
> +{

[ ... ]

> +		prog =3D bpf_patch_insn_data(env, i, r->body->insns, r->body->len);
> +		if (!prog)
> +			return -ENOMEM;
> +		env->prog =3D prog;
> +		for (j =3D i; j < i + r->body->len; j++)
> +			env->insn_aux_data[j].kfunc_body =3D 1;
> +		env->insn_aux_data[i].kfunc_body_entry =3D 1;
> +		i +=3D r->body->len - 1;

[Severity: Critical]
Since bpf_inline_kfunc_bodies() skips over the newly inlined instructions, =
it
appears nested kfunc calls inside the inlined body are not inlined themselv=
es
and remain as standard BPF call instructions.=20

Combined with the skipped prototype initialization in bpf_add_kfunc_call(),
could this allow a user to pass arbitrary unverified arguments to the nested
kfunc if do_check_main() later evaluates it using a zeroed descriptor?

> +	}
> +	return 0;
> +}
> +
> +/*
> + * The body of a kfunc gets only the arguments of the call and leaves R1=
-R5
> + * like it. The constant (__k) arguments must be known, and native code =
may
> + * use their values.
> + */
> +int bpf_mark_kfunc_body_regs(struct bpf_verifier_env *env, int prev_insn=
_idx,
> +			     const struct bpf_insn_aux_data *aux)
> +{
> +	struct bpf_kfunc_inline *r =3D env->kfunc_inlines;
> +	struct bpf_reg_state *regs =3D cur_regs(env);
> +	u32 clobber =3D 0;
> +	int i, err;
> +
> +	/* leaving the body */
> +	if (prev_insn_idx >=3D 0 && env->insn_aux_data[prev_insn_idx].kfunc_bod=
y &&
> +	    (!aux->kfunc_body || aux->kfunc_body_entry))
> +		clobber |=3D GENMASK(BPF_REG_5, BPF_REG_1);

[Severity: Critical]
Should this also clobber R0 when leaving a void kfunc?

If the kfunc does not return a value, R0 appears to be left uninitialized.
If the JIT falls back to the compiled C function, it might leave R0 with
uninitialized garbage or a user-controlled value. Could the BPF program then
dereference R0, leading to arbitrary memory reads or privilege escalation?

> +	if (aux->kfunc_body_entry) {
> +		while (r->start !=3D env->insn_idx)
> +			r++;
> +		for (i =3D BPF_REG_1; i <=3D BPF_REG_5 && !env->cur_state->speculative=
; i++) {
> +			if (!(r->imm_mask & BIT(i)))
> +				continue;

[ ... ]

> +			err =3D mark_chain_precision(env, i);
> +			if (err)
> +				return err;
> +			/* emitted code needs the same constants on every path */
> +			if (r->entered && r->imm[i] !=3D (s32)regs[i].var_off.value)
> +				r->copy =3D true;
> +			r->imm[i] =3D regs[i].var_off.value;

[Severity: High]
Will this safely handle 64-bit constants?

If multiple paths call the same kfunc with 64-bit constants that share the
same lower 32 bits, the verifier might incorrectly assume they are identical
due to the s32 cast. Could this cause the JIT to emit native code with the
wrong constant?

> +		}
> +		r->entered =3D true;
> +		clobber |=3D BIT(BPF_REG_0) | (GENMASK(BPF_REG_5, BPF_REG_0) &
> +					     ~GENMASK(r->nargs, BPF_REG_0));
> +	}

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2990,7 +2991,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
>  	desc =3D &tab->descs[tab->nr_descs];
>  	memset(desc, 0, sizeof(*desc));
> =20
> -	err =3D gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
> +	/* the body of a kfunc that the program may call checks its arguments */
> +	body =3D kfunc.flags && btf_kfunc_is_allowed(kfunc.btf, func_id, env->p=
rog) ?
> +	       btf_find_kfunc_body(kfunc.btf, func_id) : NULL;
> +	err =3D body ? 0 : gen_kfunc_arg_proto(env, &meta, &func_model, &desc->=
proto);

[Severity: Critical]
If gen_kfunc_arg_proto() is skipped for kfuncs with bodies, desc->proto
remains zero-initialized. Could this bypass argument validation for nested
kfunc calls that do not get inlined?

>  	if (err)
>  		return err;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005142219.3345=
1-1-yunwei356@gmail.com?part=3D2
