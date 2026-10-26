Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986812;
	b=0rXyNnt4NRF+EVUYbruD799BTyQJ+L7sCHSIAiY3Zf3NS8AXr/cuyvFey6vWjDMx8gR2
	 6xwouXovrRlG32fyBAJk4QtmTOihRHxSLiJRqhNdAt/xXEZ8RALqWB4VL8QhN+N52YsFv
	 U8eK0RNalyAqoO1JIwi6VeSl30ZbFiUindOsHgzmnf0MnDJBZEO5RTlJepEqJtQMiYv6K
	 YDdtZvdbckp+aOM5sPXFzJgCEzZmlE44AlvwZBNHOHdOjszpx5vC3pOuMKn4qPkMzwznP
	 t6Z/eIwxdN75quxF5eobuN2Aj58ekeQJ7imTtKr3fh7AESpIADpP4wYhBuVyO6KjG5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986812;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gr5bd6ASZLpKx3VE50upVp87ktwHSO9E0Gux1U4rgGA=;
	b=ak117ngLK+jKSoH88bOqw5rEIbpnphxNO2jds32vPfq+KiWZ3NxeJCrarDQbKeWc1lKb
	 DUA+V9xQFqInHe/beuS42SiDNxZeM8nqIqhgje4tKMrKQ9uRuT9IoGCLURoV5t6HRzwqa
	 VYuaAQXOI1pDQHrGuQ08bQH9p0DsMhRMEQbDnOS7Sz6EXePh7qdEVH0xG9GhYIk40vmRJ
	 nNmmWDF+6H+nDM84wsZDjHPDKba5By07iYFg3jGy9BMT/05gmETOgeqySJb+YlHiPokwb
	 K9K8k1wyZvP87zKg51kbqTxYPubCMvuMTnckDsjCllhC4DpuRFez9zUUNZPmEuDQyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DrDvl/KS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE1606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrDvl/KS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B1B1F01825;
	Mon, 26 Oct 2026 03:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986811;
	bh=gr5bd6ASZLpKx3VE50upVp87ktwHSO9E0Gux1U4rgGA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DrDvl/KSD22q6XVcfxLR+3f+yHMcQ7/IsAFaj/jgs/XQ2+vOw/7sFmhgx6LOYqACU
	 DYjjIy/AiCHek/Am9bwwwj8VfUQN1GwCCsF0ysjyWNWwdz4Kz9ft1dOv146dXT8um+
	 ZryDrF1V8/S0Zpiui6+dGVfebELpu8UbpzPS/F59HQ6e0lYtvxWjD7RTt/8nMXYYFv
	 Puy/yna/T22za/Q3iuaieZKC6EKxEb9QUFypUvzUFGGiUa0Njr36iVk7x/JBIGuvX/
	 XrIUylnSrE0iBANnuhhc6TdqXSzMJcnMRQTwaobZTp7CweM97GXBUB4mucxBJrKV8R
	 VeVjt6LQxziJw==
Content-Type: multipart/mixed; boundary="===============1829468745535374825=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2b2536f8f0678071cb788723e28f742532055e086986db3bf5d3185a71a6c199@mail.kernel.org>
In-Reply-To: <20261026025943.404450-74-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-74-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 73/81] selftests/bpf: Adjust tests of loops
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:31 +0000 (UTC)

--===============1829468745535374825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests of loops

TL;DR: Test issues only: the hard-coded insn number in loop_detection may fail
on cpuv4/gcc builds, and the movsx and scev test changes may no longer catch
the regressions they were meant to.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index a76bce7278e7..a48b48fb2e51 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

[ ... ]

> @@ -94,7 +94,7 @@ static int loop_detection_cb(__u32 idx, struct num_context *ctx)
>  }
>  
>  SEC("?raw_tp")
> -__failure __msg("infinite loop detected")
> +__failure __msg("loop at insn 12 never exits")
>  int loop_detection(void *unused)
>  {
>  	struct num_context loop_ctx = { .i = 0 };

Will this expectation hold for the test_progs-cpuv4 flavor?  loop_detection()
is compiled from C, and the message hard-codes the index of the loop in the
callback, which depends on how many insns the compiler emits for the main
prog:

    struct num_context loop_ctx = { .i = 0 };

With the default -mcpu=v3, the zero initialization of this 16-byte struct is
'r1 = 0; *(u64 *)(r10 - 8) = r1; *(u64 *)(r10 - 16) = r1', which gives the
12 insns the test expects.

With -mcpu=v4 (which test_progs-cpuv4 builds with), and with bpf-gcc, the
compiler emits BPF_ST instead, so the two zero stores become
'*(u64 *)(r10 - 8) = 0; *(u64 *)(r10 - 16) = 0'.  The main prog is then one
insn shorter, the callback loop starts at insn 11, and the __msg() does not
match.

The tree has run into this before.  Commit 898f55f50a00 ("selftests/bpf:
relax expected log messages to allow emitting BPF_ST") says:

  Expected messages in these tests hard-code instruction numbers for BPF
  programs compiled from C. These instruction numbers change when BPF_ST is
  allowed because single BPF_ST instruction replaces a pair of
  BPF_MOV/BPF_STX instructions

Commit 9786d424a36b ("selftests/bpf: Fix chained_global_func_calls_success()
for cpu v4") fixed a test_progs-cpuv4 failure caused by hard-coded insn
counts in a C prog.

The old expectation, "infinite loop detected", had no insn number.  Would
matching with __msg("loop at insn {{[0-9]+}} never exits") keep the test
independent of codegen?  The other new 'loop at insn N' expectations in this
series are in naked asm progs, where the index is fixed.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> index 195b27a51224..280ccee33663 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> @@ -226,7 +226,7 @@ l0_%=:							\
>  
>  SEC("socket")
>  __description("MOV32SX, S8, var_off u32_max")
> -__failure __msg("infinite loop detected")
> +__success
>  __failure_unpriv __msg_unpriv("back-edge from insn 2 to 0")
>  __naked void mov64sx_s32_varoff_1(void)
>  {

Does this change leave the privileged run of this test unable to catch the
bug it was added for?

The test came in with a62293c33b05 ("selftests/bpf: Add a few tests to
cover") as the reproducer for 380d5f89a481 ("bpf: Add missed var_off setting
in set_sext32_default_val()").  Before that fix, var_off was left stale after
'w7 = (s8)w3', so the verifier took w7 to be in [0, 127] and decided that
'if w7 >= 0x2533823b goto l0_%=' was never taken.  It walked only the
fall-through and the program loaded.  Once var_off was fixed, both branches
were possible and the back-edge led to "infinite loop detected".  So
'__failure __msg("infinite loop detected")' was what told the fixed verifier
from the broken one.

With this series, a loop that has an exit is accepted and gets may_goto, so
the fixed verifier loads the program.  A verifier that has lost the
'reg->var_off = tnum_subreg(tnum_unknown)' line in set_sext32_default_val()
also loads it, because it never reaches the back-edge.  Both outcomes match
__success.

The unprivileged expectation does not help here, since the back-edge is
rejected before any range is tracked.  No other test in verifier_movsx.c
covers this case:  mov64sx_s32_varoff_2 and _3 mask the input to 0xf, and
mov32sx_s8_range gets a fully unknown input, so a stale var_off is harmless
there.  No later commit in the series changes this test.

Could the test check something that only a correct verifier produces?  For
example, __log_level(2) together with a __msg() for the R7 state after
'w7 = (s8)w3' (var_off=(0x0; 0xffffffff), smin32=-128), or for the loop at
insn 0 being verified or getting its may_goto.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> index b30802c9e9e3..f4ea854d3212 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
> @@ -2005,18 +2256,15 @@ __msg_next("  r1=(+ r1 2) / (linear (+ r1 2) 2)")
[ ... ]
>  __msg("16: (a5) if r0 < 0x8 goto pc-6")
> -__msg("exiting loop 11")
> -__msg("17: (95) exit")
>  /* second iteration */
>  __msg("loop header at 11, clamping r0")
>  __msg("loop header at 11, clamping r1")
>  /* iteration convergence */
> -__msg("from 16 to 11: safe")
>  __not_msg("{{^}}11:")
> -/* map lookup error path */
> -__msg("from 7 to 17: safe")
> +/* loop exit */
> +__msg("exiting loop 11")
> +__msg("17: (95) exit")

Can the "iteration convergence" check in correlated_regs() still fail?

Before this change the test asserted convergence with
__msg("from 16 to 11: safe"), and the __not_msg("{{^}}11:") span ran from
there to "from 7 to 17: safe".  The new version drops the positive
convergence line, so the __not_msg() now sits between
"loop header at 11, clamping r1" and "exiting loop 11".

match_negative_msgs() in test_loader.c only searches for a negative pattern
between the end of the previous positive match and the start of the next
one.  Both neighbouring messages are logged while insn 16
('if r0 < 0x8 goto pc-6') is processed.

check_cond_jmp_op() pushes the taken branch, so flow_drain() calls
bpf_flow_deliver(11) first, and:

    bpf_flow_loop_enter()
      maybe_clamp_scev_regs()
        bpf_clamp_scev_regs()

prints the 'clamping' lines.  flow_merge() then prints either
'from 16 to 11: within' or, if the state does not converge,
'from 16 to 11: widened', and makes the state at 11 pending.

Still inside the same do_check_block(), the fall-through goes to:

    bpf_flow_deliver(17)
      flow_arrive()
        bpf_flow_loop_leave()
          loop_stack_pop()

which prints 'exiting loop 11'.  A pending state at 11 is only verified
again after do_check_block() returns and bpf_flow_next() picks it, so any
'11: (bf) r2 = r6' lines from a second pass come after 'exiting loop 11' and
fall outside the span.  The only line that can appear inside the span is
'from 16 to 11: within|widened', and it does not start with '11:'.

Nothing else in the test checks convergence (there is no 'processed N insns'
line), so the test passes even when the first back edge does not converge.

Would __msg("from 16 to 11: within") bring the convergence check back?
Other tests in this series use that kind of message, for example
__msg("from 18 to 9: within") in verifier_subprog_precision.c.  Moving the
__not_msg() between "exiting loop 11" and "17: (95) exit" would also work,
since flow_compute_order() finishes the loop before insn 17.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============1829468745535374825==--
