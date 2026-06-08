Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E83612FB
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941709; cv=none; b=Kxwe2Xyypozds1nED5RQ6OlfuNv0O9KI4XoRpW6xUTeJTvSRc01zzh+j1XPZoibEy+mmZ2ZcVhl+orJ22NS3BgYV2a39NanUNSXa7fYk8ltk6NVTo6E4XSrNy4MrmYT/Juzc66sW8Vm36R+ggnLSZKo1T2T7hjedoDhPzfUxEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941709; c=relaxed/simple;
	bh=t30B3xCRafcTKBjO9FLerYZnX9cruXut3UHNASJk7x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTuPhceEsn/EVKIhbjdVQfXbxediQtkfTv9shQJqUmSKcfhGmhdPpvtVhht79aAfZtfxK2unAzGZiq0Ud8BEv0LewHNWtTlUoGYUAQ8F2ZjuqYhE9AWGXFk4I98kal0JJcfwwwOtbbIEetz82Q6ZpKKm37OOekVebDrB7A7i3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6/v9Nzw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6/v9Nzw"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7ddd3d67084so51140407b3.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941707; x=1781546507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyznEAmKn1TlqwG0Br/nEMcz8Z6a6xKVuehAuOnmgCI=;
        b=T6/v9NzwXLXCDSngURG2RuzSLQqZi6a4QMC0cUax7ye06hr8mz5b/ofHtDwC6Ym8yr
         AmSp3yxAZRniD/fcvN33+FSCyzlZVGkcvJY68hyuuSkyHUF5QFWYl0PPDynt1XCBM7q+
         52tJC0FmWV0J+tECZF2TgIQ6ZIjBT+3Vvo0po81rk1RIIySc3P+3aUv3JnBmSIH8FUj+
         Gff4FDfs69h+v+lp+k1nOd3CpKg+6H1G39xVP5bscel8DP/7rxnNCexvc45L7RuZ7iqg
         lXrHFiJZPQbructPuan+OuSxXpNlOjv7UB7a8TesHfB2o5Iz9KUrbTvgB9vX7dfT6dB5
         Ef+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941707; x=1781546507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyznEAmKn1TlqwG0Br/nEMcz8Z6a6xKVuehAuOnmgCI=;
        b=iM5Llty7Rzuk9kvZVzKrBBF/zj1dUFjYHndZuuAiSxHJZNvXap/Ee06i7jiHgokkqf
         J8p1muFKX1aoOrjEIHwoYzcE/+2OIxNWxIVtPXIzYzzSrr8zdC3fqP/0kf+Ih4/hSqqX
         jCm4Ke7DcpqKLCtJgVZQc9tgWHrx4eHvmpVFQYaq4h7ZHkc/iehO5DvRSZjDfBT1vXZW
         0cr8LR0+DicRswaoGTFnWXlnjn+RHyEKWKoLR+XUZYg2flzHYCab66m8Z4dT40sD3Ise
         CLbn75sTS7BSiuWFEQmrQ0yySmUFRewXinG2ig+/XaL6bLHjPhz1TxhXX2dpZXVAQQME
         UduQ==
X-Gm-Message-State: AOJu0YyGUWfnKqcz1FX0AO3uzcOhiggQEiV7fHvdJ5jVliUt3c2DEFVq
	nnIt+19yDk9UUHicmtrI9pEW1ZZaoaG9xUAD9N6vtVEU21pKe8vSsK1z
X-Gm-Gg: Acq92OGn9mVC4r7EoqC4JhH6GjJ5Zcz3M/wABok9ACx2tn9/eV6SMydWrnSPkOH4EhR
	WKfIowwxKV7s0wEVZSS7bfmunXxRWp9TOyUtYfdGYMp3h6n7FdWYd4UCZBjaHpZqKzGQSn4JfTA
	LXXgj93FUsXoHsIz4N3ePaJvZ6L4Yb0luSS15l/gLutvc7CgmhX+wfps6RjBJYU5X+KQPx69GiZ
	+lar5Mbu41sEdWnPh99R8aWQYA8t+wOKMG8jshr+NeveyrvAEfBHAEHkK5yesj+KbOI70bjWbut
	IZ6Mgl4JinpbdAji4VLxAYzeckB8GSFodC9lZG0zb3M59agKX4aZIGnfOpuVJtWQpPHsQSscBW0
	76KyS+LM2WvYLs5p/+P09Rv3prABPORmxq1f1IHWJPW0/Q+mYD6Sl+RFLXgof0Mj6DKyLXBrDDI
	z1Wf+OuEUdahMl+M0gCtytHda+INtzWaMrCnTA+bSUiq6VgfRlNHzAEFei1jN6ddSbwdP+
X-Received: by 2002:a05:690c:4b0a:b0:7b3:edc7:9b97 with SMTP id 00721157ae682-7ed0878ff32mr169639427b3.0.1780941706956;
        Mon, 08 Jun 2026 11:01:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5176:5522:fd44:7a6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8d0dsm86807567b3.6.2026.06.08.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:01:46 -0700 (PDT)
Date: Mon, 8 Jun 2026 14:01:45 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Cancel special fields on map value
 recycle
Message-ID: <aicB9SZfVnUV1rz-@zenbox>
References: <20260608144841.1732406-1-memxor@gmail.com>
 <20260608144841.1732406-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608144841.1732406-4-memxor@gmail.com>

On Mon, Jun 08, 2026 at 04:48:36PM +0200, Kumar Kartikeya Dwivedi wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Map update and delete paths currently call bpf_obj_free_fields() when a
> value is being replaced or recycled. That makes field destruction depend
> on the context of the update/delete operation. For tracing programs this
> can include NMI context, where referenced kptr destructors, uptr
> unpinning, and graph root destruction are not generally safe.
> 
> Introduce bpf_obj_cancel_fields() for the reusable-value path. It only
> performs NMI-safe cleanup for timer, workqueue, and task_work fields.
> Fields that need full destruction are left attached to the recycled value
> and are destroyed by the final cleanup path instead.
> 
> Switch array and hashtab update/delete/recycle paths to this cancel
> helper. Keep bpf_obj_free_fields() for final map destruction and for
> bpf_mem_alloc destructors. Preallocated hashtabs do not have allocator
> destructors, so teardown continues to walk the normal and extra elements
> and fully destroy their fields.
> 
> This deliberately relaxes the eager-free semantics of map update/delete
> for special fields. Programs that relied on a recycled map slot becoming
> empty immediately after update/delete were relying on behavior that
> cannot be implemented safely from every BPF execution context without
> offloading arbitrary destructors.
> 
> There is a chance this change breaks programs making assumptions
> regarding the eager freeing of fields. If so, we can relax semantics to
> cancellation only when irqs_disabled() is true in the future. However,
> theoretically, map values that get reused eagerly already have weaker
> guarantees as parallel users can recreate freed fields before the new
> element becomes visible again.
> 
> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           |  1 +
>  kernel/bpf/arraymap.c                         |  8 ++---
>  kernel/bpf/hashtab.c                          | 32 +++++++++++--------
>  kernel/bpf/syscall.c                          | 27 ++++++++++++++++
>  .../selftests/bpf/prog_tests/htab_update.c    |  4 +--
>  .../selftests/bpf/prog_tests/map_kptr.c       | 10 +-----
>  .../testing/selftests/bpf/progs/htab_update.c |  4 +--
>  7 files changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0654d2ffadc1..fc24b81cc206 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2717,6 +2717,7 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
>  void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
>  void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
>  void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
> +void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj);
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
>  
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index e6271a2bf6d6..4e8d6fe6999b 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -384,7 +384,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>  		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  		copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(array->map.record, val);
>  	} else {
>  		val = array->value +
>  			(u64)array->elem_size * (index & array->index_mask);
> @@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>  			copy_map_value_locked(map, val, value, false);
>  		else
>  			copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(array->map.record, val);
>  	}
>  	return 0;
>  }
> @@ -432,14 +432,14 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  		cpu = map_flags >> 32;
>  		ptr = per_cpu_ptr(pptr, cpu);
>  		copy_map_value(map, ptr, value);
> -		bpf_obj_free_fields(array->map.record, ptr);
> +		bpf_obj_cancel_fields(array->map.record, ptr);
>  		goto unlock;
>  	}
>  	for_each_possible_cpu(cpu) {
>  		ptr = per_cpu_ptr(pptr, cpu);
>  		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>  		copy_map_value(map, ptr, val);
> -		bpf_obj_free_fields(array->map.record, ptr);
> +		bpf_obj_cancel_fields(array->map.record, ptr);
>  	}
>  unlock:
>  	rcu_read_unlock();
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b4366cad3cfa..a9b2b882b90f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -243,6 +243,10 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
>  
>  	if (IS_ERR_OR_NULL(htab->map.record))
>  		return;
> +	/*
> +	 * Preallocated maps do not have a bpf_mem_alloc destructor, so fully
> +	 * destroy every element, including the extra elements.
> +	 */
>  	if (htab_has_extra_elems(htab))
>  		num_entries += num_possible_cpus();
>  	for (i = 0; i < num_entries; i++) {
> @@ -833,8 +837,8 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
>  	return insn - insn_buf;
>  }
>  
> -static void check_and_free_fields(struct bpf_htab *htab,
> -				  struct htab_elem *elem)
> +static void check_and_cancel_fields(struct bpf_htab *htab,
> +				    struct htab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(htab->map.record))
>  		return;
> @@ -844,11 +848,11 @@ static void check_and_free_fields(struct bpf_htab *htab,
>  		int cpu;
>  
>  		for_each_possible_cpu(cpu)
> -			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
> +			bpf_obj_cancel_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
>  	} else {
>  		void *map_value = htab_elem_value(elem, htab->map.key_size);
>  
> -		bpf_obj_free_fields(htab->map.record, map_value);
> +		bpf_obj_cancel_fields(htab->map.record, map_value);
>  	}
>  }
>  
> @@ -883,7 +887,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	htab_unlock_bucket(b, flags);
>  
>  	if (l == tgt_l)
> -		check_and_free_fields(htab, l);
> +		check_and_cancel_fields(htab, l);
>  	return l == tgt_l;
>  }
>  
> @@ -948,7 +952,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
>  {
> -	check_and_free_fields(htab, l);
> +	check_and_cancel_fields(htab, l);
>  
>  	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
>  		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
> @@ -1001,7 +1005,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  
>  	if (htab_is_prealloc(htab)) {
>  		bpf_map_dec_elem_count(&htab->map);
> -		check_and_free_fields(htab, l);
> +		check_and_cancel_fields(htab, l);
>  		pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
>  		dec_elem_count(htab);
> @@ -1018,7 +1022,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>  		/* copy true value_size bytes */
>  		ptr = this_cpu_ptr(pptr);
>  		copy_map_value(&htab->map, ptr, value);
> -		bpf_obj_free_fields(htab->map.record, ptr);
> +		bpf_obj_cancel_fields(htab->map.record, ptr);
>  	} else {
>  		u32 size = round_up(htab->map.value_size, 8);
>  		void *val;
> @@ -1028,7 +1032,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>  			cpu = map_flags >> 32;
>  			ptr = per_cpu_ptr(pptr, cpu);
>  			copy_map_value(&htab->map, ptr, value);
> -			bpf_obj_free_fields(htab->map.record, ptr);
> +			bpf_obj_cancel_fields(htab->map.record, ptr);
>  			return;
>  		}
>  
> @@ -1036,7 +1040,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>  			ptr = per_cpu_ptr(pptr, cpu);
>  			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>  			copy_map_value(&htab->map, ptr, val);
> -			bpf_obj_free_fields(htab->map.record, ptr);
> +			bpf_obj_cancel_fields(htab->map.record, ptr);
>  		}
>  	}
>  }
> @@ -1252,11 +1256,11 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	if (l_old) {
>  		hlist_nulls_del_rcu(&l_old->hash_node);
>  
> -		/* l_old has already been stashed in htab->extra_elems, free
> -		 * its special fields before it is available for reuse.
> +		/* l_old has already been stashed in htab->extra_elems, cancel
> +		 * its reusable special fields before it is available for reuse.
>  		 */
>  		if (htab_is_prealloc(htab))
> -			check_and_free_fields(htab, l_old);
> +			check_and_cancel_fields(htab, l_old);
>  	}
>  	htab_unlock_bucket(b, flags);
>  	if (l_old && !htab_is_prealloc(htab))
> @@ -1269,7 +1273,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  
>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>  {
> -	check_and_free_fields(htab, elem);
> +	check_and_cancel_fields(htab, elem);
>  	bpf_map_dec_elem_count(&htab->map);
>  	bpf_lru_push_free(&htab->lru, &elem->lru_node);
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d4188a992bd8..8d12aa3728ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -808,6 +808,33 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
>  	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
>  }
>  
> +void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj)
> +{
> +	const struct btf_field *fields;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +	fields = rec->fields;
> +	for (i = 0; i < rec->cnt; i++) {
> +		void *field_ptr = obj + fields[i].offset;
> +
> +		switch (fields[i].type) {
> +		case BPF_TIMER:
> +			bpf_timer_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_WORKQUEUE:
> +			bpf_wq_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_TASK_WORK:
> +			bpf_task_work_cancel_and_free(field_ptr);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
Would a WARN_ON_ONCE for in_nmi in bpf_obj_free_fields help spot these
kind of bugs in the future?

Usually calling bpf_obj_free_fields in_nmi won't result in a deadlock
unless specific conditions are met (ie last reference to a refcounted
object, using a workqueue, etc).

Adding a check here would quickly surface bugs of this class.

> [...]
