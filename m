Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA321F1534
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668758; cv=none; b=oiUkdTF6DwAAcj6Mv0RFJfI7SPWQpXEcaXvl1RwzC/XVC31hkIdUNUqVDSsmY6AICW48ip3BhDcUt0a9uXm5E5CFBki4j9uyRZHj2zR2HfFyHBCy0hR43ivoVqoGHvDvnPWrFGDgOnfQz5+FP7qOZDtf3LW02Hj95eCNn1xhwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668758; c=relaxed/simple;
	bh=8Mepd5zi626exT2MDwl6FFhlv6eEA77pYyTYIOhdrVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHu8puXBq8DXeOl3gIhOMFsuEpCJA59vG9ou1LmgHyeRY1o9a7Syx5TE+7DUn6RLQcTkTletjb6nLcPUB2n7Dl7ODDt7LrTS9hax/xyuApeIoMVZk2fviJg1JtXpeb8jYQ8mDQoYzpUbNIa/iuuWjC0HJ80yTRGB7QJTXF4D+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAWlY+/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAWlY+/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD84F1F00A3A;
	Fri, 14 Aug 2026 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668757;
	bh=QnOn4C7to3ToHmX1kz+ytbwDJlhyjwBGiKgfN8RkZm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAWlY+/6xs6/xThZOd2lVD4rHnAFlNAeT9kAK+A7MP7vqI991g79Lgd+L2oHfxmW5
	 ABW8Z1NZ+BrJc8pzfhWnvUPJQxggjZkbSgYvKEh3vENRUK5ovA97T8naz0gOZ78tIl
	 fqdwn8lYZyoqatjtVQv+rg30dfzf/YPZC/G01kyUhrojalh/GzjIpyEoZW1Bnc06b5
	 Jybvmc3NgfKFrWHQuV/k+dl+/E9dgKSPNxJNRpl7TvzUnAeM+1dNVeXIyvD2fBBpxw
	 amIeBy2UXXLUQZoYiNSrE/IfpaEcUyMnBf/DjNmtJkM7mGD8kUTk+o6wRjEtDEPX1K
	 7JEB1DUuBF+3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 09/17] bpf: Track r11 registers in
 const_fold and liveness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163402.734987-1-yonghong.song@linux.dev>
References: <20260419163402.734987-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:52:31 +0000
Message-Id: <20260814005236.CD84F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The stack arguments feature is entirely blocked because BPF_REG_PA=
RAMS is unconditionally rejected during initial instruction sanity checks.
- [Medium] State tracking corruption due to early returns skipping register=
 invalidation for BPF_REG_PARAMS
- [Medium] Out-of-bounds access in verifier register checks when using BPF_=
REG_PARAMS in unsupported instructions
--

--- Patch [9]: [PATCH bpf-next v6 09/17] bpf: Track r11 registers in const_=
fold and liveness ---
commit 9af64f45f038d2b8f7990714d3dc13da2d1fbc25
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Track r11 registers in const_fold and liveness

This commit adds early returns in the register tracking arrays for
const_fold.c and liveness.c when instructions use BPF_REG_PARAMS (r11).
It aims to prevent out-of-bounds accesses and invalidates the destination
register for BPF_LDX instructions to avoid leaving stale states.

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index db73c4740b1e1..41e5a406432c4 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -51,13 +51,23 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>  			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>  {
>  	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
> -	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> -	struct const_arg_info *src =3D &ci_out[insn->src_reg];
> +	struct const_arg_info *dst, *src;
>  	u8 class =3D BPF_CLASS(insn->code);
>  	u8 mode =3D BPF_MODE(insn->code);
>  	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
>  	int r;
> =20
> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
> +	if (insn->dst_reg >=3D MAX_BPF_REG)
> +		return;
> +	if (insn->src_reg >=3D MAX_BPF_REG) {
> +		if (class =3D=3D BPF_LDX)
> +			ci_out[insn->dst_reg] =3D unknown;
> +		return;
> +	}

[Severity: Medium]
If an ALU or atomic instruction uses BPF_REG_PARAMS (r11) as a source or
destination register, is it possible that this early return skips clearing =
the
destination register state?

If an ALU instruction uses r11, it looks like the destination register's
tracking state is not invalidated, retaining its previous, potentially stale
constant state. Similarly, an atomic store (BPF_STX) to r11 could return
early without invalidating R0 for BPF_CMPXCHG.

Could this lead to dead branch elimination errors or forged pointers?

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 332e6e003f270..87022da94f3a0 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -1068,11 +1068,21 @@ static void arg_track_xfer(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>  	int depth =3D instance->depth;
>  	u8 class =3D BPF_CLASS(insn->code);
>  	u8 code =3D BPF_OP(insn->code);
> -	struct arg_track *dst =3D &at_out[insn->dst_reg];
> -	struct arg_track *src =3D &at_out[insn->src_reg];
> +	struct arg_track *dst, *src;
>  	struct arg_track none =3D { .frame =3D ARG_NONE };
>  	int r;
> =20
> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
> +	if (insn->dst_reg >=3D MAX_BPF_REG)
> +		return;
> +	if (insn->src_reg >=3D MAX_BPF_REG) {
> +		if (class =3D=3D BPF_LDX)
> +			at_out[insn->dst_reg] =3D none;
> +		return;
> +	}

[Severity: Medium]
Looking at this similar early return, could it skip updating the liveness
tracking for ALU and atomic instructions that use BPF_REG_PARAMS?

While reviewing this feature, I also noticed a couple of related issues in
kernel/bpf/verifier.c:

[Severity: Medium]
In kernel/bpf/verifier.c:__check_reg_arg():

    reg =3D &regs[regno];

When an ALU, JMP, or ATOMIC instruction uses BPF_REG_PARAMS (r11) as a regi=
ster
operand, it appears this might access the regs array with an index of 11.
Since the verifier's regs array is sized exactly MAX_BPF_REG (11 elements,
indices 0-10), could this lead to an out-of-bounds access?


[Severity: High]
In kernel/bpf/verifier.c:check_and_resolve_insns():

    if (insn->dst_reg >=3D MAX_BPF_REG) {
        verbose(env, "R%d is invalid\n", insn->dst_reg);
        return -EINVAL;
    }

Is BPF_REG_PARAMS unintentionally being rejected during the initial sanity
checks here?

Since BPF_REG_PARAMS is defined as MAX_BPF_REG (11), any instruction
referencing r11 seems to be immediately rejected with "R11 is invalid" befo=
re
core verification begins. Should this bounds check be updated to accommodate
the new register?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D9
