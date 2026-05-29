Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593A26ED59
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095126; cv=none; b=Mv1h9V0Y+fUXwan23jkBl+wMJvtsaOzeIaMuVixOLQLU5D9aoMW5dNfzS0pFPRUAYcNiwWCEAjTnEyW5HpsLWqao4shbxItmCckg4xDxQwN16+1sLQiklRK2a358a4/wxEpC1qW45msmlxUWUIj/BJ5HfxtyipU/yEZxRBqLIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095126; c=relaxed/simple;
	bh=m/Kpl7kMFbaD6IS9F0wm6VyRgIkEPPV+/ES7Lpp8z50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BUiwFejTfw/7kXZGMdqMj07xpcFM6yyTAK1qGXViye0bUm9D334F5q4e1HU3vrXqZERuovLBWB1Y0D3v248K1KNvNsiFOumr/+Q31P8o41B+eYadkwglM8eOyFTJrfHjUnrT439GntbujkezsUFcxVD0BqzIUBw7NhTq/6rokvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWZ92oTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWZ92oTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBAE1F00893;
	Fri, 29 May 2026 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095124;
	bh=WWpmU1h+aPE63X0ipL8iv5R2Wi7uc/eCAxl/br/5olk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWZ92oTV5pM/qv75SmkGuAOeWqUY+6UdABRMcVpsbzJznBdwYAzpfOXRAFXtnlQd4
	 51keDdsUNQuj81I5HYS99+9U73eSHNfDNo5IPkTL9W20tGVrwt9pKBW5RYUFOB0Q6b
	 ZzhhsQZpMOyJulbTiPKjw8Lq6ZcCT5O0km49lxeeNlqIiulFEAoI+5xFmCuVgDeZwf
	 kzHSerrKyJQJ2qWLot4ZDCbfacSNuXGn28Yrx0V7VXMQbxaX3qNjCU7sf5XWtLcZFY
	 hjewrVAFyHH9NvxBKw6u9AR8Em624XcvLdeswrMk58IhPGA2kp6sYzA+GlVpX0rPoc
	 ojJ7OHDovmd1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH vfs-7.2.xattr v2] bpf: Add simple xattr support to bpffs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529221234.324174-1-daniel@iogearbox.net>
References: <20260529221234.324174-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 22:52:04 +0000
Message-Id: <20260529225204.ADBAE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch relies on an out-of-tree or obsolete version of the =
VFS simple_xattr API, leading to hard compilation failures and potential me=
mory corruption.
- [High] The per-inode xattr quota limits can be underflowed by removing in=
itial security xattrs, allowing unprivileged users to bypass the `SIMPLE_XA=
TTR_MAX_SIZE` and `SIMPLE_XATTR_MAX_NR` limits.

Pre-existing issues:
- [High] `bpf_symlink` allocates symlink target strings without memcg accou=
nting, allowing an unprivileged user to bypass memory limits and exhaust ke=
rnel memory.
--

commit 5eef577d514964df263d306b47c480c2c453a101
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Add simple xattr support to bpffs

This commit adds extended attribute support to bpffs inodes. It allows user
space and BPF LSM programs to attach metadata like security labels to pinned
objects or directories. The trusted and security namespaces are supported
using in-memory simple_xattr infrastructure.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
[ ... ]
> @@ -1918,6 +1919,8 @@ struct bpf_mount_opts {
>  	u64 delegate_maps;
>  	u64 delegate_progs;
>  	u64 delegate_attachs;
> +
> +	struct simple_xattr_cache xa_cache;
>  };

[Severity: Critical]
Does this rely on an out-of-tree version of the VFS simple_xattr API?
The struct simple_xattr_cache does not exist in the mainline tree, which
causes a compilation failure here.

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
[ ... ]
> +struct bpf_fs_inode {
> +	struct list_head		xattrs;
> +	struct simple_xattr_limits	xlimits;
> +	struct inode			vfs_inode;
> +};

[Severity: Critical]
Could this cause memory corruption due to a struct layout mismatch?
The mainline simple_xattr API requires struct simple_xattrs (which embeds
an rhashtable) rather than a list_head.

[ ... ]
>  static int bpf_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		       struct dentry *dentry, const char *target)
>  {
> -	char *link =3D kstrdup(target, GFP_USER | __GFP_NOWARN);
>  	struct inode *inode;
> +	char *link;
> +	int ret;
> =20
> +	link =3D kstrdup(target, GFP_USER | __GFP_NOWARN);

[Severity: High]
This isn't a bug introduced by this patch, but does this code bypass memory
cgroup accounting?=20

The string allocation in bpf_symlink() lacks __GFP_ACCOUNT. Because bpffs
is an in-memory filesystem with no maximum limits, an unprivileged user
inside a container with write access could repeatedly create symlinks with
large targets and exhaust host kernel memory without triggering their
memory limits.

[ ... ]
> +static int bpf_fs_xattr_set(const struct xattr_handler *handler,
> +			    struct mnt_idmap *idmap, struct dentry *unused,
> +			    struct inode *inode, const char *name,
> +			    const void *value, size_t size, int flags)
> +{
[ ... ]
> +	if (handler->flags =3D=3D BPF_FS_XATTR_SECURITY) {
> +		err =3D simple_xattr_set_limited(&opts->xa_cache, &bi->xattrs,
> +					       &bi->xlimits, name, value, size,
> +					       flags);

[Severity: Critical]
Is the argument count correct for simple_xattr_set_limited()? The current
upstream API expects 6 arguments, but this code passes 7 (including the
obsolete xa_cache).

[Severity: High]
Can this lead to an atomic underflow of the xattr quota limits?=20

Since bpffs is FS_USERNS_MOUNT, an unprivileged user in a user namespace
can modify security.* xattrs. If they remove or replace an initially seeded
xattr, simple_xattr_set_limited() will decrement the limits. Because those
limits were never incremented during initialization, this causes an
underflow. The counters would wrap to negative values, effectively
disabling the SIMPLE_XATTR_MAX_SIZE limit and allowing unbounded memory
allocation.

[ ... ]
> +static int bpf_fs_initxattrs(struct inode *inode,
> +			     const struct xattr *xattr_array, void *fs_info)
> +{
[ ... ]
> +	for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
> +		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
[ ... ]
> +		if (simple_xattr_add(&opts->xa_cache, &bi->xattrs, new_xattr))
> +			break;

[Severity: High]
Does this code bypass the quota limits increment?

Initial LSM security xattrs added directly via simple_xattr_add() in
bpf_fs_initxattrs() do not increment the quota counters in bi->xlimits.
This sets up the underflow condition mentioned in bpf_fs_xattr_set() when
an unprivileged user later replaces or removes these xattrs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529221234.3241=
74-1-daniel@iogearbox.net?part=3D1
