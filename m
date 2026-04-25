Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC25C613
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777093558; cv=none; b=t6Btpyu6kpyD4xuPQy1S0zKNHb4SW7c03rO+TXLm59PFz49X9JcS8gq5Zp3xtovmop3GiWf0kATNwGqpe9kU3RdhTWOuMFAPGgFKz12ocbBlqKooffk5e7XCm1I124o+4vDY/dCecIix/QIw8EoRuJHwNAm5pgb3JnqPTKlwtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777093558; c=relaxed/simple;
	bh=YkXSYJuq3xXy5csHtDlf60MdSPGNxm4bAQsj6KcRDqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t1SonqX7x4wdHn81rrJ0GiCBvh7/uQmbqu1B6rs+CMGiCV1CVF6oeY84+Gjmnd4Y5p1rM8MqTWVC6jYy7MOpScql5IE/etkEBC7wZVRJ0XzOKfPHtUiCBhL9H3DI/3T3MDew8QIW39uogTy9i4RCR/OeD+1FD2Df01/SscI+X9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T14vVBSY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T14vVBSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827F3C2BCB2;
	Sat, 25 Apr 2026 05:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777093557;
	bh=YkXSYJuq3xXy5csHtDlf60MdSPGNxm4bAQsj6KcRDqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T14vVBSYL+fB891pu4azpUnXhnRrX3gCWSl7ztP52as6bJ1v2TDK3c2ZoamnVjUXB
	 Kc1ibIlx+JzGf7pndRW0a07DzejSczr+wfi/jGW+WoObNBbo4K+y1oh2DcasLOiV2s
	 IGPEEvT7XyXeiH8vm5MaMV7Ah4D+7rtOv8Wi3QpDOM9uoutj+75DfQa3SWoWjuRKbD
	 bK1GeF3FEwZgSBWUJWdIrAtjkwSvxKGKSIyc66ovz1ZGOHG9lzIraWAOCjx+Fpjb8W
	 6N00yiHJdzlcB57xdHTrt6dmn0qlgMWUgyTgG2QH6J3WtKsumyu+dM5JPkbnapZlkd
	 oovBo5ct7iFYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing
 program stack
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-2-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-2-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 05:05:56 +0000
Message-Id: <20260425050557.827F3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] An instruction aliasing PTR_TO_STACK and other pointer types (e.g.=
, PTR_TO_MAP_VALUE) will permanently be marked with accesses_stack =3D true=
, improperly bypassing KASAN monitoring for the non-stack access.
- [High] Instruction patching drops the accesses_stack flag from memory acc=
ess instructions, causing unintended KASAN checks on stack accesses.
- [High] bpf_insn_accesses_stack() unconditionally returns false when env =
=3D=3D NULL, breaking KASAN suppression for classic BPF (cBPF) programs.
- [Medium] Stack accesses inside global subprograms lack the accesses_stack=
 flag, leading to unintended KASAN checks when stack pointers are passed to=
 them.
--

commit 58c92691d6de0f6cbdbd48cc21d31e0a14a4fffa
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

In order to prepare to emit KASAN checks in JITed programs, JIT
compilers need to be aware about whether some load/store instructions
are targeting the bpf program stack. Make the BPF verifier mark the
instructions that access program stack.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8b018ff488750..340abfdadbedb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -1582,6 +1582,16 @@ bool bpf_insn_is_indirect_target(const struct bpf_=
verifier_env *env, const struc
>  	insn_idx +=3D prog->aux->subprog_start;
>  	return env->insn_aux_data[insn_idx].indirect_target;
>  }
> +
> +bool bpf_insn_accesses_stack(const struct bpf_verifier_env *env,
> +			     const struct bpf_prog *prog, int insn_idx)
> +{
> +	if (!env)
> +		return false;

Classic BPF (cBPF) programs are converted to eBPF and JIT-compiled directly,
bypassing the eBPF verifier, so env is NULL. The converted eBPF instructions
heavily use BPF_REG_FP for scratch memory accesses.

Because this returns false when env is NULL, will JIT compilers incorrectly
emit KASAN checks for all cBPF stack memory accesses?

Could this inspect the instruction directly when env =3D=3D NULL (e.g., che=
cking
if insn->dst_reg =3D=3D BPF_REG_FP or insn->src_reg =3D=3D BPF_REG_FP) to p=
revent
false positive KASAN splats for valid cBPF programs?

> +	insn_idx +=3D prog->aux->subprog_start;
> +	return env->insn_aux_data[insn_idx].accesses_stack;
> +}
> +
>  #endif /* CONFIG_BPF_JIT */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..1ce0388847b2b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3502,6 +3502,11 @@ static void mark_indirect_target(struct bpf_verifi=
er_env *env, int idx)
>  	env->insn_aux_data[idx].indirect_target =3D true;
>  }
> =20
> +static void mark_insn_accesses_stack(struct bpf_verifier_env *env, int i=
dx)
> +{
> +	env->insn_aux_data[idx].accesses_stack =3D true;
> +}
> +

If an instruction aliases PTR_TO_STACK and other pointer types (e.g.,
PTR_TO_MAP_VALUE) across different execution paths, check_mem_access() will
call this and permanently set accesses_stack =3D true when evaluating the s=
tack
path.

When the PTR_TO_MAP_VALUE path is evaluated, the accesses_stack flag remains
true. Will this cause the map value access to completely bypass KASAN
monitoring during JIT compilation?

Additionally, when the verifier patches an instruction (e.g., for
zero-extension via bpf_patch_insn_data()), adjust_insn_aux_data() shifts the
original auxiliary data to the last instruction of the newly inserted patch
sequence.

For patches like zero-extension, a BPF_MOV is inserted after the original
BPF_LDX_MEM instruction. Does the accesses_stack flag thus move to the MOV
instruction, while the actual memory load receives zeroed auxiliary data?

Could this result in the JIT compiler erroneously emitting KASAN
instrumentation for these verified stack accesses?

>  #define LR_FRAMENO_BITS	3
>  #define LR_SPI_BITS	6
[ ... ]
> @@ -6493,6 +6498,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  		else
>  			err =3D check_stack_write(env, regno, off, size,
>  						value_regno, insn_idx);
> +
> +		mark_insn_accesses_stack(env, insn_idx);

Global subprograms are verified independently of their call sites, and poin=
ter
arguments are tracked as PTR_TO_MEM rather than PTR_TO_STACK. Inside the
subprogram, check_mem_access() evaluates loads and stores under the
PTR_TO_MEM branch, which does not invoke mark_insn_accesses_stack().

If a BPF caller dynamically passes a pointer to its stack as an argument to
the global subprogram, will the JIT-compiled global subprogram execute with
KASAN checks enabled for those accesses?=20

Does this erroneously monitor the BPF stack, bypassing the intended
suppression mechanism?

>  	} else if (reg_is_pkt_pointer(reg)) {
>  		if (t =3D=3D BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
>  			verbose(env, "cannot write into packet\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D2
