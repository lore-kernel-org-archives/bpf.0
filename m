Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD455407CD5
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900954; cv=none; b=Om0sN3tLZQvZwaStzcUeM6yZcKOWaypl74UjmqU0jibZBK0SjtRlfY8706fzKY9QJE+O41AeXcV7rLaysxlTTEAJQJIctUKc/YPyaXUgo3tTt+X6LlIWMHfHGsD7A0LVOhmARQSTFrZ0Zik8/5Yin3xNCl7eTbFNiLv+5ccZUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900954; c=relaxed/simple;
	bh=uSn9N9TJyoXQVRBss79IZTfGWsGWwUp2C87TxpXCx+Q=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Smi5S1IlyCDfOvOOMk5iNikt0fg+drRlfLSM+fYHOFycb3pbhriMnT9d0gRrm7wEzRiPCy06Y1V2IL9vkldifJwzRwKcge4umGA906DXFA05jtrNb/5gk0O7JM5fCJqEtDIqls+ArANakmyH2aY7pru1REoFkgtGVsy27Tr9B7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqysyI2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqysyI2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470231F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782900952;
	bh=2Oup9QruGvaWt7sVymsSCUq/wyVJcA6vdrF19nMdES0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KqysyI2ijbVvhqhY6q38HH9nFpSufOhLHkzEXKfdg5TI325skfVM2BrH3IqgQuwEP
	 kRJtsjC4iHpZI13b9wwUPSKIiS4zzbRRxoRblqOL1pU93Ng5+t981hjB7SgKiRn4pU
	 5kNUQsRIu7UMlqpLb5vXuHS4FyLCKmRE4Qrq2GiCuSYC+OlmufL0JVkl3BsQcf9Bk2
	 XeV+dARc4dI7HXRqTWjFCJP+4iJxamhaRGGfy8Qsv5aITjSBDOhVmpqG9bN5K+ukcI
	 OrS7XWu9OnsZTq6kxjUYsuc2pMHDLeq2rsueqPA3Qr/11rpRbtfVVP1uRH0PcocfQD
	 LsUsnIhRn5Hjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 07/10] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-7-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-7-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:15:51 +0000
Message-Id: <20260701101552.470231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] emit_kasan_check() fails to preserve the caller-saved r10 register=
 (BPF_REG_AX), causing BPF program state corruption and kernel crashes duri=
ng BPF_ATOMIC_FETCH operations.
--

commit 9b578f89250bc8a04722f64b0dbcf3e863ff5692
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

Mark x86 as supporting KASAN checks in JITed programs so that the
corresponding JIT compiler inserts checks on the translated
instructions.

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
This isn't a bug introduced by this patch, but enabling KASAN checks for
JITed BPF programs here exposes a pre-existing issue in the x86 JIT
compiler during atomic operations.

When handling BPF_ATOMIC_FETCH with BPF_REG_0 as a source or destination,
do_jit() saves BPF_REG_0 into BPF_REG_AX before emitting the KASAN check:

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
    /* Will need RAX as a CMPXCHG operand so save R0 */
    emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
    ...
    if (!bpf_atomic_is_load_store(insn)) {
        err =3D emit_kasan_check(env, &prog, real_dst_reg,
                               insn, ip, false,
                               accesses_stack_only);
    ...
}

In the x86 JIT, BPF_REG_AX maps to the r10 register. Looking at
emit_kasan_check(), it manually pushes caller-saved registers before calling
the KASAN C function:

arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
    ...
    /* Save rdi */
    EMIT1(0x57);
    /* Save r8 */
    EMIT2(0x41, 0x50);
    /* Save r9 */
    EMIT2(0x41, 0x51);
    ...
}

This sequence fails to save r10 and r11. According to the System V AMD64 AB=
I,
r10 is caller-saved, meaning the KASAN C function is free to clobber it.

When emit_kasan_check() returns, BPF_REG_AX (r10) might contain garbage.=20

Could this cause subsequent memory accesses using real_dst_reg to dereferen=
ce
a garbage pointer if BPF_REG_0 was the destination?

Does this also corrupt the BPF program state when BPF_REG_0 is later restor=
ed
from BPF_REG_AX after the CMPXCHG loop?

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D7
