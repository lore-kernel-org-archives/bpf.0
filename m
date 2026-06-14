Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375625EF87
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455559; cv=none; b=iBQeIDFP8czlT4zfVq131D3OMYy3i4qCNRsrLH1nFPNH6BwLOhGjXxaT4FvKPzlyi6YJl5dvRNrHkSqaSHmK0R1UXgvnglFOUbznLmIkLSc1BO1NFTZVSDtPpYQQ3Cr/Ngfm6oYLCoktnVGcUycJwHXFRqt7LGG7eCFz56AsliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455559; c=relaxed/simple;
	bh=QGWTC4gwKSny8wtH4PggbeKTQKydabLDSXqeO6+i2t8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OfwAJ0MTIClb6IUGF/cab3YjYdX6iOZ8ytLF/44OfbMgwBvSSn3661Yrh0rDtiChg+EuIi6p+wX9KbeCtVm8ig1m1fHgYk91Ty1KGa3siWfr6hdLELk07qvZd0rayspBt2xILh736FobUojy1UCQGOxcXDt16g+5eButwRs/ASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioOx/jgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioOx/jgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4C1F000E9;
	Sun, 14 Jun 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781455558;
	bh=G14iPojbI//LZ9oAZZaCX/YH56yi2i4zemgYSMCiFfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ioOx/jgC3nLCTh+NSeQGbpM46xXzWxZz9DHh2afjBfzvKlFRSHdX8Cpqi+YE33yRv
	 xU4FLXfPXq1r63B9MS8l6lLGzP8OvW4qc295MtRuAIAfPNpG+JpT9s3oljHiphNsBD
	 qDJFrXsJmbbdMGeSTbaIzSjwCCqqRP9/xcxcO6SvVsKv2NcejRIU6yqxL+rPacS+e3
	 O0Q9WNYHfeuFb60lcr3a7clPrEzKEo778R1eC/tVlrxmSKrBkw85WK1xWOHV7ae0yf
	 k6xGK3wq6qfTQxhXkOV8YpBWOaGliVyuTyRr23b8BYQn+aVfFiCuLsj37AfXt4/hKc
	 /qMP2SqNZsWiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: Add arena direct-value boundary test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dhiraj Shah" <find.dhiraj@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614163352.1060813-1-find.dhiraj@gmail.com>
References: <20260614163352.1060813-1-find.dhiraj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 16:45:58 +0000
Message-Id: <20260614164558.77F4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test fails instead of skipping on unsupported architectures
--

commit bf7061c7fdbf0dd53bab769b853524e021e37dfc
Author: Dhiraj Shah <find.dhiraj@gmail.com>

selftests/bpf: Add arena direct-value boundary test

This commit adds test coverage for direct map value access against
BPF_MAP_TYPE_ARENA, verifying that valid offsets are accepted and
off-by-one out-of-bounds offsets are rejected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c =
b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> new file mode 100644
> index 0000000000000..00e65af5df6ce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c

[ ... ]

> @@ -0,0 +1,65 @@
> +static void test_direct_value_boundary(void)
> +{
> +	void *area =3D MAP_FAILED;
> +	int map_fd, prog_fd;
> +
> +	map_fd =3D create_arena();
> +	if (!ASSERT_OK_FD(map_fd, "create_arena"))
> +		return;

[Severity: Medium]
On architectures that do not support BPF arenas, bpf_map_create() will
fail and return -EOPNOTSUPP.

Does this ASSERT_OK_FD() in test_direct_value_boundary() cause the test to
falsely fail on those architectures instead of gracefully detecting the
-EOPNOTSUPP error and skipping via test__skip()?

> +
> +	area =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, map_=
fd, 0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614163352.1060=
813-1-find.dhiraj@gmail.com?part=3D1
