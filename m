Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162689;
	b=qjD1EP3PEto6OSvMunV4PyEL1hip+F19MYAsh/ovuPJg3iql53HTfWWaPJMFTg0DPf2o
	 1xG4uASOnv77oWkfJ6uf5urSJJ07B3qzi9/LY6p/XXyZGO5hFOE+XENfclAHennKDVa62
	 sQzLJZjpKoRNDv9XoafARISBHi3vqaY7jHpU+beH/DiXsV8/LsS3tIvYOzPG4bQZXSAsW
	 2Tb4sPbbVp6lbnvrqS87TY7wzEXB/Hs0CP4THqJ+sJ4Zzb29nnm18RQZz1fQ/14eyx9cz
	 ge3oGClTr/yatNCoWljwVaqTuUo12hOw/pPwxCinnZ1rpsxG+KKdAn/Gj5kx34LD5FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HvYhy5EfV3Wusj9+rJVmSHHQ89gWCeySCZQACvxxTvU=;
	b=icMfz2ZnTYZkDHyxJu12rod0rziZcK5IY7oh7I4Mj0grK3Uk2T1T2Ti32M109P1pPbJE
	 tLLwEX9x/1vDgc4tL5sovH3L5PRZFaaKl07JA9c8V//pWuLq30NL6q3xQlGIQDzaPOdPD
	 8rPZfUyCn353B4r7bloPy0ioDGc8w5imk8nIacALUt0kFrUe6SgWL6bNRp5HJ3T8TvWjD
	 ILJDQMGWNdLIGbdeRfzoHLZxa/WJp3F53nnQ7f95WcMoqHhNdlmbQN/mDrxZqbEXoQ+wA
	 ojLUgIqdcSi1B/Nk/CtVNaHgfMff8ZPkwG6dsxAZPOUubty+R1nmT3ck5/YNRKzyEwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BNFbn7/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068C606A336
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNFbn7/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752561F000D1;
	Fri, 20 Nov 2026 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162689;
	bh=HvYhy5EfV3Wusj9+rJVmSHHQ89gWCeySCZQACvxxTvU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BNFbn7/HspFlkgRfzVu4HwzP3s7R5phsPGH8AbeEZT6Y2Bagr9Nmb56I/ehcw4xEG
	 cvAFtgxuzEkKGOXUjkcv5WSh232iCWyn133e9UOzUJco+KFDRlLojGukf/G37qpMgF
	 h4odMuh10eVjVdgQJJB5plTmwxQzm8DvFh0zXR0pOcXKOpLGRpQEXHrNidzFbL9eOt
	 2QNAo3zgTf4pI71EF7fLGC7eCZEhKTRnu2AUJZARB5MpUf+3JWYxfikK838Mbje5HB
	 xS/1e+O5cZ9+l3ylH5PCkoSbmB1Y4xfq+muotHKmd6BxjRc22JUTqskCBIOUhapZFe
	 HrVPOOfFrKEYA==
Message-ID: <sashiko-outbox-224702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 12/49] bpf: Keep more of what is known about a
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-13-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:18:09 +0000
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
- [High] bpf: scalar_intersect() zeroes upper 32 bits of var_off when
  bits is 32
--

commit cf38506673fee86eba3e381affed0c24f4518bbf
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep more of what is known about a number

This commit refines six BPF verifier scalar transfer functions to preserve
more range, known-bit, parcial spill, and linear step information.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de3e9675e509f..3229372c5f496 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3994,6 +3999,10 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  				/* coerce_scalar_to_size will adjust the boundaries. */
>  				state->regs[dst_regno] =3D *reg;
>  			} else {
> +				/* the low bytes are from the spill */
> +				bool fill_exceeds_spill =3D
> +					size > spill_size && !(off % BPF_REG_SIZE) &&
> +					!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
>  				int spill_cnt =3D 0, zero_cnt =3D 0;
> =20
>  				for (i =3D 0; i < size; i++) {
> @@ -4033,6 +4042,10 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  				} else {
>  					mark_reg_stack_read(env, reg_state, off, off + size,
>  							    dst_regno);
> +					if (fill_exceeds_spill)
> +						scalar_intersect(scalar_of(&state->regs[dst_regno]),
> +								 scalar_of(reg),
> +								 spill_size * BITS_PER_BYTE);
>  				}
>  			}
>  		} else if (dst_regno >=3D 0) {
[ ... ]
> @@ -18921,16 +18957,22 @@ bool scalar_intersect(struct scalar *dst, const=
 struct scalar *src, u32 bits)
>  	/* tnum_intersect() of two tnums that don't overlap is not empty */
>  	if (!tnum_overlap(a, b))
>  		return false;
> +	s.var_off =3D tnum_intersect(a, b);
>  	/*
>  	 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on =
a zero extended int
>  	 * refines nothing but the 32-bit range.
>  	 */
> -	s.r32 =3D cnum32_intersect(dst->r32, src->r32);
> +	if (bits >=3D 32)
> +		s.r32 =3D cnum32_intersect(dst->r32, src->r32);
>  	if (bits =3D=3D 64) {
>  		s.r64 =3D cnum64_intersect(dst->r64, src->r64);
> -		s.var_off =3D tnum_intersect(a, b);
> -	} else {
> -		s.var_off =3D tnum_with_subreg(dst->var_off, tnum_intersect(a, b));
> +		if (src->step % dst->step =3D=3D 0) {
> +			if (src->base % dst->step !=3D dst->base)
> +				return false;
> +			s.step =3D src->step;
> +			s.base =3D src->base;
> +		}
> +		s.r64 =3D cnum64_intersect_linear(s.r64, s.base, s.step);
>  	}

[Severity: High]
Does dropping tnum_with_subreg() in scalar_intersect() falsely mark the
upper 32 bits of s.var_off as known zero when bits =3D=3D 32?

When bits < 64, a and b are truncated with tnum_subreg(), which clears the
upper 32 bits of both value and mask to 0.  Assigning s.var_off =3D
tnum_intersect(a, b) directly then causes scalar_bounds_sync(&s) to clamp
s.r64 to a zero-extended 32-bit range.  For example, a 64-bit stack fill
overlapping a 32-bit scalar spill and 32 bits of STACK_MISC calls
scalar_intersect() with bits =3D=3D 32 on an unknown 64-bit dst register,
leaving the verifier believing the upper 32 bits of dst are zero while at
runtime they hold arbitrary STACK_MISC data.  (A later commit in this
series, commit "bpf: Mark a state that no run of the program has",
reworks the bits < 64 handling in scalar_intersect() to preserve the upper
bits, so moving that change here would avoid this regression in
intermediate commits.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D12
