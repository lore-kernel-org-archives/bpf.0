Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517F36073E
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193926; cv=none; b=h6qho91NnQHBJ5ulfE01m5v2ojBUFWNqQ8GTB6Qk/RC/nEkS2P6bwu0AUx+bFrqt+lIGaOn7BNxJ0c4NNG8Hwh/C057e7Z9SxMmnrQ/PcaYMyCw4mZR9A8U4lyNc9Ocf2cjJVrDED/s2i4hEdgtvLzurMz4zS6s3u6pYMQxJZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193926; c=relaxed/simple;
	bh=fR5LV5NnKPtwu8awzM4U5Nvfnt5JgSGSxmxod92PbKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSsx/4vgsl5xN+3jfR8HFFGmbsLJ/k4NVrtGVHmOUAa0ME65FU5Nc6fAAu4jfQHlQrtCLVY52uNdqL525e/Fqli1GHKLIfJg+7G5YHQ6jWcQxiU6S+V3wFqSJPKtXIZd2A0wm7i1oqnJ9anUEYzMac3P1d4XvgcADgKU6kmZzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRKzWEAK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRKzWEAK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so24236135e9.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779193920; x=1779798720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqHiBjd4uJTIAek/eZGAfdb/zXvzq/hwsHk+GPVHHhY=;
        b=PRKzWEAKp8rGgWyKKEqHl5314P+iCQipXgtVHunQXpoRvtPZE4tc7x8M4xmlswhos5
         hnWzP1e2ZigYwfohtDjNfKL8bGsMhG5nmgjriCLXaKuOOxft9XNUj4jh9Ogo1018i1LA
         k1UaWUe2qwZ3txQvN9LYFQ5YnXvgTlv3NNruneP+f8Wq3gs8oNqL298pEol9Ka3BzG0+
         +PhotmG5MQA5ayHJRlCnTkXPyFK8pP9636ElHTlJdYbkAP6YrmoTBTziAbY0ekFQSx3e
         8vrxGDn/7wUl/2a2mSviKpWiMk79XeGoDrW9U9tspCv8g1qcmz8q1TTcvRTMDLahKtK1
         bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193920; x=1779798720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqHiBjd4uJTIAek/eZGAfdb/zXvzq/hwsHk+GPVHHhY=;
        b=XqXa6jpmlsw+LJ7fmPXbEDuqP4A8TYOWK7HVB6IqTOm6cwEhKpMxZgFOa/R3e0puVQ
         W3iAc0703SLqzNpEhQCxKr45JHyXI0fzPFLQ9b9UWOO+nRMzHkXJnX5aCLGUMCXV4Hp6
         SzLNqvzQ7wyhDK/bu7HsLLNitSDQWlrUbEgUSbyq6qfpnC8l37wAUTnsxGTwTNMw/Fzi
         0Ddo5qagVhTaau7fK1DcS3uKbRor0RrRi7w6vOAORe5oarAdShWm17DliJFfCfBtvsXN
         J5A5DrTouLgHpJDFZE0GAhYJJxMhpkilB1BcUNIknqgqM4XiV0LbQOJ65gmZ4GWsryBs
         hw+A==
X-Forwarded-Encrypted: i=1; AFNElJ/riwC0J1MbWInvkEFrKPufBTm+z3cL1DIN5YFgqlJQ1oZQxtXHRFPdam8lHxRQVHHkIKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCq99QVjz0RMExzSuNN2mszjWOmnTiFqvWJQUVVOBaxvZTty1V
	NHXYV/XLwnD8uqvzkkRRL9ZfQVNOqF2B77D1C0hf0Ap//nz5cVZJCPi+
X-Gm-Gg: Acq92OGvUk33o0G4z5e57zTJGAsELFeXD0Ax6S6QBkhaPmWzNIVtit0QJdDsbp/SC/V
	uQYaahGL4wIzOP3B15SztNahPhrUKlyioXtLMKPDjhkQuPOfmfY7TkatRQ767TLFI6AnsnO5DPC
	NHwKxbX+wvn/tCltJqJWjI5b34cZokidK32V61PokEsmaPHJ2OVM4k34tgPLgLMkPf9UsgNELxC
	pf9j5EnkQxgU/kG6wXq1GKY6VbosDkRWmr1LXdKgR4gNGBVw4vnbMPzhC1vMYPsqxkBIzwPRAH2
	NHf/d0tQVnHP1E9WOulNvw/0l5QFz01VmjVH2LSXB420LpWuu9v1OJepa1A+lZj2TTXLdQp0kuH
	kOx7hmu88d1QHksNpx+R4dZK8xNQ3Cimt+zSFNzpgiIAN3DkLd64+KPlav80p4T6ibPX0a8qtTE
	go1N9z3Xz1+ZUSUBoJMrAZAjntycLnSocCdK8T9L3Ra+Y76y4EH4VZVtxlgt+mmo6LDHeP2dGQ3
	P0A0SBMdfM=
X-Received: by 2002:a05:600c:3b19:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-4900f7c0f52mr97742905e9.0.1779193919758;
        Tue, 19 May 2026 05:31:59 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb00bbe4sm105973485e9.12.2026.05.19.05.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 05:31:59 -0700 (PDT)
Message-ID: <0fb7b7a8-9ff7-482d-a34a-694d31148941@gmail.com>
Date: Tue, 19 May 2026 13:31:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
To: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260519011450.1144935-1-utilityemal77@gmail.com>
 <20260519011450.1144935-2-utilityemal77@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260519011450.1144935-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:14 AM, Justin Suess wrote:
> Relax bpf_obj_free_fields to only cancel/free async work in irq_disabled
> contexts and defer unsafe free operations such as kptr dtors, list head
> and rb root destruction to a later non-irq_disabled call driven by the
> allocator or map free.
> 
> Detect fields that are unsafe to free under irqs_disabled at htab
> creation time. When creating a hashtab with these fields, forcibly set
> BPF_F_NO_PREALLOC and use the bpf memory allocator instead.
> 
> This must happen after the fields are checked, so convert the map to a
> non-prealloc one if the special fields are present, but before the map
> has been fully initialized.
> 
> Enable this fix for regular, percpu, and lru hashtabs.
> 
> This fixes a deadlock caused by updating/deleting map elements in an
> NMI context by shifting the responsibility of freeing fields that are
> unsafe to free in contexts like NMI to the memory allocators existing
> mechanism for handling this.
> 
> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> Reported-by: Justin Suess <utilityemal77@gmail.com>
> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---

This is a v3 of the patch, it would be nice to include it in the subject
(see how other people do that).

>  kernel/bpf/hashtab.c | 93 +++++++++++++++++++++++++++++++++++++++-----
>  kernel/bpf/syscall.c |  8 +++-
>  2 files changed, 89 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..0db1dc8ae0be 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -130,6 +130,16 @@ struct htab_btf_record {
>  	u32 key_size;
>  };
>  
> +static inline bool htab_has_nmi_special_fields(const struct bpf_htab *htab)
> +{
> +	const struct btf_record *rec = htab->map.record;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return false;
> +	return rec->field_mask & (BPF_KPTR_REF | BPF_KPTR_PERCPU | BPF_UPTR |
> +				  BPF_LIST_HEAD | BPF_RB_ROOT);
> +}
> +
>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>  {
>  	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> @@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
>  	return 0;
>  }
>  
> +static int htab_convert_to_non_prealloc(struct bpf_htab *htab)

This conversion is not ideal: deallocating/deinitializeing then
constructing new map again is something we should try to avoid.

Is it possible to restructure map_create to parse btf and patch map_flags
before allocation/initialization?

Or what sashiko suggests: explicitly reject this configuration 
and return -EINVAL.

> +{
> +	bool percpu = htab_is_percpu(htab);
> +	int err;
> +
> +	htab_free_prealloced_fields(htab);
> +	free_percpu(htab->extra_elems);
> +	htab->extra_elems = NULL;
> +	prealloc_destroy(htab);
> +	htab->map.map_flags |= BPF_F_NO_PREALLOC;
> +
> +	err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
> +	if (err)
> +		return err;
> +	if (percpu) {
> +		err = bpf_mem_alloc_init(&htab->pcpu_ma,
> +					 round_up(htab->map.value_size, 8),
> +					 true);
> +		if (err) {
> +			bpf_mem_alloc_destroy(&htab->ma);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			      const struct btf_type *key_type, const struct btf_type *value_type)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	int err;
> +
> +	if (!htab_has_nmi_special_fields(htab)) {
> +		if (htab_is_prealloc(htab))
> +			return 0;
> +	} else {
> +		if (htab_is_lru(htab))
> +			return 0;
> +
> +		if (htab_is_prealloc(htab)) {
> +			err = htab_convert_to_non_prealloc(htab);
> +			if (err)
> +				return err;
> +		}
> +	}
>  
> -	if (htab_is_prealloc(htab))
> -		return 0;
>  	/*
>  	 * We must set the dtor using this callback, as map's BTF record is not
>  	 * populated in htab_map_alloc(), so it will always appear as NULL.
> @@ -1355,7 +1405,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>  					  bool percpu, bool onallcpus)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> -	struct htab_elem *l_new, *l_old;
> +	struct htab_elem *l_new = NULL, *l_old;
>  	struct hlist_nulls_head *head;
>  	void *old_map_ptr = NULL;
>  	unsigned long flags;
> @@ -1387,8 +1437,17 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>  		goto err;
>  
>  	if (l_old) {
> -		/* Update value in-place */
> -		if (percpu) {
> +		if (htab_has_nmi_special_fields(htab)) {
> +			l_new = alloc_htab_elem(htab, key, value, key_size,
> +						hash, percpu, onallcpus,
> +						l_old, map_flags);
> +			if (IS_ERR(l_new)) {
> +				ret = PTR_ERR(l_new);
> +				goto err;
> +			}
> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +			hlist_nulls_del_rcu(&l_old->hash_node);
> +		} else if (percpu) {
>  			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>  					value, onallcpus, map_flags);
>  		} else {
> @@ -1408,6 +1467,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>  	}
>  err:
>  	htab_unlock_bucket(b, flags);
> +	if (l_old && htab_has_nmi_special_fields(htab) && !ret)
> +		free_htab_elem(htab, l_old);
>  	if (old_map_ptr)
>  		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
>  	return ret;
> @@ -1443,7 +1504,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  	 * to remove older elem from htab and this removal
>  	 * operation will need a bucket lock.
>  	 */
> -	if (map_flags != BPF_EXIST) {
> +	if (map_flags != BPF_EXIST || htab_has_nmi_special_fields(htab)) {
>  		l_new = prealloc_lru_pop(htab, key, hash);
>  		if (!l_new)
>  			return -ENOMEM;
> @@ -1460,11 +1521,21 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		goto err;
>  
>  	if (l_old) {
> -		bpf_lru_node_set_ref(&l_old->lru_node);
> +		if (htab_has_nmi_special_fields(htab)) {
> +			pcpu_init_value(htab,
> +					htab_elem_get_ptr(l_new, key_size),
> +					value, onallcpus, map_flags);
> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +			hlist_nulls_del_rcu(&l_old->hash_node);
> +			bpf_lru_node_set_ref(&l_new->lru_node);
> +			l_new = NULL;
> +		} else {
> +			bpf_lru_node_set_ref(&l_old->lru_node);
>  
> -		/* per-cpu hash map can update value in-place */
> -		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> -				value, onallcpus, map_flags);
> +			/* per-cpu hash map can update value in-place */
> +			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> +					value, onallcpus, map_flags);
> +		}
>  	} else {
>  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
>  				value, onallcpus, map_flags);
> @@ -1479,6 +1550,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		bpf_map_dec_elem_count(&htab->map);
>  		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
>  	}
> +	if (l_old && !ret && htab_has_nmi_special_fields(htab))
> +		htab_lru_push_free(htab, l_old);
>  	return ret;
>  }
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6600e126fbfb..1f52453d5a2f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -839,6 +839,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			break;
>  		case BPF_KPTR_REF:
>  		case BPF_KPTR_PERCPU:
> +			if (irqs_disabled())
> +				break;
>  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>  			if (!xchgd_field)
>  				break;
> @@ -854,16 +856,18 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			}
>  			break;
>  		case BPF_UPTR:
> +			if (irqs_disabled())
> +				break;
>  			/* The caller ensured that no one is using the uptr */
>  			unpin_uptr_kaddr(*(void **)field_ptr);
>  			break;
>  		case BPF_LIST_HEAD:
> -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
>  				continue;
>  			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
>  			break;
>  		case BPF_RB_ROOT:
> -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
>  				continue;
>  			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
>  			break;

