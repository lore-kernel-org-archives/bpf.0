Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D03F58FB
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596570; cv=none; b=h1mxYXiR2aTIDYBIQecHfXXO4xZMjblRUsfaQw60Cjpv0TW2Dgxs38bYL/KK4lJbhI4+fmPhCmYcu6EnnFcLXDnGWqCt1fiX668ky2AkJfsHjcx59M+RexNjvWZmZZtjlFSCIYRprsEE7979rcl+SuYyHPcU0OUP1kYrcOCosd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596570; c=relaxed/simple;
	bh=ZOaa9ie7/V+w1Rul4dzRcr80zneNLlJJE6/Jdv3B9GQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDstp9LzApLd4zjIbM7Mx9jBc1u+PUlx7AIos3V5sfEFHvAgRT+xuUYQeypYI8laB/uVsGYezrfqjPr362bwrY+2IT7WrDDh2YBAWKih0hjCZGk8wto7SUsVN/j7nC3Oh8UV9Xt/R5ktKVXwbttK5LZxd6XrIy0sqI7hsYeSQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctmU982o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctmU982o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C2D1F000E9;
	Thu,  9 Jul 2026 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783596569;
	bh=fqvU/jFC95UPOweGlMyXaN6pqTbx1tK5nXaV6SNm1ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctmU982oLTPKJ70G2lcbfzPz0SUeL+XmUDeLtR16+QIIKTOtyYASgd11Jfw0FhZjP
	 QBT6e+A+ge8VsBU9Bc/Cg1Oo/b8T3u1BvzJNAufoTTEePXRm+kHAPJfmdCAsAg3nre
	 lU9ssjRlS1Oef9RbP1RnGBt9DqsNBfIq8FjcKzPtI+qyREgaOCUSNGNqj1fimApv9X
	 bLTIJxVHws0aloT4wBfvHWwxkSDo/axprWB/rhq7Im4mqCiEQN3bNJG/DnVtZbFCyw
	 pp/pS4dIdYHyF5Bamgqs8WiKHGRxsuRmUlV7J35vaIfiyJWkuKMBJLImF+9XApKzgo
	 +r01ynv+1vLhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 07/10] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-7-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-7-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:29:28 +0000
Message-Id: <20260709112929.01C2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The BPF JIT KASAN integration on x86-64 fails to preserve caller-s=
aved registers `r10` and `r11` across calls to KASAN functions, corrupting =
BPF internal state.
--

--- Patch [7]: [PATCH bpf-next v5 07/10] bpf, x86: enable KASAN for JITed p=
rograms on x86 ---
commit ecf3ad3bc8d5ddd31f31891c28722d7d1b08f230
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

This commit marks x86 as supporting KASAN checks in JITed programs. It enab=
les=20
the corresponding JIT compiler to insert checks on translated instructions.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bdad90f210e4b..705a9ab85f3a9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -233,6 +233,7 @@ config X86
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> +	select HAVE_EBPF_JIT_KASAN		if X86_64

[Severity: High]
Enabling this option exposes a register corruption regression in the underl=
ying
KASAN JIT implementation.

Looking at how emit_kasan_check() is implemented in
arch/x86/net/bpf_jit_comp.c, it saves most caller-saved registers but
explicitly skips r10 and r11:

arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
	/* Save rax */
	EMIT1(0x50);
	/* Save rcx */
	EMIT1(0x51);
	...
	/* Save r8 */
	EMIT2(0x41, 0x50);
	/* Save r9 */
	EMIT2(0x41, 0x51);

	...
	/* call kasan_func */
	if (emit_call(&prog, kasan_func, ip))
		return -ERANGE;
	...
}

However, during atomic fetch operations, do_jit() relies on BPF_REG_AX
(which maps to r10) holding live state across the emit_kasan_check() call:

arch/x86/net/bpf_jit_comp.c:do_jit() {
		...
		case BPF_STX | BPF_ATOMIC | BPF_DW: {
			...
			if (is_atomic_fetch) {
				...
				/* Will need RAX as a CMPXCHG operand so save R0 */
				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
				if (src_reg =3D=3D BPF_REG_0)
					real_src_reg =3D BPF_REG_AX;
				if (dst_reg =3D=3D BPF_REG_0)
					real_dst_reg =3D BPF_REG_AX;
			}
			if (!bpf_atomic_is_load_store(insn)) {
				err =3D emit_kasan_check(env, &prog, real_dst_reg,
						       insn, ip, true,
						       accesses_stack_only);
			...
}

Since __asan_store* is a standard C function, it can clobber r10
(BPF_REG_AX) according to the System V AMD64 ABI.

Could the omission of r10 and r11 in emit_kasan_check() lead to corrupted
internal BPF state when the verifier expects BPF_REG_AX to be preserved?

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D7
