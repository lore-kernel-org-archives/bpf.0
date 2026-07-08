Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0D3F786F
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498573; cv=none; b=oOxwSjLS4HYAfB3T/uIATuAgDHYQQlb3bvFcrElQ4ZbIcLaxB0aWwvnj2ktGCTDhTM4dKoqeS1fpPbHIE0jsAm7yDFPSI4E5UkHjCI5VFY6iCcBCuHaTy6c7agMu4gBEZNtCc8I+1UbgvbXSeLbZ6me7rbmRopPc74Y09arbEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498573; c=relaxed/simple;
	bh=XeDZaZMWykdgXGyWI3aHxGNIccvyZkzxvXI/z+8K0BI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hWBee96KHEfzIwNLo6d+C5Mzt7mGE8WWifncYSjP9sSASVoBy25DkLjGJ4uGLKx+v1E6yy5ITNOOzDJhbECAvgd2ygpU/zOkVL1AxfgmNBxmdLpbUofM+9z1tvmBJ/Q9xFsieCIt8xqzp+DllyKwjm0kMMIdsFmqQNtAGTAiEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCIuFkyL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCIuFkyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7006D1F000E9;
	Wed,  8 Jul 2026 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498572;
	bh=1VQvPiM3lxTOlOI4kA4XbCgBSzn34aFsOQFI6/FVuGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCIuFkyLkeY73dfg4V8DNsVmr3+syNMtHf2TzrAybNQe/bd+6CC4OJWL7UcOv+lZf
	 rdzfTtb6VNDFs9jEHCnvWEQggY5SAWU8jShMR5tU46jbjVfdCnrdfiB3myKo5Si3Fa
	 WORv/IL4y6Ks4oBcp0BLtLYZ0optM+8EZ/dnFfhiAu8rsnv8LS1QSKBApEHFvHBI1B
	 1XgaeI9f5tsxawRrI+pUIRr3eKpXn9VBgn/YCWDoJXY/lQu+IoVYA58C94wBX2hwa5
	 RdFPOjwByr/j26i7cc/E5e350KqLXSTP+OE+klJZAvtzom8nU2hf8zM9t3Zu5TPgq8
	 0+mE3RpeO6WDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-4-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-4-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:16:12 +0000
Message-Id: <20260708081612.7006D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] emit_kasan_check() fails to save caller-saved registers r10 (BPF_R=
EG_AX) and r11 (AUX_REG), causing them to be clobbered by C KASAN helpers.
- [Low] The static function emit_kasan_check() is defined but never called,=
 leading to a -Wunused-function compiler warning and build failure.
--

--- Patch [4]: [PATCH bpf-next v4 04/10] bpf, x86: add helper to emit kasan=
 checks in x86 JITed programs ---
commit 702ec90119cefcab13a29595976ba78253e74ce6
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: add helper to emit kasan checks in x86 JITed programs

This commit adds the emit_kasan_check() function for x86 JIT-compiled
BPF programs. It emits KASAN shadow memory checks before memory accesses
by saving state, computing the address, and calling C KASAN helpers.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1beae..d35f58350d710 100644
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

[Severity: Low]
Does this introduce a -Wunused-function compiler warning? The static functi=
on
emit_kasan_check() is added here but does not appear to be called anywhere =
in
this patch. This could cause build failures on setups with -Werror, breaking
git bisectability.

> +#ifdef CONFIG_BPF_JIT_KASAN
> +	u32 bpf_size =3D BPF_SIZE(insn->code);
> +	s32 off =3D insn->off;
> +	u8 *prog =3D *pprog;
> +	void *kasan_func;
> +
> +	if (!env)
> +		return 0;
> +
> +	if (accesses_stack_only)
> +		return 0;
> +
> +	/* Derive KASAN check function from access type and size */
> +	switch (bpf_size) {
> +	case BPF_B:
> +		kasan_func =3D is_write ? __asan_store1 : __asan_load1;
> +		break;
> +	case BPF_H:
> +		kasan_func =3D is_write ? __asan_store2 : __asan_load2;
> +		break;
> +	case BPF_W:
> +		kasan_func =3D is_write ? __asan_store4 : __asan_load4;
> +		break;
> +	case BPF_DW:
> +		kasan_func =3D is_write ? __asan_store8 : __asan_load8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Save rax */
> +	EMIT1(0x50);
> +	/* Save rcx */
> +	EMIT1(0x51);
> +	/* Save rdx */
> +	EMIT1(0x52);
> +	/* Save rsi */
> +	EMIT1(0x56);
> +	/* Save rdi */
> +	EMIT1(0x57);
> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);

[Severity: High]
Could omitting r10 and r11 here lead to data corruption?=20

The commit message mentions skipping them to reduce overhead, but the called
C functions (__asan_loadX, __asan_storeX) follow the System V AMD64 ABI and
might clobber caller-saved registers like r10 and r11.=20

In the x86 BPF JIT, r10 is mapped to BPF_REG_AX, which is used across
instructions to hold state (such as during constant blinding rewrites where
BPF_ST_MEM is transformed into BPF_STX_MEM using BPF_REG_AX as its source).

Would this result in storing garbage data when the C helper clobbers
BPF_REG_AX?

> +
> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D4
