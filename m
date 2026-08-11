Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6043C7DB
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445428; cv=none; b=rPN0zYG/iUr5NKoWMC1M242Q27loaubGK9XywH+0SjOlWxHtxU6dqHfJEhA5gGVf0hRfWLQILcokGtifcgHMbwLWElgph7kITyn95RQ4/wKGKbtkriRy92shXlRCUe/RTpqUqmgcDsQ7BHOGbSEE4TA+2iXgJ/zkHfnqeqR6MAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445428; c=relaxed/simple;
	bh=vjv2EYEgqDBdBFWuRMyysFUuAU1MbBJI/NAEr6X02Q8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A7ZOcTlhMv+OyHwuctJ+pHpM+3mBuM1c7kTcDeumK32VGwMC/3A1JxOU0nsDC3u7XWnm/6ruUp0oaFPGczksFojhYsq2+5KXkPKxijegBGhsOmNoXeXBLEvuzedwYk4r+PlmL0cMjpEzFDk4Z/3CM4sneInABeafgIPR9taSt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzGHT1Cj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzGHT1Cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3B71F000E9;
	Tue, 11 Aug 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445421;
	bh=MrHa/xJkTfdCdq5Cga6gac2y/6R9QTjZSsHHj6sJ9Fw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kzGHT1CjRBVqmhHXQ6R91vQf7/vE8jiK3DI0rn027HIhrpVffnC4SOIG8gVRY7sU3
	 EyHSaF+3braBtdvcKN3YOQrUbsm6+4K9SMHRiodRZGIUCcDbOWymZSSlx45z3X2FJw
	 MoYXuhnQcJ5878IdlhRSNUOBhumMBKcRq1ttNPzIHff14Oy6tzwOeAiqhP+z+r3T3F
	 ODOya6DgVj9NAL8RRzxN5LlVmLk35fH74ErN/0ehCIkhbOXTYNHG8oTv9Ud6yO9NaL
	 JSLPEdK9doFhfnwYNrdnzVGqbrxdQ1T6MnV0xx+K5hY6tLgaOYXG6k5Cp82QGGO4cv
	 TPKRB0JkVB82A==
Content-Type: multipart/mixed; boundary="===============1710427764309891036=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0adbe8917a9aa517402a7d5830dd1f787fe8fba6eced07928378ccb6e62ad374@mail.kernel.org>
In-Reply-To: <20260811095531.3294167-2-chenyuan_fl@163.com>
References: <20260811095531.3294167-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Cancel special fields in resizable hashtab on recycle
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 10:50:20 +0000 (UTC)

--===============1710427764309891036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..70fa1e1b4b00 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2865,14 +2865,23 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
>  	return htab_map_alloc_check(attr);
>  }
>
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> +static void rhtab_cancel_fields(struct bpf_rhtab *rhtab,
> +				struct rhtab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(rhtab->map.record))
>  		return;
>
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> +	/*
> +	 * Only cancel NMI-safe fields (timer, workqueue, task_work) here.
> +	 * kptr/uptr/list/rbtree destruction must not run from arbitrary BPF
> +	 * execution contexts (e.g. NMI), so leave those fields attached to
> +	 * the recycled element and let rhtab_mem_dtor() destroy them once the
> +	 * element is eventually freed. This matches the hash map semantics
> +	 * introduced by a3a81d247651 ("bpf: Cancel special fields on map value
> +	 * recycle").
> +	 */
> +	bpf_map_free_internal_structs(&rhtab->map,
> +				      rhtab_elem_value(elem, rhtab->map.key_size));
>  }

This isn't a bug, but the comment lists field types that BPF_MAP_TYPE_RHASH
values cannot contain. In map_check_btf(), BPF_UPTR is restricted to
BPF_MAP_TYPE_TASK_STORAGE, and BPF_LIST_HEAD/BPF_RB_ROOT are allowed only
in BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_ARRAY.
BPF_MAP_TYPE_RHASH is absent from both lists.

The only field types that bpf_obj_free_fields() actually handles beyond
the cancelled ones are BPF_KPTR_REF and BPF_KPTR_PERCPU. Could the
comment be more precise about what this code path actually affects?

>
>  static void rhtab_mem_dtor(void *obj, void *ctx)

[ ... ]

> @@ -2964,8 +2973,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/* Cancel NMI-safe fields; full destruction happens in rhtab_mem_dtor */
> +	rhtab_cancel_fields(rhtab, elem);
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }

Does this leak referenced kptrs when a deleted rhtab element is recycled
by the bpf memory allocator?

Unlike htab, rhtab re-initialises special fields of every freshly
allocated element. In rhtab_map_update_elem():

    elem = bpf_mem_cache_alloc(&rhtab->ma);
    ...
    copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
    check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));

check_and_init_map_value() calls through to bpf_obj_init_field(), which
does memset(addr, 0, field->size) for BPF_KPTR_REF fields, overwriting
the pointer without releasing the reference.

Before this patch that was safe: rhtab_delete_elem() called
rhtab_check_and_free_fields(), which ran bpf_obj_free_fields() to xchg
the kptr out and drop it, so the recycled element arrived with the field
already zeroed. After the patch rhtab_cancel_fields() only touches
BPF_TIMER/BPF_WORKQUEUE/BPF_TASK_WORK via bpf_map_free_internal_structs(),
so the live kptr stays in the element.

Can this sequence occur?

  1. BPF prog stores a referenced kptr in an RHASH element (allowed:
     map_check_btf() lists BPF_MAP_TYPE_RHASH in the BPF_KPTR_REF
     allowlist).
  2. bpf_map_delete_elem()->rhtab_map_delete_elem()->rhtab_delete_elem()
     cancels only NMI-safe fields, then bpf_mem_cache_free_rcu().
  3. unit_free_rcu() puts the element on c->free_by_rcu; after a grace
     period it lands on c->free_llist.
  4. Next insert: rhtab_map_update_elem()->bpf_mem_cache_alloc()->
     unit_alloc() pops that element off c->free_llist.
  5. check_and_init_map_value() memsets the kptr field to 0. The
     reference is now unreachable and is never dropped.

The dtor cannot save it: rhtab_mem_dtor() is only reached from
free_all() in memalloc.c, which runs immediately before free_one()
returns the object to the slab, never on the unit_alloc() reuse path.

Why htab is not affected: alloc_htab_elem() has no
check_and_init_map_value() call, so a recycled htab element genuinely
inherits the kptr, which is what a3a81d247651 relies on. Does rhtab
break that pairing?

__rhtab_map_lookup_and_delete_batch() amplifies it: the loop at line
3363 calls rhtab_delete_elem() up to attr->batch.count times, leaking
one reference per element.

> @@ -3024,10 +3033,11 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  	 * BPF_F_LOCK, matching arraymap semantics.
>  	 *
>  	 * copy_map_value() skips special-field offsets, so old timers/
> -	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> -	 * to match arraymap's update semantics.
> +	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
> +	 * the copy to match arraymap's update semantics; referenced kptrs
> +	 * stay attached and are destroyed by rhtab_mem_dtor().
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_cancel_fields(rhtab, elem);
>  	return 0;
>  }

A subsystem pattern flags this as potentially concerning:
rhtab_map_update_existing() overwrites a live map value with
copy_map_value()/copy_map_value_locked() and, after this patch, no
longer calls bpf_obj_free_fields() on the old value.

BPF_MAP_TYPE_RHASH is in the map_check_btf() allowlists for
BPF_SPIN_LOCK/BPF_RES_SPIN_LOCK, BPF_TIMER/BPF_WORKQUEUE/BPF_TASK_WORK
and BPF_KPTR_UNREF/BPF_KPTR_REF/BPF_KPTR_PERCPU/BPF_REFCOUNT, making it
a field-capable map type. The subsystem guide notes that map operations
on field-capable types that copy values with copy_map_value() should
pair with check_and_init_map_value() (lookups) or bpf_obj_free_fields()
(updates).

Observable effect: after a successful update the element's kptr slot
still holds the previous value's kptr, which the new value inherits. A
program that writes a fresh value and then reads the kptr field sees a
pointer it never installed.

The removal appears deliberate and mirrors upstream a3a81d247651, which
made exactly this change for array_map_update_elem() and
pcpu_copy_value() so that kptr destructors are not run from NMI. That
commit's changelog explicitly accepts the relaxed semantics: "This
deliberately relaxes the eager-free semantics of map update/delete for
special fields." On that reading the field inheritance here would be
intended rather than a bug. Is that the correct interpretation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31481833569
--===============1710427764309891036==--
