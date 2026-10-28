Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150737;
	b=M7iv6bZBQE9Nt40QGeYfV85MEIjaZu9FjXkSglVWU6FP6rF3yYUJ2zDMnrj+svJR1ZMo
	 ZrmRd82bTkbHQFdicHE6ZJKFGqu6GIr4/cc9lD/FJHhGTCU1fgdqWWpRWc3zjFv5QXsYN
	 HHf2TqWh5vUIBH8nsLdbnd4SMmMmXklwI/jaIEnoMjpM4RAP909lP6cyF5SwmJnVbpY6Y
	 puDUJ3XtD/ieKCFVEKvsoZc9/xBSA/PNSguoZEUxrdzU6eMPRo2/OYtzhuqNVaCVxaKy5
	 KmoEiUCJSTza0gjGL7uL65eGzwzMlMzeI4U1EDRDWlAw7OiKcpUSWU4JE4vUvqlop6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150737;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=iUFl/fn180TykZ3yONJMrKvZttftbmNs+wwJhjkejPA=;
	b=uAUnHDy5nvOw/BQyUpnakq68flD+l8qJiXA6tCqy3gNeXGh+fyLehWf/vbtnhuqKfqTf
	 D5QBFZe+Joc82ynEN67SW1rorUezhKskpD3o158OZkqWGeUIo8CFlxSBXJor1qN8IDDa+
	 YFGqQWQGej80UVc9j70Z13/ql+Seaa/0iwbo7pgadMXOjtvZyVS1pi6KVd8FaSD6YMsBl
	 5PodXgK3Gq46Pu0zpiLC3H85t6UwiQqbQxVBZoBKNBIGqopPW8zD6YVor9tr/dqh3/Ykk
	 JcSwISbFuS4XMolkHyz96mJjdTw0YwpGcZPWRsRa9o9HT96pXNaGV8b6JWXYp9ZtMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdgOPhJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117A606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdgOPhJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6441F01825;
	Wed, 28 Oct 2026 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150736;
	bh=iUFl/fn180TykZ3yONJMrKvZttftbmNs+wwJhjkejPA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IdgOPhJ9xsE3MqiwNMUbjAtMBZzE0XlDWspR6EP+fI+Z2SVHIGA1bQsQNE5Zxr0kA
	 n3lnVUTKXH+P0FqGkCjJN5AtfOcYPLsw6YDeQKCJhEU3ngYudPiRPW9uT3zWY/xJbY
	 0N1BbytUHfsOVhFoqXdJA9zkbYGX+3s0uC7fdbsHsmOt8fHXT6NHirwkOI689w0kwz
	 qL09CgDVaU5K75M4dRQFVCrGxXIc/RGluRwjCCStZwe8GvLZM9jjf4awdtsE8R47ZU
	 hkPrvWmS71GQu+swkIaiI2Iu/uzcY7WTZ4Ng5Jvsm2SeK4qwPynjgFnzgbs2NEm23P
	 /CLTXKw0VtI4g==
Content-Type: multipart/mixed; boundary="===============3508130379299656002=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6588701a3bed9893f94098c228cc7e451f323612c151ba676f712eac8bf80cae@mail.kernel.org>
In-Reply-To: <2fb53df72300b10ba5f5aff123c331b80a7c4be5.1793147364.git.memxor@gmail.com>
References: <2fb53df72300b10ba5f5aff123c331b80a7c4be5.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 10/11] selftests/bpf: Test callbacks that unwind
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:25:36 +0000 (UTC)

--===============3508130379299656002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test callbacks that unwind

TL;DR: Selftests may fail instead of skip on x86_64/arm64 kernels built with
older gcc (no asm goto output), where callback pads are absent: unwind_drain
load error and the changed callback_unwinds message expectation.

> diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_drain.c b/tools/testing/selftests/bpf/prog_tests/unwind_drain.c
> new file mode 100644
> index 000000000000..54b9cfbef440
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unwind_drain.c
> @@ -0,0 +1,71 @@

[ ... ]

> +void test_unwind_drain(void)
> +{
> +	struct user_ring_buffer *rb = NULL;
> +	struct unwind_drain *skel;
> +	int err;
> +
> +	if (!is_jit_enabled()) {
> +		printf("%s:SKIP:JIT is disabled\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +	skel = unwind_drain__open_and_load();
> +	err = libbpf_get_error(skel);
> +	if (err == -ENOTSUPP) {
> +		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;

The test skips only on -ENOTSUPP, which is what check_unwind_insns() returns
when !bpf_jit_supports_unwind().  Is that enough on a kernel whose JIT
supports unwinding but whose helpers have no callback pads?

On x86_64 or arm64 without CONFIG_CC_HAS_ASM_GOTO_OUTPUT (gcc < 11.5,
12.0-12.3 and 13.0-13.2, see GCC_ASM_GOTO_OUTPUT_BROKEN in
scripts/Kconfig.toolchain), BPF_HAS_CB_PADS is 0 in
include/linux/bpf_unwind.h while bpf_jit_supports_unwind() still returns
true.

Loading drain then goes through:

push_callback_call()
  check_cb_unwind()
    verbose(env, "callback cannot unwind\n");
    return -EINVAL;

unwind_drain__open_and_load() returns NULL with errno = EINVAL, so the
-ENOTSUPP check is false and ASSERT_OK_PTR(skel, "open_and_load") fails the
test where it should skip, since the kernel does not offer the feature in
that configuration.

Should this also skip when the load fails with "callback cannot unwind" in
the verifier log (for example via bpf_program__set_log_buf()), or should
the kernel return -ENOTSUPP for that case so that this check catches it?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
> index 5a21345c34d4..3de145a2d065 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unwind.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
> @@ -896,12 +896,13 @@ static unsigned long cb_unwinds(void)
>  	);
>  }
>
> +/* bpf_loop() has a pad for it, so what's missing is the one after the call */
>  SEC("tc")
>  __description("unwind: callback unwinds")
>  __arch_x86_64
>  __arch_arm64
>  __load_if_JITed()
> -__failure __msg("callback cannot unwind")
> +__failure __msg("no unwind_goto after the call of bpf_loop()")
>  __naked int callback_unwinds(void)
>  {
>  	asm volatile (

The new expected message is only what the verifier prints when
BPF_HAS_CB_PADS is 1.  In include/linux/bpf_unwind.h that is the case only
for defined(CONFIG_X86_64) && defined(CONFIG_CC_HAS_ASM_GOTO_OUTPUT) and
the arm64 equivalent; the #else branch sets it to 0 and calls the callback
the plain way.

check_cb_unwind() in kernel/bpf/verifier.c tests that first:

    if (!BPF_HAS_CB_PADS || !insn_has_cb_pad(insn)) {
        verbose(env, "callback cannot unwind\n");
        return -EINVAL;
    }

so on such a kernel the log for this program still says "callback cannot
unwind" and never reaches "no unwind_goto after the call of bpf_loop()".

CC_HAS_ASM_GOTO_OUTPUT depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
(scripts/Kconfig.toolchain), which is y for GCC_VERSION < 11.5, 12.0-12.3
and 13.0-13.2, while the minimum gcc is 8.1 (scripts/min-tool-version.sh).
An x86_64 or arm64 kernel built with gcc 11.4 (Ubuntu 22.04), 12.2
(Debian 12) or 13.2 therefore still has bpf_jit_supports_unwind() == true.

check_unwind_insns() does not refuse the program there, so __arch_x86_64,
__arch_arm64 and __load_if_JITed() still let it load, and
verifier_unwind/callback_unwinds now fails.  Before this hunk the
expectation was correct on that configuration.

Nothing in the test can express the compiler dependency.  The new
verifier_unwind_cb.c tests in this commit depend on the compiler in the
same way.

Can the expectation be made to hold in either configuration, for example
with a regex that accepts either message, or can the test skip when the
helpers have no pads?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============3508130379299656002==--
