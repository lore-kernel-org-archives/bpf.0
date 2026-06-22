Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3B24677B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097498; cv=none; b=pYpPyoe02Jj0pnsJQpl7UFRVtgqAfjhFbhmpZIiY/Qb2hJMNnQDSbTELRlEGscLXyEJC+Q0JB6fcfJkREaaT4SQ9CWJ3tnzfFQvQaLFYpRH/1KXhhAk0uIJ10x6NfxOhrCtKfz5f0rgSzaGZH1j/s/5WS8BeboUjz+HHaOpsje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097498; c=relaxed/simple;
	bh=frr0UCdufQNqnZlio0HjTiMLpc1NaPKc6r04qGf6adE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GL8hLDpnMzGxucnEB9/w+pEOPykzxzCsTOhHLnY4NISIU5zO0MQrWDoAsqvURnCh7soCQb4ZXMs8Q0bFNQKTculkh47lwGjvljiK0RcAK64V0QHmk7n+NyTiV4Twau7PHxcjum5IBJXHLZ6cCat3rXblzCkUQ+CK0RmjkMBzUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZd7rtPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZd7rtPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B043E1F000E9;
	Mon, 22 Jun 2026 03:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782097496;
	bh=QRg/3gVcvWYTquffdFmZWj3pMbmLgll1TxMbBeuoMuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZd7rtPzTR7FgkyGMNm2PQbFxpWXX3kq6QPh2XGIGJpeRrtcZ9NCFS2PBjIOWcfZq
	 hM9OSeoLyq6wRUsFKkI6+1THYqwCtcS/sHvz3ttDAUOZuMxUgsQb8j6Xl8U0rLzwYV
	 41e30tWmnC3Db0I1DKyzHD2/akSgjAYYHDSl87o41PGK8nmXkgr4n6uBEzJu9Sk5c0
	 JZ3/XsY0twvS4Rqmo24AhCYg71em/inhx79jE7lwiGuTkgCO556PIazTH+Ijev7tAM
	 UxabLo6mIULg9vuB7tXCI5v9mJbjwI/wrbCYg1FhfgTr0e/nIaI8eUJR4wPV6d3cXO
	 t5ZZ6K/GE+q6g==
From: sashiko-bot@kernel.org
Subject: Re: [stable/linux-6.12.y 2/2] selinux: fix overlayfs mmap() and
 mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: paul@paul-moore.com, bpf@vger.kernel.org
In-Reply-To: <20260622031509.2663919-3-caixinchen1@huawei.com>
References: <20260622031509.2663919-1-caixinchen1@huawei.com>
 <20260622031509.2663919-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:04:56 +0000
Message-Id: <20260622030456.B043E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The PROCESS__EXECMEM permission is incorrectly evaluated against t=
he mounter's credentials instead of the executing task when mapping a backi=
ng file.
- [Low] The patch references undefined struct members, functions, and LSM h=
ooks, causing a build failure.
- [Low] Calling `backing_file_user_path()` with a `const struct file *` dis=
cards the `const` qualifier.

Pre-existing issues:
- [High] The code incorrectly uses `!file` to determine if a VMA is an anon=
ymous stack mapping, creating a potential SELinux bypass.
--

commit ad3233d429cee42bb2ed783a8bd563912a4bf6bd
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

This patch updates SELinux to enforce backing file access controls for
mmap() and mprotect() operations on overlayfs. It introduces checks using
the newly created security_mmap_backing_file() LSM hook and backing file
APIs.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8e31d3b60fc62..1b89c8d5fa2fc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -1724,49 +1724,72 @@ static inline int file_path_has_perm(const struct=
 cred *cred,
> +static int __file_has_perm(const struct cred *cred, const struct file *f=
ile,
> +			   u32 av, bool bf_user_file)
> +
>  {
> -	struct file_security_struct *fsec =3D selinux_file(file);
> -	struct inode *inode =3D file_inode(file);
>  	struct common_audit_data ad;
> -	u32 sid =3D cred_sid(cred);
> +	struct inode *inode;
> +	u32 ssid =3D cred_sid(cred);
> +	u32 tsid_fd;
>  	int rc;
> =20
> -	ad.type =3D LSM_AUDIT_DATA_FILE;
> -	ad.u.file =3D file;
> +	if (bf_user_file) {
> +		struct backing_file_security_struct *bfsec;
> +		const struct path *path;
> +
> +		if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
> +			return -EIO;
> +
> +		bfsec =3D selinux_backing_file(file);
> +		path =3D backing_file_user_path(file);

[Severity: Low]
Does this discard the const qualifier from the file pointer?
__file_has_perm() accepts a const struct file pointer, but
backing_file_user_path() expects a mutable pointer. This might trigger a
compiler warning.

[ ... ]

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
Does this evaluate the PROCESS__EXECMEM permission against the mounter's
credentials instead of the executing task?

When mapping a backing file, selinux_mmap_backing_file() and
selinux_file_mprotect() pass the mounter's credentials (file->f_cred) to th=
is
function. Because PROCESS__EXECMEM is a subject-centric privilege that
governs the executing task's memory, evaluating it against the mounter's SID
could incorrectly require the mounter to possess execmem privileges, causing
legitimate executable mappings to fail.

[ ... ]

>  static int selinux_file_mprotect(struct vm_area_struct *vma,
>  				 unsigned long reqprot __always_unused,
>  				 unsigned long prot)
>  {
> +	int rc;
>  	const struct cred *cred =3D current_cred();
>  	u32 sid =3D cred_sid(cred);
> +	const struct file *file =3D vma->vm_file;
> +	bool backing_file;
> +	bool shared =3D vma->vm_flags & VM_SHARED;
> +
> +	/* check if we need to trigger the "backing files are awful" mode */
> +	backing_file =3D file && (file->f_mode & FMODE_BACKING);
> =20
>  	if (default_noexec &&
>  	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> -		int rc =3D 0;
>  		/*
>  		 * We don't use the vma_is_initial_heap() helper as it has
>  		 * a history of problems and is currently broken on systems
> @@ -3864,11 +3955,15 @@ static int selinux_file_mprotect(struct vm_area_s=
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
This is a pre-existing issue, but does this incorrectly use !file to determ=
ine
if a VMA is an anonymous stack mapping?

Using !file as a proxy for an anonymous VMA can be bypassed. If a stack
mapping is backed by a file (e.g., a private mapping of /dev/zero), the !fi=
le
check evaluates to false. This skips the PROCESS__EXECSTACK check and falls
through to the FILE__EXECMOD check, potentially allowing a bypass. Should t=
his
be updated to use vma_is_anonymous(vma) instead?

[ ... ]

> @@ -6960,6 +7071,7 @@ static void selinux_bpf_token_free(struct bpf_token=
 *token)
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
>  	.lbs_cred =3D sizeof(struct task_security_struct),
>  	.lbs_file =3D sizeof(struct file_security_struct),
> +	.lbs_backing_file =3D sizeof(struct backing_file_security_struct),
>  	.lbs_inode =3D sizeof(struct inode_security_struct),
>  	.lbs_ipc =3D sizeof(struct ipc_security_struct),

[Severity: Low]
Does this cause a build failure? It looks like lbs_backing_file (along with
the backing_file_alloc and mmap_backing_file LSM hooks registered below) do=
es
not exist in the core LSM framework at this commit.

[ ... ]

> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index c88cae81ee4c5..dc42282a2c052 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h

[ ... ]

> @@ -159,6 +163,13 @@ static inline struct file_security_struct *selinux_f=
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
> +

[Severity: Low]
Is backing_file_security() defined anywhere? Similar to the LSM hook and bl=
ob
size additions, this appears to be missing from the tree and will likely
prevent compilation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031509.2663=
919-3-caixinchen1@huawei.com?part=3D1
