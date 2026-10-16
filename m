Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D73BE146
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148334; cv=none; b=pShRSuJUZm7mdY4mjpu5tHJl72NifpVgOIE/mhY9jJ3XFoHlVGrSCWfd1+wD+aSVfcPFiW8EcdWJmlVXc/Ff9au0TZ+tcxwtlVu59Ggy7UHcFpeB303BOUMhkBeUgKPnNeL6d+puenzO+ghVFk74hlbXaLaoYiBHmHIGtDPVL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148334; c=relaxed/simple;
	bh=rn7A/4Y6PhqVZnKNXqe5tvNMZi+QkmGuItivXny1pkw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SdctbVgFgA+R2vK1MFSRMhIH+oHHvv7UOPHUZBXQHnWkisII6HXGj/kBxd6IbDmgR+v9EILTIOusOe5xCb2MUUjaalE/l8U9pgYN+KYEo1Vys/ugr74oOU9rIWzhv43M+Y6+JSmYquugEFVZmyz7aMeaZDlB7IblNLD1q63bB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg3GY9St; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg3GY9St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397801F000C4;
	Fri, 16 Oct 2026 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792148333;
	bh=LCCzW2c4GUXryFhKDUMCKF4xOXM0foIsKzL39XmALmM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Dg3GY9Std9K7zjkS+Poy8iYerMFIU2LQ8vHDvwfdCBBHgJwJ/ffSzyHesJK9zYl2/
	 PjbNMzZKjEcWGtwjY74DDDv7QXjNBJxMg7uAbxXYwGWwVNdhxoNPn0xle5jXfKPjGu
	 5jyJFu3BjZmisa6J5ZgmYkIDdXO+wsDO+bAsfxnVv4+77uKFyj30bGfJMQna5DKkfq
	 HNKXz/CWO9kdtT7AJIAvIuRlplFzOg/eou2AUTyFAnC7KbS5rYeXftw7PPFsMhVTuJ
	 oQ7tgT6eZRdJ+xCJJKYqXlN1knVXU5WDMQu0C2FZ4xluptP5F/RF3KdqPxk8SG9iYI
	 FNE7cEOPiSmAQ==
Content-Type: multipart/mixed; boundary="===============3245694980310386037=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38e4699fafb53396f8df8aefc589d88c948757b6514e6caae14a84152463b448@mail.kernel.org>
In-Reply-To: <20261016101822.632891-3-daniel@iogearbox.net>
References: <20261016101822.632891-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Follow-up to JIT instruction tests
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 10:58:52 +0000 (UTC)

--===============3245694980310386037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Follow-up to JIT instruction tests

TL;DR:
- Selftests: acq_rel and helper_calls now fail instead of skipping on kernels
  or JITs lacking load-acquire or kfunc support; intended?
- Nit: test_calls() could use prog_run()

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> index dabf8a4abdfe..dabefdb8a353 100644
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c

[ ... ]

> @@ -2215,10 +2429,6 @@ static void test_acq_rel(void)
>  	char desc[64];
>  	int b, k, s, j, fd;
>
> -	if (!acq_rel_ok()) {
> -		test__skip();
> -		return;
> -	}
>  	for (b = 0; b < ARRAY_SIZE(pat_regs); b++) {
>  		int rb = pat_regs[b];

A subsystem guideline for selftests flags tests that fail on "capability
absent" errno values instead of skipping.  With acq_rel_ok() and its skip
removed, every load-acquire/store-release program now goes through
prog_load(), which does ASSERT_GE(fd, 0, desc).

So the acq_rel subtest fails instead of skipping when the kernel cannot
load the instruction for reasons outside the JIT under test.  Two cases:

On a 32-bit kernel the verifier rejects every BPF_DW variant, whatever the
JIT does:

    kernel/bpf/verifier.c:check_atomic() {
        if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
            verbose(env, "64-bit load-acquires are only supported on 64-bit arches\n");
            return -EOPNOTSUPP;
        }
    }

With CONFIG_BPF_JIT_ALWAYS_ON, a JIT that does not implement BPF_LOAD_ACQ
and BPF_STORE_REL fails the load with -ENOTSUPP.  Only the arm64,
loongarch, powerpc64, riscv64, s390 and x86-64 JITs handle BPF_LOAD_ACQ;
sparc64, mips and the 32-bit JITs do not.

Before this patch both cases were skips, now they are hard failures of
jit_insns/acq_rel.

The commit message says this is deliberate ("a JIT without the instruction
fails like for any other one instead of skipping"), and movsx, bswap and the
sdiv/smod tests have no probe either.  Is failing here the intended
behavior, with architectures lacking the instruction expected to use the
DENYLIST mechanism?

> @@ -2340,6 +2550,502 @@ static void test_max_jmp(void)

[ ... ]

> +static void test_calls(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	__u64 expected = 1 + 2 + 3 + 4 + 5;
> +	struct bpf_insn insns[64];
> +	struct pat_ctx ctx;

[ ... ]

> +	opts.ctx_in = &ctx;
> +	opts.ctx_size_in = sizeof(ctx);

[ ... ]

> +			fd = load_prog(insns, n, desc);
> +			if (fd < 0)
> +				return;
> +			memset(&ctx, 0, sizeof(ctx));
> +			if (ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), desc))
> +				ASSERT_EQ(ctx.res, expected, desc);
> +			close(fd);

This isn't a bug, but could test_calls() use prog_run(fd, 0, 0, expected,
desc), as test_helper_calls() does, and drop the local opts and ctx setup?
The open-coded run-and-check sequence here looks like what prog_run() already
does for the other pat_ctx based programs in the file.

[ ... ]

> +static void test_helper_calls(void)
> +{

[ ... ]

> +		EMIT(&p, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
> +				      kfunc_id));

[ ... ]

> +		snprintf(desc, sizeof(desc), "helper calls off=%d", offs[i]);
> +		fd = off_prog_load(&p, desc, false);
> +		if (fd < 0)
> +			goto out;

A subsystem guideline for selftests flags tests that fail on "capability
absent" errno values instead of skipping.  test_helper_calls() puts a kfunc
call (bpf_dynptr_size) into every program it loads, and off_prog_load()
checks the load with ASSERT_GE(fd, 0, desc).

When the running kernel cannot JIT kfunc calls, the verifier rejects the
program in add_kfunc_call() with -ENOTSUPP:

    if (!env->prog->jit_requested) {
        verbose(env, "JIT is required for calling kernel function\n");
        return -ENOTSUPP;
    }
    if (!bpf_jit_supports_kfunc_call()) {
        verbose(env, "JIT does not support calling kernel function\n");
        return -ENOTSUPP;
    }

This happens when the JIT is disabled, and on JITs that do not implement
bpf_jit_supports_kfunc_call().  In this tree only arm64, loongarch,
parisc64, powerpc, riscv64, s390, x86-32 and x86-64 implement it, so arm32,
mips and sparc64 do not.

On those kernels the helper_calls subtest fails, although the property it
checks (helper and kfunc calls preserving r6-r9 and passing five arguments)
does not depend on the missing capability.  The helper call part could
still run there.

Could the kfunc part be skipped, or the subtest skip with a message when the
load fails with -ENOTSUPP?

The commit message states a policy of failing on a missing JIT capability
("a JIT without the instruction fails like for any other one instead of
skipping"), and the same file already fails on JITs without arena support
(RUN_TESTS(jit_insns_arena) has no __arch filter), so failing and denylisting
per architecture may be the intended convention for this test.  x86-64,
arm64, s390 and riscv64 are not affected.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38887971910
--===============3245694980310386037==--
