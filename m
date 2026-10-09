Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95F3BFADE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532120; cv=none; b=c6xp4RA0RUu33WmoK60BnGZUPT7VRUdMTHwe0FNvmqd0bTIxNvQWhuKhcrglVdvCO5C32LBIC4XseRbHIRhDkwLkQsJHstk+EDabwZtIYNUFjQuDAGfzeW3ahSqIauQyedsTrbQMi5ZDTw3TNQxK2mlnkAVinGqQwP/MYyY5Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532120; c=relaxed/simple;
	bh=u9BHlzKAKTZZNNE/aMNLgoarxhw8qaXugvuc4RvW3BI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Zo2QBdBg2NDo0qTYqZBpwe/o2L5KTYiaOvb7N5fF4N9MQTQP3itHeqhJpZ+biOQft8TqKAxX4TxQoAxJrgB9rpNa1vfoWjN/J9m/kcD5fsrq7FHTjXiOuaiV/p+xRalQGSM6StnnZmWgeRtCuFro7AybGGml2IErG1RW5Q/iVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKS8Jza6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKS8Jza6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C110A1F000FF;
	Fri,  9 Oct 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532119;
	bh=fjyMLPKu66fElG83gRMyuPww0uKw8CtOs4l2ONylyBk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fKS8Jza6QqxjUYq4RvHJziHNZTzO7R5FsKV+ULGk5qCwfVT2hZdhAjWim6JXOXZiP
	 C8LvJhbDu/u7X0vC2rYv/vcFI4QZWpvxkDeB3w+TcUYYHK1epc65m1Yq/yZC+mOwdp
	 3Nkmq8pgke92GoFbR43AmRVP2jWf1bW+sfLQilxJgt4ehzhpezH2IB0J2VRXNmUnUE
	 ENpq25zKriQju2vLzBu4Dj77GysnJXE1upu/lwy0itqDpB+h4LCe651SW6frmm7N8F
	 w9PuUjqJ6+BJx0sOB1EWj+YTtMBJ/9dcANWSHDQmD2oya/xi1PE7s0RU5pzFRMXULj
	 hxalLUy0ylPZQ==
Content-Type: multipart/mixed; boundary="===============5030884465141622234=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1a3ad8ec645f448311f5b01ed6bd8d4a4bec70c459e2e6c4e4b0026aadb3ee1@mail.kernel.org>
In-Reply-To: <20261009064233.1241063-1-yonghong.song@linux.dev>
References: <20261009064233.1241063-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Test trampoline args of a BPF function at an odd slot
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 07:48:37 +0000 (UTC)

--===============5030884465141622234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test trampoline args of a BPF function at an odd slot

TL;DR:
- On arm64, the callee_stack case may read an uninitialized stack value for
  h.hi, so its assertions may fail
- Silent test__skip() without a message (nit, matches existing idiom)

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c

[ ... ]

> @@ -162,6 +164,76 @@ static void test_int128_args(void)
>  #endif
>  }
>
> +static void test_int128_tgt_prog(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__)
> +	struct tracing_struct_int128_tracer *tracer = NULL;
> +	struct tracing_struct_int128_tgt *tgt;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err, fd;
> +
> +	tgt = tracing_struct_int128_tgt__open_and_load();
> +	if (!ASSERT_OK_PTR(tgt, "tgt__open_and_load"))
> +		return;
> +	if (!tgt->rodata->has_struct_arg) {
> +		test__skip();
> +		goto out;

A subsystem pattern flags this as potentially concerning, though this isn't
a bug: test__skip() is called here without any message, and the #else branch
for other architectures does the same.  When the target object was built
without by-value struct argument support (a GCC BPF build), the run shows a
bare SKIP with nothing explaining what was missing.

The pattern says a test that skips silently with no message should be
reported.  test__skip() takes no message argument, and test_int128_args()
and prog_tests/stack_arg.c use the same bare test__skip() call, so this may
simply match the existing idiom.

Would a printf() of the reason before test__skip() be worth adding here?

> +	}
> +	fd = bpf_program__fd(tgt->progs.run);

[ ... ]

> +	if (tgt->rodata->has_stack_arg) {
> +		ASSERT_EQ(tracer->bss->stack_g, 7, "stack:g");
> +		ASSERT_EQ(tracer->bss->stack_lo, 8, "stack:h.lo");
> +		ASSERT_EQ(tracer->bss->stack_hi, 9, "stack:h.hi");

Does the callee_stack half of this subtest pass on arm64?

In the BPF convention, callee_stack(a, b, c, d, e, f, g, struct int128_arg h,
i) uses argument slots 0..6 for a..g, 7..8 for h and 9 for i.  The arm64 JIT
passes BPF slots 5..7 in x5..x7 and slot 8 onward on the stack, so h.lo is in
x7 and h.hi is at [SP + 0].

For a BPF target, commit 0ee21f37b2cb ("bpf: Keep the BPF calling convention
for a trampoline on a BPF function") makes bpf_jit_place_args() return the
identity mapping:

    if (fm->bpf_tgt_prog) {
        for (i = 0; i < fm->nr_args; i++)
            for (k = btf_func_model_arg_slots(fm, i); k > 0; k--, slot++)
                pos_of_slot[slot] = slot;

The arm64 code decides whether an argument is in registers or on the stack
from its first slot only, in calc_arg_aux():

    if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register ? */
        break;
    slot += slots;

h starts at pos 7, so it is counted as a register argument (args_in_regs = 8,
regs_for_args = 9).  Then save_args() handles h's second slot with:

    reg = a->pos_of_slot[slot++];
    ...
    emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);

with reg = 8.  That stores x8 (BPF R0 in bpf2a64[]) into ctx[8] instead of
reading h.hi from the stack.  On the call-origin path the same loop reloads
x8, and the stack loop writes only i, at oargs_off + 8.  The outgoing slot 0
is never written, so callee_stack() would read h.hi from uninitialized
trampoline stack.

With a clang that defines __BPF_FEATURE_STACK_ARGUMENT, should the
"stack:h.hi", "stack ret" and "stack fexit ret" assertions be expected to
fail on arm64?  A leftover kernel stack value would also end up in the traced
program's return value and from there in a map that userspace can read.

Before 0ee21f37b2cb the AAPCS64 placement never split an argument
(arm64_arg_abi has no split_at_boundary), so the per-argument classification
was safe.  The identity mapping, whose comment says "no split refused",
breaks that assumption.  x86 doesn't hit this because its
save_args()/restore_regs() classify each slot.

The commit message describes callee_stack() as covering arm64, but only the
x86-64 failure output is shown, and no commit in the series changes
arch/arm64/net/bpf_jit_comp.c.  Was this run on arm64?

Either the arm64 trampoline needs per-slot handling for models with
bpf_tgt_prog set, or the callee_stack case needs to be gated off there.

> +		ASSERT_EQ(tracer->bss->stack_i, 10, "stack:i");
> +		ASSERT_EQ(tgt->bss->ret_stack, 385, "stack ret");
> +		ASSERT_EQ(tracer->bss->stack_ret, 385, "stack fexit ret");
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282
--===============5030884465141622234==--
