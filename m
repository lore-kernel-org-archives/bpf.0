Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242438A706
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252175; cv=none; b=Zc13hUdFZq+6i+4xuSCZkEaZxuGPFpklcn9uRcHrOifDUY32rPSwRXDmfcIVocwogJnrtF9tScIB1NQdMYiR8Z3A0jLbOCQwtTkHMVTRjPc5hwxOBCuPCwm5UCXly1GTEwKIUF0fYAghY+B7es6Dd0C042buOU3C/v/Wgyt1WdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252175; c=relaxed/simple;
	bh=xq5djj0W/T3XU2XiMBUB+GCk0MW6WY3vdw4kRbhWy94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQSXl6OBqt3QJjWDie/aKX2aKbEoYCGqi2PiLtur5oD8z/ckQZbLbtmClocj5MI/DnxzREB36Hgr4GmbcLE4YxGs3SPWCKAs2JRDG/5gFmY13+0RvCc872vYvq3lWJ2zLWqBZQ1TGT8IiK6pw1IOmVpSJvtHpzxSkFNP4vyxeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3cqDgX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3cqDgX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A131F000E9;
	Tue, 23 Jun 2026 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782252174;
	bh=bmOYeRrCSesGnKZyJUoRUH3p3FrbNjkxMNN770EpDpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3cqDgX3fVj4cFrqPisqdfkX9DXjm6VKyAXAPGzQhRwZFwB3XsYAV7oHwAmom+oOe
	 /khhlzj03ecv1SKxl29Z32V+9uAjekSh7KgCLLCtoCpza7FtoOi244x+6cr5SZkhpn
	 0VCWfQHgg89har9Rq1i6anB4KXaoazz2IgoUfQznD46xP+wCMjwjUWfJ33mXF2DsqR
	 wyYnI825Y9sHj75f58apvzYuhzjYGfL3liKEdUfP2iete1O+Jyc1w1ZrWJCiZqLBQC
	 wG+BSxZRq+P7+mTJhrDpNK6jcSnfs17amj7LPP/ZF9wZGCxrrhlOa6m3j36JmYiyTx
	 BJt1dHLyhWO/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v9 6/8] selftest/bpf: Add tailcall verifier selftest
 for powerpc64
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623231411.6216-7-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
 <20260623231411.6216-7-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:02:53 +0000
Message-Id: <20260623220254.05A131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] JIT disasm regex for loading 64-bit immediates strictly expects =
'oris' and 'ori' instructions, but the PowerPC JIT conditionally omits them.
- [Medium] JIT disasm regex for BPF-to-BPF tail calls fails on PowerPC kern=
els with CONFIG_PPC_KERNEL_PCREL enabled.
--

commit b4e7d4404702ca69adf00490d083d127f762e2ed
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Add tailcall verifier selftest for powerpc64

This commit adds a tailcall verifier selftest targeting the powerpc64
architecture. It introduces __arch_powerpc64 JIT regex matches for both
regular function calls and tail calls.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/=
tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f4..09d7e92c84910 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,75 @@ __jited("	popq	%rax")
>  __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>  __jited("L0:	leave")
>  __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONF=
IG_PPC_KERNEL_PCREL */
> +__jited("	li 9, 0")
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/* load address and call sub() via count register */
> +__jited("	lis 12, {{.*}}")
> +__jited("	sldi 12, 12, 32")
> +__jited("	oris 12, 12, {{.*}}")
> +__jited("	ori 12, 12, {{.*}}")

[Severity: Medium]
Will this strict absolute 64-bit load match fail on Power10 and other
kernels with CONFIG_PPC_KERNEL_PCREL enabled?

It appears that when CONFIG_PPC_KERNEL_PCREL is enabled,
bpf_jit_emit_func_call_rel() checks if the relative offset between the
call site and the target is within 8GB. Since main() and sub() are BPF
programs allocated close to each other in vmalloc space, the offset should
fit within 8GB.

This means the JIT would emit a PC-relative load (pla r12, addr followed
by paddi) instead of the absolute load sequence expected here. Does the test
need a fallback or PCREL-specific wildcard block?

> +__jited("	mtctr 12")
> +__jited("	bctrl")

[ ... ]

> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")
> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")

[Severity: Medium]
Can this strict expectation for oris and ori cause test failures depending
on the page size?

The PPC_LI64 macro optimizes 64-bit immediate loads by omitting the ori
instruction if the lowest 16 bits are zero, and oris if bits 16-31 are zero.

Because the test loads the address of the jmp_table map, which is allocated
via vmalloc() and is page-aligned, on PowerPC64 systems with a 64KB page si=
ze
the lowest 16 bits will always be zero. This would cause the ori instruction
to be omitted entirely, resulting in a regex mismatch.

> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623231411.6216=
-1-adubey@linux.ibm.com?part=3D6
