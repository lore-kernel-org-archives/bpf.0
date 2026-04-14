Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26538D6B5
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154107; cv=none; b=D9j+ESqmshRAepO0pDKMk5H8JJDrLxrCdPNpKbIQ3rXaSLojjrrbtbXZJkFN+2GeW6C8RmScw7l81hPvqMn+QFtXrlXNMUh6BJ94lZ/8KGI0MX6bdTZtvKhYpHf+rP3wKSkde2Sva3QQvkvxRvXBlL1zzKmAodovy30uXOJPyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154107; c=relaxed/simple;
	bh=UzAXLaPW5Dko/8ig0aZ4KZ1NRjGpzdmcHL+HOe4fP20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNyEsee8TBLYHg8OnbSl5Onzx2tWlLwOL+0tbrcF3sNl2I+yGEcRAOGIOOWlJMD4R0ERyHQw/qpMg/Nj7jb1vIt92fwqDIYLwVXqShy+vl9iXSCg7wUIdXglT+Suhl1qHy86RbM8uOY2gTwRLh4mabKpN2LqFG5FZVApmpMTPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyjySmRy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyjySmRy"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9e04b80692so169423466b.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776154103; x=1776758903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e/46RyBZZPB6ce3NnBdiwWWBvN0J+xqPXPubrxty9Q=;
        b=HyjySmRyuPD6euM49FtJ132MpeYkuAuq9uFJpU3UA8vUEBu5zxu0bh0WrWNwHhb7+V
         sZaHa4ZiqPtWXMmFi81orcgFF/qJ+JyF6A5cnVZhpcoNp2Zd/2rBuLE1aidr4LwVpvZQ
         zR7vYdm0o19i0ttTDFCE7FcSMH+VgmCRJk+BGkzX8ZJWFQmbDsIZtIyBllWBjZ6RP89y
         PckezMwoAUF0/rgVwSShN83xjeZoess+yey0RpQdzJlmX7Jzofz9cdDJ6ZXLci7v/9qj
         ii+voFJBTIEQQOO/95ckcZYQRokjOAFrch4XB/F5UOIkGTiP5TZ4A6bjjGLyIBmMNS+M
         OxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154103; x=1776758903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3e/46RyBZZPB6ce3NnBdiwWWBvN0J+xqPXPubrxty9Q=;
        b=HeBXFArb/UX4tWzs91HePrrTVpek90Dt7ByKNJgnkhIApVUtGMzNkgr6B1VVF8oLqs
         DHtaVgVO8ipDkbjLjJ3av6NOa5GCtm4g7DSEOtnHWBp/8IU+d784gw+N2V4TFWjNbfNa
         EdIaQsdtuRJLZyNL46l6DKDHJ5ZK3RKWyxs30q5iQNJkM5O7/yfgcke1MTfdDIouvGg7
         amfHPGXgJeDM02lfOfrxTHfZOaApy/ObteVxLWNUjB4rIe5ydI/24Mqo6Llh8Eh0GEZf
         yFgAxqtPuQyukcYxf4KujZSDn1Hz5peSUtfM8y6rTj83ZIOS2dZ7zfhyuBIJWvPtuTlA
         wK+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/FIvSn723Wm84Y6eGIbUklJn8tLfZKArYVIRut3frjPZK7PzV3GP80DxA9U82AyAU/65w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYMg6GIf4VXqwFA/8SCWHvmuS4Xeczqe/CPWTAALTAeXUKAa4
	uUoZH22ZeQQdN815Q0UfEV2hu2jfktIa29TAkpItgK85kH9CehA5kIq4
X-Gm-Gg: AeBDievhzbFA9+b5I3MXVOZHUFzstJ2yHDRKD2BktOctaUDjOWQ3ZjZM+cS+9YrEuuh
	sFwhlg7a+SvwvPEXjqj4Se3IjIAUpbjmo0pf/rS/y6tAQYUhpZrn+VZT3qbWjHW5R2eYCQSwxoI
	E294Ur0td2rBpUeTKrhyqmx65rVzrEsTIMNTIqnnAMsTGZU4imV65ExHRSFwSa7YJSkEAkG83bS
	DQ6yFbpPoGnipo7OQ2zttAWRUHEYKBb2EzLhoDKZZaDB6Qw5ZNmR3+3kB3rL5jgWlSISivANQBq
	i1DZqKxSNS8R5GaUIMHzsFHSCMl4jtmhjwbkOc2qcmYrz5SwASdc8IN2NOMewOIdHRuOiJOwa35
	6a4O5A8B9sZtTlW33khg//dTWlXjnIp8/xHIbKBvqkQFPlVURXeTLpCArwzer1oyCZ48pB7tQQH
	1MRs32HubIS2LuaRL25N3ejtz6avkEkG0hhhp1d7X865+exO4zy2XtSQGHDXC36g58od7lbYU0D
	AArhvh+
X-Received: by 2002:a17:906:9fd1:b0:b95:894b:46e4 with SMTP id a640c23a62f3a-b9d727aa0a8mr929969866b.34.1776154103028;
        Tue, 14 Apr 2026 01:08:23 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c886asm377406266b.46.2026.04.14.01.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:08:22 -0700 (PDT)
Message-ID: <9cbfadf0-39ca-437e-88d7-3bb7030b799d@gmail.com>
Date: Tue, 14 Apr 2026 09:08:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 07/18] bpf: Implement batch ops for
 resizable hashtab
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-7-3b3675da1f6e@meta.com>
 <DHSEYF5BFPD0.1O9VTHZBV53C2@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHSEYF5BFPD0.1O9VTHZBV53C2@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 12:25 AM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add batch operations for BPF_MAP_TYPE_RHASH.
>>
>> Batch operations:
>>   * rhtab_map_lookup_batch: Bulk lookup of elements by bucket
>>   * rhtab_map_lookup_and_delete_batch: Atomic bulk lookup and delete
>>
>> The batch implementation uses rhashtable_walk_enter_from() to resume
>> iteration from the last collected key. When the buffer fills, the last
>> key becomes the cursor for the next batch call.
>>
>> Also implements rhtab_map_mem_usage() to report memory consumption.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/hashtab.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 134 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index e79c194e2779..a79d434dc626 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -3051,19 +3051,150 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>>   
>>   static u64 rhtab_map_mem_usage(const struct bpf_map *map)
>>   {
>> -	return 0;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	u64 num_entries;
>> +
>> +	num_entries = atomic_read(&rhtab->ht.nelems);
>> +	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
>> +}
>> +
>> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>> +					       const union bpf_attr *attr,
>> +					       union bpf_attr __user *uattr,
>> +					       bool do_delete)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
>> +	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
>> +	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
>> +	void *buf = NULL, *keys = NULL, *values = NULL, *dst_key, *dst_val;
>> +	struct rhtab_elem **del_elems = NULL;
>> +	u32 max_count, total, key_size, value_size, i;
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +	u64 elem_map_flags, map_flags;
>> +	int ret = 0;
>> +
>> +	elem_map_flags = attr->batch.elem_flags;
>> +	if ((elem_map_flags & ~BPF_F_LOCK) ||
>> +	    ((elem_map_flags & BPF_F_LOCK) &&
>> +	     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>> +		return -EINVAL;
>> +
>> +	map_flags = attr->batch.flags;
>> +	if (map_flags)
>> +		return -EINVAL;
>> +
>> +	max_count = attr->batch.count;
>> +	if (!max_count)
>> +		return 0;
>> +
>> +	if (put_user(0, &uattr->batch.count))
>> +		return -EFAULT;
>> +
>> +	key_size = map->key_size;
>> +	value_size = map->value_size;
>> +
>> +	keys = kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN);
>> +	values = kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOWARN);
>> +	if (do_delete)
>> +		del_elems = kvmalloc_array(max_count, sizeof(void *),
>> +					   GFP_USER | __GFP_NOWARN);
>> +
>> +	if (!keys || !values || (do_delete && !del_elems)) {
>> +		ret = -ENOMEM;
>> +		goto free;
>> +	}
>> +
>> +	/*
>> +	 * Use the last key from the previous batch as cursor.
>> +	 * enter_from positions at that key's bucket, walk_next
>> +	 * returns the successor in O(1).
>> +	 * First call (ubatch == NULL): starts from bucket 0.
>> +	 */
>> +	if (ubatch) {
>> +		buf = kmalloc(key_size, GFP_USER | __GFP_NOWARN);
>> +		if (!buf) {
>> +			ret = -ENOMEM;
>> +			goto free;
>> +		}
>> +		if (copy_from_user(buf, ubatch, key_size)) {
>> +			ret = -EFAULT;
>> +			goto free;
>> +		}
>> +	}
>> +
>> +	scoped_guard(rcu) {
> 
> AFAICT this guard makes sure the RCU critical section extends from the
> beginning of rhashtable_walk_enter_from all the way to walk_stop(), is
> that correct?
> 

This guard is to make sure that when rhashtable_walk_enter_from() 
initializes iterator, the element which it initialised with is not 
freed. rhashtable_walk_start() calls rcu lock as well, that's why I can 
end guard right after rhashtable_walk_start().

>> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
>> +		rhashtable_walk_start(&iter);
>> +	}
>> +
>> +	dst_key = keys;
>> +	dst_val = values;
>> +	total = 0;
>> +
>> +	while (total < max_count) {
>> +		elem = rhtab_iter_next(&iter);
>> +		if (!elem)
>> +			break;
>> +
>> +		memcpy(dst_key, elem->data, key_size);
>> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
>> +		check_and_init_map_value(map, dst_val);
>> +
>> +		if (do_delete)
>> +			del_elems[total] = elem;
>> +
>> +		dst_key += key_size;
>> +		dst_val += value_size;
>> +		total++;
>> +	}
>> +
>> +	if (do_delete) {
>> +		for (i = 0; i < total; i++)
>> +			rhtab_delete_elem(rhtab, del_elems[i]);
>> +	}
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
>> +
>> +	if (total == 0) {
>> +		ret = -ENOENT;
>> +		goto free;
>> +	}
>> +
>> +	/* Signal end of table when we collected fewer than requested */
>> +	if (total < max_count)
>> +		ret = -ENOENT;
>> +
>> +	/* Write last key as cursor for the next batch call */
>> +	if (copy_to_user(ukeys, keys, total * key_size) ||
>> +	    copy_to_user(uvalues, values, total * value_size) ||
>> +	    put_user(total, &uattr->batch.count) ||
>> +	    copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
>> +			 dst_key - key_size, key_size)) {
>> +		ret = -EFAULT;
>> +		goto free;
>> +	}
>> +
>> +free:
>> +	kfree(buf);
>> +	kvfree(keys);
>> +	kvfree(values);
>> +	kvfree(del_elems);
>> +	return ret;
>>   }
>>   
>>   static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
>>   				  union bpf_attr __user *uattr)
>>   {
>> -	return 0;
>> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
>>   }
>>   
>>   static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
>>   					     union bpf_attr __user *uattr)
>>   {
>> -	return 0;
> Shouldn't these have been -EINVAL or -ENOSUPP in previous patches?
> 
>> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
>>   }
>>   
>>   struct bpf_iter_seq_rhash_map_info {
> 

