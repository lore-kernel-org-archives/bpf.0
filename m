Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A748B367;
	Tue, 21 Jul 2026 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629797; cv=none; b=EMQkvv0Gw6VKLjI3t+1KbzuhVwoNQjQ2Q/gahWdRLs0Gc0euzfzJA1aAVcQCZ6eg7CjfwrhrMWpklfxzzg14/LMFqqEb2DtjHwyHV4hmE8WqGvdXOYH3BQj4CsSlCF0i8bUNx3RWiqZR39iuROSMq3E9BatG5oNg+Bnu6DmvTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629797; c=relaxed/simple;
	bh=E46Ku0g4KTeoRVUSAwpNNvPb2XNcslaIGLvUtUrvW2g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IxoFy0LDdxjlaTs5lROarckUEGrhWXl3cycflx9s2nkrGza7XGWzoZm9a1gfWR5GjjfXMThwo86pzx045/T1MKrF2Rg2dYn62EmEc8rkC19XXR8NqrfBt2R1P5cWOB5QaV5DoLOghoGbuzuih5B2VdEzdU1btvWCEP89TiZtShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcIjo3dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcIjo3dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7852D1F000E9;
	Tue, 21 Jul 2026 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629793;
	bh=FS23wLGx+01cMEX4sQjWjcEceJ7qZtcq+/udc4j26UQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fcIjo3dPcqqKqBOzQ9PqXpI9VYIy3QjaFsUMHxENACqLPipIOhHtjORHdboo3l+dn
	 SciYNIS9c9akZzr7fbYP1ELCvJEn6GgC/brMPQb+G1bw4YSyv4CGNJNGO6ZfD7HLvK
	 I2LLQSk1iGqneNDNXRlZqDrujkKLVh6U0nccufYzOPt5pn7PY5PCUcraJ3+prRdvp6
	 jNgfdtHrSwtu8zWgvA5aWzH5/iWiA/olfSRlLiSujpL52dZfDD9O3MXn65I1u7sMR9
	 3jJvk74l0eCIPGhluu9L+/jQs5eWlD9I6h7NHvBsDphVfgRZuKvZiWdJ5YhAtwDb29
	 adU5orI2NSilw==
Content-Type: multipart/mixed; boundary="===============3154772494840640172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b076593c985497a5f903439b864d1e8f1cd107f1561d04a22b77c6fafb3b4c13@mail.kernel.org>
In-Reply-To: <81c5f138e510622fcf908b99bfc7000b872e0966.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
References: <81c5f138e510622fcf908b99bfc7000b872e0966.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH 2/2] selftests/bpf: Cover stack frame number after scalar plus fp
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 10:29:53 +0000 (UTC)

--===============3154772494840640172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index be97f6887f0e..0483ae340726 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -11,7 +11,6 @@
>  #include "verifier_arena_globals2.skel.h"
>  #include "verifier_array_access.skel.h"
>  #include "verifier_async_cb_context.skel.h"
> -#include "verifier_basic_stack.skel.h"
>  #include "verifier_bitfield_write.skel.h"
>  #include "verifier_bounds.skel.h"
>  #include "verifier_bounds_deduction.skel.h"
> @@ -165,7 +164,6 @@ void test_verifier_arena(void)                { RUN(verifier_arena); }
>  void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
>  void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
>  void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
> -void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
>  void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
>  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
>  void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }

The verifier_basic_stack skeleton was already dispatched here through
RUN(verifier_basic_stack).  Adding the new subtest to
progs/verifier_basic_stack.c on its own would have exercised it under the
existing harness with no change to prog_tests.

This isn't a bug, but is the move to a standalone harness needed?  The new
subtest could be added to progs/verifier_basic_stack.c while leaving this
RUN(verifier_basic_stack) line in place.

There is also a behavioral difference worth noting.  run_tests_aux() in
verifier.c drops CAP_SYS_ADMIN for the whole run:

    /* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
    err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
> new file mode 100644
> index 000000000000..ff9382b47920
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +
> +#include "verifier_basic_stack.skel.h"
> +
> +void test_verifier_basic_stack(void)
> +{
> +	struct test_loader tester = {};
> +
> +	test_loader__run_subtests(&tester, "verifier_basic_stack",
> +				  verifier_basic_stack__elf_bytes);
> +	test_loader_fini(&tester);
> +}

The new harness does no capability manipulation, so the six pre-existing
basic_stack subtests now run their privileged pass with CAP_SYS_ADMIN
retained, where before they ran without it.

The verifier verdicts should be unchanged, since env->bpf_capable keys on
CAP_BPF and allow_ptr_leaks / allow_uninit_stack / bypass_spec key on
CAP_PERFMON, all of which the old harness kept and CAP_SYS_ADMIN implies.

Was the different privileged environment for the existing subtests
intentional, and is it worth a note in the changelog?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> index fb62e09f2114..634183fc8688 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> @@ -97,4 +97,45 @@ __naked void misaligned_read_from_stack(void)
>  "	::: __clobber_all);
>  }
>
> +SEC("socket")
> +__description("stack pointer arithmetic preserves frame number")
> +__failure __msg("R7 invalid mem access 'scalar'")
> +__naked void stack_ptr_arith_preserves_frameno(void)
> +{
> +	asm volatile ("					\
> +	r3 = 0;						\
> +	*(u64 *)(r10 - 8) = r3;			\
> +	r1 = %[map_hash_8b] ll;			\
> +	r2 = r10;					\
> +	r2 += -8;					\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 != 0 goto +2;				\
> +	r0 = 0;						\
> +	exit;						\
> +	r1 = r0;					\
> +	r2 = 0;						\
> +	r3 = 0;						\
> +	call stack_ptr_arith_preserves_frameno_subprog;	\
> +	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b)
> +	: __clobber_all);
> +}

The BPF program and expected message ("R7 invalid mem access 'scalar'")
match the reject path in do_check for a scalar-typed pointer dereference, so
the test itself looks correct.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29820318369
--===============3154772494840640172==--
