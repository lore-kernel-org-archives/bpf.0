Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163105;
	b=Y7ft36xNa8kimYMDuqFXLGUEhTtEoTDx3UhRDad9VC4qr1C2yXnpJIk70q2Ay5bdk4gO
	 mIScK5BNAFwCGYDvyVIJD7l5Rwd2sL03lEdK3lDqfEZSIHX4lKjyV4B9uOjGBkKc8qpwg
	 uHjxubJMkwA5vOjHZVqtXRytYTpATZLeWUQ7xzAjEIWBDjhM/wXKgL6b09aEW8mECN+K6
	 Wdb7NSKZgtEAoiCVCjn0qWnPQUCs+7aoIYjVif/iMccQfDZ8WEO0mBnPR2xxNlmKlX3mT
	 KCeEH+5utSBNFSPF2MA7Oxdu5BfA0BLJPCwIhl+JRmtv4buoAOftSIJ7n5yY4HBUx+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163105;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=o/VtfISlZmSze13yhwRhC6ZTI4obfasJa3NFe+w+jQ0=;
	b=Be8ReG3ucwwu6p2eHQnXRlRiZ5H7P4rgv4+6zvptnOFORpdUrfkbNUyqggixEcj9P49O
	 SwuoIFHfn6d3rR+3KvR/deBBigH9iQwYp3YjMHPZqXbtFeb9evO0h0J8zuQwoCbL9EAFq
	 8yt4f9xoMn8Q5Sy6mvr5TepphrGJjjMDXOHQAfCWSWsz9e7fo0hxnlcTl3NPubEhUtvBG
	 zefxq0P4QR0m7VeO8cibMW28NaLLlUYbe1ww1xY7EXaXlUKWUvNY03QwNV1x+PV0/AlHe
	 sYDlKOsocP+JuMuXY8084NIFqN0jnqQzLu2z8G1aUDKceO0tRLDbgxhHD3DMq/8+v3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD55Zwrm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED57606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD55Zwrm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673F41F000C4;
	Fri, 20 Nov 2026 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163104;
	bh=o/VtfISlZmSze13yhwRhC6ZTI4obfasJa3NFe+w+jQ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VD55ZwrmrSA+SdFhd3XmIzc4laRTjqT9WJBd5VjRPkWGFFuaw2Y6oIw8j/F2oMgrH
	 st9qq2nrMU5X/Xsa3jJBavDrTijU9bektxcuANnR4dCf/BoS8LoZzTcapk0NGytN2F
	 Dx+Wgd/3hzitz+SjclJKyXJKekEDZUxH6tGzBk0I+RJoV3hXzM5zM+C5W0y6Vqvu01
	 RPOzXDEMZGQwLJgZ+IuhXIPFCCZz/L7H1WZUjG5+vQdsVF7Fd5LxY/LDASsQbaHAM+
	 PBCne4r5bgIE2va9cmp0KziQilGSd5LNiOLUoY3jh1oObn4afUPjctW1ji0NCFHaMg
	 y1va0V2NZYFrg==
Content-Type: multipart/mixed; boundary="===============1447305057873354971=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <14c3ab14e7b6d65ef519068061235c7a19b5d5b4d6f3f0498464536e96d439a3@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-4-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 03/49] bpf: Delete the old main pass of the verifier
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:03 +0000 (UTC)

--===============1447305057873354971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Delete the old main pass of the verifier

TL;DR: Deleting the old verifier pass leaves callers behind in verifier.c,
states.c, flow.c and scalar_widen(), so with CONFIG_BPF_SYSCALL=y the kernel
may not build or link, possibly through the whole series, breaking bisection.

> The patch only deletes. Later patches add the new code as whole
> functions. The kernel builds again with "bpf: Verify in passes".

No commit with the subject "bpf: Verify in passes" exists in
120103063a0c..a50a112fb866, and no commit in that range defines the deleted
functions again.  Is the series meant to leave 18 commits that cannot build
with CONFIG_BPF_SYSCALL=y?  Documentation/process/submitting-patches.rst
asks that the kernel builds and runs properly after each patch, and git
bisect can stop on any of them.

Could the deletion be folded into the patch that adds the replacement
pass, or could the old functions be kept until then?  The individual
breakages are below.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> -/* Where may_goto that the verifier adds goes, see check_loop_guard() */
> -enum bpf_guard_edge {
> -	BPF_NO_GUARD_EDGE,
> -	BPF_GUARD_LEAVES_SUBPROG,
> -	BPF_GUARD_LEAVES_LOOP,
> -};
> -
> -struct loop_stack_entry {
> -	struct bpf_verifier_state *entry_state;
> -	u32 min_header_count;
> -	u32 max_header_count;
> -	u32 loop_id:23;
> -	u32 terminates:1;
> -	/* the loop had may_goto when the state entered it, see check_loop_guard() */
> -	u32 guarded:1;

[ ... ]

> -/* The state is in a walk on patience, which may not get to the end of the loop */
> -static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entry)
> -{
> -	return entry->apart && entry->terminates && !entry->counted && !entry->first;
> -}
> -

Does the code that is left in verifier.c still use these?  Both
struct bpf_verifier_stack_elem and check_loop_guard() still do:

    enum bpf_guard_edge guard_edge;

    if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
    if (aux->guard_edge_dropped && loop->guarded)
    env->head->guard_edge = BPF_GUARD_LEAVES_SUBPROG;

so the enum is an incomplete type, and the helper, the aux bit, the
bpf_loop field and the enum values are all gone.  copy_func_state() also
uses sizeof(*src->loop_stack) on the deleted struct loop_stack_entry, and
print_verifier_state() in log.c reads state->loop_stack[i].apart.  Later
commits (98b796be1fd1 "bpf: Peel the first trips of a loop and join the
other trips" and 885b6e36bec3 "bpf: Delete scalar evolution") fix some of
this, but the loop_stack_entry that 98b796be1fd1 adds back has no
terminates, guarded or loop_id member, so check_loop_guard() still does not
compile at a50a112fb866.

[ ... ]

> -/* The places that the table of a loop knows: registers, then stack slots, fp-8 first */
> -#define BPF_LOOP_SLOT	64
> -#define BPF_LOOP_PLACES	128
> -
> -/*
> - * Where the bounds of the number in @place may come to rest at the head of a loop: the lowest and
> - * the highest upper bound, the highest and the lowest lower bound that the jumps of the loop
> - * let come back to the head, see flow_compute_rungs().
> - */
> -struct bpf_loop_rungs {
> -	s64 max[2];
> -	s64 min[2];
> -	bool has_max;
> -	bool has_min;
> -	u8 place;
> -};
> -

[ ... ]

> @@ -1621,44 +1505,19 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
>  bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
>  			struct bpf_verifier_state *cur);
>
> -/* join.c */
> -int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
> -		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
> -		    bool widen);
> -void bpf_join_free(struct bpf_verifier_env *env);
> -
>  /* flow.c */
>  int bpf_flow_prepare(struct bpf_verifier_env *env);
>  void bpf_flow_reset(struct bpf_verifier_env *env);
>  void bpf_flow_free(struct bpf_verifier_env *env);
> -bool bpf_flow_is_point(struct bpf_verifier_env *env, int insn_idx);
> -struct bpf_verifier_state *bpf_flow_keep_state(struct bpf_verifier_env *env,
> -					       const struct bpf_verifier_state *st);
> -int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> -		     int insn_idx, int prev_insn_idx);
> -int bpf_flow_guard_edge(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> -			int insn_idx, int prev_insn_idx, enum bpf_guard_edge edge);

Is it intended to keep the scalar_widen() prototype that names
struct bpf_loop_rungs?  With the struct definition gone, the struct is first
named inside the prototype's parameter list:

    void scalar_widen(struct scalar *s, const struct scalar *old,
                      const struct bpf_loop_rungs *rungs, int linear);

so every file that includes bpf_verifier.h gets a "declared inside parameter
list" warning (an error with CONFIG_WERROR).  The definition in verifier.c
conflicts with the prototype and dereferences an incomplete type:

    if (rungs && rungs->has_max && max <= rungs->max[1])
            stop = min(stop, max <= rungs->max[0] ? rungs->max[0] : rungs->max[1]);

The only caller was join_range() in join.c, which this commit deletes, and
no later commit up to a50a112fb866 touches scalar_widen() or
struct bpf_loop_rungs.  The commit message lists "bounds for widening
flow_compute_rungs()" and "the join" as deleted, so this is old code that a
later patch cannot simply add to.  Should scalar_widen() and its prototype
be deleted here, or struct bpf_loop_rungs kept?

The same removal leaves two other join-only helpers with no callers through
the end of the series: bpf_state_subsumes() in states.c (used only by
join_check()) and the static inline bpf_stack_args_are_incoming() in
bpf_verifier.h (used only by join_func()).  They compile, but could be
deleted together with scalar_widen() if they are not meant for the new join.

Also, the prototypes of bpf_flow_prepare(), bpf_flow_reset(),
bpf_flow_free(), bpf_flow_call() and bpf_flow_exit() stay, while the
definitions are removed from flow.c.  verifier.c still calls
bpf_flow_guard_edge(), bpf_flow_deliver() and bpf_flow_is_point() from
flow_drain() and do_check_block(), whose prototypes are removed here, so
those are implicit declarations.  The other five fail at link time.

[ ... ]

>  	bool restart;			/* see bpf_flow_next_is_no_bound() */
>  	bool guards_late;		/* see bpf_flow_loop_gets_guards() */

This isn't a bug, but bpf_flow_loop_gets_guards() and bpf_flow_new_round()
are deleted from flow.c, so this comment now points at a function that does
not exist.  The comment above check_loop_guard() in verifier.c has the same
problem:

    * Every state that goes through the loop does, see bpf_flow_loop_gets_guards().

Also, bpf_flow_new_round() was the only code that cleared env->guards_late
and env->restart, and loop->guarded is deleted from struct bpf_loop.
check_loop_guard() still writes env->guards_late, but its only reader,
round_is_dropped(), has no caller after do_check_all() goes away, and the
same is true of bpf_flow_loops_lost_bound().  Both fields are write-only
now.  Neither comment is touched by any commit up to a50a112fb866.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> @@ -32,157 +8,11 @@
>
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>
> -/*
> - * States at an insn that have no join: kinds of values, references, chains of calls.
> - * A state that arrives is compared with those that it may be related to, see flow_may_relate().
> - * At worst that is all of them, and the work is the square of it.
> - */
> -#define BPF_FLOW_MAX_STATES	1024

[ ... ]

Does flow_compute_order() still compile?  This hunk removes the definition
of struct bpf_flow, but the function is kept and still does:

    static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flow)
    ...
            flow->pos[n] = pos++;

struct bpf_flow is only forward-declared through the
"struct bpf_flow *flow;" member of struct bpf_verifier_env, so this
dereferences an incomplete type.  Its only caller, bpf_flow_prepare(), is
deleted below, so the static function is also unused (an error with
CONFIG_WERROR).  struct flow_kept and the jhash.h and rbtree.h includes
have no users left either, which does not match "the code that builds the
log from kept states" being deleted.

[ ... ]

> @@ -517,2895 +305,3 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
>  	kvfree(seen);
>  	return ret;
>  }
> -
> -/* The slot that @insn spills to or fills from, if it's one that struct flow_need has a bit for */
> -static int flow_fp_slot(const struct bpf_insn *insn, u8 base)
> -{
[ ... ]

This hunk deletes the definitions of bpf_flow_prepare(), bpf_flow_reset(),
bpf_flow_free(), bpf_flow_is_point(), bpf_flow_guard_edge(),
bpf_flow_deliver(), bpf_flow_call(), bpf_flow_exit() and
bpf_flow_is_needed().  Their callers are still in the tree:

    bpf_check():            ret = bpf_flow_prepare(env);
    bpf_check():            bpf_flow_free(env);
    free_states():          bpf_flow_reset(env);
    flow_drain():           err = bpf_flow_guard_edge(env, &elem->st, ...
    flow_drain():           err = bpf_flow_deliver(env, &elem->st, ...
    do_check_block():       bpf_flow_is_point(env, env->insn_idx)
    call_func_on_its_own(): err = bpf_flow_call(env, state, &entry, subprog, insn_idx);
    exit_func_on_its_own(): err = bpf_flow_exit(env, state, env->insn_idx);
    scev.c:bpf_compute_loop_iters(): if (!call && !bpf_flow_is_needed(env, insn_idx, r))

Does flow.o link with CONFIG_BPF_SYSCALL=y?  The five functions that keep
their prototypes are undefined references, and the others are implicit
declarations.  Only the scev.c reference goes away, in 885b6e36bec3
("bpf: Delete scalar evolution").  At a50a112fb866, verifier.c still calls
all of the others and none is defined.

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> --- a/kernel/bpf/join.c
> +++ b/kernel/bpf/join.c
> @@ -1,627 +1,6 @@

[ ... ]

Is the join deletion complete?  join_range() was the only caller of
scalar_widen(), and this commit also deletes struct bpf_loop_rungs, but
scalar_widen() stays in verifier.c:

    void scalar_widen(struct scalar *s, const struct scalar *old,
                      const struct bpf_loop_rungs *rungs, int linear)
    {
            ...
            ((max > cnum64_smax(old->r64) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
             (min < cnum64_smin(old->r64) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
            ...
                    if (rungs && rungs->has_max && max <= rungs->max[1])
                            stop = min(stop, max <= rungs->max[0] ? rungs->max[0] : rungs->max[1]);

Nothing defines the struct, so the prototype declares it at parameter scope
and verifier.c dereferences an incomplete type, which is a hard error
whenever CONFIG_BPF_SYSCALL=y.  No later commit in the range touches
scalar_widen() or bpf_loop_rungs.  Should scalar_widen(), its prototype and
the @rungs/@linear kernel-doc go together with join_range(), or should
struct bpf_loop_rungs be kept if the new pass is meant to call it?

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -648,13 +374,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>  	return true;
>  }
>
> -static void reset_idmap_scratch(struct bpf_verifier_env *env)
> -{
> -	struct bpf_idmap *idmap = &env->idmap_scratch;
> -
> -	idmap->cnt = 0;
> -}
> -
>  /* Everything that @cur describes is described by @old. */
>  bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
>  			struct bpf_verifier_state *cur)

Can states.c compile after this?  The commit deletes check_ids(),
regs_exact(), regsafe(), stack_arg_safe(), refsafe(), loop_stack_safe() and
reset_idmap_scratch(), but keeps their callers:

    stacksafe():          regsafe(), check_ids()
    func_states_equal():  check_ids(), regsafe(),
                          stack_arg_safe(env, old, cur, &env->idmap_scratch),
                          loop_stack_safe(env, old, cur)
    bpf_state_subsumes(): reset_idmap_scratch(env),
                          refsafe(old, cur, &env->idmap_scratch)

None of these names is defined anywhere after this commit, and
scripts/Makefile.warn sets -Werror=implicit-function-declaration, so
states.o fails to build.  range_within() also loses its only caller
(regsafe()), which gives -Wunused-function until b63f08629edd ("bpf: Add
equations and their arithmetic") adds scalar_subsumes().

At a50a112fb866 ("bpf: Delete the equations that say nothing") stacksafe(),
func_states_equal() and bpf_state_subsumes() still call
check_ids(), regsafe(), stack_arg_safe(), loop_stack_safe(),
reset_idmap_scratch() and refsafe(), and none of them is defined.

The break looks avoidable: once flow.c and join.c lose their callers,
bpf_state_subsumes() has no callers left, and the chain
bpf_state_subsumes() -> func_states_equal() -> stacksafe() is unreachable
and is the only user of the deleted helpers.  The commit message says it
deletes "the compare of registers and references".  Could that chain be
deleted together with its helpers, or the helpers kept until the patch that
rewires bpf_state_subsumes()?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23104,44 +22585,6 @@ static int do_check_main(struct bpf_verifier_env *env)
>  	return ret;
>  }
>
> -/*
> - * What stops a loop is assumed before the main pass and checked in it, see flow_is_bound(). The
> [ ... ]
> -static int do_check_all(struct bpf_verifier_env *env)
> -{
> -	struct bpf_func_info_aux *sub_aux;
> -	u64 log_pos = env->log.end_pos;
> -	int i, ret;
> -
> -	for (;;) {
> -		bpf_flow_new_round(env);
> -		ret = do_check_main(env);
> -		ret = ret ?: do_check_subprogs(env);
> -		if (!round_is_dropped(env))
> -			return ret;
[ ... ]
> -}
> -
>  /*
>   * What it took to verify a static subprog on its own is not in insns_total of its callers.
>   * Add it, once per caller. The main prog and global subprogs have all of it already.

Does bpf_check() still compile?  do_check() and do_check_all() are deleted,
but their callers remain:

    do_check_common():  ret = do_check(env);
    bpf_check():        ret = bpf_flow_prepare(env);
    bpf_check():        ret = do_check_all(env);
    bpf_check():        bpf_flow_free(env);

No header declares do_check() or do_check_all(), so verifier.o fails with
an implicit declaration error, and bpf_flow_prepare()/bpf_flow_free() are
undefined at link time.  The same goes for bpf_flow_deliver() in
do_check_block(), and for bpf_flow_reset(), bpf_flow_call() and
bpf_flow_exit() in free_states(), call_func_on_its_own() and
exit_func_on_its_own().  With do_check_all() gone, do_check_main(),
do_check_subprogs(), round_is_dropped() and do_check_block() have no
callers left, and the comment above round_is_dropped() ("see
do_check_all()") points at a function that no longer exists.  At
a50a112fb866 verifier.c still calls do_check(), do_check_all(),
bpf_flow_prepare() and bpf_flow_free(), and none is defined.

[ ... ]

Is check_loop_guard() meant to keep working?  This commit removes the walk
accounting from account_processed_insn(), but check_loop_guard() is left
as it was and still calls bpf_loop_walk_may_give_up(entry) and reads
entry->terminates, entry->guarded and entry->loop_id.  Those are gone with
struct loop_stack_entry, so the function is undeclared and the type is
incomplete.  iter_stops_loops(), loop_stack_pop() and
maybe_clamp_scev_regs() also still use struct loop_stack_entry members,
and loop_stack_pop() and maybe_clamp_scev_regs() lose their only callers
(bpf_flow_loop_leave() and bpf_flow_loop_enter()).  At a50a112fb866 the
check `if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))` is still
in check_loop_guard() and the function is not defined anywhere; the
struct loop_stack_entry restored at the tip has no loop_id, terminates or
guarded member.  A smaller split would be to delete the old pass in the
commit that adds its replacement, or to stub the remaining call sites
(check_loop_guard(), do_check(), do_check_all()).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============1447305057873354971==--
