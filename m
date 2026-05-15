Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC532745E
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824940; cv=none; b=ZKFRVWuOznw11X9ZTtnDpyq7gCiGvG/MUvMwNsXfCY5eX5N8I0CBv38GLTS3a1ARizvKXmZ36WIfIii1iofxeVnf9wGGMgYn+bajrrrfWgLndU0TglYEVf97dj6r028rH8uqZkI4VCgx4vQAgu0SbJmmOF1yVGczvnx0TlJbZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824940; c=relaxed/simple;
	bh=RTlbYjrkgycTW/O7fngKv0EA7v+a4oC9Oey5zoF6/7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m6Yai1uO16xJLaqg2KsXYLw5CKKHn6kFyDqIMOYnvGl7VSt8MhFyIQXOkZr/uaxHW7gg1iFWhVdKqfEC3Yj92I7b00peRzvMLRKDbjINNyycQV7qZUIgtYeoTRlEBLtqUg1pPpveL7VstVfTCWBr5wFdq57QovLCMujnRtb+Fz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdr/E5sV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdr/E5sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD991C2BCB0;
	Fri, 15 May 2026 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824940;
	bh=RTlbYjrkgycTW/O7fngKv0EA7v+a4oC9Oey5zoF6/7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gdr/E5sVeiylEsCyUpFWDLEB8gHTOdx29mZk/m13+s1ougCZo2MP8kD48m/Dm12+M
	 9sN4QYVZEApTH34mQmEgEqRl5UKKJ/cQ+nXNKRPrf3GwqBRC4C7VoIPaXxmG7X+Q75
	 YiykEL6f6+9zoF1rTMZYHLLiylSHDKhWerLPG+FOSfw9AZLkhGp+luCmyVvrq0jRrm
	 VTtKtqh4OKyeyyZc5KtW2krKHIL1ssyuWShX12jbqpT9r1O83UtNdxGXUUrUYRgxUe
	 0YTOmMesrH28Z/EYvBapVeUX5AafCMcwJpxKDNDPF/vDH7iJGCnxxGC+vOceVpvWEe
	 IYHbrJqI05ZPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 17/25] bpf,x86: Implement JIT support for
 stack arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045122.2393118-1-yonghong.song@linux.dev>
References: <20260513045122.2393118-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:02:14 +0000
Message-Id: <20260515060214.CD991C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] When a BPF program with an exception boundary calls a function=
 with more than 5 arguments, unwinding an exception via bpf_throw() restore=
s callee-saved registers from the wrong stack offset, corrupting kernel reg=
isters.
--

commit 86dff956386bae1d3e030c84363f5b56f2e023a7
Author: Yonghong Song <yonghong.song@linux.dev>

bpf,x86: Implement JIT support for stack arguments

This commit implements x86_64 JIT support for BPF functions and kfuncs with
more than 5 arguments. The extra arguments are passed on the stack, maintai=
ning
compatibility with the x86-64 calling convention. It introduces logic to ha=
ndle
pushing outgoing arguments to the stack area below the callee-saved registe=
rs.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abff..ceefefb4da217 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1700,6 +1755,42 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  			push_r12(&prog);
>  		push_callee_regs(&prog, callee_regs_used);
>  	}
> +
> +	/* Compute callee-saved register area size. */
> +	callee_saved_size =3D 0;

[ ... ]

> +	/*
> +	 * Allocate outgoing stack arg area for args 7+ only.
> +	 * Arg 6 goes into r9 register, not on stack.
> +	 */
> +	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : =
0;
> +	emit_sub_rsp(&prog, outgoing_rsp);

Does allocating the outgoing stack arguments area (outgoing_rsp) after push=
ing
the callee-saved registers cause an issue when unwinding an exception via
bpf_throw()?

When bpf_throw() is called, the stack unwinder (arch_bpf_stack_walk()) capt=
ures
the current stack pointer (sp) of the BPF frame, which points to the bottom=
 of
this outgoing_rsp area.

bpf_throw() passes this shifted sp to the exception callback in the rsi
register.

The JIT-generated exception callback executes mov rsp, rsi followed by
pop_callee_regs(). Because rsp is offset by outgoing_rsp bytes below the ac=
tual
saved registers, the pop instructions will read from the outgoing arguments=
 area
instead of the saved registers.

Could returning to the kernel with corrupted callee-saved registers cause
unpredictable behavior or panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D17
