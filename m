Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939919;
	b=3TftAyM2UK6lU/j4q4SaU1MM2wd4pDFIdaIiPseeywoptfxflPlr7dK+w4aDRFtGqN2A
	 ilvYrsOSYf7AHEnF1OFDeVnQthP5zkKR58qtsatqo4dSjWqBXPO5FQoo1XlW+d+JrvVAv
	 CMZMZJ/hqQJCUrbbbfKPRhsnyCaXt4nLdYaynakuGS1situOU8GFqZ0vlEeWYxdXAz+pi
	 Y2WIG33t7eGY0c1AsA5h1/b2W3sS9FDN41K7+aqVWlKxrNHK1GgIKk/ggI3zjl8UzdVN4
	 S7NyNQLiLEa4+aYvyEYNXZJa7y1pNRcgCRZp35bNfu43ky/dpMoT/RhwC1a9Wt6QTAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939919;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WiCcvV4qip4upVSe3cZiFqFg5PP1cjCqZo/Xl3HDjO8=;
	b=W3CNIEYyyh08vMmYDORlFjBaplSQ5OP7IvrFZD4WQMRzCHD6Z5fbiS76tolTwRBi8+Z4
	 OgcJs8zsJ9vqAL3fOBy6LEVEWlJyuY0nL1spHKNFRwo+OqmQRV8aZBsAqVqzlslWdnw9v
	 in999Ow/fMhuv/9Swc8IqYJGX6TbXXWwGUc5TIaEGH1LxVcggwdtG3LTX+iJSEVOHXCrO
	 rA6z1krAGUNxBSsm6MqoGpljctkGl0x+YLA+9Z+X5Hrp2I1lY5+cMi92WbuYIw+m9dka3
	 zyKqy2deZl9Su/SOxlJebznX2Jl3pjFM1lxMhgQNsT91QtdcxpIKAM+nzRK1HuQwVUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjghCHyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FD606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjghCHyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B21F0089F;
	Fri,  6 Nov 2026 04:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939918;
	bh=WiCcvV4qip4upVSe3cZiFqFg5PP1cjCqZo/Xl3HDjO8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SjghCHySrQddX7hi1ktnY1TLXr4POl0PPNmSeL5iTcbPObIqTPT8ASLQaQBhkMD9c
	 CBgujOgHfZTXlt3iQDk00H3LoOP5ekipePoADrYEM8+sQ7Wsq1HB3BbwXnSqXxML/R
	 5uqa4JSf9qMG3lsUu8Ur7Szp7yRXCYenXZTzyzo4o6udx3xu4nYKtB+JIgrW9L3mLT
	 br4nYV64Prh+DM8KyM5RJ+8sDImHxKGvsKEQSe1V07S0ItEfiGafeReV0RwXBr9kY7
	 BQdABUaFR/j5qvAZJ3ytggqtIC7cCNt62cTeJmTlIznPRnjE7Y0RZRY6vhmGr5iykL
	 p/IHai3kJmIsg==
Content-Type: multipart/mixed; boundary="===============4955819479308878304=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ae59d5159d918dfd6bd3508851c0e44a080d7ef49c9591c9842ccb4c612e84c8@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-21-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-21-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 20/45] bpf: Keep the count of a loop when a register has no closed form
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:38 +0000 (UTC)

--===============4955819479308878304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the count of a loop when a register has no closed form

TL;DR: In bpf_flow_loop_enter(), a long counted loop whose register has no
closed form may no longer fall back to flow_try_walk(), so programs that
loaded before could be rejected (unbounded min value), until later patches.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21630,8 +21630,22 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
>  	if (err < 0)
>  		return err;
>  
> -	/* @per_trip: the insns of one iteration, times the walks around the loop. */
> +	/*
> +	 * There is no summary of what the loop does to something that is live.
> +	 * Go through the iterations one by one if that is not too long.
> +	 * @per_trip: the insns of one iteration, times the walks around the loop.
> +	 */
>  	per_trip = flow_walk_factor(cur) * loop->nr_insns;
> +	if (err == 2 && per_trip <= BPF_FLOW_MAX_WALK &&
> +	    iters.max_header_count <= BPF_FLOW_MAX_WALK / (u32)per_trip) {
> +		entry->max_header_count = iters.max_header_count;
> +		entry->terminates = true;
> +		entry->counted = true;
> +		entry->apart = true;
> +		return 0;
> +	}
> +	if (err == 2 && iters.spill_base)
> +		err = 0;
>  	/* The walk has to get to the end of the loop, so it is known to have one. Or not: */
>  	if (!err) {
>  		err = flow_try_walk(env, entry);

When bpf_compute_loop_iters() returns 2 because a register that a check
depends on has no closed form, and the counted walk is longer than
BPF_FLOW_MAX_WALK, this code no longer falls back to flow_try_walk().
Unless spill_base is set, err stays 2 and the code goes on to
bpf_widen_scev_regs(), which calls scev_forget_reg() and turns the needed
scalar into an unknown scalar for all iterations.

Before this commit that register hit cant_widen, bpf_compute_loop_iters()
returned 0, and the loop was walked by flow_try_walk().  If that walk gave
up, the loop got a may_goto and the states at the head were joined, which
keeps any bound that each iteration gives the value.

Can this reject programs that loaded before?  For example:

  idx = 0;
  for (i = 0; i < 100000; i++)
          idx = table[idx];       /* u8 table[256] */

Here idx has no closed form and bpf_flow_is_needed() reports it as needed,
so the return value is 2.  per_trip is about 12 and max_header_count of
100000 is larger than BPF_FLOW_MAX_WALK / 12, so the counted walk is
skipped.  spill_base is not set, so idx goes through scev_forget_reg() and
bpf_mark_reg_unknown_imprecise(), and then table + idx fails with "math
between map_value pointer and register with unbounded min value".  Before,
the join kept idx in [0, 255].  The same seems to apply to a value that a
call returns in each iteration, such as bpf_get_prandom_u32() & 15 used as
an index over 20000 iterations.

The commit message lists this as method 3 ("The walk is too long: an
unknown scalar, as in 1.") but does not mention that such programs are now
rejected.

Later commits in this series address this: 602c3e06835f ("bpf: Keep the
first iteration of a counted loop apart") describes that "a prog that
loaded before is rejected: math between map_value pointer and register with
unbounded min value" and handles values loaded anew in each iteration, and
01f19b3a79be ("bpf: What a call returns in each iteration is like what the
loop loads") extends that to call results.  The fallback in
bpf_flow_loop_enter() is unchanged at the end of the series, so is this
commit bisect-clean for such programs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============4955819479308878304==--
