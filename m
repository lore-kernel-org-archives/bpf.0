Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986799;
	b=ueBgNaLms9n38k6hVBvWQHtXZphwWrwTaRMwCMlOkW66gkEfiRky5VL6a1VMx8ya0D/0
	 XXOnHUE737EAqzxJTGjIr9hleDScqFx0OZxT8fp6qSoCXaunJL6fL5lS4/aOEh9hKo5b0
	 y3fuZzOeyBIVI35usWEJrsjwWtxVhmL9VIYWr12feynaltVPmiaTgdCM5N/C7QLi0jAT+
	 KZflBTv0J5fVkf3gYhMSc9WpIIHFsypK+moT6lPHiCwy2664gFpeEcOYufO4qcJS3hLCV
	 X6BRbzi8V9N3yKgJwXWRODOZWQOJt76XzUnt13NH8YlWAcjQAR6/N9o82Cbmp4CiSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986799;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QT+8K2lc4RF0rsLJo59a7S3ejX4gidqyfcQQjNUUGOs=;
	b=2SOmkoza8RTKTvEEmFNCzl6xZhbzLsouY80eGa/GyLKQmK+R6dSPJDto4bY8E2avaVxw
	 dF7u73y/nvQZh7eOnBMJGryU5zUQaMkfJKQUj1O+zbii8Y/8owZa8cLM3vmAN5oVIW5zs
	 u12ddAY7aKEdwQyodNHJ2JdwAZpAf0FziEw8zi0NpdNY3jjZzcOjHtLWalMz4CTl/Z1ee
	 HXnv40aX5jutLBnS6U9ZqH+/zlnAITyi78tLuQ43geqCJRfM4/LXDpuw8NYtRlUbvGk1W
	 Cfkh65MDAsNsbemftvek4OIojTOI19Fx9qqtQzfVi843HanT/VM0bH+IF/uibfdVJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxKKViQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CC606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxKKViQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49F41F01825;
	Mon, 26 Oct 2026 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986798;
	bh=QT+8K2lc4RF0rsLJo59a7S3ejX4gidqyfcQQjNUUGOs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nxKKViQ19e7wyeE4kqkeFexsSiAr4/5dJSKaHNNl4rhjlloua9dGWIwO/TXel5nKw
	 arrgb2MvSY99aav/rTMXOdiicfudmvrenre8plBdAHOr5etmDnwivaI99rtxOBY2I8
	 SmGjzeueMWD1Bc77N4NwKW7UQQ45e6qhSNONZKPVnvQfBw6uOPHMYkJSiuZvFDDYkb
	 tvc0EtbEJB0nnhSHLC8LUvA5GzYvbAn8E5K7L+627U32WSr0LFP+kimhtf+RscYLew
	 H8/N2v6VqEVCf+Z3bcbeGWbWHB718Q2utmpTZq3qkc+fwJwvqvt6ooHwluLhsXl4I4
	 QIpqIqns7Co4g==
Content-Type: multipart/mixed; boundary="===============3883679089565608171=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6436180eed8c806eab442e4d46c3bc801442867a9a0e6ec557353a7d1ec242ed@mail.kernel.org>
In-Reply-To: <20261026025943.404450-79-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-79-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 78/81] selftests/bpf: Test progs that run out of budget
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:18 +0000 (UTC)

--===============3883679089565608171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test progs that run out of budget

TL;DR: Test issue: recursion_through_callback's bpf_loop() with constant flags
is likely inlined, so it doesn't test helper-frame (BPF_CALLBACK_OVERHEAD)
recursion as its comment claims; a non-constant flags value may avoid
inlining.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/testing/selftests/bpf/progs/verifier_budget.c
> new file mode 100644
> index 000000000000..c126ddb6bfd2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_budget.c
> @@ -0,0 +1,1159 @@

[ ... ]

> +/*
> + * calls_loop() -> bpf_loop() -> loop_cb() -> calls_loop(): the frames of the helper are on
> + * the stack too
> + */
> +static int loop_cb(__u32 i, void *ctx);
> +
> +static __noinline int calls_loop(int x)
> +{
> +	bpf_loop(1, loop_cb, NULL, 0);
> +	return 0;
> +}
> +
> +static __noinline int loop_cb(__u32 i, void *ctx)
> +{
> +	return calls_loop(i);
> +}
> +
> +SEC("socket")
> +__description("budget: recursion through a helper that calls a callback")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(0)
> +int recursion_through_callback(void *ctx)
> +{
> +	return calls_loop(0);
> +}

The comment says the frames of the helper are on the stack, but is that the
case here?  The flags argument is the constant 0 and the callback is always
loop_cb, so update_loop_inline_state() leaves fit_for_inline set, and
bpf_optimize_bpf_loop() replaces the call:

kernel/bpf/fixups.c:bpf_optimize_bpf_loop() {
    ...
		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
    ...
}

bpf_check() runs that pass before bpf_insert_recursion_checks(), so at run
time this looks like plain mutual recursion calls_loop() -> loop_cb() ->
calls_loop() with an inlined loop, with no helper frame between the BPF
frames.

That is also what recursion_with_inlined_loop covers.  The commit message
lists "recursion through the callback of bpf_loop()" and "recursion with an
inlined bpf_loop()" as two separate cases, so was this test meant to be the
one that is not inlined?

That is the case BPF_CALLBACK_OVERHEAD exists for, the frames of the helper
or kfunc between a callback and its caller.  I could not find a test in this
commit, or later in the series, that runs such a recursion.
recursion_via_global_func_and_callback in verifier_global_subprogs.c is only
loaded.

Would passing a flags value the verifier cannot see, for example
bpf_loop(1, loop_cb, NULL, zero) using the existing "unsigned long zero;"
global, stop the inlining while still being 0 at run time?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============3883679089565608171==--
