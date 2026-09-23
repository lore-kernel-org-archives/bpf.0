Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E73876BE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205811; cv=none; b=f4qfEkvd0ieO2d5kEBGEUr3CJBJW6vn89kxKdMmcaL9lMtLSUWw+OQZlGkS4If9tzzCbiIGaB+yUtM44o+r1BlIqKI+Va04mLdUHKmcJ/etI1ansla15Tf8ZJe6291exrVGUdkN7emlohpzXqCKVhdlYEk2G+9IXKuPFhPV7Akk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205811; c=relaxed/simple;
	bh=mLspR3E7bkVNGMzlNKmSZsG+TNiKFIInfBpD5HOKcGE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LzhnCKwOnR6xAmQG4uGloxUuEfGW8BTBDgACLAOkyFFtFX+6Kf3wPBivgOqei9jh8nj+hT7TQnlEAwN9iYXYUZ5OM5SAo62yznayyNbxDqFZ9hR5JyMc0BAuUHdw/74VS4QkxNTvLMb4C1DdcSGTEh0dpCrTcKkq7+bYML+c/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbdmgFug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbdmgFug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48161F000FF;
	Wed, 23 Sep 2026 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205810;
	bh=2NS2j3ADybIY/BErzYw3VrDO+itoDUnTnWY9s7cdxPY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NbdmgFugRY6HfF71VSDu900+MHoRp3EDWFAl9RCVUA3P03Z+ZwZI5ki35pKs70TL2
	 COskNPNYvyQqZQpLIySdygHQgqnkLrRQl/Ync0b4egytpnXD8ZMF5YN9P0ddyK8fRp
	 wTl1JnGbUn3j5Vn1n+X3Y/K0MSJsfhZ3tlTBNG2U71VDRS4881D3nnen1GkNWyh/Sk
	 8wIoWAshB5XANQkFBZZbPNzxbR8W1mz+SGxjzGzGNMqWupChF4N5GwMlYfd7SeIwVa
	 oVjhQ3i6zygeRb6IqD37tfcLxQMpa8S7b2sYd92atYg7eZlo7DfW0Vl1h1Og6glxpN
	 8+YJpr0kbvgBg==
Content-Type: multipart/mixed; boundary="===============2926117444529474610=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fba497a61959c4f4205f8084c94df1543d4c0e5153aa8bacd9ed2eef13115340@mail.kernel.org>
In-Reply-To: <20260923223554.562379-9-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Add tests for widened loops
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:23:28 +0000 (UTC)

--===============2926117444529474610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 4f1e1c1cd5ab3..5bed8f9587772 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -65,6 +65,7 @@
>  #include "verifier_live_stack.skel.h"
>  #include "verifier_liveness_exp.skel.h"
>  #include "verifier_load_acquire.skel.h"
> +#include "verifier_loop_widen.skel.h"
>  #include "verifier_loops1.skel.h"
>  #include "verifier_lwt.skel.h"
>  #include "verifier_map_in_map.skel.h"
> @@ -234,6 +235,7 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
>  void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
>  void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
>  void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
> +void test_verifier_loop_widen(void)           { RUN(verifier_loop_widen); }
>  void test_verifier_loops1(void)               { RUN(verifier_loops1); }
>  void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
>  void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }

Does this registration need architecture filtering? Several of the
__success subtests in verifier_loop_widen.c appear to require JIT
exception support for the loop widening path to work.

Looking at the series, commit 3a779857709c5 ("bpf: Add may_goto to loops
that are not walked to the end") shows that widening at a loop head happens
only when loop_head_guard() returns true. In bpf_is_state_visited(), when
cannot_throw() returns a reason string, the code does:

    if (!loop_head_guard(env, insn_idx, widen_from, cur)) {
        loop_head = false;
        widen_from = NULL;
    }

And in cannot_throw() (kernel/bpf/verifier.c):

    if (!env->prog->jit_requested || !bpf_jit_supports_exceptions())
        return "JIT does not support exceptions";

Only x86 (with CONFIG_UNWINDER_ORC), arm64, s390 and powerpc64 implement
bpf_jit_supports_exceptions(). On riscv64 and loongarch, the __weak default
returns false.

When widening is not available, the verifier walks every loop iteration.
Tests like stride4_ne_250k, stride4_down_250k, stride1_lt_1m, and
nested_stride4 each need well over 1M processed instructions (stride4_ne_250k
alone is 250000 trips x 5 insns), so they fail with "BPF program is too
large" even though they are annotated __success.

Similarly, spin_until_flag and spin_until_flag_ja are not widened on those
platforms, so their infinite loops are rejected instead of getting a
may_goto guard.

tools/testing/selftests/bpf/DENYLIST.riscv64 already has an entry for
the exceptions test:

    exceptions                              # JIT does not support exceptions

But there's no corresponding entry for verifier_loop_widen. Other tests
that depend on this capability use __arch_x86_64, __arch_arm64, __arch_s390x
tags (like progs/verifier_may_goto_1.c does), or __load_if_JITed().

Should verifier_loop_widen either be added to DENYLIST.riscv64 and similar
deny lists, or should the architecture-dependent tests in
progs/verifier_loop_widen.c use __arch_* or __load_if_JITed() annotations
to skip on platforms without exception support?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_widen.c b/tools/testing/selftests/bpf/progs/verifier_loop_widen.c
> new file mode 100644
> index 0000000000000..4bdfc198bfaa8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_loop_widen.c

[ ... ]

> +/* same loop, 250000 trips, too many to walk every one of them */
> +SEC("socket")
> +__success
> +__naked void stride4_ne_250k(void)

[ ... ]

> +/* 8 byte stride, 32-bit counter */
> +SEC("socket")
> +__success
> +__naked void stride8_ne_w_125k(void)

[ ... ]

> +/* counts down by 4 to zero */
> +SEC("socket")
> +__success
> +__naked void stride4_down_250k(void)

[ ... ]

> +/* step of 1 and '<', no alignment to make use of */
> +SEC("socket")
> +__success
> +__naked void stride1_lt_1m(void)

[ ... ]

> +/* two loops, one in the other */
> +SEC("socket")
> +__success
> +__naked void nested_stride4(void)

[ ... ]

> +/*
> + * Nothing in the loop changes what it tests. may_goto that the verifier
> + * adds to the back-edge ends the program: 0 is returned instead of 2.
> + */
> +SEC("socket")
> +__success __retval(0)
> +__naked void spin_until_flag(void)

[ ... ]

> +/* same with the back-edge that is not a conditional jump */
> +SEC("socket")
> +__success __retval(0)
> +__naked void spin_until_flag_ja(void)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============2926117444529474610==--
