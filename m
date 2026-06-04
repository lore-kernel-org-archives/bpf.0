Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340203FCC
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608087; cv=none; b=mtx/SsNZRmT7opZJQu3usEP69kZ9XnpBB078oYSq3uKGGlU22VnOCd8jCcXJJTRthCHFv3GyrNrYKJh7UeeFcq7z776aW0qEBw88YWW1C+9rI83jcNXIuKH9ISl7W0RydnIvE+tgkRdQ5UPEQ2VGYqmESnPibGRQfDQk6oFKYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608087; c=relaxed/simple;
	bh=JPUED4BJHgNlt+91u518gIzMtjdw5jS/YV2rIOT/e6k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uf4IJvn6X4FbVb4Xufq6iMxvmQ4kd3s4EWcG5Ha/TZWT6dNb9Q7lEzOkviFzqaZUZIaG3Jf6iwBuf/CK8NzIlp3VJk801odugLk0rNd12zhYPoLIDfABq2BF3WWBNu0DNnIzXDXqB4XjSQN0BIh6O2sPe5cdSzdfshj4V2KOQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le0WRV+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le0WRV+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76E1F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780608085;
	bh=XTNrF/ft7Z3vBb6HkrGBLhEsG6XFROoafbypnb0pSIo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=le0WRV+uznGgvIcv7uJwdgsnmExUI1J3CmB/QEW/O1boI9DvbNRRg9NW+bcLFfN3z
	 19zTcvGM+RRZ+XREDoeFfSl3KSEGDI1VMmqq7+KDgd7sUO+WIEQ7k1Im3p7xCIswGv
	 nyO3/DWN2QM/SnrNVf8Bnm8R1Eix4nI2jKFfJ0OAb4HyddZJOySWPnk89/S6C3d67i
	 rciHrwsNSM+ZUP3zQQuMizD13jFBS88HuwtR9dPIc2Lvpxq1SAJb53lBDYAZTJ82/8
	 RNtVmMmzWjMku5ncwKMhcFG0xpRLgS9wV0jvqwJ2nJ2pS3ao2R+AQA+kdaNiEXhtsY
	 QAxExaDnm/w/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/8] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-6-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-6-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 21:21:24 +0000
Message-Id: <20260604212125.9D76E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The KASAN check in the x86 BPF JIT compiler (`emit_kasan_check=
`) fails to preserve caller-saved registers `r10` (`BPF_REG_AX`) and `r11` =
(`AUX_REG`), leading to memory corruption, arbitrary memory access, and inf=
o leaks.
- [Low] Variable declarations are placed immediately following a `case` lab=
el, violating C syntax rules and causing a build failure.
--

commit 29da435698ac0652be4882bbae40b6fd5dd2bab5
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

Mark x86 as supporting KASAN checks in JITed programs so that the
corresponding JIT compiler inserts checks on the translated
instructions.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a0c541a441cfa..cb3c03edc4bde 100644
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
> +	/* Save rdi */
> +	EMIT1(0x57);
> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);
> +
> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);

[Severity: Critical]
Does this code clobber the r10 (BPF_REG_AX) and r11 (AUX_REG) caller-saved
registers?

Since kasan_func is a standard C function, it may clobber r10 and r11 under
the System V AMD64 ABI. Because BPF_REG_AX is used in critical paths across
memory accesses (like atomic fetch operations and constant blinding),
not saving and restoring r10 and r11 here can lead to corrupted pointers or
arbitrary uninitialized memory being read/written.

[ ... ]
> @@ -2490,13 +2622,13 @@ st:			insn_off =3D insn->off;
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
>  		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> +			u32 real_src_reg =3D src_reg;
> +			u32 real_dst_reg =3D dst_reg;
> +			u8 *branch_target;

[Severity: Low]
Does this cause a compilation error?

In standard C (prior to C23), a label can only be attached to a statement,
not directly to a declaration. Since these declarations immediately follow =
the
case label without an enclosing block, it violates C syntax rules.

>  			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
> -				bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> -				u32 real_src_reg =3D src_reg;
> -				u32 real_dst_reg =3D dst_reg;
> -				u8 *branch_target;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D6
