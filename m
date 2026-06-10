Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A5427A10
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106701; cv=none; b=YR/lozC9gnKKN0Hw72IQZsWbTR+T8NjwiqZ3WHDhYTQWmXpf6dzq0YmwYXTAoV4myoTz6q7aY8o7E/NxXH1ZdnYV+mXVTRzYcuC8fvFLtHNrQ9s2h87mRAOpN4keVLGjpeq6YOdUY3tDAetacpiYAJy0wP7KdsFZZnf3aUb4rw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106701; c=relaxed/simple;
	bh=papoeRUUdKqoC1wGsry21A+FJnWpSsy3MHX2lPEpcig=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OEr58ZkEzHnNlQRq0wO90bL8+YVP8ohQ/pM0RsFz0RRb6yADxAmQWI8GxuetL2m8wuSA6dR2H87M1SDfjEcVwZKP2yEXyZQZfTqL06GsTGt/4mWLi93ALal4xFuux8v/QsoLKM+QW2qp1o6jzcFUiBi5JF7aPj6g2Yr+Dz26zeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSbbogJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSbbogJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBCB1F00893;
	Wed, 10 Jun 2026 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106700;
	bh=7Yigd3dAqyN9ZE6KmJF+/bxyvzUNbByWrEjA4dBC9gA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lSbbogJK7sBgHZHbQBHfpJwY3he1bZMvzQvyypx0peUakX+ruo1tAxEawpgfAGW7Y
	 2cpqNMnFcDrJHYQlj3hx73EVMprBuEwuguU0G/GvQM/B9TxObtjTuuZaeolYmsLzMM
	 d9cWnlzQOLwCXKGGs2LvRVXpEOLlsjETVaLEV0MFUbeC8DHFJddKhR+Etv6C+Cd00F
	 Qd4XTmcS8y6oi+reOuVVK4A30Io22TeDHcfxWRoa1U/iU0paOagxverXA3ZomNd1cz
	 XlheMalo6GMGuYvJlYXAg/UwMuQ/ejbtjmr7T3Zp5COU/e0tfHKl+D1oH/nQZ9zAbI
	 dLAiA92ZTEg5A==
Content-Type: multipart/mixed; boundary="===============7672714640087810166=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc91a6fbfbb53b29a1f48a07c8412caaca1a0f8429bf75d40f58272eacfdfcbd@mail.kernel.org>
In-Reply-To: <20260610143627.804790-3-jolsa@kernel.org>
References: <20260610143627.804790-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/6] bpf: Add support to specify uprobe_multi target via file descriptor
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,oleg@redhat.com,mhiramat@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 15:51:39 +0000 (UTC)

--===============7672714640087810166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d4188a992bd8..cef9bd6316a5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3475,7 +3475,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
>  				   "kretprobe_multi" : "kprobe_multi");
>  		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
> -			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
> +			seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
>  				   "uretprobe_multi" : "uprobe_multi");

This change in bpf_link_show_fdinfo() switches the uprobe_multi check from
an equality test to a bitwise test.  Once a second flag bit exists (the
BPF_F_UPROBE_MULTI_PATH_FD flag added by this same patch), a uretprobe_multi
link created with both flags set would be misreported as "uprobe_multi"
because the equality test no longer matches.

The equality comparison was introduced in:

  803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")

Should this change include:

  Fixes: 803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 970ce7bbf99e..f5d68f6d90f3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3214,6 +3215,38 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
>  	return run_ctx->uprobe->cookie;
>  }
>
> +static int bpf_uprobe_multi_get_path(const union bpf_attr *attr, struct path *path)
> +{
> +	void __user *upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> +	u32 path_fd = attr->link_create.uprobe_multi.path_fd;
> +	u32 flags = attr->link_create.uprobe_multi.flags;
> +
> +	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {

[ ... ]

> +	}
> +
> +	/*
> +	 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
> +	 * relative to the cwd (AT_FDCWD) or absolute using the upath string.
> +	 */
> +	if (!upath || path_fd)
> +		return -EINVAL;

This isn't a bug, but the non-FD branch (taken when
BPF_F_UPROBE_MULTI_PATH_FD is not set) reads path_fd in the check
'if (!upath || path_fd)'.

path_fd is only meaningful when BPF_F_UPROBE_MULTI_PATH_FD is set.  A caller
that supplies a valid string path but leaves path_fd as non-zero garbage (in
a struct large enough to include path_fd) would get a spurious -EINVAL here.

The garbage value is never dereferenced or used for arithmetic, so this looks
more like defensive input validation than a dangerous use, and old-style
callers passing the pre-path_fd struct size get path_fd zeroed and pass
cleanly.

Is rejecting a non-zero path_fd in the string-path mode intended, or should
path_fd be ignored when the flag is absent?

> +
> +	return user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, path);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27284577665
--===============7672714640087810166==--
