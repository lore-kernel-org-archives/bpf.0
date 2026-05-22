Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D1386450
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462007; cv=none; b=Ff0bz5Gm+20gncCiu1pVgz8+4KDMZUhXKgaNn+2Jy1BUgI9fchrNFVjj3AXSbJO6F0LfZyPlGeF3v50nksEzS/ahBl6wVamk/O9QNAH7EybGrV21o/VNh6dwBA/F2xi/Ny8Pt3OQqh7dgX3e2M9Tg4r4aApoLwzAD4tePpdpFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462007; c=relaxed/simple;
	bh=oAZ04sJhuG8qV9Cybcw2Il9Ow6uFuXxfOJ4UM6vM4VM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLW8whXq1gRWlR1yZeI8b/Tvaa7Bi+T62iWbhKzsmAZQETs9lxHc5B7/urtKhW/UH7jMASH5uLyn90/CcF+baOq7RxSHnD5m/9o+gyjxbX/3dHZhftJzE8EH3Xc/wupOD+6rtkkEf13PLoDle1YnGTLIxul31UfVjjerYapWfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffVxWHrH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffVxWHrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863311F00ADE;
	Fri, 22 May 2026 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462003;
	bh=j3PmHRxUE9v1bwz3IpJDs8tUC8breqTVX9FmQwfQQxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffVxWHrHx9vkmIQpaq/ViTcvdR7F9ou2v5+d+WyqPb0lrUJ7JJs/HK4R99+RyFyTm
	 +Q1aYdG0wYziyCRzGbm8WIAHTBckPG6kGG/EG2J+WeTrZXgcYT9XBhCBG394qAXToi
	 OQhg7L7xuG5pH27ZAsgoulcLP7rxjiw4uLe2mxz5Vl6t1mvyZviMFyZByOBgTLVes8
	 jALXweNncwM53BLu2zTttawAq6y5e0P69FnoEvhlk/Mvmyp7totCNSLROsec3gFsWh
	 JhulHkUXyHeoevucX4ChRS2gO4zCCFM/dHRTwndr8YxeSZU51M+t+WvEb4NUpdxwlC
	 kaCCRVd1TE29A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add bpffs xattr API
 coverage test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522135626.120732-2-daniel@iogearbox.net>
References: <20260522135626.120732-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 14:59:53 +0000
Message-Id: <20260522145953.863311F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_umount_lifetime` attempts to verify that root dir=
ectory xattrs are cleared upon umount, but trivially succeeds because the x=
attr was never actually set on the root directory.
--

commit eee62f5b4a9e13a37724984ba00f475e46c7075f
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add bpffs xattr API coverage test

This commit adds basic bpffs xattr API coverage tests, including validation
of supported namespaces, flag semantics, inode types, and mount-scoped
lifetimes.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpffs_xattr.c b/tools=
/testing/selftests/bpf/prog_tests/bpffs_xattr.c
> new file mode 100644
> index 0000000000000..3d02e30da338e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpffs_xattr.c

[ ... ]

> +static void test_umount_lifetime(void)
> +{
> +	char dir[64], path[128], buf[16];
> +	int map_fd =3D -1, err;
> +
> +	if (!ASSERT_OK(mount_bpffs(dir), "mount"))
> +		return;
> +	snprintf(path, sizeof(path), "%s/m", dir);
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "x", 4, 4, 1, NULL);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		goto out;
> +	if (!ASSERT_OK(bpf_obj_pin(map_fd, path), "pin"))
> +		goto out;
> +	ASSERT_OK(setxattr(path, "user.k", val_a, sizeof(val_a), XATTR_CREATE),
> +		  "set");
> +
> +	close(map_fd);
> +	map_fd =3D -1;
> +
> +	if (!ASSERT_OK(umount(dir), "umount"))
> +		goto out;
> +	if (!ASSERT_OK(mount("bpf", dir, "bpf", 0, NULL), "mount_fresh"))
> +		goto out;
> +
> +	err =3D access(path, F_OK);
> +	ASSERT_EQ(err, -1, "path_gone_ret");
> +	ASSERT_EQ(errno, ENOENT, "path_gone_errno");
> +
> +	err =3D getxattr(dir, "user.k", buf, sizeof(buf));

[Severity: Medium]
Does this test actually verify the root directory's xattr lifetime?

It looks like the user.k xattr is set on the pinned map file (path) earlier
in the function, but after remounting, this check looks for the xattr on the
mount root (dir).

Because user.k was never set on dir initially, won't this check trivially
succeed with ENODATA?

> +	ASSERT_EQ(err, -1, "root_xattr_gone_ret");
> +	ASSERT_EQ(errno, ENODATA, "root_xattr_gone_errno");
> +out:
> +	if (map_fd >=3D 0)
> +		close(map_fd);
> +	umount(dir);
> +	rmdir(dir);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522135626.1207=
32-1-daniel@iogearbox.net?part=3D2
