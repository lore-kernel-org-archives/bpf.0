Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084530594E
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910612; cv=none; b=reDER2MKgWUCA2MYqMU+zcmdrtZ5EEOwnB2598G+TtnIqwZVtwqdCVIi5neVd2LvXuzc7Mwub1qht+Lzwa+hJJJgCTdxgw9PDIOuvlk2tVKyUCO6gJTEZ6nynDfdK0yMzYKNWCl0SEfJ+nz8FIFIR9F4avV7284GhZI6NiD79E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910612; c=relaxed/simple;
	bh=wgrhph9+BoqEgyjrY4eLAxFU8pPYKzcPIW4ImfIwfR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZMazFbjpT8vzm+XSeCebMov3cCWO2vkSOXtfRS+wSXCU0KLT/G+0Yqi5ImIcH3LvFxMkPjbe0NyIyd//MyeGbxDBw5Ag0z1eiFKuN5fdLip6A4Fs9CLAnWlTnorEH3mCR5iXRjrS+/K7Nsyj2FkkeUIBpKi/x8SXsQjvUT3pUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuWZgr16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuWZgr16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390E71F00A3A;
	Wed,  5 Aug 2026 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910611;
	bh=0/B170ShITvZQ/7hyf5ldAoWqk3mwjO1BIcij1wIJK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuWZgr16xPW7/YCfLIhcljImBsnZsnFc22EV4Mex3UhuP6eo5tZr5RarGZ+SE8kx3
	 XHS4/kwgxH4Y3G/02GSdn9deJJeUWAGXlMV8m02x2m9p5mDXIoiRSFjkSbxocKBGhT
	 PWva1+Z8ZuQ5jCAcVqqLEDPMD/yhjVXL4TCmL9kXaOBoAVEV2f8izYvwdoptOgeXym
	 DPFHqK+euD57hcOqdklP5bNg/J4Kr5SRnCbzRQMapW6sarj0rFyvLdgU1kjQ5m/VqI
	 jnZ3Fic0oxbYStfNbBlXAb4ZTZnu711SmWnw2O74YvrGwFNz4gv7Y6oLmNIUBBCtuF
	 3+gR00s+Tatow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/8] powerpc/bpf: fix buffer overflow in JIT for
 large BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:16:50 +0000
Message-Id: <20260805061651.390E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inverted pass condition in `bpf_add_extable_entry()` causes JIT co=
mpilation failure and stale exception tables.
--

--- Patch [7]: [PATCH v10 7/8] powerpc/bpf: fix buffer overflow in JIT for =
large BPF programs ---
commit 7c6fc2cfb9f061eb19bae10ea234d06c7a76903c
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix buffer overflow in JIT for large BPF programs

This commit modifies the code-generation loop to iterate until the program =
size
converges, bounded by CODEGEN_MAX_PASSES, to prevent buffer overflows durin=
g JIT=20
compilation of large BPF programs. It also ensures exit_addr is non-zero be=
fore=20
treating it as in-range and resets alt_exit_addr before subsequent passes.

Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.=
com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 8be5ded13a4a6..3c20bb13cfd70 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -428,7 +446,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *i=
mage, u32 *fimage, int pass
>  	u32 *fixup;
> =20
>  	/* Populate extable entries only in the last pass */
> -	if (pass !=3D 2)
> +	if (pass >=3D CODEGEN_MIN_PASSES)
>  		return 0;
> =20
>  	if (!fp->aux->extable ||

[Severity: High]
Does this accidentally invert the logic for populating the exception table?

The comment says to populate extable entries only in the last pass, but ret=
urning 0
when pass >=3D CODEGEN_MIN_PASSES means it will skip the final code generat=
ion passes
and instead execute during the early passes.

During the scouting pass 0 in bpf_int_jit_compile(), pass >=3D CODEGEN_MIN_=
PASSES
evaluates to false, causing it to fall through. Since the exception table
is not yet allocated at this stage, bpf_add_extable_entry() returns -EINVAL
and unconditionally fails JIT compilation for any BPF program with exceptio=
ns.

Additionally, for programs taking the extra_pass path, this would cause the=
 extable
population to be skipped during the final passes. Because instructions can =
shrink=20
between passes, this might leave stale extable offsets that point to incorr=
ect=20
locations, which could trigger a kernel panic during unhandled page faults.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785906979.gi=
t.skb99@linux.ibm.com?part=3D7
