Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4363A3E66
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841033; cv=none; b=hTjVtdfRYrZ950dwZlin9/Xt1FqojsFJ/o+JXqUIl91VytysV7TchEChLD0ZBKAm+ke0ykUFfm5jcOYNDjZ3GLQilcn3JVpBdRt+aHTAxB9CplaJkzjjGarD0/EPhHSozmVlsImNz2OMrFW9Q9+Afe55qumOgR0TTA38g5cSM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841033; c=relaxed/simple;
	bh=JGTFDOpQMa80Wxe8Qa0u5FYvnouUdfJPDVq09M01nws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DrboG4CHuN8bhOYrNL27EED4RvZsiADJLPYF44ZY93e3ANkGfiCnk0856YAb4i7e7B34XLxp5pNqCASi0/HCmA50mdPP9qENXOwCm13JGqSUybNhsM8dNNPalKKsN53xPBKruD4uW46D5RLLA2iKwxJ5PkCI0fOz2vpAJFg9bDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvmRcceM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvmRcceM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F800C2BCB4;
	Sun,  3 May 2026 20:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777841033;
	bh=JGTFDOpQMa80Wxe8Qa0u5FYvnouUdfJPDVq09M01nws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jvmRcceMZddZxnFjj1bxuVM71AV6OoETJ+ddnB854kVcrE+wGTglWCoVIY2HBmnAG
	 DsW866Qv7ZQxG1ajkZz7cOS1zu2m8gSN67CSa85yyLdS5qwymC31G/lvV7rSFE1TWf
	 4Rezvr5PS15KEXJhat4hbFVNi3GzwRqrhlSF+MOa5cQB7RUuEj8aPpTKscrxq128cn
	 ffIqZ37ZOw24PiKib5GXvcgzurc2VW7aVc/JJA9aw7ko9O40EtegdnW4OcewJURSzs
	 ecMFZGSlwUXIOynVu9rZjtcCGz9U7eo6teG67y78GFOo8KJ/0FIBr4ILkv0G2cUt9n
	 rlo234dyvyXow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: enforce VFS constraints for xattr
 related BPF kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Matt Bobrowski" <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503200819.1530328-1-mattbobrowski@google.com>
References: <20260503200819.1530328-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:43:52 +0000
Message-Id: <20260503204353.2F800C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf_set_dentry_xattr and bpf_remove_dentry_xattr will crash the ke=
rnel with a NULL pointer dereference if passed a negative dentry.
- [High] bpf_xattr_write_permission() bypasses IS_APPEND() checks, allowing=
 BPF programs to modify xattrs on append-only files.
- [High] bpf_xattr_read_permission and bpf_xattr_write_permission use WARN_=
ON(!inode), allowing BPF programs to trivially spam the kernel log or trigg=
er panics.
- [Medium] bpf_cgroup_read_xattr() misses the new VFS name length constrain=
t check.
--

commit 6ac57f528df35ba363e277e2447059faac6477b7
Author: Matt Bobrowski <mattbobrowski@google.com>

bpf: enforce VFS constraints for xattr related BPF kfuncs

This commit enforces VFS constraints and semantics regarding name and value
lengths within the xattr related BPF kfuncs. It rejects names that are empty
or longer than XATTR_NAME_MAX, and values larger than XATTR_SIZE_MAX. It al=
so
validates the supplied flags to ensure only XATTR_CREATE and XATTR_REPLACE =
can
be used alongside the default flag value 0.

Closes: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.=
org/

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..a48cf35dedd2 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -117,10 +132,10 @@ static int bpf_xattr_read_permission(const char *na=
me, struct inode *inode)

This wasn't introduced by this patch, but do bpf_xattr_read_permission() and
bpf_xattr_write_permission() use WARN_ON(!inode), allowing BPF programs to
trivially spam the kernel log or trigger panics?

BPF LSM programs can attach to hooks that inherently supply negative dentri=
es
(like vfs_mkdir), where d_inode(dentry) is legally NULL. Passing a negative
dentry would intentionally trigger the warning in these permission checks:

static int bpf_xattr_write_permission(const char *name, struct inode *inode)
{
	if (WARN_ON(!inode))
		return -EINVAL;

This could panic the system if panic_on_warn is configured. Should these ch=
ecks
gracefully return -ENOENT or -EINVAL without firing a WARN_ON()?

>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *

[ ... ]

> @@ -187,10 +206,18 @@ static int bpf_xattr_write_permission(const char *n=
ame, struct inode *inode)

This wasn't introduced by this patch, but does bpf_xattr_write_permission()
bypass IS_APPEND() checks, allowing BPF programs to modify xattrs on
append-only files?

Standard VFS xattr modifications enforce restrictions via xattr_permission(=
),
which explicitly checks IS_IMMUTABLE(inode) || IS_APPEND(inode) to block
metadata tampering on append-only files. However, bpf_xattr_write_permissio=
n()
bypasses xattr_permission() and calls inode_permission(..., MAY_WRITE)
directly.

Because inode_permission() checks IS_IMMUTABLE but not IS_APPEND, could BPF
programs be erroneously permitted to modify security.bpf.* xattrs on files
marked as append-only?

>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *

[ ... ]

> @@ -274,11 +315,19 @@ __bpf_kfunc_start_defs();
>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *
> - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + * Set xattr *name__str* of *dentry* to the value in *value_p*.

This problem wasn't introduced by this patch, but will bpf_set_dentry_xattr=
()
and bpf_remove_dentry_xattr() crash the kernel with a NULL pointer derefere=
nce
if passed a negative dentry?

BPF LSM programs can attach to hooks that inherently supply negative dentri=
es
(such as inode_create or vfs_mkdir), where d_inode(dentry) is legally NULL.=
 If
a BPF program invokes bpf_set_dentry_xattr() or bpf_remove_dentry_xattr() on
such a negative dentry, the kfunc will assign inode =3D NULL and subsequent=
ly
call inode_lock(inode).

Because inode_lock() unconditionally dereferences the inode pointer, would =
this
immediately trigger a NULL pointer dereference and oops the kernel?

>   *
>   * For security reasons, only *name__str* with prefix "security.bpf."
>   * is allowed.

[ ... ]

> @@ -327,14 +376,15 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dent=
ry *dentry, const char *name_
>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *
> - * Get xattr *name__str* of *cgroup* and store the output in *value_ptr*.
> + * Get xattr *name__str* of *cgroup* and store the output in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* values prefixed with "user." a=
re
> + * permitted.
>   *
>   * Return: length of the xattr value on success, a negative value on err=
or.
>   */
>  __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char =
*name__str,
> -					struct bpf_dynptr *value_p)
> +				      struct bpf_dynptr *value_p)
>  {
>  	struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)value_p;
>  	u32 value_len;

Does bpf_cgroup_read_xattr() miss the new VFS name length constraint check?

The commit message explicitly states the goal is to "Enforce VFS constraints
and semantics regarding name and value lengths within the xattr related BPF
kfuncs", specifically rejecting names that are empty or longer than
XATTR_NAME_MAX.

While bpf_xattr_validate_name() was correctly added to the dentry-related
kfuncs like bpf_get_dentry_xattr() and bpf_set_dentry_xattr(), it appears to
be completely omitted in bpf_cgroup_read_xattr(). Could this allow BPF
programs to bypass the intended length constraints when reading cgroup xatt=
rs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503200819.1530=
328-1-mattbobrowski@google.com?part=3D1
