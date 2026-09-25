Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183350C28F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379324; cv=none; b=oTbOX2dHD1NQ1hNkMspOWslZ4Vo473Z3c3Z4Kkif9Kmoc4HG1Utzv9WF+iMtW0RlRmmCG/YgozKq4OMHMuNwqOsXN5f+RkB+CZpRDjb99iijwqBEWjp7OmPCw8EOJ4y7EubKXJlARgrYFtNHG+XeGtl74ipKO7hgN9sEIMdtOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379324; c=relaxed/simple;
	bh=glMEEQXpLGtbvOjQnpeDxk16nWPwJ4i1tn6tDmpQ/tg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=flMJ77JhIiGFxR7TKLRuhDXfwPOPgLAQs0u5Utt3QRP6TbMXVaVrbKZsrChjqFpDUcyyd9vt7ceecospxuLQJE7MWMRgQjwxeLFrdZDSs6UJ1AYcgbz1/C7Og/cUVQenCZ8pMabWxydYH/RBWDWW9+Y4r+DtzqbpeheUf/rqD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLItZ9zV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLItZ9zV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEF61F00893;
	Fri, 25 Sep 2026 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379322;
	bh=2PvbrD/FWD2pOeCZCdF9gKRDV7bFUVIUeget6Z7JNK8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bLItZ9zVg7xQ+NBQmq7oMaJDuBNSvKK4yJmcF3KU0xhuPIvPVAWRYTSPSJSuJrM8z
	 qgM5IvyEvbugS89O6wjLzZGIa+yQDalIKtZl7cSQGN5brKz805gQFe9hGQ/GqH0kxe
	 TxJLyhwExcrZsnW8TrMG7bVGGkp4NZdNBhjLTcotaxFYJlYxko7AWAglxABojoNW7T
	 +QP9jVaXm0bb/3y74rfHmkHxVcsh+SpnoZ9uhX7fp8BXMG8TQ/658tLEFtbX1l6jeQ
	 sPJ4Kve93BWIfG4u2fOR6jS0SMv1RkIHxCq2IFxuZRTCIpQJdKTxejaUQSL44XuddD
	 6CB7itBPiHXGA==
Content-Type: multipart/mixed; boundary="===============9141674494346044867=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5d45f57b4e98331accb76b468ce8f9902099071e8355a923244f00d8ed29a886@mail.kernel.org>
In-Reply-To: <20260925224631.1490488-2-andrii@kernel.org>
References: <20260925224631.1490488-2-andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add linked_externs test for externs in allocated sections
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:35:22 +0000 (UTC)

--===============9141674494346044867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index 3d92cdca62ed..2e22bb901bf3 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel
> @@ -23,7 +23,7 @@ BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
>  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>
>  LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
> -		linked_vars.skel.h linked_maps.skel.h 			\
> +		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
>  		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
>  		test_usdt.skel.h tracing_multi.skel.h			\
>  		tracing_multi_module.skel.h				\
> @@ -46,6 +46,7 @@ test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.
>  linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
>  linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
>  linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
> +linked_arena.skel.h-deps := linked_arena1.bpf.o linked_arena2.bpf.o
>  # In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
>  # but that's created as a side-effect of the skel.h generation.
>  test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> new file mode 100644
> index 000000000000..29358c82dc35
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "linked_arena.skel.h"
> +
> +static void test_skel(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct linked_arena *skel;
> +	int err;
> +
> +	skel = linked_arena__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	ASSERT_EQ(skel->arena->a_val, 1, "a_val_init");
> +	ASSERT_EQ(skel->arena->b_val, 2, "b_val_init");

Will this break the test_progs-bpf_gcc build?

linked_arena1.c and linked_arena2.c declare their globals and externs with
a bare __arena:

    linked_arena1.c: long __arena a_val = 1;
    linked_arena1.c: extern long __arena b_val;
    linked_arena2.c: long __arena b_val = 2;
    linked_arena2.c: extern long __arena a_val;

bpf_arena_common.h only maps __arena to an address space when the compiler
supports it:

    #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
    #define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
    #define __arena_global __attribute__((address_space(1)))
    #else
    #define __arena __attribute__((btf_type_tag("arena")))
    #define __arena_global SEC(".addr_space.1")

bpf-gcc does not define __BPF_FEATURE_ADDR_SPACE_CAST. Clang versions
without address-space-cast support do not define it either. With those
compilers, a_val and b_val are emitted into .data instead of .addr_space.1.
The arena map then has no initial value (init_arena_map_data is never
reached), so bpftool's is_skel_data() is false for the arena map. The
generated linked_arena.skel.h therefore has no 'arena' data member, and
the variables show up under skel->data instead.

test_skel() above dereferences that member unconditionally, so every
test_progs flavour compiles all of prog_tests/*.c against that flavour's
own skeletons. test_progs-bpf_gcc is added whenever bpf-gcc is on PATH
(Makefile: BPF_GCC ?= $(shell command -v bpf-gcc;) / TEST_GEN_PROGS +=
test_progs-bpf_gcc), and .github/workflows/gcc-bpf.yml builds it in CI. So
the flavour's linked_externs.test.o fails to compile, and
DENYLIST.test_progs-bpf_gcc cannot mask a compile failure.

The existing arena selftests avoid this. arena_atomics.c uses
__arena_global, which falls back to SEC(".addr_space.1"). arena_list.c
uses an explicit guard with a skip flag:

    #ifdef __BPF_FEATURE_ADDR_SPACE_CAST
    long __arena arena_sum;
    int __arena test_val = 1;
    ...
    #else
    long arena_sum SEC(".addr_space.1");
    int test_val SEC(".addr_space.1");
    #endif

prog_tests/arena_list.c then calls test__skip() when skel->bss->skip is
set.

Should linked_arena1.c and linked_arena2.c follow the same pattern? That
would mean placing the definitions and externs in .addr_space.1
unconditionally (for example via __arena_global, or a guarded
SEC(".addr_space.1") fallback), and adding a skip flag that test_skel()
checks, because the program bodies still need address-space-cast support to
run correctly.

> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.sum1), &opts);
> +	ASSERT_OK(err, "sum1_run");
> +	ASSERT_EQ(opts.retval, 1 + 2, "sum1_retval");
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bump2), &opts);
> +	ASSERT_OK(err, "bump2_run");
> +	ASSERT_EQ(opts.retval, 11 + 22, "bump2_retval");
> +
> +	ASSERT_EQ(skel->arena->a_val, 11, "a_val");
> +	ASSERT_EQ(skel->arena->b_val, 22, "b_val");
> +
> +	linked_arena__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/linked_arena1.c b/tools/testing/selftests/bpf/progs/linked_arena1.c
> new file mode 100644
> index 000000000000..3e8788dec1d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_arena1.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1); /* number of pages */
> +} arena SEC(".maps");
> +
> +long __arena a_val = 1;
> +extern long __arena b_val; /* defined in linked_arena2.c */
> +
> +SEC("syscall")
> +int sum1(void *ctx)
> +{
> +	return a_val + b_val;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/linked_arena2.c b/tools/testing/selftests/bpf/progs/linked_arena2.c
> new file mode 100644
> index 000000000000..d0bcdf18a4b6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_arena2.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +long __arena b_val = 2;
> +extern long __arena a_val; /* defined in linked_arena1.c */
> +
> +SEC("syscall")
> +int bump2(void *ctx)
> +{
> +	a_val += 10;
> +	b_val += 20;
> +	return a_val + b_val;
> +}
> +
> +char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36199505247
--===============9141674494346044867==--
