Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986821;
	b=w0jIvlrvYDqVlRR12O/EC9ynkKHcGLXZluYW5QNAGGxjzyNDA3mL7iJaRCQQ2N5NetpI
	 gpJrVNP12HIOaynS5aSZO3FCWZO+G+S3PTP3y64MxGogqkgD15+RElGTbExvKj9BTvuOw
	 cqqjnoFh1+qtViabDNfEf/PC6uoL61vZR333IE7q8mpTgpjt4hccqOuj0rziL0yBWRXgV
	 +zz/0APTj46QeDgdlH46vuaLivm0ifUqhekkqRs4SKJC9zG2GNY1oN/SICnbQIMFRq8Ot
	 84SnliBHo74mYBvn26pCUuonPq2XO2kAXLZkGKRhWUkH+H2vtXL36FLXUWDZYPqZg/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986821;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5Y1XzqIRfowDYxxEldxLLVUt/C7/GoHk9kXrZ9m8G7k=;
	b=pKbZzPo8TaU8VZC0KI444hdzd3axH11FkH2v3a5Cr1Gwb/DgAttwA8383mrVQswv2PY4
	 pyqTLBz7OQt2iNNvpoojcsPWgji4Pq+rrBmkk1pP6oVySR7WZMyjH2TH0jCvnkKtPI+dT
	 V9HgQJfKmzIOf7AqfoFiXuSwMpn9xwtxQ3OOYzUGr+bub4OZbeIKWodEBKWv6Cq2bxJoS
	 jRWFwJC4RIBuTI6i+tHbMuM13mJ0dUHJfN/BtkgL9YdXwn+w8tuO6JSwHycXVnhlWA8S7
	 4i9+xDct5JmVLcnMp3BWcYVHmUU0HL5tVmLmRCwMpr7vdxWB5onIBA/qc1nJgGtV0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmIDSK7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D6606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmIDSK7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3751F01825;
	Mon, 26 Oct 2026 03:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986820;
	bh=5Y1XzqIRfowDYxxEldxLLVUt/C7/GoHk9kXrZ9m8G7k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZmIDSK7hYCK1EVKk+pEWPcOTdmspxUPU12cKHrtBDuo7xbUQAQAgiVtP4X1+eNUCu
	 SJyqQcHKAwuI3t5NJRZ1K3RF4EMOSt1bAiJT2koD4WbzzsexCkbXeHTRD4CCLWEMVq
	 lvSR1ta2/ry83fai0V+vVJmlwWbSBv34dZGYKwD4EB4ECDZansE5JB+wJN0lWUz1Mx
	 gIYmn6EliH4dtvLySo3GStqZSbss/fmEfMYy+9KEEJHJZieDOKWjw797Ea2RolT3uw
	 TqBGjH8XxAq/JFx0j3SjzHQrbs12R5oZ//yhjgsNvEGXs7NMrv+o3xBLy2FT2dH3w3
	 B+jKouUyYkNEg==
Content-Type: multipart/mixed; boundary="===============4216544480226003636=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b7123f11524f2bb5a4089cde2e337ba13b924624b02590f0d7ad8d03c85da175@mail.kernel.org>
In-Reply-To: <20261026025943.404450-48-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-48-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 47/81] bpf: Add join of verifier states
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:40 +0000 (UTC)

--===============4216544480226003636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add join of verifier states

TL;DR:
- Widened join of packet pointers with ids may fail the subsume check, so
  valid programs could be rejected with a verifier bug warning
- Same possible failure in explore_alu_limits mode and stack slot poisoning
- Header comment on @widen is inaccurate

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> new file mode 100644
> index 000000000000..dde40dc4ff4f
> --- /dev/null
> +++ b/kernel/bpf/join.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Join of verifier states.
> + *
> + * bpf_states_join(dst, a, b) computes the state that describes every concrete
> + * state described by 'a' or by 'b'. With @widen what is larger in the result
> + * than in 'a' is not known at all in the result, so that a sequence of states
> + * at a loop head ends.

Is this description of @widen accurate for scalars?

It holds only for pointers, where join_range() calls
bpf_reg_forget_range().  For scalars, join_range() calls
bpf_reg_widen_range(dst, ra), which moves the bound that grew to the next
stop (0, S32_MAX, U32_MAX, S64_MAX, or S32_MIN/S64_MIN).  That keeps a finite
range such as [0, S32_MAX] and does not make the value unknown.

The commit message describes this correctly ("the join moves the bound of a
scalar that grew to the next of these stops"), so the header comment
contradicts both the code and the changelog.

[ ... ]

> +/*
> + * Join of the range of two registers of the same type, numbers or pointers
> + * with variable offset. @dst is a copy of @ra.
> + */
> +static void join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
> +		       const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
> +{
> +	if (range_equal(ra, rb))
> +		return;
> +	bpf_reg_union_range(dst, rb);
> +	if (!js->widen || range_equal(dst, ra))
> +		return;
> +	if (dst->type == SCALAR_VALUE)
> +		bpf_reg_widen_range(dst, ra);
> +	else
> +		bpf_reg_forget_range(dst);
> +}

Can this produce a result that does not subsume input 'a' when widen is set
and the registers are PTR_TO_PACKET pointers that carry an id?

join_reg() lets two such pointers through when their r64.base values are
equal, and dst keeps the id of a:

	/* displacements between pointers that share an id are kept */
	if ((ra->id || rb->id) && ra->r64.base != rb->r64.base)
		return false;
	...
	if (!jid_strict_ok(js, ra->id, rb->id))
		return false;
	...
	join_range(js, dst, ra, rb);

If b is not within a, join_range() then calls bpf_reg_forget_range(dst).
That calls __mark_reg_unbounded(), which sets dst->r64 to CNUM64_UNBOUNDED,
{ .base = 0, .size = U64_MAX }, while dst->id keeps the id of a.  regsafe()
for PTR_TO_PACKET rejects that state when the old state is dst:

	/* Preserve displacements between pointers sharing an ID. */
	if (rold->id && rold->r64.base != rcur->r64.base)
		return false;

So when the r64.base of a is non-zero, join_check(js, dst, a) ->
bpf_state_subsumes() fails.  bpf_states_join() then calls verifier_bug()
(a WARN_ONCE under CONFIG_DEBUG_KERNEL) and returns -EFAULT, and
flow_merge() aborts the load.  The same thing happens to any second pointer
with the same id at a non-zero displacement, e.g. r4 = r3 + 8.

For example, p = data + 14 gives id 0 and r64 [14,14].  Then
p += *(u8 *)p, an unknown addend >= 0, gives a fresh id and r64 [14,269].
One more trip gives another id and r64 [14,524].  The bases are both 14, the
ids form a good pair, and the ranges differ.

At the end of the series, flow_merge() (kernel/bpf/flow.c) passes widen=true
at a loop head (cycle == FLOW_CYCLE), and also at any insn once
s->joins > BPF_FLOW_MAX_JOINS (16).  bpf_flow_exit() passes widen=true for
recursive subprogs.  A valid program is then rejected with a "verifier bug:
join of states ... does not subsume input" splat, and the comment
"displacements between pointers that share an id are kept" does not hold in
widen mode.

Neither join.c nor bpf_reg_forget_range() changes later in the series
(through 51224d16c11b) in a way that fixes this.

Should bpf_reg_forget_range() keep r64.base for a packet pointer that has an
id (a full arc may use any base), or should join_reg() return 'no join' for
that case?

[ ... ]

> +static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
> +		     const struct bpf_reg_state *ra, const struct bpf_reg_state *rb, int pass)
> +{
[ ... ]
> +	switch (base_type(ra->type)) {
> +	case SCALAR_VALUE:
> +		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
> +			return false;
> +		if (pass == 1) {
> +			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
> +			return true;
> +		}
> +		join_range(js, dst, ra, rb);
> +		/* a link that exists on one side only is dropped */
> +		if (ra->id && !jid_good(js, ra->id, rb->id)) {
> +			dst->id = 0;
> +			dst->delta = 0;
> +		}
> +		return true;

When env->explore_alu_limits is set, can clearing dst->delta here give a
result that regsafe() does not accept?

In that mode two scalars are joined only if reg_value_equal(ra, rb) holds.
That is a memcmp() up to 'id', which also covers 'delta', so
ra->delta == rb->delta.  If the link is then dropped because the id pair is
bad, dst->delta is set to 0.  regsafe() in explore_alu_limits mode compares
the same bytes:

	if (env->explore_alu_limits) {
		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
		       check_scalar_ids(rold->id, rcur->id, idmap);

A scalar with a BPF_ADD_CONST link has a non-zero delta, e.g.
r7 = r6; r7 += 1.  If its pair is marked bad, dst->delta (0) no longer
equals a->delta or b->delta.  The pair goes bad when the same id has two
partners.  For example:

  a: r6.id=N, r7.id=N|BPF_ADD_CONST64 with delta=1, r8.id=N
  b: r6.id=M, r7.id=M|BPF_ADD_CONST64 with delta=1, r8.id=K

with all three being unknown scalars with the same bounds.  Then
join_check(js, dst, a) -> bpf_state_subsumes() -> regsafe() fails, and
bpf_states_join() reports verifier_bug() (WARN_ONCE under
CONFIG_DEBUG_KERNEL) and returns -EFAULT.

explore_alu_limits is set by sanitize_ptr_alu() for any pointer arithmetic
with a non-constant scalar when the Spectre v1 mitigation applies, i.e. for a
loader without bypass_spec_v1.  At the end of the series flow_merge() and
bpf_flow_exit() call bpf_states_join() whatever explore_alu_limits is, and no
fix was found through 51224d16c11b.

Would it be better to leave dst->delta alone when the id is dropped in this
mode, or to return 'no join'?

[ ... ]

> +	had_spill = slot_has_spill(sa) || slot_has_spill(sb);
[ ... ]
> +	/*
> +	 * When reads of uninitialized stack are not allowed stacksafe() accepts
> +	 * MISC in place of a spilled scalar only for whole slots.
> +	 */
> +	if (had_spill && !js->env->allow_uninit_stack) {
> +		bool ok = (slot_is_full_spill(sa) || slot_is_data(sa)) &&
> +			  (slot_is_full_spill(sb) || slot_is_data(sb));
> +
> +		for (i = 0; ok && i < BPF_REG_SIZE; i++)
> +			ok = res[i] == STACK_MISC;
> +		if (!ok) {
> +			slot_poison(js, ds);
> +			return true;
> +		}
> +	}

Is it correct to poison the whole 8-byte slot here whenever the slot is not a
full spill or plain data on both sides?

There seem to be two problems.

First, the comment does not match stacksafe(), which also accepts MISC in
place of a spilled scalar for half a slot.  At im == 4,
scalar_reg_for_stack() returns unbound_reg for a MISC run in the old (joined)
slot and spilled_ptr for a slot whose slot_type[4] is STACK_SPILL with a
scalar, and regsafe(unbound, spill) is true.

For example, a = [M,M,M,M,S,S,S,S] (a 4-byte scalar spill at fp-8 over MISC)
and b = [M x8].  A result of [M x8] is within both inputs: bytes 0..3 are
MISC against MISC, and bytes 4..7 pass the im == 4 shortcut.  The same holds
for a = [S x8] against b = [P,P,P,P,M,M,M,M] with a result of
[P,P,P,P,M,M,M,M].

Second, when ok is false, slot_poison() also sets STACK_POISON on bytes that
are initialized (MISC/ZERO) in both inputs.  Those bytes cannot be read after
the join.  check_stack_read_fixed_off() then rejects a read that is valid on
each path, with the message "slot poisoned by dead code elimination", which
says nothing about the real cause.  In the allow_uninit_stack case the same
inputs give per-byte MISC/INVALID and the reads stay valid.

Once flow_merge() and bpf_flow_exit() call bpf_states_join(), a loader with
CAP_BPF but without CAP_PERFMON (bpf_capable && !allow_uninit_stack, the only
mode that has scalar spills and this branch) can have a valid prog rejected.
flow_merge() does not keep such states apart: flow_unset_differs() looks only
at registers, and flow_join_makes_up() looks only at tested numbers.

Could this return false (no join) for the cases that really cannot be
represented, or poison only the bytes that need it, so that bytes both inputs
initialized are not lost?  The comment should also describe what stacksafe()
accepts.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b44a5c63a922..bb42c2707db2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17867,6 +17867,73 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
>  	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
>  }
>
> +/* Nothing is known about the number or the variable part of the offset anymore. */
> +void bpf_reg_forget_range(struct bpf_reg_state *reg)
> +{
> +	reg->var_off = tnum_unknown;
> +	__mark_reg_unbounded(reg);
> +	reg_step_reset(reg);
> +}

Does this make the join of two packet pointers with a variable offset fail
the check in bpf_states_join() when widen is set?

This is the same problem as noted above for join_range().  join_reg() joins
PTR_TO_PACKET registers that have ids only when the bases are equal, and
keeps the id of a in dst.  With js->widen, join_range() calls
bpf_reg_forget_range() for every non-scalar whose range grew.

__mark_reg_unbounded() sets r64 to CNUM64_UNBOUNDED, i.e.
{ .base = 0, .size = U64_MAX }.  The r64 of a pointer is the whole offset, so
this also drops the fixed displacement while dst->id is still the non-zero id
of a.  bpf_state_subsumes(dst, a) then runs regsafe():

	/* Preserve displacements between pointers sharing an ID. */
	if (rold->id && rold->r64.base != rcur->r64.base)
		return false;

That fails (0 != a->r64.base) whenever the shared base is not 0.  join_check()
then prints "join of states at insn %u does not subsume input 'a'" through
verifier_bug() and returns -EFAULT.

For example, p = data + 14 + ihl*4 is a variable add, so p has an id and
r64.base 34.  The loop body does p += p[1] (adds [0,255]), and scev cannot
count the loop or the walk runs out of patience (bpf_flow_loop_enter() sets
apart=false).  At each back edge flow_merge() runs with FLOW_CYCLE, so
widen=true.  The head state has p {id X, r64 {34, n}} and the next trip has
p {id Y, r64 {34, n+255}}.  The pair (X, Y) is good and the bases are equal,
so join_reg() goes on to join_range() -> bpf_reg_forget_range(), and
join_check() fails.

Widening also happens in flow_merge() when s->joins > BPF_FLOW_MAX_JOINS, and
in bpf_flow_exit() for recursive subprogs, so enough paths meeting at one
insn are also enough, without a loop.

The commit message says only that "The offset of a pointer that grew becomes
unknown."  Users then see a kernel warning and a "verifier bug" message for a
program that should get a normal rejection, or keep a usable pointer.  join.c
is built and called from "bpf: Verify programs as a fixpoint over the control
flow graph", and the code is unchanged through 51224d16c11b, so no later fix
was found in the series.

Could bpf_reg_forget_range() keep r64.base and forget only the size for a
PTR_TO_PACKET with an id, or could the id be cleared, or no join be returned?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============4216544480226003636==--
