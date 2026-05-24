Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4E126BF7;
	Sun, 24 May 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779625386; cv=none; b=fxKfYHtfHnkfNQ5Tal+99sKd3vbMvBTkacWdh/2YoAeLiX52ifR+8ASKcI4gdv8picy/vJ4zJ9mzq645fAnj5N7qmTXdjxrg+k0H5OlrksCnO22mEXIBbUE8Xoq5fCCytc0V/kga9wOqutXT10if02g8QJ0dGCkTBYpYtoBq8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779625386; c=relaxed/simple;
	bh=QUVCPf2q2cWrRc96veEM2vYj0iLPBZpk0+f/qtJE6u8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e/q1b1IQLM49m4jOaNPE7PLdZFJzGdUBnMtA1Y2NQYcEsMC0cbj7wa89MtDiTF5MmDAV8ZAcd3rmr3Jnrl0c6Ec6vvFLar0DHrOG+uhmyZu0ES5qA9jdmasB07OD6fNgXVsW8/IA+p1gwBtdPWb1dAMHjoD9NlbFs4BHzK6wMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPnaLy1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPnaLy1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E5A1F000E9;
	Sun, 24 May 2026 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779625385;
	bh=gx/zHL+zQGX1U1zL7cCY4B8oehpkgV/+a8Y6IQr6t9E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LPnaLy1cs3dFl4TZ8j3xxaGzjorWGiGAYczqK0WIhuljgk1pqBLp6CYms6jjCO2mI
	 b3YL2FjJ/EN4kLSFABbl8amMN19Ii3Jmxb6RHpCVPfeZ0f7n9Qfaq5Y1dylNToPjS7
	 efqoOc8gLQsEJFdpVpVzvuGwkAywStR+hO3XR71uaSk5zgDCaUQZEw0N0Z6U2QXI6a
	 hzUPujagJZoKT41ZS5p2HQwAhcKCjhbp6NYcjoh9LDpUvEFtLWejOH3W/Pp7QOISs4
	 wftmcmVwFRlINXz64hpFtPFjd5W2rvvfmg0OoORU4+gyx6PW7AGe6de8lppnIYqke2
	 p9LNYbgFXwBUg==
Content-Type: multipart/mixed; boundary="===============7443696486554360034=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0b9a09127618cb4e3dd1aae92ef25aab9beb90bd533490ec5be7789420d9ef4@mail.kernel.org>
In-Reply-To: <20260524114243.259916-1-find.dhiraj@gmail.com>
References: <20260524114243.259916-1-find.dhiraj@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel-doc for arena page kfuncs
From: bot+bpf-ci@kernel.org
To: find.dhiraj@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,alexei.starovoitov@gmail.com,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org,emil@etsalapatis.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 24 May 2026 12:23:04 +0000 (UTC)

--===============7443696486554360034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The page-management kfuncs exposed by BPF arena -
> bpf_arena_alloc_pages(), bpf_arena_free_pages() and
> bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
> rendered documentation. Their contracts (valid argument ranges,
> sleepable-only context, and the set of error returns) are today only
> discoverable by reading kernel/bpf/arena.c.

Is the description 'sleepable-only context' accurate here? The BPF
verifier supports calling bpf_arena_alloc_pages() and bpf_arena_free_pages()
in non-sleepable contexts by dynamically replacing the calls with their
non-sleepable variants. Looking at the BTF_ID_FLAGS definitions, they do not
include KF_SLEEPABLE. While the code documentation was fixed in v2 to reflect
this, the commit message text was not updated.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..948a43159106 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,31 @@ static void arena_free_irq(struct irq_work *iw)
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * bpf_arena_alloc_pages() - Allocate pages within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @addr__ign: Page-aligned user-space address within the arena at which to
> + *	       place the allocation, or %NULL to let the kernel choose. When
> + *	       non-NULL the address must fall inside the arena's user VMA
> + *	       range; otherwise the allocation fails.
> + * @page_cnt: Number of pages to allocate. Must be non-zero and no greater
> + *	      than the arena's configured size in pages.
> + * @node_id: NUMA node hint for the backing pages, or %NUMA_NO_NODE.
> + * @flags: Reserved for future use; must be 0.
> + *
> + * Allocates @page_cnt pages and inserts them into the arena at the offset
> + * corresponding to @addr__ign (or at an arbitrary free offset when
> + * @addr__ign is %NULL). The pages become accessible to the BPF program
> + * immediately and to user space through the arena's mmap()ed region.
> + *
> + * Return:
> + * * The user-space virtual address of the start of the allocated region on
> + *   success. The BPF JIT translates this address for accesses from the BPF
> + *   program.
> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */

Are there missing failure conditions in this documentation? It appears
bpf_arena_alloc_pages() can also return NULL if the requested address is
already allocated, or if there is no contiguous free space of the requested
size in the arena.

[ ... ]

> @@ -913,6 +952,26 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
>  	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>  }
>
> +/**
> + * bpf_arena_reserve_pages() - Reserve a page range within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @ptr__ign: Page-aligned user-space virtual address of the start of the
> + *	      range to reserve.
> + * @page_cnt: Number of pages to reserve. Zero is permitted and is a no-op.
> + *
> + * Marks @page_cnt pages starting at @ptr__ign as reserved so that subsequent
> + * bpf_arena_alloc_pages() calls will not place allocations in that range.
> + * No physical pages are allocated by this kfunc; the range is simply
> + * excluded from the arena's free space.
> + *
> + * Return:
> + * * 0 on success, or when @page_cnt is zero.
> + * * -EINVAL if @p__map is not an arena or the requested range falls outside
> + *   the arena's user VMA.
> + * * -EBUSY if any page in the requested range is already allocated, or if
> + *   contention on the arena's internal spinlock prevents the operation from
> + *   completing.
> + */

Does this documentation correctly describe the error returns? Looking at
arena_reserve_pages() in kernel/bpf/arena.c, there's a mismatch between the
documented -EINVAL return for misaligned addresses and the actual
implementation:

arena_reserve_pages() {
    ...
    if (uaddr & ~PAGE_MASK)
        return 0;
    ...
}

The documentation implies that misalignment should return -EINVAL (as it's
a validation error), but the code silently succeeds with return 0.

For consistency, bpf_arena_alloc_pages() has the same behavior (returns
NULL for misalignment) and its documentation correctly states it returns
NULL for misaligned addresses. Should either the code be changed to return
-EINVAL for misalignment to match the new documentation, or should the
documentation be updated to state that misaligned addresses result in
returning 0 (no-op)?

Also, does this need to document -ENOMEM? If range_tree_clear() fails to
allocate a new node during a split operation, it seems this can return
-ENOMEM.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26360590766
--===============7443696486554360034==--
