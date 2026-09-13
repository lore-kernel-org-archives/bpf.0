Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C7351C1E
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311799; cv=none; b=XxexhDZw55Iplt7ixCYCm3sFr/BkXeCZqHiMLO2q3K/qSnA1nde5ylHz8ZrRCt6C1OK7uRkhiizIrveIcGcn/QqcC6QUlIj1eI9ObinjFtQYqD8TkyULTekykp6abiVhDqcZsVNHQAzRsn60irWTiJ0o9vRM3kkHRR/YrJSdIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311799; c=relaxed/simple;
	bh=RxuOkVH2cumPN0ZwxIf7v/CASp/tjA0TPtTg/G/+LPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jFc2ELbyvhYGAU8qDXpTd9wDIrhShanGAEMz5TmPvnliqh7a29WsSRuig7l0QdUyse5XW9W/E+HQ4r7RNBMxShcXK7ge+NroVBwIdhpGVTioU7WYAo3y3RL77mVpasfWy9WY3TX2bfLxPuMAjfyQ6eRHAy5gMaSWL6pRNJfr3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnJqmKiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnJqmKiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83B51F000FF;
	Sun, 13 Sep 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789311796;
	bh=soQLE7BySlblMALrybZLgumVBitiRM53YWIpkMqfJSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnJqmKiZFLYnVJViWjJ8FutDM/Q4ejpMXC5jn+Yi9PGl96KHRzo6mQC/MuYFbyNVS
	 MrdCr/33Em0btHSwHQT24QC79Lag2kYhySmTrGcit2qJRDNwkWctwA1QeCFKBD7A4i
	 jL5df2zQB99LcOlMVBKoSsbBeS9nTr6Ulh+k+7RnPWC2UtT14DxryfaYHM+EDXWG4z
	 8Kcsk6xd+PXqqrCzPA1dwVHWHdkY+YGrTv4aAN0McXqGPH4kypDLEZeA1Qy5Wj3J9W
	 fA+sAll6fKXmGkkDnolUKycEu0NZQsEFRWBypH5xzaP9dd6p5ZHYDZ4OgNQANX4a64
	 WMmXnXh4H6vuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Cover struct_ops bitfield and
 offset validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingpei CAO" <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260913145233.1446643-4-caomingpei@gmail.com>
References: <20260913145233.1446643-1-caomingpei@gmail.com>
 <20260913145233.1446643-4-caomingpei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 15:03:16 +0000
Message-Id: <20260913150316.A83B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added tests `test_struct_ops_local_bitfield` and `test=
_struct_ops_bad_member_offset` fail during skeleton load because they forge=
t to disable autocreation of the `testmod_zeroed` map.
--

commit 69d278fe659a33375aee90852a40642cb2fe6e03
Author: Mingpei CAO <caomingpei@gmail.com>

selftests/bpf: Cover struct_ops bitfield and offset validation

This commit adds selftests to verify libbpf's handling of struct_ops bitfie=
ld
members and incorrect member offsets. It ensures that unsupported local
bitfields are rejected and bad offsets yield an EINVAL error.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 75a0dea511b3f..41029ebb22f01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
[ ... ]
> @@ -150,6 +151,91 @@ static void test_struct_ops_not_zeroed(void)
>  	struct_ops_module__destroy(skel);
>  }
> =20
> +static void test_struct_ops_local_bitfield(void)
> +{
> +	struct struct_ops_module *skel;
> +	char *log =3D NULL;
> +	int err;
[ ... ]
> +	err =3D bpf_map__set_autocreate(skel->maps.testmod_local_bitfield, true=
);
> +	if (!ASSERT_OK(err, "enable_local_bitfield_map"))
> +		goto cleanup;
> +
> +	if (start_libbpf_log_capture())
> +		goto cleanup;
> +	err =3D struct_ops_module__load(skel);

[Severity: Medium]
Will this skeleton load fail prematurely due to testmod_zeroed?

When struct_ops_module__load() is called, libbpf iterates over all
autocreate maps in the BPF object and initializes them. The testmod_zeroed
map is defined first in the BPF object and is set to autocreate by default.

Since its zeroed_op member is initialized to a non-NULL program pointer but
does not exist in the kernel BTF, bpf_map__init_kern_struct_ops() returns
-ENOTSUP.

This causes the skeleton load to abort early before testmod_local_bitfield
is fully evaluated, leading to false negatives in the test suite. Does
this test need to disable autocreation for the testmod_zeroed map before
calling struct_ops_module__load()?

> +	log =3D stop_libbpf_log_capture();
> +	if (!ASSERT_EQ(err, -ENOTSUP, "struct_ops_module_load_local_bitfield"))
> +		goto cleanup;
> +	ASSERT_HAS_SUBSTR(log, "local bitfield extra_bitfield is not supported",
> +			  "local_bitfield_rejection_log");
> +
> +cleanup:
> +	free(log);
> +	struct_ops_module__destroy(skel);
> +}
> +
> +static void test_struct_ops_bad_member_offset(void)
> +{
> +	struct struct_ops_module *skel;
> +	struct btf_member *member;
[ ... ]
> +	err =3D bpf_map__set_autocreate(skel->maps.testmod_bad_offset, true);
> +	if (!ASSERT_OK(err, "enable_bad_offset_map"))
> +		goto cleanup;
> +
> +	if (start_libbpf_log_capture())
> +		goto cleanup;
> +	err =3D struct_ops_module__load(skel);

[Severity: Medium]
Does this suffer from the same early skeleton load failure?

Since testmod_zeroed is still set to autocreate, the load will return
-ENOTSUP instead of the expected -EINVAL, causing the subsequent ASSERT_EQ
check to fail unconditionally. Should autocreation of testmod_zeroed be
disabled in this function as well?

> +	log =3D stop_libbpf_log_capture();
> +	if (!ASSERT_EQ(err, -EINVAL, "struct_ops_module_load_bad_offset"))
> +		goto cleanup;
> +	ASSERT_HAS_SUBSTR(log, "member extra is outside the 4-byte local struct=
_ops type",
> +			  "bad_offset_rejection_log");
> +
> +cleanup:
> +	free(log);
> +	struct_ops_module__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913145233.1446=
643-1-caomingpei@gmail.com?part=3D3
