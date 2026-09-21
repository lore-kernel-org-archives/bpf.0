Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D8515965
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027808; cv=none; b=gjkRjRcUVifH2bbPBiLnyR2+11dukmV9varLFKrLXuvu5w3NHaDtSTtPNXC3EwCtuhW0ypjwsAW1HukDaeHUjSe+FrWAJSrPUEOhW4oQWag6c7TJgAaKQk+y3j5uYnFNsgYEkhd/ejSfqhy4bpwhOjJRCQBTDNIJbzKcGAPJYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027808; c=relaxed/simple;
	bh=HUzCTvM03S7knhbvP/9jaaIBa0A9/obIPRMTYQ+bxgE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=soNsYIdwx4xlSwP7bXHmh4ApMt3LUWgwh2JqkLRtRAtLDVABz0v2fa9JfNyTrKq4g1sqi+HE4ncAMjHj4PbOKe9fUnlRtzvC7hh7sGI6u9TwO+LqqnUWEpzua3imWopsRO4MngRAshTFrLBiBEpv1ZOxwIiVxKGLwm5BxZiowXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctKrqiDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctKrqiDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE861F000FF;
	Mon, 21 Sep 2026 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027806;
	bh=U7Vr/JVu7sBA0A/ha1gvYJoGg/9nOobeIe4XVGalEl8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ctKrqiDCruHTqkbK1SLOJiEk0MwCQaLwpJQhFkg6w+kEFYbMd2Z9PnhziteysPfQV
	 aGxF/Iij2g034g4ZPUZCpGfS8ugIkSk/k+UBiUT5zB9IhpN5dcTgcjngEyoAKsIFBL
	 KEHK5ayMG+X62O9+wUgZzJNoU3fnv1leewW25nr8xVDwNn8QAD7XtRaVHOEfT5+k6f
	 fV9Pn/CwyqhViFMAg6mALELMo5meR4tquhb92hKuINauzeYNA1NXvkpAEeCtdxN/KM
	 FUj5t99ljelN/Gz/OOol3cpzZvvRqezqCcwcWtXdb4o9IKNrjsUHcmNDIJJfWqG7fb
	 b5jxIZ+dU4a3g==
Content-Type: multipart/mixed; boundary="===============5262340308017310518=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2803ffa96f4f3ba63f450cae3709bf467683ee8477bebb7be826e07a2698290@mail.kernel.org>
In-Reply-To: <20260921210114.1720196-1-yonghong.song@linux.dev>
References: <20260921210114.1720196-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the verifier
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 21:56:45 +0000 (UTC)

--===============5262340308017310518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_cleanup_abi.h b/include/linux/bpf_cleanup_abi.h
> new file mode 100644
> index 000000000000..40b42c78fd2b
> --- /dev/null
> +++ b/include/linux/bpf_cleanup_abi.h

[ ... ]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aa631bb45f76..076739d4d974 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -429,7 +429,8 @@ struct bpf_jmp_history_entry {
>  	u32 prev_idx : 20;
>  	/* special INSN_F_xxx flags */
>  	u32 flags : 4;
> -	u32 : 8;
> +	u32 unwind_frames : 4;	/* frames the unwind popped to get here */
> +	u32 : 4;

[ ... ]

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 507a366dffa4..bf5e7e6ab78f 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -4,6 +4,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/filter.h>
>  #include <linux/bitmap.h>
> +#include "exception.h"
>
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>
> @@ -47,6 +48,7 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
>  	p->flags = insn_flags;
>  	p->spi = spi;
>  	p->frame = frame;
> +	p->unwind_frames = 0;
>  	p->linked_regs = linked_regs;
>  	cur->jmp_history_cnt = cnt;
>  	env->cur_hist_ent = p;

Does unwind_frames stay zero when bpf_is_state_visited() takes the pruned
path?

The landing pad is both a prune point and a jmp point from
visit_cleanup_pad_edge(), so when bpf_is_state_visited() finds an equivalent
state, its hit path in kernel/bpf/states.c pushes the history entry:

    if (bpf_is_jmp_point(env, env->insn_idx))
        err = bpf_push_jmp_history(env, cur, 0, 0, 0, 0);
    err = err ? : propagate_precision(env, &sl->state, cur, NULL);

and do_check() then takes 'goto process_bpf_exit', skipping the block that
would write env->cur_hist_ent->unwind_frames = unwind_frames.  The comment
in do_check() states this entry is the only record of how many frames the
unwind popped to reach the insn, so when the pruned path keeps the zero,
propagate_precision()->bpf_mark_chain_precision() later walks from the pad
straight to the throwing insn in the deeper frame with bt->frame still at
the pad frame?

That would let the callee's writes to r6-r9 clear the caller frame's masks,
or reach the call instruction still set and trip bt_subprog_exit() or the
static-subprog checks in backtrack_insn().

> @@ -419,10 +421,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  				 * extra instructions from subprog; the next
>  				 * instruction after call to global subprog
>  				 * should be literally next instruction in
> -				 * caller program
> +				 * caller program -- or, if the callee threw,
> +				 * the landing pad of this call site
>  				 */
> -				verifier_bug_if(idx + 1 != subseq_idx, env,
> -						"extra insn from subprog");
> +				verifier_bug_if(idx + 1 != subseq_idx &&
> +						bpf_cleanup_pad_of_call(env, idx) != subseq_idx,
> +						env, "extra insn from subprog");

[ ... ]

> @@ -888,11 +892,11 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
>  		}
>
>  		for (i = last_idx;;) {
> +			hist = get_jmp_hist_entry(st, history, i);
>  			if (skip_first) {
>  				err = 0;
>  				skip_first = false;
>  			} else {
> -				hist = get_jmp_hist_entry(st, history, i);
>  				err = backtrack_insn(env, i, subseq_idx, hist, bt);
>  			}
>  			if (err == -ENOTSUPP) {
> @@ -909,6 +913,14 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
>  				 */
>  				return 0;
>  			subseq_idx = i;
> +			/* This insn is a landing pad the unwind reached from
> +			 * a throw or a resume hist->unwind_frames frames
> +			 * deeper. No insn stands between the two, so enter
> +			 * those frames here, the way BPF_EXIT enters one.
> +			 */

This isn't a bug, but the new multi-line comment starts its text on the
same line as the opening /*.  Under kernel/bpf/ the opening /* belongs on
its own line?

> +			for (fr = 0; hist && fr < hist->unwind_frames; fr++)
> +				if (bt_subprog_enter(bt))
> +					return -EFAULT;
>  			i = get_prev_insn_idx(st, i, &history);
>  			if (i == -ENOENT)
>  				break;

Can bt->frame exceed st->curframe here?

The new loop raises bt->frame by hist->unwind_frames before
get_prev_insn_idx() discovers that the pad is the first instruction of the
state.  If the pad is a checkpoint's first_insn_idx, the walk leaves the
state with bt->frame at the deep frame K+P, st = st->parent is the
checkpoint that only has frames 0..K, and the parent-state loop then runs
func = st->frame[fr] with fr up to K+P:

    for (fr = bt->frame; fr >= 0; fr--) {
        func = st->frame[fr];
        ...
        for (i = 0; i < func->out_stack_arg_cnt; i++)

func is NULL for every fr > K, so is this a NULL pointer dereference in
the verifier during program load?

The pad can be a state's first insn because visit_cleanup_pad_edge() does
mark_prune_point(env, w) and mark_jmp_point(env, w) on the landing pad, so
do_check() calls bpf_is_state_visited() at the pad and creates a checkpoint
whenever force_new_state is true or the 2-jumps/8-insns heuristic fires.
bpf_is_state_visited() sets cur->first_insn_idx = insn_idx and
bpf_clear_jmp_history(cur), and do_check() immediately pushes the pad's
history entry with env->cur_hist_ent->unwind_frames = unwind_frames.  The
pad entry is cur->jmp_history[0] with cur->first_insn_idx == pad, so
get_prev_insn_idx() returns -ENOENT.

The parent state has no such frame because the unwind pops the callee
frames in the *previous* do_check() iteration, so cur->curframe at the pad
is the shallow pad frame, the checkpoint copied from it has the same
curframe, and bpf_copy_verifier_state() frees and NULLs
dst_state->frame[i] for i > src->curframe.

BPF_EXIT does not have this problem: the history entry belongs to the
callee (the deeper frame), and the state at that point still contains that
frame.  Could this be the first case where an entry recorded in frame K
asks the backtrack to enter frames that the state at that point no longer
has?

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a7..b101baa43171 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -996,6 +996,12 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	if (old->in_sleepable != cur->in_sleepable)
>  		return false;
>
> +	if (old->unwinding != cur->unwinding)
> +		return false;
> +
> +	if (old->unwinding && old->unwind_frameno != cur->unwind_frameno)
> +		return false;
> +

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 680ae191aa3f..2bc08c18ebc8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/bpf_cleanup_abi.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/filter.h>
>  #include <net/netlink.h>
> @@ -1721,6 +1722,8 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
>  		return err;
>  	dst_state->speculative = src->speculative;
>  	dst_state->in_sleepable = src->in_sleepable;
> +	dst_state->unwinding = src->unwinding;
> +	dst_state->unwind_frameno = src->unwind_frameno;

[ ... ]

> @@ -10677,7 +10680,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				verbose(env, "failed to push state for global subprog exception path\n");
>  				return PTR_ERR(branch);
>  			}
> -			return process_bpf_exit_full(env, NULL, true);
> +			return unwind_step(env, *insn_idx, insn_idx);
>  		}

[ ... ]

> @@ -18510,9 +18513,108 @@ enum {
>  	INSN_IDX_UPDATED = 2,
>  };

[ ... ]

> @@ -18784,10 +18874,14 @@ static int do_check(struct bpf_verifier_env *env)
>  	for (;;) {
>  		struct bpf_insn *insn;
>  		struct bpf_insn_aux_data *insn_aux;
> +		u8 unwind_frames;
>  		int err;
>
>  		/* reset current history entry on each new instruction */
>  		env->cur_hist_ent = NULL;
> +		/* frames the unwind popped to reach this insn, if it is a pad */
> +		unwind_frames = env->unwind_frames;
> +		env->unwind_frames = 0;
>
>  		env->prev_insn_idx = prev_insn_idx;
>  		if (env->insn_idx >= insn_cnt) {
> @@ -18851,10 +18945,18 @@ static int do_check(struct bpf_verifier_env *env)
>  			}
>  		}
>
> -		if (bpf_is_jmp_point(env, env->insn_idx)) {
> +		/*
> +		 * The entry pushed here is the only record of how many frames
> +		 * the unwind popped to reach this insn, which the backtrack in
> +		 * mark_chain_precision() needs to follow the same edge. A pad
> +		 * is already a jump point; the second test only guards against
> +		 * it ever ceasing to be one.
> +		 */
> +		if (bpf_is_jmp_point(env, env->insn_idx) || unwind_frames) {
>  			err = bpf_push_jmp_history(env, state, 0, 0, 0, 0);
>  			if (err)
>  				return err;
> +			env->cur_hist_ent->unwind_frames = unwind_frames;
>  		}

Can the unwind_frames count get lost before this writes it?

The pad insn can prune, and the pad is a prune point from
visit_cleanup_pad_edge()->mark_prune_point(env, w), so
bpf_is_state_visited() can return 1 at the pad.  When it does, the hit
path (kernel/bpf/states.c) itself pushes the history entry and immediately
consumes it:

        if (bpf_is_jmp_point(env, env->insn_idx))
            err = bpf_push_jmp_history(env, cur, 0, 0, 0, 0);
        err = err ? : propagate_precision(env, &sl->state, cur, NULL);

and do_check() takes 'goto process_bpf_exit' before reaching this point, so
env->cur_hist_ent->unwind_frames never gets written with the
env->unwind_frames value captured at the top of the loop?  The entry pushed
on the prune path then keeps unwind_frames == 0, and
propagate_precision()->bpf_mark_chain_precision() later sees
hist->unwind_frames == 0 at the pad, does not enter the popped frames, and
walks the throwing subprogram's instructions while bt->frame is still at
the pad's frame K.

If the masks propagated from the equivalent state cover the pad frame's
callee-saved registers or stack, backtrack_insn() walks the throwing
subprogram's instructions attributing every register write to frame K; it
either reaches the static call insn that entered the throwing frame with a
non-argument mask still set and returns -EFAULT through verifier_bug(),
rejecting a valid program with an internal error, or it silently applies
the marks to the wrong frame and the pruning that produced them is unsound?

Can the pad's jmp-history entry be pushed before bpf_is_state_visited() has
a chance to create a checkpoint at the same insn?

The checkpoint is created from the state that the unwind has already popped
frames out of.  cfg.c:visit_cleanup_pad_edge() does mark_prune_point(env,
w) for the pad, so do_check() calls bpf_is_state_visited(env, pad_idx)
earlier in the loop.  On the add_new_state path (kernel/bpf/states.c) the
checkpoint is a bpf_copy_verifier_state() of the *current* state, whose
curframe is already the pad's frame K: bpf_copy_verifier_state() only
populates frame[0..src->curframe] of a freshly kzalloc'd state, so frames
K+1..K+P in the checkpoint are NULL.  kernel/bpf/states.c then does cur->parent
= new; cur->first_insn_idx = pad_idx; bpf_clear_jmp_history(cur).
Control returns here, which pushes the pad entry as cur's *first* history
entry and stamps it with unwind_frames = P.

If any later precision request's backtrack reaches that entry, the new loop
in bpf_mark_chain_precision() (kernel/bpf/backtrack.c) raises bt->frame to
K+P.  The following get_prev_insn_idx() returns -ENOENT because i ==
st->first_insn_idx and the pad entry is the only entry, so the walk breaks
out to st = st->parent, the checkpoint that has no frames above K.  The
parent-state loop then runs with fr up to bt->frame = K+P:

    for (fr = bt->frame; fr >= 0; fr--) {
        func = st->frame[fr];
        ...
        for (i = 0; i < func->out_stack_arg_cnt; i++) {

func is NULL for every fr > K, so is this a NULL pointer dereference in the
verifier during program load (CAP_BPF)?



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472
--===============5262340308017310518==--
