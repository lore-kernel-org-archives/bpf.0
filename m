Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED520D4FC;
	Sun, 27 Sep 2026 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545388; cv=none; b=qDgT0fGgijxOgWbTXiyoOClX93Vpo0z4l5cDey2LyApXt/XMBQ9L2pI1bjf7aXMUC4jwzyT3TQJD9NMSI2t7gwD8wnF8qxQFSE6viNIK17bBLVTR/ZvUlDEuyNljhVCV9BU0yyz+HMMH99WYrGCiLzGl5LMqteu4LD+U14mHpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545388; c=relaxed/simple;
	bh=n4DDGAK/8u1AuRg6WBpYGIC5R/YZsN31zuN1oi/vDD8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KkjobsF6G2sJ21IPLDuaPVMT+Fq4Yt7EShOvP6GgwZuHg5rzrsLJgnbd1DzUQJTcpNNta4lUy3ktAsvW7RCSHqfP79Zp8Vohnd6BYQXSC9GK1FBoUgfEFDkIRJwQ3A/TZbRk9mU84R20dgwc8dxtKHfHBjvMneEtEkyMICo3GxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz0V6oF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz0V6oF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAB91F000FF;
	Sun, 27 Sep 2026 21:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790545386;
	bh=BVuWMZa259dxnjcZi7fHN6YYW1e8KlsPsvD+/UH+8Z0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Zz0V6oF+13UMKXCKD2VQoDSn+jsKcMncv5yM40z7aN0c0hlM9Oshflrs1D87phTIv
	 Vzb0HlMdmMGZl0Oi0hOvHwOsXJj+SIAJ/nNBT9hgOxZr1c9n3jgtOrDXinCh6Mu7do
	 bAhIBjYSdxz4IVSvlkzT7NuRJ1W7aWTaUZmiowcucuk2bk5+otQJrZpR1Urd6+a5Ex
	 YDLb/a5zRkMQZo4KsUk7fQtjj06SOIYZKSoEc2CK3bx4PF1Oh2Yfm8bB2gQCRn684k
	 4dvET8UdWqe09IseB36SdS8wJ2qAiGDFeUkuNOWpCxXQOROGpxGHFTziqtfBuwW3EL
	 HyB2DV9aolmBQ==
Content-Type: multipart/mixed; boundary="===============7163960345673193045=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e07af39920f472e97ee3cf73eddc49a72a11dffb2e11e9b7c5b7cc1d80affef@mail.kernel.org>
In-Reply-To: <20260927205501.672807-1-visitorckw@gmail.com>
References: <20260927205501.672807-1-visitorckw@gmail.com>
Subject: Re: [PATCH v6] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,skhan@linuxfoundation.org,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org,gerg@linux-m68k.org
Cc: rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,jserv@ccns.ncku.edu.tw,marscheng@google.com,eleanor15x@gmail.com,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 21:43:04 +0000 (UTC)

--===============7163960345673193045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..a04ce91eb8e8
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +static int jit_atomic32(u32 *ptr, u32 val, int op, u32 cmp)
> +{
> +	unsigned long flags;
> +	u32 old;
> +
> +	local_irq_save(flags);
> +	old = *ptr;
> +	switch (op) {
> +	case BPF_ADD:
> +		*ptr = old + val;
> +		break;
> +	case BPF_AND:
> +		*ptr = old & val;
> +		break;
> +	case BPF_OR:
> +		*ptr = old | val;
> +		break;
> +	case BPF_XOR:
> +		*ptr = old ^ val;
> +		break;
> +	case BPF_XCHG:
> +		*ptr = val;
> +		break;
> +	case BPF_CMPXCHG:
> +		if (old == cmp)
> +			*ptr = val;
> +		break;
> +	}
> +	local_irq_restore(flags);
> +
> +	return old;
> +}

[ ... ]

> +static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const s8 *src = bpf_get_reg64_ref(insn->src_reg, tmp2, ctx);
> +	const s8 *dst = bpf_get_reg64_ref(insn->dst_reg, tmp1, ctx);
> +
> +	if (BPF_SIZE(insn->code) == BPF_W) {
> +		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
> +
> +		if (insn->imm != BPF_CMPXCHG) {
> +			if (is_stacked(dst[1])) {
> +				emit_16(ctx, 0x206e);		/* movea.l d16(%fp), %a0 */
> +				emit_16(ctx, (u16)STACK_OFFSET(dst[1]));
> +			} else {
> +				emit_16(ctx, 0x2040 | dst[1]);	/* movea.l dst, %a0 */
> +			}
> +
> +			emit_16(ctx, 0xd1fc);			/* adda.l #imm, %a0 */
> +			emit_16(ctx, (u16)((s16)insn->off >> 16));
> +			emit_16(ctx, (u16)insn->off);
> +
> +			if (BPF_OP(insn->code) == BPF_XCHG) {
> +				emit_16(ctx, 0x4eb9);
> +				emit_32(ctx, (u32)jit_atomic32);
> +			} else {
> +				emit_16(ctx, 0x2f00 | s_lo);
> +				emit_16(ctx, 0x2f3c);
> +				emit_32(ctx, insn->imm);
> +				emit_16(ctx, 0x2f08);
> +				emit_16(ctx, 0x4eb9);
> +				emit_32(ctx, (u32)jit_atomic32);
> +				emit_16(ctx, 0x4fef);
> +				emit_16(ctx, 12);
> +			}

[ ... ]

> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		emit_atomic(insn, ctx);
> +		break;

Can this code handle 32-bit BPF_LOAD_ACQ and BPF_STORE_REL atomics?

Looking at build_insn(), every BPF_STX | BPF_ATOMIC | BPF_W instruction is
sent to emit_atomic() without checking insn->imm.

On 32-bit arches, the verifier accepts BPF_W-sized BPF_LOAD_ACQ (0x100)
and BPF_STORE_REL (0x110). In check_atomic() from kernel/bpf/verifier.c,
these operations are only rejected when BPF_SIZE is BPF_DW and
BITS_PER_LONG != 64:

    case BPF_LOAD_ACQ:
        if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
            ...
            return -EOPNOTSUPP;
        }
        return check_atomic_load(env, insn);

For BPF_LOAD_ACQ, emit_atomic() loads %a0 from dst_reg + off and calls
jit_atomic32(ptr = dst_reg + off, val = src, op = 0x100, cmp). The switch
in jit_atomic32() has no case for 0x100, so it only runs `old = *ptr;` on
dst_reg + off.

But dst_reg is the destination register for a load. check_load_mem() in
the verifier only checks dst_reg with DST_OP_NO_MARK, so it can hold any
scalar or be uninitialized. The resulting dereference of dst_reg + off
(instead of src_reg + off) can read from an arbitrary address with no
exception-table entry.

Also, is_fetch is false (0x100 & BPF_FETCH == 0), so dst_reg is never
written back. The verifier tracks dst_reg as holding the loaded value, but
at runtime it keeps its old value.

For BPF_STORE_REL, jit_atomic32() is called with op = 0x110. No case
matches, so the store is silently dropped.

Other 32-bit JITs (mips32, x86_32, riscv32, parisc32) reject unsupported
atomic imm values. Could emit_atomic() or build_insn() accept only the
imm values that jit_atomic32/jit_atomic64 implement and return -EOPNOTSUPP
for the rest?

[ ... ]

> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int bpf_stack = MAX_BPF_STACK;
> +	int total_stack = SCRATCH_SIZE + bpf_stack;

Can this stack reservation overflow the kernel stack?

Every function reserves SCRATCH_SIZE + MAX_BPF_STACK = 96 + 512 = 608
bytes, plus 16 bytes for d2-d5, 8 bytes for the return address and saved
%fp, and emit_call() pushes 40 bytes of arguments for each bpf-to-bpf
call.

That's 632 bytes for the main frame and 672 bytes for each nested subprog
frame, independent of prog->aux->stack_depth.

The verifier allows MAX_CALL_FRAMES (16) nested frames. For CAP_BPF
programs, it rounds each frame's stack_depth up to 16, so subprogs with no
stack use cost nothing against the 512-byte combined limit.

A program with a chain of 16 small static subprogs is therefore accepted
and uses 632 + 15 * 672 = 10712 bytes of kernel stack on top of the
caller's stack.

On m68k, THREAD_SIZE is 8KB for every configuration where this JIT is
enabled, thread_info sits at the base of the stack, and there is no guard
page. Even 12 levels (632 + 11 * 672 = 8024 bytes) overflow by themselves.

Shallower nesting can overflow when a program runs in softirq on top of an
already deep stack. Callbacks invoked from helpers such as bpf_loop add a
C frame plus another full JIT frame per level.

The main entry needs MAX_BPF_STACK because a tail-call target reuses its
frame. Subprogs can never be tail-call targets, and they cannot issue tail
calls here because bpf_jit_supports_subprog_tailcalls() is the weak false
default.

Could subprog frames be sized from the actual stack_depth instead of always
reserving MAX_BPF_STACK?

[ ... ]

> +	case BPF_JMP | BPF_CALL:
> +		return emit_call(insn, ctx);

Does this code copy back the callee's R2 for aggregate returns?

For a subprog whose BTF return type is 9-16 bytes,
bpf_compute_subprog_ret_regs() in kernel/bpf/verifier.c sets
subprog_info->ret_reg_pair and prog->jit_required.

On exit, prepare_func_exit() copies the callee's R2 state into the caller,
including pointer types for static subprogs.

In this JIT, BPF R2 is not a machine register. It is a slot at
STACK_OFFSET() from %fp, so each frame has its own copy.

The callee writes R2 into its own frame, BPF_EXIT runs build_epilogue(),
and unlk discards that frame. emit_call() only fixes up d0/d1 for R0 and
never copies R2 back.

The caller's R2 slot keeps its old value (for example the argument it
passed in).

This creates a verifier/runtime mismatch. For example, after
'r2 = 0xdeadbeef; call sub' where sub returns {r0, r2 = map_value_ptr},
the verifier thinks r2 is a PTR_TO_MAP_VALUE in '*(u64 *)(r2 + 0) = x',
but at run time the store goes to 0xdeadbeef.

Because jit_required is set, there is no interpreter fallback.

Every other JIT that supports BPF_PSEUDO_CALL keeps R2 in a hardware
register, and arm32/x86_32 reject subprog calls.

Could the callee's R2 be copied into the caller's R2 slot after a
BPF_PSEUDO_CALL, for example by returning it in d2/d3 or through a scratch
location?

[ ... ]

> +	default:
> +		return -EOPNOTSUPP;
> +	}

Does this code handle the BPF_ST | BPF_NOSPEC instruction?

build_insn() has no 'case BPF_ST | BPF_NOSPEC:', so the speculation
barrier the verifier inserts falls to the default and returns -EOPNOTSUPP.

m68k does not override bpf_jit_bypass_spec_v1() or v4(), which default to
false.

For any program loaded without CAP_PERFMON while mitigations are on
(unprivileged, CAP_BPF-only, or through a BPF token), the verifier emits
BPF_ST_NOSPEC() for speculative-path sanitation and after stack spills, in
kernel/bpf/fixups.c:958-962 and 1035-1042.

build_body() then fails and the whole program is not JITed. With
CONFIG_BPF_JIT_ALWAYS_ON, which this patch makes selectable by adding
HAVE_EBPF_JIT, and whenever prog->jit_required is set, the load fails with
-ENOTSUPP instead of falling back to the interpreter.

test_bpf.ko runs as root and so never hits this.

Every other eBPF JIT, including arm32, mips32 and x86_32, handles
BPF_ST | BPF_NOSPEC as a no-op or a barrier.

Could this case be added, or should bpf_jit_bypass_spec_v1/v4() be
overridden if m68k does not speculate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36350420232
--===============7163960345673193045==--
