Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBD3F54AA
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468401; cv=none; b=ov1z6qi8zF5KxyMprecdLiZIqI8E9xRtjzs3ynqsaNa3ZRYWCWOrmFE4EtsiEkyjK3uRO4ts66Zh4vrlgmw4Col/ieJUW4Zxb75Kq2vBaEVu2hr0oJcaJ4xcTZYISFLdAefzjyiJEfMSOtg+eYAMmsWq7rE4Q00zXE6gMZA9NHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468401; c=relaxed/simple;
	bh=NJGC3seDg1gz8yVKGTfJap7cT2nbgOH2XofTFcYlYak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3VWACjOcc+md05miKu30+Pks2Do0ItUo9RhKVIr68yD1JAnXQCbkobP1tuHZe5qwpTgMSSj2pRi788Di306MWHIOzt8fpOfqKlTGHVa6wzdqNNAfFsc4o+2s0QFyxY20h8ZqPiLHLzMvlOlrguwOcDUXdZ32glHFeU8iLKMUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlUEmYUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlUEmYUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6DCC19425;
	Wed, 29 Apr 2026 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468400;
	bh=NJGC3seDg1gz8yVKGTfJap7cT2nbgOH2XofTFcYlYak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tlUEmYUD3SJSdOix6B/OrdEJWpo3ZVY21eBSkKWoAil3m6t4Wk17JGTmR7Bt5/er8
	 3joSy4uT7fwyWHjKdgJhk370dGfDlxLzzET7/cvqBKg18B+ooXwfNYo6CeRy4CJkWu
	 8LB1owJXHbDcuioD+cvOgBx9wbGe7vUlnnxTaykn0nSdOgIaLgNnh3BJXykkq6FQE0
	 at6IH6VDbSRZUAdN1gQP0CsWUYgizQfXl3f8pAz2dy22lKwIKLSKgE1QsTEiq6AvmJ
	 nAdgAJJxCjQoG/EF9g67Sml+b9SwxQM1p2nDwFhvi/26SqEqiiIbcw7TCXH0S5DZ6K
	 Khck8RKt5Xs2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler
 support
Reply-To: sashiko@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429124046.3480827-1-visitorckw@gmail.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:13:19 +0000
Message-Id: <20260429131320.6F6DCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The BPF JIT compiler for m68k suffers from a 16-bit integer ov=
erflow when emitting memory instructions for 64-bit values (BPF_DW), result=
ing in an out-of-bounds read or write by approximately -64KB.
- [High] BPF-to-BPF function calls will crash the kernel because `emit_call=
` hardcodes `extra_pass` to `false`.
--

commit 700ecd8180ff5bd538d3f6e6f0d7655894abb49b
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

m68k, bpf: Add initial BPF JIT compiler support

Add a BPF JIT compiler for the m68k architecture. Generating m68k machine
code targeting m68020+ processors.

> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
[ ... ]
> +static void emit_ldx(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
[ ... ]
> +	switch (BPF_SIZE(insn->code)) {
[ ... ]
> +	case BPF_DW:
> +		emit_16(ctx, 0x2028 | (d_hi << 9));		/* move.l d16(%a0), d_hi */
> +		emit_16(ctx, insn->off);
> +		emit_16(ctx, 0x2028 | (d_lo << 9));		/* move.l d16+4(%a0), d_lo */
> +		emit_16(ctx, insn->off + 4);
> +		break;
> +	}

Could adding 4 to insn->off cause a 16-bit signed integer overflow here?

The BPF instruction offset (insn->off) is a signed 16-bit integer that can
reach up to 32767 for large map accesses. If insn->off is between 32764 and
32767, insn->off + 4 evaluates to a value exceeding the 16-bit signed maxim=
um
(e.g., 32768, which becomes 0x8000).

Because m68k hardware sign-extends 16-bit displacements, would emitting
0x8000 result in a negative 32-bit displacement (-32768), leading to an
out-of-bounds memory access roughly 64KB behind the intended safe offset?

This same pattern appears to be present in emit_stx() and emit_st() for the
BPF_DW cases as well.

[ ... ]
> +static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const s8 arg_regs[] =3D { BPF_REG_5, BPF_REG_4, BPF_REG_3, BPF_REG_2, B=
PF_REG_1 };
> +	const s8 *tmp1 =3D bpf2m68k[TMP_REG_1];
> +	u64 func_addr;
> +	bool fixed;
> +	int i, err;
> +
> +	err =3D bpf_jit_get_func_addr(ctx->prog, insn, false, &func_addr, &fixe=
d);

Will this cause the JIT to emit jumps to address 0x0 for BPF-to-BPF function
calls?

Calling bpf_jit_get_func_addr() with extra_pass hardcoded to false causes it
to return a NULL function address for BPF-to-BPF pseudo-calls. Since the re=
al
addresses are not resolved, does this result in the JIT unconditionally
emitting jsr (0), which would crash the kernel when executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429124046.3480=
827-1-visitorckw@gmail.com?part=3D1
