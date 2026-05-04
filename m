Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68637DE85
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887435; cv=none; b=s5TIfgzS7P7ZxL0/4KhdT7rcdWFLuuBT6x9sfv1YAnMCLJzeN8ig/SLRDd2yw6vKRqfCd23KAlUh91/IbhbDnL6Hjtm7AsjxixcgzYrYIX+E57SjabZjBlzp1qgEGYce6az+oCGDWdyyxrVHhW+C9K8UaKMcLWdB8JDXxJJXe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887435; c=relaxed/simple;
	bh=3M7CMxBvVjOHtOt2oVF5fJeSvcFnmg04yf7JpoRH06Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWCPFoIOvt6Uk7MMaFDLhoI8Ak1zdw0qfK4ihMXd13iEDBq+SJ9PxTFdanY2SQi1NSvmk2Qbs/rD6ReTBeZBYFjpNjt8puXlCOzD7pUHyvHWAbboA1jAyW2r5NFbEDzsNlnMSykE0JvpE1TOYkm/qwN5JepvOeBZLpUWdxToT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6TpMh8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6TpMh8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7821C2BCB9;
	Mon,  4 May 2026 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887435;
	bh=3M7CMxBvVjOHtOt2oVF5fJeSvcFnmg04yf7JpoRH06Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i6TpMh8tt4pSue+nIyMEGI5BbXbmqGUsLHdVai1h+vKE6dx4E/MDg82qVblX47SQY
	 kXDv35Lt24YaI+5mJzs6jn/aHR9qnXeANsFdfoCLjoGr0kZH9Hf/aQC/z87nA1XuJh
	 w67RnSpl1oY8BdWU5lI2ajodk6ehbEm+YvaCVVHZComxUtfHmKHlscMGjVeNS8bkvR
	 pKGyTNCs9SxC0oTcJb5ASKvqEC+1jDlCvI031C1hYcF8GOTW+hSYhrAm9oqL2aSsRF
	 RYD02MlWRw0GvttUBHlZSIgTWlsFJ7sGm8ffkiVDZuHTh7fBqLf9BGuqF/jmF6kQwS
	 wuGymgDTqUlZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: enforce VFS constraints for xattr
 related BPF kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Matt Bobrowski" <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504085428.2865671-1-mattbobrowski@google.com>
References: <20260504085428.2865671-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 09:37:14 +0000
Message-Id: <20260504093714.D7821C2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The unlocked BPF kfuncs `bpf_set_dentry_xattr` and `bpf_remove=
_dentry_xattr` unconditionally call `inode_lock(inode)` without checking if=
 the inode is NULL, leading to a kernel panic.
--

commit 1eddd22ded9c4ecb43cf15dc45c01aaba4a3f609
Author: Matt Bobrowski <mattbobrowski@google.com>

bpf: enforce VFS constraints for xattr related BPF kfuncs

Enforce VFS constraints and semantics regarding name and value lengths
within the xattr related BPF kfuncs. Specifically, reject names that
are empty or longer than XATTR_NAME_MAX, and values larger than
XATTR_SIZE_MAX. Also validate the supplied flags to ensure that only
XATTR_CREATE and XATTR_REPLACE can be used alongside the default flag
value 0.

Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattr=
s")
Closes: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.=
org/

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..eb9aef1e135e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

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
> + * The length constraints imposed on both the xattr name and value abide=
 those
> + * that are also enforced by the VFS. Additionally, the flags argument r=
espects
> + * what's enforced by the VFS in the same way. By default, the flag valu=
e of 0
> + * is permitted and an xattr will be created if it does not exist, or th=
e value
> + * will be replaced if the xattr already exists. More course grained con=
trol
> + * over these exact semantics is permitted by explicitly specifying eith=
er
> + * XATTR_CREATE or XATTR_REPLACE.
> + *
>   * The caller has not locked dentry->d_inode.
>   *
>   * Return: 0 on success, a negative value on error.

This isn't a regression introduced by this patch, but there is a pre-existi=
ng
flaw when bpf_set_dentry_xattr and bpf_remove_dentry_xattr call inode_lock
unconditionally.

Can sleepable BPF LSM hooks such as bpf_lsm_inode_create, bpf_lsm_inode_mkd=
ir,
and bpf_lsm_inode_mknod receive negative dentries where d_inode is NULL?

If so, since these hooks are not in the d_inode_locked_hooks list, the BPF
verifier would allow programs attached to them to call the unlocked kfuncs
bpf_set_dentry_xattr and bpf_remove_dentry_xattr. When called with a negati=
ve
dentry, the kfuncs extract a NULL inode via d_inode(dentry) and immediately
invoke inode_lock(inode).

This results in down_write(&NULL->i_rwsem), triggering a fatal NULL pointer
dereference. The WARN_ON(!inode) safety check located later in
bpf_xattr_write_permission is unreachable because the system crashes earlier
during lock acquisition.

Could we add a NULL check for the inode before attempting to lock it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504085428.2865=
671-1-mattbobrowski@google.com?part=3D1
