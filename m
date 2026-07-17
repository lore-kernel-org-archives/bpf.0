Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199493D47A1
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271467; cv=none; b=htYLNi+d/VlsXHuRNJvd1cb/8ZPQtO9P3duqO+rJ9T00QDQ41JGuE6Ak7rXxucFqXQOqfj56Y9lDSi+OuF+SzTfQPj1C9hOGYZrv5er+17hsRGlXg3BmZqtfz1BtVaLqE3m5FKekMAbj/44g+C5YnIbShLOY+1Oyu85n1j8XaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271467; c=relaxed/simple;
	bh=Fv3dvwHeQkFuq2lYvaUCDtvR+zkXdxXHQ8k4r9aKw2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RYuM3Y49BuPZ7F3TkSrgsgKh1jPVmIEkpw0UE2zKV3AC9uFiZ+HFSF+i/GQzKu3l1+tWiM3gmCgt1R9yz67X3OexQE2NpzvdR2usl++OfBYsdPaJir+W+AmzG+hHTmpiOCmx+j/adUZY05aSI8hJHsD5z9EQF4+oMQO4l2ibE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imJP292c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imJP292c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957721F000E9;
	Fri, 17 Jul 2026 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784271463;
	bh=+U1gJJSA6wbr1gKf0i0z8rsFnsXQXTCInzuJg7LQXhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imJP292ccn5b5eC4L4e+2YG21wgjxmpPV8wieRudKUeftlrI/KLG/NVfBMStzk/x9
	 pDMkgjAp9E0d5NAxgGjspFN547xILfeismHqGRkWdH8wR/eajcxfuP9wwkS8vbFyDW
	 vMzqdT/GHlXDiB3zOv7/Ff+5FISWstm6sEBOMU2h5ThetB9M+BR+DH0tnHmEYyG0V1
	 sAasq5lLUXOd1juP3A0otFSXipNhYZ1AzF/mVqYsSGByiATiZ4idjgm9mG8jfmrEu3
	 n1vqlZfGkO32G6+U5gjlr9p/MHEyPG9tJXN/ItFjWsZNtNc811jXIJPMjiVH0U5+Nw
	 qv3x5iFS0H5gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "longlong yan" <yanlonglong@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717064719.1032-1-yanlonglong@kylinos.cn>
References: <20260717064719.1032-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:57:43 +0000
Message-Id: <20260717065743.957721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `ARRAY_SIZE` macro is used but never defined, resulting in a bu=
ild failure.
--

--- Patch [1]: [PATCH] libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c =
---
commit 49bb37468e341cf82c49ff84b927aa30773d6092
Author: longlong yan <yanlonglong@kylinos.cn>

libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c

This commit replaces manual array size calculations with the ARRAY_SIZE
macro throughout the test_rbtree.bpf.c selftest.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 856c484a009a8..f6e15f77cdf5a 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -275,7 +275,7 @@ clean_up_noalloc_tree(struct rbtree __arena *rbtree)
> =20
>  int insert_many(enum rbtree_alloc alloc, enum rbtree_insert_mode insert)
>  {
> -	const size_t numkeys =3D sizeof(keys) / sizeof(keys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(keys);

[Severity: Low]
Does this code fail to build because ARRAY_SIZE is not defined?

It appears ARRAY_SIZE is not provided by the headers included in this=20
translation unit, which could cause the compiler to reject it as an
undeclared identifier during the selftest compilation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717064719.1032=
-1-yanlonglong@kylinos.cn?part=3D1
