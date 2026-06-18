Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927833D4F2
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815503; cv=none; b=PwuuD7dhfjbVHkAvQDS+XEUg6B3L5JtwDbxHTlKEPuxBTqgf0Ola5ig00i0NDyygxpUhSuD5mUoqA4vEa//YRfeQ1YyFJaH1Bw8FIdOXN79TBSABp5EndGdUVPCGGzTxbj2PWPgyMng3bJ/luN+1DUYD3htdaFuM1nTE9cYUyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815503; c=relaxed/simple;
	bh=oAdM3oTR61VAjCn2NWHaTruFp6n3j1C18zCqJmXfV2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mCLDaeklYh/a887tTQzGdn6Gv6DqyNF8JmW3+idd+DIcjmQ7z6j+8hg/P8JQRDNwRvXpmKzRDq0JqzzTGIkINvYvjn2pUxRkiMT7TwYZovIoCARh4YqI6YsZvnSPj0PBBay3lCJBoF3+IJCCYpdZx9l8t54b5Kr6ECxwUU+2vIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP3P2f58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP3P2f58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16371F000E9;
	Thu, 18 Jun 2026 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781815501;
	bh=EivLXJbQruo/v5l88el6WMNSBbss/Uo39bsS/Bu1+o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gP3P2f582YCYYjgUXjecYHunDYQPPXYES+Kpr0nwDbi/t3qXMMIcCPLG4O4HH3Fzf
	 LLe9EZtU+5H7EiusyTq9gUUxce+Z/TYFUHgEBuZ7MtLoGN3jWe3kyAHSgXOjGWSO/6
	 xd0d7Xj6yF/4JIGWeckEWOmLJfl5Djlhax7aDIiOCe7l/+ARV4eoA/BVBSCCjGlDja
	 G7qWg5M4oCgIT5lO5B0+D1bSZoa+JrlQkEBJUuvX4NCJ8xP6ZmlvGJMXDNvAKFM/XZ
	 xRAstwjqhsp+get4CKc0xJx3djge6y2KtsZoAnc6+2hVd/8UudxcK6Gsk/BvF9xi81
	 c4t6aFMbl0UVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: paul@paul-moore.com, bpf@vger.kernel.org
In-Reply-To: <20260618203411.73917-3-dwindsor@gmail.com>
References: <20260618203411.73917-1-dwindsor@gmail.com>
 <20260618203411.73917-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 20:45:01 +0000
Message-Id: <20260618204501.C16371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Double free of the `extra` BPF link in the error path of `test_i=
nit_inode_xattr_attach_cap()`.
- [Medium] Test fails instead of skipping when the filesystem lacks xattr s=
upport (`EOPNOTSUPP`).
- [Low] Test uses `open` with `O_CREAT` without `O_EXCL` or unlinking first=
, leading to flaky failures if the file already exists.
--

commit 5953c8b908f6e9a4380d36de2bc7d988b3ec4923
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc

Test bpf atomic inode xattr labeling in inode_init_security.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> index 43a26ec69a8e3..0898898fb1253 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c

[ ... ]

> @@ -268,6 +269,102 @@ static void test_fsverity(void)
>  	remove(testfile);
>  }
> =20
> +static void test_init_inode_xattr(void)
> +{
> +	struct test_init_inode_xattr *skel =3D NULL;
> +	int fd =3D -1, err;
> +	char value_out[64];
> +	const char *testfile_new =3D "/tmp/test_progs_fs_kfuncs_new";
> +
> +	skel =3D test_init_inode_xattr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
> +		return;
> +
> +	skel->bss->monitored_pid =3D getpid();
> +	err =3D test_init_inode_xattr__attach(skel);
> +	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
> +		goto out;
> +
> +	/* Trigger inode_init_security */
> +	fd =3D open(testfile_new, O_CREAT | O_RDWR, 0644);
> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;

[Severity: Low]
If the file already exists from a previously aborted test run, will open()
without O_EXCL just open the existing file instead of creating a new one?

If so, this might bypass the inode_init_security hook the test relies on to
trigger the BPF program, causing unexpected failures. Would it be safer to
add O_EXCL or explicitly unlink the file beforehand?

> +
> +	ASSERT_EQ(skel->data->init_result, 0, "init_result");
> +
> +	/* initxattrs prepends "security." to the name. */
> +	err =3D getxattr(testfile_new, "security.bpf.test_label", value_out,
> +		       sizeof(value_out));
> +	if (err < 0 && errno =3D=3D ENODATA) {
> +		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
> +		       __func__);
> +		test__skip();
> +		goto out;
> +	}
> +	if (!ASSERT_GE(err, 0, "getxattr"))
> +		goto out;

[Severity: Medium]
Does this skip logic need to handle errno =3D=3D EOPNOTSUPP as well?

If the test runs on a filesystem that doesn't support xattrs at all (like
some tmpfs configurations), getxattr() might return EOPNOTSUPP. The test
would then fall through to the ASSERT_GE() check and fail rather than
gracefully skipping.

[ ... ]

> +static void test_init_inode_xattr_attach_cap(void)
> +{
> +	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] =3D {};
> +	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] =3D {};
> +	struct bpf_link *extra =3D NULL;
> +	int i, err;
> +
> +	/* Fill all available xattr slots */
> +	for (i =3D 0; i < INIT_INODE_XATTR_MAX; i++) {
> +		skel[i] =3D test_init_inode_xattr__open_and_load();
> +		if (!ASSERT_OK_PTR(skel[i], "open_and_load"))
> +			goto out;
> +
> +		link[i] =3D bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xat=
tr);
> +		if (!ASSERT_OK_PTR(link[i], "attach_within_cap"))
> +			goto out;
> +	}
> +
> +	skel[INIT_INODE_XATTR_MAX] =3D test_init_inode_xattr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel[INIT_INODE_XATTR_MAX], "open_and_load_extra"))
> +		goto out;
> +
> +	/* New additions fail with -E2BIG */
> +	extra =3D bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.tes=
t_init_inode_xattr);
> +	err =3D -errno;
> +	if (!ASSERT_ERR_PTR(extra, "attach_over_cap_should_fail")) {
> +		bpf_link__destroy(extra);
> +		goto out;
> +	}
> +	ASSERT_EQ(err, -E2BIG, "attach_over_cap_errno");
> +
> +	bpf_link__destroy(link[0]);
> +	link[0] =3D NULL; /* avoid double free in cleanup */
> +
> +	/* Freeing a slot lets the extra program attach */
> +	extra =3D bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.tes=
t_init_inode_xattr);
> +	ASSERT_OK_PTR(extra, "attach_after_detach");
> +
> +out:
> +	bpf_link__destroy(extra);

[Severity: Medium]
Can this cause a double free of the extra link if the first assert fails?

If extra is unexpectedly valid in the attach_over_cap_should_fail check,
bpf_link__destroy(extra) is called before jumping to the out label. Once
at the out label, bpf_link__destroy(extra) will be called a second time
on the exact same pointer since it wasn't set to NULL before the jump.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618203411.7391=
7-1-dwindsor@gmail.com?part=3D2
