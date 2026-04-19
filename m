Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311926A1B5
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776626116; cv=none; b=mkhwkjWC6YK6yhnNlnUT+QedBVF7D47R09LdsGLBBUlNm0k3JFbyLq9MLXFPoJy2gtRoxxFCYNUXCkeSzi8CIKr0BJOuCG5gDBRLXQenFgi6dcG64Jm3gT3flEr8bv+Rq4Y/gvlQDseCyXSx2Z0Ix478SctsJqSrFRzjQvGPqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776626116; c=relaxed/simple;
	bh=bSsK4GkZJSiAqZNOu2Zun/Hf9NQsf6+gRoCtNRclQas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JI3AdkG2qYTg1TpfEBCHIToE/QPQxvp8BFl8MZwCxS25dP2UVGISmS/eQhs0gpe1H5Ra+abTGMUHHQ45PFsb8mw1RUye6eJayZljUmQlvfAo1rfKNwGLx/ey3A1J1ftnvHJwbn6c3LKHwN9FPe8HdVXj0uWBTX8fMsBEygHUUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZqjUxwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZqjUxwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA1C2BCAF;
	Sun, 19 Apr 2026 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776626116;
	bh=bSsK4GkZJSiAqZNOu2Zun/Hf9NQsf6+gRoCtNRclQas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GZqjUxwNcxruFJO1viaKywL4cG17sJzyaqeKgZGIrtXre2SPkwwSI6Rpq1PitSJyS
	 jexcGF+bKFjfWIhXAxFYbew8Hk/moKn56Vl2Cc3/t2Z6OwL7pKvDI59xmWQvLiWNwD
	 N7yUQ3R++3CcO4an/qfGmo/oPXnaWONeFXt751sxHfpobrYabBVrMGnhkHqgy8g9J2
	 aG8AqggECr1c8YvPYm+oiAUI7SkxZSRid9HokUn1sZ2gXvvAky2aKinZozRwul+ANQ
	 4dfWYbE1TFI9QX+PKTnfpnPG0KGdXVjSAVivSmVTkZhdiWrdrOswVe9GSYTltf7Rlo
	 +vb+15JvQmrww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 07/17] bpf: Support stack arguments for bpf
 functions
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163352.734115-1-yonghong.song@linux.dev>
References: <20260419163352.734115-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 19:15:15 +0000
Message-Id: <20260419191516.44EA1C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Missing precision tracking for stack arguments (`BPF_REG_PARAM=
S` / `r11`) leads to incorrect verifier state pruning and arbitrary out-of-=
bounds memory access.
- [Medium] `BPF_PROG_TYPE_EXT` (freplace) programs are incorrectly rejected=
 when targeting static subprograms with more than 5 arguments.
- [Low] `stack_arg_safe()` strictly compares `stack_arg_depth`, preventing =
safe paths from being pruned and leading to state explosion.
--

commit 0c58d1bb907c4a6a387f1afd22baae9d43e95a55
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Support stack arguments for bpf functions

This commit introduces support for passing more than 5 arguments to BPF
subprograms by using a dedicated stack area accessed via register r11.
It tracks these stack arguments separately from the regular stack to ensure
proper verification and pruning.

Link: https://github.com/llvm/llvm-project/pull/189060

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8478d2c6ed5b6..235841d23fe3f 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -838,6 +838,44 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  	return true;
>  }
> =20
> +/*
> + * Compare stack arg slots between old and current states.
> + * Outgoing stack args are path-local state and must agree for pruning.
> + */
> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
> +			   enum exact_level exact)
> +{
> +	int i, nslots;
> +
> +	if (old->incoming_stack_arg_depth !=3D cur->incoming_stack_arg_depth)
> +		return false;
> +
> +	/* Compare both incoming and outgoing stack arg slots. */
> +	if (old->stack_arg_depth !=3D cur->stack_arg_depth)
> +		return false;

Does this strict comparison of stack_arg_depth prevent safe paths from
being pruned?

Since stack_arg_depth tracks the allocated capacity rather than the
active outgoing arguments tracked by out_stack_arg_mask, two branches
that call subprograms with different stack argument requirements might
end up with permanently different stack_arg_depth values.

Could this unnecessarily increase verification complexity by failing to
prune functionally equivalent states?

[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6aa4dc161a563..78c9322870a51 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
> +				 int off, int value_regno)
> +{
> +	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
[ ... ]
> +	state->out_stack_arg_mask |=3D BIT(idx);
> +	return 0;
> +}
> +
> +/*
> + * Read a value from the incoming stack arg area.
> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
> + * Callers ensure off > 0, 8-byte aligned, and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
> +				int off, int dst_regno)
> +{
[ ... ]
> +	if (is_spillable_regtype(arg->type))
> +		copy_register_state(&cur->regs[dst_regno], arg);
> +	else
> +		mark_reg_unknown(env, cur->regs, dst_regno);
> +	return 0;
> +}

Should check_stack_arg_read() and check_stack_arg_write() call
bpf_push_jmp_history() with the INSN_F_STACK_ACCESS flag?

When the callee uses a stack argument in a context requiring precision,
backtracking is initiated. Because the INSN_F_STACK_ACCESS flag is
missing, backtrack_insn() might silently return 0. This clears the
destination register without propagating the precision requirement to
the stack slot.

Could this cause the verifier to incorrectly prune execution paths
containing different, potentially unsafe scalar values, allowing
programs to bypass verifier bounds checks and perform arbitrary
out-of-bounds accesses? Note that the subsequent patch that tracks
r11 registers in const_fold and liveness does not address this
backtracking logic.

[ ... ]
> @@ -18808,7 +19097,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>  				goto out;
>  			}
>  		}
> -		for (i =3D BPF_REG_1; i <=3D sub->arg_cnt; i++) {
> +		for (i =3D BPF_REG_1; i <=3D min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG=
_ARGS); i++) {
>  			arg =3D &sub->args[i - BPF_REG_1];
>  			reg =3D &regs[i];

For freplace programs targeting static subprograms with more than 5
arguments, do we need to initialize state->frame[0]->incoming_stack_arg_dep=
th
here or allocate stack_arg_regs?

Currently it seems to only initialize arguments up to MAX_BPF_FUNC_REG_ARGS.
If incoming_stack_arg_depth remains 0, an EXT program attempting to read
its 6th argument via BPF_REG_PARAMS would fail verification in
check_stack_arg_read() with -EACCES.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D7
