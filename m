Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6C31A07F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634220; cv=none; b=Yjz1VYo0w0NAVfLjSsN3AHEOIfCxnfRzmh8gslzgzUtXx+FJrh0BHHdEF0uFiCTAukUymmlznPLd3hhovy4ETcblKBffkvYufrLvwtlN5hTypxcxNXIHyrxr00BNeiqFq93QUJrfPlPwlTSYNQfntS7Hsw2PodUtghKfEgZNyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634220; c=relaxed/simple;
	bh=MLC5jvUb/esTjBs6NX1zkD5BggFcMIIcjOp+fr8HAJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BYpLyWJ36sNiWWqgrg0GYvtOJsINxdKOJ8NPpuFEkdYMpYJy0mR8d313yAM6vnnIZFIaWR6yMplbWur5CjLgudRoexz0wgj1ny3wAGxpfz/SBgubpYEhWvZQfggnTrYizOf8OjFxkbu3+TCMZ/dChE+SIfAzWEZSXHKhVbyVBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR5dxZbh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR5dxZbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EDEC2BCB0;
	Wed, 13 May 2026 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634219;
	bh=MLC5jvUb/esTjBs6NX1zkD5BggFcMIIcjOp+fr8HAJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XR5dxZbhbP3RbaeNYCgB+nNtla5D9mI3vEbv7QU29W6mPziHkmC3r3O5B2nA41j2T
	 hSgcF9XcMOxXqUrzxQm5eRDO+x9/UOK3infPwG1TnDs8OEPKQ161pF7vrwnZZJnxmI
	 vA0P/+SgXRSibqK4rRyWLiAXyyU3ODmkauyHf8/jLptC6JFxv06GlnYh+SUGGtGiHN
	 r5J6vP398R2qcbcZTljEk0S09XQZjx/92pe2rdIwerkOl738iI64LNvlMj1JoJ1kw3
	 EsTOJ+AGm/bwGs/+4moRa0LBMZjVYHHOM9jGBGPSpD0ZoN56QzO1Bfh+v1AKFXqEHN
	 nsbgS8FWCze+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511212756.3163955-1-visitorckw@gmail.com>
References: <20260511212756.3163955-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:03:39 +0000
Message-Id: <20260513010339.81EDEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] BPF-to-BPF calls (BPF_PSEUDO_CALL) are broken, corrupting argument=
s, return values, and tail call tracking.
- [High] Missing protection against signed division overflow (`S32_MIN / -1=
` and `S64_MIN / -1`), leading to undefined behavior and potential kernel p=
anics.
- [Medium] Using `kcalloc` for potentially large array allocations leads to=
 JIT failures under memory fragmentation.
--

commit 1a2c23f18e30a4b931f962e5e35eed83ff42f6a2
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

m68k, bpf: Add initial BPF JIT compiler support

Add a BPF JIT compiler for the m68k architecture.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 0000000000000..1531b321410ae
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +static noinline s32 jit_sdiv32(s32 a, s32 b) { return b ? a / b : 0; }
> +static noinline s32 jit_smod32(s32 a, s32 b) { return b ? a % b : a; }
> +
> +static noinline u64 jit_mul64(u64 a, u64 b) { return a * b; }
> +static noinline u64 jit_div64(u64 a, u64 b) { return b ? div64_u64(a, b)=
 : 0; }
> +static noinline s64 jit_sdiv64(s64 a, s64 b) { return b ? div64_s64(a, b=
) : 0; }

What happens if signed division or modulo is performed by -1 with the minim=
um
representable value (e.g., S32_MIN / -1)?

In C, evaluating INT_MIN / -1 results in signed integer overflow (undefined
behavior), which can trigger a CPU division exception on m68k and crash the
kernel.

Should explicit bounds checking be added to handle these edge cases and ret=
urn
the dividend as required by the eBPF specification?

[ ... ]

> +static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const s8 arg_regs[] =3D { BPF_REG_5, BPF_REG_4, BPF_REG_3, BPF_REG_2, B=
PF_REG_1 };
> +	const s8 *tmp1 =3D bpf2m68k[TMP_REG_1];
> +	bool extra_pass =3D ctx->target !=3D NULL;
> +	u64 func_addr;
> +	bool fixed;
> +	int i, err;
> +
> +	err =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &func_addr, =
&fixed);
> +	if (err)
> +		return err;
> +
> +	for (i =3D 0; i < 5; i++) {
> +		const s8 *reg =3D bpf2m68k[arg_regs[i]];
> +		s8 d_lo =3D bpf_get_reg32(reg[1], tmp1[1], ctx);
> +		s8 d_hi =3D bpf_get_reg32(reg[0], tmp1[0], ctx);
> +
> +		emit_16(ctx, 0x2f00 | d_lo);			/* move.l d_lo, -(%sp) */
> +		emit_16(ctx, 0x2f00 | d_hi);			/* move.l d_hi, -(%sp) */
> +	}
> +
> +	emit_16(ctx, 0x207c);					/* movea.l #func_addr, %a0 */
> +	emit_32(ctx, (u32)func_addr);
> +
> +	emit_16(ctx, 0x4e90);					/* jsr (%a0) */
> +
> +	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
> +	emit_16(ctx, 40);
> +
> +	emit_16(ctx, 0xc340);					/* exg %d0, %d1 */

Does this code break BPF-to-BPF calls (BPF_PSEUDO_CALL)?

It appears to treat the subprogram exactly like a standard C helper by push=
ing
BPF registers R1-R5 to the stack and then executing exg %d0, %d1 to swap the
64-bit return value.

However, the subprogram's JIT-compiled code unconditionally uses the standa=
rd
build_prologue(), which lacks a check for ctx->prog->is_func.

Consequently, doesn't the subprogram act like a root BPF program, initializ=
ing
BPF_REG_1 from 8(%fp), zeroing its upper 32 bits, and completely ignoring t=
he
stacked R2-R5 arguments?

Additionally, it seems the global tail call counter (BPF_TC_LO) is improper=
ly
reset to 33 on every subprogram entry, and the return value of BPF subprogr=
ams
(which already populate BPF_REG_0 properly) gets corrupted by the swap.

[ ... ]

> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
> +{
> +	struct bpf_binary_header *header;
> +	struct jit_ctx ctx;
> +	unsigned int image_size;
> +	u8 *image_ptr;
> +
> +	if (!prog->jit_requested)
> +		return prog;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.prog =3D prog;
> +
> +	ctx.offsets =3D kcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);

Is it safe to use kcalloc() here for potentially large array allocations?

Since the BPF verifier allows up to 1,000,000 instructions per program, this
could request up to 4MB of contiguous physical memory.

On systems with memory fragmentation, this large physically contiguous
allocation is highly likely to fail, unnecessarily aborting JIT compilation.

Would it be better to use kvcalloc() instead, consistent with other BPF JIT=
s?

> +	if (!ctx.offsets)
> +		return prog;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511212756.3163=
955-1-visitorckw@gmail.com?part=3D1
