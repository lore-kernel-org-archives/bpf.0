Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95779485502
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710640; cv=none; b=JY5yxsUmRmsIqtB9OnBRmprjjpWPoQGCOFXlvW94ppV1fBH/BaWU+qqmgL+mNHDDz4ErfhvKrmXHeg0R0vgptp5jq4DrLT6Tc52sKu1KQNoLMsyvKOEW9KAJPRnM+XrsSLWoNSPhzeaSDk3zWwlcRxMK//IWDDaK3zJgl1Nfg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710640; c=relaxed/simple;
	bh=XBeWTEDuc8LsaiJo6RtFTUD9LD6sSjhTxxDso//8nY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQURJh54NHUHhjOunoYAHSH4zI2EwV3tPbmyjpJ7XzV+f7VbgFXXn6SWsyVo/hedXcIPpkgMLzv/1HWLhK2wVppHwNrWBCQ6YhvZyszDt88M2et814DhRBDnUujkxmv/mf19Ju8NZR+2QKODyEwD7t65wxu9bBgGpAAzJqbupoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDSqMJAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDSqMJAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4AE1F000FF;
	Fri, 18 Sep 2026 05:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710638;
	bh=NY2io/8sQ8uJgu7TCUddGsJBTCHl38lhabLqccmyaNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDSqMJAtKMMED6pEPhk2u2UIQszddzcS0a5aS3z5f7lZS6oLs3+H1GsUZ7GNZrs7P
	 1HX8Txi7gkSlKf/rsyW4oGfuxLQMbOBRyr39kiCyR0eQJLGrNqAgHnSJTAGkrfwFMr
	 1xm9DkTfoQAyfQtIUYqvg73LAljzXPyUs0f7c+b7XeMjQE0QSPe0sPhFg1BDb1zCZQ
	 LhHdilGe15SJYmIBjL7kbzMvTOOHeL4U0/aHZNhBVKXVdcvUHkJwPI1A312uf9Bi4O
	 DIT/IsLvccIdp9cXDwKt3VsQDC3HkG5LamjvQwPT46MXTB76qVb0FOUFX5zAZsW5Ug
	 mqEt1xiYHcVog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Check read access for initialized
 writable memory arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918052906.12226-4-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
 <20260918052906.12226-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:50:37 +0000
Message-Id: <20260918055038.1D4AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: MEM_WRITE without MEM_UNINIT enforces BPF_READ breaking o=
utput helpers
--

commit aebadfb01a3b32540321fe2b60bcb6fb1c8673be
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: Check read access for initialized writable memory arguments

This commit updates the BPF verifier to derive memory access types based on
argument flags, correctly enforcing read access for writable memory argumen=
ts
that are already initialized. The change addresses an issue where helper
argument checking previously omitted read permission checks on map values. =
It
adds a generic func_arg_access_type() helper to replace the kfunc-specific
access overrides.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1d5e4ee64fc00..21eb806b1351c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8886,6 +8886,15 @@ static int process_map_ptr_arg(struct bpf_verifier=
_env *env, struct bpf_reg_stat
>  	return 0;
>  }
> =20
> +static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_t=
ype)
> +{
> +	if (!(arg_type & MEM_WRITE))
> +		return BPF_READ;
> +	if (arg_type & MEM_UNINIT)
> +		return BPF_WRITE;
> +	return BPF_READ | BPF_WRITE;
> +}

[Severity: Critical]
Does this regression break pure output helpers that lack the MEM_UNINIT fla=
g?

For example, bpf_snprintf() is defined as an output helper:

kernel/bpf/helpers.c:
const struct bpf_func_proto bpf_snprintf_proto =3D {
    ...
    .arg1_type  =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
    ...
};

Because bpf_snprintf() does not guarantee full buffer initialization, it
cannot be safely marked with MEM_UNINIT. However, with this change, the lack
of MEM_UNINIT means func_arg_access_type() will return BPF_READ | BPF_WRITE
instead of just BPF_WRITE.

Will this inadvertently force check_helper_mem_access() to reject valid
write-only maps (BPF_F_WRONLY_PROG) when passed to such output helpers, cau=
sing
valid BPF programs to fail verification?

Additionally, for unprivileged programs lacking CAP_PERFMON, won't this
erroneously enforce stack buffer pre-initialization by enforcing a read che=
ck
requiring stack initialization in check_stack_range_initialized()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918052906.1222=
6-1-memxor@gmail.com?part=3D3
