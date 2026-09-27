Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E73C060E
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790543372; cv=none; b=Nc7LhrB8im9cJUp32FC3RJMhe3BwQmddd8fwHgvmvczWQ6lyCG6N9wutt2Wm5yCkZcKYMQ8loKhBJfdIWfA+91atDeB1HqamH2pB//sJOGodubCTEZnRWvbQUux7wSP9zuHEYnBtIo8LwT6zwQzfL2CE3PB6EXiqQ0uoSRxFDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790543372; c=relaxed/simple;
	bh=KJgHUMZ7MP5/n0+gGhyOuC1XVs9BUk/ISNjOVrfxi5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W0tQt7sMavvTpWPJ2eBiqqRuGIHYunsUJFtY/hr8pk1L9afhVTTIWR8muNSqvl/lM9PgIz/FNHp73tzgDvxSir3eKQFuXqjCWCO1lWDGAupIKyGMrYUP1bYQdXtSE8p2c/Br0uezKc8bvhj327kJHFwmo2assnGJnN5uuUQH0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqZSRvUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqZSRvUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD61F000FF;
	Sun, 27 Sep 2026 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790543369;
	bh=L2joTlAJEcUcxyFhvRqBzAF6vXsqrnzofmwrqSatRUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KqZSRvUmf/p8mpvLudWcy/yxVzJY7kve+wFCnmr1NGnOx0cggiJxilw9cDS3xt0DA
	 iPPZjXMk2RDELgIri09tUW9Upj8zb8cp+dDAaDd2wdQzLOFlupSdjNn/LDtZybpH9d
	 0Ga2/4uy6U04ACwH0EZCwTok7NTKbqAm7ccbjit5ywSBUdksc6nfGytfZi3jpm1ooF
	 VBDPA5xAbXiqajckqN8+vmYyEsf1nBrBMfSMRxrhesqmalf6AZ2cr8gDWEL1y2XNxt
	 JAQLmczRZTz3MA0b9MYnAkufDQzwAZd/AJB0rQUabR1sH9spdR37iJGOvpoLM2c0Pf
	 BoywZIRoWA1Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] m68k, bpf: Add initial BPF JIT compiler support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260927205501.672807-1-visitorckw@gmail.com>
References: <20260927205501.672807-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 21:09:28 +0000
Message-Id: <20260927210929.AADD61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] m68k/bpf: Hardcoded prologue size in tail call causes offset misma=
tch on ColdFire
- [High] m68k/bpf: Silent JIT failure in extra_pass allows execution of inc=
ompletely JITed programs
--

commit 2847ebf4b1948509dbfb51929065f4ab0a56fcf6
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

m68k, bpf: Add initial BPF JIT compiler support

This commit adds a BPF JIT compiler for the m68k architecture. It generates
machine code targeting m68020+ and coldfire processors with an MMU, while
excluding plain 68000/68010 and non-MMU coldfire processors.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
[ ... ]
> +static void emit_tail_call(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
> +{
[ ... ]
> +	emit_16(ctx, 0x2068);					/* movea.l d16(%a0), %a0 */
> +	emit_16(ctx, offsetof(struct bpf_prog, bpf_func));
> +
> +	emit_16(ctx, 0x4ee8);					/* jmp d16(%a0) */
> +	emit_16(ctx, 44);

[Severity: High]
Does this hardcoded displacement of 44 bytes account for the ColdFire prolo=
gue?

In build_prologue(), the ColdFire prologue takes 48 bytes due to an expanded
register saving sequence:

	if (CPU_IS_COLDFIRE) {
		emit_16(ctx, 0x4fef);				/* lea -16(%sp), %sp */
		emit_16(ctx, 0xfff0);
		emit_16(ctx, 0x48d7);				/* movem.l d2-d5, (%sp) */
		emit_16(ctx, 0x003c);
	} else {

If a BPF program executes a tail call on a ColdFire processor, the tail call
will jump to byte 44, unintentionally executing the last 4 bytes of the
prologue. This writes an uncontrolled %d0 value into BPF_R10_HI, corrupting
it.

Since BPF programs can be loaded by unprivileged users, can this bypass
verifier bounds tracking and lead to arbitrary memory access if the program
performs 64-bit pointer arithmetic on R10?

[ ... ]
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
> +{
> +	struct bpf_binary_header *header;
> +	struct jit_ctx ctx;
> +	unsigned int image_size;
> +	u8 *image_ptr;
> +	bool extra_pass =3D prog->jited;
> +
> +	if (!prog->jit_requested)
> +		return prog;
> +
> +	if (prog->jited && !prog->aux->func)
> +		return prog;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.prog =3D prog;
> +
> +	ctx.offsets =3D kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
> +	if (!ctx.offsets)
> +		return prog;

[Severity: High]
Can a failure to allocate ctx.offsets during an extra_pass lead to the
execution of an incompletely JITed program?

If kvcalloc fails during the extra_pass in bpf_int_jit_compile(), it returns
prog directly without clearing prog->bpf_func. Because prog->bpf_func remai=
ns
unchanged from the first pass, jit_subprogs() assumes the JIT compilation
succeeded.=20

The BPF program could then be executed with a JIT image containing unresolv=
ed
subprogram call addresses, which resolve to a 0 address, resulting in a ker=
nel
panic when executed.

Since unprivileged users can trigger this by loading BPF programs during
memory pressure, can this cause a denial of service?

> +
> +	build_prologue(&ctx);
> +	if (build_body(&ctx) < 0)
> +		goto out_off;

[Severity: High]
Similarly, if the dry run of build_body() fails, it jumps to out_off which
frees ctx.offsets and returns prog without clearing the BPF function pointe=
r.
Can this also hide the failure from jit_subprogs() when loading a BPF progr=
am
with subprograms?

> +	build_epilogue(&ctx);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927205501.6728=
07-1-visitorckw@gmail.com?part=3D1
