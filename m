Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC736896D
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742011; cv=none; b=Kx3Jjdz2zvslccTh4juWjL/IWgkssy9+Ick8mnoL/+5i/ZM8nA8sbtJ9C4rCCgQsrXrbQWI649seYHy0VmYS6/w8gngMsAKBbmuSMTodYQXyOssdMwX28aDa7JpEKR429VT/pa9qbA/6lRSBEFMz0rx4FK1fVrM52mTpKceryaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742011; c=relaxed/simple;
	bh=O/v3z3EEKAXWazoVy5oVrcoNxp0GBZOxZK9icULet3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uf2FigRRWg8XLYVcUR5GKmgwg7aWCfHln++L3GLCxfl7iRAaPBkI18kIrcVC8jem53z1un0kP0xaFwjjZEb51PSKiuPcyqkWXkL4UluL2VhKsMrtv5lhK7uKWp3DmGrp1sMqWjcv7+acrPpYTtdtVMziH/IUPuAJfF2yMNDD5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnP60pJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnP60pJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0806D1F000E9;
	Mon, 29 Jun 2026 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742010;
	bh=eHKp0XJZkMI4Ai8iMs2uGSUGdt4I7pE9WWRa/BItgWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnP60pJYz+uGkYaSeKAFC4hzaZckfpTXg50CAYxa8LcFyCVVi8gOhAzNNUNyj65lL
	 pNoaJ6JwAxRBDbu6BEjcyCNdDIxjv0K8uodO3Cq+hccamdF/Zh06V8PoqGFwHKZ9hB
	 2XbFQiuW0Nd5DRdBLBBqu+4klAULiPBlwLLl+HxKWem1d7tU6pmRVmpGj3OOWd+Cx7
	 QeF40gfIrAPNQ/TYrquDeQAZ9pzFLIy38PG+Bq5r0NdUyFdABC1YLem7gOQL+Mrpyx
	 5WKOe2em8rPuw0Af5YlZGVd7uNDa07B70thlSbAUowJ2pOUS+F7WZjVInVsxCM+59a
	 u6Hv9BT7BFAog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] riscv, bpf: Mixing bpf2bpf and
 tailcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629140048.733346-6-pulehui@huaweicloud.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <20260629140048.733346-6-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:06:49 +0000
Message-Id: <20260629140650.0806D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The RISC-V BPF JIT corrupts the Tail Call Counter (TCC) when retur=
ning from subprograms (bpf2bpf calls) or trampoline calls, breaking the max=
imum tail call limit and potentially causing stack overflows.
--

commit 5d936090d578733fdafd16fde93ba7223525701c
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Mixing bpf2bpf and tailcalls

This commit implements mixing bpf2bpf and tailcalls for the RISC-V JIT.
It transitions to passing the Tail Call Counter (TCC) between functions
using a non-callee saved register and explicitly saves it to the stack
across calls to preserve its value.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c239696cca646..384b490c48579 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -1254,6 +1240,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>  		ret =3D emit_call((const u64)__bpf_tramp_exit, true, ctx);
>  		if (ret)
>  			goto out;
> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> +		/* restore TCC to RV_REG_TCC before calling the orig bpf func */
> +		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>  	}

[Severity: High]
If BPF_TRAMP_F_CALL_ORIG is set, the preceding if block will execute and th=
is
else if branch will be completely skipped.

Does this mean the trampoline skips restoring RV_REG_TCC before returning to
the caller, thereby leaking a clobbered TCC back to the calling function?

[ ... ]

> @@ -1837,10 +1826,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
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
>  		if (insn->src_reg !=3D BPF_PSEUDO_CALL)
>  			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
>  		break;

[Severity: High]
Since RV_REG_TCC (a6) is a caller-saved register, if the subprogram executes
any BPF helper calls, won't a6 be clobbered?

Looking at __build_epilogue(), there doesn't appear to be any code to resto=
re
RV_REG_TCC from the subprogram's stack slot before it returns to the caller.

If the subprogram returns with a clobbered a6, does this emit_sd() blindly
save that garbage value as the new TCC on the caller's stack? Could this
corrupt the tail call limit counter and potentially lead to infinite tail c=
alls
or stack overflows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629140048.7333=
46-1-pulehui@huaweicloud.com?part=3D5
