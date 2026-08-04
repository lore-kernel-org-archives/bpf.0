Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D68346AE1
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867040; cv=none; b=l6uUZvxcDreJZvjuUgYWVlQOKLFlYsTjV9SLt3vW6JnhIg8HIXcqZgN+bjkzcAXwMGyQDmklHCWlO4rYHbWyJS6uF2ikiAdTrhal1xUE3AJlpTZ2GUyasc+MrMg4R22h07GtbqDQif01+WGaRHig2YrYeJ50+nkkMz14ndff40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867040; c=relaxed/simple;
	bh=xOKouAays0j0FbMORAOOBqRX0ZUwKYo+SRMvtfWEaoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVjkgOcvfoglzu53hobPcMQ6LxjIuep6dSi7RqSEglgn6W/NIDEfpBpb4fbEApkHRMuEZIg/kmAIQmgObSthTeUlPQqqj/WqHDxOWMKScKGVOP9tSQutoAT3rr7UubZ2sRFp6fWVk7TJaMKGVUHx4NXBLANPEQbyU2CEOLp126k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrAlhWXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrAlhWXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A636A1F000E9;
	Tue,  4 Aug 2026 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867038;
	bh=Eta84+SHzfq+Jfl38F2ojsCo/wyZKwoB++2pI4w/yo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrAlhWXYJcdK/f1PdM/ASTrEHaFtNNM/s4jATgBAPzSAGW8lX4QuK+g02bIhhP0wM
	 VpoTbqrOEXG9V/h5g/V44eHTBLaeW6c8xEq3obVC0tpMnJVy97Eqc2wmA2TF2XQQz5
	 VfZ5kvoKsXyM75khBt073/VwhYdcqXsRdufwFnKuYZTLIZJsGu4rEJpz5hNv8yiyTY
	 5PdfgQVKtFx+l/d8blwW0Ye+FLUD5bMur39TQn0K5oTW9y6aFz0KW58iAsN+uPUXTw
	 EE/cDvqVMkam//rJMde+8m6cW8XVQ4R4GFdSyKnDJGHidbvZiJyhJypqIeH0Rq1CN7
	 brpoFE0acl/ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 5/9] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804-kasan-v6-5-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
 <20260804-kasan-v6-5-549ef845f491@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:10:38 +0000
Message-Id: <20260804181038.A636A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The x86 BPF JIT KASAN instrumentation fails to save R10 and R11 ac=
ross calls to KASAN helpers, leading to arbitrary memory corruption when BP=
F_REG_AX is used as an address or value register.
--

--- Patch [5]: [PATCH bpf-next v6 5/9] bpf, x86: enable KASAN for JITed pro=
grams on x86 ---
commit d7d5cc9dc7fbffd1005cd390c1a9b1a31a2025be
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
This isn't a bug introduced by this patch, but enabling this config exposes
a pre-existing ABI violation in the x86 BPF JIT.

When a BPF program uses BPF_REG_0 as an address for an operation, the JIT
moves BPF_REG_0 to BPF_REG_AX (which maps to x86 register R10). It then
calls a C KASAN helper like __asan_store8 via emit_kasan_check().

In arch/x86/net/bpf_jit_comp.c:do_jit():

                emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
                if (src_reg =3D=3D BPF_REG_0)
                    real_src_reg =3D BPF_REG_AX;
                ...
                err =3D emit_kasan_check(env, &prog, real_dst_reg,
                                       insn, ip, true);

However, emit_kasan_check() explicitly skips saving R10 and R11:

arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
    /*
     * SystemV ABI states that we should also save r10/r11, but in
     * practice those registers are _not_ used by the limited set of
     * kasan helpers we are calling here, so that's fine not to save those.
     */
}

Since R10 and R11 are caller-saved scratch registers in the System V AMD64
ABI, can the C compiler clobber R10 during the KASAN helper execution
(depending on the compiler version or optimization)?

If R10 is clobbered, won't the JITed code subsequently use the corrupted
register as a memory address, leading to arbitrary memory corruption?

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-kasan-v6-0=
-549ef845f491@bootlin.com?part=3D5
