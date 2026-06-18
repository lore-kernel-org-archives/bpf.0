Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94872EEE90
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754908; cv=none; b=LH6WhHqPle+f4vMQNuMul1ntGBwaq5+w6vVytPgfek9xBWoTPGse1fru9sRJXSjvWUr+pWpvlZiLHTiDxeiujwNkrpDXhuQyJ7SmDVI35GZGP+GPOj+wU8cgRX0EkrBL/N7065ctbr5q53e0fwbjv1oqEgmU77lG+egZ6455wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754908; c=relaxed/simple;
	bh=GjCwA7ieprPSsZI+2bxWlpyXUl5WqwEr9X9KM52OPSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oo5sWtLh0+4OfJ9eZRoepCHqvUiRtOq1adEccPvre+Ya7Hp3AmFsT/N91xU6odM/g9UlpgD0ovy7ZbjVEPU/SQY3kmXd2xX24hDZhp0EXWApT9hkzWwCbO4mQFSm2UsdzUDB67LOKInAss3ME+dBVPsN2D3/qyGGrGQcaJAJ+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz5HoLkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz5HoLkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391801F000E9;
	Thu, 18 Jun 2026 03:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781754907;
	bh=ce6hsM8I17x46O9cfbKB/xhWlsa94aleD+u3UhLaHxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iz5HoLkSX1wDzRSVwx2MPwJ+Jnr131L80H8mvfm27BdX5gvhc8uSLX+a5EQpVcUSv
	 4uQAZ/0PYQMuNrM+UrutM4NTu7tcSKansJJicRjNXoMvJNMaFw9KFYPZeNyfd5gq6S
	 4sYNDLelB2OiTQEPxZalLAIaLD7LumVbQT4uabAH4rS/6I+94FgIhB0neUcJaRZZaR
	 loe2NjO+eV/3ZZJB9C/jPWAekjGunlYo8zD/H/gBhrHAiDL3TnL0/LuAMlqXydSOjL
	 W66MBNOFrBKve9Vbsck1c5RnpyljAnjtsmKBgLMWIbhr9Cq/HXwrHhtimg3c29UPvh
	 WAzFIpSU8L0Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] LoongArch: BPF: Add private stack support
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618033809.98253-3-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
 <20260618033809.98253-3-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:55:06 +0000
Message-Id: <20260618035507.391801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Per-CPU private stack memory leak upon JIT compilation failure.
- [Low] Undeclared identifier 'LOONGARCH_GPR_U0' causes build failure.
- [Low] Typo in the private stack guard check error message (`%sx` instead =
of `%s`).

Pre-existing issues:
- [Critical] Incorrect BPF_TAIL_CALL_CNT_PTR_STACK_OFF offset calculation w=
hen arena or exception boundary features are used.
--

commit ec3426d8bc4121c18182b9bd92e8adc7fa663dc5
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Add private stack support

Support per-program private stacks to reduce kernel stack pressure for deep
or recursive tracing programs. The stack depth is computed and allocated
per-CPU with guard regions. If a private stack is used, the BPF frame
pointer is pointed into this region instead of the kernel stack.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -18,8 +18,13 @@
> =20
>  #define REG_TCC		LOONGARCH_GPR_A6
>  #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
> +#define REG_PRIV_SP	LOONGARCH_GPR_S5 /* For storing the private stack po=
inter */
>  #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)

[Severity: Critical]
This isn't a bug introduced by this patch, but is the tail call count
offset calculation correct when arena or exception boundary features are
enabled? When ctx->arena_vm_start or is_exception_prog is true, 8 additional
bytes are reserved on the stack, which shifts the actual location of TCC_PT=
R.
Because the macro doesn't account for this shift, will tail calls load the
TCC counter value instead of the pointer address, causing a kernel panic
when it's dereferenced?

[ ... ]

> +static void emit_percpu_ptr(struct jit_ctx *ctx, u8 dst, void __percpu *=
ptr)
> +{
> +	move_imm(ctx, dst, (__force long)ptr, false);
> +#ifdef CONFIG_SMP
> +	/* dst +=3D __my_cpu_offset, held in $r21 */
> +	emit_insn(ctx, addd, dst, dst, LOONGARCH_GPR_U0);
> +#endif
> +}

[Severity: Low]
Does LOONGARCH_GPR_U0 exist in enum loongarch_gpr? It appears missing from
the loongarch include headers, which would cause a build failure when
CONFIG_SMP is enabled.

[ ... ]

> +static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int al=
loc_size,
> +				   struct bpf_prog *prog)
> +{
[ ... ]
> +		if (stack_ptr[0] !=3D PRIV_STACK_GUARD_VAL ||
> +		    stack_ptr[1] !=3D PRIV_STACK_GUARD_VAL ||
> +		    stack_ptr[underflow_idx] !=3D PRIV_STACK_GUARD_VAL ||
> +		    stack_ptr[underflow_idx + 1] !=3D PRIV_STACK_GUARD_VAL) {
> +			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
> +			       bpf_jit_get_prog_name(prog));

[Severity: Low]
Is the "%sx" format specifier intentional here? This looks like a typo that
would append a literal 'x' to the end of the program name in the error log.

[ ... ]

>  	if (!prog->is_func || extra_pass) {
>  		if (extra_pass && ctx.idx !=3D jit_data->ctx.idx) {
>  			pr_err_once("multi-func JIT bug %d !=3D %d\n",
>  				    ctx.idx, jit_data->ctx.idx);
>  			goto out_free;
>  		}
[ ... ]
>  out_offset:
> +		/*
> +		 * A NULL ro_header here means the JIT failed, so release the
> +		 * private stack that was allocated above; on success the
> +		 * program keeps it until bpf_jit_free().
> +		 */
> +		if (!ro_header && priv_stack_ptr) {
> +			free_percpu(priv_stack_ptr);
> +			prog->aux->priv_stack_ptr =3D NULL;
> +		}
>  		kvfree(ctx.offset);
> +out_priv_stack:
>  		kfree(jit_data);
>  		prog->aux->jit_data =3D NULL;
>  	}
> =20
>  	return prog;
> =20
>  out_free:
>  	if (extra_pass) {
>  		prog->bpf_func =3D NULL;
>  		prog->jited =3D 0;
>  		prog->jited_len =3D 0;
>  	}
> =20
>  	if (header) {
>  		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->siz=
e));
>  		bpf_jit_binary_pack_free(ro_header, header);
>  	}
>  	goto out_offset;
>  }

[Severity: High]
Does this code leak the private stack allocation when JIT compilation fails?
When jumping to out_free, ro_header is freed but the local pointer is not s=
et
to NULL.=20

Because ro_header is still non-NULL when execution falls through to
out_offset, the free_percpu() cleanup block is skipped. Furthermore, because
prog->jited is set to 0, bpf_jit_free() will also skip freeing it, resulting
in a permanent leak of the per-CPU allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618033809.9825=
3-1-dongtai.guo@linux.dev?part=3D2
