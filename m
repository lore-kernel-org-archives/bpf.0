Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456837E5D1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119586; cv=none; b=AOpxm0xI6yCK0K3AwhkAWF05pnBmoOv2YEv5j8KZbGuCgXWOzhh8wWYSfqMh8YvBHSdMMlsFc3grYVj71470N2xZgJQ9VsJiEu67sjojPcRI2X8CjVXvnJ+5E1OdQLGWYYd0uIYr1bzqkGAVNHdxldZYCjBIHFFLSFTHxSAgRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119586; c=relaxed/simple;
	bh=49Zj3cHeMW6NEsHz4EHzIQsLgzmx5lG0FTzeImFr03Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=clT0QvXJVa0WFu7IP9TRAkWKcspngWLnzt9Dj6bHK8GjaGN4NxM1jIVcwC6JdaP+H4LAE/uJLZ/TB2SJ+6XwIhCW2cCflSkiphfe7qnAlSnQgG7NqOJfg3RFoOrYPhUD3o6RyrmAghP7D96w3iUxMx14LmE7nrBSOKOU/b2BcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1h9ZAec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1h9ZAec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD291F00893;
	Fri, 11 Sep 2026 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119581;
	bh=3T3iccDz4f9/TwcWR4alyrL6jTGssoqwkvakJPjO9FY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f1h9ZAec9Z4xwGmxHF/URIFc9wg7TDRmSb0QOY8hUlvEfHY0GDh7C46uSkJU/Yu7I
	 UQT1lP9IcNHksEkgTkh/htsoYO7bXFcUOMCcFzIH882qByAje8QU0ckZEtP7vjvSXs
	 Bhl3tHS7wCHCmww6Xoatm091jwK1/skdILxIx/pZj2Dd/GwwKfRoqQLI6Jx8Fvhl6l
	 HiRhqCqtQx1EX5DzIArx/4QD5Ack2RNwLa1VEjvdthte0cr7iKN8Iew+MAdWvsADUF
	 ubcNhyEU7nueU3GvcjPuEFQ0g0KEhvIVlL4B7tjl9N3I9VyUMJ6a/of6LffuVjNeXG
	 krgpSDjqSkAnQ==
Content-Type: multipart/mixed; boundary="===============3318329687488449505=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b3cfbdd731778b2be95d3e936d306ff7a4a359d092cbae5c486f82f4d8e9c7c@mail.kernel.org>
In-Reply-To: <20260911084209.3481285-2-xyx2021@mail.ustc.edu.cn>
References: <20260911084209.3481285-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf v3 1/2] bpf: Destroy callee-local dynptrs on subprog return
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 09:39:40 +0000 (UTC)

--===============3318329687488449505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b0b1fb62878..785779dff4cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -800,6 +800,31 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
>  	return ref_cnt;
>  }
>
> +static int destroy_dynptrs_on_func_exit(struct bpf_verifier_env *env,
> +					struct bpf_func_state *callee)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +		struct bpf_stack_state *slot = &callee->stack[i];
> +
> +		if (slot->slot_type[0] != STACK_DYNPTR ||
> +		    !slot->spilled_ptr.dynptr.first_slot)
> +			continue;
> +
> +		/*
> +		 * A callee-local dynptr is destroyed when its stack frame goes
> +		 * away. Apply the normal stack-slot teardown so references cannot
> +		 * be lost and slices derived from that dynptr are invalidated.
> +		 */
> +		err = destroy_if_dynptr_stack_slot(env, callee, i);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  				        struct bpf_func_state *state, int spi)
>  {

[ ... ]

> @@ -10408,6 +10433,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  		print_verifier_state(env, state, caller->frameno, true);
>  	}
>  	account_processed_insns(env, callee, caller);
> +	err = destroy_dynptrs_on_func_exit(env, callee);
> +	if (err)
> +		return err;
>  	/* clear everything in the callee. In case of exceptional exits using
>  	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
>  	free_func_state(callee);

Is the error message from destroy_if_dynptr_stack_slot() accurate when
called on this path?

On the subprog return path (at the BPF_EXIT instruction), the frame is
being destroyed rather than a stack slot being overwritten. However,
destroy_if_dynptr_stack_slot() emits:

    verbose(env, "cannot overwrite referenced dynptr\n");
    bpf_diag_res(
        env, env->insn_idx, "referenced dynptr overwrite",
        "This stack slot contains a dynptr that owns or protects a
        referenced resource. Overwriting the last dynptr for that
        resource would lose the verifier-tracked release path.",
        "Release or clone the dynptr so another live dynptr still tracks
        the referenced resource before overwriting this stack slot.");

The remediation text suggests cloning the dynptr, but that won't help
here because a clone created in the same frame gets destroyed by the
loop one iteration later (dynptr_ref_cnt() returns 1 for the clone and
the exit is still rejected). The only fix is to release the resource
before returning.

The diagnostic also changed for existing programs. The
ringbuf_missing_release_callback test in dynptr_fail.c had to be
retargeted from __msg("Unreleased reference id") to __msg("cannot
overwrite referenced dynptr"). Functionally the program is still
rejected (check_reference_leak() at frame 0 caught these cases before),
but the log message no longer describes what actually happened.

Would it make sense to emit a return-path-specific message when the
frame is being destroyed, or to pass a context flag to
destroy_if_dynptr_stack_slot() so it can tailor the diagnostic?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34582138838
--===============3318329687488449505==--
