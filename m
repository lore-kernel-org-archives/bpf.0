Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A71C862F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763954; cv=none; b=qE9NlXzqOziQsraKL1KDH1yirbPSGlX3rI6/GgbgUi92k+BmbE2I5fhFydqPjLBTjKNBxNZrLDJhNW6fqP7/8QwMZ1KW2OKcDHef4IOICx3o2tsN9cLjzDNH6QlJb5v/tsD4vx9k3p32lt650LbcezAxsQW2Q8hQE/WfGcjKLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763954; c=relaxed/simple;
	bh=99ksPYRccVg6FmvRERA9Z/LirlHKJ+m3hffKsMhqP1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JTU7YuHSUQt9lqHV3mUMVg6mH9Wktv3PiQW6ZyTJIhf/toBLbZjnFwu1cRFl7n82Bqpb+SrU1py+2Je0VGJomRrbfwn/rEltpaPYxDAmowz87Z8BUUD4CJaxp9EBcTZagLojmHovSfjofG8SwpaKLR89E3UFwWFAp0eJVsYvbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC+mMdE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC+mMdE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094B21F000E9;
	Tue, 26 May 2026 02:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779763953;
	bh=q3p9sBqdPGDraE/qwD99JZCD3yWwcoiCE7TJPwjFP2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oC+mMdE6khaPyWAinAG68q+6tqzElGVrABFD7o0ZYd+i4Vh6m3h6pVTcVqk/sHmv2
	 AHX4oHSsvY1NMvC3/f6ocsnxiNppJM5u0iiJL2xy2BrlArk7pRS21egwSDn6cEwVHW
	 oTrVzj3bZmjNkIs4tC9+DMnm78/R8BtnEfvno/UuRI2bwwtbW7iz0T/OXTGR7VQrhS
	 rQfDvwFEAwc5XSehJBhf7ZjliejkpHXtm3OioTcWRunWAY0xi9XZEbHUxbbiO5sCvU
	 apD0yBh3qPLWmm1lZGeDNwTmm5a4uTKjEKe1u9bAAoTOMxUMq1pNxqpza+tQr6m+Qs
	 vHayrxrAx1phw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 09/11] selftests/bpf: Add test for
 memcg_bpf_ops hierarchies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <f2740b58570c06c275946f31f60858e875d7bdfe.1779760876.git.zhuhui@kylinos.cn>
References: <f2740b58570c06c275946f31f60858e875d7bdfe.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:52:32 +0000
Message-Id: <20260526025233.094B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test reuses the identical `low_mcg_ops` map for both the par=
ent and child overrides, failing to properly test the override mechanism an=
d clobbering its own state during cleanup.
- [Low] The test verifies that the third attachment fails but does not chec=
k if it fails with the correct error code (-EBUSY) as claimed in the commit=
 message.
--

commit ac1e7b9da1794e345399c9485b390263c35e79df
Author: Hui Zhu <zhuhui@kylinos.cn>
selftests/bpf: Add test for memcg_bpf_ops hierarchies

This commit adds a new selftest, test_memcg_ops_hierarchies, to validate
the behavior of attaching memcg_bpf_ops in a nested cgroup hierarchy. It
verifies the enforcement of the BPF_F_ALLOW_OVERRIDE flag across a
three-level deep cgroup subtree.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/t=
esting/selftests/bpf/prog_tests/memcg_ops.c
> index 19fd4fde22660..b4084e9327eba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> @@ -559,3 +559,76 @@ void test_memcg_ops_below_min_over_high(void)

[ ... ]

> +	skel =3D memcg_ops__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
> +		goto cleanup;
> +
> +	map =3D bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
> +	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name low_mcg_ops"))
> +		goto cleanup;
> +
> +	opts.target_fd =3D first;
> +	opts.flags =3D BPF_F_ALLOW_OVERRIDE | BPF_F_CGROUP_FD;
> +	link1 =3D bpf_map__attach_struct_ops_opts(map, &opts);
> +	if (!ASSERT_OK_PTR(link1, "bpf_map__attach_struct_ops_opts"))
> +		goto cleanup;
> +
> +	opts.target_fd =3D second;
> +	opts.flags =3D BPF_F_CGROUP_FD;
> +	link2 =3D bpf_map__attach_struct_ops_opts(map, &opts);

[Severity: Medium]
Is it intentional to reuse the identical low_mcg_ops map for both the
parent and child overrides?

Because the overriding pointer is physically identical to the overridden on=
e,
this might not genuinely prove that the kernel substituted the operations.

Also, could this clobber the state during cleanup since the kernel's
bpf_memcg_ops_unreg() clears descendant cgroups by checking map pointer
equality?

Would it be better to retrieve a distinct map, such as high_mcg_ops, for
the child cgroup to correctly test overriding?

> +	if (!ASSERT_OK_PTR(link2, "bpf_map__attach_struct_ops_opts"))
> +		goto cleanup;
> +
> +	opts.target_fd =3D third;
> +	opts.flags =3D BPF_F_CGROUP_FD;
> +	link3 =3D bpf_map__attach_struct_ops_opts(map, &opts);
> +	if (!ASSERT_ERR_PTR(link3, "bpf_map__attach_struct_ops_opts"))

[Severity: Low]
The commit message states that attaching another struct_ops to the deepest
cgroup fails with -EBUSY. Does ASSERT_ERR_PTR() only check for a generic
failure pointer?

Should this test explicitly verify that errno =3D=3D EBUSY to ensure the
hierarchical restriction logic is failing for the exact reason expected?

> +		goto cleanup;
> +
> +cleanup:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D9
