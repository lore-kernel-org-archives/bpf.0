Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941780;
	b=KevGwYOB2govyLBWN/8kqzjfcsAx0GgCUg1LtB45lHhbNsFfBRIxBiD0+jxHZ2XZEOJd
	 57yoU2JuU3prMQXCBtIoADRVUOKID+HqGHktGgKoqpCE7LCczf2LwaTNEwd7g6H/NbpgQ
	 cz1CZiePOGad7eHU/SvC8RNvhXajjRoLoyqzNFG/BzfZp4EDKParQna/aXwVkzgw0mQaw
	 lJeozhmCu6TYicLEEyTVVhvDjCeLdg8gf8qDRUBvvDfwH2FjJJvlS4kCq7dJ0R7ZxIgRF
	 W/qBu2kXVBsWHGXdHG5Eq2yltQfH0YARWzIt/K5gqu059B5lokG1+A2IY55tFV898TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tXNQhlfsh/OHOMSkPZtR6mSbEsiI2/GfOo8hEItjsmI=;
	b=BYoiI66G9T/Shl33EGxeNV3V9fQtEO8EjBjjTT9UQhv1sTdI1OLFnL62aHHYmFF99E0C
	 Ev2u3C5GjgeOpFXp1YznSZi3CIDOyMl4j3UEVFNT6Hc6ZuvhJ8tOztzHlXvp70US2MFnM
	 pL7TKna3hoJHQNaxybiFTN6H7g37E3Yk5rLTtCmjd6Eu1bSE9L0Za3V0Uh09l5au++8SX
	 CfwlvQsRjKZaXtiWqihrLFOqwcqrO0Xfk8Xqg0qJNeLG1KVBxp2GGORIu+KyyFfDCTQAS
	 iR5MdJk6TLJ7LvH/cbulh9PY57RcDjKM9EUNkFYDNYnP7xWFvTWWYctQpVDQvFhQXtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYFNCEUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAF606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYFNCEUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904881F0089F;
	Fri,  6 Nov 2026 05:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941779;
	bh=tXNQhlfsh/OHOMSkPZtR6mSbEsiI2/GfOo8hEItjsmI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KYFNCEUA/S/RzR+/Hcfq/1dGKJcHCAuLAHHPot05xH3qxSEXD3hDpia2ciibUwt4T
	 ipbzcN7OTnf5U1GKzqkztvWEDStYFCq34LZFE7LglP1ZFK8zrOT6fiysEeCgLP3TWg
	 lGvgfgkZP9xwobGREWIeR5sstJhGUvuBBeGEDAafq28vZPxDa5748COWUYjGXl4O1b
	 UXrTAFvgihv7ARCwwgeh7zOUuqiFguB4+19BY5808p4Fm0tH4ag53vyz/+r28LMQrl
	 7UoLExMGzYIY8hngT7nD8CevC9Iew1McG8TXJWqJMNvquEu747+tIt+8LgZXJrFJvK
	 BAF2xBQG2VzEA==
Message-ID: <sashiko-outbox-200800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 22/45] bpf: Allow recursive subprogs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-23-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:09:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] bpf: off-by-one frame count for recursion in compute_call_depth()
- [Medium] bpf: uncleared recursive marks on non-live subprogs in check_rec=
ursion()
- [Medium] bpf: async callback edge mismatch in mark_recursive_subprogs()
- [Medium] bpf: spurious budget exit on loop back-edge in check_recursion_g=
uard()
--

commit 3e4e0bb05c4c0b3219c8960f2496445434c33bfc
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Allow recursive subprogs

This commit allows recursive static subprograms in BPF programs by identify=
ing
cycles in the call graph prior to main verification, verifying runtime
recursion guard edges at subprogram entry, and adjusting liveness and stack
depth checks for recursive call cycles.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b61166f670945..e29fc3ee363a9 100644
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
As reported by bot+bpf-ci@kernel.org on v2 [1], check_recursion() only
iterates over cg->live when clearing env->subprog_info[s].recursive.

Before the main pass, mark_recursive_subprogs() scans all subprograms from 0
to env->subprog_cnt - 1, adds every subprogram in env->func_ptrs and
BPF_PSEUDO_FUNC instructions to taken, and connects every subprogram
containing callx to all subprograms in taken. If an uncalled subprogram s i=
n a
function pointer table has callx or is part of a cycle in that
over-approximated graph, mark_recursive_subprogs() sets si[s].recursive =3D
true.

When the main pass never calls s via callx, record_callx_edge() does not
record an edge to s and build_call_graph() leaves s out of cg->live. Because
check_recursion() only walks cg->live, si[s].recursive remains true and ski=
ps
the bpf_enable_priv_stack(), bpf_prog_reenters_datapath(), and
bpf_prog_has_invocation_budget() checks.

Later in bpf_check(), bpf_insert_recursion_checks() runs before dead code
elimination and scans all subprograms:

kernel/bpf/fixups.c:bpf_insert_recursion_checks() {
	for (s =3D 1; s < env->subprog_cnt; s++)
		found |=3D si[s].recursive;
	if (!found)
		return 0;
	env->prog->jit_required =3D 1;

	for (s =3D 1; s < env->subprog_cnt; s++) {
		if (!si[s].recursive)
			continue;
		...
}

Doesn't this leave si[s].recursive set on unreachable subprograms, forcing
env->prog->jit_required =3D 1 and patching recursion checks into dead
subprograms even on architectures or program types that do not support
recursion?

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
> +				frame =3D dinfo[s].frame + !si[j].recursive;
> +				if (bpf_subprog_is_global(env, j))
> +					frame =3D 0;

[Severity: Medium]
As reported by Sashiko on v2 [2], in compute_call_depth(), dinfo[0].frame
starts at 0 for the main program, and check_call_depth() checks
dinfo[s].frame >=3D MAX_CALL_FRAMES and dinfo[s].frame >=3D MAX_CALL_FRAMES=
_INTERP
directly without adding 1 for subprogram s itself.

When a non-recursive caller s (!si[s].recursive) calls a recursive callee j
(si[j].recursive), frame =3D dinfo[s].frame + !si[j].recursive adds 0 on en=
try
into the recursion, 0 on edges within the recursion, and 1 only for a
subsequent non-recursive callee k when exiting the recursion. This causes t=
he
entire recursive component to count as 0 frames instead of 1 frame in
dinfo[].frame, allowing a static call chain containing recursive subprograms
to exceed MAX_CALL_FRAMES (32) or MAX_CALL_FRAMES_INTERP (16) without being
rejected by check_call_depth().

Should frame be incremented by (!si[s].recursive || !si[j].recursive) to ma=
tch
the condition used for depth and arena_depth right above it, so that a
recursion counts as one frame in the static call chain?

[ ... ]
> @@ -6302,6 +6342,151 @@ static int check_call_depth(struct bpf_verifier_e=
nv *env, struct bpf_call_graph
>  	return err;
>  }
> =20
> +/*
> + * The address of the callback at @idx goes nowhere but to a helper that=
 keeps it for
> + * later: a timer, a work queue, call_rcu.
> + */
> +static bool func_is_kept_for_later(struct bpf_verifier_env *env, int idx=
, int end)
> +{
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	u8 class, reg =3D insn[idx].dst_reg;
> +	int i;
> +
> +	if (reg < BPF_REG_1 || reg > BPF_REG_5)
> +		return false;
> +	for (i =3D idx + 2; i < end; i++) {
> +		class =3D BPF_CLASS(insn[i].code);
> +		if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32)
> +			return bpf_is_async_callback_calling_insn(&insn[i]);
> +		if (insn[i].dst_reg =3D=3D reg)
> +			return false;
> +		if (bpf_is_ldimm64(&insn[i]))
> +			i++;
> +		else if (insn[i].src_reg =3D=3D reg)
> +			return false;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Find the subprogs on cycles of the call graph. It is not known yet wh=
at callx
> + * calls: it may be any subprog whose address is taken. A subprog that is
> + * marked for no reason is treated like a recursive one all the same.
> + */
> +static int mark_recursive_subprogs(struct bpf_verifier_env *env)
> +{
[ ... ]
> +				/*
> +				 * The helper that takes a callback calls it, or keeps it: the
> +				 * callback that arms itself again doesn't call itself.
> +				 */
> +				if (bpf_pseudo_call(&insn[i]) ||
> +				    !func_is_kept_for_later(env, i, si[s + 1].start))
> +					__set_bit(j, calls + s * words);

[Severity: Medium]
As reported by Sashiko on v2 [3], mark_recursive_subprogs() and
build_call_graph() use different criteria to decide whether a bpf_pseudo_fu=
nc
instruction for an async callback forms a call edge:

1. In mark_recursive_subprogs(), func_is_kept_for_later() syntactically che=
cks
whether bpf_pseudo_func loads into R1-R5 and reaches an async callback help=
er
or kfunc with no intervening jumps, calls, or register copies. If an async
callback registration in a live subprogram is on an untaken branch during
do_check_all(), func_is_kept_for_later() returns true (so si[j].recursive is
false), while push_callback_call() is never reached (so si[j].is_async_cb
remains false). When build_call_graph() later scans all instructions of
subprograms, it only skips bpf_pseudo_func when si[j].is_async_cb is set:

kernel/bpf/verifier.c:build_call_graph() {
	...
	if (si[j].is_async_cb && !bpf_pseudo_call(insn + i))
		continue;
	__set_bit(j, subprog_calls(cg, s));
}

If the callback re-arms itself, build_call_graph() adds the cycle to cg->li=
ve
and check_recursion() rejects the program because si[j].recursive was not s=
et.

2. Conversely, if a live async callback that re-arms itself (directly or vi=
a a
helper subprog) loads its bpf_pseudo_func address into a callee-saved
register, copies the register, or has an intervening branch or call before =
the
async callback helper, func_is_kept_for_later() returns false and
mark_recursive_subprogs() marks the subprogs on the cycle as recursive =3D =
true
before the main pass. Even though si[j].is_async_cb becomes true during the
main pass, the premature recursive mark causes false rejections in
mark_recursive_subprogs() (for BPF_PROG_TYPE_EXT), in analyze_subprog() (wh=
en
passing stack pointers between the subprogs), and in check_recursion_guard()
(which injects a synthetic R0 =3D 0 early exit at subprog entry).

Can mark_recursive_subprogs() and build_call_graph() use a consistent analy=
sis
for async callbacks so valid programs with timers, workqueues, or RCU
callbacks are not rejected?

[ ... ]
> @@ -22021,6 +22207,21 @@ static int flow_drain(struct bpf_verifier_env *e=
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
As reported by Sashiko on v2 [4], in bpf_insert_recursion_checks(), the
runtime recursion check is inserted before si[s].start via
bpf_patch_list_insert(), so only calls enter the check while intra-subprogr=
am
jumps to si[s].start land after the check.

However, in do_check_block(), check_recursion_guard() calls push_budget_exi=
t()
every time env->insn_idx =3D=3D sub->start, without checking whether the st=
ate
just entered the subprogram or arrived via an intra-subprogram loop back-ed=
ge
to sub->start.

If a recursive subprogram has a loop header at sub->start and holds a
reference, spinlock, RCU lock, or IRQ state across the back-edge to sub->st=
art
that is released later in the loop or after the loop exits, won't
check_recursion_guard() push a spurious exit branch with those resources st=
ill
held and cause verification to fail?

[1] https://lore.kernel.org/r/b77dd21709ea9d7691f0ffeb58635a660aef73738c24b=
1c059a01a1da42d5af4@mail.kernel.org
[2] https://lore.kernel.org/r/20261105204513.2230344-23-alexei.starovoitov@=
gmail.com
[3] https://lore.kernel.org/r/20261105204513.2230344-23-alexei.starovoitov@=
gmail.com
[4] https://lore.kernel.org/r/20261105204513.2230344-23-alexei.starovoitov@=
gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D22
