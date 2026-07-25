Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DD39EB73
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975287; cv=none; b=NCXY9Y9VxD/HvbPQH4AVeVdwZ+QbE/7JeUyKx38p3fSHYdJuLZJ3nzyZJPHNUdcuORU90rwImRe0W2J8P5JBf4fr/vVglmSVhabCID3IwwvuAIWObAQEJrRMWLvflWC4PU55M9enWjvvdqEhBWDeHP5mJxjy1pOdqduzjPaBgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975287; c=relaxed/simple;
	bh=yc5kOG3CooxdUpSK8Q/lkrKryx5vU/wc05MbVr7t9kQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+SGgbxy+pVcBk9yhTLywEIDRcuQGz9IZ11hmXZE8Fj+EoDStQn0xbHGlJfuSvkHi6cC4+Nnc4/+GDiSlDz1CegBJEZg+FeykiKvk+YCzDcUXir/FGQ4jnW7ReFp+jYXA7xBBPH31FPeJ/1T7dbGDiLgcIvaJPf3bSZsPkmP4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2BYgBk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2BYgBk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3385E1F000E9;
	Sat, 25 Jul 2026 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975284;
	bh=/UPALSNU5u2YEKzwyc38hXNmUtNrSCp02t1laTz5jVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2BYgBk37/O1Lj1wLdmoIFI7NYrGVXwDC+bwgNXczcYiRtivC8LOgknEOTv5hmUe5
	 YBrRztrXSTbzn+MmoxMeYr11tQGqLgsp+JwJ4npaqEeSW61hy/FjiAZz8LFgCBZHa5
	 1AdKrW3gXyMDFbZibDiatAptlOEKShnLSw+LI4HmFoIGPQiX/nZBQ7lSbX0/Dq5FIW
	 hOH/I5ORu83QNJ9AaJhgdDepYz0X3ndeErLcIc34cUKSYvirbklm3NbUYw1OtwXLxZ
	 PWTIV61rvZ0HTHl7h8AgYwHVs4x6mwbmRbr6pl1+cj4bIfAn0H/jCXiHVEwSkxzlOD
	 WuIJgFbnIQ0Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/7] parisc: Fix memory leak in bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-4-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:28:03 +0000
Message-Id: <20260725102804.3385E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a build failure due to the use of an incomplet=
e type (`struct bpf_jit_data`) and an undeclared static inline function (`b=
pf_jit_binary_hdr`).
--

--- Patch [3]: [PATCH bpf-next v2 3/7] parisc: Fix memory leak in bpf_jit_f=
ree ---
commit 8b0b5655843da846b247fa021046070e5875f56c
Author: Pu Lehui <pulehui@huawei.com>

parisc: Fix memory leak in bpf_jit_free

This commit implements a custom bpf_jit_free() for the parisc architecture
to free leftover JIT data when a subprogram fails to JIT.

> diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_cor=
e.c
> index 172770132440d..11e13ad6bc509 100644
> --- a/arch/parisc/net/bpf_jit_core.c
> +++ b/arch/parisc/net/bpf_jit_core.c
> @@ -178,6 +178,25 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_veri=
fier_env *env, struct bpf_pr
>  	goto out_offset;
>  }
> =20
> +void bpf_jit_free(struct bpf_prog *fp)
> +{
> +	if (fp->jited) {
> +		struct bpf_jit_data *jit_data =3D fp->aux->jit_data;
> +		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
> +
> +		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
> +		if (jit_data) {
> +			kfree(jit_data->ctx.offset);

[Severity: Low]
Will this cause a build failure on parisc?

It looks like struct bpf_jit_data is an incomplete type not defined anywhere
in the kernel, and the correct type used elsewhere in this file is struct
hppa_jit_data.

Additionally, is it possible to call bpf_jit_binary_hdr() here? It appears
to be a static inline function local to kernel/bpf/core.c and is not export=
ed.

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
770-1-pulehui@huaweicloud.com?part=3D3
