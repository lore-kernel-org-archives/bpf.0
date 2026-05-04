Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9434CFD6
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887120; cv=none; b=kCSwKx9klF9bmupM3MS47puk2LkXHR6ghSmeNYkKaJiOdC+IrmXErkTLY6WwTI7Cxcm10aIO6v6h/dYbj/sTnMtXnb/oRsBDB1+RcRExoylCz71HOwp7KtBQ8i6Unti5DLGNNOkiTdJgBQfKR54pdE8ylPkjC5XlRCbAgczBIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887120; c=relaxed/simple;
	bh=Hasw6Db373+dsyBAU4kKbeYf3b9/NL32FNAAkqKM9T4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NWUKn6/Yj0xIXO5wRgaHs/AIjUszGUxD5WCAarp+oxRQQ4ONPa7hfJAH49qY0pvI5e5So9Bods9FdcLrvC3CYK2jEStTNtr+KM6qQ6P7zngh0rreXIqLM9Pnk/quvFdsImsih9D6zBH6+KoE5ady53ElUsTRonaCmGLUaaWdR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzD9sQWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzD9sQWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD7C2BCB8;
	Mon,  4 May 2026 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887119;
	bh=Hasw6Db373+dsyBAU4kKbeYf3b9/NL32FNAAkqKM9T4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qzD9sQWyYGnf9MzzEWUCnsCPAYwJ5gD++NEscFCFslY3rkx0yA3wF73OjQjmIJ8tO
	 kppyNWFZu+gDZPnAa/J8DOoSr0oAB+APyRbaI9VI92e1RAN9QKUrNn3c9UHll1MgWi
	 RrMgVwzymX49RrQrBywl9MSz+QiECNzDr2dS5zbnhPQ3Lzixb1shxrNNDKt3RD8vJw
	 sD8W2RT3Mqs0IVFf0m+BG0Y+kwoKlLCPlTtv9+5RRFMXxxCknVauq8pusN6UZckfjQ
	 8nyOMx1vg8pbRPjHkjnlc6p597BXg9cVhJ8WmtuxfEhVLHe0cPU6iuXpN0SDRMFkEg
	 YPVTUns7BGWmQ==
Content-Type: multipart/mixed; boundary="===============2504344260646068128=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89485e276ac7f9cb228972d83d14cfc2400491cf3578dd00191bb4324a810a57@mail.kernel.org>
In-Reply-To: <20260504085428.2865671-1-mattbobrowski@google.com>
References: <20260504085428.2865671-1-mattbobrowski@google.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: enforce VFS constraints for xattr related BPF kfuncs
From: bot+bpf-ci@kernel.org
To: mattbobrowski@google.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,memxor@gmail.com,mattbobrowski@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  4 May 2026 09:31:57 +0000 (UTC)

--===============2504344260646068128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..eb9aef1e135e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -117,10 +132,10 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *
> - * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
> + * Get xattr *name__str* of *dentry* and store the output in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefixes "user." or
> - * "security.bpf." are allowed.
> + * For security reasons, only *name__str* values prefixed with "user." or
> + * "security.bpf." are permitted.
>   *
>   * Return: length of the xattr value on success, a negative value on error.
>   */
> @@ -133,6 +148,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>  	void *value;
>  	int ret;
>
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
> +
>  	value_len = __bpf_dynptr_size(value_ptr);
>  	value = __bpf_dynptr_data_rw(value_ptr, value_len);
>  	if (!value)

BPF LSM programs can attach to hooks that inherently supply negative
dentries (such as inode_create or vfs_mkdir), where d_inode(dentry) is
legally NULL. Looking at bpf_xattr_read_permission():

static int bpf_xattr_read_permission(const char *name, struct inode *inode)
{
	if (WARN_ON(!inode))
		return -ENOENT;
    ...

If a BPF program passes a negative dentry, this would intentionally trigger
the warning.

Could this panic the system if panic_on_warn is configured? Should this
gracefully return -ENOENT or -EINVAL without firing WARN_ON()?

Reference: https://lore.kernel.org/bpf/20260503204353.2F800C2BCB4@smtp.kernel.org/

[ ... ]

> @@ -187,10 +206,18 @@ static int bpf_xattr_write_permission(const char *name, struct inode *inode)
>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *
> - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + * Set xattr *name__str* of *dentry* to the value in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefix "security.bpf."
> - * is allowed.
> + * For security reasons, only *name__str* values prefixed with "security.bpf."
> + * are permitted.
> + *
> + * The length constraints imposed on both the xattr name and value abide those
> + * that are also enforced by the VFS. Additionally, the flags argument respects
> + * what's enforced by the VFS in the same way. By default, the flag value of 0
> + * is permitted and an xattr will be created if it does not exist, or the value
> + * will be replaced if the xattr already exists. More course grained control
> + * over these exact semantics is permitted by explicitly specifying either
> + * XATTR_CREATE or XATTR_REPLACE.
>   *
>   * The caller already locked dentry->d_inode.
>   *

Standard VFS xattr modifications enforce restrictions via xattr_permission(),
which explicitly checks IS_IMMUTABLE(inode) || IS_APPEND(inode) to block
metadata tampering on append-only files.

However, bpf_xattr_write_permission() bypasses xattr_permission() and calls
inode_permission(..., MAY_WRITE) directly:

static int bpf_xattr_write_permission(const char *name, struct inode *inode)
{
    ...
	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
}

Because inode_permission() checks IS_IMMUTABLE but not IS_APPEND, could
BPF programs be erroneously permitted to modify security.bpf.* xattrs on
files marked as append-only?

Reference: https://lore.kernel.org/bpf/20260503204353.2F800C2BCB4@smtp.kernel.org/

> @@ -206,7 +233,17 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  	u32 value_len;
>  	int ret;
>
> +	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
> +		return -EINVAL;
> +
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
> +
>  	value_len = __bpf_dynptr_size(value_ptr);
> +	if (value_len > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +
>  	value = __bpf_dynptr_data(value_ptr, value_len);
>  	if (!value)
>  		return -EINVAL;

[ ... ]

> @@ -274,11 +315,19 @@ __bpf_kfunc_start_defs();
>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *
> - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + * Set xattr *name__str* of *dentry* to the value in *value_p*.
>   *
>   * For security reasons, only *name__str* with prefix "security.bpf."
>   * is allowed.
>   *
> + * The length constraints imposed on both the xattr name and value abide those
> + * that are also enforced by the VFS. Additionally, the flags argument respects
> + * what's enforced by the VFS in the same way. By default, the flag value of 0
> + * is permitted and an xattr will be created if it does not exist, or the value
> + * will be replaced if the xattr already exists. More course grained control
> + * over these exact semantics is permitted by explicitly specifying either
> + * XATTR_CREATE or XATTR_REPLACE.
> + *
>   * The caller has not locked dentry->d_inode.
>   *
>   * Return: 0 on success, a negative value on error.

BPF LSM programs can attach to hooks that supply negative dentries (e.g.,
inode_create, vfs_mkdir) where d_inode(dentry) is legally NULL.

Looking at bpf_set_dentry_xattr():

__bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
				     struct bpf_dynptr *value_p, int flags)
{
	struct inode *inode = d_inode(dentry);
	int ret;

	inode_lock(inode);
    ...

If a BPF program invokes bpf_set_dentry_xattr() on a negative dentry,
inode will be NULL and inode_lock(inode) will unconditionally dereference
the NULL pointer.

Will this trigger a NULL pointer dereference and oops the kernel?

The same issue affects bpf_remove_dentry_xattr().

Reference: https://lore.kernel.org/bpf/20260503204353.2F800C2BCB4@smtp.kernel.org/

[ ... ]

The verifier unconditionally rewrites calls to bpf_set_dentry_xattr() to
bpf_set_dentry_xattr_locked() for hooks that hold inode locks, but doesn't
verify that the dentry argument is the specific context argument that was
locked.

Can a BPF program obtain a trusted pointer to an unrelated, unlocked
dentry and pass it to the kfunc, causing the substituted _locked variant
to execute __vfs_setxattr() without acquiring the proper VFS locks?

Reference: https://lore.kernel.org/bpf/5c447a881915a06db87c17ef1384f42674b0c171858c82e33666cb667101b338@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25310655349
--===============2504344260646068128==--
