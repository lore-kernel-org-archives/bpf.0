Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792988723;
	b=SxfWBR4/Ai7226YqzgqN5iGDXBJHN7dqlY3dnz2uLutg/8ONQjDKgWc1hGsbVTrSbd0O
	 uGHQXnlHw6jkSeUgOYCs9Rt9j1BtKpxNatoR6j9VTG7XlF6/kfAkO7FQ9GMXEs0xRfdas
	 9C/ECD4yzdnvjAa6AY+5PPzbSY0qcE+XsZB5mOK1RYA6M+516FebcCCLFvD5+/DKHWiuG
	 ASuP/8j+GKspwBQwCT2Snmn2nieLvutfGq0TJiL7Qsn7i0svNMaW/ud5spozcRlhjyIE3
	 SjiPM+LKxtJin6VRZdKA+neDGf+uEZd36LoDrcyxsSkrs6X49zSO6PBLB3Q+lpzDM/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988723;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=+poMcIo8gjQfR8cs5DVRxRLuX+wq1E8ZM8DrlFesUtA=;
	b=hMhdB9OawZFWV4/S46rXTgKcNI0TRcrceJ7s4RCzn/s4wldulw4NNxlErIhSLLDiwBuY
	 yGtMjLFsyjZ4niVZ6dAjlCBpGk/XrRiSYmImerjx8oXANuqu0XbYFp97TPfGboKvIVDT7
	 HXs8u2znI2VGWeTMn3E9eLFKd6x8IU4mgIydksk3krQxqzMbyCkqfXMr1KUuzVUFSTlIj
	 JJK84gAgC0BJ73zhQgetbs5/2AN3nzfwCNy4I2FM7uK/5YHfrLDwo6mriVqerVIE8p8q5
	 D3xo7tZ4i7E49mIg8OmLYjKBr3bly2I+FzeKQiILvZyDBE6rlv5mhuvfhx9lH/MMV3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4fvyhAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD14606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4fvyhAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42641F01825;
	Mon, 26 Oct 2026 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792988722;
	bh=+poMcIo8gjQfR8cs5DVRxRLuX+wq1E8ZM8DrlFesUtA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m4fvyhAAq/hbTxAXmVK2d3vzb6F1OjQOkSL9DgzbKmd+pi9VVc+W6JCJhLTplVhif
	 Bzt1jVVpmYbifXmXyQTL3NhsHlGT9++JXZnQTxXu//tFp/m6e2AK8OHxOiwjEzs9Ni
	 83aFAAQMCP8e4HU04I1j2yhLgF5kqy+KAiOqjlKNzUVy9O0Mf8yBDrA5k10bCToYoz
	 NiCF4ollEyGDv+M19vcNAU4dYnIQRM3ghTtJlSYsHETVpOVgaqZ0ilEzK0Fu2kPeS5
	 xXtnwgxBCyjEQGONqRW0cyRXodbgGs79FmF0bUeKL4GfHq4F9+uFFzbmbv7FOQbgDC
	 LUsJo8j+hjkPw==
Content-Type: multipart/mixed; boundary="===============0733389674210141719=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <52ac647e6d0ca847e4ab00accac41e64d255d57d3245479e5c87d74dfc10064a@mail.kernel.org>
In-Reply-To: <20261026025943.404450-54-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-54-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 53/81] bpf: Verify programs as a fixpoint over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 04:25:21 +0000 (UTC)

--===============0733389674210141719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify programs as a fixpoint over the control flow graph

TL;DR:
- Tail calls below recursive subprogs may overflow the kernel stack or skip
  tail-call counter setup, causing wild pointer access
- Possible stack-arg, lock and RCU-context tracking holes in subprogs verified
  on their own
- Some valid programs may now be rejected

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a9628f5045fe..0c1de0f24b85 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -4598,6 +4601,23 @@ static int check_stack_write(struct bpf_verifier_env *env,
>  	return err;
>  }
>
> +/*
> + * The function that is verified on its own has no caller to look at. Its incoming
> + * arguments are in its stack_arg_regs until it is done with loading them.
> + */
> +static void end_stack_arg_loads(struct bpf_verifier_env *env, struct bpf_func_state *state)
> +{
> +	int i;
> +
> +	if (state->no_stack_arg_load)
> +		return;
> +	state->no_stack_arg_load = true;
> +	if (state->frameno)
> +		return;
> +	for (i = 0; i < state->out_stack_arg_cnt; i++)
> +		bpf_mark_reg_not_init(env, &state->stack_arg_regs[i]);
> +}

Can an unwritten incoming stack arg survive as an outgoing one after a join?

For frame 0 of a static subprog that is verified on its own,
stack_arg_regs[0..in_stack_arg_cnt) hold the incoming stack args.
end_stack_arg_loads() wipes them on the first r11 store or the first call
insn, but only for the state that executes it.

That step is not applied when states are compared or joined.  In
func_states_equal():

    if (!old->no_stack_arg_load && cur->no_stack_arg_load)
            return false;

only rejects the case where the old state has the flag clear.  An old state
that already stored an outgoing value V in slot 0 (flag set) therefore covers
a current state whose slot 0 still holds the unwritten incoming arg A,
whenever the range of V contains A.  In join_func():

    fd->no_stack_arg_load = fa->no_stack_arg_load || fb->no_stack_arg_load;

the two slots are joined with join_reg() and the flag is ORed, so at the next
call insn end_stack_arg_loads() returns at once and the joined slot is never
invalidated.

Example, with F a static subprog with one incoming stack arg that is verified
on its own, and G a callee with one stack arg:

    F:  r0 = *(u64 *)(r11 + 8)
        if r1 == 0 goto L1
        *(u64 *)(r11 - 8) = r0
    L1: r1..r5 = 0
        call G
        exit

Verified alone, the path with r1 == 0 is rejected with 'callee expects 6 args,
stack arg1 is not initialized'.  When the two states meet at L1 and one covers
or joins the other, the call is verified once with slot 0 as a scalar and that
path is accepted.

At run time on that path the outgoing area of the frame of F is uninitialized
stack memory, but G is verified assuming arg6 is in the joined range.  A
pointer type with joinable fixed parts (PTR_TO_MAP_VALUE or PTR_TO_CTX in both
slots) is accepted the same way, so an unwritten, possibly attacker controlled
stack word can be passed as a typed argument.  This needs a JIT with stack arg
support (x86-64) and a static subprog whose code loads r11+off.

Before this patch frame 0 had no incoming stack args, stack_arg_regs was
outgoing only, and joining 'written' with 'unwritten' gave NOT_INIT.

Should func_states_equal() treat a frame 0 pair with differing
no_stack_arg_load (and in_stack_arg_cnt > 0) as incomparable, and join_func()
refuse to join it?  Alternatively the end_stack_arg_loads() wipe could be
applied to the side whose flag is clear before comparing or joining.  I did
not find a later patch in the series that touches no_stack_arg_load.

[ ... ]

> @@ -5930,17 +5958,37 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		 * The main verification pass limits the depth of the recursion,
>  		 * but it doesn't follow calls of global functions.
>  		 */

Is this comment still accurate?

It explained the -EINVAL that this loop used to return for a subprog that is
already on the chain.  The loop now accepts the cycle instead ("Recursion.
How deep it goes is not known here.  It's counted at run time.").

sort_subprogs_topo() now tolerates every cycle, not only the ones that go
through the address of a function.  And "The main verification pass limits the
depth of the recursion" does not hold for a subprog that
mark_recursive_subprogs() marked: such a subprog is verified on its own, and
its depth is limited by the check at its entry at run time
(bpf_insert_recursion_checks()).

A reader who relies on the comment will think that the case is rejected or
bounded by the main pass.  Could the comment describe the new behaviour, or be
dropped?

> -		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
> -			if (tmp != sidx)
> +		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
> +			if (tmp == sidx)
> +				break;
> +		/*
> +		 * Recursion. How deep it goes is not known here. It's counted
> +		 * at run time.
> +		 */
> +		if (tmp >= 0) {
> +			if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
> +				i--;
> +			continue;
> +		}

Can this cut leave a subprog on a cycle without tail_call_reachable?

Before this patch a call edge whose target was already on the chain was an
error, so every subprog that could reach a tail call was on a walked chain.
Now the edge is cut and the walk goes on.  The DFS visits a member of a cycle
only below the member where it entered the cycle, so a member whose only way
to the tail call goes through the cut edge is never marked.  The marking is
done only for the subprogs on the chain from the root to the subprog that has
the tail call:

    for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
            ...
            subprog[tmp].tail_call_reachable = true;

Call graph: main calls Q only.  Q calls P and then T.  P calls Q.  T contains
bpf_tail_call().  mark_recursive_subprogs() marks P and Q recursive and does
not reject them: it rejects a tail call only inside the recursive subprog
itself, and T is not on the cycle.

The walk goes main -> Q -> P.  The call P -> Q is on the chain and is cut, so
P is left without a mark.  Then Q -> T marks T, Q and main.  The result is
P.tail_call_reachable == false although P -> Q -> T is a run time path.

On x86-64 a call to a subprog loads the pointer to the tail call counter into
rax only if the caller is tail_call_reachable (arch/x86/net/bpf_jit_comp.c,
"if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable)").  A
tail_call_reachable subprog saves rax as that pointer in its prologue
(emit_prologue_tail_call(), is_subprog case).  Here P calls Q without loading
it, so Q saves whatever P left in rax (BPF R0).  T then does 'cmp qword ptr
[rax], MAX_TAIL_CALL_CNT' and 'add qword ptr [rax], 1' on the pointer it
reloads from the frame of Q.  That is a read and an increment through a value
that the verifier never constrained.

The combination was impossible before this patch because sort_subprogs_topo()
rejected every cycle.  recursive_frame_size() in fixups.c reserves room for
tail_call_reachable in the frame of a recursive subprog, so the combination
looks meant to load.

Should every subprog from which a tail call is reachable be marked
(transitively, so all members of a cycle that reaches T), or should tail calls
below recursive subprogs be rejected?  I did not find a later patch in the
series that changes this.

> +		/*
> +		 * Any recursive subprog may follow any other when they call each other
> +		 * through pointers. Don't walk all such chains: what is called from
> +		 * here was looked at with at least as much on the stack.
> +		 */
> +		if (subprog[sidx].recursive) {
> +			bool cb = subprog[sidx].is_cb;
> +
> +			for (tmp = idx; tmp >= 0 && !cb; tmp = dinfo[tmp].caller)
> +				cb = subprog[tmp].is_cb;
> +			if (depth < dinfo[sidx].seen_depth[cb] &&
> +			    arena_depth < dinfo[sidx].seen_arena_depth[cb]) {
> +				if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
> +					i--;
>  				continue;
> -			verbose(env, "recursive call from %s() to %s()\n",
> -				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
> -			bpf_diag_program_structure(
> -				env, i, "recursive subprogram call",
> -				"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
> -				"This call or callback would make the subprogram call graph recursive. "
> -				"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
> -			return -EINVAL;
> +			}
> +			dinfo[sidx].seen_depth[cb] = max(dinfo[sidx].seen_depth[cb], depth + 1);
> +			dinfo[sidx].seen_arena_depth[cb] = max(dinfo[sidx].seen_arena_depth[cb],
> +							       arena_depth + 1);
>  		}

Does this skip also drop effects that depend on the chain and not only on the
depth?

The comment says "what is called from here was looked at with at least as much
on the stack".  That holds for the summed stack depth.  The walk computes more
than that:

- tail_call_reachable is set for each subprog on the chain that leads to a
  tail call
- the checks at the tail call (stack args, via_callx, is_cb) look at the
  chain
- uses_arena_sp sets arena_stack_entry on the nearest callback of the chain

A second chain that reaches the recursive subprog with the same or less stack
skips all of it.

Call graph, for tail_call_reachable only: main calls X and then Y.  X and Y
have the same stack depth (for example both 0).  Both call rec.  rec is
recursive (it calls itself) and calls T.  T has bpf_tail_call().

The walk of main -> X -> rec sets seen_depth[0] of rec and walks T, so T, rec,
X and main become tail_call_reachable.  In the walk of main -> Y -> rec the
test

    depth < dinfo[sidx].seen_depth[cb] &&
    arena_depth < dinfo[sidx].seen_arena_depth[cb]

is true, so the walk takes the continue.  Y is never marked, although Y -> rec
-> T is a run time path.  Which of X and Y is skipped depends only on the
order of the calls in main, and a chain with less stack is skipped as well.

The JIT then compiles Y without tail call counter handling: on x86-64 a call
from an unmarked caller does not load the counter pointer into rax, and rec
(marked) saves rax in its prologue as that pointer.  The tail call in T
dereferences it, so the value is whatever Y left in R0 at the call (see the
previous comment for the JIT side).

The same skip leaves the nearest callback of a second chain without
arena_stack_entry when a subprog below rec uses the stack in arena.  That
callback is then not given its stack in arena by bpf_insert_arena_stack()
although code below it uses it.

The old code walked every chain and rejected every cycle.  The skip is new in
this patch, and it is needed so that the walk does not take exponential time,
but should it keep the effects that depend on the chain?  For example the
chain of the skipped walk could be marked with the flags that the first walk
found below rec, by remembering whether a tail call was reachable below rec.
I did not find a later patch in the series that changes the skip.

[ ... ]

> @@ -5959,7 +6007,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		/* sync tail_call_reachable with callee state on entry */
>  		tail_call_reachable = subprog[idx].has_tail_call;
>
> -		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
> +		if (bpf_subprog_is_global(env, idx))
> +			frame = 0;
> +		else if (!subprog[idx].recursive)
> +			frame++;
>  		if (frame >= MAX_CALL_FRAMES) {

Does the skip of a recursive subprog above also need to compare 'frame'?

It compares only depth and arena_depth.  Zero stack frames add nothing to
depth, so chains of different lengths can have the same depth, and the chain
with more frames is skipped.

Example: main calls rec first and then P1.  rec is recursive and calls Q1;
Q1..Q14 call each other in a line (each has stack depth 0).  P1..P14 are a
second line of calls that ends with a call of rec.

First walk: main -> rec -> Q1..Q14 reaches frame 14, which is below
MAX_CALL_FRAMES (16 in this tree).  Second walk: main -> P1..P14 -> rec, frame
is 14 at rec and depth is equal, so rec is skipped.  The checked chains are 14
frames each, but the chain P1..P14, rec, Q1..Q14 has 29 native frames at run
time.  The test 'if (frame >= MAX_CALL_FRAMES)' would have rejected that chain
before this patch.

Nothing else seems to limit it.  The main pass does not follow it:
func_is_on_its_own() lets each of these static subprogs be verified on its
own, so the frames of the callers are not in the state and setup_func_entry()
does not see them.  Recursive frames are bounded at run time by
BPF_RECURSION_STACK, but the weight of a recursive frame is its own frame
only, not the non-recursive frames between two recursive ones.  With several
recursive subprogs in a row the skip can be used at each one, so the number of
native frames grows with the number of subprogs (BPF_MAX_SUBPROGS) and not
with MAX_CALL_FRAMES.  The JIT frames of zero-stack subprogs are not counted
anywhere (round_up_stack_depth() is 0 for them with the JIT), so this is the
only bound on kernel stack use of such chains.

A chain through global subprogs is not bounded by MAX_CALL_FRAMES either
(frame restarts at 0), so the bound on static chains is the only one that is
left for the common case, and the patch removes it for chains that pass a
recursive subprog.  Later commits in the series raise MAX_CALL_FRAMES to 32
and BPF_MAX_SUBPROGS to 1024, which makes it worse; I did not find a change to
the skip.

Should 'frame' be part of what the skip compares?

[ ... ]

> @@ -6022,6 +6074,111 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	goto continue_func;
>  }
>
> +/*
> + * Find the subprogs on cycles of the call graph. It is not known yet what callx
> + * calls: it may be any subprog whose address is taken. A subprog that is
> + * marked for no reason counts its frames for no reason, that is all.
> + */
> +static int mark_recursive_subprogs(struct bpf_verifier_env *env)

[ ... ]

> +			if (bpf_pseudo_call(&insn[i]) || bpf_pseudo_func(&insn[i])) {
> +				j = bpf_find_subprog(env, i + insn[i].imm + 1);
> +				if (j < 0)
> +					continue;
> +				/* the helper that calls a callback doesn't expect it to unwind */
> +				if (bpf_pseudo_func(&insn[i]) || !bpf_is_unwind_goto(&insn[i + 1]))
> +					si[j].plain_call = true;
> +				/* the helper that takes a callback calls it */
> +				__set_bit(j, calls + s * words);
> +				if (bpf_pseudo_func(&insn[i]))
> +					__set_bit(j, taken);
> +			}

[ ... ]

> +	for (s = 0; s < cnt; s++) {
> +		if (!test_bit(s, calls + s * words))
> +			continue;
> +		err = -EINVAL;
> +		if (!s) {
> +			verbose(env, "recursive call of the main program\n");
> +			break;
> +		}
> +		/* it has no way to tell one run from another, see bpf_prog_begin_run() */
> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
> +			verbose(env, "recursive %s() in an extension\n", bpf_subprog_name(env, s));
> +			break;
> +		}
> +		if (si[s].has_tail_call || si[s].has_ld_abs) {
> +			verbose(env, "recursive %s() cannot have %s\n", bpf_subprog_name(env, s),
> +				si[s].has_tail_call ? "tail calls" : "LD_ABS");
> +			break;
> +		}
> +		if (!bpf_jit_supports_percpu_insn()) {
> +			verbose(env, "JIT does not support recursive calls\n");
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +		if (si[s].bail_insn < 0) {
> +			verbose(env, "recursive %s() has no exit\n", bpf_subprog_name(env, s));
> +			break;
> +		}
> +		si[s].recursive = true;
> +		err = 0;
> +	}
> +	kvfree(calls);
> +	return err;
> +}

Can an async callback that re-arms itself be rejected here?

Every BPF_PSEUDO_FUNC reference becomes a call edge s -> j, including
references whose target is an async callback (bpf_timer_set_callback(),
bpf_wq_set_callback(), task work).  An async callback does not run on the
stack of the function that registered it, and check_max_stack_depth_subprog()
deliberately skips it (the 'subprog[sidx].is_async_cb ... continue' branch),
but this function has no such exception.

A callback that re-arms itself, directly or through a helper subprog, is put
on a cycle and gets si[s].recursive = true.  For callx the edges are
over-approximated the same way: every subprog with callx 'calls' every
address-taken subprog, itself included.

The comment says that a subprog marked this way "counts its frames for no
reason, that is all", but the loop above rejects recursive subprogs:

- it fails with -EOPNOTSUPP ("JIT does not support recursive calls") when
  !bpf_jit_supports_percpu_insn() (only x86, arm64, powerpc, riscv and
  loongarch define it; s390x, mips and others do not)
- it fails with -EINVAL for BPF_PROG_TYPE_EXT, for has_tail_call/has_ld_abs,
  and for a subprog without an exit insn

Such programs loaded before this patch, because sort_subprogs_topo() tolerated
pseudo_func cycles and the stack walk skipped async callbacks.  The existing
selftest timer.c (loop_cb() -> rearm() -> bpf_timer_set_callback(...,
loop_cb)) is an example: loop_cb and rearm are marked recursive, so on a JIT
without percpu insn support the whole 'timer' skeleton fails to load with
EOPNOTSUPP (prog_tests/timer.c turns that into a skip, which hides it), and it
would be rejected for a freplace program.

Should async callbacks not add edges to 'calls' (they are separate roots for
the budget), or should the rejection conditions apply only to subprogs that
are on a cycle of synchronous calls?

[ ... ]

> @@ -6035,14 +6192,15 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>  		return -ENOMEM;
>
>  	for (int i = 0; i < env->subprog_cnt; i++) {
> -		if (si[i].has_tail_call) {
> -			/* the stack in arena wouldn't be returned */
> -			if (env->uses_arena_sp) {
> -				verbose(env, "tail_calls are not allowed in programs that use R%d\n",
> -					BPF_REG_ARENA_SP);
> -				kvfree(dinfo);
> -				return -EINVAL;
> -			}
> +		/* the stack in arena wouldn't be returned */
> +		if (si[i].has_tail_call && env->uses_arena_sp) {
> +			verbose(env, "tail_calls are not allowed in programs that use R%d\n",
> +				BPF_REG_ARENA_SP);
> +			kvfree(dinfo);
> +			return -EINVAL;
> +		}
> +		/* the private stack has room for one frame of a subprog */
> +		if (si[i].has_tail_call || si[i].recursive) {
>  			priv_stack_mode = NO_PRIV_STACK;
>  			break;
>  		}

Can a program with both a tail call and a recursive subprog overflow the
kernel stack?

check_max_stack_depth() now accepts such a program.  The only change it makes
is to turn off the private stack.  The one bound on the stack at a tail call
is still the 256 byte check in check_max_stack_depth_subprog():

    if (idx && subprog[idx].has_tail_call && depth >= 256) {

That walk never adds the frames of recursive subprogs to depth:

    if (!subprog[idx].recursive)
            depth += subprog_depth;

Those frames are counted at run time instead.  bpf_insert_recursion_checks()
lets them use up to BPF_RECURSION_STACK (4096) bytes for each program.
mark_recursive_subprogs() rejects a tail call only inside the recursive
subprog itself, and recursive_frame_size() even reserves room for
tail_call_reachable, so a tail call reached from a recursive subprog looks
meant to be supported.

Example: main() -> rec() (recursive, about 4 KB deep at run time) -> t() ->
bpf_tail_call().  The verifier sees only the frames of main() at t(), which is
well below 256, and accepts the program.  A tail call removes only the frame
of t().  The frames of main() and of the whole recursion stay on the kernel
stack while the next program runs, which is the reason for the 256 limit.

Each program has its own percpu recursion counter (prog->aux->call_depth), so
a chain of tail calls through programs built this way adds about 4.3 KB per
program, up to MAX_TAIL_CALL_CNT times.  Two programs that tail call each
other already exceed 16 KB (2 * 4096 + 33 * 256).  That overflows the kernel
stack and hits the guard page, or corrupts memory without VMAP_STACK.  The old
analysis (32 * 256 = 8 KB at worst) assumed that every frame below a tail call
is counted in depth.

Before this patch sort_subprogs_topo() rejected recursion, so this combination
could not occur.  Should the tail call check account for the run time budget
of recursive frames, or should tail calls below a recursive subprog be
rejected?  I did not find a later patch in the series that changes this.

Also in this loop: does the new break on a recursive subprog skip the
BPF_REG_ARENA_SP check for later subprogs?

The loop now stops at the first subprog that is recursive, not only at the
first one that has a tail call.  The check

    if (si[i].has_tail_call && env->uses_arena_sp)

runs only for the subprogs that the loop visits before the break.  Before the
patch the loop stopped only at a subprog with has_tail_call, so the check
always ran for the first tail-calling subprog, and since env->uses_arena_sp is
program-wide that was enough.

Take a program with an arena stack where subprog 1 is recursive and subprog 2
does bpf_tail_call().  At i == 1 the arena check does not fire (no tail call
there), then 'si[1].recursive' breaks the loop.  Subprog 2 is never examined,
so "tail_calls are not allowed in programs that use R%d" is never printed.  No
other check catches this: mark_recursive_subprogs() rejects tail calls only in
the recursive subprog itself, and check_max_stack_depth_subprog() and
bpf_insert_arena_stack() have no tail call/arena check.

The program loads.  Per the comments in fixups.c and arena.c, the main program
takes a stack in arena when it starts and returns it at exit.  A tail call
skips that exit, so the per-cpu arena stack (cpu->busy / stacks->busy) stays
taken.  Later runs on that cpu fall back to bpf_arena_stack_get() and leak
slots, until the program no longer runs on that cpu.

Could the arena check be done in a separate loop, or could the loop avoid
breaking before every subprog is checked?

[ ... ]

> @@ -8962,12 +9120,33 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
>   *     }
>   *     bpf_iter_num_destroy(&it);
>   */
> +/*
> + * The program asks for the next element after it was told that there is none. So it didn't
> + * leave the loops around the call, and the iterator is not what stops them.
> + */
> +static int iter_is_drained(struct bpf_verifier_env *env, int insn_idx)
> +{
> +	struct bpf_loop *loop;
> +	int h;
> +
> +	for (h = bpf_loop_at_index(env, insn_idx); h >= 0; h = env->insn_aux_data[h].loop_header) {
> +		loop = env->insn_aux_data[h].loop;
> +		if (!loop->rt_bounded)
> +			continue;
> +		loop->rt_bounded = false;
> +		env->restart = true;
> +	}
> +	return env->restart ? -EINVAL : 0;
> +}
> +
>  static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,

This isn't a bug, but is iter_is_drained() placed where the comment of
process_iter_next_call() should be?

iter_is_drained() is inserted between the long block comment that describes
process_iter_next_call() (the "Besides that, we also fork current state and
enqueue it ..." text and the DRAINED/ACTIVE state machine) and
process_iter_next_call() itself.  The documentation now sits above an
unrelated helper that has a comment block of its own, and
process_iter_next_call() is left without the comment that explains it.

Could the helper be placed above that block, or the block moved down?  The
placement is kept in the last commit of the series, so it is not fixed later.

[ ... ]

> @@ -11523,13 +11709,362 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins

[ ... ]

> +int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
> +		    const struct bpf_verifier_state *exit, int call_idx)
> +{

[ ... ]

> +	/* What is taken is added at the end. What is released leaves no hole. */
> +	for (i = 0; i < nheld && i < caller->acquired_refs; i++) {
> +		id = held[i].id ? BPF_INHERITED_ID + i : 0;
> +		if (caller->refs[i].id != id || caller->refs[i].type != held[i].type)
> +			break;
> +		caller->refs[i] = held[i];
> +		kept++;
> +	}
> +	kfree(held);
> +	/* What it means for the caller is found out in the context of the caller. */
> +	if (kept != nheld || exit->active_rcu_locks < caller_rcu ||
> +	    exit->active_preempt_locks < caller_preempt) {
> +		if (env->log.level & BPF_LOG_LEVEL2)
> +			verbose(env, "func#%d releases what its caller holds at insn %d\n",
> +				callee->subprogno, call_idx);
> +		env->subprog_info[callee->subprogno].releases_inherited = true;
> +		return 1;
> +	}

In bpf_flow_return(), can this loop mistake a different lock for the one that
was held at the call?

The loop that decides whether a function verified on its own kept what its
caller held compares only the id and the type of each entry.  For lock entries
(REF_TYPE_LOCK, REF_TYPE_RES_LOCK, REF_TYPE_RES_LOCK_IRQ) the identity of the
lock is (type, id, ptr); find_lock_state(), release_lock_state() and
process_spin_lock() all match on ptr too.  Global-data locks always have id 0
(see the comment above check_reg_allocation_locked()), and inherited_id(state,
0) returns 0.

Calls to static subprogs are allowed with a lock held, and
func_is_on_its_own() does not exclude active_locks.  Suppose the entry state
of the callee holds {LOCK, id 0, ptr A}, the callee releases it and then takes
another lock of the same type that also has id 0 but a different ptr B.  Its
exit entry is then {LOCK, id 0, ptr B}.

The loop sees the same id (0) and the same type, counts the entry as kept, and
'caller->refs[i] = held[i]' sets refs[i].ptr back to A.
copy_reference_state(caller, exit) has already set active_lock_ptr to B.

After the return, refs[] says that the lock on allocation A is held, but the
lock the code actually holds is B, and active_lock_ptr disagrees with refs[].
check_reg_allocation_locked() checks only refs[] through find_lock_state(), so
after this return the verifier treats the bpf_list_head/bpf_rb_root fields of
allocation A as protected by a held lock, although that lock was released in
the callee.  Before this patch the callee ran in the context of the caller and
refs[] stayed exact.

Should the loop also compare ptr for lock types, for example:

    (held[i].type & REF_TYPE_LOCK_MASK) && caller->refs[i].ptr != held[i].ptr

so that the mismatch takes the existing 'releases what its caller holds'
fallback?  The loop is unchanged at the end of the series.

[ ... ]

> @@ -11551,12 +12086,15 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
>  	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
>  	if (stack_arg_cnt > caller_info->stack_arg_cnt)
>  		caller_info->stack_arg_cnt = stack_arg_cnt;
> -
> +	/* btf_check_subprog_call() doesn't get to it when BTF is not reliable */
>  	err = check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS + callee_incoming,
>  					bpf_subprog_name(env, subprog), NULL, NULL);
>  	if (err)
>  		return err;
>
> +	if (func_is_on_its_own(env, state, subprog))
> +		return call_func_on_its_own(env, subprog, *insn_idx);
> +

Does this lose the RCU callback context of the caller?

func_is_on_its_own() lets a recursive subprog through even inside a callback:

    if (state_in_callback(state) && !sub->recursive)
            return false;

call_func_on_its_own() then builds a fresh entry state whose frame[0] is the
callee.  It copies in_sleepable, the reference/lock/rcu counters and a generic
in_callback bool, but not the in_rcu_callback_fn flag of the caller frames.
That flag is set by set_map_elem_callback_state() for hash maps
(bpf_for_each_hash_elem() calls the callback under rcu_read_lock()) and by
set_find_vma_callback_state().

Inside the subprog the sleepable test is:

    static inline bool in_sleepable_context(struct bpf_verifier_env *env)
    {
            return !in_rcu_cs(env) && !in_rcu_callback(env);
    }

in_rcu_callback() scans only the frames of the current state, so it returns
false.  In a sleepable program in_rcu_cs() is also false, because
active_rcu_locks is 0 (the RCU of the callback is implicit).

Example: a sleepable program does bpf_for_each_map_elem(&hash, cb, ...), and
cb calls a recursive rec(int n) that calls bpf_copy_from_user() or a
KF_SLEEPABLE kfunc.  check_helper_call() tests 'fn->might_sleep &&
!in_sleepable_context(env)', the insn is not marked non_sleepable, and the
program loads.

At run time the helper can sleep inside the rcu_read_lock() of
bpf_for_each_hash_elem().  That is a sleeping-in-atomic bug, and the hash
element being walked can be freed while the program still uses it.
has_rcu_read_lock() and the checks of global calls (sub_aux->called[]) see the
same wrong context.

Before this patch recursion was rejected, and callees verified in the context
of the caller kept the callback frame, so in_rcu_callback() saw the flag.
Should call_func_on_its_own() carry this context into the entry state, for
example as a state-level flag that in_rcu_callback() also tests?  I did not
find a later patch in the series that changes this.

[ ... ]

> @@ -12181,6 +12719,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  			return -EACCES;
>  		}
>
> +		/* It's called any number of times. Nobody can release what it leaves behind. */
> +		for (i = callee->entry_refs; i < state->acquired_refs; i++) {
> +			if (state->refs[i].type != REF_TYPE_PTR)
> +				continue;
> +			verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
> +				state->refs[i].id, state->refs[i].insn_idx);
> +			bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, *insn_idx);
> +			return -EINVAL;
> +		}
> +
>  		/* we are going to rely on register's precise value */
>  		err = mark_chain_precision(env, BPF_REG_0);
>  		if (err)

Can this reject callbacks that hand the reference to their caller?

The new check at callback exit rejects any synchronous callback that returns
while holding a REF_TYPE_PTR acquired after entry.  The comment says nobody
can release it, but the caller can: the callback can store the reference
through its ctx pointer into the stack of the caller, and the caller releases
it after the helper returns.  For example:

    static int cb(u32 i, struct ctx *c) {
            if (!c->p)
                    c->p = bpf_kfunc_call_test_acquire(&sl);
            return 0;
    }
    ... bpf_loop(n, cb, &c, 0); if (c.p) release(c.p);

Before this patch check_reference_leak() returned 0 for frame > 0, and the
callback was verified as a loop.  On the NULL branch mark_ptr_or_null_regs()
drops the reference.  On the non-NULL branch the guard skips the second
acquire.  The states at the call site converge, and the caller releases the
pointer on every path, so the program loaded.

Now the first callback exit has refs[entry_refs] of type REF_TYPE_PTR and
fails with "Unreleased reference".  The fixpoint does not seem to need this
check for soundness: those states cannot be joined since their refs differ,
and a real leak is still caught at the frame 0 exit, as for the cb2/leak_prog
test in cb_refs.c.

The commit message lists the rejections it introduces (the join that loses the
relation between scalars), but not this one.  Is this rejection intended?

[ ... ]

> @@ -15115,14 +15663,59 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins

[ ... ]

> +/* The registers in which the kfunc takes nothing but a known constant ("__k") */
> +u16 bpf_kfunc_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
> +{
> +	struct bpf_call_arg_meta meta;
> +	const struct btf_param *args;
> +	u32 i, slot, nargs;
> +	u16 mask = 0;
> +
> +	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
> +		return 0;
> +	args = btf_params(meta.func_proto);
> +	nargs = btf_type_vlen(meta.func_proto);
> +	for (i = 0, slot = 0; i < nargs && slot < MAX_BPF_FUNC_REG_ARGS; i++) {
> +		if (is_kfunc_arg_constant(meta.btf, &args[i]))
> +			mask |= BIT(BPF_REG_1 + slot);
> +		slot += btf_arg_slots(btf_type_skip_modifiers(meta.btf, args[i].type, NULL));
> +	}
> +	return mask;
> +}

Should this mask also cover '__szk' and the rdonly_buf_size/rdwr_buf_size
arguments?

bpf_kfunc_const_arg_regs() only reports "__k" arguments, but
check_kfunc_args() also requires a known constant for "__szk"
(ARG_CONST_MEM_SIZE -> process_const_arg(): "%s must be a known constant") and
for "rdonly_buf_size"/"rdwr_buf_size" (ARG_CONST_ALLOC_SIZE_OR_ZERO ->
process_const_alloc_mem_size(): "%s is not a const"); see
get_kfunc_arg_type().

The mask is the only input of flow_compute_need_const(FLOW_NEED_ARG) for kfunc
calls, and flow_merge() uses flow->need_const to refuse joins of states whose
needed registers hold different constants:

    if (!widen && flow_needed_consts_differ(flow->need_const, &t->st, &s->st))
            continue;

Without a bit for the __szk register, two states with different constant sizes
are joined at the block head of the call, and the joined range fails
process_const_arg().  This is the same compiler pattern that the comment above
flow_compute_need_const() mentions for bpf_rdonly_cast(): LLVM sinks two calls
that differ in one operand into one call with a phi.

Example, which loads before this commit because each path has its own constant
in R4:

    if (skb->protocol == bpf_htons(ETH_P_IPV6))
            p = bpf_dynptr_slice(&d, ETH_HLEN, buf, 40);
    else
            p = bpf_dynptr_slice(&d, ETH_HLEN, buf, 20);

Once the call is merged, the states {r4=20} and {r4=40} meet at the call.
flow_null_differs(), flow_unset_differs() and flow_join_makes_up() do not
apply, so bpf_states_join() gives r4=[20,40], and the verifier rejects the
program with "R4 must be a known constant".  bpf_dynptr_slice() and
bpf_dynptr_slice_rdwr() take buffer__szk.

The helper variant bpf_helper_const_arg_regs() does cover
ARG_CONST_ALLOC_SIZE_OR_ZERO; the kfunc variant misses the kfunc arguments
that map to that type and to ARG_CONST_MEM_SIZE.  Could it test
is_kfunc_arg_const_mem_size() and the rdonly_buf_size/rdwr_buf_size names the
way get_kfunc_arg_type() does?  No later commit in the series changes this
function.

[ ... ]

> @@ -20274,6 +20879,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
>  {
>  	struct bpf_func_state *cur_frame = cur_func(env);
>
> +	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
> +		return exit_func_on_its_own(env);
> +

Can a speculative state reach this early return and lose its speculative flag?

With !env->bypass_spec_v1 (CAP_BPF without CAP_PERFMON, which is enough for
bpf2bpf calls), check_cond_jmp_op() pushes the dead side of every decided
branch with speculative = true through sanitize_speculative_path().  Inside a
function verified on its own, branches on constant arguments copied from the
caller are decided, so such states are common.

When one reaches the exit, the new early return calls exit_func_on_its_own()
-> bpf_flow_exit() without testing state->speculative:

- join.c refuses to join it with non-speculative exits
- states.c refuses to let it cover them
- so it stays in f->exits, and flow_apply_exit() applies it to every waiting
  caller

bpf_flow_return() does not carry exit->speculative into the caller, so the
caller continues non-speculatively with values from a path that cannot happen.

Example: 'static int f(int x) { if (x) return 1; return 100; }' called as
f(1), followed by an access indexed by the result.  The old code returned
through prepare_func_exit() with the state still speculative, and the bad
access got a nospec barrier (error_recoverable_with_nospec()).  Now the same
access is checked as a real path and is a hard rejection.

This is not a safety hole, since the caller is checked more strictly, but
programs that loaded before can be rejected, and the speculative continuation
in the caller is no longer modeled as speculative.  Should
exit_func_on_its_own() drop speculative states, or should bpf_flow_return()
propagate 'speculative' to the caller?

[ ... ]

> @@ -20490,6 +21098,24 @@ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *in
>  	return err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
>  }
>
> +/*
> + * NULL is dereferenced. In a program that has arena take it for a pointer to arena:
> + * the compiler may have moved the cast to where the number was not known to be 0 yet,
> + * and what check_loop_guard() sets to 0 may be a pointer that was cast in the loop.
> + */
> +static void null_to_arena(struct bpf_verifier_env *env, int regno)
> +{
> +	struct bpf_reg_state *reg;
> +
> +	if (!env->prog->aux->arena || regno >= BPF_REG_FP)
> +		return;
> +	reg = &cur_regs(env)[regno];
> +	if (reg->type != SCALAR_VALUE || !tnum_equals_const(reg->var_off, 0))
> +		return;
> +	__mark_reg_const_zero(env, reg);
> +	reg->type = PTR_TO_ARENA;
> +}
> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>  {
>  	int err;
> @@ -20499,6 +21125,11 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>  	if (is_arena_sp_insn(insn))
>  		return check_arena_sp_insn(env, insn);
>
> +	if (class == BPF_LDX)
> +		null_to_arena(env, insn->src_reg);
> +	else if (class == BPF_STX || class == BPF_ST)
> +		null_to_arena(env, insn->dst_reg);
> +

Does this miss the load-acquire form?

The commit message says "in a prog that has an arena, a load or a store
through the scalar 0 is an access to arena", and the comment of
null_to_arena() gives as a reason the registers that check_loop_guard() sets
to 0 on the may_goto edge.

For BPF_STX | BPF_ATOMIC with imm == BPF_LOAD_ACQ the address is in src_reg,
not dst_reg: check_atomic_load() tests atomic_ptr_type_ok(env, insn->src_reg,
insn) and check_load_mem() accesses regs + insn->src_reg.  null_to_arena() is
applied to dst_reg (the destination, which the load overwrites), so the
pointer register stays SCALAR_VALUE 0 and check_mem_access() rejects the
load-acquire with "invalid mem access 'scalar'".  A plain BPF_LDX through the
same register is accepted.

Scenario: an arena pointer is set only in a loop body and is read with
smp_load_acquire() after the loop.  The bpf_atomic.h of libarena lowers
smp_load_acquire() to __atomic_load_n(..., __ATOMIC_ACQUIRE), which is
BPF_LOAD_ACQ when __BPF_FEATURE_LOAD_ACQ_STORE_REL is set.  When the loop gets
a guard at its header, check_loop_guard() zeroes the NOT_INIT live register on
the guard edge.  The plain-load version of the program loads.  The
load-acquire version is rejected, including programs whose loops the old
verifier followed to the end and which now get may_goto.

Should null_to_arena() be given src_reg when the insn is BPF_LOAD_ACQ?

[ ... ]

> @@ -20728,18 +21364,66 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)

[ ... ]

> +int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop)
> +{

[ ... ]

> @@ -20752,43 +21436,336 @@ static int handle_loop_entry_exit(struct bpf_verifier_env *env)

[ ... ]

>  		return err;
>
> -	terminates = err == 1;
> -	if (!terminates)
> +	/*
> +	 * There is no summary of what the loop does to something that is live.
> +	 * Go through the iterations one by one if that is not too long.
> +	 */
> +	if (err == 2 && flow_walk_factor(cur) * iters.max_header_count * loop->nr_insns <=
> +			BPF_FLOW_MAX_WALK) {
> +		entry->max_header_count = iters.max_header_count;
> +		entry->terminates = true;
> +		entry->counted = true;
> +		entry->apart = true;
> +		return 0;
> +	}

Can this product wrap?

BPF_FLOW_MAX_WALK (100000) is meant to cap the insns that a counted walk
processes.  Now that BPF_COMPLEXITY_LIMIT_INSNS is no longer enforced, this
cap and the flow.c state counts are what bound the verification time.  The
product is computed in u64 and can wrap: flow_walk_factor() can reach about
1e5, iters.max_header_count can be up to U32_MAX - 2 (compute_max_iters()),
and loop->nr_insns can be up to the program length.

Inside one frame the nr_insns of the outer loop includes the inner loop, so
the product stays below 2^64.  Across frames it does not: flow_walk_factor()
multiplies the loop stacks of all frames, and the frames of the callers stay
in the state when the callee is not on its own (for example when it gets a
pointer to the stack of the caller).  For example:

- A caller loop of 3 insns (call; add; jlt) walked as counted with
  max_header_count 32768 gives factor = 2^15.
- The callee has a loop with err == 2, max_header_count = 2^31 and
  nr_insns = 2^18.
- 2^15 * 2^31 * 2^18 = 2^64 wraps to 0, which is <= BPF_FLOW_MAX_WALK, so
  the loop is walked trip by trip for up to 2^31 trips of 262144 insns.

The walk ends only when env->total_states reaches 256 * len + 65536, after on
the order of 10^13 processed insns.  That is hours to days of verifier CPU.
The task can be killed (signal_pending), and the loader needs CAP_BPF.

Could the bound be computed without the overflow, for example by comparing
iters.max_header_count against BPF_FLOW_MAX_WALK / (flow_walk_factor(cur) *
loop->nr_insns)?

[ ... ]

> +/*
> + * The loop that is not counted and has nothing that stops it at run time gets
> + * may_goto in front of this insn. When it is out of budget the program goes
> + * where may_goto goes with the registers and the stack as they are here.
> + */
> +static int check_loop_guard(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	branch = push_stack(env, env->insn_aux_data[env->insn_idx].guard_to, env->insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +	env->head->parked = aux->guard_unwind;
> +	aux->loop_guard = true;
> +	if (!aux->guard_at_header)
> +		return 0;
> +	/*
> +	 * The program doesn't leave the loop from here. What it computes in the loop
> +	 * for the code that follows is not there. Nothing good comes out of a loop
> +	 * that is cut short anyway. Let it be 0.
> +	 */
> +	regs = branch->frame[branch->curframe]->regs;
> +	for (i = BPF_REG_0; i < BPF_REG_FP; i++)
> +		if (regs[i].type == NOT_INIT &&
> +		    (env->insn_aux_data[aux->guard_to].live_regs_before & BIT(i)))
> +			aux->guard_zero |= BIT(i);
> +	for (i = BPF_REG_0; i < BPF_REG_FP; i++)
> +		if (aux->guard_zero & BIT(i))
> +			__mark_reg_const_zero(env, &regs[i]);

Can a guard branch that was pushed earlier be verified with guard_zero masks
that are out of date?

check_loop_guard() collects aux->guard_zero and aux->guard_zero_slots one
state at a time.  It applies the bits collected so far only to the guard
branch of the state it is processing at that moment.  bpf_insert_loop_guards()
in fixups.c then emits 'rX = 0' and '*(u64 *)(fp - off) = 0' on the may_goto
edge for every bit in the final value, and that code runs on every execution.

A state that reaches the guard insn before a later state adds a bit has its
guard branch pushed and verified with that register or slot unchanged (for
example, still a pointer).  At run time the same edge writes 0 there.  Nothing
re-verifies the earlier branch when guard_zero or guard_zero_slots grows.

The fixpoint processes states in a fixed order (flow_set_pending() sorts by
subprog rank and insn position, FIFO for ties), so two states that cannot be
joined at the guard insn can be handled in that order.  In that case the code
after the loop is verified with a register or slot type that differs from the
value the patched program loads at run time.

Should the main pass re-verify the guard edges at that insn whenever the zero
masks grow?  Alternatively the masks could be fixed before any guard branch is
delivered, for example by restarting the pass when they change.

[ ... ]

> @@ -22279,6 +23221,26 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
>  	return ret;
>  }
>
> +static int do_check_common(struct bpf_verifier_env *env, int subprog,
> +			   enum bpf_func_context context)
> +{
> +	int insn_idx = env->insn_idx, tries = 0, ret;
> +	u64 log_pos = env->log.end_pos;
> +
> +	for (;;) {
> +		env->restart = false;
> +		ret = __do_check_common(env, subprog, context);
> +		if (!ret || !env->restart)
> +			return ret;
> +		if (++tries == 8) {
> +			verbose(env, "verification was started again too many times\n");
> +			return ret;
> +		}
> +		bpf_vlog_reset(&env->log, log_pos);
> +		env->insn_idx = insn_idx;
> +	}
> +}

Can the pass finish without a restart although env->restart was set on a
speculative path?

do_check_common() starts the pass again only when __do_check_common() fails
and env->restart is set:

    if (!ret || !env->restart)
            return ret;

The restart requests come from iter_is_drained() (reached from
process_iter_next_call() through do_check_insn()) and from
flow_iters_are_remade() (reachable through bpf_flow_call() from
do_check_insn()).  Both set env->restart, clear loop->rt_bounded and return
-EINVAL.

In do_check_block() an -EINVAL from do_check_insn() on a speculative state
counts as recoverable: error_recoverable_with_nospec() includes -EINVAL, so
the code sets nospec on the insn and goes to process_bpf_exit.  When
env->bypass_spec_v1 is false, check_cond_jmp_op() pushes the branch that the
state does not take as a speculative path.  That path can carry a drained
iterator back to bpf_iter_*_next(), so iter_is_drained() can run on it.

The pass then goes on with rt_bounded already cleared and finishes with ret ==
0, and do_check_common() returns 0 without starting again.  check_loop_guard()
handled the states before the change as bounded: it returned early, verified
no guard edge and set no aux->loop_guard.  States after the change set
aux->loop_guard and push guard branches.  bpf_insert_loop_guards() then adds
may_goto, and its exit edge applies to all executions, including those that
match states whose guard edge was never verified.

Should the pass start again whenever env->restart is set, whether or not it
succeeded?  Another option is to not treat the -EINVAL as recoverable with
nospec once env->restart is set.

[ ... ]

> @@ -22364,6 +23326,37 @@ static int do_check_main(struct bpf_verifier_env *env)
>  	return ret;
>  }
>
> +/*
> + * What it took to verify a static subprog on its own is not in insns_total of its callers.
> + * Add it, once per caller. The main prog and global subprogs have all of it already.
> + */
> +static void add_insns_of_callees(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *si = env->subprog_info;
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	int *added, i, j, s, c;
> +
> +	added = kvcalloc(env->subprog_cnt, sizeof(*added), GFP_KERNEL_ACCOUNT);
> +	if (!added)
> +		return;
> +	/* callees first */
> +	for (i = 0; i < env->subprog_cnt; i++) {
> +		s = env->subprog_topo_order[i];
> +		if (!s || bpf_subprog_is_global(env, s))
> +			continue;
> +		for (j = si[s].start; j < si[s + 1].start; j++) {
> +			if (!bpf_pseudo_call(&insn[j]))
> +				continue;
> +			c = bpf_find_subprog(env, j + insn[j].imm + 1);
> +			if (c <= 0 || c == s || !si[c].on_its_own || added[c] == s)
> +				continue;
> +			added[c] = s;
> +			si[s].insns_total += si[c].insns_total;
> +		}
> +	}
> +	kvfree(added);
> +}

Does this add the right total for a callee that is verified in both ways?

The comment says that only what was verified on its own is missing from the
insns_total of the callers, and the function adds si[c].insns_total, but that
total is not only the on-its-own part.  account_processed_insns() adds the
subtotal of every frame of c to subprog_info[c].insns_total, in-context frames
included, and those insns were already propagated into the total of the caller
(caller->insns_subtotal += insns).

(1) Double count: if s calls c in the context of its own frame at one site
(for example c receives a PTR_TO_STACK argument, so func_is_on_its_own() is
false) and on its own at another, c.insns_total holds both parts, and
s.insns_total gets the in-context part twice.

(2) Omission: the gate is si[c].on_its_own, so a callee c that is only ever
verified in context is skipped even though its own on-its-own callees were
added to c.insns_total.  With q -> p(&local) -> c(scalars), p.insns_total is
p.self + c.total but q.insns_total is q.self + p.self, so a caller reports
less than its callee.

Only the BPF_LOG_STATS output ('subprog N ... insns_total') is affected, not
verification, but the output differs from the per-chain totals that
verifier_subprog_insn_stats.c documents.  The sum can also wrap in a u32 for
deep call DAGs.

Should the callee total added for a callee that is not on its own be its full
total minus what the caller frame already accumulated, or should the totals be
kept per category?

[ ... ]

> @@ -24397,10 +25398,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>
>  	ret = do_check_main(env);
>  	ret = ret ?: do_check_subprogs(env);
> -
> -	/* reject recursion through the callx edges found by the main pass */
> -	if (ret == 0 && env->callx_edges)
> -		ret = sort_subprogs_topo(env);
> +	/* while the calls are what they are in the program */
> +	if (env->log.level & BPF_LOG_STATS)
> +		add_insns_of_callees(env);

Are the comments about the repeated sort still correct?

This hunk removes the second sort_subprogs_topo() call from bpf_check() (the
old "reject recursion through the callx edges found by the main pass").
sort_subprogs_topo() now has one call site, which runs before the main pass.
env->callx_edges is only allocated by record_callx_edge() during the main
pass, so it is always NULL there.  next_callx_callee() then always returns -1,
and the bpf_is_callx() branch in sort_subprogs_topo() never finds a callee.

Two comments are now wrong.  The header comment of sort_subprogs_topo() still
says:

    The callees of callx are not known before the main verification pass.
    When callx is used the sort is repeated after it with the recorded callx
    edges added to the call graph to reject recursion through indirect calls.

and the comment of record_callx_edge() still says that the edges are recorded
for the checks that follow the main pass: "absence of recursion and the
maximum stack depth".  Recursion through callx is now accepted and checked at
run time (mark_recursive_subprogs()), and only check_max_stack_depth_subprog()
still reads the callx edges.

Neither comment is changed later in the series.  Could the comments be
updated, and the dead callx branch in sort_subprogs_topo() dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============0733389674210141719==--
