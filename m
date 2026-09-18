Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B783F482C
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713345; cv=none; b=ZkpobOKIkK7PtmaGN5e8bZUZ4h9C6NIsBK7JlpCuEDtSfXy6vVtY+zdXwHM//qYW9tqvmEtYDd7Y+dU8AG2WrH2d4ZQ9W34eoVxvAqk27yC/DUP7hU06ywjOBd1eVVN/zM0zLomjJUEqESy4QlrT0oH8E4Xw7HpUSC2j9Vsyki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713345; c=relaxed/simple;
	bh=LifIYRJg8SSxNMar3683E01Bvoo0desfGz7GA+I4eK8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tVN7cSzpSjQ65ZymthCrIdeazSjYn8sqEwE0nU8Dx93b8WooRAv/eRi/ublwS1kcIk7gyvG3esbt1dxXHNghGZ2cHc3PzvDa1oo3pIuzWyZfW2ijmcOjjqgz4OifImmRZUnoWaXbRmAwGSV88/TtcHzaoqXsfgU4TNyZMcLLcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv6x8Lkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv6x8Lkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E3E1F000FF;
	Fri, 18 Sep 2026 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713339;
	bh=cBSqFD0Pab+ih1wa/dvHSroIZ4AW3aoNqJN6noe2mEw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hv6x8Lkzk8A0wK5mDEpyISEEE8F2zrPLeRLQLKy5DMGS0NnGyrSH4FiqKyWx0WTQg
	 byJDjXFOgRxn79Zz7E+pyFlMXCW6NMvEZVvT8AFxzaYoJVaHLNd117cl89YgAP+dSd
	 fzYBO64GdGV7+qA5gO6mTOmGVk4uQs/ajCwC+JhIxxd89NBwvuv0QRJ5ZkK+ZfYlW4
	 KD4t40O/IHvN027ss+SVhnM4PcN12AwyG8M8Gvwti6nR9S1YWLR54L2nRAN77Ey2nC
	 +H4CUGVMa/ODOXJfV/2vwRuxh6TF3/AiG2G2vaKvSOySTZBYvbc5DnZztn70NgErj6
	 vCq9iikxn23IA==
Content-Type: multipart/mixed; boundary="===============5325562805383109954=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c105060bb66e62f7f7b09c9b080dd909865eac0d0a39acee6ee91e123be79c5@mail.kernel.org>
In-Reply-To: <20260918052906.12226-9-memxor@gmail.com>
References: <20260918052906.12226-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Cover __uninit kfunc output argument slots
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 06:35:38 +0000 (UTC)

--===============5325562805383109954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index d1e50a952a13a..24a69807c74cb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -57,6 +57,7 @@
>  #include "verifier_jit_convergence.skel.h"
>  #include "verifier_kfunc_packet_access.skel.h"
>  #include "verifier_kfunc_uninit.skel.h"
> +#include "verifier_kfunc_uninit_multi.skel.h"
>  #include "verifier_ld_ind.skel.h"
>  #include "verifier_ldsx.skel.h"
>  #include "verifier_leak_ptr.skel.h"
> @@ -224,6 +225,7 @@ void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null)
>  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
>  void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
>  void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
> +void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
>  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
>  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
> new file mode 100644
> index 0000000000000..18ced0d0a3b2c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +/* Keep the kfunc BTF records used by the inline assembly. */
> +void __kfunc_btf_root(void)
> +{
> +	asm volatile ("" :
> +		: "r"(&bpf_kfunc_test_uninit_multi),
> +		  "r"(&bpf_kfunc_test_uninit_pair),
> +		  "r"(&bpf_kfunc_test_uninit_stack));
> +}
> +
> +SEC("tc")
> +__success __retval(42)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
> +__prepare_priv
> +__success_unpriv
> +__naked void multiple_outputs(void)
> +{

A subsystem pattern flags this as potentially concerning: the new prog
file progs/verifier_kfunc_uninit_multi.c (plus a new #include and a new
test_verifier_kfunc_uninit_multi() entry in prog_tests/verifier.c) is
added for the per-argument-slot variant of __uninit output tracking.

Looking at progs/verifier_kfunc_uninit.c in the same directory - added
two commits earlier in the same series (40e810febe863) - it already
covers __uninit kfunc output initialization and uses exactly the same
scaffolding: identical SPDX/copyright header, identical include set, an
identically shaped __kfunc_btf_root() stub, and the same
__flag(BPF_F_TEST_STATE_FREQ) + 'goto +0' poisoning idiom with the same
__caps_unpriv(CAP_BPF | CAP_NET_ADMIN) __prepare_priv __success_unpriv
tag block.

The four new cases (multiple_outputs, variable_size_preserves_other_output,
output_after_by_value_argument, output_passed_on_stack) could be appended
to verifier_kfunc_uninit.c as additional cases, avoiding the duplicated
boilerplate and the extra skeleton/registration.

The commit message states an explicit rationale: "Keep coverage for
per-slot output tracking separate from the immediate single-output
regression tests." Splitting also keeps the arch-gated cases
(__arch_x86_64/__arch_arm64 and the __BPF_FEATURE_STACK_ARGUMENT case)
out of the arch-neutral file, and the BPF selftest Makefile globs
progs/*.c so no build plumbing is needed.

Worth asking: is the split into a second file wanted, or should these be
additional cases in verifier_kfunc_uninit.c?

> +	asm volatile (
> +		"*(u64 *)(r10 - 16) = 0;"
> +		"*(u64 *)(r10 - 8) = 0;"
> +		"goto +0;"
> +		"r1 = r10;"
> +		"r1 += -16;"
> +		"r2 = r10;"
> +		"r2 += -8;"
> +		"r3 = 8;"
> +		"call %[bpf_kfunc_test_uninit_multi];"
> +		"r0 = *(u32 *)(r10 - 16);"
> +		"r1 = *(u32 *)(r10 - 8);"
> +		"if r1 != 0x2a2a2a2a goto 1f;"
> +		"r1 = *(u32 *)(r10 - 4);"
> +		"if r1 == 0x2a2a2a2a goto 2f;"
> +	"1:;"
> +		"r0 = 0;"
> +	"2:;"
> +		"exit;"
> +		: : __imm(bpf_kfunc_test_uninit_multi) : __clobber_all);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35311871659
--===============5325562805383109954==--
