Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832034;
	b=U6QPPSD3Yk6wXh/c27GtOWGtgtUzDtpaGXzQtNspKvWGKTINPT80YulaGQAVwgTtrFfb
	 R9v8zEzav8VC8gDul/MzsxLF/M+/PAl6GfEosKRZu6Ni6CJJK1lI6oOTwMKri/28zDVJN
	 jnkX423H04yS5h21HBX2I2K9h6AX76go58moEyo0DBa8TXbyAO71ShFO6VCB41YUtujTX
	 vrqiFRxXOhIb55zEpFzJeadEzDFnsRQrQCGex4NTX7x3162KiwzLniPDrKqn3edaq9exE
	 utnPxxJGx5T9Sqw/8/8cgMzK5kWA46D50Ua116Gm5XfRN2N69EdTiSz79cLJqXdSajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832034;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1KuwbhRYS8evU/5GR37yFGBoWIymzEOg/VrvKxMvfJo=;
	b=WClfEBXnyLgCXqAAUGQaEdFuJk0eHoEczu5Az5nRPU4qA9bSBWkKhy6NJ2fyek7weJKy
	 I9UrVQZ9sZWZoMqDIGiD8JWAwfiT8yJj+TcYBPsmux+8KQWQpmMxbsBKFBaBHuEJAX3Kx
	 3mSE3Yzt6S+VtQcc5cVz6fuhepzsbxILwardjptnxSs+iKVYJyZ+xKc+3nFcwud/xtKtF
	 UuhEsUC56rEOIYKJqy7/4BFku8unxntrtrRPfA8M2yC8KGaiwn0FReJWBJ33iHlirC15J
	 CuQfiSzwGh7Rewid+UmxV18aOnLWhMhhL/7j1dyJbwFAGj6nKQLHWO1RDwg/hyjNHMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5OuOeV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319C606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5OuOeV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA931F000C1;
	Wed,  4 Nov 2026 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832033;
	bh=1KuwbhRYS8evU/5GR37yFGBoWIymzEOg/VrvKxMvfJo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g5OuOeV+uC4XPhTlC/gGM8/rTSOrZyLoVFePjbf0/6gJUvOua/vTlYyvQqLmHom5J
	 fA0GywvudeLs4UA/6AAWCsoZtuJ1CtU5M9sEBTlLKESbiGh0Sbx1JCZdAI1RCE30ER
	 Ik+ArdX8s9gWUZujGh6dUhT4S3BDlmYU6B4NnUqTphUuXPJpuNbKXnfBa72BLg+22h
	 MZxK8HuAaSfD91uwlH9+KAhbT2MYLLCbCsHw8TJhP8ucve6NvwI00q2HI174sGwUQz
	 LHFe+tAZv6Yen4qdo4A70NfA2np3cPsgqbnW3HjLxZdp3Smf/sV/nTU+Pjl2UcnjBL
	 NH2YYE6cqAlMA==
Content-Type: multipart/mixed; boundary="===============9185524490659806987=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a87dc20e1ec5a9b71efac37998600cdf8449e5cfbfdba8391138f2a79089c90e@mail.kernel.org>
In-Reply-To: <20261104215523.1852636-9-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 8/9] bpf: Bump MAX_CALL_FRAMES to 32
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 22:40:33 +0000 (UTC)

--===============9185524490659806987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Bump MAX_CALL_FRAMES to 32

TL;DR: Raising MAX_CALL_FRAMES to 32 may let bpf2bpf chains plus tail calls
overflow the kernel stack at run time, since the 256-byte check counts only
BPF stack. The gap predates the patch, which doubles it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6127,6 +6127,16 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
>  			goto out;
>  		}
>  
> +		err = -EOPNOTSUPP;
> +		if (dinfo[s].frame >= MAX_CALL_FRAMES_INTERP) {
> +			if (!env->prog->jit_requested) {
> +				verbose(env, "JIT is required for a call stack of more than %d frames\n",
> +					MAX_CALL_FRAMES_INTERP);
> +				goto out;
> +			}
> +			env->prog->jit_required = true;
> +		}
> +
>  		err = -EACCES;
>  		depth = dinfo[s].arena_depth + si[s].arena_stack_depth;
>  		if (depth > env->max_arena_stack_depth)

Can the combination of 32 frames and tail calls overflow the kernel stack
at run time?

The only bound on bpf2bpf calls combined with tail calls is the rule in
check_call_depth() that the summed BPF stack of the callers of a subprog
that tail calls must stay below 256 bytes:

    if (s && si[s].has_tail_call && depth >= 256) {

That rule counts only BPF stack, not the kernel stack each JITed frame
takes.  On x86-64 a tail_call_reachable subprog uses at least 32 bytes of
kernel stack even with stack_depth 0 (the return address, push rbp in
emit_prologue(), and push rax; push rax in emit_prologue_tail_call()).  A
tail call unwinds only the frame that makes it, so the callers' frames stay
on the stack while the next program runs, and the tail call counter is
shared through tcc_ptr, so MAX_TAIL_CALL_CNT (33) tail calls can happen in
one run.

For example, main calls f1 .. f31, all static with no stack, and f31 calls
bpf_tail_call() into a prog array slot holding the same program.  f31 is at
frame index 31, below MAX_CALL_FRAMES, so it is accepted.
dinfo[f31].depth is 0, so it passes the 256 check, and the program is
JITed because jit_required is set.

Each tail call level then keeps 31 frames * 32 bytes = 992 bytes.  After 33
tail calls that is about 32.7K, twice the 16K THREAD_SIZE and IRQ_STACK_SIZE
on x86-64 without KASAN.

The gap existed before this patch, since with 16 frames the same
construction keeps about 15 * 32 * 33 = 15.8K plus up to 33 * 240 bytes of
BPF stack.  But doubling the frame limit doubles the term the 256-byte
check does not count.

The commit message does the stack arithmetic only for the verifier's
analyze_subprog() recursion, not for runtime tail call chains.

Would it make sense to limit tail_call_reachable chains to
MAX_CALL_FRAMES_INTERP frames, or to add a per-frame cost to the 256-byte
tail call check?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41921975876
--===============9185524490659806987==--
