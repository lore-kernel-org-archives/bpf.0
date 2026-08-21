Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2D493659
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349219; cv=none; b=QJD20mc4VYjBOY4QwHFFwcR3PIL/DOGFurkEW/7uldN6Fxdfkk/EK92XD8MZqSzuSjL5OV4BtN2ClbE/7Fbx/DjYZkQcDSnHca9FCo8j01VVIODH7XC0T5Zmk8hE0xuTw1fAg79WEdfPSxTWC/lb4T71Ng8FfBsV1w+6yOPffNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349219; c=relaxed/simple;
	bh=tXuNwg5HqewBd0XUFSEWko9PLR3sZyNHbQGISIEZPHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sd2O69DJSXGvwKgSmsqndTkbSnNlUOCEv80sLGXpcGpt7owdG+Yi6v6rQYfvJdEPMByNM8EuAq8WodcKeFx/QstfPlBFgQBU3iRRiXZchqk95cGRYIezRBiVqlKu+tvb/+PT3KRxxhwZ4ULgb4HHRjjOzz0xkMlksImhtOWlPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH8b5JNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH8b5JNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152D61F000E9;
	Fri, 21 Aug 2026 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349218;
	bh=3F6JQ/rsjGyGs4bfcRZSM8v35qaVs1Mrj2AuW0jjhpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LH8b5JNhKce0/LY45d7bPVQXjQPEfMJidKsCVm7RdLbylOnSSAhZlFuxvWihTlMOl
	 rKx0lCRmGPb0bE8Kl+xvzIhqEOQYNE+tcuWybJqqv21PMyI3UZVrmDWEWgCg3BU+m/
	 WhwfUgJ1O/4Yx1NvD2lHUFB5sR6zlSXW0C3ng9+UJu3J+JJfssTkhLVZ/ZAGcap1Ph
	 GQI9GAJ+Abw+ADR4SPDmHyCZciEMLDoR9DMxLWnijRxRpJHZkMqdSvwq7RhxQXJilw
	 BWXsyUbcJgJckst2TxNGWuwcRYWsvLvVTHMIt5Be275MVsZZuCXzztEXeHsZ9NvHM1
	 f6xltlH5WdSJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/11] selftests/bpf: Add a test for the sealed
 bpf keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821214111.1120748-6-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:53:37 +0000
Message-Id: <20260821215338.152D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] API conflict and UAPI omission: The BPF system keyring sentinel =
value (3) collides with the valid user key serial number space.
--

--- Patch [5]: [PATCH bpf-next 05/11] selftests/bpf: Add a test for the sea=
led bpf keyring ---
commit 3de34ebcd8baa817e75280e15e9985c407307d98
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add a test for the sealed bpf keyring

This commit adds a selftest to ensure that loading a program naming the BPF
keyring fails with -ENOKEY when the keyring has not been provisioned. It
verifies the ordering of error checks prior to real signature processing.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> index 0c5294738d6ce..94b57e7cdab39 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> @@ -32,8 +32,11 @@ enum {
>  	BPF_SIG_KEYRING_SECONDARY,
>  	BPF_SIG_KEYRING_PLATFORM,
>  	BPF_SIG_KEYRING_USER,
> +	BPF_SIG_KEYRING_BPF,
>  };
> =20
> +#define BPF_KEYRING_BPF		3
> +

[Severity: Medium]
Does this hardcoded magic number (3) for the BPF keyring collide with the
valid user key serial number space?

Since key_alloc_serial() in security/keys/key.c only excludes values less
than 3, a user's dynamically allocated key serial could theoretically be
assigned serial 3.

If a user creates a keyring and happens to get assigned serial 3, and then
passes keyring_id =3D 3 to bpf_prog_load, wouldn't the verifier intercept it
via VERIFY_USE_BPF_KEYRING (which is defined as 3 in
include/linux/verification.h) and incorrectly route it to the .bpf system
keyring instead of the user's provided keyring?

Additionally, should this value be exposed via a UAPI header rather than
requiring user-space to hardcode it in the selftest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214111.1120=
748-1-daniel@iogearbox.net?part=3D5
