Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C07415F29
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502188; cv=none; b=qn8xPyhg8DkAPsE9fMruZTweOp1SCnN2FRM6tNXbOHSo3z+p42mC8RU0XKpDnuJ2FEy6S7PJqEOnIwfGtSYCLhHFljYUH/JWrVOqVoEBqPXN0kj2Um4U8plbiILGZH/gxdGqDyAkACF5t6W2UnbOXEs+bQ5EMVSW/tEHlciJn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502188; c=relaxed/simple;
	bh=sjk1Fz6IB4tc5Jvcrj5s7Tz6gEeEv2+F588btWlWD70=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t9OhdFOan+HcSDwgfZZI9Zv8AyOHLht4QT8sRsQu0AkuS0nIK0AU+wBw+0IL6fNcx32fIiqg3LKRY7GGFkB5fLk+YXHcX9vrip3MdxpOYVx/A2+c03HBsqzuZypRJJ2kmuObVwrBgAXsSHh2DFxLE0Jyr+uhGQbiCMl79M/TgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/4myiV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/4myiV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF561F00A3F;
	Fri,  4 Sep 2026 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502186;
	bh=7J9s8/nN0QOhN61w7E3LgsPm5kKCSHyzBHryByTvXYw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z/4myiV665EnJSmLiaB1Z3ahydrvECL12zBXdgPw9viUZaNv9XvPX/FixwF3L0+Kj
	 DjvGTQaaP01lVCL6ICTcUj/OUb2oLQGbFtHorN13koPtGZTK0yAGpeWj0DP66jxLhW
	 4S2VrKlg0fj9wySlYOlvcC/872byLexLoUyb8G/GjRBSA4TX7ws3s6mTB29pCnC27M
	 2/Ye8j6EgvDy5dzc+fXVD6PF3dinhjMHzfpnAp2Kq2LZzQj2do4uxDMh1URdbdBY1r
	 aYBc5Fd977N/JHMhM/L6h1Qq0Ip8AsA7q/bIcsa8q+hEqvc8fjSq0UPfeKj7gHL9I4
	 EPa9x/zelG/lA==
Content-Type: multipart/mixed; boundary="===============2186309978750082446=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad847760e5ace756d56643446a1eabb99354e2dfbdb394f0800c382933237420@mail.kernel.org>
In-Reply-To: <20260904051049.3982644-1-yonghong.song@linux.dev>
References: <20260904051049.3982644-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add C tests for by-value arguments up to 16 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:46 +0000 (UTC)

--===============2186309978750082446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
> index 044fc4a80055..b10fb4aeb405 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c

[ ... ]

> @@ -28,4 +153,43 @@ int aggregate_arg_int128_c_test(struct __sk_buff *skb)
>  	return 0;
>  }
>
> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
> +
> +static __noinline __u64 take_spilled_pair(int a, int b, int c, int d, struct pair p)
> +{
> +	return (__u64)a + b + c + d + p.lo + p.hi;
> +}
> +
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__success __retval(0)
> +int aggregate_arg_spilled_struct_c_test(struct __sk_buff *skb)

Should aggregate_arg_spilled_struct_c_test() include the __load_if_JITed()
tag?

The test calls take_spilled_pair(int a, int b, int c, int d, struct pair p)
which has 5 BTF parameters but 6 argument slots. btf_prepare_func_args() in
kernel/bpf/btf.c expands the 16-byte struct into two slots:

    nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
    while (nslots--)
        sub->args[slots_used++].arg_type = ARG_ANYTHING;
    ...
    if (slots_used > MAX_BPF_FUNC_REG_ARGS) {
        ...
        sub->stack_arg_cnt = slots_used - MAX_BPF_FUNC_REG_ARGS;

This path is reached for a static callee too: check_func_call() calls
btf_check_subprog_call() -> btf_check_func_arg_match() ->
btf_prepare_func_args() before the bpf_subprog_is_global() branch in
kernel/bpf/verifier.c, and then propagates the count into
caller_info->stack_arg_cnt. So bpf_in_stack_arg_cnt() returns 1 for
take_spilled_pair().

bpf_fixup_call_args() then rejects the program outright when the JIT is
not used:

    for (i = 0; i < env->subprog_cnt; i++) {
        if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
            verbose(env, "stack args are not supported in non-JITed programs\n");
            return -EINVAL;
        }
    }

This is in kernel/bpf/fixups.c, inside #ifndef CONFIG_BPF_JIT_ALWAYS_ON,
reached whenever prog->jit_requested is 0.

On the harness side, test_loader.c derives the runtime from the sysctl
and only skips programs that asked for the JIT:

    int current_runtime = is_jit_enabled() ? JITED : NO_JITED;
    ...
    if ((current_runtime & spec->load_mask) == 0) { test__skip(); return; }

and spec->load_mask defaults to JITED | NO_JITED. __arch_x86_64 and
__arch_arm64 only constrain spec->arch_mask, not load_mask.

So with /proc/sys/net/core/bpf_jit_enable == 0 and CONFIG_BPF_JIT_ALWAYS_ON=n,
the program is loaded, rejected with "stack args are not supported in
non-JITed programs", and the __success expectation fails.

The idiom for this is __load_if_JITed() (bpf_misc.h). The sibling file
progs/verifier_aggregate_ret.c tags every one of its __success __retval
cases with __load_if_JITed() for exactly this reason. Adding
__load_if_JITed() alongside __arch_x86_64 __arch_arm64 here would turn
the JIT-off run into a skip.

The same tag also appears to be missing on the stack-argument cases added
later in the series (progs/aggregate_arg_kfunc.c:
aggregate_arg_kfunc_last_regs, aggregate_arg_kfunc_straddle), and on the
pre-existing progs/verifier_stack_arg.c __success cases.

> +{
> +	__u64 a = skb->len ^ MIX_A;
> +	__u64 b = skb->len ^ MIX_B;
> +	struct pair p = { .lo = a, .hi = b };
> +	int n = skb->len;
> +
> +	if (take_spilled_pair(n, n + 1, n + 2, n + 3, p) != a + b + 4 * n + 6)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +#endif

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============2186309978750082446==--
