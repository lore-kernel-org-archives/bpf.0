Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060B46B5
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198924; cv=none; b=sV9P+5Bx/Ljh5k7MQmWcZ9f7/W5byso0tYc5+DwZH3kQucpMBZijzycvQz2cR58V4QwRAnYz8/yLuAaNXBcGnAie+Y77J4h3FAj9SoHJBf55xGc6cPwF5yHAuRIyihe9/lXACshC53v8vh6tYrwXRRiFn+085vn6rNdDSlIWt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198924; c=relaxed/simple;
	bh=BH1OeKxplIkyBQn1BF2Hs2+oJBgWLMeSftT415rjV/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvHtOvBkiwKkkeqSi+lPAKR0lJ5HMnVNl4yBmEFOEQ9udzn5IGcPSpbN+d2Z/1PzaZTZQ7/65KJFZ3bw457E68YlOz1GVy6XF/EA3I+fD9q8/GphnWr0JJSKNJglfTN0EOKtADA2d7NZCwqhI9WMTsmVbnFscXyoqmdfBc0sHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWu0uIO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWu0uIO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so39937595e9.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198920; x=1779803720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQAl3SSrqT1px4vCTG/2nGsNiicROeZNBtXzAlW/q8Y=;
        b=hTWu0uIO2Uw5JzYn7H0r1REGzK7/L6DXxYTQxpy17bKi6rW2aQBvvL+Ybesfu2ZFS8
         ZoOQLAUNR5eMdJ6oVF1cGfgLRAiG+tAW+mWgLb3TCmtJ7srN6gsi3C/wbDMZE7+uHdUV
         aWzm1zlEUGyAVq+VW2U6+FMD343W8gS75rVb07KplH6EdhxuSkC5Bh3a3fl0JZLX8TDv
         7+n0jqY2oq9ZyiLWVdzwUyio8iH8cg3Bx2ph0d9N2UuRO04iDxE69N68uYd0qHOgK0df
         +7I5CrYRafckAqa81I+AdN31RlXqwLDZwnwhlh63EfG65rS01HVEp3s9kTHzYmdweSdZ
         DCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198920; x=1779803720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQAl3SSrqT1px4vCTG/2nGsNiicROeZNBtXzAlW/q8Y=;
        b=KOd8lWfOqh8dohZeYpGYe/NpglPtluJSGo7d8PMe8oHWmMdV1NQa8pPIEU1XX0b54k
         8XdcMLUaEwGnNtwF9Nnvpfkn/2mroZC3Hzf0uS5PuWeJBYvfVBzOoAOaYu/FZFelE4GR
         r9l3BSqJtHxrkxQhPgxxOjqABoKhrZUSygiEvwmKzoyj6Kj/KuZeD/nOcc2hRtJldeyk
         /X4OBZtNoGBnpJ9YOj2ehd8hRrySLk0fYFB8ymaRrseQljGzXB9YCx+Oxx3s5F50lR1i
         P6rksxwpieSmRYnAUf4jHQfLSgNewu8lS4iy5WBAp78GFs1YxFaZiiPfwZ2GaT42pIJ8
         caaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mbtjJIKcWXZmLkx2GvwEcHYedn5LKjJ68/gs0zWFWZ2yzB8qr6KEpybZ7LIs6FkRkp8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAajLPaFSV7/NuwHDurvG7T0uFRu2n2j/mxgBkXdbfxNB9QQgh
	CCuTld9rYroPtjq20ssStTEeMEVkzVqWJsgVp88WVNXN5t6W1Ht7CgMN
X-Gm-Gg: Acq92OEDKWPqk/1OBeEnHlnUDhFrAcvXEBgcaXgQ47jRHoBiflLdMH2RLJz00No46at
	S144n2I8qSccQzQtVLoy+qxJqw5nyD1HWvnYeoI+2XvftXASSlhKbvcdp9fuVeRa8CIObMn6Q7F
	heGfADmbidMQlWZ6ItFDxIKvZsNFO/iEjQCQlxcZraEeRowEYwfZ0GR8/3kz3vmk9F71ZEOBbe0
	vQleU2LzPi0ikw7rXi7Xj+RkpFBlyOs1064zwSOrnmRNKRi1Z9D2hB0SOPSloG5Cnp7Jnvg3Omp
	zq/11+sdPjVG8WYPUkgIJgoJKGhDtRTW9BivzDz6jdTlTeH6hTyu65QlWV0c+TYklLB8CNWsUQ4
	zOt1Dp0Upk0ICx0zzXNUpWjAm2ijOG2HFN95u8QPpIwskA2VJ1Gk/sZFjMPKfXMxzooebJqvNWx
	4VLV9CI1GVpFPOJDzKhB4TRckIWDqZM/gbWLfAh+Li+/abp5orYzIdn22WoPjKsrF/bIzO0LYOT
	mDheWU7Xa4by00K9+F5qA==
X-Received: by 2002:a05:600c:858d:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48fe66129efmr205207355e9.27.1779198920205;
        Tue, 19 May 2026 06:55:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead18659sm107539285e9.7.2026.05.19.06.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:55:19 -0700 (PDT)
Message-ID: <48ca9fa1-69e6-41ef-ae8d-d1639e6e635f@gmail.com>
Date: Tue, 19 May 2026 14:55:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
 mic@digikod.net, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260519011450.1144935-1-utilityemal77@gmail.com>
 <20260519011450.1144935-2-utilityemal77@gmail.com>
 <0fb7b7a8-9ff7-482d-a34a-694d31148941@gmail.com>
 <agxZBPjq7ee3hnoJ@suesslenovo>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <agxZBPjq7ee3hnoJ@suesslenovo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 2:22 PM, Justin Suess wrote:
> On Tue, May 19, 2026 at 01:31:58PM +0100, Mykyta Yatsenko wrote:
>>
>>
>> On 5/19/26 2:14 AM, Justin Suess wrote:
>>> Relax bpf_obj_free_fields to only cancel/free async work in irq_disabled
>>> contexts and defer unsafe free operations such as kptr dtors, list head
>>> and rb root destruction to a later non-irq_disabled call driven by the
>>> allocator or map free.
>>>
>>> Detect fields that are unsafe to free under irqs_disabled at htab
>>> creation time. When creating a hashtab with these fields, forcibly set
>>> BPF_F_NO_PREALLOC and use the bpf memory allocator instead.
>>>
>>> This must happen after the fields are checked, so convert the map to a
>>> non-prealloc one if the special fields are present, but before the map
>>> has been fully initialized.
>>>
>>> Enable this fix for regular, percpu, and lru hashtabs.
>>>
>>> This fixes a deadlock caused by updating/deleting map elements in an
>>> NMI context by shifting the responsibility of freeing fields that are
>>> unsafe to free in contexts like NMI to the memory allocators existing
>>> mechanism for handling this.
>>>
>>> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
>>> Reported-by: Justin Suess <utilityemal77@gmail.com>
>>> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
>>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>>> Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/
>>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>>> ---
>>
>> This is a v3 of the patch, it would be nice to include it in the subject
>> (see how other people do that).
>>
> I did mention this in the cover letter and link to the patch.
> 
> I was debating whether to make this a v4 of the last series (I already did a v3 [1]),
> but decided against it since this approach really doesn't share a single common line
> of code with the previous series.
> 
> But I'm not familiar with the norms on this.

I'd say carry the versioning, even if the code is completely changed, the problem you
are solving is the same, so it's the same patch series.

> 
> [1] https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77@gmail.com/
> 
> 
>>>  kernel/bpf/hashtab.c | 93 +++++++++++++++++++++++++++++++++++++++-----
>>>  kernel/bpf/syscall.c |  8 +++-
>>>  2 files changed, 89 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 3dd9b4924ae4..0db1dc8ae0be 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -130,6 +130,16 @@ struct htab_btf_record {
>>>  	u32 key_size;
>>>  };
>>>  
>>> +static inline bool htab_has_nmi_special_fields(const struct bpf_htab *htab)
>>> +{
>>> +	const struct btf_record *rec = htab->map.record;
>>> +
>>> +	if (IS_ERR_OR_NULL(rec))
>>> +		return false;
>>> +	return rec->field_mask & (BPF_KPTR_REF | BPF_KPTR_PERCPU | BPF_UPTR |
>>> +				  BPF_LIST_HEAD | BPF_RB_ROOT);
>>> +}
>>> +
>>>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>>>  {
>>>  	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
>>> @@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
>>>  	return 0;
>>>  }
>>>  
>>> +static int htab_convert_to_non_prealloc(struct bpf_htab *htab)
>>
>> This conversion is not ideal: deallocating/deinitializeing then
>> constructing new map again is something we should try to avoid.
>>
>> Is it possible to restructure map_create to parse btf and patch map_flags
>> before allocation/initialization?
> Agreed it's annoying.
> 
> The problem is map_check_bpf expects a bpf_map pointer.
> 
> So we must allocate the map before then with the existing map ops
> definition as far as I can tell.
> 
> So we could do it but it would need to have a special case in the
> __create_map function itself. Doable enough.

It's worth trying to find a refactoring that going to work.
Maybe moving map_flags patching logic out of map_check_btf.

This approach with reinitialization looks like the worst choice:
you are destroying/allocating map in the map_check_btf() (which sounds
like a function with no side effects), this is
very non-obvious. I think there is no precedent of map reinitialization.
Imagine if in other place we needed to change configuration again, are you
going to reinitialize it there too?
How would you design this if you were writing this from scratch?

>>
>> Or what sashiko suggests: explicitly reject this configuration 
>> and return -EINVAL.
>>
> Yeah but that would just break userspace progs that use referenced kptrs
> without the BPF_F_NO_PREALLOC flag.
> 
> That would be nice but it's too late to reject such a broad
> configuration like that with an error.
>>> +{
>>> +	bool percpu = htab_is_percpu(htab);
>>> +	int err;
>>> +
>>> +	htab_free_prealloced_fields(htab);
>>> +	free_percpu(htab->extra_elems);
>>> +	htab->extra_elems = NULL;
>>> +	prealloc_destroy(htab);
>>> +	htab->map.map_flags |= BPF_F_NO_PREALLOC;
>>> +
>>> +	err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
>>> +	if (err)
>>> +		return err;
>>> +	if (percpu) {
>>> +		err = bpf_mem_alloc_init(&htab->pcpu_ma,
>>> +					 round_up(htab->map.value_size, 8),
>>> +					 true);
>>> +		if (err) {
>>> +			bpf_mem_alloc_destroy(&htab->ma);
>>> +			return err;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>>>  			      const struct btf_type *key_type, const struct btf_type *value_type)
>>>  {
>>>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>> +	int err;
>>> +
>>> +	if (!htab_has_nmi_special_fields(htab)) {
>>> +		if (htab_is_prealloc(htab))
>>> +			return 0;
>>> +	} else {
>>> +		if (htab_is_lru(htab))
>>> +			return 0;
>>> +
>>> +		if (htab_is_prealloc(htab)) {
>>> +			err = htab_convert_to_non_prealloc(htab);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>> +	}
>>>  
>>> -	if (htab_is_prealloc(htab))
>>> -		return 0;
>>>  	/*
>>>  	 * We must set the dtor using this callback, as map's BTF record is not
>>>  	 * populated in htab_map_alloc(), so it will always appear as NULL.
>>> @@ -1355,7 +1405,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>>  					  bool percpu, bool onallcpus)
>>>  {
>>>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>> -	struct htab_elem *l_new, *l_old;
>>> +	struct htab_elem *l_new = NULL, *l_old;
>>>  	struct hlist_nulls_head *head;
>>>  	void *old_map_ptr = NULL;
>>>  	unsigned long flags;
>>> @@ -1387,8 +1437,17 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>>  		goto err;
>>>  
>>>  	if (l_old) {
>>> -		/* Update value in-place */
>>> -		if (percpu) {
>>> +		if (htab_has_nmi_special_fields(htab)) {
>>> +			l_new = alloc_htab_elem(htab, key, value, key_size,
>>> +						hash, percpu, onallcpus,
>>> +						l_old, map_flags);
>>> +			if (IS_ERR(l_new)) {
>>> +				ret = PTR_ERR(l_new);
>>> +				goto err;
>>> +			}
>>> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>> +			hlist_nulls_del_rcu(&l_old->hash_node);
>>> +		} else if (percpu) {
>>>  			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>>>  					value, onallcpus, map_flags);
>>>  		} else {
>>> @@ -1408,6 +1467,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>>  	}
>>>  err:
>>>  	htab_unlock_bucket(b, flags);
>>> +	if (l_old && htab_has_nmi_special_fields(htab) && !ret)
>>> +		free_htab_elem(htab, l_old);
>>>  	if (old_map_ptr)
>>>  		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
>>>  	return ret;
>>> @@ -1443,7 +1504,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>>  	 * to remove older elem from htab and this removal
>>>  	 * operation will need a bucket lock.
>>>  	 */
>>> -	if (map_flags != BPF_EXIST) {
>>> +	if (map_flags != BPF_EXIST || htab_has_nmi_special_fields(htab)) {
>>>  		l_new = prealloc_lru_pop(htab, key, hash);
>>>  		if (!l_new)
>>>  			return -ENOMEM;
>>> @@ -1460,11 +1521,21 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>>  		goto err;
>>>  
>>>  	if (l_old) {
>>> -		bpf_lru_node_set_ref(&l_old->lru_node);
>>> +		if (htab_has_nmi_special_fields(htab)) {
>>> +			pcpu_init_value(htab,
>>> +					htab_elem_get_ptr(l_new, key_size),
>>> +					value, onallcpus, map_flags);
>>> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>> +			hlist_nulls_del_rcu(&l_old->hash_node);
>>> +			bpf_lru_node_set_ref(&l_new->lru_node);
>>> +			l_new = NULL;
>>> +		} else {
>>> +			bpf_lru_node_set_ref(&l_old->lru_node);
>>>  
>>> -		/* per-cpu hash map can update value in-place */
>>> -		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>>> -				value, onallcpus, map_flags);
>>> +			/* per-cpu hash map can update value in-place */
>>> +			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>>> +					value, onallcpus, map_flags);
>>> +		}
>>>  	} else {
>>>  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
>>>  				value, onallcpus, map_flags);
>>> @@ -1479,6 +1550,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>>  		bpf_map_dec_elem_count(&htab->map);
>>>  		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
>>>  	}
>>> +	if (l_old && !ret && htab_has_nmi_special_fields(htab))
>>> +		htab_lru_push_free(htab, l_old);
>>>  	return ret;
>>>  }
>>>  
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 6600e126fbfb..1f52453d5a2f 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -839,6 +839,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>>  			break;
>>>  		case BPF_KPTR_REF:
>>>  		case BPF_KPTR_PERCPU:
>>> +			if (irqs_disabled())
>>> +				break;
>>>  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>>>  			if (!xchgd_field)
>>>  				break;
>>> @@ -854,16 +856,18 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>>  			}
>>>  			break;
>>>  		case BPF_UPTR:
>>> +			if (irqs_disabled())
>>> +				break;
>>>  			/* The caller ensured that no one is using the uptr */
>>>  			unpin_uptr_kaddr(*(void **)field_ptr);
>>>  			break;
>>>  		case BPF_LIST_HEAD:
>>> -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>>> +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
>>>  				continue;
>>>  			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
>>>  			break;
>>>  		case BPF_RB_ROOT:
>>> -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>>> +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
>>>  				continue;
>>>  			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
>>>  			break;
>>

