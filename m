Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B930567A
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962383; cv=none; b=d+BgJmvkE7zUB5sA+3o2XCUF+n/rAv2drQdey48SzZBcrUIKBK7uUk5erh+D4bv1FLGowxkku4DEOODD4e3jb7oSh6R1ro/fudqwxUq2npwr0NzaXr8Pf+aVSx4CibaAVW5xs5pCO6xRZWzqcLKOm6Aqt1oogx7M2QH4xOD8J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962383; c=relaxed/simple;
	bh=qm2W9ANEy2dlMio5kkAqn/SxxQgmGk9RIt1XO4Ro2wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhEQkap+zdHj9Mo0Z7378Y2XoZ6KlQUipDl18vaIJCqHHDOC7okrw6bgRmoOG2iggk0XGf6BYoa3D6OBlmwL8fKh0Iazk7JwNKynIVCXLLzDXxsrBmYwW5VTruhkX51AKKB6+tTY6esIJbfuCUo2eDutS6FEIBlntDO8Wdr2ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwFcZSSV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwFcZSSV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ed9336049so2233634f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779962380; x=1780567180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3hLnIaBOP/ipRZixh5BEnkeeSU+qlmR6wJk8pB9G5I=;
        b=LwFcZSSV7RsJmYihxnE+jMJNQ3+rj1gCiaOIV0QNRsaRHk/CIm+y66MvaGtSWaeh97
         0lPVFqfh3kLPewy5MVLlshvDAiTS+io4khAMyC+lsvP6WD/no66auBVR8Uxb6JDseUQK
         GThMvQrj6FGyORdukdGA4rAutryh8mgohGLlNmmO8OPsPa9l0+R9npsaWz7IU3nQbVcm
         7/Y/8L7fJ2dNgPhbJzu5xAQ3WtrTsgt15zmSioVPQOycwuF8myKvoSKKnuudNVqDQWpe
         E3D3YGxenwEsybWrYd5RdwOZpHqTM7RlrCxdtUbtxK6m1gRqB0Oht00gYFNvT7sAD0n2
         CuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962380; x=1780567180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3hLnIaBOP/ipRZixh5BEnkeeSU+qlmR6wJk8pB9G5I=;
        b=bjwD7wz14oDQN5PfRLL4+BDHPL5NX9ej3hUwceUZW0kNNjDVs/dRCDMDr2oNK+H1EA
         YCnS6/xYsOraSIIYMf3ebxsiRCgL3IXgouYM0XAgGZzuFA5UMuP8SH9/zi15u77G/3W5
         PSSap2OlqsCl1/WcIsyjgw514lqmyk2C2Y8pt97JDI8Lh9XumzOXs7Nq7nSJSzPJEI5O
         MMPBe2OLe5iGzqcaeE0vNSsHP5AsakNWcFvdvilCQg4OvbThQl4a4DNemmfhjmWJ7y/q
         zH5OiblqXyllr4+2gWVBG/rWad6DMKR5moI0psDc4xKfRqp1dsHuyg9imb+7WpVjWZ1t
         3BEA==
X-Forwarded-Encrypted: i=1; AFNElJ+gViN/M1O8Kt4Of/ALKEtMZfq7f/NLQKZq1HammTRJztb3LN2y7Ho+Byv6QzTLzWNakUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKRiUSbzbW55XXwyhi3HfjFMg+POtVtrQ+fPhR3aItGChhtp/
	ULGmbZaYpSrv/7hLseyVYOzu3TCha9yCgdfTD4HmDPp76r0/ST0hwiwi
X-Gm-Gg: Acq92OHwpqUHvypsQF2IuqWNyczHXqAPTfkyhrgUKz41eNcn3vFmMiCbr1H/gd54SRJ
	bvg9ABJJI5b3G0dMncE+TuMofYcny92cf7ua0GsxuJPEtlF6AZ8+y/cf8kZClL2OjfqUzeSUD1J
	MRAjWPfcI8Hm6U/rWsmL8g4cylfKAyqz7kMRXYHeGBx2s5FCaQ5mddN5U9dKZsNy92FyILkZnm1
	Pqkp5VoOlXQgkcnkUYd7x4WnLTA1qUMT4Qj4r8Zb3QqFhy9PSHs9KhvJ7eAThK7q3BiKT9z5sTm
	rzl+CW4qxWZKZh+0Dk6/rnDMA7I5KTvMSblJf5Llj3hN8WIXUkHIwhSs9jG1ugGXDwldFM4UB0f
	6Cro3Yrs8qpdEhRiLrOQn6Qjj6XQYkzdyc2gKgJrFg9Mn+gFxWw8d1bdSTuHUnOwfeBEPttgS8y
	9fhVpC7NLmAqMv5ci7OzWEUBR4s0RMH8OzwtQwgPduFtpiEKoFY1X/nJrhiQ5lBU5y7ymwOeFKt
	M0zsbZ7aid6Y1NQ8kAgoA==
X-Received: by 2002:a5d:5f54:0:b0:45e:73a5:e1ed with SMTP id ffacd0b85a97d-45eb36adb4dmr47096404f8f.27.1779962379509;
        Thu, 28 May 2026 02:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549addsm12196345f8f.5.2026.05.28.02.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:59:38 -0700 (PDT)
Message-ID: <c86d27b1-d063-4584-99e6-297c6d8d5d23@gmail.com>
Date: Thu, 28 May 2026 10:59:36 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 03/11] bpf: Implement resizable hashmap basic
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260513-rhash-v4-3-dd3d541ccb0b@meta.com>
 <faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/26 12:21 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/rculist_nulls.h>
>>  #include <linux/rcupdate_wait.h>
>>  #include <linux/random.h>
>> +#include <linux/rhashtable.h>
>>  #include <uapi/linux/btf.h>
>>  #include <linux/rcupdate_trace.h>
>>  #include <linux/btf_ids.h>
> 
> [ ... ]
> 
>> @@ -2739,3 +2740,383 @@ static void htab_of_map_free(struct bpf_map *map)
>>  	BATCH_OPS(htab),
>>  	.map_btf_id = &htab_map_btf_ids[0],
>>  };
>> +
>> +struct rhtab_elem {
>> +	struct rhash_head node;
>> +	/* key bytes, then value bytes follow */
>> +	u8 data[] __aligned(8);
>> +};
>> +
>> +struct bpf_rhtab {
>> +	struct bpf_map map;
>> +	struct rhashtable ht;
>> +	struct bpf_mem_alloc ma;
>> +	u32 elem_size;
>> +};
> 
> [ ... ]
> 
>> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, void *copy,
>> +			     u64 flags)
>> +{
>> +	int err;
>> +
>> +	/*
>> +	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
>> +	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
>> +	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
>> +	 * raw tracepoints, which we don't have in rhashtable.
>> +	 */
>> +	bpf_disable_instrumentation();
>> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
>> +	bpf_enable_instrumentation();
> 
> Alexei Starovoitov suggested in v1 that update/delete operations should
> check 'if (irqs_disabled()) return -EBUSY' to prevent deadlocks when
> called from IRQ/NMI contexts.
> 
> The v4 implementation uses bpf_disable_instrumentation() instead, which
> only prevents NMI-based tracing programs but does not address the softirq
> deadlock scenario described by Sashiko bot in v3: if a syscall holds the
> bucket lock and is interrupted by hardware IRQ that schedules softirq
> (e.g., XDP/TC program), the softirq would deadlock trying to acquire the
> same bucket lock.
> 
> Does the bpf_disable_instrumentation() approach prevent this scenario?

rhashtable's rht_lock() calls local_irq_save(), so IRQs are
disabled while the bucket lock is held. Softirq from XDP/TC 
cannot execute during this window. Only NMI re-entry remains 
as a concern, and bpf_disable_instrumentation() blocks BPF 
programs (except raw tracepoints, which rhashtable does not use) 
from running in NMI.

> 
> Link: https://lore.kernel.org/all/CAADnVQKvp2tnQSWW4Kh3ofGLvaEYJ47kyZeNUscAH_DShw8XHw@mail.gmail.com/
> 
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	if (copy) {
>> +		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>> +		check_and_init_map_value(&rhtab->map, copy);
>> +	}
>> +
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>> +				      u64 map_flags)
>> +{
>> +	void *old_val = rhtab_elem_value(elem, map->key_size);
>> +
>> +	if (map_flags & BPF_NOEXIST)
>> +		return -EEXIST;
>> +
>> +	if (map_flags & BPF_F_LOCK)
>> +		copy_map_value_locked(map, old_val, value, false);
>> +	else
>> +		copy_map_value(map, old_val, value);
>> +	return 0;
>> +}
>> +
>> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem, *tmp;
>> +
>> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
>> +		return -EINVAL;
>> +
>> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> +		return -EINVAL;
> 
> The commit message claims 'Users requiring consistent reads should use
> BPF_F_LOCK', but can BPF_F_LOCK actually work with BPF_MAP_TYPE_RHASH?
> 
> Looking at map_check_btf() in kernel/bpf/syscall.c, BPF_MAP_TYPE_RHASH
> is not in the list of map types allowed to have BPF_SPIN_LOCK fields
> (only HASH, ARRAY, CGROUP_STORAGE, SK_STORAGE, INODE_STORAGE,
> TASK_STORAGE, CGRP_STORAGE are allowed). Map creation with a
> BPF_SPIN_LOCK field on a BPF_MAP_TYPE_RHASH map returns -EOPNOTSUPP.
> 
> Therefore btf_record_has_field(map->record, BPF_SPIN_LOCK) is always
> false for rhtab maps, and any update with BPF_F_LOCK is rejected with
> -EINVAL. The BPF_F_LOCK code paths in rhtab_map_update_existing,
> rhtab_read_elem_value, and rhtab_map_lookup_and_delete_elem are all
> dead code.
> 
> Is there currently any way to obtain consistent reads on rhtab maps?
> 
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
>> +	/* Prevent deadlock for NMI programs attempting to take bucket lock */
>> +	bpf_disable_instrumentation();
>> +	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
>> +	bpf_enable_instrumentation();
>> +
>> +	if (tmp) {
>> +		bpf_mem_cache_free(&rhtab->ma, elem);
>> +		if (IS_ERR(tmp))
>> +			return PTR_ERR(tmp);
>> +
>> +		return rhtab_map_update_existing(map, tmp, value, map_flags);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> rhtab_map_get_next_key always returns -EOPNOTSUPP. As a result,
> userspace cannot iterate keys of a BPF_MAP_TYPE_RHASH map via the
> standard syscall API, and tools like bpftool dump cannot list rhtab
> map contents.
> 
> The series previously added rhashtable_next_key() (commit 595ea21f6c1c)
> which provides best-effort iteration. Is there a plan to wire this up?
> 
>> +
>> +static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
>> +{
>> +}
>> +
>> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>> +				void *callback_ctx, u64 flags)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static u64 rhtab_map_mem_usage(const struct bpf_map *map)
>> +{
>> +	return 0;
>> +}
> 
> rhtab_map_mem_usage unconditionally returns 0, regardless of how many
> elements the map holds or its memory footprint. This callback is consumed
> by bpf_map_show_fdinfo, BPF map iteration tools, and memory accounting
> reporting.
> 
> For an rhtab map containing arbitrarily many elements (up to 2^31) plus
> the rhashtable bucket arrays plus the bpf_mem_alloc per-CPU caches,
> does reporting 0 mislead userspace introspection and accounting?
> 
>> +
>> +static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
>> +				  union bpf_attr __user *uattr)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
>> +					     union bpf_attr __user *uattr)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> [ ... ]
> 
>> +static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
>> +{
>> +}
> 
> [ ... ]
> 
>> +const struct bpf_map_ops rhtab_map_ops = {
>> +	.map_meta_equal = bpf_map_meta_equal,
>> +	.map_alloc_check = rhtab_map_alloc_check,
>> +	.map_alloc = rhtab_map_alloc,
>> +	.map_free = rhtab_map_free,
>> +	.map_get_next_key = rhtab_map_get_next_key,
>> +	.map_release_uref = rhtab_map_free_internal_structs,
>> +	.map_lookup_elem = rhtab_map_lookup_elem,
>> +	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
>> +	.map_update_elem = rhtab_map_update_elem,
>> +	.map_delete_elem = rhtab_map_delete_elem,
>> +	.map_gen_lookup = rhtab_map_gen_lookup,
>> +	.map_seq_show_elem = rhtab_map_seq_show_elem,
>> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
>> +	.map_for_each_callback = bpf_each_rhash_elem,
>> +	.map_mem_usage = rhtab_map_mem_usage,
>> +	BATCH_OPS(rhtab),
>> +	.map_btf_id = &rhtab_map_btf_ids[0],
>> +	.iter_seq_info = &rhash_iter_seq_info,
>> +};
> 
> Multiple map_ops are registered as functional callbacks but are stubs.
> 
> map_seq_show_elem is registered with rhtab_map_seq_show_elem (empty
> body) - bpffs map fdinfo will not show element contents.
> 
> map_for_each_callback is registered with bpf_each_rhash_elem returning
> -EOPNOTSUPP - the BPF helper bpf_for_each_map_elem() will fail at runtime.
> 
> iter_seq_info points to rhash_iter_seq_info whose start/next/show/stop
> are all stubs - BPF map iter programs targeting rhtab maps will iterate
> nothing.
> 
> BATCH_OPS expands to rhtab_map_lookup_batch/lookup_and_delete_batch
> returning -EOPNOTSUPP - userspace BPF_MAP_LOOKUP_BATCH and
> BPF_MAP_LOOKUP_AND_DELETE_BATCH syscalls fail.
> 
> While returning -EOPNOTSUPP is graceful (no crash), registering ops
> pointers that fail rather than relying on the dispatcher's NULL check
> defeats the verifier's compile-time validation: the verifier will accept
> BPF programs that call bpf_for_each_map_elem on an rhtab map, only to
> fail at runtime.
> 
> Should these callbacks be NULL instead?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25830929099

