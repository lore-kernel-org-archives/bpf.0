Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B603D649F;
	Wed, 19 Aug 2026 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123808; cv=none; b=Ofodi+2FCo4OzLgJG+lnUmiSLSWzHD3eZOcJSlsrWWrTXlU/j0bh0d8ipLURIP3QBSaWUNNZtWpnH7KQL/XvZ2I3KX34mSScjEKwshgpTffffv0u6h0JERGtmEsBDXPOMaTj1Z32hy0yk2miG8EJUqBdXKAfKx5VF9iG352BNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123808; c=relaxed/simple;
	bh=LJe6G25CjBShw3ZQTcVh8/gPFLh8zcys6Z/FX3FE0hE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q0jn3VLV3iIAsW/V+yrpOPb+piqbexKdyLGeXpVkvZWOzfdYQNit3rtWkPKlb5rMxgDijJ81dK/nVVcj1ZoCiMl0u6jc20unlMdagI5etufUAFQBDnLmAUguuJezE6y93ZFzUIjvADmpBRqhTa6pJ0YSzgB/7ps0Yv9131AyzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jimDSjAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jimDSjAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364661F00A3A;
	Wed, 19 Aug 2026 07:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123806;
	bh=hELGPib/uH3jPFvdTEiadn+HQnK3QW+avnxHHcXWrcE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jimDSjAvJfZoTLMtIC0ThiUVmvCu8Vs72gsJczOMZPS0siLynXOz1CIRuMRugJXJk
	 xX4XP352evKC8B9jSbOHdjlBpfuIUTGaa3gnxqKU3G35O9L92Mh4jIHbRvW0mrAYPf
	 WHdp4ivAfDbKTJ/aZmyqscdNqtnq2yeixGL0pxhTsEpaFR7gjYgR5blkOwLFX8yEpo
	 lNePHXGhZGwVSu8l932rl9ls+MC1R1ELISDQGOqkhGfhjqSB9JDm+vHKsZUYQVxy/f
	 fAHk3JdLq1U+9OMgiVq6Ux4uCaYkLFiZ1qhbmzxo9eaafqokoYQxyZJao+oXkQaA4u
	 ZA2exkXVQtpJA==
Content-Type: multipart/mixed; boundary="===============5324425049345538991=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e8780b47d3ea4ea88bc54e5f3171e54adfb868a694d857d838ce28319598915@mail.kernel.org>
In-Reply-To: <0a2355a169c0900427b6e3c0d73ca6ae1be56f13.1787120833.git.zhuhui@kylinos.cn>
References: <0a2355a169c0900427b6e3c0d73ca6ae1be56f13.1787120833.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 07:16:46 +0000 (UTC)

--===============5324425049345538991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..b0a0d4c55dc4 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/memcontrol.h>
> +#include <linux/swap.h>
>  #include <linux/bpf.h>
>
>  __bpf_kfunc_start_defs();

[ ... ]

> +/*
> + * Reclaim must not recurse. try_to_free_mem_cgroup_pages() unconditionally
> + * overwrites current->reclaim_state on entry and resets it to NULL on exit.
> + * So invoking it from an in-flight reclaim would clobber the outer reclaim
> + * state and corrupt its accounting.
> + *
> + * The guard is PF_MEMALLOC. Every reclaim entry point marks the current
> + * task with it for the whole reclaim window: try_to_free_mem_cgroup_pages()
> + * and __perform_reclaim() do so via memalloc_noreclaim_save(), and kswapd
> + * keeps it set for its entire lifetime. A hook inside the reclaim path
> + * (shrink_node, shrink_slab, ...) executes in the context of the
> + * reclaiming task, where current->flags already carries the flag. The page
> + * allocator, the memcg charging path and node_reclaim() rely on the same
> + * flag to avoid reclaim recursion.
> + *
> + * In try_to_free_mem_cgroup_pages(), reclaim_state is set slightly before
> + * PF_MEMALLOC, with only a tracepoint in between, which a sleepable BPF
> + * program cannot attach to.
> + * Also, PF_MEMALLOC is set in some non-reclaim contexts (e.g. direct compaction
> + * and vmalloc), where the kfunc conservatively refuses to reclaim as well.
> + */
> +static bool bpf_in_reclaim_context(void)
> +{
> +	return current->flags & PF_MEMALLOC;
> +}
> +
> +/*
> + * Shared implementation of the proactive reclaim kfuncs: performs one
> + * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, and
> + * @swappiness as the anon/file balance override (NULL to follow the
> + * cgroup's own swappiness setting).
> + */
> +static unsigned long
> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_pages,
> +			    int *swappiness)
> +{
> +	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> +					    MEMCG_RECLAIM_MAY_SWAP |
> +					    MEMCG_RECLAIM_PROACTIVE,
> +					    swappiness);
> +}

Does the PF_MEMALLOC-only guard fully close the recursion window?

The comment states "In try_to_free_mem_cgroup_pages(), reclaim_state
is set slightly before PF_MEMALLOC, with only a tracepoint in between,
which a sleepable BPF program cannot attach to."

The restriction on tracepoint attachment is accurate - sleepable BPF
programs cannot attach to non-faultable tracepoints like
mm_vmscan_memcg_reclaim_begin. But the tracepoint dispatcher itself is
attachable:

Looking at mm/vmscan.c:try_to_free_mem_cgroup_pages():

    set_task_reclaim_state(current, &sc.reclaim_state);
    trace_mm_vmscan_memcg_reclaim_begin(sc.gfp_mask, 0, memcg);
    noreclaim_flag = memalloc_noreclaim_save();

The trace_mm_vmscan_memcg_reclaim_begin() macro expands to a call to
__traceiter_mm_vmscan_memcg_reclaim_begin(), which is a plain global
function generated by __DEFINE_TRACE_EXT(). It carries no notrace
attribute, mm/Makefile doesn't remove ftrace flags from vmscan.o, and
it isn't in btf_id_deny, making it fentry-attachable.

can_be_sleepable() in kernel/bpf/verifier.c returns true for
BPF_TRACE_FENTRY, and check_attach_btf_id() applies no further
restriction beyond btf_id_deny. So a sleepable fentry program on
__traceiter_mm_vmscan_memcg_reclaim_begin would be accepted by the
verifier.

Since the kfuncs are registered for BPF_PROG_TYPE_UNSPEC, such a program
can call bpf_proactive_reclaim().

In that window, current->reclaim_state points to the outer reclaim's
state but PF_MEMALLOC is still clear, so bpf_in_reclaim_context()
returns false. The nested try_to_free_mem_cgroup_pages() would then:

  - Trip the WARN_ON_ONCE(rs && task->reclaim_state) in
    set_task_reclaim_state()

  - On exit, execute set_task_reclaim_state(current, NULL), leaving
    current->reclaim_state == NULL for the rest of the outer reclaim

The outer reclaim continues and under MGLRU, shrink_lruvec() calls
lru_gen_shrink_lruvec() which calls set_mm_walk() in mm/vmscan.c:

    struct lru_gen_mm_walk *walk = current->reclaim_state->mm_walk;
    ...
    current->reclaim_state->mm_walk = walk;

evict_folios() has the same pattern. Result: NULL pointer dereference.

On the classic LRU path the outcome would be lost reclaim accounting in
flush_reclaim_state(), plus the WARN_ON_ONCE on the outer exit.

Would testing current->reclaim_state in addition to PF_MEMALLOC close
this window?

> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * the memory.reclaim cgroup file: pages are reclaimed according to the
> + * cgroup's own swappiness setting and swap is allowed. Note that,
> + * unlike memory.reclaim, this does not retry until @size is reached;
> + * callers can invoke it again if needed.
> + *
> + * Return:
> + *   The number of pages actually reclaimed, or 0 if @size is smaller
> + *   than a page or the calling task is already in a reclaim/freeing
> + *   context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size)
> +{
> +	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL);
> +}

The kfunc takes @size in bytes but returns a count in pages
(try_to_free_mem_cgroup_pages() returns nr_reclaimed in pages). Input
and output use different units.

Every other kfunc in this file normalizes to bytes:
bpf_mem_cgroup_usage() returns page_counter_read(&memcg->memory) *
PAGE_SIZE and is documented as "The current memory cgroup size in
bytes"; bpf_mem_cgroup_page_state() documents "The output is in bytes."

A natural BPF loop like:

    usage = bpf_mem_cgroup_usage(memcg);
    while (usage > target)
            usage -= bpf_proactive_reclaim(memcg, usage - target);

would be off by PAGE_SIZE. The kdoc does say "The number of pages
actually reclaimed", but since this is UAPI-visible the unit asymmetry
is worth resolving before it freezes. Would it make sense to return
nr * PAGE_SIZE, or take @nr_pages instead?

> +/**
> + * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
> + *                                    memory cgroup with an explicit
> + *                                    swappiness
> + * @memcg:      the target memory cgroup to reclaim from
> + * @size:       the amount of memory to reclaim, in bytes
> + * @swappiness: swappiness override for this reclaim pass
> + *
> + * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
> + * balance is controlled by @swappiness instead of the cgroup's
> + * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS]
> + * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
> + *
> + * Return:
> + *   The number of pages actually reclaimed, or 0 if @size is smaller
> + *   than a page, @swappiness is out of range, or the calling task is
> + *   already in a reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long
> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long size,
> +				 int swappiness)
> +{
> +	if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_ONLY)
> +		return 0;
> +
> +	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
> +					   &swappiness);
> +}

An out-of-range @swappiness returns 0, the same value as a successful
call that reclaimed nothing, and the same as a call refused due to
PF_MEMALLOC context. A BPF program cannot distinguish a programming
error from legitimate lack of progress.

The sibling kfuncs in this file use a distinguishable sentinel for
invalid parameters:

    bpf_mem_cgroup_vm_events():   if (unlikely(!memcg_vm_event_item_valid(event)))
                                      return (unsigned long)-1;

    bpf_mem_cgroup_page_state():  if (unlikely(!memcg_stat_item_valid(idx)))
                                      return (unsigned long)-1;

The userspace equivalent also rejects rather than ignores:
user_proactive_reclaim() returns -EINVAL for out-of-range swappiness in
mm/vmscan.c. Would returning (unsigned long)-1 here match both this
file's convention and the write(2) behaviour of memory.reclaim?

> +__bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -172,6 +270,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
> +
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>
>  static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32224943030
--===============5324425049345538991==--
