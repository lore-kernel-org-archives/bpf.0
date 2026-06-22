Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B641B3B19
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097421; cv=none; b=pNRPEq/zPEP3T7O5TCeQHF9tY9HEe1bS+fwGFdQuVfuDVUumzPrp00ZWT26KcETzsCDBh4vWhrH5EVk4ncAapaVxLQPd/1xOXhT47OMuH+jm6N3RwU2gvN+qRf+JJufSDMUr+55Mg67aSyZmUkdA9ZsMMNaM+Y2s6Es/MJicau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097421; c=relaxed/simple;
	bh=gVlXQ/a30gHzSERq7/+iMVjJZkgCCZjjvJlWwqIxDj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzVArunI5guPac8ys0hwh7qEEL7syfDiuAA/Gph20YFahE/HI7nkwlHDzqxtbW7y2JGIIjs0BD3DrfASF3FDnxBSdHsHdHT87VfplBGo9/0Z36dxSPkyzOMqpXAteh00haG7a2ONHDmpyttomNlXa6EkNI+tP1pjopZ539PrX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/GfTSYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/GfTSYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEE31F000E9;
	Mon, 22 Jun 2026 03:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782097420;
	bh=V7lW5oDEHChFF06LaJw+8gVdyolvYI6NIc6SunWsmQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/GfTSYxCr6b2ntCauDgnqBjke5tQIjSZPNAk0TxhGC6pUD4/TqpLS/fw9CSV88ea
	 b+fwMlnij8ewk9m6ApRQT+Wn7WWaMdVBPmEVCgItLvvis4zEvltZaghuo1H33MrTwM
	 M4qsiqDy2FpHweUn6R6vVzslivrGy9FNux+3w4xw8Ig1rIHAn1e/rw0EQe6ar+Inmt
	 /kt4Hjl7cwFhPgdooD6B0vXrBpr+uh+r/Fu203L8iMQMNkbHMy4DQiWQc29eNMEExz
	 rojknf5DFxI14lMeUc0DcO2WZNVWf4yylW6PtYatiXgsDTKpbh1GLCKYDgKzgj8Cja
	 SOLbxJsnR5kLA==
From: sashiko-bot@kernel.org
Subject: Re: [stable/linux-6.18.y 2/2] selinux: fix overlayfs mmap() and
 mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, paul@paul-moore.com
In-Reply-To: <20260622031416.2663747-3-caixinchen1@huawei.com>
References: <20260622031416.2663747-1-caixinchen1@huawei.com>
 <20260622031416.2663747-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:03:39 +0000
Message-Id: <20260622030340.0BEE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incorrect SELinux PROCESS__EXECMEM capability check against the mo=
unter's credentials for backing files.

Pre-existing issues:
- [High] Use of `!file` to classify anonymous VMAs bypasses the SELinux PRO=
CESS__EXECSTACK security check for /dev/zero mappings.
--

commit fc1612e3086f71b6727cf2b1788b9dcb2edf19fb
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

The existing SELinux security model for overlayfs is to allow access if
the current task is able to access the top level file (the "user" file)
and the mounter's credentials are sufficient to access the lower
level file (the "backing" file).

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3da3017ad2ca0..f96ee8f372e3b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3916,42 +3950,55 @@ static int selinux_file_ioctl_compat(struct file =
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
> -	const struct cred *cred =3D current_cred();
> -	u32 sid =3D cred_sid(cred);
> -	int rc =3D 0;
> +	struct inode *inode =3D NULL;
> +	bool prot_exec =3D prot & PROT_EXEC;
> +	bool prot_write =3D prot & PROT_WRITE;
> +
> +	if (file) {
> +		if (bf_user_file)
> +			inode =3D d_inode(backing_file_user_path(file)->dentry);
> +		else
> +			inode =3D file_inode(file);
> +	}
> +
> +	if (default_noexec && prot_exec &&
> +	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
> +		int rc;
> +		u32 sid =3D cred_sid(cred);
> =20
> -	if (default_noexec &&
> -	    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
> -				   (!shared && (prot & PROT_WRITE)))) {
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
Does this code inadvertently check the mounter's credentials for the
PROCESS__EXECMEM capability when handling backing files?

In __file_map_prot_check(), the EXECMEM permission is verified using the
subject ID derived from the 'cred' argument. When this is called for backing
files from selinux_file_mprotect() or selinux_mmap_backing_file(), the
backing_file->f_cred (the mounter's credentials) is passed instead of the
calling process's credentials.

Because EXECMEM restricts process memory creation, shouldn't this check
apply to the current user process rather than the mounter's domain? This
might cause legitimate memory mappings to be falsely rejected if the mounter
lacks this permission.

> +		if (rc)
> +			return rc;
>  	}

[ ... ]

> @@ -4010,11 +4101,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>  		    vma->vm_end <=3D vma->vm_mm->brk) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +			if (rc)
> +				return rc;
> +		} else if (!file && (vma_is_initial_stack(vma) ||
>  			    vma_is_stack_for_current(vma))) {

[Severity: High]
This isn't a bug introduced by this patch, but does checking '!file'
accurately identify anonymous VMAs for the PROCESS__EXECSTACK check?

According to the MM subsystem guidelines, evaluating 'vma->vm_file =3D=3D N=
ULL'
is incorrect for classifying a VMA as anonymous, because private mappings of
/dev/zero have a valid vm_file but remain anonymous mappings without vm_ops.

If an attacker uses a private mapping of /dev/zero as a stack, '!file'
evaluates to false, bypassing the PROCESS__EXECSTACK mitigation and falling
through to the FILE__EXECMOD check instead. Could this be corrected to use
vma_is_anonymous(vma) as the discriminator?

>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECSTACK, NULL);
> -		} else if (vma->vm_file && vma->anon_vma) {
> +			if (rc)
> +				return rc;
> +		} else if (file && vma->anon_vma) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031416.2663=
747-3-caixinchen1@huawei.com?part=3D1
