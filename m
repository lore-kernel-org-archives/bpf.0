Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D363F4112
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073034; cv=none; b=sBbH5imFZd1QsIihA4nGRTJhMcHRZoGDKzRVD1jt1uuPWOAX8qgjrYSj/6zqDFy1ZPSMjyBimXPkkhU629IHal0xqWe39VMVBewh6HmFqh66kjdxSGRJfVY7yALTg+4IOBrqXa19ls1AgSM2UWgPfjGl0lm8QLerGG2G7HfHOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073034; c=relaxed/simple;
	bh=G71hOzCHg19EkCBkLBm5auxYB6zOLQZ1IM/l3FBIBlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NM26qS03uXGdRXY8lExaCCnYsliERmyf++jqVMwF89DbzsOqBsGQJumnM5J0C5aV4Ikc6jzZ7ClXKWH11zxvs6Dl+434lHRZLIgVVyv5ea5DAbTxPReOPRqvIzQqKxmd+D7MlDZXVYy6nU0eik3+HDJfdmOKW08Uqmd1o0u+R7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMkKHzom; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMkKHzom"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so70162845e9.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073029; x=1780677829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB/T/vmqw22V2Krdl0obT8vEaBinQE8eUYWt08eC/CA=;
        b=XMkKHzomHlHLvvl/B6uS617IcJU7OL3vsLwS0m6ZcONeNePJ75V6X39VJjJOKSQNyA
         dcLWry2m7HQZBA/DCJJyOb2LPG0hUg+9mYICptZio3eIGk6RaNmRMoZeWHrKoXdSbADs
         xw26YcZ/M745JA/3rVHG1J0zzcDYpnq/KEXE+oi9Q/59H6+su2xbM5zopjDLIfrf9p5O
         n4aA4/6lfcphtB6RKZYCJEcCmrpCc/xz5NzWeaOb3y9Jzo0Q9YGptlvjCr2BBNCvUsxO
         /wDP09J5K2qmueVymybJVQGY8e9RDPW4VbEr0sWQOmxtmhcciKrXKfp8KXPRlAsu+ciq
         Kb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073029; x=1780677829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB/T/vmqw22V2Krdl0obT8vEaBinQE8eUYWt08eC/CA=;
        b=bSlo+9w4JKZ9qTS9Xo+Zm/DDaFUQov4ishZI1YFovBpRNCj8doejfyHsQAVpdr81HZ
         l8kw3KjjMLNJh8zRYm+8jk0KvSB9YOq6w+El5DTrQCqFY87hTiLqZSOq08j/dChyyjOm
         siK5bA/3NgrytzU81mpoPQLevJIk9uymFBUU2QF8bMyj1yBxluviQNGyqLaRr/7cXlD7
         u6cTN2xGFmt0uXKEznIrirU6s1Pzp73RKoITd/9Oxk2uGHv2yzXwXJOMZ6PXUifZHRbV
         untl/9OHtEaMUjrL+UZMCI0rZZoZ+y4sGJAfRb2siMoFKBZ8Y4RjB2sm9apY23OXiiIt
         F3pw==
X-Gm-Message-State: AOJu0Yy4nAgFwrjJSXrn4OPv01MLnoY17+YQxNJn5xD6Ymf/XIDnyP6O
	bAxIODXG0PwJNslB3+fkn9P3N9BWKoK9GccU1bDt36+SdplL8R0AkRGnj1BLWqJt
X-Gm-Gg: Acq92OEEsgWUXu9G28GJEMUCoKwiNmB3O1UY2+HSUwnIgHiLQap68tpGqnn93gVgPx6
	LJ3gp7SCV9JmhndSqfcFn2G1YzogJ02zqSvGGWIXLk7rPisOCIme0GeLsYM6tBAIELDMu2oZveX
	gLiXBAbtK0QyX/Yvhp4mugUSJYFpCZvOlkRKQHuy4VxZDjyc3bpo73XdmM/XQZSA4nShbFQGK59
	ytvwdjL+rCxQvtBRgj/CzBb2pSkYLrz/V+ue7n654+xpPYguf3zAe8oezSduTHxNPwPsdrJV55o
	o5ETbt+u2PGPtYgFyVCFw9UmfkReZ/Frd2Vl3mamX7U8QmVjbQ+yYzc/De5GLojyYy3RtK9jA8B
	DwTLb81xexM20Zx6Qzpo16E/wRj+qxUoQnhMtQ+sQWSrzRkCIIt3LruBOXULmFu7g2QsRVl3tc4
	sbx//5ZCWH2gG5yvZUM9A6M1zWrvMSnEVGmib412quSU/2cndaRvtR6AvUsHUTb6DVSzgFpdT8V
	p/UT1Bl4IxLKKhirwVhxg==
X-Received: by 2002:a7b:c001:0:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490a294ba0emr4632645e9.31.1780073029041;
        Fri, 29 May 2026 09:43:49 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e79sm104723165e9.13.2026.05.29.09.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 09:43:48 -0700 (PDT)
Message-ID: <c717a1be-5e41-4f83-bb62-36ec3fc1bdf8@gmail.com>
Date: Fri, 29 May 2026 17:43:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 01/11] rhashtable: Add rhashtable_next_key()
 API
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260528-rhash-v5-1-7205191b6c57@meta.com>
 <20260528181644.360F61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260528181644.360F61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 7:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] rhashtable_next_key completely skips unmigrated elements if prev_key has already been migrated during a concurrent rehash.
> - [High] rhashtable_next_key enters an infinite loop if the hash table contains duplicate keys.
> - [High] Concurrent deletion of the prev_key element aborts the iteration prematurely and returns a dangerous ERR_PTR(-ENOENT) pointer.
> - [High] rhashtable_next_key silently ignores all duplicate elements when used on rhlist-enabled tables.
> --
> 
> commit 2aba1f7c85d79ee4c37a0c5013226a79bf52f189
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> Subject: rhashtable: Add rhashtable_next_key() API
> 
> Introduce a simpler iteration mechanism for rhashtable that lets
> the caller continue from an arbitrary position by supplying the
> previous key, without the per-iterator state of the
> rhashtable_walk_* API.
> 
>> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
>> index ef5230cece364..d6eb3ba476ea2 100644
>> --- a/include/linux/rhashtable.h
>> +++ b/include/linux/rhashtable.h
>> @@ -650,6 +650,97 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
>>  	return NULL;
>>  }
>>  
>> +/* Internal: scan one element forward from prev_key's position.
>> + * Returns first rhash_head whose bucket >= prev_key's bucket and
>> + * (if within prev_key's bucket) appears after prev_key in chain.
>> + * Returns first element if prev_key is NULL or ERR_PTR(-ENOENT) if prev_key
>> + * is not found.
>> + */
>> +static __always_inline struct rhash_head *__rhashtable_next_in_table(
>> +	struct rhashtable *ht, struct bucket_table *tbl,
>> +	const void *prev_key, const struct rhashtable_params params)
>> +	__must_hold_shared(RCU)
>> +{
>> +	struct rhashtable_compare_arg arg = { .ht = ht, .key = prev_key };
>> +	struct rhash_head *he;
>> +	unsigned int b = 0;
>> +	bool found = false;
>> +
>> +	if (prev_key) {
>> +		b = rht_key_hashfn(ht, tbl, prev_key, params);
>> +		rht_for_each_rcu(he, tbl, b) {
> 
> [Severity: High]
> Does this silently skip duplicate elements when the table is configured with
> rhlist = true?
> 
> For rhlist-enabled tables (like rhltable), the primary hash chain only connects
> the first element of each unique key group, while duplicates are stored in
> secondary linked lists via the rhlist_head structure.
> 
> Since this iteration relies exclusively on rht_for_each_rcu() and doesn't
> traverse those secondary lists, it seems it will only yield the most recently
> inserted element for each unique key.
> 

rhltable is not supported, I can return -EOPNOTSUPP for it:
if (unlikely(ht->rhlist))
    return ERR_PTR(-EOPNOTSUPP);

>> +			if (found)
>> +				return he;
>> +			if (params.obj_cmpfn ?
>> +			    !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
>> +			    !rhashtable_compare(&arg, rht_obj(ht, he)))
>> +				found = true;
> 
> [Severity: High]
> Can this lead to an infinite loop and RCU stall if the hash table contains
> duplicate keys?
> 
> Since standard rhashtables permit duplicate keys, rhashtable_compare() will
> match the first occurrence of prev_key in the chain and then yield the
> immediate next element.
> 
> If the next element is also a duplicate of prev_key, when the caller resumes
> iteration with it, the search restarts from the bucket head, matches the
> first occurrence again, and repeatedly yields the same second duplicate
> without making forward progress.
> 

good point, This code can be modified to skip duplicate keys. For BPF
codepaths duplicate keys are not possible, though.

>> +		}
>> +		if (!found)
>> +			return ERR_PTR(-ENOENT);
> 
> [Severity: High]
> Is it safe to return ERR_PTR(-ENOENT) if prev_key is concurrently deleted?
> 
> Unlike standard rhashtable iterators, this abruptly aborts the iteration if the
> element is removed, missing the remainder of the map.
> 
> Additionally, generic callers utilizing standard loop termination checks
> (e.g., while (obj)) could inadvertently dereference this error pointer and
> cause a kernel panic.

users should use IS_ERR_OR_NULL() instead of just checking for NULL.

> 
>> +		b++;
>> +	}
>> +
>> +	for (; b < tbl->size; b++)
>> +		rht_for_each_rcu(he, tbl, b)
>> +			return he;
>> +	return NULL;
>> +}
> 
> [ ... ]
> 
>> +static inline void *rhashtable_next_key(
>> +	struct rhashtable *ht, const void *prev_key,
>> +	const struct rhashtable_params params)
>> +	__must_hold_shared(RCU)
>> +{
>> +	struct bucket_table *tbl;
>> +	struct rhash_head *he;
>> +
>> +	tbl = rht_dereference_rcu(ht->tbl, ht);
>> +	do {
>> +		he = __rhashtable_next_in_table(ht, tbl, prev_key, params);
>> +		if (!IS_ERR_OR_NULL(he))
>> +			return rht_obj(ht, he);
>> +		if (!he)
>> +			prev_key = NULL;
>> +		/* Ensure we see any new future_tbl attached during a rehash. */
>> +		smp_rmb();
>> +		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
> 
> [Severity: Critical]
> Does this logic completely skip unmigrated elements if prev_key has already been
> migrated during a concurrent rehash?
> 
> If prev_key was migrated, __rhashtable_next_in_table() will fail to find it in
> the old table and return ERR_PTR(-ENOENT).
> 
> The code then falls back to searching future_tbl where it finds the key and
> continues. However, by jumping to future_tbl, the iterator permanently abandons
> the old table (ht->tbl) and will never visit its remaining unmigrated buckets,
> causing significant data omission.
> 

Yes, this is a limitation we have to deal with when using rhashtable.

>> +	} while (tbl);
>> +	return he; /* NULL or -ENOENT */
>> +}
> 

