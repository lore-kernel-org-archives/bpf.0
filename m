Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843EA23EA8B
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573217; cv=none; b=GJAG8HEWO8ihWFZwtKGx2W5Tk1w95oVXiU4YoXC1xsJ/NGo7i26elK88MqPIsO/SCGQn0BCvzjdee3iP+5tvUf07j5Lo1ZJvenHuQXgyb4FpfKPp6D6n7YwRiLuXfpBatDCXXqnaqDK8AI6p3Sr9UWF/RHMn8OafAM/kZKqtvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573217; c=relaxed/simple;
	bh=R+4n81MJHTzIYUhc+IY4h7BKKbghu69QkEDEA8AO8+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g1ntPULPHEOduGLQFQnTvBCrvMDurR1/sSk4b+pZGOr+uqG4Z9vQ0H+Z2nWI5TaA8YyTFHN6LLm4bFTWQsmsrn76YoK8+sME/djsV5y2aOSxYzmE+BXHtdz62ZEpJHuo1nMjEa0QipAU8zd7eQmGkpuRJqPS1iBQUZifAHGCsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsnsiKcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsnsiKcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72721F000E9;
	Sat, 27 Jun 2026 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573214;
	bh=p7LZMZaaotv9JfJG1yVEuko6Zht6GCxhZ0yMax2b4WA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsnsiKcJ0DPy+D89S2zHdqS4Ffxw7LOdSKfxqQJWN8lTqbvjvXPH+alrqEgxrYsHX
	 GJgPKAPT8Qllu/yefrpq7Psoap8niNr6uupZgVazFwd6t7gf0uj0Jt1WvjO1OHiC/2
	 c9AXhvCgRpJW11pGaphNG08nGibXoQOpMxHiwt+c9/kfMPFgs+qyUSCk+WLDC7Ap9Q
	 +0BqCJuWtBVspa8XphhIJWFaVny0SMFth8UTPaLCDto17tMPxwlulhRv81wL6ceEYw
	 z02yz5KVp0EEDre2yKDQNbroiihmzibpiQzQb/D6aDxJ7MZCKzUERzdwrf2HFdpH1U
	 hVEHKNgWQxD5Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 11/12] bpf, x86: Add JIT support SDT for
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <48943c5608280cade48d459ca15fd156c7470209.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <48943c5608280cade48d459ca15fd156c7470209.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:13:34 +0000
Message-Id: <20260627151334.A72721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] NULL pointer dereference in the x86 JIT compiler for classic B=
PF (cBPF) programs
- [High] Stack buffer overflow in `bpf_sdt_link_attach()` due to unvalidate=
d `nargs` field
- [High] Out-of-bounds read in the Verifier and JIT compiler via unvalidate=
d SDT argument registers
- [High] The SDT probe trampoline clobbers x86 caller-saved registers, corr=
upting the execution state of the target BPF program
- [High] Verifier bypass of SDT probe constraints via duplicate `orig_off` =
map entries
--

commit e3ca8ab99711f4294e8b0182251c50473a63e6d7
Author: Xu Kuohai <xukuohai@huawei.com>
Subject: bpf, x86: Add JIT support SDT for probe

This commit adds x86 JIT support for SDT probes. It jits SDT probe sites to
a 5-byte NOP and patches them to a CALL instruction when attached to an
observer program. It also modifies the BPF trampoline to save and restore
arguments from the func_model's arg_regs instead of fixed BPF registers.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 054e043ffcd22..262f1bd74d53f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2797,6 +2797,16 @@ st:			insn_off =3D insn->off;
>  			}
> =20
>  			if (!jmp_offset) {
> +				int index =3D bpf_prog->aux->subprog_start + i - 1;
> +
> +				/*
> +				 * Emit a 5-byte NOP for SDT probe site, so it can be patched to
> +				 * a CALL instruction when observer program is attached.
> +				 */
> +				if (env->insn_aux_data[index].sdt_entry) {

[Severity: Critical]
Does this code dereference a NULL pointer when JIT compiling classic BPF
programs?

When an unprivileged user attaches a classic BPF filter containing a jump to
the next instruction, the kernel translates it to eBPF and invokes
bpf_int_jit_compile() with a NULL verifier environment.

During compilation, do_jit() processes the jump with a zero offset and
evaluates env->insn_aux_data[index].sdt_entry. Since env is NULL, could this
lead to an immediate kernel panic?

> +					emit_nops(&prog, X86_PATCH_SIZE);
> +					break;
> +				}
>  				/*
>  				 * If jmp_padding is enabled, the extra nops will
>  				 * be inserted. Otherwise, optimize out nop jumps.

[ ... ]

> @@ -3087,9 +3101,12 @@ static void restore_regs(const struct btf_func_mod=
el *m, u8 **prog,
>  		arg_regs =3D (m->arg_size[i] + 7) / 8;
>  		if (nr_regs + arg_regs <=3D 6) {
>  			for (j =3D 0; j < arg_regs; j++) {
> -				emit_ldx(prog, BPF_DW,
> -					 nr_regs =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
> -					 BPF_REG_FP,
> +				u8 reg =3D (flags & BPF_TRAMP_F_SDT_PROBE)
> +					? m->arg_regs[nr_regs]
> +					: (nr_regs =3D=3D 5 ? X86_REG_R9
> +					   : BPF_REG_1 + nr_regs);
> +
> +				emit_ldx(prog, BPF_DW, reg, BPF_REG_FP,

[Severity: High]
Can this lead to an out-of-bounds read if the register index is unvalidated?

If a user provides an out-of-bounds value for arg_reg in an insn_array map
entry, and the verifier is bypassed, could m->arg_regs[nr_regs] hold a value
exceeding the expected register range?

When this unvalidated index is passed to emit_ldx(), it appears to cause an
out-of-bounds read on the reg2hex array during x86 opcode generation,
potentially corrupting memory.

Is there a similar issue in check_sdt_probe() during verification?

kernel/bpf/verifier.c:check_sdt_probe() {
    ...
    u8 reg =3D val->arg_reg[i];
    struct bpf_reg_state *rs =3D &regs[reg];
    ...
}

If reg is unvalidated, could this also cause an out-of-bounds read on the
verifier's regs array?

>  					 -stack_size);
>  				stack_size -=3D 8;
>  				nr_regs++;

[ ... ]

> @@ -3603,7 +3620,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>  	}
> =20
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_regs(m, &prog, regs_off);
> +		restore_regs(m, &prog, regs_off, flags);

[Severity: High]
Does the SDT probe trampoline clobber x86 caller-saved registers here?

The verifier treats the 5-byte NOP as a jump with a zero offset, assuming a=
ll
BPF caller-saved registers remain intact. However, when an observer attache=
s,
the NOP is patched to call the BPF trampoline, which executes the observer
program.

Could the observer program clobber the x86 caller-saved registers (RAX, RCX,
RDX, RDI, RSI, R8)? Since restore_regs() only restores the explicitly track=
ed
SDT argument registers, the remaining caller-saved registers might remain
corrupted when control returns to the target program, potentially corrupting
its execution state.

> =20
>  	/* This needs to be done regardless. If there were fmod_ret programs,
>  	 * the return value is only updated on the stack and still needs to be

[ ... ]

[Severity: High]
Is it possible to bypass the verifier's SDT probe constraints using duplica=
te
offsets in the insn_array map?

In bpf_insn_array_init(), multiple map entries with the same offset appear =
to
overwrite each other sequentially:

kernel/bpf/bpf_insn_array.c:bpf_insn_array_init() {
    ...
    env->insn_aux_data[values[i].orig_off].sdt_entry =3D &values[i];
    ...
}

This means the verifier might only validate the last matching element.
However, bpf_insn_array_get_sdt_probe_by_name() seems to return the first
matching element by scanning sequentially:

kernel/bpf/bpf_insn_array.c:bpf_insn_array_get_sdt_probe_by_name() {
    ...
    if (!strcmp(insn_array->values[j].name, name)) {
        *val =3D insn_array->values[j];
    ...
}

Could this allow a malicious user to place a malformed, unverified probe
entry before a valid one with the same offset, completely subverting the
verifier?

[Severity: High]
If the verifier is bypassed, could bpf_sdt_link_attach() suffer from a stack
buffer overflow?

When looking up a probe by name, bpf_sdt_link_attach() might retrieve an
unverified entry with an arbitrary nargs value (up to 255):

kernel/bpf/syscall.c:bpf_sdt_link_attach() {
    ...
    for (i =3D 0; i < sdt->val.nargs; i++) {
        tgt_info.fmodel.arg_size[i] =3D 8;
        tgt_info.fmodel.arg_regs[i] =3D sdt->val.arg_reg[i];
    }
    ...
}

Because tgt_info.fmodel.arg_size and arg_regs are statically sized arrays
on the kernel stack, could this loop write out-of-bounds if nargs exceeds
the arrays' bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D11
