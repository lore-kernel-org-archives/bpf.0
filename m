Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915506;
	b=3kaCcnyBcdUdCX/4gk8RBzcZsI2VfjWumR03sSDyIGr01+72tDouVuZVkICG5pauA8BB
	 YEbIRDNjXc5Jdj8x60H3cErljnBOZ0/U9YLFYx4uRMMlRVDotBotMbSo2IKEm1ubdbjtd
	 PQNDzcuMC8ENvPh7uyxuBoo0gbDtbSYp5H54DCRKxkkDNXsoEe5rq/+GaTCng4gv+T7Tk
	 j2gxrilFp6TSdfKFnoq84lwZwejMm+a4acq7wJEDcQWNQkkekrzyBEkZIxoShazm+RmUh
	 tLPPGslEyw6sREfT+E+B9aPqfabnka5Qwy9Zp7E5m5GExhCk+8ghIUhlZa5m/rdJcRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915506;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TCn8q2bANHjlUF81ge/KB1U7YzukXGYOD54hEgcSedk=;
	b=AEdic9+xP3KkDAyF3CfkfK8JN3V0jIk0J6NfDCce/KnbT505QVwkTsdp0Nl8Kg9t1edY
	 LsLthl5UxNZipmdRR+xeCSWGJlqE4myYVTE5fhUDss8gwYoSoKo8RBXBmHqnlZRYQhoa9
	 Mneiqx5ElNVbGm/2TLWAEJqq2O8h6/+geRQwA1N4el2muArTbX2aYVD/fC7qBhtm0/FWu
	 XEe6wI4plEk14l2++yr4jWC0Jytiq+7tjY9ywt1mwFytfwzsuJozK/uoJ9FhEfK28EPxS
	 peuQre7zLFWta7zI/QUCRYgkr2ivb3OlNqxliJfVF97vMpG0DNteuBgkZOGEaLo272g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAuAyuBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5291606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAuAyuBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124AB1F0089F;
	Thu,  5 Nov 2026 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915505;
	bh=TCn8q2bANHjlUF81ge/KB1U7YzukXGYOD54hEgcSedk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WAuAyuBM5GEgM9b2cHVOF70gke3gX1QCG4CSWVQSOJ9ZTUZ4LEVKXQIpw2/gb+NcS
	 DgM/Eeu0alLF4LZdAbBXHhbhwtT0OEEPutJrFX/9bdwE73yBAFrYxOnOvkKDe30Yzd
	 3XRrs+7EeuC6wE2obEBf/XdXynOzbpCLuud3ufs6akh4HcoxwIUb7O/v1zGp+BUD9i
	 CVo9dmWYrOG6JAlUKeTyA96sVBtBSbsvFRByBZ2dJb5oSE+T9U0ctM8VIgdNdwFnKA
	 hICQJjIGVIt8fv3pZTtE9LvwBCan+55nvbiqfudI/LN9A/+QOjuJhoQE4MgVh6MhUo
	 MAtG4tSsFi2ag==
Content-Type: multipart/mixed; boundary="===============2863668149325531182=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fbc6a76bd8cb0b115a602fe1f8064612f09afac8924a23ae5d64cf4e7fe68b43@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-22-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-22-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 21/35] bpf: Verify static subprogs on their own
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:51:45 +0000 (UTC)

--===============2863668149325531182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify static subprogs on their own

TL;DR:
- Speculative exits of a subprog verified on its own may be delivered to
  callers as non-speculative, so safe programs could be rejected
- BPF_LOG_STATS insn totals may double count mixed in-frame/on-its-own calls

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* The current state is at exit of a function that is verified on its own. */
> +static int exit_func_on_its_own(struct bpf_verifier_env *env)
> +{
> +	struct bpf_verifier_state *state = env->cur_state;
> +	struct bpf_func_state *callee = state->frame[0];

[ ... ]

> +	account_current_path(env);
> +	err = bpf_flow_exit(env, state, env->insn_idx);
> +	return err ?: PROCESS_BPF_EXIT;
> +}

Can a speculative state reach this exit and be handed back to the waiting
callers as an architectural state?

func_is_on_its_own() refuses a call made on a speculative path, so the
waiting call w->st is never speculative.  Inside the callee, speculative
paths are still pushed as usual.  For example, check_cond_jmp_op() calls
sanitize_speculative_path() when !env->bypass_spec_v1 (CAP_BPF without
CAP_PERFMON).  Such a path can run to the BPF_EXIT of the callee, go
through process_bpf_exit_full() -> exit_func_on_its_own() ->
bpf_flow_exit(), and be stored as a separate exit.

Then flow_apply_exit() does, for each waiting call:

    err = bpf_copy_verifier_state(&st, &w->st);   /* st.speculative == false */
    if (!err)
        err = bpf_flow_return(env, &st, &x->st, call_idx);
    if (!err)
        err = bpf_flow_deliver(env, &st, call_idx + 1, call_idx);

bpf_flow_return() copies R0/R2, refs, unwound and changed_pkt_data from the
exit, but does not look at exit->speculative.  The caller continues as an
architectural path with register values that only exist under
misprediction.

Before this patch, prepare_func_exit() popped the frame and kept
state->speculative, so the code after the call was checked speculatively
and do_check_block() could turn a recoverable error into a nospec barrier
through error_recoverable_with_nospec().  Now the same error is fatal.

For example, loaded with CAP_BPF but without CAP_PERFMON:

    static __noinline int f(int x) { if (x == 0) return 0; return 8; }
    ...
    r0 = f(0);              /* entry { r1 = 0 } */
    p = map_value_of_8_bytes;
    p += r0;
    *(u64 *)p = 1;

In f(), "if r1 == 0" is known taken, so the fall-through branch is pushed
speculatively and reaches exit with r0 = 8.  join_check_state() does not
join it with the non-speculative exit, so the caller gets r0 = 8 as a real
path and the store is rejected as an out-of-bounds map access, where the
old verifier only set nospec.

The same happens when a speculative path skips a release that the real
paths always do: the waiting caller inherits a reference and fails with
"Unreleased reference" at its own exit.  The extra non-speculative states
also widen the joins of real states after the call.

Should bpf_flow_return() or flow_apply_exit() carry the flag over, for
example caller->speculative |= exit->speculative, so that the code after
the call is still checked speculatively?  I did not find a later commit in
the series that handles speculative exits.

> @@ -20839,6 +21014,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
>  {
>  	struct bpf_func_state *cur_frame = cur_func(env);
>  
> +	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
> +		return exit_func_on_its_own(env);

This branch sends every frame 0 exit with flow_entry set to
exit_func_on_its_own(), speculative states included.  Speculative paths
start inside the callee via push_stack(env, ..., true), which copies
flow_entry through bpf_copy_verifier_state().

bpf_flow_exit() keeps them apart from non-speculative exits, and
flow_apply_exit() then applies them to every waiting call as described
above.  Would it make sense to propagate the speculative flag into the
caller state here or in bpf_flow_return()?

[ ... ]

> +/*
> + * What it took to verify a static subprog on its own is not in insns_total of its callers.
> + * Add it, once per caller. The main prog and global subprogs have all of it already.
> + */
> +static void add_insns_of_callees(struct bpf_verifier_env *env)
> +{

[ ... ]

> +			c = bpf_find_subprog(env, j + insn[j].imm + 1);
> +			if (c <= 0 || c == s || !si[c].on_its_own || added[c] == s)
> +				continue;
> +			added[c] = s;
> +			si[s].insns_total += si[c].insns_total;

Can the BPF_LOG_STATS totals count the same insns twice here?

on_its_own is one bit per subprog, set in call_func_on_its_own() when any
call of c was verified on its own.  Other calls of c can still be verified
in the caller's frames (PTR_TO_STACK or dynptr argument, maybe-NULL
pointer, a non-held id), and so can a call that is re-verified in the
caller's frames after bpf_flow_return() returns 1 for releases_inherited or
changes_pkt_data.

For an in-frame call, account_processed_insns() adds the callee frame's
insns both to si[c].insns_total and to the caller's insns_subtotal:

    env->subprog_info[callee->subprogno].insns_total += insns;
    if (caller)
        caller->insns_subtotal += insns;

So for main -> s, where s calls c once with a stack pointer (in frame) and
once with a scalar (on its own), si[c].insns_total = A (in frame) + B (on
its own), and si[s].insns_total already holds A.  This loop then adds A + B
to s, so A is counted twice.  A static caller t that has only in-frame
calls of c also gets all of c's total if another caller's call of c was on
its own.

Are the comments "a call of it was verified on its own: its insns are not
in insns_total of the caller" and "What it took to verify a static subprog
on its own is not in insns_total of its callers" accurate for these mixed
cases?  This only affects the numbers printed by BPF_LOG_STATS.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============2863668149325531182==--
