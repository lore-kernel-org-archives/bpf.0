Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545154399EA
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123892; cv=none; b=R1bT50QI/35gnfVpi8ipzxmHY4vRvetPEX4Mc5HK0LntYqPzYX0Kcxi7isjc4ko7yI6hB5v8FtlsjlYx0fEeAfiHN8ivzR6MjorbwdwJlwvVbMv+5Lb+MY367dJKUiSydjnJ+RHBbLUVcBX9PsRjczmuDtBQl7Cgt4BLT15AXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123892; c=relaxed/simple;
	bh=H2TSuvZPo9QIRDJj1yja7vfqfJY5h+XZU2UCNVOlaQA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GUtcnHKpQMV9EJhfh3WV11sAG/ZY0UpPHWzQzry4dCpu7+j+FukR61K7cZcfTRf4SuQ9IobpA1NzdiUTm5/xRTXj7HShP741Jv30q01g5LMwSExLMb3Z2x0CSUW1dVx6IO/eXX5J4uzRMhRWrjnjOcUtzbRYUFPqIWC0puQc3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCp6b2JS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCp6b2JS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9432C1F000FF;
	Sun,  4 Oct 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123890;
	bh=igRnSOg8ppKq53wLej+3dS19KsZQNmliUj2AA5WKlqo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bCp6b2JSKSh5tvnkM9F+qTbg3lF3/bT00Gbk9dUQWtj00QnsSUGoliJxWbeMui3Bh
	 7gRHdMuscicl4dzJ9CuCPF1V6Cka69A1ylqrxfOW/Ib/w3QK8aFNNOPxkQz8PXUTEJ
	 I/IdYXbd5T4MiCewrZlSk/Qvjdq3DP/hlBSwKacv4wjxjQP7ONPRS02yAMJRD6xt00
	 8Cwt9Iy/Tmms315J/tbKlr/Lpq3ATe5c+xvU+bC2Xyqba3jR6mr+Yx/uG+II8QVuGc
	 aY5PgBOb15qTFnaQCPPKBEtulJPVqYauwwtHyLqFlePxBAt2K4R0WwuLTUCYYOsico
	 44U13hN2D6GdQ==
Content-Type: multipart/mixed; boundary="===============8218615695770975537=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f119c0b4d52ec59b861294f9d32bfe97007ec504f165dbf0b1cb3dceba3b1d53@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-43-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-43-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 43/43] selftests/bpf: tests for SCEV analysis and loop widening
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:49 +0000 (UTC)

--===============8218615695770975537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for SCEV analysis and loop widening

TL;DR:
- store_load_exprs test lacks CAN_USE_LOAD_ACQ_STORE_REL guard, so it may fail
  instead of skip on 32-bit or some JIT-only arches
- nested_irreducible_loop __not_msg may never fail
- comment inaccuracies only

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> new file mode 100644
> index 000000000000..7a1b5b8ec287
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
> @@ -0,0 +1,2376 @@

[ ... ]

> +__naked void store_load_exprs(void)
> +{
> +	asm volatile (

[ ... ]

> +	ST_OP(".8byte %[load_acquire8]")
> +	ST_OP(".8byte %[load_acquire16]")
> +	ST_OP(".8byte %[load_acquire32]")
> +	ST_OP(".8byte %[load_acquire64]")
> +	ST_OP(".8byte %[store_release8]")
> +	ST_OP(".8byte %[store_release16]")
> +	ST_OP(".8byte %[store_release32]")
> +	ST_OP(".8byte %[store_release64]")

A subsystem pattern flags this as potentially concerning: a test that depends
on an optional capability should be skipped, rather than fail, when the
capability is absent.

store_load_exprs() always emits BPF_LOAD_ACQ and BPF_STORE_REL instructions
and is tagged __success.  The other selftests that use these instructions
(verifier_load_acquire.c, verifier_store_release.c, verifier_precision.c,
verifier_arena_scalar.c, compute_live_registers.c and verifier_live_stack.c)
guard them with #ifdef CAN_USE_LOAD_ACQ_STORE_REL.

Without such a guard, could this test fail instead of being skipped on
configurations that lack support?  On 32-bit kernels, check_atomic() rejects
the BPF_DW form:

    case BPF_LOAD_ACQ:
        if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
            verbose(env, "64-bit load-acquires are only supported on 64-bit arches\n");
            return -EOPNOTSUPP;
        }

On 64-bit arches whose JIT does not implement these instructions (mips64 and
sparc64, for example) and that set CONFIG_BPF_JIT_ALWAYS_ON,
bpf_prog_select_runtime() returns -ENOTSUPP.

In both cases test_loader would report unexpected_load_failure for the whole
store_load_exprs subtest, including its ordinary load/store expectations.
Without CONFIG_BPF_JIT_ALWAYS_ON the interpreter handles these instructions,
so the 64-bit arch case would still pass there.

Would it make sense to put the load_acquire/store_release ST_OP lines, their
__imm_insn operands and their __msg expectations under
#ifdef CAN_USE_LOAD_ACQ_STORE_REL, or move them into a separate guarded test?

[ ... ]

> +/*
> + * Loop A (counter in r6) contains irreducible loop B (header 5),
> + * which contains C (counter in r9).
> + * Entering B at 'body' saves and restores r6, making it appear invariant.
> + * Entering B at 'alternate' skips the save and modifies r6 instead.
> + * Hence A must not infer a SCEV expression for r6.
> + * SCEV expression for r9 in C should still be computed.
[ ... ]
> + *  5: B:  r8 = r6;                      // B
> + *  6:     goto body;
> + *  7: alternate:
> + *         r8 = r6;
> + *  8:     r8++;
> + *  9: body:
> + *         r6 = r8;

This isn't a bug, but does the comment assign the two entries of B the wrong
way round?

B is {5, 6, 9..14} in the pseudo-code above and has two entry points: its
header 'B' (insn 5, reached by fall-through from insn 4) and 'body' (insn 9,
reached from 'alternate', insns 7-8, which are outside B).

Entering at the header 'B' is the path that saves and restores r6:

    r8 = r6; goto body; ... r6 = r8;

Entering at 'body' via 'alternate' is the path that modifies r6:

    r8 = r6; r8++; r6 = r8;

The comment says "Entering B at 'body' saves and restores r6" and "Entering B
at 'alternate' skips the save and modifies r6".  That names 'body' as the
invariant entry, and names 'alternate' as an entry of B although it is not
part of B.

Would something like this be more accurate?

    Entering B at its header 'B' saves and restores r6, making it appear
    invariant.  Entering B at 'body' (via 'alternate') skips the save and
    modifies r6 instead.

[ ... ]

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

Can this __not_msg() ever fail?  The comment says "Hence A must not infer a
SCEV expression for r6", but it looks like the check cannot catch widening of
r6 in loop A.

test_loader's match_negative_msgs() only searches for a __not_msg() pattern
in the span between the end of the previous positive match and the start of
the next one.  When no positive match follows, the span runs to the end of
the log.  Here the previous positive match is:

    __msg("loop header at 11, widening r9 to 0..2 step 1")

Widening is only logged when a loop is first pushed on the loop stack:
handle_loop_entry_exit() calls bpf_compute_loop_iters() and
bpf_widen_scev_regs() only when loop_stack_push() sets pushed = true.

Loop A (header 1) is pushed once, on the 0 -> 1 edge at the very start of
do_check(), which happens before the verifier first reaches insn 11 via
1..4 -> 5 -> 6 -> 9 -> 10 -> 11.  Every later visit to insn 1 arrives through
the 15 -> 1 backedge with A already on the loop stack.  That path goes to
maybe_clamp_scev_regs() and never logs "widening".

So any "loop header at 1, widening r6 ..." line would appear before the
matched r9 widening line, outside the searched span.  If
bpf_widen_scev_regs() started widening r6 for loop A, this check would still
pass.  Only the earlier __msg_next("  r6=?") would catch a related
regression, and that checks the SCEV printout rather than the widening
decision.

Would moving the __not_msg() before the "widening r9" __msg(), for example
right after:

    __msg_next("  r9=(+ r9 1) / (linear r9 1)")

make its span cover do_check()'s processing of header 1?

[ ... ]

> +/*
> + * Complement of no_widen_stack_spill: a sub-register (1-byte) store to the stack
> + * lands as STACK_MISC and carries no tracked value, so the induction variable
> + * addressing it (r2) is still widened.
> + */
[ ... ]
> +__naked void widen_byte_stack_store(void)

Is the stated reason for widening accurate here?  The comment says a 1-byte
store "lands as STACK_MISC and carries no tracked value", but that only holds
once r2 has been widened and the store has a varying offset
(check_stack_write_var_off() marks the bytes STACK_MISC).

At a fixed, 8-byte-aligned offset, which is what the un-widened loop would
produce here (fp-64, fp-56, fp-48, fp-40), check_stack_write_fixed_off()
saves a scalar byte store as a narrow spill whose value is tracked:

    if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE &&
        env->bpf_capable) {
        ...
        save_register_state(env, state, spi, reg, size);

check_stack_read_fixed_off() then returns the exact value for a 1-byte read
of the same slot.  So widening r2 does lose tracked values for byte stores
too.

The reason r2 is widened appears to be that collect_store_base_regs() only
treats BPF_W and BPF_DW stores and loads as stack bases:

    if (size == BPF_W || size == BPF_DW)

If so, the cause and effect in the comment are reversed: the store lands as
STACK_MISC because r2 was widened, not the other way round.  This also
misdescribes the trade-off made by commit 04dcb46b3aba.

Could the comment say that byte and half-word stores are intentionally not
considered stack bases (accepting the loss of narrow-spill precision), rather
than saying such stores carry no tracked value?

[ ... ]

> +/*
> + * struct xdp_md *slots[2] = { ctx, ctx };
> + *
> + * r7 = 0;
> + * for (r8 = 0; r8 < 2; r8++) {
> + *         value = slots[r7]->data;
> + *         if (i == 0)
> + *                 r7 = 1;

[ ... ]

> +	if r8 != 0 goto 2f;				\
> +	r7 = 8;			/* conditionally update r7 */ \

This isn't a bug, but the pseudo-code in the comment tests a variable i
that does not exist:

    if (i == 0)
            r7 = 1;

The loop counter is r8 (for (r8 = 0; r8 < 2; r8++)) and the assembly tests
r8:

    if r8 != 0 goto 2f;
    r7 = 8;

Should the condition read "if (r8 == 0)"?

The same comment also uses two units for r7: the pseudo-code sets r7 = 1 (an
index into slots[]), while the assembly and the following sentence ("SCEV
expression for r7 is (any r7 8)") use the byte offset 8.  Should the
pseudo-code say whether r7 is an index or a byte offset?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============8218615695770975537==--
