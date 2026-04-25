Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF82BDC26
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777098804; cv=none; b=rpnfWIauOIOZC9Khe/J5zg8cR8Yqf17YULWUtxMv+vReoAUN4ZAr97j2pInk4QXr60679Ep32SMVAW+BYA6BwIbre+a228GqqXFp9FyPJkB1pRUU8d5EVqS2U7ZNxJBKP3hU1C4dijh2+HOaJnqM0jn5kBsw14SotsjDyCiy/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777098804; c=relaxed/simple;
	bh=cKvbIX024p6VOSC4pNw75gWTgCVeSh4dqRaxtwn0axA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QJlH1Eh4hsMJ6bNZART7eLUUZE9xDhD5c1LQL27ti82XONBNomIVM3MujD/giL+lxm9ZKYm1XCg+g1UIXrRISrLQJXUgIpzLSb7An8iA6da/Jyt6Mn/SeHQmG7msfS70QovYJLwMR66IfQVtPx3DeucpDkIFM8S6QJtHNOK8VQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPIjN0+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPIjN0+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856BCC2BCB0;
	Sat, 25 Apr 2026 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777098803;
	bh=cKvbIX024p6VOSC4pNw75gWTgCVeSh4dqRaxtwn0axA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RPIjN0+Gd4kCJDPKjzGJDVYKFvZ99gpZqGEsMb/yjbUzYbAwbqZxcQzrurD7L5Aj5
	 gxs2HUU9gmRR+3oXoR9OOKX/eriSW9umwzBuOJ8Qv2CKSM9v3ELGDXt6BTNBVvQeEC
	 OM/HKfg4sfvxdEtWySq31jPvm8GVhu5pyFE9FwdXCKuBeY8/x6qfHso2bW1kaS8WcH
	 N6buOzFSMm0ZTYpiE6MWsBRgxLcXSJYlXOHz7AbYBBnDI0IaFW5T1y9Cme2gtXBrPY
	 TbMiDFrVGIgI2jPOwEvkg1lEooe47DGvc0lcxaaWVk/8Hc0wYFgCeCTG7olmM+OClj
	 L5X2YZYhTMaaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 7/8] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-7-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-7-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 06:33:22 +0000
Message-Id: <20260425063323.856BCC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The x86 JIT compiler misses KASAN instrumentation for BPF_ST (stor=
e immediate to memory) and BPF_ATOMIC (atomic read-modify-write) instructio=
ns.
--

commit b74234d98543fb8b6b97cccfe13819f42ebebe33
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

Mark x86 as supporting KASAN checks in JITed programs so that the
corresponding JIT compiler inserts checks on the translated
instructions.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3f7cb01d69d0..cc140108b74c5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -235,6 +235,7 @@ config X86
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> +	select HAVE_EBPF_JIT_KASAN		if X86_64

Is it safe to enable KASAN for eBPF JIT on x86 when some memory access
instructions appear to be missing KASAN checks?

Looking at arch/x86/net/bpf_jit_comp.c, while BPF_LDX | BPF_MEM and
BPF_STX | BPF_MEM correctly call emit_kasan_check(), BPF_ST | BPF_MEM
and BPF_STX | BPF_ATOMIC directly emit x86 memory access instructions witho=
ut
instrumentation.

For example, BPF_ST | BPF_MEM does not include the check:

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
		case BPF_ST | BPF_MEM | BPF_W:
			if (is_ereg(dst_reg))
				EMIT2(0x41, 0xC7);
			else
				EMIT1(0xC7);
			goto st;
    ...
}

Similarly, atomic operations are missing the check:

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
		case BPF_STX | BPF_ATOMIC | BPF_W:
		case BPF_STX | BPF_ATOMIC | BPF_DW:
			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
    ...
}

Could this allow an eBPF program to bypass KASAN memory safety validation
by using immediate stores or atomic operations?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D7
