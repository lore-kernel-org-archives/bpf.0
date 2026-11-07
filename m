Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025194;
	b=HL0tuEeFAGWJOAF7Q1z4+5PQddZ8+WsOCsgPuT4ymFg1P5wQPnSYNaXojCndxt5ay+Ga
	 UeWX6RlEFtLdGZyL4l4pkj2MZKgZM/HoI3llR90XtbWvo1y8V/zw5+yb6n0uZaKNvM1nd
	 f5M4smhGPSzCmrU8N+HvnGYR2Yn/1uHeE8LKZVK3qd9lXZSMiVa3VmKiT3TL0FqhD+OFb
	 jBxODcz4/o8x2Rg31230pB4yXxZaS9cP8kEoaUHpq900cmBR6pqKuXp+Jza4kiyZObAWo
	 AdJGB7asEmtT3VjQ5qYVH0Lg0H70fizeqG9L1065MTSeaiWbN9C69GrWwhCs1021rAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025194;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=O7tK931/H3kHjHjSXTzxTVJ7L6tBBGWtzfLbWRzgyV8=;
	b=DGflwZSQ9ShLB1W3CTZ43i0xnsEU02BzqbRbfJIai21fFCKDSERwjjyTaEk0109TyPEQ
	 Zfcl82xZQqP6Hp81gjw5Vlu5BXEENXFO/fnhv6mh08u0eJYqv7ZY8ULLnzutlchli6A+F
	 C0h/q5KGllYTrOcDauME9PaFy4LlGTWuQ5YvTq+8oqQ7boyP/4u9MU94/AfJ4hdWm4EpN
	 c2uW7QFKHo6f3wPV42avTGQ9Gwl2JoQCJ8wSrxTxFAzfa9vxkokvzXh1L+r7D8A2e6nXH
	 R4aXYIXufoyzI7fJ1fn4JHbW+S9hR34ul8DHBE774jHrdGxJbiya56IUutWKoZJ1+HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRHFZlW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D8606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRHFZlW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411A91F0089F;
	Sat,  7 Nov 2026 04:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025194;
	bh=O7tK931/H3kHjHjSXTzxTVJ7L6tBBGWtzfLbWRzgyV8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dRHFZlW1eHKXwxStSwvDrjsQxut/xf/W4VVOIub9Tt3ZbgWIvliOzh/WYiwt2egm0
	 AI+EuRBlfXMwq9rupSmjCJIy6mvSqz8UaRSnm/uz2HBgbCK2CxycZQKf6Epfx37d+a
	 D4Rw1scbBsH4SuLgXaCcQJ4xvGCQCXRZt4dkuaorITEqsByt4S/Jp4oOoX6lN0/Gaq
	 gScHsPdTE2giKEMoJEvmJWkwKSMITFhWLxIJaPmy34NEhd2K3YyRllrKKvsnNpNm9U
	 MTTEbflbTP9A8JCyJEZ7YsUmJXuUkWk/QLag0Rim/kS8sXJ4lJXh1URh5roLmOu8B6
	 BVQL/DWsGcR0Q==
Content-Type: multipart/mixed; boundary="===============6932069632915020581=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7e790e2a864b69682ae6f22186931f94b09fcae0abc354b03eb518a3b845ef0d@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-39-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-39-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 38/46] selftests/bpf: Adjust tests to log lines that are gone
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:54 +0000 (UTC)

--===============6932069632915020581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to log lines that are gone

TL;DR:
- Test weakening: several selftests lose log checks without the promised
  replacement, so some only check the verdict
- Changelog omits five changed files and still says BPF_F_TEST_STATE_FREQ was
  removed from changed tests
- Possible duplicate verifier/precise.c test

>     selftests/bpf: Adjust tests to log lines that are gone
>
>     Without this patch 114 subtests of test_progs and 4 tests of test_verifier
>     fail. Their progs get the old verdict, but the tests match lines of the
>     verifier log that the kernel does not print any more. Keep the progs. Match
>     the line of the new log that shows the same fact.
>
>       [P] "bpf: Remove precision tracking"
>       [V] "bpf: Remove is_state_visited(), bpf_compute_scc() and iter.depth"
>       [F] "bpf: Verify programs as a fixpoint over the control flow graph"
>
>       the tests matched        they match now
>       -----------------------  ------------------------------------------------
>       [P] "mark_precise: ..",  The value of the scalar where the prog uses it:
>       462 lines                "R2=-8".
>       [V] "N: safe", 23 lines  "from M to N: within". If no state covers the
>                                other one: "joined", and the join.
>       [F] "id=1" of a scalar,  No id: the verifier clears an id that only one
>       12 lines                 live register has.
>
>     The first row is verifier_precision.c, _subprog_precision.c, _spill_fill.c,
>     _scalar_ids.c, stack_arg_precision.c and verifier/precise.c. The second row
>     is verifier_bounds_step.c, _search_pruning.c, _live_stack.c: the tests of
>     regsafe(), stacksafe() and range_within(). The target of a jump is verified
>     before the fall-through. Thus the tests in which the first of two states
>     must cover the second one swap their branches.
>
>     Three verdicts change. short_loop1 was "too large". Now one state at the
>     loop head covers all iterations, and it loads. 2 unprivileged progs of
>     verifier_value_ptr_arith.c load: r1 = [0, 3] and r1 = [0, 7] are joined in
>     front of 'r1 += r0', and the insn gets one limit for its mask. 8 progs are
>     rejected as before, with a different message. BPF_F_TEST_STATE_FREQ has no
>     effect. Remove it from the tests that change.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The changelog does not seem to match the diff in two places.

First, the list of files for the "mark_precise" row:

> The first row is verifier_precision.c, _subprog_precision.c, _spill_fill.c,
> _scalar_ids.c, stack_arg_precision.c and verifier/precise.c.

This leaves out five files whose mark_precise checks the patch also
deletes: aggregate_ret_func.c (2 tests), aggregate_ret_kfunc.c,
test_global_func15.c, verifier_array_access.c (3 tests) and
verifier_var_off.c (3 tests).

Second, the changelog says:

> Match the line of the new log that shows the same fact.

That is done in stack_arg_precision.c and verifier_subprog_precision.c.  In
aggregate_ret_func.c, aggregate_ret_kfunc.c, test_global_func15.c,
verifier_array_access.c and all four changed tests of verifier/precise.c,
the log expectations (and __log_level(2) / VERBOSE_ACCEPT) are just deleted
and nothing replaces them.  The "precise: cross frame pruning" errstr even
ended with the value line "5: R0=-1 R4=0", and that line was dropped too.

In aggregate_ret_static_precise() the remaining verdict does not depend on
the fact the test was written for.  The callee sets "r2 = 4", but the
caller does:

    r6 = r2; r6 &= 7; r1 = r10; r1 += -8; r1 += r6;

followed by a 1-byte store.  That load succeeds privileged for any readable
R2, so the test no longer shows that the second half of the aggregate
return is known in the caller.  Would a line such as the R6=4 state show it?

The comments next to these tests also still describe removed machinery:
"/* ptr += scalar marks r6 (hence R2) precise */" in aggregate_ret_func.c
and aggregate_ret_kfunc.c, "its value is made precise below" in
aggregate_ret_func.c, and the "checkpoint", "precision tracking for R0" and
"is_state_equal() logic" comments in test_global_func15.c.  This patch
rewrote the matching comments in stack_arg_precision.c and
verifier_subprog_precision.c.

Could the changelog list every file and say which tests now check only the
verdict, or could those tests get the replacement log line the message
promises?

> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
> index a9242103dc47..de9d35ed8a4b 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c

[ ... ]

> @@ -95,24 +76,8 @@
>  	},
>  	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
>  	.fixup_map_array_48b = { 1 },
> -	.result = VERBOSE_ACCEPT,
> +	.result = ACCEPT,
>  	.flags = BPF_F_TEST_STATE_FREQ,
> -	.errstr =
> -	"26: (85) call bpf_probe_read_kernel#113\

[ ... ]

The changelog says "BPF_F_TEST_STATE_FREQ has no effect. Remove it from the
tests that change."  Three of the four verifier/precise.c tests changed here
keep the flag: "precise: test 2" (above), "precise: ST zero to stack insn
is supported" and "precise: STX insn causing spi > allocated_stack".

Also, "precise: test 1" and "precise: test 2" used to differ only in their
errstr.  Now both have the same .insns, .prog_type, .fixup_map_array_48b
and .result = ACCEPT, and differ only by a flag that does nothing.  Does
test_verifier now run the same case twice under two names?

Should the flag be dropped from the changed tests as the message says, and
"precise: test 2" merged with or removed in favor of "precise: test 1", or
should the commit message be reworded?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============6932069632915020581==--
