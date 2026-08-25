Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDB3911A8
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650362; cv=none; b=eBPxEV/JxAyn5vb+cVDDsSTbh4yQXKwGAEYfazfQoxJ0vlH2nzQZRUOcdQGjKm1ED7lg4g6kjRx1hVgkJ0vonQQsGXmOigSjJ44WDZ6IRBLZTZMqnTbN+D70WUuLK+X17Ll4wS5Zv/KKzPhFd64vo+rdxWVVuZ6G4bG0iVsU1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650362; c=relaxed/simple;
	bh=u7Ethh3ktH9k5Qq6Zvm4WuHPDEqywcgsnd1fk5VumIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJhUt0+M875ACSKNlAyUD/u43vBfjOTY4XjEtt8OBZf9ia+lYDEDRmSxefBEFSPLhoCwa0ZZYVwfbg4qrig8y6BJWGBd0QTnGhtbgNQ/my4WT649T31Nu7k7iiMiUXwO4W4MD3QKbZryS+r1V7Lq6H7pW9QyFUMYdKMU1B9Jnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgigNJxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgigNJxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968801F000E9;
	Tue, 25 Aug 2026 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787650360;
	bh=BhHrPBmPXcDD14Jw7sGqGJm63CCufn/gixLCGLJ8n74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CgigNJxoZJ3REpe8TAc48zVPWLiHOYm4OeoK/sB+IcSax8IZwd3XnadDdjSswuLev
	 BQRdieovJQ8GfKdj6KZTwpjUEJ+it/xHCubqqCKLB5mkxh5Tc+jgm+aWxaNwJRE3L1
	 K6/puVAbawnszfOkX72XjQwjgjz59wKL2NInbsAO3aJ0Qib3ks/V71cVRoTcD21qBK
	 dfm++Ompo10+QFaVJIiQVDcWYmtfZhOn2OY9nusQXd34GupIiSRswajaTbi+JubWNj
	 qFVVsjQHV9afYLs3SOEYW1RD+FikUhYd35tIfAlG3truv0YVc0Xn3rnPC+3rG7htCF
	 aPOsubFFlDyqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] bpf: arena: allocate the fault-in page outside
 the lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825091952.81971-3-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
 <20260825091952.81971-3-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:32:40 +0000
Message-Id: <20260825093240.968801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized kernel memory can be mapped to user space via th=
e non-blocking BPF arena page allocator.
--

--- Patch [2]: [PATCH v6 2/4] bpf: arena: allocate the fault-in page outsid=
e the lock ---
commit ff315e328e06f5f1bb6983dd7c2505e416510536
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: arena: allocate the fault-in page outside the lock

This commit reworks arena_vm_fault() to preallocate the fault-in page outsi=
de
the lock, allowing it to sleep and use memory reclaim. It handles failures =
by
returning VM_FAULT_SIGBUS instead of SIGSEGV, and uses a lockless probe to
skip preallocation when possible.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..fa462a0ff1ad6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -489,59 +490,106 @@ static vm_fault_t arena_vm_fault(struct vm_fault *=
vmf)
>  	kbase =3D bpf_arena_get_kern_vm_start(arena);
>  	kaddr =3D kbase + (u32)(vmf->address);
[ ... ]
> +	if (!new_page) {
> +		/*
> +		 * Very rare race: the bpf program had allocated a page here, so
> +		 * the lockless probe saw it and we skipped preallocation, but it
> +		 * freed the page before we took the lock. Now we do need one;
> +		 * sleeping is not allowed here, so fall back to the non-blocking
> +		 * allocator and give up if it fails.
> +		 */
> +		ret =3D bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);

[Severity: Critical]
This is a pre-existing issue, but does this fallback path expose uninitiali=
zed
kernel memory to user space?

When this rare race happens and we call bpf_map_alloc_pages() under the
arena->spinlock, preemption is disabled. The bpf_map_alloc_pages() function
calls __bpf_alloc_page(), which checks can_alloc_pages() (returning false
because preemption/IRQs are disabled).

It then falls back to alloc_pages_nolock():

kernel/bpf/syscall.c:__bpf_alloc_page() {
    ...
    if (!can_alloc_pages())
        return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
    ...
}

The __GFP_ACCOUNT flag completely omits __GFP_ZERO. This causes the raw page
allocator to return an unzeroed page. This page is then mapped into the user
VMA via apply_to_page_range(), which allows user space to read the residual
kernel data.

Since this new fallback path relies on the same non-blocking allocator, it
appears vulnerable to the same issue. Can __GFP_ZERO be added to the
alloc_pages_nolock() call to prevent this?

> +		if (ret) {
> +			fault_ret =3D VM_FAULT_SIGBUS;
> +			goto out_err_locked_memcg;
> +		}
> +	}
> =20
>  	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825091952.8197=
1-1-ahemadkhawar123@gmail.com?part=3D2
