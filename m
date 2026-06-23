Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9143C4162
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253042; cv=none; b=HT9KZb/xoOgPgH1Wwg/xlziKhJfGMIvHALmyeM5vNJqP7H9Zt8UtiwZ85GZPSOHJnK3So95fFFqnKwPN0exe+pE8K38tQtRKQm4Rp6DoPIY8rrangmRt9S29+ZPk0uW2grD5g8dMr8Cs4BEr9aBjPjyKOUEmoRoNnPzxgjI1+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253042; c=relaxed/simple;
	bh=cB/9TvOGtIcnr/QUmdtz6pwmTmXuxwDXpRI3VsV3Y+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wd98Dpl3v2sTfPLUC420OYjxrwptBmB8Cle+oO4R+hsPBXFhZxoKt1akdE27p3BoujJVhHbeRXMlUkxL610YZqPUvul4w1xLK1LM/2Y3K8YFP0xJVBBWt9lomK+pLT6YH0QJHkHqhs6zD5iJmGKvCav+R/cRsL0XU6U40DiVVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An8JAzMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An8JAzMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619D11F000E9;
	Tue, 23 Jun 2026 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782253041;
	bh=AnGxf6pviNf4In3OIufxf5dwihai/wpjN+geUZI2TFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=An8JAzMq+YBL5IRmnDgZvRs0h4vZVM9KllMUrMH2ulgn97MeLPJd7XEl8IYHLNCz7
	 YZ1UJvY7gf25I+ecg3JzEa9J8LjRctvxT+hKQOXRZtr1B0ZBcDIFABR/nes5SGXhWj
	 A+wvBgj34L0gESh57ALjFqhQ21S2tF34KBV77nwhcz6DAZTfqoqR2KAirqN3Ekg5J6
	 Kmps+uEYelY/CfVQiaqkKwmFL2IMfyXLVBGhd8deSAtHzam9r/Av/2P5GMaeT+abVt
	 oFSsonsCr2RFUkhNdIzL4ZKXlJkIgWjvfO4i0/mdkBtzfJa+nRpksRgG/qUQwVmTc3
	 bPWFM/avQQ4Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v9 7/8] powerpc/bpf: fix buffer overflow in JIT for
 large BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623231411.6216-8-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
 <20260623231411.6216-8-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:17:20 +0000
Message-Id: <20260623221721.619D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stale exception table due to missing updates during additional JIT=
 passes, leading to kernel panic on BPF_PROBE_MEM.
- [Medium] Unratelimited error log on JIT convergence failure enables log s=
pam (Denial of Service).
--

commit b6894df59a3f875e5bd3f27ed0af4e32b5c00461
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix buffer overflow in JIT for large BPF programs

This commit fixes a buffer overflow in the PowerPC BPF JIT by ensuring
the pass-0 size calculation falls through to the epilogue when the exit
address is out of range. It converts the fixed two-pass code generation
into a loop that iterates up to CODEGEN_MAX_PASSES until the program size
converges.

Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.=
com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 7255d29f269bb..8396ff556f026 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -335,8 +335,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_veri=
fier_env *env, struct bpf_pr
>  	code_base =3D (u32 *)(image + FUNCTION_DESCR_SIZE);
>  	fcode_base =3D (u32 *)(fimage + FUNCTION_DESCR_SIZE);
> =20
> -	/* Code generation passes 1-2 */
> -	for (pass =3D 1; pass < 3; pass++) {
> +	/* Code generation passes 1-2+, loop until program size converges. */
> +	for (pass =3D 1; pass <=3D CODEGEN_MAX_PASSES; pass++) {
> +		u32 prev_proglen =3D proglen;
> +
>  		/* Now build the prologue, body code & epilogue for real. */
>  		cgctx.idx =3D 0;
>  		cgctx.alt_exit_addr =3D 0;

[Severity: High]
Does this loop need to reset cgctx.exentry_idx along with cgctx.idx?

Since CODEGEN_MAX_PASSES is now 3, the exception table could be populated
with stale instruction offsets if the JIT requires 3 passes.

Looking at bpf_add_extable_entry(), there is a hardcoded pass check:

bpf_add_extable_entry() {
        /* Populate extable entries only in the last pass */
        if (pass !=3D 2)
                return 0;
        ...
}

If the program takes 3 passes to converge, this would leave the exception
table populated exclusively during pass 2. During pass 3, instruction sizes
shrink and absolute offsets shift, leaving the exception table with stale
relative offsets.

When a page fault occurs on a valid BPF_PROBE_MEM, could the kernel fail to
find the matching exception table entry and panic?

>  		bpf_jit_build_prologue(code_base, &cgctx);
>  		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
>  				       extra_pass)) {
>  			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>  			bpf_jit_binary_pack_free(fhdr, hdr);
>  			goto out_err;
>  		}
> +		addrs[fp->len] =3D cgctx.idx * 4;
>  		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
> =20
> +		proglen =3D cgctx.idx * 4;
> +
>  		if (bpf_jit_enable > 1)
>  			pr_info("Pass %d: shrink =3D %d, seen =3D 0x%x\n", pass,
> -				proglen - (cgctx.idx * 4), cgctx.seen);
> +				prev_proglen - proglen, cgctx.seen);
> +
> +		/* Check if program size has converged, but ensure minimum passes */
> +		if (pass >=3D CODEGEN_MIN_PASSES && proglen =3D=3D prev_proglen)
> +			break;
> +
> +		if (pass =3D=3D CODEGEN_MAX_PASSES && proglen !=3D prev_proglen) {
> +			pr_err("BPF JIT: Program did not converge after %d passes\n",
> +								CODEGEN_MAX_PASSES);

[Severity: Medium]
Could this unconditional pr_err() cause log spam?

If a user loads a pathological BPF program that fails to converge, they
could repeatedly trigger this compilation failure and flood the kernel logs.

Should this use pr_err_ratelimited() instead, similar to other
user-triggerable JIT failures?

> +			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> +			bpf_jit_binary_pack_free(fhdr, hdr);
> +			goto out_err;
> +		}
>  	}
> =20
>  	if (bpf_jit_enable > 1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623231411.6216=
-1-adubey@linux.ibm.com?part=3D7
