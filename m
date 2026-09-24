Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD23AC0EF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222180; cv=none; b=j8nDuDg3Dge5GwNiX7pFZqsE4w1D5X/EKowWw4blL7wwcgiQb8G67ST0LHF05/X3e/3yo1qxFYIoa1ACpfgH4d+u4nEwwqzBunor8ILAq2GB0knguYaHYJbArUKGYxWd61GrfOIDiQ7/j8rGLlKZv6shs/DJ19OUuhbfprVFVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222180; c=relaxed/simple;
	bh=RotpGiA05m+p0Amug6HPkQ1OcXVJJYrOYgXatiaygZg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fXAZEDCXreQE66LLIjU28Zj8pMQIdCCdRaBeObCfgGMHtDoMx4G4anwwMEI/8EQNihrQQYMKHxGD9c/33tUHByZWD48/Msln7ycJSqDC04C563dNJuEva1v2lLHexL5qbjtRq9dXLvWMz+QVwMbQiT8TNiSUVLyMIUvMeLAOX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdBL8wvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdBL8wvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051DF1F000FF;
	Thu, 24 Sep 2026 03:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790222179;
	bh=3s/iTWKRnntYee5bNdR/4pwL2asbyaja04eCrtTR6SA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WdBL8wvxtEAwbrLOsscd7hbubogyz609wWPnWpIkj3ssWMGR4HTd297C/Jp83/EWO
	 Yr7pFK6K8MN87izrWXZiODx7IJNpqLFFx3AgPlxKUykQmXOGCIX9Fj2de6xxJ2TQEt
	 b/b+ZQqeGMP4RoQSgUGGjVbLio4mm6Kt2zevcSNHw5U+B6kVgFU3clpurq/rB3C9dG
	 +vPAlQBsojhQ5OIY2zihmNw42G6fJ417WAHxtla+oJPpKL6Scdl/TWzxN0jZdJIZdq
	 a/O7/4kaklZSiqrXjneFRsgHIOsmwJgFb84614d37pLuEFurUny8oajheSeG2G7CN/
	 7NEc6oXPtyJMw==
Content-Type: multipart/mixed; boundary="===============5293372113419748155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a38d9324b4b99767bf5b5988a7f6852c7815a5db8c3b1ec3f3440e59cc1d760@mail.kernel.org>
In-Reply-To: <20260924031042.1690890-16-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-16-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/17] selftests/bpf: Add tests for callx
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 03:56:17 +0000 (UTC)

--===============5293372113419748155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 8b4be06bb181..bc96a752b1ae 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> @@ -173,6 +174,14 @@ static void run_tests_aux(const char *skel_name,
>
>  #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
>
> +/* for tests of what the interpreter doesn't support */
> +#define RUN_JITED(skel) do {		\
> +	if (is_jit_enabled())		\
> +		RUN(skel);		\
> +	else				\
> +		test__skip();		\
> +} while (0)

Does RUN_JITED() properly check JIT support for callx?

Looking at the kernel side added in this series, callx is rejected
in more cases than just the JIT being off:

kernel/bpf/verifier.c:require_callx_jit() {
    if (!env->prog->jit_requested) {
        verbose(env, "JIT is required to use callx\n");
        return -EOPNOTSUPP;
    }
    if (!bpf_jit_supports_callx()) {
        verbose(env, "JIT doesn't support callx\n");
        return -EOPNOTSUPP;
    }
    ...
}

Only x86 and arm64 implement bpf_jit_supports_callx(). Everywhere else the
__weak default in kernel/bpf/core.c returns false: s390x, riscv64, powerpc,
loongarch and others. On x86 it also returns false when cfi_mode ==
CFI_FINEIBT. By default FineIBT is picked on IBT-capable CPUs when the
kernel is built with CFI support.

RUN_JITED() only checks whether the JIT is turned on via
is_jit_enabled(), which reads /proc/sys/net/core/bpf_jit_enable. In all
of the cases where bpf_jit_supports_callx() returns false, bpf_jit_enable
is 1, so RUN_JITED() goes ahead with RUN(verifier_callx). Then:

- Every __success program in progs/verifier_callx.c fails with
  "unexpected_load_failure". check_func_callx() and the rodata read path
  both call require_callx_jit() and get -EOPNOTSUPP.

- Most __failure __msg(...) programs also fail. The log says "JIT doesn't
  support callx" instead of the expected message.

None of the 40 programs in verifier_callx.c have __arch_* annotations.
DENYLIST.s390x and DENYLIST.riscv64 do not list verifier_callx either, so
test_progs will report FAIL, not SKIP, on the s390x BPF CI.

The selftests guide says a missing capability that causes EOPNOTSUPP must
lead to a skip with a reason message. Here the test fails, and in the
bpf_jit_enable=0 case test__skip() is called with no reason.

Other JIT-only verifier tests already handle this per program, using the
__arch_x86_64 / __arch_arm64 annotations together with __load_if_JITed()
(see progs/verifier_arena.c:641-642 and progs/arena_kfunc_jit.c).
run_subtest() in test_loader.c already applies both the arch mask and the
JITED/NO_JITED load mask. Using these annotations, or probing the load of
a minimal callx program and skipping on -EOPNOTSUPP, would cover
s390x/riscv64 and the rest. Only the runtime probe would also cover x86
with FineIBT.

The later commit in this series, 922d9559e25a ("selftests/bpf: Add tests
for callx through pointers in read-only data"), does not fix this. It adds
test_verifier_callx_rodata with the same RUN_JITED() gate, so it has the
same problem.

> +
>  void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }

[ ... ]

> @@ -199,6 +208,7 @@ void test_verifier_bswap(void)                { RUN(verifier_bswap); }
>  void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
>  void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
>  void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
> +void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
>  void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
>  void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
>  void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35951148075
--===============5293372113419748155==--
