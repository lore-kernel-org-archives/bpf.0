Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE339EB73
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975279; cv=none; b=rJGxaefwBGTRuE/WOtlnV0aT97WG4Ryfy8qmo48pWCf60xx90gsO6eWR0QCjjuYhtL9IaIKWpIP0rKE16peIBoPY13898DdLkfEsYmORIXmV6bxQ8MKguzwPMEQu3MyKuEEvgbrTHrlTRbK8z2WITK5gdWpt72iD1796PUgfrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975279; c=relaxed/simple;
	bh=XSx8LFwNUq6IJuSvJOS2AQkQDprRPfOUZ6SxzYoe2PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hst/sVgG32BMxLdUk0dEzyv5S7cByrTLoMnV5DUad9dlHdnFpQd3RzRXWzaJssRDfoFR9aeZsqlp73f+Q857gREnosqEqZXgSGCfb9iLnEWrjaxZl92BCqDqSHc4bpAFxOyQXH5mA5D+IfsqICbhzLDSM6e+6gKszdI4nZBfwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPwxrs80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPwxrs80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F4D1F00A3A;
	Sat, 25 Jul 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975273;
	bh=sp4Wm87Vruxlp20e1dUYVIzkSUMXAtHrCwnwezBwEKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPwxrs80CN/6yU3QlDUFd7V5tnhDQu5rQS/vdHmv1RnUsRJaSJ4l/wLZs8WnTlrsu
	 OYIUPNbT/UqrErVUmrL5x5pl0Hh1+2/qoPko5XM6O0wDM/ejJF3xkAB8yDJ/oAw82C
	 koyjHq4WFTvWGP93sDDj9UQ57pcZu3b6UlG+FCMDMbiUqS3hwzJ1cFSmnasPsHvLt/
	 X9vMgaedsCGW2ROlgNdR3ysYpOT7rZRqjIv794E+257S96zue+7yBepSMR1XCtMzMy
	 ghADZbmiI1xzv/iP/4CJBruoFnys1WGG1EQINtpWp1h9G2bpk56q3aV5OFVaufLGCH
	 DW2jA9eTAMt9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/7] s390/bpf: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-3-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:27:53 +0000
Message-Id: <20260725102753.87F4D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a direct compilation error on s390 by declarin=
g and dereferencing an undefined struct `struct bpf_jit_data`.
--

--- Patch [2]: [PATCH bpf-next v2 2/7] s390/bpf: Fix memory leak in bpf_jit=
_free ---
commit 69c0bb88eff440919ad293e92f90d3f1f44abf60
Author: Pu Lehui <pulehui@huawei.com>

s390/bpf: Fix memory leak in bpf_jit_free

This commit implements a custom bpf_jit_free() for s390 to clean up leftover
jit_data when a subprogram fails to JIT, fixing a memory leak.

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index b60877478b45d..d9fdb32b7a96c 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
[ ... ]
> @@ -3106,3 +3106,22 @@ bool bpf_jit_inlines_helper_call(s32 imm)
>  		return false;
>  	}
>  }
> +
> +void bpf_jit_free(struct bpf_prog *fp)
> +{
> +	if (fp->jited) {
> +		struct bpf_jit_data *jit_data =3D fp->aux->jit_data;

[Severity: Low]
Does this code cause a build failure on s390?

It appears struct bpf_jit_data is undefined in this context, as the s390
architecture uses struct s390_jit_data instead.

This leads to a compiler error when trying to dereference it to access
jit_data->ctx.addrs below.

> +		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
> +
> +		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
> +		if (jit_data) {
> +			kvfree(jit_data->ctx.addrs);
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
770-1-pulehui@huaweicloud.com?part=3D2
