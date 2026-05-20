Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CD352030
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293647; cv=none; b=kdXL9ZH0GPNJiPcddZsa3El1DqzE0aLenIkI0eh8SrKgYPfl0vxC2eC6nGVlNOwmt3CnbNPvOkMkOOUbmvOcJPZM2Iw6ps2B+F8LbyrcKZ11tHj+l81WTdG5OEXIG+7U3vI/90mkKrayQwFtlVqer2y/CHuwe3rjHH0IEy9TOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293647; c=relaxed/simple;
	bh=6kqY/ur0x5TLIzlJKS4aF/SghHIcgjEIR08zZRKPkzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eydDKZInlvmH5XuPM1oQZBJRwMsbWVfm/Z+286w0vykOU33XPG6KWLyaINGKZONsqrY4rPQW0+52C4X76GkT/9I9/I25GO6wrinBhOENFnEBQosR+caa9esejUQdapV6V/SUHrnVRoTGDOo/pY4XaKiRZ7acbj6T1I9fyvzfzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHXWTWJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHXWTWJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1C31F00893;
	Wed, 20 May 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293645;
	bh=69pOzZY69NWvcEgAut7EKnhQVYs88Wuhw+/AiTNaRGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHXWTWJ/reE1JsKDL81apW8dPM64hS+in6FW6hF/oEjeu4zPkkEbmKCQCib0Vpb3W
	 2DzxXsKR4MzSkgFqbqvldQcQKpRo6hRbU3I0qpjhT7vlDa4MBOM39cR9NvGZQMla5b
	 cWuyk8FYHgE+kXB7ptgBT9jZfWXptYPgyia8pchT3fwajTlplhCeEBYQ9iLpVxk5Hv
	 du53HXfW/0B5ajqlJEZI+TKSgpIm3lzTcNg+XfUXdE4XUVnU+WGyPVpNDAdBxHsCej
	 wbUzcW9mwHNRkBaCjVUgkTJhJB9ZMSne3in8FnI4LHjFmx2qVb/UqBo8p/v1C5FS3u
	 RxeNLSA6UEweA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/20] unwind_user/sframe: Show file name in debug
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-12-jremus@linux.ibm.com>
References: <20260520154004.3845823-12-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:14:05 +0000
Message-Id: <20260520161405.AE1C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Incorrect use of `vma->vm_file` instead of `!vma_is_anonymous(vma)`=
 to classify a VMA as file-backed.

Pre-existing issues:
- [Critical] Calling `sframe_remove_section` from `sframe_find` acquires a =
spinlock in NMI context, leading to deadlocks, and triggers a user-controll=
able WARN.
--

commit 60b05617f9a9c00f287a96dda25f8e4086c6178b
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Show file name in debug output

This commit prefixes debug output strings with the file name to make sframe
debugging easier. It looks up the VMA corresponding to the sframe section
and extracts the filename based on the VMA properties.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -374,14 +374,17 @@ int sframe_find(unsigned long ip, struct unwind_use=
r_frame *frame)
>  	user_read_access_end();
> =20
>  end:
> -	if (ret && ret !=3D -ENOENT)
> +	if (ret && ret !=3D -ENOENT) {
> +		dbg_sec("removing bad .sframe section\n");
>  		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
> +	}

[Severity: Critical]
This is a pre-existing issue, but can this lead to deadlocks in NMI context?

sframe_find() is invoked for user stack unwinding from contexts like perf,
which executes from NMI or hardirq contexts. sframe_remove_section() calls
mtree_erase(), which acquires the maple tree's non-IRQ-safe mtree_lock.

Acquiring a regular spinlock in NMI context can cause a hard CPU deadlock
if the lock was already held by the interrupted thread.

Also, could an unprivileged user trivially trigger this WARN_ON_ONCE by
unmapping the section, potentially crashing the system if panic_on_warn
is enabled?

[ ... ]
> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> --- a/kernel/unwind/sframe_debug.h
> +++ b/kernel/unwind/sframe_debug.h
[ ... ]
> +static inline void dbg_init(struct sframe_section *sec)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct vm_area_struct *vma;
> +
> +	guard(mmap_read_lock)(mm);
> +	vma =3D vma_lookup(mm, sec->sframe_start);
> +	if (!vma)
> +		sec->filename =3D kstrdup("(vma gone???)", GFP_KERNEL_ACCOUNT);
> +	else if (vma->vm_file)
> +		sec->filename =3D kstrdup_quotable_file(vma->vm_file, GFP_KERNEL_ACCOU=
NT);

[Severity: Low]
Does this code accurately classify file-backed VMAs?

Anonymous mappings, such as private mappings of /dev/zero, can also have
vm_file populated. Relying only on vm_file might misclassify these mappings
for the debug output.

Would it be more reliable to use !vma_is_anonymous(vma) to check if the
VMA is file-backed before accessing vm_file?

> +	else if (vma->vm_ops && vma->vm_ops->name)
> +		sec->filename =3D kstrdup(vma->vm_ops->name(vma), GFP_KERNEL_ACCOUNT);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D11
