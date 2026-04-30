Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DD2F5A06
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536850; cv=none; b=THI17oDpnImRXHwg0n/y4+u5RcAmNBbouG8DHcQL2Ps2GqJrgEDMXHeEUf1bRqI2M+BtTRy2E7rdOkKT520Wb4e+SWySPKJs3qv8HV3y268DovC6OgGxIneqbo8uPfJOFzgisQGjVVBBF2nGBSyzn3wjPFsm1ftvbXSxHuUekbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536850; c=relaxed/simple;
	bh=oqYwOo9fZceqnyPRRZNlviU6k2X2IZqH5xoWNA5/KVA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p/aoNuYPoo/74UAK4aehR9cs6dySQECsraJZZfvyKZDcfEyaEVU/wTdl6eN7zI06tWcfLfQQytOXkVtlYkgLx4uIfbfa3vXYtXpjjw/t+QdtvNjoihWOZ7evHq13ZpbEfBuVyx5arNA0uKmQsuqv+yzAW01TR6HgBBrc+6h7+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/vJaw45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/vJaw45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB98C2BCB3;
	Thu, 30 Apr 2026 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777536850;
	bh=oqYwOo9fZceqnyPRRZNlviU6k2X2IZqH5xoWNA5/KVA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Y/vJaw455H3OQoBl3/isLLRjAI2jKX89FwD3eJKXOFArr+xwy3HLJeZ3w1ZeLcEaG
	 rtSWpU4QGIrs3GQC+cDiAtwO5DfCu8NThB4jo5pZqeJIhnhvmfZDKMoEoGqMUR1fsV
	 LOP1OF44fV1G89x0RQu7lzJROk1jiPAqp+sncKpbcC+1ieIaPfgGjvq3hsJ8APqbOD
	 lDcM1vKqhsKf2zDEb4EPgAvyEaNfImrWUghy4SjscoLtg3nyqFswvTeQn4X8BKxQd1
	 xwqKxTTfXvs9puDOvdkLJRW4wBJvij4Euw4oYo581tZ7Vx4PM5HXLeFZY4/B8XDb5C
	 TKsqnQYeZk/Hw==
Content-Type: multipart/mixed; boundary="===============2695036780635388988=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <68b132c306faed4b808eee7f6929c0286fae1171538412df75e0666db64640cb@mail.kernel.org>
In-Reply-To: <20260430073836.2894001-1-mattbobrowski@google.com>
References: <20260430073836.2894001-1-mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next v2] bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries
From: bot+bpf-ci@kernel.org
To: mattbobrowski@google.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 08:14:07 +0000 (UTC)

--===============2695036780635388988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..8642a754b37d 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -289,6 +289,9 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
>  	struct inode *inode = d_inode(dentry);
>  	int ret;
>
> +	if (!inode)
> +		return -EINVAL;
> +
>  	inode_lock(inode);
>  	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);

An earlier review comment from sashiko-bot raised concerns about the
BPF verifier's unconditional rewriting of bpf_set_dentry_xattr() calls
to bpf_set_dentry_xattr_locked() in LSM hooks that already hold inode
locks.

The concern is that the verifier doesn't check whether the dentry
argument provided to the kfunc is the specific context argument that
the VFS already locked. Could a BPF program obtain a trusted pointer to
an unrelated, unlocked dentry and pass it to the kfunc, causing the
substituted _locked variant to execute __vfs_setxattr() without
acquiring the proper VFS locks?

This concern was acknowledged as valid and worth reviewing separately,
but remains unaddressed in v2.

Reference: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/

[ ... ]

In bpf_set_dentry_xattr_locked():

>  	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name__str,
>  			     value, value_len, flags);
>  	if (!ret) {

An earlier review comment from sashiko-bot pointed out that the
standard setxattr system call sanitizes inputs in setxattr_copy(),
rejecting sizes larger than XATTR_SIZE_MAX and masking flags.

Since bpf_set_dentry_xattr() and its _locked variant directly invoke
__vfs_setxattr(), a BPF program can supply arbitrary unvalidated flags
and massive values up to 4GB.

Could this bypass lead to huge allocations, integer overflows, or
out-of-bounds accesses in drivers that assume VFS-enforced bounds?

This concern was acknowledged as valid and to be addressed in a
follow-up patch, but remains unaddressed in v2.

Reference: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25153819489
--===============2695036780635388988==--
