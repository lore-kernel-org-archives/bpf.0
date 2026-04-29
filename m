Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2A37E2FD
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429796; cv=none; b=Jw2yeG221TIy1fcQTUHNml9CjjUeSo1vzdG4hc0vvs9vNkrQ57apfphx6Q1iKPp8xUXhXk5bWEF6uJTfeBWS/OyT/md5mAwbL7mDFJyRxiCmMMBqRsPMvfR7/m0PU8/nd5U9GkZiTrvWBbp0AOtgx+t3M6ogQD7qK62xnUyhnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429796; c=relaxed/simple;
	bh=VNaFJAAY6cl15iV8RjRGLZq3cUDDH06RZ2CkbGmSDX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dFyljVyqfQ05o+KL8/3Bn80/ek7TuIFTFfAUCs78qTacJTvQR4su9eYeOytGjwDYKU9R2GwGnIsBJa13OC1Re/ZRYZAH9dOM5aVwM0LMAxQcr3Quwb1b4XmwIc6sPDrHn9TNgQ9Zxjb6Btch08vFVX0FuJfwDWkEcuov6FtHLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txo12w8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txo12w8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D0AC2BCB7;
	Wed, 29 Apr 2026 02:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777429796;
	bh=VNaFJAAY6cl15iV8RjRGLZq3cUDDH06RZ2CkbGmSDX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=txo12w8gKPJ8xwPSryIdpwiSqWxKyfHcknwsxpnJQlCnjR/NQsGWiSnUzNbLOyVgI
	 F8bsXPDmB2Fdm1T+LiML20Lv7KhSuV9ya/t4lGqmDMzhdHf85l9FZAGkx7uEjY8XPU
	 WHFgYt4QImVxWzUqRQeDUPk/l6a4qAZxEqtHjjEog9fXJzh44lpqbImHzM+jfyUfha
	 DPGr2NpxfgvQlWK/9e2Zm7LN5Pay/oz5iMKkbJWTNO/8U1/Lkwpcof9ts8d3fQf6Xn
	 Po31ZOvOFSaLFafWIXN4o1X0t69s+yq8bOxCbUcGar4Sf/JJEeBs1X/lyODtU/4BoP
	 CNkSeX4QDvtCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf: Fix deadlock in kptr dtor in nmi
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428201422.1518903-4-utilityemal77@gmail.com>
References: <20260428201422.1518903-4-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:29:55 +0000
Message-Id: <20260429022955.D0D0AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Use-After-Free and lockless list corruption due to independent=
 irq_work execution.
- [Critical] Kernel pointer leak and arbitrary code execution via mmapable =
array maps.
- [Critical] Heap out-of-bounds write for dynamically allocated BPF local o=
bjects.
- [Critical] Use-after-free during map teardown due to premature element de=
struction.
- [High] Heap out-of-bounds access in local storage maps due to alignment m=
ismatch.
- [High] List corruption and double free in `btf_record_dup` error path.
- [High] Out-of-bounds write during map creation due to suppressed `btf_par=
se_fields` errors.
- [Medium] Preallocated map elements are permanently leaked during NMI upda=
tes.
- [Medium] Use of uninitialized synchronization primitives in dummy BTF rec=
ord cleanup paths.
- [Low] The `free_list` member in `struct btf_field_kptr` is unused dead co=
de.
--

commit 94e8c46e991deb52c20e3b7e90fd68827ad56fd4
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Fix deadlock in kptr dtor in nmi

This commit defers freeing of referenced kptrs using an irq_work queue
to prevent deadlocks in BPF tracing programs running under NMI. It adds
auxiliary storage to map elements to queue kptrs for deletion outside
the NMI context.

Link: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gm=
ail.com/

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 715b6df9c403..037bdadbed96 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
[ ... ]
> @@ -234,6 +236,10 @@ struct btf_field_kptr {
>  	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
>  	 */
>  	btf_dtor_kfunc_t dtor;
> +	struct irq_work irq_work;
> +	struct llist_head irq_work_items;
> +	struct llist_head free_list;

Is the free_list member used anywhere?

It appears to be initialized and cleared in the patch, but no elements are
ever added or removed from it, leaving it as dead code.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 5e25e0353509..919861b553c2 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
[ ... ]
> @@ -74,8 +75,12 @@ int array_map_alloc_check(union bpf_attr *attr)
>  	/* avoid overflow on round_up(map->value_size) */
>  	if (attr->value_size > INT_MAX)
>  		return -E2BIG;
> +	aux_size =3D bpf_map_attr_ref_kptr_aux_size(attr);
> +	if (aux_size < 0)
> +		return aux_size;
>  	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
> -	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
> +	if (percpu &&
> +	    round_up(attr->value_size, 8) + aux_size > PCPU_MIN_UNIT_SIZE)
>  		return -E2BIG;

Does this expose kernel pointers to userspace if the map is created with
the BPF_F_MMAPABLE flag?

Since aux_size is added to the element size of array maps without restricti=
ng
BPF_F_MMAPABLE, the internal struct bpf_kptr_dtor_aux could be mapped
directly into userspace.

Could this allow a malicious userspace application to overwrite the
llist_node.next pointer and potentially alter kernel control flow when
the irq_work processes the list?

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 6fc6a4b672b5..8b0be9612f20 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
[ ... ]
> @@ -800,14 +801,20 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>  		raw_res_spin_lock_init(&smap->buckets[i].lock);
>  	}
> =20
> -	smap->elem_size =3D offsetof(struct bpf_local_storage_elem,
> -				   sdata.data[attr->value_size]);
> +	smap->elem_size =3D offsetof(
> +		struct bpf_local_storage_elem,
> +		sdata.data[attr->value_size]);
> +	err =3D bpf_map_attr_ref_kptr_aux_size(attr);
> +	if (err < 0)
> +		goto free_buckets;
> +	smap->elem_size +=3D err;

Could this cause a heap out-of-bounds access if attr->value_size is not a
multiple of 8?

The offset calculation here does not round up attr->value_size to an 8-byte
boundary. However, btf_parse_fields() computes aux_off as
round_up(value_size, 8). This mismatch might shift the auxiliary structure
into padding that was never allocated.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..c3ad371948c3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> +static void htab_nmi_free_irq_work(struct irq_work *work)
> +{
> +	struct bpf_htab *htab =3D
> +		container_of(work, struct bpf_htab, nmi_free_irq_work);
> +	struct llist_node *node, *tmp, *list;
> +
> +	list =3D llist_del_all(&htab->nmi_free_elems);
> +	if (!list)
> +		return;
> +
> +	list =3D llist_reverse_order(list);
> +	llist_for_each_safe(node, tmp, list) {
> +		struct htab_elem *elem;
> +
> +		elem =3D container_of((struct pcpu_freelist_node *)node,
> +				    struct htab_elem, fnode);
> +		if (htab_is_prealloc(htab)) {
> +			if (htab_is_lru(htab))
> +				bpf_lru_push_free(&htab->lru, &elem->lru_node);
> +			else
> +				pcpu_freelist_push(&htab->freelist,
> +						   &elem->fnode);
> +		} else {
> +			htab_elem_free_nofields(htab, elem);
> +		}
>  	}
>  }

Could this lead to a use-after-free or lockless list corruption?

Element destruction in NMI is split into two independent irq_work items:
field->kptr.irq_work and htab->nmi_free_irq_work. Since they are scheduled
independently, htab->nmi_free_irq_work might execute first and return the
element memory to the allocator.

When field->kptr.irq_work subsequently runs, it iterates over aux->node
which is embedded inside the now-freed element memory.

> @@ -1082,12 +1189,23 @@ static struct htab_elem *alloc_htab_elem(struct b=
pf_htab *htab, void *key,
> =20
>  	if (prealloc) {
>  		if (old_elem) {
> -			/* if we're updating the existing element,
> -			 * use per-cpu extra elems to avoid freelist_pop/push
> -			 */
> -			pl_new =3D this_cpu_ptr(htab->extra_elems);
> -			l_new =3D *pl_new;
> -			*pl_new =3D old_elem;
> +			if (in_nmi() && htab->kptr_ref_aux_size) {
> +				struct pcpu_freelist_node *l;
> +
> +				l =3D __pcpu_freelist_pop(&htab->freelist);
> +				if (!l)
> +					return ERR_PTR(-E2BIG);
> +				l_new =3D container_of(l, struct htab_elem,
> +						     fnode);
> +			} else {

Does this leak preallocated map elements during NMI updates?

When updating an existing element from an NMI context, the code allocates
a new element from the freelist but skips stashing the old_elem in
htab->extra_elems. The htab_map_update_elem() logic assumes the old element
was stashed and purposely avoids freeing it, which could detach the element
permanently.

> @@ -1634,6 +1769,7 @@ static void htab_map_free(struct bpf_map *map)
>  	 * underneath and is responsible for waiting for callbacks to finish
>  	 * during bpf_mem_alloc_destroy().
>  	 */
> +	irq_work_sync(&htab->nmi_free_irq_work);
>  	if (!htab_is_prealloc(htab)) {
>  		delete_all_elements(htab);
>  	} else {

Can this cause a use-after-free during map teardown?

This function synchronizes htab->nmi_free_irq_work and frees all map elemen=
ts
via delete_all_elements() or prealloc_destroy(), but btf_record_free() is
called later in bpf_map_free_record().

If an element was deleted in NMI shortly before map destruction, its aux->n=
ode
might still be linked in field->kptr.irq_work_items. Flushing the kptr
deferred destruction after the elements are already freed could dereference
freed memory.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2caafce00f24..f26c8ed81690 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -751,6 +832,7 @@ struct btf_record *btf_record_dup(const struct btf_re=
cord *rec)
>  		}
>  		new_rec->cnt++;
>  	}
> +	bpf_kptr_record_init(new_rec);
>  	return new_rec;
>  free:
>  	btf_record_free(new_rec);

Could this error path cause list corruption and double frees?

Since kmemdup() creates a bitwise copy of the btf_record, the copied
irq_work_items llist_head points to the exact same nodes as the original
record. If an error occurs (such as try_module_get() failing), calling
btf_record_free(new_rec) will flush these uninitialized bitwise-copied list=
s,
potentially executing destructors prematurely for the original map's elemen=
ts.

> @@ -792,14 +874,79 @@ bool btf_record_equal(const struct btf_record *rec_=
a, const struct btf_record *r
[ ... ]
> +int bpf_map_attr_ref_kptr_aux_size(const union bpf_attr *attr)
> +{
[ ... ]
> +	rec =3D btf_parse_fields(btf, value_type, BPF_KPTR_REF, attr->value_siz=
e);
> +	if (IS_ERR(rec)) {
> +		aux_size =3D 0;
> +		goto out;
> +	}
> +	aux_size =3D rec ? rec->kptr_ref_aux_size : 0;
> +	btf_record_free(rec);
> +out:
> +	btf_put(btf);
> +	return aux_size;
> +}

Could suppressing the btf_parse_fields() error here cause out-of-bounds
writes later?

If btf_parse_fields() fails, aux_size is returned as 0 and the map allocati=
on
proceeds without auxiliary padding. If map_check_btf() later succeeds,
element initialization via bpf_kptr_aux_init_value() might write the 16-byte
structure past the allocated size of the element.

Also, could btf_record_free(rec) use uninitialized synchronization primitiv=
es?

Since bpf_kptr_record_init() is not called on the dummy record parsed here,
the irq_work structures remain zeroed. When btf_record_free() calls
bpf_kptr_record_flush(), it invokes irq_work_sync() on this uninitialized
memory, which might be unsafe on PREEMPT_RT kernels.

> @@ -857,14 +1003,35 @@ void bpf_obj_free_fields(const struct btf_record *=
rec, void *obj)
>  			if (!xchgd_field)
>  				break;
> =20
> -			if (!btf_is_kernel(field->kptr.btf)) {
> -				pointee_struct_meta =3D btf_find_struct_meta(field->kptr.btf,
> -									   field->kptr.btf_id);
> -				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
> -								 pointee_struct_meta->record : NULL,
> -								 fields[i].type =3D=3D BPF_KPTR_PERCPU);
> +			if (field->type =3D=3D BPF_KPTR_REF && in_nmi()) {
> +				struct bpf_kptr_dtor_aux *aux;
> +
> +				aux =3D bpf_kptr_ref_aux(field, obj);
> +				WARN_ON_ONCE(READ_ONCE(aux->ptr));
> +				WRITE_ONCE(aux->ptr, xchgd_field);
> +				if (llist_add(&aux->node,
> +					      &field->kptr.irq_work_items))
> +					irq_work_queue(&field->kptr.irq_work);
> +				break;
> +			}

Could this cause an out-of-bounds write for dynamically allocated BPF local
objects?

While map allocators were updated to include kptr_ref_aux_size, dynamically
allocated objects created via bpf_obj_new() might still only allocate the
base BTF struct size.

When dropping such an object in NMI context, bpf_kptr_ref_aux() might
calculate an offset past the allocated bounds, writing the auxiliary data
into adjacent heap memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428201422.1518=
903-1-utilityemal77@gmail.com?part=3D3
