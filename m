Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315C471CF2;
	Thu, 24 Sep 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268953; cv=none; b=k1ULBR988AHKvdWJiWEHx2Y+P6Thumk8mNlrLNkPk7JWov6Lnr/SRils7M6opIjsMIgemTUBtWriYtDSrxr82iiZ8Dweux3EznKHwWMwk0ocrYb3kpU5QZCXmfwh6nv+cHfrDEMhOOSqENUN+5f7dSCSoGJ7jEeQWuW8lVZUqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268953; c=relaxed/simple;
	bh=kecBkykJubcMkJE5TewGMoRQqghUS3OdRRAfUilScvU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eQ0xUjvKpu9bQAH56M6xpiY4F0NQHRKyhjVJIrg3li6gsKMDr10tD6mKslq5fG5f3la3tM2PXdSDBr6ziWQuDd0KZ8Rch9xP/79lud/bNzKeig7WgS9tR0sxoB2tgdOOiAfz5ayn3yz4IvCXt4+c4Bdv8HTiny49dUjw3dEn9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWnveK6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWnveK6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE3E1F000FF;
	Thu, 24 Sep 2026 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268951;
	bh=joNSgZEXLB69O2UAxqlDk0/+b+L362VWJ9CU4JUJCEg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XWnveK6vGWb/VHoJ/GZcGgQJn17JCIpUZTJ7hJd4Ok2EnmUAJaZbPQaKxn+5nyLk+
	 jlOzExW2LaT9pz1WCF2L5kSE5mVhq9j+VzOgoH/wz3Ltvgv8L9fywTH7sPRKsQg+ao
	 +umqkRNnhlMVYc9T0ffJMEX2NBvI6beRTUsBGifquie/HLLVVTKRadiDEdK7/k1e9E
	 Mn1hVwvKVPI8brom3dJ25CU1+6lXHH4VSh3ZwwwX1bczVe7/Pl4JDCCyOb/Mq1Dzgh
	 UkQ58ISys0g5cNn9L7WSrwvhHoz4luYmuzHBLog8CeBTftgD6oUCGSXXXB/+QVhimd
	 +JNhG9JCt4rrg==
Content-Type: multipart/mixed; boundary="===============5293050500466644801=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaa76b3ec5eb32105dfcc066b46c985e71d70839d58fbf5d8a258c9fa317fdb1@mail.kernel.org>
In-Reply-To: <20260924160354.531101-3-puranjay@kernel.org>
References: <20260924160354.531101-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 16:55:49 +0000 (UTC)

--===============5293050500466644801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> index 1ad5d03d07ad..42061e70e1a3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
> index 73bc2b835f3f..9a3eee526cc9 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c

[ ... ]

> @@ -213,6 +198,64 @@ int xchg(const void *ctx)
>  	return 0;
>  }
>
> +__u64 __arena_global fetch_src_r0_value = 0x110;
> +__u64 __arena_global fetch_src_r0_result = 0;
> +__u64 __arena_global fetch_dst_r0_value = 0x110;
> +__u64 __arena_global fetch_dst_r0_result = 0;
> +__u64 __arena_global fetch_dst_r0_readback = 0;
> +
> +/*
> + * A fetching OR with the operand in r0, and one with the arena pointer in r0.
> + * The x86 JIT needs RAX for its CMPXCHG loop and substitutes BPF_REG_AX for
> + * whichever of the two is r0, so both have to keep working. Hand-written
> + * because clang picks its own registers and will not reliably emit either.
> + */
> +SEC("raw_tp/sys_enter")
> +int fetch_r0(const void *ctx)
> +{
> +	if (pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	asm volatile (
> +	"r1 = %[fetch_src_r0_value] ll;"
> +	"r1 = addr_space_cast(r1, 0x0, 0x1);"

[ ... ]

> @@ -221,15 +264,20 @@ int uaf(const void *ctx)
>  {
>  	if (pid != (bpf_get_current_pid_tgid() >> 32))
>  		return 0;
> -#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
> -    !defined(__TARGET_ARCH_x86)
> +/*
> + * arm64 stays excluded as it has been since this test was added: its JIT only
> + * accepts arena RMW atomics when LSE is present, which is a run-time property.
> + * The rest of the file shares that dependency without a guard, so on a non-LSE
> + * arm64 the whole skeleton already fails to load.
> + */
> +#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64)
>  	__u32 __arena *page32;
>  	__u64 __arena *page64;
>  	void __arena *page;
>
>  	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>  	bpf_arena_free_pages(&arena, page, 1);
> -	uaf_recovery_fails = 24;
> +	uaf_recovery_fails = 26;

[ ... ]

> +
> +	/*
> +	 * The x86 JIT needs RAX for the CMPXCHG loop it lowers a fetching
> +	 * AND/OR/XOR into, and substitutes BPF_REG_AX for r0 when r0 is either
> +	 * operand. Only then does the fault fixup have to name that register,
> +	 * so spell both forms out: clang picks its own and never produces them.
> +	 */
> +	asm volatile (
> +	"r0 = %[page];"
> +	"r0 = addr_space_cast(r0, 0x0, 0x1);"
> +	"r1 = 1;"
> +	".8byte %[fetch_dst_r0];"
> +	: : [page]"r"(page64),
> +	    __imm_insn(fetch_dst_r0,
> +		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0))
> +	: "r0", "r1", "memory");
> +	uaf_recovery_fails -= 1;
> +
> +	asm volatile (
> +	"r1 = %[page];"
> +	"r1 = addr_space_cast(r1, 0x0, 0x1);"
> +	"r0 = 1;"
> +	".8byte %[fetch_src_r0];"
> +	: : [page]"r"(page64),
> +	    __imm_insn(fetch_src_r0,
> +		       BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_1, BPF_REG_0, 0))
> +	: "r0", "r1", "memory");
> +	uaf_recovery_fails -= 1;
>  #endif

Would this build with clang 18 or earlier?  Both new asm blocks in uaf()
use the textual addr_space_cast syntax, but uaf() is only guarded by
ENABLE_ATOMICS_TESTS and !__TARGET_ARCH_arm64.  It does not check for
__BPF_FEATURE_ADDR_SPACE_CAST.

Every other use of textual addr_space_cast in this file is under that
guard: fetch_r0() above at the new code, and load_acquire/store_release
elsewhere.  The addr_space_cast asm syntax and __BPF_FEATURE_ADDR_SPACE_CAST
both arrived in LLVM 19, so with clang 18 the integrated assembler would
reject the unknown mnemonic and arena_atomics.bpf.o would fail to build.

Before this patch uaf() was plain C and was compiled out on x86, so the
asm never reached older clang there.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36026297900
--===============5293050500466644801==--
