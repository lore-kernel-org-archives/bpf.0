Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473936657B
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994866; cv=none; b=letyxFQ0HXbhZPUMWf5tdzTxpTmph+omuuqbHLJJkZgFo1AmmcR8XOq0k9cjiUka/rG60HcrBkFqHpOZxbEMsVRryTn82hcQsln2jAzU3bUmHwhFsNoDWoq2/NCzMF6+HzqAT5qYsnP4CejykxhEGD/MdoVXP047rd9FI25R5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994866; c=relaxed/simple;
	bh=X2vp4DiJeWhVw0iBB3Hbv9Npzu96Ue1EPRCLQhAyF8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMoYvLWuTdCZ3vafUlUdaEyC+89g89+3S32iLnR6E+lhfRAxltUmnoGhox3NxT85B+9vzUJpsERqB2cGb6ihoBdoVFY5fS/pbgGNWwexU98Avv/ddAV6z28OyZEarPgJCke6JgO/aRteGln1dF1SCNf1Op6KBS54w5x9dbP5L30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZwQ0EPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZwQ0EPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7DC1F000E9;
	Sat, 25 Jul 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994859;
	bh=GYW8Wedqp/TZBjiOjhPACRiZf77maKlAoP9WGzgDABM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZwQ0EPJoj9gpfKubf9sjcDWbWlhnKvbzVFsOxKkiSO4G8tl8vnDqJQS5hbo59SJj
	 E3hgtprsZs3hYbG49IQCWTRXlclZ+VcQCFUX09ajg+qxCKLA04LU/ObCGdHNVBJyTA
	 cgnkRvFEQXpEZd442DGWJgWLYYCTR82BESovBrwCS2VN5Wu5hDzhmr4TNmkk2oMn8w
	 KmfkOaLGXX9l9jI0joEmHq2H0wXe4+1Hc4VfIGOKTdUG8CDZROqsrhVn7AhcDmd/Gq
	 2aZLVFxkwBEuS9hfjOlnBgCYqPYocSg10OF9vjRBcENHEFJPnt09HcitKjq3AusD3W
	 5yEVazZiV0naw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/9] parisc: Fix memory leak in bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725154915.2488611-4-pulehui@huaweicloud.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:54:18 +0000
Message-Id: <20260725155419.4B7DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak of the allocated JIT image (`jit_data->he=
ader`) in `bpf_int_jit_compile()` if `build_body()` fails during an iterati=
on after the image is allocated.
--

--- Patch [3]: [PATCH bpf-next v3 3/9] parisc: Fix memory leak in bpf_jit_f=
ree ---
commit 91fdce2769b7bfc645bd4e9356cd152dd1568159
Author: Pu Lehui <pulehui@huawei.com>

parisc: Fix memory leak in bpf_jit_free

If a subprogram fails to JIT in jit_subprogs(), previously JITed
subprograms are freed. However, the generic bpf_jit_free() fails to
free their leftover jit_data, causing a memory leak.

> diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_cor=
e.c
> index 172770132440d..ef63c38bdf151 100644
> --- a/arch/parisc/net/bpf_jit_core.c
> +++ b/arch/parisc/net/bpf_jit_core.c
> @@ -178,6 +178,25 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_veri=
fier_env *env, struct bpf_pr
>  	goto out_offset;
>  }

[Severity: High]
This is a pre-existing issue, but does bpf_int_jit_compile() leak
jit_data->header on some error paths?

Looking at bpf_int_jit_compile(), if build_body() fails during an iteration
after the image is allocated:

	for (i =3D 0; i < NR_JIT_ITERATIONS; i++) {
		...
		if (build_body(ctx, extra_pass, ctx->offset))
			goto out_err;
		...
		if (ctx->ninsns =3D=3D prev_ninsns) {
			if (jit_data->header)
				break;
			...
			jit_data->header =3D bpf_jit_binary_alloc(...);

The code jumps to out_err, which falls through to out_offset (seen above):

out_err:
	if (extra_pass) {
		...
	}
	goto out_offset;

However, the out_offset cleanup block only frees ctx->offset and jit_data,
and skips freeing the already allocated jit_data->header:

out_offset:
		kfree(ctx->offset);
		kfree(jit_data);
		prog->aux->jit_data =3D NULL;

Could this lead to a memory leak of the JIT image buffer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725154915.2488=
611-1-pulehui@huaweicloud.com?part=3D3
