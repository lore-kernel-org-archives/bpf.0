Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E63C10B5
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541773; cv=none; b=gaUkBo+ftV2w84i2WyGJN/9blx5uklMYq+n6tLA+fZzPJQMGWQLF8rKFJ5sldIn6MClo7+B9Fc5mj/rcxb/BTe22Mfwvu+NRuQWnVcts+WOI4MFp9/Rl8V1AHX5Ybm6H4FKBwlFe4XjPhPXK/nwyGcOVUlZAUBRMByZG92LXl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541773; c=relaxed/simple;
	bh=radqAnBuLbg0sI+snYICGdV5NbthAUhgPW5YmCn3ogw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nQDl/0apFp9nYNXpQREHRnxgKaUjBRAg5cPXmmgZCa4hQgCPB52EZsXG1XdkKmEGHYngAKEkA9d6UYwp70ecwkzDzQSTY8muHIRYfsDuo/G5S1C2prKh26wqz105MswHNRUtLOLJ7nebtbaAQmNK9tmiPYkKsNGoeVdONPt9dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/a+D+aI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/a+D+aI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0C41F00893;
	Sun, 27 Sep 2026 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541771;
	bh=9VXQ7HkILLnRWPcSrW1LR7szTR5XD7SY49UdmSbZNhs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=G/a+D+aI6Qf+Tvlm8+lQ7YsnBqTCsZvPwSqr/QmtVKPmvFueIo0h74Jiboc+g/Yp4
	 bP4RbtT7ZLA5UZuveqCmKC4M7CXsbaaZ2tNQ13t1eYDvW5MayEQRS8sJBGqo324dvt
	 lvgT//aV76HpY94RMksrSVSxCgabNac1w0xCQzBouqHce/xzryGWLE/uHS4sx93i/o
	 o36TvjSx6u0uNAZxoAC7az59EoxfekbF6SwSDEh1T0cj1WVtKrbkSQu14sC4rk8xxT
	 CJrAAolPWw24lTz25PxnOZ0FJua1O/fswViaenoN+TwX8zbFo8wOMeqWwZIZwQoZp0
	 h+2oEzBvJX01w==
Content-Type: multipart/mixed; boundary="===============4703152210799744251=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a92d98d702c9cbab1575c9c4a6d9f721fa8b797012928dd5fee4b606574c543@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-36-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-36-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 36/36] selftests/bpf: cover SCEV analysis and loop widening
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:50 +0000 (UTC)

--===============4703152210799744251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 82b21ec472ba..2bc1ef910c16 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> new file mode 100644
> index 000000000000..69e9062870ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> +/*
> + * Loop A (counter in r6) contains irreducible loop B (header 5),
> + * which contains C (counter in r9).
> + * Entering B at 'body' saves and restores r6, making it appear invariant.
> + * Entering B at 'alternate' skips the save and modifies r6 instead.
> + * Hence A must not infer a SCEV expression for r6.
> + * SCEV expression for r9 in C should still be computed.
> + *
> + *  0: r6 = 0;
> + *     do {                              // A
> + *  1:     r6++;
> + *  2:     r0 = bpf_get_prandom_u32();
> + *  3:     r7 = 0;
> + *  4:     if (r0 > 5) goto alternate;
> + *  5: B:  r8 = r6;                      // B
> + *  6:     goto body;
> + *  7: alternate:
> + *         r8 = r6;
> + *  8:     r8++;
> + *  9: body:
> + *         r6 = r8;
> + * 10:     r9 = 0;
> + *         do {                          // C
> + * 11:         r9++;
> + * 12:     } while (r9 < 3);
> + * 13:     r7++;
> + * 14:     if (r7 < 4) goto B;
> + * 15: } while (r6 < 4);
> + * 16: r0 = 0;
> + * 17: return r0;
> + */
> +SEC("xdp")
> +__success
> +__log_level(2)
> +__msg("loop at 1{{$}}")
> +__msg("loop at 5, nested in 1, irreducible")
> +__msg("loop at 11, nested in 5")
> +__msg("scev at header 1:")
> +__msg_next("  r6=?")
> +__msg("scev at header 11:")
> +__msg_next("  r9=(+ r9 1) / (linear r9 1)")
> +__msg("loop header at 11, widening r9 to 0..2 step 1")
> +__not_msg("loop header at 1, widening r6")
> +__naked void nested_irreducible_loop(void)
> +{
> +	asm volatile ("					\
> +	r6 = 0;						\
> +a_%=:	r6 += 1;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r7 = 0;						\
> +	if r0 > 5 goto alternate_%=;			\
> +b_%=:	r8 = r6;					\
> +	goto body_%=;					\
> +alternate_%=:						\
> +	r8 = r6;					\
> +	r8 += 1;					\
> +body_%=:						\
> +	r6 = r8;					\
> +	r9 = 0;						\
> +c_%=:	r9 += 1;					\
> +	if r9 < 3 goto c_%=;				\
> +	r7 += 1;					\
> +	if r7 < 4 goto b_%=;				\
> +	if r6 < 4 goto a_%=;				\
> +	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

Does the comment describe the entry points correctly? Looking at the
pseudo-code and the asm, loop B has its header at 'b_' (insn 5, the
backedge 14 -> 5), and two entry points: the header itself at 'b_' (reached
by falling through from insn 4), and 'body_' at insn 9 (reached from
'alternate_' at insns 7-8).

The path that saves and restores r6 enters at the header 'b_':

    b_:  r8 = r6;
         goto body_;
    ...
    body_: r6 = r8;

The path that modifies r6 goes through 'alternate_' (which is outside loop
B), then enters B at 'body_':

    alternate_:
         r8 = r6;
         r8 += 1;
    body_: r6 = r8;   // gives r6 + 1

The comment says "Entering B at 'body' saves and restores r6" but that
describes the header path, and "Entering B at 'alternate'" names a label
that is outside B. Could the comment be updated to say "Entering B at B
saves and restores r6 ... Entering B at body (via alternate) skips the save
and modifies r6 instead"?

[ ... ]

> +/*
> + * Complement of no_widen_stack_spill: a sub-register (1-byte) store to the stack
> + * lands as STACK_MISC and carries no tracked value, so the induction variable
> + * addressing it (r2) is still widened.
> + */
> +SEC("xdp")
> +__success
> +__log_level(2)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("widening r2 to 0..24 step 8")
> +__naked void widen_byte_stack_store(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	r2 = 0;						\
> +1:	r3 = r10;					\
> +	r3 += -64;					\
> +	r3 += r2;					\
> +	*(u8 *)(r3 + 0) = r0;				\
> +	r0 += 1;					\
> +	r2 += 8;					\
> +	if r0 < 4 goto 1b;				\
> +	r0 = 0;						\
> +	exit;						\
> +"	::: __clobber_all);
> +}

Does the comment correctly describe the verifier's behavior here? In this
test, r3 = fp-64 + r2 with r2 in {0, 8, 16, 24}, so before widening each
store '*(u8 *)(r3 + 0) = r0' is at a fixed offset that is 8-byte-aligned
(-64, -56, -48, -40).

check_stack_write_fixed_off() handles that as a narrow spill when the value
fits:

    if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE &&
        env->bpf_capable) {
        ...
        save_register_state(env, state, spi, reg, size);

save_register_state() marks the low 'size' bytes STACK_SPILL and saves the
scalar. r0 is 0..3, so it fits in a byte and is fully tracked with its
scalar id. check_stack_read_fixed_off() then gives it back on a same-size
fill.

The store only lands as STACK_MISC after r2 is widened, because then the
write offset varies. That can happen with any size store, so it is not what
separates this case from no_widen_stack_spill.

The actual difference is that collect_store_base_regs() only counts BPF_W
and BPF_DW accesses:

    if (size == BPF_W || size == BPF_DW)

Byte and half-word spills lose precision under widening in the same way.

Could the comment describe the actual rule (byte and half-word accesses are
not treated as spill bases) rather than say a 1-byte store has no tracked
value? Also, BPF does not use the term "sub-register" for narrow
operations.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4703152210799744251==--
