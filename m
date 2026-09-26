Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BFB3AA4E4
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466943; cv=none; b=VWjlBajwNEewgP6WBm8zKv3RM8E5hkO2RzxggKJWvODBYjmL8Vxep9g+ATbI3Icu8pdwdO4gY3A7U8abvreIBCUtWulUHJQVqYvMvbYDZgtYUO7O4d0JamFtEoo7w8yM8f3ZS8OiR4gpaL8fv2Ct1x7lFe3yh2p+WuAE6Ytx6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466943; c=relaxed/simple;
	bh=o4n1/p092CG12fBCszcYbftlZE/h2IVcw8eBcvUxs9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZfXwubjl4x/FlewCH5OfFOlLdIL1Z+Rv4CVwee6OXgKPhYYftmu21ds7NQ1mFIekFXnpR+TVm3HbVCTtOFsbsOuZBHp2ltqcgzs4oi7ydGMyP5GHBxqhWu2Xnxe1fzgR17X/THwbRSPlGRBXaWRj6C04REOpIerBPe/Um/cFEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5D2x1Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5D2x1Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF5B1F000FF;
	Sat, 26 Sep 2026 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466942;
	bh=NloI5wrF3Vxw7RCJqvkWk5r4C8Vb3J/8bWWyC/Asr6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5D2x1KdwykKiCFKufb0NoO1qZ8ydUYCx8w1DiTX2zib6F+5CmJaVa+B9/YNjRxZB
	 wju32/DeBy5XWy3v/mj5DFODePYdRFSGqzTnRI0sAZbcSahPtM69efVLsCd0lQLhP4
	 0XGT9Eb1p7/HjbleN+Cue/VAJHFrpcpYga8Nm+v5qzH77ynsfalTlPN4I4GOgTQUgP
	 dHRC3B382PloES1QUUaAwZbVoZgDhDd3wAuXtSUGxRj04xJfzexxicAC62+TqJhw+s
	 cH87MPOEKt3lBoEumXEcFFXvrZCKGnOZtiQc5ZBURKnAsTIW/yR8qj4+TipZxJ2Ojt
	 VUpt6LDp1w1Sw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 04/16] bpf: Add the typed_arena_cast
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-5-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:55:41 +0000
Message-Id: <20260926235541.CFF5B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: typed arenas leak on late verification failure
- [Medium] bpf: diagnostic log state leak in check_alu_op() on typed arena =
cast
- [Low] bpf: comment style violation in backtrack_insn()
--

commit 1039fff673a440b6fdcfc452a1630f899213bc0c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add the typed_arena_cast instruction

This commit adds the typed_arena_cast instruction, which turns an untrusted
64-bit value into a verifier-trusted pointer to a typed arena object. The
verifier registers the typed arena on first sight, logs it, and lowers the
instruction after verification.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 0e38b9575328c..38984e52ee375 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -328,11 +328,13 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>  				if (sreg !=3D BPF_REG_FP)
>  					bt_set_reg(bt, sreg);
>  			} else {
> -				/* dreg =3D K
> +				/* dreg =3D K, or dreg =3D typed_arena_cast(sreg, imm)
>  				 * dreg needs precision after this insn.
>  				 * Corresponding register is already marked
>  				 * as precise=3Dtrue in this verifier state.
> -				 * No further markings in parent are necessary
> +				 * No further markings in parent are necessary;
> +				 * a cast yields a pointer that is safe for any
> +				 * value of sreg, which needs no precision.
>  				 */
                                 ^^^

[Severity: Low]
Does this multi-line comment violate the BPF subsystem comment formatting r=
ules?
The opening /* should typically be on its own line for multi-line comments =
in
BPF subsystem code.

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d3b8b626ec0f7..619f7c6a778d9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3085,6 +3085,8 @@ static void bpf_prog_free_deferred(struct work_stru=
ct *work)
>  	aux =3D container_of(work, struct bpf_prog_aux, work);
>  #ifdef CONFIG_BPF_SYSCALL
>  	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
> +	/* The typed arenas outlive the program; only the load's failure retrac=
ts them. */
> +	kfree(aux->typed_arenas);
>  #endif
>  #ifdef CONFIG_CGROUP_BPF
>  	if (aux->cgroup_atype !=3D CGROUP_BPF_ATTACH_TYPE_INVALID)

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03dbc0e003986..a0069983f1036 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16993,7 +17173,9 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  			struct bpf_reg_state *dst_reg =3D regs + insn->dst_reg;
> =20
>  			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> -				if (insn->imm) {
> +				if (insn->off =3D=3D BPF_TYPED_ARENA_CAST) {
> +					return check_typed_arena_cast(env, insn);
                                        ^^^^

[Severity: Medium]
Does this early return bypass the paired bpf_diag_mod_end(env) cleanup at t=
he
end of check_alu_op()? Leaving the diagnostic state active here fails to re=
cord
the register modification in the diagnostic event log.

> +				} else if (insn->imm) {
>  					/* off =3D=3D BPF_ADDR_SPACE_CAST */
>  					mark_reg_unknown(env, regs, insn->dst_reg);
>  					if (insn->imm =3D=3D 1) /* cast from as(1) to as(0) */

[ ... ]

> @@ -20580,8 +20764,26 @@ static int resolve_func_ptrs(struct bpf_verifier=
_env *env)
>  }
> =20
>  /* drop refcnt of maps used by the rejected program */
> +/*
> + * Drop the rejected program's typed arena references before its arena m=
ap
> + * reference. A typed arena nobody else registered is retracted; one tha=
t a
> + * loaded program registered lives on for the map's lifetime.
> + */
> +static void release_typed_arenas(struct bpf_verifier_env *env)
> +{
> +	struct bpf_prog_aux *aux =3D env->prog->aux;
> +	u32 i;
> +
> +	for (i =3D 0; i < aux->typed_arena_cnt; i++)
> +		bpf_typed_arena_put(bpf_prog_arena(env->prog), aux->typed_arenas[i]);
> +	kfree(aux->typed_arenas);
> +	aux->typed_arenas =3D NULL;
> +	aux->typed_arena_cnt =3D 0;
> +}
> +
>  static void release_maps(struct bpf_verifier_env *env)
>  {
> +	release_typed_arenas(env);
        ^^^^

[Severity: High]
Can this leak the typed arena references?

In bpf_check(), if verification fails after env->prog->aux->used_maps is
populated, the err_release_maps path bypasses calling release_maps(env):

err_release_maps:
	if (ret)
		release_insn_arrays(env);
	if (!env->prog->aux->used_maps)
		release_maps(env);

If release_maps(env) is skipped, release_typed_arenas(env) will not be call=
ed.
Then, bpf_prog_free_deferred() only does kfree(aux->typed_arenas) without
dropping the actual bpf_typed_arena_put() refcounts, permanently leaking
the typed arenas and their backing resources.

>  	__bpf_free_used_maps(env->prog->aux, env->used_maps,
>  			     env->used_map_cnt);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D4
