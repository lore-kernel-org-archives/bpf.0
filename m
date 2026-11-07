Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024647;
	b=vi35a/+7mZV7IWJq2wCC/FKWENfp5sR8gMUZjHn19DA24y7hadPqfke8NUtvvF0WAA6T
	 TnOh5+TytPiiZOWFxq+uw8Gy9PT7EoNgm8zO5j7+HJ2o4EFxcExMnFNXslCQqIm+vqni6
	 ZMPPCn/mOSk3b6I4IybotirFJCS0FjMsoMCvHJVGZKAAQJPr5T54fMb/KWl4gMDAk8RvB
	 tvauq97SCcR7NuJ0eGM5rQ6HRV+uZcGYTEdyYP1M43Db6EgI9JiwQG4sH9sGuI7rDbaoo
	 iqF1JOIIxLtEJeYgBOkg0pxOIY3ykrRgmu0Sw6to2VS/DbBDVW8f1aqnyZ8Sk07sI9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kttZOG3OUPSgDQJ09LE3S+u97Q4DzHOZQ5DsMXVprFg=;
	b=HMMjE/zDGlTHmBMJ3p//yp/BzJ9lV3EVD9T5IJjx2MPmOzvhhY1Of0AUSMqKc23r03sq
	 34mNCR4Ce4PUggOcCGf6eOY5JbpjajnaA+aMSRF3DOJzlXBfivZWINfvKGR0RVwM0kPGv
	 WC5C82shcPSj+hl1O9CCZOweTP6hs26Yzz2Jb4sc8GdADC9VP3yRJ5uIEV4pKucTMs2+X
	 CvXtnduJ/ju6AdPSboSesQ+kts78QqWa0kfa5hb7Jd3y9+BcZM/O+1deQLkh0pi0ozfoa
	 DmC3GSEqwqvZ2RbP1KUEimbf528LNMYBrtTALCZoVoiTtaS1ALmV9KROzBbETfzt60Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmuUkfuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F57606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmuUkfuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266BA1F0089F;
	Sat,  7 Nov 2026 04:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024646;
	bh=kttZOG3OUPSgDQJ09LE3S+u97Q4DzHOZQ5DsMXVprFg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LmuUkfuGurT3JRGLXsMfT3hX9fbwntRBRX/rVoH5IJeRTpCrmqxBJ/RLQMIL8Nv4f
	 PZ+WcQtbEu4glLFNAAKbgc1NO6tQlu+ID2u3JaRZekhNJUGSi5tYWJ85gIoF6tHz8x
	 SZB0BylhRFj0jlvyW4E209j646L1DfHzV5GmcOKAww1JWZSZFnUrY8DFhvesz42qO+
	 aWp2FEtmZ+TeJ4e2kpFiB4r7wlk8oU1kKJVU9wK5Nj8G/pWQeHmpMARpKPzAbVSf8u
	 yDPaXE9GwM8zcYcrs9zvOs3h4ltevv5YyUd8hhBDxduclxkcU8kf/xMGNVOTk6lNnn
	 kakBFpzIKMVHw==
Message-ID: <sashiko-outbox-202556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 18/46] bpf: Tell the passes over the graph
 where an added may_goto goes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-19-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-19-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:10:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: missing head guard target edge in update_insn() stack
  liveness
- [High] bpf: bpf_prune_dead_branches() folds jumps before head guards
  are placed
--

commit b45291925cc857048f8bb1e4b926985f761611df
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Tell the passes over the graph where an added may_goto goes

This commit runs bpf_flow_place_guards() right after loop detection so
constant folding, subprog argument tracking, and register liveness
account for synthetic may_goto edges from loop headers, and adds
backward condition tracking in bpf_compute_leave_conds() to identify
loop exits controlled by flags.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 525c0faff1a66..6a2ee407412b8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2780,6 +2796,7 @@ int bpf_compute_live_registers(struct bpf_verifier_=
env *env)
>  			u32 new_out =3D 0;
>  			u32 new_in =3D 0;
>  			u32 use;
> +			int t;
> =20
>  			succ =3D bpf_insn_successors(env, insn_idx);
>  			for (int s =3D 0; s < succ->cnt; ++s)
> @@ -2794,6 +2811,10 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
>  				use |=3D state[insn_idx + insns[insn_idx].imm + 1].in &
>  				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
>  			new_in =3D (new_out & ~live->def) | use;
> +			/* may_goto that is added at the head of a loop goes there */
> +			t =3D bpf_head_guard_target(env, insn_idx);
> +			if (t >=3D 0)
> +				new_in |=3D state[t].in;
>  			if (new_out !=3D live->out || new_in !=3D live->in) {
>  				live->in =3D new_in;
>  				live->out =3D new_out;

[Severity: High]
Does update_insn() need the same bpf_head_guard_target() edge for
backward stack-slot liveness (FM_LIVE_BEFORE)?

compute_subprog_args() now propagates stack pointers and spills across
bpf_head_guard_target(), and bpf_compute_live_registers() unions
state[t].in into new_in at the loop header, but update_insn() still
computes FM_LIVE_BEFORE only from normal CFG successors minus
must_write:

kernel/bpf/liveness.c:update_insn() {
	...
	for (s =3D 0; s < succ->cnt; ++s) {
		unsigned long *succ_live;

		succ_live =3D rel_mask(fm, relative_idx(instance, succ->items[s]), FM_LIV=
E_BEFORE);
		for (w =3D 0; w < fm->words; w++)
			new_after[w] |=3D succ_live[w];
	}
	...
	for (w =3D 0; w < fm->words; w++) {
		unsigned long new_before =3D (new_after[w] & ~must_write[w]) | may_read[w=
];
}

If a stack slot is initialized before the loop header, overwritten on
every normal path through the loop to the exit target t, and read at or
after t, FM_LIVE_BEFORE is cleared at the loop header.  When a state
arrives at the header in flow_arrive(), __clean_func_state() sees
bpf_stack_slot_alive() =3D=3D false, clears spilled_ptr to NOT_INIT, and
marks the slot STACK_POISON before check_loop_guard() delivers the state
along the head-guard edge to t.  Reads of that slot after t then fail
verification as reading a poisoned slot, or if the slot held a spilled
pointer before the header and a scalar on normal loop exits, join_slot()
at t can merge the poisoned slot with the scalar into STACK_INVALID when
allow_uninit_stack is set, allowing the spilled pointer bytes on the
may_goto path to be read as a scalar.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5faea922699af..62a58f38f4e22 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25268,6 +25268,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> +	/*
> +	 * It took the constants to remove dead branches and find the loops. No=
w it's known
> +	 * which edges the verifier may add, see bpf_head_guard_target(). What =
follows
> +	 * believes the constants.
> +	 */
> +	ret =3D bpf_flow_place_guards(env);
> +	if (ret > 0)
> +		ret =3D bpf_compute_const_regs(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
> +	ret =3D bpf_find_latches(env, true);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D bpf_compute_live_registers(env);
>  	if (ret < 0)
>  		goto skip_full_check;

[Severity: High]
Can re-running bpf_compute_const_regs() after bpf_flow_place_guards()
leave behind conditional jumps that bpf_prune_dead_branches() already
rewrote into unconditional jumps using constants that only hold on
normal loop exits?

Before bpf_compute_loops() and bpf_flow_place_guards() run, the first
bpf_compute_const_regs() pass has no head-guard edges, so a register (or
a read-only map load through it, as in the r7 =3D=3D &ro vs &rw case from
the commit message) that is constant on all normal exits to t is marked
constant at and after t.  bpf_prune_dead_branches() then permanently
overwrites conditional jumps testing that register at or after t in
env->prog->insnsi with BPF_JMP_A and recomputes postorder.  Re-running
bpf_compute_const_regs() after bpf_flow_place_guards() clears
const_reg_mask at t, but the in-place BPF_JMP_A rewrites remain in the
program, so a state taking the header may_goto to t will unconditionally
follow the branch decided for normal exits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D18
