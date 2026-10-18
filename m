Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115145038
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286917; cv=none; b=IzlpBaMxb/aboEZrV1L4wWdgsmfHf33pyvwsknX/FmxTMyBE1DBcOtQYAAu3zMNhVWxtz2f+UQfyoKYKChjSWvee1DToLpfLNp01j1ieVzSX6K6Geg+EqZ0cw3rwiw9sHruWuvboSzoZ56OZe7WkQUup//wtpcYaGhb5NvRUPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286917; c=relaxed/simple;
	bh=cFzAOCXqV8a1/F2bHS1g/zQ3yM5K/wBQKk7KwaithYQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=jWA0inAtw57X0VLCUf4PP4LXEpV79DBGMhS6dQVNHayzIIwgxl3hHZOuz1pkmWMjby+7wR9YpEhNwXOVChh0ftHJP9ByepYmEBTzehDBFLc7J4UD5lUBbLlDFXAshE4gnx/uTIdUeWPQPF5HVPAA+v2zrPar27ynzP0zGftjm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA0Z9349; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA0Z9349"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E591F000C4;
	Sun, 18 Oct 2026 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792286915;
	bh=RtRqq/TJPMvZVi/OkwNDiC0AwxEqv1Lc3S4VfaewHsI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LA0Z9349WxDv6cUQNLMjrdbT0yu0Wf0bQOmTp1CZxCHm0Tp3B1+MLxQdsBiRgW/K7
	 tR1Kvk10O2D5lQ0gaF3tbkanlAKQnfHaYtDD7iwJL4RFX+pgjKNCBIx0B5lcs200Qv
	 /yGiBY9bc+LBOQzhvCotRrt05okWqTKgU8Tr1C7CjqfCNNRr2b7TW0mobh8vTSr+EE
	 Dwbs9ee14ACo41fGd1pk9cykkDNeVZh30Y364zHGk2nbqi5WHEf4Or95MopacURWNO
	 vPQtqICWs2o3m+Tx8eMxs1zlvAVc//M3utVf8LSpWWOFeS293E5fQHKy5r1T9UNB6T
	 A1ZeKpRafuBRQ==
Message-ID: <sashiko-outbox-175871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/5] bpf, x86: Replace 'if r3 != 0 goto pad'
 after a call with an extable entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261018010246.1643877-3-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
 <20261018010246.1643877-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:28:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: stale jump_target in bpf_jit_unwind_site() and bpf_jit_un=
wind_exit()
--

commit 5cf9f95ceda5d2950b3e2ae8af36899c1bc4137e
Author: Alexei Starovoitov <ast@kernel.org>

bpf, x86: Replace 'if r3 !=3D 0 goto pad' after a call with an extable entry

This commit optimizes unwinding subprogram calls on x86-64 by replacing the
post-call 'if r3 !=3D 0 goto pad' branch with an exception table entry and
redirecting the caller's return address at subprogram exit when unwinding.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b16d74d2681a9..14696555e8a51 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3331,6 +3331,50 @@ bool __weak bpf_jit_supports_unwind(void)
>  	return false;
>  }
> =20
> +/*
> + * A subprog that can unwind says so in r3 and its caller does
> + * 'if r3 !=3D 0 goto pad' after the call. A JIT can keep that off the n=
ormal path.
> + * It doesn't emit the branch and adds an extable entry instead:
> + *   insn  =3D return address of the call - 1
> + *   fixup =3D pad - return address of the call
> + * - 1, because what follows the call can have an entry of its own.
> + * An exit with r3 !=3D 0 looks its own return address up and returns to=
 the pad.
> + * When there is no entry it returns as usual and the branch is there.
> + *
> + * Is insn i of the prog such a call?
> + */
> +bool bpf_jit_unwind_site(const struct bpf_verifier_env *env, const struc=
t bpf_prog *prog, int i)
> +{
> +	const struct bpf_insn *insn =3D &prog->insnsi[i];
> +
> +	if (!env || i + 1 >=3D prog->len)
> +		return false;
> +	if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
> +		return false;
> +	/*
> +	 * No need to know the callee: the verifier lets r3 be read after
> +	 * a call only when every callee seen there says something in it.
> +	 */
> +	return insn[1].code =3D=3D (BPF_JMP | BPF_JNE | BPF_K) && !insn[1].imm =
&&
> +	       insn[1].dst_reg =3D=3D BPF_REG_UNWIND &&
> +	       !bpf_is_jump_target(env, prog->aux->subprog_start + i + 1);
> +}
> +
> +/* What does 'exit' at insn i of the prog do? */
> +enum bpf_unwind_exit bpf_jit_unwind_exit(const struct bpf_verifier_env *=
env,
> +					 const struct bpf_prog *prog, int i)
> +{
> +	const struct bpf_insn *insn =3D &prog->insnsi[i];
> +
> +	if (!env || !prog->aux->ret_unwind)
> +		return BPF_EXIT_RETURNS;
> +	if (!i || bpf_is_jump_target(env, prog->aux->subprog_start + i) ||
> +	    insn[-1].code !=3D (BPF_ALU64 | BPF_MOV | BPF_K) ||
> +	    insn[-1].dst_reg !=3D BPF_REG_UNWIND)
> +		return BPF_EXIT_LOOK_AT_R3;
> +	return insn[-1].imm ? BPF_EXIT_UNWINDS : BPF_EXIT_RETURNS;
> +}

[Severity: Critical]
Is env->insn_aux_data[].jump_target still accurate when bpf_jit_unwind_site=
()
and bpf_jit_unwind_exit() query bpf_is_jump_target() during JIT compilation?

env->insn_aux_data[].jump_target is populated once during bpf_check_cfg()
before main verification, and several post-verification passes in
kernel/bpf/fixups.c and kernel/bpf/const_fold.c modify instructions without
preserving jump_target on the resulting jump targets:

1. NOP removal in bpf_opt_remove_nops() -> verifier_remove_insns():
   Dead conditional branches folded to 'ja +0' (by bpf_prune_dead_branches()
   or bpf_opt_hard_wire_dead_code_branches()) and removed fastcall
   spills/fills (by bpf_remove_fastcall_spills_fills()) are deleted unless
   aux[i].indirect_target is set:

   kernel/bpf/fixups.c:bpf_opt_remove_nops() {
       ...
       if (aux[i].indirect_target)
           continue;

       err =3D verifier_remove_insns(env, i, 1);
   }

   verifier_remove_insns() redirects incoming jumps from off to the next
   instruction, but overwrites aux_data[off] with aux_data[off + cnt]:

   kernel/bpf/fixups.c:verifier_remove_insns() {
       ...
       memmove(aux_data + off, aux_data + off + cnt,
               sizeof(*aux_data) * (orig_prog_len - off - cnt));
   }

   If a jump targeted the removed NOP at k (aux_data[k].jump_target =3D=3D =
true)
   while k + 1 was only reached by fallthrough (aux_data[k + 1].jump_target=
 =3D=3D
   false), the instruction shifting into k inherits the incoming jump with
   jump_target =3D=3D false.

   In an unwinding subprogram such as:

       r3 =3D 1
       if r1 =3D=3D 0 goto L
       r3 =3D 0
   L:  if r2 =3D=3D 0 goto dead   /* folded to ja +0 and removed */
       exit

   removing the NOP at L leaves exit at L with jump_target =3D=3D false and
   insn[-1] =3D=3D 'r3 =3D 0'. bpf_jit_unwind_exit() then returns BPF_EXIT_=
RETURNS
   instead of BPF_EXIT_LOOK_AT_R3, so do_jit() omits emit_unwind_ret_addr().
   When the 'r1 =3D=3D 0' branch is taken with r3 =3D 1, the subprogram ret=
urns to
   the caller's normal post-call instruction (where do_jit() set
   skip_branch =3D true and stripped 'if r3 !=3D 0 goto pad') instead of the
   landing pad, bypassing cleanup on the unwind path. Conversely, if
   insn[-1] is 'r3 =3D 1', bpf_jit_unwind_exit() returns BPF_EXIT_UNWINDS a=
nd
   unwinds unconditionally even when a jumping path had r3 =3D 0.

   Similarly, if a jump-targeted NOP between a call and 'if r3 !=3D 0 goto =
pad'
   is removed, 'if r3 !=3D 0 goto pad' shifts into insn[1] after the call w=
ith
   jump_target =3D=3D false, causing bpf_jit_unwind_site() to return true a=
nd
   do_jit() to elide the branch via skip_branch =3D true even though another
   jump targets it.

2. PROBE_MEM fixup in bpf_do_misc_fixups():
   When bpf_arch_uaddress_limit() is non-zero (such as on x86-64), a
   BPF_LDX | BPF_PROBE_MEM (or BPF_PROBE_MEMSX) load into r3 immediately
   before exit is expanded via bpf_patch_insn_data():

   kernel/bpf/fixups.c:bpf_do_misc_fixups() {
       ...
       *patch++ =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, =
2);
       *patch++ =3D *insn;
       *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
       *patch++ =3D BPF_MOV64_IMM(insn->dst_reg, 0);

       cnt =3D patch - insn_buf;
       new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
   }

   The synthesized 'goto +1' jumps over 'r3 =3D 0' to exit without marking
   exit as a jump target, and places 'r3 =3D 0' at insn[-1].
   bpf_jit_unwind_exit() then sees jump_target =3D=3D false and insn[-1] =
=3D=3D
   'r3 =3D 0', returning BPF_EXIT_RETURNS instead of BPF_EXIT_LOOK_AT_R3.

3. Instruction patching in adjust_insn_aux_data():
   When expanding an instruction in BPF_PATCH_KEEP_TARGET mode,
   indirect_target is moved from data[off + cnt - 1] back to data[off],
   whereas jump_target is left on data[off + cnt - 1] and cleared on
   data[off]:

   kernel/bpf/fixups.c:adjust_insn_aux_data() {
       ...
       if (mode =3D=3D BPF_PATCH_KEEP_TARGET && data[off + cnt - 1].indirec=
t_target) {
           data[off].indirect_target =3D 1;
           data[off + cnt - 1].indirect_target =3D 0;
       }
   }

Should jump_target be maintained across verifier_remove_insns(),
adjust_insn_aux_data(), and fixup patches (or recomputed after all instruct=
ion
rewrites before JIT compilation)?

>  /*
>   * How this arch places a by-value kfunc argument, or NULL for one that =
has
>   * not opted in and so only takes an argument of a single eightbyte, whi=
ch

[ ... ]

>
endasi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018010246.1643=
877-1-alexei.starovoitov@gmail.com?part=3D2
