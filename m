Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B536E49B
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349236; cv=none; b=qJr9Og4rk3zEmrlYfJVTaaJuxQ7HQ2Jhr4vV9lg134B3o0ycBFwC8NdvZYdS4FKmFhVSSMl+xfh9HcmwAMz6UG8xphDI1GvhaqMMn1n/bTKhoNDHXp2wl7ohChGYXZfriQMz0oh9j9Trm2B6DbU54ubzzSt3wszVOcdRtFV9qCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349236; c=relaxed/simple;
	bh=ecZuTYEEduf5cj7peRpB0q1J9/noCY5hK7bFY7BkPtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fv6RP72OFxQ6Bl2K6UokV693zdZCkmI7JPgp4W8vYNTYDxvtfFBlXqvNb9vO+CirK5um2KNzPGn5D6cCDxNj4QR4swK/RGbrJVq4Ez+BwHh0jd9M+cc4gW6DI4UG3PxZuOIuA7Nc/WG+/hcL/4m79gRJV1njUOebCbZAIfnloCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3M3rBkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3M3rBkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F871F000E9;
	Fri, 21 Aug 2026 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349233;
	bh=bjptNR9ABEyemP2454AuYIzqzhDyP6wek0tzgpGybIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3M3rBkl5fLks8jSvbIv4ESZL8j5FZu8S4InbcMtagYcI95eELirPf4LarFjannQC
	 L1J87CXAzbomxcCNX5MNCkVvT1QVLYhPivWTzClCkWGBrLmPKYPijdkG5qowKrGRZI
	 YUmNceh0sAWqjlPnGOD5WhbL/V5XrvvEPGYBEfK2THHJ7eCVIl+nurU2SQG6J7Zb07
	 TYIG+erDEFKsKRdmxWZCTIZcju0GqzYAbUQ0wdhm4+Hvnh6HvdfL0fwlukqigKf8le
	 pkDHpd/qrkeYdeCK5vqbT8/pemwBfAORbq/SPL98bRgMkkPIKEvsKvJkijp6ZLFDia
	 52yGjf/xfBu/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/11] selftests/bpf: Add tests for bpf keyring
 in signed loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821214111.1120748-11-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-11-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:53:53 +0000
Message-Id: <20260821215353.B3F871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] A ternary operator logic error causes a NULL pointer dereference=
 if `strstr` returns `NULL` in `bpf_keyring_lookup`.
--

--- Patch [10]: [PATCH bpf-next 10/11] selftests/bpf: Add tests for bpf key=
ring in signed loader ---
commit c9f1ea97a7848e9a19ec91707712827e46792acd
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add tests for bpf keyring in signed loader

This commit adds selftests for the bpf keyring in the signed loader. It
verifies the keyring through its lifecycle, including key generation,
enrollment, and testing loading restrictions based on the keyring state.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> +static int bpf_keyring_lookup(int *nr_keys)
> +{
> +	char line[512], type[32], desc[64];
> +	int serial =3D -ENOENT;
> +	FILE *f;
> +
> +	f =3D fopen("/proc/keys", "r");
> +	if (!f)
> +		return -errno;
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		unsigned int hex;
> +		char *sum;
> +
> +		if (sscanf(line, "%x %*s %*s %*s %*s %*s %*s %31s %63s",
> +			   &hex, type, desc) !=3D 3)
> +			continue;
> +		if (strcmp(type, "keyring") || strcmp(desc, ".bpf:"))
> +			continue;
> +
> +		serial =3D (int)hex;
> +		if (nr_keys) {
> +			sum =3D strstr(line, ".bpf: ");
> +			*nr_keys =3D (sum && !strncmp(sum + 6, "empty", 5)) ?
> +				   0 : atoi(sum + 6);

[Severity: Medium]
Could this ternary expression result in a NULL pointer dereference?

If strstr does not find ".bpf: ", sum will be NULL. In that case, the
ternary condition (sum && !strncmp(sum + 6, "empty", 5)) evaluates to
false. The execution will then fall through to the false branch,
calling atoi(sum + 6).

Since sum is NULL, this leads to a dereference of NULL + 6, which
would crash the selftest binary with a segmentation fault.

This situation could occur if the keyring description is parsed as
.bpf: by sscanf above, but the line does not contain the exact
substring ".bpf: " (with the trailing space).

> +		}
> +		break;
> +	}
> +	fclose(f);
> +	return serial;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214111.1120=
748-1-daniel@iogearbox.net?part=3D10
