Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882B30F7F7
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140255; cv=none; b=KYkH/EJ3zLXcnvQsrlMVJVHw9OJRCQlUxejonpRSoBqq5dzVCWIBYEfRgG9Lg0cFRcZNar/xqNoJ02BzUV/2RnWFhTWhxZGdugIys6bqct/JyNyReAN14anGgpe4914RzsGrs5hVCUJ16so9I7UddwDYK4jQ5luDZIJgHgw3prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140255; c=relaxed/simple;
	bh=z0/b1Wfu09daVxeumHgbLNLbRiwx5WXEvPR26gNSeZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJRInbKVY/NRJ6sH3ZLkWyZ3GWz9OEUVFVgVGJcmzZyWJPbR0PNCKGzYuUQVlXsi0C2vGCkGZKj619XyqQGNPdF+6Bl74uWfK5u6cn/LEVpjlUwdxOoKMn0Iv8wvF9BsoA4t+OO2F22KoMGhQfOsxBpAqzf/2qvVT/9NavtnBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfhp9bnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfhp9bnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A049A1F000E9;
	Mon, 22 Jun 2026 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140253;
	bh=W2HvmBnMTAnMqz1eHk6tEuUfNC5VYBiKax2Z9+q15r0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gfhp9bnuIM2xw8VPe4BqxCYk8t/rXtQ2wNKqsphuCfi9SY7VT5iMaWhE6oRVCGMCV
	 ETT/wslAn7tFG5rFD3phdB1AQv/8DHUhvOMaJXjPHB+Vu5igUrHb7eLr/b33XbMOib
	 TZQL4SQX8gQSWHI/xfiObp4sWzlgxQGOX9sO84qbVXAm4tYZyDUCwfrscwA5ozGwwW
	 Bxi8ePiF3zX+Vr21A/JeMEd0HayC4d2t55ayDpvm6ZKeoQkiO2U9O4G41WcZ4cVYt6
	 5D+VsKICy0tBzpatM1GVwQle5RP/QfJa1cWKagl+gJE5HCKWT7WbamEXSxN1CdsnFN
	 M6DCB4gnSXs9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 08/11] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622143557.22955-9-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:57:33 +0000
Message-Id: <20260622145733.A049A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The subskel test incorrectly asserts that `var_cnt > 0`, causing=
 the test to reliably fail.
--

commit 55ee2a40d2c9fa6afdbccf30892e0d5b8f148c44
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify global percpu data

This commit adds tests to verify global percpu data using libbpf APIs.
It also introduces a subskeleton test to ensure that the live variables
of a subskel do not include variables for global percpu data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel=
.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> new file mode 100644
> index 0000000000000..8aebd533d86b5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
[ ... ]
> +void test_global_percpu_data_subskel(void)
> +{
> +	struct test_global_percpu_data *subskel =3D NULL;
> +	struct bpf_object *obj;
> +	int i;
[ ... ]
> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
> +		goto out;
> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRA=
Y,
> +		  "percpu_map_type");
> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");

[Severity: Medium]
Will this assertion cause the test to unconditionally fail?

Looking at test_global_percpu_data.c, all defined variables are placed
in the .percpu section. Since bpftool explicitly skips .percpu maps when
generating subskeletons, there appear to be no non-percpu maps with BTF
variables present.

If that is the case, subskel->subskel->var_cnt will be exactly 0, causing
this check to evaluate to ASSERT_GT(0, 0) and reliably fail the test.

> +
> +	for (i =3D 0; i < subskel->subskel->var_cnt; i++) {
> +		const struct bpf_var_skeleton *var;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622143557.2295=
5-1-leon.hwang@linux.dev?part=3D8
