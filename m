Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B87173
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259394; cv=none; b=MPC/VWp2BbKdDYEvbp2zDwUPmBPyzhq1DPN2bmUGYu42a+AmVKFB6lx0DGwvt2l5JUlSuXEQsViuYiFkpuUihUPpJeLIlJ7WEGtORfR49nmM4cGJYlxFFEYdKPGbKeO+A0oWegYTBqFzxPEKw3kKls8ekCra3ceTeE9sVVUv1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259394; c=relaxed/simple;
	bh=zkZvD+UYKje+3xKPYO81GrzxG1VQ/g65EXXpKj16XwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nVPQbsM7pm+a6dopCrRovyOpzhdVhj61HEhxkDaFNVTuJ2SKlPUlQEH+mQ29ew0IIxeFE2xYTOJR36TrDT2PV/FSSJ9+S4Q3OVZIUruZEoKmRYBSeGlHEhdoD1idMaekJOLSLR2CQS1gj3wRZivOhdP6gsLIiT5/rHoE6SbyO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTwv5qAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTwv5qAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6581F000E9;
	Wed, 24 Jun 2026 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782259392;
	bh=4N2gJ9qPXIRZUXaK7xZ9aBBv68PUQA9QYFwVqxzbQSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTwv5qAv408TCUdFBzvdmARCQWqQLBNhNCVJClgz2brUv/p3avMtDaaa9wO7Sribp
	 QGMzkNEw7oxscpyQ87bphmomHm+gIhn900bJkEwPZKf8uK3/gadWyIcgD5qD3bV2gb
	 WZkxDFtGa4rFMfQkC7molo0di27IqssHt+WPD6ArssH0dKHxx4nXcCwIvn3MGfD8Y7
	 xgYURYCwT7Dlff26KLZjMxa4bB4vel7meQWeZ41pfRwOeCxRlmAAaV/wFWh2oh2Y+S
	 wqYMBwjPkd7U9VR4QrWcZtpTnN3IQVj9Z3PHz//jgV3mINLHtUlRufb10NQDMZXURB
	 io/Lmhze3VrTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/15] selftests/bpf: Test attaching
 struct_ops to a cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-15-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-15-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 00:03:12 +0000
Message-Id: <20260624000312.AD6581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test state pollution in the `inherit` subtest bypasses the inten=
ded `cgroup_bpf_inherit()` testing path because the child cgroup persists f=
rom the previous `hierarchy` subtest.
--

commit 9dd80df6f86c72623dac7d2f203da4036e4e8827
Author: Martin KaFai Lau <martin.lau@kernel.org>
Subject: selftests/bpf: Test bpf_tcp_ops cgroup generic link

This commit adds selftests for attaching bpf_tcp_ops struct_ops to cgroups =
via
the generic cgroup link infrastructure. The tests validate various behaviors
including execution order, query interfaces, updates, and inheritance.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
> new file mode 100644
> index 000000000000..4d087bdc4613
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c

[ ... ]

> +static void run_hierarchy_subtest(void)
> +{
> +	struct bpf_tcp_ops *skel =3D NULL;
> +	struct netns_obj *ns =3D NULL;
> +	int parent_fd, child_fd =3D -1;
> +
> +	parent_fd =3D test__join_cgroup(CGROUP_PATH);
> +	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
> +		return;
> +
> +	child_fd =3D create_and_get_cgroup(CGROUP_PATH "/child");
> +	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
> +		goto done;
> +
> +	if (!ASSERT_OK(join_cgroup(CGROUP_PATH "/child"), "join_child_cgroup"))
> +		goto done;
> +
> +	ns =3D netns_new(TEST_NETNS, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto done;
> +
> +	skel =3D bpf_tcp_ops__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto done;
> +
> +	test_hierarchy(parent_fd, child_fd, skel);
> +
> +done:
> +	bpf_tcp_ops__destroy(skel);
> +	netns_free(ns);
> +	if (child_fd >=3D 0)
> +		close(child_fd);
> +	close(parent_fd);
> +}

[Severity: Medium]
Does this code leak the child cgroup and pollute the state for the inherit
subtest?

Because the child cgroup is not explicitly removed here (e.g., via
remove_cgroup()), the directory persists in the filesystem after the file
descriptor is closed.

When test_inherit() runs immediately afterward, its call to
create_and_get_cgroup() will re-open this existing cgroup instead of creati=
ng a
new one. This causes test_inherit() to silently bypass the intended
cgroup_bpf_inherit() testing path, and instead exercise the
cgroup_bpf_update_effective() path during the parent attachment.

[ ... ]

> +static void test_inherit(int parent_fd, struct bpf_tcp_ops *skel)
> +{
> +	struct bpf_link *plink =3D NULL;
> +	int child_fd =3D -1;
> +
> +	plink =3D bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, parent_fd, N=
ULL);
> +	if (!ASSERT_OK_PTR(plink, "attach_parent"))
> +		goto done;
> +
> +	child_fd =3D create_and_get_cgroup(CGROUP_PATH "/child");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D14
