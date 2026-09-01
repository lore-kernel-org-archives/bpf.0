Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F3489867;
	Tue,  1 Sep 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282962; cv=none; b=Xtn3aTbfig6c80iRCuO28lQqgR9yWOEFKdJ0uauvw7IkQ8ns1inh/nGDFR5aSMVT1TWMJbmhiHODPHYlMawzadHgu++zfRDLCTTgD7O19Npx8V1O7i2zSmIu6dHDsDkpNLJgLrnWdQ53VXREHQLyyGBEo2m+1TgMY4/cXhKDN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282962; c=relaxed/simple;
	bh=toMJjZ6G4VmVzYjBjjNb4/0QMXdFW9z6P894zbv/+xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=js99Lt0+tCHW10vHfosBrT4PO3KaxTtSDf7LY4U4uGSVYSFQgnzRDUAtCjtpCW0+hpxsxupQXHv+GcQxTtxrSATLnWoq8WpzCvHcwFIPugjy4YeSQ3URQlyoQ5A1DabzKDcy7A4lj/8Myd9q8b8j48LrOdo1EDB/WVi7iuZ9Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6q/QQ7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6q/QQ7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091581F000E9;
	Tue,  1 Sep 2026 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282961;
	bh=MlYUo7e+6JHQBeyEuCBNbPrU410UL26fmjqc5fZtZZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6q/QQ7ViFM+6E3Nnev2JJKEUS44dDNW8I/Vyl1jxX3UpGchalAF235DgNeQTSPH+
	 A6mbQg05Of8v4OuJ60fFy9aTcU6DJSPhIGdi+iBwfxnu90iZMInBd7KbrSlhIGojKW
	 i6RuyBv4FofBMGWV771hbKlMFKDuu9hUOW1Q3LbQ4pkYdX1wuab4RuyXjkqBnpH55C
	 DTLFTHUifi7DJ3nqhUqd14h1dTHOms6RXYXDATBlKNl01LXjxLw2QLvnO+aCVu1EAm
	 TMm2xWXVIzP0VwjhR9lWAt50f2w/aU2tQLOC7DwvQ8qacZjaIgiqTOc0V+Dnl0rOiY
	 76BB6Yrwzovbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 08/18] selftests/bpf: Validate that
 btf__permute transfer works
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-9-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:16:00 +0000
Message-Id: <20260901171601.091581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL check on btf__raw_data() return value leads to segf=
ault and uninitialized size usage in btf__new().
--

commit 843335a53af929d0f8f7676cbbf1cb2a7296aacb
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Validate that btf__permute transfer works

This patch adds test coverage for the btf__permute() transfer mode. It
verifies type-ID remapping, LOCSEC record ordering in split BTF, and string
handling and deduplication.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools=
/testing/selftests/bpf/prog_tests/btf_permute.c
> index 04ade5ad77aca..ef75fd71df96e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c

[ ... ]

> +/* Permuting BTF with a layout section must keep section offsets in sync=
. */
> +static void test_permute_layout(void)
> +{
> +	LIBBPF_OPTS(btf_new_opts, opts, .add_layout =3D true);
> +	LIBBPF_OPTS(btf_permute_opts, permute_opts);
> +	struct btf *btf, *parsed, *transfer_btf =3D NULL;
> +	const void *raw;
> +	__u32 raw_sz;
> +	__u32 permute_ids[] =3D { 0, 1, BTF_PERMUTE_ID_TRANSFER | 2 };
> +	int err;
> +
> +	btf =3D btf__new_empty_opts(&opts);
> +	if (!ASSERT_OK_PTR(btf, "empty_layout_btf"))
> +		return;
> +
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	btf__add_ptr(btf, 1);
> +	permute_opts.transfer_btf =3D &transfer_btf;
> +	err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), &permut=
e_opts);
> +	if (!ASSERT_OK(err, "btf__permute_layout"))
> +		goto cleanup;
> +
> +	raw =3D btf__raw_data(btf, &raw_sz);

[Severity: Medium]
Could this missing return check lead to passing a NULL pointer and
uninitialized size to btf__new() if btf__raw_data() fails?

> +	parsed =3D btf__new(raw, raw_sz);
> +	if (!ASSERT_OK_PTR(parsed, "parse_permuted_layout"))
> +		goto cleanup;
> +	btf__free(parsed);
> +cleanup:
> +	btf__free(transfer_btf);
> +	btf__free(btf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D8
