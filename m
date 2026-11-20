Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211501;
	b=IRR3o7XwfLdgBWF6A5NXGSQTWEWnyPag6DwDTd82eFV+szOBCfY5mMXzgZ9Qxb8Kd2uZ
	 0F3fluNaA8cW31hbWLwuZ4F52VfnKTkZx9ty+gcz/TwQhfYd4qsBthTKQ/AmuR5eTf9p1
	 T+hAH27HdC6bbeyNvAvX+ioN9zSc72eLv3XAAihKK99A66xXZ441sje8wzuyFSTQfwct7
	 8pEszCeE3g22roOSc9nOELNvbLplJGHqHgQskLtUOp8w7bc39N9Ks1fym2kPY32pgTRju
	 lhP6S1Edd+BmAvG4nWYaHCMnqi4tgohnQNVMb/zEduuyX+qc8xVDu8h5nv8Bw5sHs0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211501;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=zqpYPOyv3Wb17b7Br4LxwG2s9g/hiW9c1cQhjlmShrg=;
	b=1GdLSBhkXh9znIA5mM6/rTtiHZkweEySocXvICgT4bFLsK4S5M6POC6s247KWeILaFHa
	 7ykeiMWe6gRYgiRw4ha444jysu+l6Ee4YAaT285PXGu8tqS2oxS6CnLNr7JzoX6GkDzQ0
	 e7Bk39EAZiU1iI8hBslYiBynWYXv7mz69moQa+7hDDp30rY1jqynnk8HgphyYKQQMx7QF
	 pb9ilWMUUfL3AYL/ow814tztHrTpFrXwyiJan2pNjrpJzGh2hgYdEuKWeygXPrRidUxjL
	 JmXB06NXlTDvCHcqO+xJGwRlsuphHmHE27M5G0t/MTMU1M7V971DSwkOwTos7g5SMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWxsBsRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3E606A698
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWxsBsRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF11F000C6;
	Fri, 20 Nov 2026 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211500;
	bh=zqpYPOyv3Wb17b7Br4LxwG2s9g/hiW9c1cQhjlmShrg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oWxsBsRNmP0QlBSd5IDUYEID+3RZlkbXM37iWz1zRbJhdGPmenxhZrskXhRwTmj/e
	 cpvZoVPDKYGEsqP8DHf+lLh4Lmuvhq1fwF3n9/HnlJNQSxLtYoK5KmmfAD3C2yeYq6
	 Jgu4qqGbXx3fh6Lgjw12gyGL3cLOdK3OG840tmGpY/pJsIP48IHRbA7l3CddoRyGAz
	 c6KChoCpC7tX41Pu+O+sW2f0Mrs0yLhs8rO1R7TI5RckJhlMiYcbutWpWzDgb93gql
	 BLF/E0XlK1IIM/KJVkl7L61QRUqMnkBh1iByThUW8YupzOCy8UGPlqm2z6WPPADZLr
	 B8LjF16IGgdeA==
Content-Type: multipart/mixed; boundary="===============0649409446711110983=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <973babfe80081ebe72e12a2574fd0feac044aefcf6ac67feaa0762064dd4e464@mail.kernel.org>
In-Reply-To: <20261120204959.614908-36-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-36-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 35/49] bpf: Reproduce an error on one path, with no joins
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:39 +0000 (UTC)

--===============0649409446711110983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reproduce an error on one path, with no joins

TL;DR:
- Loop-trip skip may build impossible states with no guess flagged, so valid
  programs could be rejected
- State hash may conflate r6==r1 with r6==r1+1, missing the failing path
- find_failing_path() unused here: possible -Werror build break

> diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
> --- a/kernel/bpf/equation_join.c
> +++ b/kernel/bpf/equation_join.c

[ ... ]

> +/* A path-sensitive run has no equations for the trip index. Two trips give the step. */
> +static void note_trips_left(struct bpf_verifier_env *env, struct loop_stack_entry *e,
> +			    const struct scalar *x, u8 op, bool jmp32, const struct scalar *bound,
> +			    bool is_body_jump)
> +{
> +	u64 value = jmp32 ? x->r32.base : x->r64.base, far_end;
> +	s64 step = jmp32 ? (s32)(value - e->iv_prev) : value - e->iv_prev;
> +
> +	if (e->iv_jump_idx && e->iv_jump_idx != env->insn_idx)
> +		return;
> +	far_end = value + (step < 0 ? 0 : jmp32 ? x->r32.size : x->r64.size);
> +	if (e->iv_jump_idx)
> +		e->trips_left = step ? compute_trip_count(step, &far_end, op, jmp32, *bound) : 0;

Can this skip a path the program cannot take without setting
run_has_guess?  note_trips_left() takes the step from the iv operand alone
(value - e->iv_prev) and passes the other operand's current value to
compute_trip_count() as a fixed bound.  Nothing checks that the bound stays
put between trips.

bpf_fast_forward_xregs() then moves every xreg that changed into iv_xregs,
the bound register included.  bpf_jumps_see_same() leaves out the iv jump
and drops iv_xregs from loop_carried, so the moving bound is never
compared.  bpf_steps_are_constant() only asks whether the operands of the iv
jump have a constant step, and a bound such as 'n--' has one, so it returns
true.

For example:

  for (i = 0; i < n; i++) if (rnd()) n--;

The passes do not treat n as an iv because it moves only on some paths, so
bpf_collect_iv_thresholds() sets aux->iv_operand = 1.  On the path that
takes the n-- edge on every trip with n = 100000, trips_left is computed as
n - i (about 99994), but the real count is (n - i) / 2.  The skip moves i by
+99992 and n by -99992, and the loop exits with i = 99996 and n = 4, while
every real execution of that path exits with i == n == 50000.

That state is impossible and no guess is recorded.  Once 02e7abee2ca0
("bpf: Verify in passes") wires up find_failing_path(), a check after the
loop that depends on n or i can fail on this false path.  The program is
then rejected with that path's error and log, and 'if (path_err && !guess)'
cuts env->max_cost.  Isn't that the case run_has_guess is meant to prevent
("If such a path cuts the budget, a valid program can be rejected")?

Would it work to count the trips from the step of the difference of the two
operands, or to treat a bound operand that is in iv_xregs as a guess (or
refuse the skip)?

[ ... ]

> +/* If the operand has a constant step, the result has one too. @prev: in the same block. */
> +static bool keeps_constant_step(const struct bpf_insn *insn, const struct bpf_insn *prev,
> +				bool infinite)
> +{
> +	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
> +
> +	if (bpf_is_ldimm64(insn))
> +		return true;
> +	if (class != BPF_ALU64 && (class != BPF_ALU || infinite))
> +		return false;
> +	if (op == BPF_MOV)
> +		return !insn->off || (!infinite && insn->off == 32);

Is it correct to treat 32-bit ALU insns as keeping a constant step whenever
!infinite?  Here, when trips_left <= 2^32, keeps_constant_step() accepts
BPF_ALU insns, 'w = w' zero extension, movsx32 and the '<<= 32; >>= 32'
idiom.  bpf_steps_are_constant() does the same for 4-byte fills
('!infinite || BPF_SIZE(insn->code) == BPF_DW').

The comment '@infinite: above 2^32 trips.  Only the jump counts, and 32-bit
insns wrap.' assumes a 32-bit result cannot wrap in fewer than 2^32 trips.
That holds only for a step of +-1 that starts from 0.  A 32-bit value wraps
once start + trips * step crosses 2^32.  For 'w7 += 0x10000' in a
100000-trip loop that happens after 65536 trips, and for a hash constant
such as 0x9e3779b9 it happens every other trip.

move_bounds() then adds the 64-bit delta times factor through
scalar_add().  For:

  u32 h = 0; for (i = 0; i < 100000; i++) h += 0x10000;

the skip sets r64 of the zero-extended register to 0x1869F0000 (r32 =
0x869F0000), but the real register is 0x869F0000.  Any 64-bit use after the
loop (a 64-bit jump, a shift, an index added to a pointer) sees a value no
execution has.  bpf_steps_are_constant() still returns true, so
run_has_guess is not set, and the result is a false failing path with no
guess, as above.

The 'i += 1; x = (u32)i; yes' example in the bpf_steps_are_constant()
comment has the same problem when i does not start near 0 or the step is
not 1.

[ ... ]

> +			slot = slot_of_insn(env, insn);
> +			has_step = !slot ? keeps_constant_step(insn, prev, infinite) :
> +				   test_bit(bpf_xreg_to_spi(slot),
> +					    aux[loop->header].live_stack_before) &&
> +				   !test_bit(slot, not_linear) &&
> +				   (!infinite || BPF_SIZE(insn->code) == BPF_DW);

Can stores that move with the iv be lost by the skip without being counted
as a guess?  bpf_fast_forward_xregs() moves only the registers and spilled
slots of the current frame whose bounds differ between the saved trip and
this one.  Stores that the skipped trips make at addresses that move with
the iv are not reproduced.

Take a fill loop such as:

  u64 arr[N] = {}; for (p = arr; p < arr + N; p++) *p = f(i);

Here 'p' (PTR_TO_STACK) and 'i' move with a constant step.  The store
'*(u64 *)(r1 + 0) = r6' has a base that is not BPF_REG_FP, so
slot_of_insn() returns 0 and keeps_constant_step() returns false for
BPF_STX.  A store has no def_regs, though, so the miss changes neither
no_step nor new_step, and bpf_steps_are_constant() returns true.
bpf_jumps_see_same() does not see the stored slots either: they are not
live at the header, so they are not in loop_carried, and no control seed
depends on them.

After the skip, the path state lacks every store from the skipped trips.
arr[k] for the skipped k still holds its value from before the loop
(STACK_ZERO here, STACK_INVALID without the '= {}').  A check after the
loop that reads such an element, for example buf[arr[50]], sees a value no
execution has.  It can fail at the insn where the joined pass failed, with
run_has_guess false.  Once find_failing_path() is wired up, that false path
becomes the reported error and log, and the budget of the passes that could
peel the loop and prove the program is cut.

The commit message lists three guesses (non-constant steps, 'infinite', the
may_goto target).  This case is none of them, yet it also "can make a path
that the program cannot take".  Should it be a guess too?

> diff --git a/kernel/bpf/failing_path.c b/kernel/bpf/failing_path.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/bpf/failing_path.c

[ ... ]

> +static u64 hash_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
> +{
> +	unsigned long all[XREG_WORDS], control_deps[XREG_WORDS];
> +	u64 hash = bpf_hash_join_key(env, st);

[ ... ]

> +		bpf_add_cost(env, 2 * bitmap_weight(all, bits), BPF_COST_XREG);
> +		hash += bpf_equations_hash(env, st, fr, all, bits);

Can this hash tell r6 == r1 apart from r6 == r1 + 1?  hash_state() is the
dedup key of the path-sensitive run: bpf_failing_path_was_here() drops a
state at a join point when another state with the same hash got there
first.  The only relational part of the key is bpf_equations_hash(), which
hashes the pairs (first xreg, xreg) of xregs that map to the same sym:

	first = &env->eq_env->scratch[xreg_eq->sym].new_symno;
	if (*first != U32_MAX)
		hash = jhash_2words(*first, xreg_eq->xreg, hash);

It does not hash xreg_eq->coef or xreg_eq->off.  An xreg equation is
'xreg = coef * sym + off', so r6 = sym0 and r6 = sym0 + 1 give the same key
when r1 = sym0 in both states.  alu_add() keeps the sym for an added
constant: bpf_find_next_diff() returns make_expr(1, sym0, 1) when the
operand is a constant.

The commit message gives this hash a job: "Two paths can have the same
ranges, and only one of them has r1 == r6.  The other one can be the path
that fails.  So the hash of a state has the xregs that share a sym".

  r1 = *(u64 *)(r7 + 0)    // full 64-bit range
  r6 = r1                  // r1 = sym0, r6 = sym0
  if r3 != 0 goto join     // path A: jumps to join
  r6 += 1                  // path B: r6 = sym0 + 1, range still full
 join:
  if r6 == r1 goto out     // A always jumps, B never does
  <check that fails>       // only path B gets here

At 'join' both states have the same join_key, the same bytes in r1 and r6
(an unbounded scalar plus 1 is still unbounded) and the same pair (r1, r6)
in bpf_equations_hash().  Path A is delivered to 'join' straight from the
jump, and flow_add() calls bpf_failing_path_was_here() at delivery, so A
goes into prec->seen before B has run 'r6 += 1'.  When B gets to 'join',
bpf_failing_path_was_here() returns 1 and flow_add() frees it.  So the run
cannot reproduce this error, whatever order it picks.  The same happens for
r6 = 15 - r1 (coef -1, off 15) with r1 in [0, 15], where both registers get
range [0, 15] and tnum (0; 0xf).

The verdict does not change, since the passes still reject the program.
But find_failing_path() returns 0, so the budget is not cut and the log gets
no failing path.  This is reachable once 02e7abee2ca0 ("bpf: Verify in
passes") calls find_failing_path() from do_check_all(), and
bpf_equations_hash() and hash_state() stay the same through 2b5f274b69fe.

Would hashing coef and off for each xreg in 'all', relative to the first
xreg of its sym, keep these states apart?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> + * A function gets half of the budget that is left. @last: the budget is twice the cost so far.
> + */
> +static int find_failing_path(struct bpf_verifier_env *env, struct bpf_snapshot *initial, bool last)
> +{
> +	u32 trips;
> +	u64 start;
> +	int ret;

Is it intended that find_failing_path() has no caller in this commit?  A
grep of the tree at this commit finds only its definition, and
do_check_all() still runs the old bpf_flow_new_round() / round_is_dropped()
loop.  This should give a '-Wunused-function' warning ('find_failing_path'
defined but not used), and with CONFIG_WERROR=y (the default under
COMPILE_TEST) the build would break.  run_path_sensitive() and
check_funcs() are reached only from find_failing_path(), so the whole
path-sensitive run and every env->path_sensitive branch added here is dead
code at this commit.

The commit message and the new comments also describe behaviour that this
commit does not have yet:

  "If the run made no guess, see below, the passes that are left get a
  small budget.  So a wrong program is rejected fast."

  "check_funcs() checks all functions from a snapshot.  A pass uses it
  too."

  run_path_sensitive(): "If the error of a pass is real, do_check_all()
  limits the next passes and logs a path to it."

At this commit no pass calls check_funcs(), and do_check_all() never calls
find_failing_path(), so it neither cuts the budget nor logs a failing path.

The first caller arrives two commits later, in 02e7abee2ca0 ("bpf: Verify
in passes"), via 'path_err = find_failing_path(env, initial, last);' in
do_check_all().  Could find_failing_path() be wired up here, or moved
together with the claims about passes and budgets into "bpf: Verify in
passes", so that each step builds cleanly and the description stays
accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============0649409446711110983==--
