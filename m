Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665593;
	b=0H68U/WtJJSwK4cMpKmcfLFPKclsCuB8xX170M4MhEZCIchNznF6SQYHCEfehBeQ7hOX
	 TsLU5dY/WTXIQCkPXLgGW1897AtVK/Xjp1iVzqlddR8bV29xFly7whhCG73iwg/x+FP9a
	 fHqYN6IfAgY5l9tzBxsbsFVOXQOS1IwFq2Iw7UkET4NESxF8kDWC7D25qfh8Y+NFOYFB1
	 Ay3UtM0Kq29kYA+BW2d1Ot/hDqEoZoP7QJz8q9rJwwOqGNlW05qzbEJEq1H4j/KmN3nPL
	 93rKrxwPfe5Vs6Tn8LFTPB8ABylHsm4jIYp7pDVTS3BBbqx3BIYoHG0QI/KLwQtwxig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dq9r5zjnwfyjhLD5jAAfeM3BPq0EkqFCr6nxUg4GyYI=;
	b=FqeKOj5Ls7ScxBzNAtxdOnGP1Jq3skFfs6obsNVg2ifEnyhcahrfjgi1fD0gz/sxufzK
	 axbyxyrrKhuITuBj+vnc5DERv+1gmcjUWK5dgOtgWedPvrwN/zlsyqAScabKcvRQ8gm8W
	 qCgoEDogePip9Aixu0NyfSenwCNT13XgoslWBENMGLugvVvOm5LsWbwDLODs/DE0U2DXA
	 e9pcolXC2a3ynDkMWMiQu050Pscb6WBlRnrTdRRc2/rlN4SH5B17biHva7dpdASYPMPgh
	 2RjBHvJbxCPypZXRqdX7J2h/hMdwyVI96XULatOXRzk+LHj8VqXmy3joAPykw6M/Ypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwh6bZ7+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0D606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwh6bZ7+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2061F000C4;
	Thu, 26 Nov 2026 03:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665593;
	bh=Dq9r5zjnwfyjhLD5jAAfeM3BPq0EkqFCr6nxUg4GyYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwh6bZ7+5czkxPg4uQFrndbehXyt22+6WJXhqR1DEIC2LTuGlbkYGT34uVfh/ZEe9
	 AzrY5PiwvPNjCjDDsxVhKbwnCTsrRt3QbncnZLEYhkKot4+fDwLdy1aUWJak/H7gRg
	 e50R/REA8NeXaP1q0g+2CPyaDSbQzeaErOmkVNI0AC/II7URLhYlcnFS3dBkS2AwYN
	 iHYDBmJmZ59Xu80gshLgvXZEKUjoPHwbDOqvpzMGpC6vrGR6g7rvmoUcakT3WLjB7o
	 /jVtNABmjSVgg6dZmyCcOQR6C3EZL98y1hmx0ZaNiPgiHqol5LatuizFiDc2PBsncE
	 TUmahg+3MLTNA==
Message-ID: <sashiko-outbox-234712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] LoongArch: BPF: Add support for exceptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126034048.7370-3-dongtai.guo@linux.dev>
References: <20261126034048.7370-1-dongtai.guo@linux.dev>
 <20261126034048.7370-3-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 03:59:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] LoongArch: BPF: missing save/restore of s7 and s8 for exception
  progs
--

commit 64e60e0cab39cdd5da1ae8974c3aaebabf22619c
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Add support for exceptions

This commit adds BPF exception handling support to the LoongArch JIT compil=
er
when CONFIG_UNWINDER_ORC is enabled, updating build_prologue() and
__build_epilogue() so exception callbacks reuse the boundary program's stack
frame.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3ff15b64925f1..19907612a51c5 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -120,8 +120,8 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx =
*ctx, int *store_offset)
>   *                            +-------------------------+
>   *                            |           tcc_ptr       |
>   *                            +-------------------------+
> - *                            |           arena         |
> - *                            |         (optional)      |
> + *                            |   $s6 (arena/exception) |
> + *                            |        (optional)       |
>   *                            +-------------------------+ <--BPF_REG_FP
>   *                            |  prog->aux->stack_depth |
>   *                            |        (optional)       |
> @@ -133,6 +133,13 @@ static void build_prologue(struct jit_ctx *ctx)
>  	int i, stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>  	const struct bpf_prog *prog =3D ctx->prog;
>  	const bool is_main_prog =3D !bpf_is_subprog(prog);
> +	/*
> +	 * Exception boundary and callback programs must agree on the frame
> +	 * layout: the callback reuses the boundary's frame to restore its
> +	 * callee-saved registers, so the s6 slot is always reserved for them.
> +	 */
> +	const bool is_exception_prog =3D prog->aux->exception_boundary ||
> +				       prog->aux->exception_cb;
> =20
>  	bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, 16);
> =20
> @@ -142,7 +149,7 @@ static void build_prologue(struct jit_ctx *ctx)
>  	/* To store tcc and tcc_ptr */
>  	stack_adjust +=3D sizeof(long) * 2;
> =20
> -	if (ctx->arena_vm_start)
> +	if (ctx->arena_vm_start || is_exception_prog)
>  		stack_adjust +=3D sizeof(long);

[ ... ]

> @@ -201,13 +221,14 @@ static void build_prologue(struct jit_ctx *ctx)
> =20
>  	prepare_bpf_tail_call_cnt(ctx, &store_offset);
> =20
> -	if (ctx->arena_vm_start) {
> +	if (ctx->arena_vm_start || is_exception_prog) {
>  		store_offset -=3D sizeof(long);
>  		emit_insn(ctx, std, REG_ARENA, LOONGARCH_GPR_SP, store_offset);
>  	}

[ ... ]

> @@ -261,7 +285,7 @@ static void __build_epilogue(struct jit_ctx *ctx, boo=
l is_tail_call)
>  	/* Skip the unused local 'tcc_ptr' slot to align with arena */
>  	load_offset -=3D sizeof(long);
> =20
> -	if (ctx->arena_vm_start) {
> +	if (ctx->arena_vm_start || is_exception_prog) {
>  		load_offset -=3D sizeof(long);
>  		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
>  	}

[Severity: High]
Do build_prologue() and __build_epilogue() also need to save and restore
LOONGARCH_GPR_S7 and LOONGARCH_GPR_S8 when is_exception_prog is true?

In the LoongArch C ABI, s0 through s8 are callee-saved registers.  JITed BPF
programs normally leave s7 and s8 untouched, and any called C function saves
and restores them in its own frame.  When bpf_throw() unwinds the stack,
however, bpf_throw() and its callees never run their epilogues; the excepti=
on
callback restores only the boundary frame and returns directly to the
boundary program's caller, leaving s7 and s8 clobbered if any unwound C
function used them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126034048.7370=
-1-dongtai.guo@linux.dev?part=3D2
