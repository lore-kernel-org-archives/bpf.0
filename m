Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522642;
	b=0SwHORicuIphR9kmA1pE6lz9DbelLjaVBCW3sQl9mS6v047EepRGxsb4lpHdb4s8QcJV
	 fIACCm0+pX7IGyrlstvRRAozm+nz9anZCtbkitqxa3jUCD6FtXyzLRLKQfehleH0bhkG/
	 6GblXw7xW0kBpraHOWWXuFe1Idz7tT+OhWyUVFfOTu1lLMiHgr5aQ/eJGCPefBlSwvDzn
	 gYt6RMbUUN+d1whjmBgxa1YygsB5GoTwNhoCuVtqk699UkfuddnOBhLuJvbiv/KXzwtxi
	 xGyGR/Tp4dlGWuL4irVoasM/1SmcEgspMgdc/bTbshk/FB88vjbYSAPwoHeUFCMRpVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yeNfD1r7O2zaFVbXoyVgtwFroKZCpG00rRZEDp5qZSk=;
	b=aZQ8mumfq/uau56UItu11vS3A8te4mPuE5GiXm0Tk1f2hGX4Ahfcj3Df7XS3sBL9WFQs
	 NElMoeBPi24cKUhXIf5pgFHaWCXpEiIl69IDhrNQLt4qbpezcXVj9ymKDC87InYzxnQXJ
	 RpMm+hCsweFkvoPF9y12xhjOvleYDmoMr7V94aWcEGKzdYz2qr9B/yRh5QaR4hRnwErN4
	 2yBVER9N/aVqgqpJqecAl6gGgV6rGNl4QdgFM9Pve6cQxChReC8TBWxSnnkAyGC2RiekD
	 EPsf3QGpvIc395cgswV7hOJ5v2v0+AafUjlcgJ9qpPuvX9fLm3KZbxC4vAN1LyPEqOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIjDaGXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309E606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIjDaGXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBAC1F000C9;
	Tue, 20 Oct 2026 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522641;
	bh=yeNfD1r7O2zaFVbXoyVgtwFroKZCpG00rRZEDp5qZSk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FIjDaGXxutye5VLfSzqgjnOaGCw2HVcUI6aqvHTDxbeKNDaD7WHxitay1tZwgD2oL
	 VpzbAKhnNnakGLx7tc0cuV6n5hz8wennSVOZrT28Ykf+lysbj+ZwBN50HLMBaAisnA
	 795N1xX0ZOadYT7vnfMTOycaDATzq9UfFEPwWASeLxvPlTBSL4INnSk8dJByAnu7KF
	 fw+sW9BfVZ810E1XPdBmyXatY0O/0zJjsRzwH5pZjRPAY5IOonqvOEitrSZ/lnn2wa
	 3uMxC/SeU8NIds+u0903dYZc4l/6lzRkbIUav2FPmw8zat+BZiQ5y5mBQlG2F2xkxH
	 Nm6A5zUjufYTQ==
Message-ID: <sashiko-outbox-179499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 1/6] bpf: Add unwind_goto and unwind_exit
 insns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020181320.1284798-2-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
 <20261020181320.1284798-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:57:21 +0000
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
- [High] bpf: stale insn_aux_data and unvisited unwind_goto handling in bpf=
_opt_hard_wire_dead_code_branches()
- [Medium] bpf: missing jit_requested and offload checks in check_unwind_in=
sns()
--

commit d6e6c3108f32eea3c296a97e0da89132803476f1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add unwind_goto and unwind_exit insns

This patch introduces the BPF_UNWIND_GOTO and BPF_UNWIND_EXIT instructions
to support stack frame unwinding in BPF programs without extra register
overhead or stack walking. It adds verifier tracking, dead-code branch
fixups, and disassembler and dump support for the new instructions.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 409b9104c723e..f062ef7dd943d 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -658,6 +658,7 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_=
verifier_env *env)
>  {
>  	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
>  	struct bpf_insn ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +	struct bpf_insn trap =3D BPF_JMP_IMM(BPF_JA, 0, 0, -1);
>  	struct bpf_insn *insn =3D env->prog->insnsi;
>  	const int insn_cnt =3D env->prog->len;
>  	int i;
> =20
> @@ -666,6 +667,20 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf=
_verifier_env *env)
>  		if (!bpf_insn_is_cond_jump(insn->code))
>  			continue;
> =20
> +		if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen) {
> +			/*
> +			 * The callee never exits. Its unwind_exit needs
> +			 * unwind_goto all the same, and the cpu predicts that it
> +			 * returns to what follows. Don't let the removal of dead
> +			 * code put something else there.
> +			 */
> +			if (!aux_data[i + 1].seen) {
> +				memcpy(insn + 1, &trap, sizeof(trap));
> +				aux_data[i + 1].seen =3D env->pass_cnt;
> +			}
> +			continue;
> +		}

[Severity: High]
When bpf_opt_hard_wire_dead_code_branches() overwrites insn + 1 with trap a=
nd
marks aux_data[i + 1].seen =3D env->pass_cnt, could stale flags in
aux_data[i + 1] corrupt the trap instruction or trigger a verifier bug?

Before do_check_main() and do_check_subprogs() run,
bpf_compute_live_registers() sets insn_aux[i + 1].zext_dst =3D true on the
static CFG if the original instruction at i + 1 defines a 32-bit subregister
whose upper half is live out:

kernel/bpf/liveness.c:bpf_compute_live_registers() {
	...
	for (i =3D 0; i < insn_cnt; ++i) {
		int def32 =3D bpf_insn_def32(env->prog, &insns[i]);
		u32 out =3D state[i].out;
		u32 in =3D state[i].in;

		insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32));
	}
}

In addition, when !env->bypass_spec_v1 is true, check_cond_jmp_op() calls
sanitize_speculative_path(env, NULL, *insn_idx + 1, *insn_idx) for
unwind_goto. That speculative walk leaves aux_data[i + 1].seen as 0 via
sanitize_mark_insn_seen(), while do_check_insn() can set zext_dst,
needs_zext, or arena_scalar on aux_data[i + 1].

Unlike keep_funcs_with_addr_taken() and sanitize_dead_code(), which clear
zext_dst =3D false when overwriting an unvisited instruction with trap,
bpf_opt_hard_wire_dead_code_branches() leaves aux_data[i + 1] flags intact.

Later, bpf_do_misc_fixups() will rewrite the BPF_JA trap instruction if
needs_zext or arena_scalar is set on aux_data[i + 1]:

kernel/bpf/fixups.c:bpf_do_misc_fixups() {
	...
		if (env->insn_aux_data[i + delta].needs_zext)
			/* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64 to 32-bit ALU */
			insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);

		if (env->insn_aux_data[i + delta].arena_scalar) {
			cnt =3D arena_scalar_access(insn, insn_buf);
	...
}

And on architectures where bpf_jit_needs_zext() is true,
bpf_opt_subreg_zext_lo32_rnd_hi32() sees load_reg =3D=3D -1 on the BPF_JA t=
rap
instruction while aux[adj_idx].zext_dst is set, hitting verifier_bug_if():

kernel/bpf/fixups.c:bpf_opt_subreg_zext_lo32_rnd_hi32() {
	...
		if (verifier_bug_if(load_reg =3D=3D -1, env,
				    "zext_dst is set, but no reg is defined"))
			return -EFAULT;
}

Also, what happens if the call and unwind_goto at insn i are themselves in
dead code (!aux_data[i].seen), but jump to a shared landing pad that was
reached from another call (aux_data[i + 1 + insn->off].seen)? Because
aux_data[i].seen is not checked here, insn + 1 is overwritten with trap and
marked seen, so bpf_opt_remove_dead_code() removes the dead call and
unwind_goto while leaving an orphaned goto pc-1 in the program (and any
later live conditional jump with untaken target i + 1 can no longer see
!aux_data[i + 1].seen).

Should this check aux_data[i].seen before handling unwind_goto, and clear
zext_dst, needs_zext, and arena_scalar on aux_data[i + 1] when writing trap?

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 849bc9136299d..90bc7230afa8a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5087,6 +5087,12 @@ static struct bpf_insn *bpf_insn_prepare_dump(cons=
t struct bpf_prog *prog,
>  			insns[i].imm =3D BPF_FUNC_tail_call;
>  			/* fall-through */
>  		}
> +		/*
> +		 * BPF_JCOND is the same opcode as BPF_CALL_ARGS. The latter is for
> +		 * the interpreter, and a prog with unwind_goto is always JITed.
> +		 */
> +		if (prog->jited && bpf_is_unwind_goto(&insns[i]))
> +			continue;
>  		if (code =3D=3D (BPF_JMP | BPF_CALL) ||
>  		    code =3D=3D (BPF_JMP | BPF_CALL_ARGS)) {
>  			/* Restore the legacy xlated dump layout. */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01434e1d23b59..e387320e196f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3430,6 +3431,46 @@ static int next_callx_callee(struct bpf_verifier_e=
nv *env, int caller, int from)
>  	return bit < end ? bit - caller * cnt : -1;
>  }
> =20
> +/*
> + * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind=
_exit.
> + * JITs don't emit a branch for it. unwind_exit finds the pad by its ret=
urn
> + * address. So unwind_goto has to follow the call and nothing may jump t=
o it.
> + */
> +static int check_unwind_insns(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	bool seen =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < env->prog->len; i++, insn++) {
> +		if (bpf_is_unwind_exit(insn)) {
> +			bpf_find_containing_subprog(env, i)->can_unwind =3D true;
> +			seen =3D true;
> +		}
> +		if (!bpf_is_unwind_goto(insn))
> +			continue;
> +		seen =3D true;
> +		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1))) {
> +			verbose(env, "unwind_goto at insn %d doesn't follow a call of a subpr=
og\n",
> +				i);
> +			return -EINVAL;
> +		}
> +		if (bpf_is_jump_target(env, i)) {
> +			verbose(env, "jump to unwind_goto at insn %d\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +	if (!seen)
> +		return 0;
> +	if (!bpf_jit_supports_unwind()) {
> +		verbose(env, "JIT does not support unwinding\n");
> +		return -ENOTSUPP;
> +	}
> +	env->prog->jit_required =3D 1;
> +	env->prog->aux->can_unwind =3D env->subprog_info[0].can_unwind;
> +	return 0;
> +}

[Severity: Medium]
Should check_unwind_insns() also reject programs when
!env->prog->jit_requested or bpf_prog_is_offloaded(env->prog->aux)?

When CONFIG_BPF_JIT_ALWAYS_ON is enabled and a program with unwind_goto is
loaded with prog_ifindex set to an offload device (such as netdevsim),
bpf_fixup_call_args() skips bpf_jit_subprogs() because
!bpf_prog_is_offloaded(env->prog->aux) is false, and the
#ifndef CONFIG_BPF_JIT_ALWAYS_ON check on prog->jit_required is compiled ou=
t:

kernel/bpf/fixups.c:bpf_fixup_call_args() {
	...
	if (env->prog->jit_requested &&
	    !bpf_prog_is_offloaded(env->prog->aux)) {
		err =3D bpf_jit_subprogs(env);
		if (err =3D=3D 0)
			return 0;
		if (err =3D=3D -EFAULT || err =3D=3D -EINTR)
			return err;
	}
#ifndef CONFIG_BPF_JIT_ALWAYS_ON
	if (prog->jit_required) {
		verbose(env, "program requires BPF JIT compiler but it is not available\n=
");
		return -EINVAL;
	}
	...
}

__bpf_prog_select_runtime() then takes the bpf_prog_offload_compile() branch
without checking jit_needed, leaving prog->jited as 0:

kernel/bpf/core.c:__bpf_prog_select_runtime() {
	...
	if (!bpf_prog_is_offloaded(fp->aux)) {
		...
		if (!fp->jited && jit_needed) {
			*err =3D -ENOTSUPP;
			return fp;
		}
	} else {
		*err =3D bpf_prog_offload_compile(fp);
		if (*err)
			return fp;
	}
}

Because prog->jited is 0 on that offloaded program, bpf_insn_prepare_dump()
skips the prog->jited && bpf_is_unwind_goto(&insns[i]) check and falls
through to the BPF_JMP | BPF_CALL_ARGS branch, where insns[i].src_reg =3D=3D
BPF_PSEUDO_CALL (both equal to 1) causes prepare_dump_pseudo_call() to
corrupt unwind_goto into BPF_JMP | BPF_CALL in xlated program dumps.

Similarly, when CONFIG_BPF_JIT_ALWAYS_ON is disabled and bpf_jit_enable is =
0,
checking !env->prog->jit_requested in check_unwind_insns() (like
require_callx_jit() does) would reject unwinding before passes such as
bpf_compute_subprog_ret_regs() that gate on env->prog->jit_requested.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181320.1284=
798-1-alexei.starovoitov@gmail.com?part=3D1
