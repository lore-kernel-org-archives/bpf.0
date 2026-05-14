Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD03388378
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757697; cv=none; b=D8K6VxD+jKJ7cSnM3iRXW1kO/1li1ddYzAFnfKVFFk89ETxsAUvadmwguJJJPVRUm84VsSAOQ/gmW9JoTbgeSj0+TV2/yD7ENc/0v2S4nVGl9q6JBW3bgXlH0nU4plqjQtLAqCab8C7aFohNz/314O3d3JGHC71xZUtiwwwUgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757697; c=relaxed/simple;
	bh=BXQpEdto4eUZwUCPfJkV6N+Amxhik1yX1IAh2jS9bwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuY06LZk4gy0IEf1JtgQmX4FJ/951iZGuS5hoIxKroiVc6IpJo4SuSdwvhuP1+t11fBCywAdyZvvvLEwJIpMI8Zx47fEI5Vbh8K+Chq2POTVCndP59GV+h9++mEYaoRSGQdH1yf0YVrSUyr8KUmQ9Q5sKlpyKecTgK/UMJgIueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxUddwfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxUddwfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBAEC2BCB3;
	Thu, 14 May 2026 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778757697;
	bh=BXQpEdto4eUZwUCPfJkV6N+Amxhik1yX1IAh2jS9bwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SxUddwfhftUK342PSWqFZUXqcqPkNpfZO2D51Jj492QAiebhQVFmWwqJ7ErCbtV4X
	 przfyciJKzvp8mzVlNXy1bUNGESq/MErijOfDtuVM+o/G5kNTL5pg45ilOGtRrZFKE
	 o1mSRDqYpRGeZ/mkjoep3ATfjGiZnKxOcs+3CyRPORIinJDrkCrUJfFMQjrAWAC6KA
	 Q5aVjw5uChc19j+4D3d65tEZNrnJJ9dS936Ii30/T37iA3OLypcwmsQrK6cxzeH+Jg
	 PV314FJfj4gCgdFu9Dk9HNVtj56p9yEoZksb/pkqgbGj2ySUsuRD+tc2aHKD8PvO/D
	 BzJtvG+0/9hcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: arena: fix use-after-free in VMA tracking on
 fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Hodges" <git@danielhodges.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513191322.21319-1-git@danielhodges.dev>
References: <20260513191322.21319-1-git@danielhodges.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:21:36 +0000
Message-Id: <20260514112137.2CBAEC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] zap_pages() accesses user page tables locklessly, causing page=
 table Use-After-Free during concurrent VMA teardown.
- [High] Silent allocation failure in arena_vm_open() leads to memory leak =
and physical page desynchronization.
--

commit 305653246e6ae24222d49bb8aa21f98a5bc22903
Author: Daniel Hodges <git@danielhodges.dev>
bpf: arena: fix use-after-free in VMA tracking on fork

This commit addresses a use-after-free by giving each vma its own vma_list
entry in arena_vm_open, rather than sharing a refcounted entry. It also
ensures arena_vm_close removes and frees the respective entry.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -336,9 +334,19 @@ static int remember_vma(struct bpf_arena *arena, str=
uct vm_area_struct *vma)
> =20
>  static void arena_vm_open(struct vm_area_struct *vma)
>  {
> -	struct vma_list *vml =3D vma->vm_private_data;
> +	struct bpf_map *map =3D vma->vm_file->private_data;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	struct vma_list *vml;
> =20
> -	refcount_inc(&vml->mmap_count);
> +	vml =3D kmalloc_obj(*vml);
> +	if (!vml) {
> +		vma->vm_private_data =3D NULL;
> +		return;
> +	}

Because vm_ops->open has a void return type, returning early here does not
abort the vma creation. The child vma will successfully map the arena memory
but remain omitted from arena->vma_list.

Later, when bpf_arena_free_pages() calls zap_pages(), it iterates only over
arena->vma_list. Does this omission cause the child process to retain valid
user-space ptes pointing to the old physical pages?

If so, this could prevent the physical pages from returning to the buddy
allocator, leaking the memory. It may also break shared memory coherency if
new physical pages are reallocated at the same virtual offset while the
child still accesses the old pages.

> +	vml->vma =3D vma;
> +	vma->vm_private_data =3D vml;
> +	guard(mutex)(&arena->lock);
> +	list_add(&vml->head, &arena->vma_list);
>  }

This is an existing issue not introduced by this patch, but zap_pages()
iterates over arena->vma_list and calls zap_vma_range() holding only
arena->lock.

The memory management subsystem requires mmap_lock or the per-vma lock to
be held for vma->vm_mm when traversing a vma's page tables. Concurrently,
processes may exit or unmap the arena. In the teardown sequence,
free_pgtables() unlinks and frees the pud, pmd, and pte pages before
remove_vma() invokes vma->vm_ops->close.

Could zap_pages() execute during this teardown window and attempt to walk
page tables that have already been freed, leading to a use-after-free on
the page directory and table pages themselves?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513191322.2131=
9-1-git@danielhodges.dev?part=3D1
