Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939194;
	b=t7ogDT72rNPx2kzwyvmzUzPAt2/7DqmTOh50//4nZnoEpZCkKhNShVx9dt83xuFBYWRJ
	 V0iNjnQFXZKMR6SjPe+a/xFVHoj31BpvAY1z91bS3Jbqx3JJm8WfG1eleDJBDNeA7C2VG
	 q1dTRaP70b20FStLTrjQz8SSdcgwMpYLtQ8KgrLgWr76vxEjEtXUIQ0i9I8LFWRPTBn9h
	 spd8vxoUmBwo/PUc4BXDkddRxezQymX4oa9Zg9io37YzbVH26dZZnpfuSNSm1gnGvaG/a
	 eAAF/8Qc/R2oG58YMardnov6ob4efG6gYM2nkcqfCbr2NYe9UgunLhXpSEQEoT8SoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1vcCAH6b6zre+Xzbwajcm0QD8cyEwAcsyiVrAU5UC+M=;
	b=xqpqc2a3ynCxioEZxi5wKX6+hiXWno4g4t3xvV0R2sfV4FxIfB+iK80U/15mcdg8zp2B
	 MbjySWGFQj/4sLZnUf2sih8qCCbDsYB/wzH2tkDiFfvrUKeVE5ZqMLE0n1CUgL6Y1R6tB
	 jPsED3ELmYjH/IgZdHT/v531DM9uoPsflX75xLxh/Ls8n2aiM/NUhC8ijGcnmf2/15XiL
	 jQ0WPabof07d63zdGhAUSGoiwq0IPnMO1QyMBZCQKn6NOGzZ0li1olsE49nWBttmvGYhs
	 WBMIAnVgdnArR9MJvRG/SZ5XFFhJgVqAJnKhDN+kPqP+OmZy2ZdrXo13R2VVhulDoBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiE0BruY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B6606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiE0BruY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A61F0089F;
	Fri,  6 Nov 2026 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939193;
	bh=1vcCAH6b6zre+Xzbwajcm0QD8cyEwAcsyiVrAU5UC+M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XiE0BruYMTKILZbbDEHhHV0ikgP0IB1UuVjl6R64B+i2c05bOtn72c00XExxmBM+Y
	 DgQqmgWXvb0+O1Cx8KY3TP9iopQzcjEVvBRf6oi1xjl1avi3vu7JV2Q08hTG+sTHSU
	 dNcXRT9AtuMmFwZTQKOZ3k4BfuisOTKd01TzeKhFX8xs67uG8vqmV32F1iCuiGe3Bi
	 qhwVyw16nV9OWg1PoYxCjktEub/Y37vT8QvBJZbcsBP/VAu0JH2dcwHHx84rD+WCNY
	 3+k474cqAIsx/MV+t/IxBxI3SVNtJ79sYJz3R8pgNbuwEn9v9eJ5Nq839dAsOTLZxz
	 uvwN7Hp1OJ1jw==
Message-ID: <sashiko-outbox-200719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 18/45] bpf: Tell the passes over the graph
 where an added may_goto goes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-19-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-19-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:26:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: missing head guard target edge in update_insn() stack liveness
- [High] bpf: bpf_prune_dead_branches() folds jumps before head guards are =
placed
--

commit dc67a790eecafbb6bb6ef2d65c1ca1f5bfcd6434
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Tell the passes over the graph where an added may_goto goes

This commit places loop guards right after loop discovery so pre-passes over
the control flow graph account for may_goto edges added at loop headers, and
extends bpf_edge_leaves_loop() to propagate constants when identifying loop
latches controlled by flags.

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
As reported by Sashiko on v2 [1], bpf_compute_live_registers() unions
state[t].in into new_in for t =3D bpf_head_guard_target(env, insn_idx), and
compute_subprog_args() joins the forward pointer and spill state from the
loop header into t, but does update_insn() in kernel/bpf/liveness.c also ne=
ed
to union FM_LIVE_BEFORE of t into new_before for stack slot liveness?

In bpf_compute_subprog_arg_access() -> analyze_subprog() ->
update_instance() -> update_insn(), backward stack liveness only inspects
normal CFG successors:

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
	...
}

If a stack slot in the current or caller frame is initialized before the
loop, overwritten (FM_MUST_WRITE) on every normal CFG path through the loop
to the exit t (or by the loop header instruction insn_idx itself), and then
read at or after t, update_insn() clears its liveness bit via ~must_write[w]
and leaves FM_LIVE_BEFORE as 0 at the loop header insn_idx.

When a verifier state reaches insn_idx during the main pass,
bpf_clean_verifier_state() -> clean_verifier_state() -> __clean_func_state()
sees bpf_stack_slot_alive() as false, resets spilled_ptr to NOT_INIT, and
marks the slot as STACK_POISON before the state is sent along the header
may_goto edge to t. Can that cause valid stack reads at or after t to be
rejected, or cause __clean_func_state() and join_slot() at t to mishandle
spilled pointers or uninitialized stack slots that were prematurely poisoned
at the loop header?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c89bf67a8424..5af42d2dcab94 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25219,6 +25219,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
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

[Severity: High]
When bpf_flow_place_guards() returns a positive value and bpf_check()
re-runs bpf_compute_const_regs(), what happens to conditional jumps at or
after a head-guard target that were already rewritten in-place by
bpf_prune_dead_branches() earlier in bpf_check()?

Earlier in bpf_check(), the first bpf_compute_const_regs() pass and
bpf_prune_dead_branches() run before bpf_compute_loops() and
bpf_flow_place_guards():

kernel/bpf/verifier.c:bpf_check() {
	...
	ret =3D bpf_compute_const_regs(env);
	if (ret < 0)
		goto skip_full_check;

	ret =3D bpf_prune_dead_branches(env);
	if (ret < 0)
		goto skip_full_check;
	...
}

At that point aux[h].guard_at_header is not yet set. If a register (or a
read-only map load derived from it, such as r7 =3D=3D &ro on normal exits v=
ersus
r7 =3D=3D &rw at the loop header) resolves to a constant at the exit target=
 t in
the first bpf_compute_const_regs() pass, bpf_prune_dead_branches()
permanently rewrites any conditional jump testing that constant at or after=
 t
into BPF_JMP_A(taken ? insn->off : 0) and recomputes the CFG postorder.

Re-running bpf_compute_const_regs() after bpf_flow_place_guards() clears
aux->const_reg_mask at t, but won't the in-place BPF_JMP_A instruction
rewrites in env->prog->insnsi remain in effect when a state jumps from the
loop header to t via may_goto?

[1] https://lore.kernel.org/r/20261105204513.2230344-19-alexei.starovoitov@=
gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D18
