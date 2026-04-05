Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF63164D8
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408947; cv=none; b=DhVok5AASLko7VMWRhH7CKPmDp1tJimDTlisuOSemx6sgLgv2EK782TXeu2cyAW56PembBUbXgPopr/q+aI0jgxKkpxIX8gxoWvkvBBwI4JMZjhYqbF8fcMkbBzjBSqL4jc+YwzDXu6DLHE/qatzMq/muoIAJtE1wSl6MbUhQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408947; c=relaxed/simple;
	bh=3oeH+xBIvUDB+3f28XJKJBZ6fQCeLQB0VBcm6GCdbiU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KLjzwH1l+oa49DCfVq3r3Hj5XY0I2PDPE1g3nBDdr52/z/fEA9hmkqLPdX2g93Gic8xRKMw5CN5G2B4HIqodxPvUj1XDqypotsyXMmLjJHM/Ou7KFAEMjZFHTiQ45k0sm4+dtkfl5XFbIc4jkiGoRTGU2l3YKTBK9b3iBBliSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TDbQvWrt; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDbQvWrt"
Message-ID: <2251a12b-2c2c-4222-935f-0629f44ecc8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775408943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYO4GzmZb7R1A++gV2+STnRC9rzuc7iaxfU4Fqf9RGM=;
	b=TDbQvWrtNUyr8pq7doKWWEFMhJPUWi91EnA/aX2JeqKJwUuiq5W5P9vFR6DXlTLI071JAG
	DJPwyZVhwU9fEtllqcgMmcv96Z/mhulME/Pkq6nQ50S1V9t5yRhdGl1Wz3PplWQIG8nGZX
	s3/5ldLdT7FhSSwR1zp6wFDube4USfo=
Date: Sun, 5 Apr 2026 10:08:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 00/11] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260405165300.826241-1-yonghong.song@linux.dev>
In-Reply-To: <20260405165300.826241-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 9:53 AM, Yonghong Song wrote:
> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> parameters. For function calls with more than 5 parameters,
> developers can use always inlining or pass a struct pointer
> after packing more parameters in that struct. But there is
> no workaround for kfunc if more than 5 parameters is needed.
>
> This patch set lifts the 5-argument limit by introducing stack-based
> argument passing for BPF functions and kfunc's, coordinated with
> compiler support in LLVM [1]. The compiler emits loads/stores through
> a new bpf register r12 (BPF_REG_STACK_ARG_BASE) to pass arguments beyond
> the 5th, keeping the stack arg area separate from the r10-based program
> stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
> (12), which is sufficient for the vast majority of use cases.
>
> The x86_64 JIT translates r12-relative accesses to RBP-relative
> native instructions. Each function's stack allocation is extended
> by 'max_outgoing' bytes to hold the outgoing arg area below the
> program stack. This makes implementation easier as the r10 can be
> reused for stack argument access. At BPF-to-BPF call sites, outgoing
> args are pushed onto the native stack before CALL. The incoming
> parameters can directly get the value from pushed native stack from
> caller. For kfunc calls, args are marshaled per the x86_64 C calling
> convention (arg 6 in R9, args 7+ on the native stack).
>
> Global subprogs with >5 args are not yet supported. Only x86_64
> is supported for now.
>
> For the rest of patches, patches 1-6 added verifier support of
> stack arguments for bpf-to-bpf functions and kfunc's. Patch 7
> enables x86_64 for stack arguments. Patch 8 implemented JIT for
> x86_64. Patches 9-11 are some selftests.
>
>    [1] https://github.com/llvm/llvm-project/pull/189060
>
> Changelogs:
>    v1 -> v2:
>      - v1: https://lore.kernel.org/bpf/20260402012727.3916819-1-yonghong.song@linux.dev/
>      - Add stack_arg_safe() to do pruning for stack arguments.
>      - Fix an issue with KF_ARG_PTR_TO_MEM_SIZE. Since a faked register is
>        used, added verification log to indicate the start and end of such
>        faked register usage.
>      - For x86_64 JIT, copying incoming parameter values directly from caller's stack.
>      - Add test cases with stack arguments e.g. mem, mem+size, dynptr, iter, etc.
>
> Yonghong Song (11):
>    bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
>    bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
>    bpf: Support stack arguments for bpf functions
>    bpf: Refactor process_iter_arg() to have proper argument index
>    bpf: Support stack arguments for kfunc calls
>    bpf: Reject stack arguments in non-JITed programs
>    bpf: Enable stack argument support for x86_64
>    bpf,x86: Implement JIT support for stack arguments
>    selftests/bpf: Add tests for BPF function stack arguments
>    selftests/bpf: Add negative test for greater-than-8-byte kfunc stack
>      argument
>    selftests/bpf: Add verifier tests for stack argument validation
>
>   arch/x86/net/bpf_jit_comp.c                   | 140 +++++-
>   include/linux/bpf.h                           |   6 +
>   include/linux/bpf_verifier.h                  |  31 +-
>   include/linux/filter.h                        |   4 +-
>   kernel/bpf/btf.c                              |  21 +-
>   kernel/bpf/core.c                             |  12 +-
>   kernel/bpf/verifier.c                         | 474 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/stack_arg.c      | 132 +++++
>   .../selftests/bpf/prog_tests/stack_arg_fail.c |  24 +
>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>   tools/testing/selftests/bpf/progs/stack_arg.c | 212 ++++++++
>   .../selftests/bpf/progs/stack_arg_fail.c      |  32 ++
>   .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 ++++++
>   .../selftests/bpf/progs/verifier_stack_arg.c  | 302 +++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 +++
>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  26 +
>   16 files changed, 1594 insertions(+), 60 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
>   create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
>   create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c
>   create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.c
>
Please ignore this patch set. Just discovered that there is a selftest failure
and a couple of 'UTF-8' issues. I will fix these issues and send the next revision
shortly.

