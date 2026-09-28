Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FC440621
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577937; cv=none; b=lCHa3hvZSkBKoLlxKO+AM9mUsX1ivtG2TuS0WbfCVyX3VmWry6PQOvY04TaED0GVf6nZkN3qNcUtzSdieVd1qvtwVWIPe9tEOiH11e2/DQofm0PuKUMl6yhnoWe8d2HO4ZDaA4e+cJ1cw3P9gi2zxcVx4pYuBMq2ipMNZWk6x/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577937; c=relaxed/simple;
	bh=aFhyx+M6xnlooD6oAvMfXlaKTgFZCNCHf857i4pSEwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UMk4NZkm9qq8nmBaHbYAQHvmS4khRBRhOSD9f+CTPmOIadpEOefFOaOs3/PQzIeeuOkmA5wUkqvGPr1JoqnboeV2/sRc60WLDZZLH9+EGoWaAMbcOZ9+neUvFacurAiyIL+g1JVrQBInQcn3qx70dpDplrCiQqLpDM6c9PV/jh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEgFo3Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEgFo3Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68A31F000FF;
	Mon, 28 Sep 2026 06:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790577935;
	bh=DULnqJ7Er/j8KwLo/uQJx0R8wZyECop6R3S17ezf5w0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEgFo3Rdeg3K0KZo7MW4SAGJKk7FF902Ypyih8EqEAyGxMlW1uoMrwU+NNx3WRDvd
	 h2CFOi0e2qH3t1rBq1iF5p4Ohu+2vPmN+Hiue19n8fnIezKHahprQmPZv8ThgjKrz6
	 IxQEimphzEUOqJvHputhh/xrovqe2b1eUeOj+8cOMrA4Xs8d1w64Dn3pAcXGK1h2Ya
	 tTvR46rxlKjlTk4MktEIuRAcnlxyy311NcbfHBu/tc1EJg04rGrxFB5nZVJmcxcHWd
	 +uIDxMPNW7tYw1YASDVbLdi/Z/GKBQzL9VVCU6TjEJLQOSVEjOT7ETX0tL9qKRw63Z
	 iHmipfZqWVP2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add bpf_proactive_reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928063724.24008-1-hui.zhu@linux.dev>
References: <20260928063724.24008-1-hui.zhu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:45:35 +0000
Message-Id: <20260928064535.C68A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: memcg_proactive_reclaim test fails instead of ski=
pping when regular fs is missing
--

commit 8a730887084ae177532f166fce0611c868fe9578
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: Add bpf_proactive_reclaim test

This commit adds a selftest for the bpf_proactive_reclaim() kfunc. It charg=
es
page cache to a cgroup and issues a bounded reclaim pass using the BPF help=
er,
verifying that the result is capped correctly.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_recla=
im.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> new file mode 100644
> index 0000000000000..d642658a21981
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
[ ... ]
> +static const char *workload_dir(void)
> +{
> +	static const char * const dirs[] =3D { "/tmp", "." };
> +	struct statfs st;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dirs); i++)
> +		if (!statfs(dirs[i], &st) && st.f_type !=3D TMPFS_MAGIC &&
> +		    st.f_type !=3D RAMFS_MAGIC)
> +			return dirs[i];
> +
> +	return NULL;
> +}
> +
> +void test_memcg_proactive_reclaim(void)
> +{
[ ... ]
> +	dir =3D workload_dir();
> +	if (!ASSERT_OK_PTR(dir, "workload dir on a regular filesystem"))
> +		return;

[Severity: Medium]
Will this cause the test suite to incorrectly report a failure rather than a
skip when a regular filesystem is missing?

If workload_dir() returns NULL when both /tmp and . are tmpfs or ramfs (whi=
ch
is common in CI or initramfs environments), using ASSERT_OK_PTR(dir) here
will fail the test suite explicitly. Should this skip the test instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928063724.2400=
8-1-hui.zhu@linux.dev?part=3D1
