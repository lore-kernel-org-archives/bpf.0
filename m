Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802493;
	b=m4ZHJ/79c6dQb9e/SyWID+MRiBaeVMYnmhmB9UYaBadWrOPO584ZCm9ByrsNm+HhSQN9
	 iOpVIYLDaG1HXL3x9NOklVHWbdP8uHzxzks9/xSbCnxSnouMzym3TC9ZVNNczQPbafVn6
	 WTJSp7OVgNzvTxcE40gkD3mygpl0wTmQky//7ASKLg752PofWHLlVvXX3jY8mHfmewAG0
	 ErDhG45B1Emb4zju+0FjNWm+J6UNJ6mDTSc7zuR23mxA/dRCl0V+pJ4yaEEyI/0S4YG6+
	 RMb1Vu4RIueQoRqdr+DLEoyiiZ8qEM2BTwR1zVzhTqPCH42b3q3wcfflk/uXeob0AQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802493;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1kXTjsaIGX2NschUsRNIU4GhotpCvltijPNZq+/9BPk=;
	b=OQLOJ4O+zSh4urB2D3Wa5rOjY3F2lNcLapktfW3P52+PmQM2HG1kgRyIV4UJsl994XnI
	 Dj/CkD+XvAKbcjDIKIQGEuDAC5l9yo0a3zwhxaofjUuemETVmFEdUIzII+JjgKeufr6gq
	 2ssHsSMg+0BvsB1uRapKfAofT4EMB3iMAUdjvFsAYgBxXlwp52Xy7onKh9I0/Ilz8EJFM
	 DdsaNpnmSoAILAy7CzKP02aF8kHnZJyByYSREnNGCsQffDWAsfmxt6i0sWRSyRcdQzhej
	 EMrNZ213IalnLncuTpFn0hLIGcSVB0sQ3aBiYfWkp+tEacUZufeKdLxpR6BEKuRCnlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juBRoh3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536B606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juBRoh3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DFC1F01825;
	Sat, 24 Oct 2026 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792802492;
	bh=1kXTjsaIGX2NschUsRNIU4GhotpCvltijPNZq+/9BPk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=juBRoh3en3vjfgSPCZhuJVN2fz0c9vaxEGDqcDUza69mU1W4Ev4fmX2Ap6Psk1iWW
	 N/NkGT+sHbJ8/VYEBrie/FFx7tyaG9KN7dfl0KNXbR1VO51/96uUazgDa6xt1kjd2j
	 jS+XFfLOFs5ssrhwlX5IZMMCHP7PwgnrJZ9NAceJIixYjxolqp/P+1QxUp7AVu3Cu0
	 G4rg8ZOiKY9JMcMRhZrnYLi4NScniqVlf3jIX5lRA18Gm0TWa1JgcRbKWzgkH1ghMK
	 UFf4I+lWP3uTF1923WFTeg7w95b+uCV07AyimD+4UZfOfqInia46qls/jARoGDlkr/
	 Edayk3E95C6VA==
Content-Type: multipart/mixed; boundary="===============7118014080286198603=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b735903dfe798ed77b7fedc8511971224d6ea6f4f02d9aaf962fbd0b2ad223c3@mail.kernel.org>
In-Reply-To: <20261023-scev-simpler-clamp-v1-3-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-3-d43a07eda7af@gmail.com>
Subject: Re: [PATCH bpf-next 03/11] bpf: look for current loop in upper frames in states_equal()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 00:41:32 +0000 (UTC)

--===============7118014080286198603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: look for current loop in upper frames in states_equal()

TL;DR:
- Possible false "infinite loop detected" rejection of terminating programs
  when a callee has its own loop; current_loop() stops at the callee's loop
- Subject and commit message imprecise

>     bpf: look for current loop in upper frames in states_equal()
>
>     When checking if current loop exploration terminates, look for active
>     loops in upper frames as well. E.g. for the following program:
>       int main(...) {
>         for (int i = 0; i < 10; i++) {
>           ...
>           foo(...);
>           ...
>         }
>       }
>       void foo(...) {
>         ...
>       }
>     Checkpoints created inside foo() now count as loop checkpoints,
>     plus states.c:bpf_is_state_visited() does skip_inf_loop_check
>     for states inside foo().
>     Doing skip_inf_loop_check is necessary after the previous patch:
>     - Clamping now reproduces the widened range at every back edge.
>     - Meaning that induction variable ranges no longer vary between
>       iterations.
>     - So a loop calling a subprogram can reach a callee state identical
>       to the one from a previous iteration.
>     - Hence for states inside a callee an infinite loop check in
>       states.c:bpf_is_state_visited() might report:
>         infinite loop detected at insn 12
>     See selftest clamp_callee_state_pruning introduced later in this
>     series.
>     Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

The subject says the lookup changes "in states_equal()", but states_equal()
is not modified by this patch and does not call current_loop(). The only
caller of current_loop() is bpf_is_state_visited().

The body says "Checkpoints created inside foo() now count as loop
checkpoints", which could be read as referring to the loop_checkpoint flag
from need_loop_checkpoint(). That function still only looks at
cur->frame[cur->curframe], so callee checkpoints still don't get
force_new_state or the n = 64 eviction threshold. What changes is that they
now take the RANGE_WITHIN / skip_inf_loop_check path in
bpf_is_state_visited().

Could the subject name bpf_is_state_visited() (or current_loop()), and could
the body be more precise about what changes for callee checkpoints?

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index d7df6632a5c4..306ad208a8e4 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1361,10 +1361,14 @@ static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
>  static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
>  {
>  	struct bpf_func_state *frame = st->frame[st->curframe];
> +	int fr;
>
> -	if (frame->loop_stack_cnt == 0)
> -		return NULL;
> -	return &frame->loop_stack[frame->loop_stack_cnt - 1];
> +	for (fr = st->curframe; fr >= 0; fr--) {
> +		frame = st->frame[fr];
> +		if (frame->loop_stack_cnt)
> +			return &frame->loop_stack[frame->loop_stack_cnt - 1];
> +	}
> +	return NULL;
>  }

Does this cover a callee that has an active loop of its own?

current_loop() stops at the first frame with a non-empty loop_stack. If the
callee is inside its own terminating loop, the callee's loop is returned
instead of the caller's loop.

That callee loop is re-entered on every iteration of the caller's loop, and
each entry gets a new entry_state (handle_loop_entry_exit() sets
entry->entry_state = cur->parent after bpf_split_cur_state()). The check in
bpf_is_state_visited():

    if (old_loop && cur_loop &&
        old_loop->terminates && cur_loop->terminates &&
        old_loop->entry_state == cur_loop->entry_state) {

therefore fails across caller iterations, and those states fall through to
the exact-match infinite-loop check. That looks like the same false positive
the commit message describes.

For example, take the clamp_callee_state_pruning selftest added later in the
series, with the callee body wrapped in its own bounded loop:

    caller: slot = 32-bit spill;
            for (r6 = 0; r6 < 10; r6++) callee(&slot);
    callee: for (r7 = 0; r7 < 5; r7++) {
                slot[1] = 1;
                bpf_get_prandom_u32();  /* P */
            }

In the first invocation, P gets a checkpoint S_P(1) after the scrub. The
caller loop header and every callee point before the scrub still hold the
spill. On the caller backedge r6 is clamped to 0..9, the same range as the
first widening, but the slot is now STACK_MISC, so the header does not
match. With this patch the pre-scrub callee points do not match either
(spill vs STACK_MISC under RANGE_WITHIN).

In the second invocation the callee loop is entered again with a new
entry_state, r7 is widened to the same 0..4 with id 0
(scratch_widened_reg_id()), and the slot is already STACK_MISC. At P,
S_P(1) still has branches > 0 because the second invocation descends from
it. current_loop() returns the callee loop for both states, with different
entry_states.

states_maybe_looping() memcmp() up to step passes, and the exact
states_equal() passes too: frame 0 r6 is 0..9 in both, the stack is
STACK_MISC in both, and loop_stack_safe() compares only loop_id,
max_header_count and terminates. The result is "infinite loop detected at
insn P" for a program that terminates.

Should current_loop(), or its caller in bpf_is_state_visited(), also take a
terminating loop in an upper frame (or an enclosing loop) with a matching
entry_state into account when the innermost loop entries differ? The same
pattern also appears with nested loops within a single frame.

This is a remaining false rejection rather than a safety problem, coming
from the clamping change in 3a3d77b09ac6 that this patch only partly
addresses. No later patch in the series appears to touch
kernel/bpf/states.c.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40044354980
--===============7118014080286198603==--
