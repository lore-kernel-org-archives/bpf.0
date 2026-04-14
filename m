Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675939A04F
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155703; cv=none; b=agEL6Te5U5LMSI9wvTvKFwxDnLbi/WfJIYM8fvKVsQ8ygbo3VaqUA5HBAaFFnoFJWd9vneETTWG7SUOBruWpHIxsnCK+WI7mYOzMQd3rOCrz9ZgpfYhxwRdxIZKPMaM+vYhn/qa75n/1I5qPlEmd3j3zer647rnb2EVR6g3NWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155703; c=relaxed/simple;
	bh=Sb5dc5g3KATrWpL6IqWbGiPcOORiFJ0aPfa+MYA2BWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4u1R8b4wkjQbuN93Q1mSvkNnzdRZ35jsiKkAGXUi8rhAof8OMpbmnvjV4pl6uCoB7Tvq1BLkq6jpi3e2ZzpeacGkKnO5b3Oqg3VNLtniLUlU2Mc1KtTpnLKVclHJ12NIBXB3SZRgHMLCUwkOZF4MJdx9fMqcnXbx5oNvPct2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHvxIS3R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHvxIS3R"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so1886474a12.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776155699; x=1776760499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYQaAq2jbQGVhlnw3hA2xp1hOS8rpTLqnTmsZDTPVAA=;
        b=jHvxIS3RyQcJglbSAQE3nDkZaDfFRs801tyAKq8B44V5py1RzfW3kGHgyY0MQKc4Us
         9tAQg3LGcNY6eT07PzbwfGPB/qEPWSPyB4GfWk0tz/PsWxbpOtfwaoZAxYnSuM3Nd3hq
         PHF6ohpq/wffXJoPY+harQFiiGazW7hgkgYZg9P2fqjhtPYMzx4zQywxxG0MxtWJuVkW
         71yJ4T5sA7MvVLi+07vpMU2LC9ejqp6P2PebC/ZE5H/jT4z9t07oKVDnekqB1vwKXzy+
         YgtFY8WnrSfcOlLsRJwzzQ54Czbrsja6omDhrf52t53DTX6FiodcBfRafdIH8hAkc8Y+
         YNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155699; x=1776760499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYQaAq2jbQGVhlnw3hA2xp1hOS8rpTLqnTmsZDTPVAA=;
        b=Z4HlK5N6ngu50VgJzwYv7daukHdY/PNLf+qATtI5y5cK8EsTTDtW8VLZpAnCrf9vgc
         bG5ZmVIS+jEvsx8szZZwI4UUJ53MdRkMBavxBXy3OhBqICcjj38T8Cvbpe/YdiRoO172
         dygzzQJ4ssAAvtzmTiExtITXC7l+yHMueO+esEYjS7K0EhCyog0/A8MqFnzZcCljtjuf
         FApv0sV0lHsGC8GbT3xRs9XBlrOlnXvrkf/1LhICoPxMQrkc77vVoSGBQokE8TaAxPPz
         4GBZNx8Q0YcdN93rS9UWjp4ddBIaYlW0+lyc7kickMxOCiCilxsqN6AqI4ZqmPBJZtPb
         KpMg==
X-Forwarded-Encrypted: i=1; AFNElJ9HdydOm/9Ygw4Nk6OtBeucylqMKwEwDOwzY1CZoYb0abvnQfhSI1JVXb3tVbBD0byP64g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkCHpVGwkOJmX73fJSmV2ucFkltkJY1dC+4wYhnFLqlm0lDqF
	4B62AM7fsPLd8Wfg4OJnOJpNjP2qtl4UoL+Vt65hE3QNGVLHNXz/GeeH
X-Gm-Gg: AeBDiese8XaIrsTzz09JjfBxbO3vYDYmZqoSnzsBwU074nbhjn6apV4yh+HPC/0r/Bd
	o5gNbCMQb5cOJumVDSS3G6VInxIX62uuNzCNEVZn1r9fVoC0JDEXiSyQnd6WYhLnMixIY5AMkyu
	1kIqnFVlDXJ+fNxAI2hgVQgb7PP/rThqUhYYT7GYgqBc9o0fdZj/RmR3GYqK7Sc+4OPlrTwofLk
	vR9uZrPgDauP33poNu0jp5OHmc6lcgFshLBnTEAQ7u5KjPAF9DlIkvQRG3NQqkPOL/g5myJ7LnZ
	wN3yP9K/gjGhvXIuZk+d5rXjj4u/GUQbAOiwvX3Q4+loTNPD/2qZxhhnbs3xMw2hmc74S6lQlfU
	e6/tqIrk7XCuUzv8euq1vygWD/8+0sgM2pttldj87FTdIXSvJs8BCFDLMlg6MddatzPF508V/rh
	OOfeeb+5gPaxuinCGgxQKbslZ/OBsXeOm33UkBU86ZpjAiaKoTemDRcW0STTg1lmRwGMlJou/d5
	T7z1ei6
X-Received: by 2002:a05:6402:4545:b0:66e:8ce7:630d with SMTP id 4fb4d7f45d1cf-670785a08aemr5637365a12.10.1776155699246;
        Tue, 14 Apr 2026 01:34:59 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-671c4f6049bsm391016a12.13.2026.04.14.01.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:34:57 -0700 (PDT)
Message-ID: <e6872b9f-ef6d-40a1-8ad6-c75bad92e60a@gmail.com>
Date: Tue, 14 Apr 2026 09:34:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
 <DHSBDLRKCAQO.1IPJTSEMPESV7@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHSBDLRKCAQO.1IPJTSEMPESV7@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/26 9:37 PM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Use rhashtable_lookup_likely() for lookups, rhashtable_remove_fast()
>> for deletes, and rhashtable_lookup_get_insert_fast() for inserts.
>>
>> Updates modify values in place under RCU rather than allocating a
>> new element and swapping the pointer (as regular htab does). This
>> trades read consistency for performance: concurrent readers may
>> see partial updates. Users requiring consistent reads should use
>> BPF_F_LOCK.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/hashtab.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 134 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 9e7806814fec..ea7314cc3703 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2755,6 +2755,11 @@ struct bpf_rhtab {
>>   	u32 elem_size;
>>   };
>>   
>> +static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
>> +{
>> +	return l->data + round_up(key_size, 8);
>> +}
>> +
>>   static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
>>   {
>>   	return ERR_PTR(-EOPNOTSUPP);
>> @@ -2769,33 +2774,155 @@ static void rhtab_map_free(struct bpf_map *map)
>>   {
>>   }
>>   
>> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	/* Using constant zeroed params to force rhashtable use inlined hashfunc */
>> +	static const struct rhashtable_params params = { 0 };
>> +
>> +	return rhashtable_lookup_likely(&rhtab->ht, key, params);
>> +}
>> +
>>   static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
>>   {
>> -	return NULL;
>> +	struct rhtab_elem *l;
>> +
>> +	l = rhtab_lookup_elem(map, key);
>> +	return l ? rhtab_elem_value(l, map->key_size) : NULL;
>> +}
>> +
>> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
>> +{
>> +	int err;
>> +
>> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
>> +	if (err)
>> +		return err;
>> +
>> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +	return 0;
>>   }
>>   
>>   static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *l;
>> +
>> +	guard(rcu)();
>> +	l = rhtab_lookup_elem(map, key);
>> +	return l ? rhtab_delete_elem(rhtab, l) : -ENOENT;
>> +}
>> +
>> +static void rhtab_read_elem_value(struct bpf_map *map, void *dst, struct rhtab_elem *elem,
>> +				  u64 flags)
>> +{
>> +	void *src = rhtab_elem_value(elem, map->key_size);
>> +
>> +	if (flags & BPF_F_LOCK)
>> +		copy_map_value_locked(map, dst, src, true);
>> +	else
>> +		copy_map_value(map, dst, src);
>>   }
>>   
>>   static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *l;
>> +	int err;
>> +
>> +	if ((flags & ~BPF_F_LOCK) ||
>> +	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>> +		return -EINVAL;
>> +
>> +	/* Make sure element is not deleted between lookup and copy */
>> +	guard(rcu)();
>> +
>> +	l = rhtab_lookup_elem(map, key);
>> +	if (!l)
>> +		return -ENOENT;
>> +
>> +	rhtab_read_elem_value(map, value, l, flags);
>> +	err = rhtab_delete_elem(rhtab, l);
>> +	if (err)
>> +		return err;
>> +
>> +	check_and_init_map_value(map, value);
>> +	return 0;
>>   }
>>   
>> -static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>> +static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>> +				      u64 map_flags)
>>   {
>> -	return -EOPNOTSUPP;
>> +	if (map_flags & BPF_NOEXIST)
>> +		return -EEXIST;
>> +
>> +	if (map_flags & BPF_F_LOCK)
>> +		copy_map_value_locked(map, rhtab_elem_value(elem, map->key_size), value, false);
>> +	else
>> +		copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> 
> It looks like Sashiko is accurate about special fields not getting handled here.
> 

Special fields are not copied, this is similar to other maps.

>> +	return 0;
>>   }
>>   
>> -static void rhtab_map_free_internal_structs(struct bpf_map *map)
>> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>>   {
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem, *tmp;
>> +
>> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
>> +		return -EINVAL;
>> +
>> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> +		return -EINVAL;
>> +
>> +	guard(rcu)();
>> +	elem = rhtab_lookup_elem(map, key);
>> +	if (elem)
>> +		return rhtab_map_update_existing(map, elem, value, map_flags);
>> +
>> +	if (map_flags & BPF_EXIST)
>> +		return -ENOENT;
>> +
>> +	/* Check max_entries limit before inserting new element */
>> +	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
>> +		return -E2BIG;
>> +
>> +	elem = bpf_mem_cache_alloc(&rhtab->ma);
>> +	if (!elem)
>> +		return -ENOMEM;
>> +
>> +	memcpy(elem->data, key, map->key_size);
>> +	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
>> +
>> +	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
>> +	if (tmp) {
>> +		bpf_mem_cache_free(&rhtab->ma, elem);
>> +		if (IS_ERR(tmp))
>> +			return PTR_ERR(tmp);
>> +
>> +		return rhtab_map_update_existing(map, tmp, value, map_flags);
>> +	}
>> +
>> +	return 0;
>>   }
> 
> Note: I am actually skeptical about Sashiko's warning here. Sure, the
> update may get overwritten even as we are returning 0, but we are
> providing no guarantees about how long the write will survive in the
> map, and there is no inherent atomicity between an update and any other
> operations.
> 

Right, either way can't guarantee that user going to see it's write 
anyway, if concurrent writers exist.

>>   
>>   static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_insn *insn = insn_buf;
>> +	const int ret = BPF_REG_0;
>> +
>> +	BUILD_BUG_ON(!__same_type(&rhtab_lookup_elem,
>> +				  (void *(*)(struct bpf_map *map, void *key)) NULL));
>> +	*insn++ = BPF_EMIT_CALL(rhtab_lookup_elem);
>> +	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>> +	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>> +				offsetof(struct rhtab_elem, data) + round_up(map->key_size, 8));
>> +
>> +	return insn - insn_buf;
>> +}
>> +
>> +static void rhtab_map_free_internal_structs(struct bpf_map *map)
>> +{
>>   }
> 
> This gets filled in in later patches, but the fact it's here and a no-op
> debatably the line into being non-bisectable. Can we move it to the walk
> patch, since that's where it gets populated?
> 

I think this is bisectable, because with this patch you can't create 
resizable hashmap anyway (allocation support comes as the last patch of 
the series). Alexei suggested to to merge these patches, so I'll do that.

>>   
>>   static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
> 

