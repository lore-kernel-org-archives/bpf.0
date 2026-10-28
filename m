Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151109;
	b=uxVMaaWi9W0LKwlLQMGu+HYSMA1vnXTmalqenEeJM1myivMBib5+RkZTggyLuE64Urte
	 UwHLQvvzJSLbnnwPB6hB+ybYDhg43HyzII0/OVlQYjQkgT1qMFuO1OqL/5JThHGRkwbRy
	 LCMpqqBSWxetvoW58rerJ7MV4ry/64qWdPdJHu9jlMNDC7bK4ksC7Z3wVefhnnHxSe7u8
	 fj6P9q3ngoGo08qd88bRl0RYKWFrqIcyigwoJpEa62zkopptltZYcs9XXHIHk7jHenV/D
	 wmcSW7k3D30d/EMJBpi5rnrkS9RlB2INaogoBA51pkZ07Z2ofso0BD04MMdBda8rhpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ismksdJxi4Tqj8K5ibFN07MrD5fTK/T56anopTcOSI=;
	b=jCe0XAbbeSyU3RtI1YP+QiHXDlW0q5zWh1NUcyvyFbyB0GjvTsg5muDSefSPC53OhG3Y
	 a+PC5/+FAj1qu8lF6ICJIAaggxHSusy5s70UboRWkye2YaMNuXKssP7n9kCqXiftpU9Fp
	 Z89mX0Yl3MHYLVVgHXEzz1VLfxCb2Kyevu9+3dHwcMtwvyRSZQffECwaaPQ+na9NJ4PSt
	 +sFkhd+q+tpjA/E2Z9/3iLUkcfj/UPe1fVUN63xZqMSU/LiXcXgqk1GAWum6FBFvRaq4q
	 TYth3iD+RSSOh8j+UfOQ+SbR5aWLQv7p564Z1lT+hG9/FEPjjVySqc66QyF446DNwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ0PYKu2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E722606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ0PYKu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4911F01825;
	Wed, 28 Oct 2026 01:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151108;
	bh=3ismksdJxi4Tqj8K5ibFN07MrD5fTK/T56anopTcOSI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SZ0PYKu2Na63mPxQs2qGNB+LGFy9eRNd7u+H1+7qa7trzcezGumlYodiG3zreiQ0+
	 YJOqG7Zw5Fc8ruYaXPEEgv1unQpaFCO/MgsCQgC/Ex3To6M/6Fe7azM8G0VQKGtTYS
	 EJ7yUic+YwumW7QXUBNaJivrq6ih6XfwMQyS5hpRngq6J++0njNKyASwmNY112+hQI
	 aopKvrr9s2e8EdozQO5Ol9+auiJsc1YcePLKhOjL6Wfx+u/lsQkqLmDZ4jX09bBKrg
	 cJJ+2d9bdogM1X9A07+wsnTzvmeSbmBQfsbaoDrxbwsgiYpNH1yTl8IL83bHUckEfq
	 tjPvOXGxQ+ezw==
Message-ID: <sashiko-outbox-187317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Let a callback unwind into
 the pad of its helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:31:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: prepare_func_exit() clobbers caller R2 on ret_reg_pair cb unw=
ind
- [Medium] bpf: verifier_bug_if() in do_check() when callback unwinds with =
const R0
- [Medium] bpf: inline_bpf_loop() leaves unwind_goto after BPF_LDX_MEM when=
 callback cannot unwind
--

commit 00033d1866979957f9c4c976952ca2e9b1a444c5
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let a callback unwind into the pad of its helper

This commit extends the BPF verifier to allow synchronous callbacks invoked=
 by
helpers or kfuncs to exit via unwind_exit into an unwind pad following the
helper or kfunc call. Upon unwind_exit, the verifier revisits the callsite
with the callback's R0 preserved so helper effects are applied before
proceeding to the unwind_goto instruction. It also updates register liveness
and precision backtracking to account for R0 flowing from the callback acro=
ss
the call.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..ac9dbe0821811 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10,6 +10,7 @@
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/bpf.h>
> +#include <linux/bpf_unwind.h>
>  #include <linux/btf.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/filter.h>
> @@ -3435,6 +3436,8 @@ static int next_callx_callee(struct bpf_verifier_en=
v *env, int caller, int from)
>   * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind=
_exit.
>   * JITs don't emit a branch for it. unwind_exit finds the pad by its ret=
urn
>   * address. So unwind_goto has to follow the call and nothing may jump t=
o it.
> + * The call may be of a helper or a kfunc that calls a callback: it leav=
es like
> + * the callback did, see check_cb_unwind().
>   */
>  static int check_unwind_insns(struct bpf_verifier_env *env)
>  {
> @@ -3450,8 +3453,10 @@ static int check_unwind_insns(struct bpf_verifier_=
env *env)
>  		if (!bpf_is_unwind_goto(insn))
>  			continue;
>  		seen =3D true;
> -		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1))) {
> -			verbose(env, "unwind_goto at insn %d doesn't follow a call of a subpr=
og\n",
> +		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1) ||
> +			    bpf_is_sync_callback_calling_insn(insn - 1))) {
> +			verbose(env,
> +				"unwind_goto at insn %d doesn't follow a call of a subprog or of a h=
elper with a callback\n",
>  				i);
>  			return -EINVAL;
>  		}

[Severity: Medium]
What happens when unwind_goto follows a call to bpf_loop() that gets inlined
by bpf_optimize_bpf_loop() -> inline_bpf_loop(), but the callback does not
unwind (!env->subprog_info[subprog].can_unwind)?

Here check_unwind_insns() permits unwind_goto after any
bpf_is_sync_callback_calling_insn(insn - 1), and check_cb_unwind() returns 0
when !env->subprog_info[subprog].can_unwind.

When bpf_loop() is inlined in kernel/bpf/fixups.c:inline_bpf_loop() (both h=
ere
and after the later commit "bpf: Give the inlined bpf_loop a pad" when
!can_unwind):

	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
	insn_buf[cnt++] =3D BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JA, 0, 0, 16);
	...
	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);

the call instruction is replaced with 19 instructions ending in BPF_LDX_MEM
without converting the trailing unwind_goto into BPF_JMP_A(0), and the
BPF_JMP_IMM(BPF_JA, 0, 0, 16) instruction jumps directly to that unwind_got=
o.

If the target of that unwind_goto was marked seen during verification (for
example, a shared pad or unwind_goto with offset 0) or when !is_priv,
bpf_opt_hard_wire_dead_code_branches() leaves the unwind_goto instruction in
place:

	if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen) {
		if (!aux_data[i + 1].seen) {
			memcpy(insn + 1, &trap, sizeof(trap));
			aux_data[i + 1].seen =3D env->pass_cnt;
		}
		continue;
	}

Wouldn't this leave unwind_goto immediately after BPF_LDX_MEM instead of a
call instruction (and targeted by a jump), violating the JIT invariant in
arch/x86/net/bpf_jit_comp.c and arch/arm64/net/bpf_jit_comp.c (including the
x86-64 priv_frame_ptr path that assumes insn[i - 1] is a call ending in pop=
 r9
and keys the exception table at addrs[i - 1] - 2)?

Conversely, in the later commit "bpf: Give the inlined bpf_loop a pad", if
can_unwind is true for the callback subprog, but R1 (nr_loops) is known to =
be
0 at the bpf_loop() callsite, check_helper_call() skips push_callback_call()
so the unwind pad is never verified. Yet inline_bpf_loop() sees
subprog_info[callback_subprogno].can_unwind && bpf_is_unwind_goto(insn + 1)
and emits an inlined pad jumping via BPF_JMP32_A to an unverified pad that
bpf_opt_remove_dead_code() then strips.

Should inline_bpf_loop() rewrite a trailing unwind_goto to BPF_JMP_A(0) when
the callback does not unwind during the call, or only emit the pad when the
unwind_goto target was actually verified?

[ ... ]

> @@ -12111,12 +12178,16 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
>  	}
> =20
>  	caller =3D state->frame[state->curframe - 1];
> -	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
> -		/* the helper or the kfunc that called it doesn't expect that */
> -		if (callee->in_callback_fn) {
> -			verbose(env, "callback cannot unwind\n");
> -			return -EINVAL;
> -		}
> +	unwinds =3D bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]);
> +	if (unwinds) {
> +		/*
> +		 * A callback returns into the helper that called it, and to the
> +		 * pad of the helper when the helper has one. check_cb_unwind()
> +		 * has seen to that, and to the unwind_goto after the call of
> +		 * the helper, where the helper leaves to right away, with the
> +		 * r0 of the callback as it is: the pad gets its state, as the
> +		 * pad after a subprog call does.
> +		 */
>  		if (!bpf_is_unwind_goto(&env->prog->insnsi[callee->callsite + 1])) {
>  			verbose(env, "unwind_exit, but no unwind_goto after the call at insn =
%d\n",
>  				callee->callsite);
> @@ -12124,7 +12195,7 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>  		}
>  		state->unwound =3D true;
>  	}
> -	if (callee->in_callback_fn) {
> +	if (callee->in_callback_fn && !unwinds) {
>  		if (r0->type !=3D SCALAR_VALUE) {
>  			verbose(env, "R0 not a scalar value\n");
>  			return -EACCES;

[Severity: High]
Can a callback with a 9..16 byte BTF return type clobber the caller's R2
argument register when it exits via unwind_exit?

In bpf_compute_subprog_ret_regs(), ret_reg_pair is set for any static subpr=
og
whose BTF return type is 9..16 bytes, and btf_check_subprog_call() in
push_callback_call() does not reject this for callbacks. At the top of
prepare_func_exit():

	callee =3D state->frame[state->curframe];
	r0 =3D &callee->regs[BPF_REG_0];
	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;

When callee->in_callback_fn && unwinds is true, prepare_func_exit() now tak=
es
the else branch:

	} else {
		/*
		 * return to the caller whatever the callee had in the
		 * return register(s)
		 */
		for (i =3D 0; i < nregs; i++) {
			u32 regno =3D ret_regs[i];

			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
					   BPF_DIAG_MOD_WRITE);
			caller->regs[regno] =3D callee->regs[regno];
			bpf_diag_mod_end(env);
		}
	}

If nregs =3D=3D 2, this copies callee->regs[BPF_REG_2] into
caller->regs[BPF_REG_2] before redirecting *insn_idx back to callee->callsi=
te.

When the verifier revisits the call instruction at callee->callsite,
check_helper_call() or check_kfunc_call() re-runs argument validation and s=
ide
effects using the overwritten caller->regs[BPF_REG_2]. In particular, for
bpf_rbtree_add_impl(root, node, less, ...), R2 is the owning reference to t=
he
node being added:

	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta.f=
unc_id)) {
		id =3D regs[BPF_REG_2].id;
		insn_aux->insert_off =3D regs[BPF_REG_2].var_off.value;
		insn_aux->kptr_struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.ar=
g_btf_id);
		ref_convert_owning_non_owning(env, id);
	}

If the callback places a different allocated node pointer in its R2 before
unwind_exit, wouldn't the revisit of check_kfunc_call() release the wrong
reference ID in the verifier while bpf_rbtree_add_impl() drops the original
node at runtime, leaving a dangling owning reference to the freed original
node in the caller's unwind pad?

Should nregs be forced to 1 when callee->in_callback_fn is true (or should
callbacks with ret_reg_pair be rejected)?

[ ... ]

> @@ -20589,7 +20692,8 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
> =20
>  		if (bpf_is_jmp_point(env, env->insn_idx)) {
> -			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
> +			err =3D bpf_push_jmp_history(env, state, state->unwound ? INSN_F_UNWO=
UND : 0,
> +						   0, 0, NULL, 0);
>  			if (err)
>  				return err;
>  		}

[Severity: Medium]
Can revisiting the call instruction with state->unwound set trigger
verifier_bug_if() in do_check()'s precomputed constant register check?

Before do_check() runs, bpf_compute_const_regs() computes intraprocedural
constant register values at each instruction. If the caller holds a known
32-bit constant C1 in R0 before a callback-calling helper or kfunc instruct=
ion
(for instance, r0 =3D 0; call bpf_loop; unwind_goto +pad;),
bpf_compute_const_regs() sets BIT(BPF_REG_0) in
insn_aux->const_reg_mask and records C1 in
insn_aux->const_reg_vals[BPF_REG_0].

When the callback unwinds with a different constant scalar C2 in R0,
prepare_func_exit() sets state->unwound =3D true, copies C2 into
caller->regs[BPF_REG_0], and sets *insn_idx =3D callee->callsite. On the re=
visit
of the call instruction in do_check(), just below this hunk:

		/* Sanity check: precomputed constants must match verifier state */
		if (!state->speculative && insn_aux->const_reg_mask) {
			struct bpf_reg_state *regs =3D cur_regs(env);
			u16 mask =3D insn_aux->const_reg_mask;

			for (int r =3D 0; r < ARRAY_SIZE(insn_aux->const_reg_vals); r++) {
				u32 cval =3D insn_aux->const_reg_vals[r];

				if (!(mask & BIT(r)))
					continue;
				if (regs[r].type !=3D SCALAR_VALUE)
					continue;
				if (!tnum_is_const(regs[r].var_off))
					continue;
				if (verifier_bug_if((u32)regs[r].var_off.value !=3D cval,
						    env, "const R%d: %u !=3D %llu",
						    r, cval, regs[r].var_off.value))
					return -EFAULT;
			}
		}

Because regs[BPF_REG_0] now holds the callback's unwound constant C2 rather
than the caller's pre-call constant C1, wouldn't this fire verifier_bug_if()
and fail verification with -EFAULT unless BPF_REG_0 is skipped when
state->unwound is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D3
