Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8C3D34A8
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971877; cv=none; b=VnWQX6ZWnkXr1aIeWHbjM+Res5ujzAk3ziTvElTgzzoihPrWEtIK/oO707ZsMdYZ18y7M9RJoNVvO9YUwJsvZk6ilyPYrB4QMJZ/AzLri5hVXSY9s4/yzxXmgjhGDLH10+pscmSIQe94c/lXYldWn9iqn2dKNWSIl57xnH8NbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971877; c=relaxed/simple;
	bh=khgWph/1JeBxN4asChdbrT28nuRTtxMW1KJZTZ7iRgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZhRQ0x3dSwvyH8JHe0hj3Kghcvz7N+uEhbN6ELXVldA0PMiUf0L7Thp0ElBieQ0PCr7ltKtL62Z3aYuddYmTKmJxJL3lGS6hE2dBo7gDrWKCa/byfcCHkGBQBl7RMjE6/7g71hOQXeLpk3W3Lt+seSt+EHVo63hpCY1gRH9mzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HND+aB0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HND+aB0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966CC1F000E9;
	Wed,  5 Aug 2026 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785971875;
	bh=tNGITSmdENBgeHPs62/33+Oe5XmNVUIPR7Rc2q80C8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HND+aB0+N/i4vq7RylSxOFgnRqL0i/ltW3A/f8LVhlj16x5fPtKgIgWs5oU2ZEcqx
	 MrdbqDZ6tPFko45UDs5R5J8Kgu3Yin+xVdOFL0sTtSedt3QO1UCVIHrkbE/uTM2Lak
	 lYSQ8i8imIutAPzUUDoukmmlY54KOAIKKnUf+wSsQagEeei5/w/493cS9q8Lsslf9+
	 54nIzlobGKbd1D1VjPdJOWMaJ7xW61bIpw74RoEcXFdRr25nVwtLDySiI9tR6WQTe+
	 MmCZlOXCXHkUQeuc8bv3Iw11zgDM33qXNOgA7QhVjJLydLaHkRTYFwDjA1xvuFnjSa
	 Iu2H4wKMt8zRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/6] selftests/bpf: Verify arena type tags
 in resolve_btfids test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805230648.2354989-4-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:17:55 +0000
Message-Id: <20260805231755.966CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL pointer check on the result of `btf__type_by_id()` =
causes a segmentation fault when a kfunc symbol is missing.
--

--- Patch [3]: [PATCH bpf-next v2 3/6] selftests/bpf: Verify arena type tag=
s in resolve_btfids test ---
commit 833ac8bbb8ac1055e25790da1396864987e31541
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

selftests/bpf: Verify arena type tags in resolve_btfids test

This commit extends test_resolve_btfids() to assert that resolve_btfids
emits the address_space(1) type attribute on the return type and arguments
of kfuncs marked with KF_ARENA_RET, KF_ARENA_ARG1 or KF_ARENA_ARG2.

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index ac51fd4548214..8482f00046d4c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
[ ... ]
> @@ -227,6 +260,39 @@ void test_resolve_btfids(void)
>  	check_kfunc_set(&test_kfunc_set);
>  	check_kfunc_set(&test_kfunc_set_rev);
> =20
> +	/*
> +	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
> +	 * with the address_space(1) type attribute, and left other
> +	 * pointers/returns untouched.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +		const struct btf_type *fn, *proto;
> +		const struct btf_param *params;
> +		const char *name =3D kfunc_symbols[i].name;
> +		u32 fl =3D kfunc_symbols[i].flags;
> +		__u32 nr;
> +
> +		fn =3D btf__type_by_id(btf, kfunc_symbols[i].id);
> +		if (!ASSERT_TRUE(btf_is_func(fn), name))
> +			continue;

[Severity: Medium]
Could this cause a segmentation fault if a kfunc symbol is missing?

If resolve_symbols() fails to find a kfunc in the parsed BTF file, the
symbol's id remains -1. When -1 is passed to btf__type_by_id(), it
returns NULL.

Since btf_is_func() unconditionally accesses the info member, passing a
NULL pointer to it would crash the test program before the ASSERT_TRUE
evaluates.

Should we check if fn is NULL before passing it to btf_is_func()?

> +		proto =3D btf__type_by_id(btf, fn->type);
> +		if (!ASSERT_TRUE(btf_is_func_proto(proto), name))
> +			continue;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805230648.2354=
989-1-ihor.solodrai@linux.dev?part=3D3
