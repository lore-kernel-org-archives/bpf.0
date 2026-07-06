Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617573BBFD7
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354149; cv=none; b=bR+lIxGjowSqkXru4gzmwVyAd1bOMIXXpLcuFvlcG4kvbufaZDbGJz/dMBdptScA0s/FJhxQfrSfC5RFBJALw4FX5Jj0wnH+26t/ns7nlVXA75ZiviOMWjszW2ZVr6YWr/6CosG5Qzlkc2lYcjjEu/fAPKCB+2FsZ9e/HaLy3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354149; c=relaxed/simple;
	bh=jE/EoY0WQe5kVQqqHNPZ1i25fNDo1TKnwjpRh7JC+2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFIkKKYkpxxaW8l2wkVCR/9/dynyxXqQhzK2FVXTwrJfit4Iqidg1QKeFD8JSjAits1iqphjdhvPhsjA6rkgoUhSMBkeJG7PX1Q9Bj6P/ps4nRy6sqpjjauX8Xfb+Ut1abMJFIphNyh7hlVzH+nHaOsjgHfBTiZlNiRrFYY47GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW56EowS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW56EowS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC97B1F000E9;
	Mon,  6 Jul 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783354148;
	bh=pl4ILPnpiyntWxkRE5njEiZ0qRvdPy7Z6FjLR/utbrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hW56EowS46LV/IobLdjdkKuJyHFMqqW88/30c02UJcvKRd1WyzpX6ild8BAB4k0AA
	 oDkLYoY08FfSSOVIrYrKEteLPPvfGxbAGvfoaUDdJByIg/NmKj763499kKUKrdnKEo
	 /COwMbCi7tpfgZ7+0JjsTOk82eM7JBxJarAGoNwbLIPFL49Zc+I7/xGS4iYo24QEEi
	 sqioFKVJyU04N6u6wIwKrzgHaB3WyimPmiXRN1tw0cuJNoMC+isCnTX4ld8+IEs+H+
	 nNAUBNql5CC2izOTMlyDynImz69Q1yNSz5cISFkWFrqo/OfKSQMKJNwh6+8nRryIX9
	 KsD+0oxOvnqnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject out-of-range arena free
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706-f01-31-arena-free-bpf-next-v1-1-3ad6e7384285@mails.tsinghua.edu.cn>
References: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
 <20260706-f01-31-arena-free-bpf-next-v1-1-3ad6e7384285@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 16:09:07 +0000
Message-Id: <20260706160907.DC97B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing 32-bit boundary check in `arena_map_mmap` allows kernel PT=
E overwrite and sandbox escape.
--

commit d41218f03bbc51a996de1d468ac821cb61f84615
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Reject out-of-range arena free addresses

This commit adds a check in arena_free_pages() to reject frees where the
computed full address is below arena->user_vm_start. This prevents
out-of-domain page offsets from being inserted into the free range tree.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 80b7b8a694464..97a5d8d212955 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -853,6 +853,8 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>  	uaddr &=3D PAGE_MASK;
>  	kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
>  	full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> +	if (full_uaddr < arena->user_vm_start)
> +		return;

[Severity: High]
This is a pre-existing issue, but looking at arena_map_mmap(), is it possib=
le
for a user to dynamically choose a VMA that crosses a 32-bit boundary?

kernel/bpf/arena.c:arena_map_mmap() {
[ ... ]
	arena->user_vm_start =3D vma->vm_start;
	arena->user_vm_end =3D vma->vm_end;
[ ... ]
}

If a user maps the arena at an address crossing a 32-bit boundary (e.g.,
0x7FFF_FFFF0000 with a size of 4MB) by not specifying map_extra and using
mmap with MAP_FIXED, does this bypass the boundary check?

If so, could this lead to an overflow in arena_alloc_pages() when calculati=
ng
uaddr32?

kernel/bpf/arena.c:arena_alloc_pages() {
[ ... ]
	uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);

	while (remaining) {
[ ... ]
		ret =3D apply_to_page_range(&init_mm,
					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
[ ... ]
}

When uaddr32 overflows, does the calculation kern_vm_start + uaddr32 exceed
the KERN_VM_SZ bounds? Can this overwrite PTEs of adjacent vmalloc areas?

>  	uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SH=
IFT));
>  	if (full_uaddr >=3D uaddr_end)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-f01-31-are=
na-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn?part=3D1
