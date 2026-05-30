Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293C1E5B68
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780116466; cv=none; b=tvlzKN0K2A/y93P9uHk+88aFoM9gtLWEsxxtbmvG1LBJDtZzFHaGCJK+Jm7pxtTeG+tlFCqBb2slNhZSAtKDPWxYqzWm43tgL9LfEfSvKtCb2GJFjQAvYCQMMaDukB6MZ45mCWKutigOybr8Kz9x/V2FzXnRhb1Cgq7lFlNlcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780116466; c=relaxed/simple;
	bh=u3LvGopUMg/fuKzQtrDKR6ERXgJOpJALyKo4reECHaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=apHytbw/OkW5DQGcs0Iea1p369VPaGV6vX5k7mFa+VLw0MHt4uFNoKmAgeN+cFeR688ngGLc1SQE49MCKLZ79cLnM15c6jq5YE089QA4L19J/nZQEAjFfYnSsyKyjweOXU9beOKpRsX+1jz69ZPofVtJBStlzH+HbDC0E8xShqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZe0fEYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZe0fEYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A67C1F00893;
	Sat, 30 May 2026 04:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780116465;
	bh=Z7fYhp7lkQ+3twsyb91JH+bczxktRxAi5CmDdWjW6HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZe0fEYUCyZDcV+hOsZp/U31Wevm0/ZTXCqlgTsusrXrtotpqaPG8nGb5hR3kY0vh
	 qdZf8Cg/7JtyTUqnwPpcCLMjq1+vymyGmP/9VSvSGN65Vgc5beg765+h6ExKlXOETD
	 YOdHk1WlJ1Y4OYRpMZwMyQbdxhyn/vXI+0kK/mAtBztzfZDYPzSs5/mVYY0RyGmp33
	 ls/tf5iZiHh6YSJ8KHTu+sGCm5gNsgprYg851jERmGNbNvflr12Q0/lLJL3kkrkTdA
	 WdgkPSKyX8Rg96D5441ztg9rRgu8Md4zSFDEpyKpK1F+IzwKI0b9lOW5MLW6sUY4Eq
	 x8kQkKJIiG8BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add tests for arena
 slub-backed allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530011345.99342-5-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 04:47:44 +0000
Message-Id: <20260530044745.0A67C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing verification loop for sentinel values in arena_slab_allo=
c.
--

commit 37191f82932baa8c7a355ab2dc782678851699f6
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add tests for arena slub-backed allocator

This commit adds end-to-end tests for the SLAB_BPF_ARENA path. It includes
smoke tests for the bpf_arena_alloc and bpf_arena_free kfuncs, as well as
tests exercising corrupted in-object freepointers to validate clamping.

> diff --git a/tools/testing/selftests/bpf/progs/arena_slab.c b/tools/testi=
ng/selftests/bpf/progs/arena_slab.c
> new file mode 100644
> index 0000000000000..738a48c45da33
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_slab.c
[ ... ]
> +SEC("syscall")
> +int arena_slab_alloc(void *ctx)
> +{
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +	int i;
> +
> +	for (i =3D 0; i < N; i++) {
> +		__u32 size =3D 8U << (i & 7); /* 8, 16, 32, ... 1024 */
> +		__u8 __arena *p =3D bpf_arena_alloc(&arena, size);
> +
> +		if (!p) {
> +			alloc_failed =3D i + 1;
> +			return 0;
> +		}
> +		/*
> +		 * Write a sentinel that depends on the slot =E2=80=94 proves the obje=
ct
> +		 * is real arena memory and not aliased with another slot.
> +		 */
> +		p[0] =3D (__u8)(i + 1);
> +		p[size - 1] =3D (__u8)(i + 1);
> +		objs[i] =3D p;

[Severity: Medium]
Does this code actually verify the non-aliasing property it mentions?

The loop writes sentinels to p[0] and p[size - 1] to prove the memory is re=
al
and not aliased, but it appears there is no subsequent loop to read these
values back. If bpf_arena_alloc() were to incorrectly return aliased memory,
the sentinels would be overwritten by subsequent allocations but the test
would still pass.

Should there be a verification pass to check these values before returning =
or
freeing the memory?

> +	}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530011345.9934=
2-1-alexei.starovoitov@gmail.com?part=3D4
