Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5864B66D1
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487537; cv=none; b=n3c4YNSbJ4ounzohI+ni0Aefks5Si/rZnvuaixzBGXADVSrCWxPMHvgZwjzwGBZLRQ+rmH0qAL8h/GA8dFcLWP3B1uEWsoyEJ7Vu2BctmmTO/lich2R7qdMF5wRjwud0M7nm/Cf41qYQJbikhEPSezjlxh49+eN4JeOHrOaZ3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487537; c=relaxed/simple;
	bh=vSdoU0ZWVnXFxso1lzATrr2sVnbH1aAW6yrQLSuVwu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S6FaMVd8PkwvJQEGKlW2MJ/fZHyoLtLZ+14EMDvsxUjxQmy+goDfYkaqlUB2Bvkntqp3ny2htqh9mxed5tuhsyIWljrr6d6MaUqZBnyaArmAvpK8Ywv7F0UriO8mUv4XX3e1+ZJeiewrzmtpOcRBmVJWfFZSRBgD2LNESIygTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5XhU8kV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5XhU8kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88F51F000FF;
	Tue, 15 Sep 2026 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487535;
	bh=plET7GX3SsjilHN1sDitFHiGq6LSD7EAeZzAD/csE4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5XhU8kV3OufeQgNkihmjMeb6XDE2/MATBRhotRS4d+5sV5mqF3oL08qlHLbZ0QAX
	 0FQ/7/IE38Y9DN9PPUFWwCiXxow/aiUlQ55Xkdw9f5lpiWvaf4ulRKHkQqgjD8kv9G
	 kOpyWb8eZg6esbwfWiDPUUtgoG80sSm+e4Nl0iovWb3h24453+qgzLwAwRoekMsfcz
	 2NIzzwvktSJz/H0YyJKsUCaRpq2yvMiq1qn+RWZDYVpMNdf1v7tIZ73w+GcOiUYZ6E
	 7Aq8iI1lz3ObGezyF3iawaxnMDkg6nhQll9wVY5P24vrTjXW5/Kp8F/u+Eb2m98Rst
	 UPaKsWVUmPxZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Add tests for
 bpf_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915154248.3612028-3-puranjay@kernel.org>
References: <20260915154248.3612028-1-puranjay@kernel.org>
 <20260915154248.3612028-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:52:15 +0000
Message-Id: <20260915155215.B88F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: data race in test_call_rcu_chain between callbacks increment a=
nd chain_err
--

commit 4178e68b1467222b91e572aaee89ee9d04f051af
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add tests for bpf_call_rcu()

This commit adds tests for bpf_call_rcu() to cover callback execution
after a grace period, testing error handling on double arming, reuse of=20
the head, and verifying proper verifier rejections for invalid usages.

> diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/te=
sting/selftests/bpf/prog_tests/call_rcu.c
> new file mode 100644
> index 0000000000000..c2d266aee8eac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c

[ ... ]

> +static void test_call_rcu_chain(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct call_rcu *skel;
> +
> +	skel =3D call_rcu__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	skel->bss->chain =3D 1;
> +	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm),=
 &opts), "test_run"))
> +		goto out;
> +
> +	if (!wait_for_callbacks(skel, 1))
> +		goto out;
> +	ASSERT_EQ(skel->bss->chain_err, 0, "chain_err");

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing=
/selftests/bpf/progs/call_rcu.c
> new file mode 100644
> index 0000000000000..aa5d2b0fa36e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/call_rcu.c

[ ... ]

> +static int reclaim(struct bpf_map *map, void *key, void *value)
> +{
> +	struct elem *e =3D value;
> +
> +	cb_key =3D *(__u32 *)key;
> +	__sync_fetch_and_or(&cb_keys, 1ULL << cb_key);
> +	cb_val =3D e->val;
> +	cb_max_entries =3D map->max_entries;
> +	e->val =3D 0;
> +	__sync_fetch_and_add(&callbacks, 1);
> +
> +	if (chain > 0) {
> +		chain--;
> +		chain_err =3D bpf_call_rcu(&e->rh, &arr, reclaim);
> +	}
> +	return 0;
> +}

[Severity: Low]
Could there be a data race here between the callback execution and userspac=
e?

In test_call_rcu_chain(), userspace calls wait_for_callbacks(skel, 1), which
returns as soon as it observes the callbacks counter reach 1. It then
immediately asserts that chain_err =3D=3D 0.

Since __sync_fetch_and_add(&callbacks, 1) happens before chain_err is updat=
ed
in reclaim(), userspace could potentially read a stale chain_err value (0)
before bpf_call_rcu() is actually invoked and writes its return value.

Would it be safer to increment the callbacks counter after updating chain_e=
rr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915154248.3612=
028-1-puranjay@kernel.org?part=3D2
