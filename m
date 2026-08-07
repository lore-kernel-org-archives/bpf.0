Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835A3CF68F
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106538; cv=none; b=n1VVhFH7C9duK82OIaHiiLAkUCd+KWcxdzVqSIGCIgHlJyUnpFD+hxcqgUZY3O6iU3MmPGp6tmMi+YIRdFYBpWY9QrfiIgTIniUdBxwSiM6HmfzFSCIvghtYavM5oluQy5ugrahc7WwA5F+qKDO7A5wSCZHcAPmJHrydd/pVE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106538; c=relaxed/simple;
	bh=hde7oAgGYAPwuXDoNn+zlDklBViJ8dG0sLsqt8XXmeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WuH9GXovIcSkjz4ZdegfaCXvl4mmzqWAjZU2BSrVfAjVaybfBeJeRvS8tApCNImlM6i9AyjEJ+DgUIXuhDacOgLzCoWO3JcUeMimpn0htc1C6saevcS0s+AYQQjaQB6yjTmRaRlEpRmTbqUQsRptWytreJb+CrKZLNQUI7u/IP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwBFxdLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwBFxdLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3461F000E9;
	Fri,  7 Aug 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106519;
	bh=zHBip2GgT26X8cx4T0ZM3zHoNeTGWmXXD0jdaIFVvJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwBFxdLxC/y2ZzjmPge2gwdlmFqx+mrgSCvX3aB5UMjX5aPCjfsS28c0r+ltslFML
	 56fR+WhkqvcMBjTVGI/oOdRzg5cAnrydUpcmtI8CmU4Qpv1AuoGNzHheOTob0vtO64
	 yEjD2O4+yGBIWhjBbMUNlW3tw/OYVSq13TgVL8uoz8kkLiXcW9pvkxgTPxZ6BNqVpn
	 Ku4l8acwjxpeLK68be7vKairtqBchfwzpp7rt5v4BDGpVAbOBUvuMEfk57y7IwHVEI
	 fYota6nlGDAZ8Apa9ViEj2zL2z0YzVEXagVJY5xn4rqmoOZCR3Vu5RSxsg7azwgJ2p
	 uREa8VPRplf+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/8] powerpc/bpf: fix buffer overflow in JIT for
 large BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <8c6611f4244c448766d04e90f8ea07bb1dd22dd8.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
 <8c6611f4244c448766d04e90f8ea07bb1dd22dd8.1786099877.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:41:58 +0000
Message-Id: <20260807124159.4E3461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent branch offset truncation in exception table fixup generatio=
n.
--

--- Patch [7]: [PATCH v11 7/8] powerpc/bpf: fix buffer overflow in JIT for =
large BPF programs ---
commit 575dc92c1d10e63b9fc1ecf052e4cace5279974f
Author: Abhishek Dubey <adubey@linux.ibm.com>
Subject: powerpc/bpf: fix buffer overflow in JIT for large BPF programs

This commit fixes a buffer overflow during JIT compilation of large BPF
programs on PowerPC. It addresses an issue where the exit address was
unpopulated in the first pass, skipping the epilogue size calculation and
causing a buffer overflow in subsequent passes when the real exit address
required a full inline epilogue. The patch updates the multi-pass logic to
loop until the program size converges.

Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.=
com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 757b36bfbac35..2cc1124ed5303 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -428,7 +446,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *i=
mage, u32 *fimage, int pass
>  	u32 *fixup;
> =20
>  	/* Populate extable entries only in the last pass */
> -	if (pass !=3D 2)
> +	if (pass < CODEGEN_MIN_PASSES)
>  		return 0;
> =20
>  	if (!fp->aux->extable ||

[Severity: High]
This is a pre-existing issue, but since this patch explicitly targets
support for large BPF programs (exceeding the 32MB branch range), does the
exception table fixup generation also need an out-of-range branch check?

Looking at bpf_add_extable_entry() just below this hunk:

    fixup[BPF_FIXUP_LEN - 1] =3D
        PPC_RAW_BRANCH((long)(pc + jmp_off) - (long)&fixup[BPF_FIXUP_LEN - =
1]);

Since PPC_RAW_BRANCH silently masks out-of-range offsets without returning
an error (unlike PPC_JMP which uses is_offset_in_branch_range()), could a
large BPF program with exception handlers result in a truncated branch
offset?

If a program has PROBE_MEM accesses and the offset between the fixup
routine and the main program exceeds 32MB, it seems the CPU might jump to
a corrupted address after handling the exception. Is it worth validating
the branch offset here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786099877.gi=
t.skb99@linux.ibm.com?part=3D7
