Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E62416CEC
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102904; cv=none; b=snZfjo5dDyl90EZjPWmQ0pzKfh8Hmi8zCqBEu0Kpmzgpmgze1aafUbigenRMIaPlqD2shoP1NBdgcY2fs9R0qPFHRpb0psqP53pXPG1+9wwPcLQ+RAO8Av7aiAPKsFDgKgK195sGwNk1ZhxQvNsSlvW8dk8oEhvSLQAssCCnsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102904; c=relaxed/simple;
	bh=k8dYNWTtlRLiT33VfIQ84qxgM+3q2MTqwR+zBxajFiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdNCC1k33Ej1WfUM+klehhV6JYtIEHTEUNG2nqRWB/r6yJgzcudo7qSr1HExxQh2fZwJSJFl1QRDIFm4ztQhvS1Vixkp4mN/cEl3RgkVEXCo8lpol3Zx6D7kKWAhepMMhezVRomPfGldAZfh31HXyOQveOXzuGd28jsc8ID4LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLxnpzXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLxnpzXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E831F00893;
	Wed, 10 Jun 2026 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102902;
	bh=kr3lAVjRvUzOV3fa4oqbRlAGisyuULMpieNUemeC5UY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLxnpzXbOpd1dMdV+ofALWGFl5NvleNvPhu+1ovNYoHt5t2Z13GfmVXHurX7r+uMk
	 pbq3C1rhrJJ7WZNLVjTSNPbfCE9u8poEhCrlKpdS7OYHPzHCGnLIic7JE0IJZhd3d1
	 4Uwn7T2ioC/G9C8Id+lWqxqIaDoh7yXhPhfJvJlo+0oZvdvVaaY/YtY82G0aWSQdGm
	 fMzgsOOKyGMcYn7WzvC28pMPwjTgls1Yj+fmw+QkV81MYVFtqM4ofGwFi0BFKRYxO3
	 c57Bdljcicu78M1VtwOFQh+6E+IKW2HW2QzhU1vGPesR66OxVoodpR3+YEMmhi1uCU
	 ij3dLzCk3inFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 5/6] selftests/bpf: Add uprobe_multi path_fd
 fail tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610143627.804790-6-jolsa@kernel.org>
References: <20260610143627.804790-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:48:21 +0000
Message-Id: <20260610144822.32E831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references an undefined struct member `path_fd` and an un=
declared macro `BPF_F_UPROBE_MULTI_PATH_FD`, which will cause compilation t=
o fail.
--

commit 0e3f7d4f9ed46a64d02a1c29acb4f8e2215cb7c0
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add uprobe_multi path_fd fail tests

This commit adds tests to the attach_api_fails suite to verify that
invalid setups using the new path_fd feature in uprobe_multi fail as
expected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -536,7 +536,37 @@ static void test_attach_api_fails(void)

[ ... ]

> -	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
> +	if (!ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong"))
> +		goto cleanup;
> +
> +	/* wrong path_fd */
> +	LIBBPF_OPTS_RESET(opts,
> +		.uprobe_multi.path =3D NULL,
> +		.uprobe_multi.path_fd =3D -1,
> +		.uprobe_multi.flags =3D BPF_F_UPROBE_MULTI_PATH_FD,

[Severity: Low]
Does this commit depend on a missing prerequisite patch?=20

The path_fd member and BPF_F_UPROBE_MULTI_PATH_FD macro do not appear to be
defined in the current tree's bpf_link_create_opts struct or UAPI headers,
which will cause a compilation failure here.

> +		.uprobe_multi.offsets =3D (unsigned long *)&offset,
> +		.uprobe_multi.cnt =3D 1,
> +	);
> +
> +	link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> +	if (!ASSERT_ERR(link_fd, "link_fd"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(link_fd, -EBADF, "path_fd_is_wrong"))
> +		goto cleanup;
> +
> +	/* path and path_fd both set with BPF_F_UPROBE_MULTI_PATH_FD flag */
> +	LIBBPF_OPTS_RESET(opts,
> +		.uprobe_multi.path =3D path,
> +		.uprobe_multi.path_fd =3D 1,
> +		.uprobe_multi.flags =3D BPF_F_UPROBE_MULTI_PATH_FD,
> +		.uprobe_multi.offsets =3D (unsigned long *)&offset,
> +		.uprobe_multi.cnt =3D 1,
> +	);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610143627.8047=
90-6-jolsa@kernel.org?part=3D1
