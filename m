Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFF13AF2
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097866; cv=none; b=M3pgRmq6dzS9zZ/5xQUEO2kVcqQqwvy5AmSpbaY/8wsu0h07dkRqbXpRFZvLhz66pw2srM1b7F6tJ2wW62zWoQuaGL16eapWzad3px7sWlOZTJwB/WFZLvDDFCj5wyWKlKX9KXYwZAYI7XXyPzHvxG4YpM0PXLNuQxgQgmy+YeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097866; c=relaxed/simple;
	bh=EyJ+JTGSwvQeOygqestQg2r99z6RqYaM2U6YOU5/Ng0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oaBrDrkECTyG+hO2B6m9y826LKddEsAI9PhhFlK5OHpVrceEvssATwRgnWdb64PLH1PqwC4OGM4V+iGDdGiFIpDoZY8xL7pvQb6xQvAOI7PwxboI8jeqCZ5LwtIqsoaLFfxMTKPJkluJeDeYm09m0i/wiBKtaFdnkP9gDSHMfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1l+9bn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1l+9bn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105941F000E9;
	Mon, 22 Jun 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782097865;
	bh=MCCFpdJC4Gh+yrpEWxYeSGT5W2rPLNrKMpImet72lKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n1l+9bn2DR5IFNHgr+bNZMzzDfbBUnW26gmxVCgLwdFIZctZumviZRt4BFc7WRuS1
	 VyXP4YlWs1dBZ7t7JdJ9OsZOLkwz3DDMtMnn9ihSnakNuxFK1tQMrc9SHCt4nHk8oa
	 ZpNtvCNymgx4ApVW44JyWGWET7ME3yFGzD3O9lsZMxsM/BTQlDYvsS7mCwYHX2grxV
	 uG+5OJy1dFgZyWYmfc5XsZGlZHeQTLJfitNIwx3Z0GHau9UtRl1EqbZGEa5n4o0xny
	 Kw/el5Ts/S4ZT+AGXjrGh1CpKHAziLTOkuO4/MojOYd3Vjg36BV0Ic0Q9LCXVLLW8X
	 vmhL1VjCT4oAg==
From: sashiko-bot@kernel.org
Subject: Re: [stable/linux-6.12.y 1/2] lsm: add backing_file LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, paul@paul-moore.com
In-Reply-To: <20260622031509.2663919-2-caixinchen1@huawei.com>
References: <20260622031509.2663919-1-caixinchen1@huawei.com>
 <20260622031509.2663919-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:11:04 +0000
Message-Id: <20260622031105.105941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double-free and NULL pointer dereference in backing_file error pat=
h.
- [Low] Compiler warning due to pointer signedness mismatch in `lsm_blob_si=
zes`.
--

commit c06a83c8499b5a2cfb9d2bf689d02826faee9cb1
Author: Paul Moore <paul@paul-moore.com>
Subject: lsm: add backing_file LSM hooks

This commit adds a new LSM security blob to the backing_file struct and
introduces three new LSM hooks to manage its lifecycle and authorize mmap()
operations. These changes provide the necessary mechanisms for LSMs to
enforce access controls on mmap() and mprotect() for stacked filesystems.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 2a08bc93b0b9c..a771be30eb43d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -289,7 +308,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);

[Severity: High]
Does this fput() trigger a double-free on the error path?

FMODE_BACKING is set on the file before init_backing_file() is called.
If init_backing_file() fails (which delegates to
security_backing_file_alloc()), this fput() will eventually call
backing_file_free() and then security_backing_file_free().

However, security_backing_file_alloc() already cleans up after itself on
failure by calling security_backing_file_free() explicitly, leading to it
being called twice.

>  		return ERR_PTR(error);
>  	}
[ ... ]
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 090d1d3e19fed..12b1576d5b027 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -104,6 +104,7 @@ struct security_hook_list {
>  struct lsm_blob_sizes {
>  	int lbs_cred;
>  	int lbs_file;
> +	unsigned int lbs_backing_file;

[Severity: Low]
Does this cause a compiler warning due to a pointer signedness mismatch?

The other fields in struct lsm_blob_sizes are declared as int, but this
is unsigned int. When passed to lsm_set_blob_size() in security.c, it
expects an int pointer, which could break builds configured with -Werror.

>  	int lbs_ib;
>  	int lbs_inode;
[ ... ]
> diff --git a/security/security.c b/security/security.c
> index 6e4deac6ec073..aef71585d49ef 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -2893,6 +2925,57 @@ void security_file_free(struct file *file)
>  	}
>  }
> =20
> +/**
> + * security_backing_file_alloc() - Allocate and setup a backing file blob
> + * @backing_file: the backing file
> + * @user_file: the associated user visible file
> + *
[ ... ]
> + */
> +int security_backing_file_alloc(struct file *backing_file,
> +				const struct file *user_file)
> +{
> +	int rc;
> +
> +	rc =3D lsm_backing_file_alloc(backing_file);
> +	if (rc)
> +		return rc;
> +	rc =3D call_int_hook(backing_file_alloc, backing_file, user_file);
> +	if (unlikely(rc))
> +		security_backing_file_free(backing_file);

[Severity: High]
This explicit cleanup on failure seems to conflict with the fput() in
alloc_empty_backing_file() mentioned above. Will this result in
security_backing_file_free() being called twice for the same file?

> +
> +	return rc;
> +}
> +
> +/**
> + * security_backing_file_free() - Free a backing file blob
> + * @backing_file: the backing file
> + *
> + * Free any LSM state associate with a backing file's LSM blob, includin=
g the
> + * blob itself.
> + */
> +void security_backing_file_free(struct file *backing_file)
> +{
> +	void *blob =3D backing_file_security(backing_file);
> +
> +	call_void_hook(backing_file_free, backing_file);

[Severity: High]
Can this unconditionally trigger an invalid pointer dereference?

If security_backing_file_free() is called on an error path where the blob
allocation failed (or on the second call of a double-free), the security
blob will be NULL.

Calling the LSM free hooks before checking if the blob is NULL can cause
LSMs to dereference a NULL pointer when calculating their internal state
pointers.

> +
> +	if (blob) {
> +		backing_file_set_security(backing_file, NULL);
> +		kmem_cache_free(lsm_backing_file_cache, blob);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031509.2663=
919-2-caixinchen1@huawei.com?part=3D1
