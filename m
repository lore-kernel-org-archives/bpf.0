Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABC36897E
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037848; cv=none; b=d1o1QSFkY8AI+8SrupwPWnnBTzaG5i5lOqloTAEy7MCUIknqK1JmTwQ/kQfzV/xj6qx5ZEE2gsHbetmAF5d5qT9j75nHFBCOW9pZgWgjoZU9XcZ71WZ5hy4XtNbkid3zggK+9u1begaunvZnXXe67MmkxQQzfen7jdWxfuO3a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037848; c=relaxed/simple;
	bh=QDqrHaAT3Z5GRNTMoHp4a6SY83zELweOUi7Rvw+Q+fI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=szwUIGu14ZyWDALv1Mz1502CZqTTr3pOSCXAY5TdQjBTpIKnX3qbOf4EMA4fmqyA+x/najPj+D7ywE2s/fosqdgSNH62Kj1yqpVQx12Mr9sKxoAL3mpXHySq6U0WJ5GQ40T7qRF8G0pP6cBSM8G4ByYUcrW+mhP6YxpiOUhKE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irmFiY5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irmFiY5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A51F00893;
	Tue,  9 Jun 2026 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781037847;
	bh=qgDapqs+eBf16D2JrOuRW9QTS6xuvY2nZtj4hL7JCqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irmFiY5iqfy8RRBZoIVlhrAgmU12VOptEW+mZME4D+77Xvs3BAGNkJlW4/8Ih56pN
	 ilcwCTdt5eP5N2ZYQFJVKRvo5aa82lnZswJ46ZplDI4XUynC11cWjdeA3Vi+c8IqK5
	 lA/jWsxPlEGc1IktrsXKlHpL5W2CGbB4pAZ5K1O40FI0UC8mnEsmC/Eigm6VYjU21F
	 Nj30aJSeKLC6w3wvZ6hkSarHKeExIUTMbrXolHQjvdxxvzH8zu+yMD86DiqU/BBhBZ
	 apa0rzJorXL1iEpLJvvJPjkJQ7/HRYfUUOUZPOIULqRht0eMepQsmI0LbklEsR3FQl
	 b7OeDjd7Z3V1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Cancel special fields on map value
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609202548.3571690-3-memxor@gmail.com>
References: <20260609202548.3571690-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 20:44:06 +0000
Message-Id: <20260609204406.ED1A51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Map updates and deletions on field-capable map types fail to fully=
 clear special BTF fields (BPF-001 violation).
- [Low] Multi-line comment uses the deprecated style with text starting on =
the same line as the opening '/*'.
--

commit ffac6bea087651cd2b865ac62682061845ecd16e
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Cancel special fields on map value recycle

This commit introduces bpf_obj_cancel_fields() to perform NMI-safe cleanup
of timer, workqueue, and task_work fields on the reusable-value path. It
updates array and hashtab update and delete paths to use this cancel
helper instead of bpf_obj_free_fields().

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -384,7 +384,7 @@ static long array_map_update_elem(struct bpf_map *map=
, void *key, void *value,
>  	if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
>  		val =3D this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  		copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(map, val);

[Severity: High]
Does this change violate the BPF subsystem invariant for map updates?

When copy_map_value() overwrites an existing map value, the subsystem guide
states that bpf_obj_free_fields() must be called to fully release resources
held by the old value. By switching to bpf_obj_cancel_fields() in
array_map_update_elem(), it appears fields like BPF_KPTR_REF or
BPF_LIST_HEAD are skipped, which could retain kernel resources in recycled
elements.

>  	} else {
>  		val =3D array->value +
>  			(u64)array->elem_size * (index & array->index_mask);
> @@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map=
, void *key, void *value,
>  			copy_map_value_locked(map, val, value, false);
>  		else
>  			copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(map, val);
>  	}
>  	return 0;
>  }

[ ... ]

> @@ -432,14 +432,14 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
>  		cpu =3D map_flags >> 32;
>  		ptr =3D per_cpu_ptr(pptr, cpu);
>  		copy_map_value(map, ptr, value);
> -		bpf_obj_free_fields(array->map.record, ptr);
> +		bpf_obj_cancel_fields(map, ptr);

[Severity: High]
Could this leak old BTF fields during a per-cpu array update?

Similar to the issue above, replacing bpf_obj_free_fields() with
bpf_obj_cancel_fields() here in bpf_percpu_array_update() seems to
bypass the full destruction of special fields when overwriting the
old map value.

>  		goto unlock;
>  	}
>  	for_each_possible_cpu(cpu) {
>  		ptr =3D per_cpu_ptr(pptr, cpu);
>  		val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>  		copy_map_value(map, ptr, val);
> -		bpf_obj_free_fields(array->map.record, ptr);
> +		bpf_obj_cancel_fields(map, ptr);
>  	}
>  unlock:
>  	rcu_read_unlock();

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -833,8 +837,8 @@ static int htab_lru_map_gen_lookup(struct bpf_map *ma=
p,
>  	return insn - insn_buf;
>  }
> =20
> -static void check_and_free_fields(struct bpf_htab *htab,
> -				  struct htab_elem *elem)
> +static void check_and_cancel_fields(struct bpf_htab *htab,
> +				    struct htab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(htab->map.record))
>  		return;
> @@ -844,11 +848,11 @@ static void check_and_free_fields(struct bpf_htab *=
htab,
>  		int cpu;
> =20
>  		for_each_possible_cpu(cpu)
> -			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
> +			bpf_obj_cancel_fields(&htab->map, per_cpu_ptr(pptr, cpu));
>  	} else {
>  		void *map_value =3D htab_elem_value(elem, htab->map.key_size);
> =20
> -		bpf_obj_free_fields(htab->map.record, map_value);
> +		bpf_obj_cancel_fields(&htab->map, map_value);

[Severity: High]
Does this leave special fields partially initialized?

By calling bpf_obj_cancel_fields() instead of bpf_obj_free_fields() in
check_and_cancel_fields(), the map value is not fully zeroed and special
fields are not fully released. This is required for operations reusing
these elements across both delete and update paths.

>  	}
>  }

[ ... ]

> @@ -1252,11 +1256,11 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
>  	if (l_old) {
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> =20
> -		/* l_old has already been stashed in htab->extra_elems, free
> -		 * its special fields before it is available for reuse.
> +		/* l_old has already been stashed in htab->extra_elems, cancel
> +		 * its reusable special fields before it is available for reuse.
>  		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style?

The BPF guidelines strictly require that multi-line comments have the
opening '/*' on its own line, with the comment text starting on the
next line.

>  		if (htab_is_prealloc(htab))
> -			check_and_free_fields(htab, l_old);
> +			check_and_cancel_fields(htab, l_old);

[Severity: High]
Is it safe to reuse the old element without dropping its special fields?

In htab_map_update_elem(), replacing check_and_free_fields() with
check_and_cancel_fields() means that when the old element is pushed to the
extra_elems or freelist, it may still hold onto kernel resources like
kptrs or list heads.

>  	}
>  	htab_unlock_bucket(b, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609202548.3571=
690-1-memxor@gmail.com?part=3D2
