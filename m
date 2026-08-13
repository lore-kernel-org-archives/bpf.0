Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591F48C8C7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635767; cv=none; b=HNOKmQi99zEdVCC/Y+cW01CrHUXPh8DAth3qx6/hKxKT8LQryFptGP7kjHzmG/vrsU1kJJb3eOc00wBqzlseyr/S28w+nAQ4oY+Jj97qAh+q8kkxZxTrxJPsFjG/yaIiW7jVaU+FsA6LIhicp2yKIwSMS2l0inwkQmG5ltQm6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635767; c=relaxed/simple;
	bh=Ehxv+PdmvtZ0/wzImMnX0ggrJRdrwr/IqdU9OiXNaTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2Lx7HSWSji/4TWaytejyUoty8zV/aQRKPqb5WEnqX81xWoPH29FX1hOBAfn8twhPRSSILJB1nvmgqImdSBIqqAvd4kI1Wkc4sPKlC+jPYEwplWUukKknpc45Vx71Y8d/D8eOYFkEpGzjPFT1fM7VROWx3lpAJ5sT+rZ6emaFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H//1yB6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H//1yB6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D451F000E9;
	Thu, 13 Aug 2026 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786635763;
	bh=C2OqAED1sklXRZjpqW3hnte1n9EKdOHr5ScZd5p/xnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H//1yB6uGcpWutvC8jbtN9yiV1waszoo4HG2B4sGMMtFXJl2OdtSp83slA+zQed8x
	 u6ZnMur5SJV37U2J25Zpu8++MZNkotqheoC1uU+Dass7nQYurhwnXnsGAeY4Jz8DrF
	 Ze9XfwVqXLng2JtS1HBQUUPJxBJqxC46mZTdHGIf3qKw9DpKcSYrpsLk7RCbH5UJ52
	 jzyu+urz9PHSpo3/we0xfF1CLE1sVERGVldJRWrznunqQGjVaKSGvvRWcaQKK05aic
	 n5+o+Q09IaHNY2rv/J4KXn9xcwkN+/wIhHKhnW9MOSUXugZ1JV9vj7TqUmkQH2Qqt4
	 /OdD/QD5N/qdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813152324.97937-8-leon.hwang@linux.dev>
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:42:42 +0000
Message-Id: <20260813154243.62D451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_global_percpu_data` fails because `bpf_map__set_v=
alue_size()` clears the `.percpu` map's BTF type ID when it encounters a no=
n-array as the last variable in the datasec.
--

--- Patch [7]: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verif=
y global percpu data ---
commit 0224e1ae61dc47271ec8a72ac29b073935a25d31
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify global percpu data

This patch adds a selftest to verify global percpu data map initialization
and modification using APIs like bpf_map__set_value_size() and
bpf_map_lookup_elem_flags(). It includes both light and standard skeleton
tests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406f..06d163a022dcc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
[ ... ]
> +static void test_global_percpu_data_init(void)
> +{
[ ... ]
> +	err =3D bpf_map__set_value_size(map, desired_sz);
> +	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +		goto out;
> +	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "percpu value size=
"))
> +		goto out;
> +	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "percpu BTF value t=
ype"))
> +		goto out;

[Severity: Medium]
Will this test fail here because bpf_map__set_value_size() clears the BTF
type ID?=20

When bpf_map__set_value_size() is called, it attempts to resize the BTF
datasec. This requires the last variable in the datasec to be an array.
Because `struct_data` is defined last in the `.percpu` section in the BPF
program, map_btf_datasec_resize() returns -EINVAL and clears the BTF type
ID to 0, causing this assertion to fail.

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> new file mode 100644
> index 0000000000000..416841cd35692
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
[ ... ]
> +int nums[7] SEC(".percpu");
> +bool set SEC(".percpu") =3D false;
> +struct {
> +	char set;
> +	int i;
> +	int nums[7];
> +} struct_data SEC(".percpu") =3D {
> +	.set =3D 0,
> +	.i =3D -1,
> +};

[Severity: Medium]
Does placing this struct at the end of the `.percpu` section break the
BTF resizing logic?

Could the variables in the `.percpu` section be reordered so that an array
like `nums` or `cpu_id` is the last variable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813152324.9793=
7-1-leon.hwang@linux.dev?part=3D7
