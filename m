Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFC370D6D
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846322; cv=none; b=fmBHd7Y/KsEdBfdzvOA5bwJePF9d83T7NzLHPunzEZwVZJYpZ0qt1uUn/oarCngzP/WlEDsJ69dzfjWTtsFI97KCxQBoNUKvllDcV8JoB3uImnZWT1Ep3xhWLRzmm63hH3dqxanNzhxD4MCbvLUpNQCyEKjSAf2y42Xe4iFSzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846322; c=relaxed/simple;
	bh=bDnnwCVn9aHfiRddj3/UTVA8YKrQGCPk0TyyNAiPaNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q0iQAM4lk2zIsDsES1wIC3Gn3Mlsp/l4Vc5kIH/rl1rzsB5auqxP+9j5Ehl6YvQRjuL8wpjpbFMwMW+bCErErTV8vsQO5G0HtCiKqekopvRAhibNmVq4/dCv0F6JVEqZ/c2pWBYXfFTUi/Oyw+QNJLQCAg6YtyTIbfDBpfcXXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1l3Mr1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1l3Mr1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD1BC2BCB4;
	Sun,  3 May 2026 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777846322;
	bh=bDnnwCVn9aHfiRddj3/UTVA8YKrQGCPk0TyyNAiPaNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S1l3Mr1fLgiF55qoQEiIsz5d0XuB0aZsrrED7XwSJwVZ5A5Ii+pmWrCYUQ54yCDWq
	 kjtxidlVJdPBpfB8NKMG2J9x78hKcxP4W0bxDRgEsCFmvcrnyxMLMBp2l7fAbMueFu
	 mhQMaaOZQwdWCgHbGc67CCjozlm6cPStDboPkCRNCRcvgRg7dLLK2j5pM5fed4SSO5
	 SaPG9V2sq4Cj+aUd2c0YYRArtvmS3U+kdZKklRsJNXD29R/xFrOGD+Wl5bHzpw+CIc
	 GD/4vlEzIepWA8jLKUjki17DxhUWWGDyTr2bbZNvBNo87hmfME7aI8lYPXUyNF6T26
	 ZGdeyaJZ10Ekg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503211835.16103-3-dwindsor@gmail.com>
References: <20260503211835.16103-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 22:12:01 +0000
Message-Id: <20260503221201.DFD1BC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test will fail spuriously if the target test file already ex=
ists.
- [Medium] Uninitialized stack memory is read if `getxattr` returns a small=
er length than expected.
- [Low] The test fails instead of gracefully skipping on filesystems that d=
o not support xattrs.
--

commit 96e5b274b42a271a01409d6e21dc11302496f1d3
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc

This commit tests BPF atomic inode xattr labeling via the
inode_init_security LSM hook.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> index 43a26ec69a8e..26daef116ee2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
[ ... ]
> @@ -268,6 +269,51 @@ static void test_fsverity(void)
>  	remove(testfile);
>  }
> =20
> +static void test_init_inode_xattr(void)
> +{
> +	struct test_init_inode_xattr *skel =3D NULL;
> +	int fd =3D -1, err;
> +	char value_out[32];
> +	const char *testfile_new =3D "/tmp/test_progs_fs_kfuncs_new";
[ ... ]
> +	/* Create a new file =E2=80=94 this triggers inode_init_security */
> +	fd =3D open(testfile_new, O_CREAT | O_RDWR, 0644);

Could this cause spuriously failing tests if the file already exists from a
previous, aborted run?

If the file exists, no new inode is created, so the inode_init_security
hook won't be triggered, leaving init_result at -1.

Should we unlink the file before opening it, or use the O_EXCL flag to ensu=
re
we're creating a new inode?

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->data->init_result, 0, "init_result");
> +
> +	/* The initxattrs callback prepends "security." to the name */
> +	err =3D getxattr(testfile_new, "security.bpf.test_label", value_out,
> +		       sizeof(value_out));
> +	if (err < 0 && errno =3D=3D ENODATA) {

Will this fail the test instead of gracefully skipping it on filesystems
that don't support extended attributes?

If the filesystem lacks xattr support (like some tmpfs configs), getxattr
will return -EOPNOTSUPP.

Could we broaden the check to include EOPNOTSUPP?

> +		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
> +		       __func__);
> +		test__skip();
> +		goto out;
> +	}
> +	if (!ASSERT_GE(err, 0, "getxattr"))
> +		goto out;
> +
> +	ASSERT_EQ(err, (int)sizeof(skel->data->xattr_value), "xattr_size");
> +	ASSERT_EQ(strncmp(value_out, "test_value",
> +			  sizeof("test_value")), 0, "xattr_value");

Could this lead to an uninitialized stack memory read?

If getxattr returns a smaller size than expected, the size assertion will
fail, but execution will continue to strncmp since there is no goto out.
Because value_out is uninitialized, strncmp may read garbage data and
trigger KMSAN errors.

Would it be better to wrap the size assertion with if (!ASSERT_EQ(...))
goto out, or zero-initialize value_out?

> +
> +out:
> +	close(fd);
> +	test_init_inode_xattr__destroy(skel);
> +	remove(testfile_new);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503211835.1610=
3-1-dwindsor@gmail.com?part=3D2
