Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F467319857
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009865; cv=none; b=hYuPizldMX8hBz1/XcQ/4AcyJAAht3Be2QuKfimdqjMQjp8cyqbqreNfd3hb/PqXv5suMXcThAMAMkVg2lvQTY0uuQgubypz3mMYpRA/KCz84jlyN+GJXPXJjqh1DmO2JG/MzKZfWf7LLFdou9a7ew64USSbvbgYHOPeTqR/zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009865; c=relaxed/simple;
	bh=L6t0n9Y18CniHzFig61j6AKjE8zsDNfzVo5Zjes5qTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JbwBPKSaSgRnsBTPscAcanX+6srsC0iU41qPkJefhL7Eoh2hVCu0AKBZE+GqXez67MpVlHlD0/8CfpoDlRR0Ozj2xJh1Nn4TJPVUxMMepyquPfJnbMEtcX58mithAMzvstbo4hd6xCQBQtXPDcITME9DlxnKf/+a4LKgl1tXFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSc6KrSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSc6KrSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC921F000E9;
	Thu, 28 May 2026 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780009864;
	bh=VFP0mY9vs2qfAepgRjNM2DQMHdoOaQvVgUkXmwPsyTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSc6KrSBman4E3Zt9XwFmsWDJL1jAi/kBgk/E4YoP5SRITbqeQHDAVmsuZ9CY7NYd
	 dIczq/CqHl5RMdDwbm6y5UCRZu5p0FDCP0s1JbussJava+BNJcEiMw7MsChwAv4jwX
	 +nfyter39omAhPQJC3fmyDaSTf2waM5B/R4o4uMNiF5PFOaylEXmY2KIXIceY0JN+p
	 +EsRcfilhWHnMMfI/zGI0KbYJCbbcs+xHxm7JTEWWiOyqPkUurQMLuyOuDzt0kbIjv
	 SxO992jnRj02tNDikciIWha0GTy8Unhe4yaYtZdNk7zOh2sycYRX4Ny0XFsfmwktYE
	 IBKcpYcu/K3Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 23:11:03 +0000
Message-Id: <20260528231103.DEC921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] zap_pages() can enter an infinite loop if userspace continuously m=
maps and munmaps the arena, stalling the thread indefinitely.

Pre-existing issues:
- [Critical] zap_pages() can pass an address range to zap_vma_range() that =
exceeds the boundaries of the VMA, causing the kernel to unmap memory belon=
ging to adjacent mappings.
--

commit 5e7dd96eaa4e65e290f989d52d5ebe8450def72a
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Take mmap_lock in zap_pages()

This commit addresses an AB-BA deadlock between arena->lock and mmap_lock
in zap_pages() by dropping arena->lock before acquiring mmap_read_lock().
It introduces a zap_gen counter and a zap_mutex to track processed VMAs and
serialize callers while the lock is dropped.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1727503b25d84..9b2dea229b385 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
>  static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  {

[ ... ]

> +	mutex_lock(&arena->zap_mutex);
> +	mutex_lock(&arena->lock);
> +	my_gen =3D ++arena->zap_gen;
> +	for (;;) {
> +		mm =3D NULL;
> +		list_for_each_entry(vml, &arena->vma_list, head) {
> +			if (vml->zap_gen >=3D my_gen)
> +				continue;
> +			vml->zap_gen =3D my_gen;
> +			if (!mmget_not_zero(vml->vma->vm_mm))
> +				continue;
> +			mm =3D vml->vma->vm_mm;
> +			vm_start =3D vml->vma->vm_start;
> +			break;
> +		}
> +		if (!mm)
> +			break;
> +		mutex_unlock(&arena->lock);

[Severity: High]
Can this loop run indefinitely if userspace continuously mmaps and munmaps
the arena?

Since remember_vma() unconditionally sets vml->zap_gen =3D 0 and adds the n=
ew
VMA to the vma_list, concurrent mmap() and munmap() calls could repeatedly
inject new VMAs with a zap_gen of 0 while the lock is dropped. This might
cause the loop to repeatedly process these new VMAs and stall the thread.

> +
> +		mmap_read_lock(mm);
> +		/*
> +		 * Re-resolve: while we waited the VMA could have been unmapped
> +		 * and a different mapping installed at the same address.
> +		 */
> +		vma =3D find_vma(mm, vm_start);
> +		if (vma && vma->vm_start =3D=3D vm_start &&
> +		    vma->vm_file && vma->vm_file->private_data =3D=3D &arena->map)
> +			zap_vma_range(vma, uaddr, size);

[Severity: Critical]
This is a pre-existing issue, but could this unmap memory belonging to
adjacent mappings if the VMA was partially unmapped?

The uaddr and size variables appear to be bounded by the global
arena->user_vm_start and arena->user_vm_end. If userspace partially unmaps
the arena using munmap(), the vma->vm_start or vma->vm_end shrinks, but the
global arena bounds remain unchanged.=20

Since zap_vma_range() relies on the caller to provide a range fully
contained within the VMA, passing an un-shrunk uaddr and size could exceed
the current bounds of the VMA and inadvertently unmap adjacent userspace
mappings.

> +		mmap_read_unlock(mm);
> +		mmput(mm);
> +
> +		mutex_lock(&arena->lock);
> +	}
> +	mutex_unlock(&arena->lock);
> +	mutex_unlock(&arena->zap_mutex);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528222014.3898=
0-1-alexei.starovoitov@gmail.com?part=3D1
