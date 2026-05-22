Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43E2F28E3
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461300; cv=none; b=RVPVBVsUjXkV/xdYrxanJxwi80qMqO/DOIRsMnu8+q4QMC8YxVPXbFGTZ1ipiYyPTxjnNal/DO1JHmb9A8T3Chkbchm4GuY8NNOszOG2uc1ecXrWsna2qu43GENC7ms1qSFl2We9Fj56KGAATi9U4LFL0cRmLQIq6KC5V8irPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461300; c=relaxed/simple;
	bh=kahulLXVs2gebZttEn5I0KmOoBBiLS3zFm0xahEo05A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZFGRN6+DLRF7quwNqhgRP/6xY/3eDLmAACpVTF6oY8/+CvOcwcgiLmvK2NIABba8nuZT52ZtmYUkj2pSqORiPWNJF8ecb1hw5n3xVBv9ElDl7XWjaY1+kKz2nCw+em0Hwn0SYo9P044+1nlDHXmAyO5Sm2arVaGbYwdUpcdueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXlotj9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXlotj9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7EB1F000E9;
	Fri, 22 May 2026 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461299;
	bh=1BQLQ0CgvRrz5tZEY0CYjrlwvjvvF+xmmmC43fIL9JA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXlotj9JAsC3tYsrhLuRb64OhdRyvKzf7SmwXhIinkK+YzCAsj10YUOg5LibHlrKQ
	 t2Hoj5osqqpd2UDct439+fwhRBcmbaRSLYPWz7/tV+GdCM44TvcuNvvwJlwLidX5Xt
	 ZtZjjILb69LxIV2fscLHP1ddg7GE0rwAYenpeLYFS4HAhKUUMFHZ2/+JWlxt7nYBWg
	 I2y45ExkSlY78RuiTQJYCehkO+fvwQxfUPnX3oOVmVjZN27zXEUcKUoZxJJDgm8oI5
	 PpnVUnUGoxt5W0dCXHCK+DVve83ItAybgyQyZXmR6sqDfGzBxcfDFv8iisuZMb8Uc6
	 X3Z16pMmE4k4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: Add simple xattr support to bpffs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522135626.120732-1-daniel@iogearbox.net>
References: <20260522135626.120732-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 14:48:18 +0000
Message-Id: <20260522144818.DD7EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unprivileged users can exhaust kernel memory via unbounded user.* =
extended attributes on bpffs.
- [High] NULL pointer dereference in bpf_fs_initxattrs() if an LSM returns =
a NULL xattr value.
--

commit 57543eec66ace3d4d002256a01cff4f1797f61e2
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Add simple xattr support to bpffs

This commit adds support for extended attributes on bpffs inodes, allowing =
user
space and BPF LSM programs to attach metadata to pinned objects or director=
ies.
The xattr store is in-memory and lives only for the lifetime of the mount.

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a0118258..638aa996cbaf4 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c

[ ... ]

> @@ -762,22 +821,151 @@ static int bpf_show_options(struct seq_file *m, st=
ruct dentry *root)
>  	return 0;
>  }

[ ... ]

> +static int bpf_fs_xattr_set(const struct xattr_handler *handler,
> +			    struct mnt_idmap *idmap, struct dentry *unused,
> +			    struct inode *inode, const char *name,
> +			    const void *value, size_t size, int flags)
> +{
> +	struct bpf_fs_inode *bi =3D BPF_FS_I(inode);
> +	struct simple_xattrs *xattrs;
> +	struct simple_xattr *old;
> +
> +	name =3D xattr_full_name(handler, name);
> +	xattrs =3D simple_xattrs_lazy_alloc(&bi->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
> +	old =3D simple_xattr_set(xattrs, name, value, size, flags);

[Severity: High]
Does this code allow an unprivileged user to exhaust kernel memory?

Because bpffs can be mounted in an unprivileged user namespace
(FS_USERNS_MOUNT), a user could create directories and repeatedly set user.*
extended attributes.

Since simple_xattr_set() does not enforce per-inode limits like
simple_xattr_set_limited() does, couldn't this lead to an unbounded memory
allocation and soft lockups during rhashtable traversals?

> +	if (IS_ERR(old))
> +		return PTR_ERR(old);
> +	simple_xattr_free_rcu(old);
> +	inode_set_ctime_current(inode);
> +	return 0;
> +}

[ ... ]

> +static int bpf_fs_initxattrs(struct inode *inode,
> +			     const struct xattr *xattr_array, void *fs_info)
> +{
> +	struct bpf_fs_inode *bi =3D BPF_FS_I(inode);
> +	const struct xattr *xattr;
> +	size_t len;
> +
> +	CLASS(simple_xattrs, xattrs)();
> +	if (IS_ERR(xattrs))
> +		return PTR_ERR(xattrs);
> +
> +	for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
> +		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
> +		if (IS_ERR(new_xattr))
> +			break;
> +
> +		len =3D strlen(xattr->name) + 1;
> +		new_xattr->name =3D kmalloc(XATTR_SECURITY_PREFIX_LEN + len,

[Severity: High]
Can this cause a NULL pointer dereference?

If an LSM program returns a NULL xattr value, the simple_xattr class
constructor will call simple_xattr_alloc() which can return NULL.

The IS_ERR(new_xattr) check evaluates to false for a NULL pointer, leading
to a NULL pointer dereference when accessing new_xattr->name here.

> +					  GFP_KERNEL_ACCOUNT);
> +		if (!new_xattr->name)
> +			break;
> +
> +		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
> +		       XATTR_SECURITY_PREFIX_LEN);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522135626.1207=
32-1-daniel@iogearbox.net?part=3D1
