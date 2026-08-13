Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEC375F69;
	Thu, 13 Aug 2026 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608715; cv=none; b=Gk9yx0HUjMjhdTsEeP5uX1lI5eaKbLh9M3hvABX2mYGYJ0pejpa7crMLem8UQfc5vd+kT+MASVvBbFz9L95S4MQnHtlNqpL4J4ehHHKjKsk21vw98HIOQzm7CuJQgizIez3HDsz9G1IzihHCcOnaNG+T4EKkZWpW9CLvcAlK9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608715; c=relaxed/simple;
	bh=qttu4fYmUDRy3FTNeF98wM3nW+uEUBnjwzf+ufmYzfc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uOrQU/JxpCQVCpXhBSUHRE6nZ7PETK5divD3qSrTZyti/LbxSDCxExpb58uSfzH1mn2ZsYZj90CQS0JwWZ6NTdoLaIIg+iwAPzIIQ7FQ7dMF4a9WrLnn2JA3u9/o5FDamg2sZvH81ZSS7+xAQKW1MAWb7b6DwefEakzrzvT3/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl1S1oS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl1S1oS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03161F000E9;
	Thu, 13 Aug 2026 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786608701;
	bh=oi6YfmylgiaRy6lZ9IbknTEinfCK3Vqt0CBXZSOgL1o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kl1S1oS26DfJC0qlVQi5CkPWT3JiLVwo5SRTC3qlChKX0AJZT2yiN70mfw6bIa4IQ
	 LXkPo2d96kO7zbiPPiVMdT9SR5iENs/SQqaFEqn5KmDoWtU8rXJx8AFq4fKBojnKN2
	 nQEd8QX0eDrJ9QYSa7GCjQhTvE2WMx6r40VIlLW8JaV8Mp/0u0YupODNX+wJOYBHVs
	 d3HJR4A5QjssDhqAzkA17r0ayG9Da3zc4/zupPDoK/zxJOSlvDuhZuCJj4FItSAzZ2
	 X5yUtOl5do5VeWiCrG8JdSUAzRDRNqR32g9cfLaXSakYypL2fLM3LacRP59by0s0xy
	 saBAtFnYGp7Ng==
Content-Type: multipart/mixed; boundary="===============9171113939442554113=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1dfa8001d720a33be0d34916414f80a04349057cd35e62ba71a8d0ef8528db69@mail.kernel.org>
In-Reply-To: <20260813-bpf-riscv-stack-args-v2-2-efea8f9b3fe1@kylinos.cn>
References: <20260813-bpf-riscv-stack-args-v2-2-efea8f9b3fe1@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Enable stack argument tests for RV64
From: bot+bpf-ci@kernel.org
To: jiangfeng@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,jiangfeng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 08:11:39 +0000 (UTC)

--===============9171113939442554113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
> index c8d716fbd4191..bae20f0f247eb 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions.c
> @@ -379,8 +379,9 @@ int exception_bad_assert_range_with(struct __sk_buff *ctx)
>  	return 1;
>  }
>
> -#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
> -	&& defined(__BPF_FEATURE_STACK_ARGUMENT)
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
> +	defined(__BPF_FEATURE_STACK_ARGUMENT)
>
>  const volatile bool has_stack_arg = true;

Can the code following this guard actually run on RV64?

The block enabled by this guard contains four bpf_throw()-based programs
(exception_throw_stack_arg, exception_throw_after_stack_arg,
exception_throw_subprog_stack_arg, exception_throw_subprog_after_stack_arg)
plus the has_stack_arg flag. bpf_throw is only accepted by the verifier
when the target JIT supports exceptions:

kernel/bpf/verifier.c
    if (!bpf_jit_supports_exceptions()) {

RISC-V implements neither bpf_jit_supports_exceptions() nor
arch_bpf_stack_walk() (only arch/x86, arm64, s390 and powerpc do), so both
fall back to the __weak definitions in kernel/bpf/core.c:

    bool __weak bpf_jit_supports_exceptions(void) { return false; }
    void __weak arch_bpf_stack_walk(...) { }

Consequently exceptions.bpf.o cannot be loaded at all on RV64 - the rest
of exceptions.c is full of bpf_throw() outside this guard - and the test
is already excluded from RV64 runs:

tools/testing/selftests/bpf/DENYLIST.riscv64
    # riscv64 deny list for BPF CI and local vmtest
    exceptions                     # JIT does not support exceptions

prog_tests/exceptions.c only consumes has_stack_arg after
exceptions__load() succeeds:

    ret = exceptions__load(skel);
    if (!ASSERT_OK(ret, "exceptions__load"))
            goto done;
    ...
    if (skel->rodata->has_stack_arg) {
            RUN_SUCCESS(exception_throw_stack_arg, 56);

so on RV64 the flag is never read. The hunk therefore changes nothing
observable on riscv64 and cannot have been validated there, which
conflicts with the commit subject 'Enable the stack argument selftests for
RV64'. The other seven hunks are genuinely effective; only this one is
not.

Either drop the exceptions.c hunk from this patch (and add it when the
RV64 JIT gains arch_bpf_stack_walk()/bpf_jit_supports_exceptions()), or
state in the changelog that it is deliberately pre-enabled for a future
RV64 exception implementation and remains untested for now.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31677823910
--===============9171113939442554113==--
