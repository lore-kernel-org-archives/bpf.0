Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2D47F762
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373703; cv=none; b=ea2ETVKhNbGNZq0NnkPvW009mNvqYfAZPjgVijVABkTIhVQ50rhqmX7zBMt8x/+oh2ibSIKdVkIzdpmVWm9eMOOysW8rkApevvLBuDghsLztCL8tUXLDgJBhR2yHs1hxuPaWm1AoGhp5LusFSzAT/rM1AzsgHq9/L56Rlg7+0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373703; c=relaxed/simple;
	bh=eR6I640Np5hSVWdetmUeAin19DSdY+ma1K/til9+OXo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WNcUsUo0QecTPxqIJQ80h1d4jDiYXabHBp02DxYTGJy8irXBuspTWp8k1LvnITaMPsH68x0WIFs85bpnMXcG+ql0jaQraPxgvYQ8933RGzKf43iLbGlOknbeLRDHemHzMKLiCI5z+bRKhDfIw8MeCFK2V9QAr3e5PJj7vDxh1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J61Enlzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J61Enlzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498CF1F000FF;
	Fri, 25 Sep 2026 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373702;
	bh=T6I2fTPRR8RlBIH2cyQVGzNc/Dp12F6wzkJk242K9J8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J61EnlzjDHujaqSNb12WZpYkN4Tqz37QD6MxHrV3s7vBtn63yLthZ8v4VY4sxhmG3
	 RzYJlfLjxEa2L0XH6EMTK/AMg95aEZA32+hA5VSFuDizn2m2xWxAOk39yh9Tev42tX
	 R6IZXf6fs2wABGxeBViZe/RFBKUrsi/bsaXwxQGfp/BN4OBcCaNor3UpCGTfPzX2RX
	 uGeaGEJDXIyTd1KKVIOQAozvXNnXDuoMkTr8YRaLT6ixbpSIvNS9NscvOKvr28VOCo
	 ufZ0reMIDGA0m0pi2REJAbJuG43EUyzdGhdGlky291Op1OC2/0L2ttYTkGRyiiswXR
	 1ymeVye6Y1MAA==
Content-Type: multipart/mixed; boundary="===============2585481607635438913=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <774eb23ef292825f25383caab985de85ec4475aca1f487263a97c0b894e9399c@mail.kernel.org>
In-Reply-To: <20260925211256.1834061-5-ameryhung@gmail.com>
References: <20260925211256.1834061-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/12] bpf: Check subprog scalar arguments in the common path
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 22:01:41 +0000 (UTC)

--===============2585481607635438913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4b683502c959..0f86feefbeb2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10872,10 +10872,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  		nslots = btf_arg_slots(t);
>
>  		if (arg_type == ARG_SCALAR) {
> -			if (reg->type != SCALAR_VALUE) {
> -				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
> -				return -EINVAL;
> -			}
> +			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
> +			if (ret)
> +				return ret;

Does this change inadvertently create diagnostics on the tolerated path?

For static subprogs, callx targets and callbacks, btf_check_subprog_call()
failures are tolerated (only -EFAULT is fatal):

    err = btf_check_subprog_call(env, subprog, caller->regs);
    if (err == -EFAULT)
        return err;

The comment in btf_check_subprog_call() explains this is because "Compiler
optimizations can remove arguments from static functions".

Before this patch, such a mismatch only logged the single line "R%d is not
a scalar". Now the same situation runs through code that writes a full
diagnostic straight into the verifier log:

- If the register is NOT_INIT (for example, the compiler dropped an
  argument), __check_reg_arg() calls bpf_diag_unreadable_reg(), which calls
  bpf_diag_header(env, REGISTER_TYPE_SAFETY, "unreadable register"). That
  prints "Verification failed: Register Type Safety: Unreadable register"
  and the suggestion "Initialize R%d on every path before this instruction."

- If the register holds a pointer, check_reg_type() calls
  bpf_diag_call_arg_fmt() -> bpf_diag_call_type(), which prints
  "Verification failed: Call Type Safety: Invalid call argument".

Nothing suppresses the output on the tolerated path, so verification
carries on after the log has already reported a failure.

Example: static __noinline int sub(int x) called with r1 = r10, or called
after clang removed the argument so that R1 is NOT_INIT. At log_level 2 a
program that loads successfully has this block in its log. At log_level 1,
the level libbpf uses when it reloads a failed program to fetch the log,
pop_stack() only rewinds the log to the push position of the branch being
resumed. So a block printed by such a call on the path that finally fails
(for example before its first branch) stays in the log ahead of the real
error. A user reading the first "Verification failed:" block is sent to a
harmless call site, with advice to initialize a register the verifier
deliberately does not require.

The ctx, dynptr and BTF-ID branches could already print diagnostics in this
tolerated path. This patch adds the same behaviour for scalars, the most
common static-subprog argument type and the exact case the tolerance was
written for.

Should diagnostics be muted, or the log rewound, when
btf_check_subprog_call() fails for a non-global subprog?

>  		} else if (arg_type & PTR_UNTRUSTED) {
>  			/*
>  			 * Anything is allowed for untrusted arguments, as these are

[ ... ]

> @@ -10965,15 +10964,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  		}
>
>  		for (k = 1; k < nslots; k++) {
> -			argno_t extra_argno = argno_from_arg(slot + k + 1);
> -			struct bpf_reg_state *extra_reg;
> -
> -			extra_reg = get_func_arg_reg(caller, regs, slot + k);
> -			if (extra_reg->type != SCALAR_VALUE) {
> -				bpf_log(log, "%s is not a scalar\n",
> -					reg_arg_name(env, extra_argno));
> -				return -EINVAL;
> -			}
> +			ret = check_arg_extra_slot(env, caller, slot + k, &meta);
> +			if (ret)
> +				return ret;

This extra-slot routing through check_arg_extra_slot() has the same
diagnostic behaviour as the scalar branch above.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36191749180
--===============2585481607635438913==--
