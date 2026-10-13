Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84596313267
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917184; cv=none; b=rsKdokjY6OdYERdw0ByFoj80O9J0ab5bxtboJwWlq6C8b2B3wgvif3fGDedRFX9BWqlC34tk+jHwXEIHx4WT5kd62dqJJwnhvlEWVnQPbJn97MOcHawtF7y0aa6b8byXgvuqdL3Uf7AoOVEzK7dfsKTmD2kTOntzBW1PlE5Gef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917184; c=relaxed/simple;
	bh=STBDSe++wqW2LusJKjTlOyzqUfdCI5g3g/N9BjL62+I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mzVAOPuaAQClcTuP02n8JbKWBjpTl6UPZdkN/CnJpsdz6S24iLo3W4MEEICxUqBCVO+83pm9QKUaYKXqyEbM+z4U/gPeSMVUyqTwc0kOMFLM4TNZsoAqgM/KAbppu8u4UmVsTBO4S78Hmu/ujcmH5ODB4KZv+TXHUnGz8wFeM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5e5mC/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5e5mC/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46591F000FF;
	Tue, 13 Oct 2026 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917182;
	bh=oGfRC8+LTJbuz4XUSr1FzuaB7mHcWpUlGuqgJdD6TIE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q5e5mC/qQvXBdnUbIQs9FEX8Ve/nLxH3IJXEuFttDx6ohU1gc9B+I8UtyVdhTLqcy
	 yU8aDjoVNpbaW+42aRueFUn78UNu00VUKzbkL9pG25sjpAfJ+5k6wg3s8WCcbT1m3X
	 3ZLMjZNvPDtTW3MzmTMPhYXPicamKK7ROo7sIvrxZ00aHWw5EtI58pD1iAwrSYUzxr
	 3plQltesF59qZkLAv+bF77/fmYs1Ols7Ua/+NjTrDV9YlMv84+Wn20XiXPnZkiE4pF
	 u0LG6d4F+A/JnUESBFd0krNKkv7dDXjEiezYhEa8YACncwksgXIAvOMLUW12+tY41F
	 WhO058K76VWCg==
Content-Type: multipart/mixed; boundary="===============8695117140356268114=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2730fafced4cbfb48a7a5085a19f6dbace8c619a81e6de7f1c2a667a0ed98a7e@mail.kernel.org>
In-Reply-To: <20261013171230.523677-18-daniel@iogearbox.net>
References: <20261013171230.523677-18-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 17/18] selftests/bpf: Add JIT instruction tests
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 18:46:20 +0000 (UTC)

--===============8695117140356268114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add JIT instruction tests

TL;DR:
- Test gaps: verifier may fold the staggered jumps away, and mis-targeted
  jumps may still pass
- 32-bit cmpxchg compare of a non-zero upper r0 half is no longer covered
- Missing JIT features may fail instead of skip

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> new file mode 100644
> index 000000000000..dabf8a4abdfe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> @@ -0,0 +1,2433 @@

[ ... ]

> +static void emit_alu_imm(struct batch *b, void *arg, __s64 dst, __s64 imm)
> +{

[ ... ]

> +	if (!alu_result(&res, dst, (__s32)imm, a->op, a->flags))
> +		return;
> +	k = batch_case(b, BPF_REG_3, dst, 0);

Does this record the right second input for the failure message?
batch_case(b, BPF_REG_3, dst, 0) stores in1 = 0 for every case, but the
immediate is the only operand that varies within one dst value.

batch_flush() identifies a failing case only by its recorded inputs:

    snprintf(buf, sizeof(buf), "%s: in0=0x%llx in1=0x%llx out%d",
             b->desc, b->ctx.in[k][0], b->ctx.in[k][1], j);

A wrong "alu64_div_k magnitudes" or "alu64_mul_k magnitudes" result is
therefore reported as in0=0x4000000000000000 in1=0x0, which cannot tell the
failing immediate apart from the dozens of others used with the same dst.
For div and mod it even suggests a zero divisor, which alu_result() never
lets through.

emit_jmp(), test_shifts() and div_const() all pass their immediate to
batch_case().  Would this work as:

    k = batch_case(b, BPF_REG_3, dst, (__s32)imm);

in[k][1] is never loaded by this program, so only the diagnostic changes.

[ ... ]

> +static void emit_cmpxchg(struct batch *b, void *arg, __s64 dst, __s64 src)
> +{

[ ... ]

> +	/* Mismatch: the memory keeps its value, r0 gets it */
> +	EMIT(b, BPF_MOV64_REG(BPF_REG_0, BPF_REG_1));
> +	EMIT(b, BPF_ALU64_IMM(BPF_XOR, BPF_REG_0, -1));
> +	EMIT(b, BPF_ATOMIC_OP(size, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, MEM_SLOT));
> +	ST_OUT(b, k, 0, BPF_REG_3, BPF_REG_0);
> +	/* Match: the memory gets the source, r0 the old value */
> +	EMIT(b, BPF_ATOMIC_OP(size, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, MEM_SLOT));

Is the successful 32-bit compare still exercised with a non-zero upper half
in r0 here?

The matching BPF_CMPXCHG reuses the r0 left behind by the mismatching one,
and the verifier always zero extends r0 after a BPF_W cmpxchg, so the upper
32 bits of r0 are zero when the matching compare runs.

The test_bpf version this was ported from (__bpf_emit_cmpxchg32()) reloaded
r0 with the full 64-bit dst before the matching cmpxchg:

    /* Result successful */
    i += __bpf_ld_imm64(&insns[i], R0, dst);
    insns[i++] = BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R2, -4);

so for negative values and magnitudes of 2^32 and up the JIT had to compare
only the low half.

Nothing else in jit_insns covers this.  atomic_reg_pairs() sets r0 to ~mem
and only tests the mismatch path, and test_ldst_zero_off() loads r0 with a
zero extending BPF_LDX_MEM(BPF_W, ...).  A JIT that compares all 64 bits of
r0 against the zero extended memory value would pass every jit_insns case.

The next commit in the series, 5ba768097e67 ("selftests/bpf: Remove the old
test_bpf module"), removes test_bpf, and nothing later restores this check.

Would reloading r0 before the matching cmpxchg, for example with
LD_IN(b, k, 0, BPF_REG_3, BPF_REG_0), work?  The low 32 bits of in0 still
equal the memory value, so the expected results stay the same.

[ ... ]

> +/*
> + * Taken jumps over regions of doubling length, forward or backward, up to
> + * the maximal offset of the jump: 16 bits, or 2^17 for the 32-bit
> + * unconditional jump. The not taken path of a conditional jump and the
> + * guard of an unconditional one lead to an exit with the region number, so
> + * the verifier sees every instruction reachable and a jump landing anywhere
> + * else than on its target fails the run.
> + */
> +static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool backward,
> +			    const char *desc)

[ ... ]

> +	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8);
> +	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> +	insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
> +	for (gap = backward ? 4 : 2; gap <= max; gap = gap < max / 2 ? gap * 2 : max) {

Do all the jumps still reach the JIT with long offsets?

r1 and r2 are loaded from the ctx only once, here, and every later region
reuses the bounds the verifier learned on the taken path of the region
before it.  For four of the eight kinds that is enough for the verifier to
decide the branch:

- "staggered jmp_jeq_k": after the taken JEQ r1, 1234, r1 is the constant
  1234, so every later JEQ is always taken.

- "staggered jmp32_jlt_k": after the taken JLT w1, 0x80000000, the u32 max
  of w1 is 0x7fffffff, so every later JLT is always taken.

- "staggered ja" and "staggered gotol": the guard JEQ r2, 0, +1 falls
  through with r2 != 0, so every later guard is never taken.

The skipped paths are never marked seen, and since test_progs runs with
CAP_BPF the verifier then runs bpf_opt_hard_wire_dead_code_branches(),
bpf_opt_remove_dead_code() and bpf_opt_remove_nops().

In the forward layout every region after the first is deleted and its jump
becomes "ja +0", so "staggered ja forward", "staggered gotol forward",
"staggered jmp_jeq_k forward" and "staggered jmp32_jlt_k forward" each JIT
only a single 2-instruction jump.

In the backward layout the regions survive, but for jeq_k and jlt32_k every
conditional jump after the first is rewritten to a plain BPF_JA with the
same offset.  No JMP32 conditional with an immediate, and no 64-bit JEQ
with an immediate, reaches the JIT with a long offset.

This seems to contradict "so the verifier sees every instruction reachable"
in the comment above.  lib/test_bpf.c ran its programs without the
verifier, so it had no such folding.  Would reloading r1 and r2 from the
ctx inside each region, right before the guard or jump, stop the refined
bounds from carrying over?

The same happens in test_jmp_reg_pairs() for rd == rs, since the verifier
resolves "reg1 == reg2" for every op except JSET, so those register
combinations never reach the JIT as jumps.

[ ... ]

> +		} else {
> +			/* An unconditional jump needs a way into its region */
> +			if (ja)
> +				insns[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1);
> +			insns[i] = *jmp;
> +			set_jmp_off(&insns[i++], ja32, gap);
> +			insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, ++n);
> +			for (k = 0; k < gap - 2; k++)
> +				insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0);
> +			insns[i++] = BPF_EXIT_INSN();
> +		}

Can a jump that lands inside the skipped region be detected here?

The program starts with r0 = 0 and passes when opts.retval is 0.  In the
forward layout only the "r0 = n" slot right after the jump writes r0.  If a
JIT miscomputes the target and the jump lands anywhere in the "r3 = 0"
fillers or on the region's exit, execution reaches an exit with r0 still 0
and ASSERT_EQ(opts.retval, 0, desc) passes.  All later regions are skipped
as well, so their jumps never run.

The backward layout has the same weakness.  The region body only holds
"r3 = 0", so a backward jump that lands short in the body, or a leading
jump that lands in the body instead of on the guard, still reaches the
region's exit and continues to the next region.

So the only mis-target that is caught is a landing on the single "r0 = n"
slot, which in practice means the jump was not taken at all.  That does not
match "a jump landing anywhere else than on its target fails the run" in
the comment above.  max_jmp() in the same file ends its skipped region in
"r0 = 2", so any landing inside it changes the result.

lib/test_bpf.c checked r0 at every hop in __bpf_fill_staggered_jumps(), and
5ba768097e67 deletes that.  Would filling the skipped forward region with
"r0 = n" instead of "r3 = 0" close the forward gap?  The backward layout
would need a check that a short landing cannot get past and that the
verifier cannot constant-fold.

[ ... ]

> +	fd = load_prog(insns, i, desc);
> +	if (fd >= 0) {
> +		if (ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), desc))
> +			ASSERT_EQ(opts.retval, 0, desc);
> +		close(fd);
> +	}

[ ... ]

> +static int prog_load(struct prog *p, const char *desc)

[ ... ]

> +	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", p->insns, p->cnt, &lopts);
> +	if (!ASSERT_GE(fd, 0, desc))
> +		fprintf(stderr, "%s", log);
> +	return fd;

A subsystem pattern flags this as potentially concerning: the "staggered
gotol" kinds load through load_prog(), and the cpu v4 sweeps load through
prog_load() in the same way.  Both treat every load error as a failure
via ASSERT_GE(fd, 0, desc).

The x86-32, sparc64, parisc and riscv32 JITs have no BPF_JMP32 | BPF_JA
case.  With CONFIG_BPF_JIT_ALWAYS_ON, __bpf_prog_select_runtime() then sets
*err = -ENOTSUPP, and the subtest fails instead of skipping with a reason.
The same file already probes and skips for a missing JIT capability in
acq_rel_ok() and test_acq_rel().  Should the capability-absent case be a
skip here?

On the other hand, without JIT_ALWAYS_ON the kernel falls back to the
interpreter and the load succeeds.  5ba768097e67 says that archs wanting
BPF JIT support should move over to these selftests, so a hard failure on a
missing JIT instruction may be intended.

[ ... ]

> +static int off_prog_load(struct off_prog *p, const char *desc, bool quiet)

[ ... ]

> +	if (!ASSERT_GE(fd, 0, desc))
> +		fprintf(stderr, "%s", log);
> +	return fd;

[ ... ]

> +static void load_offsets(struct off_mem *m, int kind, int size, int rb, int rd,
> +			 const int *off, int nr)

[ ... ]

> +		if (kind == K_LDX)
> +			EMIT(&p, BPF_LDX_MEM(size, rd, rb, off[i]));
> +		else
> +			EMIT(&p, BPF_RAW_INSN(BPF_LDX | BPF_MEMSX | size, rd, rb, off[i], 0));

A subsystem pattern flags this as potentially concerning: test_ldst_offsets()
calls load_offsets(&m, K_LDSX, ...) for B/H/W, which emits BPF_LDX |
BPF_MEMSX loads, and off_prog_load() asserts on any load failure.

The verifier accepts BPF_MEMSX on every architecture, but the x86-32, mips,
sparc, parisc and riscv32 JITs have no BPF_MEMSX case.  With
CONFIG_BPF_JIT_ALWAYS_ON=y, __bpf_prog_select_runtime() then returns
-ENOTSUPP:

    if (!fp->jited && jit_needed) {
            *err = -ENOTSUPP;

and each LDSX combination is reported as a FAIL instead of a skip.

The same change already probes and gates one missing capability with
unaligned_ok(), and gates load-acquire/store-release with acq_rel_ok() and
test__skip().  progs/verifier_ldsx.c also restricts its LDSX tests to the
JITs that support them.  Would a one-time probe like unaligned_ok() that
skips the K_LDSX calls, with a message, be appropriate?

That said, failing here may be intended, since the aim is to flag JITs that
lack the cpu v4 instructions.  Without JIT_ALWAYS_ON the load falls back to
the interpreter and passes, and the plain LDX/STX/ST programs only use base
instructions.  test_movsx() behaves the same way.

[ ... ]

> +static void test_probe_mem(void)

[ ... ]

> +			EMIT(&p, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL,
> +					      0, kfunc_id));

[ ... ]

> +			fd = prog_load(&p, desc);
> +			if (fd < 0)
> +				return;

A subsystem pattern flags this as potentially concerning: every program
here calls the bpf_rdonly_cast kfunc, and bpf_add_kfunc_call() rejects such
a program with -ENOTSUPP in two cases:

    if (!env->prog->jit_requested) {
        verbose(env, "JIT is required for calling kernel function\n");
        return -ENOTSUPP;
    }
    if (!bpf_jit_supports_kfunc_call()) {
        verbose(env, "JIT does not support calling kernel function\n");
        return -ENOTSUPP;
    }

The first case is bpf_jit_enable=0 without CONFIG_BPF_JIT_ALWAYS_ON.  The
second is any JIT that does not override the weak
bpf_jit_supports_kfunc_call(); only loongarch, arm64, parisc, powerpc,
riscv, s390, x86 and x86-32 do, so the 32-bit arm, mips and sparc JITs are
among those affected.

In both cases prog_load() hits ASSERT_GE(fd, 0, desc) and the probe_mem
subtest is reported as FAIL, although the -ENOTSUPP only means the
capability is absent.  Should this skip instead?

5ba768097e67 ("selftests/bpf: Remove the old test_bpf module") makes
jit_insns the replacement for test_bpf and says that archs wanting BPF JIT
support should move over to the selftests.  A failure here may be intended,
since the usual way to exclude a BPF selftest on an arch that lacks a
feature is a DENYLIST entry.

[ ... ]

> +static bool acq_rel_ok(void)

[ ... ]

> +	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", p.insns, p.cnt, &lopts);
> +	if (fd < 0)
> +		return false;

[ ... ]

> +	if (!acq_rel_ok()) {
> +		test__skip();
> +		return;
> +	}

The opposite case is handled here: acq_rel_ok() returns false for any load
error, and test_acq_rel() then calls a bare test__skip() without a reason.

Doesn't that treat a capability-absent error (-EOPNOTSUPP for 64-bit on
32-bit arches, or -ENOTSUPP from a JIT that cannot emit the instruction
under JIT_ALWAYS_ON) the same as a verifier or JIT regression (-EINVAL,
-EACCES) on a JIT that does support load-acquire?  Such a regression would
show up as SKIP instead of FAIL.

[ ... ]

> +void test_jit_insns(void)
> +{
> +	RUN_TESTS(jit_insns_arena);

A subsystem pattern flags this as potentially concerning: the two arena
subtests run from here fail, rather than skip, on any JIT without arena
support.

arena_map_alloc() returns -EOPNOTSUPP when !bpf_jit_supports_arena(), which
is the case for the arm32, x86_32, mips, parisc, ppc32, riscv32, sparc64
and arc JITs.  The "arena" map in progs/jit_insns_arena.c then fails to
create, and test_loader reports "arena access with zero offset" and "cast
to a user address" as FAIL.  So the whole jit_insns test fails on those
JITs, although the commit message says the tests run "on every JIT" and
5ba768097e67 points exactly these architectures at them.

The two arena programs also call a kfunc, and test_jit_insns() deliberately
does not check is_jit_enabled().  With bpf_jit_enable=0 and no
CONFIG_BPF_JIT_ALWAYS_ON they fail with "JIT is required for calling kernel
function" while the raw-instruction subtests pass on the interpreter.

The same file already handles a missing JIT feature by probing and
skipping in test_acq_rel().  Could the arena programs be gated the same
way, for example by probing libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA,
NULL) before RUN_TESTS(jit_insns_arena)?

The header comment of jit_insns_arena.c says a kernel without arena support
"fails only these programs", and verifier_arena is also run with RUN()
rather than RUN_JITED(), so failing may be intended.

[ ... ]

> +void serial_test_jit_insns_blinded(void)
> +{

[ ... ]

> +	if (!is_jit_enabled()) {
> +		test__skip();
> +		return;
> +	}

Relatedly, serial_test_jit_insns_blinded() calls test__skip() here without
printing a reason when the JIT is disabled.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38442623945
--===============8695117140356268114==--
