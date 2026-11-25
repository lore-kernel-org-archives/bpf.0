Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643894;
	b=dOFECdzIe4768r1VQ5ZT+fxsP8xR1r/z60Dlmkuj58EHvI3Vu4HX9GCo8p18xpgITqb3
	 btDtGmoR07Yn9Z45wpw59Q8IPXvG/DTBmLy5c/6og9Z89A/yiUAeZZ4n61X7TrmhxRnzs
	 4rxiEGm7PjMCuLIlABIcqzQJFR8jcH36Cs0LXu9G1ZmpO8pzTQOxGXyzjFVfY7Ubh2Yp6
	 HsoLmYcBf9xJRF2F0ea18MS6pig/kIhTplYU5EErQFUxLOsyX461osrgrQUKQL8jVAipt
	 mT5uWw4qODAslwBBDQhkVoh7vIM06E/meeg4XyxGvAPsH2n4fyY8K8su0Wr8IGLv1tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643894;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=h6Q9R3G+JkZHYy+1pHT69C6xcyqGso5GBeWoA+f5Z7M=;
	b=b3Kg38jHwp1M4fFk+AiX8ACIwvxVsGjm9VZvc8jbrEXW3Kr5Z2CUskKBaggzqUntCovG
	 UY2AV7ghaqC3RDmnGPeDNH6q9W3M4ygUpJlmehMVqL2gJin7B7IJ1t5x1+2O2pR4VnvQ4
	 nnpSbhgRW09TYjPGS80HqBSmBsjd1qftK74kVTmkYkYm7iSfwDAtd1efne75W+aMNtKF6
	 lJRIAmmQMY5Ts5kx4DuIgmfcgmbvtuUQJk4R0gJgeHkTaFCtjVy67/94a7Qhkom3pHU7D
	 ni2hv4uH6vLUucAeWK+VJgp+h8OTc3sBVRxaXKTX+FpLHL0v8X1lY0KwNm7s5Fj1h7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Do+Lu3gJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C461606A326;
	Wed, 25 Nov 2026 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Do+Lu3gJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DD01F000C0;
	Wed, 25 Nov 2026 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643893;
	bh=h6Q9R3G+JkZHYy+1pHT69C6xcyqGso5GBeWoA+f5Z7M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Do+Lu3gJMB6cY+Z5JHaD0/fg3qxdr1h0BBjsgfNyeezx2S61E5LLgF6PI+w/r8o9A
	 Uq56f3OpGuCsgLpdIf7GkIKcazyOnxxLIn61kz0mzNsig1or3pyPskbhrOD3Vw8ZHz
	 VnjQdROaoj+ECEwNgNYxgXifIw70w/8rr2onK7IgWc56QDHL1IIPbR25zXrHreQFFQ
	 r6vDvIn+fMlsZ4psReeZNSG15nGtZ6rFJhQNi2aMEswnnoMd5shEYMpCdQyvBi5NCm
	 oRWoFfYjgW7az6nX0D7HKRyHNXMGn2acm/uyW8pclyrjQqfm52a2Uyl4/IL7LZ70En
	 NrxtRRyPJ4JeA==
Content-Type: multipart/mixed; boundary="===============6772155462259261077=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6262e5090a78f9ff8760d62be7c78067f4daa988ab01fc6659c5f60ece1d7d1c@mail.kernel.org>
In-Reply-To: <20261125211928.3481451-1-daniel@iogearbox.net>
References: <20261125211928.3481451-1-daniel@iogearbox.net>
Subject: Re: [PATCH vfs.bpf] bpf: Read security.bpf xattrs without caller's permission
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,brauner@kernel.org
Cc: ast@kernel.org,kpsingh@kernel.org,dwindsor@gmail.com,bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 21:58:12 +0000 (UTC)

--===============6772155462259261077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Read security.bpf xattrs without caller's permission

TL;DR: Skipping inode_permission() for security.bpf. xattrs may let a
sleepable BPF LSM program send FUSE_GETXATTR to an untrusted server for
disallowed tasks, possibly hanging root's statfs in D state. Should FUSE still
be refused?

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -107,8 +107,9 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
>  		return -EINVAL;
>
>  	/* Allow reading xattr with user. and security.bpf. prefix */
> -	if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
> -	    !match_security_bpf_prefix(name))
> +	if (match_security_bpf_prefix(name))
> +		return 0;
> +	if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
>  		return -EPERM;
>
>  	return inode_permission(&nop_mnt_idmap, inode, MAY_READ);

A subsystem pattern flags this as potentially concerning.  For
security.bpf. names, bpf_get_dentry_xattr() now goes straight to
__vfs_getxattr() without inode_permission().  On FUSE that reaches:

fuse_xattr_get()
  fuse_getxattr()
    fuse_simple_request(FUSE_GETXATTR)

and fuse_xattr_get() never calls fuse_allow_current_process().  Before this
change, inode_permission() reached fuse_permission(), which returns -EACCES
without sending a request when !fuse_allow_current_process(fc).

Can this send FUSE_GETXATTR to an untrusted server on behalf of a task the
mount owner does not allow?  For example, sb_statfs is a sleepable LSM hook
that receives a trusted struct dentry *.  If a sleepable BPF LSM program
calls bpf_get_dentry_xattr(dentry, "security.bpf.<x>", ...) there, and an
unprivileged user has mounted a FUSE filesystem without allow_other, then
root calling statfs() (e.g. df, or statfs on /proc/<pid>/cwd) goes:

statfs_by_dentry()
  security_sb_statfs(dentry)

with no prior inode_permission() on an inode of that connection.  Previously
the result was -EACCES with no request sent.  Now the request is sent, and
request_wait_answer() ends in an uninterruptible wait until the server
replies, so a non-replying server can hang root's statfs in D state.

The commit message compares this to SELinux and Smack reading labels with
__vfs_getxattr().  Those LSMs cache the label in the inode blob at
d_instantiate or mount time, in the context of a task that already passed
the FUSE checks, whereas a BPF LSM program may read security.bpf. on every
hook invocation.

Mitigating context: this only applies when an admin-loaded sleepable BPF LSM
program reads security.bpf. xattrs in such a hook, the user. prefix is
unaffected, and security.* xattrs are already readable from userspace
without read permission.

Should the security.bpf. path keep refusing FUSE inodes whose connection does
not allow the current task, or should the kfunc documentation state that it
can block on an untrusted FUSE server for any task?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45706851285
--===============6772155462259261077==--
