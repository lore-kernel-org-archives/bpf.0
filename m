Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21D3054C7
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435750; cv=none; b=jypinFsPnNUoq6CTGUDUZtRkKVfzxKtEt3CQ88ugJEelNoTjYYLxtB/vlAf2warO1YogMkYH0wKYtWHM9gx1P6XX1MNrcixZOzTI/1ldxUznqq4wlaYwbLH/7tvqPaxvLm2aBMJ2J86PWpezzyZ/JDFq1bxOguZQAIn8CDDdR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435750; c=relaxed/simple;
	bh=6cUKWvbX6yq+Fd7Hha2K6IVSzIN5Z/y8Q57VcZlPxY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X7YZ9fbJoT1Qne3taO5U79H1eVIA434im/5dD5L3/ELVscPNMmOIV0LQWVQEGe2p+P/F7PlIELiZ8hu9QhBc9Z1ogHF2dlvTm6iBq+UvzzWpwKi3mPZBwL1gjZnmjbd3VLNRHzwTKLNsonEUBYc8raTqoJZsvVGz7F1jtdIxnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQy47ERK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQy47ERK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3151F000E9;
	Tue,  7 Jul 2026 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435748;
	bh=NEECrIiuPg363T2lMe0+Y4dxEZOgscYxXLQf2360K5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQy47ERKWSKmID8zofKcAZZFyMkBDKTtz5ABYBGkzSHIyfIwiKkgUBUIJJO71jOQe
	 aMq9xFZoozxNyLntO7lffjMulEiPg4eHKXLCPDLD7K4ie6BlbzKYt1lSrIyz0W/lZK
	 kzfCUkXXEBR8gD0DW7lT68zrHsTmZjBsMbpdzd6hns29qxn/Daqv1PrO3TZwm5LKQc
	 Sww+yfUXDo+tubbvaOSXyzFKvdaY5zsq0b3uJxa/dHIp5B1gmW3rHZ/uraNsJcA9c2
	 waZN0lGnwiI6R0m7AwUhswnyO5h7/0WWVXOiyCbdKyCrsPV7og+GiXrsvrAqyEV3QA
	 Nre8Gs1Mo1jNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 5/6] riscv, bpf: Mixing bpf2bpf and
 tailcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707142219.2871758-6-pulehui@huaweicloud.com>
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
 <20260707142219.2871758-6-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:49:07 +0000
Message-Id: <20260707144908.AB3151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Extension programs (BPF_PROG_TYPE_EXT) targeting subprograms incor=
rectly reset the Tail Call Counter (TCC), bypassing the tail call limit and=
 allowing infinite loops.
--

--- Patch [5]: [PATCH bpf-next v5 5/6] riscv, bpf: Mixing bpf2bpf and tailc=
alls ---
commit f7082c3640c8a167ff897d3870ee0dd71fc2faab
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Mixing bpf2bpf and tailcalls

This commit implements mixed bpf2bpf and tailcalls for the RV64 JIT.
It changes how the Tail Call Counter (TCC) is passed and preserved,
storing it in a non-callee saved register and explicitly saving/restoring=20
it around bpf2bpf calls and tail calls.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 7c6304e0b846a..823262ca47ebf 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -1836,10 +1829,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>  			}
>  		}
> =20
> +		/* restore TCC to RV_REG_TCC before bpf2bpf call */
> +		if (aux->tail_call_reachable && insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> +			emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +
>  		ret =3D emit_call(addr, fixed_addr, ctx);
>  		if (ret)
>  			return ret;
> =20
> +		/* store updated TCC back to stack after bpf2bpf call */
> +		if (aux->tail_call_reachable && insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> +			emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
> +

[Severity: High]
If the bpf2bpf call jumps to a BPF_PROG_TYPE_EXT program that incorrectly
reset RV_REG_TCC, will the caller now save that clobbered value to its own
stack?

If the TCC is continuously reset to 33 in this manner, could this bypass the
tail call limit and allow an infinite loop resulting in a CPU soft lockup?

>  		if (insn->src_reg !=3D BPF_PSEUDO_CALL)
>  			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
>  		break;
[ ... ]
> @@ -2038,11 +2038,10 @@ void bpf_jit_build_prologue(struct rv_jit_context=
 *ctx, bool is_subprog)
>  	for (i =3D 0; i < RV_FENTRY_NINSNS; i++)
>  		emit(rv_nop(), ctx);
> =20
> -	/* First instruction is always setting the tail-call-counter
> -	 * (TCC) register. This instruction is skipped for tail calls.
> -	 * Force using a 4-byte (non-compressed) instruction.
> -	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +	if (!is_subprog)
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +

[Severity: High]
Does this logic handle BPF_PROG_TYPE_EXT (freplace) programs correctly?

When an extension program is loaded independently and attached to a global
subprogram of another BPF program, is_subprog will be false because it is t=
he
main program of its own object.

Won't this cause the EXT program to unconditionally emit this instruction,
clobbering the inherited TCC passed in RV_REG_TCC from the caller?

> +	/* tailcall starts here, emit insn before it must be fixed */
> =20
>  	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707142219.2871=
758-1-pulehui@huaweicloud.com?part=3D5
