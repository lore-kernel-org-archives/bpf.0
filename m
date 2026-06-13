Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B92E571
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309590; cv=none; b=B29oxlOPc4A8WD8NgV0LpMrQBXWLfFe3IA1HmJcHXnl6YWFubacE2YKWTeLJ3rYBzrxZ5RxUsaadcUaXwRCjJacazrNxM2OrRqt1gbPPqtbiVIGEsWkwPPlr9QClZVNJ8yXdj8sT1a6DFg3ACO13h+zGwnShYvjBFDASPw3cB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309590; c=relaxed/simple;
	bh=xXhYZulwye+SEI86XFb8bDq9v65t4ZiVkEKh+TBi9ng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZn3hIsks7F3zoizY3Iw9P5j88HfqqMKtNt+OYzbkWFKlGPt5IZsYNjkPUQjZHDQ3Ha/bvXKpzkFJXMZhH21J7RATAOIZJ6sHz1a1jbEETR64fVycwhp14QmdcEYlo2fuhDTA1qBKulBqbJqdsub+3JS14Hic1EDyAarQ3J10cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naofgJkU; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naofgJkU"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30749947917so4665690eec.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781309588; x=1781914388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLyF5u2SHZ0Con6y/rCHwVlZzVYA9Ufz+1Pa0/Nb1Nc=;
        b=naofgJkUkSEG3yZJGCAt1eB8ilC87hwytYwYBeHbT/Q9vpMzkAQ4Dijl2+eSRlFi27
         RkEt24MtgDvo0uYTSy5W2PRgrIFfCvt8DCsy/PMnMhxN2smjY2Gtq0tzg9MFbEZUGrwK
         6//4bxpcZvNa6MQor0VFfSXEUFFQRe2oZ3eSBJxTDiMvCjoe9VBWcoqCLXOJOgTXg5Pg
         QAfVb/e8Btkq9oKFFUjDQ7HXJqU47QCp7E/dB/JLk5KPKfSmSKT/llpylYAv9C61sHwy
         lwCKoEL/j7TdNdOUqoxa1EGtfsQFjx0H/xcx3kqaq50IPNt0cA6FrouVEFG8RYXo1k+4
         /xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309588; x=1781914388;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLyF5u2SHZ0Con6y/rCHwVlZzVYA9Ufz+1Pa0/Nb1Nc=;
        b=KodvVOR2V2CayO13bXCmMPaP5NB8B1PXyzOD0ThXMT3k1EyrjYIOVEYv4PZoc++/0O
         BAxHD544QYAF/wsULXpWyAoYKavCSthDzZgUW2BpBUdWmp0e/OWVlmd01PeX1Lyg0rcT
         +TDCb/kFCUu9gIJxOrSF1K5YtOlmftdLPnmCSR5GqlZWBmGeslwrBlRfJ49axI3XFm8H
         AnBVp8qdvtQ7KlTlvHBslF4YW4tjBkxSH9kFNOEATZP3UvZZ92n87/uBQlYGi+6lFpsF
         o8zihTNVzsOVgXDYhVf+TqX+2qWWLbGfyDjIHoaqK2wxhDfp+pzbUmkz1DK/z5cjs3XQ
         EZDA==
X-Gm-Message-State: AOJu0Yytc3iGNrZXoCYsU2b8G1nhX+eS4xU8u+wc7UMiV6lvBgxqmqSS
	B6b71S+RV59x24FuWWGk80Q5b9Jo979fNct/UfB+EPUmyN8bNENbW69g
X-Gm-Gg: Acq92OEHFwK/bKIITduVDLJwWpPoC1uN0qNk3KotIvLNd+2XIubVE3B46IPo/SHUsYP
	iROb+AVzT99IbKfOjxFmB3sLic0v/Uc6f9tKWmfojZ51J3Ff915ExcBhb2jizOdkj5iL8iIsr6f
	zfgZ/h8fA0+vwLSRJ5cTRMYcspfsZc+eXrWPuNa618YEJV7zs16xaJ+U8KG/AcVK5q3lNNRRIq/
	QqSqf+blwOjayyWQlEabuuxC2DOfUtFy30II1JujMjCIjJ4+73EG516J7LO2JbpqHOirjBb9zia
	exF7I8z8broWCxdH5y87FU0zR6a5DdROgpfBvz5WckL1hq7xHRgIY6+r8rk82b/Wg8KU7GhH/Gb
	gfr1KwXzFR4SuegCp9HLYxYO0PbAWLZ4ulgQC1K3DRxF4cUOUtooJPaYthwxblhHSG9UhKjl9e3
	IRIyjVS6VcZ7PkNIwtbW76DiR7UrarMMuk7L9lJ9S9ZocLwncAYpL/4K1U9EjJLsRdKJX90m9ps
	sVPfQ==
X-Received: by 2002:a05:7300:4791:b0:304:c651:bdfe with SMTP id 5a478bee46e88-3093eb498bcmr1111725eec.17.1781309587463;
        Fri, 12 Jun 2026 17:13:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3bc2:d1df:77fc:cea4? ([2620:10d:c090:500::bfa7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm6052820eec.4.2026.06.12.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:13:07 -0700 (PDT)
Message-ID: <1e223d73e52d06361de599d588bd53b01dbc6f78.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack
 reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 12 Jun 2026 17:13:05 -0700
In-Reply-To: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
References: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-11 at 19:11 +0900, Woojin Ji wrote:
> mark_reg_stack_read() currently treats a variable-offset stack read as
> known-zero only when every byte in the read range has STACK_ZERO type.
> This loses precision for stack bytes that are represented as STACK_SPILL
> but come from a spilled scalar const zero.
>=20
> Fixed-offset stack reads already preserve such partial reads from a
> spilled scalar zero as const zero. Variable-offset stack writes also keep
> a spilled scalar zero intact when a zero write overlaps it. The read side
> is therefore inconsistent and can reject otherwise valid programs: a byte
> read from a spilled zero becomes an unknown u8 and may then make a
> stack access through that value appear out of bounds.
>=20
> Treat STACK_SPILL bytes backed by a spilled scalar const zero as zero
> bytes in mark_reg_stack_read(). When such a spilled scalar is used to
> prove the destination register is const zero, mark every contributing
> source stack slot precise before state pruning can use an explored
> zero-spill path for a later non-zero spill path.
>=20
> This has to be done eagerly for variable-offset loads. Fixed-offset stack
> fills can record one source stack slot in the jump history and propagate
> destination precision back to that slot later, but a variable-offset load
> may source bytes from multiple stack slots. Seed precision backtracking
> with every zero-spill slot that contributes to the const-zero
> classification instead.
>=20
> Add verifier selftests for both sides: accepted programs that read a byte
> through a variable stack offset from spilled zero scalars, including a
> multi-slot range, and a rejected program that would be accepted unsafely
> by a naive implementation that promotes spilled zero bytes to const zero
> without tracking the source spilled slot precisely. Use
> BPF_F_TEST_STATE_FREQ for the rejected test so it does not depend on the
> current verifier checkpoint heuristic thresholds.
>=20
> Tested:
>   ./test_progs -t verifier_var_off
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
>  kernel/bpf/verifier.c                              | 52 ++++++++++---
>  .../testing/selftests/bpf/progs/verifier_var_off.c | 88 ++++++++++++++++=
++++++
>  2 files changed, 130 insertions(+), 10 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd..c4b89fbd9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4058,14 +4058,21 @@ static int check_stack_write_var_off(struct bpf_v=
erifier_env *env,
>   * SCALAR. This function does not deal with register filling; the caller=
 must
>   * ensure that all spilled registers in the stack range have been marked=
 as
>   * read.
> + *
> + * If the const-zero classification depends on spilled scalar zeroes, ma=
rk the
> + * contributing stack slots precise so pruning cannot reuse a zero-spill=
 state
> + * for a later path containing a different spilled scalar.
> + *
> + * Returns an error if precision backtracking fails.
>   */
> -static void mark_reg_stack_read(struct bpf_verifier_env *env,
> -				/* func where src register points to */
> -				struct bpf_func_state *ptr_state,
> -				int min_off, int max_off, int dst_regno)
> +static int mark_reg_stack_read(struct bpf_verifier_env *env,
> +			       /* func where src register points to */
> +			       struct bpf_func_state *ptr_state,
> +			       int min_off, int max_off, int dst_regno)
>  {
>  	struct bpf_verifier_state *vstate =3D env->cur_state;
>  	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
> +	u64 zero_spill_mask =3D 0;
>  	int i, slot, spi;
>  	u8 *stype;
>  	int zeros =3D 0;
> @@ -4075,19 +4082,38 @@ static void mark_reg_stack_read(struct bpf_verifi=
er_env *env,
>  		spi =3D slot / BPF_REG_SIZE;
>  		mark_stack_slot_scratched(env, spi);
>  		stype =3D ptr_state->stack[spi].slot_type;
> -		if (stype[slot % BPF_REG_SIZE] !=3D STACK_ZERO)
> -			break;
> -		zeros++;
> +		if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_ZERO) {
> +			zeros++;
> +			continue;
> +		}
> +		if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_SPILL &&
> +		    bpf_is_spilled_scalar_reg(&ptr_state->stack[spi]) &&
> +		    tnum_is_const(ptr_state->stack[spi].spilled_ptr.var_off) &&
> +		    ptr_state->stack[spi].spilled_ptr.var_off.value =3D=3D 0) {
> +			zero_spill_mask |=3D 1ull << spi;
> +			zeros++;
> +			continue;
> +		}
> +		break;
>  	}
>  	if (zeros =3D=3D max_off - min_off) {
>  		/* Any access_size read into register is zero extended,
>  		 * so the whole register =3D=3D const_zero.
>  		 */
>  		__mark_reg_const_zero(env, &state->regs[dst_regno]);
> +		if (zero_spill_mask) {
> +			for (spi =3D 0; spi < MAX_BPF_STACK / BPF_REG_SIZE; spi++) {
> +				if (zero_spill_mask & (1ull << spi))
> +					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);

Nit: Instead of looping over the mask here, I'd extend the `bpf_bt_*` api
     with something like `btf_set_frame_mask(&env->bt, ptr_state->frameno, =
zero_spill_mask)`.

> +			}
> +			return mark_chain_precision_batch(env, env->cur_state);

I tested this change against a big corpus of BPF programs
(selftests, sched_ext, Meta internal, cilium) and see no veristat regressio=
ns,
despite this mark_chain_precision_batch() call.

> +		}
>  	} else {
>  		/* have read misc data from the stack */
>  		mark_reg_unknown(env, state->regs, dst_regno);
>  	}
> +
> +	return 0;
>  }
> =20
>  /* Read the stack at 'off' and put the results into the register indicat=
ed by
> @@ -4109,6 +4135,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
>  	struct bpf_reg_state *reg;
>  	u8 *stype, type;
> +	int err;
>  	int insn_flags =3D insn_stack_access_flags(reg_state->frameno, spi);
> =20
>  	stype =3D reg_state->stack[spi].slot_type;
> @@ -4235,8 +4262,11 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  			}
>  			return -EACCES;
>  		}
> -		if (dst_regno >=3D 0)
> -			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
> +		if (dst_regno >=3D 0) {
> +			err =3D mark_reg_stack_read(env, reg_state, off, off + size, dst_regn=
o);
> +			if (err)
> +				return err;
> +		}
>  		insn_flags =3D 0; /* we are not restoring spilled register */
>  	}
>  	if (insn_flags)
> @@ -4291,7 +4321,9 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env,
> =20
>  	min_off =3D reg->smin_value + off;
>  	max_off =3D reg->smax_value + off;
> -	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno)=
;
> +	err =3D mark_reg_stack_read(env, ptr_state, min_off, max_off + size, ds=
t_regno);
> +	if (err)
> +		return err;
>  	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c
> index f345466bc..2d4878270 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -59,6 +59,94 @@ __naked void stack_read_priv_vs_unpriv(void)
>  "	::: __clobber_all);
>  }
> =20
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero")
> +__success
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)

Please add some __msg() here to verify that `r3` read from stack is
considered to be zero and mark_precise trail. (In other tests as well).

> +__naked void stack_read_var_off_preserves_spilled_zero(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
         ^                       ^
         Why additional spaces?

> +	"r2 =3D *(u32 *)(r1 + 0); "
> +	"r2 &=3D 7; "
> +	"r2 -=3D 8; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D r3; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}

Please add a test cases demonstrating the behavior when spill size is
less than 8 bytes, with neighboring slots being STACK_ZERO + spill or
STACK_MISC + spill.

> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero across =
slots")
> +__success
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void=
)
> +{
> +	asm volatile (
> +	"r0 =3D 0; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	" *(u64 *)(r10 - 16) =3D r0; "
> +	"r2 =3D *(u32 *)(r1 + 0); "
> +	"r2 &=3D 15; "
> +	"r2 -=3D 16; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D r3; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read tracks spilled zero precisely"=
)
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("invalid variable-offset write to stack R1")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__naked void stack_read_var_off_tracks_spilled_zero_precisely(void)
> +{
> +	asm volatile (
> +	"r6 =3D *(u32 *)(r1 + 0); "
> +	"r6 &=3D 1; "
> +	"r0 =3D 0; "
> +	"if r6 !=3D 0 goto "
> +	"+"
> +	"2; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	"goto "
> +	"+"
> +	"2; "

Huh?

> +	"r0 =3D 1; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	"r0 =3D 0; "
> +	"r2 =3D *(u32 *)(r1 + 4); "
> +	"r2 &=3D 7; "
> +	"r2 -=3D 8; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D 0; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}
> +
>  SEC("cgroup/skb")
>  __description("variable-offset stack read, uninitialized")
>  __success
>=20
> ---
> base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
> change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533
>=20
> Best regards,
> -- =20
> Woojin Ji <random6.xyz@gmail.com>
