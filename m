Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557884;
	b=350YzjCGernyej9bTEYKFZ+w4ubpIW9EzL3MGxfZ9dXhFy75K4mid2uxGF1B7hYe9OT/
	 8VxNHf5+gBMw3eE7LAjMXWU7czmR2pSjeJtfLbKQmINuuvDY0sB9udpptrH5UgmD/WyIW
	 qCl7gq+tJ9928mNFB12SzAuTb4drkWIhoYm2k+sY2751KjWKTd8MBBza6TkWf2I3JxeW1
	 fcNC/pIc+EyEvq5QcGLHqEV/62SmW1yW8pcjvqhsj356sfw1Ox9cmlCqwL7iME895MW1R
	 reUZvMk4AnxzEVkvFX2V7kD+puwG00oPvnnumBSsLr598hVI4D7Ze7gzIWRAtxIU7mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557884;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=noxXZsFaiYKZpmIh+5P0JmnW1Vf3sBx9HEZ5XiMmsLk=;
	b=5nt2UCX9H58YwRkjodJqteTjKf3oAiKQ15jFX0jIE4kryWD3ARPPehWj1h9ym0/juneh
	 ezE9oLol45WorNnJ6uohOUk6tEj+wzx9MbCk0hDrNlsJG44Ydvs1TC7AKkcXbYDL40/OO
	 XYyb7ur+NFFZqQouBgQutbCJlogxZGQiV0ldhoH/hxpBDY8PeQTuuUPzV4SRJZR82Y4nk
	 LSMW0UcbSxxiWDDmP9NSUlyUVga+TNgTcepAZ7enZ3RN8kDEucs7NjXg/LPlZtDehgrGj
	 wdHy6f2Lj0Uv+zmbB/aQWmTv7z/UKZjSlJEZf7i4zH54ZnC41Az8DX3UXh/ta4avvDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7jMUlTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2F606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7jMUlTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A191F000C1;
	Sun,  1 Nov 2026 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793557883;
	bh=noxXZsFaiYKZpmIh+5P0JmnW1Vf3sBx9HEZ5XiMmsLk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m7jMUlTSlxplXFhKsjtkBufxkBuXa5Qg+zVhD0xjkrqW3x5AarQiIP+0zIsLRWjAW
	 uwW2+bkjpRqNDafApy/jzuI1X9IGP911fq2Z/m2FCIwvr9S9kpIITC8BHO8+fs1vA0
	 l6XxF+rBY1Y0ycxpITxVBBl7Rl/zOk7FyRSgV9M7PNkVjBDypcPEpj6FyEySurNOe/
	 ZLIX7YEx1mfwhMVrqcdDDRqfagxiQ767jl/vyOpSScAxGmCucA6ThNMmbN78mgP3/E
	 cd+t1w5o51qutmFB6LvdqtXkMEY2D9Owi/pVz/V3Lw3FHCGbog3X0WuNDf8sHtRHB0
	 qHjkPpP9V/Liw==
Content-Type: multipart/mixed; boundary="===============2438624405266919593=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8581ffeb7c773e5dc931ab99c0fd6a7cee06a0771aefddce1183890550402cb7@mail.kernel.org>
In-Reply-To: <20261101174405.4055052-3-alexei.starovoitov@gmail.com>
References: <20261101174405.4055052-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test liveness of an implicit kfunc argument
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 18:31:23 +0000 (UTC)

--===============2438624405266919593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test liveness of an implicit kfunc argument

TL;DR: The new selftest uses the may_goto mnemonic in inline asm without an
__BPF_FEATURE_MAY_GOTO guard, so older clang (e.g. 18) may fail to assemble it
and break the whole selftest build.

> diff --git a/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
> --- a/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c

[ ... ]

> +/*
> + * r0 and r1 are live at may_goto, r2 is the first register that is not. The
> + * insns that the verifier adds for may_goto are free to use r2: 'r2 = aux'
> + * comes behind them.
> + */
> +SEC("syscall")
> +__retval(5)
> +__naked void implicit_arg_after_may_goto(void)
> +{
> +	asm volatile (
> +	"r6 = 1;"
> +"1:"
> +	"r0 = r6;"
> +	"r1 = r6;"
> +	"may_goto 2f;"
                  ^^^^

Can this build with a clang that predates the BPF assembler support for the
may_goto mnemonic?

implicit_arg_after_may_goto() writes may_goto straight into the inline asm
with no guard.  The LLVM BPF assembler learned the mnemonic after LLVM 18
was released, together with the __BPF_FEATURE_MAY_GOTO macro.  Commit
965c6167c93f ("selftests/bpf: Using llvm may_goto inline asm for cond_break
macro") says "Using llvm may_goto insn is controlled by macro
__BPF_FEATURE_MAY_GOTO".

With an older clang, the asm fails to assemble, so kfunc_implicit_args.bpf.o
is not built.  kfunc_implicit_args.skel.h is then missing, and test_progs
and its no_alu32 and cpuv4 flavors fail to build.  That takes down the
whole BPF selftest build, not only this test.

This looks like the only unguarded use of the mnemonic under progs/.  The
other users either guard it:

verifier_large_stack.c and verifier_stack_ptr.c:
    #ifdef __BPF_FEATURE_MAY_GOTO
    ...
    may_goto l0_%=;

or encode the instruction as raw bytes, as compute_live_registers.c and
verifier_may_goto_1.c do:

    ".8byte %[may_goto];"
    ...
    __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, ...))

libarena/include/bpf_may_goto.h also falls back to ".byte 0xe5 ..." when
__BPF_FEATURE_MAY_GOTO is not defined.

The selftests still support pre-19 compilers on purpose: bpf_misc.h gates
features on __clang_major__ >= 18, and commit f7213961e8e2 gates on LLVM 23
and falls back to a dummy test.  Ubuntu 24.04 ships clang 18 as its default.
The default LLVM version in .github/scripts/matrix.py is 21, so that
configuration would not exercise this.

Should implicit_arg_after_may_goto() be wrapped in #ifdef
__BPF_FEATURE_MAY_GOTO, as verifier_large_stack.c does?  Alternatively,
could the instruction be encoded with .8byte and __imm_insn(), as
compute_live_registers.c does?  For that option the file would need
BPF_RAW_INSN, since it includes vmlinux.h and not
../../../include/linux/filter.h.

> +	"call %[bpf_kfunc_implicit_arg];"
> +	"if r0 != r6 goto 2f;"
> +	"r6 += 1;"
> +	"if r6 < 5 goto 1b;"
> +	"r0 = r6;"
> +"2:"
> +	"exit;"
> +	:
> +	: __imm(bpf_kfunc_implicit_arg)
> +	: __clobber_all);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41334428337
--===============2438624405266919593==--
