Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E43BD649
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993766; cv=none; b=JJULPSTZSR1Wpdos5bLHkoNap/ekZY69FZjx0J9v9JpjIs/yEIcDS5qxXftzjHtIbJuGgvGsTkh7ATsXAfwI2fZufjtvibVDxMFXlSxHImtiDr89E538e6Hv/g7WGTBT2euwT8zXDbEeo0ts0CAAN/Ol9l6BCelub9eWaLwunbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993766; c=relaxed/simple;
	bh=xUo9TQ2nW97LYLu2bTraNtDgyWnUh/8fBPkADUFzmuM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VvFddqMwkX0PvSKSG31XfPf70UIBjNslfvMJtDx4wKGZUFNSKbTKUNBjAJvTLk5jU8DTQVFmXcfqzTxUmoaBvd4NcmYaHp0VsAO1Y0/G8jx15UBqnXqeKMHGFMdfjK6+fjIMf2kdLoGGbhnIaMksPJ7TNFvjsr8NQWl2QehRZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFSu7RLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFSu7RLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3871F000E9;
	Thu, 28 May 2026 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779993764;
	bh=ztzWJliDJMLBQgFEKdGAPSokC8MNvhv1yeD9/r7/0oc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hFSu7RLWz0YaU0bykDiIsdYymb8DN/M9SfgF1Z3j/txurVV2mHRrIntrllznesxv7
	 s0QM93nzHqBHNaJQizpyIMIJXpEwy2VUgPUifmOD665Oi1arz6OVCzLftt47xl6mqy
	 OVMoU+OjY8s7B7X/6M0F8ed6GjUxHOk+KqyKiEWUaHSqeVN2auzMJKrQCaaVyrjcVS
	 XO7JsFmgUe3IiiyQWXkaxj8M0ydZF6pJEJKQTMF9IvMmuGOPNUJ0a6ApmrgZtovDc/
	 hUltfjQhx/LUq8G7AJWZ3qIJhwiInnCIz+rSfjmWGjCnPS6pmhejgwnyNdddQv8tI9
	 iv3XyT+eBK/3g==
Content-Type: multipart/mixed; boundary="===============4954265713293012791=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd400a6c3c1452ca221fe95e15d160f014605ff826271d4954fc5cb31c08ece9@mail.kernel.org>
In-Reply-To: <20260528-rhash-v5-3-7205191b6c57@meta.com>
References: <20260528-rhash-v5-3-7205191b6c57@meta.com>
Subject: Re: [PATCH bpf-next v5 03/11] bpf: Implement resizable hashmap basic functions
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 18:42:44 +0000 (UTC)

--===============4954265713293012791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..8944c9f070ca 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +static void rhtab_free_elem(void *ptr, void *arg)
> +{
> +	struct bpf_rhtab *rhtab = arg;
> +	struct rhtab_elem *elem = ptr;
> +
> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> +}

bpf_map_free_internal_structs only handles timers, workqueues, and
task_work (not kptrs, list_heads, rb_roots, or refcounted objects). In
contrast, htab's htab_elem_free calls check_and_free_fields which
eventually invokes bpf_obj_free_fields for the full field list. As a
result, when this restriction is later lifted, rhtab_free_elem would
leak kptrs and skip list/rbtree drains during map teardown.

The issue is latent at this commit because syscall.c map_check_btf
rejects all those field types for RHASH maps (map->record is NULL), but
the follow-up commit that enables the field types must rewrite this
entire function and add a memalloc destructor with bpf_obj_free_fields.

[ ... ]

> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, void *copy,
> +			     u64 flags)
> +{
> +	int err;
> +
> +	/*
> +	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
> +	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
> +	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
> +	 * raw tracepoints, which we don't have in rhashtable.
> +	 */
> +	bpf_disable_instrumentation();
> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
> +	bpf_enable_instrumentation();

Does bpf_disable_instrumentation prevent the softirq deadlock scenario?

The v4 bot review noted that if a syscall holds the bucket lock and
is interrupted by hardware IRQ that schedules softirq (e.g., XDP or TC
program), the softirq would deadlock trying to acquire the same bucket
lock. bpf_disable_instrumentation only prevents NMI-based tracing
programs, not softirq programs triggered by hardware IRQs.

Alexei Starovoitov suggested in v1 that update/delete operations should
check 'if (irqs_disabled()) return -EBUSY' to prevent this class of
deadlock. That check is not present in this version.

Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/

> +
> +	if (err)
> +		return err;
> +
> +	if (copy) {
> +		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
> +		check_and_init_map_value(&rhtab->map, copy);
> +	}
> +
> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> +	return 0;
> +}

The element is freed with bpf_mem_cache_free_rcu without calling
bpf_obj_free_fields or check_and_free_fields on the value. Compare with
htab's free_htab_elem which calls check_and_free_fields before freeing.

Once special fields are enabled for RHASH maps (by a later commit),
deleting an element with kptrs, list_heads, or rb_roots would leak those
resources. The later commit that enables special fields adds
rhtab_check_and_free_fields here.

[ ... ]

> +static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
> +				      u64 map_flags)
> +{
> +	void *old_val = rhtab_elem_value(elem, map->key_size);
> +
> +	if (map_flags & BPF_NOEXIST)
> +		return -EEXIST;
> +
> +	if (map_flags & BPF_F_LOCK)
> +		copy_map_value_locked(map, old_val, value, false);
> +	else
> +		copy_map_value(map, old_val, value);
> +	return 0;
> +}

copy_map_value deliberately skips special-field offsets so it doesn't
clobber kptr/timer/list_head pointers. After this in-place update
returns, the element's value contains the new scalar bytes but still
holds the OLD kptrs, timers, and work-queue handles at the special
offsets.

Arraymap and htab both invoke bpf_obj_free_fields or cancel timers on
the old value after the scalar copy to release the per-element
resources. The follow-up commit that enables special fields adds
rhtab_check_and_free_fields after the copy to match this pattern.

[ ... ]

> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *elem, *tmp;
> +
> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> +		return -EINVAL;
> +
> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
> +		return -EINVAL;

Similar deadlock question as rhtab_delete_elem: does
bpf_disable_instrumentation (used later in this function) prevent the
softirq deadlock where a syscall holds the bucket lock and is interrupted
by hardware IRQ that schedules softirq?

Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/

[ ... ]

> +	elem = bpf_mem_cache_alloc(&rhtab->ma);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	memcpy(elem->data, key, map->key_size);
> +	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);

bpf_mem_cache_alloc returns memory that is not zeroed at special-field
offsets (the cache may recycle freed objects). copy_map_value
deliberately skips those offsets. The freshly inserted element's value
therefore has uninitialized bytes at every special-field offset (timer
pointer, kptr, list_head, rb_root, etc.).

The canonical pattern is to call check_and_init_map_value after
copy_map_value to zero-initialize or call the field-specific init for
every special-field offset. htab does this in alloc_htab_elem and
pcpu_init_value. The follow-up commit adds check_and_init_map_value
here.

[ ... ]

> +
> +BTF_ID_LIST_SINGLE(rhtab_map_btf_ids, struct, bpf_rhtab)
> +const struct bpf_map_ops rhtab_map_ops = {
> +	.map_meta_equal = bpf_map_meta_equal,
> +	.map_alloc_check = rhtab_map_alloc_check,
> +	.map_alloc = rhtab_map_alloc,
> +	.map_free = rhtab_map_free,
> +	.map_get_next_key = rhtab_map_get_next_key,
> +	.map_release_uref = rhtab_map_free_internal_structs,
> +	.map_lookup_elem = rhtab_map_lookup_elem,
> +	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
> +	.map_update_elem = rhtab_map_update_elem,
> +	.map_delete_elem = rhtab_map_delete_elem,
> +	.map_gen_lookup = rhtab_map_gen_lookup,
> +	.map_btf_id = &rhtab_map_btf_ids[0],
> +};

rhtab_map_ops does not define a .map_mem_usage callback. At this commit,
kernel/bpf/syscall.c __map_create enforces:

  if (!ops->map_mem_usage)
    return -EINVAL;

This check sits before map_alloc. As a result, every attempt to create a
BPF_MAP_TYPE_RHASH map fails with -EINVAL at the bpf(BPF_MAP_CREATE)
syscall. No code path inside rhtab_map_alloc / rhtab_map_update_elem /
etc. is reachable from user space.

The commit's stated runtime semantics (use rhashtable_lookup_likely for
lookups, in-place updates) are untestable because no map of this type
can exist. The bpf_map_show_fdinfo path also relies on
map->ops->map_mem_usage(map) without a NULL check, so even if the create
check were bypassed, /proc/[pid]/fdinfo/[map_fd] would NULL-deref.

The follow-up commit 'bpf: Implement iteration ops for resizable
hashtab' adds rhtab_map_mem_usage and wires .map_mem_usage =
rhtab_map_mem_usage in rhtab_map_ops. Each patch must compile and
introduce a working feature when applied to a kernel that bisects to it.
This commit is the first to expose BPF_MAP_TYPE_RHASH to user space (it
touches uapi bpf.h and the syscall.c switch), so this missing callback
breaks bisection.

[ ... ]

> +static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
> +{
> +	return -EOPNOTSUPP;
> +}

rhtab_map_get_next_key always returns -EOPNOTSUPP, meaning userspace
cannot iterate keys of a BPF_MAP_TYPE_RHASH map via the standard syscall
API, and tools like bpftool dump cannot list rhtab map contents.

The series previously added rhashtable_next_key API which provides
best-effort iteration, but it was never wired up.

Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/

[ ... ]

Multiple map_ops are registered as functional callbacks but are stubs
that were removed in v5. However, in v5 many callbacks that should be
present are missing entirely (map_seq_show_elem, map_for_each_callback,
map_mem_usage, BATCH_OPS, iter_seq_info).

While returning -EOPNOTSUPP is graceful (no crash), registering ops
pointers that fail rather than relying on the dispatcher's NULL check
defeats the verifier's compile-time validation: the verifier will accept
BPF programs that call bpf_for_each_map_elem on an rhtab map, only to
fail at runtime. Should these callbacks be NULL instead?

Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d4ea700aac6..12c07310016a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... syscall.c changes for map_extra and map_lookup_and_delete_elem allowlist ... ]

The commit message states: 'Updates modify values in place under RCU
rather than allocating a new element... This trades read consistency for
performance: concurrent readers may see partial updates. Users requiring
consistent reads should use BPF_F_LOCK.'

The rhtab implementation in kernel/bpf/hashtab.c is wired for BPF_F_LOCK:
rhtab_map_update_elem checks btf_record_has_field(map->record,
BPF_SPIN_LOCK), and rhtab_read_elem_value / rhtab_map_update_existing
call copy_map_value_locked when BPF_F_LOCK is set.

However, this patch does not add BPF_MAP_TYPE_RHASH to the BPF_SPIN_LOCK
allow-list in map_check_btf at kernel/bpf/syscall.c (the case
BPF_SPIN_LOCK block that lists HASH, ARRAY, CGROUP_STORAGE, SK_STORAGE,
INODE_STORAGE, TASK_STORAGE, CGRP_STORAGE).

When a user attempts to create an RHASH map whose value type contains a
struct bpf_spin_lock (the only way to enable BPF_F_LOCK on a map),
__map_create calls map_check_btf, the BPF_SPIN_LOCK case checks the
allow-list, does not find BPF_MAP_TYPE_RHASH, and returns -EOPNOTSUPP.
The map cannot be created.

Therefore the BPF_F_LOCK code paths in rhtab_map_* are unreachable in
this commit, contradicting the commit message. A user bisecting a tree
at this commit and trying to use the documented BPF_F_LOCK feature on an
RHASH map will get -EOPNOTSUPP at map creation time.

The follow-up commit 'bpf: Allow special fields in resizable hashtab'
adds BPF_MAP_TYPE_RHASH to both the BPF_SPIN_LOCK and
BPF_TIMER/BPF_WORKQUEUE/BPF_TASK_WORK switch cases in map_check_btf.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26592533594
--===============4954265713293012791==--
