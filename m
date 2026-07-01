Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD139A7E7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901007; cv=none; b=BQTSyf+/bTmLlpwyC24ZtmwU9GKzgK27bIIvg/XeDox42mM88endU9Wa9qq0a+xjP9fB0CZWrLj2tm7PGyYWdcFA1txz6Uc0PVGoHZ/528HInryCBa/DLg0QOi1cQOIqoGqzgH5t5YchBuoTa0sY/DOj4ZARlpVxKICz+vE/gfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901007; c=relaxed/simple;
	bh=mYfYMy/zxfog/q4GXRCEPTcTKcptD/iHpx2j17PhzOs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pkf0pfe9fwLOGtGjFFuhQ80Tzt0QkKxYtk0RxUgZ/ObKcGIxlbn9V+2DW54ByrLuzse4NlpRC17mrEKbfSgNzeI1N+N0HWgcKn897fxtSA55GajtxooucUiqwwSkobgmoh0wXXZUwM9of+t896pDRN3LX5IJ5b5yV+hlAutBM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9XTXyqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9XTXyqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D21F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782901006;
	bh=PWWHJdNi0n0kM9nesVIM25JpiZ5KARNvZPwLzjo1PKY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=e9XTXyqIHgOjP6i3z76kcGC0a+5ts3wAO3zx4Lu0BK7AkPbdGzlgycPchZERJR6YM
	 dO46oplueKaa+C1CtlEvdUNLfsanRDd5xlXpxgk0Agt67MKoKEGvcm8gcr0e47Nffp
	 AK/6jRY1gjq7ctWloE5CDvd6Bv6oZmw3WH50unY4PaN7BSI+ua9cMogdpY6HJFwPLw
	 xGA5ch67ZBxaZnoRUZG4c/BTtNPZALfJQkg3zmpXNofxGGVPuICaauZ8b6OpCg9LQL
	 BBxNy4IiJfUMvb0+J38iPztKm5OjVWg2Q6QoHyRfPVVNqhAQzN+VKQ1uuJVT8bAlUj
	 6XR4NwdaE9pcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:16:45 +0000
Message-Id: <20260701101645.D14D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] emit_kasan_check() fails to save BPF_REG_AX (R10), leading to =
memory corruption when combined with constant blinding.
--

commit 4c7e1a72bec793ca4ed19fd754408dd627715a3c
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: add helper to emit kasan checks in x86 JITed programs

This patch adds emit_kasan_check() to emit KASAN shadow memory checks before
memory accesses in x86 JIT-compiled BPF programs. The helper saves temporary
registers before calling the KASAN functions, but deliberately omits r10 and
r11 to reduce overhead.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 054e043ffcd22..68c5f9f94e5e2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, b=
ool is64)
>  	*pprog =3D prog;
>  }
> =20
> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
> +			    bool is_write, bool accesses_stack_only)
> +{

[ ... ]

> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);
> +

[Severity: Critical]
Can this lead to data corruption when BPF constant blinding is enabled?

The commit message notes that r10 and r11 are skipped here to reduce
overhead. However, when constant blinding is enabled, bpf_jit_blind_insn()
in kernel/bpf/core.c translates BPF_ST_MEM into a sequence that uses
BPF_REG_AX (which maps to x86's r10) as the source register:

kernel/bpf/core.c:bpf_jit_blind_insn() {
        ...
        case BPF_ST | BPF_MEM | BPF_DW:
                *to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from=
->imm);
                *to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
                *to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX,
                                    from->off);
        ...
}

When do_jit() processes this BPF_STX_MEM, it first calls emit_kasan_check(),
which invokes the C function __asan_storeX. Since __asan_storeX is a standa=
rd
C function, it is permitted by the System V AMD64 ABI to clobber caller-sav=
ed
registers like r10.

Upon returning from the KASAN check, r10 might contain garbage. Then do_jit=
()
calls emit_stx() which will use this clobbered r10 as the data to be writte=
n,
potentially writing corrupted data to memory.

Should BPF_REG_AX (r10) be explicitly saved and restored here to prevent th=
is?

> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D4
