Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163095;
	b=IlRyZqhgLT0/XqHBqv8fB97rj9hpCwVrxmLW1zgt7Ejkp47qvuf7+tfSwnY27Yi5XHHU
	 uoNERMkW14LTvJLFzmd2chHuHWoCsLp9CyKMlD3STkG9QlNPeAx4lxvEJ+dWpBbsH4+wG
	 gkcmU8XdVQSFxVQDTGF0V87Uz+6OQ9XY8umckP4/ukgEm/n/oektMsSgY07xdgkr9i1ZJ
	 0/tHimLU+y7BKIp7jAty7iu4u5ghis3AR4AITs9axdKwz1ne2S3QgoSNopIfTGfVWicDq
	 kqOWZRxvYnOfLANWVhOZCc4qMuFrcK//O5g08A5we8CmR8zSmEzxi65Fcjgz5VOHaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163095;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=m9/Z4dNNtSQMZ4QIbjMdSfiRuxef6kxNCEbZ5tBx0rU=;
	b=rBKyDEtMB3GXgapWSFhVKK4JAGdENo/WnNwjjwUw6Dsqloqd2C8yatfnaEZ7n4gcsj79
	 xX+fzlKokpH1d34Fs3luAxzQ26YPaSz/oNfkSoqaw0xRdSKIVFy79VZz+7ppq9jmSJKLX
	 NdA9bA6LSb5sibGUMbowORRKw8yMcgv5r2l9X/ase/jGhjfxR9xvcvClAWr66LLKQUekh
	 fPa61w652Mr+OuH+BAwsoz+tPFdeC4jc2Vhl2JZufrNWx0eMeOSa9Eq/9k3SK/8jpNp26
	 nup31SVsYZ0Ot0eKk3KY4DSVt0gdTuqd6djKMZBHN/R5FZZEfX0JA/b+N2hUpotE7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wr0+miGl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02937606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wr0+miGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B351F000CA;
	Fri, 20 Nov 2026 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163094;
	bh=m9/Z4dNNtSQMZ4QIbjMdSfiRuxef6kxNCEbZ5tBx0rU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wr0+miGlIImr/xeEwksH5aLBeZMatkjPPjxrMlEjKZxF1dKnlCHMlT2jJV1cBcDF2
	 3gHtXOA6rDe2x9PiYzXznyUN+YQtTkIe+GmfIBEcElSecpXyY7dqCllHYiZ+qAQn1o
	 v7UV1OIVXv7FOJ+SNX50Tk8BTZcVRP68KK72L+y8w88qfJsgyzTB7hGKE9rWSvGsCi
	 76QSQLg4+rLWIAM2mx+H3f23FCCFwh+XQPnH0JZeOFFmje3psrCJLHD59SLZkYlR52
	 ELCNUADHjQXhSL3Dt4XhICdU0DFEVmKmM2XhzHR7YnSxjdKWzu13GxzgDSFt3W/4Pd
	 cPaDkJpNVUw6A==
Content-Type: multipart/mixed; boundary="===============6778475305194276429=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fb1adb1484d4dfdf8f231380b939c46dabaf0f2693f55cf7fc5ef6099bee9280@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-15-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 14/49] bpf: Mark a state that no run of the program has
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:24:53 +0000 (UTC)

--===============6778475305194276429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mark a state that no run of the program has

TL;DR:
- scalar_intersect() change may leave 32-bit spill fills unsoundly bounded, so
  the verifier could accept unsafe programs; undocumented in the commit
  message
- the new infeasible flag is never read, and may be set on the wrong state

> bpf: Mark a state that no run of the program has
>
> A jump can leave an xreg without a value: the ranges and the known bits
> have no number in common. No run of the program has such a state.
>
>   jump -> range is empty -> infeasible -> a pass:              continues
>                                           a run without joins: drops it
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The commit message only describes marking infeasible states, but the patch
also changes scalar_intersect().

First, it removes the forced zeroing of the upper 32 bits of dst->var_off.
In the parent, with bits == 32, the code did:

    a = tnum_subreg(a);
    b = tnum_subreg(b);
    ...
    s.var_off = tnum_intersect(a, b);

check_stack_read_fixed_off() passes bits = 32 for a 4-byte spill read by an
8-byte fill (fill_exceeds_spill), where the upper 4 bytes come from
STACK_MISC.  For example:

    *(u32 *)(r10 - 4) = 0xffffffff;
    *(u32 *)(r10 - 8) = w1;
    r2 = *(u64 *)(r10 - 8)

scalar_bounds_sync() then bounds r2 to [0, U32_MAX], while at run time r2
is 0xffffffff_xxxxxxxx.

Second, the removal of "if (bits < 32) return false;" turns on refinement
for 1 and 2 byte spills.

Could the soundness fix be folded into 20d7b7b266b5 ("bpf: Keep more of
what is known about a number") so each prefix of the series stays sound for
bisection, or at least be described in this changelog?

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -522,6 +522,8 @@ struct bpf_verifier_state {
>  	struct bpf_reference_state *refs;
>  	u32 insn_idx;
>  	u32 curframe;
> +	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
> +	bool infeasible;

Is anything reading this field?  It is written in reg_bounds_sanity_check()
and refine_live_branch() and copied in bpf_copy_verifier_state(), but
states_equal() does not compare it and log.c does not print it.  The only
later reader in the series, infeasible_state_ends(), tests
env->cur_state->equations.infeasible, a different flag.

The comment says "Only a path-sensitive run drops such a state", and the
commit message says "a run without joins: drops it".  No code does this,
and env->path_sensitive is never set.

Where the flag is set, it does not always match "an xreg has no value":

In check_cond_jmp_op() with both branches live, push_stack() copies the
current state into other_branch before regs_bounds_sanity_check_branches()
runs.  If true_reg1 or true_reg2 fails the check, reg_bounds_sanity_check()
marks env->cur_state:

    env->cur_state->infeasible = true;

That is this_branch, which takes false_reg1/false_reg2.  The jump state,
which takes the bad registers, is left unmarked.

reg_bounds_sanity_check() also reaches the out: label through
verifier_bug_if(reg->step == 0 || reg->base >= reg->step, ...), which its
own comment calls a verifier bug rather than an empty value set, yet it
still marks the state infeasible.

If a later reader drops states using this flag, both cases would skip a
path that runs.  The later equations-based reader also checks
env->bypass_spec_v1 first, since a speculative run can still reach such a
path, and this field's comment gives no such condition.

Could the field be added in the patch that first reads it, with the
producers changed to mark the state that actually holds the empty register?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============6778475305194276429==--
