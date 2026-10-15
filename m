Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A63BF677
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087745; cv=none; b=e9fNyrPnv/hl3irWgKPSYefUDIkVEFDw9kg73l0Ez02x1UmOAQq577MqjqFq66cc29MADdm0K0+3v/48tmrhw06DdFxbcI0Wb5id9b6X86JkaZOnjefCcOwEJK1MUV/n8q8JpXi4wn1ypRYTtWpZbZNO1njhdVOxni5riWcDer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087745; c=relaxed/simple;
	bh=pCwLO9KL7+4t7ull3XRtDGLL4YyzP3Od2pLrTHa5pwA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pcjXYafvseKcPgZmjtMifp9tzsPdqyQDGdP7A/ApoukKMEJ4RhyI2QJkGG2LBHNTMi5M5Y+hKcimurMkb3gjbol0ZrBanIM2RGTUdPEXu7heQGgRuIG7gCVjH8zUkTzynsq9W0Tg9aeMtoh+UTR9uvo3J0Mz/jWF2+VmfPNzdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgUWpmKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgUWpmKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E59E1F000C4;
	Thu, 15 Oct 2026 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792087735;
	bh=E8vqjZEjKdmczuyYd5aag6gd+uA112nlhG1I/pzwjSA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KgUWpmKq8CyZW2lT3rT1Podlq1BSwZ+LRzJIz74NN+Mb+46uEXsiDcIS+xNadIq1u
	 GAZoMNzfiuczD/J/U57ro3VnEaUxEIGuOUL2YMi+29RPbxglfEtYui+3PF/5trOrwa
	 mGvy9U/GTd4vdgDWinBudrynvRrKHwYwK0q6wtXQ2KqL65dyXPdWKTJPih8uwa/Jog
	 evSGBVP2kzvt7tBWuAe6oH6XWJvROn8Wsr2wjNmyfijFNvkZgYQqDiXmEEEVBxGXrU
	 E9ilzCmacseW4DURME1vJGKgKBVFUcf3uRBPnounMMqoHtM1kIBzHH1pVZoChaiNCb
	 rsJUE4QOmsYFQ==
Content-Type: multipart/mixed; boundary="===============5756007415653613052=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5ac7a3c96c75413b180c435b15401c2f6435824eff44de5df2fd4942da603f46@mail.kernel.org>
In-Reply-To: <20261015171917.599025-1-daniel@iogearbox.net>
References: <20261015171917.599025-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Follow-up coverage to JIT instruction tests
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 18:08:54 +0000 (UTC)

--===============5756007415653613052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Follow-up coverage to JIT instruction tests

TL;DR:
- New selftests may fail on s390x/powerpc: shift-count edges assume masking
  those JITs may not do
- calls subtest may fail to load on JITs without large stack (512-byte limit)
- stale comment and redundant div_result() special case (nits)

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> index dabf8a4abdfe..86fb43484f07 100644
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c

> @@ -192,9 +251,10 @@ static const char *jmp_name(int op)
>  /* ALU result computation, false when the operands are not valid */
>  enum { F_ALU32 = 1, F_SIGNED = 2 };
>  
> -static bool alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
> +static void alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
>  {
>  	bool is_signed = flags & F_SIGNED;
> +	int mask = flags & F_ALU32 ? 31 : 63;
>  
>  	/* Narrow operands for ALU32 */
>  	if (flags & F_ALU32) {

This isn't a bug, but the comment above the enum still describes the old
contract:

/* ALU result computation, false when the operands are not valid */

alu_result() now returns void and gives a defined result for every operand,
including zero divisors, signed division by -1 and out of range shift
counts, so it has no false return any more.  Could the comment be updated
to say that it models the ISA result for all operands?

Also, div_result() still special-cases the signed -1 divisor:

static __u64 div_result(int op, __u32 flags, __s32 imm, __u64 n)
{
	__u64 res;

	/* LLONG_MIN / -1 == LLONG_MIN, LLONG_MIN % -1 == 0, same for INT_MIN */
	if ((flags & F_SIGNED) && imm == -1)
		res = op == BPF_MOD ? 0 : -n;
	else
		alu_result(&res, n, (__s32)imm, op, flags);
	return flags & F_ALU32 ? (__u32)res : res;
}

alu_result() now handles that case itself (-v1 for BPF_DIV, 0 for BPF_MOD),
and the results are identical after truncation.  Is the special case in
div_result() still needed?

[ ... ]

> @@ -398,6 +486,41 @@ static void test_alu_reg(void)

[ ... ]

> +			for (r = 0; r < (a.op == BPF_NEG ? 1 : 2); r++) {
> +				snprintf(b.desc, sizeof(b.desc), "alu%d_%s%s_%c edges",
> +					 f ? 32 : 64, a.flags & F_SIGNED ? "s" : "", alu_name(a.op),
> +					 r ? 'x' : 'k');
> +				if (a.op == BPF_NEG) {
> +					for (i = 0; i < ARRAY_SIZE(edges); i++)
> +						emit_alu_imm(&b, &a, edges[i], 0);
> +					batch_flush(&b);
> +				} else if (r) {
> +					fill_edges(&b, &a, false, emit_alu_reg);
> +				} else {
> +					fill_edges(&b, &a, true, emit_alu_imm);
> +				}

Do these edge sweeps pass shift counts that not every JIT masks?

fill_edges() feeds every value in edges[] (0x7f, 0xff, 0x7fffffff,
0xffffffff, ...) as the register count for BPF_LSH, BPF_RSH and BPF_ARSH,
and the expected result comes from alu_result(), which now masks the count
by the width:

	int mask = flags & F_ALU32 ? 31 : 63;
	...
	case BPF_LSH:
		*res = v1 << (v2 & mask);

That matches the interpreter in kernel/bpf/core.c
(DST = (u32) DST OP ((u32) SRC & 31)) and instruction-set.rst.  The
verifier, however, calls these shifts undefined
("Shifts greater than 31 or 63 are undefined" in
is_safe_to_compute_dst_reg_range()), and nothing masks the count before the
JIT runs.

Not every JIT masks it.  In arch/s390/net/bpf_jit_comp.c, BPF_ALU | BPF_LSH |
BPF_X emits "sll %dst,0(%src)" (and srl for BPF_RSH).  SLL/SRL use only the
low six bits of the address as the count, so a 32-bit shift by 32..63 gives
0 rather than a shift by count & 31.  In arch/powerpc/net/bpf_jit_comp64.c,
PPC_RAW_SLW has a 6-bit count for ALU32 and PPC_RAW_SLD a 7-bit count for
ALU64.

On s390x, "alu32_lsh_x edges" with in0=0x1 and in1=0x7f expects
(u32)(1 << 31) = 0x80000000, but the JIT shifts by 63 and stores 0.
"alu32_rsh_x edges" with in0=0x80000000 and in1=0x7f expects 1 but gets 0.
On ppc64, "alu64_lsh_x edges" with in1=0x7f expects v1 << 63 but gets 0.
batch_flush() would then fail ASSERT_EQ, and jit_insns/alu_edges and
jit_insns_blinded/alu_edges fail.

jit_insns is not in tools/testing/selftests/bpf/DENYLIST.s390x, the commit
message shows only an x86 run, and nothing in the series changes a JIT.

The new counts[] in test_shifts() has the same dependency:

> @@ -632,8 +764,10 @@ static void test_shifts(void)
>  		0x0123458967abcdefLL, /* dword > 0, word > 0 */
>  	};
>  	static const int ops[] = { BPF_LSH, BPF_RSH, BPF_ARSH };
> +	/* Counts at and above the width and negative ones, masked by the width */
> +	static const __s64 counts[] = { 32, 33, 63, 64, 65, 127, -1, -3, 1LL << 32 | 3 };
>  	struct batch b;
> -	int o, f, v, imm, k;
> +	int o, f, v, c, imm, k;

Should the series fix the s390 and powerpc JITs to mask the count first, or
should the register count edges for shifts stay within the width until they
do?

[ ... ]

> @@ -2340,6 +2522,168 @@ static void test_max_jmp(void)

[ ... ]

> +static void test_calls(void)

[ ... ]

> +			insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8);

[ ... ]

> +			/* Clobber the rest, sum the arguments through the deepest slot */
> +			for (r = 0; r < 4; r++)
> +				if ((nested ? ~mask : mask) & (1 << r))
> +					insns[n++] = BPF_MOV64_IMM(BPF_REG_6 + r, 0);
> +			insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -512);

[ ... ]

> +			fd = load_prog(insns, n, desc);
> +			if (fd < 0)
> +				return;

Can the calls subtest load on JITs without large stack support?

The main frame spills ctx to the stack:

	insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8);

and the deepest callee (the direct callee, or the second level one when
nested) then writes the deepest slot:

	insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -512);

check_max_stack_depth_subprog() adds up the rounded frame depths along the
call chain and compares the total with env->stack_limit.  With the JIT that
is round_up(8, 16) + round_up(512, 16) = 528.  With the interpreter it is
round_up(8, 32) + 512 = 544.

env->stack_limit comes from bpf_prog_stack_limit():

	if (prog->jit_requested && !bpf_prog_is_offloaded(prog->aux) &&
	    bpf_jit_supports_large_stack() && bpf_jit_supports_subprog_tailcalls())
		return MAX_BPF_STACK_JIT;
	return MAX_BPF_STACK;	/* 512 */

Only arch/x86 and arch/arm64 override the weak
bpf_jit_supports_large_stack(), which returns false otherwise.
BPF_PROG_TYPE_SYSCALL gets no private stack either, since
bpf_enable_priv_stack() returns NO_PRIV_STACK for it.

So on s390x, riscv64, powerpc64 and loongarch64, and on any run with
bpf_jit_enable=0, the limit is 512 and the first case already fails with:

	combined stack size of 2 calls is 528. Too large

load_prog()'s ASSERT_GE(fd, 0) then fails the jit_insns/calls subtest.
Those JITs support bpf2bpf calls and a -512 slot in a single frame, so the
failure says nothing about them.  jit_insns is not in DENYLIST.s390x, and
the commit message shows only an x86 run.  The later commit in the series,
"selftests/bpf: Add JIT cBPF-related instruction tests", does not touch
this code.

Also, -512 is not the deepest slot on JITs that do have the 2048 byte
budget, and on 512 byte JITs it cannot be combined with the caller's frame.
The tree already has is_large_stack_supported() in testing_helpers.c and
__load_if_large_stack()/__load_if_no_large_stack() for this situation.

Could the leaf slot be picked from the available budget, for example
-(512 - 16) when is_large_stack_supported() is false, or the subtest be
skipped on such kernels?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38779093397
--===============5756007415653613052==--
