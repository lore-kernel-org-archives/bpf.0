Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917141;
	b=amFgAeCjfBjH1o7JQRIFaOzKj/x9sRAmsonRGqlbGPJ+wuDn42n9rKYH50/4tFHJ2Po9
	 UFtNb93i6GNPcTCDaagLcC5CgLy9eEM/3V0RFgF5uH1lhsgr2VDeeeh8K5uWkc3hvm4JF
	 Q55meed0s7PjetlKCARP5Q5Ix2Way+vYw6GrHabzJLKdbOIpjSGqI3jsjYzH7+KPHCygV
	 B5fxfCUts8zkB/t1uzJuUUKSeNNZLWZgPs0Svod6pf5tM2fcWtzkJmr3FluADS7Hn7W3a
	 aCNLHannrhTZCEj2blhaBBMXwYlW3Fc9NMbv7sFP9asIv+7hAWARP9D60SnlEQkUF7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T0YLs6rMh4qoiZGEdfWv/cQKeSr5X9dhoRNVQzcBz8Q=;
	b=n9qFYDZEheMjmVDO7nYWSaIaOJDV9yeCXD2GrXdbQsC+J39x0coNpdqQzoppUCi9FH/i
	 CccHhHyIJ3cMRYVpUQazwjqFuibqoe+uJE5HLtNgxtGCmzxO9AXQMRwVZ2jd1zHMzDTqi
	 +mMU5C5Lf6Vx5evhkwMC9JvvKr8rVEWQri+IlElDxSQXgW03SnI/2VbVW9eNpo9k+LUL2
	 utGl1giScyX2AK5d9yV9dT+wYZQBy41nCSoSrrpBipEfi0lA+px2J8/u//iexrOl5qp0w
	 BZ3rQoWWVpUg6ZaQHoZ6sL7QNjUEf07Lp6FuulHKmH9B5gbCj4ohL8noXWaoXN4q4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz+gXFTv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E8606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz+gXFTv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5481F0089F;
	Thu,  5 Nov 2026 22:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917141;
	bh=T0YLs6rMh4qoiZGEdfWv/cQKeSr5X9dhoRNVQzcBz8Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vz+gXFTvRHAU+at5kTOquSWrx4Oq+mggVZjwtFKMHKPO/lWIOe42CuWZNoldBO2fL
	 HMg58/uzZlXm1xeRO31CkUAShmKQS1/LmaOW3h34qnCbISeBomd0M/q/rtBHlwnd0P
	 ScMtRnvjku5apslhSC30wMBUeupIZyVaDMPoSs7vwNcNvk8nyibIuH9odECk3KKWEu
	 WmiUHLasgdfrUfVBKcAT5bAkD5Hv1IXddR8mwrH7P+8/o8EVykhyw7WmhV8dPdwVp9
	 rh2BYltMzcncGwYGqEGI3jjkj2ebqQDqaNH7IhxDSmUhQ7RU7XFMRIDhz0dLaHHgEu
	 HsPml3MzzHa2w==
Message-ID: <sashiko-outbox-200300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/35] bpf: Tell the passes over the graph
 where an added may_goto goes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-19-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-19-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:19:00 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing head guard target edge in update_insn() stack liveness
--

commit 4a8572cac3df2db5693520d517c638b94138c076
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Tell the passes over the graph where an added may_goto goes

This commit runs bpf_flow_place_guards() earlier and teaches
bpf_compute_const_regs(), compute_subprog_args(), and
bpf_compute_live_registers() about the synthetic edge from a loop header to
bpf_head_guard_target() when a may_goto may be inserted at the loop header.

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
Should the stack-slot liveness pass in update_insn() also union
FM_LIVE_BEFORE of bpf_head_guard_target(env, insn_idx) into new_before, just
as bpf_compute_live_registers() does here for registers?

In kernel/bpf/liveness.c, bpf_compute_subprog_arg_access() ->
analyze_subprog() -> update_instance() -> update_insn() still computes
FM_LIVE_BEFORE using only the static CFG successors:

kernel/bpf/liveness.c:update_insn() {
    ...
	for (s =3D 0; s < succ->cnt; ++s) {
		unsigned long *succ_live;

		succ_live =3D rel_mask(fm, relative_idx(instance, succ->items[s]), FM_LIV=
E_BEFORE);
		for (w =3D 0; w < fm->words; w++)
			new_after[w] |=3D succ_live[w];
	}
	may_read =3D rel_mask(fm, rel, FM_MAY_READ);
	must_write =3D rel_mask(fm, rel, FM_MUST_WRITE);
	live_before =3D rel_mask(fm, rel, FM_LIVE_BEFORE);
    ...
	for (w =3D 0; w < fm->words; w++) {
		unsigned long new_before =3D (new_after[w] & ~must_write[w]) | may_read[w=
];
    ...
}

When a loop has guard_at_header set, bpf_insert_loop_guards() places may_go=
to
in front of the loop header insn_idx, jumping directly to
t =3D bpf_head_guard_target(env, insn_idx) before insn_idx or the loop body
executes.

If a stack slot is read at or after t (so FM_LIVE_BEFORE is set at t) and is
overwritten (FM_MUST_WRITE) on every normal path through the loop to t (or =
by
insn_idx itself), update_insn() clears its bit via ~must_write[w] and marks
the slot dead (FM_LIVE_BEFORE =3D=3D 0) before the loop header insn_idx.

When a verifier state arrives at insn_idx during the main pass,
flow_arrive() -> bpf_clean_verifier_state() -> clean_verifier_state() ->
__clean_func_state() sees bpf_stack_slot_alive() =3D=3D false and marks the=
 slot
as STACK_POISON (and resets spilled_ptr to NOT_INIT):

kernel/bpf/states.c:__clean_func_state() {
    ...
	for (i =3D 0; i < bpf_stack_nr_slots(st); i++) {
		bool lo_live =3D bpf_stack_slot_alive(env, frame, i * 2);
		bool hi_live =3D bpf_stack_slot_alive(env, frame, i * 2 + 1);

		if (!hi_live || !lo_live) {
    ...
			if (!hi_live) {
    ...
				bpf_mark_reg_not_init(env, spill);
			}
			for (j =3D start; j < end; j++)
				bpf_stack_slot(st, i)->slot_type[j] =3D STACK_POISON;
		}
	}
}

When check_loop_guard() -> bpf_flow_guard_edge() then propagates that state
from insn_idx to t, the slot arrives at t as STACK_POISON while
FM_LIVE_BEFORE is true at t.

Wouldn't this cause valid stack reads after the loop exit to be rejected wi=
th
"slot poisoned by dead code elimination", or cause a spilled pointer erased
to STACK_POISON at the loop header to merge with a scalar/zero slot from a
normal loop exit into STACK_INVALID in join_slot()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D18
