Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920160;
	b=c/XruLGd9weyHkJMHLkOIN8HNzzmu+PI+0arq98jAs4W7aNYcMyNkfP5jJe469omMQnw
	 Gezs4rlOQ5HFECD86HFKNuSObxbAosd6VskkVObPkO/Nkf7PCygDR2SZQWiU11KI/3d/N
	 9d/ogA7Ff4Lt7k8t69yb5qeaFWucT8lHq+0zOPzN8TxR2WssF8/DO8xdS6aT57HWplxSc
	 pgybfEu7VWVfwrjUrwb2fUPoUqz7T1cKA27H7p5HTLFnPCU5kVTDMX7VG9X5ntbyvzINY
	 H+A/tlSVRFre0eLqkn8T1inuNXRBCxT7g1HupKE/TrW06YyqsuD/xgdXHwsOoL0LqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gHlF75HUjvERcFLfzFf+mJE7+Uf+YJELHB1I0vUZkjw=;
	b=lF6oWo3/z4H0+35GI4tIJbwBVojFmoyU/nzy45OIhH1ssyAEnXIVT/qGESvJZC6s+QoO
	 hKL6CRJcPPLpfu9uuYMqWgTSBnStadO3A69fbdYIH+VtZolm8DGe+4J4v+BrYjrdQKRGF
	 tOZofG+GwD59RBAsF+shQ6MQAUXDyOW7ppSwdJTdFzMqc3tuj0v763npqxUc6+HuIDwxl
	 FcHGulRHmQ447x1rzvmeVazyGztOgNbl6uj0AOhsTA0filrB7tKzNGxU70MBdL6rMGzKO
	 5REkhvGd9rrJSMJemSvgSsvt1yVBXp5TM+v+e4GkGkgVeXX2QZ6nly8qSKSrYAjHy4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5d2Gkx1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0D606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5d2Gkx1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D721F008A1;
	Thu,  5 Nov 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920160;
	bh=gHlF75HUjvERcFLfzFf+mJE7+Uf+YJELHB1I0vUZkjw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X5d2Gkx1IfY4pz+BI8XEE8WTqycRz0FSXtxo/QBmS7FwEd/+VI9O86mLFDIG/7Rpr
	 Fx4z5ijZI5duGcgC9CQ/4WY3p+XiF0Gk7DtKKgcuff/Aw+5/EF/xWAR9eV1TufE17X
	 R05Tl0qFG440kjssggIwwK2Ts5PLKYqsJEbGwE9GHkyz6bkT2NmvDyyNFcMbOvHKZZ
	 3n9vBxPOPtwmF4BeOfPHs5EiJJCqirYyficBL7LqOTtQujow8GhRnxSrI4tpKgZsJw
	 vFC1DJphcpdeJaoqeD7Z0yYHxqPs11p4LMK7ijo2wqnYMhsNSSEUWvk/z/PVEaCRM7
	 zCt78ADczn6UA==
Message-ID: <sashiko-outbox-200350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 22/35] bpf: Allow recursive subprogs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-23-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 23:09:19 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] bpf: unchecked stack_depth inflation in bpf_insert_recursion_check=
s()
- [Medium] bpf: uncleared recursive marks on dead subprogs in check_recursi=
on()
- [Medium] bpf: off-by-one frame count for recursion in compute_call_depth()
- [Medium] bpf: async callback edge mismatch in build_call_graph()
- [Medium] bpf: spurious budget exit on loop backedge in check_recursion_gu=
ard()
--

commit a695dbe863cc6aa8bea9098a7b33c426b4e3cb1a
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Allow recursive subprogs

This commit enables verification of recursive static BPF subprograms by
identifying cycles in the call graph prior to the main verification pass,
widening entry and exit states across recursive calls, and verifying runtime
recursion depth and time-budget guard edges.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 901f4c7620e9e..e9466cff05a04 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -5975,20 +5979,45 @@ static int check_exception_cb(struct bpf_verifier=
_env *env, struct bpf_call_grap
>  	return 0;
>  }
> =20
> +static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog);
> +
>  /*
> - * The DFS of sort_subprogs_topo() follows the address of a function lik=
e a call, and
> - * tolerates a cycle only when such address closes it, since it doesn't =
know what it is
> - * taken for. Such cycle counts as a recursion, unless the function is a=
n async callback:
> - * its address is not an edge of the graph. The main verification pass l=
imits the
> - * depth of the recursion, but it doesn't follow calls of global functio=
ns.
> + * Every subprog on a cycle has to check the stack at run time. mark_rec=
ursive_subprogs()
> + * didn't see the cycle coming when a helper got the callback from a tab=
le of
> + * functions, or from another subprog. A subprog that it marked for call=
x, which turned out
> + * to call something else, needs no check.
>   */
>  static int check_recursion(struct bpf_verifier_env *env, struct bpf_call=
_graph *cg)
>  {
>  	int j, s;
> =20
>  	for_each_set_bit(s, cg->live, cg->cnt) {
> -		if (!test_bit(s, subprog_reach(cg, s)))
> +		if (!test_bit(s, subprog_reach(cg, s))) {
> +			env->subprog_info[s].recursive =3D false;
>  			continue;
> +		}

[Severity: Medium]
What happens if a subprogram was speculatively marked with
env->subprog_info[s].recursive =3D true in mark_recursive_subprogs() (for
example, because its address was in env->func_ptrs and another subprogram u=
sed
callx), but the main pass never calls it so it is not in cg->live?

Because check_recursion() only iterates over cg->live, any subprogram outsi=
de
cg->live keeps env->subprog_info[s].recursive =3D true and also bypasses the
bpf_enable_priv_stack(), bpf_prog_reenters_datapath(), and
bpf_prog_has_invocation_budget() checks below.

Later in bpf_check(), bpf_insert_recursion_checks() runs before
bpf_opt_remove_dead_code() and sanitize_dead_code(), scanning all subprogra=
ms:

kernel/bpf/fixups.c:bpf_insert_recursion_checks() {
	for (s =3D 1; s < env->subprog_cnt; s++) {
		if (!si[s].recursive)
			continue;
		found =3D true;
		arena_frame =3D max(arena_frame, si[s].arena_stack_depth);
	}
	if (!found)
		return 0;
	env->prog->jit_required =3D 1;
}

Wouldn't an uncalled subprogram with a stale recursive mark cause
bpf_insert_recursion_checks() to force jit_required, inflate
env->max_arena_stack_depth (or fail with -EACCES if it uses an arena stack
frame), and patch runtime recursion checks into dead code even on
architectures or program types that do not support them? Should
env->subprog_info[s].recursive also be cleared for subprograms not in
cg->live?

[ ... ]
> @@ -6134,11 +6164,17 @@ static void compute_call_depth(struct bpf_verifie=
r_env *env, struct bpf_call_gra
>  		for_each_set_bit(s, cg->live, cg->cnt) {
>  			if (dinfo[s].depth < 0)
>  				continue;
> -			depth =3D dinfo[s].depth + subprog_stack_size(env, s);
> -			arena_depth =3D dinfo[s].arena_depth + si[s].arena_stack_depth;
>  			for_each_set_bit(j, subprog_calls(cg, s), cg->cnt) {
>  				callee =3D &dinfo[j];
> -				frame =3D bpf_subprog_is_global(env, j) ? 0 : dinfo[s].frame + 1;
> +				depth =3D dinfo[s].depth;
> +				arena_depth =3D dinfo[s].arena_depth;
> +				if (!si[s].recursive || !si[j].recursive) {
> +					depth +=3D subprog_stack_size(env, s);
> +					arena_depth +=3D si[s].arena_stack_depth;
> +				}

[Severity: High]
Can the combined kernel stack depth of a call chain exceed env->stack_limit
when a recursive subprogram uses an arena stack frame?

In bpf_check(), check_max_stack_depth() -> check_call_depth() ->
compute_call_depth() runs before bpf_insert_recursion_checks():

kernel/bpf/verifier.c:bpf_check() {
	if (ret =3D=3D 0)
		ret =3D check_max_stack_depth(env);

	/* instruction rewrites happen after this point */
	if (ret =3D=3D 0)
		ret =3D bpf_optimize_bpf_loop(env);

	if (ret =3D=3D 0)
		ret =3D bpf_insert_recursion_checks(env);
}

Then bpf_insert_recursion_checks() increases si[s].stack_depth up to
env->stack_limit so the kernel stack check bounds arena stack usage:

kernel/bpf/fixups.c:bpf_insert_recursion_checks() {
		if (si[s].arena_stack_depth) {
			frame =3D DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room=
);
			if (frame > env->stack_limit) {
				verbose(env, "no room in the stack in arena for recursion\n");
				return -EACCES;
			}
			si[s].stack_depth =3D max(si[s].stack_depth, frame);
		}
}

Because check_max_stack_depth() already ran using the smaller initial
si[s].stack_depth, bpf_insert_recursion_checks() only checks frame <=3D
env->stack_limit in isolation. If caller frames before s (or non-recursive
callees called by s) also use kernel stack, couldn't the combined stack usa=
ge
around the recursion reach up to 2 * env->stack_limit while leaving
env->max_stack_depth under-reported?

> +				frame =3D dinfo[s].frame + !si[j].recursive;

[Severity: Medium]
Does this undercount the frame depth of a recursive cycle by one frame?

In check_call_depth(), dinfo[0].frame starts at 0 and is checked with:

	if (dinfo[s].frame >=3D MAX_CALL_FRAMES) {
		verbose(env, "the call stack of %d frames is too deep !\n",
			dinfo[s].frame);
		goto out;
	}

When a non-recursive subprogram s (!si[s].recursive) calls a recursive
subprogram j (si[j].recursive), !si[j].recursive evaluates to 0, so entering
the recursive component does not increment frame, and edges within the
recursive cycle also add 0. As a result, the recursion counts as 0 frames
rather than 1 frame, allowing a chain of 31 non-recursive calls followed by=
 a
recursive subprogram (33 frames total, or alternating non-recursive and
recursive subprograms) to stay below MAX_CALL_FRAMES.

Should frame be incremented when (!si[s].recursive || !si[j].recursive),
matching how depth and arena_depth are accumulated right above?

[ ... ]
> @@ -6256,6 +6296,151 @@ static int check_call_depth(struct bpf_verifier_e=
nv *env, struct bpf_call_graph
[ ... ]
> +				/*
> +				 * The helper that takes a callback calls it, or keeps it: the
> +				 * callback that arms itself again doesn't call itself.
> +				 */
> +				if (bpf_pseudo_call(&insn[i]) ||
> +				    !func_is_kept_for_later(env, i, si[s + 1].start))
> +					__set_bit(j, calls + s * words);

[Severity: Medium]
Can an async callback registration in a branch that is not reached during t=
he
main pass cause check_recursion() to falsely reject a program?

Here in mark_recursive_subprogs(), a bpf_pseudo_func instruction that passe=
s a
callback j to an async helper is skipped via func_is_kept_for_later(), so
si[j].recursive remains false.

However, if that registration is in an untaken branch of a live subprogram,
the main pass never visits the helper call and never sets si[j].is_async_cb=
 =3D
true. Afterwards, build_call_graph() scans all instructions of all subprogr=
ams
and only skips bpf_pseudo_func edges when si[j].is_async_cb is set:

kernel/bpf/verifier.c:build_call_graph() {
			if (si[j].is_async_cb && !bpf_pseudo_call(insn + i))
				continue;
			__set_bit(j, subprog_calls(cg, s));
}

If the untaken branch registers the enclosing live subprogram itself (or
registers an async callback j that re-arms itself), build_call_graph() will
include that edge in cg->live with recursive =3D=3D false, causing
check_recursion() to reject the program. Should build_call_graph() also ign=
ore
func_is_kept_for_later() edges when si[j].is_async_cb is not set?

[ ... ]
> @@ -21933,6 +22119,21 @@ static int flow_drain(struct bpf_verifier_env *e=
nv)
>  	return err;
>  }
> =20
> +/*
> + * A subprog on a cycle of the call graph checks the stack at run time, =
see
> + * bpf_insert_recursion_checks(). When there is no room, or the time sli=
ce is over, it leaves
> + * at once with 0 in place of the result: it unwinds if it can, see bail=
_unwinds, otherwise
> + * it returns and callers have to be fine with that.
> + */
> +static int check_recursion_guard(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *sub =3D &env->subprog_info[cur_func(env)->subp=
rogno];
> +
> +	if (!sub->recursive || env->insn_idx !=3D sub->start)
> +		return 0;
> +	return push_budget_exit(env);
> +}

[Severity: Medium]
What happens in check_recursion_guard() if a recursive subprogram has a loop
header at sub->start (for instance, when a loop begins at the first
instruction of the subprogram, or one recursive branch is tail-call elimina=
ted
into a jump back to sub->start)?

In bpf_insert_recursion_checks(), the runtime check is inserted with
bpf_patch_list_insert(env, si[s].start, buf, n), where the comment notes:

	/* calls get to the check, jumps to the first insn do not */
	err =3D bpf_patch_list_insert(env, si[s].start, buf, n);

At runtime, internal jumps to sub->start land after the recursion check.
During verification, however, check_recursion_guard() triggers every time
env->insn_idx =3D=3D sub->start, including on internal loop backedges. If t=
he loop
body holds a lock, RCU read lock, or acquired reference across the backedge=
 to
sub->start, wouldn't push_budget_exit() simulate a bail-out from the backed=
ge
state and falsely reject the program with a resource leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D22
