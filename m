Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786A441638;
	Wed, 23 Sep 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144185; cv=none; b=O23XvXDAn9pwxWJCXt7fonBD+znIUogCN4+9QpSN4QdGwl/EnxbD6n8Jr1kwRL7HhpOXLoEhNCVCqVM4bz6MtzR823v6KiE/UxYs92HMCVgpfkW/uM1mYiy2lw/AkAjICD0anLpccqgBpwjzjLxEIjJFa1E17ZJRmsr+L5VcJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144185; c=relaxed/simple;
	bh=kMRv8eCNm2nztJhHwCjpaRmZ6NvST8TtkElXLsI7wdk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BDlyLldr0rwQdzRrAGu2fHCXYZbclIxv1pHJjqIQHqFOmFBRJEqhGTlOPwjdmXnelhmtcu7eOzawAumMehCE8mghiyarg3tEyIypLY/4VT+8hA08ykPvtWTVWbzjc2HvKRo1TlL/4lpz5tZXyWdEZt5+5GZCnGHSOrUcLYlh7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnOjFpcS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnOjFpcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870741F000FF;
	Wed, 23 Sep 2026 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790144184;
	bh=0rzrMSvbWOaFyMMs1F7rT8VAWWrV5i4g+RGli8kTCk8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RnOjFpcSMohGY69dj7vrqmPAe88HjF+SkmNmBRdN148kPIT/gP6hIc9omjZURvBYm
	 pKNnpBy8SJIGwb4TQeLwayzKaqaxQlu8tDX4ulkoUPn6gAriJL8yIEz1wNxcaocm0/
	 5FxD9iETI1AWEnBx+vnDQx/tdLkNR4Kv6kKOo+TJOLUycKZHebNHlObaP8KJVzSM2e
	 f3mRjnpdv8RbhG+PDUW0PLRYzHNQ+fr7P/4NCC+hXW+wcmlLSm0FBAAy5ff9yiYIL8
	 vAh48MmHnHV/9G6aAfdvkZrIaTTFklDNS9CFA0ldrWz0kI3drzNzkXkYkKrkRUR69/
	 hHp/O0+oCBboQ==
Content-Type: multipart/mixed; boundary="===============2477945947446860180=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ae62cc7c8da94b68778bfd040a658730a7b098ddc64f6d23d9a4a895f71b994@mail.kernel.org>
In-Reply-To: <20260923053948.30617-3-wanjay@amazon.com>
References: <20260923053948.30617-3-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,linux-modules@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 06:16:21 +0000 (UTC)

--===============2477945947446860180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 1178acd72296..bf3004908d15 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a6634237dc89..c3c1421208b4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -10135,32 +10150,36 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
>  	return NULL;
>  }
>
> -int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +static int btf_struct_ops_add(struct btf *btf, struct bpf_struct_ops *st_ops)
>  {
>  	struct bpf_verifier_log *log;
> -	struct btf *btf;
> -	int err = 0;
> -
> -	btf = btf_get_module_btf(st_ops->owner);
> -	if (!btf)
> -		return check_btf_kconfigs(st_ops->owner, "struct_ops");
> -	if (IS_ERR(btf))
> -		return PTR_ERR(btf);
> +	int err;
>
>  	log = kzalloc_obj(*log, GFP_KERNEL | __GFP_NOWARN);
> -	if (!log) {
> -		err = -ENOMEM;
> -		goto errout;
> -	}
> +	if (!log)
> +		return -ENOMEM;
>
>  	log->level = BPF_LOG_KERNEL;
>
>  	err = btf_add_struct_ops(btf, st_ops, log);

This isn't a bug, but btf_struct_ops_add() sits next to the existing
btf_add_struct_ops() that it calls - would a name that does not mirror
the callee, for example btf_register_struct_ops() or
btf_struct_ops_add_locked(), read more clearly here?

The two names differ only in word order, and a reader scanning the file
or grepping has to check which of the two is the wrapper.

>
> -errout:
>  	kfree(log);
> -	btf_put(btf);
> +	return err;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35824427607
--===============2477945947446860180==--
