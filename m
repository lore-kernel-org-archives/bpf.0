Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736014A0C
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152247; cv=none; b=PrUoOTLY1MwzDc/CQK4I9e4PePPBOf75e/6EcIeQBf2CoUpHkJmI2yh2rqyfnHq3OEivgHDNGlvQjC1y4hArjVYn3IHoVQo/Ye1rHgBITEbcicFQXnv68zqIQkIVd9oRrmaiyCJZ8MimaRRoUsohpKWcNaOnffFLvlhFwBUnz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152247; c=relaxed/simple;
	bh=1oR1maHWr2VxA3bzm372xAgJuAsbHxTX80jv0ysGOuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoNnvXuWrI9VXs0WyfPR37w77KFu0p+T8FBGxc3WW8EDFMe0OiWIq9Ind2uB+xpl5KH9tWhjB05E2NNHTzVFmjVx+MwXd87aytEh8c5TmteYLuDpbb0yfySib+ObVqu770Rfc5CDKhp0qo4RxZVnTYfpXiA7Su+58LKjYogaowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Fa5x+U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Fa5x+U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso124704385e9.3
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777152241; x=1777757041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQZKJCwTCaw4HCfH21SJ/CrBDJiSNTq7WQ9W8kxFMU8=;
        b=A4Fa5x+UP9HXDX4M65vrm/F4eW0Ben9SeCW+54yFWQkCZguFzFkl+X/87QdaPnoC2r
         crTkgpcZri28q5I4jYNXcQJBO+joTLE5Fj5APax6q1OIYfzoajzLMOvebZbnx65XwJJQ
         DKBNj59Z9dDMs+h7FT6Tnu/L6vWq2rIK7AhHZ+2+PkPfjin3UB2gNq9TvEaILuwdEkLv
         LBxj7k+kEUM8nPe7sYfqMksrphsUlkus10f9nrY05ZPDaIVtNAzJaQGO9XCNhWEyIrEl
         NlGrz85b66RQDtl8OI5rFpr2eMIfqikw2/Jp8iebLrTNx6ccOEQD6MTuWhV9p4zdXiVY
         NTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777152241; x=1777757041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQZKJCwTCaw4HCfH21SJ/CrBDJiSNTq7WQ9W8kxFMU8=;
        b=e9o8/QIPYdBpLbrFlwsSG3wLawTlJH4bQRPSwwrHX5LKkjcTGGyNys3SJi+RMRuSSw
         F7OmEcpD/+jbThOubXmRnqfGwKkiU7MoLLCHvupXIkyLGPfosyn9rdrVajg2Ga6Qo7Aw
         r2rFFZW+D81lu5oza3XYx9UHkdd1SHFYP/dD0obK00PXTEUZu8mg4Dxg6hkORNPll8NN
         4jS7UnTub8MaPBJDPZFDE7qFtgionfOnWyB14VGal1tVdWLT7x3AB0LJlHc770GBmIdY
         4lYa1V8521k1yrOG4Hu8MQHg3irKQzohmrfOLNQLhs+T+30ygjJ2Gj6ov7JYbrnw8EG4
         5cbw==
X-Gm-Message-State: AOJu0YzQfAXXs5Vv4iMxPX8Lwe/acAYOmGQGwcDalFvIMPblsYZSevbc
	xzQUoP3JSGynfqTbY/vjwCByotsW/TLiM0iGyc4FAGoVsDjOitDeU1iZpuq0RQ==
X-Gm-Gg: AeBDies49tAEwd3x7Z080h1EP+vizPgbI+K1desebjB9244xJ+P9u2ukFLr3i/P4CbN
	SUjxtUlpSMQY3fdKRiadohCWSj6eC//9AgW9N9/5dEbGumB2oeZI8s/ik34zCq73YBCQEFi5pXM
	PQts/nKT8W+heu+Q2UuSI43j3Ff8Eo1ZTZDa/HmugqpZzxsUhGAFQeMN5GvizZ8JXaz+kzXtLA4
	dOmLf2OtK9ypYUlYU9ARUv5gNytOH/FQTeYcVd3Rmi40CphW+rqVsG24hfT682uLfzHtZS488D8
	qi1S0nC7NwjBxT8OIeB3dKS8GhLu1ymOgqzUv6bTiCOw8UelydetbNLA6yVf+G70Uoy1uYLm5t0
	zCiLFbHAKKifNMlbD4/8kcoCo9b2VQ5CkObkPCxHpVB7yscLWdiqOHngejikOcJH+KH/V4zfZn3
	+qAYELm6CzQHm2FE1rqsktMe6rQI8kZTGBp+ol3SQNCrNkszQ8nBVyP69XGXqcRzoDVDBSQRgg+
	O0e56a2bTJKMvBPGSVjPA==
X-Received: by 2002:a05:600c:8b64:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a56dedb1emr282778415e9.11.1777152241064;
        Sat, 25 Apr 2026 14:24:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm761739425e9.12.2026.04.25.14.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 14:24:00 -0700 (PDT)
Message-ID: <dd0057c1-e0b2-4559-afe9-2bf19760f68b@gmail.com>
Date: Sat, 25 Apr 2026 22:24:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 04/10] bpf: Implement batch ops and iterators
 for resizable hashtab
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260424-rhash-v3-4-d0fa0ce4379b@meta.com>
 <20260424202858.7DD0FC19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260424202858.7DD0FC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 9:28 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [High] Cursor invalidation in batch and seq_file iterators causes O(N^2) complexity and infinite loops.
> - [High] Unbounded RCU read lock duration in batch operations allows user-triggered RCU stalls.
> - [High] Map iterators and seq_file dumps spuriously abort during normal background resizes.
> - [High] Deadlock risk in `bpf_each_rhash_elem` due to acquiring `spin_lock` from atomic contexts.
> --
> 
> commit 9f7ce51619eb27e8a4a65df12f862e12e34bc285
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Implement batch ops and iterators for resizable hashtab
> 
> This commit adds batch operations for resizable hashtab maps, using
> rhashtable_walk_enter_from() to resume iteration. It also wires up
> seq_file BPF iterators and implements rhtab_map_mem_usage().
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index d37f3d548d3658..000caa2c7f4cd9 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -3066,64 +3066,330 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
>> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>> +				void *callback_ctx, u64 flags)
>> +{
> 
> [ ... ]
> 
>> +	/*
>> +	 * The rhashtable walk API uses spin_lock in rhashtable_walk_start/stop,
>> +	 * which is not safe in NMI or soft/hard IRQ context.
>> +	 */
>> +	if (in_nmi() || in_hardirq() || in_softirq())
>> +		return -EOPNOTSUPP;
>> +
>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
> 
> Does this adequately protect against deadlocks when called from kprobes or
> tracepoints in process context with preemption disabled?
> 
> If a thread currently holding ht->lock (e.g., during map insertion) is
> interrupted by a kprobe that runs this BPF program, attempting to acquire
> the same spin_lock inside rhashtable_walk_enter() might cause a deadlock.
> 
>> +	rhashtable_walk_start(&iter);
>> +
>> +	while ((elem = rhashtable_walk_next(&iter))) {
>> +		/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>> +		if (IS_ERR(elem)) {
>> +			num_elems = -EBUSY;
>> +			break;
>> +		}
> 
> Is it expected to abort the entire iteration if a background map resize
> occurs? 
> 
> rhashtable_walk_next() returns -EAGAIN to indicate the table was resized and
> the iterator was rewound. Since resizable hashtabs automatically resize
> during normal workloads, returning -EBUSY here could cause
> bpf_for_each_map_elem() and bpftool map dumps to randomly fail.
> 
> Should this handle -EAGAIN by retrying or continuing the walk instead?

No, resize is not handled automatically.

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
>> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
>> +		rhashtable_walk_start(&iter);
>> +	}
> 
> If the key stored in buf was already deleted, will this iteration restart
> from the beginning of the map?
>

 
yes, if cursor is deleted, iteration is restarted.

> Looking at rhashtable_walk_enter_from(), if it fails to find the key, it
> leaves iter->slot at 0. Then rhashtable_walk_start() and walk_next() will
> start from bucket 0 instead of where the previous batch left off.
> 
> Since lookup_and_delete_batch deletes the elements returned in the previous
> batch, the cursor key will always be deleted. Could this cause the iterator
> to repeatedly scan over all emptied buckets, resulting in an expensive
> traversal?
> 

If too many elements are deleted, the table will be resized, so the
number of empty buckets traversed should not be very big. But this is a
good point, we may not need to store the cursor at all.

> Similarly, for lookup_batch and seq_file dumps, if the cursor is
> concurrently deleted, could this trap userspace in an infinite loop of
> duplicate elements?
> 

This should not cause infinite loop, if cursor is deleted every time,
we'll run out of elements. Table resize exposes any iterators to the risk
of duplicate elements, it's up to user to make sure table is in steady
state when iterating.

>> +
>> +	dst_key = keys;
>> +	dst_val = values;
>> +	total = 0;
>> +
>> +	while (total < max_count) {
>> +		elem = rhtab_iter_next(&iter);
>> +		if (!elem)
>> +			break;
> 
> Can this loop cause RCU stalls or soft lockups if max_count is very large? 
> 
> The max_count parameter is controlled by userspace. Since
> rhashtable_walk_start() acquires the RCU read-side critical section, this
> loop might iterate, copy memory, and process millions of elements without
> ever dropping the RCU lock or calling cond_resched().
>
 
Existing htab does handle this situation; maybe splitting big batch into
smaller chunks with 
```
rcu_read_unlock();
bpf_enable_instrumentation();
```
in between will help.

> [ ... ]
> 
>> +static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>> +	__acquires(RCU)
>> +{
> 
> [ ... ]
> 
>> +	elem = rhashtable_walk_next(&info->iter);
>> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>> +	if (IS_ERR(elem))
>> +		return ERR_PTR(-EBUSY);
> 
> Similar to bpf_each_rhash_elem, will returning -EBUSY here on normal hash
> table resizes cause userspace map dumps to fail spuriously?
>
 
This is by design.

> [ ... ]
> 
>> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> +{
> 
> [ ... ]
> 
>> +	elem = rhashtable_walk_next(&info->iter);
>> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>> +	if (IS_ERR(elem))
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	return elem;
>> +}
> 
> Again, aborting on -EAGAIN here might interrupt the map dump when a resize
> happens in the background. Is there a way to handle -EAGAIN without failing
> the entire sequence?
> 

