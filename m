Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986815;
	b=Q8S2pJ0TIixbtO2ASC8oIlKHPmUepJtbLhEmzV56ndyFaHJJbAp3g3skWe9qeHDbXctP
	 x92aQUFSbKvdCvEmDbdAq3LogRfTLl6fRfF4xzyK0CS0U1psn98uQXCd78JP/HiPZ0LdK
	 SBFfurL52pCfxHYdkv/IlV6g8B8w428BtvTVBJfP83QWLM1/Rm8bcid2bmZU/XJ+X7XsO
	 v2TH9emo21CJ9qgJlaqS5eciLaF0UR90vBqDHhAf3G2WfaHmu7yWycYZv/fw8BN11VNEl
	 h5TQe9fwQ/aRPErHqI4JXPd2Ra/4T8eaNhXFkk6KzG48+uLaNhE95ceJGDjL4MnFeHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986815;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kSFl8h37gT5AbDgvQG6TYNei4P3Rzfpk+IJJWzclt78=;
	b=LdZ+gWpI6l4Z6wcxZESwQAPBlelFZKW4AAX6yPq/q++yMXiSAitcJVHfSuXJxRH4/REs
	 gDRCG44BlzpwnwlfNydj7tT+83gMueDJC3fWd1dEsS+R/3ksnb1jiHyz2hX+wQZipwy4i
	 vuv66NhfnUG1UhdrR5cabvnhoMY8fAiNa7EKcGdrIO1SMWNWudq5gVjAeGjROW71m6Uu0
	 l5BU3L2g/SZ1wmFOLQKmZ10U8Un+QjFXI5RGlfba1vS8FEr27dmug7PVjC/jeVJj6bfxt
	 7RfGoyoCq7922YVNMjK/Br331H0oanFJ/Sbl6uje59fjAvoDadjQx97mMPmAIQSqEow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1Bd7xjf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41544606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1Bd7xjf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E274A1F01825;
	Mon, 26 Oct 2026 03:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986815;
	bh=kSFl8h37gT5AbDgvQG6TYNei4P3Rzfpk+IJJWzclt78=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C1Bd7xjfjYlL9QoXidIr9xSAG0mFJwBOrnPCbHU9u47jRXpNG+auIYmFnGJ3kfXpH
	 Ng7f0swt/OXxtlAZ/PYbCmuhN8yWOcWZ8fOlRTW+zIwjqCleskvL1vSQnfbsW1z7ZV
	 jXY3kXVzsOY8lDtCIG6O2nYR42/bpzYPfVhqcrwVrqnMOu0uCQ4Hv9ZO9NdBOyDumu
	 LKL2PL4vf5BCDCC9h69G5ztP+vcIiDmwNFrX+soqHmv5b+yWqBBj4U5lYvpc6gNetL
	 BZtdWM7Jj30GFyF7d+2ap5zwih+7vwm4EguPytd3dzCbl9cSZtKEIgo17Kq7na72bn
	 kzHIre8oyWUDA==
Content-Type: multipart/mixed; boundary="===============8113903478147373790=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fe248f316797d71d68a81f9c55ff33b42f3882a438c3ec22bc114fca2a5748bb@mail.kernel.org>
In-Reply-To: <20261026025943.404450-72-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-72-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 71/81] selftests/bpf: Adjust tests of linked registers and spills
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:34 +0000 (UTC)

--===============8113903478147373790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests of linked registers and spills

TL;DR:
- Test issue: rewritten stacksafe() spill-vs-STACK_MISC selftests may be
  decided by r0, not stacksafe(), losing coverage
- Stale or wrong comments mentioning precision tracking

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> index f0077d951a25..2671323255cd 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> @@ -110,64 +110,49 @@ __naked int aggregate_ret_static_uninit_fail(void)
>  }
>
>  static __naked __noinline u128 static_agg_precise(void)
>  {
>  	asm volatile (
>  	"r0 = 0;"
>  	"r2 = 4;"	/* second half; its value is made precise below */
>  	"exit;"
>  	);
>  }
>
>  SEC("tc")
>  __load_if_JITed()
>  __success __retval(0)
> -__log_level(2)
> -__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
[ ... ]
> -__msg("mark_precise: frame1: regs=r2 stack= before 11: (b7) r2 = 4")
>  __naked int aggregate_ret_static_precise(void)
>  {
>  	asm volatile (
>  	"call %[static_agg_precise];"
>  	"r6 = r2;"		/* derived from the aggregate's second half */
>  	"r6 &= 7;"		/* keep it in [0, 7] to index the stack */
>  	"r1 = r10;"
>  	"r1 += -8;"
>  	"r1 += r6;"		/* ptr += scalar marks r6 (hence R2) precise */

The patch removes the __log_level(2) and all of the mark_precise:
expectations from aggregate_ret_static_precise(), but the comments in the
programs still describe the removed behavior.  Is "its value is made precise
below" still accurate?

Nothing marks a register precise any more, and nothing in the test checks it.
The test now only checks that the load succeeds and that the return value is
0.

The comment "ptr += scalar marks r6 (hence R2) precise" is repeated in
aggregate_ret_global_precise() further down in this file, and in
aggregate_ret_kfunc_precise() in aggregate_ret_kfunc.c:

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> index 0361a7b42c9b..102156175ba0 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> @@ -22,31 +22,24 @@ void __kfunc_btf_root(void)
[ ... ]
>  SEC("tc")
>  __arch_x86_64 __arch_arm64
>  __load_if_JITed()
>  __success __retval(0)
> -__log_level(2)
> -__msg("mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1")
[ ... ]
> -__msg("mark_precise: frame0: regs=r2 stack= before 2: (85) call bpf_kfunc_call_test_i128")
>  __naked int aggregate_ret_kfunc_precise(void)
>  {
>  	asm volatile (
>  	"r1 = 1;"
>  	"r2 = 2;"
>  	"call %[bpf_kfunc_call_test_i128];"
>  	"r6 = r2;"		/* second return half */
>  	"r6 &= 7;"		/* keep it in [0, 7] to index the stack */
>  	"r1 = r10;"
>  	"r1 += -8;"
>  	"r1 += r6;"		/* ptr += scalar marks r6 (hence R2) precise */

The same patch deletes the matching "force r0 to be precise" comments in
verifier_scalar_ids.c.  Should these three comments be reworded to say what
the tests check now, for example "ptr += scalar needs the range of r6 (from
R2)", or dropped?

The same question applies to the comment inside
global_func15_tricky_pruning():

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
> index 201cc000b3f4..497f09dc8876 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func15.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
> @@ -2,55 +2,50 @@
[ ... ]
>  SEC("cgroup_skb/ingress")
> -__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
>  __failure
> -/* check that fallthrough code path marks r0 as precise */
> -__msg("mark_precise: frame0: regs=r0 stack= before 2: (b7) r0 = 1")
> -/* check that branch code path marks r0 as precise */
> -__msg("mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7")
>  __msg("At program exit the register R0 has ")
>  __naked int global_func15_tricky_pruning(void)
>  {
>  	asm volatile (
>  		"call %[bpf_get_prandom_u32];"
>  		"if r0 s> 1000 goto 1f;"
>  		"r0 = 1;"
>  	"1:"
>  		"goto +0;" /* checkpoint */
>  		/* cgroup_skb/ingress program is expected to return [0, 1]
>  		 * values, so branch above makes sure that in a fallthrough
>  		 * case we have a valid 1 stored in R0 register, but in
>  		 * a branch case we assign some random value to R0.  So if
>  		 * there is something wrong with precision tracking for R0 at
>  		 * program exit, we might erroneously prune branch case,
>  		 * because R0 in fallthrough case is imprecise (and thus any
>  		 * value is valid from POV of verifier is_state_equal() logic)
>  		 */

This comment explains the test in terms of "precision tracking for R0" and
the "is_state_equal() logic", while this hunk removes the annotations that
checked r0 precision.  Is it meant to stay as it is?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index 256547048cc4..92331e1a6c63 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
[ ... ]
> @@ -132,18 +109,15 @@ __naked void linked_regs_bpf_x_dst(void)
>
>  /* Same as linked_regs_bpf_k, but break one of the
>   * links, note that r1 is absent from regs=... in __msg below.
>   */
>  SEC("socket")
>  __success __log_level(2)
> -__msg("7: (0f) r3 += r0")
> -__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
> -__msg("frame0: parent state regs=r0 stack=:")
> -__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
> -__msg("frame0: parent state regs=r0,r2 stack=:")
> -__flag(BPF_F_TEST_STATE_FREQ)
> +/* r1 is not there */
> +__msg("5: (25) if r0 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) "{{$}}")
> +__msg("8: (bf) r1 = r1                       ; R1=0")
>  __naked void linked_regs_broken_link(void)

The header comment still points to "regs=..." in the __msg below.  That was
the "frame0: parent state regs=r0,r2 stack=:" line of precision tracking,
which this patch removes, and the new __msg contains no "regs=" text.

The patch also adds "/* r1 is not there */" a few lines further down, so the
test now has two comments saying the same thing, and one of them names a log
format that no longer exists.  Should the header say something like "note
that R1 is absent from the registers printed after the jump in __msg below"
and the added comment be dropped?

[ ... ]
> @@ -595,21 +478,19 @@ __naked void check_ids_in_regsafe_2(void)
>   * If such IDs *are* generated the 'l1' below would be reached in
>   * two states:
>   *
>   *   (1) r1{.id=A}, r2{.id=A}
>   *   (2) r1{.id=C}, r2{.id=C}
>   *
> - * Thus forcing 'if r1 == r2' verification twice.
> + * neither of which is within the other one.
>   */

Is "neither of which is within the other one" correct for the two states
listed just above it?  (1) r1{.id=A}, r2{.id=A} and (2) r1{.id=C},
r2{.id=C} have the same shape, so check_scalar_ids()/check_ids() map A<->C
one to one and each state is within the other.

The listing was already inaccurate before this patch, but the new sentence
now contradicts it.  The states the program would produce at l1 if constants
got ids use r3 and r4:

  (1) r3{.id=A}, r4{.id=A}   from "r3 = r1; r4 = r1;"
  (2) r3{.id=B}, r4{.id=C}   from "r3 = r1; r4 = r2;"

For that pair check_ids() fails in both directions, because one id would
have to map to two ids, and so "from 7 to 14: within" would not appear.
Could the listing be updated to those states?  no_scalar_id_for_const32()
relies on this comment through "Same as no_scalar_id_for_const()".

[ ... ]
> @@ -743,109 +620,95 @@ __naked void ignore_unique_scalar_ids_old(void)
[ ... ]
> -/* Check that two different scalar IDs in a verified state can't be
> - * mapped to the same scalar ID in current state.
> +/* Check that two different scalar IDs in the state that is there can't be
> + * mapped to the same scalar ID in the state that arrives.
>   */
>  SEC("socket")
>  __success __log_level(2)
> -/* The exit instruction should be reachable from two states,
> - * use two matches and "processed .. insns" to ensure this.
> - */
> -__msg("16: (95) exit")
> -__msg("16: (95) exit")
> -__msg("processed 22 insns")
> -__flag(BPF_F_TEST_STATE_FREQ)
> +__not_msg("from 10 to 11: within")
> +__msg("11: R0=0 R6=" ALONE(255, 0xff) " R7=" ALONE(255, 0xff))
>  __naked void two_old_ids_one_cur_id(void)
>  {
>  	asm volatile (
>  	/* Give unique scalar IDs to r{6,7} */
>  	"call %[bpf_ktime_get_ns];"
>  	"r0 &= 0xff;"
>  	"r6 = r0;"
>  	"r8 = r0;"
>  	"call %[bpf_ktime_get_ns];"
>  	"r0 &= 0xff;"
>  	"r7 = r0;"
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
>  	 * will become singular and reset to zero before if r6 > r7
>  	 */

Is this comment still accurate?  The program has no "if r6 > r7" any more,
because the patch replaces it with "if r6 <= r7 goto l1_%=;".

The timing also differs under the new verifier.  bpf_clear_singular_ids() is
now called from flow_arrive() when a state arrives at a block, that is at
the two arrivals at l1 after the "if r6 <= r7" jump, and not before the jump
as is_state_visited() used to do.  Should this read something like "when the
states arrive at l1"?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 4d1374885f6d..b41f390df3af 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -515,21 +515,12 @@ __msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0=0 R10=fp0 fp-16=0")
>  __msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0")
>  /* similarly, when R2 is assigned from spilled register, it is initially
>   * imprecise, but will be marked precise later once it is used in precise context
>   */
>  __msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2=0 R10=fp0 fp-16=0")
>  __msg("11: (0f) r1 += r2")
> -__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
[ ... ]
> -__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
>  __naked void partial_stack_load_preserves_zeros(void)

This patch removes the mark_precise: expectations from
partial_stack_load_preserves_zeros(), but the comments above them still
describe precision tracking.  They talk about "IMPRECISE" spills, and say
R2 "will be marked precise later once it is used in precise context".

There is no precise field in struct bpf_reg_state any more, and the
annotations that showed the later marking are gone.  In the same file the
patch changes the matching wording in stack_load_preserves_const_precision()
and stack_load_preserves_const_precision_subreg() from "IMPRECISE fake
register spill" to "fake register spill" and from "spilled IMPRECISE ... const
reg" to "spilled const reg".  Should the comments here be updated the same
way?

[ ... ]
> @@ -1115,159 +1045,142 @@ l0_%=:	r1 >>= 32;					\
[ ... ]
> -/* stacksafe(): check that stack spill of a precise scalar in old state
> - * is not considered equivalent to STACK_MISC in cur state.
> +/* stacksafe(): check that the state with STACK_MISC is not considered to be
> + * within the state with a stack spill of a known scalar, which is there.
>   */
>  SEC("socket")
>  __success __log_level(2)
> -/* verifier should visit 'if r1 == 0x2a ...' two times:
> - * - once for path entry - label 2;
> - * - once for path entry - label 1 - label 2.
> - */
> -__msg("if r1 == 0x2a goto pc+0")
> -__msg("if r1 == 0x2a goto pc+0")
> -__msg("processed 15 insns")
> -__flag(BPF_F_TEST_STATE_FREQ)
> +/* what is loaded is not known to be 42 */
> +__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar() R10=fp0 fp-8=mmmmmmmm")
> +__msg("9: (15) if r1 == 0x2a goto pc+0       ; R1=scalar()")
> +__msg("processed 11 insns")
>  __naked void old_precise_scalar_vs_cur_stack_misc(void)
>  {
>  	asm volatile(
>  	/* get a random value for branching */
>  	"call %[bpf_ktime_get_ns];"
>  	"if r0 == 0 goto 1f;"
>  	/* conjure STACK_MISC at fp-8 */
>  	"call %[bpf_ktime_get_ns];"
>  	"*(u64*)(r10 - 8) = r0;"
>  	"*(u32*)(r10 - 4) = r0;"
> +	"goto 2f;"
> +"1:"
> +	/* conjure scalar at fp-8 */
> +	"r0 = 42;"
> +	"*(u64*)(r10 - 8) = r0;"
>  "2:"
> -	/* read fp-8, should not be considered safe on second visit */
>  	"r1 = *(u64*)(r10 - 8);"
> -	/* use r1 in precise context */
> +	/* the value of r1 matters */
>  	"if r1 == 42 goto +0;"
>  	"exit;"

After this rewrite, is the outcome decided by fp-8 or by r0?  The comment
says the test checks "that the state with STACK_MISC is not considered to be
within the state with a stack spill of a known scalar", but with the new
block order it looks like r0 decides it.

The label 1 state (r0 = 42, fp-8 = spill of 42) reaches insn 8 first.  The
fall-through state (r0 = unknown from bpf_ktime_get_ns(), fp-8 = mmmmmmmm)
arrives second.  flow_merge() first calls flow_within(t, s), which is
bpf_state_subsumes(old = spill state, cur = MISC state).  func_states_equal()
runs regsafe() on the live registers before it calls stacksafe(), and r0 is
live there because exit reads it:

    regsafe(old r0 = 42, cur r0 = unknown)    fails range_within()

so stacksafe() is never reached in the direction the comment describes.  The
second check, flow_within(s, t), succeeds through:

    if (env->allow_uninit_stack && old_type == STACK_MISC)
            continue;

and that alone gives the expected "R1=scalar()" and "processed 11 insns".

Suppose stacksafe() wrongly accepted MISC in place of a spilled known
scalar, which is the unsound pruning the original test guarded against.  Would
the r0 mismatch still reject the "within" and leave this test passing?
Before precision tracking was removed, r0 was imprecise at the checkpoint and
only fp-8 was precise (through "if r1 == 42"), so stacksafe() decided the
outcome.  Now that every scalar is compared by range, "r0 = 42" decides it.

old_imprecise_scalar_vs_cur_stack_misc() has the same problem: its
"r0 = 42" label 1 state fails the first check on r0, so the 64-bit scalar
spill vs MISC handling (im == 0) in stacksafe() is never what decides it.

Would making r0 dead at label 2, for example with "r0 = 0;" before exit,
help?  Then fp-8 would decide the first check, and a stacksafe() bug would
show up as "from 5 to 8: within" and R1=42.

[ ... ]
> @@ -1307,41 +1220,40 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
[ ... ]
>  /*
> - * stacksafe(): check if 32-bit scalar spill in old state is considered
> - * equivalent to STACK_MISC in cur state.
> + * stacksafe(): the state with a 32-bit scalar spill is there, the state with
> + * STACK_MISC arrives. The first one is within the second one.
>   * 32-bit scalar spill creates slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL.
>   * Without 32-bit spill support in stacksafe(), the STACK_SPILL vs STACK_MISC
> - * mismatch at slot[4] causes pruning to fail.
> + * mismatch at slot[4] keeps the states apart.
>   */
>  SEC("socket")
>  __success __log_level(2)
> +__msg("8: R0=scalar() R10=fp0 fp-8=????mmmm")
>  __msg("8: (79) r1 = *(u64 *)(r10 -8)")
> -__msg("8: safe")
> -__msg("processed 11 insns")
> -__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("processed 10 insns")
>  __naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
>  {
>  	asm volatile(
>  	/* get a random value for branching */
>  	"call %[bpf_ktime_get_ns];"
>  	"if r0 == 0 goto 1f;"
> -	/* conjure 32-bit scalar spill at fp-8 */
> -	"r0 = 42;"
> -	"*(u32*)(r10 - 8) = r0;"
> -	"goto 2f;"
> -"1:"
>  	/* conjure STACK_MISC at fp-8 */
>  	"call %[bpf_ktime_get_ns];"
>  	"*(u16*)(r10 - 8) = r0;"
>  	"*(u16*)(r10 - 6) = r0;"
> +	"goto 2f;"
> +"1:"
> +	/* conjure 32-bit scalar spill at fp-8 */
> +	"r0 = 42;"
> +	"*(u32*)(r10 - 8) = r0;"
>  "2:"

Does this test still run the stacksafe() code it was written to guard?
7b4f1a29c704 ("selftests/bpf: Test 32-bit scalar spill pruning in
stacksafe()") added it for the im == 4 handling from 596bef1d718d ("bpf:
Support 32-bit scalar spills in stacksafe()").

With the branches swapped, the 32-bit spill state A (r0 = 42, slot[4-7] =
STACK_SPILL, slot[0-3] = STACK_INVALID) reaches insn 8 first.  The
STACK_MISC state B (r0 = scalar(), fp-8 = ????mmmm) arrives from insn 5.
flow_merge() makes two checks.

The first is flow_within(A, B), i.e. bpf_state_subsumes(old = A, cur = B).
func_states_equal() compares the live registers before it calls stacksafe(),
and r0 is live at insn 8 because exit reads it:

    regsafe(old r0 = 42, cur r0 = scalar())    fails range_within()

so stacksafe() is never called.

The second is flow_within(B, A), i.e. stacksafe(old = B, cur = A).  Every
byte of B is STACK_INVALID or STACK_MISC, and stacksafe() skips both before
it reaches the scalar spill code:

    if (old_type == STACK_INVALID || old_type == STACK_POISON)
            continue;

    if (env->allow_uninit_stack && old_type == STACK_MISC)
            continue;
    ...
    if (im == 0 || im == 4) {
            old_reg = scalar_reg_for_stack(env, old_slot, im);

allow_uninit_stack must be true in this run, otherwise the 8-byte read of
????mmmm at insn 8 would be rejected and the test expects __success.

So the im == 4 handling is never executed here.  If it were removed, A would
still be within B, and the log would still have
"8: R0=scalar() R10=fp0 fp-8=????mmmm" and "processed 10 insns".  Is the
edited sentence "the STACK_SPILL vs STACK_MISC mismatch at slot[4] keeps the
states apart" still correct?  Without 32-bit spill support the states would
be joined in exactly the same way, so reverting 596bef1d718d would not fail
this test.

The same root cause affects the neighbouring tests.
old_imprecise_scalar_vs_cur_stack_misc() (the 64-bit im == 0 path from
6efbde200bf3) is decided by the same two steps, and
old_precise_scalar_vs_cur_stack_misc() is decided by regsafe() on r0
(42 vs scalar()) rather than by stacksafe().

To get the coverage back, could the two branches leave the same r0, with the
32-bit spill holding an unbounded scalar and the STACK_MISC state reaching
the join after the spill state?  Then "from N to 8: within" would be printed
only when stacksafe() accepts the spill.  Another option is a
__caps_unpriv(CAP_BPF) variant, like the nearby stack_noperfmon tests, where
allow_uninit_stack is false and the MISC bytes go through
scalar_reg_for_stack().  No later patch in this series changes these tests or
stacksafe().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============8113903478147373790==--
