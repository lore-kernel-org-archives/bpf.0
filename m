Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099D356742
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339421; cv=none; b=JpWV2LmXMnjKFruUQbH5EnJQj0Q8mTdy+9DwUBgY0P47FAffT1lbpHvJ75s+Yewt/w04n10/Qht1mXPLhp7FRvjWyYIXtrJAQ4XYLBZOWLDOZG0mWR8la9+moWlqeJQjDh3QIhXJE+ggaAT6rIUCohEP3isOt2Fc8TcEAFcdHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339421; c=relaxed/simple;
	bh=clZocPYahXOIq+s4V3WQfYa/rc3dgnQQxWB9110dPNE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dZdBh3fckxwoV3DuUxfhP7qFj9xNuxJKtJdaM7StdbuQGb4KpRO7efi++wME6/DzQLaSN4wR7lYVdbCCNBECbYCQ7T4Jy+rVGMfKiFtkDxt4BY+H+fUgJAcK8BvYzBuzDuu3QEkBjuh0MP0G/VORFLHhzAKgKrU86YdBXZ34kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=AG2sjvvN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="AG2sjvvN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82faf871346so4421051b3a.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779339419; x=1779944219; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+wWjZ/53iRyZK/xmDFaek94wEFKccAvhQMtnqakHR4=;
        b=AG2sjvvNTeJtSLCu7luyNGzUgt+HsuFv/eQ6qciJxdK6i894z2PgfipFOizZ0n9HG5
         0fbZjYebe+RrA2FSSpWqlqJYhMYKSx1OvvinHbD5xWc+H3TZTBReC1ghbiasRgRV6Asc
         HGDW8Tn36w9lrHg8UZCvVbRjvLYEGelXuJ22F91ey2QvG/yiKBJDrTZz+u2IMk6Cy0wA
         o+2c7kN1dll2Y9PwKOgvqYFzvAjMje/pO/SaetFWWgvoj1QADqqno0etYxN+tjnrvrTe
         trjYGyGZhOKukCT1ZgbVUMOcW/mDp1AMTKXSljEmm8hTn16QjzFiwQzRcsAsKA92leDK
         G+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779339419; x=1779944219;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+wWjZ/53iRyZK/xmDFaek94wEFKccAvhQMtnqakHR4=;
        b=SbvtARDwrrdhHonUUY0NPjPSTXZsBy0kX6uBi4dtJyVxJ0M14utItLSVAGBKlbL9+e
         EDfD3hnrCn33NAGpf63ZBqsHqoSDLP+NvDxAvOXjYIUboWfbTeJtWv1mFqJHTbunppdW
         G5esZWBALjR9NSAK3KoCuajH6outeHtz/onIAi4iEiGXdOYtZ2W6DU0F7A9np7ERTrVz
         df9jSEv268AR7XxHuzv+aouurhsf3+YpWCAl/KOr8WsX/w32qWXjEVLhybGADspG7vMR
         X8WVfKy4vzWJVzaVQhy+LTFNzVvESX1r5TjzK5NqBwkz5cecfwGiXOCjRW6/BAFlyfZZ
         8gbw==
X-Forwarded-Encrypted: i=1; AFNElJ+CTlkf0TAgoY/hPQl57iTX/2oGBVxpWEmGOUQGrB7LsUZZZ0AKVFMis9v687JijtoLBUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhBQLsWQnJl3RrFW4q5IX3jOoVkmYvqqsgqIOu4aIGFUeoW3e
	s/cJLlPCVlt7UUj03DVpOCAHi6xnp9RHnHJMoj6gOuQo6cA85oo5eeLKKJbuQWW1P1A=
X-Gm-Gg: Acq92OF3kUZnR9StHxS4JZgYAfwNwK72TmM9shQVQZWLYZoMFvTtr+INOka77SmxoRw
	3FMvDV8Jvsd3r384IBJ5QrPzRwrrHc5+iXeCEsvegeX6WxolcBrJbj/Xq+2HBtZq8cmON5EgraI
	2aZbPRRsveSl5EVpBIlfG7u0Jg1LQyQNizSdKA9QgeQye0rNANcACSxCAChnvqwwN42MZ/ozEVr
	rWZ6cSPXiVWq7UwAPLdNpghmiQG5vfDarHJn5dQrsT9LbaDfAltWyKjgX2SLJsGsR+plnRbh8ZE
	sIqhB5VnA3//tzpHCM8Bj+VjtpaTc0v3dwZL8sYzgjGKEf7UK26+H9U1WEnafKGd7vUhp6SQCFi
	rwbDPe2o4qmuDVqmGe/jTZZ0mvBU3hu37Dj/4P5Gga+e0bsaKioIK5PYhi/cR0Bj0NNrOWGNepu
	Af3kHFUqTBmyHRHz/5/X8ppqWtbOmFS11c/y6Az0skse00aw==
X-Received: by 2002:aa7:88d0:0:b0:83e:c8fb:54df with SMTP id d2e1a72fcca58-8414ac7f1f3mr1535453b3a.2.1779339419533;
        Wed, 20 May 2026 21:56:59 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5c020sm22849542b3a.30.2026.05.20.21.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:56:58 -0400
Message-Id: <DIO36K7NMKCI.1M7YER0754VUW@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: Add kernel-doc for arena page kfuncs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dhiraj Shah" <find.dhiraj@gmail.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521043553.199781-1-find.dhiraj@gmail.com>
In-Reply-To: <20260521043553.199781-1-find.dhiraj@gmail.com>

On Thu May 21, 2026 at 12:35 AM EDT, Dhiraj Shah wrote:
> The page-management kfuncs exposed by BPF arena -
> bpf_arena_alloc_pages(), bpf_arena_free_pages() and
> bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
> rendered documentation. Their contracts (valid argument ranges,
> sleepable-only context, and the set of error returns) are today only
> discoverable by reading kernel/bpf/arena.c.
>
> Add a kernel-doc comment block above each of the three kfuncs and
> render them under a new "BPF arena kfuncs" subsection in
> Documentation/bpf/kfuncs.rst, alongside the existing core kfunc
> subsections.
>
> No functional change.
>
> Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 27 +++++++++++++++
>  kernel/bpf/arena.c           | 64 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..fe0df1e16453 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -732,3 +732,30 @@ the verifier. bpf_cgroup_ancestor() can be used as f=
ollows:
>  BPF provides a set of kfuncs that can be used to query, allocate, mutate=
, and
>  destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-=
label`
>  for more details.
> +
> +4.4 BPF arena kfuncs
> +--------------------
> +
> +A BPF arena (``BPF_MAP_TYPE_ARENA``) is a sparsely-populated shared memo=
ry
> +region that a BPF program and a user-space process can both address. The
> +following kfuncs allow a sleepable BPF program to allocate, free, and re=
serve
> +pages within an arena:
> +
> +.. kernel-doc:: kernel/bpf/arena.c
> +   :identifiers: bpf_arena_alloc_pages bpf_arena_free_pages bpf_arena_re=
serve_pages
> +
> +A typical pattern is to allocate one or more pages, write to them from B=
PF,
> +and let user space observe the same memory after a page fault populates =
its
> +VMA:

Maybe slight rephrase? This description is a bit dense. E.g.,

"...and let user space access the pages through a mapping in its address sp=
ace."

> +
> +.. code-block:: c
> +
> +	void __arena *page;
> +
> +	page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	/* ... use the page from BPF; user space sees the same bytes ... */
> +
> +	bpf_arena_free_pages(&arena, page, 1);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..b8ec2953dee6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,33 @@ static void arena_free_irq(struct irq_work *iw)
> =20
>  __bpf_kfunc_start_defs();
> =20
> +/**
> + * bpf_arena_alloc_pages() - Allocate pages within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @addr__ign: Page-aligned user-space address within the arena at which=
 to
> + *	       place the allocation, or %NULL to let the kernel choose. When
> + *	       non-NULL the address must fall inside the arena's user VMA
> + *	       range; otherwise the allocation fails.
> + * @page_cnt: Number of pages to allocate. Must be non-zero and no great=
er
> + *	      than the arena's configured size in pages.
> + * @node_id: NUMA node hint for the backing pages, or %NUMA_NO_NODE.
> + * @flags: Reserved for future use; must be 0.
> + *
> + * Allocates @page_cnt physically-backed pages and inserts them into the
> + * arena's kernel VMA at the offset corresponding to @addr__ign (or at a=
n
> + * arbitrary free offset when @addr__ign is %NULL). A subsequent user-sp=
ace
> + * page fault on the matching user address populates the user VMA with t=
he
> + * same pages, giving BPF and user space a shared view of the region.
> + *
> + * The underlying allocator may sleep, so this kfunc is only callable fr=
om
> + * sleepable BPF programs.

I think this is half the story, since the verifier adjusts the call to
the function to the non-sleepable version when necessary. So the kfunc
is technically only callable from sleepable BPF programs but it never
will be thanks to the verifier.

> + *
> + * Return:
> + * * Kernel pointer to the start of the allocated region on success.
> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is =
zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */
>  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u=
32 page_cnt,
>  					int node_id, u64 flags)
>  {
> @@ -893,6 +920,23 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__m=
ap, void *addr__ign, u32 pag
> =20
>  	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, false);
>  }
> +
> +/**
> + * bpf_arena_free_pages() - Free a range of pages within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @ptr__ign: User-space virtual address of the first page to free, as u=
sed
> + *	      to address the arena from BPF and user space. Typically the
> + *	      same address that was previously returned (in user-space form)
> + *	      by bpf_arena_alloc_pages().
> + * @page_cnt: Number of pages to free.
> + *
> + * Releases the backing pages, unmapping them from the arena's kernel VM=
A
> + * and from any user-space VMA that previously faulted them in. May slee=
p,
> + * so the kfunc is callable only from sleepable BPF programs.

Same here.

> + *
> + * The call is a no-op when @p__map is not an arena, when @page_cnt is z=
ero,
> + * or when @ptr__ign is %NULL.
> + */
>  __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 =
page_cnt)
>  {
>  	struct bpf_map *map =3D p__map;
> @@ -913,6 +957,26 @@ void bpf_arena_free_pages_non_sleepable(void *p__map=
, void *ptr__ign, u32 page_c
>  	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>  }
> =20
> +/**
> + * bpf_arena_reserve_pages() - Reserve a page range within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @ptr__ign: Page-aligned user-space virtual address of the start of th=
e
> + *	      range to reserve.
> + * @page_cnt: Number of pages to reserve. Zero is permitted and is a no-=
op.
> + *
> + * Marks @page_cnt pages starting at @ptr__ign as reserved so that subse=
quent
> + * bpf_arena_alloc_pages() calls will not place allocations in that rang=
e.
> + * No physical pages are allocated by this kfunc; the range is simply
> + * excluded from the arena's free space.
> + *
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
>  {
>  	struct bpf_map *map =3D p__map;

