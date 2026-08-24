Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03C44D685;
	Mon, 24 Aug 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586150; cv=none; b=Ponx+JMkVxF9Kg326ibMqlXJnJF2gB1FJLiZp8mPOXeRXAT60eFstDCJ7aUlxww1yYNKa+a29P7MdljJat6cVPS8L8781n4jd1oPZ5moUtLilw7UwRC2U5LHz4mr6ZXKKEVr3ZTFyBZFBdESxKuHBFIJOzI0MNjFgaM6Wq78W18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586150; c=relaxed/simple;
	bh=jHFchdjdGcnOQpwM/xnJ2rXTRBJ9Z07e4UdPB5SjEgM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=egergZghEP3MjT4jaXWw+7zcj4MbQVC/AlvXSk56JxZxdoePezlsk0drHiQ6qhzUtAG9bWtTn3IuLppeyK4KI5JDm0f6IpK+iRM8+ImIYiu8qe3hRC8WuX0wynBkarwKUywF9gW3WzMPkGYnpseZr6NUBa0WHjfLups0VKJidVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHIMt5vR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHIMt5vR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EFB1F00A3D;
	Mon, 24 Aug 2026 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586141;
	bh=GDGm9kCuRIA/gsg9zQDj/jBe/CB8+xesttXtkMtpukg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EHIMt5vRpKjIqZ+EKC7kxJgIjHlJ2hUElrIjAR1eSPfXUhcbVjXxseGY4SYHjIe+6
	 scaqg0WnqTo9pCFewfggZGD7wES4oCESHJ74T+sXlShmnV5qX+uS8ta72Ysnj9AUnJ
	 q+48Dcyfmwwk4PZ9M9Lj96Y8UBG7zEvGBpIxbyqUcnoK1c9IRu2Eh0AsvbOuldAS1F
	 44q2yOcwvF9B8ekc2T4N3Cy+Eu7h1ldDNJpHj94cReEI5pkaZccZaFU4OuMFc8oG82
	 5apjShKFBjZxlSzI/EJvgEqwlJfOZ3WU6dWi9p6jTSx5P33Apyzfnaopfh6kxtRAJT
	 fRAcdIMQUHawA==
Content-Type: multipart/mixed; boundary="===============1208854577277626609=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ceccb98284af19c29afad1d8269ec4376a3e430db17870352c21374330c6a09a@mail.kernel.org>
In-Reply-To: <20260824143621.2098856-2-chenyuan_fl@163.com>
References: <20260824143621.2098856-2-chenyuan_fl@163.com>
Subject: Re: [PATCH 1/4] bpf: Cancel special fields in resizable hashtab on recycle
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 15:42:20 +0000 (UTC)

--===============1208854577277626609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446c..0df8db27cd8c 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2864,14 +2864,56 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
> +	 * RHASH values can also carry referenced kptrs (and per-cpu kptrs),
> +	 * whose destructors must not run from arbitrary BPF execution
> +	 * contexts (e.g. NMI); leave them attached to the recycled element
> +	 * and let rhtab_mem_dtor() destroy them once the element is
> +	 * eventually freed. This matches the hash map semantics introduced
> +	 * by a3a81d247651 ("bpf: Cancel special fields on map value
> +	 * recycle").
> +	 */
> +	bpf_map_free_internal_structs(&rhtab->map,
> +				      rhtab_elem_value(elem, rhtab->map.key_size));
> +}

This isn't a bug, but could the explanation live in one place with the call
sites pointing at it? The same rationale appears in five spots throughout
this change: here above rhtab_cancel_fields(), above rhtab_init_map_value(),
and in three more comments in the call sites below. That's roughly 33
comment lines against 25 lines of code, and any future adjustments to the
reasoning need to be synced across all five. For comparison, the equivalent
hash map helpers check_and_cancel_fields() and htab_elem_free() carry no
comment at all.

> +
> +/*
> + * Initialize special fields of a freshly allocated rhtab element, but keep
> + * kptr fields untouched. A recycled element may carry a referenced kptr from
> + * its previous life: the delete path only cancels NMI-safe fields (matching
> + * the hash map semantics), so the kptr reference stays owned by the element
> + * until rhtab_mem_dtor() destroys it. Zeroing it here (as
> + * check_and_init_map_value() would) would drop the reference without
> + * releasing it.
> + */
> +static void rhtab_init_map_value(struct bpf_map *map, void *value)
> +{
> +	struct btf_record *rec = map->record;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		struct btf_field *field = &rec->fields[i];
> +		void *field_ptr = value + field->offset;
> +
> +		switch (field->type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
> +			continue;
> +		default:
> +			bpf_obj_init_field(field, field_ptr);
> +		}
> +	}
> +}

This isn't a bug, but could this kptr-filtering init be unified with
bpf_obj_init() rather than duplicated here? rhtab_init_map_value()
re-implements the field walk from bpf_obj_init() with a kptr filter in
front of bpf_obj_init_field(). The hash map path this change says it is
matching takes a different route: alloc_htab_elem() does no special-field
initialization at all on a recycled or fresh element, relying on __GFP_ZERO
for fresh memory and on bpf_obj_cancel_fields() having left the cancelled
fields reusable. Would it be simpler to drop the init call entirely the way
alloc_htab_elem() does, or to add the kptr skip as a flag or variant of
bpf_obj_init() so the field walk lives in one place?

[ ... ]

> @@ -3022,10 +3064,11 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
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

A subsystem pattern flags this as potentially concerning: after this change,
rhtab_map_update_existing() overwrites an existing map value in place with
copy_map_value() but then only calls rhtab_cancel_fields(), which now calls
bpf_map_free_internal_structs() instead of bpf_obj_free_fields().
bpf_map_free_internal_structs() handles only BPF_TIMER, BPF_WORKQUEUE and
BPF_TASK_WORK. The BPF_KPTR_REF or BPF_KPTR_PERCPU reference held by the
value the user just overwrote is no longer released at update time; it stays
attached to the live element and is only destroyed when the element is
eventually freed to the slab.

Before the change:

rhtab_check_and_free_fields(rhtab, elem);   /* -> bpf_obj_free_fields() */

After:

rhtab_cancel_fields(rhtab, elem);           /* -> bpf_map_free_internal_structs() */

The change appears intentional and mirrors array_map_update_elem(), which
was itself converted from bpf_obj_free_fields() to bpf_obj_cancel_fields()
by a3a81d247651. The reference is not leaked, only its release is deferred:
the element keeps ownership, and rhtab_mem_dtor() runs bpf_obj_free_fields()
before returning memory to the allocator. The kptr slot holds at most one
reference and copy_map_value() never writes it, so repeated updates cannot
accumulate references. Is this deferred-release semantic for RHASH
intentional, matching the hash map and array behavior?

> @@ -3066,7 +3109,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> -	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
> +	/*
> +	 * Initialize special fields of the (possibly recycled) element, but
> +	 * leave kptr slots alone: a recycled element may still own a
> +	 * referenced kptr that rhtab_mem_dtor() will release, so zeroing it
> +	 * here would leak the reference. Fresh memory from the bpf mem
> +	 * allocator is zeroed, so skipping the kptr init is safe there too.
> +	 */
> +	rhtab_init_map_value(map, rhtab_elem_value(elem, map->key_size));

A subsystem pattern flags this as potentially concerning: after this change,
rhtab_map_update_elem() copies the user value into a newly allocated element
with copy_map_value() and the paired check_and_init_map_value() call is
replaced by rhtab_init_map_value(), which explicitly skips BPF_KPTR_UNREF,
BPF_KPTR_REF and BPF_KPTR_PERCPU instead of calling bpf_obj_init_field().
copy_map_value() also skips special-field offsets via bpf_obj_memcpy(), so
no code writes the kptr slots of the new element. bpf_mem_cache_alloc() may
hand back an element recycled from a previous operation whose kptr slots
were left populated, and the element is then published into the rhashtable
under a new key while still carrying the previous occupant's kptr.

Before the change:

check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));

After:

rhtab_init_map_value(map, rhtab_elem_value(elem, map->key_size));

Skipping BPF_KPTR_REF and BPF_KPTR_PERCPU init appears required for the
accounting to balance: zeroing the slot with bpf_obj_init_field() would drop
the pointer without running the destructor. The equivalent reference path,
alloc_htab_elem() for non-prealloc hash maps, performs no special-field
initialization at all, so htab inherits recycled kptrs the same way. Fresh
memory from the allocator is verified to be zeroed via __GFP_ZERO. Is the
kptr inheritance across recycled elements under new keys the intended
behavior?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32741782570
--===============1208854577277626609==--
