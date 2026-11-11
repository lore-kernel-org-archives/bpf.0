Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376646;
	b=JH1Z3hXAo+ijGF2Lyi/jicBYG2bAkxsmg6kf9IBjnOA0wRfncn+HThJMeIR3WkK59nTA
	 cmUhUWdCUBhPOzAX3mcX5M+rb82oKNISyKcBk/YKlkT4ZyJzeM+7aH2TvTE7MbjcAzB2y
	 DT9nFP4mieEHrma2qLlj35mj8kGjDiw7fJvFswgYGuz9TwbOjubQoM6yOrMCJRq1BAE3s
	 +kfVS20wath5DpWCvfQLJIK66A1Mos8l6fSFGFueaSc67wbef21Iu7jQlyM9E+0gUCKtG
	 yHLYbj3FbvukMVaJ0KmjJnkXrqKGpVgfVwV78A5QdolCG2L4fk8ZXcooJ6Qsxm0+aDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376646;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zJ3gmAhUG/wHgA+AL57VErPdcaRAFryCOX+lbljQeHs=;
	b=aeyXmunTHxz1weaHe8nJGrDYks/P8uCTrjv9z4Ug+JHKVdlzg40pCEqRhsHjPdQe/Smi
	 +yNSJNZ4TwSitn+xFXvYM2H8GfKCT0qKdRPl9dQOiLOrsTrtSWhla45yQ0i8Xc6EQAQBt
	 iWQkAux+OuVwhtxOv0cK25tR+8ICBUSKvEsEWyQrVYlZr2CoaPS4m18pTDzLZxLZ5cgVL
	 B+SWncvgaSn/cT0yVngM6a5GEOYYOiIZOBj8pDPF7awiGX3Py8Ab4QitcCNEj1tSOYzdS
	 9IEs1fO7yLlZLvgELCCXgrqAbvM0L6Up6Nk2W0jnAWT4vWb3nJWciLWbOJzsHPP2YzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ob1/QMJv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61B606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob1/QMJv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44441F00A05;
	Wed, 11 Nov 2026 05:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376645;
	bh=zJ3gmAhUG/wHgA+AL57VErPdcaRAFryCOX+lbljQeHs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ob1/QMJv824a2gmnphDUIzRMVhaTtKbNtFt8zY2e45n2K24gdiSaWzK0uJJqq0Kix
	 kA1br3U09lkC4ulq11NjU/u4UfDJqeZmEwJfGiBOq1H+oOCpADPzqJy/rzCT56PVM0
	 3+VGf+31NbGr3wBJUjppiluxRaF39TSBpN/b4pxUUuYvdI52dgYM/hfq5XR9Zfa+ii
	 GD1/MJwKmG8pwXQDueWyFRpJdCVzs+V0WPa4J0feZnnueJEQS4YpF3NyKXVCIrL7Q0
	 bpW2k1Lq29cVpR04iClk/5ojfnUPNz59j+fj5bSxhXOaXlCb8SBPaUKTZfKOhy7PV/
	 DLEapzwUajJcg==
Message-ID: <sashiko-outbox-208372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 20/29] bpf: Find a copy of an induction
 variable without scalar ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261111051341.2800252-21-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
 <20261111051341.2800252-21-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:57:25 +0000
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
- [High] bpf: type confusion between pointer and scalar bounds in
  is_iv_at_header()
--

commit a899486291f489b60aa159499a2316c95dbc938e
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Find a copy of an induction variable without scalar ids

This commit replaces COPY_SCEV and scalar ID checks for induction variable
copies with untyped expression comparisons via const_diff_at_header().

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 98a05f97196a6..28fd06c16fe4d 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -4585,6 +4518,19 @@ static void linear_bounds(struct bpf_reg_state *re=
g, u32 max_header_count,
>  	out->r32 =3D r32;
>  }
> =20
> +/*
> + * Is @r the induction variable that the latch tests, or congruent to it=
: equal to it at the header
> + * of the loop at @h in every iteration? Then the range of the one is th=
e range of the other.
> + */
> +static bool is_iv_at_header(struct bpf_verifier_env *env, int h, int iv_=
reg, u32 r)
> +{
> +	s64 delta;
> +
> +	if (iv_reg < 0)
> +		return false;
> +	return r =3D=3D iv_reg || (const_diff_at_header(env, h, iv_reg, r, &del=
ta) && !delta);
> +}
> +
>  static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
>  {
>  	struct cnum64 r64 =3D cnum64_intersect(bounds->r64, iv_range);

[ ... ]

> @@ -5128,7 +5074,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *en=
v, struct bpf_verifier_state
>  			if (err)
>  				return err;
>  			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
> -			if (coefs.base_reg =3D=3D iters->iv_reg)
> +			if (is_iv_at_header(env, insn_idx, iters->iv_reg, coefs.base_reg))
>  				iv_bounds(&bounds, iters->iv_range);
>  			if (log->level & BPF_LOG_LEVEL2) {
>  				bpf_log(log, "loop header at %d, widening ", insn_idx);

[ ... ]

> @@ -5251,7 +5196,11 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *e=
nv, struct bpf_func_state *cur
>  			continue;
>  clamp:
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> -		if (coefs.base_reg =3D=3D entry->iv_reg && !moved)
> +		/*
> +		 * iv_range is the range at the header. After the latch @r can be the =
zero extension
> +		 * of its header value. @reg went through that insn and has what holds=
 of the range.
> +		 */
> +		if (!behind && is_iv_at_header(env, insn_idx, entry->iv_reg, coefs.bas=
e_reg))
>  			iv_bounds(&bounds, entry->iv_range);
>  		if (moved) {
>  			/* a sum that can wrap has another residue, see scalar_step_add() */

[Severity: High]
Can is_iv_at_header() apply a pointer induction variable's offset range
(iv_range) to a congruent SCALAR_VALUE register?

const_diff_at_header() compares untyped SCEV expressions without checking
that iv_reg and r have the same register type in the loop-entry state.  In
transfer(), a no-op 64-bit BPF_ALU | BPF_END (such as le64 on a
little-endian host) leaves reg2expr[dst] unchanged:

kernel/bpf/scev.c:transfer() {
    ...
			need_bswap =3D class =3D=3D BPF_ALU64 || ((x_or_k =3D=3D BPF_TO_LE) !=3D=
 little_endian);
			switch (insn->imm) {
			case 16: op =3D need_bswap ? BSWAP16 : ZEXT16; break;
			case 32: op =3D need_bswap ? BSWAP32 : ZEXT32; break;
			case 64: op =3D need_bswap ? BSWAP64 : 0; break;
    ...
			id =3D reg2expr[dst];
			if (op)
				id =3D expr1(scev, op, reg2expr[dst]);

			return replace_reg(scev, e, dst, id);
}

When env->allow_ptr_leaks is enabled, check_alu_op() degrades a pointer
register passed to that instruction to an unknown SCALAR_VALUE while the
instruction preserves the raw 64-bit pointer value at runtime.

If iv_reg is a pointer induction variable (for example PTR_TO_MAP_VALUE
with offset in [1, 10]) and r is copied from iv_reg and passed through a
64-bit no-op BPF_END both before the loop and on the backedge,
compute_header_scevs() and is_iv_at_header() treat r as congruent to
iv_reg.  bpf_widen_scev_regs() and bpf_clamp_scev_regs() then intersect
r's scalar bounds with iv_range, causing the verifier to bound a register
holding a raw 64-bit kernel pointer to the small scalar range [1, 10] and
allowing out-of-bounds memory access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111051341.2800=
252-1-alexei.starovoitov@gmail.com?part=3D20
