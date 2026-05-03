Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753613128CC
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841057; cv=none; b=ibiK365yocpto86sU9a2YaxVp+GLqQGw/vDx8TJ8hKj/je5f3c8wiK4FczxMlHCzh+BLQCeSCQ72cM/e8H1gSSjKdsbHfZ3L5MdFNW9ZcQLM7WK8z8ghnZGmk0Q/pqDQLNtpt4BPV9ymnKvFhQX4EKVokPPSboKRKL2qFjACuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841057; c=relaxed/simple;
	bh=I9qjlUGMFqhkk5U2rCVGA52uqoD8c4HlXYrp29tQLyA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lOt5F7fJ/JV6ADnfnmJFcuDj6wV4G7kBZUjB8ou7Tp5iW/w0FwUtJwlRw0kkR3dD+X1Q9a/C4xlIMvpA/OmazL0KEtV0JE6ieH4UjbneXYc6BIyMyL1gMk3DVW6fJAKecoK0vmMGIyJcawkNYKTE9kFX1ztH6YqJfJVH8PfIQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoKTMI0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoKTMI0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B35EC2BCB4;
	Sun,  3 May 2026 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777841057;
	bh=I9qjlUGMFqhkk5U2rCVGA52uqoD8c4HlXYrp29tQLyA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BoKTMI0l/ZSCDLTHkXWR11o8n76W/wIZvImXWKPIvpbFlh5g8Bs1T4LK8kGcC8DXE
	 +9ROlq8UY+Y+vHF+q0CnJSJGWEJXY0OSEQgRa4+Avllbp51880ALgc2pqJXsv+K+rJ
	 a3olegyF+LoKXBeQDefA8bWy5grhG+T0UUL7xlx3bRNJmipYEo85UfwVW7itkeH5Ao
	 Y4t/UtBMJtH/Z3a8bGAzKhvTv+ZJxVLKnqmmcX9hk4Y9fxS9N+tGn2IK/UFTosYUZU
	 gIBtE7uXQdNUUjmCrg97XkPw6AoA6xxQSsI5bncxu2Jq4nl7vBtVplWZE+DSke/iyD
	 MqpZclUIEIc9Q==
Content-Type: multipart/mixed; boundary="===============7720530520412859774=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c447a881915a06db87c17ef1384f42674b0c171858c82e33666cb667101b338@mail.kernel.org>
In-Reply-To: <20260503200819.1530328-1-mattbobrowski@google.com>
References: <20260503200819.1530328-1-mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: enforce VFS constraints for xattr related BPF kfuncs
From: bot+bpf-ci@kernel.org
To: mattbobrowski@google.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,memxor@gmail.com,mattbobrowski@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 20:44:15 +0000 (UTC)

--===============7720530520412859774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..a48cf35dedd2 100644
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

In the previous patch discussion, Sashiko AI raised a concern about
WARN_ON(!inode) in bpf_xattr_read_permission() potentially causing a DoS
on panic_on_warn systems. You acknowledged that dropping the WARN_ON
makes sense since attempting to set xattr on a negative dentry is
invalid and should be handled gracefully. Can this still happen if a
BPF program passes a negative dentry to bpf_get_dentry_xattr() or the
_locked variants? If d_inode(dentry) returns NULL and is passed to
bpf_xattr_read_permission() or bpf_xattr_write_permission(), wouldn't
the WARN_ON(!inode) trigger?

[ ... ]

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

Sashiko AI raised a concern about a potential VFS lock bypass through
the BPF verifier's kfunc substitution mechanism. The verifier
unconditionally rewrites calls to bpf_set_dentry_xattr() to
bpf_set_dentry_xattr_locked() for hooks that hold inode locks, but
doesn't verify that the dentry argument is the specific context
argument that was locked.

Can a BPF program obtain a trusted pointer to an unrelated, unlocked
dentry and pass it to the kfunc, causing the substituted _locked
variant to execute __vfs_setxattr() without acquiring the proper VFS
locks? You mentioned this is "probably a valid concern" that "should be
reviewed in further depth separately," but should this be addressed
before the patch is merged to avoid introducing a security regression?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25289845959
--===============7720530520412859774==--
