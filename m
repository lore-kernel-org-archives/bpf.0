Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82C57EDBE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194384; cv=none; b=QE/1gaftj0nyJJ/aUpMLC6NSkP12HlnslrSDBB3nN8qZ/ITsb3OquJODQ2aqVF1t09tfdzmgjFwxDfPyt/h8HcKoImAZRIbxdtDrOBDfPy+bjE61o3tkbLL5wT5Yd0NEgsBtsDQftyo+l9seSUFwbsKmbBIrQ6DskEiU9Tj6mNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194384; c=relaxed/simple;
	bh=BPbbh6VLm/RV1u50zN/0uc6vRLyE78uhCKW0eDrK7e4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XFANAOpYLQvHg23Ln57E240owMHf3pmYHU7sIl7FgblvMlS0ytW9uObN35DAZTgpyH8MIf7+Lie6WDcvgOoPeEdbfSa9/7ed6NzONnjSJkmnptvX480vI/HqFReNEsG51SDzMgf++ZylQbQn4CM96He+BPM5tdhvj0kXOibzlhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5kLo7vP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5kLo7vP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9700B1F000FF;
	Wed, 23 Sep 2026 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194370;
	bh=n3FxEWBUOc/jj1LhV1fJQBtLeWJ4UN78c1CtDHrxZ54=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E5kLo7vPYLW9gKgwoN395aJETB8HBZWm4+Mre+QIEERxkNomPlmgCRKqokWcenw6a
	 GAyNV8Tla2KC/VqMR51ncVMovIwifm7UjswMPoCPL8uytnWsfTTcHbw+p/IDAtIRI5
	 VXQak6kggOdpJey3txW7krlqcrNw20dH1LzQHq+PmybFwAZvbdgSjnN1eE5gWIB9iP
	 cYNv1NMd7sgO53kSKN3sH9EBenfEWF6W9r+TVrFfD+dpU392t71PzanCzzV+vIjJkG
	 nG6p20EUe87iLC3b40S56OwpzN0S0DQmrevmRFjp0HTiJQl6O3KjtjPC1mXgjbLk29
	 HwDuy7upgWDcQ==
Content-Type: multipart/mixed; boundary="===============8741637474100580299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da4e6f7d608df34719ae1c05ec5da4da9f53e42adfde8e80d653ef0017c3bf47@mail.kernel.org>
In-Reply-To: <20260923191139.2816206-17-memxor@gmail.com>
References: <20260923191139.2816206-17-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 16/18] bpf, x86: Allow programs 2 KiB of stack
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:12:48 +0000 (UTC)

--===============8741637474100580299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index eb19c945f4d5..be5fc4ac00d6 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -221,9 +221,13 @@ newer kernels. BPF programs need to change accordingly when this happens.
>
>  Q: How much stack space a BPF program uses?
>  -------------------------------------------
> -A: Currently all program types are limited to 512 bytes of stack
> -space, but the verifier computes the actual amount of stack used
> -and both interpreter and most JITed code consume necessary amount.
> +A: A program may use up to 2 KiB of stack, combined over its call
> +chain, when the JIT of the architecture reports support for large
> +stacks (currently x86-64); a single function may use all of it, and
> +every frame of a program running on a private stack gets the whole
> +amount. Elsewhere, and whenever the interpreter is used, the limit is
> +512 bytes. The verifier computes the actual amount of stack used and
> +both interpreter and most JITed code consume necessary amount.

Is the interpreter limit stated correctly here? The text says "whenever
the interpreter is used, the limit is 512 bytes" in a paragraph where
2 KiB is defined as combined over the call chain.

When bpf_jit_supports_large_stack() returns true, a program with
jit_requested set is verified against MAX_BPF_STACK_JIT (2048) in
bpf_check() via env->stack_limit = bpf_prog_stack_limit(env->prog), and
check_max_stack_depth_subprog() bounds the combined depth of the call chain
by that limit.

If JIT compilation then fails with anything other than -EFAULT (for example,
a subprogram not being jited returns -ENOTSUPP in bpf_jit_subprogs(), or an
allocation failure during blinding occurs) and CONFIG_BPF_JIT_ALWAYS_ON is
not set, bpf_jit_subprogs() restores the instructions, clears
prog->jit_requested, and bpf_fixup_call_args() falls back to the
interpreter. The interpreter checks on that path are per frame in
bpf_patch_call_args():

    int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
    {
        stack_depth = max_t(u32, stack_depth, 1);
        /* Prevent out-of-bounds read to interpreters_args */
        if (stack_depth > MAX_BPF_STACK)
            return -EINVAL;

and bpf_prog_select_interpreter() for the main frame.

A chain of four subprograms each using 512 bytes (2048 combined) would be
accepted by the verifier and run in the interpreter, whereas before this
patch the combined chain was capped at 512. Each interpreter frame has its
own stack array, so this is not an out-of-bounds access. Should the text
clarify that the interpreter's 512 byte limit applies per function, or
should the fallback path reject a chain whose combined depth exceeds
MAX_BPF_STACK?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35909853278
--===============8741637474100580299==--
