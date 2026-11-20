Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163126;
	b=YVdcO11M/hO0QQYyAOeyBhNmQQU03H4fMHjJ2q4rh+5HRLO/609lxhoFt43QYHokp99D
	 W2Or2SP95PyRY/ardNTWBljRazhRjhQ+I2GxG7Z7BCGusKGy5j3XJIOqB2BKKf9mSYgBW
	 xTk5rnnDJ8eD+enpDhVbK0F/EEGiegPTc3QuEqQabbQhlUhDsib538df1C8055Yx4FKaL
	 /59nfYGND9tZyZ72dke1cO2DbHT84ga+XgHp5u8LayofQ5mHeWwhfuczXZHLBRZrddkMb
	 C9VhYQNYlfcumYJ1ye2zkQn/GuMrgKxxjHtmOO+dfny+RX/rqkSfcrTaWzfP9ZQcP4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163126;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=j/8Ar/K08QnRFPOxHZ6zui4+dZIEn3WW+TgRFBb2LXo=;
	b=x0+4G6zTZbZoF0uics2zm8WuiazJapVk8QDxmrsWFO2eSWRsru5pmsebCUNoaeKDaSn+
	 yy6B3MTJ74Soe/PND57JNKdJjHC+ifJ5kmTShyx6X+e0oZZO6ECyFGo2JsvmNNdGGaFbr
	 CfmPPBcrOdaqGPK+MnmoKhA+S8D6qSQcBfblVCgnynhweGakWn7bl63TrrsANF6rutLjj
	 Y9QJopNYwhHpAQt/UmK0pJnhZHMX61wUNnvvpPf079cb9ltdHkqHfl9NhjIXF0Ig1My3h
	 7QS4rcuPWePc8C6Z0dEk/R+arME/ELv7NcQxLPfwjIfdwDJjaxUQtsn/VNwQetVHMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmBQwOPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C85606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmBQwOPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4621F000C6;
	Fri, 20 Nov 2026 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163126;
	bh=j/8Ar/K08QnRFPOxHZ6zui4+dZIEn3WW+TgRFBb2LXo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AmBQwOPnV9m1ByQuYRuvFojpqIyUCjGW//iZVWVWQz/7k82pg8Tqopfz1RUxAlPKC
	 wxr/ncckw6AJESB19Q56XsWvuJXVtqawKhJ2XO5Uylc+oapDQPWdJYOzLVR+gBtxOV
	 YNEM72EqJDO2sKbed1VP3zMPGMkikpiyld19R2mKfBXD/itNzPkL4+pPr7m2G/bFva
	 YB5RZ7l/s4nIsZ4JQ9J0QJcaiMfTGZJAH8wgUeSNoG5QBBWvH/ZqrzmcoHjP5lmOZx
	 hGVjqcVrbBbmkflbShKEBp+W7iDTFkj06BNg0m6gQ/GUDcAG/OGKZ2BtI6OZFQPNem
	 nOE3vkOhIaFOQ==
Content-Type: multipart/mixed; boundary="===============6137567754453418669=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7a8ef9d86f606dad773f53efcfb9af9a614668f27b2e5b4d81c968a14ee10c76@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-12-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 11/49] bpf: Put a barrier where no mask fits
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:25 +0000 (UTC)

--===============6137567754453418669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Put a barrier where no mask fits

TL;DR:
- Possible NULL env->head dereference in check_loop_guard() for speculative
  states
- Build breaks: undefined budget_exit_insn() and note_pessimized_insn();
  leave[] may overflow
- ~16 unprivileged selftests not updated

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1235,6 +1234,7 @@ struct bpf_verifier_env {
>  	/* a global function is verified for BPF_FUNC_CTX_NO_RCU_LOCK */
>  	bool no_rcu_read_lock;
>  	bool signature;
> +	u8 bug:1;			/* ends the load, see bpf_note_bug() */
>  	u32 insn_aux_data_len;

The comment points to bpf_note_bug(), but no such function exists in the
tree, and nothing sets env->bug.  verifier_bug() and verifier_bug_if() only
do BPF_WARN_ONCE() and bpf_log().

The only reader is is_error_of_state() in verifier.c:

    return err != -ENOMEM && err != -EINTR && !env->over_limit && !env->bug;

Since env->bug is always 0, can the -EFAULT returned by verifier_bug() in a
speculative state now be swallowed?  The old error_recoverable_with_nospec()
only recovered -EPERM, -EACCES and -EINVAL, so with this change the insn
gets a barrier, the path ends, and the program loads instead of being
rejected.  Should the setter be added (for example in verifier_bug()), or
the field and its use dropped?

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -565,21 +566,31 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
>  	return err;
>  }
>
> -/* How a subprog leaves when it is out of budget, see push_budget_exit() */
> -static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
> +/* How subprog @s leaves when it has to stop, see push_unwind_exit(). Returns the length. */
> +static int emit_unwind_exit(struct bpf_verifier_env *env, int s, struct bpf_insn *buf)

[ ... ]

This removes budget_exit_insn(), but bpf_insert_loop_guards() in this file
still calls it:

    leave[1] = BPF_MOV64_IMM(BPF_REG_2, 0);
    leave[n - 1] = budget_exit_insn(env, sub);

Is there a definition of budget_exit_insn() anywhere in the tree?  It looks
like this is an undeclared function returning into a struct bpf_insn, so
fixups.o would not build with CONFIG_BPF_SYSCALL=y.  The call is still
there at the end of the series.

Also, the commit message says:

    may_goto --> r0 = 0; exit            barrier before r0 = 0

but the leave[] sequence built in bpf_insert_loop_guards() is still
'r0 = 0; [r2 = 0;] exit' with no BPF_ST_NOSPEC().  Only
bpf_insert_recursion_checks() was converted to emit_unwind_exit().  Since
push_unwind_exit() now returns without pushing for a speculative state, the
may_goto -> leave edge is not checked speculatively, so this barrier
appears to be missing.

A plain rename would not be enough either.  leave[] is sized 3 and n is
'bpf_ret_reg_pair() ? 3 : 2', which is also used as the jump-back distance
passed to bpf_patch_list_jump().  With the barrier and an R2 pair that is 4
insns, so leave[] would overflow and the may_goto would land on the wrong
insn.  Should leave[] be sized for emit_unwind_exit() and n taken from its
return value?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static void need_nospec(struct bpf_verifier_env *env, u32 idx)
> +{
> +	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
> +	struct bpf_insn *insn = &env->prog->insnsi[idx];
>
> +	/* nothing fits between it and the call */
> +	if (bpf_is_unwind_goto(insn)) {
> +		need_nospec(env, idx + 1);
> +		return need_nospec(env, idx + insn->off + 1);
>  	}
> +	note_pessimized_insn(env, idx);
> +	aux->nospec = true;
> +	aux->alu_state = 0;
> +}

Where is note_pessimized_insn() defined?  I could not find a function or
macro with that name at this commit, at the series base or at the series
end, and the kernel is built with -Werror=implicit-function-declaration, so
verifier.c would not compile.  Is a definition missing from the series?

> +static int sanitize_err(struct bpf_verifier_env *env, int err)
> +{
> +	if (err != NO_MASK_FITS)
> +		return err;
> +	if (env->cur_state->speculative)
> +		return -EACCES;
> +	need_nospec(env, env->insn_idx);
> +	return 0;
> +}

The messages that the old sanitize_err() printed are gone:

    R%d has unknown scalar with mixed signed bounds
    R%d has pointer with unsupported alu operation
    R%d tried to %s from different maps, paths or scalars
    R%d tried to %s beyond pointer bounds

The commit says "Some unprivileged programs load now", but nothing in the
series touches tools/testing/selftests/bpf/.  About 16 existing tests still
expect __failure_unpriv and/or these __msg_unpriv() strings:

    progs/verifier_bounds_deduction.c (8)
    progs/verifier_value_ptr_arith.c (5)
    progs/verifier_map_ptr.c (2)
    progs/verifier_bounds.c (1)

For example, "check deducing bounds from const, 2" ('r1 -= r0' on ctx)
expects "R1 has pointer with unsupported alu operation" unprivileged, but
retrieve_ptr_limit() now returns NO_MASK_FITS for PTR_TO_CTX, so the insn
just gets a barrier and loads.  "map access: known scalar += value_ptr
unknown vs const" expects "tried to add from different maps, paths or
scalars", and "subtraction bounds (map value) variant 2" expects "R1 has
unknown scalar with mixed signed bounds".

Should these tests be updated in the same series, so that test_progs -t
verifier does not fail?

[ ... ]

> @@ -20669,12 +20661,14 @@ static bool guard_reads_unset_reg(struct bpf_verifier_env *env,
>  static int push_unwind_exit(struct bpf_verifier_env *env)
>  {
>  	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
>  	struct bpf_verifier_state *branch;
>  	struct bpf_reg_state *regs;
>
> +	if (env->cur_state->speculative)
> +		return 0;
>  	branch = push_stack(env, sub->bail_insn, env->insn_idx, false);

[ ... ]

> @@ -20750,14 +20744,14 @@ static int check_loop_guard(struct bpf_verifier_env *env)
>  	if (!aux->guard_no_unwind) {
> -		err = push_budget_exit(env);
> +		err = push_unwind_exit(env);
>  		if (err)
>  			return err;
>  		env->head->guard_edge = BPF_GUARD_LEAVES_SUBPROG;

Can this dereference a NULL env->head?  push_unwind_exit() now returns 0
without pushing anything for a speculative state, but check_loop_guard()
still treats 0 as "a branch was pushed" and writes env->head->guard_edge.

check_loop_guard() runs from do_check_block() before do_check_insn(), and
env->head is emptied after every insn by flow_drain() (and by
free_pushed_states()), so nothing has been pushed for the current insn at
that point.  If some other element were on the list, it would get the
BPF_GUARD_LEAVES_SUBPROG mark instead.

This looks reachable.  A loader with CAP_BPF but not CAP_PERFMON
(bypass_spec_v1 false) can load a program with a loop that needs a may_goto
guard.  A speculative state is pushed inside the loop body by
sanitize_speculative_path() (from sanitize_ptr_alu() or from a branch whose
outcome is known).  copy_func_state() copies loop_stack, so on its next
trip that state reaches the guard_place insn.  In the main prog with
zero_is_valid_retval(), state_can_unwind() keeps aux->guard_no_unwind false,
and the state reaches the write above.  Before this commit
push_budget_exit() pushed a branch for speculative states too.

check_loop_guard() and push_unwind_exit() are unchanged at the end of the
series.  Would skipping the block for speculative states, for example
'if (!aux->guard_no_unwind && !env->cur_state->speculative)', or having
push_unwind_exit() report whether it pushed, be the right fix?

[ ... ]

> @@ -20916,24 +20934,23 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
>  		if (state->speculative && insn_aux->nospec)
>  			goto process_bpf_exit;
>
> -		err = check_loop_guard(env);
>  		if (err)
>  			return err;
>
> -		err = check_recursion_guard(env);
> +		err = check_loop_guard(env) ?: check_recursion_guard(env);
>  		if (err)
>  			return err;

Is the first 'if (err) return err;' now dead?  At that point err only holds
a value that was already checked after bpf_check_limits() and
bpf_prog_offload_verify_insn(), so it can never fire.

>  		err = do_check_insn(env, &do_print_state);
> -		if (error_recoverable_with_nospec(err) && state->speculative) {
> +		fixups = insn_aux->fixups;
> +		if (nospec_ends_path(env, state, err)) {
>  			/* Prevent this speculative path from ever reaching the
>  			 * insn that would have been unsafe to execute.
> +			 * What it noted does not apply to the other paths.
>  			 */
> +			insn_aux->fixups = fixups;

The snapshot 'fixups = insn_aux->fixups;' is taken after do_check_insn()
has run, so 'insn_aux->fixups = fixups' writes back the same bytes.  Does
this restore anything?  The comment ("What it noted does not apply to the
other paths") and the commit message ("What the state noted at the insn is
dropped") describe a rollback that does not happen.

Whatever the failing speculative state wrote into struct bpf_insn_fixups
before its error stays for later states and passes: ptr_type through
save_aux_ptr_type(), non_arena_load in check_load_mem() (set before
save_aux_ptr_type() can fail), map_ptr_state, nospec_result and so on.
need_nospec() only clears alu_state.  Since an insn has one fixup for all
states (fixups_differ()), a value that came only from a speculative path
can make a later non-speculative state fail.  For example, non_arena_load
set on the speculative path, and then a real path that loads an __arena
member fails with "an insn loads an arena pointer member on one path and
something else on another".  A stale ptr_type can likewise produce "same
insn cannot be used with different pointers".

Commit 0462c546cfe6 ("bpf: Make equations from ALU, spill, fill and call
insns") later in the series moves 'fixups = insn_aux->fixups;' in front of
do_check_insn().  Should that move be part of this patch, since at this
commit the restore is a no-op?

>  			need_nospec(env, prev_insn_idx);
>  			free_pushed_states(env);
>  			goto process_bpf_exit;

Related to the removal of the only caller of error_recoverable_with_nospec()
here, the function stays behind as an unused static function.  -Wall
reports it as "defined but not used", which is a build error with
CONFIG_WERROR=y.  It is still present at the end of the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============6137567754453418669==--
