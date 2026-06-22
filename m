Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DE2853E0
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097724; cv=none; b=d4WUHk47eyqSfgGeAnKPnq7jBTFtHrx3enUXjVItmEJB4juYN/icJUCx1xPMma6taK3rt8XAbOZl/v6OdBwtuFsBKCBelpnnwf0NYuncrlVOFYtegmWQ1ogNQow0cr8lg4mK7qT8+LG+uBPSP+dx+t4vZwIW7SNZI5GFOEh0iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097724; c=relaxed/simple;
	bh=qo2cSk9OeYyX8Rvcx+3kLHdAvgsBDDJlw8vDrjFxEzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rA/lcee5qXxKYrHZqIstZbqpNvxpHgw9ilGYTxbZWp2n9a8jHIltCyGebkLVF+4JHkGW1IeHQaSfM/swkj3mX856ix5GBi0nF08yz5m/kgY+0L1gVhCqtj9LPS2SLg6KtEodi7cFuJ6XBvHrgGSephtFkBjx6L07dXlfs7ESXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwmzCAT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwmzCAT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61F81F000E9;
	Mon, 22 Jun 2026 03:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782097723;
	bh=pbc8df8pRgd6c3bGOvuHXWYLnoL6bVDFb0uBLQPNia8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwmzCAT0nDD3uTvGQ+YeE0ztuLHw6kyygOmHI2wyvJv1tdSzXKi9WdXEXso+Jl9Av
	 PC0+Xcd7eajf8oL14FI8PG+hAtmWq47xuzyDXNamtgIyxSNoy6WZfN0XCidGUGea7p
	 wpSOHdcF4gOMmsHlsV3qSOLgyEtnY7fZZ9vogG4Ay+1hrq1lHQeRP9t3fYD0TeDCLr
	 k5P51KlbwOkrkHHCi9zhYh2/yZjGTkc5C/GRojNdUtnYzrOkOWxsQXPMI0bvkkhSXJ
	 yP/UKX6Rqp0qR3ClHe0SL1KAQvTh6j/bStboh48QVX3PC42EG18yFinhkLfL3zszGr
	 avVZ9Y/V5Qb0Q==
From: sashiko-bot@kernel.org
Subject: Re: [stable/linux-6.18.y 1/2] lsm: add backing_file LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, paul@paul-moore.com
In-Reply-To: <20260622031416.2663747-2-caixinchen1@huawei.com>
References: <20260622031416.2663747-1-caixinchen1@huawei.com>
 <20260622031416.2663747-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:08:42 +0000
Message-Id: <20260622030842.D61F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Error paths in backing file allocation cause the `backing_file_fre=
e` LSM hooks to be invoked twice or with uninitialized state, and violate t=
eardown ordering.
- [Medium] `lbs_backing_file` is defined as `unsigned int` instead of `int`=
, causing `-Wincompatible-pointer-types` warnings.
- [Low] `lsm_backing_file_cache` is missing the `static` keyword, polluting=
 the global namespace and contradicting the commit message.
--

commit c7ac34e119da0f05f75151b3feefa3ded48b06cb
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

Stacked filesystems such as overlayfs do not currently provide the
necessary mechanisms for LSMs to properly enforce access controls on the
mmap() and mprotect() operations. In order to resolve this gap, a LSM
security blob is being added to the backing_file struct.

> Mainline declares lsm_backing_file_cache in security/lsm.h.  Linux 6.18.y
> does not have security/lsm_init.c or security/lsm.h; the cache variable
> is defined locally as static struct kmem_cache *lsm_backing_file_cache in
> security/security.c.

[Severity: Low]
This isn't a bug, but the commit message explicitly states the cache
variable is defined locally as static, yet the actual definition in
security/security.c omits the static keyword.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 762f03dcbcd77..987e01da99389 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -301,7 +319,8 @@ static int init_backing_file(struct backing_file *ff)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
> +				      const struct file *user_file)
>  {
>  	struct backing_file *ff;
>  	int error;
> @@ -318,7 +337,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);
>  		return ERR_PTR(error);
>  	}

[Severity: High]
Can this error path cause a double-free regression or execute
uninitialized hooks?

If init_backing_file() fails because a security module hook returns an
error, security_backing_file_alloc() internally rolls back the state by
calling security_backing_file_free() before returning the error.

When the error is returned here, fput(&ff->file) is called.

Since the file mode already contains the backing bit, fput() triggers
a cleanup cascade that calls file_free(), which in turn calls
backing_file_free().

This sequence invokes security_backing_file_free() a second time on the
same file with a null blob.

If the initial blob allocation fails instead and lsm_backing_file_alloc()
returns an out of memory error, it skips the internal free but still
returns an error. The fput() call still drives the cleanup, and the
backing_file_free void hooks are executed unconditionally despite the
allocation hook never having run.

Additionally, in the teardown sequence inside file_free(),
security_file_free(f) is called before backing_file_free().

Does destroying the base object's security state before the backing
file's state expose any security hooks to a use-after-free, if they
attempt to access the base file state during backing file teardown?

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 79ec5a2bdcca7..e0707ec5a76dc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -104,6 +104,7 @@ struct security_hook_list {
>  struct lsm_blob_sizes {
>  	int lbs_cred;
>  	int lbs_file;
> +	unsigned int lbs_backing_file;

[Severity: Medium]
Is this intentional? The other blob size fields in struct lsm_blob_sizes
are declared as int.

In security/security.c:lsm_set_blob_sizes(), the address of this field
is passed to lsm_set_blob_size(int *need, int *lbs):

lsm_set_blob_size(&needed->lbs_backing_file, &blob_sizes.lbs_backing_file);

Could passing an unsigned int pointer to an int pointer generate a
pointer type warning that could break builds configured to treat warnings
as errors?

> diff --git a/security/security.c b/security/security.c
> index 603c3c6d5635d..5d5ad55dbca76 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -94,6 +94,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX + 1] =3D {
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> =20
>  static struct kmem_cache *lsm_file_cache;
> +struct kmem_cache *lsm_backing_file_cache;

[Severity: Low]
Would this missing static modifier pollute the global symbol namespace?

As mentioned in the commit message, this was intended to be locally
defined.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031416.2663=
747-2-caixinchen1@huawei.com?part=3D1
