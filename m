Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C33905F4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206629; cv=none; b=YZRAUFuX7nOSNqYrIFK6DkBrkG/yi8ECpYTJWAhhbTRVXr/FCYTmCriYiYnZAaPR58atmQ+0nt1DKwoGaqjv4rIMyazpZWygSkDD+aBMJCdADtmkMWgdFGnmuamp1f4Y87wfzAOh/zxIOWGKnLheV3K8fjiDrEyqrtPMzfOPTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206629; c=relaxed/simple;
	bh=kE5HN6IEtUDyR0NYi1ujgz85skb5wAv5kmZAU5Qdr6I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P8UzaTs4gzrTchvodGDCH8Tk2inAj3w9Bj26wbciz2wpyRCfNBSbvl/8mDMc/uP9Ua5lJFy2+uSo9pGjfNoCaCY3/Xa0tAlUoYT/pjOJ1kPqdGdaKR3NaZpuAZ7PrBx3mfEYEM7TM5p4mS46jH+uC2lHUTDo0upqNUM/51iXUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVwu1i2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVwu1i2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E081F000FF;
	Wed, 23 Sep 2026 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206627;
	bh=N8hSfk6Wl2b9hDgHap0AFCiHOE+WoW++h15s8vo66bc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EVwu1i2QXt6uDkeXcSXAlwIXg1KAFQaOQcfIlwtCmQSNe+QI3KCVU5c9npM4DQOi3
	 8B297My7PNDuTZgeHwrytAlhMYYa8UugA4EkhawHfj1kcpPoOLi4ceDR9blYL2LSoj
	 YDkjIzBFwR60aYTB2F8i02GzTjfH6OrkbCa6DwJooQoAq3TX57xrd/Q5BM0M3IsTjW
	 RVEBYugLJLiDSJwMd9zRuQFx4fHfZ+PFg2YXnrCT0iECRBeXXPPHg252NBNFFGI5SF
	 filzdlVChs0dP2xyPAruCqpPJ3gH6WVM8sarDIUIu9hGvkSPDJYb8y7x0jUBoqQvlI
	 4r/9fVGrwGcEQ==
Content-Type: multipart/mixed; boundary="===============5014498001170898123=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18bd41964fbba19f88700b86cb724513f56e55764ed20cf4986f7f7073355b35@mail.kernel.org>
In-Reply-To: <20260923223554.562379-8-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Adjust tests to widened loops
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:05 +0000 (UTC)

--===============5014498001170898123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index 902a70d5afeb6..2dc37090d7a4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
> index 3c3bb03e8217a..700eadf5d430a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
> @@ -98,8 +98,8 @@ l0_%=:	r1 = r0;					\
>
>  SEC("socket")
>  __description("conditional loop")
> -__failure __msg("infinite loop detected")
> -__msg_unpriv("back-edge")
> +__success
> +__failure_unpriv __msg_unpriv("back-edge")
>  __naked void conditional_loop(void)
>  {
>  	asm volatile ("					\

Can this test pass on arches where the JIT doesn't support exceptions?
Adding the may_goto guard depends on bpf_jit_supports_exceptions()
returning true in the verifier's cannot_throw() check. When that check
fails, the loop isn't widened, and the verifier rejects the program with
"infinite loop detected" or "BPF program is too large" like before the
series.

Looking at bpf_jit_supports_exceptions() in kernel/bpf/verifier.c:

	if (!env->prog->jit_requested || !bpf_jit_supports_exceptions())
		return "JIT does not support exceptions";

Arches where bpf_jit_supports_exceptions() is false include riscv64
(which has an official config.riscv64, and DENYLIST.riscv64 already lists
"exceptions # JIT does not support exceptions"), loongarch, ppc32, and x86
without CONFIG_UNWINDER_ORC. Kernels with the JIT disabled are also
affected.

This applies to the other tests updated in this commit as well:
 - verifier_movsx: MOV32SX, S8, var_off u32_max
 - verifier_search_pruning: short_loop1
 - verif_scale_loop3
 - test_verifier: "calls: conditional call 6"

None of these use __load_if_JITed(), __arch_x86_64, __arch_arm64,
__arch_s390x gating, F_NEEDS_JIT_ENABLED, or DENYLIST.riscv64 entries,
so they will fail instead of being skipped on those arches.

Per the selftests guide, a test that fails when a capability is missing,
instead of skipping, is a bug.

Should these tests be gated on JIT plus exception support? For example,
__load_if_JITed() and arch masks in the test_loader programs,
F_NEEDS_JIT_ENABLED for test_verifier, and a skip for verif_scale_loop3,
or adding them to DENYLIST.riscv64?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> index 195b27a51224f..280ccee336635 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
> index f4459561bf393..88358586e7964 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -152,22 +152,21 @@ __naked int bpf_store_release(void)
>  SEC("?raw_tp")
>  __success __log_level(2)
>  /*
> - * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
> - * and "parent state regs=" lines. "R0=6" parts are here to help anchor
> - * expected log messages to the one specific mark_chain_precision operation.
> - *
> - * This is quite fragile: if verifier checkpointing heuristic changes, this
> - * might need adjusting.
> + * The state is widened when it comes back to the loop head, so the exit test
> + * is decided only on the first trip around the loop. "R0=2" parts are here to
> + * help anchor expected log messages to that mark_chain_precision operation.
>   */
> -__msg("2: (07) r0 += 1                       ; R0=6")
> +__msg("2: (07) r0 += 1                       ; R0=2")
>  __msg("3: (35) if r0 >= 0xa goto pc+1")
> -__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
> +__msg("mark_precise: frame0: last_idx 3 first_idx 1 subseq_idx -1")
>  __msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
>  __msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
> -__msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
> -__msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
> -__msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
> -__msg("3: R0=6")
> +__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=P0")
> +__msg("mark_precise: frame0: last_idx 0 first_idx 0 subseq_idx 1")
> +__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 0")
> +__msg("3: R0=2")
> +__msg("loop head 1 widened, pass 1")
> +__msg("1: safe")
>  __naked int state_loop_first_last_equal(void)
>  {
>  	asm volatile (
> @@ -175,11 +174,7 @@ __naked int state_loop_first_last_equal(void)
>  	"l0_%=:"
>  		"r0 += 1;"
>  		"r0 += 1;"
> -		/* every few iterations we'll have a checkpoint here with
> -		 * first_idx == last_idx, potentially confusing precision
> -		 * backtracking logic
> -		 */
> -		"if r0 >= 10 goto l1_%=;"	/* checkpoint + mark_precise */
> +		"if r0 >= 10 goto l1_%=;"	/* mark_precise */
>  		"goto l0_%=;"
>  	"l1_%=:"
>  		"exit;"

Does this test still cover the original bug it was written to test?
state_loop_first_last_equal was the regression test for precision
backtracking when a checkpoint has first_idx == last_idx and jump history.
The old expectations checked the "before 4: (05) goto pc-4" / "before 3:
(35) if r0 >= 0xa" history between "last_idx 3 first_idx 3" and "parent
state regs=" lines.

As the commit message says, loop widening means that checkpoint no longer
happens. The test now only checks one straight-line backtrack from the
first trip. The name no longer describes what it tests, and nothing else
covers the first_idx == last_idx case.

The backtracking code in bpf_mark_chain_precision/get_prev_insn_idx is
unchanged and still runs through the every-iteration walk in these cases:

	loops that hold references or locks
	callbacks
	fallback walk after a widened walk fails
	JITs without exception support

So a regression of the original bug would no longer be caught on
JIT-capable arches.

Should there be a variant that forces the old walk, for example by holding
a reference across the loop or using a program type where 0 is not a valid
return value, and keep the old expectations for that variant?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> index f40e57251e941..7098b44faafc5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 8b94b87135bcf..c7c501bfc660a 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============5014498001170898123==--
