Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738E3F39FB
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867055; cv=none; b=T9CGhyywwW7Ha1IRNmy1lnTNk2z9HWnh2agXe6+Rl7TuqjgPyBVAYjgmITlBKVNmJLGKSkLJ2d8l9Gp0ow2URrx6jnSEaO17BHHP7/5dj6D+QTfP+tqNsvx7094oYjgEr9a12IIdV+HhQiVAaKJmo6mSvmV+bfmHzfT+BAk2moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867055; c=relaxed/simple;
	bh=SCtyrhnyK5OwP11sd6plqczSY0wQweUN4kPBLKwyDl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0Xt9oXi5qA7H0pOQ7eGYdSjp+GfN8jhLqqIpy1tTiMnP1rOiuoA8rgg+XUr8xm8L1s1VjzuFpm/1gzJPZ6MikFzwcf596IErSaUoGziRFmriJ/5xTe7C0ttHpcHJi0au48f/DqhFBCB4vtvONNjiuKWbxbfP0CGAwRWUzi/oSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzzoYO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzzoYO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9731F00A3A;
	Tue,  4 Aug 2026 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867054;
	bh=2zjRurl0aCeLEeP1Iw2WAomiUWSUoHhSrnM5cQGLDAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNzzoYO8fDWcoNNHoM0TCuF/P5gplhso8I74aHE3y2P+0aEtD2+UmzUsojBz1wYLZ
	 ovepciRvjxwEJutAr/oisKMcLaCci9tB6PfTx+GoZycJ/5qMvwblPEkfRT+j9N6zpb
	 Zpb8CDjKpSA94ApsTmmiSpxNzGeb7x6eDp+TAr1ZNp7HiiYr63ydzQdgw+kbHuhPZS
	 vA9uhXlkWv7yykNLfOVPw2OAKS+DpmpDJkuQjJIep+MnTT0zUrCFGtdtkGmwZNgDdd
	 KDPlpUm7jV0S5gvOnsPInqjR0LY8AWA+vCeJyDtYt39hlhtF27/qOdcyabwSMvpX1V
	 gmxRxg81VF70w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 4/9] bpf, x86: emit KASAN checks in x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804-kasan-v6-4-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
 <20260804-kasan-v6-4-549ef845f491@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:10:53 +0000
Message-Id: <20260804181054.5E9731F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] emit_kasan_check fails to save caller-saved register R10 (BPF_REG_=
AX), causing BPF state corruption during atomic fetch operations and consta=
nt blinding.
--

--- Patch [4]: [PATCH bpf-next v6 4/9] bpf, x86: emit KASAN checks in x86 J=
ITed programs ---
commit fb8c8d1198314de6985fab9f1a09f3f7baf90343
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
Subject: bpf, x86: emit KASAN checks in x86 JITed programs

This commit adds KASAN shadow memory checks before load and store operations
in JIT-compiled BPF programs on x86. It aims to detect memory safety bugs at
runtime by emitting calls to standard KASAN C helper functions.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 0b8b5dfe37ab0..b7881b9953107 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, b=
ool is64)
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
Is it safe to skip saving R10 (BPF_REG_AX) here?

Since R10 is a caller-saved register under the System V ABI, the compiler
is free to use it in __asan_loadX or __asan_storeX. Furthermore, if a
KASAN warning triggers, the kasan_report() slow path will clobber R10
before returning.

> +
> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);

[ ... ]

> @@ -2288,6 +2416,12 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
>  				dst_reg =3D BPF_REG_FP;
>  			}
> +			if (!accesses_stack_only) {
> +				err =3D emit_kasan_check(env, &prog, dst_reg,
> +						       insn, ip, true);
> +				if (err)
> +					return err;
> +			}

[Severity: High]
Could emit_kasan_check clobber the source register here if constant
blinding is used?

When bpf_jit_blind_constants rewrites a BPF_ST instruction, it places the
unblinded constant into BPF_REG_AX (R10) and issues a BPF_STX with
BPF_REG_AX as the source register. If R10 is clobbered by the KASAN check,
does this cause a store of garbage memory?

>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>  			break;

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
Will this result in BPF state corruption during atomic fetch operations?

Here, BPF_REG_0 (RAX) is temporarily saved to BPF_REG_AX (R10) just prior
to calling emit_kasan_check(). If emit_kasan_check() clobbers R10, won't
BPF_REG_0 be restored with corrupted data after the operation?

>  				branch_target =3D prog;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-kasan-v6-0=
-549ef845f491@bootlin.com?part=3D4
