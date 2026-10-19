Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EF3A7193
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393189; cv=none; b=SrPt04MzeDX0uLqXYpdPzTBpRNFD4Tgr3/pcCthi+CPABOctVhfOGK1iOkfrlOIaWIo/1aAj8LbXZIkrYXuW9ipnutc96YB/tl5bsaa6HeOJwOFL/YKJUPC4UtJcFMGlH8VhWH4SokNAqryDSBRP182krVfrpUUGDHqQTdZ5ZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393189; c=relaxed/simple;
	bh=foHXeHfz/zsVUU/Yvx3ydaTSg3rQvmqelYP0tWifqc8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lvLnJ3VP+FvcfOJa0AtmVtyfuUiuUavY64q1hiDUupC1+MvejouJ51yI9DWRVedhAt1OtC/Zoefq3dJXhn5lKjNHEmFDY1PBuCR+4JFLMd3lKrat5IK8i1BOR3zNj4U/jwile7dP47I0NhInXT+eX0tKx7OdOvLYAd6jx3YlopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEB/LlPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEB/LlPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34301F000C4;
	Mon, 19 Oct 2026 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393186;
	bh=LJgIHhm5X76g1e5bxYvAEeup3Xs0y3RYjZ4eWSmYQJM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EEB/LlPwADMmwGDGTiwmf9iVT40k4xaV2b1mWTM5IZdJlBXSqsLIAxyW2HKAe7XJ3
	 QigmcQIMjjxHHgQg01YoYQPwitLpW1KFScJy9gqiOjfrgA6l468u4Msyzov+pAZIXd
	 WkLPtlaZ7IZ6bgc3UiO/ko9ArSvwyyEWICiFQnIWNHlvq38xCI6Bu3+7ul1mpybMxq
	 mbfsaNM8kIzoDUvk1nJ6nPsOQv3rw65bEAErnvzK+O6/6kpMsc6OdCaKAxjKxMX9fk
	 Hzoc1K5ILSnf/z25BOMLUwIdSa1hCVPQOmtFLjD7rjQZo5J/pT6vvSfHQoxKlHSOyB
	 f8YmdqMCzUJ2w==
Content-Type: multipart/mixed; boundary="===============5635817760675365655=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e385bdb66a2c0a1cb3c2b34c0694f7ac6043363e48c58341ad24ea44514ec6c7@mail.kernel.org>
In-Reply-To: <20261019051846.3012089-2-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add unwind_goto and unwind_exit insns
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 06:59:46 +0000 (UTC)

--===============5635817760675365655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add unwind_goto and unwind_exit insns

TL;DR:
- Possible build failure on MIPS with CONFIG_BPF_JIT=y: bpf_unwind_target()
  uses e->fixup, which MIPS lacks
- Verifier may skip checking the fall-through after unwind_goto, allowing
  possible Spectre-v1-style speculative execution

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 6e32db9777c2..da3691b47cc7 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -804,6 +804,24 @@ const struct exception_table_entry *search_bpf_extables(unsigned long addr)
>  	return e;
>  }
>
> +/*
> + * JITs don't emit a branch for unwind_goto. They add an extable entry
> + *   { .insn = ret_addr - 1, .fixup = pad - ret_addr }
> + * where ret_addr is the return address of the call in front of it. unwind_exit
> + * replaces the return address of its frame with what this function returns.
> + * ret_addr - 1, because what follows the call can have an entry of its own.
> + * No insn starts there, so a fault cannot hit the entry.
> + */
> +u64 bpf_unwind_target(u64 ret_addr)
> +{
> +	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
> +
> +	/* The verifier made sure that unwind_goto follows the call */
> +	if (WARN_ON_ONCE(!e))
> +		return ret_addr;
> +	return ret_addr + e->fixup;
                          ^^^^^^^^

Does this still build on MIPS with CONFIG_BPF_JIT=y?

bpf_unwind_target() sits in the CONFIG_BPF_JIT section of kernel/bpf/core.c,
so it is compiled for every architecture that has a JIT, and it reads
e->fixup.  On MIPS, struct exception_table_entry has no fixup member:

arch/mips/include/asm/extable.h:
    struct exception_table_entry
    {
            unsigned long insn;
            unsigned long nextinsn;
    };

MIPS selects HAVE_EBPF_JIT and some defconfigs (loongson3_defconfig for
example) set CONFIG_BPF_JIT=y, so this looks like it would fail with
"'const struct exception_table_entry' has no member named 'fixup'".  Until
now generic code only used e->insn.

None of the later patches in this series touch kernel/bpf/core.c or
arch/mips, so the build would stay broken through the end of the series.

Should bpf_unwind_target() only be built for JITs that opt in through
bpf_jit_supports_unwind(), or should the arch decode the target (a helper
next to bpf_jit_supports_unwind()), or should the JIT do the lookup itself?

> +}
> +
>  int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  		    char *sym)
>  {

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d13868846823..dd2d200a73c3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18697,6 +18763,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>
> +	if (bpf_is_unwind_goto(insn)) {
> +		if (env->cur_state->unwound)
> +			*insn_idx += insn->off;
> +		env->cur_state->unwound = false;
> +		return 0;
> +	}
> +
>  	if (opcode == BPF_JCOND) {
>  		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
>  		int idx = *insn_idx;

When the callee left with unwind_exit, this only follows the pad.  The
fall-through insn after the call is never verified with the unwound state,
not even as a speculative path.

Is that enough given how the JITs implement it?  The x86 and arm64 patches
later in this series emit no branch for unwind_goto.  unwind_exit rewrites
the saved return address and then executes a normal ret, so the CPU's
return-address predictor still points at the insn after the call.  Each
unwind would then run the fall-through code speculatively before it is
redirected to the pad.

For a static subprog, prepare_func_exit() copies the callee's r0/r2 at
unwind_exit into the caller, and the callee may also have written caller
stack slots differently on that path.  So the fall-through code can run
speculatively with register and stack state the verifier never checked for
it.

check_cond_jmp_op() already handles the equivalent case for branches whose
outcome is known when !env->bypass_spec_v1:

    if (pred == 1) {
            ...
            if (!env->bypass_spec_v1) {
                    err = sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_idx);
                    ...

but the unwind_goto path returns before reaching that logic and has no
equivalent.  This would matter for loaders with CAP_BPF but without
CAP_PERFMON (including BPF token setups) on x86-64 and arm64, where
bpf_bypass_spec_v1() is false and bpf-to-bpf calls are allowed.  For global
subprogs the gap does not arise, since check_func_call() gives both paths
the same state apart from the unwound bit.

Should the unwound case push a speculative fall-through state when
!env->bypass_spec_v1, for example with:

    sanitize_speculative_path(env, NULL, *insn_idx + 1, *insn_idx);

Alternatively, could the commit message explain why speculative execution
of the fall-through after a return mispredict is not a concern here?
Neither the commit message nor the selftests later in the series cover
speculation, and no later patch in the series changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39205301464
--===============5635817760675365655==--
