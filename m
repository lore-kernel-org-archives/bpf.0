Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACF2233A
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252224; cv=none; b=ASSGe+1bszV1DrWoho5WWl0l4mKhjnyVrbO2Vb6YPa+ZL7PHA4EwDXAy8RZAL/et6vL23c07ASnuFFiaRvnAO1EHR8K623nF1RnAIXQJnef8jKi1YoyKHrgpJf5ZmRVGRloR2MFjieTda5X37laoRPHvANXgYyXubAYFo4y2kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252224; c=relaxed/simple;
	bh=4xbb5bbDrPNVB5XEpqJsNjug6e3n2kAVJ+RJDZPrdN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uj30DxwLlUVhnDHSZWYf5eOTaNmgs+GJgWzu0Gd1m/Soni1a7MiUaz4ksTkCJ1KFIOI8fo7iDIIaaYhl72xLdEd/zt2gY7m3SQyFNLT7NGdRMtPgfCg0WvrP85Zj42Ml9NpX9xf/PoPSq1/uRWkiZ88jFMq9I4vgMEAXfIka1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAT0O9/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAT0O9/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5D9C2BCAF;
	Mon, 27 Apr 2026 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777252224;
	bh=4xbb5bbDrPNVB5XEpqJsNjug6e3n2kAVJ+RJDZPrdN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IAT0O9/TxkuOaymzFqmMABs5dliQSCSjNCzLflaO2/b2JDaVrTlegtqdnitPkngdg
	 h6daDDl5a56+/vtLJf4i0/AcPD13+ru61H30+Fm7DPICOOlYQZXQiM5HQ2eBNcu7mF
	 8Letm5pk3+VP91LhR/RmJxFZfGcXuAPS1js/4+QLp3cJy9lVot+ApSs0sfoUuA1551
	 GxGEKf9kew0VUwukVjCn6DYB4YxzSC+3WD7DK02z83skm8zhgPRxSwlvUZEHqDX2so
	 OKx0g/Fp1jjumuDtSiwJO+xcGDNiJjiWNMzaKojOHhyykpPioPTZhrcP+GXk4r5hll
	 WghIoaIA4g8FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427001602.38353-3-dwindsor@gmail.com>
References: <20260427001602.38353-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 01:10:23 +0000
Message-Id: <20260427011024.7A5D9C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] Test flakiness due to missing file removal before open(O_CREAT).
- [Medium] Test fails instead of gracefully skipping on filesystems without=
 xattr support.
- [Low] Uninitialized stack memory read if getxattr returns an unexpected l=
ength.
- [Low] Insecure temporary file creation in world-writable directory.
- [Low] Closing uninitialized file descriptor on error paths.
--

commit b0095935131688a0b976829cf24db472a2eab938
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc

This commit adds selftests for the bpf_init_inode_xattr kfunc to test
atomic inode xattr labeling via the inode_init_security hook.

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

Could value_out be read while uninitialized?

If getxattr() succeeds but returns fewer bytes than expected, the size
ASSERT_EQ check will fail but execution will continue. The subsequent
strncmp() might then read uninitialized stack memory.

Would it be better to zero-initialize this buffer, or use
if (!ASSERT_EQ(...)) to abort the test early?

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
> +	/* Create a new file =E2=80=94 this triggers inode_init_security */
> +	fd =3D open(testfile_new, O_CREAT | O_RDWR, 0644);

If this test file already exists from a previous failed run, will open() ju=
st
open the existing file without triggering the inode_init_security hook?
Since the hook only fires when a new inode is instantiated, this would cause
the test to persistently fail.

Also, since this runs as root in the world-writable /tmp directory, could
this predictable path be vulnerable to a symlink attack?

Would adding O_EXCL to the open flags ensure both that the hook is triggered
and prevent symlink issues?

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->data->init_result, 0, "init_result");
> +
> +	/* The initxattrs callback prepends "security." to the name */
> +	err =3D getxattr(testfile_new, "security.bpf.test_label", value_out,
> +		       sizeof(value_out));
> +	if (err < 0 && errno =3D=3D ENODATA) {

If the underlying /tmp filesystem does not support extended attributes at
all, getxattr() returns -1 with errno set to EOPNOTSUPP (or ENOTSUP).

Should this condition also be handled to correctly skip the test instead of
failing on the next ASSERT_GE check?

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
> +
> +out:
> +	close(fd);

If an error occurs before the file is opened (e.g. during skeleton load
or attach), fd will be -1. Does this result in an unnecessary close(-1)
which returns -EBADF?

Should this be guarded with if (fd >=3D 0)?

> +	test_init_inode_xattr__destroy(skel);
> +	remove(testfile_new);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427001602.3835=
3-1-dwindsor@gmail.com?part=3D2
