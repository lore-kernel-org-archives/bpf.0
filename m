Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163117;
	b=Q3p5S5SkJy6csPoe+VeUmoM1MOzThAarJ29T0Jv0suKpSVLm11EO87yLFlM4rHGaOEos
	 ot8GvEGFViYA8I1GbLXJ2Fo1+Iy0/UfB0kwaBjGjY1/kQ+GMsKciZIKDK7X61Q1KDduKz
	 UrgZPxDY3ygQpd92v5oc3ld8b3pXv+aXcMWsnjYWGRbn1eZ0y8lOs5aU4jU89k0cQCYbk
	 wp1MboT5ef/gSN8efpbMahgN+r7qTeYwtatT/q4UKKj1g30GxTwha8GGpVT3ZpBaK2N+k
	 cMyg89B07hS6qwQtkpAqIdhWcKpWT8hBKG+sL5++jtM8JF3Ri6O+rPyagyEQ7t0+eEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163117;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TFtjb58aZEIqikjFp+mhElbGl3RqKyvfM3yJlnwP+mA=;
	b=QmWp6KnzP13rUJDjq8NXXOTTUDtmhp6iVvCVV+DKFd0R+/3X5fJ/KNk0BV8A0+Ef1vz/
	 1cJdTk/n+z1prm7Css1HMfuqjmih2VT+wzfxrc+5LNG+fxFeAtNkDZY8ad5kAaoTAW1BB
	 t3c+QF5xv0ApC3GqyF9u6ZYd6XEHsJ9IU85uxrMz5vtwRf+6riLpEoVauchP8GcULfD8V
	 vnjhMvNQjdP3JHOl3/74gsyYsCFNV0oI1BmZv4E4KMcvIDPhH+t9hA7XcG3/i77ZMIjva
	 8ep0BDyVdleky9TBeQhivcMXC5awC1RFrhRftjcIJU9qASRtGjEuj7RQ0sXo2b6P3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqR9gZar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B263606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqR9gZar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098D11F000C4;
	Fri, 20 Nov 2026 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163117;
	bh=TFtjb58aZEIqikjFp+mhElbGl3RqKyvfM3yJlnwP+mA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PqR9gZarTb+RRH0tQZzz/tkeBZvtr33oGl3LamGGIC40jKkNk14wgRYC0y6p5T2uf
	 KOnl96b6ptCz7PL1T2AAQrwRE6UYkd7bn99Mp/rIaYFc1CqjWXytIF094n4PtKYmiQ
	 kMNVbbpFQKj2NV4XwMKGEsANBiZPd2m5RsdcwsPtvi4xwqVg8tkHO24p4tzrVxK+I8
	 JCX6QrdKsfkZsr7wunQ5sCuDytK3BaCX7F5361kDjms2UPuXJLBukWXf6HCrEcyivJ
	 0EmPJ8c0SdJ8ggDy8qDUwGJphe/nSKKZC6MojybdsbtVVa+Y2lFEueMABUjXE9eE2P
	 +ZBFWX107DRxQ==
Content-Type: multipart/mixed; boundary="===============3053629218588268660=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8d8fc59d0e40030219d1da9e05860aa0428d3c11ac26184c48c59cf97bcbd42d@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-13-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/49] bpf: Keep more of what is known about a number
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:15 +0000 (UTC)

--===============3053629218588268660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep more of what is known about a number

TL;DR: scalar_intersect() may mark the upper 32 bits of a 64-bit fill over a
smaller spill as known zero, so the verifier could accept out-of-bounds map
accesses; fixed only later in the series, breaking bisection.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -4033,6 +4042,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  				} else {
>  					mark_reg_stack_read(env, reg_state, off, off + size,
>  							    dst_regno);
> +					if (fill_exceeds_spill)
> +						scalar_intersect(scalar_of(&state->regs[dst_regno]),
> +								 scalar_of(reg),
> +								 spill_size * BITS_PER_BYTE);
>  				}

Can this make the verifier believe the upper 32 bits of the loaded value are
known zero?  The commit message says "w1 is 5", but the code seems to make
the whole 64-bit register known.

With a 4-byte spill, bits is 32 and scalar_intersect() now does:

    if (bits < 64) {
        a = tnum_subreg(a);
        b = tnum_subreg(b);
    }
    ...
    s.var_off = tnum_intersect(a, b);

Both tnums are cut to their low 32 bits, so the result has the upper 32 bits
known 0.  The previous code kept the destination's upper bits with
tnum_with_subreg(dst->var_off, tnum_intersect(a, b)), and that call is
removed here.  scalar_bounds_sync() then narrows r64 to the low-32 range.

Take a CAP_BPF program:

    r6 = 0
    *(u32 *)(r10 - 8) = r6      ; 4-byte scalar spill
    *(u32 *)(r10 - 4) = 1       ; upper half becomes STACK_MISC
    r1 = *(u64 *)(r10 - 8)      ; fill_exceeds_spill

mark_reg_stack_read() leaves r1 unknown because of the STACK_MISC byte, and
scalar_intersect() then turns r1 into the constant 0, while at run time r1 is
0x100000000.  The same applies when an unknown 8-byte value is stored before
the u32 spill.  If r1 is then added to a map value pointer, an access the
verifier believes is at offset 0 lands outside the object.

The same state may be reachable without CAP_BPF: a NULL-checked pointer spill
becomes SCALAR 0 in mark_ptr_or_null_reg(), and the new keep path in
check_stack_write_fixed_off() narrows it to a 4-byte spill after a 4-byte
write at r10 - 4.

This is fixed later in the series by 8b85922f37e3 ("bpf: Mark a state that no
run of the program has"), which replaces the tnum_subreg() of both operands
with:

    b = tnum_or(tnum_cast(b, bits / BITS_PER_BYTE),
                tnum_lshift(tnum_unknown, bits))

so this commit is unsound on its own, which breaks bisection.

[ ... ]

> @@ -18921,16 +18957,22 @@ bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
>  	/* tnum_intersect() of two tnums that don't overlap is not empty */
>  	if (!tnum_overlap(a, b))
>  		return false;
> +	s.var_off = tnum_intersect(a, b);
>  	/*
>  	 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero extended int
>  	 * refines nothing but the 32-bit range.
>  	 */
> -	s.r32 = cnum32_intersect(dst->r32, src->r32);
> +	if (bits >= 32)
> +		s.r32 = cnum32_intersect(dst->r32, src->r32);
>  	if (bits == 64) {
>  		s.r64 = cnum64_intersect(dst->r64, src->r64);
> -		s.var_off = tnum_intersect(a, b);
> -	} else {
> -		s.var_off = tnum_with_subreg(dst->var_off, tnum_intersect(a, b));
> +		if (src->step % dst->step == 0) {

Does removing the else branch here make scalar_intersect() unsound for
bits == 32?  s.var_off = tnum_intersect(a, b) is now used for every width,
and for bits < 64 both a and b have been cut with tnum_subreg(), so the
upper 32 bits of dst are reported as known zero even though they are
unknown.

scalar_bounds_sync() -> __update_scalar64_bounds() then clamps r64 to at most
U32_MAX, or to an exact constant when the spilled value was constant.  The
only caller added by this patch is check_stack_read_fixed_off():

    *(u64 *)(r10 - 8) = r6      // r6 known == 5, 8-byte scalar spill
    *(u32 *)(r10 - 4) = 1       // bytes 7..4 kept as a 4-byte spill, 3..0 STACK_MISC
    r1 = *(u64 *)(r10 - 8)      // fill_exceeds_spill, r1 unknown after
                                // mark_reg_stack_read()
                                // scalar_intersect(r1, spilled r6, 32)
                                // -> var_off = const 5, r64 = [5, 5]

The verifier then treats r1 as the 64-bit constant 5, but at run time r1 is
0x100000005.  Using r1 as an offset into a map value passes the bounds check
and accesses about 4 GiB past the object.  The same happens with a BPF_ST
spill of size 4 and with uninitialized upper bytes.

Could the upper bits of dst->var_off be kept when bits < 64, for example by
restoring tnum_with_subreg(dst->var_off, ...), or by leaving a as the full
dst->var_off and widening b with unknown upper bits?

Commit 8b85922f37e3 later changes this in the way described above, without
mentioning the problem.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============3053629218588268660==--
