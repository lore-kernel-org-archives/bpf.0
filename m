Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B4352038;
	Thu, 21 May 2026 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340509; cv=none; b=ILCrRvhZ08OLgAeR7ViZzKz276u4YFqLOk8wN9g0zdotQY45RNto77C6IwK40ss4ADy3IpZD29VcXcWARVmwt8LoB6haP3ZVm5tr7ZmeaC/BP16T0dvx4uF+YfL1ewPEEsww7hQMtmgUAoV7J5N+B7QAemPdZRf0HnDcDrqF58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340509; c=relaxed/simple;
	bh=aLD/PR7PjrViU3D/OpzZULL/Po0oQ4tvv4aCgsu8eKY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tlFE78Thq9SNffoPsmdlsYNLCYISYhTzDRVwk6ucktFLDN/jshKSgL0nzOMDuC127+haRUFn5jiv0rKRrZlHYu+sLjkLfuvq/HPosah3RQZbHYAb3gTHQo4Rm0JdmCmXX39wToDDaASkUExw5EVj1zReJvV4VpCp/aZIWVkwBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F18u/Eav; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F18u/Eav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BF1F000E9;
	Thu, 21 May 2026 05:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779340507;
	bh=zPCHw+uYV+VglazCfJS0++q4rXjO5ThrOkfv2svPtV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F18u/EavS6JPAf0MsjfNlU99Aemi42UsMu/dYZHRxA6dMmhFdhJ+6QT24bZZxwl+Z
	 7xP7dPoiEONt70vpZ1cDOXmsITjsvgln+zndC+KWysbkbPcmXiCYcahrfCa7NhZipC
	 a8WLisDM3tDlnfLdgEkCyEaVMVhG2wgv9bvZ1UgBCH94a2Udi19haeHlQHtHMJ7odI
	 Shj6RgzKZz9eGabHBpEvdAzaPRIVAsqbl1YJz+OncN/FA/mFRnHW0kbxjjbqGrknTQ
	 KSoiT+DVkWOtfwmPsiJLNSuaRk6shz+F+r8T/HZUnbjemL5TTt9dfJmyTACzqdxjDr
	 c3B3KCVrItLgg==
Content-Type: multipart/mixed; boundary="===============2492185008812927827=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23fbb5873bb90ce3201e3cdd2e6b6512ed519a9d4c8cbd950d96eeeca3ff463e@mail.kernel.org>
In-Reply-To: <20260521043553.199781-1-find.dhiraj@gmail.com>
References: <20260521043553.199781-1-find.dhiraj@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kernel-doc for arena page kfuncs
From: bot+bpf-ci@kernel.org
To: find.dhiraj@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 05:15:07 +0000 (UTC)

--===============2492185008812927827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..fe0df1e16453 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..b8ec2953dee6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,33 @@ static void arena_free_irq(struct irq_work *iw)
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
> + * Allocates @page_cnt physically-backed pages and inserts them into the
> + * arena's kernel VMA at the offset corresponding to @addr__ign (or at an
> + * arbitrary free offset when @addr__ign is %NULL). A subsequent user-space
> + * page fault on the matching user address populates the user VMA with the
> + * same pages, giving BPF and user space a shared view of the region.
> + *
> + * The underlying allocator may sleep, so this kfunc is only callable from
> + * sleepable BPF programs.
> + *
> + * Return:
> + * * Kernel pointer to the start of the allocated region on success.

Does the return value description match the implementation? Looking at
arena_alloc_pages() in kernel/bpf/arena.c, the function returns:

    return clear_lo32(arena->user_vm_start) + uaddr32;

which is a user-space virtual address derived from the arena's
user_vm_start. This matches the description for bpf_arena_free_pages()
later in this patch which notes the address is "in user-space form" when
previously returned by bpf_arena_alloc_pages().

Should the documentation state it returns a user-space pointer rather than
"Kernel pointer"?

> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */
>  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
>  					int node_id, u64 flags)
>  {

[ ... ]

> @@ -913,6 +957,26 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
>  	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>  }
>
> +/**
> + * bpf_arena_free_pages() - Free a range of pages within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @ptr__ign: User-space virtual address of the first page to free, as used
> + *	      to address the arena from BPF and user space. Typically the
> + *	      same address that was previously returned (in user-space form)
> + *	      by bpf_arena_alloc_pages().
> + * @page_cnt: Number of pages to free.
> + *
> + * Releases the backing pages, unmapping them from the arena's kernel VMA
> + * and from any user-space VMA that previously faulted them in. May sleep,
> + * so the kfunc is callable only from sleepable BPF programs.
> + *
> + * The call is a no-op when @p__map is not an arena, when @page_cnt is zero,
> + * or when @ptr__ign is %NULL.
> + */
>  __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
>  {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26206146239
--===============2492185008812927827==--
