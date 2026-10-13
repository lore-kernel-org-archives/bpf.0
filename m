Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F31C84CB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854895; cv=none; b=LZWIOMpxRbaPnmXglW0+Ri/YoOJRn/GIDH6jqwIqYZu9vMjnbo2iDj+LCnAk+bMmnp0eBA+7neblpuuhEmiEtpHDii27HpW5B9IFsq0HoJDzEwphw1FyHb1OP927tH3VDZRibrVBNLI6iGoWybuHF3qXFjnHFSTGExbBukCH67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854895; c=relaxed/simple;
	bh=qknzAzbo2WIuCDjRAQ59Gwms7EM594cYXnpEUidPcEE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EbXFcfJkcvFKWecW+BSSuF0F8jnP1DF4Eoa45qNYhmp2M78057r8k4F9JXpyZwPZEaSuGgkwWxzNNauin1RdEvZiiwaoTfPGOsAT79j3PUf0de4wwWy2XUqTvOXUAM6RX+vKrHosm/Jt8j8z3hnep6VS9O9ig77VQEf+OCoEF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL4s7/kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL4s7/kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D641F0089B;
	Tue, 13 Oct 2026 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791854894;
	bh=6lwwpoverR67IGGxOb14ck6rIR/sMjpim4u6fAjv+4M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dL4s7/kbdLmrZ5AjykQjTcjKNEm4H/JMF8CDs7zXkUnt87I1SAWN2PGscvC4k4ktU
	 8FiYy7afPrxTheG586iJdL1DX2U4jLiVxzIG0GXtEV+w1kfbDEKmNcNpgAhXXp4zi4
	 VFecb931WDYlZUKZLPgsNKv+CLUU1hi6xITKeEawNw7Ksns6pmf1HQaxBUaDB1a3ov
	 nbaHXbZu7V+jMw077lrhlGo/BOVl4Gwos40eVaO3y3OsxrAhJi1/aNfW4b+wXrBpIA
	 rVrHmnaVQ+2Dk57xjs6LOmwfe3e5qLPRo3bIXA7E+NzWXIyyHMoMxTq0K+i1mlNDWe
	 MGXOnt+VFrHIw==
Content-Type: multipart/mixed; boundary="===============3818435198422104203=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27a2eb77876d70e316ad6e4c5d28f5c39a25b339388a29bf46679494268f700b@mail.kernel.org>
In-Reply-To: <20261013003454.1857445-1-yonghong.song@linux.dev>
References: <20261013003454.1857445-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 05/11] bpf, x86: Place trampoline arguments by the x86-64 calling convention
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 01:28:13 +0000 (UTC)

--===============3818435198422104203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Place trampoline arguments by the x86-64 calling convention

TL;DR: Nits only: two comments in the x86 trampoline code (save_args() and
__arch_prepare_bpf_trampoline()) could put the opening /* on its own line.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -3472,8 +3479,35 @@ static void save_args(const struct btf_func_model *m, u8 **prog,

[ ... ]

> +		for (j = 0; j < arg_regs; j++, slot++, bargs_off -= 8) {
> +			u8 pos = pos_of_slot[slot];
> +			u32 src;
> +
> +			if (!x86_arg_on_stack(pos)) {
> +				/* Only copy the arguments on-stack to
> +				 * current 'stack_size' and ignore the regs,
> +				 * used to prepare the arguments on-stack for
> +				 * origin call.
> +				 */

This isn't a bug, but this comment is re-wrapped in the new per-slot loop in
save_args() with text on the same line as the opening /*.  Could it use the
form with the opening /* on its own line, as is preferred in BPF code?

	/*
	 * Only copy the arguments on-stack to ...
	 */

[ ... ]

> @@ -3837,12 +3839,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  
>  	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
>  
> -	for (i = 0; i < m->nr_args; i++)
> -		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
> -
> -	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
> -	 * are passed through regs, the remains are through stack.
> +	/* x86-64 supports up to MAX_BPF_FUNC_ARGS argument slots, six in
> +	 * registers and the rest on the stack, where bpf_jit_place_args()
> +	 * puts them.
>  	 */
> +	nr_regs = bpf_jit_place_args(&x86_arg_abi, m, pos_of_slot);
>  	if (nr_regs > MAX_BPF_FUNC_ARGS)
>  		return -ENOTSUPP;

This isn't a bug, but the same applies to this reworded comment in
__arch_prepare_bpf_trampoline().  Could it also be changed to the form with
the opening /* on its own line?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38329598343
--===============3818435198422104203==--
