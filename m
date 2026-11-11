Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413573;
	b=sc3RGqin622kcV89elPKNbGQDvB9AIJRQGtm0uIfXZasCJV+DXMrBLkXSnDWqDg1t71R
	 CxkCnljcPJWsfJfKU6UblInxw31aR5ZrapZXZWN/kxAwqDg8HsUrw+JjkPaDbBtwQWSBV
	 pkM24qbH3X0GuBBrSwBSJw98Yq0lMpLKtE/xpJsjVCFA5IB/EN9/uLX76vjOWrel1V1u0
	 Mjbvsu2t/QTSuq/bBrqWHt8ALU2igcGzRIA/+ibgTKHiK+eC0bUtT6s3ZEe3i7srQ4Dqo
	 l4HaU1L7SIkBgyt2ytBGM49V0ECVvqmfnJUDgqcTnRY1vdIVkx4cl9dIrEY3HKLrRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dSVzSRb3fMtMH/5HnCdDino7pe0w8+fshMhiMPTrDfk=;
	b=YMF01XrsTw11DaxWa3Ht8w43/6qBM7TdCUh5/+AREhNfN9U4dHFca+exX9BR019UavqI
	 htkpieoIeHIjpk0adSXnJ5hscTNtGJgdxzG4LZZYOAN5CBZ5JAKgeUvYmJ1Uucg4eO86w
	 tLWG4ZIsBzSsYxGrEZCZREOByNlI6DLdwoFflSJ9ER1o7JhsTOva9HwRID1mEiB5qvt7N
	 ibZaF5v0yFUcSQ4b+mW/7UJ9I4JQN4/EvR2SHxC7jFkyriKWRDzGgHuYWd0RALO4ye/kz
	 m2Go4wmIrGMGwnpTALD9BC2wWeE5Kwi2BrrbeOiz2mdoMfNsGcedyel6vtEWxDy6K1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIrBXKRU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B87606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIrBXKRU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A275C1F00A06;
	Wed, 11 Nov 2026 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413572;
	bh=dSVzSRb3fMtMH/5HnCdDino7pe0w8+fshMhiMPTrDfk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GIrBXKRUOFwi0SRdZDXwBL457Ne/62vN9OGpIop3fx3PLQjLoX7EWBPgimtAGX/wX
	 WPZANV2EPSMpGbeKo2siqBi6TL3li/6BHGMf89QUvYNX4H0QRoZELvj59acTZtnGLU
	 FTsTiVj8bepaUBwSXIQYJObjv8vORnnMPUnRMXTiAQm4f0AWeNqHiFJXV77zyvELNV
	 +6M8ncicIJkW7WInSUI/70OGLn3wjTrbalmgr2fNMti1+E+J46LmCZEw3fEvB+9geY
	 a+z5jcjObzFEQpjlkg66iy+AwFK/t2btYKJeDGfmcFIl8G9tY1NzLVMwgsiOIpJ39k
	 9SZL7m0oTGVbQ==
Message-ID: <sashiko-outbox-209264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 13/29] bpf: Track held resources in hidden
 stack slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <0b8d0a69ecb9f74ed3e3645bc7dccbc022a83cc2.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <0b8d0a69ecb9f74ed3e3645bc7dccbc022a83cc2.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:12:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] bpf: emit_entries() hides arena stack adjustment from recursion
  check
- [High] bpf: RCU iterator outlives section when subprog unlocks and
  throws
- [High] bpf: double-free on unwind due to wrong slot cleared in
  emit_release()
- [High] bpf: non-LIFO lock unwind in bpf_frame_desc_build() corrupts
  IRQ and lock state
- [High] bpf: hidden slot overwritten when subprog call returns NULL in
  frame_desc
- [Medium] bpf: duplicate check_max_stack_depth() inflates recursive
  frame depth
--

commit 197c825766b69a79fd4f8ec64eb1bed1f952135c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track held resources in hidden stack slots

This commit tracks held kernel resources, locks, and RCU or preemption
sections in hidden stack slots and builds per-subprogram frame descriptors =
so
bpf_throw() can release them during unwinding.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> new file mode 100644
> index 0000000000000..b0db3feeb9b0f
> --- /dev/null
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bp=
f_verifier_state *st,
> +				 int idx, int callsite, const struct bpf_reg_state *r0)
> +{
> +	struct bpf_reference_state *ref;
> +	s16 adj =3D 0;
> +	int acq;
> +
> +	if (!env->describe_frames || st->speculative)
> +		return 0;
> +	ref =3D idx < 0 ? NULL : &st->refs[idx];
> +	if (!ref || !ref->res) {
> +		if (r0->type !=3D SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
> +			env->insn_aux_data[callsite].res_none =3D true;
> +		return 0;
> +	}

[Severity: High]
Can a second call at the same callsite that returns NULL overwrite a live
handle in the callsite's hidden stack slot?

emit_acquire_after() unconditionally stores R0 into the callsite's slot
after every return.  If a subprog can return either an acquired reference or
NULL (R0 =3D=3D 0, idx < 0), and the caller invokes that callsite a second =
time
while still holding the reference from the first call,
bpf_frame_desc_record_return() returns 0 without checking whether st->refs[]
already holds a reference from that callsite.  At runtime, the second return
writes 0 into the hidden slot, so a later bpf_throw() sees NULL and leaks t=
he
object from the first call.

[ ... ]

> +static int emit_release(struct bpf_verifier_env *env, struct bpf_insn *b=
uf,
> +			const struct res_item *it, int n)
> +{
> +	const struct bpf_res_rel *r =3D &env->res_rels[it->rec];
> +	int i, cnt =3D 0, reg =3D r->reg, per =3D r->adj ? 5 : 4;
> +
> +	if (r->flags & BPF_RES_F_DEREF) {
> +		buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, r->reg, 0);
> +		reg =3D BPF_REG_0;
> +	}
> +	for (i =3D 0; i < n; i++) {
> +		s16 off =3D env->res_acqs[env->res_rels[it[i].rec].acq].off;
> +		bool last =3D i =3D=3D n - 1;
> +
> +		buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_FP, off);
> +		if (r->adj)
> +			buf[cnt++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, r->adj);
> +		buf[cnt++] =3D BPF_JMP_REG(BPF_JNE, BPF_REG_AX, reg, last ? 1 : 2);
> +		buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP, off, 0);
> +		/* past the slots that follow: the last one has no jump */
> +		if (!last)
> +			buf[cnt++] =3D BPF_JMP_A((n - 1 - i) * per - 1);
> +	}
> +	return cnt;
> +}

[Severity: High]
Can emit_release() clear the wrong hidden slot when a frame holds two
references to the same underlying pointer?

Suppose a frame acquires a =3D bpf_obj_new(...) (acq 0, slot0) and
b =3D bpf_refcount_acquire(a) (acq 1, slot1), so both slots hold the same
pointer value p.  If a first release call R_A takes a on one path and b on
another, R_A is recorded with both acq 0 and acq 1.  On the path that passes
b to R_A and then passes a to a second release call R_B, the verifier remov=
es
b's ref at R_A and records only acq 0 at R_B.

At runtime on that path, R_A checks slot0 first, sees slot0 =3D=3D p, clears
slot0, and jumps past slot1.  R_B then only checks slot0 (already 0), leavi=
ng
p in slot1 after both references have been dropped, so a subsequent
bpf_throw() releases p a third time and causes a double free or refcount
underflow.

[ ... ]

> +static int emit_entries(struct bpf_verifier_env *env)
> +{

[ ... ]

> +		for (k =3D 0; k < ARRAY_SIZE(sub->section_off); k++)
> +			if (sub->section_off[k])
> +				buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP, sub->section_off[k], 0=
);
> +		if (!cnt)
> +			continue;
> +		ret =3D bpf_patch_list_insert(env, sub->start, buf, cnt);
> +		env->frame_desc_insns +=3D cnt;
> +	}
> +	ret =3D ret ?: bpf_patch_list_commit(env);

[Severity: High]
Does inserting slot-zeroing instructions at sub->start hide a recursive
subprog's arena stack adjustment from bpf_insert_recursion_checks()?

bpf_frame_desc_emit() runs before bpf_insert_recursion_checks() and commits
the prologue stores at sub->start, which moves sub->start in front of the
subprog's leading is_arena_sp_adj() instruction:

kernel/bpf/fixups.c:bpf_insert_recursion_checks() {
    ...
		/* The exit drops the frame in the stack in arena. Take it before the che=
ck. */
		if (is_arena_sp_adj(&env->prog->insnsi[si[s].start])) {
			buf[n++] =3D env->prog->insnsi[si[s].start];
    ...
}

Because si[s].start is now a BPF_ST_MEM instruction instead of
is_arena_sp_adj(), bpf_insert_recursion_checks() does not hoist the arena
frame allocation ahead of the recursion check's bailout exit (and also looks
up live_regs_before at the wrong offset).  bpf_insert_arena_stack() still
prepends r12 -=3D arena_stack_depth to every BPF_EXIT in the subprog, inclu=
ding
the bailout exit, so hitting the recursion or may_goto budget check decreme=
nts
BPF_REG_ARENA_SP without the matching entry increment and corrupts the
caller's arena stack pointer.

[ ... ]

> +int bpf_frame_desc_build(struct bpf_verifier_env *env)
> +{

[ ... ]

> +		for (i =3D 0; i < 2 * env->res_acq_cnt; i++) {
> +			const struct bpf_res_acq *a =3D &env->res_acqs[i % env->res_acq_cnt];
> +			bool first =3D i < env->res_acq_cnt;
> +
> +			if (acq_subprog(env, a, new_of) !=3D s ||
> +			    resource_goes_first(&env->resources[a->res]) !=3D first)
> +				continue;
> +			d->ent[d->nent++] =3D (struct bpf_frame_desc_entry) { .res =3D a->res=
, .off =3D a->off };
> +		}

[Severity: High]
Should bpf_frame_desc_build() emit lock and IRQ flag entries in reverse
acquisition order?

d->ent[] is populated in forward env->res_acqs[] order, and
bpf_unwind_release_frame() walks d->ent[] forward during
BPF_UNWIND_PHASE_LOCKS.  If a frame entered with interrupts enabled calls
bpf_spin_lock() (saving IF=3D1 in per-CPU irqsave_flags and disabling IRQs),
then calls bpf_res_spin_lock_irqsave() (saving IF=3D0 into the stack flag s=
lot),
and throws, pass 0 of BPF_UNWIND_PHASE_LOCKS first runs bpf_spin_unlock(),
which restores IF=3D1 while the resilient spinlock is still held, and then =
runs
bpf_local_irq_restore() on the stack slot (since arch_irqs_disabled_flags()
is true, late is false), leaving local CPU interrupts disabled during sleep=
ing
destructors in BPF_UNWIND_PHASE_OBJS and after bpf_throw() returns.

When a frame holds two nested resilient spinlocks, unlocking them in forward
order also pops the wrong entry in res_spin_unlock() (which clears
rqh->locks[rqh->cnt - 1]), corrupting the per-CPU held-lock stack.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cf3cfc734ed4d..4d85a42a18d5f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11232,21 +11321,34 @@ static void invalidate_non_owning_refs(struct b=
pf_verifier_env *env)
>  	}));
>  }
> =20
> -static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
> +static int invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
>  	u32 clear_mask =3D (1 << STACK_SPILL) | (1 << STACK_ITER);
> +	bool iter =3D false;
> =20
>  	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clea=
r_mask, ({
>  		if (reg->type & MEM_RCU) {
> +			iter |=3D stack && stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_IT=
ER;
>  			bpf_diag_mod_begin(env, reg, NULL, BPF_DIAG_MOD_WRITE);
>  			reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL | NON_OWN_REF);
>  			reg->type |=3D PTR_UNTRUSTED;
>  			bpf_diag_mod_end(env);
>  		}
>  	}));
> +	/*
> +	 * Nothing may destroy an RCU protected iterator once its section ended:
> +	 * not the program, which is refused when it leaks one, and not the
> +	 * unwinder, which destroys what a frame holds at a throw, see
> +	 * frame_desc.c.
> +	 */
> +	if (iter && env->describe_frames) {
> +		verbose(env, "an RCU protected iterator may not outlive its section in=
 a program that throws\n");
> +		return -EINVAL;
> +	}
> +	return 0;
>  }

[Severity: High]
Does this miss RCU-protected iterators on caller frames when a subprog is
verified on its own and calls bpf_rcu_read_unlock() followed by bpf_throw()?

When call_func_on_its_own() verifies a subprog, the caller frames are not in
env->cur_state->frame[], so bpf_for_each_reg_in_vstate_mask() does not see a
caller's STACK_ITER slot (while env->cur_state->refs[] carries the inherited
iterator reference with frameno =3D=3D -1).  If the subprog then calls
bpf_throw() instead of returning normally, process_bpf_exit_full() skips
exit_func_on_its_own(), so bpf_frame_desc_record_exit() never checks
rcu_released_below and bpf_flow_return() never sets releases_inherited.  The
subprog can then drop the caller's RCU lock (and sleep in a sleepable prog)
before throwing, causing the unwinder to destroy the caller's RCU-protected
iterator after its RCU section has ended.

[ ... ]

> @@ -25600,6 +25809,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	if (ret =3D=3D 0)
>  		ret =3D check_max_stack_depth(env);
> =20
> +	/*
> +	 * The pass has seen what every frame holds and the stack is final:
> +	 * reserve the slots the frames keep their handles in and emit the insns
> +	 * that keep them up to date, with the insns still those the main pass
> +	 * recorded.
> +	 */
> +	if (ret =3D=3D 0)
> +		ret =3D bpf_frame_desc_resolve(env);
> +	if (ret =3D=3D 0)
> +		ret =3D bpf_frame_desc_emit(env);
> +
> +	/* Account for the slots reserved by frame descriptor resolution. */
> +	if (ret =3D=3D 0)
> +		ret =3D check_max_stack_depth(env);

[Severity: Medium]
Does calling check_max_stack_depth() both before and after
bpf_frame_desc_resolve() inflate stack_depth for recursive subprogs that use
the arena stack?

During the first check_max_stack_depth() call, pad_recursive_frames()
overwrites si[s].stack_depth in place with max(si[s].stack_depth, frame).
bpf_frame_desc_resolve() -> bpf_reserve_stack_slots() then reserves hidden
slots on top of that already-padded stack_depth instead of the verified sta=
ck
depth, which can push stack_depth past env->stack_limit on the second
check_max_stack_depth() call and cause false verifier rejections.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D13
