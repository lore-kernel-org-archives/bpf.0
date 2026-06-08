Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BB2E9729
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933480; cv=none; b=Oe1FDhtwiYj+v2e3pOtgvVL5VC0pTvX2K/Ov3AS0svotE4LPFSbI+JtZ+NOJ0e6cMjpAttc0uTtm3fsOqO/pjDX8pCJLI0aGc0naXvYkto+ERoNllqop6MFYtw+0nee7b5svlABHNgr7eJxE2tAI9s6ydao0An5CYlfIi1faofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933480; c=relaxed/simple;
	bh=z6BPLfR/gnecj+szUdWJ1ksZ138x5VAoS+s/l6rYEa8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F56IfqblP+dYuj/cx7ftvmgxuEhdZMh+OHNK2xZIt0lXTJdWny1AGCluDKFo1UkPI8tQ1iv9Ynf+tSqeZFqnYtirmtTIWRfGn63I4SpMskjasomy6pMIXp+PEfiwIdfZUwjBYvKPczbhbl+9TBaMjEIjvcbqHvDaq54xiyFal6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB0AmaNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB0AmaNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CADC1F00898;
	Mon,  8 Jun 2026 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933479;
	bh=K2y1jqybFU1DGuuhtjFEyBGAB6ayPkcdd+TAOqPPHfs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZB0AmaNhGUgsM2/Kzv7cdkOp6i2FwX2uy7GdDluRknJeMhKwHkOnRs2Z5nao/aPLz
	 K7GEWL1r9s08tqToVBhovrqjubfPTj8rQRVK0Ub5QlE6F1rH6X5g6gKb59fOPQG6On
	 yKFYgnfhjeOFhkioSnVZgiDir1rDbX9a61dhTu+LdArfGPSTKXxKRAweSTe1/dQ1O4
	 KGsViSrRnwqVVTo3DTZZL1+OXwGN+QprE2t4Dgt/z/2Yjueis3sVXYASy8E4vPS6iR
	 yHAXLUV4W/s9mHmMlXDUfbiKiGl13/LGeUdW2nGsA7BkFzfGw31VkIn4jHdRZyH2fQ
	 7+X+/kZAVxX1g==
Content-Type: multipart/mixed; boundary="===============1733491595102378714=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ff511d0bd86a52d43fe54dcb5fab646e1a0c583d4900cbe1dfad6f702284654c@mail.kernel.org>
In-Reply-To: <20260608144841.1732406-4-memxor@gmail.com>
References: <20260608144841.1732406-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Cancel special fields on map value recycle
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 15:44:38 +0000 (UTC)

--===============1733491595102378714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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

In the prior version review thread, Kumar noted that the prealloc-related
changes are unnecessary and orthogonal to the actual fix. Could this patch
focus only on the cancel helper conversion without the htab_has_extra_elems
changes? Kumar suggested the approach should skip unconditionally rather
than use irqs_disabled().

Reference: https://lore.kernel.org/bpf/DIMWGCWL1AG2.14F7CN23GMS8N@gmail.com/

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

[ ... ]

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

This handles the map update/delete paths, but what about the bpf_obj_drop()
kfunc? During the prior version discussion, you and Kumar identified that
bpf_obj_drop() can also trigger NMI deadlocks when called from tracing
programs (for example, tp_btf/nmi_handler).

Kumar suggested rejecting bpf_obj_drop() in is_tracing_prog_type() when
the object has kptr fields. Should this patch also address that path, or
will that be a separate follow-up fix?

Reference: https://lore.kernel.org/bpf/DIMWGCWL1AG2.14F7CN23GMS8N@gmail.com/

> +
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
>  	const struct btf_field *fields;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27147105932
--===============1733491595102378714==--
