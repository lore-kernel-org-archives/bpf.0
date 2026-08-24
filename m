Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32483F4116
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564575; cv=none; b=TYO9dq2VrjsfXWLbESSQrH+Zvo7lj9uMqAVnUDlylGxVEJ4FLJBhPDxZZ0KCZP39y871C9xJ/iK9qjhZr8ymqnKUEnmPDHKdNVbHpSyrH9AeLoGEC35dXOMC9qeCXaExW4MuYT9uyUlrGepyg53rfmjw9t+8t8zviLp/eFa3wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564575; c=relaxed/simple;
	bh=ijRgKlS8W7CfCP/dSceUMOGkqQycnVDAGEu9/t3gSPc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VQNAPnG5KiR7JDp3IGhpnH/07yFA2wxGf1y3g9yduTxsBBGEAO5oGnc68bk/WW1bmCx8Yo09EarSsxtqMBoBVT9cX177CbT+AJImQjwQZBU/dYb8J+X6zAnZLQV8dAFpOQOm4PhG74zULo1Ec9gIe8zv+H8dy7ywaX6OxUN1TN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxw3co/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxw3co/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C642F1F000E9;
	Mon, 24 Aug 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787564572;
	bh=yfyl0DM/6yFBAmzW2O79GbuNg+TWTlsALOuJj6SJ5WQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cxw3co/UcCiSUNHlfUUZuN0QAHviUVCa+3CEDUQs8vqHS16KqAgNUhagYn1dBl92z
	 zGZ39UJ2x7UUIEgywWZgFM5k93zbGK6usO7qTZr70TH552zVRAELRYSXyd6ykAJeRs
	 rUh6FYWNIeVksZom42E78IkU56mgYppBCFPRHf0jrj6pwAh4EadT5Oy0o/NU91+Jy8
	 4X3D7a8xyfWdqhN15dV/5ZbgA/jksVp3z6pe3xL/XLImIV735vWzg21qFhQ9tqSTmr
	 /4IhC97eqmUNe9bCHAQS8DQ4O+bPsJADz1c+Iax75azg/62Q3bZe7CGtV2xXHgH2tZ
	 86QaEb+AvhEqA==
Content-Type: multipart/mixed; boundary="===============4624490049248520616=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a507954693fb4a93adff4bde6a5869998de8f2a1c1a316758ee7b7eb0746246@mail.kernel.org>
In-Reply-To: <20260824082530.47553-3-emil@etsalapatis.com>
References: <20260824082530.47553-3-emil@etsalapatis.com>
Subject: Re: [PATCH 2/3] bpf: Add sleepable arena page allocation path
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 09:42:51 +0000 (UTC)

--===============4624490049248520616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b3cd28d9e3b5..fcb21c29aef2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -710,6 +710,12 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
>  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>  				   struct bpf_dynptr *ptr__uninit);
>
> +static inline bool is_bpf_alloc_nonsleepable(void)
> +{
> +	return preempt_count() > 0 || irqs_disabled() ||
> +		IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +
>  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
>  					  u64 flags);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index da356989786a..126ddae763f9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -683,8 +683,73 @@ static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt,
>  	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
>  }
>
> -static long arena_alloc_pages_internal(struct bpf_arena *arena, long page_cnt,
> -		long uaddr, long pgoff, int node_id, bool sleepable)
> +static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long page_cnt,
> +		long uaddr, long pgoff, int node_id)
> +{
> +	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
> +	struct apply_range_data data;
> +	struct page **pages = NULL;
> +	unsigned long flags;
> +	u32 uaddr32;
> +	int ret, i;
> +
> +	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
> +	if (!pages)
> +		return 0;
> +
> +	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
> +	if (ret) {
> +		kvfree(pages);
> +		return 0;
> +	}
> +
> +	data.i = 0;
> +	data.pages = pages;
> +	data.arena = arena;
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +		goto out_free_pages;
> +
> +	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		goto out_free_pages;
> +	}
> +
> +	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> +
> +	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> +			page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
> +
> +	if (ret)
> +		goto out_unmap;
> +
> +	flush_vmap_cache(kern_vm_start + uaddr32, page_cnt << PAGE_SHIFT);
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +	kvfree(pages);
> +
> +	return clear_lo32(arena->user_vm_start) + uaddr32;
> +
> +out_unmap:
> +	/* data.i pages were mapped, undo only those who failed to map */
> +	flush_vmap_cache(kern_vm_start + uaddr32, data.i << PAGE_SHIFT);
> +	range_tree_set(&arena->rt, pgoff + data.i, page_cnt - data.i);
> +
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +	arena_free_pages(arena, uaddr32, data.i, true);

This isn't a bug, but does the comment describe the right thing?

The comment says "undo only those who failed to map", but the code below
unmaps the pages that succeeded:

  arena_free_pages(arena, uaddr32, data.i, true);

This unmaps exactly data.i pages starting at uaddr32, which are the ones
that apply_range_set_cb() installed (data.i is incremented once per
successful PTE). The pages that failed to map get freed in the
out_free_pages loop below:

  for (i = data.i; i < page_cnt; i++)
          __free_page(pages[i]);

Should the comment say something like "data.i pages were mapped, undo
those" instead?

> +
> +out_free_pages:
> +	for (i = data.i; i < page_cnt; i++)
> +		__free_page(pages[i]);
> +
> +	kvfree(pages);
> +	return 0;
> +}
> +
> +static long arena_alloc_pages_non_sleepable(struct bpf_arena *arena, long page_cnt,
> +		long uaddr, long pgoff, int node_id)
>  {
>  	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
>  	struct apply_range_data data;

[ ... ]

> @@ -802,7 +867,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>
> -	addr = arena_alloc_pages_internal(arena, page_cnt, uaddr, pgoff, node_id, sleepable);
> +	if (sleepable && !is_bpf_alloc_nonsleepable())
> +		addr = arena_alloc_pages_sleepable(arena, page_cnt, uaddr, pgoff, node_id);
> +	else
> +		addr = arena_alloc_pages_non_sleepable(arena, page_cnt, uaddr, pgoff, node_id);

Can this dispatch block while in an RCU read-side critical section?

The sleepable parameter is hardcoded to true by the kfunc entry point
in kernel/bpf/arena.c:

  void *bpf_arena_alloc_pages(struct bpf_map *map, void *addr__ign,
                              u32 page_cnt, int node_id) {
    return (void *)arena_alloc_pages(arena, (long)addr__ign,
                                     page_cnt, node_id, true);
  }

and that kfunc is registered without KF_SLEEPABLE:

  BTF_ID_FLAGS(func, bpf_arena_alloc_pages,
               KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)

The verifier checks in kernel/bpf/verifier.c specifically prevent
non-sleepable programs from calling sleepable kfuncs:

  sleepable = bpf_is_kfunc_sleepable(&meta);
  if (sleepable && !in_sleepable(env)) {
          verbose(env, "program must be sleepable to call sleepable "
                  "kfunc %s\n", func_name);
          return -EACCES;
  }

but that check never triggers because bpf_arena_alloc_pages() is not
tagged KF_SLEEPABLE. So non-sleepable programs can call it.

is_bpf_alloc_nonsleepable() checks for:

  preempt_count() > 0 || irqs_disabled() || IS_ENABLED(CONFIG_PREEMPT_RT)

That detects hardirq/softirq/NMI/preempt-disabled/IRQ-disabled/RT
contexts, but it does not detect the RCU read-side critical section
that every non-sleepable BPF program runs inside.

Non-sleepable trampoline programs (fentry/fexit/fmod_ret/raw_tp/
struct_ops) enter via __bpf_prog_enter() in kernel/bpf/trampoline.c,
which calls rcu_read_lock_dont_migrate():

  rcu_read_lock_dont_migrate() {
    if (IS_ENABLED(CONFIG_PREEMPT_RCU))
            migrate_disable();
    rcu_read_lock();
  }

On CONFIG_PREEMPT_RCU=y kernels (the default for CONFIG_PREEMPT_DYNAMIC
distro kernels), rcu_read_lock() is __rcu_read_lock() which only
increments current->rcu_read_lock_nesting, and migrate_disable() uses
a scoped guard(preempt) so it does not leave preempt_count() elevated.

So with CONFIG_PREEMPT_RT=n, is_bpf_alloc_nonsleepable() returns false
and arena_alloc_pages_sleepable() is selected.

arena_alloc_pages_sleepable() then calls:

  kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT)
  bpf_map_alloc_pages() -> alloc_pages_node(..., GFP_KERNEL, ...)
  arena_free_pages() -> mutex_lock() and flush_tlb_kernel_range()

All of these can sleep. Documentation/RCU/whatisRCU.rst states "It is
illegal to block while in an RCU read-side critical section" even under
CONFIG_PREEMPT_RCU. Being preempted is permitted, but voluntarily
blocking is not.

The blocked reader is queued on rnp->blkd_tasks, so every concurrent
synchronize_rcu() on the system waits for the duration of the direct
reclaim. Under memory pressure (which the commit message says triggers
this path for "heavy BPF arena users like scx"), this yields unbounded
RCU grace-period extension, RCU CPU stall warnings, and delayed freeing
kernel-wide. The task also blocks with current->migration_disabled set
and rq->nr_pinned elevated, which stalls CPU hotplug for the same
duration.

The in-tree selftests confirm that non-sleepable programs are accepted:
tools/testing/selftests/bpf/progs/verifier_arena.c has several
SEC("socket") __success programs calling bpf_arena_alloc_pages(), and
tools/testing/selftests/bpf/progs/struct_ops_arena.c shows non-sleepable
SEC("struct_ops/...") callbacks bound to an arena map.

Should the sleepability decision be based on the verifier-known program
context rather than this runtime heuristic? For example, tagging
bpf_arena_alloc_pages() with KF_SLEEPABLE and adding a separate
non-sleepable kfunc, or plumbing the prog's sleepable flag down to
arena_alloc_pages()?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..700ed7a99579 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -596,15 +596,9 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>  }
>  #endif
>
> -static bool can_alloc_pages(void)
> -{
> -	return preempt_count() == 0 && !irqs_disabled() &&
> -		!IS_ENABLED(CONFIG_PREEMPT_RT);
> -}
> -
>  static struct page *__bpf_alloc_page(int nid)
>  {
> -	if (!can_alloc_pages())
> +	if (is_bpf_alloc_nonsleepable())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
>
>  	return alloc_pages_node(nid,


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32709208315
--===============4624490049248520616==--
