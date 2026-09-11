Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897D4A0924
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143575; cv=none; b=LueSOBnBWADOaXWd5NCKc6qs4a19kQRUdHSeiTBGLxozOkKuQ3pEwpid7CDGuf9OhDiZmFRhCd0lRwcSABBD8mLzgxpgqbccdaeXzIrOiyiAm/erMfc6CorxgA17uLXyeKBpaCGvQixfDkEvOW2kpXCcMZrwXrWJwwL339XFzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143575; c=relaxed/simple;
	bh=1uR5awNRtdbIVnZtq/VUTOni1QwgUBR1DKXzAujxEok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TExQBLhMcl5m6l4cNznuX6SNOtNveHNnbQgXTq38DHgr1B4BO3rve7HIAIHzbCxUWWBqdlGr9I9Q2ouqX+owKFHgTYlFzVO7t/1/H3Y/poMkAThCIadTx/DMVbq7RI3FosDxa7k3Yuy87NBcxyX89Z+KB8E1H0aeWAuBP/is4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HngGm51l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HngGm51l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B9B1F000FF;
	Fri, 11 Sep 2026 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143573;
	bh=3zizEVrwjZoYjx+sJFwRWO5N3A+1hXHva+wkxbApbyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HngGm51lKgZkwZAbjsBgLPyArKUSSEXEZ2Q3JKkg3TPHxjuP0sFPGXQ/scfymv5g7
	 F4Lp/Ld1ded7PyaOI38AVqO+sIzIBNCgZ4vfdnmNXLr1N8ZZdWrjvhI1QGaDk1DogG
	 RUvfkjP4za0nIfSUkr38OuDYxRsm0Wi6mysB4pa8EaVW4cnS4YnDA5EE5iJRDub17b
	 D43j1CqCclux0+0EDLRb3bIrRFP4Y3rKoaj8B93maWlv58d78X2jeVXSmTwqm1Buce
	 7z+jyMxB9qm0RsqEGydgdDHWwuvY1eOHwhA02qJATlkr4GR4whLsiVBMx4Qwk4yI85
	 C+6vkzo9c+1DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 11/15] bpf, arm64: Move kfunc arguments into
 the arm64 calling convention
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911155010.2011265-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
 <20260911155010.2011265-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:19:32 +0000
Message-Id: <20260911161933.01B9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The ARM64 BPF trampoline incorrectly saves and restores 16-byte al=
igned arguments, violating AAPCS64 alignment rules.
--

commit cd40aa31f4bf1158416008f7fcb9c0b7717dda3f
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, arm64: Move kfunc arguments into the arm64 calling convention

Do the proper move from the BPF calling convention to the arm64 calling
convention to satisfy the native requirement. AAPCS64 only ever moves an
argument to a higher slot, so the moves need one scratch register to carry
an eightbyte from one stack slot to another, and never the one a
convention moving an argument down would need.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3aa3ea0bc30bb..bbde7c0836ae5 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2534,7 +2598,13 @@ struct arg_aux {
>  static int calc_arg_aux(const struct btf_func_model *m,
>  			 struct arg_aux *a)
>  {
> -	int stack_slots, nregs, slots, i;
> +	int stack_slots, nregs, slots, i, total;
> +
> +	/* arm64 supports up to MAX_BPF_FUNC_ARGS argument slots */
> +	for (i =3D 0, total =3D 0; i < m->nr_args; i++)
> +		total +=3D (m->arg_size[i] + 7) / 8;
> +	if (total > MAX_BPF_FUNC_ARGS)
> +		return -ENOTSUPP;
> =20
>  	/* verifier ensures m->nr_args <=3D MAX_BPF_FUNC_ARGS */
>  	for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {

[Severity: High]
This isn't a bug introduced by this patch, but since the series introduces
support for by-value 16-byte arguments, this previously dormant ABI violati=
on
in the BPF trampoline appears to now be actively reachable.

Does calc_arg_aux() fail to account for skipped registers due to alignment
requirements?

If a user attaches a BPF program to a kernel function (or struct_ops
callback) that takes a 16-byte aligned argument (e.g., __int128 or
by-value struct) preceded by an odd number of register-sized arguments,
the native AAPCS64 caller places the 16-byte argument in an even/odd
register pair (like x2 and x3, skipping x1).

However, the nregs calculation here simply increments by slots without
checking for skipped odd registers:

arch/arm64/net/bpf_jit_comp.c:calc_arg_aux() {
    ...
    for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {
        slots =3D (m->arg_size[i] + 7) / 8;
        if (nregs + slots <=3D 8) /* passed through register ? */
            nregs +=3D slots;
    ...
}

This strictly sequential register handling seems to propagate to both
save_args() and restore_args() in the trampoline, where arguments are
read and written sequentially without skipping odd registers:

arch/arm64/net/bpf_jit_comp.c:save_args() {
    ...
    slots =3D (m->arg_size[i] + 7) / 8;
    while (slots-- > 0) {
        ...
        emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
        reg++;
        bargs_off +=3D 8;
    }
    ...
}

arch/arm64/net/bpf_jit_comp.c:restore_args() {
    ...
    for (reg =3D 0; reg < nregs; reg++) {
        emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
        bargs_off +=3D 8;
    }
    ...
}

Could this cause data corruption for arguments passed to BPF programs
attached via fentry, fexit, or struct_ops when 16-byte arguments are
involved?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911154914.2004=
336-1-yonghong.song@linux.dev?part=3D11
