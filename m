Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633038F62F
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077201; cv=none; b=gS7MS0lhnR5qn4cQmZxKU5T0f1JBnVK3Deb6qB+eskE/tMQpuaSBDq2N9yYrUPK4Rb1B5lAIo2Ll4GJgeqPQgAmw7z3hRp7nUnMrl+tezUTNSE9yleTag+B49y3UgPVII5Q1usKTUQREs1NTfGoAPc1YhbuET/V3+kEcyKnqHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077201; c=relaxed/simple;
	bh=4eX2IheEfKEGXzQj5ef3fBL4UR13GXoPaLn+BRITsTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNQYiawshf+tsJEZje04SxlGh1SmFVatKz9aSlTs2sAECR/RYI7hW4Z1fEZZinwUGadHSSavj8lOFNgNzGKD/8HYzRUA9QZegsQZJhSkKtP/VD4R2y+ADznE6l3/us1sO4bulaMUj0ihRJr64zYfqb3An4n19NL2q4kPdi3EFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyV86T5j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyV86T5j"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eedc94d37so938013f8f.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780077199; x=1780681999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zao36TtWYxh/e80MWBb+whUA2eRiMTH3Yxx7v4i0ShY=;
        b=RyV86T5jiomDC14hpVbeuvvVoag1/MmqYX71D9RIGmmYYNqqglxVVcnBE5cMSIIYYD
         qe7299GLa8BjE3mdMTSu/UquNnSR3wQnh/ew4iTiSBMLeqrnnx38IvfNM36xZX3QHRAZ
         uuEH3Dp2xl06ZMmqX+C3d2Qnwke/HnEAS+ULq0pmd2oJfSikRyB0sW7qPvXgfSWvbT+e
         v/amavpxPaPSODTTkzeXQbiwTXYXoMpcv0aXUb02+vkPoMIiGvNcEWM/VsL0iSgN3HJQ
         kWxUaVDTVxEwjmPxlLYy7Oo7fJP/8FvHkHMqXFYGTbcHbNG57RA2jpIH9QVx5VEPL3cp
         GbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077199; x=1780681999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zao36TtWYxh/e80MWBb+whUA2eRiMTH3Yxx7v4i0ShY=;
        b=SIT58rx3pDyMkmLe7UnikiJx9fpby6VQp1ve84Kctas3HeryJxrinmXtcFgGLsX4zF
         jNA3iEaZo0vZfAyaNMhH1VEC7F3ioyvK+8gf9TqUZaRjHT4iFiUf+24pafFA3bPoRz4y
         QH5l98+A/Kpk9LD9v6PYGbljQ15RGJjseeZAjbMqnOZlBDknWQhua+apj1teSAQV4Lcw
         1PvoHSQIlVjzInYqZ0roCo8SNT/T5ECIZwwYvSfCehXACXmVGsLrh5UE0ttYPwDcpthj
         aDOH//G8rhwie5scWeATNwgFnpChSTSoVh4bdSGWyaJaPeKGAVULJ2Rph014WwrPkw91
         kmgg==
X-Gm-Message-State: AOJu0YzwRekhAAdPfe4x+ZI8a7GJSG9T58x4Imx6a++5YH4z9Q+7++wu
	xNLHe4j/5rvoWQaMwk/CotBO3Bi9k19He3p/Le7G8zbM3zmUQme/2P09
X-Gm-Gg: Acq92OF7GM1mZHEEBDLCPLcgnuPrDgZXAmmCoy6G+erkQLtNBxq7N5WYEJAjuwjkr7k
	L5jikBrzdQYSpAfUkHWFm6XvEzJpW6vR44LcVY8o13BmbwWKV4FbQp7zoAk8T+/HAQx7E2TOfa0
	d61YQfKY25Qwj4PxtJ/Cb6qTd4cOiJDRo+5JY/R2k4EvGlXvL2GDa8GnJduRLH0L2nrAo8NAspr
	jRUYrYwqAKFfVna6zidy2rS441yg6ym5vabb3uiRwVzyx9dmdGpJeQ0xRmb3A3QcFPjqMMCoswe
	vweoNMwl3tFrZERTd9Z3RO1fzzk/fhFGDIUkeFiPdx111aS0Tdo2Nc3UkX77SPkR4FRnPz9PU8i
	x0huCpePf355OUgqXqZCM+wTyvb3MHaatcDKJc0ovuLHzkNzpS0zbNwvI32mGsl1UtHTQpIURSi
	ztyM7x2m51s73B+ODXNJzqM4aSl1sbsfNWbiCWEDksA05a2Ef/iyGmIpjAB2jl6rO0B30fqPMG0
	gcN/KLIq7B0eY0gHosX7J0myq7rIA0w
X-Received: by 2002:adf:f2cf:0:b0:45e:f672:40fb with SMTP id ffacd0b85a97d-45ef6b4f72bmr1207924f8f.22.1780077198422;
        Fri, 29 May 2026 10:53:18 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef358c07bsm5227305f8f.36.2026.05.29.10.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:53:18 -0700 (PDT)
Message-ID: <c8acb23e-ac1f-48d3-8e33-64c40bba16eb@gmail.com>
Date: Fri, 29 May 2026 18:53:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Implement iteration ops for
 resizable hashtab
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260528-rhash-v5-4-7205191b6c57@meta.com>
 <20260528182814.AD3771F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260528182814.AD3771F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Missing error pointer check in `rhtab_map_get_next_key` leads to unhandled error pointer dereferences and kernel panics.
> - [High] `bpf_each_rhash_elem` illegally calls `cond_resched()` and drops `rcu_read_lock()` from within a BPF map iterator callback, which will trigger kernel panics in atomic contexts.
> - [High] Batch lookup and `seq_file` iterators prematurely terminate when encountering concurrent deletions, breaking BPF map iteration guarantees and causing silent data omission.
> --
> 
> commit afc331365f30658242015d82e7bdd35a014f432d
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Implement iteration ops for resizable hashtab
> 
> Implement rhtab_map_get_next_key(), batch lookup/lookup-and-delete,
> and the seq_file BPF iterator for BPF_MAP_TYPE_RHASH.
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 8944c9f070ca8..a03fa5fa6545b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -3021,10 +3021,363 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)
>>  }
>>  
>>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>> +	__must_hold_shared(RCU)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem;
>> +
>> +	elem = rhashtable_next_key(&rhtab->ht, key, rhtab_params);
>> +
>> +	/* if not found, return the first key */
>> +	if (PTR_ERR(elem) == -ENOENT)
>> +		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
>> +
>> +	if (!elem)
>> +		return -ENOENT;
>> +
>> +	memcpy(next_key, elem->data, map->key_size);
> 
> [Severity: Critical]
> Could this dereference an error pointer if rhashtable_next_key() returns
> ERR_PTR(-EAGAIN)? 
> 
> The first check only handles -ENOENT. If we get -EAGAIN (which can happen
> during concurrent resizing), it bypasses the PTR_ERR check, passes the
> !elem check since it isn't NULL, and then passes the error pointer directly
> into memcpy().
> 

-EAGAIN is never returned from rhashtable_next_key(), but the error check
can be made more reliable. I'll address this for the v6

>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>> +				void *callback_ctx, u64 flags)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	void *prev_key = NULL;
> 
> [ ... ]
> 
>> +	rcu_read_lock();
>> +	/*
>> +	 * Best-effort iteration: if rhashtable is concurrently resized or
>> +	 * elements are deleted/inserted, there may be missed or duplicate
>> +	 * elements visited.
>> +	 */
>> +	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
>> +		if (IS_ERR(elem))
>> +			break;
>> +		num_elems++;
>> +		ret = callback_fn((u64)(long)map,
>> +				  (u64)(long)elem->data,
>> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
>> +				  (u64)(long)callback_ctx, 0);
>> +		if (ret)
>> +			break;
>> +
>> +		prev_key = elem->data;	/* valid while RCU held */
>> +
>> +		if (need_resched()) {
>> +			memcpy(key_buf, elem->data, map->key_size);
>> +			rcu_read_unlock();
>> +			cond_resched();
> 
> [Severity: High]
> Can this cond_resched() trigger "BUG: scheduling while atomic" panics?
> 
> BPF programs using the bpf_for_each_map_elem helper often run in
> non-sleepable contexts (like XDP, TC, or tracing) under an outer RCU read
> lock or with preemption disabled. 
> 
> While this drops the inner RCU lock, it doesn't exit the outer atomic
> context, so sleeping here might violate those constraints and cause system
> instability.
> 

yes, I'll remove cond_resched() from here. Dropping and re-acquiring rcu lock,
though may still be needed.

>> +			rcu_read_lock();
>> +			prev_key = key_buf;
>> +		}
>> +	}
>> +	rcu_read_unlock();
> 
> [ ... ]
> 
>> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>> +					       const union bpf_attr *attr,
>> +					       union bpf_attr __user *uattr,
>> +					       bool do_delete)
>> +{
> 
> [ ... ]
> 
>> +	rcu_read_lock();
>> +
>> +	/*
>> +	 * Cursor stores the key of the next-to-process element (stashed by
>> +	 * the previous batch). Look it up directly so the element is included
>> +	 * here rather than skipped by next_key(). If the cursor was deleted
>> +	 * concurrently (or by the previous do_delete batch), lookup returns
>> +	 * NULL and userspace must restart from a NULL cursor.
>> +	 */
>> +	if (ubatch)
>> +		elem = rhtab_lookup_elem(map, cursor);
>> +	else
>> +		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
>> +
>> +	while (elem && !IS_ERR(elem) && total < max_count) {
> 
> [Severity: High]
> Will this prematurely terminate the batch iteration if a concurrent deletion
> occurs? 
> 
> If the cursor element was concurrently deleted, rhashtable_next_key() returns
> ERR_PTR(-ENOENT). This loop checks !IS_ERR(elem) and will break out early.
> 
> This results in the function returning -ENOENT to userspace. Under BPF UAPI
> semantics, userspace interprets -ENOENT as the end of the map, which might
> cause silent data omission instead of safely recovering or continuing.

Maybe return -EAGAIN in case of cursor deletion, so that userspace will retry.

> 
>> +		memcpy(dst_key, elem->data, key_size);
>> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
>> +		check_and_init_map_value(map, dst_val);
> 
> [ ... ]
> 
>> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> +{
>> +	struct bpf_iter_seq_rhash_map_info *info = seq->private;
>> +	struct rhtab_elem *elem = v;
>> +	void *next;
>> +
>> +	memcpy(info->last_key, elem->data, info->map->key_size);
>> +	info->last_key_valid = true;
>> +	++*pos;
>> +
>> +	next = rhashtable_next_key(&info->rhtab->ht, info->last_key,
>> +				   rhtab_params);
>> +	if (IS_ERR(next))
>> +		return NULL;
> 
> [Severity: High]
> Does this also prematurely terminate the seq_file iteration on concurrent
> deletions? 
> 
> Similar to the batch logic above, returning NULL when next is
> ERR_PTR(-ENOENT) signals the end of the sequence to the iterator, which could
> silently truncate the iteration results.

Yes, in case cursor is deleted, the iteration finishes early.

> 
>> +	return next;
>> +}
> 

