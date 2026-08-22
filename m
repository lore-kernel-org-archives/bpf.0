Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11372931FF
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359601; cv=none; b=HW2XJmcAu3uA0OWCoMQAmKyEvsIj6EaihVl4nY32UTOMT/ecP4pjWyRAQqtnEd39AMmz3UbyEbLhXJZwUlUngatIvXsQlS8MMFfnT69pT5gfsQVbI6of/84s4fp4MLJOQ22FhxsAkrl/ZpcC+jPgd5vsYlbMYQ5mglBZAlJXWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359601; c=relaxed/simple;
	bh=gqqqgNPOYU5FUxIEWBqn+9h68ys/EXC5fCw4xbivNdQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qa3zfVdHbb7V71kuvKXVScJPIGYogH4uIHF3xSio932mf+24yt+/iIYaJM8JCAPnwXrve7o2Xu3kY4IWYi5zaUiNWLWqegP1udUED9byb73KpCm8ir9aoCf/nUTbaFMD9Z7nrPAFqUH8dAzvNdJBdlpG9cKnI+HjwqUK/KWFGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H96X+5HI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H96X+5HI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D931F000E9;
	Sat, 22 Aug 2026 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359599;
	bh=fZbvoDpWetONHbEIwV4CbUIWZmKRxLLugcDb7slWSBI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H96X+5HIBZnXZVPo4WAMTM1mDLmJ5E7oECAIJCr0n+DNN4K95MRB/Ia0xoxNzQ0tJ
	 SIlgn58Igo+DbCG5C1G5LbvoXWNllHw03XQH3Tj76BKTtBnOpbputy2jceNr/uB+oC
	 bfZYr5Ha/TVcLW7R/Ovu0i2uXveUvVLQh7iFEqbM6QG5aJoSPGElcMbBxVaJBwvVJd
	 Iau6WUfG2IxSO6yIHTBT+vMN37XbaieKyVizh/rgJN/fIzb0TCmzBznBSOKDmVCopk
	 jhYEzJ6YkfJjHHeHz+RmeJlMfEBQve6OtYCVHFXuQ5yWGuTU/pXTMlKaxKUOHnyC8h
	 kbi6O4ilYdPkg==
Content-Type: multipart/mixed; boundary="===============6354114049250902479=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <98b36474ee52fe0f06fe1ddcce0ad3719baa7503b7abd71de4a7d1b440d31a4c@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-12-memxor@gmail.com>
References: <20260821233516.3426127-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument flags with suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:38 +0000 (UTC)

--===============6354114049250902479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..6c34a0d34b3f9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -1044,18 +1044,28 @@ static void arena_free_irq(struct irq_work *iw)
>  	schedule_work(&arena->free_work);
>  }
>
> +static long arena_kaddr_to_uaddr(struct bpf_arena *arena, const void *addr)
> +{
> +	if (!addr)
> +		return 0;
> +
> +	return (long)addr - bpf_arena_get_kern_vm_start(arena);
> +}
> +
>  __bpf_kfunc_start_defs();
>
> -__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
> -					int node_id, u64 flags)
> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__arena__nullable,
> +					u32 page_cnt, int node_id, u64 flags)
>  {
>  	struct bpf_map *map = p__map;
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	long addr;
>
>  	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
>  		return NULL;
>
> -	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
> +	addr = arena_kaddr_to_uaddr(arena, addr__arena__nullable);
> +	return (void *)arena_alloc_pages(arena, addr, page_cnt, node_id, true);
>  }

The commit message states that marking the allocation address with
__arena__nullable preserves allocation-anywhere and freeing the first page
of a 4 GiB arena. Does the nullable annotation actually preserve freeing
the first page?

A 4 GiB-aligned arena is constructible (arena_map_alloc() only requires
map_extra to be page-aligned and not cross a 32-bit boundary, both of which
hold for a 4 GiB-aligned map_extra with vm_range == SZ_4G). For such an
arena, the pointer that bpf_arena_alloc_pages() returns for pgoff 0 is:

    clear_lo32(arena->user_vm_start) + 0 == user_vm_start

whose low 32 bits are zero.

When a program passes that pointer back, the JIT emits for the nullable
argument (arch/x86/net/bpf_jit_comp.c emit_kfunc_arena_args):

    mov edi,edi;
    test edi,edi;
    je +3;
    add rdi,r12

so the truncated value 0 takes the branch and NULL reaches the kfunc.
arena_kaddr_to_uaddr() then returns 0 and arena_alloc_pages() takes the
else branch:

    } else {
        ret = pgoff = range_tree_find(&arena->rt, page_cnt);

which picks an arbitrary free range instead of pgoff 0. The kfunc returns a
valid but different address and the program has no way to tell its
placement request was ignored.

Before this commit the parameter was addr__ign, so it was neither
verifier-checked nor JIT-rebased and the full 64-bit user address reached
the kernel: 'if (uaddr)' was true (uaddr == user_vm_start != 0),
compute_pgoff() returned:

    (u32)(user_vm_start - (u32)user_vm_start) >> PAGE_SHIFT == 0

and the page was allocated exactly where requested.

The commit message claims the conversion preserves allocation-anywhere,
freeing the first page of a 4 GiB arena, and reservation at address zero.
It mentions treating 1ULL << 32 as the same allocation-anywhere request as
NULL after the required 32-bit truncation. However, it does not address
that allocating at the first page of a 4 GiB-aligned arena stops working.

The verifier_arena_large.c hunk in this same patch flips:

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 6ab8730d48782..f6515e0e9b174 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -49,8 +49,10 @@ int big_alloc1(void *ctx)
>
>  	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
>  					1, NUMA_NO_NODE, 0);
> -	if (no_page)
> +	/* Only the low 32 bits contribute, so this is equivalent to NULL. */
> +	if (!no_page)
>  		return 3;
> +	bpf_arena_free_pages(&arena, (void __arena *)no_page, 1);

which also drops the only coverage for an out-of-range allocation address
being refused.

Does distinguishing 'no address preference' from 'address with zero low 32
bits' need an out-of-band encoding (e.g. a flags bit) rather than the
nullable suffix?

> commit a3ff9c5abfeb66a3cd71d6298d7f8a13e7fc8fe3
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>     bpf: Replace arena kfunc argument flags with suffixes
>
>     The arena allocation kfuncs still identify pointer arguments with
>     KF_ARENA_ARG2. These flags cover only the first two parameters and
>     duplicate the __arena suffix mechanism used by other kfuncs.
>
>     Annotate the optional allocation address with __arena__nullable. Mark the
>     free and reserve addresses with __arena so a valid address whose low 32
>     bits are zero is rebased unconditionally instead of becoming NULL.
>
>     The JIT now passes kernel arena addresses to these kfuncs. Translate them
>     back to the lower-32-bit user addresses expected by the existing arena
>     helpers by subtracting kern_vm_start. This preserves allocation-anywhere,
>     freeing the first page of a 4 GiB arena, and reservation at address zero.
>
>     Drop KF_ARENA_ARG1 and KF_ARENA_ARG2 from the kernel interface and remove
>     the flags from the arena kfunc sets. KF_ARENA_RET remains responsible for
>     annotating the allocation return value.
>
>     Keep the affected selftests synchronized with the conversion. Associate
>     an arena before the iterator map-pointer failures so they still reach the
>     intended diagnostics, account for the extra nullable branch in JIT labels,
>     and treat 1ULL << 32 as the same allocation-anywhere request as NULL after
>     the required 32-bit truncation.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for arena kfunc argument handling. Should this
include:

  Fixes: 9a8b57f2bd4d ("bpf: Split arena kfunc and struct_ops JIT capabilities")

The JIT arena rebasing enabled in commit 9a8b57f2bd4d caused the JIT to
pass kernel addresses to arena kfuncs, but the kfuncs still expected 32-bit
user addresses. This led to incorrect address handling, including valid
addresses with zero low 32 bits being treated as NULL.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============6354114049250902479==--
