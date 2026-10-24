Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802491;
	b=C3cg8ZweS3cqDBVMMwvdjlMo6albjfeEHiCylcLBUgAiViQj7IczmqhOgxwikfMlmCll
	 GN/nRh/VzdiSUaMCz57aiiNUQDjCgOKPQy8zRLQ+r6I+kOA/bzTfEvwf8MiGpsdxfKX2y
	 qroAuyfNj1YkURwfkxlut0YyDn864YVfuuEmd/6Q/s8iDs2fWM6Gtj46M4cP1yPpimjEO
	 bOqnjeL1cF915+jFYTEnq+xkqmOifO3zym6EwvU4azw97RHOCOcJ1aXS1ybaKHmwdS3zd
	 nP8kTLGyfk1jxENya09yvoQ5XTvIvsynQwRsRiBwb07JNQdCcrsUD2zm9sIAHnQq14w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802491;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KE83eTVPuG4AfnXCBZ1c2CkZFLWbRTk4ebX/RN+JgjA=;
	b=DVffo/If48DA1Q/SpdojYLGnsMaBBNZf8CrkLe+AHGCrZ4kFYwY2FK35k/KLG9JSFzMA
	 ufbwZAUrKspFv/q6vJa17cnAYkJfQO7JXbN06lerCXIED5B67Ah2SShLlll6dkohrXDXd
	 8oF954K8fQYQC7hNkFqRGjMRQwAlDMkC5qycNoS6rou0zRjifS8ZQJS0BZAuJgISNC5VV
	 XW4UvSoUXVksq6bbmSaXF2kYdZpunjnqBJ/5FW1CAMjxsXoTOscJqz6+wn3/UNhK3epZy
	 jZJsLqLKgIS68okxw6mceTqYUJOvRHe6wU94qifZmRHgZkwicHpIl7oFDVUWtwsqyVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HCEOvz/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE54606A321
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCEOvz/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E98A1F01825;
	Sat, 24 Oct 2026 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792802490;
	bh=KE83eTVPuG4AfnXCBZ1c2CkZFLWbRTk4ebX/RN+JgjA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HCEOvz/e2pv87oEhJY7A/HrRoYSZ9r/4pBKmICefbylg5W7RMgIxQ5OOUKXtTFbg4
	 rRRBLCPIjr8mDXtxTEZkkJuiRjcYHkPw0XMWvFnPVdVRN1NgZMu4DmQJWf2J3stFtR
	 lDU3273uXTml+oqc2tOclEHVhJU3QnNxYGdn/hB1/aIwdbZb3ZqlZO2nHfvKtRc+gb
	 Wulrr7iXhFrYhHU1pl9XwAeiid5X9lxQdVmqpueNniE7dqMI4ZrJvUSwqS1Wud5WcP
	 FexfQj6kOfgc7LRtZYdZk41V+FMqimhcSJdTSONYfQDz4u+WyjCF6qB4fpoDa8pyA1
	 8uMJz/tfFKTjA==
Content-Type: multipart/mixed; boundary="===============4218977592103443766=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org>
In-Reply-To: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: do not intersect with current register range on clamp
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 00:41:30 +0000 (UTC)

--===============4218977592103443766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: do not intersect with current register range on clamp

TL;DR:
- This patch alone may make the verifier reject valid bounded loops with
  "infinite loop detected"; the fix is later in the series, which breaks
  bisection
- Nested loops may still be wrongly rejected after the later fix

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2893,18 +2893,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
>  		reg = scev_reg_for_linear(cur_func_state, r);
>  		if (!entry_reg || !reg || entry_reg->type == NOT_INIT || reg->type == NOT_INIT ||
>  		    is_unbound_scev_reg(env, entry_st, r))
>  			continue;
>
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> -		bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);
> -		bounds.r32 = cnum32_intersect(reg->r32, bounds.r32);
> -		if (cnum64_is_empty(bounds.r64)) {
> -			verifier_bug(env, "scev clamp produced empty range for r%d", r);
> -			return -EFAULT;
> -		}
>  		if (log->level & BPF_LOG_LEVEL2) {
>  			bpf_log(log, "loop header at %d, clamping ", insn_idx);
>  			log_reg(env, r);
>  			bpf_log(log, " to ");
>  			log_bounds(env, &bounds);
>  			bpf_log(log, "\n");

With the intersection gone, the clamped range depends only on the loop
entry state.  bpf_widen_scev_regs() computes the same thing, since it calls
linear_bounds() on the same entry register with the same max_header_count.

So every backedge now gives the induction variable the widened range again,
and the induction variable no longer changes between iterations.  Before
this patch it narrowed each time:

  [0..9] -> [1..9] -> [2..9]

bpf_is_state_visited() only sends a checkpoint with branches > 0 to
RANGE_WITHIN pruning when current_loop() finds the same entry_state for the
old and the current state.  Otherwise it falls through to the infinite loop
check:

    if (states_maybe_looping(&sl->state, cur) &&
        states_equal(env, &sl->state, cur, EXACT) && ...) {
            verbose(env, "infinite loop detected at insn %d\n", insn_idx);
            return -EINVAL;
    }

At this commit current_loop() only looks at st->frame[st->curframe], so it
returns NULL for checkpoints inside a subprogram called from the body of a
terminating loop.

One trigger is a valid bounded loop where the first iteration changes some
caller state that blocks the match at the header (for example, the callee
turns a caller spill into STACK_MISC), while the callee states of
iterations 1 and 2 are otherwise identical.  The old intersection kept the
caller's induction variable different in iteration 2, so
states_equal(EXACT) failed and verification continued.  With this patch
the states compare EXACT-equal and the program is rejected with "infinite
loop detected".  The clamp_callee_state_pruning test in 120b396ad6dc
("selftests/bpf: case reporting infinite loop w/o current_loop() changes")
is this case.

Doesn't this commit on its own reject valid programs?

A fix appears later in the series in cf18840bc068 ("bpf: look for current
loop in upper frames in states_equal()"), whose changelog says:

  Doing skip_inf_loop_check is necessary after the previous patch:
  Clamping now reproduces the widened range at every back edge

Since bisection can land on this commit, could that change be folded into
this patch or ordered before it?

A related question about the end of the series.  cf18840bc068 only helps
when the current frame has no active loop.  Consider states inside an inner
loop that is entered again on the second iteration of a terminating outer
loop.  current_loop() finds the inner loop in both states, but its
entry_state differs, because handle_loop_entry_exit() splits a new one on
each entry.  So the EXACT check runs, and loop_stack_safe() does not
compare entry_state.

With the outer induction variable now the same on every outer iteration, a
program like the one below looks like it would still hit "infinite loop
detected" after cf18840bc068 (with the old code the outer induction
variable was [1..9] on the second outer iteration and the EXACT compare
failed):

    w1 = 1;
    *(u32 *)(r10 - 8) = r1;
    r6 = 0;
1:  r7 = 0;
2:  *(u32 *)(r10 - 4) = 1;   /* fp-8 spill -> STACK_MISC */
    r7 += 1;
    if r7 < 3 goto 2b;
    r6 += 1;
    if r6 < 10 goto 1b;
    r0 = *(u32 *)(r10 - 8);
    exit;

Is that case covered somewhere I missed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40044354980
--===============4218977592103443766==--
