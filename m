Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF563A16AE
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865082; cv=none; b=ueCS02uo8sck7WfeK+asc9j9SbNr6Fmz/DrLlQ3Xuf3UEKMLl90/p4a03cnWvlCGm4MYqboR32h2pxYgpCLbRxMq7VOglgWOOZdFnXHQWI5JY5pr3/RaoDbDylocMnT6cQ4OnSlW7UmsqImDg36MSjk7j9AitVXT2oue/OvAXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865082; c=relaxed/simple;
	bh=xcaHrrmcHIoFSuNJyxhAYz//jPy4riEfZRYkk4jfruo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jVoGAa6CFzF4bQNlVdmKvHThM7d5vtFTJtD7S+BaQkU7zcEuG/NXYiqfO83p4yHOswx71mql0KHrLj/07h9GBdUHSCKJnOqRAV6VqUbLCu5iuQKGCcLqiy66gR3cyEJ5fZi9r0HQuk06Uk9K/xXWZu7E9YqHnlxtO1rYjpbsgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYw5HX9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYw5HX9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F7E1F00898;
	Thu,  1 Oct 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865075;
	bh=5+j/gzm1UIDKKeGDsmkOzEQm0x/Nq97A+omr237HlwQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mYw5HX9OVR8kpe7L/kSrhdFEEnM9dR1+ycQ3wWoJxmW+yH/t+NZmoTbDTQMhUsBkx
	 7KDjrJsy9caRr57MkAFM9FRBrVFEvoQ4dKBQqqgmfcJC6G8GvFblefFxLtQbKSAXqp
	 7ZYxcuI5YFUA3oPqskyJqRhKRPJ6PryHfK4oJzK5MvMq9fJ6w0bV8Z5oHYimmQWTju
	 qwn4JgKPbJchNPSHUf3I2CtUMQAtTA5fPKxvVFV+qpHSM1s7TLVxRlqa333Y8mJHuw
	 Q32zQ0eHj4Evzu28TQRRLjjWV7rcpkR+uTXzXhTrJkfkJ8SxAW2Qnj4PBdbuJX8ZRF
	 p7Eg/B3LicM/A==
Content-Type: multipart/mixed; boundary="===============3065970111078494225=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a203a496c37cc672ef89f2e95a82b48c4a19863d832a055a3bfda60e3fd206ec@mail.kernel.org>
In-Reply-To: <20261001133047.1339752-1-yonghong.song@linux.dev>
References: <20261001133047.1339752-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 08/22] bpf: Require an unwind to leave a frame holding what it entered with
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 14:31:15 +0000 (UTC)

--===============3065970111078494225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Require an unwind to leave a frame holding what it entered with

TL;DR: call_may_unwind() treats every callx as possibly unwinding, so the
verifier may wrongly reject valid programs that hold a reference or spin lock
across a callx; the exact target is available from the register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c7a350be538e..a7b25ab04051 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19244,6 +19245,32 @@ static int unwind_out_of_global_call(struct bpf_verifier_env *env, int call_idx,
>  	return INSN_IDX_UPDATED;
>  }
>
> +/* Can an unwind come back out of this call? */
> +static bool call_may_unwind(struct bpf_verifier_env *env, const struct bpf_insn *insn,
> +			    int insn_idx)
> +{
> +	int subprog;
> +
> +	/* Which subprog a callx lands in is not known here, so any may be it. */
> +	if (bpf_is_callx(insn))
> +		return bpf_prog_may_unwind(env);

Is it true that the target of a callx is not known here?

call_may_unwind() is reached from check_unwind_through_call() in
do_check_insn(), just before check_func_callx().  check_func_callx() takes
the exact target from the same register state a few lines later:

	reg = reg_state(env, insn->dst_reg);
	if (reg->type != PTR_TO_FUNC) ...
	/* PTR_TO_FUNC is a pointer to a static subprog */
	subprog = reg->subprogno;

and check_func_ptr_read() pushes one state per possible table target, each
with its own subprogno.  So each verified callx has exactly one target at
this point.  Only the CFG pass has to be conservative, and
mark_callx_might_unwind() already marks any target that itself contains a
callx.

With the current code, an uncovered callx is refused by
bpf_exc_check_frame_balance() whenever the calling frame has changed its
RCU, preempt, IRQ, spin lock or reference state since entry, as long as some
unrelated subprog in the program is marked might_unwind.  For example:

	foo():
	    t = bpf_task_acquire(...);  /* id > entry_id_gen */
	    r1 = vtable[i];             /* PTR_TO_FUNC -> bar, no unwind in bar */
	    callx r1                    /* no cleanup record covers it */
	    bpf_task_release(t);

	baz():
	    bpf_unwind();               /* makes bpf_prog_may_unwind() true */

Before this patch this program was accepted.  Now it is refused with "an
unwind through this call keeps the reference id=N the frame acquired", even
though no unwind can pass through that call.  callx is also explicitly
allowed under a spin lock, so a frame that holds a bpf_spin_lock across a
callx is refused as well with "an unwind through this call does not leave
the frame's bpf_spin_lock state as it found it".

Could this look at the register instead, something like:

	reg = &cur_regs(env)[insn->dst_reg];
	if (reg->type == PTR_TO_FUNC)
		return env->subprog_info[reg->subprogno].might_unwind;

and leave it to check_func_callx() to refuse any other register type, as it
does today?

> +	if (insn->src_reg != BPF_PSEUDO_CALL)
> +		return false;
> +	subprog = bpf_find_subprog(env, insn_idx + insn->imm + 1);
> +	return subprog >= 0 && env->subprog_info[subprog].might_unwind;
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096
--===============3065970111078494225==--
