Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE042A9D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645035; cv=none; b=sWjCBwicRucBTCAiugetyyiKJGEgnFi6BphervOgDOd5j0M67ykEMU4BLfdJ9amS1qzrd2PCs9vEvj342qPtfTBxE/IXKEPNqhdgbqUhbF76yx2lRQetMT8337QtqGxqqLnCPz0n0rL/v59mML3e6BKTtNuTAA4TEIReYV6JpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645035; c=relaxed/simple;
	bh=lUnjOhlnqQGqftunmfKEl3mhfDHz4M8mWYfiaVUtrdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q1e5MpxfMfuzVCb2EO3hh42VIFCdUi1675UMXiWngdjLPcc5bREG5NApBB/bAKE9pA6LozDrzKFdbZffIIys4eKjv3Lnrf5d8afuQuc6T8TCMW5dDFCKLw1plOq2ASEwaugqDq3l/tuj9AmLbUDOSJpF9W52abK/oPu0kA9St6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF+bdNHK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF+bdNHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED092C2BCC7;
	Wed, 13 May 2026 04:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778645035;
	bh=lUnjOhlnqQGqftunmfKEl3mhfDHz4M8mWYfiaVUtrdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tF+bdNHKt2orWdppQEwdn8UguzYbc6kNwU/JM6mtyLL0oUrMW5lBa5Gz8qxAvOOBA
	 gEWHVioKlpvFc+pPm0RMcnzIr5pmWiWCavtmq4EpL/oETZEMn+7cVBvQZQaJT5NoXB
	 WbKtvhnGv+5CuAxyTwRiJxpKdMtn3bfjynmQoFkQXmwGeRh9Nha8syk+Wn9OFWnRFx
	 0jbHCWeV1/iJzuAJKU4Q1gSK7w20cnXNsyR/bYIw0xFjWO+X/i4T1hE7Kkn3DJZdlW
	 H1tmmZLUFGJZyIspZd31/fJQ483ieIIQLw8HWbin/4Rc2ze9rPNbf3Euf+peB8gn0v
	 KlTAy/CHOrpzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/3] bpf: Avoid faultable build ID reads under mm
 locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
References: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:03:54 +0000
Message-Id: <20260513040354.ED092C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleepable build ID parsing unconditionally fails on systems where =
CONFIG_PER_VMA_LOCK is disabled.
- [High] Incorrect VMA classification using `!vma->vm_file` violates MM API=
 and risks unsafe driver reads.
- [High] Missing caching causes a severe performance regression due to redu=
ndant file I/O for IPs within the same VMA.
--

commit 8402e095f9b6a82fa06a32af10007e005d6c5e76
Author: Ihor Solodrai <ihor.solodrai@linux.dev>
bpf: Avoid faultable build ID reads under mm locks

This commit updates the stackmap sleepable path to avoid calling
build_id_parse_file() while holding mmap_lock or a per-VMA read lock. It
achieves this by acquiring a stable read-side reference to the backing file,
dropping the VMA lock, and then parsing the build ID.

Link: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linu=
x.dev/
Link: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.or=
g/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea58..c1e96df360c3f 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -158,6 +159,105 @@ static inline void stack_map_build_id_set_ip(struct=
 bpf_stack_build_id *id)
>  	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>  }
> =20
> +struct stack_map_vma_lock {
> +	bool vma_locked;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *
> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{

[ ... ]

> +	vma =3D vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	mmap_read_unlock(mm);
> +	return NULL;
> +#endif

Does this unconditionally fail on systems where CONFIG_PER_VMA_LOCK is
disabled?

Looking at the fallback block, it unlocks the mmap_read_lock and returns
NULL. Will this cause stack_map_get_build_id_offset_sleepable() to always
receive a NULL VMA and fail to extract any build IDs on architectures lacki=
ng
per-VMA lock support?

[ ... ]

> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_bui=
ld_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct stack_map_vma_lock lock =3D {
> +		.vma_locked =3D false,
> +		.vma =3D NULL,
> +		.mm =3D mm,
> +	};
> +	unsigned long vm_pgoff, vm_start;
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 ip;
> +
> +	for (u32 i =3D 0; i < trace_nr; i++) {

I see this is addressed in a later commit in the series ("bpf: Cache build
IDs in sleepable stackmap path"), but is there a risk of a performance
regression here?

The original non-sleepable path cached the previous VMA and build ID. Since
that caching logic is missing here, will adjacent stack frames from the same
binary repeatedly trigger file reference acquisitions and blocking reads for
every single IP?

> +		ip =3D READ_ONCE(id_offs[i].ip);
> +		vma =3D stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {

Is checking vma->vm_file sufficient to determine if the mapping is
file-backed?

Anonymous VMAs, such as private mappings of /dev/zero or driver mappings
calling vma_set_anonymous(), can legitimately have vm_file set.

Could passing these anonymous VMAs to build_id_parse_file() invoke
__kernel_read() on a driver's read handler, leading to unintended side
effects or hangs?

Would it be safer to use !vma_is_anonymous(vma) instead?

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}
> +
> +		file =3D get_file(vma->vm_file);
> +		vm_pgoff =3D vma->vm_pgoff;
> +		vm_start =3D vma->vm_start;
> +		stack_map_unlock_vma(&lock);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			fput(file);
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512032906.2670=
326-1-ihor.solodrai@linux.dev?part=3D2
