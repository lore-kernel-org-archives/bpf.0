Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150344;
	b=Fj3idXR8oDOzKuc8VrZU16PhxN7Uet72AaEyLkptv+bbusLfrRXt+nIQ2Nvso193zhig
	 3NLxdvBaEfi4G7xF7YD4o5EA4+9EfehzljR+3Eyc45nGdK4aOiJonluBEFA0sT9N+tf7L
	 GK3f31E0Zn0J1bcJ6au/FmJvRSnaJiGfeIo95FAEOeww8XdFKX5XLomrwpA4XKWO0EMV2
	 ojWi4nVUM0sD4EbiiX8N4L8VD3be1ttrPUW03ZssVIUZf6VuSBmMV+75+MenDqxiD7D4F
	 fB0AdAJVGONxk+j1aF7A4HaPzRl5KNYo2OckqdWulWNmLy+eE5rt/E+EaWm7JMg6U/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WG8vgnxA41NzTKna0SA8drziUJt9ZTZjWpzkblwvleE=;
	b=mEOvsM77IJWl9Y/OtjuOaZ32DmYfa1T/yRyTczAFnRqHntQWeEI1npxIGM0bgrpG6CwC
	 oa/IBcDv67nKYxeA6Ihh8CNml7oG4joZbzO/fDlB8s8XWphLlWYqXLi1w3P0jf1pI+g9w
	 KNX3uxl9POA0be8pfMEu5dmAML+Ban8VIsx1LDzPAlgOUlPSFKZHu6/wVnWkM1MEzb0Nv
	 xw8GpdYlp3msMAGPMYKQDPNWrgUF7KTNRMNQG5i/UVi7heg3UWEgVDzWhUXf/4wcixyka
	 uwwcnILCc0ZL1JgRqfQPKWyqqTvyZBizouC6e9fFELpyuRIqvRTgsOnaSD9lx6WBFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUNRfjDF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04269606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUNRfjDF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC541F01825;
	Wed, 28 Oct 2026 01:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150343;
	bh=WG8vgnxA41NzTKna0SA8drziUJt9ZTZjWpzkblwvleE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NUNRfjDF8wAKiZUZrDOVY8Osg2NL57CBOb18YyohfYBidDbMHOvy+Wi09iAdSNICB
	 GrrV8plaK3385PPRs2LmhPds7qhfO2RxhMP4IUmH+IA7+jRjloWR6M2xY6USjxzkCJ
	 vtfR5E18cXnVhQvbEPQoYsR4M6d0SImgMwQ4u9dkQzfL6KjSwaPTbkoTXk9RJdQV/t
	 DP9SwxhXu6s+BFSYKoy7dcmZzF1rpWGuuMqam08FFm4Ru0WD4m/naeCuL3ZOv+rOk4
	 6DdhCubMeXvAyNRDTql+6osAGOAbPi6wwNBEBt10uiD+cPwFFQ7Xw56H/8SPSTR3An
	 BbC57drI45nlQ==
Message-ID: <sashiko-outbox-187310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 05/11] bpf: Let the callback of bpf_loop
 unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:19:03 +0000
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
- [Critical] bpf: inline_bpf_loop() emits dangling jump to dead unwind pad
- [Medium] bpf: clobbering of caller R2 in prepare_func_exit() on callback =
unwind
--

commit 342597e9c392b90ccb12e07eaf21a9e820d7f364
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let the callback of bpf_loop unwind

This commit adds an unwind landing pad to bpf_loop() using bpf_call_cb() and
bpf_unwind_leave(), and updates helper_has_cb_pad() so the verifier permits
bpf_loop() callbacks to unwind.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ac9dbe0821811..4b4d8479fa87b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11402,10 +11402,15 @@ static int btf_check_subprog_call(struct bpf_ve=
rifier_env *env, int subprog)
>  	return err;
>  }
> =20
> -/* The helper calls its callback with a pad, see bpf_call_cb(). None yet=
. */
> +/* The helper calls its callback with a pad, see bpf_call_cb() */
>  static bool helper_has_cb_pad(enum bpf_func_id func_id)
>  {
> -	return false;
> +	switch (func_id) {
> +	case BPF_FUNC_loop:
> +		return true;
> +	default:
> +		return false;
> +	}
>  }

[Severity: Critical]
When helper_has_cb_pad(BPF_FUNC_loop) returns true, can inline_bpf_loop() in
kernel/bpf/fixups.c emit a live BPF_JMP32_A instruction that jumps to a dead
landing pad which is subsequently removed by dead code elimination, or leav=
e a
stray BPF_UNWIND_GOTO after a load instruction?

In kernel/bpf/verifier.c:check_unwind_insns(), subprog_info[subprog].can_un=
wind
is set statically whenever the callback contains an unwind_exit instruction,
and check_cb_unwind() then requires an unwind_goto instruction at position =
+ 1
immediately after the bpf_loop() call.

If a privileged program calls bpf_loop() with flags =3D=3D 0 and a single c=
allback
target (so fit_for_inline is true), and the callback does not dynamically t=
ake
its unwind_exit path during verification of that call (for example, when
guarded by callback_ctx or loop index, or when nr_loops =3D=3D 0), state->u=
nwound
is never set at position + 1. In check_cond_jmp_op(), the unwind_goto branch
to the caller's landing pad (caller_pad =3D position + 2 + unwind_goto->off=
) is
never taken, leaving env->insn_aux_data[caller_pad].seen =3D=3D 0.

In kernel/bpf/verifier.c:bpf_check(), bpf_optimize_bpf_loop() runs before d=
ead
code elimination:

	if (ret =3D=3D 0)
		ret =3D bpf_optimize_bpf_loop(env);

	if (is_priv) {
		if (ret =3D=3D 0)
			bpf_opt_hard_wire_dead_code_branches(env);
		if (ret =3D=3D 0)
			ret =3D bpf_opt_remove_dead_code(env);

Inside kernel/bpf/fixups.c:inline_bpf_loop(), pad is computed without check=
ing
whether the target of unwind_goto at position + 1 was actually visited:

	bool pad =3D env->subprog_info[callback_subprogno].can_unwind &&
		   bpf_is_unwind_goto(&env->prog->insnsi[position + 1]);
	...
	if (pad) {
		struct bpf_insn *unwind_goto =3D &new_prog->insnsi[position + cnt];

		/* the jump of the pad, one insn before, takes the target of the unwind_g=
oto */
		new_prog->insnsi[position + cnt - 1].imm =3D unwind_goto->off + 1;
		/* and the unwind_goto after the call of bpf_loop follows no call anymore=
 */
		*unwind_goto =3D BPF_JMP_A(0);
	}

Because adjust_insn_aux_data() copies the call instruction's non-zero seen
count to all patched instructions, the inlined pad and its trailing
BPF_JMP32_A are marked seen !=3D 0. bpf_opt_hard_wire_dead_code_branches() =
does
not fold the inlined BPF_UNWIND_GOTO (its target is the inlined pad, which =
has
seen !=3D 0) and ignores the unconditional BPF_JMP32_A.

When bpf_opt_remove_dead_code() then deletes the unvisited caller_pad via
verifier_remove_insns() -> bpf_remove_insns() -> bpf_adj_branches() ->
bpf_adj_delta_to_off() in kernel/bpf/core.c:

	if (curr < pos && curr + off + 1 >=3D end_old)
		off +=3D delta;
	else if (curr >=3D end_new && curr + off + 1 < end_new)
		off -=3D delta;

BPF_JMP32_A's offset is not adjusted because its target falls inside the
removed range [pos, end_old). If caller_pad was at the end of the subprogra=
m,
func[i]->len shrinks while BPF_JMP32_A still jumps past the end of the
subprogram, causing out-of-bounds reads of addrs[i + insn->imm] in do_jit()=
 in
arch/x86/net/bpf_jit_comp.c and ctx->offset[bpf_insn + off] in
bpf2a64_offset() in arch/arm64/net/bpf_jit_comp.c, or jumping into post-ret=
urn
int3 padding or subsequent instructions.

Additionally, if the callback has can_unwind =3D=3D false and an unwind_goto
follows the bpf_loop() call (which check_unwind_insns() and check_cb_unwind=
()
allow), pad is false in inline_bpf_loop(), so *unwind_goto =3D BPF_JMP_A(0)=
 is
skipped, leaving BPF_UNWIND_GOTO immediately after BPF_LDX_MEM instead of a
call instruction when the landing pad is shared (seen !=3D 0) or !is_priv.

[Severity: Medium]
What happens in prepare_func_exit() in kernel/bpf/verifier.c when a bpf_loo=
p()
callback subprogram with a 9 to 16 byte BTF return type (ret_reg_pair =3D=
=3D true)
unwinds via unwind_exit?

In kernel/bpf/verifier.c:bpf_compute_subprog_ret_regs(), any static subprog=
ram
whose BTF return type has size in [9, 16] bytes gets ret_reg_pair =3D true,=
 and
neither check_func_args() nor btf_check_subprog_call() rejects such a
subprogram when passed as ARG_PTR_TO_FUNC.

With helper_has_cb_pad(BPF_FUNC_loop) now returning true, the
callee->in_callback_fn && unwinds path in prepare_func_exit() becomes
reachable:

	callee =3D state->frame[state->curframe];
	r0 =3D &callee->regs[BPF_REG_0];
	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
	for (i =3D 0; i < nregs; i++) {
		if (callee->regs[ret_regs[i]].type !=3D PTR_TO_STACK)
			continue;
		verbose(env, "cannot return stack pointer to the caller\n");
		return -EINVAL;
	}
	...
		for (i =3D 0; i < nregs; i++) {
			u32 regno =3D ret_regs[i];

			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
					   BPF_DIAG_MOD_WRITE);
			caller->regs[regno] =3D callee->regs[regno];
			bpf_diag_mod_end(env);
		}

Even though bpf_call_cb() in bpf_loop() only propagates R0 to the landing p=
ad,
prepare_func_exit() uses nregs =3D 2 (ret_regs =3D { BPF_REG_0, BPF_REG_2 })
without checking !callee->in_callback_fn.

First, because set_loop_callback_state() initializes the callback's R2 to
caller->regs[BPF_REG_3] (callback_ctx), passing a stack pointer as
callback_ctx causes the PTR_TO_STACK check on callee->regs[BPF_REG_2] to
falsely reject the unwind if the callback did not overwrite R2.

Second, prepare_func_exit() copies callee->regs[BPF_REG_2] into
caller->regs[BPF_REG_2] before setting *insn_idx =3D callee->callsite to re=
visit
the bpf_loop() call instruction. When check_helper_call() re-runs with
env->cur_state->unwound =3D=3D true, check_func_args() re-validates
caller->regs[BPF_REG_1..5] before caller-saved registers are scrubbed. Beca=
use
caller->regs[BPF_REG_2] (the callback_fn argument) was overwritten with the
callback's R2, could check_func_args() fail verification or update
meta.subprogno in update_loop_inline_state() to a different subprogram?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D5
