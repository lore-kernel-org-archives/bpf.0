Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7E1A9FB7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595342; cv=none; b=KNMov5NH6E5dgj+JeZjuMvnkfr0V51n50FUsojJ9CsCyKoBuuzc8H/nnl7FqwxoZVSGY0YODQ3kmg/vZlbmoTcbprWxAdc28W759nSJ+DCdtObUfsdTrUFaZ7qe3lomorKne/jypihETC2Lp2poTNrZ7nIhj+bY3z5EhHHxMfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595342; c=relaxed/simple;
	bh=yWBu1MPYYyt3Q5SiEdFdzoHWPjBNo6d5tU/nKkmobNQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ai8a7jchGwTVTlnS1N06VzPcfo5rAKWyq1egww/AgQmtY21BNVYz2zJdkLq7jxiF12cWQdUGndn1ss5ZRRzKPdHSI32jmHIQLz9ViP9ENyfdujfDsGrpoflHpa16JoIC2LjWIbuKxucMys6R0kMjjbUU2zCnZtJd0QOqzDf37HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVkaejho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVkaejho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DA1F00A3D;
	Sat,  5 Sep 2026 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595341;
	bh=u5IS7v94zmyHPBAfugXwi2pdSBZFv8+8+cDPs6T9RF8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WVkaejhov8J5pJ2C/JI/+IPa7EaYcR4+aTl2D0cI746oYBLyOSeOKGjc56wKdc22S
	 bMECaeFqccwc+yXZN9LS88bpmzXDfvgqovqrZug4buBBN4XdiKjoYXzrXZJXX5mxkF
	 EAc6dPosCfd2p7nLw0N98e6cFoxXAhQTghGDREt6w2TODtRqqcSJl+RWPcrW+ox3hl
	 x9XbQxhB8l4Di6gQWTMKcDxSqGjXxKB5LxXQKEOFeGPTi4KKxwnXQV/cuGquUR/vLl
	 d0i0nOyRDVvWPTzDgowcnmJcDF2i9gEZRUy/EcT0yrd0hMAMQTv/ntlk6gBz19XRMY
	 er7BR6cokdYuw==
Content-Type: multipart/mixed; boundary="===============4977414390371807582=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a8709a9cba92084216eea79f39c25892d4601408e1c95f4de4f64a5a8cfcdef@mail.kernel.org>
In-Reply-To: <20260905070003.3193366-2-memxor@gmail.com>
References: <20260905070003.3193366-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 1/8] bpf: Make post-verification instruction rewrites killable
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:02:20 +0000 (UTC)

--===============4977414390371807582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 52d3cec33672..9401fffcedfd 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -306,12 +307,28 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
>  	}
>  }
>  
> +/*
> + * Some post-verification instruction rewriting passes require an
> + * O(prog->len) operation per instruction. Keep their shared primitives
> + * killable and preemptible.
> + */
> +static bool bpf_rewrite_must_abort(void)
> +{
> +	if (fatal_signal_pending(current))
> +		return true;
> +	cond_resched();
> +	return false;
> +}
> +
>  struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
>  				     const struct bpf_insn *patch, u32 len)
>  {
>  	struct bpf_prog *new_prog;
>  	struct bpf_insn_aux_data *new_data = NULL;
>  
> +	if (bpf_rewrite_must_abort())
> +		return NULL;
> +

Is this NULL return actually a cancellation point for every caller of
bpf_patch_insn_data()?

Besides the verifier rewrite passes, bpf_patch_insn_data() is also reached
from bpf_jit_blind_constants(), and on that path a NULL return is
deliberately treated as non-fatal.

bpf_jit_subprogs() maps the blinding failure to -ENOMEM and clears
jit_requested/blinding_requested:

kernel/bpf/fixups.c:bpf_jit_subprogs() {
	...
	prog = bpf_jit_blind_constants(env, prog);
	if (IS_ERR(prog)) {
		err = -ENOMEM;
		prog = orig_prog;
		goto out_restore;
	}
	...
out_cleanup:
	/* cleanup main prog to be interpreted */
	prog->jit_requested = 0;
	prog->blinding_requested = 0;
	return err;
}

but bpf_fixup_call_args() only propagates 0 and -EFAULT out of it:

kernel/bpf/fixups.c:bpf_fixup_call_args() {
	if (env->prog->jit_requested &&
	    !bpf_prog_is_offloaded(env->prog->aux)) {
		err = bpf_jit_subprogs(env);
		if (err == 0)
			return 0;
		if (err == -EFAULT)
			return err;
	}
#ifndef CONFIG_BPF_JIT_ALWAYS_ON
	...
	err = 0;
#endif
	return err;
}

so with CONFIG_BPF_JIT_ALWAYS_ON=n the -ENOMEM is overwritten by the
interpreter-fallback path and bpf_check() carries on.

The other caller documents the same policy:

kernel/bpf/core.c:bpf_prog_jit_compile() {
	prog = bpf_jit_blind_constants(env, prog);
	/*
	 * If blinding was requested and we failed during blinding, we must fall
	 * back to the interpreter.
	 */
	if (IS_ERR(prog))
		goto out_restore;
}

and __bpf_prog_select_runtime() only turns that into an error when
fp->jit_required is set.

So if the fatal signal only becomes pending after bpf_do_misc_fixups() and
bpf_opt_subreg_zext_lo32_rnd_hi32() have run, that is during
bpf_fixup_call_args() or the later __bpf_prog_select_runtime() call,
BPF_PROG_LOAD still returns 0 with the jit and constant blinding silently
skipped.  A load under net.core.bpf_jit_harden can then end up unblinded
rather than rejected.

The changelog says:

>     Callers already handle NULL or propagate an error, so a
>     fatal signal can abort without leaving a partially accepted program visible.

Should that be narrowed to the verifier rewrite passes, or would it be
better to keep the abort check out of a helper that the constant blinding
path also uses?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952325041
--===============4977414390371807582==--
