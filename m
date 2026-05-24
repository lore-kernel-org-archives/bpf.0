Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F4390987
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779623806; cv=none; b=L7AV4LIQwn15vsSxlcsmhGcTbfftV1iiDdZDzDwmQ/OskFDK4GM5TrBPljvX00Uw6nAmqzhEwI2I/wiD8g5/K5wsMJUh0FtdLxBZmOEP5uQg/jeHzcX2bBfLW3OwOSqmHFTVuQDU1rnFkOl65VpoEMoMl0NHv9pBI8ANp6hciiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779623806; c=relaxed/simple;
	bh=CLCMMm00XC969F/EyWfD7hQ/cx2zkr2TIjU8qvLERGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJPHpzSlorTJGIfHNbr4ZLhRy3oGN6x+s87Ef5n8e9p8DX6ZTz2xWeY8TPd8SrP/ViY2Kle+aEqYUmY7gsHVDWvskwdlntuTHxovVriIrGqGaGMegrlTUl2Bx7LcsdIET7VbLLzVkrQj6VDZTmJf24aQvkmQIF5Mvu/ZVnCRR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV8ajD/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV8ajD/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF4C1F000E9;
	Sun, 24 May 2026 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779623805;
	bh=gBcNMTWbUGZ9U4gmMWRMaHPWe37QLuPZyMkkAr9QSi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OV8ajD/U7fKwWUp3r8et31mYi2+uTuzFUE3M/oNAkb4lC3WKXdDSbQWwVoQ7x1bgZ
	 DCpwGor2p+b1LQtmKGrQiVzIksKrB6q/SvEG6KX8cdq4/NhYbcZED8Atnvo/CTFhyd
	 D1QwKs19ufnEk567F3yxSExcORNnkf7+mV7KI1vk0uOk3K/vrGK2A4yRFJJHUo0ZbR
	 pj67sE/gdHHKuYaUWV5sYSFxbTwcAIQ0yqEA2cbSBoJUW+gGHKMR5YAItAM4QtHPoG
	 OyqoUucOBE70x2O9hWDcRo7fRt+tHQFeJwhvYC3ZPdw/UAhOV3Eg5dtWycAIK4u4KG
	 aL5GBm5jPVdsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel-doc for arena page kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dhiraj Shah" <find.dhiraj@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260524114243.259916-1-find.dhiraj@gmail.com>
References: <20260524114243.259916-1-find.dhiraj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 11:56:44 +0000
Message-Id: <20260524115644.EDF4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message incorrectly claims that the BPF arena kfuncs =
have a "sleepable-only context" contract.
- [Low] The newly added kernel-doc comments omit several failure conditions=
 and error returns for the BPF arena kfuncs.

Pre-existing issues:
- [High] `bpf_arena_reserve_pages()` silently returns 0 (success) when pass=
ed a non-page-aligned address, failing to actually reserve the pages.
- [High] `range_tree_clear()` corrupts the range tree and leaks free space =
if memory allocation fails.
--

commit 4e0172dd044fa3635f4bf80032c1bc3a4a5ac292
Author: Dhiraj Shah <find.dhiraj@gmail.com>

bpf: Add kernel-doc for arena page kfuncs

This commit adds kernel-doc comments for BPF arena page-management kfuncs
and renders them under a new subsection in Documentation/bpf/kfuncs.rst.
No functional changes are introduced.

> The page-management kfuncs exposed by BPF arena -
> bpf_arena_alloc_pages(), bpf_arena_free_pages() and
> bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
> rendered documentation. Their contracts (valid argument ranges,
> sleepable-only context, and the set of error returns) are today only

[Severity: Medium]
Is the description "sleepable-only context" accurate here?

The BPF verifier supports calling bpf_arena_alloc_pages() and
bpf_arena_free_pages() in non-sleepable contexts by dynamically replacing
the calls with their non-sleepable variants
(bpf_arena_alloc_pages_non_sleepable and
bpf_arena_free_pages_non_sleepable).

Additionally, the BTF_ID_FLAGS for these kfuncs do not appear to include
the KF_SLEEPABLE flag.

> discoverable by reading kernel/bpf/arena.c.

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef5..948a431591063 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> + * Return:
> + * * The user-space virtual address of the start of the allocated region=
 on
> + *   success. The BPF JIT translates this address for accesses from the =
BPF
> + *   program.
> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is =
zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */
>  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u=
32 page_cnt,

[Severity: Low]
Are there missing failure conditions in this documentation?

It appears bpf_arena_alloc_pages() can also return %NULL if the requested
address is already allocated, or if there is no contiguous free space of
the requested size in the arena.

[ ... ]

> + * Return:
> + * * 0 on success, or when @page_cnt is zero.
> + * * -EINVAL if @p__map is not an arena or the requested range falls out=
side
> + *   the arena's user VMA.
> + * * -EBUSY if any page in the requested range is already allocated, or =
if
> + *   contention on the arena's internal spinlock prevents the operation =
from
> + *   completing.
> + */
>  __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u3=
2 page_cnt)

[Severity: Low]
Does this also need to document -ENOMEM?

If range_tree_clear() fails to allocate a new node during a split operation,
it seems this can return -ENOMEM.

[Severity: High]
This isn't a bug introduced by this patch, but does arena_reserve_pages()
silently fail when passed a non-page-aligned address?

In arena_reserve_pages(), if the user-provided address is not page-aligned:

kernel/bpf/arena.c:arena_reserve_pages() {
    ...
    if (uaddr & ~PAGE_MASK)
        return 0;
    ...
}

Since 0 indicates success for this kfunc, doesn't this mislead the caller
into believing the pages were successfully reserved? No pages are actually
reserved in the arena's range tree, which could allow subsequent
bpf_arena_alloc_pages() calls to allocate that exact memory.

[Severity: High]
This is a pre-existing issue, but does range_tree_clear() corrupt the range
tree and leak free space if memory allocation fails?

When range_tree_clear() clears a range that strictly overlaps the middle of
an existing range node, it splits the node. It removes the original node,
reinserts the left portion, and then calls kmalloc_nolock() to allocate a
new node for the right portion.

If kmalloc_nolock() fails (returning -ENOMEM), the function returns
immediately and the right portion of the original node is never reinserted.
Since this tree tracks free space in the arena, does losing a node
permanently leak that free space and make it unavailable for future
allocations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524114243.2599=
16-1-find.dhiraj@gmail.com?part=3D1
