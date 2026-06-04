Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DD3A5E6F
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606237; cv=none; b=HMUXnZF/3WRxFj8L/C04n1+gimIfXJMRR14IYSQSvu0dJEw0uzGjJA2fcboAYgcStgm202pVhWzzhibRC0ATha4mfrXPE7fQdrqxyPw83K3J8ZnT0w6jIC8ePIJNl6jWGXgBL4gwXGqQ947Z+/+0NTWS/qtfL0dOdoKPMGx6hQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606237; c=relaxed/simple;
	bh=qe3axeA3cnoYiQfdiS0BfBpZEu0g58RX/7Fp0GmaAbA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVUgF9gW23WgHmjkQQuN1ah2SfKHv2Sn+JXJpXUDLIkD2OMlyBIJGHs6SMrc6J52jvLOrjZy+UBtF7isrCXRmOdSpJHP39LreL0pMtJRsPL1QQqrodjhSWa8gvtuGtn2Vfopq3Zfb9MXJsGx5E/IfivGXj4m19qYYkR7p5Bf3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzREqQkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzREqQkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C91F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606236;
	bh=2S6tiJ6SGMpUMs43iXg5XCsXORGn/11HK4tiMMzm5ww=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DzREqQkUAjEeD8x8t172MGBLE6QxJh9DhfHniLEf3WXPmlGfDRq3nij/OgVGWJUqr
	 CxQdqurvN3z028EcHOCWcdeQtJVH5jqgUNyk42e2aBnTKRuV61DPh4+kKluA8F54Cw
	 KarLWgB3N/P2gponUvgvmv7lpViYfPxIwZKkF5lOPYWd5JIq0mtVIjBEIerFOz+QaU
	 j9yek4VhEkzhb253qIkZGUHvv5kjeNrbRaXnvdevC5s19UN3Fz4QWKDcmfaeoDtT+l
	 zOOSXW83EOBHzF5SvWWeakq4s8q0BMElF3sAQEWPsNADAiTsVZcVh4OJ9qtyq13k3z
	 P/2tESt7vEFJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/8] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-3-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-3-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:50:35 +0000
Message-Id: <20260604205035.CF9C91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] `emit_kasan_check` fails to save and restore the x86-64 caller=
-saved registers `%r10` and `%r11`, which are actively used by the BPF JIT =
as `BPF_REG_AX` and `AUX_REG`.
--

commit 77bd053eee8b8130b5fe38c11b29a99d8c12317a
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: add helper to emit kasan checks in x86 JITed programs

This commit adds the emit_kasan_check() function to insert KASAN shadow
memory checks before memory accesses in JIT-compiled BPF programs. It works
by saving caller-saved registers, computing the accessed address, invoking
the relevant KASAN function, and then restoring the registers.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a0c541a441cfa..0981791014eb3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -1330,6 +1343,86 @@ static void emit_store_stack_imm64(u8 **pprog, int=
 reg, int stack_off, u64 imm64
>  	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
>  }
> =20
> +static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *i=
nsn,
> +			    u8 *ip, bool is_write, bool accesses_stack_only)
> +{
[ ... ]
> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);
> +

[Severity: Critical]
Does this code fail to save and restore %r10 and %r11?

These registers are caller-saved in the x86-64 System V ABI, and the called
C KASAN functions (like __asan_store8) are permitted to clobber them. In
the BPF JIT, %r10 maps to BPF_REG_AX and %r11 maps to AUX_REG, which are
actively used as temporary registers right before memory operations. If they
are clobbered by the KASAN check, it could lead to corrupted operands or
invalid memory accesses.

> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);
[ ... ]
> +	/* call kasan_func */
> +	if (emit_call(&prog, kasan_func, ip))
> +		return -ERANGE;
> +

[Severity: Critical]
Should %r10 and %r11 also be restored here, assuming they are pushed before
the call?

> +	EMIT2(0x41, 0x59);
> +	EMIT2(0x41, 0x58);
> +	EMIT1(0x5F);
> +	EMIT1(0x5E);
> +	EMIT1(0x5A);
> +	EMIT1(0x59);
> +	EMIT1(0x58);
> +
> +	*pprog =3D prog;
> +#endif /* CONFIG_BPF_JIT_KASAN */
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D3
