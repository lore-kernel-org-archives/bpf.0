Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78D25B0B9
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098396; cv=none; b=LbXNLG/l0tFsSlX43ElcMgMQuwl49UvfPjc0tXqXO92Hdglvc0bJ1AZCEkPxTJ/iYPA9mPylLlRhZpMfs7UkcNj8uNedOfVCbZ/lG09i2ImzaYT+8LUhMxphE9TsWNJsO+3J6j9300GzRYRZSuEIAK6+pnZfY7EP7djYTPfkEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098396; c=relaxed/simple;
	bh=GVCqnR3wdZr79xKbkoS1FEkqVr8/P3hy1dxelix41T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cy1xDzsgVgJLVDlPegsIYEdj1/VFUlCxn/TbRCqjjPXh/n6mzOEeq81ZrBEQ5hHVXepIpzbVtn7tp7v2HmHl08BUB4Q7/zoqkSVkZ6zwNskNvABB51A3U1rgECNbxaScCFCCbWR94YmK8LqkerURBsO9mSkwHWlzEN3xecHN7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuTz9TnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuTz9TnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF651F000E9;
	Mon, 22 Jun 2026 03:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782098395;
	bh=jxgcfp13AnZ0k8qFr6HL3BCkR1c2BF/p0DpyAfyM3Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuTz9TnDvJaH/v6mgUmq24jiFLAW0yKg7sikfapCszLmv2yQuOO/NdBeYLelOzPWC
	 ZfC3apN6tH1pAOrZIbf74/OZUpeYckq/lL3AAzdVJTKwWyCq3shOIuf1SaAEJy4MEb
	 THgvnG9eCxu1A/bwh2JjPhWkYwkO4hqfeNlmlo6xW0WaMbkuM2aCKFNAXpEWDdLwt1
	 ONxvDUBf6kmY4Zc1cqvbkqh30Ke8oqlJfK15iR6YGNKvJCp0D4lQ00s0ttE2rqR5/q
	 flqWy3yYLQu9n8Mz1fAo5XT6fwK+JlObaBklflDucUzSdAMfpVdF2rNRgmnJcK30mL
	 RggqypPJ/L2zw==
From: sashiko-bot@kernel.org
Subject: Re: [stable/linux-6.6.y 3/3] selinux: fix overlayfs mmap() and
 mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, paul@paul-moore.com
In-Reply-To: <20260622031556.2664089-4-caixinchen1@huawei.com>
References: <20260622031556.2664089-1-caixinchen1@huawei.com>
 <20260622031556.2664089-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:19:55 +0000
Message-Id: <20260622031955.7CF651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `PROCESS__EXECMEM` permission is incorrectly evaluated against=
 the mounter's credentials for backing files, causing spurious access denia=
ls.
- [Low] The patch references undefined LSM hooks and structures for backing=
 files, causing a compilation failure.
--

commit 65acd7a339b0b894f76445b113fd808e3582ef18
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

The existing SELinux security model for overlayfs allows access if the
current task can access the top-level file and the mounter can access the
backing file. This commit updates the mmap() and mprotect() operations
to use the newly created LSM hooks to properly enforce access controls
for the backing file.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 60092d0b013ce..3f11c5ae8fbf0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -3755,42 +3789,55 @@ static int selinux_file_ioctl_compat(struct file =
*file, unsigned int cmd,
> =20
>  static int default_noexec __ro_after_init;
> =20
> -static int file_map_prot_check(struct file *file, unsigned long prot, in=
t shared)
> +static int __file_map_prot_check(const struct cred *cred,
> +				 const struct file *file, unsigned long prot,
> +				 bool shared, bool bf_user_file)
>  {

[ ... ]

> +	if (default_noexec && prot_exec &&
> +	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
> +		int rc;
> +		u32 sid =3D cred_sid(cred);
> =20
>  		/*
> -		 * We are making executable an anonymous mapping or a
> -		 * private file mapping that will also be writable.
> -		 * This has an additional check.
> +		 * We are making executable an anonymous mapping or a private
> +		 * file mapping that will also be writable.
>  		 */
> -		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> -				  PROCESS__EXECMEM, NULL);
> +		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM,
> +				  NULL);

[Severity: High]
When this is evaluated for a backing file, is the check performed against
the mounter's credentials instead of the current task?

In selinux_mmap_backing_file(), the mounter's credentials are passed:

selinux_mmap_backing_file()
  selinux_mmap_file_common(backing_file->f_cred, ...)
    file_map_prot_check(cred, ...)
      __file_map_prot_check(cred, ...)

This leads to evaluating the process-level PROCESS__EXECMEM permission agai=
nst
the mounter's SID rather than the actual process mapping the memory.

Could this cause spurious access denials if the mounter lacks execmem
permissions, breaking containerized applications?

[ ... ]

> @@ -6870,6 +6981,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_a=
ux *aux)
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
>  	.lbs_cred =3D sizeof(struct task_security_struct),
>  	.lbs_file =3D sizeof(struct file_security_struct),
> +	.lbs_backing_file =3D sizeof(struct backing_file_security_struct),

[Severity: Low]
Does this assign to a non-existent field in struct lsm_blob_sizes?

The core LSM infrastructure doesn't appear to define .lbs_backing_file in
this tree. Is this patch missing prerequisite commits from the backport?

[ ... ]

> @@ -7074,9 +7186,11 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
> =20
>  	LSM_HOOK_INIT(file_permission, selinux_file_permission),
>  	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
> +	LSM_HOOK_INIT(backing_file_alloc, selinux_backing_file_alloc),
>  	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
>  	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>  	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
> +	LSM_HOOK_INIT(mmap_backing_file, selinux_mmap_backing_file),

[Severity: Low]
Are backing_file_alloc and mmap_backing_file missing their definitions
in the core LSM infrastructure?

Attempting to initialize these hooks causes a compilation failure here.

> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 8159fd53c3de2..541933dd295c0 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h

[ ... ]

> @@ -158,6 +162,13 @@ static inline struct file_security_struct *selinux_f=
ile(const struct file *file)
>  	return file->f_security + selinux_blob_sizes.lbs_file;
>  }
> =20
> +static inline struct backing_file_security_struct *
> +selinux_backing_file(const struct file *backing_file)
> +{
> +	void *blob =3D backing_file_security(backing_file);
> +	return blob + selinux_blob_sizes.lbs_backing_file;
> +}

[Severity: Low]
Is backing_file_security() an undeclared function in this codebase?

Since the prerequisite LSM hooks for backing files appear to be missing,
calling this will result in a build failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031556.2664=
089-4-caixinchen1@huawei.com?part=3D1
