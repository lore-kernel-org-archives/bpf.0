Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E672D47E9
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116226; cv=none; b=h/n1DlBByzWqfKWMavqQcgZjLAnK34rRHifpIW2WwjAMSMKt1QDz46BLMODkHDwCsNgoaZP1OaMrlXRevqLJFf71eLFTB3okWP5xz9OLWo0K/zlbO4GinVTeCM7fg0PL/5uAK7ZhiR7KeOy6C2BpC7BmgsKYthLVVtKWBc2T9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116226; c=relaxed/simple;
	bh=fhNUs4q1HG7sCZOjWdUukixzw/tziBQO0q7RBrqllgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xaz2eLPZQ2cq8plUgZ2+ZaerrF3sXSmr8MeTwJB890NCeQEN+duwQQvywVd+1DNj3IIH7iRaOArsSrSjEshS0/KZB+cKmtB4ZMAhOnA+GTxdVxrUGZacxaiy58VAEKAQ7t7GRn0qJUql6tyPzn/YASUgDFuBW2QNv4yP1i6U72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZlZRgji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZlZRgji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57320C2BCB7;
	Mon, 18 May 2026 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116226;
	bh=fhNUs4q1HG7sCZOjWdUukixzw/tziBQO0q7RBrqllgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nZlZRgjiZUOvM+j+AMQOfeQhC7iqlznpHFFuxKN5PIDdEN5yZbHscaXScw4UfsG2i
	 Yhp0Bygc5IH42IbZ1ncGD/Eo2RTfzjD5xnsdYLn0OJI9QB5DnPxcmeqaWTRmi27TTp
	 V4yNRPL0PcyW8XkuBPfTI3vG9dANfClOEvrI1737sldAbVGR7CTavFDEMVubtEzI8F
	 NTK13MCjqGkgjegwiPj5cCw7fd1VsWP8wtWCTvbPNAFHV2SNpbYwU6KAWT2F5pvv57
	 kDq/C/HfvuOSL7yQYRKLP89gyHFfabSNLznkfeIMSp03dQlvEEo1Tky2hcky851sqk
	 UtWKWLwa3dUuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/2] selftests/bpf: add regression test for
 ktls+sockmap verdict UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xingwang Xiang" <v3rdant.xiang@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517145630.20521-3-v3rdant.xiang@gmail.com>
References: <20260517145630.20521-3-v3rdant.xiang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 14:57:04 +0000
Message-Id: <20260518145705.57320C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Usage of ASSERT_TRUE for skeleton pointer checks instead of ASSERT_=
OK_PTR.
--

commit 2da876f992ba88c42d69b2910d90f780e2c1b89f
Author: Xingwang Xiang <v3rdant.xiang@gmail.com>
selftests/bpf: add regression test for ktls+sockmap verdict UAF

This commit adds a regression test for a use-after-free vulnerability
involving KTLS and sockmap verdict programs. The test creates a scenario
where TLS RX is configured after inserting the receiver socket into a
sockmap.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> index b87e7f39e15a8..6ed8e149e3d58 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c

[ ... ]

> @@ -417,6 +417,107 @@ static void run_tests(int family, enum bpf_map_type=
 map_type)
>  	close(map);
>  }
> =20
> +/*
> + * Regression test for the KTLS + sockmap (verdict) reverse-order UAF.
> + *
> + * Vulnerable sequence:

[ ... ]

> +static void test_sockmap_ktls_verdict_with_tls_rx(int family, int sotype)
> +{
> +	struct tls12_crypto_info_aes_gcm_128 crypto_info =3D {};
> +	char send_buf[] =3D "hello ktls sockmap reverse order";
> +	char recv_buf[sizeof(send_buf)] =3D {};
> +	struct test_sockmap_ktls *skel;
> +	int c =3D -1, p =3D -1, zero =3D 0;
> +	int prog_fd, map_fd;
> +	ssize_t n;
> +	int err;
> +
> +	skel =3D test_sockmap_ktls__open_and_load();
> +	if (!ASSERT_TRUE(skel, "open_and_load"))

This isn't a bug, but should this use ASSERT_OK_PTR() instead?

ASSERT_OK_PTR() handles IS_ERR_OR_NULL checks and provides better
debugging output for pointers on failure.

> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517145630.2052=
1-1-v3rdant.xiang@gmail.com?part=3D2
