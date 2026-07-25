Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507B3C4B63
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975372; cv=none; b=b8w/rU6eihGavJgJWn79pAzgT0h6i/ws7opYu0HdR2GkdS88HkkpnpNqvf3hwM+AQZHUESFpcjnKE66r6jBs+ArSe7H8GFSuPyldcxEZOV+CkGhJDa2Et/R0b+IGrDy9IyzMkn7flGZdvpamK9xk6VC8P6Gd8QsZqb2s3TRxDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975372; c=relaxed/simple;
	bh=jEfZWUmvgg/mCs9qSCN9vk77DpNfqdDGDUF7oakHbUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqTQHe+CW1ysHpZOeUCmShiTBpWFty+AY2XGYo+2e0sfgwX3ZNn4wTJcehUchdvP6IrGqw9yL5GqApMXIORokA9kFRMJOm8H/NSdUCx3mc/t9RGlCCSN69blQxxFTCE8uFbzHOVcBBARmZwRO+Y8TDorJEr6K1gCfdDuHzu2/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqHAqzWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqHAqzWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47251F000E9;
	Sat, 25 Jul 2026 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975370;
	bh=dscTKMCOXEUidoeIjYRrNmT+6vTNWUPEVEa1HvqTGzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqHAqzWiUUc+85LCDd/DvJcFyIzBBSigzOxpZy6FRJgJ4T4HXZ0JxspEUYxiwP3Dz
	 7pDGjGAicKyzt8tgKQMdjG0oBU/gmMaiq/7PZujBzOFAidNPLLnH4JzzmVzALYFWfx
	 Sbl7JiA54F/q1hFSBHgrwaKmNQC9H61cp0UBiKl/VRaNlSBvoeqgVne+hQMDrNLWlX
	 LZxE+TglvNAXJP3rRMTnyG0Nx0dRtTpGfJjGyWv8WWNIAzpk/09fC2z7gTbq9RgSlC
	 mUunqmYYtGOJWM2N+rkuNk967stYWFzvnBE89buAAlc8I0dOjoWq4+FP1lSGSpJtnA
	 Re+oH4Iw28KDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/7] bpf, sparc64: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-5-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:29:29 +0000
Message-Id: <20260725102929.E47251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces fatal compilation errors by dereferencing an u=
ndefined struct `struct bpf_jit_data` and calling an undeclared function `b=
pf_jit_binary_hdr`.
--

--- Patch [4]: [PATCH bpf-next v2 4/7] bpf, sparc64: Fix memory leak in bpf=
_jit_free ---
commit 85bc88f184eccb691d35e9449a95fcc1e9059dca
Author: Pu Lehui <pulehui@huawei.com>

bpf, sparc64: Fix memory leak in bpf_jit_free

If a subprogram fails to JIT in jit_subprogs(), previously JITed
subprograms are freed. However, the generic bpf_jit_free() fails to
free their leftover jit_data, causing a memory leak.

> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_co=
mp_64.c
> index 2fa0e93751276..3b72ff2dba9ce 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -1611,3 +1611,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
>  	}
>  	goto out_off;
>  }
> +
> +void bpf_jit_free(struct bpf_prog *fp)
> +{
> +	if (fp->jited) {
> +		struct bpf_jit_data *jit_data =3D fp->aux->jit_data;
> +		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);

[Severity: Low]
Does this code introduce a build regression for sparc64? The
architecture-specific struct appears to be struct sparc64_jit_data rather
than struct bpf_jit_data, which would cause an incomplete type error when
dereferencing jit_data->ctx.offset below.

Also, is bpf_jit_binary_hdr() available in this context? It appears to be a
static inline function defined locally in kernel/bpf/core.c, which would ca=
use
an implicit declaration error during compilation here in
arch/sparc/net/bpf_jit_comp_64.c.

> +
> +		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
> +		if (jit_data) {
> +			kfree(jit_data->ctx.offset);
> +			kfree(jit_data);
> +		}
> +
> +		bpf_jit_binary_free(hdr);
> +		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
> +	}
> +
> +	bpf_prog_unlock_free(fp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725102020.2287=
770-1-pulehui@huaweicloud.com?part=3D4
