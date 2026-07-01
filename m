Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9543FD95C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900733; cv=none; b=MhoiIwJ8AntjDormfNtoxR0Yw8SepSutEQzwKkr63VJLvKOqc+Zv3Qj6xcIkxkLLzunClYLOvEwlSszyFEFI0fRk3QUMWdIJZdTUU+a5/at0LHxLDM0dK6yXjli1sZuvxyabf24BZkw1cVu/H8P8eO4RGGV6B4GxCS0i7RCYAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900733; c=relaxed/simple;
	bh=nMdmmmk7MgFxQIe4QKfYAxnfbVHFYsYy2fsUsbB++CQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARvTUyFyFm/W+C9DrbSBCq4zmPkRKBTN+LbJiuGXj3BsPFkrqTzeycEQ9tJrpiuyYQ5tM6ljZwXaCi8ZBzZ92HINh1u2VOTDUTu9yIfQdwI0URt218CvqesE/WduT0XToHmgQb0OYZN9CLWwD6jYnOCIMFrqL+d67MS3z6kTmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHNyBZfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHNyBZfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD851F00A3D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782900731;
	bh=zgzHspPZoPCOjxbPvmh30ujzLd9Y0dkfmJk5isxrxRg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KHNyBZfGZ5xJ1SLngCK3x/2gdrkXcRVESsNlEzwz4/YbXqxik3V0TJ8viVwPLy7/n
	 pH2WsWFgqNkk0zYeBjOY0hPuA/KO8+37OrOntoVICqpdmzsJRl4CM18nHSZWt85zp8
	 XbGquEoETIZr0+ho6lrPHvF2JIcAXI527vaDYCZdJP5/cUoKumQCczdhnaaRs7d3Zo
	 co0NtUk8ICbbtBax+ER2ajQ8LqLttDbYe+y3U+5+hY1xsg57j1xe4WaU2/y28BT9Su
	 k1cFHy9iM8fsi1ICaLfoX4QYIJ4zgcfyLI9oSMCSmJ5TqWfoPK5XCZSjqfWXQlrpvw
	 kq389gRJhjYMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:12:11 +0000
Message-Id: <20260701101211.AAD851F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF_JIT_KASAN needlessly restricts its availability by unconditi=
onally requiring VMAP_STACK.
--

commit 23714982e1ca6e827ba19b9f4c74b703b4ad2090
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs

This commit introduces CONFIG_BPF_JIT_KASAN to enable generic KASAN memory
access checks for JIT-compiled BPF programs. The JIT compiler emits shadow
memory checks before memory accesses to detect bugs like use-after-free or
out-of-bounds at runtime. The feature is gated behind HAVE_EBPF_JIT_KASAN.

> As KASAN instrumentation for eBPF program will depend on the info that
> can be accessed during each instruction verification, there may be
> instructions that will be instrumented even if they don't really need to
> (eg: global subprograms that access caller stack memory passed as
> argument). To make sure that those additional checks do not trigger any
> crash, make sure that VMAP_STACK is enabled so that programs stack has
> shadow memory allocated.

[Severity: Medium]
Does generic KASAN already map shadow memory for the entire linear mapping?
If VMAP_STACK is disabled, the kernel stack resides in the linear mapping,
which should already have shadow memory allocated. Could this justification
be slightly misunderstanding the default generic KASAN shadow memory covera=
ge?

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig

[ ... ]

> @@ -101,4 +105,9 @@ config BPF_LSM
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> +config BPF_JIT_KASAN
> +	bool
> +	depends on HAVE_EBPF_JIT_KASAN
> +	default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_STACK

[Severity: Medium]
Is it necessary to unconditionally require VMAP_STACK for BPF_JIT_KASAN?

Following up on the commit message note, since generic KASAN covers the
linear mapping where non-VMAP stacks reside, this condition might needlessly
disable a useful security and debugging feature on kernel configurations
where VMAP_STACK happens to be turned off.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D3
