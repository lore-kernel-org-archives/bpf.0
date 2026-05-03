Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2113A9D84
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777845598; cv=none; b=JvvD55bOQ74biilFBoBzoOTA4NJt/n1vmCzwlk5mi6nfb4iVDk0dUNzjwYj4YupERsYGb6KEA6bLYWXM2GY9UBP3Z6bNzgiV0ouQE0ef6MkZxRen4ab3t6w/K4UxtPFaP1QLwSgZuVkoscEZmw4gc0yMYpyFLTjFheuED3bpP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777845598; c=relaxed/simple;
	bh=f6qeSgrgy0PbQbD40ae5eS+0TiLIwJLgghCtxkdf9lY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mfyKNK1v4x8deZTEKCipBuIEiYk+EUsa+8D4bGhtlb1USyz1ekYxkIFg2kt7bXyjB5/HVwJ7kpXwe+kWaP6/OLvxZGYNEvh07vhlUz+n1DL58Cdtv2P9SOwho9EK36MDB+58eanzupFQFKH2bOnSdFhJXeJMaYw5QPSJeZMOFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig1bJXlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig1bJXlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4828CC2BCB4;
	Sun,  3 May 2026 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777845598;
	bh=f6qeSgrgy0PbQbD40ae5eS+0TiLIwJLgghCtxkdf9lY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ig1bJXlm+xeRc3jbEQtren13BOPdxx/L5yH4rn7dsf6gUcqb3SSVNXb9XR1PiAAiZ
	 hZ+MkQRMULlNnWreutNFsKlWQY8y0rw0RETxquL86cIme2GYmp7A+2LpE4/s25GWlq
	 ugTw2Pa2g6ktwIXjozoQnpFP6/k6bZaXN7Dt3xGDTthhbRGYIIkdLLIcJ46pPm6BVv
	 /41Rm2AyY+0OE5pic+dWtD8tdj1dMSHP7BIdxj2o1N5FI+E8eff5AXCmNB6dMqgWB3
	 +Onnx4vJadHKLK+nhp/SYDPGs+AS/btgN0MCSeCuKoF3q0ILmMiwQ9kjeLkjJ3tsrg
	 Om0ldiwqDi1Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
Reply-To: sashiko@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503211835.16103-2-dwindsor@gmail.com>
References: <20260503211835.16103-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 21:59:57 +0000
Message-Id: <20260503215958.4828CC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `bpf_init_inode_xattr` uses `GFP_KERNEL` for memory allocation, wh=
ich can cause filesystem deadlocks.
- [High] SELinux unconditionally reserves an xattr slot before returning -E=
OPNOTSUPP, creating a gap that causes subsequent LSM xattrs to be silently =
ignored.
- [Medium] `bpf_init_inode_xattr` returns `-EINVAL` instead of `-EOPNOTSUPP=
` when the filesystem does not support xattrs, creating a footgun that can =
break system-wide file creation.
--

commit 00cf871463d8e20da79c3ca19beea5e0a775a6d4
Author: David Windsor <dwindsor@gmail.com>

bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling

This commit adds the bpf_init_inode_xattr() kfunc to allow BPF LSM
programs to atomically set xattrs via the inode_init_security hook.
It encapsulates the xattr array and count into a new lsm_xattr_ctx
structure and updates existing callers to use it.

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..193accc00796 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> +static int __bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
> +				  const char *name__str,
> +				  const struct bpf_dynptr *value_p)
> +{

[ ... ]

> +	xattrs =3D xattr_ctx->xattrs;
> +	xattr_count =3D xattr_ctx->xattr_count;
> +	if (!xattrs || !xattr_count)
> +		return -EINVAL;

Does returning -EINVAL here break file creation on filesystems that do not
support xattrs?

For filesystems like pipefs or procfs, the initxattrs callback passed to
security_inode_init_security is NULL, making xattr_ctx->xattrs NULL. If
a BPF program propagates this -EINVAL return value directly from the
inode_init_security hook, the core VFS wrapper treats it as a hard error
and aborts inode creation entirely.

Could this return -EOPNOTSUPP instead to align with other LSMs and allow
the core code to gracefully ignore the unsupported operation?

[ ... ]

> +	value_len =3D __bpf_dynptr_size(value_ptr);
> +	if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	value =3D __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value =3D kmalloc(value_len + name_len + 1, GFP_KERNEL);
> +	if (!xattr_value)
> +		return -ENOMEM;

Could this GFP_KERNEL allocation cause an ABBA deadlock?

The inode_init_security LSM hook is executed during VFS file creation
(e.g., vfs_mkdir, vfs_create), typically while the caller holds critical
filesystem locks or active journal transactions.

Calling kmalloc with GFP_KERNEL allows the memory allocator to sleep and
enter direct memory reclaim. This might attempt to flush dirty pages or
free inodes on the same filesystem, recursively attempting to acquire
the exact same locks.

Should this use GFP_NOFS, similar to how the core
security_inode_init_security wrapper and other LSMs handle allocations
in this hook?

[ ... ]

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..dca81a22bf83 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

>  static int selinux_inode_init_security(struct inode *inode, struct inode=
 *dir,
>  				       const struct qstr *qstr,
> -				       struct xattr *xattrs, int *xattr_count)
> +				       struct lsm_xattr_ctx *xattr_ctx)
>  {
>  	const struct cred_security_struct *crsec =3D selinux_cred(current_cred(=
));
>  	struct superblock_security_struct *sbsec;
> -	struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
> +	struct xattr *xattr =3D lsm_get_xattr_slot(xattr_ctx);
>  	u32 newsid, clen;
>  	u16 newsclass;
>  	int rc;

This isn't a bug introduced by this patch, but does allocating the xattr
slot here cause subsequent LSM xattrs to be silently ignored if SELinux
later returns -EOPNOTSUPP?

selinux_inode_init_security calls lsm_get_xattr_slot unconditionally
at the beginning of the function. If it subsequently decides not to
provide an xattr (e.g., if the mount does not support labeling), it
returns -EOPNOTSUPP.

Since the slot has already been consumed and the count incremented, the
reserved slot's name pointer is left as NULL. The filesystem's
initxattrs iterators loop over the array and terminate early upon
encountering name =3D=3D NULL, which causes any valid xattrs added by
subsequent LSMs (like EVM or this new BPF kfunc) to be dropped and
ignored instead of being written to disk.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503211835.1610=
3-1-dwindsor@gmail.com?part=3D1
