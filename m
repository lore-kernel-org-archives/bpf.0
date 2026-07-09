Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B02400DE1
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596938; cv=none; b=nCQdLMipyRoNDLIbF+N8DmkQHgmywTmafJDYTQ0AGhYVncOlYSktsey+iZtTc5if5wMbR27yu83srRVOyZUSdaEqHBxQl0f8zqWYKJcoI2Hb3HH5MIZpGRFRlniRuv4IaCyXqGWJ/gJZzPDReLQ4gD1XyzgYkA+Viw0+PkefrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596938; c=relaxed/simple;
	bh=Ohl3a3C9GmphvdEBuLALpALWsTQ52A+JLzFH/QM4E28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOG4bxFCb7Npnn6y/YwGdUD4r1FhpBF6ZZi6Vs2/TFPizdOHYqXGKzDyGhFoCslOMc58Oxw1Apx+zi+s1JHR5jmMc9jHMoc2ix4T+QbpqhclPeuY8GQS3bNwYoCqTihXBHImCgNJbum1slxsjaRIZXvykcyNnpBEaPdkd/g5Dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOdhqe4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOdhqe4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FC21F000E9;
	Thu,  9 Jul 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783596936;
	bh=11FdmEgPWnNTpNVZsbJDwq7UtzPJGiHiG/WW5xtVgso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOdhqe4QpCcu5L+P7BZBI83Sw6AkxOpZlK2Gp3CRT5z1KrP9PwV4NUoYJE4bdB4Bz
	 PcTzsp8L2Re8msWLxiNAPC/aF8MeM3hQLDEOpnhKmK0mQt7fPpwUjybOQh8aqWddFY
	 a0hD0XCWo2cpgnXfItqR9VweNl8JRiKjyGc/6LVF1SGpgnYb0yE5iLboPbkL2CsgZD
	 YPYGF4B47evdgZgfhA7dIUJVTK8Akg90lC/1s1Ml9vcO515GZQbWFIJM3xM6scjoa8
	 zE+eaEB8l+bT7zIJ3ECj5y91Fvhcpb9HcoiPmOEJ68r/YDxxClTmj7AJnGeVhmBC+Q
	 qFesqBjQkOF5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 08/10] selftests/bpf: add helpers for KASAN
 in JIT testing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-8-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-8-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:35:35 +0000
Message-Id: <20260709113536.47FC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added get_kasan_multi_shot_enabled() helper is highly =
unreliable due to its reliance on the broken cmdline_contains() helper, whi=
ch reads uninitialized stack memory and performs incorrect prefix matching.
--

--- Patch [8]: [PATCH bpf-next v5 08/10] selftests/bpf: add helpers for KAS=
AN in JIT testing ---
commit 89c5dbabce02201a3bf78105cd83cff83602d41f
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add helpers for KASAN in JIT testing

Add two simple helpers to allow checking whether KASAN for eBPF tests
should be executed.

> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> index f997d7ec8fd08..95be839378837 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c

[ ... ]

> @@ -142,3 +142,13 @@ bool get_unpriv_disabled(void)
>  	}
>  	return mitigations_off;
>  }
> +
> +bool get_kasan_jit_enabled(void)
> +{
> +	return config_contains("CONFIG_BPF_JIT_KASAN=3Dy") =3D=3D 1;
> +}
> +
> +bool get_kasan_multi_shot_enabled(void)
> +{
> +	return cmdline_contains("kasan_multi_shot");
> +}

[Severity: Medium]
Can this return false positives due to the parsing logic in
cmdline_contains()?

Looking at cmdline_contains(), the buffer isn't correctly null-terminated
after reading:

    if (read(fd, cmdline, sizeof(cmdline) - 1) < 0) {
        perror("read /proc/cmdline");
        goto out;
    }

    cmdline[sizeof(cmdline) - 1] =3D '\0';

This leaves uninitialized stack memory between the read bytes and the end of
the array, which gets tokenized by strtok().

Additionally, the token matching logic uses strlen(c) instead of the pattern
length:

    for (c =3D strtok(cmdline, " \n"); c; c =3D strtok(NULL, " \n")) {
        if (strncmp(c, pat, strlen(c)))
            continue;

Because strncmp() checks only the length of the token, any kernel parameter
that happens to be a prefix of "kasan_multi_shot" (such as "k" or "kasan")
would incorrectly return true.

Could cmdline_contains() be updated to null-terminate at the read length and
use strcmp() for exact matching to avoid non-deterministic test behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D8
