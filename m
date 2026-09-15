Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5442C500
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489568; cv=none; b=ajkSBOQjhiUrMyg1CVzfTjIufp3nUaxzAbjCJX7DmVV3qr+jwzv6etpAA821zlaaCwdZ/YGAkzgBm6kE7s6Ns5ozTMYF0ZEQRhsLm0aHFPZWzOpVNzq3fS40YM2NhFuSwLmHvKtJM9O/ZUfmllf7KgaYDIUCYLcXQ5IRkvhyr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489568; c=relaxed/simple;
	bh=5mj8tHkXXF9BSNCE7+TUoNqQzFy5A4Y95djiOTXmgMc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OsiKv/vl3TO/BNeH08VqGJUEba3ds1rb1Haw5r8bGuDT4yHhEo+9JVSIEI3oeyI0nkvxKtZCgmrpeOqWW+9ZYHv18VZ/C4JTdxNFjxHW6Cd/dm/QZgItUXfmxEqutlYc6FEmn0MwEehdY2OEzDWUBbXkjwqTeMEzkYijOW/deQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8ni4hlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8ni4hlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2161F00893;
	Tue, 15 Sep 2026 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489566;
	bh=Zeo8wHSpe1xffsWZGrZZyEoAPbHbVU9j2Qs3j49n72E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P8ni4hlVhvaHJRnC04db0CScHYiyGvEUaDS/IxPxBRH4rSFcfVbyHm4ezhSCqkZbo
	 TK3OI2d2mhVWc83J1yvEmyerd9ewyX3HdZbOhL3BVOkMOpcixeEbNM8ie7CbTdqTW0
	 +HzFWLwVGKNE2awmHMSBE7wBSpEnJXsPxV5JFhBtIAczLWNx/RfSVM/S4t7jmHo48Z
	 DraGdPKjRf5NOK59K/AB0Y8kYd4tcmF/puMerm4oBlitNRO38RX/5aGCPi8mjUBOVc
	 w6uOMoj9Ej7yqiHxmIA34145SQ3zlSEr/CQ5e0frWhEz5lw+045X7cscn8utkrXVVZ
	 TktAcFr98RxdA==
Content-Type: multipart/mixed; boundary="===============5240696140086466740=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3529bce28450ccf6a648ff56e3dfcf170acec5c7f23b8a67b525f1239791ec9f@mail.kernel.org>
In-Reply-To: <20260915150739.284189-8-daniel@iogearbox.net>
References: <20260915150739.284189-8-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Add verifier tests for the __ctx_out plumbing
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,dwindsor@gmail.com,john.fastabend@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 16:26:05 +0000 (UTC)

--===============5240696140086466740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index ae71e9b690518..1b408fe9e0fbc 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -78,18 +78,29 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
>  extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_ptr,
>  				      const struct bpf_dynptr *sig_ptr,
>  				      struct bpf_key *trusted_keyring) __ksym;
> -
> -struct dentry;
> -/* Description
> +/*
> + * Description
>   *  Returns xattr of a dentry
>   * Returns
>   *  Error code
>   */
> +struct dentry;
>  extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
>  			      struct bpf_dynptr *value_ptr) __ksym __weak;
> -
>  extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
>  				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
>  extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;

This isn't a bug, but are the blank-line removals and the reflow of the
bpf_get_dentry_xattr() comment needed for the new declaration? The rest
of the file keeps blank lines between declaration groups, and the six
other comment blocks use the old form. Could these changes be left out,
or moved to a separate cleanup that converts all the blocks in this
header at once?

>
> +/*
> + * Description
> + *  Attach a xattr to an inode that is being created, from a program on the
> + *  inode_init_security LSM hook. *xattrs* and *xattr_count* must be the
> + *  hook's own arguments, passed through unmodified.
> + * Returns
> + *  0 on success, a negative value on error
> + */
> +struct xattr;
> +extern int bpf_inode_init_xattr(struct xattr *xattrs, int *xattr_count,
> +				const char *name__str,
> +				const struct bpf_dynptr *value_p) __ksym __weak;

This isn't a bug, but would it read better to keep the kernel's
xattr_count__ctx_out name here? The rest of the declarations in this
header keep their __str/__sz/__uninit suffixes, but this one drops the
__ctx_out marker that tells a BPF author the argument is special.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c b/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c
> new file mode 100644
> index 0000000000000..b706bf17b5560
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c

[ ... ]

> +SEC("lsm/inode_init_security")
> +__success
> +int BPF_PROG(allow_spilled_count, struct inode *inode, struct inode *dir,
> +	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
> +{
> +	struct bpf_dynptr value;
> +	int *saved = xattr_count;
> +
> +	if (!xattrs)
> +		return 0;
> +
> +	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
> +	bpf_inode_init_xattr(xattrs, saved, xattr_zone, &value);
> +	return 0;
> +}

This isn't a bug, but does allow_spilled_count actually exercise a
spill/fill of the __ctx_out pointer? Since r6-r9 are callee-saved,
clang can keep saved in a register across the two calls, in which case
this duplicates the plain register-propagation case. Would forcing the
spill with explicit inline asm (as verifier_value_adj_spill.c does), or
renaming the test to reflect a copied-register case, describe the
coverage more accurately?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34989961168
--===============5240696140086466740==--
