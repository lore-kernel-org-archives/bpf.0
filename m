Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D9328B62
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958668; cv=none; b=o88oK7OsUmka3EwoafPSBM92iHsr69tPJuqFGOPcn2a6GV4be3v39WAeOkiZkOGtbYS88WpEfughX73RrTbS1bMsEq3iURBI69I9O8JpP/yKmyT8FhWcJKOR7Hfl+OKsP1UtrYqL2aLXvokEq3MAyeWDQJl/Miv0t3P+PlQhRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958668; c=relaxed/simple;
	bh=N7c5QlW6Ww+ysVIjFYv537DYxbRnqZALBQ94VZssDpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QWiyFojHpEK081XYHTuWmFPmeCyrvhIPPV+dgdAZ40KDsa4yeujKDq9mnXYajrYTXcOmU8XZJVNjJLICgp5wKl6Dlw9DzzFSieCkIYpimhZmfyjOpdvmGrsjWqfyTrFuOP4Ro4jNcI9hh9vjlOZERWv4IXnA+f4flmGimhV0CaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFsmkJ4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFsmkJ4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75121F000E9;
	Mon, 13 Jul 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958667;
	bh=MCP6NxS7bGT05l8TCCdTZLjg4PS71N69rPqq8+nLfxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFsmkJ4ShbHUAUS7oZQ2VDq7BFguPCYuBEuXk8XSos82+45pWhmD/wZ7O+U5u+GF6
	 zCu8ODeY4q572+/VXz3ZiIG3Y0kmEChQbHwW16tAckYMPJErEFshYK3Vt7wSCPJqMU
	 fPTgESRcUmzzCXZmiteyZ9wxg3o8Q1dNnWnB1q+RhOsjo0oWGWRshIClbVNRzjZw7k
	 FDvwaNJ5iD/J3mYbmr7oyQr5iw+w4oSe54HB+mRIghMO6+lKueJVyhAjuevxUrDK7s
	 lsqf+m2b6Yi5VwXrivkAsp+1ZY36+1AXq3XkqgfSGQD+o6tu97MjoYks0VRmtbprzS
	 e2ZNSI1vj7jVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 10/17] bpf: Report Resource Lifetime
 reference leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-11-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:04:26 +0000
Message-Id: <20260713160426.D75121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Diagnostic functions print `insn 4294967295` due to a hardcoded `-1=
` instruction index passed to `process_dynptr_func`.
--

--- Patch [10]: [PATCH bpf-next v3 10/17] bpf: Report Resource Lifetime ref=
erence leaks ---
commit 11b108e2b9d6802e27c431d5c20ed1b81781c4e6
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Resource Lifetime reference leaks

Augment selected Resource Lifetime Safety failures with structured diagnost=
ics
while preserving the existing verifier messages.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bd233083b4950..84eda5e83f873 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7625,9 +7695,18 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, struct bpf_reg_stat
>  	int spi, err =3D 0;
> =20
>  	if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DYNPTR) {
> +		const char *fmt =3D "A dynptr argument must be a pointer to a dynptr s=
tack slot or a "
> +				  "verifier-provided const struct bpf_dynptr, but %s is %s.";
> +		const char *reason;
> +
>  		verbose(env,
>  			"%s expected pointer to stack or const struct bpf_dynptr\n",
>  			reg_arg_name(env, argno));
> +		reason =3D bpf_diag_scratch_printf(env, 0, fmt, reg_arg_name(env, argn=
o),
> +						 bpf_diag_reg_type_plain(env, reg->type));
> +		bpf_diag_res(env, insn_idx, "invalid dynptr argument", reason,
> +			     "Pass the address of a stack dynptr object, or use a const dynpt=
r "
> +			     "pointer returned by the verifier-supported path.");
>  		return -EINVAL;
>  	}

[Severity: Low]
Will passing insn_idx directly to bpf_diag_res() cause an integer underflow=
=20
in the diagnostic output?

Looking at btf_check_func_arg_match(), it calls process_dynptr_func() with=
=20
-1 hardcoded as the instruction index:

kernel/bpf/verifier.c:btf_check_func_arg_match() {
    ...
    ret =3D process_dynptr_func(env, reg, argno, -1, arg->arg_type,=20
                              &ref_obj, NULL);
    ...
}

Because bpf_diag_res() expects a u32 for insn_idx, this -1 gets cast to=20
4294967295. This results in the verifier log printing "insn 4294967295"=20
during validation failures for dynptrs in global subprogram calls.

Could this use env->insn_idx instead, or handle the -1 case explicitly=20
before passing it to bpf_diag_res()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D10
