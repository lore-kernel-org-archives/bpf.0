Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EC370D57
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186594; cv=none; b=JZi+kes8ygz2PYm+LtkqsXZ9vpKLYikTWAb2FoAkdTf+DDqPtP2k0GjH/bGBw2ekTB8Xw8wJD1/EQuoEqDQfTuUdNEZn77MeaSDfjJ6fbV1IZJ0ffVTBcj1wq+9hJ8Io4BZ4nyhbnAviDj3DOz26h3NM3cexYGe5yGBEx6oNgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186594; c=relaxed/simple;
	bh=oRl9TF+bryDH9Bo4cLRFXyQk46PUQ362CxGBol/tvkA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gqQYn+5qveMEbDdi1Zeq1YpCbuoQpWKT+cc+8bwAgTdoUUrIvBKXL/BxCxE/Cy3gfX6ZAB5/86R5Grxmr1KhEtZ985KWChpm8FRroPZiQoUSR7+8RCmXTl1rTseTP5XveKRY/FtvIZTqoHcSzeTcYGvtPgbSFadj6/o6bg83tO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYuP2bPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYuP2bPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F91F000FF;
	Wed, 23 Sep 2026 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186593;
	bh=59wldGR+BDFMIKUaDrWacQi6e2R/wmt6QcHwyVPaM3o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SYuP2bPiJkeAjoG/+pmob+7/XmmnnODDRl+xc/vYjn6wiiEsTDUFqX9GS9uRCJba9
	 Q1TVi/I7W6F3XgyI4gayg6W5w5fFc3HcZjtrqAcfjgH2v97cB8HdMj1sWDzefAOFbv
	 rqP+36KUQBkoA+zarNEJoAlsTGn1iWVoloBZ9JUZifBCUWgHgl1z89qoMlwVJfLSPd
	 rS79vS04C4eju+vCScz2IzxRX9EZnelsItq9XU6YgIhIeT1HgG+fkRMgE5EETDKYAr
	 Dhzy9dUeSPXxgRYUt5cn5Di/oO0S9h9DHvZblpz54P/mWsFemfLXA7aJT5U6ymzcwx
	 ieQE0r/zbvVPg==
Content-Type: multipart/mixed; boundary="===============8125914925404220446=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1500ebe4bc44005c2359587a88fe0e3e27e5f62d5eb884f42c0fd6c15b7d591@mail.kernel.org>
In-Reply-To: <20260923165301.3463007-2-puranjay@kernel.org>
References: <20260923165301.3463007-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: Support fetching AND/OR/XOR atomics in arena
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 18:03:11 +0000 (UTC)

--===============8125914925404220446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4a980140b48..c601e42e1876 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -236,8 +236,17 @@ static const int reg2pt_regs[] = {
>  	[BPF_REG_7] = offsetof(struct pt_regs, r13),
>  	[BPF_REG_8] = offsetof(struct pt_regs, r14),
>  	[BPF_REG_9] = offsetof(struct pt_regs, r15),
> +	/* Substituted for R0 by the CMPXCHG loop lowering below. */
> +	[BPF_REG_AX] = offsetof(struct pt_regs, r10),
>  };
>
> +static bool is_atomic_fetch_op(const struct bpf_insn *insn)
> +{
> +	return insn->imm == (BPF_AND | BPF_FETCH) ||
> +	       insn->imm == (BPF_OR | BPF_FETCH) ||
> +	       insn->imm == (BPF_XOR | BPF_FETCH);
> +}
> +

[ ... ]

> @@ -1639,6 +1648,68 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>  	return 0;
>  }
>
> +/*
> + * A fetching AND/OR/XOR can't be implemented with a single x86 insn, so do a
> + * CMPXCHG loop. @index_reg is X86_REG_R12 for an arena access or -1 otherwise,
> + * and @dst_reg/@src_reg are already substituted for R0 by the caller.
> + *
> + * Both the load and the CMPXCHG can fault when accessing the arena, so their
> + * addresses are handed back in @fault. A fault has to resume at @resume, which
> + * is past the loop and past the move of the value that was never loaded, but
> + * before the R0 restore.
> + */
> +static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
> +				 u32 src_reg, int index_reg, u8 *fault[2],
> +				 u8 **resume)
> +{
> +	bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +	u8 *branch_target, *prog = *pprog;
> +	int err;
> +
> +	branch_target = prog;
> +
> +	/* Load old value */
> +	fault[0] = prog;
> +	if (index_reg < 0)
> +		emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg, insn->off);
> +	else
> +		emit_ldx_index(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg,
> +			       index_reg, insn->off);
> +
> +	/*
> +	 * Perform the (commutative) operation locally, put the result in
> +	 * the AUX_REG.
> +	 */
> +	emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> +	maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
> +	EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> +	      add_2reg(0xC0, AUX_REG, src_reg));
> +
> +	/* Attempt to swap in new value */
> +	fault[1] = prog;
> +	if (index_reg < 0)
> +		err = emit_atomic_rmw(&prog, BPF_CMPXCHG, dst_reg, AUX_REG,
> +				      insn->off, BPF_SIZE(insn->code));
> +	else
> +		err = emit_atomic_rmw_index(&prog, BPF_CMPXCHG, BPF_SIZE(insn->code),
> +					    dst_reg, AUX_REG, index_reg, insn->off);
> +	if (WARN_ON(err))
> +		return err;
> +
> +	/* ZF tells us whether we won the race. If it's cleared we need to try again. */
> +	EMIT2(X86_JNE, -(prog - branch_target) - 2);
> +	/* Return the pre-modification value */
> +	emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
> +
> +	*resume = prog;
> +
> +	/* Restore R0 after clobbering RAX */
> +	emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
> +
> +	*pprog = prog;
> +	return 0;
> +}
> +
>  /*
>   * Metadata encoding for exception handling in JITed code.
>   *
> @@ -1652,7 +1723,11 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>   * | ARENA_ACC | ARENA_WRITE | Unused | ARENA_REG | DST_REG | INSN_LEN |
>   * +-----------+-------------+--------+-----------+---------+----------+
>   *
> - * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
> + * - INSN_LEN (8 bits): How far past the faulting insn to resume. That is its own length
> + *                      for a single-insn access, but the distance to the end of the whole
> + *                      sequence where one BPF insn became several, as for the CMPXCHG loop
> + *                      of a fetching AND/OR/XOR. Bounded by the BPF_MAX_INSN_SIZE check on
> + *                      ilen below, which is what keeps this inside 8 bits.
>   * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
>   *                      This is set to DONT_CLEAR if the insn does not read into a register.
>   * - ARENA_REG (8 bits): Offset of the register that is used to calculate the

[ ... ]

> @@ -1707,6 +1782,44 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>  	return true;
>  }
>
> +/*
> + * Record an arena access that may fault. @fault_ip is the address of the
> + * faulting insn in the RO image, @resume_off how far past it execution has to
> + * resume: for a multi-insn lowering that is the end of the whole sequence, not
> + * the end of the one insn.
> + */

this isn't a bug, but does the phrase "the end of the whole sequence"
match emit_atomic_fetch_rmw()'s actual behavior?  The function comment
says the resume point is "past the loop and past the move of the value
that was never loaded, but before the R0 restore", and the code sets
*resume before the final emit_mov_reg() that restores R0.

If the resume point isn't at the true end of the emitted sequence, would
"the end of the rest of the sequence that must be skipped" be clearer
than "the end of the whole sequence" in both this comment and the
bit-layout comment at line 1726?

> +static int emit_arena_exentry(struct bpf_prog *bpf_prog, u8 *image, u8 *rw_image,
> +			      int *excnt, u8 *fault_ip, u32 resume_off,
> +			      u32 fixup_reg, u32 arena_reg, bool is_write, s16 off)
> +{
> +	struct exception_table_entry *ex;
> +	s64 delta;
> +
> +	if (!bpf_prog->aux->extable)
> +		return 0;
> +
> +	if (*excnt >= bpf_prog->aux->num_exentries) {
> +		pr_err("mem32 extable bug\n");
> +		return -EFAULT;
> +	}
> +	ex = &bpf_prog->aux->extable[(*excnt)++];
> +
> +	delta = fault_ip - (u8 *)&ex->insn;
> +	/* switch ex to rw buffer for writes */
> +	ex = (void *)rw_image + ((void *)ex - (void *)image);
> +
> +	ex->insn = delta;
> +	ex->data = EX_TYPE_BPF | FIELD_PREP(DATA_ARENA_OFFSET_MASK, off);
> +	ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, resume_off) |
> +		    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
> +		    FIELD_PREP(FIXUP_REG_MASK, fixup_reg) |
> +		    FIXUP_ARENA_ACCESS;
> +	if (is_write)
> +		ex->fixup |= FIXUP_ARENA_WRITE;
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -2800,20 +2891,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		fallthrough;
>  	case BPF_STX | BPF_ATOMIC | BPF_W:
>  	case BPF_STX | BPF_ATOMIC | BPF_DW: {
> -		bool is64 = BPF_SIZE(insn->code) == BPF_DW;
>  		u32 real_src_reg = src_reg;
>  		u32 real_dst_reg = dst_reg;
> +		bool is_atomic_fetch = is_atomic_fetch_op(insn);
> +		u8 *fault[2], *resume;
>  		u8 *old_prog;
> -		bool is_atomic_fetch =
> -			(insn->imm == (BPF_AND | BPF_FETCH) ||
> -			 insn->imm == (BPF_OR | BPF_FETCH) ||
> -			 insn->imm == (BPF_XOR | BPF_FETCH));
> -		if (is_atomic_fetch) {
> -			/*
> -			 * Can't be implemented with a single x86 insn.
> -			 * Need to do a CMPXCHG loop.
> -			 */
>
> +		if (is_atomic_fetch) {
>  			/* Will need RAX as a CMPXCHG operand so save R0 */
>  			old_prog = prog;
>  			emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
> @@ -2834,34 +2918,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>  		}
>  		if (is_atomic_fetch) {
> -			u8 *branch_target = prog;
> -			/* Load old value */
> -			emit_ldx(&prog, BPF_SIZE(insn->code),
> -				 BPF_REG_0, real_dst_reg, insn->off);
> -			/*
> -			 * Perform the (commutative) operation locally,
> -			 * put the result in the AUX_REG.
> -			 */
> -			emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> -			maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
> -			EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> -			      add_2reg(0xC0, AUX_REG, real_src_reg));
> -			/* Attempt to swap in new value */
> -			err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
> -					      real_dst_reg, AUX_REG,
> -					      insn->off,
> -					      BPF_SIZE(insn->code));
> -			if (WARN_ON(err))
> +			err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
> +						    real_src_reg, -1, fault,
> +						    &resume);
> +			if (err)
>  				return err;
> -			/*
> -			 * ZF tells us whether we won the race. If it's
> -			 * cleared we need to try again.
> -			 */
> -			EMIT2(X86_JNE, -(prog - branch_target) - 2);
> -			/* Return the pre-modification value */
> -			emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
> -			/* Restore R0 after clobbering RAX */
> -			emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>  			break;
>  		}

this isn't a bug, but the non-arena atomic path declares 'u8 *fault[2],
*resume;' at the top of the case block and passes them to
emit_atomic_fetch_rmw(), yet this branch never builds an exception
table entry, so both out-parameters are written and immediately
discarded.

Could emit_atomic_fetch_rmw() accept NULL for the @fault and @resume
parameters when the caller does not need them, to avoid carrying dead
locals in the non-arena case?

>
>  		err = emit_atomic(&prog, insn->imm, dst_reg, src_reg, insn->off,

[ ... ]

> @@ -4276,6 +4374,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  		padding = true;
>  		goto skip_init_addrs;
>  	}
> +
> +	/*
> +	 * An arena fetching AND/OR/XOR is lowered to a CMPXCHG loop whose load
> +	 * and CMPXCHG can both fault, one more entry than the verifier reserved.
> +	 * Only reachable on the first pass, so the count is adjusted once.
> +	 */
> +	for (i = 0; prog->aux->arena && i < prog->len; i++) {
> +		const struct bpf_insn *insn = &prog->insnsi[i];
> +
> +		if (BPF_CLASS(insn->code) == BPF_STX &&
> +		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC &&
> +		    is_atomic_fetch_op(insn))
> +			prog->aux->num_exentries++;
> +	}
> +

this isn't a bug, but every other loop in this function uses a plain
index condition, while this one re-evaluates 'prog->aux->arena' on
every iteration.

Would 'if (prog->aux->arena) for (i = 0; i < prog->len; i++)' make it
clearer that the arena test is a one-time fast path rather than part of
the iteration condition?

>  	addrs = kvmalloc_objs(*addrs, prog->len + 1);
>  	if (!addrs)
>  		goto out_addrs;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35893521945
--===============8125914925404220446==--
