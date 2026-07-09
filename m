Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E33DCD9D
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594454; cv=none; b=IlJ8v41BLJ/cZWsptRehn0EZAdqPQDgAJ/2QopsXzfXZDl0ki8l5RCsYlkna6v1ctc/n7HV4DfbqtOgJCPUDkBloCg/NCtdNzxk2DDv8n605iyi3hAW+QCgmMEFFcr6Od8wqCQviWsQKJhrfX59DneegCh9rYl3dwCQBui9rCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594454; c=relaxed/simple;
	bh=orKT5MMJCCL0dUCVVojiHKU/1lyKprd/7R2mhiZjY4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YYwOWmndHvCqY6v8noEVRlAk9AHwH9D++hRYYJAIO/GRoBN2EfvLMkE5ynygrTYgi1L8lPHcD3ThLuFd6bPXn2dROC4rmR5++9yJSFPoI08+h4segeq/4HwTnWaZuamfvaSW4fiJQbSGCRkTLme1svinvnl7wFktyCCJX1XvVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeZJwitl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeZJwitl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02921F000E9;
	Thu,  9 Jul 2026 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594453;
	bh=TwAhowS0wegcVUELfh/K++fPh/ru88IBRIAwd8B7JHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OeZJwitl58VvlUYjpLmJIFFWSAwtKR+C4FfsrK9VHBjmrOMeu8BoGkPC5wVS3BOTg
	 HKEpJ30uMce2aurp3eJzKRtMo3XQ6MlOuaUdcJKUg8Wq+pvvFVzDIHjPJpMrI1X4tv
	 FkTsAbK3Auv+Pwbmnuez6b3poEjTr684ukCfbX26lCgGD1G9eAUsfEcD5iKmAn9+qm
	 PVMPW99C9cFk058NmKIXjZdAdxdf+wGxGXxzUwL8ofxwmTsTDoqhLN2Hhrn/NFVQzF
	 voWYei4AtWSCElNws6T7LClCQAIPcyF9e4znm7PQyjdfQM/h5MxZpmnlARfVY756Pj
	 ii78LloWVC+Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-4-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-4-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:54:12 +0000
Message-Id: <20260709105412.E02921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `emit_kasan_check()` fails to save and restore caller-saved regist=
ers `%r10` and `%r11`, causing ABI violation and memory corruption.
- [Low] `emit_kasan_check()` is static but unreferenced, breaking the build=
, and KASAN configuration is incomplete.
--

--- Patch [4]: [PATCH bpf-next v5 04/10] bpf, x86: add helper to emit kasan=
 checks in x86 JITed programs ---
commit 95547145be173ba9a87f9eff2492384b8ac25f18
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: add helper to emit kasan checks in x86 JITed programs

This commit adds emit_kasan_check(), which emits KASAN shadow memory checks
before memory accesses in JIT-compiled BPF programs. The helper calls stand=
ard
KASAN C functions to validate the memory accesses.

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
Is this static function used anywhere in this patch? It looks like it is
declared and defined but never referenced, which will cause a build failure
when compiled with -Werror=3Dunused-function.

Additionally, the HAVE_EBPF_JIT_KASAN Kconfig option does not appear to be
selected by any architecture in this series, making the feature unreachable.
(Also noting a potential issue where adjust_insn_aux_data() in
kernel/bpf/fixups.c may retain stale state when insn_off_in_patch =3D=3D -1=
).

> +#ifdef CONFIG_BPF_JIT_KASAN
> +	u32 bpf_size =3D BPF_SIZE(insn->code);
> +	s32 off =3D insn->off;

[ ... ]

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
Does skipping the save and restore of %r10 and %r11 violate the System V AB=
I?

While the commit message notes they are skipped to reduce overhead, %r10 is
mapped to BPF_REG_AX in the x86 JIT. Because standard C functions like the
KASAN helpers clobber caller-saved registers, wouldn't this corrupt the
BPF_REG_AX register (which is used for operations like blinded constant
stores) when the KASAN check is executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D4
