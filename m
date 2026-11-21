Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290901;
	b=bNHHBIVyJudxpn+bnOuHTUcUkJyIbUoKvBlMA+rojUXjEJklBgYOwtYjY9BSMHBTUAf0
	 qnBR3BTOCLH/zLH4p3ts3mwVfY+bUjUoYj5tm5g1Jb1KHllyIO0WHum2L5P2K8SVZKBTN
	 nbYA7O7uabhHJcCfnTuTSi63ImTMnvbRzQVmbgl72zqVC+p7iWOEfrHFsG4DihOJnTd9x
	 R0aYKu7zdUP7GqmLYeaLotv2uT9kgI9xYGJkt+7meD7TtFrFJa4k6/BY0LT7mlO/WKtn8
	 EM1jWPmv5gbbwEF3PN12ItWKSqxyxeDX0alIaW4LeM2RfT6NWkRF/k3GwGgQh5y09rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290901;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=R6nnZaB6qCELps0u7LmqILJlisvBDAsabDcE+hjU1w8=;
	b=dawbsJz+pRUt9B61V6GYsQss/TWPfD+4L88qD8VF0UlZmMXwYmWaHyuL6MPHewyhJpMk
	 vNA1IqCvfXd95U9XFxdU3FXwggh4WPPCZmuCVdy0bTKlnIqtAx45MChAj9PLpUCkmMGXx
	 QHLqUjDVXBbEOjBy0Z4CtOYSk1eL8oK6dtYwfKWZ5E6JCTV8GihxNWw1sn11NvMgd/VJB
	 SoSJi5bNMQRihprMei1/mvOkGMS2pWkATPhRVU+Vj941XP6muPsrqrSiwcGsqJ7eLCog3
	 0ie6n+5b+4RjCvgxzc+YGjOQDX427Suk88ejSRFpagPvRhV6zh6JR4mw+KUFUpS1sMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFbeV+w+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09E606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFbeV+w+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BA71F000C4;
	Sat, 21 Nov 2026 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795290901;
	bh=R6nnZaB6qCELps0u7LmqILJlisvBDAsabDcE+hjU1w8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iFbeV+w+GM3hO6eSvJ8sQKpVu+L9zHdfmFPmBxA6EEiN+lsFfwh+6N9L5oSt6ZUmO
	 5lP12b1CCvNw9IkBiXwe+HHwdWgNYA1sj3aJ1ZXB1Z+Q6GiZ86jo79C9uhc7mvYPFA
	 OIFbmNi129SKpgQLTfHYiUBevJ4Vif2EBe1FzR+ivb7WREJNromWAE+O+G3pKhUncG
	 qNk3TuwywdNZY8K0MNZH4vCY17o/14kHPQ4E4xSJKXi2XAlhplFfx7hESj5rZMXYTf
	 dxig3IkErwKyjHzjBXlN5ALHLSjig4sTt5CVp8ULC+Nz+rgABd78Npi5i+SFm6cF7Z
	 MP0Ds2qpuaw+g==
Content-Type: multipart/mixed; boundary="===============5532563045449429305=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a58f255b83f168b0bc0e48267550137f17851aca7956e8cef48d266f889d3a6d@mail.kernel.org>
In-Reply-To: <20261121191343.3670609-3-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: Mark a skip of trips as a guess if the bound moves
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 19:55:00 +0000 (UTC)

--===============5532563045449429305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mark a skip of trips as a guess if the bound moves

TL;DR: In note_trips_left(), exit_threshold may not match the bound end
compute_trip_count() uses (jmp32 not truncated to u32, JNE step on first
visit), so valid trip skips may be wrongly marked as guesses.

> diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
> --- a/kernel/bpf/equation_join.c
> +++ b/kernel/bpf/equation_join.c

[ ... ]

> @@ -756,11 +756,17 @@ static void note_trips_left(struct bpf_verifier_env *env, struct loop_stack_entr
>  	e->iv_jump_idx = env->insn_idx;
>  	e->iv_prev = value;
> +	/* the jump moves the other end of the bound */
> +	op = bpf_signed_opcode(op);
> +	e->exit_threshold = jmp32 ? bound->r32.base : bound->r64.base;
> +	if (op != BPF_JSGT && op != BPF_JSGE && (op != BPF_JNE || step > 0))
> +		e->exit_threshold += jmp32 ? bound->r32.size : bound->r64.size;
>  }

Is the value stored in exit_threshold always the end of the bound that
compute_trip_count() uses?  Two states with the same limiting end can
compare unequal in fast_forward_trips(), and a valid skip then gets marked
as a guess.

For jmp32, bound->r32.base and bound->r32.size are u32, but the
conditional expression has type u64, so the sum is computed in 64 bits and
never wraps at 2^32.  The 64-bit case does wrap mod 2^64.  The
cnum32_umax()/cnum32_smax() helpers used through scalars_refine_cond_op()
inside compute_trip_count() add base and size in u32.  When the arc
crosses the signed boundary, cnum32_smax() returns S32_MAX, and when it
crosses 0, cnum32_umax() returns U32_MAX, not base + size.

For example, with an s32 bound n in [-10, 100] and i < n as
BPF_JMP32|BPF_JSLT, i = 0, step 1:

  first visit: r32 = {0xfffffff6, 110}
      -> exit_threshold = 0x1_0000_0064 (smax is 100)
  the continue branch refines n to [1, 100], next visit: r32 = {1, 99}
      -> exit_threshold = 0x64 (smax is still 100)

The same happens with an unknown s32 bound (CNUM32_UNBOUNDED, so
exit_threshold = 0xffffffff) that is refined to [1, S32_MAX]
(exit_threshold = 0x7fffffff).  There trips_left is about 2^31, which is
below BPF_MAX_TRIPS, so this takes the skip path.

For JNE, on the first visit to the iv jump iv_prev is still 0 from
push_loop(), so step is the iv value itself and not a step.  For
for (i = 0; i != n; i++) the first visit has step == 0 and keeps base,
while every later visit has step == 1 and keeps base + size.  When n is a
range, these differ.

When the header state that fast_forward_trips() compares against was
saved right after the first visit, the bound's limiting end is unchanged
but the check sets guess:

> -	guess = !bpf_steps_are_constant(env, entry, iv_xregs, infinite);
> +	guess = (!infinite && saved->exit_threshold != entry->exit_threshold) ||
> +		!bpf_steps_are_constant(env, entry, iv_xregs, infinite);

and then env->run_has_guess.  As a result do_check_all() skips the
max_cost cut (path_err && !guess), the pass error is reported instead of
the failing path, and the log gets "this path has a guess, its values can
be wrong".  failing_path_trip() also copies run_has_guess into
loop->infinite_is_guess for loops found to be infinite later in the run.

For invalid programs this undoes the real/guess distinction the patch is
meant to make.  Could the kept end be computed with the cnum accessors
that match the op (cnum32/64_smax, umax, smin, umin), or at least be
truncated to u32 for jmp32?  The JNE case also needs a real step, which is
only available from the second visit on.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44940968656
--===============5532563045449429305==--
