Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DE146588
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644317; cv=none; b=NGE+tdttHDGBl34gBooYIRitYMmlKKi5TpVe1oiL5ampGqgHTL7V0VIzCUHvqTCX0QvqMgbirSZOLwvZps9WVVtXX8TH/nGlViIQcLvlMERVnurRzlYJDCY46brDwOUNtyzGslm3Va9z5K1JI7PHKbg3kH7+GAPFjNWf5medEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644317; c=relaxed/simple;
	bh=RkcY7jNnIlAsV0Xuz+wUQpJvdwnHH8418UU4sKK9pQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2I6pvWrIqMF23kNuwh8xHLk+KymqJHXqNvIEXGTM38zdjz3qfe1h1CQaR01kZZz9CfCFLC1Rg8tc2SrTvH2N4tn9siSIBXQMVAB7QVF4CxdoTgxH4A48JY1IapIbleAMsWuFFzK+sjpgTPE7NWR5EnIR5Jt2nYxXzJTllryrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDJBIf+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDJBIf+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3E71F000E9;
	Tue, 21 Jul 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644316;
	bh=aIfEVN8a1OcmS5FPgckDQx75PEvZqvq6m0vy+4Heph8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDJBIf+/duBxXGBPAu57NK2QN3VfFEZ5I//KoQA0EkLWWzGFG28VpLc4pABEj5/La
	 g2yG75fohuhqBlQo9Ls+6cMrhL8As2e6+9fmFmx2XDLF5J9lZBhpdiw0WQG7KE1kI/
	 2hpavsGWWFKwiD/u+1KoVGhylGJvUPV1SUYRzUmZHCX+Z1wa3c/hqGpNkvz4oenWs4
	 mwfgaIbnNgGMly4dncPEDUci5GO5CL6TIwS27rDLXAJD3iF68x0up5qKNUgVtvQV9q
	 fDP8sk5198k1Ji7L4oEIwVG+SGkC7azMJT/k8Mj1U0MEqfvZY/2QyDk6PciQ3GIHg+
	 7FwfPce1NiLJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/21] binfmt_misc: add transparent interpreter
 dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-10-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-10-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:31:55 +0000
Message-Id: <20260721143156.0F3E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Contradiction between commit message and code regarding `bprm->i=
nterp` modification in transparent execution mode.
--

--- Patch [10]: [PATCH v2 10/21] binfmt_misc: add transparent interpreter d=
ispatch ---
commit 6ffbfe6dc985c69faed5889214a86663cd8cbca7
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: add transparent interpreter dispatch

This commit adds a transparent mode to binfmt_misc, where the binary is pas=
sed
to the interpreter via AT_EXECFD without modifying the argument vector or
bprm->interp. This aims to make the execution look like a direct execution =
of
the binary to the application.

Link: https://inbox.sourceware.org/libc-alpha/20260717-work-glibc-binfmt_mi=
sc-v3-0-45129bfb13fe@kernel.org [1]

> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 304109a5091f0..e5a17ca935cad 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c

[ ... ]

> @@ -458,21 +463,23 @@ static int load_misc_binary(struct linux_binprm *bp=
rm)

[ ... ]

>  	flags =3D entry_invocation_flags(fmt, bprm);
> =20
> -	retval =3D build_interp_argv(bprm, interpreter, flags);
> -	if (retval)
> -		return retval;
> +	/* No argv is built for a staged argument to land in. */
> +	if ((flags & MISC_FMT_TRANSPARENT) && bprm->bpf_interp_arg)
> +		return -EINVAL;
> =20
> -	/* Update interp in case binfmt_script needs it. */
> +	if (!(flags & MISC_FMT_TRANSPARENT)) {
> +		retval =3D build_interp_argv(bprm, interpreter, flags);
> +		if (retval)
> +			return retval;
> +	}
> +
> +	/* Update interp for the next round; sched_prepare_exec reports it. */
>  	retval =3D bprm_change_interp(interpreter, bprm);

[Severity: Medium]
The commit message explicitly states: "The argument vector and bprm->interp
are left exactly as the caller set them." Is this description accurate for
transparent mode?

Looking at load_misc_binary(), bprm_change_interp() is called unconditional=
ly,
which updates bprm->interp to the transparent loader's path.

If the transparent loader happens to be a script, won't binfmt_script consu=
me
this updated bprm->interp and modify argv by replacing the original argv[0]
with the loader script's path? Does this break the untouched argv promise f=
or
script loaders during transparent execution?

>  	if (retval < 0)
>  		return retval;
> @@ -481,6 +488,10 @@ static int load_misc_binary(struct linux_binprm *bpr=
m)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D10
