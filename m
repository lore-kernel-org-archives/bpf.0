Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751991;
	b=S2OE6SuRJFbb1tcnA/LafHc5FO/MrPDKXf0jf7ZxD9l3/5S8Hoo+UZinKuY1RIOY25as
	 TbFRzGWVC1ZqVkngDYSLfYjAUrxd9ZtO0hvml4Rpldcwkf8bT3PgQCF44D6CZZ0BgJRdR
	 xUk4vyrLFPVWUmHwUKb4lRsGkXaMvvPgvyAp92IwDvzel1cj+aXnW5jvpkUvmYkmaMd88
	 bJQMWIgw7WIT+HdZkEjIsjO2z/Bd3es2tvFJRcUFmjt1NqSDE3belv8uXeUUXdfdplNs6
	 0YjMdqu3Wg3Z1IBZZFjcpl+npNo4KBygHIebU0GCDVPdBlBfZ7DvmP/sJ+S0YT7ttFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kh/QBHbLhqLSJIbDJB3z2xw3TCoXZA9oMioGo7KHv74=;
	b=onujF44m/YCpr4GmEBxeoIubEXoifgEBy4HHFOj8hwWYKRFSaz/wT4Ai4MYAuadU6ZhO
	 qgVgEOYS29itTIycmSwUsi3EQtIA7FYmHIkQROM2nQWFxffu6GQF44W3YUgcbXpeaeuYV
	 4y3EK8rqSb8N6rK3QPrx+NWS97reblk2eXv7g5P8snKzWOd+tWc8LwcTNILPxGFIFrb3Q
	 AD4CD6mQZMI+ZMSrTDcxWjvl4n+xS5tmHbCKhuzi/MZyf6AtY723/GBvRzqG6Lw5MR3N2
	 gtkXjK3y6jBrqtEnsj2dAme1vPtB1/uU5cAtQ6joLbtgkTelQSoyTekVAKyE2GbC//Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dZv17/Dx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B3606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZv17/Dx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D681F000C1;
	Wed,  4 Nov 2026 00:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751990;
	bh=Kh/QBHbLhqLSJIbDJB3z2xw3TCoXZA9oMioGo7KHv74=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dZv17/DxGJL13h6dhJ5Ca156b1XbNS2Xseo+Mo8Lf0bqQ8yPdTsnJ/ncX49U4kvs6
	 ij43YIdsq9R6f+v0y6snpkJNkOMBu6t1SEAcqe//NW29RvRvFJONgw3rsPp66M+7dl
	 wThT6+MPzTSrexFT8rQpKTYZ64mfjkEa4KOH0/byumUKAkz+/lTo0nVt+k1f27hU5j
	 0LfhFJ6xa4nf/cq8mr4HXWEk6BNT+dDKB2jXbkpA4RctCOsexyZtr4LHP6CNxgHOY+
	 d85RNcAgj04i9PCj77+VQANFP6vT3i6RCPlHyXzwN6rWZSaPSeMUYDu23FRtJ7R1bv
	 mOQcVp0u9hA8Q==
Message-ID: <sashiko-outbox-196311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 29/37] bpf: Count '!=' across 0 in 32 bits and
 loops that go down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261103234104.208239-30-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
 <20261103234104.208239-30-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:26:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: 64-bit JLT/JLE on 32-bit counter in compute_max_iters() lac=
ks jmp32
- [Medium] bpf: compute_max_iters() zeroes bound_val before checking konst
- [Low] bpf: compute_max_iters() misses downward BPF_JLE when initial equal=
s bound
--

commit 08a1779026bb125181a7c2d2c0167baa7768249b
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Count '!=3D' across 0 in 32 bits and loops that go down

This commit teaches BPF scalar evolution to compute iteration counts for
32-bitBPF_JNE loops that cross zero and for downward loops tested with
unsigned BPF_JLT or BPF_JLE latches by rewriting the latter to signed
BPF_JSGE comparisons against zero.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 9ddaae03ac351..70d15449eebe1 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2738,8 +2738,9 @@ static bool compute_max_iters(struct bpf_verifier_e=
nv *env,
>  	struct scev *scev =3D env->scev;
>  	struct scev_value initial_val, step_val, bound_val;
>  	u64 step, bound, initial, total_change, backedge_taken_count;
> -	bool konst;
> +	struct linear_latch counted;
>  	u8 op =3D latch->op;
> +	bool konst, sign32 =3D latch->jmp32 && is_signed_op(op);
> =20
>  	iters->iv_reg =3D -1;
> =20
> @@ -2761,6 +2762,23 @@ static bool compute_max_iters(struct bpf_verifier_=
env *env,
> =20
>  	if (!scev_value_is_const(&step_val))
>  		return false;
> +	/*
> +	 * 'i >=3D 0 && i < 128' is one unsigned test. A counter that goes down=
 stays below 128.
> +	 * The loop ends when it gets below 0. A 64-bit jump compares all 64 bi=
ts of the bound.
> +	 * The latch of the caller stays as it is: same_latch() compares what t=
he prog tests.
> +	 */
> +	if ((op =3D=3D BPF_JLT || op =3D=3D BPF_JLE) && initial_val.ptr_reg < 0=
 &&
> +	    (latch->jmp32 || latch->zext32 ?
> +	     (s32)step_val.umin < 0 && initial_val.u32_min < bound_val.u32_max =
&&
> +	     (latch->jmp32 ? bound_val.u32_max : bound_val.umax) <=3D S32_MAX :
> +	     (s64)step_val.umin < 0 && initial_val.umin < bound_val.umax &&
> +	     bound_val.umax <=3D S64_MAX)) {

[Severity: Low]
In compute_max_iters() in kernel/bpf/scev.c, both BPF_JLT and BPF_JLE are
checked with strict inequality between the minimum initial value and maximum
bound (initial_val.u32_min < bound_val.u32_max or
initial_val.umin < bound_val.umax).

When op =3D=3D BPF_JLE and a downward counter starts at a value equal to the
bound (initial_val.u32_min =3D=3D bound_val.u32_max or
initial_val.umin =3D=3D bound_val.umax), this condition evaluates to false =
and
the latch is not rewritten to BPF_JSGE. Downward BPF_JLE is then rejected by
compute_backedge_taken_count() and compute_backedge_taken_max().

Should the comparison allow equality when op =3D=3D BPF_JLE?

> +		counted =3D *latch;
> +		latch =3D &counted;
> +		op =3D latch->op =3D BPF_JSGE;
> +		bound_val =3D (struct scev_value){ .ptr_reg =3D -1 };
> +		sign32 =3D true;
> +	}

[Severity: Medium]
When a 64-bit unsigned BPF_JLT or BPF_JLE jump tests a 32-bit downward
counter (latch->zext32 is true and latch->jmp32 is false) with
bound_val.umax <=3D S32_MAX, compute_max_iters() in kernel/bpf/scev.c rewri=
tes
counted.op to BPF_JSGE with bound_val =3D 0 and sets sign32 =3D true, but l=
eaves
counted.jmp32 as false.

When compute_max_iters() subsequently calls compute_backedge_taken_max() or
latch_false_until(), both pass latch to latch_domain() with sign =3D true,
latch->jmp32 =3D false, and latch->zext32 =3D true:

kernel/bpf/scev.c:latch_domain() {
	...
	bias =3D sign ? 1ULL << 63 : 0;
	d->bmin =3D (sign ? (u64)bound->smin : bound->umin) ^ bias;
	d->bmax =3D (sign ? (u64)bound->smax : bound->umax) ^ bias;
	if (latch->zext32) {
		/* zero extended, so it is not negative */
		d->imin =3D initial->u32_min ^ bias;
		d->imax =3D initial->u32_max ^ bias;
		d->lo =3D bias;
		d->hi =3D bias + U32_MAX;
		return;
	}
}

Because bound is 0, latch_domain() sets d->bmin =3D bias and d->lo =3D bias=
, and
uses u32_min/u32_max instead of s32_min/s32_max.

In the non-constant case (!konst), compute_backedge_taken_max() then checks:

	case BPF_JGE:
	case BPF_JSGE:
		if (!down ||
		    check_add_overflow(div64_u64(d.imax - d.bmin, step), 1, &cnt) ||
		    d.bmin < d.lo || step > d.bmin - d.lo)
			return false;

Since d.bmin - d.lo is 0 and step >=3D 1, step > d.bmin - d.lo is always tr=
ue
and compute_backedge_taken_max() unconditionally returns false.

In the constant case (konst), latch_false_until() computes
div64_u64(d.imin - d.lo, -step), which evaluates to initial_val.u32_min / -=
step
(i.e. backedge_taken_count - 1, the distance to 0 rather than the distance =
to
S32_MIN), causing bpf_compute_loop_iters() to reject multi-backedge loops
when another backedge has a different latch.

Should counted.jmp32 also be set to latch->jmp32 || latch->zext32 when
rewriting the latch to BPF_JSGE?

>  	konst =3D scev_value_is_const(&initial_val) && scev_value_is_const(&bou=
nd_val);

[Severity: Medium]
In compute_max_iters() in kernel/bpf/scev.c, bound_val is overwritten with
zero before konst is computed from scev_value_is_const(&initial_val) &&
scev_value_is_const(&bound_val).

If a downward BPF_JLT or BPF_JLE loop has a constant initial_val and a
non-constant range bound_val (for example initial_val =3D 10 and
bound_val in [5, 20]), scev_value_is_const(&bound_val) checks the overwritt=
en
zero bound_val and evaluates konst to true.

As a result, compute_max_iters() skips compute_backedge_taken_max() (leaving
iters->iv_reg as -1) and sets:

	iters->min_header_count =3D konst && loop->exits_cnt =3D=3D 1 ? iters->max=
_header_count : 0;

This sets min_header_count to max_header_count even when the original
bound_val range includes values at or below initial_val that cause the loop
to exit on the first iteration. It also forces mixed-width latches
(!latch->zext32 && latch->jmp32) with non-zero upper 32 bits in initial_val
onto the constant path where they are rejected.

Should konst be evaluated before bound_val is overwritten?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234104.2082=
39-1-alexei.starovoitov@gmail.com?part=3D29
