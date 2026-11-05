Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915503;
	b=kYSW0A0bnhgMm6ktn0rqpTYWBGrtcgxhSyfuIR091U/r5FzGM28jpDsVwKhK96pEVW45
	 Lr+nw2porpUXB4kKKuKcmpOgyUBXnSWVJ6YNhWNyUouQI4Xs6mDFi1wN00b6kT1U+uZ8R
	 9CaufZGvUNOCOJa3oDuUeZk83cuw20obFxCwgbOmNYBbZAZIstzUFEUUMTI3fN2AAnmMx
	 bgeJEby/jp1pMQkZWiTce23fVkXjfDxRWtaoGcFj8lM455s2I4goKvLmJuJuoCubPNVi+
	 TOaomnzx6JvhwdsX7zi0nuyEdsdHrExoXfXN+A0fqdz2FYMXcd4BBv0EO89Jbh09PVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915503;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=+K9aqu8CSFx8MpCV+bqVodrEJ5RfnkX1Exp+Aw73UE8=;
	b=uWF+nHV7IpI2NUnRuXGwObf+HJUSaCKfc5AsQWbUAc3iIULQwd3B1qkzZlxJvwgHf29m
	 p/OY1iAh29Prn/4AwS9E5PsCDsP+S88+uuc0YZUNX1rn8EzX7dlNKdDRaAQbsd6V5YxzK
	 j8/vw4Uoc1sT6qCGbqu3yzyFiBHPX5phElCkJCNV35d5gjKbHmdFTD0qD4MifyNVJv6v2
	 owtbswFNA70WjveqWLiw0KrIp3d6ncUpUdTGUkr+F6U9HmHAP7avNWf18QjxGg3V21Uzq
	 tzJ89LZcrxcCOaBYDuf/TWgRu57NIaOqPCELXsEgXcRxaSKAPKT+qaoCOy14D4kBm7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/Ako2lk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB4606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/Ako2lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170D1F0089F;
	Thu,  5 Nov 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915502;
	bh=+K9aqu8CSFx8MpCV+bqVodrEJ5RfnkX1Exp+Aw73UE8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S/Ako2lkL3u6RPCQvMykqYis2fQ14DLSIYqKsS2dZo6RT3JlqfyTV/QCXw1lcZ8vm
	 TWIcRJtJIXxVDqNUovl9WmoRa+id7gNX1jgCqHaYGuGsSWf7NYQyyWQ2HCgrQm6+T3
	 WRloTSpkArLwcA/Y9DZ57GzOWLlRvKwKHRjIKsDz77y2+4JeGCYRcZVI86YOp4+JyQ
	 LeFsFBGpKInxf16M/dGK4yX1jqMMwfoND9pk3migUoo0RBUQpYQG3KKWDoy3i27WAK
	 GHbT9+KZ5FnnTo18GZYuMhh/sU4DKP2VohLBA2nOibPUAFGbffI8R8CAdm0HFuPHXg
	 6MjrqKLeNLI3g==
Content-Type: multipart/mixed; boundary="===============5323785928805555811=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b77dd21709ea9d7691f0ffeb58635a660aef73738c24b1c059a01a1da42d5af4@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-23-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-23-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 22/35] bpf: Allow recursive subprogs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:51:42 +0000 (UTC)

--===============5323785928805555811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow recursive subprogs

TL;DR:
- Possible regression: over-approximated callx recursion marks may reject
  previously accepted non-recursive programs at load
- Stale marks on non-live subprogs may wrongly enable recursion checks and
  fail loads
- Stack depth is possibly not rechecked after frame bump (no overflow found)

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2408,6 +2415,17 @@ static int analyze_subprog(struct bpf_verifier_env *env,
>  		if (!has_fp_args(callee_args))
>  			continue;
>
> +		/*
> +		 * at_in[] is kept per subprog and the snapshot of the stack per call insn:
> +		 * the walk must not enter a subprog that it has not left.
> +		 */
> +		if (env->subprog_info[subprog].recursive && env->subprog_info[callee].recursive) {
> +			verbose(env, "recursive %s() passes a pointer to the stack to %s()\n",
> +				bpf_subprog_name(env, subprog), bpf_subprog_name(env, callee));
> +			err = -EINVAL;
> +			goto out_free;
> +		}

Can this reject programs that have no recursion and that were accepted
before?

analyze_subprog() runs from bpf_check() -> bpf_compute_live_registers() ->
bpf_compute_subprog_arg_access(), before the main pass.  At that point
subprog_info[].recursive is only the over-approximated mark from
mark_recursive_subprogs(), which gives every subprog that contains a callx
an edge to every subprog whose address is taken:

    for_each_set_bit(s, callx, cnt)
        bitmap_or(calls + s * words, calls + s * words, taken, cnt);

check_recursion() clears unconfirmed marks only after the main pass, so
this check sees marks that are later dropped.

For example:

    static __noinline int leaf(int x) { return x + 1; }
    static __noinline int helper(int *p) { int (*f)(int) = leaf; *p = f(*p); return 0; }
    static int cb(u32 i, void *ctx) { int v = i; helper(&v); return 0; }
    SEC("tc") int prog(void *c) { bpf_loop(10, cb, NULL, 0); return 0; }

Here taken = {cb, leaf} and helper contains a callx, so helper -> cb is
added.  With cb -> helper that is a cycle, and both get recursive = true.
analyze_subprog(cb) then sees a frame pointer argument for helper and fails
the load with "recursive cb() passes a pointer to the stack to helper()",
although the main pass would only find helper -> leaf for that callx.

The commit message lists only a pointer to the stack passed "between
recursive subprogs" as still rejected.  Could this check be limited to marks
that check_recursion() confirms, or skip the callx-to-taken edges that the
main pass has not seen yet?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

>  static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
>  {
>  	int j, s;
>
>  	for_each_set_bit(s, cg->live, cg->cnt) {
> -		if (!test_bit(s, subprog_reach(cg, s)))
> +		if (!test_bit(s, subprog_reach(cg, s))) {
> +			env->subprog_info[s].recursive = false;
>  			continue;
> +		}

[ ... ]

The commit message says "A mark that it does not confirm is dropped, and the
subprog gets no check", and the comment above check_recursion() says such a
subprog "needs no check".  Is that true for subprogs that are not in
cg->live?

This loop walks only cg->live.  A subprog that mark_recursive_subprogs()
marked through its over-approximated callx edges, but that no live subprog
calls, keeps recursive == true.  For example, g can be reached through a
read-only function table that is visited by check_cfg(), while the callx in
main resolves only to f.  g has a callx, so g -> {f, g} is added and g is
marked, but the main pass never calls g.

bpf_insert_recursion_checks() in kernel/bpf/fixups.c walks every subprog:

	for (s = 1; s < env->subprog_cnt; s++) {
		if (!si[s].recursive)
			continue;
		found = true;
		arena_frame = max(arena_frame, si[s].arena_stack_depth);
	}
	...
	env->prog->jit_required = 1;

So the stale mark sets jit_required, inserts the stack check and may_goto
into g, and adds g's arena frame to arena_frame.  That shrinks room for the
live recursive subprogs and can fail the load with "no room in the stack in
arena for recursion".  Such a program had no recursion handling before this
patch.

Could the recursive flag be cleared for every subprog that is not in
cg->live, for example with a loop over 0..cg->cnt?

[ ... ]

>  static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg,
>  			       struct bpf_subprog_call_depth_info *dinfo)

[ ... ]

> +				depth = dinfo[s].depth;
> +				arena_depth = dinfo[s].arena_depth;
> +				if (!si[s].recursive || !si[j].recursive) {
> +					depth += subprog_stack_size(env, s);
> +					arena_depth += si[s].arena_stack_depth;
> +				}

A subsystem pattern flags this as potentially concerning: a rewrite pass that
adds to stack_depth after check_max_stack_depth() has run is unsafe when the
program is JITed and the amount added is not a small constant per subprog,
since the rechecks against MAX_BPF_STACK in bpf_do_misc_fixups() and
bpf_patch_call_args() run only for programs that are not JITed.

On an edge from a recursive s to a non-recursive j, subprog_stack_size(env, s)
is si[s].stack_depth as the main pass left it.  This patch keeps
si[s].recursive set for confirmed recursion, so bpf_insert_recursion_checks()
now runs on real programs, after check_max_stack_depth(), and does:

	frame = DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room);
	if (frame > env->stack_limit) { ... return -EACCES; }
	si[s].stack_depth = max(si[s].stack_depth, frame);

The bump can be up to env->stack_limit, and nothing checks the chain of s and
its non-recursive callees again with the new frame of s.  env->max_stack_depth
no longer holds either.

The analysis of this case did not show an actual overflow: the bumped frame
plus the old chain limit stays within about 2 * stack_limit, and the lower
half of THREAD_SIZE that emit_stack_check() keeps free appears to have room
for that.  The comment above bpf_insert_recursion_checks() says the lower half
holds "a chain of calls that check_max_stack_depth() looked at together with
that frame", but that is not the frame size check_max_stack_depth() used.  Is
the chain limit meant to be rechecked with the bumped frame?

[ ... ]

> +static int mark_recursive_subprogs(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	for_each_set_bit(s, callx, cnt)
> +		bitmap_or(calls + s * words, calls + s * words, taken, cnt);

[ ... ]

> +		/*
> +		 * Each call of the function that it replaces is an invocation of its own: a
> +		 * loop in the prog that it extends gets a new time slice each time.
> +		 */
> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
> +			verbose(env, "recursive %s() in an extension\n", bpf_subprog_name(env, s));
> +			break;
> +		}

[ ... ]

> +		if (si[s].has_tail_call || si[s].has_ld_abs) {
> +			verbose(env, "recursive %s() cannot have %s\n", bpf_subprog_name(env, s),
> +				si[s].has_tail_call ? "tail calls" : "LD_ABS");
> +			break;
> +		}
> +		if (si[s].bail_insn < 0) {
> +			verbose(env, "recursive %s() has no exit\n", bpf_subprog_name(env, s));
> +			break;
> +		}

Can these rejections fire for programs with no recursion that loaded before?

A subprog that contains callx and whose own address is taken (a bpf_loop()
callback, a function table entry, a vtable method making a dyn call) is on a
cycle in this pre-pass graph, even when its callx can only reach other
functions.  The same holds for every taken subprog that reaches such a callx
subprog.  All of them get marked, and the checks above act on the mark before
check_recursion() can drop it.

Example with an extension:

    static int leaf(void) { return 1; }
    static long cb(u32 i, void *ctx) { int (*f)(void) = leaf; return f(); } /* callx */
    SEC("freplace/x") int ext(void *ctx) { bpf_loop(1, cb, NULL, 0); return 0; }

taken = {leaf, cb} and cb has callx, so cb -> cb in the pre-pass graph, and
the load fails with "recursive cb() in an extension".  The main pass would
have recorded only cb -> leaf.

Example without an extension, with read-only tables T1 = {h} and
T2 = {x, y}: main calls T1[0] with callx, h calls helper(1, &local), and
helper calls T2[i & 1] with callx.  helper -> taken includes h, so both are
marked and liveness rejects with "recursive h() passes a pointer to the stack
to helper()".

The old code accepted both programs: the pre-pass sort_subprogs_topo()
ignored callx, and the later sort and check_recursion() used only the callx
edges the main pass recorded.

The rationale in the extension comment applies only when run time checks are
inserted, but bpf_insert_recursion_checks() inserts none once
check_recursion() has cleared the mark.  A mark also makes the main pass
verify a return of 0 from the subprog entry via check_recursion_guard() and
widen its entry states, and none of that is undone when the mark is dropped.

The comment above the function ("A subprog that is marked for no reason is
treated like a recursive one all the same") admits false marks, while the
commit message lists only real recursion under "Still rejected".  Could the
prog type, tail call, LD_ABS and no-exit rejections act only on marks that
check_recursion() confirms, and could the callx-to-taken edges be left out
until the main pass has seen them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============5323785928805555811==--
