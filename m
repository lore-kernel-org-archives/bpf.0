Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714222DEA93;
	Sun, 28 Jun 2026 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782669053; cv=none; b=rjJ0ubjmuPThBOv+mXFLcZYPeRAP1+9TFslcwJY6GIwb1NhrnDw+Pgb64rPOzJKmZxEosF7eVihwY4YjM62Js9kP+m7GxtFIlEE7C0NWij7BAUD4eTpm6Qcma7gRQ/u19n0q0bOBINwk+a0rU8bkYu1jNEfOVec4glcaELW3V3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782669053; c=relaxed/simple;
	bh=2cEjVa3joALpCSoB902JGGkpYstE9HYQNG0dqHq0cJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTTLYGc1LN3UcesKq4jKQg6PGLxo6jlDStl/TKGGYk0ZJDjfp4vWyMp6sMBO7q52vB+Ldjnn/UCSDqVZOt2/+hxCDUGhw5ISLOvlECSbbkXlmdyk7sveqyKbTR9hat6KcnKR2+TBTe3rFeCX/cAHBS+0GNdmMsWZRkA0eOuPk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIM+0kPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIM+0kPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7951F000E9;
	Sun, 28 Jun 2026 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782669052;
	bh=6mFg+vRVXkDMJryF3S/ofCtYY+gHbSFhj5EVfVorN4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lIM+0kPyzDzwXttK+SvOxudiOx+2QBMx/0b2r8omq2+Hy+KxTiTy4/CbLeKRdYT3F
	 dIkuVXLOwHxvX5b/siDhowjs4KuYm/doxdBet1Z5sCrDoa4hxoodsN2LV7j9oAj6FC
	 fZOnIEzgjolrVCT5Od9asMPzeIq/qB0UwoYhi9ZlRemF8ECSO4L4BS5nW+t5fLEb3x
	 EkfTbfhSEECMdgve3UjpIApsKbuW5v6sPKcBchhcRtXSRD2/bd9mD+LJFVpNd2GqzU
	 FR3/5VCKmHBkEn0eJQ/O+bSEzhxiar5927HI9e1OimMrUKBNbrebdjYpCKI4Px8Xy5
	 dlYNYMqd329+g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Varun R Mallya <varunrmallya@gmail.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, pulehui@huawei.com
Cc: alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, shuah@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, varunrmallya@gmail.com
Subject: Re: [PATCH bpf-next v2 2/3] riscv, bpf: Add support for BPF exceptions
In-Reply-To: <20260628081710.113333-3-varunrmallya@gmail.com>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
 <20260628081710.113333-3-varunrmallya@gmail.com>
Date: Sun, 28 Jun 2026 10:50:48 -0700
Message-ID: <87bjcuy2o7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Varun R Mallya <varunrmallya@gmail.com> writes:

> Add the JIT support required for BPF exceptions (bpf_throw()) on riscv64.
>
> Two kinds of program need special prologue/epilogue handling:
>
>   - A program acting as an exception boundary must save the full set of
>     riscv callee-saved GP registers (ra, s0-s11), not just the ones it
>     happens to clobber, so that the exception callback can restore the
>     state that was live at the boundary. ra and fp are stored first so
>     the saved ra/fp pair forms a valid stackframe record for the
>     unwinder.
>
>   - The exception callback (exception_cb) does not allocate its own
>     frame. It reuses the boundary program's frame, whose frame pointer
>     is passed in a2, by setting SP =3D FP - stack_adjust. This lines the
>     epilogue's loads up with the registers the boundary saved, so both
>     paths restore the same order.
>
> Wire up bpf_jit_support to be true only when CONFIG_FRAME_POINTER is
> enabled.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 115 ++++++++++++++++++++++++++++----
>  1 file changed, 102 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c03c1de16b79..c6e2f852e854 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -56,6 +56,30 @@ static const int pt_regmap[] =3D {
>  	[RV_REG_T0] =3D offsetof(struct pt_regs, t0),
>  };
>=20=20
> +/*
> + * Full set of RISC-V callee-saved GP registers (ra, s0-s11) saved by a =
program
> + * acting as an exception boundary, in the order they are stored on the =
stack.
> + * RA and FP come first so the saved ra/fp pair forms a valid stackframe=
 record
> + * at [FP-8]/[FP-16] for the unwinder. The exception callback reuses the
> + * boundary program's frame and restores this same set in its epilogue, =
so both
> + * paths must agree on the contents and ordering of this list.
> + */

nit: Please use netdev style multi-line comments (/* Blah, vs /*\n)

> +static const int rv_exception_csave_regs[] =3D {
> +	RV_REG_RA,
> +	RV_REG_FP,
> +	RV_REG_S1,
> +	RV_REG_S2,
> +	RV_REG_S3,
> +	RV_REG_S4,
> +	RV_REG_S5,
> +	RV_REG_S6,
> +	RV_REG_S7,
> +	RV_REG_S8,
> +	RV_REG_S9,
> +	RV_REG_S10,
> +	RV_REG_S11,
> +};
> +
>  enum {
>  	RV_CTX_F_SEEN_TAIL_CALL =3D	0,
>  	RV_CTX_F_SEEN_CALL =3D		RV_REG_RA,
> @@ -231,6 +255,22 @@ static void emit_imm(u8 rd, s64 val, struct rv_jit_c=
ontext *ctx)
>  static void __build_epilogue(bool is_tail_call, struct rv_jit_context *c=
tx)
>  {
>  	int stack_adjust =3D ctx->stack_size, store_offset =3D stack_adjust - 8;
> +	struct bpf_prog_aux *aux =3D ctx->prog->aux;
> +	int i;
> +
> +	if (aux->exception_boundary || aux->exception_cb) {
> +		/*

nit: Comment again.

> +		 * An exception boundary saved the full callee-saved register
> +		 * set and the exception callback restores it from the boundary's
> +		 * frame. Both restore the same fixed set, in the same order it
> +		 * was stored by bpf_jit_build_prologue().
> +		 */
> +		for (i =3D 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +			emit_ld(rv_exception_csave_regs[i], store_offset, RV_REG_SP, ctx);
> +			store_offset -=3D 8;
> +		}
> +		goto epilogue_tail;
> +	}
>=20=20
>  	if (seen_reg(RV_REG_RA, ctx)) {
>  		emit_ld(RV_REG_RA, store_offset, RV_REG_SP, ctx);
> @@ -267,6 +307,7 @@ static void __build_epilogue(bool is_tail_call, struc=
t rv_jit_context *ctx)
>  		store_offset -=3D 8;
>  	}
>=20=20
> +epilogue_tail:
>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>  	/* Set return value. */
>  	if (!is_tail_call)
> @@ -2002,11 +2043,61 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>  void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>  {
>  	int i, stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> +	struct bpf_prog_aux *aux =3D ctx->prog->aux;
>=20=20
>  	bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
>  	if (bpf_stack_adjust)
>  		mark_fp(ctx);
>=20=20
> +	/* emit kcfi type preamble immediately before the first insn */
> +	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
> +
> +	/* nops reserved for auipc+jalr pair */
> +	for (i =3D 0; i < RV_FENTRY_NINSNS; i++)
> +		emit(rv_nop(), ctx);
> +
> +	/* First instruction is always setting the tail-call-counter
> +	 * (TCC) register. This instruction is skipped for tail calls.
> +	 * Force using a 4-byte (non-compressed) instruction.
> +	 */
> +	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +
> +	if (aux->exception_boundary || aux->exception_cb) {
> +		/*
> +		 * A program acting as an exception boundary saves the full set
> +		 * of riscv callee saved registers (ra, s0-s11).
> +		 */
> +		stack_adjust =3D round_up(ARRAY_SIZE(rv_exception_csave_regs) * 8,
> +					STACK_ALIGN);
> +		stack_adjust +=3D bpf_stack_adjust;
> +		store_offset =3D stack_adjust - 8;
> +
> +		if (!aux->exception_cb && aux->exception_boundary) {
> +			/*
> +			 * Boundary program: allocate the frame and save the
> +			 * full callee-saved set, capturing the caller's values.
> +			 */
> +			emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
> +			for (i =3D 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +				emit_sd(RV_REG_SP, store_offset,
> +					rv_exception_csave_regs[i], ctx);
> +				store_offset -=3D 8;
> +			}
> +			emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
> +		} else {
> +			/*
> +			 * Exception callback, reuse the boundary program's
> +			 * frame, whose frame pointer is passed in a2. Setting
> +			 * SP =3D FP - stack_adjust lines the epilogue's loads up
> +			 * with the registers the boundary saved.
> +			 */
> +			emit_mv(RV_REG_FP, RV_REG_A2, ctx);
> +			emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
> +		}
> +
> +		goto tail_setup;
> +	}
> +

This function is getting large... I tend do forget details, so having it
in smaller helpers would be good. Let's try to refactor a bit.

The special case is really just:
  * exception boundary: allocate frame and save full layout
  * exception_cb: reuse boundary FP from a2 and derive SP from it
  * both: restore the same fixed layout

So helpers like is_exception_prog(), exception_stack_adjust(),
emit_exception_boundary_prologue(), emit_exception_cb_prologue(), and
emit_exception_restore() would make the prologue/epilogue changes much
easier to review and also reduce churn in bpf_jit_build_prologue().

>  	if (seen_reg(RV_REG_RA, ctx))
>  		stack_adjust +=3D 8;
>  	stack_adjust +=3D 8; /* RV_REG_FP */
> @@ -2030,19 +2121,6 @@ void bpf_jit_build_prologue(struct rv_jit_context =
*ctx, bool is_subprog)
>=20=20
>  	store_offset =3D stack_adjust - 8;
>=20=20
> -	/* emit kcfi type preamble immediately before the  first insn */
> -	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
> -
> -	/* nops reserved for auipc+jalr pair */
> -	for (i =3D 0; i < RV_FENTRY_NINSNS; i++)
> -		emit(rv_nop(), ctx);
> -
> -	/* First instruction is always setting the tail-call-counter
> -	 * (TCC) register. This instruction is skipped for tail calls.
> -	 * Force using a 4-byte (non-compressed) instruction.
> -	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> -
>  	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>=20=20
>  	if (seen_reg(RV_REG_RA, ctx)) {
> @@ -2082,6 +2160,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *=
ctx, bool is_subprog)
>=20=20
>  	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>=20=20
> +tail_setup:

Hmm, thinking more about it, maybe folding the "normal_prologue()" in as
pre-commit, so we can avoid more gotos.

  | if (is_exception_prog(aux))
  |     emit_exception_restore(ctx, stack_adjust);
  | else
  |     emit_normal_restore(ctx, stack_adjust);
  |=20
  | emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
  | ...

or smth.

>  	if (bpf_stack_adjust) emit_addi(RV_REG_S5, RV_REG_SP,
>  	bpf_stack_adjust, ctx);
>=20=20
> @@ -2157,3 +2236,13 @@ bool bpf_jit_supports_fsession(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_exceptions(void)
> +{
> +	/*
> +	 * bpf_throw() unwinds by walking the frame-pointer chain from inside
> +	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
> +	 * exceptions require the frame-pointer unwinder to be enabled.
> +	 */

nit: Comments...


Thanks,
Bj=C3=B6rn
