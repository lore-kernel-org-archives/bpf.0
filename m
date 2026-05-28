Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59E324B2D
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007836; cv=none; b=Ypr045rW12KPT2wpyXRQeRcQp0BMAF1PjLwb+vmu3WSbDRoesuXAj0uyOjO4jxwE2GrUb2fvsXtn/qzSaodc3eq46hkdeSucXP6OCVdz8xFsqVorzeHXhJDOm3VjWDGUHivR4aESfdy7SX0udEDdIuqtTpMpGIKRbci/kSx6o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007836; c=relaxed/simple;
	bh=xOMkUfDI5WBiRLonTXc8juh1iEHJN2M67njKbqr5ebg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUrOuRBsTEblBNBjzhhk4rpbA65PEhN8Qc6+ErM50wJddm9f++KKGlRm1nx+7367dIcPTG5gpQA+aColGPf4BAeSErqEJG1emCkM+uM7qvoWszRfw0hr+apmTEqiN4CdGKlUpOmx8nBpkZ1sTe56Z3buhQ/17P1+wfdVsobcl1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVgYObjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVgYObjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3621F000E9;
	Thu, 28 May 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780007835;
	bh=rfY0ioYTOSgNEHwOZBELS99YZYxUFsFKAOHgri8TUfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVgYObjEzxKAFGJaDYKF9wY9JFb2D8nYdfHCWZ5IJ1qcWw8Tq9/lZ+JabQGQJM3DI
	 7Ee+oLI09DBV4Qg3C3su5QONyr//cJft2RwTuVQlaqcxNDGhx6TuM2IFOBWzP497qn
	 eUGz3X6XLirwtTeXE8D5+1kn0+jraxIgK0yXqUc4qQ8jwjawcoLaMuq9UqofXfCwjg
	 MZu0eA52sF8jqqLgQ5Mz0e76bykNAoWfwmlnhrS4s3cmjsPlKqTQrEQsQ1cve/yygR
	 /p3qK/oHdF0bj2NVjI1AK8DIjm5LN0wiHHzuIebBsmCf3gANMAK4zqdONc4DDqLu1I
	 xwCaiLOsrsMRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] powerpc/bpf: fix alignment of long branch
 trampoline address
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529015855.364704-2-adubey@linux.ibm.com>
References: <20260529015855.364704-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 22:37:13 +0000
Message-Id: <20260528223715.0D3621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch fails to pass `fimage` to `bpf_jit_emit_exit_insn()`, =
passing `NULL` to `bpf_jit_build_epilogue()` instead, which incorrectly cal=
culates alignment for the alternate exit stub and causes an unaligned memor=
y store.
- [Low] The alignment fix unconditionally forces 8-byte alignment on 32-bit=
 PowerPC architectures where it is unnecessary.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a pre-existing h=
eap buffer overflow occurs during JIT compilation of large BPF programs due=
 to uncounted inline epilogues.
--

commit 95a864e2af236591e1cc0108bc8a4e322e47431e
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix alignment of long branch trampoline address

This patch ensures the dummy trampoline address field between the OOL stub
and the long branch stub is 8-byte aligned for memory compatibility when
loaded to a register.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 53ab97ad60745..3492d82d147f3 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
[ ... ]
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_instrs;
> =20
>  	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
[ ... ]
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_instrs =3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4*4 : 3*4;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_inst=
rs, 8))
> +		EMIT(PPC_RAW_NOP());

[Severity: Low]
Does this unconditionally force 8-byte alignment on 32-bit PowerPC
architectures where it is unnecessary?

While 8-byte alignment is necessary on PPC64 where dummy_tramp_addr is load=
ed
as an 8-byte doubleword, unsigned long is only 4 bytes on PPC32.

Because the JIT buffer consists of u32 words, 4-byte alignment is inherently
guaranteed. By forcing 8-byte alignment on PPC32, this emits unnecessary
padding NOPs. Should the alignment check logically depend on SZL?

[ ... ]
> @@ -107,7 +136,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen=
_context *ctx, int tmp_reg,
>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr =3D ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);

[Severity: High]
This is a pre-existing issue, but does this lead to a heap buffer overflow
during JIT compilation of large BPF programs?

During the JIT size calculation pass 0, addrs[fp->len] is not yet populated,
so exit_addr evaluates to 0. Consequently, bpf_jit_emit_exit_insn() skips
generating the alternate inline epilogue and unconditionally emits a short
branch via PPC_JMP(0), meaning the alternate epilogue size is unaccounted f=
or.

During final passes, if a BPF program exceeds the 32MB branch range,
bpf_jit_emit_exit_insn() generates a full alternate epilogue inline. Because
alloclen did not account for these additional instructions, the JIT compiler
could write past the end of the allocated buffer, potentially corrupting
adjacent packed BPF programs.

[Severity: Medium]
Could passing NULL as fimage here cause an unaligned memory store?

During passes 1 and 2, image is non-NULL, so the alignment check=20
!IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_instrs, 8) evaluates
using fimage =3D=3D 0.

Since the actual read-only memory base (fcode_base) is only guaranteed to be
4-byte aligned via bpf_jit_binary_pack_alloc(), assuming it is 8-byte align=
ed
leads to incorrect padding.

If fcode_base is 4 mod 8, the padding logic behaves inversely, deliberately
misaligning dummy_tramp_addr in the final image and triggering an unaligned
8-byte memory store.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529015855.3647=
04-1-adubey@linux.ibm.com?part=3D1
