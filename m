Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59752F7F02
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249106; cv=none; b=QqCoQDnBTpv6BixdYusw+hAA6klDNq8nrml0NdF0iX2IeZl7rRhbNAOe9Cj37510QJh6Hls91QLRGbN2mcl9K/PRC5YOmY4lupGvnkLEA8WiAm441H/6qc6MzXZtzxeKrvL98nI9P4pU2NeJIxOYJt7eBqUEdli2erbdGJ3zB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249106; c=relaxed/simple;
	bh=X8Yv/GQT1x7ZA8znuqex0DSqXMYM+rwlt1OzlqPe+Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8zV+nv/Y0J4oTqQe/ZNoxCeanDukzDLrRnzLjZTceqikYl0Drd0IZawDO+RtXIL17qX9Q8o07haB1ghmr4x9nbxQ99agXKkH6wTDVfHxuBwUo8WzhInqirivvw99DvCvzLWTwe07Z1mV1yB8bDnDTiLURaLW27H6wiz5vRzbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9LUnvIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9LUnvIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D251F000E9;
	Thu, 20 Aug 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249105;
	bh=2LVlpAHdq8nVBXIsYajQaIz3EZzKxFGp+eeKoBj+TgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9LUnvIRBterz1dFPNgdAzdWbgcvMRwTuq7cWK0XOwbIEKuR6ZlarN/tkTQEJ7bmM
	 kLdltAKullbFZ5tT9GdFE8OpK4bxiXF1HMxRMANwz4fGRBZXyMVK1RC3i/e18hvDYx
	 VQp+ba51TAalbe4vh/hSmtVSzorUJkOJ6o9EOV6J8y2tdDtts8+nU6cVB9JDLH1A4Q
	 BcxImknE5ksE5Dmuoo6UQ7AUiOd05MQwBDCXa5utejzL2GZa1NIbFxcIUKHPLvpuZh
	 aVA93JOxs0ShZ4HnWvS7xWS1qUHHs9P32rMqmzphMfxhUveBn3BBr/i4U6NN+wmKRm
	 lQfCLs0zZMlPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: convert lirc_mode2 to prog_tests and
 extend coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820175154.708374-1-sean@mess.org>
References: <20260820175154.708374-1-sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 18:05:04 +0000
Message-Id: <20260820180505.41D251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing `globfree()` when `glob()` returns an error in `find_loo=
pback_devices`.
- [Low] Orphaned test file `test_lirc_mode2_user.c` left in the source tree.
- [Low] Multi-line comment formatting violates BPF subsystem guidelines.
--

--- Patch [1]: [PATCH] selftests/bpf: convert lirc_mode2 to prog_tests and =
extend coverage ---
commit 932c1322ffc2d27251b53c4449db5c4ec36061e6
Author: Sean Young <sean@mess.org>

selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage

While porting, extend coverage of the BPF_LIRC_MODE2 attach/detach/
query API:

[ ... ]

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 2b2f93dec474b..f8ec0f574559a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -141,7 +140,6 @@ TEST_GEN_PROGS_EXTENDED =3D \
>  	bench \
>  	flow_dissector_load \
>  	test_cpp \
> -	test_lirc_mode2_user \
>  	veristat \

[Severity: Low]
This isn't a bug, but it looks like tools/testing/selftests/bpf/test_lirc_m=
ode2_user.c
was removed from the Makefile here but not deleted from the source tree. Sh=
ould
that file be deleted as part of this patch?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/=
testing/selftests/bpf/prog_tests/lirc_mode2.c
> new file mode 100644
> index 0000000000000..17a38cd03845c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
> @@ -0,0 +1,328 @@
[ ... ]
> +/* Read the DEVNAME=3D line out of the first uevent file that matches
> + * pattern, and turn it into a /dev/<name> path.
> + */
> +static bool find_devname(const char *pattern, char *path, size_t path_sz)

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line comment
style guidelines? The opening /* should probably be on its own line:

/*
 * Read the DEVNAME=3D line out of the first uevent file that matches
 * pattern, and turn it into a /dev/<name> path.
 */

[ ... ]
> +/* Load rc-loopback and find the lirc and input chardevs it created. */
> +static bool find_loopback_devices(char *lirc_path, char *input_path,
> +				  size_t path_sz)
> +{
> +	glob_t gl =3D {};
> +	bool found =3D false;
> +
> +	/* Ignore failure, we check for the resulting devices below. */
> +	system("modprobe rc-loopback > /dev/null 2>&1");
> +
> +	if (glob("/sys/class/rc/rc*", 0, NULL, &gl)) {
> +		fprintf(stderr, "No rc devices found, is CONFIG_RC_LOOPBACK enabled?\n=
");
> +		return false;
> +	}

[Severity: Medium]
Could this leak memory if glob() returns an error like GLOB_NOMATCH? Some
implementations of glob() may allocate memory for gl_pathv even on error pa=
ths.
Should there be a call to globfree(&gl) before returning false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820175154.7083=
74-1-sean@mess.org?part=3D1
