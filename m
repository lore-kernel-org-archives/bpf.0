Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C192FDC5E;
	Fri, 27 Mar 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613947; cv=none; b=V3nvVw52rgMbREjQA2kmjnFY9wOi6WVG3kkkysxHftn4GXQJKWd8IFA6uD/cnoS4HBEfUwLys6Qw9dSKoeF+9/N0mkFmc/7HAAMbqUolScTET3ipiZgxvulzhYVHb1OQqw8pzk6JoJ90fyslfEnaIRK7Ld30TNv2hWQfLvvL+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613947; c=relaxed/simple;
	bh=vOf9JpiJqLBAVffpWxFYe1jMzCTrAUeY8ihzrFmTcLM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WcuQ2f8QIiBES4wnPMEE3UhREN2LGhFhk0j2KIwD/3K03FN5Av3bIa1D+K06GXlvwg+B/0BOamyaUPfvA3zDXzAr0whBCPvu4rMrN0cNllwxIJ0e2syv6oiHTohzPGlNROn4FpXmt9CCKi1rgfw4qNetxfuIjUnolYc4LKljgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT7ld0MR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT7ld0MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28870C2BC86;
	Fri, 27 Mar 2026 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613947;
	bh=vOf9JpiJqLBAVffpWxFYe1jMzCTrAUeY8ihzrFmTcLM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TT7ld0MRJx6IUHvNp38ae6q4SBmb6njUx181P5uRwfy5R45PUarx5UuX4up24I0eb
	 1zEMypb/e1w42pE2eEKZuifZW6iavBlCSE0fWSzZfSxAigPth3KCX2ERWDWBPJHH8b
	 /2qvSgvIy3HIMhZWZ+k/Bnhyt71LnWUc98Ih10HF+NhYRA5VYTHjJVbFoWYrCkfhD0
	 X+D4VEk92gnP3LUwLFathHjDI5UU6919AcoFFAFxwUIwWzyExSqRNpTXjv+10da/M4
	 EgIKYqBCas3Sg0SeqcdOZjtw2j2Hx3DWM9wM/P+QDHKDa2c2qL4kBUAvYB7sSsPgAA
	 aeQUpqxXyhfdw==
Content-Type: multipart/mixed; boundary="===============2884610874117475039=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0129a179266ecd9071d04e6db172790e3e1dc2a70c896e91069bd12724776569@mail.kernel.org>
In-Reply-To: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
From: bot+bpf-ci@kernel.org
To: brauner@kernel.org,amir73il@gmail.com
Cc: viro@zeniv.linux.org.uk,jack@suse.cz,daniel@iogearbox.net,ast@kernel.org,linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,brauner@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Mar 2026 12:19:07 +0000 (UTC)

--===============2884610874117475039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..fc30aa906b8c 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +	return d_real_inode(dentry);
> +}

[ ... ]

> +BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE)

d_real_inode() calls d_inode(d_real(dentry, D_REAL_DATA)), and
d_inode() returns dentry->d_inode, which is NULL for negative
dentries.

BPF LSM programs can be attached to hooks that receive negative
dentries, for example security_inode_create() or
security_inode_mkdir(), where the dentry represents a name that
does not yet exist.  If a BPF program passes such a dentry to
bpf_real_inode() and then dereferences the returned pointer, does
this result in a NULL pointer dereference?

Without KF_RET_NULL, the verifier marks the return as
PTR_TO_BTF_ID | PTR_TRUSTED, so it will not require a NULL check
before the BPF program accesses the returned inode.  Should this
have KF_RET_NULL to let the verifier enforce a NULL check?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23644830944
--===============2884610874117475039==--
