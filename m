Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914547;
	b=gMFzvh+hULW+Gv8ptQcho+CaCNdWz6jxmU59vL86xpXEDM8nJx7XCnidNZrKW4TBUwjn
	 D1QbD+7Ivs7s12nqVJnyx3tM7z5PPbJldjOcZUgbY5aWAYZ4N7BC3RkoO/HXOIZkVUTUe
	 Ff39W4I+c9VV8jIT2AFve0ecOvihO1UL9+C3cDzNrATi/1pI37ARKe1tdiIw62y1Y3Jc1
	 wfSs0NrCxUMZBY3uvFbnGZGlqhzQsQ0BRKYOaboLqKcEuUOlnvRNHRo1RLQ45uNOplQVV
	 4FNtw8Qh+HP98zP7ZohIeI208+3jSLvdirs3BUoKAj1gbmht6piKQUc9parhb2RLbcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914547;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Vb4kdl1gMuHbzOGURluhe1Pmkv9kqoZd2Aeme2Ko+8c=;
	b=kIQislK4zhdcZ/m+B6gPLtcZelgb+rYb1iC1NjatM5HHGrGCt+URCp2DQAzCR5FPeVx5
	 fbeFWlRv0yjqiT9bEpZrH/iWemfMm54pHw3N/K6jAGTSZO2E2RCJ/3bK8DTgX9bnnxlu8
	 nZVqLfhBj9DGNHTLy0iWyOXz0uxQSgR6NMRQFYjE3HvFkVTRpxPIXcT5iW7WjNd16AkFc
	 bmZIHSNwe13jqJ3t/DyTiaWxUlKfanXWRfVvfLVyFrBTUlFuMIiHerkbYqwIYEOJXaQ2n
	 R73mCw+e8WF3Hh/QOou3Ks2izfWuirbehSpAhxuL4wECHcc35c8t4+ePjgZEGbloG0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAZ3gOWQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD9606D815
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAZ3gOWQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE71F008A7;
	Thu,  5 Nov 2026 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914547;
	bh=Vb4kdl1gMuHbzOGURluhe1Pmkv9kqoZd2Aeme2Ko+8c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bAZ3gOWQaOBd3f4rshLModyWlqL6JVkLhGoz+0kjhpzb0WW629iXwW97MzERbnGzB
	 8mfhudeDEveOwUbqP0p7gYqqwiSL5Tn0IXjK8Kq+YhHh7pqYMIwfSNFN3l2wwobKp+
	 m39IO5qR/rIOSU+F0tq9pMJjaPHuPd7B4JX7psCHD35nA7rsGvY/HgSFX5832ZqTko
	 TfKK7U50fRclDBi5JHGggyrppoZWE9BZ+xlieEB/+im1jAMM8X+xzWJajdhfIO7Fgw
	 DDG8ljOWOxz7Y2qITM5xagZEIidSqvkDV413Lp+pfo0pAZPBGnqMltyV553WikRy04
	 k6kykP/KMHeHQ==
Content-Type: multipart/mixed; boundary="===============7507013332646739707=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a62019b90ed4a5d6bbe52f18f29d860310a5a48bba11a76b31c8f03c8e685743@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-21-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-21-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 20/35] bpf: Keep the count of a loop when a register has no closed form
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:46 +0000 (UTC)

--===============7507013332646739707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the count of a loop when a register has no closed form

TL;DR: In bpf_compute_loop_iters(), a NOT_INIT register read only under an
iteration-dependent guard may not be treated as needed, so the verifier could
reject a previously loading program with "!read_ok".

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -3541,10 +3546,69 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  				bpf_log(log, ", requires exact stack-offset tracking");
>  			bpf_log(log, "\n");
>  		}
> -		return 0;
> +		/* the count stands, it is this one that is not known in the loop */
> +		if (spill_base) {
> +			iters->spill_base = true;
> +			walk = true;
> +			continue;
> +		}
> +		__set_bit(r, iters->forget_regs);
> +		/*
> +		 * Only a walk through the iterations tells what it is in each of them. That is not
> +		 * worth it for a number that nothing looks at: a sum, a hash, what a call leaves in
> +		 * r1 - r5. It's not known in the loop then. A pointer, or a slot that holds
> +		 * something else than a register, would be of no use any more.
> +		 */
> +		if (!reg || (reg->type != SCALAR_VALUE && reg->type != NOT_INIT) ||
> +		    bpf_flow_is_needed(env, insn_idx, r)) {
> +			walk = true;
> +			continue;
> +		}

Can a NOT_INIT register that is live at the loop header be treated as "nothing
looks at it" here?

scev_forget_reg() only rewrites SCALAR_VALUE and PTR_TO_ARENA registers:

	if (r < MAX_BPF_REG) {
		if (func->regs[r].type == SCALAR_VALUE) { ... }
		else if (func->regs[r].type == PTR_TO_ARENA) { ... }
		return;
	}

so in the head state that has to cover every iteration the register stays
NOT_INIT.  If the loop reads it only under an iteration-dependent guard, the
widened induction variable makes both sides of the guard feasible, and
check_reg_arg() rejects the read with "R8 !read_ok".  The bpf_flow_is_needed()
tables only record jumps, pointer and stack offsets, helper arguments and
load/store bases, so a plain arithmetic read does not set them.

For example (privileged, no pseudo calls in the loop):

	r6 = 0; r7 = 0;
1:	call bpf_get_prandom_u32;
	if r7 == 0 goto 2f;
	r6 ^= r8;          /* r8 is set from iteration 1 on */
2:	r8 = r0;
	r7 += 1;
	if r7 < 64 goto 1b;
	r0 = 0; exit;

This is what clang makes of:

	u64 prev;
	for (i = 0; i < 64; i++) {
		now = ...;
		if (i)
			sum ^= now - prev;
		prev = now;
	}

r7 is linear with a count of 64, while r6 and r8 have no closed form.
Neither is flagged as needed, so bpf_compute_loop_iters() returns 1,
bpf_widen_scev_regs() widens r7 to [0,63], and r8 stays NOT_INIT.  "if r7 == 0"
is no longer decided, so the fall-through reads r8 and the load fails.

Before this patch the first register without a closed form made
bpf_compute_loop_iters() return 0, and flow_try_walk() walked the loop
exactly.  In iteration 0, "r7 == 0" is decided, r8 is never read
uninitialised, and the program loaded.  Does this reject a program that
loaded before?

The commit message says of method 1 that "It is an unknown scalar in the
state that covers all iterations", which does not hold for NOT_INIT.  Should a
NOT_INIT register that liveness reports as read count as needed (walk = true)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============7507013332646739707==--
