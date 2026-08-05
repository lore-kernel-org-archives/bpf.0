Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA81632E7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910446; cv=none; b=t6orb5QcZOk4DiOLwnkLrWilZail1h1w/dZiqs7yrOvJvkyqkGXWPDgOmZTb54VChHsNQukSgWiN1ptWg9FSlxS4paE4jiX931P7BYdx8pYWKc/7IWsgbpf7evJvBHENPeUWxxlJZlIrx2+sjUwAi7lrrKvyxVcHVBDD86YO7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910446; c=relaxed/simple;
	bh=yVwntV7jYbm+BSKYMQSMY4OxViXD52S7q7TBluXbCdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nABMboOeejP/tAaBgHE/HVQegqX4maKwrcBEqfotk/ol4I/E9QtGSfvjRaAs+KikUgGkwZRD2Hmr224U5uz4KV19LtdbEoEk3/3RTEQ+QOzhVRd6qmlCrJtpBPigeYwtSRWoUC0r9zdPHDX/Wle3PPhMxrOtj1nD2qzvJLsHHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VInlMyPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VInlMyPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC51F000E9;
	Wed,  5 Aug 2026 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910445;
	bh=PZCDCaTGoNVEuoxqz4/El3uV8AYzotS9rXqTToJiK4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VInlMyPB7cUhlWTiYGMMk/eROnUvYdFixpvfE+M1M35uRdKLblcXDwb/C6ojy4Wsc
	 QvC+DeRbxUA9oFBpQFMrjHJV7685NUzd8H8fMZ8KDg1k4TtTxkQrS3UVVUfPKzMz2s
	 IwXRSjbuvCnqtyKucpGfw76zxWF89b626FakD4r4E+NH76JyGXMMzCjvzYjsGuJoDM
	 hXv7eQau4U6SR9wC+f9+cNJoAOHUEtlDn1P77mSh+0n7LugtJTX+ydM7KIVtO9qhv4
	 kNw2a5fdA1Tn0AJqdNi2IuTzqq1y2MouMd6dev1uwhumMk71fWwkPo3zWL+aPnCQr9
	 X4DB/9vLMwzzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/8] selftest/bpf: Add tailcall verifier selftest
 for powerpc64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <83b869ecd74466a3fb08343c365494dcf144e3f6.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <83b869ecd74466a3fb08343c365494dcf144e3f6.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:14:04 +0000
Message-Id: <20260805061404.CCDC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch introduces a multi-line comment that violates the BPF sub=
system comment style.
- [Low] Redundant and misleading repetition of `__jited("...")` annotations.
--

--- Patch [6]: [PATCH v10 6/8] selftest/bpf: Add tailcall verifier selftest=
 for powerpc64 ---
commit 93fe35d1a465f1c1dd05d30ed36bf46603bc5f71
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Add tailcall verifier selftest for powerpc64

This commit adds a new BPF tailcall verifier JIT selftest for the
powerpc64 architecture. It verifies the emitted JIT instructions for
tail calls, handling differences between PCREL and non-PCREL kernels.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/=
tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f4..7655742f627bc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
[ ... ]
> @@ -91,6 +91,80 @@ __jited("	popq	%rax")
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
> +/* Address materialization differs between PCREL and non-PCREL kernels.
> + * Skip the address generation sequence and verify only that the call
> + * target is loaded into CTR before branching.
> + */

[Severity: Low]
This isn't a bug, but does this comment block follow the standard BPF
subsystem comment style?=20

The subsystem guidelines require multi-line comments to have the opening
characters on a dedicated line, like this:

/*
 * Address materialization differs between PCREL and non-PCREL kernels.
 * Skip the address generation sequence...
 */

> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")

[Severity: Low]
Are these consecutive string annotations redundant?

When test_loader.c parses the "..." string via push_disasm_msg(), it merely
sets the on_next_line flag to false. Repeating it multiple times does not
force the verifier to skip exactly five instructions; it just sets the same
boolean flag repeatedly.=20

Would a single annotation be sufficient to achieve the desired skip?

> +__jited("	mtctr 12")
> +__jited("	bctrl")
> +__jited("	mr	8, 3")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785906979.gi=
t.skb99@linux.ibm.com?part=3D6
