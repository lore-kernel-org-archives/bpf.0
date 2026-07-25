Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697803C73C1
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975378; cv=none; b=g6Jes5WTg44BxytZdmzyrqRN4Ogo82IYX+3G45VIUgOJGoGrLLv96+ZZhm3y+7QkZVd4BIAqM4GHjNIqzh88aM74jrDvFx4wQmkwe9Vj4AM2kd8NLR8egdjYHcOO44kvQpBRwzrqnd0GY5KdwNulwchDrWc9I1TrjiusUl3Nris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975378; c=relaxed/simple;
	bh=g6GqlJRGMSw+w5PeXuxzLi0h+cvwPchICQ83eSJbodE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tdnCj7q02drKix7muKBXn/VVzoPR/ViECcmFdaGcmWZSVKHVpebXpFhvO3dqvUL9MaL3UcK2OVezUgt9lGXw5u9ZJxTA8YlZIwM6QVOWUprjxIeUin4Ed7WpguBL2KOq3ItpV0myaSxcgg03em7a+CuZaEoiFr7MiV6WU/WMABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQBw3Ff1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQBw3Ff1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B06E1F000E9;
	Sat, 25 Jul 2026 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975375;
	bh=CqAqK+w3NohxpXNspTicw+xkTl/1ACwW18RDWT/S3NM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQBw3Ff1lKiUIjLjByTYBvHsqIn29xfrKZ5c84WCdo4amknRBsgc/nWwzC6buERun
	 xHbLmAT/cPOFFbK7Vc1w+UeJ8gOC7E0ATS+NB3dYahruoNAgWvttAbD2RT4OghziIr
	 LyuucXTlHF3D0zuwTyG0/kYOrKPkMFhoAmZ5qpPKCNVr2JJR4waSPY99oH8jIJ25ur
	 Nu9EpAf+vqJsJiLxa7zJ4qfwt4RDQERvU7dhMN2iS2DHOOyAl+eELAzoAAz/cLUFg/
	 0Co5bXi/kLJpAoZlCLHnSEJyIIObBuZNK9gI6wEtMEl+TLkne8//BMIpuyWgugq5VX
	 Wgrq8NaxoijDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/7] ARC, bpf: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-6-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-6-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:29:35 +0000
Message-Id: <20260725102935.7B06E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation failure due to missing semicolon and undefined struct t=
ype in `bpf_jit_free`.
--

--- Patch [5]: [PATCH bpf-next v2 5/7] ARC, bpf: Fix memory leak in bpf_jit=
_free ---
commit 40d714ef82bd5c9cd5f5fc752d7d4c925d1f6fe9
Author: Pu Lehui <pulehui@huawei.com>

ARC, bpf: Fix memory leak in bpf_jit_free

This patch implements a custom bpf_jit_free() for the ARC architecture.
It cleans up leftover jit_data when a subprogram fails to JIT, addressing
a memory leak that the generic bpf_jit_free() missed.

> diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
> index 639a2736f029e..45a700f42cd4b 100644
> --- a/arch/arc/net/bpf_jit_core.c
> +++ b/arch/arc/net/bpf_jit_core.c
[ ... ]
> @@ -1412,3 +1412,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
> =20
>  	return prog;
>  }
> +
> +void bpf_jit_free(struct bpf_prog *fp)
> +{
> +        if (fp->jited) {
> +		struct bpf_jit_data *jit_data =3D fp->aux->jit_data;

[Severity: Low]
Does this code cause a build failure? It appears that struct bpf_jit_data
is an undefined type in this context, and ARC uses struct arc_jit_data
for this purpose instead.

> +                struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
> +
> +		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
> +		if (jit_data) {
> +			kfree(jit_data->bpf2insn)

[Severity: Low]
Is there a missing semicolon at the end of this kfree() statement?

> +			kfree(jit_data);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725102020.2287=
770-1-pulehui@huaweicloud.com?part=3D5
