Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D973E63B7
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250139; cv=none; b=C1PyWi4Ryp9YA5HCFbqpDCCVnBynHZq4G6g2GUgmygIbIbUO5t/PDtmiqZeDZ2CAOvPPcES26KhJnWpqtTDmcB1T4OWHEXZdzl1MXwMoPqer3OKMLuBvGjGPZtt/exsqgHJj/UQLYoldKHNfBO0bA8MTkM/LckacSDqZP3QPxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250139; c=relaxed/simple;
	bh=fWh4qAN6Z5WTcX1oxJGR+D/RLQC6aLRn3nuMIbPYe1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNsGpnGa3ggzFKBaqxfhC5pSfvExVXknroBSJ7JoIjmfZlFSM3HbAbSnu2yOmqyUnQ0OctcMrpgk7BNnFZyBwTHUXZlZMBYKBla96Uo+5n6CoczihmX4aexJS2fDyGhlJlAOzs/Xe+ozx8kRhZoEaCIpOEiALfkbRwgq2XxAszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnXfDmAq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnXfDmAq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso18153625e9.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778250136; x=1778854936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjTs0wWLeN/IQCPdndax2nhRUMnSZ9jr6ALmgiGSuAI=;
        b=RnXfDmAqGaNu7NEkDjj3nwlYMcU3RJmZzMbcD8ZgUCgjPdEpWlJxbRZAfkYZFjBJSo
         j/p8dBt8XkYS/WByep8za+Qdhs6tc6CCdHK7VD5oinwSEd6/+ZK+Uye51R4po7TlBMJb
         LvOHmcvKMueSOyrpP4wpiIGXzR9w2NZzk1UgLFI5B0eXWw7JLT4JFg8lb6TvGKYdeo5x
         IciIKymsVBwhj59JqQDdJRKTfghxn1PJZXZ0v2PhikfnPgzp0/5d7nYWwfR0NRipMH2P
         qffWRJgsksJSSMBPeEi4LXPLVUyS1Rjs/ZvijFXbigkFiHz/qN0PXlNfrGTxxmRpU2Li
         ycBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778250136; x=1778854936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjTs0wWLeN/IQCPdndax2nhRUMnSZ9jr6ALmgiGSuAI=;
        b=oZRZ1YAqnBj9lfkTdEngZtbNVc5xClDOv0QQ9gNSO+sY66bGqb9IxXLvgqiQyDL06A
         KjYsTRZYhI08lBQ7YvU9MdlcvKm7iKM0IUidh/MPTchnsHUQB+FDRaL7vKkFlV18pglF
         7yGcNB4LLh08cgnNHcnzT3k5d1UmVqhK+Q2YB6VDxUIvWGRXxmFmnU3A9UqHJcgId72B
         /OoPaZHFO5WErSlO5JU+zuKflw0XJzKelUZBpYf89LMZx7xxH0qcg7RacrezLVjXPvWi
         6mB7kmXGqglYEKpVqd/TAEKjbRDZceaRZ9NsfF39l4DtGTrcrBKgJcd44NSZ5Bn2Pa5W
         Oh7g==
X-Gm-Message-State: AOJu0Yy1Kl4GXLQRxIc+h41uitnyD0HAtBffiFQHnS0v0141emrH8yeD
	r1IjdngBvSi/Tey5UjTd5uwPqrKq1VjTNMnVmskDwxG8V3NJc7FlxXFf
X-Gm-Gg: AeBDietQHjWkJcaiXPa4rZx/t7H/uR0MrkUS0k2aiHunkmJhSyE+EFlFsciG7tMzuj8
	A4lPmMmG6ZUlZFrQlS54PO/zgbX0JJX9QuP8QPf7LLGzArEsAW7G5tfTV2vv1uD7faORnZQyi8+
	sCB39VIs4K0L8Tmt3L310z/T1pT1/adJcOH0dZbY+MhOh00gdf3zPdBI4DbTJg+MddjHN5pgj85
	A232zYZHVWIHjFgd1S/0dTPD6vHKJszlfhjOuw/55XRPGVCjv00HrQfpv4ZzO6MQTwLLzIlX+3+
	h0/ac1gTwqP8rFlaZLKqaQ+imEskOfGkVzWdMxLrNjtTPJJWex0y943QI8B1/E888oDpaMPh+5z
	M2az3pO/rbOY/ewo2XuVwcdrA2LPQqCEhHYdAP8vT9eH/+fo+OGGbYChno8NJ9UPQgGFnt3vTTO
	RqJBC46zNRv3u89rnZG+sLYQutjSOyemyaj9JqPYwwxO4Cnh5IV31u8ecHXR4rMTLkORkWF45cf
	fTQw0qMOGBMFk6vGlAaNw==
X-Received: by 2002:a05:600c:8485:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48e51f2f853mr213351045e9.14.1778250135813;
        Fri, 08 May 2026 07:22:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm4578901f8f.17.2026.05.08.07.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:22:15 -0700 (PDT)
Message-ID: <bce63f2c-be86-4c6c-b8a9-6bea3de692ea@gmail.com>
Date: Fri, 8 May 2026 15:22:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
 <afCNcFLArNkj7GXh@gondor.apana.org.au>
 <9a83db58-5192-4d12-80f1-2a63ba29def3@gmail.com>
 <afxMsrMYRDHZMIa_@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <afxMsrMYRDHZMIa_@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 9:26 AM, Herbert Xu wrote:
> On Tue, May 05, 2026 at 05:57:41PM +0100, Mykyta Yatsenko wrote:
>>
>> We brainstormed with Alexei on how to integrate rhashtable better,
>> as a BPF map, we have the next proposal:
>>
>> Introduce rhashtable_next_key() API
>> ```
>> static inline struct rhash_head *rhashtable_next_key(
>> 	struct rhashtable *ht, const void *prev_key,
>> 	const struct rhashtable_params params);
>> ```
>>
>> It returns the next element, by finding prev_key in the tbl chain
>> and returning the next element in whatever tbl the prev one is.
>> This way we keep rhashtable API tight, less surface, not exposing unnecessary
>> details, although, this new API will have the same issues with full
>> iteration support (which we fine to deal with on userspace side).
>> Appreciate if you share your opinion on this.
> 
> Can you please show me how this gets used? Basically send me the
> patch 03 from your v3 series with this new interface.
> 
> Thanks,

Below is the example of the get_next_key() from BPF using rhashtable_next_key(),
I also included an implementation from rhashtable.

hashtab.c:
==========

static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
	__must_hold_shared(RCU)
{
	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
	struct rhtab_elem *elem;

	elem = rhashtable_next_key(&rhtab->ht, key, rhtab->params);

	/* if not found, return the first key */
	if (PTR_ERR(elem) == -ENOENT)
		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab->params);

	if (!elem)
		return -ENOENT;

	memcpy(next_key, elem->data, map->key_size);
	return 0;
}

rhashtable.h:
=============

static __always_inline struct rhash_head *__rhashtable_next_in_table(
	struct rhashtable *ht, struct bucket_table *tbl,
	const void *prev_key, const struct rhashtable_params params)
	__must_hold_shared(RCU)
{
	struct rhashtable_compare_arg arg = { .ht = ht, .key = prev_key };
	struct rhash_head *he;
	unsigned int b = 0;
	bool found = false;

	if (prev_key) {
		b = rht_key_hashfn(ht, tbl, prev_key, params);
		rht_for_each_rcu(he, tbl, b) {
			if (found)
				return he;
			if (params.obj_cmpfn ?
			    !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
			    !rhashtable_compare(&arg, rht_obj(ht, he)))
				found = true;
		}
		if (!found)
			return ERR_PTR(-ENOENT);
		b++;
	}

	for (; b < tbl->size; b++)
		rht_for_each_rcu(he, tbl, b)
			return he;
	return NULL;
}

/**
 * rhashtable_next_key - return next element after a given key
 * @ht:		hash table
 * @prev_key:	pointer to previous key, or NULL for the first element
 * @params:	hash table parameters
 *
 * Returns the next element in best-effort iteration order, walking the
 * @tbl chain (including any future_tbl in flight). Caller must hold RCU.
 *
 * Pass @prev_key == NULL to obtain the first element. To iterate, set
 * @prev_key to the key of the previously returned element on each call,
 * and stop when NULL is returned.
 *
 * Best-effort semantics:
 *   - Across the tbl->future_tbl chain, an element being migrated may
 *     transiently appear in both tables and be observed twice.
 *   - Concurrent inserts may or may not be observed.
 *   - Termination of a full iteration loop is NOT guaranteed under
 *     adversarial continuous rehash; callers MUST tolerate skips and
 *     repeats and SHOULD bound their loop externally.
 *   - If prev_key was concurrently deleted and is not present in any
 *     in-flight table, returns ERR_PTR(-ENOENT).
 *
 * Returns entry of the next element, or NULL when iteration is exhausted
 * or ERR_PTR(-ENOENT) if prev_key is not found.
 */
static inline void *rhashtable_next_key(
	struct rhashtable *ht, const void *prev_key,
	const struct rhashtable_params params)
	__must_hold_shared(RCU)
{
	struct bucket_table *tbl;
	struct rhash_head *he;

	tbl = rht_dereference_rcu(ht->tbl, ht);
	for (; tbl; tbl = rht_dereference_rcu(tbl->future_tbl, ht)) {
		he = __rhashtable_next_in_table(ht, tbl, prev_key, params);
		if (!he)
			/*
			 * this table is exhausted, try the next one from
			 * the beginning
			 */
			prev_key = NULL;
		else if (!IS_ERR(he))
			return rht_obj(ht, he);
	}
	return he; /* NULL or -ENOENT */
}

