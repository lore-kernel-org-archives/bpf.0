Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163133;
	b=DGQo2XZIPcXIcQnp0ywy9vMlvTgcB0rn0pZ849Ym4IuXu6ODLJ9/vQYLyaof8R6VtoaA
	 cjCd1LUUs7bM+MlwvMzpsLnimT8RCn8DmZmdpZlX60JwsERpaOB7WLw/zpdwx/+YAwWb7
	 P2MlDG6AJ7xn1CiWt6xzdpYJBQ9rrFjb0toYuJbAq9+ott5VqHvo3nkxZXW8RMjB6ilUD
	 V3xghk+j8NxklouHfUYEen9vvC4BGKmjCSphkjoU3bB1Q5VbcrIj/2zGgIw8AQOUCkERo
	 yiWXVpimbffUwYxSj6pWlIc3f4Td25aH+JDaRb3GZU0quNuJnDeppJ0KUONL28cluoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163133;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=K9U7slNSg5vtm046+zJ09iw7P+eiqGOK3f3o/AN2tL8=;
	b=jfNCZhdgeRKecy3rLfHWMbCegi9ChafDZHPtMaSH9u7uQIEAQJbiCyO1opMN2zST3HP1
	 qwPx8LSz7u9FU4tI6ikETxIo+cFWjHugz24IRA/Wn3EprwwlGZOW5erFgOyBdJAb30Eey
	 hYnmYjcoxFiyFymU39+eizbSUE3h4tt683RCZ2M/zppx7uQPq57keEAYH01l+R7GyhFif
	 Kw1EUpTAPtdAtDWVru6UgYan/3mTz7shOMp00heQ0DuA3tJBBLSTSUJ4+UNEL5BwvQRUf
	 uoD78qe8tuCf0ysXcErnM++u2FtCLNbhGHgqhbS4PIHHfw97PuuaFwq9qQ3wMPf4gjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI7E+ySI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104E606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI7E+ySI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D81F000C4;
	Fri, 20 Nov 2026 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163132;
	bh=K9U7slNSg5vtm046+zJ09iw7P+eiqGOK3f3o/AN2tL8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DI7E+ySIW+ggOfGjDx9T5Qru/2KgtSuEhofG1wuFY/1QBdRnZ9VxX9c+QzasOB2BF
	 PeoPH6iRwGj6cw0OuVPAkZTIPHk+F41LNerUu4jgQarxBxVltKwxn3ONfxkFaRTtPL
	 /wglw02Y5hxa5WiYFPVcV7OM1weK/0gltor2YHvmRVhWt9zWq0unZmX+TgqRiJ2njG
	 kzTg+UmjeMhed9fht9oiBkC0XBpxpfzfby07VqL0m71NkYYUKqa6L7On6vcE1B4OFF
	 Ko4OhWPXF47QWVk89x6i9SsClZImYyBxc1FBY8+OkVfAvy+O5GJ/zKZW6MepSxwSOs
	 bJsSBubIovwLg==
Content-Type: multipart/mixed; boundary="===============1890503310734702141=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <087c22921fc8e543a74a5aeba248957dfc70c312789843430666ebb95451d4d2@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-16-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-16-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 15/49] bpf: Peel the first trips of a loop and join the other trips
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:31 +0000 (UTC)

--===============1890503310734702141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Peel the first trips of a loop and join the other trips

TL;DR:
- check_loop_guard() still uses removed loop_stack_entry members, so it likely
  fails to compile
- Peeling and loop-stack code is never reached: no writers or callers, unused
  flow_new_call_loop()
- enter_recursion() may update the caller's state instead of the callee's

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cc90e237d535..77f1fe969a2a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -420,6 +422,24 @@ static inline u32 bpf_xreg_to_spi(u32 xregno)
>  	return xregno - MAX_BPF_EXT_REG;
>  }
>  
> +/*
> + * A state in a loop, see bpf_flow_loop_enter()
> + *
> + * entry -> [0] -> [1] -> ... -> [d-1] -> +----------+ <--+
> + *          peeled trips, kept apart      | LEFTOVER |    |
> + *                                        |  widened |----+
> + *                                        +----------+
> + */
> +struct loop_stack_entry {
> +	struct bpf_loop *loop;
> +	/* How many times the state came back to the header. A join has the larger number. */
> +	u32 trip;
> +	/* The state that entered the loop. What comes back to the header is for that state. */
> +	u32 entry_id;
> +	u32 held_cnt;		/* when the state entered the loop */
> +	bool peeled;		/* in a peeled trip, not in the leftover */
> +};
> +

The members loop_id, terminates and guarded are gone from
struct loop_stack_entry.  iter_stops_loops(), loop_stack_pop() and
print_verifier_state() are converted, but check_loop_guard() in
kernel/bpf/verifier.c, which do_check_block() calls for every insn, is
not:

	if (loop->rt_bounded || !env->insn_aux_data[env->insn_idx].guard_place ||
	    entry->loop_id != h)
		return 0;
	if (verifier_bug_if(!entry->terminates && !entry->guarded, env,
			    "nothing stops the loop at %d", h))
		return -EFAULT;
	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
		return 0;

Doesn't this fail to compile, since entry->loop_id, entry->terminates and
entry->guarded no longer exist?

Even once it compiles, check_loop_guard() decides whether a loop needs a
may_goto exit from terminates and guarded, and the verifier_bug_if() assumes
one of them is set.  The new peeled/leftover entries carry neither.  Should
the guard logic be restated in terms of entry->loop and entry->peeled?

iter_stops_loops() also no longer skips a loop with a known trip count
(the old "if (entry->terminates || stops) continue;"), so it now calls
bpf_flow_next_is_no_bound() for such loops.

None of the later patches up to a50a112fb866 ("bpf: Delete the equations
that say nothing") touch check_loop_guard().

[ ... ]

> @@ -766,8 +812,29 @@ struct bpf_loop {
>  	u32 nr_insns;
>  	/* not rt_bounded: there are places for may_goto, see guard_to in bpf_insn_aux_data */
>  	bool has_guards;
> +
> +	/* What one pass gives to the next pass */
> +	struct_group_tagged(bpf_loop_precision, precision,
> +	u32 peel_cnt;		/* trips before the leftover */
> +	/* while bpf_loop_per_pass.cost is not above @budget: */
> +	u64 budget;
> +	u32 max_peel_cnt;	/* peel up to this trip */
> +	);
> +	bool partitioned;	/* the last partition was for this loop */
> +	struct bpf_loop_per_pass this_pass;
>  };

Is anything writing peel_cnt, max_peel_cnt, budget, partitioned or
suspect_bit, or this_pass.cost and this_pass.has_unproven?  I could not
find a writer in this patch or later in the series.

The precision group is never read or copied between passes either.  Since
the struct is zeroed at allocation, try_peel_trip() sees:

	if (entry->trip >= loop->peel_cnt &&
	    (entry->trip >= loop->max_peel_cnt || !bpf_loop_partition_is_active(loop)))
		return false;

which is always true for peel_cnt == 0 and max_peel_cnt == 0, so no trip is
ever peeled.  this_pass.peeled_cnt then stays 0, and
check_held_in_leftover() uses it as the allowance for locks.  Likewise
"st->suspect_loops |= entry->loop->suspect_bit" always ORs in 0.

The commit message says "A later pass peels if an error asks for it, see
try_peel_trip()".  Can any code path peel a trip with this patch applied?

Similarly, scalar.grew_once is only ever cleared, and the join_range()
function that its comment refers to is not in the tree.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index cbbc663acac8..2c1835d1b3ef 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
> @@ -311,3 +311,20 @@ int bpf_check_limits(struct bpf_verifier_env *env)
>  	env->over_limit = true;
>  	return -E2BIG;
>  }
> +
> +static struct bpf_loop *flow_new_call_loop(struct bpf_verifier_env *env, enum bpf_loop_kind kind,
> +					   int header, int func)
> +{
> +	struct bpf_loop *loop = kvzalloc_obj(*loop, BPF_VERIFIER_GFP);
> +
> +	env->mem += sizeof(*loop);
> +	if (!loop)
> +		return NULL;
> +	loop->kind = kind;
> +	loop->header = header;
> +	/* the helper stops, the function checks the stack, see check_recursion_guard() */
> +	loop->rt_bounded = true;
> +	loop->nr_insns = func < 0 ? 1 :
> +			 env->subprog_info[func + 1].start - env->subprog_info[func].start;
> +	return loop;
> +}

Is flow_new_call_loop() ever called?  It is static and nothing in the tree
calls it, so gcc and clang will warn about an unused function, which breaks
the build with CONFIG_WERROR=y.

It is also the only allocator of BPF_LOOP_CALLBACK and BPF_LOOP_RECURSION
loops, so insn_aux_data[].callback_loop and .recursion_loop are never set
(only reset to NULL in bpf_clear_insn_aux_data()).  enter_callback() and
enter_recursion() then always take their "if (!loop) return 0;" path.

In the same way, bpf_flow_loop_enter() is declared in bpf_verifier.h as
"/* verifier.c, for flow.c */", but nothing calls it, so loop_stack_push()
and loop_stack_pop() never run.  The commit message says "The calls of a
callback and recursive calls go around like the body of a loop" and
"bpf_flow_loop_enter() keeps the loop stack of a frame".  Should the
callers be added here, or the unused allocator and declaration be left out
until a patch uses them?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c0a83c10cf27..808adc4b7f82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11497,6 +11525,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
>  		return -ENOMEM;
>  	entry.frame[0] = callee;
>  	entry.in_sleepable = state->in_sleepable;
> +	entry.suspect_loops = state->suspect_loops;
>  	entry.callers_unknown = state->callers_unknown;
>  	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
>  	/* the frame that says so is not there when the function is verified */
> @@ -11504,7 +11533,8 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
>  	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>  		if (live & BIT(i))
>  			callee->regs[i] = caller->regs[i];
> -	err = grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->subprog_info[subprog]));
> +	i = bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
> +	err = grow_stack_arg_slots(env, callee, i) ?: enter_recursion(env, callee);
>  	if (err) {
>  		bpf_free_verifier_state(env, &entry, false);
>  		return err;
> @@ -11517,6 +11547,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
>  		bpf_free_verifier_state(env, &entry, false);
>  		return err;
>  	}
> +	entry.max_held_cnt = state->max_held_cnt;
>  	callee->entry_refs = entry.acquired_refs;
>  	callee->entry_rcu_locks = entry.active_rcu_locks;
>  	callee->entry_preempt_locks = entry.active_preempt_locks;

[ ... ]

> +/* @callee is the frame of a function that is verified on its own */
> +static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_state *callee)
> +{
> +	u32 cycle = env->subprog_info[callee->subprogno].cycle;
> +	struct bpf_loop *loop = env->insn_aux_data[env->subprog_info[cycle].start].recursion_loop;
> +	struct loop_stack_entry *entry, *from = env->cur_state->frame[0]->loop_stack;
> +	bool starts_leftover;
> +	int err = 0;
> +
> +	if (!loop)
> +		return 0;
> +	entry = push_loop(env, callee, loop);
> +	if (!entry)
> +		return -ENOMEM;
> +	starts_leftover = !try_peel_trip(entry);
> +	if (env->cur_state->frame[0]->loop_stack_cnt && from->loop == loop) {
> +		*entry = *from;
> +		starts_leftover = false;
> +		err = next_trip(env, entry, &starts_leftover);
> +	}
> +	if (starts_leftover)
> +		leave_peeled_trips(env, entry);
> +	return err;
> +}

enter_recursion() works on the callee frame of the local "entry" state that
call_func_on_its_own() is building, but leave_peeled_trips() and
check_held_in_leftover() act on env->cur_state, which is the caller's
state.  Can this write to the wrong state?

leave_peeled_trips() does:

	bpf_for_each_reg_in_vstate(env->cur_state, frame, reg, reg->grew_once = false);

so the grew_once flags of the waiting caller are cleared, while the
callee's R1-R5 (copied from the caller just before enter_recursion())
keep the caller's grew_once values.  The stack args are copied after the
call and do get the cleared values.  With try_peel_trip() always false in
pass 0, this happens on every first call into a recursive function from
outside its cycle.

Also, next_trip() -> check_held_in_leftover() sets
"st->suspect_loops |= entry->loop->suspect_bit" and st->max_held_cnt on the
caller's state.  call_func_on_its_own() copies max_held_cnt after
enter_recursion() but suspect_loops before it:

	entry.suspect_loops = state->suspect_loops;
	...
	entry.max_held_cnt = state->max_held_cnt;

so the callee path does not carry the suspect bit of the recursion loop.
Should leave_peeled_trips() run on the callee entry state, and
entry.suspect_loops be copied after enter_recursion()?

Separately, the other loop entry points treat env->path_sensitive
specially, for example in enter_callback():

	if (env->path_sensitive)
		return failing_path_trip(env, entry);

enter_recursion() has no such branch.  func_is_on_its_own() does not look
at path_sensitive, so in a path-sensitive run a first recursive entry that
cannot peel sets loop->this_pass.has_leftover, clears entry->peeled, and
never calls failing_path_trip() for trip 0.  The cleared peeled flag is
copied into re-entries by "*entry = *from" and reaches
exit_func_on_its_own(), which calls check_held_in_leftover() without
checking path_sensitive.

Is a "if (env->path_sensitive)" branch missing in enter_recursion() for the
first entry?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============1890503310734702141==--
