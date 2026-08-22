Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EB2D23BC
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359592; cv=none; b=ERi/Sqi94T/zPc1nBEQRYeDM/+Kl782rAAgKojv43G4ODAkmXorTXD17XVC4sTaLayoW566KJlTFyc/p9alqlmoyrFHpzmWGs8V1+uHJuqbXfUdNHESYpJb62UppQDKRDiAJlF3eIJu6DoJLE8vV3+eeWAX2YxUw1RJUwpsDyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359592; c=relaxed/simple;
	bh=UcVi7gO75iTDgxw1AaDUa0GHh0kivSbQUCSq3q3xe6U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r4v5b1yPMtohWf/XfCnY98HfPssQvKV6C6CSJGHg/gxruY7oDx1GrdPhBi5SABeP/ye5o2SsZkblk45oo88hzEqdeHIwWgsuWGhFdOM6itkTwgx6t3Mrv0ZhZaArijI8T0UFQfO2EgiMMdPqsjwUDpUXJlLj7NbfMPlehxXMeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkMdDgz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkMdDgz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463B51F00A3A;
	Sat, 22 Aug 2026 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359590;
	bh=WPgpYioqc7rD+1serMsi49R/qNaJrEknDykRSH9BtRw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NkMdDgz13AsQrbb9iRcNjkogj97XYUBfWXxAC/0XOIQzK/N8Rq35zuf36Ex8gHohs
	 D5RnF+hGyXbFLxVXINL/2ETSDQ/qhfaYhSHj6Tslk9Cp7kHZBKXmKMxYFa9WVD4xTL
	 n6lCj8PBNWWQeo95swnDUaabXxf2tNIhi7AovCR6PxFy4rSaJgcMzxoymZ/rIJdc+y
	 CJBq8DuOIokdNm9fOe11QEtrTP3et0EeP0L8STB8u0PBqFOYy8ZD0+2jn4+RATvQUM
	 QUc7XtVWHXJSftyJstExf+2V8xI3EbHAQvohZWdzvx5HVWNxBIymSRJuv4D2A3WOzr
	 XLNXJHBNTlGJw==
Content-Type: multipart/mixed; boundary="===============7204203892003572518=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <123c22a672a6f56a6f0150ca001a35c5dcfee73375ee94492ed9799cc249d870@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-14-memxor@gmail.com>
References: <20260821233516.3426127-14-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/14] selftests/bpf: Exercise arena arguments on every capable JIT
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:30 +0000 (UTC)

--===============7204203892003572518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
> index bf0d304e0e59c..8ee2bd4d66331 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c

[ ... ]

> @@ -174,6 +190,10 @@ int arena_arg_mixed(void *ctx)
>  SEC("syscall")
>  __arch_x86_64
>  __arch_arm64
> +__arch_riscv64
> +__arch_s390x
> +__arch_loongarch
> +__arch_powerpc64
>  __success __retval(0)
>  int arena_arg_unpopulated(void *ctx)
>  {
> @@ -187,7 +207,7 @@ int arena_arg_unpopulated(void *ctx)
>  	 * and returns VM_FAULT_SIGBUS. That condition is diagnosed by
>  	 * bpf_prog_test_run_syscall() as -EFAULT propagated from ctx_access_ok().
>  	 */
> -	val = (u64 *)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	val = (u64 __arena *)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>  	if (!val)
>  		return 3;
>
> @@ -195,9 +215,13 @@ int arena_arg_unpopulated(void *ctx)

Can arena_arg_unpopulated run safely on the newly added architectures?

This test deliberately passes an unpopulated arena address to the kernel
(stash = (u64)val + PAGE_SIZE, then bpf_kfunc_arena_arg_test((u64 *)stash)).
The kernel dereferences this address in bpf_testmod.c:

  old = *val__arena;
  *val__arena = old + 1;

For this to work without crashing, the page fault handler must call
bpf_arena_handle_page_fault(), which installs the per-arena scratch page.

Looking at the fault handler integration, bpf_arena_handle_page_fault() is
only wired up on x86-64 (arch/x86/mm/fault.c) and arm64
(arch/arm64/mm/fault.c). The other architectures use the __weak stub that
always returns false, meaning the fault is never recovered.

Without a scratch page, the fault on an unmapped vmalloc address becomes
an unrecoverable kernel oops. The new JIT capability
(bpf_jit_supports_arena_kfunc_args) only covers rebasing the argument at
the call site, not recovering from unpopulated-page faults.

Should this test remain restricted to x86-64 and arm64, or does the
recovery path need to be implemented on the new architectures first?


[ ... ]

> @@ -221,6 +249,10 @@ int arena_arg_bad_reg(void *ctx)
>  SEC("syscall")
>  __arch_x86_64
>  __arch_arm64
> +__arch_riscv64
> +__arch_s390x
> +__arch_loongarch
> +__arch_powerpc64
>  __failure __msg("arena pointer cannot be a stack argument")
>  int arena_arg_stack(void *ctx)
>  {
> @@ -228,6 +260,10 @@ int arena_arg_stack(void *ctx)
>  	return bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
>  }

Will arena_arg_stack produce the expected failure message on the new arches?

The test expects the verifier to reject the program with "arena pointer
cannot be a stack argument". However, this message is only reachable after
the verifier checks whether the JIT supports stack arguments.

bpf_kfunc_arena_stack_arg_test() takes 6 parameters, which exceeds
MAX_BPF_FUNC_REG_ARGS (5). In kernel/bpf/verifier.c, gen_kfunc_arg_proto()
checks this first:

  if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
      verbose(env, "JIT does not support kfunc %s() with %d args\n", ...);
      return -ENOTSUPP;
  }

Only after this gate does the per-argument loop inspect individual
arguments and emit "arena pointer cannot be a stack argument".

bpf_jit_supports_stack_args() returns true only on x86-64 and arm64. On
riscv64, s390, loongarch, and powerpc64, it returns false (the __weak stub
in kernel/bpf/core.c). So the program does fail to load on those arches,
but with "JIT does not support kfunc bpf_kfunc_arena_stack_arg_test() with
6 args" instead of the expected message.

test_loader's validate_msgs() will report this as a test failure since it
does not match the __msg annotation. Should this test stay limited to
x86-64 and arm64?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============7204203892003572518==--
