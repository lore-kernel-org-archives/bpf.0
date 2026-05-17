Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372C223708
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045290; cv=none; b=A+ycjHLOLbAPmekTQ2RRoQSusDhU1OplEqe8cACYvbKzBWYEdlERVLRUD7VMo2dthoh5ioHSSEUGgo/n+yOdrjtoW0EfwiLO43YJw7Mn3yBihwXfXemkvIc7p9vrfNl2Oj+Y7T3yEkHdE9DGbAebizTFm54BkzH5nIgvjgM0MpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045290; c=relaxed/simple;
	bh=5F2cd6kmpe3y9hbOQm94lBRiFdLKH/wKiPITz5T4emY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGLJxxrwk5s8LFZBdtHoQUQ73T/8lUD8mWYelwwVrPC8iWbFejj82k9hfvr7DVwQT1hj78yXe6z79lZj5WQWqm+PY/nZ3UzkQifVgTtgvhutQ970IP2ZHKM0qtX4QZT7u/rmRPSUzDZhna8P7sVc20kYoBteNF2Ca/84SXx0cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf5c0BYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf5c0BYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE6C2BCB8;
	Sun, 17 May 2026 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779045290;
	bh=5F2cd6kmpe3y9hbOQm94lBRiFdLKH/wKiPITz5T4emY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zf5c0BYw6cAgvWBCMoyMLsPEmgJ6NINIAIj7eoIEROAZCJeZ11YJz/9jwekLscNjM
	 v9SFGKqjfG6HDJvQD8uMttggh5Kn8oZ5ZGuW5DP/H0WWOznzqMeeTuK3nykLzOa32D
	 wAB4EVpn7XeCi7+VqxCJWCSVr5fHV6YdVffBsmyelNvEf1YbazcqJ6/2rqEpm4PcEr
	 QVhxpYPKi7NZt+XuzDSGG+A6iow23v/OnJCbIVc5XFUv/qI5wJ+rCz0tub15PwB28r
	 r2dSO0YV9NzM6Mr7NTUzWw9Nc7TfmJQvuUOq7x4QW6Hb1Bokqzbxcz4aXW3Fa9iKzz
	 Fl+azf26dmBdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] selftest/bpf: Add tailcall verifier selftest for
 powerpc64
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517214043.12975-6-adubey@linux.ibm.com>
References: <20260517214043.12975-6-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 19:14:50 +0000
Message-Id: <20260517191450.85AE6C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] This problem wasn't introduced by this patch, but the selftest enf=
orces the use of a 32-bit comparison (`cmplwi`) for distinguishing 64-bit p=
ointers from scalar values, codifying a tail-call limit bypass vulnerabilit=
y.
- [Medium] The expected powerpc64 JIT disassembly hardcodes config-dependen=
t instructions and offsets, causing test failures on kernels with `CONFIG_P=
PC_KERNEL_PCREL` enabled.
--

commit 9136278f4ffaab3858500dc94c8a08d981e53500
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Add tailcall verifier selftest for powerpc64

This commit adds a verifier tailcall test case specifically for the powerpc=
64
architecture. It verifies the JIT compiler's code generation for BPF tail
calls by matching expected instructions.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/=
tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 8d60c634a114f..17475ecb3207a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -90,6 +90,75 @@ __jited("	popq	%rax")
>  __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>  __jited("L0:	leave")
>  __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")
> +__jited("	ld 2, 16(13)")

Are we sure this load is always emitted?

On modern PowerPC configurations where CONFIG_PPC_KERNEL_PCREL is enabled,
the TOC load might be omitted by the JIT compiler.

Could this use wildcards to prevent test failures on kernels with PC-relati=
ve
addressing enabled?

[ ... ]

> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmplwi	9, 33")

This isn't a bug introduced by this patch, but does the use of cmplwi here
codify a vulnerability in the JIT compiler?

Since tail_call_info can contain either a scalar counter value or a 64-bit
pointer to the counter, using a 32-bit compare (cmplwi) only checks the low=
er
32 bits.

If a 64-bit pointer's lower 32 bits happen to be <=3D 33 (for example, a st=
ack
pointer near a 4GB boundary), it might incorrectly bypass the tail call lim=
it
and cause an infinite loop leading to a CPU hard lockup.

Should the JIT (and this selftest) be using cmpldi instead to properly hand=
le
the 64-bit comparison?

[ ... ]

> +/* bpf_tail_call implementation */
> +__jited("	ld 9, -8(1)")
> +__jited("	cmplwi	9, 33")
> +__jited("	bf	{{.*}}, {{.*}}")
> +__jited("	ld 9, 0(9)")
> +__jited("	cmplwi	9, 33")

(Same question here regarding the use of cmplwi instead of cmpldi)

[ ... ]

> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	cmpldi	10, 0")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	addi 10, 10, 16")

Does this instruction offset also depend on the kernel configuration?

It looks like the prologue size calculation that produces this offset depen=
ds
on !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL).

Could this fail on configurations where PC-relative addressing is enabled, =
and
would wildcards be more appropriate here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517214043.1297=
5-1-adubey@linux.ibm.com?part=3D5
