Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04304137A0
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868542; cv=none; b=I6V9iYjg93QRCaww4JJLRHN22B2AARxiEbdFiTZzAt8iVi9SKXSU48g9PDLfV4+A3GPmqT3Zd9cUpmKrLqasa6wayAYqYfKuEsyKN0hQOiJoU4YYLYtyDTyK+2FatZl4KOwfUiKkrF1RqVuEyQWivitsVqDA00mMi5AzkkAqe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868542; c=relaxed/simple;
	bh=prNmGaUtXlWodgxKHVEyt6vJRe3g1indiQMhDVLw/uI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gHpZO66vRueeelEv8wbNvJuLe410taXWcvT1CEucHI9ciQf1VXccdqt/dx30GjjroSaMqGf8Qw4+AKNuyPoAUfZ1oBhRSjP8YYqfw4GYQOYApXX1DTrEFNrTpwP2m9xrkDpI1D2u6E1NC66UxD/485pWpToB9mONQXN/1B0ywZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw9efDz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw9efDz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464031F000E9;
	Tue,  4 Aug 2026 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868540;
	bh=4oRBeEDgLgwI7kzmC7vRsaXm8XwUVMc5caAOg7EaMWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nw9efDz9VbyArP5lGmO0+arASPge8J1MlCjJxWBkob0PugGeyOAqD2nGhzobqr6jz
	 yZJoTZPTrX1MzXyr/EpzUpl9DqiPHQ9ILEOgvku+MzNMgCvY2X+f//DC9LmTQkR28K
	 SmL6rQ0yzNy0KuygdCbVMgdnC3758kYzmtICH5EzL76BWhaEOHxtKhvvAi2gKHPVta
	 N17Wqo7c+HFjirkerbuC+YqWrpKSJB8frjswulMyIOiQ/R8Zv42yZ+DOKQriJ3QUBM
	 FvGhqzHuPYDq44u7RM4HFTPfeUpYecdfrsxmVEtEeBr+sB9sa37o9p2RwLJpBxv2Pr
	 6l/9H9tQNMvLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804-kasan-v6-9-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
 <20260804-kasan-v6-9-549ef845f491@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:35:39 +0000
Message-Id: <20260804183540.464031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF JIT KASAN instrumentation fails to save R10/R11 registers, cor=
rupting BPF register state during atomic operations and memory probes.
- [High] BPF JIT emits KASAN checks for BPF_PROBE_MEM instructions, bypassi=
ng exception tables and causing log spam/DoS on expected invalid memory acc=
esses.
--

--- Patch [9]: [PATCH bpf-next v6 9/9] selftests/bpf: add tests to validate=
 KASAN on JIT programs ---
commit cb1fd6ebd1a7c30b4a1e50931fc142f072a09a37
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add tests to validate KASAN on JIT programs

Add a basic KASAN test runner that loads and test-run programs that can
trigger memory management bugs. The test captures kernel logs and ensure
that the expected KASAN splat is emitted. The runner covers different
cases and settings, including specialized tests for atomic ops.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 0b8b5dfe37ab0..b7881b9953107 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, b=
ool is64)

[ ... ]

> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);
> +	/*
> +	 * SystemV ABI states that we should also save r10/r11, but in
> +	 * practice those registers are _not_ used by the limited set of
> +	 * kasan helpers we are calling here, so that's fine not to save those.
> +	 */

[Severity: High]
Is it safe to skip saving r10 and r11 here?

If the compiler allocates r10 in the KASAN helper, or if a KASAN report is
triggered calling kasan_report(), it appears r10 could be clobbered. This
could corrupt the BPF register state for operations that rely on BPF_REG_AX
(which maps to x86 r10).

> +
> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);

[ ... ]

> @@ -2449,6 +2583,11 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>  				start_of_ldx =3D prog;
>  				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
> +			} else if (!accesses_stack_only) {
> +				err =3D emit_kasan_check(env, &prog, src_reg,
> +						       insn, ip, false);
> +				if (err)
> +					return err;
>  			}

[Severity: High]
Does this code emit KASAN checks for BPF_PROBE_MEM and BPF_PROBE_MEMSX
instructions?

Tracing programs frequently probe pointers that may be NULL or point to
userspace memory using BPF_PROBE_MEM. The verifier emits these
instructions to use the BPF exception table, which safely faults without
crashing or logging.

If emit_kasan_check() is called here unconditionally, it evaluates the
pointer using __asan_load*, which will call kasan_report() on NULL or
userspace pointers. Won't this bypass the exception table entirely and
print a KASAN BUG report to dmesg for every expected invalid pointer,
potentially causing log spam?

>  			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX ||
>  			    BPF_MODE(insn->code) =3D=3D BPF_MEMSX)

[ ... ]

> @@ -2510,28 +2649,42 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
> -			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
> -			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
> -				bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> -				u32 real_src_reg =3D src_reg;
> -				u32 real_dst_reg =3D dst_reg;
> -				u8 *branch_target;
> -
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> +			u32 real_src_reg =3D src_reg;
> +			u32 real_dst_reg =3D dst_reg;
> +			u8 *branch_target;
> +			u8 *pprog;
> +			bool is_atomic_fetch =3D
> +				(insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
> +				 insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
> +				 insn->imm =3D=3D (BPF_XOR | BPF_FETCH));
> +			if (is_atomic_fetch) {
>  				/*
>  				 * Can't be implemented with a single x86 insn.
>  				 * Need to do a CMPXCHG loop.
>  				 */
> =20
>  				/* Will need RAX as a CMPXCHG operand so save R0 */
> +				pprog =3D prog;
>  				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
>  				if (src_reg =3D=3D BPF_REG_0)
>  					real_src_reg =3D BPF_REG_AX;
>  				if (dst_reg =3D=3D BPF_REG_0)
>  					real_dst_reg =3D BPF_REG_AX;
> -
> +				ip +=3D (prog - pprog);
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				if (!accesses_stack_only) {
> +					err =3D emit_kasan_check(env, &prog,
> +							       real_dst_reg,
> +							       insn, ip, true);
> +					if (err)
> +						return err;
> +				}

[Severity: High]
Could this call to emit_kasan_check() corrupt the BPF register state?

Just above, BPF_REG_0 is saved into BPF_REG_AX, which is mapped to x86 r10.
Since emit_kasan_check() explicitly skips saving r10, any clobbering of
r10 by the KASAN helpers will silently corrupt the saved value of BPF_REG_0.

>  				branch_target =3D prog;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-kasan-v6-0=
-549ef845f491@bootlin.com?part=3D9
