Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939924;
	b=zoTVo9TfrqNxDgtKSs7PKcEqORgmlIOgqJFfTB041ls1NMYBRvlf4V/SSB9JA9F7I05C
	 d/Xl2Eu+gzKX7Oc9Vh7HQ42TGnUhneA6S8Apy1gL9ykS6ZqQ4IBJ2tEx5PyJ5O4tf5riY
	 YFC2i1/tkHt4UmgzpMsgfdSyfga/G/CDkPP59CE3IWoX4xzdgkYesLWB0gb/XgeZTDLcE
	 xT6F9fyDh/AICoFUq74TOWgP2+TrCc3g7fX4PdrMzhb86x78Nqe/9OFa2QmvN+4bFnW0l
	 EWLHMDqgClsAPCtzr3s6/NBCvXS5ljxO9A0OIgMQxrt6N683IDbEiFDH3NkSrIhQReQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939924;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2P371uHku5zr2btjIJRQjwz5qfuarW98Ofz5nyQX6C8=;
	b=axx/lQ7ckU2G3Wr5kM8KpFY88mm1I9NI0WFX14lXNMfHwary0OpSJREjp6qoVGEskyQz
	 dzYHbXL9iF7WTHu/ytYTmPtvrV5qqEkCkNtjyJaK4es2iATvDWUEU+AEHidbfx+yEBMKX
	 zKgv7MuSpNxRLQ5DzQU/7Qezlf+hKYspsJZF/JuH1X9/q6NxiX/5iGradWFGQC36jK8vf
	 CS6ysbkg5+J2s0OMIdCvA8lgwEtN6BPBTOfv+rIehblRIHJgYeWIsLHTxZonVwyv/FxGZ
	 Bd6A1SgIXkNyx0AvWZx/RUgvbDEzZUDlp2TIQMr1XM62zaCUdnu/q10Z96ItGqZLBHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCEsYrpU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68874606A32E
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCEsYrpU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012D31F0089F;
	Fri,  6 Nov 2026 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939924;
	bh=2P371uHku5zr2btjIJRQjwz5qfuarW98Ofz5nyQX6C8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SCEsYrpUbVUZzyatZxrShXMmsVmOncyz7Jrc9bQNdnMivumIpUGFfLSE1t0ebpD7F
	 rL2olYsi82XtDrUA1HnRfbaNKudNkIEdcx0DoGcQx1fdhVeIkJvpi7tNuzKDaBDM7F
	 GPVFDe7cv/IRXUjrMNdfGDBgb+q+dQ2SbzVBbMNgJuZgm1WGmAiPz2vr42AfL+u4IZ
	 7IrVv69X0sq191eH7u5sPMqsAeR7fl5eU61VQZuYELITjsmp10Gra9p6ljnsUgwtu3
	 YoPEJY06KHSyQMMAeBa7ppWTOX6j+w6ejNhFZDpMTcnvyvRmNGo50OuOIPPQyVSC8p
	 6GyTgIVJ9KJTw==
Content-Type: multipart/mixed; boundary="===============6337975675787324275=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9f42ce54721ab339f2f763f96b5f82bef209cd6f7141785265a2d44f7d06c89e@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-40-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-40-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 39/45] selftests/bpf: Adjust tests to log lines that are gone
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:43 +0000 (UTC)

--===============6337975675787324275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to log lines that are gone

TL;DR:
- Commit message says progs are kept, but a spill_fill test now spills an
  unknown scalar, possibly changing pruning
- Message says BPF_F_TEST_STATE_FREQ is removed, but three precise.c tests
  keep it
- Stale test comments (nits)

> selftests/bpf: Adjust tests to log lines that are gone
>
> Without this patch 114 subtests of test_progs and 4 tests of test_verifier
> fail. Their progs get the old verdict, but the tests match lines of the
> verifier log that the kernel does not print any more. Keep the progs. Match
> the line of the new log that shows the same fact.
>
> [ ... ]
>
> The first row is verifier_precision.c, _subprog_precision.c, _spill_fill.c,
> _scalar_ids.c, stack_arg_precision.c and verifier/precise.c. The second row
> is verifier_bounds_step.c, _search_pruning.c, _live_stack.c: the tests of
> regsafe(), stacksafe() and range_within(). The target of a jump is verified
> before the fall-through. Thus the tests in which the first of two states
> must cover the second one swap their branches.
>
> Three verdicts change. short_loop1 was "too large". Now one state at the
> loop head covers all iterations, and it loads. 2 unprivileged progs of
> verifier_value_ptr_arith.c load: r1 = [0, 3] and r1 = [0, 7] are joined in
> front of 'r1 += r0', and the insn gets one limit for its mask. 8 progs are
> rejected as before, with a different message. BPF_F_TEST_STATE_FREQ has no
> effect. Remove it from the tests that change.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The message says "Keep the progs" and that the only prog changes are the
branch swaps.  In verifier_spill_fill.c,
old_imprecise_scalar32_vs_cur_stack_misc() also changes what it spills:

-	/* conjure 32-bit scalar spill at fp-8 */
-	"r0 = 42;"
-	"*(u32*)(r10 - 8) = r0;"
 [ ... ]
+	/* conjure 32-bit scalar spill at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u32*)(r10 - 8) = r0;"

It used to spill the constant 42 and now spills an unknown scalar.  Without
precision tracking, regsafe() compares the fake register built from the slot
by range, and stacksafe() goes through scalar_reg_for_stack(), so a spilled
known constant no longer covers STACK_MISC.  Is that pruning change
intended?  Also, old_precise_scalar_vs_cur_stack_misc() gets an extra
"r0 = 0;" before the exit.

Could the commit message mention these changes instead of describing the
progs as kept?

The message also says "BPF_F_TEST_STATE_FREQ has no effect. Remove it from
the tests that change."  In verifier/precise.c three changed tests still
carry the flag:

> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
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

The same applies to "precise: ST zero to stack insn is supported" and
"precise: STX insn causing spi > allocated_stack", which change
VERBOSE_ACCEPT to ACCEPT but keep .flags = BPF_F_TEST_STATE_FREQ.  Nothing
breaks, since the flag is still accepted.  Should .flags be dropped from
these three tests, or should the sentence in the commit message be limited
to the __flag() annotations used by test_loader?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -518,15 +518,6 @@ __msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0")
>   */
>  __msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2=0 R10=fp0 fp-16=0")
>  __msg("11: (0f) r1 += r2")
> -__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
> -__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
 [ ... ]
>  __naked void partial_stack_load_preserves_zeros(void)

The nine mark_precise checks of partial_stack_load_preserves_zeros() are
removed, but the comments above the remaining __msg() lines are unchanged:

	/* fp-8 is spilled IMPRECISE value zero (represented by a zero value fake reg) */
	/* validate that assigning R2 from STACK_SPILL with zero value  doesn't mark register
	 * precise immediately; if necessary, it will be marked precise later
	 */
	/* similarly, when R2 is assigned from spilled register, it is initially
	 * imprecise, but will be marked precise later once it is used in precise context
	 */

Do these comments still make sense?  They describe IMPRECISE spills and
"marked precise later", and the checks for that are gone.  The matching
comments in stack_load_preserves_const_precision() were updated ("make sure
fp-8 is IMPRECISE fake register spill" became "make sure fp-8 is fake
register spill"), so this test looks like it was missed.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

[ ... ]

> @@ -830,24 +709,22 @@ __naked void two_old_ids_one_cur_id(void)
>  	"r9 = r0;"
>  	"r0 = 0;"
>  	/* Maybe make r{6,7} IDs identical */
> -	"if r6 > r7 goto l0_%=;"
> -	"goto l1_%=;"
> -"l0_%=:"
> +	"if r6 <= r7 goto l1_%=;"
>  	"r6 = r7;"
>  "l1_%=:"
[ ... ]
>  	"r2 = r10;"
>  	"r2 += r6;"
>  	"r2 += r7;"
>  	/*
>  	 * keep r8 and r9 live, otherwise r6->id and r7->id
> -	 * will become singular and reset to zero before if r6 > r7
> +	 * will become singular and reset to zero before if r6 <= r7
>  	 */
>  	"r9 += r8;"
>  	"exit;"

Is "before if r6 <= r7" still the right place in this comment?  The old
text was correct when BPF_F_TEST_STATE_FREQ put a checkpoint at the jump and
bpf_split_cur_state() called bpf_clear_singular_ids() on the current state
before the jump ran.

With the flag gone, the only caller of bpf_clear_singular_ids() is
flow_arrive(), reached through bpf_flow_deliver() when a state arrives at
the start of a basic block:

  bpf_flow_deliver()
    flow_arrive()
      bpf_clear_singular_ids()

In this prog the first such points after the jump are 'r6 = r7' and l1, so
the ids would be reset after the jump, not before 'if r6 <= r7'.  The
reasoning in the comment is still right, only the location is stale.
Something like "... will become singular and be reset to zero when the
states arrive after the jump" would match the new behavior.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============6337975675787324275==--
