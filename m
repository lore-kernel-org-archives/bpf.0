Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0D3ABD96
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498030; cv=none; b=QiNn5hCTfqex2StZ+loblM3O3pjJyBtWMTF7LTguLIVkSJLndpZM6lVDG3MjphEoGze2TAw2k+61/Ds6ixbH85qKocexRBthdBfRmlP4lc8CE5de30VmQMSW0fXh+DuPaioLz3pu0G+VuhxShwyP8CLaj2BSZEfP9nlKtJJUPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498030; c=relaxed/simple;
	bh=bHVop+QDlkBq0TztU88wPSbOwnYqIrKgLfSgEirTDjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1Nyf1IZPej3bysCCKrMNehdh1Zro4FV0AOgFLmynOQUQWGt3UtBfVdQ4/nVx3T/E5HGTPC/lAs7+zR5lYlU0hwPFbArw9expaizza97st/Xq52c6LEPlONloDvE2eFVVdegIt8jdIVKeD6P0dfBQkItxLpGknWyKTJbYCrONYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZixBmtaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZixBmtaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDD1F00A3D;
	Wed,  8 Jul 2026 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498025;
	bh=mJj2OvIwCt2mmFAnTSjfaSkkqCVvJUEnjjNoaJlG5Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZixBmtaB04DHIdDYZ8wlypYpgFlhgdMrg8++vpFvZnHWRClcFUJ/5OXEpqvGbIO2d
	 3iI2aDzdVuNp6eUXlj34vjPWdpR0BROIAHNoUjzSErSaxJp+S8CCvunor2zaf83Ikp
	 pRgsY7uAvzoVBR4eRzDpV4yLQDfwbrH3Yw6s299D4S+sHEVdiYGwgmHW/DkNpSO03A
	 DfJbKHD8J4hMzUiug/ohunFpf4z7v+rItf4FvXaFyairB+DwSFVY2+HMP4haQDlZOd
	 t4/qxcomDRtNpSNhZRrbegBHilT/pUYPrsX2nxtgFQFeNL2W2WqkwpZ6alV74R4VvV
	 1XURIlNd664Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 7/8] selftests/bpf: Verify load-time signed
 loader metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708075343.358712-8-daniel@iogearbox.net>
References: <20260708075343.358712-1-daniel@iogearbox.net>
 <20260708075343.358712-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:07:05 +0000
Message-Id: <20260708080705.A1DDD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing file descriptor cleanup on unexpected test failure.
--

--- Patch [7]: [PATCH bpf-next v6 7/8] selftests/bpf: Verify load-time sign=
ed loader metadata ---
commit 64830bb6cea6aee71f09d788c841cd423f6308e6
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Verify load-time signed loader metadata

This commit updates the signed loader tests to verify load-time signed load=
er
metadata end to end. It extends the tests with more cases, such as map-less
programs and asserting the LSM admission hook, while retiring the older
subtests that asserted the removed in-loader check.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> index 5fc417e31fc61..0019492cf07a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> -static void metadata_sha_mismatch(void)
> +static void signature_enforced(void)
>  {
> +	static const __u8 junk[64] =3D { 0x30, 0x42, 0x13, 0x37, };
>  	struct gen_loader_fixture f;
> -	bool ran;
> -	int r;
> +	int fd;
> =20
>  	if (gen_loader_fixture_init(&f) =3D=3D 0) {
>  		/*
> -		 * blob[0] lives in the loader's fd_array scratch (first add_data in
> -		 * bpf_gen__init); a 0-map program never reads it, so flipping it
> -		 * changes only map->sha. The metadata check is the only thing that
> -		 * can notice -> isolates emit_signature_match.
> +		 * A present-but-invalid signature (the cert bytes are not a
> +		 * PKCS#7 signature) must be rejected at load: the signature
> +		 * path is honored, not ignored. (The valid path is covered by
> +		 * the signed lskels.) Pin -EBADMSG, the PKCS#7 parse failure:
> +		 * a looser fd < 0 check could also be satisfied by the sparse
> +		 * fd_array rejection (-EACCES) that the loader's map reference
> +		 * would trip even if the signature were silently ignored.
>  		 */
> -		f.blob[0] ^=3D 0xff;
> -		r =3D run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
> -				   f.data_sz, f.excl, sizeof(f.excl), NULL, 0,
> -				   true, f.ctx, f.ctx_sz, &ran);
> -		ASSERT_TRUE(ran, "loader ran");
> -		ASSERT_EQ(r, -EINVAL, "tampered blob rejected by emit_signature_match"=
);
> +		fd =3D load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> +				 sizeof(junk), KEY_SPEC_SESSION_KEYRING, 0);
> +		ASSERT_EQ(fd, -EBADMSG, "invalid signature rejected at load");
>  	}
>  	gen_loader_fixture_fini(&f);
>  }

[Severity: Medium]
If the kernel unexpectedly accepts the load during signature_enforced,
load_loader will return a valid file descriptor. Does this file descriptor
leak since the ASSERT_EQ macro allows execution to continue?=20

Other tests introduced in this patch, such as signature_failure_logs, use
the following pattern to ensure the file descriptor is closed on test failu=
re:

    if (fd >=3D 0)
        close(fd);

Would it make sense to include this cleanup here to prevent file descriptor
exhaustion during a cascading test suite failure?

[ ... ]

> @@ -495,12 +573,31 @@ static void signature_too_large(void)
>  		 * is rejected before the buffer is read.
>  		 */
>  		fd =3D load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> -				 64 << 20, KEY_SPEC_SESSION_KEYRING);
> +				 64 << 20, KEY_SPEC_SESSION_KEYRING, 0);
>  		ASSERT_EQ(fd, -EINVAL, "oversized signature rejected");
>  	}
>  	gen_loader_fixture_fini(&f);
>  }
> =20
> +static void signature_zero_size(void)
> +{
> +	static const __u8 junk[64] =3D {};
> +	struct gen_loader_fixture f;
> +	int fd;
> +
> +	if (gen_loader_fixture_init(&f) =3D=3D 0) {
> +		/*
> +		 * A present signature with signature_size =3D=3D 0 is rejected
> +		 * up front, before the keyring is resolved or the signature
> +		 * buffer is read.
> +		 */
> +		fd =3D load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> +				 0, KEY_SPEC_SESSION_KEYRING, 0);
> +		ASSERT_EQ(fd, -EINVAL, "zero-size signature rejected");
> +	}
> +	gen_loader_fixture_fini(&f);
> +}
> +
>  static void signature_bad_keyring(void)
>  {
>  	static const __u8 junk[64] =3D {};
> @@ -515,7 +612,7 @@ static void signature_bad_keyring(void)
>  		 * large positive serial takes the user-keyring path and won't exist.
>  		 */
>  		fd =3D load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> -				 sizeof(junk), INT_MAX);
> +				 sizeof(junk), INT_MAX, 0);
>  		ASSERT_EQ(fd, -EINVAL, "signature with bad keyring_id rejected");
>  	}
>  	gen_loader_fixture_fini(&f);

[Severity: Medium]
Similar to signature_enforced, if load_loader unexpectedly succeeds in the
newly added signature_zero_size test, or in the updated signature_too_large
and signature_bad_keyring tests, could this result in leaked file descripto=
rs?

Adding the same close cleanup check here might help prevent test environment
instability if these assertions ever fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708075343.3587=
12-1-daniel@iogearbox.net?part=3D7
