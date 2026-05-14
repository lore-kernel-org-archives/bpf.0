Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFD34752A
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794264; cv=none; b=tkE5YdCxmOavL2BBpNoGFQiaejYD1LFBlUJBvWk0LB/L69ck5eJZq6hA49c0HcwSJfPh1iatY43ePgQQNTebCuMi0/R8P0yUX1ZC6P+ZKSe3pi0haV7Opcb449P406XkbImOZ5j0XNMzcuQ+RSDwsFgVJpzehl41n3PXCdErTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794264; c=relaxed/simple;
	bh=BGJOcV12Yojt7+Gh85TUMr76DZIq1PH8pLKGzwMYzbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0bwMvzRUPusdX+5PQoN/xTPm4tOm3H9UIZ7rCPE30TTkifV+hPqlfRwhKWBPaMdsb285BPjGO+aNb7vGZqBmdeFrB3pjYm7pEDAJBVwYfgps86R0e3n5zRdqi/lZ38lgmA8zozH182DWpiGdNQ5dgt+m5MR9iSWqK8rE1apy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJvosg9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJvosg9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF769C2BCB3;
	Thu, 14 May 2026 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794264;
	bh=BGJOcV12Yojt7+Gh85TUMr76DZIq1PH8pLKGzwMYzbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GJvosg9D7U9u2KO/i2lAQDjJowsB4j/7vU6rY9wd/6E5l+E3XgMbb9/yrx4tPXs8I
	 bh1t0vigw3DNtvPb68nWkWwrQQXcKPi1f9PtdYe9Yzy0oQAKdgmVRIC/Fcga5JH8o8
	 cCHHbJuCX4Xkupir4cGL3XfQenBm+iFa6M9LmKp1rXNcnCNycsPKm5AV3KOivQ4+ZU
	 uNR26PIqhr4Ge6lqYwPmksZ/3qqurLVg+i10HSGPwPJ+ZiGWs+vIzoIlCtHXL64kPr
	 dcc9sttldtTqYYjp3eEKkhk6ImcbXV9SYKV3h6zrgbvrLul2LmWgD7gNPMMXYPPb0g
	 E+S9mrEaVMq7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
References: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:31:02 +0000
Message-Id: <20260514213103.EF769C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleepable build ID parsing unconditionally fails on platforms with=
out CONFIG_PER_VMA_LOCK.
- [High] Incorrect file-backed VMA classification using !vma->vm_file inste=
ad of vma_is_anonymous(vma).
- [Medium] Severe I/O performance regression due to removal of VMA and buil=
d ID caching.
--

commit 5e68cb2c06b22387698d796c574ee7addecfea18
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Avoid faultable build ID reads under mm locks

This commit introduces a sleepable path for build ID parsing to avoid
blocking in __kernel_read() while holding mmap_lock or a per-VMA read lock.

Link: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linu=
x.dev/
Link: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.or=
g/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea58..c1e96df360c3f 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

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

Does this unconditionally fail on platforms without CONFIG_PER_VMA_LOCK? If
the fallback logic acquires the mmap_read_trylock() and successfully locates
the VMA, it looks like it will drop the lock and return NULL in the #else
block.

Could the locking abstraction be extended to hold the mmap_read_lock across
the get_file() call when per-VMA locks are unavailable?

> +vma_locked:
> +	lock->vma_locked =3D true;
> +	lock->vma =3D vma;
> +	return vma;
> +}

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
> +		ip =3D READ_ONCE(id_offs[i].ip);
> +		vma =3D stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {

Can anonymous VMAs (like private mappings of /dev/zero) have a valid vm_file
pointer? If so, using !vma->vm_file as a proxy for file-backed
classification might dispatch pseudo-files to build_id_parse_file().

Would using !vma_is_anonymous(vma) be more robust here?

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
> +		fput(file);

Does this cause an I/O performance drop by removing the VMA and build ID
caching that exists in the non-sleepable path? Without caching prev_vma and
prev_build_id, this loop appears to perform get_file(), build_id_parse_file=
()
(which reads from the filesystem), and fput() for every single frame in the
stack trace.

I note that this caching is added back later in the series in commit
38cfe2cebe4d604860680459fcb33a68258f0654 ("bpf: Cache build IDs in
sleepable stackmap path"). Should this patch include the caching to avoid
introducing a temporary regression if bisecting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514184727.1067=
141-1-ihor.solodrai@linux.dev?part=3D2
