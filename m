Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0F48E0EA
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815244; cv=none; b=PYYKn8A6X4STvDGjfpF0aimWe5OE0CDeIxc6YsA+JDyd9ndTedPoGpjDp+OSR9t0rLs+H3Yve3EZwdm5q/xJrFiyBksbtPP4P+DhZYwYTiodJoNTAJ+CtdDMkUFdv324cY+J75cXBOMcUJYIRVsDeAL11f4KTwzTsIcMLNVx5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815244; c=relaxed/simple;
	bh=TLm1DfHIQbDdU/Rk9WaItXsbgEpQZWDOP8n8uMZ+pi8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V6v8z4ES5Yk60iHGSPREE2bZQX+NFjxJhazg6aGjx65HC5SF0S7/omU3APoOruStLPsvOM8LPTjdBiGG582ekxwAYchqQCsGAadjIpgfnoxk+JFzvOOux5vF+37xgbCIu0GK2KT5POjAjLf24gEQefF327vpCpz2+ARkfEMm61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHw4w3k0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHw4w3k0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1678D1F0089B;
	Mon, 12 Oct 2026 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815243;
	bh=/1W9UCqoi0/Du8jbKH4h0L5wD8gQ0vbH+karIp3kozg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oHw4w3k0JZF/gAuTRksOFZU8X+rqMhrePpJLNZY/TW8iP40yT7t7VXAuqKxpJ5qpd
	 ktEGgJnpe3MbYzCtO/RHnW303JBZNXrJhUgE9hmehNpI6iwRvJpyzCVcrfJea0e6zs
	 wygztOBhnj1c2h1IlPSX6HUBEw/gaKmUvxqvn9Nt/pjZyGEBp24ylGAZzlzXBpvWZx
	 g9juPDEDoi2Se50vFv0Q0yxtm7TJZB+XbpNw0D3XIJhUuen5GYdwaVRAmkm3z9QVX5
	 NEsT56HSqH1nvZIc15I+oddqdbKGQHqTKMmc+VV1Zb0O9czIZQJfUbifsqAi9V+OEC
	 wy7Ll6Q4ezICg==
Content-Type: multipart/mixed; boundary="===============4228498711650598839=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <162582b750eb1134fd6b486c1a3970a4e39bd21588537af1e8c41768c102d087@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-9-memxor@gmail.com>
References: <20261012133711.4030594-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Set up the arena base only in functions that use it
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:22 +0000 (UTC)

--===============4228498711650598839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Set up the arena base only in functions that use it

TL;DR: Kfunc __arena arg use is possibly marked on subprog 0 rather than the
calling subprog, so JIT of that subprog may fail, rejecting programs that
loaded before (WARN, panic with panic_on_warn).

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 083fcd6cf15b..3130d9ecbb99 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1980,7 +1980,7 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
>  
>  		if (!(flags & BTF_FMODEL_ARENA_ARG))
>  			continue;
> -		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
> +		if (WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog)))
>  			return -EINVAL;
>  
>  		/* mov eN, eN: truncate and clear the upper 32 bits */

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a24a2bab802b..9e4aedab71ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5436,6 +5436,18 @@ static bool is_arena_scalar(struct bpf_verifier_env *env, int regno)
>  	return reg->type == SCALAR_VALUE && env->arena_scalar && env->prog->aux->arena;
>  }
>  
> +/*
> + * The insn being verified works with the arena base, which a JIT sets up in
> + * the prologue of the function the insn belongs to, see
> + * bpf_prog_uses_arena_insns(). Every caller checked that the program has an
> + * arena, so uses_arena_insns implies one.
> + */
> +static void mark_uses_arena_insn(struct bpf_verifier_env *env)
> +{
> +	bpf_find_containing_subprog(env, env->insn_idx)->uses_arena_insns = true;
> +	env->prog->aux->uses_arena_insns = true;
> +}
> +

[ ... ]

> @@ -13848,6 +13862,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  				reg_arg_name(env, argno));
>  			return -EINVAL;
>  		}
> +		/* the JIT rebases the argument on the arena base */
> +		mark_uses_arena_insn(env);
>  		if (reg_from_argno(argno) < 0) {
>  			verbose(env, "%s arena pointer cannot be a stack argument\n",
>  				reg_arg_name(env, argno));

Can this record the arena use against the wrong function?

get_kfunc_arg_type() is not run once per call site.  Its only caller is
gen_kfunc_arg_proto(), and the only caller of that is bpf_add_kfunc_call():

    add_kfuncs()
      bpf_add_kfunc_call()
        gen_kfunc_arg_proto()
          get_kfunc_arg_type()
            mark_uses_arena_insn()

bpf_add_kfunc_call() builds one descriptor per kfunc and returns early
through find_kfunc_desc() when the descriptor already exists.  add_kfuncs()
runs from bpf_check() after add_subprogs()/check_subprogs() and before
do_check_main(), so env->insn_idx is still 0 at that point (env comes from
kvzalloc_obj(), and insn_idx is only set inside do_check_main(),
do_check_subprogs() and the gotox handling).

mark_uses_arena_insn() then does:

    bpf_find_containing_subprog(env, env->insn_idx)->uses_arena_insns = true;

which always marks subprog_info[0], and never the subprog that contains the
call.  jit_subprogs() copies the per-subprog flag:

    func[i]->aux->uses_arena_insns = env->subprog_info[i].uses_arena_insns;

so func[i] for i >= 1 has the flag clear when its only arena related insn is
the kfunc call.

ARG_PTR_TO_ARENA accepts SCALAR_VALUE, so a subprog can forward a number it
received as an argument without any arena access, addr_space_cast or
arena-scalar access of its own:

    static __noinline int cap(u64 v)
    {
        return bpf_kfunc_arena_cap_test((u64 *)v);
    }

    SEC("syscall") int prog(void *ctx)
    {
        stash = (u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
        return cap(stash);
    }

The same applies to a static or global wrapper around scx_bpf_sub_grant(),
scx_bpf_sub_caps() or scx_bpf_cid_override().

The function model still carries BTF_FMODEL_ARENA_ARG for the argument, so
when func[1] is JITed:

    x86 emit_kfunc_arena_args():
        if (WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog)))
            return -EINVAL;

    arm64 emit_kfunc_arena_args():
        if (WARN_ON_ONCE(!ctx->arena_vm_start))   /* now 0 for func[1] */
            return -EINVAL;

do_jit() propagates the error, func[1]->jited stays 0, and jit_subprogs()
returns -ENOTSUPP.  Because kfunc calls set prog->jit_required,
bpf_fixup_call_args() then rejects the program ("program requires BPF JIT
compiler but it is not available"), or returns the JIT error under
CONFIG_BPF_JIT_ALWAYS_ON.

Before this patch the check was !bpf_prog->aux->arena, and
func[i]->aux->arena is set for every subprog, so this program loaded and
ran.  The WARN_ON_ONCE can be triggered by any CAP_BPF loader, so with
panic_on_warn this becomes a panic.

The same mistake also marks subprog 0, and so sets up r12/x28, even when the
main function never uses the arena, which works against what the patch is
trying to do.  The add_kfunc_in_insns() path from bpf_convert_ctx_accesses()
also calls mark_uses_arena_insn() with a stale env->insn_idx left over from
do_check.

The existing selftests (arena_kfunc.c, arena_kfunc_jit.c,
struct_ops_arena_member.c) only call these kfuncs from the main function,
where marking subprog 0 happens to be right, so they do not catch this.

The commit message says the verifier records "a kfunc call with an __arena
argument" per function, the comment above mark_uses_arena_insn() says "The
insn being verified", and the comment above bpf_prog_uses_arena_insns() in
filter.h says the verifier "sets the flag for every function with an insn
that works with the base".  None of these hold for this path.

Should the kfunc case be marked at the call site during do_check, for
example in check_kfunc_args() when an ARG_PTR_TO_ARENA argument is
processed, or in check_kfunc_call(), instead of when the prototype is built?

No later commit in the series (a34d46a6be25 "libbpf: Render the arena type
tag with its address space", 00e951183327 "selftests/bpf: Test the address
space rendering of the arena type tag") addresses this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============4228498711650598839==--
