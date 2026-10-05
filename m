Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1141A77C
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211189; cv=none; b=m0/FJO0+2I328tq10Xroql9h3MgiJZkFwfFTPCKVmGY2lyZH249/oDEZ7/YgCsXI8WJRWrb7OPuzTtQeuQaBg1RpVmlPyZ7L/AZhHAGpizem+FTXTvNJEZrZ055ihGP/iQpQrniGs8He6xdiGg+V6oomzfgLXzo+Cq6JqYHeYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211189; c=relaxed/simple;
	bh=lK7/RYZUoU0KB1Ud2KqZUPaPgxxO18/qwVDDLBQqDyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pp5bUX+zPOkB/SEzO64So52kiuvaRQdxJ9SWSd6Wy0NtyaLwLSJHjUQzuKbOV/ejgFBbdzk3flZxTd9MHJwMUmXnY7Fg8GASYatU6tU94iBVLajBQAjwTa39eLaT+PrDY71ABSd8oCSzyq6gJ7xA77UHOxkyaHzc6io28ldiSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtkxU4jN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtkxU4jN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533901F00893;
	Mon,  5 Oct 2026 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211176;
	bh=pC/oCmml29ePsfgqPrksGojc/KDKy3Bk7XdtJOEMkPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtkxU4jN4cRD/DSliZUVPRLclPmzBRq4Fv2QCSttsegD0+PDopN/6PzkzBnqdxCxO
	 uRjxx+cNZIET5hctGG2vzuYfVw/YHxRkvySF/C+h0QIXa3IL5xduWfHdmY5zDXUzXj
	 j1fyTFpBpSoDftJ56F3AYF7f3p9fLmPXC5Nf2mw8l5QANZKnYhdYqeK9VJaf//tzpZ
	 fIxOziciXqyOxxzeKcoYbEc7h/gqysVkmxIWgnduXxWTQrLBxSa2qyGTCVCdFWPnW/
	 FfXoHaRuDTvaMILq+BK3fBVkihZJ0479CH6C9fIAJXZT4pdtrkrTOAMFvaQETvOwPy
	 BePuO1g/6x8Ng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 4/7] bpf: Add kfuncs with bodies for common
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yusheng Zheng" <yunwei356@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005142219.33451-5-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
 <20261005142219.33451-5-yunwei356@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:39:35 +0000
Message-Id: <20261005143936.533901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_extract64 lacks bounds checking, leading to UB and inco=
rrect results
--

commit 585ec9b342241a745cc98fb7ad012ebceacf697c
Author: Yusheng Zheng <yunwei356@gmail.com>

bpf: Add kfuncs with bodies for common operations

This commit adds kfuncs with bodies for common operation families, including
bpf_extract64 for bit field extraction. They are placed in
kernel/bpf/insn_kfuncs/ and can be inlined by the x86-64 JIT.

[1] https://arxiv.org/abs/2606.24213

> diff --git a/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c b/kernel/bpf/insn_k=
funcs/bpf_insn_kfuncs.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c

[ ... ]

> +__bpf_kfunc u64 bpf_select64(u64 cond, u64 a, u64 b)
> +{
> +	return cond ? a : b;
> +}
> +
> +__bpf_kfunc u64 bpf_extract64(u64 x, u32 start__k, u32 len__k)
> +{
> +	return x << (64 - start__k - len__k) >> (64 - len__k);
> +}

[Severity: Medium]
Will this shift operation cause undefined behavior when len__k is 0 or when
start__k + len__k is greater than 64?

In C, shifting a 64-bit value by 64 or more is undefined behavior. For
example, when len__k is 0, 64 - len__k evaluates to 64. Even when this is
masked by the architecture or BPF semantics, a zero-length extract might
incorrectly return the unmasked value instead of 0, and out-of-bounds
extracts could return garbage.

> +
> +__bpf_kfunc u64 bpf_load_be64(const void *p, s32 off__k)
> +{

[ ... ]

> +/* the jump lands within the body, here on its last instruction */
> +static const struct bpf_insn select64_body[] =3D {
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
> +	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
> +};
> +
> +/* x << (64 - start - len) >> (64 - len) */
> +static const struct bpf_insn extract64_body[] =3D {
> +	BPF_MOV32_IMM(BPF_REG_4, 64),
> +	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_2),
> +	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_3),
> +	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> +	BPF_ALU64_REG(BPF_LSH, BPF_REG_0, BPF_REG_4),
> +	BPF_MOV32_IMM(BPF_REG_4, 64),
> +	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_3),
> +	BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_4),
> +};

[Severity: Medium]
Does this BPF body also lack bounds checking for the extraction lengths?

If a BPF program calls bpf_extract64 with invalid arguments and falls back
to these BPF instructions, this logic mimics the C code above. This appears
to mask a shift of 64 down to 0, which would return an incorrect non-zero
value for 0-length extracts instead of 0.

> +
> +/* the offset is an s32 */
> +static const struct bpf_insn load_be64_body[] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005142219.3345=
1-1-yunwei356@gmail.com?part=3D4
