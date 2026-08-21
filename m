Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730734D4E9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349038; cv=none; b=aRct7X1CABTPls0RyvMoatJJu138m4bPCmKIIoZVn8hy2KGBCEaLtnZ5/MS+eQvrIWVnTjVk07G4dH7bOezsUrwE6znkXRNNrNC5cIxGTJGXZ4M5qAnMq87U/DvK6mxs8U4VcAMIylRsZ7soroa1K7/Jt5r2T1i09K4GFckd5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349038; c=relaxed/simple;
	bh=uiVKo5YtFabjAke0vdnFH/kCVJkwDunn36dDB4NmI1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hBsq+PAzU6SNPOXSnQmxg4tCgFQfrERZRTW+6JLjcdKSX7T9sjM/NEWfdoMn3oxmTMc6IOgKIAG3FP1KBRCZBpVfg9OHxZrD3ii108IxrYdJJRkDdka63CuFFkJgswYxTM5b36YXWtEsZM6kTbwC8YKdszwpI6wEfnLKIQWbsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhV/82UC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhV/82UC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E71A1F000E9;
	Fri, 21 Aug 2026 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349036;
	bh=GSnShiwIckVJTlbZ/CsZegwLOMqu7gLcjw+PRUVZftM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhV/82UCkBzOLf3g8U7g/Rd//ECwpI2z0V79sWw+SZX0lPc2r/JGywUNhpuyqHln8
	 y0Gs+3mGtRByxal0zL7lm1O39uFSDA0bMBEHu5X9zfDNgcfSSrxvqI5E2QV00ciT5c
	 wUh+PewWRZ5cKz6Vr1ngxbX64axDT6H5JLZqYBDSHa1t822PKr0dnXF8dVVFFhTn39
	 gBepvvu61BQX8tlQRKwIcTZsnb7ZpQJD5n7sBMBtdBdjZ84/tHhQatEcYqoDqZSrg9
	 lgR8hfaJSqdHmjOQ8N+ANqD4xG+FHi9H8iLnVjohPu9pyGRlYwx2dOs72GCUYP/qkY
	 SC5Tlh3W1XY/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/11] selftests/bpf: Add an end-to-end ML-DSA
 signed loader test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821214111.1120748-9-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-9-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:50:36 +0000
Message-Id: <20260821215036.8E71A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Temporary directory and generated key files are leaked if `verify_s=
ig_setup.sh setup-mldsa` fails.
--

--- Patch [8]: [PATCH bpf-next 08/11] selftests/bpf: Add an end-to-end ML-D=
SA signed loader test ---
commit 3cc419c08f9d1d4d5a77de9eb5cccbc21b94232e
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add an end-to-end ML-DSA signed loader test

This commit adds an end-to-end ML-DSA signed loader test to the BPF CI. It
introduces a new test case that verifies an ML-DSA signed program can be
loaded successfully using the existing pkcs7 signature verification.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> index 4b2416903d90d..a1fa1c37815bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
[ ... ]
> @@ -1550,6 +1563,87 @@ static void loadtime_with_map(void)
>  	test_signed_loader_map__destroy(skel);
>  }
> =20
> +/*
> + * End-to-end signed load with a post-quantum key. ML-DSA (FIPS-204) is =
wired
> + * through the X.509 and PKCS#7 parsers, and BPF reaches them via
> + * verify_pkcs7_signature() without knowing the algorithm, so an ML-DSA =
key in
> + * the keyring should verify an ML-DSA signed program with no BPF-side w=
ork.
> + */
> +static void mldsa_signed_load(void)
> +{
> +	char dir_tmpl[] =3D "/tmp/bpfmldsaXXXXXX";
> +	int map_fd =3D -1, prog_fd =3D -1, err;
> +	__u8 *sig =3D NULL, *buf =3D NULL;
> +	struct gen_loader_fixture f;
> +	bool have_fixture =3D false;
> +	__u32 sig_sz =3D 16384;
> +	char *dir;
> +
> +	dir =3D mkdtemp(dir_tmpl);
> +	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
> +		return;
> +
> +	err =3D run_setup("setup-mldsa", dir);
> +	if (err =3D=3D SETUP_SKIP) {
> +		printf("%s:SKIP:openssl has no ML-DSA support (needs 3.5+)\n",
> +		       __func__);
> +		test__skip();
> +		rmdir(dir);
> +		return;
> +	}
> +	if (!ASSERT_OK(err, "verify_sig_setup setup-mldsa")) {
> +		rmdir(dir);

[Severity: Low]
If run_setup("setup-mldsa", dir) fails after creating files in the temporary
directory (for example, if keyctl padd fails in the bash script), does this
code leak the temporary directory and its contents?

Since rmdir() does not recursively remove files, it will fail with ENOTEMPTY
if there are still generated files like signing_key.der inside the director=
y.

Would it be safer to call run_setup("cleanup", dir) here instead of rmdir()
to ensure all temporary files are properly cleaned up?

> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214111.1120=
748-1-daniel@iogearbox.net?part=3D8
