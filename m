Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE0846A
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029258; cv=none; b=oYcP8DHLK5gz2UICf58gibD751X8lyNfRRCAIVijGh5y1I5ajHy+sgUE8BzjmRgfAIgmyZSRjSL+h5nLJoVn17Nk7KSGjOTlB82rgFRxPnP6fAHeJP3Trv+BO0gxtphmdJbSAdhUl1d5pALnE8Ek3+PcVOTjrsh/457qzznSstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029258; c=relaxed/simple;
	bh=sqETVgVrVL9XLsmQfZzAkuZDecE+KFE68uKWjYjDb+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pr+nTLpA1F/moZ0Jt6mWdnz3k6AGrQLIJyPx9/YKxufktJNpOrKByw2M3f1HU55HhOt5hj5T2hQRfFc3lYWYIFZAKe/4oIvv75F6Clj7+QF2KuhTJnwLT3S5oZEBx//TQch/lFvPhxvaphLV9aAYVn9Zfkgex7k3Yofs8ejmVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjNCqAJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjNCqAJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1811F000E9;
	Tue, 18 Aug 2026 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787029256;
	bh=Ztb6wwK6/xNyraziJIRsZSuv/t/KjBXfgmFl4ySAK48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjNCqAJMe/9QQ0WQahzQ9BLm+Jibu7iK0S6gdHl8NQUzQ46iqMs+Ir8qIB93sMBZh
	 T6Gq9jQvR4esZD4PPPr4oLsG2FE3iBT3d5OE9NOpo1J/GDKpQI+PQvMwBFmk9prZwU
	 EJvBcSz7OVQ0hGyjaKSBfulOGPBZclpPoAabphx9qt7X4ygHMGyS3ZDlojkXlL+MeQ
	 9D3zhvZDA18y106U2feKkmSa4+DZpBiVQJjurWrRPZ9nIfOGhqTalXx9XFrSfk7glc
	 UeMhV87UbbfXhgegGlFp7m2IlLoxReO/60aaR1cqQLPX1ZcweQDt5PVlFUK0ed3iYh
	 Enqtr9C90TtfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/8] powerpc/bpf: fix buffer overflow in JIT for
 large BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <191961a8100f3656a01ab826a02d43c765d02464.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
 <191961a8100f3656a01ab826a02d43c765d02464.1787027080.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 05:00:56 +0000
Message-Id: <20260818050056.AC1811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_jit_binary_pack_finalize leaks modmem charge and uses uninitia=
lized size on error path.
--

--- Patch [1]: [PATCH v12 1/8] powerpc/bpf: fix buffer overflow in JIT for =
large BPF programs ---
commit 86d46c787bf7b94485f88f3d4dc3220927360140
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix buffer overflow in JIT for large BPF programs

This patch fixes a buffer overflow in the PowerPC BPF JIT compiler
caused by incorrect handling of exit_addr during pass-0 size calculation.
It ensures the epilogue instructions are conservatively accounted for
in the initial allocation and iterates the code-generation loop until
the program size converges.

Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.=
com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 7b07b43575f11..8bee2674d4a90 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -306,10 +306,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
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
> +		cgctx.exentry_idx =3D 0;
>  		cgctx.alt_exit_addr =3D 0;
>  		bpf_jit_build_prologue(code_base, &cgctx);
>  		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
> @@ -318,11 +321,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  			bpf_jit_binary_pack_free(fhdr, hdr);
>  			goto out_err;
>  		}
> +		addrs[fp->len] =3D cgctx.idx * 4;
>  		bpf_jit_build_epilogue(code_base, &cgctx);
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
> +			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> +			bpf_jit_binary_pack_free(fhdr, hdr);
> +			goto out_err;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but since we are touching the JIT
error paths here, I noticed a potential leak in bpf_jit_binary_pack_finaliz=
e().

Does the error path in kernel/bpf/core.c:bpf_jit_binary_pack_finalize() leak
the global JIT memory charge?

When bpf_arch_text_copy() fails, the error path cleans up the memory
allocations but appears to completely omit the corresponding
bpf_jit_uncharge_modmem() call:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
	...
	kvfree(rw_header);

	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
	...
}

Additionally, could ro_header->size be uninitialized if bpf_arch_text_copy()
fails early, potentially causing bpf_prog_pack_free() to corrupt the
pack bitmap?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787027080.gi=
t.skb99@linux.ibm.com?part=3D1
