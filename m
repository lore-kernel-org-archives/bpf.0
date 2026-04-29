Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060F3B3881
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500606; cv=none; b=r68FPvTpZDEQ19k5+ZAqoObQRJS6aD9fremv9BcVzkpYllG652L4YmuTM8tLZpBW2mDkk8UIIv7FYtQH82UYS35WHltWu/Hr6TNezpp4cNX2kfOflG9GirBhmJ5U460Ciz4yDWn9xOYlqlExfr+1Ea5INLHslmKd1fgyHVZeJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500606; c=relaxed/simple;
	bh=RC6JQ68RlC5gYkIgGOuBNqUCe87K1v0o203SkmAFyCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtlZS3prMOC/ACY7b1aPKUlmuOPiCs0+L8J10cAma+YvHb3zdZ3hBhA40z7hukaGODvfZsWGZ6rU2lsgwKoeXMjKNGMGo1KrKpuMEiYMGov5C7DtnO4p210ZXmHl9c6bQ7G2CtVSn826GazTMFCj2uI6Px47Ef/gE9H585aVG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY+ZGex5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY+ZGex5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1C6C19425;
	Wed, 29 Apr 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500605;
	bh=RC6JQ68RlC5gYkIgGOuBNqUCe87K1v0o203SkmAFyCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dY+ZGex5El4x0oA0e4xm+r0DK4kFWVTur+B5v0yDuUQDM8meIMfluYN3c7vsdpO6b
	 by3oqCiVgq6OP70cJorsnwyAOLVOSvTCYk6C3cgXWbf+uul6jXT/LEoyN1KJHQwZMG
	 dxMReNnaJZIbjwYgzKyz7kSXmr1Y7pXk2aMZfKJVYIdyKaf9izJsORSP1NbdIiUhS9
	 6uVf8XUDezM9Lzsyg2rxfvMu3kVXG7eXlsSiLGUjn7OhnMFzoY5svqEIW7U1+wbxhV
	 XfN3CjygbZdXDtt5Cekb7j/83mIdhrbsNIV/1Cse1H8zWbFVYEjiGE6Qmg98oryJrV
	 sCdu6bzBzLmjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: fix crash in
 bpf_[set|remove]_dentry_xattr for negative dentries
Reply-To: sashiko@lists.linux.dev
To: "Matt Bobrowski" <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429205438.2601592-1-mattbobrowski@google.com>
References: <20260429205438.2601592-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:10:00 +0000
Message-Id: <20260429221005.6D1C6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incomplete Fix: Negative dentries still trigger WARN_ON splats in =
bpf_get_dentry_xattr and _locked variants
- [High] BPF verifier blindly substitutes locked kfuncs, allowing arbitrary=
 VFS lock bypass
- [High] Missing VFS parameter sanitization allows out-of-bounds xattr size=
s and arbitrary flags
--

commit 07ec989f2fe3141fcb87e29833232a3f0591690d
Author: Matt Bobrowski <mattbobrowski@google.com>

bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries

This commit adds a NULL check for the inode in bpf_set_dentry_xattr() and
bpf_remove_dentry_xattr() to prevent a NULL pointer dereference when a
negative dentry is passed. If the inode is NULL, the functions now return
-EINVAL instead of attempting to lock it.

Closes: https://lore.kernel.org/bpf/1587cbf4-1293-4e25-ad24-c970836a1686@st=
d.uestc.edu.cn/

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..a0d58d5e3022 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -289,6 +289,9 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *d=
entry, const char *name__st
>  	struct inode *inode =3D d_inode(dentry);
>  	int ret;
> =20
> +	if (!inode)
> +		return -EINVAL;

Are similar checks needed for bpf_get_dentry_xattr() and the _locked varian=
ts
(bpf_set_dentry_xattr_locked() and bpf_remove_dentry_xattr_locked())?

If a negative dentry is passed to those functions, they will extract a NULL
inode and pass it to bpf_xattr_write_permission() or
bpf_xattr_read_permission(), which will trigger a WARN_ON(!inode) splat:

fs/bpf_fs_kfuncs.c:bpf_set_dentry_xattr_locked() {
	...
	struct inode *inode =3D d_inode(dentry);
	...
	ret =3D bpf_xattr_write_permission(name__str, inode);
	...
}

Could a user-controlled BPF program intentionally pass a negative dentry to
trigger this warning, causing a denial of service on systems with
panic_on_warn enabled?

> +
>  	inode_lock(inode);
>  	ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);

This isn't a regression from this patch, but does the BPF verifier safely
handle the substitution of these locked kfuncs?

If a program is attached to an LSM hook that holds an inode lock, the
verifier unconditionally rewrites calls to bpf_set_dentry_xattr() to
bpf_set_dentry_xattr_locked(). The verifier doesn't check if the dentry
argument provided to the kfunc is the specific context argument that the
VFS already locked.

Can a BPF program obtain a trusted pointer to an unrelated, unlocked dentry
and pass it to the kfunc, causing the substituted _locked variant to execute
__vfs_setxattr() without acquiring the proper VFS locks?

Additionally, do these kfuncs bypass necessary VFS parameter sanitization?

The standard setxattr system call sanitizes inputs in setxattr_copy(),
rejecting sizes larger than XATTR_SIZE_MAX and masking flags. Since
bpf_set_dentry_xattr() and its _locked variant directly invoke __vfs_setxat=
tr(),
a BPF program can supply arbitrary unvalidated flags and massive values up
to 4GB.

Could this bypass lead to huge allocations, integer overflows, or
out-of-bounds accesses in drivers that assume VFS-enforced bounds?

>  	inode_unlock(inode);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429205438.2601=
592-1-mattbobrowski@google.com?part=3D1
