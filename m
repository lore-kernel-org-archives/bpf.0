Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C05473C85
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104056; cv=none; b=YFJr43ghkSfseWnaLD2MwvL70PcUbtbOZxWa9kgKYvletyMfGJw0qvoP+DgfbG4D79vMPtttA2FMNW3s+J9OCEvKOIEJu5f9cRz6o/LeRGO5gt5WHSNDKZ+nApPs2L1m5QiT3K8tzaG/bW6Koe3VUzMLGO7xHhNgTmhTx2wu+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104056; c=relaxed/simple;
	bh=ftdTyPsscqtIlYr5PbB2P0WbPIgGWRqFgJUfiZq4qJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSxvxmY3QUH9KteSGPdOiZTc7SkW9dSR7MPxcoejtA8SlwPE+6j5WdOk/YZTyKES4QWKXX3Zj8sBMQcsAcv4A9boWjHP121x+ZIHAJNc6xTMo93o7ZwqaNrqPP6bPmDuW+qjUkP/+gW8VMhysk6OKwv5ddMWfAbSpas14hT5p6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R03/FVOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R03/FVOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F01D1F00A3A;
	Fri,  7 Aug 2026 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786104039;
	bh=ATYaES3H7LJPj+NFBnX29IOVLT8bKz5zqlPTk47oRCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R03/FVOZzMzD6eQRYbXCqxsp5YkJn/W9qMQuu7q5qf13NSSpSnF+YFUfZQhqzHa/x
	 kA+WYNgF4gEwcJOzeYZ3XGKpDRQxvOBe2IUWdoWBtB28ypO5liKP2vbnGM01vyw1Q1
	 9I4QsNuQvoLSlJUO4w5Jt8I/LKAO6nKz0JzrtTUJk6ABiKtfpOuLhKyXpxR5WQeBeB
	 sF++11yklN7q1WSvXAz66uHopSJVjJBUx/gDMfTgKxlpn+HYkr/LCRmX/6AGTnwu83
	 zmv+7Yb/DYjPLTslEgaz1VP7jx55Mrbromki0XX2A2h55j/Q1KOfvyX+uHLpy9Kud+
	 xrA+hZ18Bq6rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/8] powerpc/bpf: fix alignment of long branch
 trampoline address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <27ec08c30f6c37b3f25ba735f9cd7f81ff9e98d5.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
 <27ec08c30f6c37b3f25ba735f9cd7f81ff9e98d5.1786099877.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:00:38 +0000
Message-Id: <20260807120039.6F01D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Dynamic epilogue sizing breaks JIT pass convergence, causing BPF_E=
XIT branches to skip the first instruction of the epilogue.
- [Low] The patch introduces a compilation error in `arch/powerpc/net/bpf_j=
it_comp32.c` by failing to remove the old 4-argument call to `bpf_jit_emit_=
exit_insn()`.

Pre-existing issues:
- [Critical] Out-of-bounds write in BPF JIT due to under-calculated allocat=
ion size for large programs.
--

--- Patch [1]: [PATCH v11 1/8] powerpc/bpf: fix alignment of long branch tr=
ampoline address ---
commit a15c5c8b15ef787442dd6c60c0e42163a958cb5a
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix alignment of long branch trampoline address

This patch ensures the dummy trampoline address field between the out-of-li=
ne
stub and the long branch stub is 8-byte aligned. It modifies the epilogue a=
nd
fentry stub building functions to accept the final image pointer and emit a
conditional NOP if needed.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 7b07b43575f11..f2e0f9755e653 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
[ ... ]
> @@ -49,11 +49,39 @@ asm (
>  "	.popsection				;"
>  );
> =20
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_stub_sz;
> =20
>  	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * dummy_tramp_addr must be 8-byte aligned for load-register
> +	 * compatibility. The fimage can be non 8-byte aligned, so final
> +	 * alignment depends on start of fimage and the stub's instruction
> +	 * count offset. The OOL stub size is 4 instructions (with
> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> +	 * before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if (ctx->idx + ool_stub_sz) is odd, so that
> +	 * dummy_tramp_addr lands at an even instruction offset (=3D=3D 8-byte
> +	 * aligned from an 8-byte aligned base).
> +	 *
> +	 * In pass=3D0 when image=3D=3DNULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_stub_sz =3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub=
_sz, SZL))
> +		EMIT(PPC_RAW_NOP());
> +

[Severity: High]
Does this conditional NOP break the JIT convergence loop in
bpf_int_jit_compile()?

If the body size shrinks by an odd number of instructions in the final JIT
pass, this could flip the alignment and cause an extra padding NOP to be
emitted.

This would increase the epilogue size by 4 bytes while the total proglen
remains constant. Could this cause the JIT loop to terminate prematurely wh=
ile
exit_addr still points to the old epilogue start, skipping the first
instruction of the epilogue and potentially leading to register corruption?

>  	/*
> -	 *      nop     // optional, for alignment of dummy_tramp_addr
[ ... ]
> @@ -97,7 +126,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct cod=
egen_context *ctx)
>  	}
>  }
> =20
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int =
tmp_reg, long exit_addr)
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_conte=
xt *ctx,
> +							int tmp_reg, long exit_addr)
>  {
>  	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))=
) {

[Severity: Critical]
This is a pre-existing issue, but does the !exit_addr condition falsely
report large branches as in-range during Pass 0?

In bpf_int_jit_compile(), the true epilogue offset is populated after the
second Pass 0 loop, meaning during all Pass 0 execution, exit_addr is
evaluated as 0. This bypasses the branch range evaluation and falsely
predicts only 4 bytes per BPF_EXIT.

When exit_addr is resolved in Pass 1 for large programs (>32MB) that exceed
the branch range, could this cause an under-calculated allocation size,
leading to an out-of-bounds write when the inline epilogue is emitted?

>  		PPC_JMP(exit_addr);
[ ... ]
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit=
_comp32.c
> index bfdc50740da8e..1cf12edf0343f 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
[ ... ]
> @@ -1150,6 +1150,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *im=
age, u32 *fimage, struct code
>  			 */
>  			if (i !=3D flen - 1) {
>  				ret =3D bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
> +				ret =3D bpf_jit_emit_exit_insn(image, fimage,
> +								ctx, _R0, exit_addr);
>  				if (ret)
>  					return ret;
>  			}

[Severity: Low]
Is the old 4-argument call to bpf_jit_emit_exit_insn() accidentally left he=
re?

Leaving this intact right above the newly added 5-argument call appears to
directly break the build on 32-bit PowerPC architectures due to too few
arguments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786099877.gi=
t.skb99@linux.ibm.com?part=3D1
