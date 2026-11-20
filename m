Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163124;
	b=2lZnw4cqEswLwZiS9audOzydsxJ8mGTiQZBKYRY8MkfSoX+jq0IIc5zEALDzKvC5xAQI
	 YfkBdBgkTayXMfpacFJxKxL5cJvHtsVGOa2jIVAES9ZnGVgdDTfd1EVUcIaxJC/j6BsBD
	 jly4FY01oSUhwr/DlBuCCcMiWMhETUe3Ox3XNx94Tbq0ZJQNT55zZY4L0kKZhIy/mITuY
	 xXiMprX9MxSSLrKgFx2tmrIgGmPjJkCTpv6mKc7Y0Ya0CyQpCN0kWWEvtCKxbCDhBPuP5
	 OWoGjwNMIxlpBdDEPamz4NK9EWbwc12auIbqnjYREZs4rUp+/HuOgmvR/YBzBzZkUiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163124;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ntqtj8WJOB7cPSF/Nl6RQcNzYdoM5cYgbl1NqNCdeLU=;
	b=3apXFeMYvS1hYxC3Ef04OSld4FMMXuyqDUon5bqg3Uk6IG0+CCOx0LGfVklrbJZjfyFv
	 0SL/h88wwPbqjYO7AtIdtvfbFkmqaeHW+eZbHz10SLGo+7zt3UOgsLHzQG2DjOWZIgUo8
	 d3cgNrIHR0eZGQFgrIN+bttxXjNU2YAy9NhCBfC2IamhCFiee+VW/Wfo+64mAwmDY3xMR
	 Qc67tKa/rikPfCcfzGd8lEy96VXJMFaJcYxUmMR4Px1+onRhYgYeejGEvi7IEyE7D13oY
	 MZgReOqs1nzkRYR2RBv960DqCUBXczhrjsRJLLAnaQX2OGJXHywtwLp9pJNaTPEstfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDa3xpS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9881606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDa3xpS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8031F000C6;
	Fri, 20 Nov 2026 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163123;
	bh=ntqtj8WJOB7cPSF/Nl6RQcNzYdoM5cYgbl1NqNCdeLU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PDa3xpS9YHqeYtju0wkvt1fHmWAKzgwYENNFHGv+MXlgG3P8W/hYEy61sHWk6p3BI
	 nT1fxYwKI+uZ2BPRZUMIxN4DUTfVSufTQLfgnMK7sorLEINXyKlEAxmNJHzIRRpRdu
	 scqRtPq4O6kqXqafktUjuePT3RHQMSraAd42bl28DEZU0Fozl1WVgaTWLoaAhw1k+U
	 obHXRMvmCDgHo/lqEGZc4TwUvibKvGwB736V1SfKfvTvGsxyyz4cCur5D+qiqPrEir
	 ka4KL1dP7B4w5iisfwdbkF8pbnRAvBaQOg7I92QLk5hHoSOQQYf92QgqYnhJAxbgNu
	 cVK2ts2JvRS5A==
Content-Type: multipart/mixed; boundary="===============0396688676479576007=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b3d11041808b151f2294de5bfc9e8454baf6d7e4832c43a311d06dc30040567a@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-10-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 09/49] bpf: Check fixups in the main pass and keep a snapshot of them
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:22 +0000 (UTC)

--===============0396688676479576007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check fixups in the main pass and keep a snapshot of them

TL;DR:
- Possible unsafe program free: sleepable_async_cb flag never read, so wq
  callback may outlive program
- Snapshot restore may drop callx edges, letting stack depth check pass
  wrongly
- check_after_pass() never called, so checks vanish; undefined function breaks
  build

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1184,13 +1189,23 @@ struct bpf_verifier_env {
>  	u64 max_cost, max_mem;
[ ... ]
> +	bool seen_exception;
> +	bool sleepable_async_cb;
> +	u32 id_gen;			/* used to generate unique reg IDs */

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11316,7 +11325,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>  		if (IS_ERR(async_cb))
>  			return PTR_ERR(async_cb);
>  		if (is_async_cb_sleepable(env, insn))
> -			mark_sleepable_async_cb(env);
> +			env->sleepable_async_cb = true;
>  		callee = async_cb->frame[0];

Does anything read env->sleepable_async_cb?  mark_sleepable_async_cb() was
the code that set prog->aux->sleepable_async_cb and ran:

	for (i = 0; i < env->used_map_cnt; i++)
		atomic64_inc(&env->used_maps[i]->sleepable_refcnt);

It now has no caller, and neither copy_snapshot() nor check_after_pass()
looks at the new flag.

With that, bpf_prog_runs_sleepable() returns false for a non-sleepable
program that sets a bpf_wq or bpf_task_work callback.  Such a program is
freed after a plain RCU grace period, and its maps do not count it as a
sleepable user (bpf_map_fd_put_ptr(), bpf_local_storage).

bpf_wq_work() runs the callback under rcu_read_lock_trace() only, so can
the program or its JIT image be freed while the callback runs?  That would
bring back the problem fixed by 1e28a5e52d32 ("bpf: Keep a program until
its bpf_wq callback has ended").

The refcounts presumably cannot be taken during a pass because a restored
snapshot cannot undo them.  If so, the call to mark_sleepable_async_cb()
after the last pass when env->sleepable_async_cb is set is not documented
in the commit message, and no commit in this series range does it.  Maybe
the later "bpf: Verify in passes" patch adds it?

[ ... ]

> @@ -12613,6 +12624,14 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
>  	return &env->insn_aux_data[env->insn_idx];
>  }
>
> +/* An insn has one fixup for all states. The state that was here first can be wrong too. */
> +static int fixups_differ(struct bpf_verifier_env *env, const char *msg)
> +{
> +	verbose(env, "%s\n", msg);
> +	bpf_note_fixups_differ(env);
> +	return -EINVAL;
> +}

bpf_note_fixups_differ() is not declared or defined anywhere in the tree,
at this commit or at a50a112fb866.  Doesn't
-Werror=implicit-function-declaration make verifier.c fail to build here?

The same goes for the rest of the new code.  check_after_pass(),
save_snapshot() and restore_snapshot() have no callers in this commit or
in the range, and nothing uses struct bpf_snapshot.  The tree has not built
since 32e8f52de3c8 ("bpf: Delete the old main pass of the verifier"), which
says "bpf: Verify in passes" restores the build, and that patch is outside
this range.  Should that patch define bpf_note_fixups_differ() and call
check_after_pass() and the snapshot helpers, or can this be arranged so
that each patch builds?

[ ... ]

> +static void copy_snapshot(struct bpf_verifier_env *env, struct bpf_snapshot *snapshot, bool save)
> +{

[ ... ]

> +	for (i = 0, sub = env->subprog_info; i < env->subprog_cnt; i++, sub++) {
> +		/* the sum over all passes */
> +		snapshot->subprogs[i].insns_total = sub->insns_total;
> +		snapshot->subprogs[i].insns_self = sub->insns_self;
> +		COPY(snapshot->subprogs[i], *sub);
> +	}

Is it correct to snapshot all of struct bpf_subprog_info here?  That
includes callx_edge, the head of a per-caller list whose storage,
env->callx_edges, and dedup index, env->callx_index, are not snapshotted
and never reset.

record_callx_edge() returns early when the edge is already indexed:

    if (bpf_index_find(&env->callx_index, key) >= 0)
        return 0;

After restore_snapshot(), subprog_info[caller].callx_edge goes back to its
saved value (0 when the snapshot predates the first pass).  When the next
pass reaches the same call, record_callx_edge() finds the key and does
nothing, so the edge is never linked again.

build_call_graph(), used by check_max_stack_depth() from check_after_pass(),
takes callbacks and callx targets only from si[s].callx_edge.  Then the
callback is not marked CG_LIVE through its caller, check_call_depth() does
not add its frame to the caller's chain, and check_recursion() and the
tail-call marks miss paths through it.  For example, a main program using
400 bytes of stack that calls bpf_loop() with a 400 byte callback could
pass the combined depth check.

The reverse also looks wrong: an edge recorded only on a path that the
snapshot is meant to forget stays in callx_index.

[ ... ]

> +/* What the pass found about functions and about the program has to be consistent */
> +static int check_after_pass(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *sub = env->subprog_info;
> +	u16 outgoing;
> +	int i, err;
> +
> +	err = check_max_stack_depth(env) ?: check_ext_takes_prologue(env);

[ ... ]

> @@ -24334,16 +24479,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
> -	if (ret == 0)
> -		ret = check_max_stack_depth(env);
> -

Nothing calls check_after_pass(), and this hunk drops the only other call
to check_max_stack_depth().  Doesn't that mean the following checks run
nowhere at this commit?

- the combined stack depth, check_call_depth(), check_tail_calls(),
  check_callbacks(), check_exception_cb() and the private stack mode
- the removed BPF_PROG_TYPE_EXT checks in bpf_convert_ctx_accesses()
  ("Extension writing packet data must take ctx and scalars only" and
  bpf_check_ext_prologue())
- the "func#%d writes %u stack arg slots, but calls only require %u" check
  in bpf_fixup_call_args()
- the "uses R%d and is both called and a callback" check in
  bpf_insert_arena_stack()

bpf_convert_ctx_accesses() still applies the prologue when gen_prologue()
returns cnt > 0.  An extension replacing "int f(int x, struct __sk_buff
*skb)" that writes packet data would get a prologue that reads R1 as the
context while R1 holds a scalar.

mark_arena_stack_entries() and max_arena_stack_depth, which
bpf_insert_arena_stack() depends on, are also only reached through
check_max_stack_depth().  The stack depth shrink in
bpf_remove_fastcall_spills_fills() moved there as well, so the new comment
there, "check_max_stack_depth() has adjusted the stack depth of
subprograms", is not true at this commit.

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -840,9 +840,9 @@ static void keep_funcs_with_addr_taken(struct bpf_verifier_env *env)
>  		if (aux_data[t].seen)
>  			continue;
>  		memcpy(insn + t, &trap, sizeof(trap));
>  		aux_data[t].zext_dst = false;
> -		aux_data[t].seen = env->pass_cnt;
> +		aux_data[t].seen = env->check_cnt;
>  	}
>  }

pass_cnt is renamed to check_cnt, but bpf_opt_hard_wire_dead_code_branches()
still has:

	aux_data[i + 1].seen = env->pass_cnt;

No pass_cnt member is left in struct bpf_verifier_env, so doesn't fixups.c
fail to build here?  931721673c10 ("bpf: Put a barrier where no mask fits")
happens to rewrite that block later, so this commit and de9dd94c5b76 break
bisection.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============0396688676479576007==--
