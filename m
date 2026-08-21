Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A49438493
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355875; cv=none; b=VCw5HKZuPaPMHad1XuE6UfFEMR6zHda6H1mOg5jyybIPRDULy6g0xLa7jHSnLaS7DdL9BrS7SRZf1Z3kzrEWTHpsHASLQpyjhV+PYgUSw4oeFMfpSwvd9mJGlp0xXiXWLJPl5eIgT+etfPoUsZ62V4Hh8NaaSmTXKzKw1kNVtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355875; c=relaxed/simple;
	bh=QCdY6gMRZJF5YytuNY3mLOvRQPnFUqm6PBuwhorlZZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RmZJyt7VlMV0OQDzWmKlCbkjCyMsLSUBB5hoZmqnr60Npkuh/P5T1Xb2zB5Z2ym5swPi6WA4yz7wZUfzY0XBWe9njAsWdCaZMnh0XiGJks/MVZxwoBYQh68qCjqhea6GoQk9N8fP6HuB+rSIXtRX4xRSTQ9mNKn+19DTukQGXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+4AuvEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+4AuvEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85691F000E9;
	Fri, 21 Aug 2026 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355874;
	bh=mIU6Y3LnsxtPwEsHyYoNHCxhErteAa2OkChPlIqZ12U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+4AuvEGI+4RyYAnB83Kp5KXl/hTZw/7WgLqsUlGRGFGWJVSp56h+SrCDl9HADWsW
	 ulEYfQLhsyGkM+Usj+Ye7Pw2JS9A+qC1P0A7SxRsknily5kuqVQWinWhx+1rdrEDeF
	 kSVxvDn4jrSRLq48yJiN4Ok+NOZpuHWx4d7E3Tbs+AklDmtVX8iHR1Tgf3Llxg14bJ
	 ykbkw81ekXT9UVTU72hHoUUlqGXtZnX6CFx9Kv3M0OtDBVs4Bh0XFGD1sHdawdXQqC
	 Fc7UMqijVXHxmZNtEdG9h2w32s/2qNAQ6abVabfGacL2xq1JsmsXKGFfao6mwgbi8x
	 iok/zi74DkV4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 04/14] bpf, riscv: Convert struct_ops arena
 arguments in the trampoline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821233516.3426127-5-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 23:44:33 +0000
Message-Id: <20260821234433.C85691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned memory access in JIT instruction patching
--

--- Patch [4]: [PATCH bpf-next v1 04/14] bpf, riscv: Convert struct_ops are=
na arguments in the trampoline ---
commit 0283a3765a698e09bc666805ea8cb746cf58f299
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf, riscv: Convert struct_ops arena arguments in the trampoline

This commit converts struct_ops callback arena arguments into the arena poi=
nter
form when copied into the BPF context. It walks the function model by argum=
ent,
adjusts the pointers via bpf_tramp_arena_base(), and handles nullable argum=
ents.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c97d13a3eae4e..8db992a285f6a 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -888,20 +888,75 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke=
_type old_t,
>  	return ret;
>  }
> =20
> -static void store_args(int nr_arg_slots, int args_off, int stack_args_of=
f,
> +/*
> + * Convert an arena kernel address into the arena pointer form on its way
> + * into the BPF ctx, dst =3D (u32)(src - kern_vm_start). A nullable arg
> + * preserves NULL, tested on the full 64-bit kernel pointer. The final
> + * zero-extension makes the stored value satisfy the JIT invariant for a=
rena
> + * pointer registers.
> + */
> +static void emit_arena_arg_conv(u8 dst, u8 src, bool nullable, u8 base,
> +				struct rv_jit_context *ctx)
> +{
> +	int branch_off =3D 0;
> +
> +	if (nullable) {
> +		if (dst !=3D src)
> +			emit_mv(dst, src, ctx);
> +		branch_off =3D ctx->ninsns;
> +		/* Patched below once the variable-length conversion is emitted. */
> +		emit(rv_nop(), ctx);
> +		src =3D dst;
> +	}
> +
> +	emit_sub(dst, src, base, ctx);
> +	emit_zextw(dst, dst, ctx);
> +
> +	if (nullable && ctx->insns) {
> +		u32 insn =3D rv_beq(dst, RV_REG_ZERO, ctx->ninsns - branch_off);
> +
> +		*(u32 *)(ctx->insns + branch_off) =3D insn;

[Severity: High]
This is a pre-existing issue, but does this direct 32-bit store cause an
unaligned memory access trap?

If earlier instructions in the JIT context use 16-bit compressed instructio=
ns,
ctx->ninsns (and therefore branch_off) becomes an odd number. In that case,
ctx->insns + branch_off points to a 2-byte aligned address, not a 4-byte
aligned one.

On RISC-V hardware that does not support unaligned memory accesses, casting=
 an
unaligned u16 pointer to a u32 pointer and performing a 32-bit store trigge=
rs
a CPU exception.

Could this be safely written as two sequential 16-bit writes to avoid the t=
rap?

> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821233516.3426=
127-1-memxor@gmail.com?part=3D4
